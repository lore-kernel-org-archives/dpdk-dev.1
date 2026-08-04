Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C8C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72ECC40A79;
	Tue,  4 Aug 2026 17:46:05 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id ED07F402D1
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:03 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cea3004256so118965ad.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858363;
 x=1786463163; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AwHrPsW4f6XCF60zBPwaokPa8XyhH9hwgkG4mZ0/XOY=;
 b=DhFGHlHB6fEz8I11Q4GuSiM5qHgTbVKC6kRslI8SuZpyRmTYzvampZw44J559+XLIQ
 0tL2izUDcsofn7eTubIZtbM6jIGFCgmW8fzyl+e9EbK43SOUamyunU6UDIA9TDXnV1lt
 92qiPv8vJd5HRxB7DHP47tGNGT5y1iwfrGEYAS7r2CzyjB3DmjnfbppMqqWbYXyj7WXc
 9XzEeKJ1ctDx4sGwxAYS3v4D1D5c5vkJHuYsluzKqlV7bRgBqAKFZYva9L3N85Aub5Q2
 sG4Joq/d/65mxsvbMNa8okXBbum/mfRZ4UuS66RIf83pFz5WtKVEbla+hQygffCGQea8
 CJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858363; x=1786463163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AwHrPsW4f6XCF60zBPwaokPa8XyhH9hwgkG4mZ0/XOY=;
 b=NglZ/oahrQLZl+W/zAfzNQdkFvOhJ5gFw3qA6BWM9L1zAnrxQIABVYzijZ2iYziQPC
 Gk2Ut68ANtoM3Y67JycCHjZTtAIN2WCISf46DvM7maSY4/7x8jYWkgRJLwVTBJlAlUWm
 N9NsvYS4ywa74nCzDKMo2bv0Js1K4VL4z1w/dwY5sarPxOnSPOmI7aJPhfPKWhGr3Y18
 qdlhtfYFBNKALnHWdAjHEdlbGMJyZQOaSwp/1ApylJumH8+oE2w9W1mXFWr05G46VnGq
 cEbfUrzbSpJhU8zut302h6Z1uX6jDOPPn0wPq4+LylVOcSik4U692CdYapMwdYoQxquO
 13pA==
X-Gm-Message-State: AOJu0YxpXSKqlGABcIPnffFkSESnkq2n33PMDtpuZobBpMvFXcRy2EdX
 cGFb+wZ9IMIvZVHZu47mtDN2W9J7rcIOpL4+uCmlzhcUDigksrSXlNn4tzdjCPpLwSt1w3k/qwC
 KMVd4
X-Gm-Gg: AR+sD12aAtgQN88PNQp4V9sTHxr8nAxHZK3VZVC020WeMxsPwqpeQISoU77gXSJhSOz
 gsxEGUgRXUcYBTkmrS26KH+0lCfLaRUrPXcxckriSpZBob50NYIDSiRXvbju0JLUzp1CSJCavGJ
 I+kHU9SyLoBCEMoxELdgn18VCy3wvqH4WnPteba6lM32qo4CvLRjs1aRr6C/PgaX1CV0cXXlFqU
 bB9InpiGkOhNCfql0n70NMBGev0YuzR2NWrd5QkipL1EPbignpiIOs5InLhWtdKulQThUWjomD8
 TnjIgdl2LMl7hoSkCy5dQkV508i8bOB0AWfjrw6hi8TV8JXIu3az7oakwTUu1SYRY2g8R0exAX8
 S1XX++dnfuNAM3z/da3qoxxDHs/mlGSqIhO+RsjDmMV9T0lKsTSHu59dWPbr6pDkVsxaapB6Gnn
 pWsDrbeXagL53CO/Lq2jEwRoCBouR5h2XxlHvfSqsozh+8OKXAtBoax7B21kpagv8C5Aw1g3dKC
 3YMsql06wbFXmiBCg3C0mNvnMc=
X-Received: by 2002:a17:903:1aa6:b0:2cf:32bc:9722 with SMTP id
 d9443c01a7336-2d0524671d5mr149279255ad.34.1785858363114; 
 Tue, 04 Aug 2026 08:46:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 06/23] app/testpmd: move str_to_flowtype to i40e
