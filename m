Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9F1CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0A20427E0;
	Tue, 29 Sep 2026 15:06:38 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 57F1D427E8;
 Tue, 29 Sep 2026 15:06:35 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687193tdf9073e9
X-QQ-Originating-IP: 36eQG+0AsnLrlB9yCx9hg52VG6mG76yJvZixFa+GU8A=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4295785356544797212
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 08/15] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue, 29 Sep 2026 21:04:39 +0800
Message-ID: <5C21F48D54B83786+20260929130611.4871-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Oc5PqwRWY15FVB10Zmo4qCPDYh/r0IliAt510rFqAaPbMTL6ku1XYc73
 4ObkBfLmRMgbrHjkTCCi9fZk17KM/rZ7V2YLmGZbL2JuwVPFYr+3oUAdZRtBZFAN0fhoCiZ
 7nj1WSp8q5p1Pq+4BNWcKB9IWNSNh0GYDU1vEHUICbEJqPrRefEsJZcjJJBnFmaFo3/SZRM
 E9I4pZhZ/QdrEuMYT4p5VSs+RBctGzFSFSflH60FIAKiYmVBmWAKkB0ONLfGlpbQpbvKd0G
 SeouwEbHg8v4nqZi00eFoxDelMS6UkmJ9WhUKA3xcOsCI6ce4gRsUehgKrC0LaYNB078wsE
 eimAyugMZLjxvWD0EwDABlWs2iw7tiQGb8Kyb/ljEdXeB7Gf6adzdH0KdbWQJQOE63G1uZp
 ZQLjyi9+Ju6xi4pHlbJlBWGPtmp/3/gkW87lgVDGifiSS7JDUgjSnBZHiKfVttLQDsv8Wqj
 x14gP+NI5i48NxUL13ZieWf2MgoSvsq8w5RnJ+kU0nqN4YDJ8GoFnN1gZJ5wgnw0IiN1wiT
 lCCVeNsCURavr8ZA1yxZGghHAYiht3+bhGktNKmvcoMm1mWTiJlF8X9YapvV84negEDtudD
 2hGXQQSXXuGwuf6TLE5m7vvRJbGlK7vd+2pBK7chNJGSGPGabh5KLYp98lOjOjnoNmEf0ru
 H+5RuuYLEtBO+KlX1YPQNICmz9SH9Xb7hk20dDIWI1+CHCTXaPDgVy7yToN58gDTwPN0CjY
 gVfXyBAA4Ng9hmKjMSW/fC8/sTBneNVxhYmYRuNDOkD3sBPMLlJ8Njhbn1HnicaccXju+a6
 +AnWK3MJUir/NwYDR8F7oN/RaSSVK+TQcxwGu/y37nxFQDm6wTmIJc+IgPKNtDOef6Twwwq
 Tvd3D6QcbuACPhLYn1JIuA7YjMMVB135lcRG2jndG/RR3+LSYzktJmp4ZysGRNmEO5kK2kQ
 yz6xNRQPqTrz7PbsLkya0o3h7LmiiCZ0xcCHKKwYt4fopy8LFHxPwgUg51wcc6h8dC7vIwH
 qyVQFo4M7pK22Xg1GZz01ypL6XpVKT8gDvODhW6wUwV6mL/donXI7L0Ur6lGkx6lL0pj3o4
 tVspqZl26pYSDb63tPqw4HGjMvHpsUhiz3ol3dF552Q/QDvqJAJ3Bd2jBVy0hLEzuVFDxUs
 7+gh
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

