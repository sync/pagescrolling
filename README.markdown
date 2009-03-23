Based on this code (thanks to Matt):
http://cocoawithlove.com/2009/01/multiple-virtual-pages-in-uiscrollview.html

Basically you create 2 controllers on your scroll container nib, and then add loadContent:
to your controller and the scroll container controller will handle all the job for you.

It is showing how to remember the last user known position.

Know limitation:
You cannot have a up/down scrolling view on your page.