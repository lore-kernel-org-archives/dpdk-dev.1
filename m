Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9968CC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A5242F53;
	Fri, 13 Jun 2025 10:42:54 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 4CD8142ED0;
 Fri, 13 Jun 2025 10:42:50 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804168tcd7c7bf5
X-QQ-Originating-IP: RI7Jnhmu3v/7cNVgjAMHlCU3TfVXhwFZPYkRVfZDRsg=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4820752736188005470
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 17/17] net/txgbe: add missing LRO flag in mbuf when LRO
 enabled
Date: Fri, 13 Jun 2025 16:41:59 +0800
Message-Id: <20250613084159.22184-18-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OYMEOeTae7mlIN3nWYrY+O+kV/2MtUYvmD+rN+NbN+Tbe1mIBTcFs1vi
 Ene/4HHCu0oTJIiU6rPdsEz35Z356sT7pFAlfQ0GhbFxuCGs3hSdE+ONZMVafMh+mtOiaKl
 pySFuDGklsAmf2JmXheCiaczxQPiPBz2i41mv8m3/FbLTVr5v7dFdE3K+cTS3WJ0cP1hq4M
 XFQEQzAa4JUZIGBFXqYb65qFvVQzNaoBq/CWdbwxu8uoUWc3JPqJvdCMQavAP0wJlgKfxcM
 V0qXZfw8oa2t+c+T1GkumQrBobCPn7pjRdi9c5/kfLO+nypHgA3rbRSWLWpLxJhXWWyk8xP
 k0gjondVxjAjixHBjZCzOPzZiWyjkCp/wcZiluVzvAOVc2NK6fdXBzim6izXJFwwTx2vDrd
 +FdjpmFMP2BGgE1YFloLkZWSKHuKJwXwV6qOpku5cFdZ5ToTY0rl0/mwmhLPe1hVzlCXYvi
 OIfLwHWp4tJl3+7pvnj4j5Q1mPDhQ5s4WYUXVqND+trG4TCqhiAHFSgBjsWqliy82mmmazK
 M3m+IeyUnsdlnQ1Z1WRL9TXG/gyW0a4CEVKgiai85P9gH8N1dW5p4QtLO4Dh6wVG9DWKCba
 m/2l/7H1nc79rFQrC/0iHNLLiB/GBnkB8KJJ7QGp0PlBwzvj5yxnl7eU8MQbV4WWoPLDQ86
 Ij+1uKJwO9fSpCWomtoXn0TA68KOFqeIl697KJb1cNYespqpe5yxsp8J/fKM1Lr/Fw5m3pI
 ESpj2bg5yPfjUnbAfkfqJ8MtGgokl2p2SaIqhW0oBGehjr0DA5f70HNuaV2SytpguhdvwNx
 Xv2IWgLLop9L4Xt4KHaYJhtFy5fuwt+b5yy4l/n+At5YDMGCf5XNpwIJELJHyRUz62wzCD4
 fK/mTzF6sxhG6ZHIDoneAgK4hHuwaPCCDNOrusTXV0RebhA3ySLfn08K7I1y9yotCdY8wkG
 kyFh6wBd3Cr3kuSMrVFwfaP/pGPUyLf+MISdxV4MIYjK3BO2sSy7I9DzBlRRZZXwt6lDnzt
 gsaqIWYIu0U8bAGA00XR9KFvbMCekCMLoNfpE6vytOITUhuaaRbSKK3YLkV1/b4iksmdATQ
 g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

When LRO is enabled, the driver must set the LRO flag in received
aggregated packets to indicate LRO processing to upper-layer
applications. Add the missing LRO flag into the ol_flags field of mbuf
to fix it.

Fixes: 0e484278c85f ("net/txgbe: support Rx")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a85d417ff6..e6f33739c4 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -1793,6 +1793,8 @@ txgbe_fill_cluster_head_buf(struct rte_mbuf *head, struct txgbe_rx_desc *desc,
 	pkt_flags = rx_desc_status_to_pkt_flags(staterr, rxq->vlan_flags);
 	pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
 	pkt_flags |= txgbe_rxd_pkt_info_to_pkt_flags(pkt_info);
+	if (TXGBE_RXD_RSCCNT(desc->qw0.dw0))
+		pkt_flags |= RTE_MBUF_F_RX_LRO;
 	head->ol_flags = pkt_flags;
 	head->packet_type = txgbe_rxd_pkt_info_to_pkt_type(pkt_info,
 						rxq->pkt_type_mask);
-- 
2.48.1

