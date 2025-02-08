Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6117C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A0A40A7D;
	Sat,  8 Feb 2025 21:32:36 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 81A0340B9F
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:31 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2166651f752so71917915ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046751;
 x=1739651551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUR6XHuFBoNaJfR2km4oqUrluHfeQKp4ZjjOi5tuAj0=;
 b=iWxA2kz64D4pBkGrGE/RlVVlgSTKWwynw6J8pkFEh96Anm6yiB/W9d1xG8C1UHoWQL
 Ah7sFvscIugpYZBdKiC7Fu7qJGHiXZbMkOtP+lyx8Q+hmgU556a3QQgZJyLGj9v+Egu9
 TUOptubeddqGDpNycHTlOBtTEK2WtbQg9duNK9vtpECYV3UWwalfRcRwrTT7F0RAievi
 UZymzveBBUnwiUHanWMY906jyF1pQkfrMo/7JRkAVjVMHLCdCVr1OL1fbP9++y5qogYw
 qsV8ENV0k14YPdIHgbB8+4mPRunrEl1RQ41BpUQspSNJVaIwFa+NESEWGatvZE2VV+Nk
 cKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046751; x=1739651551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUR6XHuFBoNaJfR2km4oqUrluHfeQKp4ZjjOi5tuAj0=;
 b=T4cfFD6vSuIPOS6ghVuNMsbw1VRLqakJzJzBdO6mYbgSLxkBsOpTBS/vPLqDdZKql8
 5zaOr8Hgt90A+kPF+c8JLdkcQNW/t9dlF+JQ8r8MkreEKWlafufTFGOQSeBaHGG93rvN
 wruItVKAzNRNn00jEO4hStFxRDH3w3H82pdI8hICuU3PSqaXcpxkHC0s6HsYyiWd3Ruh
 SJ308I1w6GU+BsXQVnk13YjeMcqsQ3fW1tOa/WiqxUTp3mVa/KEn2XaRYc4n3b2ZFWtw
 RV8Pb08rgJ8YFFndBp/U/OYbI9mOAfwAhZSiypsSZddrtgHe1Z9RLH7GVXuebCRZWsBv
 fIJg==
X-Gm-Message-State: AOJu0YxKUPrXptFXszEiZHYUAXpCFI6/rARD0UBM/BV3wKhe0i7wNTFX
 9g6jQG53zp0fCrAMRq+lSPGUurghRsA9jOxIQOOJwdk3GBNUhwAXt1RU9XYkE0soSurjPZR1hzc
 vfGM=
X-Gm-Gg: ASbGncstPeCyhmGzKn/hIl+e6Eh0eKUZ3yPrqUpKkTKKYaY41pWdBUD3M3Lt+evIby/
 e05DLfrwTMgf9FYiFppY8uly4Lgnls/WIoMiFHfJqimqW5UTx2+uOHU+1lInvuyI+gobinr7wWS
 xpHYSZpmxIn9uXd34mM0jG+8SWTaCqy4VoRhb1So3JeJd7YFhx/T3rVv6mj8YRUVV9Ztkpzr/f5
 z544deekq7XIFZBGymOMzNMWhvqN9864rkZVci4lvKQzPojV7142/MjObVQCQGkI1/fkj3BX3Gl
 T7RZR/EUL4OM6XhtP0a8iZbr+TYm3YuV1qi0m3nl04ty2XneOBH4dup7SV2bEomQn8iD
X-Google-Smtp-Source: AGHT+IFPx9A1InrMjgl4jGbs0IQFhjx2RVCI22vOM5aqcqnDCPIzORqIZ+zgad7TaUv1RBroONfPjg==
X-Received: by 2002:a05:6a20:6f88:b0:1e1:becc:1c91 with SMTP id
 adf61e73a8af0-1ee03b42a5cmr13811063637.28.1739046750753; 
 Sat, 08 Feb 2025 12:32:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH 31/32] test: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:23 -0800
