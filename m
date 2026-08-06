Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C7C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:10:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 919E840A6C;
	Thu,  6 Aug 2026 07:10:23 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2CFFF40695
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:21 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso1407815a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993020;
 x=1786597820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AwHrPsW4f6XCF60zBPwaokPa8XyhH9hwgkG4mZ0/XOY=;
 b=E2hkYHS5kvXsmik2dwKEZ3uNIceDCN6bnjskMXpZKwdl9/xFOWX/jWR4sZRov1PkU+
 p/4duTTMEu19Kn9/utCjTRRgss1wNK9oYNZaM5KLH+MXNhuyDkzwQJTal4RqOLGsHJs4
 GWqYJ2bxZeylwcvvCmc20iwy3bYB4wbUgLqPvw0aR1bPidDJCzAWeTNEru0kkpgecyEZ
 kjBlWRFLBLjz9wXg9gTqgzmRWNF1c760qupIU6NrkUoIEw2/40KKgs0fhy9xp3Aq7Dto
 O/W/ercIauQVZCESAfTDWSo5P7xysbbOlEjo9TrZmQinCrdOtT4fQXdIgWop772aIH22
 ylYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993020; x=1786597820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AwHrPsW4f6XCF60zBPwaokPa8XyhH9hwgkG4mZ0/XOY=;
 b=JNZVeq3fpk1yoED5yPxAYTc6zhfYaEhO08ez8tJ4jWvCSwuSLgLqOWp2YJpLvhZxCf
 xjm6AlRJ+Nn8QZldxkJcRi2ZNF171hPGCxanZm0Fq6cVBoSVO+lU19dvezsaMqTVAisI
 +eeDomsl7GGgZ7Za+atxRKPLZWXIrChIsK67+9HR88ghD7lRAlMBA0zQsKSZhJ6x6ItO
 Rg/Bxs3TEyUd+KdeD4hbdikSKQS9zYS8rfNzDBZjCXBknO50eaMpgluly+7UZNUaSSeV
 A7alFfcko38Gn80JCTJAmQ7XXbYjxyuiiNhMw53Z4S3Y6zbDGR+uTRDJpVjKJB1G1h6j
 ESmA==
X-Gm-Message-State: AOJu0YyBuUvksxRBfpsS+npk9wuZcimK6Nr+H/QkUb1TC9owxH+pB9Bd
 bYaDBRzTprbmlMHJJMTAVtP8zq6ZO1tHfVuOieNMsJQBNNESBXUMKvsPD4k7tB4+6ixXljkc7Uk
 tbAop
X-Gm-Gg: AR+sD12auUo68iz+dI34tCeql8zIroqJ4aslDqFKwT8bSXlQ06oVoS5yegfHFAn+tT5
 DTXFw4F4Vcy3oW0ILgDoeydhFx/aEIOiPYjCOjDqXN3mmgbOcMvYyTixXyYNIzQciS4Pjfh/cWt
 WzWkyTQqkAb49x226bR5ZyvTxltFNEJx+uMg6ldmq6iX/dBQDANBirI4JBtd6EmcEDVYIYVIrIi
 L74FmuQ5Hc1Bo8utlUADYQuoImASmY/Qj+4eyGudnYX3wD/PZF2ft1rntxorfWpl5EbzY3NjZng
 UCABbwJzj8B4+3HRTZ7zkqog4jyN07IXg45kuSjaNxRcfqr0o6gJmWUgGEJd9DhxbZfWjz06t+o
 Q3H2qy4MAcjLChCCHMamTSM7GJdALNhZ/DAwkJiv2sLWR5K0SH0XVEOaei6uKs940IHKYaAhLMf
 lbo4Ed5zm9lHgHhe4J+NI1y6UG26802nIP+Ahdx/IAea1V5sXcDt9mldJQ/8UVLhnI1xYZB5ryH
 c27p8J9BOPROCJotMn2rDzLQNUahOa62QboDg==
X-Received: by 2002:a05:6a20:72a4:b0:3bf:9142:ba3a with SMTP id
 adf61e73a8af0-3cb85ef7460mr14059511637.26.1785993020034; 
 Wed, 05 Aug 2026 22:10:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 06/23] app/testpmd: move str_to_flowtype to i40e
Date: Wed,  5 Aug 2026 22:09:00 -0700
Message-ID: <20260806051004.166778-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

