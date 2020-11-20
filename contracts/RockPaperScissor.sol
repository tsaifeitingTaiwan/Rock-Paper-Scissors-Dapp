pragma solidity 0.5.0;

contract RockPaperScissor {
    address payable public zotau;
    bool  SCISSORS;
    bool  PAPER;
    bool  ROCK;
    string public whoWin;	
    
    uint  price;
    uint  zotauanswer;
    address payable public winner;
 
    enum State {Start , end}
    enum Gesture {scissors , rock, paper}
    State public state ;
    
    mapping(address => uint) public counts ;
    mapping(address => Gesture) public yourGesture;
    

constructor(uint _price)public payable{
    zotau = msg.sender;
    price = _price * 1 ether;
    state = State.Start;
    //  this.transfer(address(msg.send);
     
    zotauanswer = (uint256(sha256(abi.encodePacked(now))) % 3)+1; 
    // this.transfer(msg.value);；
       address(this).transfer(msg.value);
}

modifier checkState(State _state){
        require(state == _state);
        _;
    }

modifier musthavegesture(){
        // require(yourGesture[msg.sender] != null);
        _;
    }
    
modifier onlyOwner{
        require(zotau == msg.sender, "You are not owner");
        _;
    }
    
    
 function scissors() public payable {
    
     address(this).transfer(msg.value);
     
     SCISSORS = true;
     ROCK = false;
     PAPER = false;
      require(state == State.Start);
      if (zotauanswer == 1 ) {
          whoWin="再玩一次";
          
          
      }
      if (zotauanswer == 2 ) {
          whoWin="莊家拿錢";
          winner = zotau;
          
      }
      
      if (zotauanswer == 3 ) {
          whoWin="莊家輸錢";
          winner = msg.sender;
        //   winner = zotau;
           address(winner).transfer(msg.value* 2 );
          
      }
    require(zotau != msg.sender);
    
    // winner.transfer(address(owner).balance * 9 / 10);
 } 
 
 function rock() public payable{
    // _guessMoney=msg.value;
     address(this).transfer(msg.value);
     
     ROCK = true;
     SCISSORS = true;
      require(state == State.Start);
    require(zotau != msg.sender);
       if (zotauanswer == 1 ) {
         whoWin="莊家輸錢";
         winner = msg.sender;
        //   winner = zotau;
            // if (this.getContractBalance > msg.vlaue*2) {  
                // address(msg.sender).transfer(msg.value);
                address(winner).transfer(msg.value*2);
                   
            // }
            
      }
      if (zotauanswer == 2 ) {
           whoWin="再玩一次";
          
      }
      
      if (zotauanswer == 3 ) {
           whoWin="莊家拿錢";
        //   winner = msg.sender;
          winner = zotau;
      }

     
     
 }
 
 function paper() public payable {
      
     address(this).transfer(msg.value);
     
      
     PAPER = true;
      require(state == State.Start);
    require(zotau != msg.sender);
    
     if (zotauanswer == 1 ) {
         whoWin="莊家拿錢";
        //   winner = msg.sender;
          winner = zotau;
      }
      if (zotauanswer == 2 ) {
           whoWin="莊家輸錢";
          winner = msg.sender;
             address(winner).transfer(msg.value*2);
        //   winner = zotau;
      }
      
      if (zotauanswer == 3 ) {
           whoWin="再玩一次";
          
      }
      

 }

function ()external payable{}

function sendmoney()public payable checkState(State.end) onlyOwner{
        if (winner == zotau) {
        //問老師
        zotau.transfer(address(this).balance * 9 / 10);
        // zotau.transfer(address(this).balance);
        }
        else{
            if(winner == msg.sender){
                winner.transfer(address(this).balance * 9/10);
                zotau.transfer(address(this).balance);
            }
        }
}    
function getContractBalance() public view returns(uint){
        return address(this).balance;
}

}





