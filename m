Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E4CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D46CC40395;
	Wed, 27 May 2026 13:11:52 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 929B04028A
 for <dev@dpdk.org>; Wed, 27 May 2026 13:11:50 +0200 (CEST)
X-QQ-mid: Yeas6t1779880303t090t42907
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 1952813347519264943
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-19-zaiyuwang@trustnetic.com>
 <20260517165434.5a4e3a72@phoenix.local>
In-Reply-To: <20260517165434.5a4e3a72@phoenix.local>
Subject: RE: [PATCH v4 18/20] net/txgbe: fix get EEPROM operation
Date: Wed, 27 May 2026 19:11:41 +0800
Message-ID: <00bf01dcedc9$98ce2b50$ca6a81f0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAa3yeRcBjGqyMbVCiHVQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MN7J+qOXnZ1LdjGfz3an6wX/TwGr/Y++BLg+SSMQZpWqy/4JRlHltGMq
 PbJUFLEDEO+ok/MnVH70QvXB9vQiltaMWgQy3ZgTQ3Ad9b/cB3lMFpOyStyttnyMugAa1v6
 S4Qa5CbSy/Zx/wM3hm80ZBPnsr4m+UVCXHMerwn6787UKkTZ8XzeVTAaWa/6qitQgUz77lT
 gnCId3u6tuyha9RSsY7G6XoFa0N5yO3It21gRtKWDgdwXx295nbOq6vxYQqeoCfPNHA0b8+
 lVRPsrkSq2sHThT1gV3XGog22f7/cN5/Tq4mKyjuaraNKRi0+6+hnJ9dvboh85n7WbO/KfT
 sIUN6dcdM4o2cW7xHa93LW2sAPlHU5Dfx+ribI3aGFG1bxEI5/Dgy8mEtkKrNp8M335oWGT
 l9/O0AQuI8eUTeinjf4wo2DIGmrXl4LZJVZ5GZ9/W2j5C8kccR1bUmiJ+Zviej5blsmbite
 76yIfECpKBN1R4FeusG1+6JZVVtDsN3Pgoo11oVNGhdKPzimaJNTuwOSl8GKyNX3RqJwPQ6
 TJ/ZaAzlUlOAJMFbvjWeRP5bq3VY4Gc7xIPNybyCYq7QOAr00DmkGnWPQhPVvmJoyH8b1mO
 RKbH7/wIB5ng2GibvGASa2rD3DloZEBM8L3IE/X8M1SOE2OBDZsMaTBe5BhbU3YAlDWwdk3
 GYmXZ922/5sWldVFC92nA09tWgqBrZZz0nQv9ZNBGUC1AG3TJvUM0l+PwxXfBC/IPX+XewE
 5xOJG5W7C5djGVIUaV63pYvynI9w4zRURmlC5EynHmS3c3oXtm/ndjBf0QY2RrtkYcTD5r0
 LN0Pn9tMzsKoeKVzBmcMP3LQ1ayCBztIY8YmSMbSR2gr9XDks9cry9Bf1fF+DIu0pGkNMAS
 1xAM+7lS+KClQsMaV50aO8hvTMRyUXNz1cbkNu5nKYltf2xkiiGoXBY4IvCvnvpMz7GzPL/
 kot3gNkUjxEGjbza+KlS0mV/Suuk7HRTFhVYvq59x2TKVCXjRiFx7QiNyYK5n9VJBdfcfNY
 HfGoUOBQXPju5lm8l9Abgz5d0Cdsr9K3kbxO4JP4A3Hpj3JOeH18ch0HD8eJY=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org


> I agree with AI that u8, u16 should not be used except in base/ code.
> 
Fixed. 

