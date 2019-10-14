#created by rbsathish

from tkinter import filedialog
from tkinter import *
from tkinter import messagebox
import cv2
# import numpy as np
# class resizer():
root = Tk()
root.title("Welcome to Resizer")
root.geometry('250x100')
root.configure(background = "black")
w = Entry(root)
h = Entry(root)
w.grid(row=0,column=1)
h.grid(row=1,column=1)

def resizefun(root):
    width = Label(root,text="Enter width:",bg="red",fg="white")
    height = Label(root,text="Enter height:",bg="red",fg="white")
    
    width.grid(row=0,column=0)
    height.grid(row=1,column=0)
    # w.grid(row=0,column=1)
    # h.grid(row=1,column=1)
    Button(text="load image",command=select_image).grid(row=3,column=1)
    resize = Button(root,text='resize',command=resizeclick)
    resize.grid(row=4,column=1)

def select_image():
    # open a file chooser dialog and allow the user to select an input
    # image
    path = filedialog.askopenfilename()
    if len(path) > 0:
        image = cv2.imread(path)
        cv2.imwrite("image.jpg",image)

def resizeclick():
    image = cv2.imread("image.jpg")
    print("original image shape",image.shape[:2])
    #Getting Image width height
    width =  int(w.get())
    height = int(h.get())
    #passing image,width,height to resz function
    resz(image,width,height)
    #Message
    messagebox.showinfo("Resized","COMPLETED")
    respose = messagebox.askquestion("Do you want to resize again?","Click Yes to resize again or click No to exit")
    if respose == "yes":
        print("One more ")
        resizefun(root)
    elif respose == "no":
        root.quit()

def medec(func):
    def indec(*args, **kwargs):
        print("RESIZING ON PROGRESS")
        print ("Height & Width You Entered to Resize---> \n Height : {} Width : {}".format(h.get(),w.get()))
        # print(*args, **kwargs)
        func(*args, **kwargs)
        # print ("Resized Height & Width  ---> \n Height : {} Width : {}".format(height,width))
        print ("SUCCESSFULLY RESIZED")
    return indec

@medec
def resz(img,w,h):
    rez = cv2.resize(img,(w,h),interpolation=cv2.INTER_AREA)
    #writing the resized image
    cv2.imwrite("resized_image.jpg",rez) 
    #loading the resized image and seeing the height & width
    resized = cv2.imread("resized_image.jpg")  
    (height,width) = resized.shape[:2]
    print ("Resized Height & Width  ---> \n Height : {} Width : {}".format(height,width))
    

resizefun(root)
root.mainloop()