DEBUG = false

isPureRed = (imageData, x,y)->
  index = (x + y * imageData.width) * 4
  imageData.data[index] == 255 and imageData.data[index+1] == 0 and imageData.data[index+2] == 0

isPureBlack = (imageData, x,y)->
  index = (x + y * imageData.width) * 4
  imageData.data[index] == 0 and imageData.data[index+1] == 0 and imageData.data[index+2] == 0

isPureWhite = (imageData, x,y)->
  index = (x + y * imageData.width) * 4
  imageData.data[index] == 255 and imageData.data[index+1] == 255 and imageData.data[index+2] == 255

topRowNumberWithoutAnyPureRedPixels = (imageData, startRow) ->
  for y in [startRow...imageData.height]
    for x in [0...imageData.width]
      if isPureRed imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        break
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
    if DEBUG then console.log imageData.width + "  " + x
    if x == imageData.width
      if DEBUG then console.log "Found row without red pixels at #{y}"
      break
  return y

topRowNumberWithoutAnyPureRedOrBlackPixels = (imageData, startRow) ->
  for y in [startRow...imageData.height]
    for x in [0...imageData.width]
      if isPureRed imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        break
      else if isPureBlack imageData, x, y
        if DEBUG then console.log "Found black pixel at #{x}, #{y}"
        break
      else
        if DEBUG then console.log "Found non-red non-black pixel at #{x}, #{y}"
    if DEBUG then console.log imageData.width + " " + x
    if x == imageData.width
      if DEBUG then console.log "Found row without red nor black pixels at #{y}"
      break
  return y


leftmostColumnNumberWithoutAnyPureRedPixels = (imageData) ->
  for x in [0...imageData.width]
    for y in [0...imageData.height]
      if isPureRed imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        break
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
    if DEBUG then console.log imageData.height + " " + y
    if y == imageData.height
      if DEBUG then console.log "Found column without red pixels at #{x}"
      break
  return x

leftmostColumnNumberWithoutAnyPureBlackPixels = (imageData) ->
  for x in [0...imageData.width]
    for y in [0...imageData.height]
      if isPureBlack imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        break
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
    if DEBUG then console.log imageData.height + " " + y
    if y == imageData.height
      if DEBUG then console.log "Found column without red pixels at #{x}"
      break
  return x

leftmostColumnNumberWithoutAnyPureWhitePixels = (imageData) ->
  for x in [0...imageData.width]
    for y in [0...imageData.height]
      if isPureWhite imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        break
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
    if DEBUG then console.log imageData.height + " " + y
    if y == imageData.height
      if DEBUG then console.log "Found column without red pixels at #{x}"
      break
  return x

leftmostColumnNumberWithAnyPureRedPixels = (imageData) ->
  for x in [0...imageData.width]
    for y in [0...imageData.height]
      if isPureRed imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        return x
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
  return -1

leftmostColumnNumberWithAnyPureBlackPixels = (imageData) ->
  for x in [0...imageData.width]
    for y in [0...imageData.height]
      if isPureBlack imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        return x
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
  return -1

rightmostColumnNumberWithAnyPureBlackPixels = (imageData) ->
  for x in [imageData.width-1...0]
    for y in [0...imageData.height]
      if isPureBlack imageData, x, y
        if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        return x
      else
        if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
  return -1

bottomestRowWithAnyPureBlackPixels = (imageData) ->
  for y in [imageData.height-1...0]
    for x in [0...imageData.width]
      if isPureBlack imageData, x, y
        if DEBUG then console.log "Found black pixel at #{x}, #{y}"
        return y
      else
        if DEBUG then console.log "Found non-black pixel at #{x}, #{y}"
  return -1

topRowWithAnyPureBlackPixels = (imageData) ->
  for y in [0...imageData.height]
    for x in [0...imageData.width]
      if isPureBlack imageData, x, y
        if DEBUG then console.log "Found black pixel at #{x}, #{y}"
        return y
      else
        if DEBUG then console.log "Found non-black pixel at #{x}, #{y}"
  return -1

###
topRowWithAnyPureRedPixels = (imageData, startRow) ->
  for y in [startRow...imageData.height]
    for x in [0...imageData.width]
      if isPureRed imageData, x, y
        #if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        return y
      #else
      #  if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
  return -1
###

