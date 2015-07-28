- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:addButton];

    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:removeButton];

    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    clearButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:clearButton];

    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(addButton, removeButton, clearButton);

    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[addButton]" options:0 metrics:nil
views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[removeButton]" options:0 metrics:nil
views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[clearButton]" options:0 metrics:nil
views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint
       constraintsWithVisualFormat:@" [addButton(<=100)]-[removeButton(==addButton)]-[clearButton(==addButton)]"
       options:0 metrics:nil views:viewsDictionary]];

   NSLayoutConstraint *pinToLeft = [NSLayoutConstraint
        constraintWithItem:addButton attribute:NSLayoutAttributeLeading
        relatedBy:NSLayoutRelationEqual
        toItem:self.view attribute:NSLayoutAttributeLeading
        multiplier:1 constant:20];
   pinToLeft.priority = 500;
   [self.view addConstraint:pinToLeft];


   NSLayoutConstraint *pinToRight = [NSLayoutConstraint
       constraintWithItem:clearButton attribute:NSLayoutAttributeTrailing
       relatedBy:NSLayoutRelationEqual
       toItem:self.view attribute:NSLayoutAttributeTrailing
       multiplier:1 constant:20];
   pinToRight.priority = 500;
   [self.view addConstraint:pinToRight];


   NSLayoutConstraint *center = [NSLayoutConstraint
      constraintWithItem:removeButton attribute:NSLayoutAttributeCenterX
      relatedBy:NSLayoutRelationEqual
      toItem:self.view attribute:NSLayoutAttributeCenterX
      multiplier:1 constant:0];
   [self.view addConstraint:center];
}

- (void)rebuildImageViewsConstraints
{
    [self.view removeConstraints:self.imageViewConstraints];
    [self.imageViewConstraints removeAllObjects];

    if (self.imageViews.count == 0)
        return;

    UIImageView *firstImageView = [self.imageViews objectAtIndex:0];

    // Pin first view to the top left corner
    NSDictionary *viewsDictionary =
        [[NSDictionary alloc] initWithObjectsAndKeys:
            self.addButton, @"firstButton",
            firstImageView, @"firstImageView", nil];

   [self.imageViewConstraints addObjectsFromArray:[NSLayoutConstraint
       constraintsWithVisualFormat:@"H:|-[firstImageView(50)]"
       options:0 metrics:nil views:viewsDictionary]];

   [self.imageViewConstraints addObjectsFromArray:[NSLayoutConstraint
       constraintsWithVisualFormat:@"V:[firstButton]-[firstImageView(50)]"
       options:0 metrics:nil views:viewsDictionary]];

   if (self.imageViews.count > 1)
   {
       UIImageView *previousImageView = firstImageView;

       for (int i=1; i < self.imageViews.count; i++)
       {

            UIImageView *imageView = [self.imageViews objectAtIndex:i];

            [self.imageViewConstraints addObject:[NSLayoutConstraint
                constraintWithItem:imageView attribute:NSLayoutAttributeLeading
                relatedBy:NSLayoutRelationEqual
                toItem:previousImageView attribute:NSLayoutAttributeLeading
                multiplier:1 constant:10]];

            [self.imageViewConstraints addObject:[NSLayoutConstraint
                constraintWithItem:imageView attribute:NSLayoutAttributeTop
                relatedBy:NSLayoutRelationEqual
                toItem:previousImageView attribute:NSLayoutAttributeTop
                multiplier:1 constant:10]];

            [self.imageViewConstraints addObject:[NSLayoutConstraint
                constraintWithItem:imageView attribute:NSLayoutAttributeWidth
                relatedBy:NSLayoutRelationEqual
                toItem:previousImageView attribute:NSLayoutAttributeWidth
                multiplier:1.1 constant:0]];

            [self.imageViewConstraints addObject:[NSLayoutConstraint
                constraintWithItem:imageView attribute:NSLayoutAttributeHeight
                relatedBy:NSLayoutRelationEqual
                toItem:previousImageView attribute:NSLayoutAttributeHeight
                multiplier:1.1 constant:0]];

            previousImageView = imageView;
         }
     }

     [self.view addConstraints:self.imageViewConstraints];
 }
 
 - (void)addImageView
{
    UIImage *image = [UIImage imageNamed:@"sweflag"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageViews addObject:imageView];

    [self rebuildImageViewsConstraints];
  }
 
 - (void)removeImageView
{
    if (self.imageViews.count > 0)
    {
        [self.imageViews.lastObject removeFromSuperview];
        [self.imageViews removeLastObject];
        [self rebuildImageViewsConstraints];
    }
}
- (void)clearImageViews
{
    if (self.imageViews.count > 0)
    {
        for (int i=self.imageViews.count - 1; i >= 0; i--)
        {
            UIImageView *imageView = [self.imageViews objectAtIndex:i];
            [imageView removeFromSuperview];
            [self.imageViews removeObjectAtIndex:i];
         }

         [self rebuildImageViewsConstraints];
     }
}
