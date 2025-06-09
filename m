Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8388FC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB22640B8F;
	Mon,  9 Jun 2025 09:05:22 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id CBAF740661;
 Mon,  9 Jun 2025 09:05:18 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452714t2b43affc
X-QQ-Originating-IP: raM430ZCn63BFc8JIBfpdMRK2wdv0uHcmFgBLIptq48=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10835568398516550477
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 03/12] net/txgbe: fix reserved extra FDIR headroom
Date: Mon,  9 Jun 2025 15:04:45 +0800
Message-ID: <C2EFD7259E98FF0B+20250609070454.223387-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MSrNHHHirmth57yk78xp6W69joqYxWY5t3fSGrvxdPbZlDHWk29ZwsOt
 ukaT+Lk7QFx+a4uBMLf2n58BIgMW/6z2gpL/hHJ7GtjtiaB4DCW1M3qOiMwGaTwOUKqo5/h
 hUji6pDubb9GknzXV2d7jNS4Qn6QoJsbiHJMrT8PYxAn1evJTCNAvyX+CyfUWKyyAGi29yb
 Mvjs44V/ETixlw6wsMa5zUwl9V1pbg6rOffHis5/0R6Vo8HDm++eJ/7dWLLxbAh54SVEI7g
 8baiotsg9tyMDMuYSH+3oYXfCCSZPIKuxImk0UFsp7rUqpyIr/uvBS15uwyqKOIQuDrWHg8
 MGBMVH+lTMT1wN3vmgzvurwNWDxdJ3X0Of8gwlY5EUbo8xJJusJHoCbW1OwAfLtxmxm0ZiU
 oZKQXOmcjfYqVfiizAxNxas0E3cStqkdGv8v/5nY2ccip/SF+k5q1gE4LlsA5T37lNQfq7Z
 4ykGQnST7YT3lGc688WspOSw5QG/IOOWJkTw+sDDU6tIXcupgi6Mit28ReYT7+ahTTu+S5J
 z4EJK+cMd2P965vBOPnBWZj6UcUEVmnvCe1Y5QqS6Y8K/ySSFIyChKVSdp6GyvcnA25iitJ
 NEqsnJG21VYAodXUA4B2itxOE5Os3bak/SGRMNKNBQFwyeSXVoRNC9JB4+udXL6naUcBF6C
 YHCP5yMM6QFl0OG9NFe1cOqkwKPw8tIjZWCLITsW+j1CT/36fMWRinJFpWFFaBAagkEJiVU
 1xDNcrtWvkwhOy+gVEGcqn3/Jh1xjpnCBdG1Vdsn6j3gxVjVN+CfjboJc0llwBuuRAJY6w1
 0PQmVBfQiUDVlGem4CvHxaTP97zPaOTY6MzC4b9PvfiTcs/LI3J84DI7BdyRKHC4k9FjhC0
 kn6HGulIa41E3rY9eit6HCdB9MpB/+fGrxqhvBEVyUEBotVQCMwasbmyLlGkF+9qZ4BxCS9
 Eters+9sIZTycz4Pu7VijWzgAamPVBv+FCwyvBS5irSYF2qz616AbLReFSxAAziBxkxWz1L
 nIkJXWlRXh/4pTQEKPVY4BPHuSwJy1tV20tLLvtA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Remove redundant 256KB FDIR headroom reservation. FDIR headroom was
already allocated in txgbe_fdir_configure() when FDIR is enabled, the
second reservation resulted in 256KB less available RX packet buffer than
the theoretical size.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index ae2ad87c83..76b9ee3c0a 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2106,9 +2106,7 @@ void txgbe_set_pba(struct txgbe_hw *hw, int num_pb, u32 headroom,
 	u32 rxpktsize, txpktsize, txpbthresh;
 
 	UNREFERENCED_PARAMETER(hw);
-
-	/* Reserve headroom */
-	pbsize -= headroom;
+	UNREFERENCED_PARAMETER(headroom);
 
 	if (!num_pb)
 		num_pb = 1;
-- 
2.48.1

