Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B585C982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B4040658;
	Fri, 18 Sep 2026 20:30:41 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id A94CC4325E
 for <dev@dpdk.org>; Fri, 18 Sep 2026 20:30:39 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396cccbba92so1104880a91.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789756239; x=1790361039; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYyEMLKD34v+JHAZoaBZKHZpimt8mMS20J5pxuoDviI=;
 b=iMtLOgsIWxFpVbhDlOoZ47eixwMhM1KxRUFNzvBItZ5JW0fs/U7FlOtlHmXSTlXwNi
 NZ2+/JHCzYTCmtIqaqYkz76mCCpHoYkkC4fRRlMCkN+DShifFbS5N+R6DuSeZklsSnAz
 HkVsF/pnAkGfjewUQrpzlGEjAEOy5JCdjpS2M/xTorgZh5QUai5Ikyi8tPKarPBb87Kt
 HdYDE5tGWYD9jvuURakVndNKVRu5K5D80yL/mO02f32zqyLLPUsg97mKzcFkdEy0KqPl
 2dKNouWYkPNMmQu9rIGRpTslYvBvs1RucXw6/iCpfUHkTNi40B6VqIp1N9WRDNY9gi+s
 sB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756239; x=1790361039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bYyEMLKD34v+JHAZoaBZKHZpimt8mMS20J5pxuoDviI=;
 b=YHaYK6I9uvwYlm+/R189P8FyFEsfysDUdVvckV61gjwRN+TeLUTN+HdSkFf1lj4G4q
 SLXdbGUO62izezOITeL6bXL100MOKuQDfhOOhMelOUIHSPGiv8JRhxi3XIpj00F+bM6C
 kh/FCe2LQVoX+8gXF0/PQpZCIXB27CRli7S9HumhSnU03mTgTrONMkIW9JLtabq2FaXU
 8hrTlOwLe+I6la+XjwkzxUDioecy67IAoVjF19QMKAnmjgmBDVY3bMZeVUOmTevSgepb
 xrwTirfl3xoPxi5/GLE/ItkxHcvaQIJWR6LaxM4KRqr5/b2ovkMC3GN0Az6wLgS6PYBC
 pufQ==
X-Gm-Message-State: AFuF++nz9R9Z9UMbcp3JErR15H/jpa4sCxe9WMBMyAS+jOI/nhCy8LAX
 nkZYSvtTvFKssQDy6fMx9fwDGeEYCHpNOEJcVDj12XFUmDzVNNmxO48/
X-Gm-Gg: AYBFou2tL533jPyHHIGZFZXpKFBNTljsTykJdAUpaRE2eMG/axX/YIZUP1Ivla/9/N6
 8jym39O2UGFXlisnbXoUoteTPsNsnDHk03ZghS+ijhp1NfwOis7ztTJjOXp7JqwWZ+xMYcIMhQX
 vR+vIn5/DLXuUqYuaqUQcl0ISB4h4hP4ICJXrJSIk5RZHWPYXbfb+V0bfo3cdvQM6YFlwEMv2P5
 3wI7gw3x5YUwJNtQdeOdO2G3tMoizvHRuPlGpcq2Lq6LtSWYbQEmWiMQCVwRVQ+VGJpo28f1fwC
 vJ4hqBwOQB1rdUyL9dvX/63YpYIwvCLGWygcAk/X/ty0RcZcgfzysYMF4qJha803usDWfW9VXTF
 UWi8UIgWQvXclujeJyKLIyjDRoLZKXtEi/P4ecxjsXmeuhxl7t6W0NDBWNunIS3NXoK1ZHyA1a7
 pau/zXlM35ye9zdkCDj5R6zq3Mzfz1kRMxZ4ySvorzksCNbSRMMuBYU8EXWWqd+PgRyXahymEco
 updQ08=
X-Received: by 2002:a17:90b:548d:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-39e54d11d8dmr7269872a91.18.1789756237892; 
 Fri, 18 Sep 2026 11:30:37 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d4c0dsm397209eec.29.2026.09.18.11.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:30:37 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 2/3] net/txgbe: fix leak of filters on flow create
Date: Sat, 19 Sep 2026 02:30:10 +0800
Message-ID: <20260918183012.42520-3-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918183012.42520-1-zhtfdev@gmail.com>
References: <20260917153242.29315-1-zhtfdev@gmail.com>
 <20260918183012.42520-1-zhtfdev@gmail.com>
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
RSS filters into hardware before allocating the software copy.
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

