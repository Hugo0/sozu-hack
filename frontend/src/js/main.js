
function toggleForm() {
    const formContainer = document.getElementById('formContainer');
    const toggleIcon = document.getElementById('toggleIcon');
    if (formContainer.style.display === "none" || formContainer.className === "hidden") {
        formContainer.style.display = "block";
        formContainer.className = "";
        toggleIcon.className = "fas fa-chevron-up";
    } else {
        formContainer.style.display = "none";
        formContainer.className = "hidden";
        toggleIcon.className = "fas fa-chevron-down";
    }
}


async function testNFTCall(wallet) {

    // check the balannce of an NFT for current wallet
    console.log("current wallet address: ", wallet._address);
    console.log('connected to chainId: ', (await provider.getNetwork()).chainId);
    let NFT_contract_address = "0x932ca55b9ef0b3094e8fa82435b3b4c50d713043";
    let NFT_contract_abi = [
        "function balanceOf(address owner) external view returns (uint256 balance)",
    ];
    let NFT_contract = new ethers.Contract(NFT_contract_address, NFT_contract_abi, wallet);
    let balance = await NFT_contract.balanceOf(wallet._address);
    console.log("balance: ", balance);            
}

function testGetEncodedFunctionData(wallet) {
    let ABI = [
        "function balanceOf(address owner)"
    ];
    let iface = new ethers.utils.Interface(ABI);
    let encodeFunctionData = iface.encodeFunctionData("balanceOf", [ wallet._address ])
    console.log("encodeFunctionData: ", encodeFunctionData);
    return encodeFunctionData;
}


function getEncodedFunctionData(function_signature, input) {
    // TODO: support functions with multiple inputs
    let ABI = [
        // "function balanceOf(address owner)"
        function_signature
    ];
    function_name = function_signature.split("(")[0].split(" ")[1];
    let iface = new ethers.utils.Interface(ABI);
    let encodedFunctionData = iface.encodeFunctionData(function_name, [ input ])
    console.log("encodedFunctionData: ", encodedFunctionData);
    return encodedFunctionData;
}

async function testSendData(wallet) {
    let dataEndpointContractAddress = "0x9fa4cfab777274aedbd7a5c39b733c3e4534844f";
    let NFT_contract_address = "0x932ca55b9ef0b3094e8fa82435b3b4c50d713043";
    let dataEndpointContractABI = [
        "function sendData(address contractAddress, bytes memory encodedFunctionData, uint32 destinationDomain, bytes32 recipient) public payable returns(bytes memory)"
    ];
    let dataEndpointContract = new ethers.Contract(dataEndpointContractAddress, dataEndpointContractABI, wallet);
    let encodedFunctionData = getEncodedFunctionData(wallet);
    let destinationDomain = 420;
    let recipient = ethers.utils.hexZeroPad("0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685", 32);
    // let recipient = ethers.utils.formatBytes32String("0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685");
    let result = await dataEndpointContract.sendData(NFT_contract_address, encodedFunctionData, destinationDomain, recipient, {value: ethers.utils.parseEther("0.01")});
    console.log("result: ", result);        
}


async function testCallDataEndpoint(){
    let dataEndpointContractAddress = "0x9fa4cfab777274aedbd7a5c39b733c3e4534844f";
    let NFT_contract_address = "0x932ca55b9ef0b3094e8fa82435b3b4c50d713043";
    let dataEndpointContractABI = [
        "function sendData(address contractAddress, bytes memory encodedFunctionData, uint32 destinationDomain, bytes32 recipient) public payable returns(bytes memory)"
    ];
    let dataEndpointContract = new ethers.Contract(dataEndpointContractAddress, dataEndpointContractABI, wallet);
    let encodedFunctionData = getEncodedFunctionData(wallet);
    let destinationDomain = 420;
    let recipient = ethers.utils.hexZeroPad("0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685", 32);
    // let recipient = ethers.utils.formatBytes32String("0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685");
    let result = await dataEndpointContract.sendData(NFT_contract_address, encodedFunctionData, destinationDomain, recipient, {value: ethers.utils.parseEther("0.01")});
    console.log("result: ", result);        
}


async function sendData(wallet, dataEndpointContractAddress, encodedFunctionData, destinationDomain, recipient, value) {
    dataEndpointContractAddress = "0x9fa4cfab777274aedbd7a5c39b733c3e4534844f";
    let dataEndpointContractABI = [
        "function sendData(address contractAddress, bytes memory encodedFunctionData, uint32 destinationDomain, bytes32 recipient) public payable returns(bytes memory)"
    ];
    let dataEndpointContract = new ethers.Contract(dataEndpointContractAddress, dataEndpointContractABI, wallet);
    let result = await dataEndpointContract.sendData(NFT_contract_address, encodedFunctionData, destinationDomain, recipient, {value: ethers.utils.parseEther(value)});
    console.log("result: ", result);
    return result;
}

async function readData(wallet, srcContractAddress, encodedFunctionData) {
    // calls readData function on destination contract
    // function readData(
    //     address contractAddress, 
    //     bytes memory functionSignature
    // ) public view returns(bytes memory) {
    //     return data[contractAddress][functionSignature];
    // }
    let registryContractAddress = "0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685"; // harcoded for now, optimism testnet
    let registryContractAbi = [
        "function readData(address contractAddress, bytes memory functionSignature) public view returns(bytes memory)"
    ];
    let registryContract = new ethers.Contract(registryContractAddress, registryContractAbi, wallet);
    let result = await registryContract.readData(srcContractAddress, encodedFunctionData);
    console.log("readData() result: ", result);
    return result;
}

async function pollRegistryForStateChange(wallet) {
    // polls registry contract for new event / transaction
    // if new event, return event
    let registryContractAddress = "0xfe5CD4EB9748C62B6B3edd36FA6c033c95D2f685"; // harcoded for now, optimism testnet
    // get number of latest transaction of contract
    let registryContractAbi = [
        "function readData(address contractAddress, bytes memory functionSignature) public view returns(bytes memory)"
    ];
    let registryContract = new ethers.Contract(registryContractAddress, registryContractAbi, wallet);

    // TODO: do later. Just add button for now that calls readData() when we know it's ready
    // ...
}

// // get NFTs using alchemy
// const axios = require('axios')

// // Wallet address
// const address = 'elanhalpern.eth'

// // Alchemy URL
// const baseURL = `https://eth-goerli.g.alchemy.com/v2/DFAY_eQ0hxon_stElS4hJoxSyn0sLH4n`;
// const url = `${baseURL}/getNFTs/?owner=${address}`;

// const config = {
//     method: 'get',
//     url: url,
// };

// // Make the request and print the formatted response:
// axios(config)
//     .then(response => console.log(response['data']))
//     .catch(error => console.log('error', error));
