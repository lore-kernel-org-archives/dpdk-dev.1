Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC4606A323
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JJda/iPQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94C0B40616;
	Sat, 14 Nov 2026 19:57:08 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 544D34025A
 for <dev@dpdk.org>; Sat, 14 Nov 2026 19:57:06 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso800260a12.3
 for <dev@dpdk.org>; Sat, 14 Nov 2026 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794682625;
 x=1795287425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UPGMcgP0baWsGHerBMt4h9DYLvDp806RCcrpZyV2d/w=;
 b=JJda/iPQjAXbR8RdqY2BlTJ3j6acmso0Y6/L21qXQUoqCQ+YQmYKHcPtJMY0IuynBp
 ohpzXrP36Rvi7wCwVTICI64CJIznGiuidpBlBwbw6NWpZWSfs1APMiwRb4/duL0gI+H5
 3x+fDwwRUZRfT20YIFaqhfp5ieM7g2pW+a6xVSgyuHwoPB/fga/oUonBZ7NiBIXMFK11
 HpM0jedboqMgBOvpg9Rza9Jj9sxFvlA3M8bunUYrEMhoYWEiyY620hK1OpVr+P2s0+mi
 s7osnp97z2sebs8os1tIFLF2c9XHMD1Yxsu24D4CKV2vYCzqOslRSZJDYSq+KXFjD7Qr
 z/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794682625; x=1795287425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UPGMcgP0baWsGHerBMt4h9DYLvDp806RCcrpZyV2d/w=;
 b=PpABcfNR5AaYu1JTJBLLLQuXawG0uv2DLuTItVHvLfQ3EnQsmSWGaVMiGixUXCeue8
 V9U7NLUtD23piPif3J+AF9Z835Isr58b+cISeH/Xq2X6i0QQSdCHSnBHR0gTPZzUKpXO
 B4jggl7KJmTlz4atIKsJsDpoXwc3Y6WhK19zYrgsUyTS9ibUSDsDR6kvY0BmSutiWNwO
 b0HGjQy0sEBStEyO4WgWEMYqnF8+5V9BuLCzPgGQMHRrB8nIWRFTzi2PNf6UFwzpoG7v
 4dNd1rW7WL/NRITezfY+q6d4EkrlBqjnEBOttdP3vdzP2PZ9gdWTMneKU7R88G/jUjCW
 0dkw==
X-Gm-Message-State: APuU4Z8uIxV5KpKya9cjqKFJwppQOdGQl/nuZG/6KIPfkRdI9Kv/85nD
 CgnUIoH7X2tcJSp+DCJCgVMJtsrpqTWiXMfmTBBI1ljemEbGoyA6hbBBOnX3vhUpwZCqujiJq63
 RnAF4OuA=
X-Gm-Gg: AYBFou2xyBEEc+NC5nb/M4TXgREMvW6bK9prV5bt60Uf3LwBVi55B48n8WJ/+h+kgIB
 XVJNVRSBtRWOkhYnw2piGZu6pkuWreRMKDLN9qOLAS/AK1R5BuFYbILdwd8c4LKEkt6xaB6RmB1
 E7isBvnOUjTpz/pO1JlNcYTj2CQG8TwOndsJTJhs9n86ie54op4YDV9XdEzwWvmrwtVqcib6j32
 tpDzdwiP8gUlddWmeQ3LywyvXyha6mATihpIZufCdMo8SVcwLZHZEl2XCE10uKE/wKYcW/GiIKb
 1hXZGpQ5472C0Zc4aPatHmrTD0KlltCMiV5QFV7/sKwqO8TDbgj+MQwSEBwxKfmWeB03TOup3SF
 gxBpq5ets1PSaCJqbJsJBulGEGktciumsRgM4WnfA7ltRzlX2QClJxwFINg/EC1tm+dWgV8cpUh
 L83X71x9DAPlMtcvtqpTCRO/pYT7P/sGUpgfex/qD6rnCwXqq+AITPj+dFtAoW3L7SDOAKxPNbf
 A0LWFAXFTTqvs3SAGouZTmf7Y27JvvIS18Aa5RfbD/C5AMgySVJdcSUQz4xfDkvw1B8uqodjVoN
 n1ohUDrjz+wMtkoBCmw1f2kF9bzGFKXEYi7u9ZNRMprALGohfQLJJYWHTpu4XGIcYz5kIKOU
X-Received: by 2002:a17:90b:4cd0:b0:3ab:e588:c295 with SMTP id
 98e67ed59e1d1-3b1b0b5f348mr4933351a91.42.1794682624668; 
 Sat, 14 Nov 2026 10:57:04 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce460csm14591624a91.5.2026.11.14.10.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 10:57:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 John McNamara <john.mcnamara@intel.com>, Tero Aho <tero.aho@coriant.com>
Subject: [PATCH 2/2] net/pcap: handle > 64K packets in capture file
Date: Sat, 14 Nov 2026 10:57:01 -0800
Message-ID: <20261114185701.833180-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114185701.833180-1-stephen@networkplumber.org>
References: <20261114185701.833180-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a pcap file given to the pcap PMD had a super jumbo frame
there would be a silent truncation and also the driver was not
checking for excessive number of mbuf segments.

Bugzilla ID: 2129
Fixes: 6db141c91e1f ("pcap: support jumbo frames")
Cc: stable@dpdk.org

Reported-by: Anthropic OSS scanner (ANT-2026-VD4V3KPV)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b89f4a0c2e..fb18f0932b 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -226,7 +226,7 @@ queue_missed_stat_get(struct rte_eth_dev *dev, unsigned int qid)
 
 static int
 eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
-		const u_char *data, uint16_t data_len)
+		const u_char *data, uint32_t data_len)
 {
 	/* Copy the first segment. */
 	uint16_t len = rte_pktmbuf_tailroom(mbuf);
@@ -237,9 +237,12 @@ eth_pcap_rx_jumbo(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
 	data += len;
 
 	while (data_len > 0) {
+		/* Avoid excessively long chain */
+		if (mbuf->nb_segs + 1 > RTE_MBUF_MAX_NB_SEGS)
+			return -1;
+
 		/* Allocate next mbuf and point to that. */
 		m->next = rte_pktmbuf_alloc(mb_pool);
-
 		if (unlikely(!m->next))
 			return -1;
 
-- 
2.53.0

