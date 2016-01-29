class Printer implements Printable {

  File imageFile;
  PImage bufferedImage;
  PageFormat a5Page;

  public Printer()
  {
    //Sets up the correct paper size (A5 for minimal paper wastage)
    a5Page = new PageFormat();
    Paper paper = new Paper();
    paper.setSize(420, 595);
    paper.setImageableArea(28.0,36.0,363.0,531.0);
    a5Page.setPaper(paper);
  }

  public void print(String fileName)
  {
    try {
      bufferedImage = loadImage(IMAGE_ROOT + fileName);
    } 
    catch (Exception e) {
      System.out.println("File can not be opened...");
    }

    PrinterJob job = PrinterJob.getPrinterJob();
    a5Page = job.pageDialog(a5Page);
    a5Page = job.validatePage(a5Page);
    System.out.println(a5Page.getImageableX() + "," + a5Page.getImageableY() + "," + a5Page.getImageableWidth() + "," + a5Page.getImageableHeight());
    job.setPrintable(this, a5Page);
    //Uncomment the following lines to use the print dialog.
    
    RepaintManager currentManager = RepaintManager.currentManager(null);
    currentManager.setDoubleBufferingEnabled(false); 
    
    boolean ok = job.printDialog();
    //if (ok) {
    try {
      job.print();
    } 
    catch (PrinterException ex) {
      System.out.println("Printer Error (Don't ask me, look at your printer");
    }
    //}
  }

  public int print(Graphics g, PageFormat pf, int page) throws PrinterException
  {

    if (page > 0) { /* We have only one page, and 'page' is zero-based */
      return NO_SUCH_PAGE;
    }

    /* User (0,0) is typically outside the imageable area, so we must
     * translate by the X and Y values in the PageFormat to avoid clipping
     */
    Graphics2D g2d = (Graphics2D)g;
    g2d.translate(pf.getImageableX(), pf.getImageableY());

    /* Now we perform our rendering */
    //FIXME: Actually print image, as it is a blank page atm.
    //g.drawImage(bufferedImage, 0, 0, null);

    /* tell the caller that this page is part of the printed document */
    return PAGE_EXISTS;
  }

}