Date: Tue,  4 Aug 2026 08:44:54 -0700
Message-ID: <20260804154549.148691-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

Only the i40e internal command is still using str_to_flowtype()
so move it to there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/config.c                 | 62 ---------------------------
 app/test-pmd/testpmd.h                |  3 --
 drivers/net/intel/i40e/i40e_testpmd.c | 51 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 582e7287be..230640ea44 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -3,7 +3,6 @@
  * Copyright 2013-2014 6WIND S.A.
  */
 
-#include <ctype.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <stdbool.h>
@@ -182,35 +181,6 @@ static const struct {
 	},
 };
 
-static const struct {
-	char str[32];
-	uint16_t ftype;
-} flowtype_str_table[] = {
-	{"raw", RTE_ETH_FLOW_RAW},
-	{"ipv4", RTE_ETH_FLOW_IPV4},
-	{"ipv4-frag", RTE_ETH_FLOW_FRAG_IPV4},
-	{"ipv4-tcp", RTE_ETH_FLOW_NONFRAG_IPV4_TCP},
-	{"ipv4-udp", RTE_ETH_FLOW_NONFRAG_IPV4_UDP},
-	{"ipv4-sctp", RTE_ETH_FLOW_NONFRAG_IPV4_SCTP},
-	{"ipv4-other", RTE_ETH_FLOW_NONFRAG_IPV4_OTHER},
-	{"ipv6", RTE_ETH_FLOW_IPV6},
-	{"ipv6-frag", RTE_ETH_FLOW_FRAG_IPV6},
-	{"ipv6-tcp", RTE_ETH_FLOW_NONFRAG_IPV6_TCP},
-	{"ipv6-udp", RTE_ETH_FLOW_NONFRAG_IPV6_UDP},
-	{"ipv6-sctp", RTE_ETH_FLOW_NONFRAG_IPV6_SCTP},
-	{"ipv6-other", RTE_ETH_FLOW_NONFRAG_IPV6_OTHER},
-	{"l2_payload", RTE_ETH_FLOW_L2_PAYLOAD},
-	{"ipv6-ex", RTE_ETH_FLOW_IPV6_EX},
-	{"ipv6-tcp-ex", RTE_ETH_FLOW_IPV6_TCP_EX},
-	{"ipv6-udp-ex", RTE_ETH_FLOW_IPV6_UDP_EX},
-	{"port", RTE_ETH_FLOW_PORT},
-	{"vxlan", RTE_ETH_FLOW_VXLAN},
-	{"geneve", RTE_ETH_FLOW_GENEVE},
-	{"nvgre", RTE_ETH_FLOW_NVGRE},
-	{"vxlan-gpe", RTE_ETH_FLOW_VXLAN_GPE},
-	{"gtpu", RTE_ETH_FLOW_GTPU},
-};
-
 static void
 print_ethaddr(const char *name, struct rte_ether_addr *eth_addr)
 {
@@ -7024,38 +6994,6 @@ set_record_burst_stats(uint8_t on_off)
 	record_burst_stats = on_off;
 }
 
-uint16_t
-str_to_flowtype(const char *string)
-{
-	uint8_t i;
-
-	for (i = 0; i < RTE_DIM(flowtype_str_table); i++) {
-		if (!strcmp(flowtype_str_table[i].str, string))
-			return flowtype_str_table[i].ftype;
-	}
-
-	if (isdigit(string[0])) {
-		int val = atoi(string);
-		if (val > 0 && val < 64)
-			return (uint16_t)val;
-	}
-
-	return RTE_ETH_FLOW_UNKNOWN;
-}
-
-const char*
-flowtype_to_str(uint16_t flow_type)
-{
-	uint8_t i;
-
-	for (i = 0; i < RTE_DIM(flowtype_str_table); i++) {
-		if (flowtype_str_table[i].ftype == flow_type)
-			return flowtype_str_table[i].str;
-	}
-
-	return NULL;
-}
-
 void
 set_vf_traffic(portid_t port_id, uint8_t is_rx, uint16_t vf, uint8_t on)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index f7c10ab6b8..ed94bd65c6 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1325,9 +1325,6 @@ int parse_hairpin_map(const char *hpmap);
 uint64_t str_to_rsstypes(const char *str);
 const char *rsstypes_to_str(uint64_t rss_type);
 
