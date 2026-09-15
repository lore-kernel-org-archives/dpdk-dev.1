Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403DC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D4A942D76;
	Tue, 15 Sep 2026 17:25:24 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 35B5742D6A
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:25:23 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2dso2252009a12.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789485922; x=1790090722; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B5Dn04Kk3dDRIiPfB1K/qlumpMEeVXZBfZU++/5hqLg=;
 b=IZSFX5KW1eXFcq2gm5QAhUUeyYePUzv8lgiJT+YSUcKS/56bxvuI6kaAtk/xwmbCZn
 pjtIodqVkmbe+9QTmmSb0Q9NCfa2bEpkWX8ZEgnrA6T7mFVnccqqJN5wn60Fj/9Y+X+r
 OA0g3BI5mN2o0PBUXsN2eyrHR8YGN+UvNb040fVI5O0sKMFxgH06AF/N5OCJYEO1LgSi
 T+X5aaQQZNDUR40IHkx2Ojp01fgPZG3eBb7BRYIgcwKHsiM10h1LgzREzIlsr1RfCPV2
 rJQptP/FIhPoZa0osNC1pWIUOBo70YSWf8Vp1bcry/j2rJ5G233CDpBFWN6meZBRnxfJ
 nAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485922; x=1790090722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B5Dn04Kk3dDRIiPfB1K/qlumpMEeVXZBfZU++/5hqLg=;
 b=mMMmmgfI6K0HdEzhY3YcTCas7cUXBTPM+x1fTYBlW86tKdUshYJqGfrXyO2V5MfDrY
 HYIxirCMqhppdjzYYdRfawm0tkPzb2dUY5CLypyTASSJhke6v63OW5LDEAApTb/Ff6sF
 TI4c+HbQrcIRFshAFCD/AjEUAt8HcV6r02dBudEnqA7Evb/d7d3GYGbfPHj3csKZvEg3
 TVuKzw5YiH4E8tvXf647bZQ3yeRapzhSH5JTx97YgFewzPTmLbAF13ip0x+JKYN1eNak
 NFR7hmDzmJBwM8uUV8jpQcc98G9QwBtmfZp2qbYcFl8DAlNZgWvSxsZB8Z4edz2WbH6Y
 5sJQ==
X-Gm-Message-State: AFuF++naQifeVaCgNzEq3PvDi6aFRcNovC623CDoxyc3SvauJ2YUrDSD
 +olDu5hdJdu/6odi574VEW8zEwgcW1sqd+A1/ngIvbUp57DcumIgzk+p
X-Gm-Gg: AYBFou3KKdoYVflAgpkvjlazKu2nkTW2oNN1x4C8tbj3nBAETjohZ9LP2BvBQt6X99m
 ymf/Kc0gUckdIjYIdKm1FN16nOdWmnz7fVewWYpda0nUY+nSOfPQjSC+bCQvZxpjLIglwnucG67
 UsowLmHF2FECJUUnKvtuRDiXrUHT2vAJDeP6V3Fdut+ZLmPcc9DXm+eJFpf5wvi22XfNncn9Fgl
 9G1C02Tf6wrfkkqCqmuPLi2iwPtptB4SOiJCy/JkwW7sPmyF1aEXPZUsJeme8AVwkfsWgDjxJTf
 9R33t+rTl1/d7GmpNeLRcBIyw9i3iRQyWOPrW3nJBMQVbYvoulCSox/0fbhhf0BxO1S0hIkqH5O
 Dan1jzxmBeThWuK5s080D5QhUa3wihseb3CrMq99mBQlvhxYIewRCadp5EjTTndANkYxVrCme6V
 eQPeX9/0lVGuceakoBABvl1Fe0UoGpU1n0y4GhcbZWyvETykFqErAOD1gmOKq2jTwaF7lgkwCpn
 H47ugeeMfvEmLNNGA==
X-Received: by 2002:a05:6a20:d527:b0:3d3:b00b:50fc with SMTP id
 adf61e73a8af0-3db4066232bmr18612878637.28.1789485922006; 
 Tue, 15 Sep 2026 08:25:22 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc50ab7e1b1sm90240a12.16.2026.09.15.08.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:25:21 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH] net/txgbe: fix leak of filters on flow create
Date: Tue, 15 Sep 2026 23:24:36 +0800
Message-ID: <20260915152436.67378-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

txgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
RSS filters into hardware before allocating the software flow object.
If that allocation fails, create returns an error but leaves the
hardware filter installed. The application has no handle to destroy it.

Allocate the software copy first, then program the hardware. On a
programming failure, free the copy. Set ENOMEM when allocation fails
so the error path does not report success.

L2 tunnel add failures now return immediately instead of falling
through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
and overwrote the original error.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 227 ++++++++++++++++++---------------
 1 file changed, 122 insertions(+), 105 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index eaeb973c91..a3e6f8cb83 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
