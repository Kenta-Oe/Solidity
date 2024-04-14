"use client"
import { ethers } from "ethers";
import { useEffect, useState } from "react";
import artifact from "../abi/Mytoken.sol/Mytoken.json";

//デプロイしたMytokenのアドレス
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

export default function Home() {
  const [windowEthereum, setWindowEthereum] = useState();
  const [inputValue, setInputValue] = useState("");

  useEffect(() => {
    const { ethereum } = window as any;
    setWindowEthereum(ethereum);
  }, []);

  const handleButtonClick = async () => {
    if (windowEthereum) {
      const provider = new ethers.BrowserProvider(windowEthereum);
      const signer = new ethers.Contract(
        contractAddress,
        artifact.abi,
        provider
      );
    const walletAddress : string = await signer.getAddress();
        const balance = await contract.balanceOf(walletAddress);
        setInputValue(balance.toString());
    }
  };

  return(
  <div>
    <h1>Blockchain sample app</h1>
    <button onClick={handleButtonClick}>Tokens owner</button>
    <input type="text" value={inputValue} readOnly />
  </div>
  );
}