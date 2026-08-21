Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB5C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DD5E40A6E;
	Fri, 21 Aug 2026 21:28:25 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5359B40A6E
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:24 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1841721b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340503;
 x=1787945303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xg4w58E9AqoXVyxwVb/CyJtQC2w7/klnJaNQD0yMiKs=;
 b=WOh5dnaWPKY5udY+YhFpEHMBUuGEagGlch1PbFpey/axW23TWg8eaX/5ThbKSvi9Dp
 vZUnhtJMDRefK2b57aiYADyNXwrS1OrqcyGLzJ/VWdMR1YxGtyf62vrtLIRgH0e0zKtW
 vbBhe6O8EfneLSQo8hh/UMXz+dzTp9hsMrzlrs3Cd+eaj54hmymBgQ8yOcDh0fNUdCve
 K6teqXOsQFhwlvJMJJpxNZWHDP2Jrefr9l1SIHePYSxE+9gT9zopALo/nWwd5q8EWDYX
 v2WdZoU4zoWSereL228fdFNaSOMLBSu9X+tSHBoMsPy/VUiDBA2q3n6VGZuzCD1wlUpN
 cKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340503; x=1787945303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xg4w58E9AqoXVyxwVb/CyJtQC2w7/klnJaNQD0yMiKs=;
 b=VYJwEDjHvp8hqBo5Q4AWirsFhfALrR9cu0YzuER2pb1zroaCsMoT2rRoqzsy/05Jvk
 NIekJcw9ZHjaC3PrcynWhGfzrpO0xb5oGeG7V35fbIvOshV+Htyi21Vsh6xdI0J76g2c
 SiPA8IjMfIJpwFNd2+B94qyXJKSrOUKeUsgVo/z2j8jhdRim85Wc25ZVOIiXeghNDOYs
 JYDx/VFBthZ9lu8MaP5o24HPGMj661TbKkxuAEvSJvBwJ6O23tBPtBNEXrceNWrqvbW1
 MtBCJmj3OF5TCmdud2jPoBN88xDw4KfUBS+pCgko2EX2TttLJk0oKh0QuSA9iVM/UI3a
 S8BQ==
X-Gm-Message-State: AFuF++nMj3ZZdP692aLrR2hK0upq+LxlPGoAEAOODGHqy9FMKUzxpgp8
 UkalmCY11OHPH4A1QVQP61txJLPoH1cj+KRnoSLH+JLunhUYioPt7E4UszwJq6Opwg6Ox+2R0Z9
 /IKHC
X-Gm-Gg: AR+sD10GE1tROXwNL9w7u1DPpkxVR2cLETvqJK9o190QQXOMyNu5k98zozY3TBcF3KL
 V7JoLQE0FsZG3K2tXPy9LTPDfsMLENL0VzG4Qb4XLXjXhmzfZG/CHiF7zRid8R6vjBWYUaNfWa0
 9ZQbG0dEpjtEUwRq3JxdQXb5jASiXdCK+EAwiO6ZWKHMvmT3T0ITv1agibjKAz1B0ByGVwAzIzZ
 cf+uPyj5XNmr8gIAbVSwDnVG3MHq9uONtqqWkepnvZOKvDjMRu/7HshcplhUJKAAv/NIx4Ece2b
 gAC82hJzrVM13BYaaMFBF8lnjabNe4qfr+eSSA74gz1mk3RyUrreTA/XoJgLg0BgLSxhSFO+KHo
 zEs9QOCbcG+BSvUNQd3WHQHi7ZIcbIsoUgSs3v7aW36OniMjZ7tAuCVVwgYZU/gQnT6VX5QeMR3
 +T60ayOOOhi81PWoZ/KouQ3noQulihBXESc87FwGDnA6uFko7WnAzsRepjXcgaUrocjzKq/muv+
 GKqAwts7FV5EHeldmjjeaoxwYY=
X-Received: by 2002:a05:6a20:d49b:b0:3b4:661d:8405 with SMTP id
 adf61e73a8af0-3cd3183746fmr8165777637.4.1787340503408; 
 Fri, 21 Aug 2026 12:28:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 09/68] app/testpmd: replace rte_memcpy with memcpy
