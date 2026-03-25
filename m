Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2805106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0469A4279E;
	Wed, 25 Mar 2026 21:46:19 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0A9AF427AC
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:15 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486fd3a577eso2628775e9.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471575; x=1775076375; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtpmXMM4TgfBdvsv6qAW7NcvxbbY4HJl9s9irvrNqcI=;
 b=IJ4WoFrGbUsWzj1OZmLCXSDbEuf+zwPUuQBDHKNZYGNiDZ0glzyARJ1FYEorC0IZuv
 KZzIRK59uzFemZKxGRHzEZaYpmyEqITnvr7Cz8Mqko8kaJ/kzv+AyhmwVJUVKNFtDU3h
 D4P/lV6o4ixPPrK8HqQfgcDGjJHj7yPU0oTg9wuUNI0vFoCJUG5WGcZxLpo4aNuA9BGO
 LHp3h5NjQSoQ2G6gNVVOp6uRXDGJe98xHCqhDbxKB3iFIibvv0gr6cvf8XS1DcnoiYZK
 l20skmBQYe5ZWZo/tTPz7Br2+VZqJGMGrcIBD53+kxSL/lmAoi2uwjsRKM9nvYHsQ63q
 8szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471575; x=1775076375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MtpmXMM4TgfBdvsv6qAW7NcvxbbY4HJl9s9irvrNqcI=;
 b=LOAwh/cKpyCP+vVzFhtYm8M+k2ttf6vAGGGTpAbfCIheRXkuqd/6mTo6wnVD2lbHQp
 ZYuRequx1yas3u1KCZiMtTsTCU3FDorON1teN1NnFPpI+rYUphX1y2wlrQJbaXjMiDoT
 BdUVwIV6Ef0M3MzMWW1yg1EztAaJWvCihmbDr8TmtmMRAoCF6Bo0//Dl5tci440Th+e9
 rt1fYGzalMZWnZ1ySd3s0xNnQxPRs2dgatsn5YEW70eUYCe3aAjVxXlC46N4PH+VvHL/
 jLoEVCiSUxK3tgyX0htGbEz05y0+kXP/BlJcZTVsGpoVXNmu+YLjrjrcc+qLGY2Ly8ng
 zXbA==
X-Gm-Message-State: AOJu0YyiAbLvMHYTYQiHgR1+NUw+842wc+F2AeUO246ZB2rD4KvLhIHk
 jbFAtG8QLF/MAgZzCGqRe57EKaXmzRl0hodz2WFNTTThkntnBCZQ6rMgVnw0HDp/
X-Gm-Gg: ATEYQzxesmWJPuRM/G2DbIjZzbvHXXIKmidvtCH8TAYYORq2CVC1f+rurl30yUefu7e
 c4Yq6LOcssUS5mw+0XkMMRnY9j6OngSEDh1SuKp5PJvC5aPsyhq1MuDR2m0/yozmk6Bz0zxIgBe
 vVIbj6kGYkf44i3AMjfgqKr9pHFvaxAeuj95PlBbgBjA7mo76gJLaSCHhacEB59hzswAYEvcOYh
 FuS8wxTIzASz70RIkMl9C8mIKQyWB1w3UjWsNU1C8XKZ6GiuZg746B5JKQwa83w4A1x+VfJT3xb
 8Pe7lbBg/GBbnaFCLTv/4H0L7gOZ4iFtL2gALOiiYYPuCMnCQ24szSFjwq87QiFMDA/AOJkuSbB
 +7Js4z8N7aTR1bmL1t9FqRJNTWhQIpgPXIh84hEvxUceQLWcRXLWGgyxaRTvNvoFdGw9spQWG7F
 MYd8+Vw8vXBhCq+rIn
X-Received: by 2002:a05:600d:8453:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-4871604c8d4mr53375065e9.23.1774471574504; 
 Wed, 25 Mar 2026 13:46:14 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fbbf65asm2328455e9.2.2026.03.25.13.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:14 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 09/17] net/dpaa2: fix L4 packet type in slow parse path
Date: Wed, 25 Mar 2026 21:45:36 +0100
Message-ID: <20260325204544.101444-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RTE_PTYPE_L4_* values are not independent bits but mutually exclusive
values in a single field. The code set RTE_PTYPE_L4_NONFRAG (0x600)
first then OR'd the specific L4 type on top, corrupting the result:
- TCP: 0x600 | 0x100 = 0x700 (undefined)
- UDP: 0x600 | 0x200 = 0x600 (UDP lost, still NONFRAG)
- SCTP: 0x600 | 0x400 = 0x600 (SCTP lost, still NONFRAG)
- ICMP: 0x600 | 0x500 = 0x700 (undefined)

Move RTE_PTYPE_L4_NONFRAG to the final else fallback so it is only
set when no known L4 protocol is identified, matching how
rte_net_get_ptype() handles L4 classification.

Also remove the L3_IP_UNKNOWN_PROTOCOL check that OR'd
RTE_PTYPE_UNKNOWN (0x0), which was a no-op. That case is now
correctly covered by the NONFRAG fallback.

Not tested, found by code review.

Fixes: a5fc38d422a7 ("net/dpaa2: support Rx packet parsing")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 0de52cbef2..9c908f87b1 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -212,24 +212,18 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 	    L3_IP_N_MORE_FRAGMENT)) {
 		pkt_type |= RTE_PTYPE_L4_FRAG;
 		goto parse_done;
-	} else {
-		pkt_type |= RTE_PTYPE_L4_NONFRAG;
 	}
 
 	if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_UDP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_UDP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_TCP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_TCP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_SCTP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_SCTP;
-
 	else if (BIT_ISSET_AT_POS(annotation->word4, L3_PROTO_ICMP_PRESENT))
 		pkt_type |= RTE_PTYPE_L4_ICMP;
-
-	else if (BIT_ISSET_AT_POS(annotation->word4, L3_IP_UNKNOWN_PROTOCOL))
-		pkt_type |= RTE_PTYPE_UNKNOWN;
+	else
+		pkt_type |= RTE_PTYPE_L4_NONFRAG;
 
 parse_done:
 	return pkt_type;
-- 
2.43.0

