Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9CBC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 13:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF5540DCA;
	Mon, 14 Sep 2026 15:38:53 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id DEFFD40A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 15:38:51 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso3547358a91.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789393131; x=1789997931; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OOvL+G8G1XPZI/qFRo0sDmCXobDzsGT8e6yGP0C1L2k=;
 b=WoyGPTDMMP88SdkfgUsmIq2Bk23dF2UmmPgAntJHRPzrzOSDBezSjnLQAkgh9EoFTG
 g7LaHdOpvquwkXL6okuVBsgqakpdujk2w1rxPHinIzqzqhHjezGu6eQN0KW22Bx1q2EE
 zTtQIFhypdc6tUErZIh1oMOF4n6AN8sh8+Cdlp1KuE1CsVBtCPegqsaed18ZkGx8Ro3c
 /RTD10BWfuEPRkQNL06HVisNNoz4JM5HnkU2vfAyrUv+G3Fq5b3WJjIkC7pe+1Eip5sn
 VWw1a/oarz9YgFpIkJKgOGiTtolx+qE/HVaG0CIp5GXkvXDHB49NUFn2+ddu62Q9WA1m
 O3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789393131; x=1789997931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OOvL+G8G1XPZI/qFRo0sDmCXobDzsGT8e6yGP0C1L2k=;
 b=VWrlKk3tpVU+1sEWiDGxbcODCtq6w+y4SXd/LOzRC44B2zgrzLAAqKlCxw3xUZGraX
 Zao9dk3wUt71uf652MDKWAwwxhoMy8ZczVL3jUDfXX98KN4DHeXkJPcErdW8VKB1n+kW
 RswXjZprhJnflThuy1JaDTEX7yq/Bb8Yqj0ms1+r4ClZrUyad0Pp0Y/Ei/OOw0DQxW4z
 PVy8vmgsY3A2SJiOLMPu8wfv69h1mH5NjXGVYgLJWYKYEqqZAa3qpxAQ8hCoZ+pNN+Jz
 9YmtQVcLDKE5OmFyS3gH1MC+YdgnTtT+Dtbr7EqXRCnzDdlFDfNH6CRzKpv6S8J/rkok
 mVug==
X-Gm-Message-State: AFuF++lj8ED/nU5TfmmeIqeJGpbnFDoxWjMMMUiBs9KLGv8HzA+AKZHV
 SA7mHYE2bPdWGo05sodufGu30sfGUiZwxuiNtYFiXOsZ9KZuiLkhfN1nKIE55nQ7
X-Gm-Gg: AYBFou14CtK6XwxVigUXH1HoQuP6hvkREjMeXC8/4i38y/aQiPIR5sywwAp89XLsy+Y
 du/QuDQHelDlagCAsZbeDj38Q70yFNp/+FckEz7tRR3KrhHvrPEguT0E4CHSd5iewQ7aO69S0zf
 XL7lCYPiA7p9uudwneyQB3SgibWESwf2lGc9FNlPtmK0hFuBqmCuS9gDyuCPOhYE8/ow4jyW2J2
 K9MFmwdEvhVwcXp9Fn36eMKPrQQcwG1cK+iM0oL3Ve1xrA9SkyJJYEbyua/eErKQUA9a2beDB7y
 M3q64yvhHOH5qbDJNwElSYO1ZEMdfyknrly7bOARF+YGTzw4BexqtiOHtwQK0bKuDD9+7vHis/2
 gnQbJoghwpX1kokWDDlSlLIgXefOGmZeOJGC0tFr0ySDYOnPSVzoy8JTZGKaXSh/jhH5zpvX/LO
 BJsZk3tjt7f3J57sdMeigkNcwog6gnWMxkweBKAS8mIq29ee0G92/eU2BRHOfGr8coRDmB7pWb1
 pL3
X-Received: by 2002:a17:90b:1b01:b0:39d:e213:9dd3 with SMTP id
 98e67ed59e1d1-39debf6cf03mr5318944a91.1.1789393130760; 
 Mon, 14 Sep 2026 06:38:50 -0700 (PDT)
Received: from fedora (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d98e5c630sm23241678a91.6.2026.09.14.06.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:38:50 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net/ixgbe: fix leak of filters on flow create
Date: Mon, 14 Sep 2026 21:38:36 +0800
Message-ID: <20260914133836.14644-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

ixgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
RSS filters into hardware before allocating the software flow object.
If that allocation fails, create returns an error but leaves the
hardware filter installed. The application has no handle to destroy it.

Allocate the software copy first, then program the hardware. On a
programming failure, free the copy. Set ENOMEM when allocation fails
so the error path does not report success.

L2 tunnel add failures now return immediately instead of falling
through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
and overwrote the original error.

Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 164 +++++++++++++++------------
 1 file changed, 90 insertions(+), 74 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..e572a1f21a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2858,68 +2858,73 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 			actions, &ntuple_filter, error);
 
 	if (!ret) {
+		ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
+			sizeof(struct ixgbe_ntuple_filter_ele), 0);
+		if (!ntuple_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(&ntuple_filter_ptr->filter_info,
+			&ntuple_filter,
+			sizeof(struct rte_eth_ntuple_filter));
 		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, TRUE);
