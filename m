Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B217CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF33D42E55;
	Wed, 30 Sep 2026 12:21:11 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 8182142DCD;
 Wed, 30 Sep 2026 12:21:07 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763665t85c8f6ff
X-QQ-Originating-IP: /zc4Z9x4XX4QhYrWxt01rgnDTP47PSUOY0xkzDeX/6A=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:21:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2388037781350036644
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 08/15] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Wed, 30 Sep 2026 18:17:55 +0800
Message-ID: <967E82BFE9C03719+20260930102042.2214-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OWISOlifo4HySarB9YfPAol4QuXz/tBi5iI5IBvVqvcL2gOhiqhzx4EA
 VxxxrG9oIBJuCLxmn1UGBD/MuXKf0IU+RcH93SOUn8jUJS5NBydNmz77Y/2MIRQ1k+mC5ex
 Lh9DZd/Vl9rQgou/B015+0HfUMMBjeuyV7WLoMayLDUrIQ24e0aBrNfW+jHkqZE3sRTtavd
 Smh8y9uBm/XyVDOUDMUbvpvzBXsPJDbK6dXn9GNmYnOZ0Qnuh4kfTWT+KTprFgHTYrSpOaI
 iMfUJt8484VxWW5L/vr5TLZGOnCM0UUF1S6w7EExvst2MAPp53cm1UgYuLLDbmeb1igvGDZ
 H8X3sqgew4IsmOpw3zdpBk7FiKj243/mQAcAJvB784PrkPJomFN5yA0Efrrev9ayjKOWa6B
 /QfFq3EBqIRHLhK3i6NggZNMY+AUkqMRP/bMmjreYo2KyoRgKRHOZE+rRdw+Hx0Bi5t9WlH
 apE/mqjgd96V529Byv1Tbw8giuxjPGD4PhkORLRD5PrpzsJiR6TNLhUh7ZQpKb53jMKaO8K
 b6mCs3RldtQdvl+nBI6p7OUm/yGCd5I+lB/R2QMHMsBZLu3uWEN5eHet0xlPthiErLp3lfW
 dEITZll3qn0sY1J9L+Il5G8y5f7UYmE/c0470193K42fkjIZZ/0C5BArQvlAkAGIc5ccC8W
 fD/e7sz8TKaRDROcFTu8K3TnE7+KtKD293BwTl3lwY+NA8riYGn92vvXDjm9Pubj4B7/3+y
 8GvoSqY4C9H77AVqBRCytuWz2i4AOTHFcMJ5Hw/RWkjFMuEYYkkn38odNeseXKw3y0jW96c
 oHX98xDLfLMa9ZUXGNhegnzPJGh5WqiMMUV3hyN7iQGXzHbssFRA9HcNg1rAbp3o+V2v8wD
 gVhC8qp5f0/MiUoQIM+AX9yKMzNq1wE2/3rIPq9LxGFEpNxYdKkhRrj6ngOe6cmD5uggLNR
 qpFixHprT9TgvezxU6OdrqL1yQ9U9FBvDUiKk48COahllyQs4HDyDyWyddtFJW1fbhdkl5N
 oSHkPHdX83jmAJpZko5n/L43UIBFzw4TeY8IpzF8KMhTTEA7DFxt323K0ntiMQz3UMW24Ye
 A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