topRowWithAnyPureRedOrBlackPixels = (imageData, startRow) ->
  for y in [startRow...imageData.height]
    for x in [0...imageData.width]
      if (isPureRed imageData, x, y) or (isPureBlack imageData, x, y)
        #if DEBUG then console.log "Found red pixel at #{x}, #{y}"
        return y
      #else
      #  if DEBUG then console.log "Found non-red pixel at #{x}, #{y}"
  return -1


newCanvasWithoutConsecutiveColumnsWithPureRedPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithoutAnyPureRedPixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width - leftmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, -leftmostColumn, 0
  return newCanvas

newCanvasWithoutConsecutiveColumnsWithPureBlackPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithoutAnyPureBlackPixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width - leftmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, -leftmostColumn, 0
  return newCanvas

newCanvasWithoutConsecutiveColumnsWithPureWhitePixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithoutAnyPureWhitePixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width - leftmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, -leftmostColumn, 0
  return newCanvas

newCanvasWithoutConsecutiveColumnsWithoutPureRedPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithAnyPureRedPixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width - leftmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, -leftmostColumn, 0
  return newCanvas

newCanvasWithoutConsecutiveColumnsWithoutPureBlackPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithAnyPureBlackPixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width - leftmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, -leftmostColumn, 0
  return newCanvas

newCanvasWithoutConsecutiveRowsWithoutPureBlackPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  topRow = topRowWithAnyPureBlackPixels imageData
  if DEBUG then console.log "topRow: #{topRow}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width
  newCanvas.height = imageData.height - topRow
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, 0, -topRow
  return newCanvas


newCanvasWithoutConsecutiveRightColumnsWithoutPureBlackPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  rightmostColumn = rightmostColumnNumberWithAnyPureBlackPixels imageData
  if DEBUG then console.log "rightmostColumn: #{rightmostColumn}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = rightmostColumn
  newCanvas.height = imageData.height
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, 0, 0
  return newCanvas

newCanvasWithoutConsecutiveBottomRowsWithoutPureBlackPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  bottomRow = bottomestRowWithAnyPureBlackPixels imageData
  if DEBUG then console.log "bottomRow: #{bottomRow}"
  newCanvas = document.createElement 'canvas'
  newCanvas.width = imageData.width
  newCanvas.height = bottomRow
  newContext = newCanvas.getContext '2d'
  newContext.putImageData imageData, 0, 0
  return newCanvas


newCanvasWithConsecutiveRowsWithPureRedPixels = (canvas, startRow = 0) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  topRowWithoutAnyPureRedPixels = topRowNumberWithoutAnyPureRedPixels imageData, startRow
  if DEBUG then console.log "topRowWithoutAnyPureRedPixels: #{topRowWithoutAnyPureRedPixels}"
  canvas = document.createElement 'canvas'
  canvas.width = imageData.width
  canvas.height = topRowWithoutAnyPureRedPixels - startRow
  context = canvas.getContext '2d'
  context.putImageData imageData, 0, -startRow
  return canvas

newCanvasWithConsecutiveRowsWithPureRedOrBlackPixels = (canvas, startRow = 0) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  topRowWithoutAnyPureRedOrBlackPixels = topRowNumberWithoutAnyPureRedOrBlackPixels imageData, startRow
  if DEBUG then console.log "topRowWithoutAnyPureRedOrBlackPixels: #{topRowWithoutAnyPureRedOrBlackPixels}"
  canvas = document.createElement 'canvas'
  canvas.width = imageData.width
  canvas.height = topRowWithoutAnyPureRedOrBlackPixels - startRow
  context = canvas.getContext '2d'
  context.putImageData imageData, 0, -startRow
  return canvas
  
newCanvasUpToColumnWithPureRedPixels = (canvas) ->
  context = canvas.getContext '2d'
  imageData = context.getImageData(0, 0, canvas.width, canvas.height)

  leftmostColumn = leftmostColumnNumberWithAnyPureRedPixels imageData
  if DEBUG then console.log "leftmostColumn: #{leftmostColumn}"
  canvas = document.createElement 'canvas'
  canvas.width = leftmostColumn
  canvas.height = imageData.height
  context = canvas.getContext '2d'
  context.putImageData imageData, 0, 0
  return canvas


showCanvasInPage = (canvas, x, y) ->
  # draw a thick black border
  #context = canvas.getContext '2d'
  #context.lineWidth = 10
  #context.strokeStyle = 'black'
  #context.strokeRect(0, 0, img.width, firstRowWithoutRed)
  document.body.appendChild canvas
  canvas.style.position = 'absolute'
  canvas.style.top = y + 'px'
  canvas.style.left = x + 'px'

