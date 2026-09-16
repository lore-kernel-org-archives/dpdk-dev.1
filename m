Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B498C982C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF53142F27;
	Wed, 16 Sep 2026 15:12:21 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 9F14D42F35
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:12:20 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c5so687287b3a.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564340; x=1790169140; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UuXfF0uqFF1SyyxQwd+wJ0TWiGGFTlZjZ1+5gqwk3hE=;
 b=p51+Qk0aOStDdLbVCkH8wGHjtnmanSqW6gMxjdnULbP9cdVHwQA1Xm5pzN9ZwO6606
 C2aMaUU5yx9cPsDUM+ciha/87bpTcTMzAKYb9bbpYyEyx88yr9C90/z4sCrgNyfA9bH0
 6D6YN62YxT1mfUKIw0tChAsDPIyR23ZKsbvpRe0VkdwLv5TrccVymhPw3kKbZbzpjnMo
 0EuAwSflAGFkZgIckwZs3aY+ntZMfhAcsDAWwnL2fvvqP+EU0IJjKL3bFu3KceuK4aPp
 4h5AugQMzqa1hPreTl82PeJwj72PUNN/3GzHNOay7iK7W+7QafiSJ/PbTEK2/ok9qJgl
 CSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564340; x=1790169140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UuXfF0uqFF1SyyxQwd+wJ0TWiGGFTlZjZ1+5gqwk3hE=;
 b=xJI6ADj9tudCCtROcLWvasSXYTTltnrmpG1hPhUfdJzUwMmOYvMH4p1Oh6KlVoPCr7
 JoAchltaFmcqBGCCHXr8bhfH4HvsywN65wYe+dPPTwZLB+6q95+pZaeiOliReVO22Vbj
 r/i9BXFBzBx62jOHqiRGMQdhIgIHi0r8XSOzB5LD92UrQEUJGBZUkv0Q6gGHTcOnynch
 fNz3t7noAV5YDdVAWTagjMAnUR84o4eKQ5Blq9g/2oU5zTWBlhXq8yToqBohqvpFbhH5
 pMp9NcMn0i7fQWQM5RDV899jaGOQvaeR1zeHCV/udGw0t0awDMSJEFEXJUr6L9J7y/IK
 OyKQ==
X-Gm-Message-State: AFuF++k6HtFg2UbrCGBSYDCoMJoP7DFrhNNxSWOkPdO5dPPUp36zwJ16
 MWanWBLo2fUq0F1jXDpX1SRAD1zvkMj4xHVpFMbrwaCs+YKJW3GjLpr6
X-Gm-Gg: AYBFou24LMKteKoY4FN/wQXMovZAwD1Vsm1Dk9g2K0gG5AxPRty9DvNy90E+62JoRxu
 L/Yv2pI2pXvabxvt0jzMdJMI2CsHQCpgpebQlZE51InLy9rzaA1i1e5cAcXn+Ae1oBuU3DOkG9+
 6oVOb0LrJo6sa7KHPo0mW4nlsXmbH1s/8Tee8yJ2v5oqPTEpONmHWhvsSDQemFGfZKYFfaHXk98
 4w/8MKjrP5zvSCyHC6i+OA99ticnh5SWT5hrKfEUlI4eQdG30uVCgTcl/QUJttMk2X4unMh4B12
 TGN0t5dy77RhvJ9W/G5g5Q6mpofa9tMPOrJVqNWmj25IKqmxwWWGbJpw2w6BdGyJFVUbySeTunP
 Osm6u2i3bemzxlO4ePjErtTLGe9DAiAQYkV6CvKhjNP+DtyrCnjs5U4I2KSGhfQv2IwgqipwuYH
 q/E/qPhX0J2iXgACqQ8mMUBnWPPRBMisxQrOtV2UdItKwKL/XlUAyuvZ/QRxpmC14aELaOpTajP
 ZhncK4=
X-Received: by 2002:a05:6a00:2d8c:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-87238d890c7mr4948454b3a.16.1789564339436; 
 Wed, 16 Sep 2026 06:12:19 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-872025dd04csm1224882b3a.60.2026.09.16.06.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:19 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 2/3] net/txgbe: fix leak of filters on flow create