-uint16_t str_to_flowtype(const char *string);
-const char *flowtype_to_str(uint16_t flow_type);
-
 /* For registering driver specific testpmd commands. */
 struct testpmd_driver_commands {
 	TAILQ_ENTRY(testpmd_driver_commands) next;
diff --git a/drivers/net/intel/i40e/i40e_testpmd.c b/drivers/net/intel/i40e/i40e_testpmd.c
index 21f596297b..8ae1db698f 100644
--- a/drivers/net/intel/i40e/i40e_testpmd.c
+++ b/drivers/net/intel/i40e/i40e_testpmd.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation.
  */
 
+#include <ctype.h>
 #include <stdlib.h>
 
 #include <rte_pmd_i40e.h>
@@ -465,6 +466,56 @@ static cmdline_parse_inst_t cmd_show_queue_region_info_all = {
 };
 
 /* *** deal with flow director filter *** */
+
+static const struct {
+	char str[32];
+	uint16_t ftype;
+} flowtype_str_table[] = {
+	{"raw", RTE_ETH_FLOW_RAW},
+	{"ipv4", RTE_ETH_FLOW_IPV4},
+	{"ipv4-frag", RTE_ETH_FLOW_FRAG_IPV4},
+	{"ipv4-tcp", RTE_ETH_FLOW_NONFRAG_IPV4_TCP},
+	{"ipv4-udp", RTE_ETH_FLOW_NONFRAG_IPV4_UDP},
+	{"ipv4-sctp", RTE_ETH_FLOW_NONFRAG_IPV4_SCTP},
+	{"ipv4-other", RTE_ETH_FLOW_NONFRAG_IPV4_OTHER},
+	{"ipv6", RTE_ETH_FLOW_IPV6},
+	{"ipv6-frag", RTE_ETH_FLOW_FRAG_IPV6},
+	{"ipv6-tcp", RTE_ETH_FLOW_NONFRAG_IPV6_TCP},
+	{"ipv6-udp", RTE_ETH_FLOW_NONFRAG_IPV6_UDP},
+	{"ipv6-sctp", RTE_ETH_FLOW_NONFRAG_IPV6_SCTP},
+	{"ipv6-other", RTE_ETH_FLOW_NONFRAG_IPV6_OTHER},
+	{"l2_payload", RTE_ETH_FLOW_L2_PAYLOAD},
+	{"ipv6-ex", RTE_ETH_FLOW_IPV6_EX},
+	{"ipv6-tcp-ex", RTE_ETH_FLOW_IPV6_TCP_EX},
+	{"ipv6-udp-ex", RTE_ETH_FLOW_IPV6_UDP_EX},
+	{"port", RTE_ETH_FLOW_PORT},
+	{"vxlan", RTE_ETH_FLOW_VXLAN},
+	{"geneve", RTE_ETH_FLOW_GENEVE},
+	{"nvgre", RTE_ETH_FLOW_NVGRE},
+	{"vxlan-gpe", RTE_ETH_FLOW_VXLAN_GPE},
+	{"gtpu", RTE_ETH_FLOW_GTPU},
+};
+
+static uint16_t
+str_to_flowtype(const char *string)
+{
+	uint8_t i;
+
+	for (i = 0; i < RTE_DIM(flowtype_str_table); i++) {
+		if (!strcmp(flowtype_str_table[i].str, string))
+			return flowtype_str_table[i].ftype;
+	}
+
+	if (isdigit(string[0])) {
+		int val = atoi(string);
+		if (val > 0 && val < 64)
+			return (uint16_t)val;
+	}
+
+	return RTE_ETH_FLOW_UNKNOWN;
+}
+
+
 struct cmd_flow_director_result {
 	cmdline_fixed_string_t flow_director_filter;
 	portid_t port_id;
-- 
2.53.0

