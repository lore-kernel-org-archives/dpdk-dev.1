Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CFBC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 257E042E6E;
	Tue, 22 Sep 2026 14:54:47 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id C00F642E93;
 Tue, 22 Sep 2026 14:54:44 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081682taa3bdf4b
X-QQ-Originating-IP: JZE4orl05EamI2dZPbGhLJeYaWzTcn57gbxmk1CDA7w=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9162710848094194004
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 08/16] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue, 22 Sep 2026 20:37:41 +0800
Message-ID: <405C1BA22C44ABE8+20260922125414.3638-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OE3tIrIEWSq4hR7465LqEypQdUBa76mm+nQjw8buqHgeHCDo8vYMJxFK
 WPUXQooO3c4FIxyscV94SmoL1hsRl9cF2xpnlwCHhDbYERx3s6daoNDhGPpCewjx5i/QEMr
 IIS3vnpQS99uPHUcZy1Sx/jb6A34L/9DNAxGEMFZWBC0PX3GNcfuaAVQiwibYFt0azoRYp0
 xbLFBR4xomhyQ6aieFptewcYivPCdKnr7/KJ6R9H+3bZf91rP22MMAItufIO1010yMFtcRT
 6gu2NHr86hZnlt5uGir1P4U2Xrn195fMv1tszGt5kGbhbu+Ufbdgkhc4gXESI9DPnzWTsAO
 tfLetGhh23d+DGC1MNG7fGhbHM50R1exVsEJ2SJ5lnyhjZoGWWXOVBFU4VNl/fAFEO30a/k
 bojOQd+SaFHJslprxlJfLnRVeqd9EP0V6G5W9sLAAnsRobBjHm3+L9SzBxlw2lxctMKVCDp
 UvlVmdmxF3Uh2yFMbgRet+0668ajMsI+UCqlE9kcJcUfwyohFjM/U3g/PshBZSBw3qIINGl
 k0c3I/w3Cmff+2dNV0rdSjKEukmc/wKW87Nfk81Rf6rbhVZ9Rci0697SwhEg986Xz0hFi8n
 w4Tt98+JealyNOWHByDci31MQ4wJuLRhuJi/oopXR/8f/AxtPECb6miDGvyOxIF77KgWhg4
 9jc5La+dDdC7j5XRraIe0gA1GKJZXZuZjJAsrwyG4s7oiRexzRRKcddCMgsjA+v19mtJhdQ
 CrXsvIcZ/2lpABL9GPTkfnsKQ94P/Wygl8JNqzR+fEaGo9BD69J2S4T87tsgAIfefrGX1ul
 qNgJxJ8nBN3Paa/t9egKN+9K61+BvIVqsdP2KmJGjz/ImehpB8cSmtLbVW6WIgUwYI8ntge
 KbTxrZD9J1rgT1LRwHRZRh7tCDAtMnhFGlepC95MPg4lpLkrNehx+d+OlTp5/Tx7O0Vf+/6
 /+ACsr4oubtPD+OjeoY1CZkoG9KdK60ajzIEOOWNXQmaZCSI5EmI4usaIU64rdpQoX8Rrr7
 7TU1nW6nd5Xh2NtjqJlCjmpNIYH+8Ty8Dbc8d+aWcxQufTCLG9WQ3hTBwwqJH/mp6x3Nbzp
 A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

RTE_MBUF_F_TX_OUTER_UDP_CKSUM is no longer advertised in
dev_info->tx_offload_capa, but it is still listed in
TXGBE_TX_OFFLOAD_MASK. The two are now inconsistent: a packet
carrying the flag is accepted by the offload mask check although the
driver no longer handles it.

Drop the flag from TXGBE_TX_OFFLOAD_MASK so the advertised
capability and the accepted offload flags match.

Fixes: 25fe1c780d39 ("net/txgbe: remove outer UDP checksum capability")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 794ba041a4..a295666f9d 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -61,7 +61,6 @@ static const u64 TXGBE_TX_OFFLOAD_MASK = (RTE_MBUF_F_TX_IP_CKSUM |
 		RTE_MBUF_F_TX_UDP_SEG |
 		RTE_MBUF_F_TX_TUNNEL_MASK |
 		RTE_MBUF_F_TX_OUTER_IP_CKSUM |
-		RTE_MBUF_F_TX_OUTER_UDP_CKSUM |
 #ifdef RTE_LIB_SECURITY
 		RTE_MBUF_F_TX_SEC_OFFLOAD |
 #endif
-- 
2.55.0.windows.2

