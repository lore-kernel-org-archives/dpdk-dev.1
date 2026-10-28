Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E84606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3413140DCE;
	Wed, 28 Oct 2026 11:40:49 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTPS id 6489440B9E;
 Wed, 28 Oct 2026 11:40:42 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184016tf19c1385
X-QQ-Originating-IP: GyC7c2rEzzkgKpq3Ef18tskHcgay/fC0rV5cp3NwtGw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8772103010459037425
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 08/17] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Wed, 28 Oct 2026 18:33:57 +0800
Message-ID: <F0E212238BE764E7+20261028103913.10188-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvH2zBBgt3uTRC691TirGyDmXbtRcbQ+EPKvH/UPYDzjZCvEDRPthPDZ
 NshiAiprJLTcfEClylOHiitEhKBglECwBLMavdMzsDg/YGjg8bUktjb8qgINMQfCViaUEKR
 N1L8UsJufdMJqsEVEqIBQMgVkulpwhiTPELENaRaogEYKgPBqOU6O8ntD78lNXoysFJkgIn
 hED2UcVYiKTd477NyfyOe+K+3K5rXSiu2HzOpM6cXiSy6LfbNqsXdjDBJwzU5vKFeTFZ1YF
 AlwXMJZEhkwYUOViO1G8sq2RpAHp3oWrJV1xkoz506Znd1CCe1rK2urAB9eOuRFP5XWg+4r
 5OlyNKwTvYiniMBwYzxxBTv8JfTgIwtq+KbpzSQ9BIauIKcwqfukGxK5picHkkqAktkjQZX
 YQKf5YS0NmM2PtSpq0PnssfwXHcwQJLckcSg9AVlO9mB9RrtvnEQ2ESjUyBX5Z5T0dwhqfO
 1D/k+lIcApghj4mtW2mScuiy5d+D4Wx5pECFH6+3+xzU/gWhZmpBW0HCuaI7jeUMZEHp776
 XQ4zv/24CjTYN3Z2LRrHaS5KmRCqjKhRPWvXyD46GPUhEDc38QcB5idtOA6phcFlXQe9Vn3
 SrXQxzBEgnJMT2TSBpA/Qx3GceLbtP3dsurr+XPhu72syzKcGph/nwp3vTq9jd+R5GL3+pj
 AylaVtiCfmRTFVOB2IZ7bANJ/5jymYXAS5XYUaWJqNXVuawRmSo7EDxwVOz/1R7bBondlQ+
 d9sP9LeAFDVepgLUUuUKliDT6yR0xlHQUZvCtCM5yzKJZG0LKAfdStKyU1Jv9MBUj8GOZG1
 pJtkKbWO79eQZXR0kznrCB/en9PAplBAzHG2SzpFQ63Ji5UN9Gr5VNPwG+OgxAAV9aIYcJt
 NzifLvKJChYmjy4SQOX7qbULex5aQZCsmn8IPLAYEiY/+3F+gQs06NX9Xr50YqyKijFlQQc
 mF02oCS+mL8exIf3lzP100fqk79QhLXviVsjJWzsay8Ul6hvVTIfThAJx1PCwdA6VAEDlx/
 xPTP/CIYTjyKEbJDWKw/F2N4HWQVsOL93hLDLYs72iVp7STcGMm8uI9G1vUZDhNRtYuLLau
 x1xAMsSrK4u8OFwcAbi6vvBjTdj8acbRA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

