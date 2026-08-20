Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 126ED40E34;
	Thu, 20 Aug 2026 07:25:33 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id F1A2540BA5
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:30 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so1867744a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203530;
 x=1787808330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqgVkVYFeNp6FeqjJpHc7QsyG6NDmOjV7kM+fhiEVeI=;
 b=qt49bUnkhyUxTKnI6HEKOIKrry0ePwD5KL6Q57VhSctGZTfmn6jOI9XaKYYrMYlgQO
 zzxLfI9owy5TIS3yr4QKo7unJfY66Xf1o4EncoZYefCvMkxoD010Kigx1AP2+EcK3PIq
 LQXO9NjS9ahEc3RzszmtqZ3H/g0Xn7Q0Sfi7B3pJRQY6OMOYPKIMlIpJg9uApWLAhghn
 dTvA2SBTiUV3Zh6XfH5iakSfZ4UaGXPo2bgzW2F9UwpYR6PxRt53tWmlAsNy9NXqjRGA
 9oOF4Yqci7jCbdKgOCDE+y5309+3d5mTQzzbcyfiihriIC0lnCcqb+0rEk0UImP9nW+T
 sMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203530; x=1787808330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RqgVkVYFeNp6FeqjJpHc7QsyG6NDmOjV7kM+fhiEVeI=;
 b=n7DdXKqQdOaF7CEcnwzcik/zpvMOaff2vJaa9mEe8HJ3vAXNN2sU25n+1jMuxd/aI7
 7uTXKXQ8VFk00pQz14Wc5MTwZQcJwjjZr4uMBZIRUp3qHm9lpCuCYAiQqO0x9z9D/nIm
 796d+PzifVbDMPEmSDqdtBdccqvCHsYWNZTc+X+H72s6BA+0CesoN2AIbcb33tPUaXBu
 rKJns+uJDeH3v/cIRJDPWSbz0luKsOFQhAKELY2x7Cy5AwWmU0cbV9R1U42mui7pH04u
 YNg8J4VtkWgdSelCe4TMqee2zAKcR7SX8yVP2FFmCdBBJWbA04JQ/v+rHI53zDWeLsbW
 WGag==
X-Gm-Message-State: AFuF++nAuy4m5cdBg8OZBso66scp2KxPKgDu70UQ/LBve0dAE+g0ZGZF
 bzjJ2d7xg2pZeHCcqYA6IA1jARhueEatNu8wh2BsdSy9cgSDbiJvTUD8kCBTQ2uKi+USQGaPdaG
 bktTR
X-Gm-Gg: AR+sD12JR8ZRE4dN73kAElhfdRgJZp4ZdDzGHF9HsDjG8mBxpcYyhQFPlBRuxOKSrNf
 UagzB+zF5qxNnj0D/Uq5a2l0nt1lCt6+VvxYM1Bb3wx/bB9Ov0l2wNFDBbdEYSorN36EMJwQddP
 xLzZmFHFMG6JGoCSPj2zDlOMboMjhru0vQKi3B0CwTd/QFYfb6c3fITfbtK+VB9IR+W+iq7q4ta
 osFOyZ4zQ2Ec31Ckk1lDta89tMzopay/NXRaBaNJJ3ClxwX66dJOW6355jOu7t+5XHRMCRV3urd
 YFL/bx4PbP2Fx+qZsmsp/QDXgFw46asW1UEkoXO8tBEOe2clfNx+U5mhsUnIOT3ENJJ2dAdhPKr
 txVWIFQjaeeBQInAoziReX+Oie8uB7zhCzx7GkvYKUmIrIRN0fzCls1xd+RrUFsKZGeinmrRIDW
 L8TXksWTFOfVRG55kdNI9tm6R3U1P+T1w7Fmv46HZGDSBDubiHY71RbY1ZB+LYii3U/jwYFQpqQ
 9cRnmXFymJRZjCV+pSp4rKusm4=
X-Received: by 2002:a17:90b:39ab:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39580ed4567mr16631930a91.4.1787203530007; 
 Wed, 19 Aug 2026 22:25:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 41/61] net/txgbe: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:31 -0700
Message-ID: <20260820052251.1453273-42-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy() for small fixed values.