Message-ID: <20250208203142.242284-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_acl.c                   |  5 ++--
 app/test/test_compressdev.c           | 36 +++++++++------------------
 app/test/test_security_inline_proto.c | 23 +++++++----------
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 503ff08894..43d13b5b0f 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1223,8 +1223,7 @@ test_create_find_add(void)
 
 	/* create dummy acl */
 	for (i = 0; i < LEN; i++) {
-		memcpy(&rules[i], &acl_rule,
-			sizeof(struct rte_acl_ipv4vlan_rule));
+		rules[i] = acl_rule;
 		/* skip zero */
 		rules[i].data.userdata = i + 1;
 		/* one rule per category */
@@ -1286,7 +1285,7 @@ test_invalid_rules(void)
 	 * such rules.
 	 */
 	/* create dummy acl */
-	memcpy(&rule, &acl_rule, sizeof(struct rte_acl_ipv4vlan_rule));
+	rule = acl_rule;
 	rule.data.userdata = 1;
 	rule.dst_port_low = 0xfff0;
 	rule.dst_port_high = 0x0010;
diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index 81b8e02006..c217ad6cda 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -346,8 +346,7 @@ test_compressdev_invalid_configuration(void)
 	RTE_LOG(INFO, USER1, "This is a negative test, errors are expected\n");
 
 	/* Invalid configuration with 0 queue pairs */
-	memcpy(&invalid_config, &valid_config,
-			sizeof(struct rte_compressdev_config));
+	invalid_config = valid_config;
 	invalid_config.nb_queue_pairs = 0;
 
 	TEST_ASSERT_FAIL(rte_compressdev_configure(0, &invalid_config),
@@ -360,8 +359,7 @@ test_compressdev_invalid_configuration(void)
 	 */
 	rte_compressdev_info_get(0, &dev_info);
 	if (dev_info.max_nb_queue_pairs != 0) {
-		memcpy(&invalid_config, &valid_config,
-			sizeof(struct rte_compressdev_config));
+		invalid_config = valid_config;
 		invalid_config.nb_queue_pairs = dev_info.max_nb_queue_pairs + 1;
 
 		TEST_ASSERT_FAIL(rte_compressdev_configure(0, &invalid_config),
@@ -2188,8 +2186,7 @@ test_compressdev_deflate_stateless_fixed(void)
 		goto exit;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-			sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 	compress_xform->compress.deflate.huffman = RTE_COMP_HUFFMAN_FIXED;
 
 	struct interim_data_params int_data = {
@@ -2260,8 +2257,7 @@ test_compressdev_deflate_stateless_dynamic(void)
 		goto exit;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-			sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 	compress_xform->compress.deflate.huffman = RTE_COMP_HUFFMAN_DYNAMIC;
 
 	struct interim_data_params int_data = {
@@ -2372,8 +2368,7 @@ test_compressdev_deflate_stateless_multi_level(void)
 		goto exit;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-			sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 
 	struct interim_data_params int_data = {
 		NULL,
@@ -2442,8 +2437,7 @@ test_compressdev_deflate_stateless_multi_xform(void)
 			goto exit;
 		}
 
-		memcpy(compress_xforms[i], ts_params->def_comp_xform,
-				sizeof(struct rte_comp_xform));
+		*compress_xforms[i] = *ts_params->def_comp_xform;
 		compress_xforms[i]->compress.level = level;
 		level++;
 
@@ -2456,8 +2450,7 @@ test_compressdev_deflate_stateless_multi_xform(void)
 			goto exit;
 		}
 
-		memcpy(decompress_xforms[i], ts_params->def_decomp_xform,
-				sizeof(struct rte_comp_xform));
+		*decompress_xforms[i] = *ts_params->def_decomp_xform;
 	}
 
 	for (i = 0; i < NUM_XFORMS; i++) {
@@ -2614,8 +2607,7 @@ test_compressdev_deflate_stateless_checksum(void)
 		return TEST_FAILED;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-			sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 
 	struct rte_comp_xform *decompress_xform =
 			rte_malloc(NULL, sizeof(struct rte_comp_xform), 0);
@@ -2625,8 +2617,7 @@ test_compressdev_deflate_stateless_checksum(void)
 		return TEST_FAILED;
 	}
 
-	memcpy(decompress_xform, ts_params->def_decomp_xform,
-			sizeof(struct rte_comp_xform));
+	*decompress_xform = *ts_params->def_decomp_xform;
 
 	struct interim_data_params int_data = {
 		NULL,
@@ -2960,8 +2951,7 @@ test_compressdev_deflate_stateful_decomp_checksum(void)
 		return TEST_FAILED;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-	       sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 
 	struct rte_comp_xform *decompress_xform =
 			rte_malloc(NULL, sizeof(struct rte_comp_xform), 0);
@@ -2971,8 +2961,7 @@ test_compressdev_deflate_stateful_decomp_checksum(void)
 		return TEST_FAILED;
 	}
 
-	memcpy(decompress_xform, ts_params->def_decomp_xform,
-	       sizeof(struct rte_comp_xform));
+	*decompress_xform = *ts_params->def_decomp_xform;
 
 	struct interim_data_params int_data = {
 		&compress_test_bufs[0],
@@ -3186,8 +3175,7 @@ test_compressdev_deflate_stateless_fixed_oos_recoverable(void)
 		goto exit;
 	}
 
-	memcpy(compress_xform, ts_params->def_comp_xform,
-			sizeof(struct rte_comp_xform));
+	*compress_xform = *ts_params->def_comp_xform;
 	compress_xform->compress.deflate.huffman = RTE_COMP_HUFFMAN_FIXED;
 
 	struct interim_data_params int_data = {
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 480469f672..04ecfd02c6 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -858,7 +858,7 @@ test_ipsec_with_rx_inject(struct ip_pkt_vector *vector, const struct ipsec_test_
 	burst_sz = vector->burst ? ENCAP_DECAP_BURST_SZ : 1;
 	nb_tx = burst_sz;
 
-	memcpy(&sa_data, vector->sa_data, sizeof(struct ipsec_test_data));
+	sa_data = *vector->sa_data;
 	sa_data.ipsec_xform.direction =	RTE_SECURITY_IPSEC_SA_DIR_EGRESS;
 	outer_ipv4 = is_outer_ipv4(&sa_data);
 
@@ -873,7 +873,7 @@ test_ipsec_with_rx_inject(struct ip_pkt_vector *vector, const struct ipsec_test_
 	}
 
 	for (i = 0; i < burst_sz; i++) {
-		memcpy(&sa_data, vector->sa_data, sizeof(struct ipsec_test_data));
+		sa_data = *vector->sa_data;
 		/* Update SPI for every new SA */
 		sa_data.ipsec_xform.spi += i;
 		sa_data.ipsec_xform.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS;
@@ -901,7 +901,7 @@ test_ipsec_with_rx_inject(struct ip_pkt_vector *vector, const struct ipsec_test_
 	}
 
 	for (i = 0; i < burst_sz; i++) {
-		memcpy(&sa_data, vector->sa_data, sizeof(struct ipsec_test_data));
+		sa_data = *vector->sa_data;
 		/* Update SPI for every new SA */
 		sa_data.ipsec_xform.spi += i;
 		sa_data.ipsec_xform.direction = RTE_SECURITY_IPSEC_SA_DIR_INGRESS;
@@ -1078,7 +1078,7 @@ test_ipsec_with_reassembly(struct reassembly_vector *vector,
 	memset(tx_pkts_burst, 0, sizeof(tx_pkts_burst[0]) * nb_tx);
 	memset(rx_pkts_burst, 0, sizeof(rx_pkts_burst[0]) * nb_tx);
 
-	memcpy(&sa_data, vector->sa_data, sizeof(struct ipsec_test_data));
+	sa_data = *vector->sa_data;
 	sa_data.ipsec_xform.direction =	RTE_SECURITY_IPSEC_SA_DIR_EGRESS;
 	outer_ipv4 = is_outer_ipv4(&sa_data);
 
@@ -1096,8 +1096,7 @@ test_ipsec_with_reassembly(struct reassembly_vector *vector,
 	}
 
 	for (i = 0; i < burst_sz; i++) {
-		memcpy(&sa_data, vector->sa_data,
-				sizeof(struct ipsec_test_data));
+		sa_data = *vector->sa_data;
 		/* Update SPI for every new SA */
 		sa_data.ipsec_xform.spi += i;
 		sa_data.ipsec_xform.direction =
@@ -1132,8 +1131,7 @@ test_ipsec_with_reassembly(struct reassembly_vector *vector,
 	}
 
 	for (i = 0; i < burst_sz; i++) {
-		memcpy(&sa_data, vector->sa_data,
-				sizeof(struct ipsec_test_data));
+		sa_data = *vector->sa_data;
 		/* Update SPI for every new SA */
 		sa_data.ipsec_xform.spi += i;
 		sa_data.ipsec_xform.direction =
@@ -2371,13 +2369,11 @@ test_inline_ip_reassembly(const void *testdata)
 	reassembly_td.nb_frags = td->nb_frags;
 	reassembly_td.burst = td->burst;
 
-	memcpy(&full_pkt, td->full_pkt,
-			sizeof(struct ip_reassembly_test_packet));
+	full_pkt = *td->full_pkt;
 	reassembly_td.full_pkt = &full_pkt;
 
 	for (; i < reassembly_td.nb_frags; i++) {
-		memcpy(&frags[i], td->frags[i],
-			sizeof(struct ip_reassembly_test_packet));
+		frags[i] = *td->frags[i];
 		reassembly_td.frags[i] = &frags[i];
 
 		/* Add extra data for multi-seg test on all fragments except last one */
@@ -2466,8 +2462,7 @@ test_ipsec_inline_proto_rx_inj_inb(const void *test_data)
 	out_td.sa_data = td->sa_data;
 	out_td.burst = td->burst;
 
-	memcpy(&full_pkt, td->full_pkt,
-			sizeof(struct ip_reassembly_test_packet));
+	full_pkt = *td->full_pkt;
 	out_td.full_pkt = &full_pkt;
 
 	/* Add extra data for multi-seg test */
-- 
2.47.2

