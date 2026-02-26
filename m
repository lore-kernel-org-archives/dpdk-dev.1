Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D8DFCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2E8940DCE;
	Thu, 26 Feb 2026 15:34:20 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D4A384060C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:11 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43996323357so503026f8f.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116451; x=1772721251; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoYWhldEM4zw2qNpd2HCWFvKqIfixPN2sblp0Ta17bc=;
 b=gKlxX1AljJQqaDq1YXi6iMrGfmgTTW2jbHMQ+ubRJMHOPSOTBCaFg2hIBF+2WHALj1
 eXc/tPt/TPv8hx5KjJ/aNq63NZSPQ/SsRL/atRBuJs+T5QYnUwHni2znqTrKxBd/zQJ1
 N/cLNePyr/qh0q0vaMdPhOQoiVCajHf4PTrqU+ByhjvW8sgjin4ef8h8h6Djsqz9ulxR
 hrzGxQbGBCWHljbMZtf30yn1GRLsMtZzRWmtaCasvY2DKbLiILMB04fDsp3yyi13/jJx
 n264s+Yaou7pGWSFKCYEJ2DK8j+ZU5H6b+EMe/0C3qMLtn08419IniYVfsgVW+avEha9
 noBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116451; x=1772721251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RoYWhldEM4zw2qNpd2HCWFvKqIfixPN2sblp0Ta17bc=;
 b=nZZDAsZUsEFNIeCUX+phy8tqREIcMGrdPu3MrdGOVbx43D3Hj4+VJ3Umt8vPAwzOh2
 yxMVSSSW7rzi/1vR6qS8WUFPVv7afwtUOMmTUafS/bKBF8PT1lv7XNjiGKKCA41spJNa
 UZ4etFNcCaIaLIdot7Op8my9T40S3tRodxWHIZAEg1Dr4TOMbevpczNQuev3/KYu0CrB
 SDoptQ7hHGXZy1D2A6/qQMai5zXKuZS9M5MOb6Ck0stI79zstk9ZpAeT0W31gUEG/inG
 fNEIx5+ZeGY1TVeAIundE9Sx5fpSpXQTG84qVEoaw6Wc4EkXbg4rF6UkY5LJpJduWgOW
 H8UA==
X-Gm-Message-State: AOJu0YyWwor4Cx7Ppykmn8GSzW5XnyOWIE/I1EJDabY/yJ+7jnzPeem9
 rVh4cpR0tiWCGsxxRcGtFXs0UsLJWyh/U4rdI7zffhYPMBGis6Yxl8hsgNf26g==
X-Gm-Gg: ATEYQzwM5+pAocQaQ9Kx90lzYWF5OEbPydmG/LUz45gocVp08qZfyazJAcL+90srwuN
 ZBKnjb2q4bKFq9Pi6XVoSzrLkgNSm/0LPuCD8GC5Pa7VYXtw74DEKwsdHqFBuZplPVMCYrbPdpE
 v9L2t9YFKr8LLhoZOMW5H7g1EZ9dFSEl5ZqC+baOHG2ym0uRwKZIa1rqGXw5SHO3qiIomwpf6XE
 moSsnEUkI/lQhN0u1uJABwlK42elzHw01T9Wn9qcDqitWi1B+JA7iriipq0o9kRRCmJEEY5or5/
 7puNO5BsVSPRsd9PqPHkpCdwBXxy9ni+3+IDzr2DZRajHhZZOd+DN+c4hwlq4f3DjEFaRvuLpRB
 3pATrv/qKIZv+IKu6BZs0t6IAN59KWjCtxv8/mTEjU0MvSFC6oyIoungwPpPmc3vC+TanhjdzVJ
 S3y1nCtkY18wF+ngKSEyajiUuiZg==
X-Received: by 2002:a05:6000:1acd:b0:436:2fdf:b599 with SMTP id
 ffacd0b85a97d-4396f167865mr39133987f8f.21.1772116451348; 
 Thu, 26 Feb 2026 06:34:11 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:10 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 10/17] net/dpaa2: fix L3/L4 checksum offload flags
Date: Thu, 26 Feb 2026 15:33:34 +0100
Message-ID: <20260226143341.282188-11-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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
   clear), report RTE_MBUF_F_RX_IP_CKSUM_GOOD / RTE_MBUF_F_RX_L4_CKSUM_GOOD.

Fix both issues in dpaa2_dev_rx_parse_slow() and dpaa2_dev_rx_parse().

Not tested, found by code review.

Cc: stable@dpdk.org
Fixes: 870354264644 ("net/dpaa2: fix L3/L4 checksum results")

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
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