-		if (!ret) {
-			ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
-				sizeof(struct ixgbe_ntuple_filter_ele), 0);
-			if (!ntuple_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
-			flow->rule = ntuple_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
-			return flow;
+		if (ret) {
+			rte_free(ntuple_filter_ptr);
+			goto out;
 		}
-		goto out;
+		flow->rule = ntuple_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_NTUPLE;
+		return flow;
 	}
 
 	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
 	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
 				actions, &ethertype_filter, error);
 	if (!ret) {
+		ethertype_filter_ptr = rte_zmalloc("ixgbe_ethertype_filter",
+			sizeof(struct ixgbe_ethertype_filter_ele), 0);
+		if (!ethertype_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(&ethertype_filter_ptr->filter_info,
+			&ethertype_filter,
+			sizeof(struct rte_eth_ethertype_filter));
 		ret = ixgbe_add_del_ethertype_filter(adapter,
 				&ethertype_filter, TRUE);
-		if (!ret) {
-			ethertype_filter_ptr = rte_zmalloc(
-				"ixgbe_ethertype_filter",
-				sizeof(struct ixgbe_ethertype_filter_ele), 0);
-			if (!ethertype_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
-			flow->rule = ethertype_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
-			return flow;
+		if (ret) {
+			rte_free(ethertype_filter_ptr);
+			goto out;
 		}
-		goto out;
+		flow->rule = ethertype_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
+		return flow;
 	}
 
 	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
 	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
 				actions, &syn_filter, error);
 	if (!ret) {
+		syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
+			sizeof(struct ixgbe_eth_syn_filter_ele), 0);
+		if (!syn_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+		memcpy(&syn_filter_ptr->filter_info,
+			&syn_filter,
+			sizeof(struct rte_eth_syn_filter));
 		ret = ixgbe_syn_filter_set(adapter, &syn_filter, TRUE);
-		if (!ret) {
-			syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
-				sizeof(struct ixgbe_eth_syn_filter_ele), 0);
-			if (!syn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&syn_filter_ptr->filter_info,
-				&syn_filter,
-				sizeof(struct rte_eth_syn_filter));
-			flow->rule = syn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_SYN;
-			return flow;
+		if (ret) {
+			rte_free(syn_filter_ptr);
+			goto out;
 		}
-		goto out;
+		flow->rule = syn_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_SYN;
+		return flow;
 	}
 
 	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
@@ -2929,17 +2934,21 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 		bool first_mask = false;
 
-		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
-			&first_mask, error);
-		if (ret)
-			goto out;
-
 		fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
 				sizeof(struct ixgbe_fdir_rule_ele), 0);
 		if (!fdir_rule_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
+			&first_mask, error);
+		if (ret) {
+			rte_free(fdir_rule_ptr);
 			goto out;
 		}
+
 		/* update global state */
 		if (first_mask) {
 			fdir_info->mask_added = TRUE;
@@ -2961,41 +2970,48 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
 					actions, &l2_tn_filter, error);
 	if (!ret) {
-		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter, FALSE);
-		if (!ret) {
-			l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
-				sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
-			if (!l2_tn_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			memcpy(&l2_tn_filter_ptr->filter_info,
-				&l2_tn_filter,
-				sizeof(struct ixgbe_l2_tunnel_conf));
-			flow->rule = l2_tn_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
-			return flow;
+		l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
+			sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
+		if (!l2_tn_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
 		}
+		memcpy(&l2_tn_filter_ptr->filter_info,
+			&l2_tn_filter,
+			sizeof(struct ixgbe_l2_tunnel_conf));
+		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter,
+						     FALSE);
+		if (ret) {
+			rte_free(l2_tn_filter_ptr);
+			goto out;
+		}
+		flow->rule = l2_tn_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
+		return flow;
 	}
 
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
 	if (!ret) {
+		rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
+			sizeof(struct ixgbe_rss_conf_ele), 0);
+		if (!rss_filter_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			ret = -ENOMEM;
+			goto out;
+		}
 		ret = ixgbe_config_rss_filter(adapter, &rss_conf, TRUE);
-		if (!ret) {
-			rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
-				sizeof(struct ixgbe_rss_conf_ele), 0);
-			if (!rss_filter_ptr) {
-				PMD_DRV_LOG(ERR, "failed to allocate memory");
-				goto out;
-			}
-			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
-					    &rss_conf.conf);
-			flow->rule = rss_filter_ptr;
-			flow->filter_type = RTE_ETH_FILTER_HASH;
-			return flow;
+		if (ret) {
+			rte_free(rss_filter_ptr);
+			goto out;
 		}
+		ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
+				    &rss_conf.conf);
+		flow->rule = rss_filter_ptr;
+		flow->filter_type = RTE_ETH_FILTER_HASH;
+		return flow;
 	}
 
 out:
-- 
2.55.0

