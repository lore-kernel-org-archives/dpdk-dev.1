Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821FD606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B80040663;
	Fri, 23 Oct 2026 13:08:16 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 98DAD4060C;
 Fri, 23 Oct 2026 13:08:13 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753690t4850fdbf
X-QQ-Originating-IP: PXzIVgQBgradshr6rGJ5NOfNMfxQECdRiJtVeq8uV70=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12005351997367957140
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 08/17] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Fri, 23 Oct 2026 19:03:46 +0800
Message-ID: <CD11C1A8B77AFD9F+20261023110728.3975-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nfb8qmDGnFI1TzRiDJOgAeYO4flgEV0WROGlL9J7wpVT76KCSXWEVCx+
 zidG0LcC0Zg3idj/S2MCtdVKztqzz5NYObfFeGr1nmkNBk7MVBWjELtL00bX7nVXKtMa72k
 cpFH4eFMkGUIJLY7tybO4Wu4vNcPa6Rf3qXXPoahV7q7NInsWHIjbFvKNCdm2w2DNAyVcZ1
 b8PaeYoBHUptIvTqFKCE1trbN1AM6MnEKu7RjrZ3VmkjKsWtwK+pBqlxWGyF0QfKGkSjhdw
 XKpmS1d5F4gwmoRlXCBwXyZN6erBEJGMauiKja6Uo57r/InVZBoOL5BrAWBNdTdHEyUeW9Y
 25LAvZWIS0Gi9UwdyXIpW26ikXJ8qn+go6JrEanTCIt5bP/KjIpB+uFU1E4P9bCEzqlJG0c
 RWDWbC+7MiPVDpwHOSkYwKIIKzpbAe5RlMoskgfikmmOlI4MX8GfKRbtX6Y9p5KPjaFLsi9
 N5QZtptTCdwV9ziMQpy0OHjkgfKRuDNIyrB+9SMYVmSKEALGmjCHWyyE4y9Onpw8LltCWXj
 RgxH8oROAXltOi/P2/BJR2wzIbzHzzXo2SKhODNDFHJF0rCQY2D0Dai/VWwtEEJH4JNl4t+
 sbrNSCPCzLTalu3HbE0QB8+I2jrzFGTuAhhCx3ANbjqlEJP9JkNQU+GFbmTiXZkeo8cLSrG
 yLEnbWoy2/7HUtXWDF6ZrCPeGEl3LximqKbNpPgpPPnAUumThLj/KqsdVdIbxm61ywraJyh
 R6PCvj4U9orhpxTBvbm0qc2Xs30fmWpHBOfh4dF1wXqvHl+qD1vZFHYL9ade2E2sV+PZo9S
 8EYAJP+jC8kzqMnA8EvzrbXTAvIEW4TGX9xVBI2sUb2ZPPrMlgVeO/O16HodWP2cygjphkw
 /C2XlUvtaN9J/1CGFSKVXI/jyzwiyFtBCOCIZOO0wTxg5uCQ1DPWOSJ76gl05Flcr/UUthR
 H00ayTTgk/EThjR36hVCFcmYRqJzNeGxI12M7paBa2h49t7Prmp62vnzvkPR3vTy31w2a56
 muRPOFEqFCAmAKNeufeAm2TAo4rc02swDzFk0yRjZlo1eKkcjLaQ8L4vNG2Ev4JfJnq8rce
 ZaLrhldTT865XwauFA5f+pjJIsFcFun4Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

