Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ABC61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4849840682;
	Thu, 27 Aug 2026 13:43:59 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id ADF7440678;
 Thu, 27 Aug 2026 13:43:56 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831032t6e65295c
X-QQ-Originating-IP: uw4bNGKsRxuEgjKVo/stJ7j1BHLcMIEytiLWty+J3DQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1486896128473960644
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 06/13] net/txgbe: remove stale outer UDP checksum offload flag
Date: Thu, 27 Aug 2026 19:41:58 +0800
Message-ID: <5173583081B19B50+20260827114309.10530-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Of2rhkJtnHpRgkhI+xbL79yZUDEix/Ls4jMnDolgMvLIVnQYfTDFmSzF
 KETdazyJI7fWdB3t6q2iMteevy125NDcPUHFU8699j5Byyc8sHoTDJPnq+aWjm5w/2S1cUR
 yXVfbTJGb2FTKTkT8h2kjPmfEYflbIwMwnHfNGxZkm2rY1VHQWkIKNgXZPBubOtX5CC/urr
 bGVKTzH8vqRkfVx9L1avv1Qhp1auO9liWBTJHmuf0XAxL6IOd46tVYsvM3O6xvJO+qBPxIx
 ISIYVS93EUGTFAZF0z/pq6R770D8neG0o8OqBWU+WRJW8iHQBRdw3MJ/m6QHGUhuPCXhYz5
 3m63mGwhVoASo2XFSaXuV3f9ivVEbJo88yztL/I9Xqz+6uoRBZcK+XunYTzRtOEPtR6MNrh
 l0Jrq/2YZwstvBko4oYIyWwHNIGv4j3muEiTp2LZL1wLpKFmcb005lNHX6Rf4AgIj9IxP8v
 MfOlyhcSZPKsdHbKJcFAevcFipKTmeNgZpUjljpgNopkYWhRTsrgPq9CnqdtE9hEssZXn/q
 /SKuT7Jey58BdPYZo4IeflpyUi/n+TxCCXRMGV/ayAxVQ4jGhPteW9aPP9sKFGHPc4m9V+P
 7+DtdFIarQaAX6yQjYvfjJsPfKqu7XQolhFXk7f/L4IephA4wHt5Itnqg/0cmBfEiCXDtN2
 q0u99gre0lIG4VaZTrQRb64Qhw1ET/p5kSqXCk0tyXtpHW4JeKrS2VwM4gCYkJMbcLmAiw2
 MZ6yMSl5aq53o1FEjK3fgQOYCHm0XxK5Tkmt2IVlSm7XEZujpITIbSvOOEqIM0r6dvnbXDt
 j4YlOR+aeVbhVq6VHtss73heCtvCZ3s4ipsn25QxnUQptTUqJaATuQij3bHvkwZKQbZIokV
 T35jx+U0CHA7DejffdFHi4nAj7OY725xRkZl2vp50TAiDoHKg+fvimRGAkIYtu4eyBULLAp
 Qhd9CQDBdYesmx3Jg7QJyxUt0JQPABQfGbUA3j/43JDkD5rC0UcJlmLUwmsXC2GMtBNU4+k
 fbwM94lS0kxD7RrES6t8EPuoe3ZiP3Atr3yX9iWCiYW9LVlrkrgRFXngyp8uNySZHBGJhnc
 iFh5Cdo1J41
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