+#include <errno.h>
 #include <sys/queue.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
@@ -3246,26 +3247,28 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 #endif
 
 	if (!ret) {
+		ntuple_filter_ptr = rte_zmalloc("txgbe_ntuple_filter",
+			sizeof(struct txgbe_ntuple_filter_ele), 0);
+		if (!ntuple_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		rte_memcpy(&ntuple_filter_ptr->filter_info,
+			&ntuple_filter,
+			sizeof(struct rte_eth_ntuple_filter));
 		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
-		if (!ret) {
-			ntuple_filter_ptr = rte_zmalloc("txgbe_ntuple_filter",
-				sizeof(struct txgbe_ntuple_filter_ele), 0);
-			if (!ntuple_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
-			TAILQ_INSERT_TAIL(&filter_ntuple_list,
-				ntuple_filter_ptr, entries);
-			flow->rule = ntuple_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
-			return flow;
-		} else if (filter_info->ntuple_is_full) {
-			goto next;
+		if (ret) {
+			rte_free(ntuple_filter_ptr);
+			if (filter_info->ntuple_is_full)
+				goto next;
+			goto out;
 		}
-		goto out;
+		TAILQ_INSERT_TAIL(&filter_ntuple_list,
+			ntuple_filter_ptr, entries);
+		flow->rule = ntuple_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_NTUPLE;
+		return flow;
 	}
 
 next:
@@ -3273,51 +3276,53 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	ret = txgbe_parse_ethertype_filter(dev, attr, pattern,
 				actions, &ethertype_filter, error);
 	if (!ret) {
+		ethertype_filter_ptr = rte_zmalloc("txgbe_ethertype_filter",
+			sizeof(struct txgbe_ethertype_filter_ele), 0);
+		if (!ethertype_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		rte_memcpy(&ethertype_filter_ptr->filter_info,
+			&ethertype_filter,
+			sizeof(struct rte_eth_ethertype_filter));
 		ret = txgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, TRUE);
-		if (!ret) {
-			ethertype_filter_ptr =
-				rte_zmalloc("txgbe_ethertype_filter",
-				sizeof(struct txgbe_ethertype_filter_ele), 0);
-			if (!ethertype_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
-			TAILQ_INSERT_TAIL(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
-			flow->rule = ethertype_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
-			return flow;
+		if (ret) {
+			rte_free(ethertype_filter_ptr);
+			goto out;
 		}
-		goto out;
+		TAILQ_INSERT_TAIL(&filter_ethertype_list,
+			ethertype_filter_ptr, entries);
+		flow->rule = ethertype_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
+		return flow;
 	}
 
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = txgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
 	if (!ret) {
+		syn_filter_ptr = rte_zmalloc("txgbe_syn_filter",
+			sizeof(struct txgbe_eth_syn_filter_ele), 0);
+		if (!syn_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		rte_memcpy(&syn_filter_ptr->filter_info,
+			&syn_filter,
+			sizeof(struct rte_eth_syn_filter));
 		ret = txgbe_syn_filter_set(dev, &syn_filter, TRUE);
-		if (!ret) {
-			syn_filter_ptr = rte_zmalloc("txgbe_syn_filter",
-				sizeof(struct txgbe_eth_syn_filter_ele), 0);
-			if (!syn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&syn_filter_ptr->filter_info,
-				&syn_filter,
-				sizeof(struct rte_eth_syn_filter));
-			TAILQ_INSERT_TAIL(&filter_syn_list,
-				syn_filter_ptr,
-				entries);
-			flow->rule = syn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_SYN;
-			return flow;
+		if (ret) {
+			rte_free(syn_filter_ptr);
+			goto out;
 		}
-		goto out;
+		TAILQ_INSERT_TAIL(&filter_syn_list,
+			syn_filter_ptr, entries);
+		flow->rule = syn_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_SYN;
+		return flow;
 	}
 
 	memset(&fdir_rule, 0, sizeof(struct txgbe_fdir_rule));
@@ -3325,16 +3330,21 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				actions, &fdir_rule, error);
 	if (!ret) {
 		if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
-			ret = txgbevf_fdir_filter_program(dev, &fdir_rule, FALSE);
-			if (ret < 0)
-				goto out;
-
 			fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
-					    sizeof(struct txgbe_fdir_rule_ele), 0);
+					sizeof(struct txgbe_fdir_rule_ele), 0);
 			if (!fdir_rule_ptr) {
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
+				ret = -ENOMEM;
 				goto out;
 			}
+
+			ret = txgbevf_fdir_filter_program(dev, &fdir_rule,
+							  FALSE);
+			if (ret < 0) {
+				rte_free(fdir_rule_ptr);
+				goto out;
+			}
+
 			rte_memcpy(&fdir_rule_ptr->filter_info,
 				   &fdir_rule,
 				   sizeof(struct txgbe_fdir_rule));
@@ -3393,28 +3403,19 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		}
 
 		if (fdir_rule.b_spec) {
-			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
-					FALSE, FALSE);
-			if (!ret) {
-				fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
+			fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
 					sizeof(struct txgbe_fdir_rule_ele), 0);
-				if (!fdir_rule_ptr) {
-					PMD_DRV_LOG(ERR,
-						"failed to allocate memory");
-					goto out;
-				}
-				rte_memcpy(&fdir_rule_ptr->filter_info,
-					&fdir_rule,
-					sizeof(struct txgbe_fdir_rule));
-				TAILQ_INSERT_TAIL(&filter_fdir_list,
-					fdir_rule_ptr, entries);
-				flow->rule = fdir_rule_ptr;
-				flow->filter_type = RTE_ETH_FILTER_FDIR;
-
-				return flow;
+			if (!fdir_rule_ptr) {
+				PMD_DRV_LOG(ERR,
+					"failed to allocate memory");
+				ret = -ENOMEM;
+				goto out;
 			}
 
+			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
+					FALSE, FALSE);
 			if (ret) {
+				rte_free(fdir_rule_ptr);
 				/**
 				 * clean the mask_added flag if fail to
 				 * program
@@ -3423,6 +3424,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					fdir_info->mask_added = FALSE;
 				goto out;
 			}
+
+			rte_memcpy(&fdir_rule_ptr->filter_info,
+				&fdir_rule,
+				sizeof(struct txgbe_fdir_rule));
+			TAILQ_INSERT_TAIL(&filter_fdir_list,
+				fdir_rule_ptr, entries);
+			flow->rule = fdir_rule_ptr;
+			flow->filter_type = RTE_ETH_FILTER_FDIR;
+
+			return flow;
 		}
 
 		goto out;
@@ -3432,45 +3443,51 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	ret = txgbe_parse_l2_tn_filter(dev, attr, pattern,
 					actions, &l2_tn_filter, error);
 	if (!ret) {
+		l2_tn_filter_ptr = rte_zmalloc("txgbe_l2_tn_filter",
+			sizeof(struct txgbe_eth_l2_tunnel_conf_ele), 0);
+		if (!l2_tn_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		rte_memcpy(&l2_tn_filter_ptr->filter_info,
+			&l2_tn_filter,
+			sizeof(struct txgbe_l2_tunnel_conf));
 		ret = txgbe_dev_l2_tunnel_filter_add(dev, &l2_tn_filter, FALSE);
-		if (!ret) {
-			l2_tn_filter_ptr = rte_zmalloc("txgbe_l2_tn_filter",
-				sizeof(struct txgbe_eth_l2_tunnel_conf_ele), 0);
-			if (!l2_tn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			rte_memcpy(&l2_tn_filter_ptr->filter_info,
-				&l2_tn_filter,
-				sizeof(struct txgbe_l2_tunnel_conf));
-			TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
-			flow->rule = l2_tn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
-			return flow;
+		if (ret) {
+			rte_free(l2_tn_filter_ptr);
+			goto out;
 		}
+		TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
+			l2_tn_filter_ptr, entries);
+		flow->rule = l2_tn_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
+		return flow;
 	}
 
 	memset(&rss_conf, 0, sizeof(struct txgbe_rte_flow_rss_conf));
 	ret = txgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
 	if (!ret) {
-		ret = txgbe_config_rss_filter(dev, &rss_conf, TRUE);
-		if (!ret) {
-			rss_filter_ptr = rte_zmalloc("txgbe_rss_filter",
-				sizeof(struct txgbe_rss_conf_ele), 0);
-			if (!rss_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			txgbe_rss_conf_init(&rss_filter_ptr->filter_info,
-					    &rss_conf.conf);
-			TAILQ_INSERT_TAIL(&filter_rss_list,
-				rss_filter_ptr, entries);
-			flow->rule = rss_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_HASH;
-			return flow;
+		rss_filter_ptr = rte_zmalloc("txgbe_rss_filter",
+			sizeof(struct txgbe_rss_conf_ele), 0);
+		if (!rss_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
 		}
+		ret = txgbe_config_rss_filter(dev, &rss_conf, TRUE);
+		if (ret) {
+			rte_free(rss_filter_ptr);
+			goto out;
+		}
+		txgbe_rss_conf_init(&rss_filter_ptr->filter_info,
+				    &rss_conf.conf);
+		TAILQ_INSERT_TAIL(&filter_rss_list,
+			rss_filter_ptr, entries);
+		flow->rule = rss_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_HASH;
+		return flow;
 	}
 
 out:
-- 
2.53.0

