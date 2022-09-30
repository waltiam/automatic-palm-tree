(module 
  (memory $mem 1)
  (global $currentTurn (mut i32) (i32.const 0))
  (global $CROWN i32 (i32.const 4))
  (global $WHITE i32 (i32.const 1))
  (global $BLACK i32 (i32.const 2))

  (func $indexForPosition (param $x i32) (param $y i32) (result i32)
    (i32.add 
      (i32.mul
        (i32.const 8)
        (local.get $y)
      )
      (local.get $x)
    )
  )

  (func $offsetForPosition (param $x i32) (param $y i32) (result i32)
    (i32.mul 
      (call $indexForPosition (local.get $x) (local.get $y))
      (i32.const 4)
    )
  )

  (func $isWhite (param $piece i32) (result i32)
    (i32.eq 
      (i32.and (local.get $piece) (global.get $WHITE))
      (global.get $WHITE)
    )
  )

  (func $isBlack (param $piece i32) (result i32)
    (i32.eq 
      (i32.and (local.get $piece) (global.get $BLACK))
      (global.get $BLACK)
    )
  )

  (func $isCrowned (param $piece i32) (result i32)
    (i32.eq 
      (i32.and (local.get $piece) (global.get $CROWN))
      (global.get $CROWN)
    )
  )
         
  (func $addCrown (param $piece i32) (result i32)
    (i32.or (local.get $piece) (global.get $CROWN))
  ) 

  (func $removeCrown (param $piece i32) (result i32)
    (i32.and (local.get $piece) (i32.const 3))
  ) 

  (func $setPiece (param $x i32) (param $y i32) (param $piece i32)
    (i32.store
      (call $offsetForPosition 
        (local.get $x)
        (local.get $y)
      )
      (local.get $piece)
    )
  )
  
  (func $getPiece (param $x i32) (param $y i32) (result i32)
    (if (result i32)
      (block (result i32)
        (i32.and
          (call $inRange
            (i32.const 0)
            (i32.const 7)
            (local.get $x)
          )
          (call $inRange
            (i32.const 0)
            (i32.const 7)
            (local.get $y)
          )
        )
      )
      (then 
        (i32.load 
          (call $offsetForPosition
            (local.get $x)
            (local.get $y)
          )
        )
      )
      (else (unreachable))
    )
  )
  
  (func $inRange (param $min i32)(param $max i32) (param $value i32) (result i32)
    (i32.and 
      (i32.ge_s (local.get $value)(local.get $min))
      (i32.le_s (local.get $value)(local.get $max))
    )
  )
  
  (func $getTurnOwner (result i32)
    (global.get $currentTurn)
  )
  
  (func $toggleTurnOwner
    (if (i32.eq (call $getTurnOwner) (global.get $WHITE))
      (then (call $setTurnOwner (global.get $BLACK)))
      (else (call $setTurnOwner (global.get $WHITE)))
    )
  )
  
  (func $setTurnOwner (param $piece i32)
    (global.set $currentTurn (local.get $piece))
  )
  
  (func $isPlayersTurn (param $player i32) (result i32)
    (i32.gt_s
      (i32.and (local.get $player)(call $getTurnOwner))
      (i32.const 0)
    )
  )
  
  (func $shouldCrown (param $pieceY i32) (param $piece i32) (result i32)
    (i32.or
      (i32.and
        (i32.eq (local.get $pieceY) (i32.const 0))
        (call $isBlack (local.get $piece))
      )
      (i32.and
        (i32.eq (local.get $pieceY) (i32.const 7))
        (call $isWhite (local.get $piece))
      )
    )
  )
  
  (func $crownPiece (param $x i32) (param $y i32)
    (local $piece i32)
    (local.set $piece (call $getPiece (local.get $x)(local.get $y)))
    (call $setPiece (local.get $x) (local.get $y) (call $addCrown (local.get $piece)))
    (call $notify_pieceCrowned (local.get $x)(local.get $y)))
  )

  (func $distance (param $a i32) (param $b i32) (result i32)
    (i32.sub (local.get $a)(local.get $b))
  )

)