Date: Fri, 21 Aug 2026 12:24:04 -0700
Message-ID: <20260821192646.146382-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The standard C library memcpy is as fast and has more
checking by analysis tools than DPDK rte_memcpy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c      | 28 ++++++++++++++--------------
 app/test-pmd/cmdline_flow.c | 34 +++++++++++++++++-----------------
 app/test-pmd/config.c       | 13 ++++++-------
 app/test-pmd/csumonly.c     |  1 -
 app/test-pmd/flowgen.c      |  1 -
 app/test-pmd/iofwd.c        |  1 -
 app/test-pmd/macfwd.c       |  1 -
 app/test-pmd/macswap.c      |  1 -
 app/test-pmd/noisy_vnf.c    |  1 -
 app/test-pmd/rxonly.c       |  1 -
 app/test-pmd/testpmd.c      |  1 -
 app/test-pmd/txonly.c       |  7 +++----
 12 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..40aad7effa 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -10516,7 +10516,7 @@ static void cmd_set_vxlan_parsed(void *parsed_result,
 		vxlan_encap_conf.select_ipv4 = 0;
 	else
 		return;
-	rte_memcpy(vxlan_encap_conf.vni, &id.vni[1], 3);
+	memcpy(vxlan_encap_conf.vni, &id.vni[1], 3);
 	vxlan_encap_conf.udp_src = rte_cpu_to_be_16(res->udp_src);
 	vxlan_encap_conf.udp_dst = rte_cpu_to_be_16(res->udp_dst);
 	vxlan_encap_conf.ip_tos = res->tos;
@@ -10530,9 +10530,9 @@ static void cmd_set_vxlan_parsed(void *parsed_result,
 	}
 	if (vxlan_encap_conf.select_vlan)
 		vxlan_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
-	rte_memcpy(vxlan_encap_conf.eth_src, res->eth_src.addr_bytes,
+	memcpy(vxlan_encap_conf.eth_src, res->eth_src.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
-	rte_memcpy(vxlan_encap_conf.eth_dst, res->eth_dst.addr_bytes,
+	memcpy(vxlan_encap_conf.eth_dst, res->eth_dst.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
 }
 
@@ -10711,7 +10711,7 @@ static void cmd_set_nvgre_parsed(void *parsed_result,
 		nvgre_encap_conf.select_ipv4 = 0;
 	else
 		return;
-	rte_memcpy(nvgre_encap_conf.tni, &id.tni[1], 3);
+	memcpy(nvgre_encap_conf.tni, &id.tni[1], 3);
 	if (nvgre_encap_conf.select_ipv4) {
 		IPV4_ADDR_TO_UINT(res->ip_src, nvgre_encap_conf.ipv4_src);
 		IPV4_ADDR_TO_UINT(res->ip_dst, nvgre_encap_conf.ipv4_dst);
@@ -10721,9 +10721,9 @@ static void cmd_set_nvgre_parsed(void *parsed_result,
 	}
 	if (nvgre_encap_conf.select_vlan)
 		nvgre_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
-	rte_memcpy(nvgre_encap_conf.eth_src, res->eth_src.addr_bytes,
+	memcpy(nvgre_encap_conf.eth_src, res->eth_src.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
-	rte_memcpy(nvgre_encap_conf.eth_dst, res->eth_dst.addr_bytes,
+	memcpy(nvgre_encap_conf.eth_dst, res->eth_dst.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
 }
 
@@ -10838,9 +10838,9 @@ static void cmd_set_l2_encap_parsed(void *parsed_result,
 		return;
 	if (l2_encap_conf.select_vlan)
 		l2_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
-	rte_memcpy(l2_encap_conf.eth_src, res->eth_src.addr_bytes,
+	memcpy(l2_encap_conf.eth_src, res->eth_src.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
-	rte_memcpy(l2_encap_conf.eth_dst, res->eth_dst.addr_bytes,
+	memcpy(l2_encap_conf.eth_dst, res->eth_dst.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
 }
 
@@ -11020,7 +11020,7 @@ static void cmd_set_mplsogre_encap_parsed(void *parsed_result,
 		mplsogre_encap_conf.select_ipv4 = 0;
 	else
 		return;
-	rte_memcpy(mplsogre_encap_conf.label, &id.label, 3);
+	memcpy(mplsogre_encap_conf.label, &id.label, 3);
 	if (mplsogre_encap_conf.select_ipv4) {
 		IPV4_ADDR_TO_UINT(res->ip_src, mplsogre_encap_conf.ipv4_src);
 		IPV4_ADDR_TO_UINT(res->ip_dst, mplsogre_encap_conf.ipv4_dst);
@@ -11030,9 +11030,9 @@ static void cmd_set_mplsogre_encap_parsed(void *parsed_result,
 	}
 	if (mplsogre_encap_conf.select_vlan)
 		mplsogre_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
-	rte_memcpy(mplsogre_encap_conf.eth_src, res->eth_src.addr_bytes,
+	memcpy(mplsogre_encap_conf.eth_src, res->eth_src.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
-	rte_memcpy(mplsogre_encap_conf.eth_dst, res->eth_dst.addr_bytes,
+	memcpy(mplsogre_encap_conf.eth_dst, res->eth_dst.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
 }
 
@@ -11256,7 +11256,7 @@ static void cmd_set_mplsoudp_encap_parsed(void *parsed_result,
 		mplsoudp_encap_conf.select_ipv4 = 0;
 	else
 		return;
-	rte_memcpy(mplsoudp_encap_conf.label, &id.label, 3);
+	memcpy(mplsoudp_encap_conf.label, &id.label, 3);
 	mplsoudp_encap_conf.udp_src = rte_cpu_to_be_16(res->udp_src);
 	mplsoudp_encap_conf.udp_dst = rte_cpu_to_be_16(res->udp_dst);
 	if (mplsoudp_encap_conf.select_ipv4) {
@@ -11268,9 +11268,9 @@ static void cmd_set_mplsoudp_encap_parsed(void *parsed_result,
 	}
 	if (mplsoudp_encap_conf.select_vlan)
 		mplsoudp_encap_conf.vlan_tci = rte_cpu_to_be_16(res->tci);
-	rte_memcpy(mplsoudp_encap_conf.eth_src, res->eth_src.addr_bytes,
+	memcpy(mplsoudp_encap_conf.eth_src, res->eth_src.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
-	rte_memcpy(mplsoudp_encap_conf.eth_dst, res->eth_dst.addr_bytes,
+	memcpy(mplsoudp_encap_conf.eth_dst, res->eth_dst.addr_bytes,
 		   RTE_ETHER_ADDR_LEN);
 }
 
diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index fbbe36233b..fc98c42c61 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13967,31 +13967,31 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 		switch (action->type) {
 		case RTE_FLOW_ACTION_TYPE_MARK:
 			size = sizeof(struct rte_flow_action_mark);
-			rte_memcpy(&sample_mark[idx],
+			memcpy(&sample_mark[idx],
 				(const void *)action->conf, size);
 			action->conf = &sample_mark[idx];
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
 			size = sizeof(struct rte_flow_action_count);
-			rte_memcpy(&sample_count[idx],
+			memcpy(&sample_count[idx],
 				(const void *)action->conf, size);
 			action->conf = &sample_count[idx];
 			break;
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
 			size = sizeof(struct rte_flow_action_queue);
-			rte_memcpy(&sample_queue[idx],
+			memcpy(&sample_queue[idx],
 				(const void *)action->conf, size);
 			action->conf = &sample_queue[idx];
 			break;
 		case RTE_FLOW_ACTION_TYPE_RSS:
 			size = sizeof(struct rte_flow_action_rss);
 			rss = action->conf;
-			rte_memcpy(&sample_rss_data[idx].conf,
+			memcpy(&sample_rss_data[idx].conf,
 				   (const void *)rss, size);
 			if (rss->key_len && rss->key) {
 				sample_rss_data[idx].conf.key =
 						sample_rss_data[idx].key;
-				rte_memcpy((void *)((uintptr_t)
+				memcpy((void *)((uintptr_t)
 					   sample_rss_data[idx].conf.key),
 					   (const void *)rss->key,
 					   sizeof(uint8_t) * rss->key_len);
@@ -13999,7 +13999,7 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 			if (rss->queue_num && rss->queue) {
 				sample_rss_data[idx].conf.queue =
 						sample_rss_data[idx].queue;
-				rte_memcpy((void *)((uintptr_t)
+				memcpy((void *)((uintptr_t)
 					   sample_rss_data[idx].conf.queue),
 					   (const void *)rss->queue,
 					   sizeof(uint16_t) * rss->queue_num);
@@ -14008,13 +14008,13 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 			break;
 		case RTE_FLOW_ACTION_TYPE_RAW_ENCAP:
 			size = sizeof(struct rte_flow_action_raw_encap);
-			rte_memcpy(&sample_encap[idx],
+			memcpy(&sample_encap[idx],
 				(const void *)action->conf, size);
 			action->conf = &sample_encap[idx];
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_ID:
 			size = sizeof(struct rte_flow_action_port_id);
-			rte_memcpy(&sample_port_id[idx],
+			memcpy(&sample_port_id[idx],
 				(const void *)action->conf, size);
 			action->conf = &sample_port_id[idx];
 			break;
@@ -14022,7 +14022,7 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 			break;
 		case RTE_FLOW_ACTION_TYPE_VF:
 			size = sizeof(struct rte_flow_action_vf);
-			rte_memcpy(&sample_vf[idx],
+			memcpy(&sample_vf[idx],
 					(const void *)action->conf, size);
 			action->conf = &sample_vf[idx];
 			break;
@@ -14038,13 +14038,13 @@ cmd_set_raw_parsed_sample(const struct buffer *in)
 			break;
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
 			size = sizeof(struct rte_flow_action_ethdev);
-			rte_memcpy(&sample_port_representor[idx],
+			memcpy(&sample_port_representor[idx],
 					(const void *)action->conf, size);
 			action->conf = &sample_port_representor[idx];
 			break;
 		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 			size = sizeof(struct rte_flow_action_ethdev);
-			rte_memcpy(&sample_represented_port[idx],
+			memcpy(&sample_represented_port[idx],
 					(const void *)action->conf, size);
 			action->conf = &sample_represented_port[idx];
 			break;
@@ -14177,7 +14177,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 			if (geneve_opt->option_len && geneve_opt->data) {
 				*total_size += geneve_opt->option_len *
 					       sizeof(uint32_t);
-				rte_memcpy(data_tail - (*total_size),
+				memcpy(data_tail - (*total_size),
 					   geneve_opt->data,
 					   geneve_opt->option_len * sizeof(uint32_t));
 			}
@@ -14217,7 +14217,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 
 				/* We have to add GTP header extra word. */
 				*total_size += sizeof(ext_word);
-				rte_memcpy(data_tail - (*total_size),
+				memcpy(data_tail - (*total_size),
 					   &ext_word, sizeof(ext_word));
 			}
 			size = sizeof(struct rte_gtp_hdr);
@@ -14263,19 +14263,19 @@ cmd_set_raw_parsed(const struct buffer *in)
 				if (gre_opt->checksum_rsvd.checksum) {
 					*total_size +=
 						sizeof(gre_opt->checksum_rsvd);
-					rte_memcpy(data_tail - (*total_size),
+					memcpy(data_tail - (*total_size),
 						   &gre_opt->checksum_rsvd,
 						   sizeof(gre_opt->checksum_rsvd));
 				}
 				if (gre_opt->key.key) {
 					*total_size += sizeof(gre_opt->key.key);
-					rte_memcpy(data_tail - (*total_size),
+					memcpy(data_tail - (*total_size),
 						   &gre_opt->key.key,
 						   sizeof(gre_opt->key.key));
 				}
 				if (gre_opt->sequence.sequence) {
 					*total_size += sizeof(gre_opt->sequence.sequence);
-					rte_memcpy(data_tail - (*total_size),
+					memcpy(data_tail - (*total_size),
 						   &gre_opt->sequence.sequence,
 						   sizeof(gre_opt->sequence.sequence));
 				}
@@ -14288,7 +14288,7 @@ cmd_set_raw_parsed(const struct buffer *in)
 		}
 		if (size) {
 			*total_size += size;
-			rte_memcpy(data_tail - (*total_size), src_spec, size);
+			memcpy(data_tail - (*total_size), src_spec, size);
 			/* update some fields which cannot be set by cmdline */
 			update_fields((data_tail - (*total_size)), item,
 				      upper_layer);
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index aa03eb99cc..7810143383 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -24,7 +24,6 @@
 #include <rte_debug.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_launch.h>
 #include <rte_bus.h>
@@ -2263,9 +2262,9 @@ port_flow_tunnel_offload_cmd_prep(portid_t port_id,
 					pft->num_pmd_actions, &error);
 			return NULL;
 		}
-		rte_memcpy(pft->actions, pft->pmd_actions,
+		memcpy(pft->actions, pft->pmd_actions,
 			   pft->num_pmd_actions * sizeof(actions[0]));
-		rte_memcpy(pft->actions + pft->num_pmd_actions, actions,
+		memcpy(pft->actions + pft->num_pmd_actions, actions,
 			   num_actions * sizeof(actions[0]));
 	}
 	if (tunnel_ops->items) {
@@ -2291,9 +2290,9 @@ port_flow_tunnel_offload_cmd_prep(portid_t port_id,
 					pft->num_pmd_items, &error);
 			return NULL;
 		}
-		rte_memcpy(pft->items, pft->pmd_items,
+		memcpy(pft->items, pft->pmd_items,
 			   pft->num_pmd_items * sizeof(pattern[0]));
-		rte_memcpy(pft->items + pft->num_pmd_items, pattern,
+		memcpy(pft->items + pft->num_pmd_items, pattern,
 			   num_items * sizeof(pattern[0]));
 	}
 
@@ -2731,7 +2730,7 @@ port_flow_template_table_create(portid_t port_id, uint32_t id,
 	}
 	pt->nb_pattern_templates = nb_pattern_templates;
 	pt->nb_actions_templates = nb_actions_templates;
-	rte_memcpy(&pt->attr, table_attr,
+	memcpy(&pt->attr, table_attr,
 		   sizeof(struct rte_flow_template_table_attr));
 	printf("Template table #%u created\n", pt->id);
 	return 0;
@@ -3367,7 +3366,7 @@ port_queue_action_handle_update(portid_t port_id,
 		update = action->conf;
 		break;
 	case RTE_FLOW_ACTION_TYPE_METER_MARK:
-		rte_memcpy(&mtr_update.meter_mark, action->conf,
+		memcpy(&mtr_update.meter_mark, action->conf,
 			sizeof(struct rte_flow_action_meter_mark));
 		if (mtr_update.meter_mark.profile)
 			mtr_update.profile_valid = 1;
diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index c841651756..7de2cf3b08 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test-pmd/flowgen.c b/app/test-pmd/flowgen.c
index 8dac7b9209..1ec5b30071 100644
--- a/app/test-pmd/flowgen.c
+++ b/app/test-pmd/flowgen.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test-pmd/iofwd.c b/app/test-pmd/iofwd.c
index ba06fae4a6..c9727d2856 100644
--- a/app/test-pmd/iofwd.c
+++ b/app/test-pmd/iofwd.c
@@ -24,7 +24,6 @@
 #include <rte_per_lcore.h>
 #include <rte_lcore.h>
 #include <rte_branch_prediction.h>
-#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_interrupts.h>
diff --git a/app/test-pmd/macfwd.c b/app/test-pmd/macfwd.c
index d19ace7395..ba63aedd79 100644
--- a/app/test-pmd/macfwd.c
+++ b/app/test-pmd/macfwd.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test-pmd/macswap.c b/app/test-pmd/macswap.c
index 57f77003fe..e1f9be4901 100644
--- a/app/test-pmd/macswap.c
+++ b/app/test-pmd/macswap.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test-pmd/noisy_vnf.c b/app/test-pmd/noisy_vnf.c
index 81d1187cfe..cf951e9532 100644
--- a/app/test-pmd/noisy_vnf.c
+++ b/app/test-pmd/noisy_vnf.c
@@ -24,7 +24,6 @@
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_lcore.h>
-#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
diff --git a/app/test-pmd/rxonly.c b/app/test-pmd/rxonly.c
index 315f9286cd..cc73cf4ebf 100644
--- a/app/test-pmd/rxonly.c
+++ b/app/test-pmd/rxonly.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index cab2fa1556..138f167caf 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -30,7 +30,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_bus.h>
 #include <rte_eal.h>
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index a4acb85d29..5b8b3befa5 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_cycles.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
@@ -80,21 +79,21 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 	copy_len = seg->data_len - offset;
 	seg_buf = rte_pktmbuf_mtod_offset(seg, char *, offset);
 	while (len > copy_len) {
-		rte_memcpy(seg_buf, buf, (size_t) copy_len);
+		memcpy(seg_buf, buf, (size_t) copy_len);
 		len -= copy_len;
 		buf = ((char*) buf + copy_len);
 		seg = seg->next;
 		seg_buf = rte_pktmbuf_mtod(seg, char *);
 		copy_len = seg->data_len;
 	}
-	rte_memcpy(seg_buf, buf, (size_t) len);
+	memcpy(seg_buf, buf, (size_t) len);
 }
 
 static inline void
 copy_buf_to_pkt(void* buf, unsigned len, struct rte_mbuf *pkt, unsigned offset)
 {
 	if (offset + len <= pkt->data_len) {
-		rte_memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset),
+		memcpy(rte_pktmbuf_mtod_offset(pkt, char *, offset),
 			buf, (size_t) len);
 		return;
 	}
-- 
2.53.0