Date: Wed, 16 Sep 2026 21:11:04 +0800
Message-ID: <20260916131106.105667-3-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916131106.105667-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
 <20260916131106.105667-1-zhtfdev@gmail.com>
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
programming failure, free the copy. Set ENOMEM when allocation fails.
Allocate the FDIR object before installing the global mask so an
allocation failure cannot leave mask_added set with no rule.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Fixes: 7eef71080e16 ("net/txgbe: switch to FDIR on VF")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 233 +++++++++++++++++----------------
 1 file changed, 121 insertions(+), 112 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 76191a7c2d..a1a497fa22 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
+#include <errno.h>
 #include <sys/queue.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
@@ -3246,26 +3247,26 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 #endif
 
 	if (!ret) {
+		ntuple_filter_ptr = rte_zmalloc("txgbe_ntuple_filter",
+			sizeof(struct txgbe_ntuple_filter_ele), 0);
+		if (!ntuple_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		ntuple_filter_ptr->filter_info = ntuple_filter;
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
@@ -3273,51 +3274,49 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
+		ethertype_filter_ptr->filter_info = ethertype_filter;
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
+		syn_filter_ptr->filter_info = syn_filter;
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
@@ -3325,19 +3324,22 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
-			rte_memcpy(&fdir_rule_ptr->filter_info,
-				   &fdir_rule,
-				   sizeof(struct txgbe_fdir_rule));
+
+			ret = txgbevf_fdir_filter_program(dev, &fdir_rule,
+							  FALSE);
+			if (ret < 0) {
+				rte_free(fdir_rule_ptr);
+				goto out;
+			}
+
+			fdir_rule_ptr->filter_info = fdir_rule;
 			TAILQ_INSERT_TAIL(&filter_fdir_list,
 					  fdir_rule_ptr, entries);
 			flow->rule = fdir_rule_ptr;
@@ -3345,6 +3347,14 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			return flow;
 		}
 
+		fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
+				sizeof(struct txgbe_fdir_rule_ele), 0);
+		if (!fdir_rule_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		/* A mask cannot be deleted. */
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
@@ -3366,8 +3376,10 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				fdir_info->mask.pkt_type_mask =
 					fdir_rule.mask.pkt_type_mask;
 				ret = txgbe_fdir_set_input_mask(dev);
-				if (ret)
+				if (ret) {
+					rte_free(fdir_rule_ptr);
 					goto out;
+				}
 
 				fdir_info->mask_added = TRUE;
 				first_mask = TRUE;
@@ -3381,40 +3393,25 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					sizeof(struct txgbe_hw_fdir_mask));
 				if (ret) {
 					PMD_DRV_LOG(ERR, "only support one global mask");
+					rte_free(fdir_rule_ptr);
 					goto out;
 				}
 
 				if (fdir_info->flex_bytes_offset !=
 				    fdir_rule.flex_bytes_offset ||
 				    fdir_info->flex_relative !=
-				    fdir_rule.flex_relative)
+				    fdir_rule.flex_relative) {
+					rte_free(fdir_rule_ptr);
 					goto out;
+				}
 			}
 		}
 
 		if (fdir_rule.b_spec) {
 			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
 					FALSE, FALSE);
-			if (!ret) {
-				fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
-					sizeof(struct txgbe_fdir_rule_ele), 0);
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
-			}
-
 			if (ret) {
+				rte_free(fdir_rule_ptr);
 				/**
 				 * clean the mask_added flag if fail to
 				 * program
@@ -3423,8 +3420,17 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					fdir_info->mask_added = FALSE;
 				goto out;
 			}
+
+			fdir_rule_ptr->filter_info = fdir_rule;
+			TAILQ_INSERT_TAIL(&filter_fdir_list,
+				fdir_rule_ptr, entries);
+			flow->rule = fdir_rule_ptr;
+			flow->filter_type = RTE_ETH_FILTER_FDIR;
+
+			return flow;
 		}
 
+		rte_free(fdir_rule_ptr);
 		goto out;
 	}
 
@@ -3432,46 +3438,49 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
+		l2_tn_filter_ptr->filter_info = l2_tn_filter;
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
-		goto out;
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

