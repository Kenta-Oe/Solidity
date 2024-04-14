// SPDX-License-Identifier: UNLICENSED

// Solidityのファイルはこのプラグマで始める必要があります。
// Solidityコンパイラがそのバージョンを検証するために使用されます。
pragma solidity ^0.8.0;

// これはスマートコントラクトのための主要な構成要素です。
contract myToken {
    // トークンを識別するための文字列型の変数です。
    string public name = "MyToken";
    string public symbol = "MYT";

    // トークンの固定量を符号なし整数型変数で格納します。
    uint256 public totalSupply = 1000000;

    // Ethereumアカウントを格納するためにアドレス型変数が使用されます。
    address public owner;

    // マッピングはキー/値のマップです。ここでは各アカウントの残高を保存します。
    mapping(address => uint256) balances;

    // Transferイベントは、オフチェーンアプリケーションがコントラクト内で何が起こるかを理解するのに役立ちます。
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * コントラクトの初期化。
     */
    constructor() {
        // totalSupplyはトランザクションの送信者に割り当てられます。これは、
        // コントラクトをデプロイしているアカウントです。
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * トークンを転送する関数。
     *
     * `external`修飾子は関数を*外部*から*のみ*呼び出すことができるようにします。
     */
    function transfer(address to, uint256 amount) external {
        // トランザクションの送信者が十分なトークンを持っているか確認します。
        // `require`の最初の引数が`false`と評価された場合、
        // トランザクションはリバートされます。
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // 量を転送します。
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // オフチェーンアプリケーションに転送を通知します。
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * 与えられたアカウントのトークン残高を取得するための読み取り専用の関数。
     *
     * `view`修飾子は、それがコントラクトの状態を変更しないことを示し、
     * トランザクションを実行せずにそれを呼び出すことができることを可能にします。
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