The use of rte_memcpy() in the IPV6_ADDR_TO_MASK macro is in the
flow director mask setup, which is control path only. Regular
memcpy() has no performance disadvantage there and gets more
compile time checking of the arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/txgbe_ethdev.c |  9 ++--
 drivers/net/txgbe/txgbe_fdir.c   | 11 +++--
 drivers/net/txgbe/txgbe_flow.c   | 73 +++++++++++++++-----------------
 drivers/net/txgbe/txgbe_ipsec.c  |  8 ++--
 drivers/net/txgbe/txgbe_pf.c     |  6 +--
 drivers/net/txgbe/txgbe_tm.c     | 11 +++--
 6 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4d2746371b..69be47e8f4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4933,9 +4933,8 @@ txgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
 				sizeof(struct txgbe_5tuple_filter), 0);
 		if (filter == NULL)
 			return -ENOMEM;
-		rte_memcpy(&filter->filter_info,
-				 &filter_5tuple,
-				 sizeof(struct txgbe_5tuple_filter_info));
+		memcpy(&filter->filter_info, &filter_5tuple,
+		       sizeof(struct txgbe_5tuple_filter_info));
 		filter->queue = ntuple_filter->queue;
 		ret = txgbe_add_5tuple_filter(dev, filter);
 		if (ret < 0) {
@@ -5889,9 +5888,7 @@ txgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 		if (!node)
 			return -ENOMEM;
 
-		rte_memcpy(&node->key,
-				 &key,
-				 sizeof(struct txgbe_l2_tn_key));
+		memcpy(&node->key, &key, sizeof(struct txgbe_l2_tn_key));
 		node->pool = l2_tunnel->pool;
 		ret = txgbe_insert_l2_tn_filter(l2_tn_info, node);
 		if (ret < 0) {
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 67f586ffc7..2a9f56b49a 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -21,7 +21,7 @@
 #define IPV6_ADDR_TO_MASK(ipaddr, ipv6m) do { \
 	uint8_t ipv6_addr[16]; \
 	uint8_t i; \
-	rte_memcpy(ipv6_addr, (ipaddr), sizeof(ipv6_addr));\
+	memcpy(ipv6_addr, (ipaddr), sizeof(ipv6_addr));\
 	(ipv6m) = 0; \
 	for (i = 0; i < sizeof(ipv6_addr); i++) { \
 		if (ipv6_addr[i] == UINT8_MAX) \
@@ -42,7 +42,7 @@
 		else \
 			ipv6_addr[i] = 0; \
 	} \
-	rte_memcpy((ipaddr), ipv6_addr, sizeof(ipv6_addr));\
+	memcpy((ipaddr), ipv6_addr, sizeof(ipv6_addr));\
 } while (0)
 
 /**
@@ -898,8 +898,8 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 				   sizeof(struct txgbe_fdir_filter), 0);
 		if (!node)
 			return -ENOMEM;
-		rte_memcpy(&node->input, &rule->input,
-			   sizeof(struct txgbe_atr_input));
+		memcpy(&node->input, &rule->input,
+		       sizeof(struct txgbe_atr_input));
 		node->fdirflags = rule->fdirflags;
 		node->fdirhash = fdirhash;
 		node->queue = queue;
@@ -1051,8 +1051,7 @@ txgbevf_fdir_filter_program(struct rte_eth_dev *dev,
 			   sizeof(struct txgbe_fdir_filter), 0);
 	if (!node)
 		return -ENOMEM;
-	rte_memcpy(&node->input, input,
-		   sizeof(struct txgbe_atr_input));
+	memcpy(&node->input, input, sizeof(struct txgbe_atr_input));
 	node->fdirflags = rule->fdirflags;
 	node->fdirhash = fdirhash;
 	node->queue = rule->queue;
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 1bb0d3978c..8d7d919262 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1868,10 +1868,10 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
 		if (item->spec) {
 			rule->b_spec = TRUE;
 			ipv6_spec = item->spec;
-			rte_memcpy(rule->input.src_ip,
-				   &ipv6_spec->hdr.src_addr, 16);
-			rte_memcpy(rule->input.dst_ip,
-				   &ipv6_spec->hdr.dst_addr, 16);
+			memcpy(rule->input.src_ip, &ipv6_spec->hdr.src_addr,
+			       16);
+			memcpy(rule->input.dst_ip, &ipv6_spec->hdr.dst_addr,
+			       16);
 		}
 
 		/**
@@ -2628,10 +2628,10 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 		if (item->spec) {
 			rule->b_spec = TRUE;
 			ipv6_spec = item->spec;
-			rte_memcpy(rule->input.src_ip,
-				   &ipv6_spec->hdr.src_addr, 16);
-			rte_memcpy(rule->input.dst_ip,
-				   &ipv6_spec->hdr.dst_addr, 16);
+			memcpy(rule->input.src_ip, &ipv6_spec->hdr.src_addr,
+			       16);
+			memcpy(rule->input.dst_ip, &ipv6_spec->hdr.dst_addr,
+			       16);
 		}
 
 		/**
@@ -3254,9 +3254,9 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
+			memcpy(&ntuple_filter_ptr->filter_info,
+			       &ntuple_filter,
+			       sizeof(struct rte_eth_ntuple_filter));
 			TAILQ_INSERT_TAIL(&filter_ntuple_list,
 				ntuple_filter_ptr, entries);
 			flow->rule = ntuple_filter_ptr;
@@ -3283,9 +3283,9 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
+			memcpy(&ethertype_filter_ptr->filter_info,
+			       &ethertype_filter,
+			       sizeof(struct rte_eth_ethertype_filter));
 			TAILQ_INSERT_TAIL(&filter_ethertype_list,
 				ethertype_filter_ptr, entries);
 			flow->rule = ethertype_filter_ptr;
@@ -3307,9 +3307,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&syn_filter_ptr->filter_info,
-				&syn_filter,
-				sizeof(struct rte_eth_syn_filter));
+			memcpy(&syn_filter_ptr->filter_info, &syn_filter,
+			       sizeof(struct rte_eth_syn_filter));
 			TAILQ_INSERT_TAIL(&filter_syn_list,
 				syn_filter_ptr,
 				entries);
@@ -3335,9 +3334,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&fdir_rule_ptr->filter_info,
-				   &fdir_rule,
-				   sizeof(struct txgbe_fdir_rule));
+			memcpy(&fdir_rule_ptr->filter_info, &fdir_rule,
+			       sizeof(struct txgbe_fdir_rule));
 			TAILQ_INSERT_TAIL(&filter_fdir_list,
 					  fdir_rule_ptr, entries);
 			flow->rule = fdir_rule_ptr;
@@ -3403,9 +3401,9 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 						"failed to allocate memory");
 					goto out;
 				}
-				rte_memcpy(&fdir_rule_ptr->filter_info,
-					&fdir_rule,
-					sizeof(struct txgbe_fdir_rule));
+				memcpy(&fdir_rule_ptr->filter_info,
+				       &fdir_rule,
+				       sizeof(struct txgbe_fdir_rule));
 				TAILQ_INSERT_TAIL(&filter_fdir_list,
 					fdir_rule_ptr, entries);
 				flow->rule = fdir_rule_ptr;
@@ -3440,9 +3438,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			rte_memcpy(&l2_tn_filter_ptr->filter_info,
-				&l2_tn_filter,
-				sizeof(struct txgbe_l2_tunnel_conf));
+			memcpy(&l2_tn_filter_ptr->filter_info, &l2_tn_filter,
+			       sizeof(struct txgbe_l2_tunnel_conf));
 			TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
 				l2_tn_filter_ptr, entries);
 			flow->rule = l2_tn_filter_ptr;
@@ -3569,9 +3566,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct txgbe_ntuple_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ntuple_filter,
-			&ntuple_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ntuple_filter));
+		memcpy(&ntuple_filter, &ntuple_filter_ptr->filter_info,
+		       sizeof(struct rte_eth_ntuple_filter));
 		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_ntuple_list,
@@ -3582,9 +3578,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct txgbe_ethertype_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ethertype_filter));
+		memcpy(&ethertype_filter, &ethertype_filter_ptr->filter_info,
+		       sizeof(struct rte_eth_ethertype_filter));
 		ret = txgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
 		if (!ret) {
@@ -3596,9 +3591,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct txgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
-		rte_memcpy(&syn_filter,
-			&syn_filter_ptr->filter_info,
-			sizeof(struct rte_eth_syn_filter));
+		memcpy(&syn_filter, &syn_filter_ptr->filter_info,
+		       sizeof(struct rte_eth_syn_filter));
 		ret = txgbe_syn_filter_set(dev, &syn_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_syn_list,
@@ -3608,9 +3602,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct txgbe_fdir_rule_ele *)pmd_flow->rule;
-		rte_memcpy(&fdir_rule,
-			&fdir_rule_ptr->filter_info,
-			sizeof(struct txgbe_fdir_rule));
+		memcpy(&fdir_rule, &fdir_rule_ptr->filter_info,
+		       sizeof(struct txgbe_fdir_rule));
 		if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
 			ret = txgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
 		else
@@ -3632,8 +3625,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_L2_TUNNEL:
 		l2_tn_filter_ptr = (struct txgbe_eth_l2_tunnel_conf_ele *)
 				pmd_flow->rule;
-		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
-			sizeof(struct txgbe_l2_tunnel_conf));
+		memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
+		       sizeof(struct txgbe_l2_tunnel_conf));
 		ret = txgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_l2_tunnel_list,
diff --git a/drivers/net/txgbe/txgbe_ipsec.c b/drivers/net/txgbe/txgbe_ipsec.c
index 65b6c251c6..e704732541 100644
--- a/drivers/net/txgbe/txgbe_ipsec.c
+++ b/drivers/net/txgbe/txgbe_ipsec.c
@@ -658,10 +658,10 @@ txgbe_crypto_add_ingress_sa_from_flow(const void *sess,
 			const struct rte_flow_item_ipv6 *ipv6 = ip_spec;
 			ic_session->src_ip.type = IPv6;
 			ic_session->dst_ip.type = IPv6;
-			rte_memcpy(ic_session->src_ip.ipv6,
-				   &ipv6->hdr.src_addr, 16);
-			rte_memcpy(ic_session->dst_ip.ipv6,
-				   &ipv6->hdr.dst_addr, 16);
+			memcpy(ic_session->src_ip.ipv6, &ipv6->hdr.src_addr,
+			       16);
+			memcpy(ic_session->dst_ip.ipv6, &ipv6->hdr.dst_addr,
+			       16);
 		} else {
 			const struct rte_flow_item_ipv4 *ipv4 = ip_spec;
 			ic_session->src_ip.type = IPv4;
diff --git a/drivers/net/txgbe/txgbe_pf.c b/drivers/net/txgbe/txgbe_pf.c
index 91f73521fe..9dd6aabce1 100644
--- a/drivers/net/txgbe/txgbe_pf.c
+++ b/drivers/net/txgbe/txgbe_pf.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
 #include <inttypes.h>
@@ -17,7 +18,6 @@
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
 #include <bus_pci_driver.h>
@@ -435,7 +435,7 @@ txgbe_vf_reset(struct rte_eth_dev *eth_dev, uint16_t vf, uint32_t *msgbuf)
 
 	/* reply to reset with ack and vf mac address */
 	msgbuf[0] = TXGBE_VF_RESET | TXGBE_VT_MSGTYPE_ACK;
-	rte_memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
+	memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
 	/*
 	 * Piggyback the multicast filter type so VF can compute the
 	 * correct vectors
@@ -457,7 +457,7 @@ txgbe_vf_set_mac_addr(struct rte_eth_dev *eth_dev,
 	struct rte_ether_addr *ea = (struct rte_ether_addr *)new_mac;
 
 	if (rte_is_valid_assigned_ether_addr(ea)) {
-		rte_memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
+		memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
 		return hw->mac.set_rar(hw, rar_entry, new_mac, vf, true);
 	}
 	return -1;
diff --git a/drivers/net/txgbe/txgbe_tm.c b/drivers/net/txgbe/txgbe_tm.c
index 29c7c4adfb..b69883ffa9 100644
--- a/drivers/net/txgbe/txgbe_tm.c
+++ b/drivers/net/txgbe/txgbe_tm.c
@@ -280,8 +280,8 @@ txgbe_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
-			 sizeof(struct rte_tm_shaper_params));
+	memcpy(&shaper_profile->profile, profile,
+	       sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&tm_conf->shaper_profile_list,
 			  shaper_profile, node);
 
@@ -625,8 +625,8 @@ txgbe_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->no = 0;
 		tm_node->parent = NULL;
 		tm_node->shaper_profile = shaper_profile;
-		rte_memcpy(&tm_node->params, params,
-				 sizeof(struct rte_tm_node_params));
+		memcpy(&tm_node->params, params,
+		       sizeof(struct rte_tm_node_params));
 		tm_conf->root = tm_node;
 
 		/* increase the reference counter of the shaper profile */
@@ -706,8 +706,7 @@ txgbe_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->reference_count = 0;
 	tm_node->parent = parent_node;
 	tm_node->shaper_profile = shaper_profile;
-	rte_memcpy(&tm_node->params, params,
-			 sizeof(struct rte_tm_node_params));
+	memcpy(&tm_node->params, params, sizeof(struct rte_tm_node_params));
 	if (parent_node_type == TXGBE_TM_NODE_TYPE_PORT) {
 		tm_node->no = parent_node->reference_count;
 		TAILQ_INSERT_TAIL(&tm_conf->tc_list,
-- 
2.53.0

