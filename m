Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBB106B534
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E629A427BC;
	Wed, 25 Mar 2026 21:46:19 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 356C2427A8
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:17 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso2819025e9.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471577; x=1775076377; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me/1QG1Z0queODaohqMoty0KuBGVF+xexusM7Rliz9s=;
 b=Npy8te4GTdaf9xsyxTYG+ivL0yS8VRAnQlspGI5814bqAZDk07dtlzzHOZSZ4eYVzS
 0K8Uk1IkkhrZh0H0YdcepgYH2Lr0exjY+du0SbTkTarjPl6UI9vux0ASbv0l8NJFVJvg
 ei+Gx9td/xy6+eEKJAZKrLVeagkkING2AYSWjVIvkhuVlif/WB+MenLn8jPhgFH/4X/G
 CoPr1PQUyNFRYBRt+opF4ZdkHWPlUzmHGenmK2K3z428klzJi3/a2qXAOCj6tkdwme9G
 0SOdEoTs7JMCNsHME4AMZzqTPm9zhJHcsMOsy2l4oA7yQVXB7+EVU/Zj74Aw+OZwh38b
 Rc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471577; x=1775076377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=me/1QG1Z0queODaohqMoty0KuBGVF+xexusM7Rliz9s=;
 b=e6VGxgD1fhjujMpuU1tMJnPH3cXE+6ApAUvQpUfQn8EEWP8jc9VuLF6LgCSsgZs2tv
 ehg0WFNUSeEv8vjYITWZ+SOWsaZFJLW9JrbUccnusa9KQTjLEeFnaAofKIZvvlpVBmJL
 imWQJbfr1DdMBY1AwtOJqs9u1Hw/Ru8AEeQZvr18M6mcQm00pHy1Qu4J3Ypc+iww95ce
 v9aqi34EmlFySfwjqSTHYiLck6sPtBjJ/7F5u06aCOuVkWEccP9Ok+xcrehKfv3eVqzr
 tZ/HmqU7fm5EWPRfib8QhwROBL/ITjzdq6YPhxuJJ6ZWAkZOJjxUI+NAwK3f1/6STi/F
 AEhg==
X-Gm-Message-State: AOJu0Yx+t+70TQ0Vy9X3fAgDZs0TaYfh5f/SSqw9ea3HgXkJ4S1Av+DA
 sZKWAv7t+adUbKwj3zf5Q01zpITUiNlFfdg8RKmVqDkrjB2L7aiNf/Uq7DciObnP
X-Gm-Gg: ATEYQzwITBtyZxn7zcyi/flS5H1oMas+wT7nX9I1XzpmVbXCeeL3z1Zq+zXLmctAIZS
 3+jsiC9sIqcaLxBXqaLKJftFDPrTxAid5e64nlo4egjFkKC4zR2Lwtp/bql4bwHmEBqNXFAweGU
 NX0aRLKr9d4552uh/SjVgytQ5E7kJsEniAcVYclYosJTyZqK8IhDzEM3gExnucuuLH+x9c9Cihw
 47bdHjtQjUbz0zQff0YcFGEkjp89dcqHjisGvhnkVJyLxxFKhaNmsjOzCe+GvEtioNpNWgzSvpt
 LpiyjFKPN/e32N3a+GlC1bAZAOSFXdmwt4+4tnyF+CNhPq7BPzNllq6+FxFEbkZPLSlZiSXUf8i
 TPTdo8RhHkDq361ulC/rKQj6/y0WJ4U96iOCb+CFfgqWOPvtawwN47aGRfk+K24Sjvpk8pf9WvF
 kRd+jbPzqwEX60hWof
X-Received: by 2002:a05:600c:8711:b0:486:ffa3:584 with SMTP id
 5b1f17b1804b1-48715febb55mr83626245e9.15.1774471576685; 
 Wed, 25 Mar 2026 13:46:16 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117077cbsm149017225e9.6.2026.03.25.13.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:16 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 10/17] net/dpaa2: fix L3/L4 checksum offload flags
Date: Wed, 25 Mar 2026 21:45:37 +0100
Message-ID: <20260325204544.101444-11-maxime@leroys.fr>
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

The WRIOP FAS (Frame Annotation Status) field provides independent
bits for L3/L4 checksum validation (L3CV/L4CV) and error (L3CE/L4CE).

Two problems:

1. The driver used 'else if' between the L3 and L4 error checks, so
   when both checksums were bad only the L3 error was reported and
   the L4 error was silently lost. Use two independent 'if' statements
   instead, matching how other drivers (i40e, ixgbe, bnxt) handle this.

2. The driver never reported GOOD checksums. When validation was
   performed (L3CV/L4CV set) but no error was flagged (L3CE/L4CE
   clear), report RTE_MBUF_F_RX_IP_CKSUM_GOOD /
   RTE_MBUF_F_RX_L4_CKSUM_GOOD.

Fix both issues in dpaa2_dev_rx_parse_slow() and dpaa2_dev_rx_parse().

Not tested, found by code review.

Fixes: 870354264644 ("net/dpaa2: fix L3/L4 checksum results")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 9c908f87b1..689e5e7ee7 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -203,8 +203,13 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 
 	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
-	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CV))
+		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+
+	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CV))
+		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
 	if (BIT_ISSET_AT_POS(annotation->word4, L3_IP_1_FIRST_FRAGMENT |
 	    L3_IP_1_MORE_FRAGMENT |
@@ -240,8 +245,13 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 
 	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
-	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CV))
+		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+
+	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CV))
+		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
 	if (unlikely(dpaa2_print_parser_result))
 		dpaa2_print_parse_result(annotation);
-- 
2.43.0

