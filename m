Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B2F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF3544279E;
	Fri,  6 Mar 2026 14:31:08 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id A14DC427A1
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:06 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-439c944bb62so2303821f8f.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803866; x=1773408666; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oiZ9lZ4g7DaoWHEN5sXP9fOCjDW3WCahnIx1cLUE/Wk=;
 b=PM9y6WdPYyYyZ6y7c7BO7j91gTm8VtRCLwudqL0ZhOY5DtRLIhG/A313rnuPL6UQZ5
 StTObUcH62z/lSm6Y/4leUN36+YkqaHRlCnW/LO87LDPESEGl67CuJX7n1bukulBoowZ
 KLEUyiB6hjZInb3cQO2tqmC8c4BA9E+R+GRx3jLAn/YlUDR8aOjlGHNs7DHuwkGXDF+R
 Aa/mdgt9A6/E3xgDb6pm4uCkp+cOssC4f0rykxubj/Ni4oa/hU9Z3KDAmiYBM6t+T8um
 wD0ZULzUcCOtBGTmYZgZQXRw+Pm5b09D31U5v4TM5vbPhNIo0NNOoAu2rtfda6bEuGH0
 Wy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803866; x=1773408666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oiZ9lZ4g7DaoWHEN5sXP9fOCjDW3WCahnIx1cLUE/Wk=;
 b=pNxv1PWHwp4YIDLJxoSO8J6ehcYcMb0jBJ33nNk0cuxe/BCfmd8gY4pdr7q+o66bHU
 Nqjxe2H863HrbzaTL4Wna7xYNh4vRWlPzNxtUSw6VDyq+suqLtoLx+H8/xoIjTNEnL5+
 s+pFLqUETCfPuGYQ1KpqngJSwtUCVUFYW0/5C1ZztUr+Ru9+Tes3H6qaByGedAn6zoi/
 9oTPPXl6WWF3Z/0Ifkomne28X6xtIzw7V4gZ8C7x0rHtHwsgwRzBi488TBg+AFEVEY8J
 Kw7tbnXtjAV0UzYLq6xinK81+B0D5vmxhD9XPKRFAUtklIssO9LzoCIo6IKIuzuU/WOD
 FjKw==
X-Gm-Message-State: AOJu0YwCd3JNR8XNdhwefd3F+TPn/2DMPcR6axaMMOQLp43doKtUMmm+
 WAssFqnOQ3PbGiB/wXM8W0rpwLTP1NcpFJH2bkYkpzwHbiOwoivB9hjiy5AQSd6r
X-Gm-Gg: ATEYQzzALh0zQDwl7n7ecZmsUC64xRgLy9pV/koMI05TgbDMLmegpQUaIlQ84o6Lw7e
 dA95qQesSCi3I6OYVIgu/myFiZOMKOcFufQGcq4A0RwJEMqUf+61Ia8UEUSrsVyVi2PtJ0R6ntx
 tA8ah6Yf9MjcZcpO/PEcNnGZ1mlKKWcudGlcanmqzYZ6W8C/by/l3n+IXc51i6aibKYqou8h/dv
 OGgHMBVkbycCDYjHl5+jVGnYisNtaq+OmxGZRaRj3PYeFv0WFQUBax4VbCVa02zB6vo+651PuMD
 XvgqjmlQA6ee2FggDknpovjL48qSxficxBkIXgtnlDZSCNhRAUZHYcD3sFqWEnS7gYNr+1WaofF
 4kHOYzRKvc7t4grlmw64hVDXcvjYVX5LP+k0gH5TQXpzaN1gnjisblwBcv5i82CllSgV9SWYVqn
 6wxXIaK2j6b8985Ti6sD+qMApAqGk=
X-Received: by 2002:a5d:5d89:0:b0:439:b932:b445 with SMTP id
 ffacd0b85a97d-439da5553bemr3712490f8f.2.1772803866060; 
 Fri, 06 Mar 2026 05:31:06 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadac2a7sm3993829f8f.15.2026.03.06.05.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:05 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 10/17] net/dpaa2: fix L3/L4 checksum offload flags
Date: Fri,  6 Mar 2026 14:30:28 +0100
Message-ID: <20260306133035.179709-11-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

