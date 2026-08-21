Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5721C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA58840DF5;
	Fri, 21 Aug 2026 21:30:48 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 412F240E72
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:47 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1843530b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340646;
 x=1787945446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqgVkVYFeNp6FeqjJpHc7QsyG6NDmOjV7kM+fhiEVeI=;
 b=x2aTIBy+e1g9CUHTr0Hv1FQxCYTjbspJU8NUGCkQFJu56p8vuGTgnSsEoONFzahaV0
 e1kLD57mZsXEZaqynkCjS8dFc36MPel+MRMgqKRemtwervHCmQQYgSK3RTDheqHveAcO
 rafRlzGFZsUTnJLnGDq5y/rAfHwWzHDUlYLS8IjhOUT60uX1lhZ+J/JOkV7IVq8M+SNc
 gapcETGVLcKlJrHIn16DINzbmE9JTlkS3wl1ugNcLw2frfjzcrlkizXgZON+UbIkaglj
 SxKsqt5P6QVpR+2TqJ0eQrw/J0NEb22SRQEgGuDIzjHQixqMt713Np3quTVuT/oYQ8Gf
 1GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340646; x=1787945446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RqgVkVYFeNp6FeqjJpHc7QsyG6NDmOjV7kM+fhiEVeI=;
 b=qfmfmP4Do+dQxpzdvUX5gYZW93HlWpJTKDZuL8Iykv91HkQZGmQQHl5KkgRrLiLppP
 25ux+WwmBM78M3GXQtdrKzoJshFtoPnqsLL+la0AdmiWGb8a3taVCqdY6XI9E7kzS/Zg
 jjg4UnSCJ9odj6yuTC6mllBvB7PkDZQA3U0Uirm9BM32A6HNmxqo1OfeNph0pxXTIQjb
 z+uZusJkA2lUugYaGf3LzDe03bbReXOtt/SLZZ1m857ejLi5LAmZ8DzTEbbdmNPPs28h
 UiGo7+DneYLN0TvKt2osKGxo7Qs1msvymcqeZ1+n+i/meMNtwoK80kCYeRPLC8CK6/tX
 EQ2A==
X-Gm-Message-State: AFuF++nr9Ei0PjwRHQY2fhUhDfR5s4p6Sp2THTq8f4MHp6HaKnPPTNtN
 RJBlBxqrhw9GXEpSwteCJQapdrNnNlZw5hMK1Fb45mm4YVckE/55dFZrFjEXpqTnm2+R4EaFYGa
 PuAQ0yd4=
X-Gm-Gg: AR+sD13i6gyv42YdTuQb679UP361qJx2nRsbHPUyhm6k1qpMBXR57CgCN54hRLWJ9QX
 /qiDRmivA3K3z2i7I+RRRn9dTM+f9q5BKrPjeu2RQ38gTl01Qb2LtNvYcEoOZklasv6K1sPMqwZ
 zenJEic9+SMn80qhs8v2IFsdY17/rXnitjCboO3tfw0ACkRhmKftrmeCx/kA4Rh+tsU20xJg8Al
 FGVkq0BlNSy3OShzi5wEFVjFsm/XDdTdlVjDzczPXxKUfd0Pu0Ne+K+qepcudVRPojKYNlNqCW3
 I2IkDPe0M3i7BO4O59ZrDpsCZrhWhIKc5cA3NqD9cVdt0Jq0bxc0rWvjJJ7mFus0fIF+MQ4uhEC
 EF6LojOwI4K1mF5R+FODgIXRWIJEG/kpU/o2nX97hZk09QcTHY4mmp0HqMZTtnit9hy2qDpJrJ+
 An8RY2yZCxe0Veo6mGWypM3jZ4DlukKBGG5AozWEgMUgZ+Un17IiiJh9hrE7a59XS8CDnizPSSW
 bpaZ7rWg9rhmmxfwyUmqtZOwGA=
X-Received: by 2002:a05:6a21:4e01:b0:3bf:bbad:500e with SMTP id
 adf61e73a8af0-3cd31a2ca79mr9102239637.5.1787340646293; 
 Fri, 21 Aug 2026 12:30:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 48/68] net/txgbe: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:43 -0700
Message-ID: <20260821192646.146382-49-stephen@networkplumber.org>
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