doit = ->
  canvas = document.createElement('canvas')
  context = canvas.getContext('2d')
  img = document.getElementById('myimg')
  canvas.width = img.width
  canvas.height = img.height
  context.drawImage img, 0, 0

  ###
  # select the first row marked by the first red rectangle
  canvas3 = newCanvasWithConsecutiveRowsWithPureRedPixels canvas
  showCanvasInPage canvas3, 50, -50

  # now cut out the red rectangle at the left
  canvas4 = newCanvasWithoutConsecutiveColumnsWithPureRedPixels canvas3
  showCanvasInPage canvas4, 50, -50

  # take now the part up to the second red rectangle, i.e. the letter "A"
  # used to see where the baseline and ascenders are
  canvas5 = newCanvasUpToColumnWithPureRedPixels canvas4
  showCanvasInPage canvas5, 200, 200

  # draw a green horizontal line on canvas 5 showing the baseline
  # i.e. where the last row with black pixels is, in the capital "A"
  context = canvas5.getContext '2d'
  context.lineWidth = 10
  context.strokeStyle = 'green'
  lastRowWithBlackPixels = bottomestRowWithAnyPureBlackPixels context.getImageData(0, 0, canvas5.width, canvas5.height)
  context.strokeRect(0, lastRowWithBlackPixels, canvas5.width, 1)

  # draw a green horizontal line on canvas 5 showing the ascender
  # i.e. where the first row with black pixels is, in the capital "A"
  context = canvas5.getContext '2d'
  context.lineWidth = 10
  context.strokeStyle = 'green'
  firstRowWithBlackPixels = topRowWithAnyPureBlackPixels context.getImageData(0, 0, canvas5.width, canvas5.height)
  context.strokeRect(0, firstRowWithBlackPixels, canvas5.width, 1)


  # now take the part from the second red rectangle (included) onwards
  canvas6 = newCanvasWithoutConsecutiveColumnsWithoutPureRedPixels canvas4
  showCanvasInPage canvas6, 300, 300

  # draw a green horizontal line on canvas 6 showing the descender
  # i.e. where the last row with black pixels is, in the "y"
  context = canvas6.getContext '2d'
  context.lineWidth = 10
  context.strokeStyle = 'green'
  lastRowWithBlackPixels = bottomestRowWithAnyPureBlackPixels context.getImageData(0, 0, canvas6.width, canvas6.height)
  context.strokeRect(0, lastRowWithBlackPixels, canvas6.width, 1)

  # draw a green horizontal line on canvas 6 showing the X-height
  # i.e. where the first row with black pixels is, in the "y"
  context = canvas6.getContext '2d'
  context.lineWidth = 10
  context.strokeStyle = 'green'
  firstRowWithBlackPixels = topRowWithAnyPureBlackPixels context.getImageData(0, 0, canvas6.width, canvas6.height)
  context.strokeRect(0, firstRowWithBlackPixels, canvas6.width, 1)

  # now skip to the next "red rectangle" section i.e. the next letter
  context = canvas.getContext('2d')


  ###
  startRow = 0
  for i in [1...109]
    # why not just use the top of the red rectangles to as the top boundary?
    # because at some font sizes some letters have the accent mark that goes above it
    # Note that no descenders seem to go below it at any font size (however, if they did, we still catch any
    # descenders as long as they are "contiguously black" vertically speaking)
    startRow = topRowWithAnyPureRedOrBlackPixels context.getImageData(0, 0, canvas.width, canvas.height), startRow
    canvas7 = newCanvasWithConsecutiveRowsWithPureRedOrBlackPixels canvas, startRow
    startRow += canvas7.height

    canvas8 = newCanvasWithoutConsecutiveColumnsWithPureBlackPixels canvas7
    canvas9 = newCanvasWithoutConsecutiveColumnsWithoutPureBlackPixels canvas8
    canvas10 = newCanvasWithoutConsecutiveRightColumnsWithoutPureBlackPixels canvas9
    canvas11 = newCanvasWithoutConsecutiveRowsWithoutPureBlackPixels canvas10
    canvas12 = newCanvasWithoutConsecutiveBottomRowsWithoutPureBlackPixels canvas11
    showCanvasInPage canvas12, 400, startRow + i * 1




  # encode the canvas2 as a dataurl in png format and print it out
  #if DEBUG then console.log canvas2.toDataURL('image/png')



