Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4483EC54F4C
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC6A940647;
	Tue, 28 Jul 2026 16:38:07 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 09D4D4060C
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:38:07 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so3183944a91.3
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785249486;
 x=1785854286; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfn8AQ8pwIIBZgB5wWHe18CkZzGx5Gmkce0LDMq94B4=;
 b=eS/IrDV4Sawk5CKBlRFALOeKnnBVNk1bg7DJyaSnR//o+1z0H3oaWp8g3VLQ1vYE+E
 AJdRe/yvKyGgPZXnkGYz37gCfbPPfUrWgeMpRFzJnZilWrlPWVr9Ar4iktrh+00Uw2c9
 KGH3tKpYJaM0a/R0EYufHpEow+w9qW9/NlXOoUPSKOPrNGLFwh5SSa1238RKxrKdHRgh
 fiknXN8rIU5tzd5YyZFIh9T69MhxUk6aV0wX+M2qekGr1w3naViWJBI4AWw4yGy5vGW1
 SHWunyBCXyRV47GHmTZoOX7QsIkHFq2vM++3e96PJ3g1LE88To9KqcpfwsB6YT0Wn87c
 BZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249486; x=1785854286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfn8AQ8pwIIBZgB5wWHe18CkZzGx5Gmkce0LDMq94B4=;
 b=L7uwRfSU2il7XeDlIdZ6AbrVNo5+w1cVKBbJhFNIM+gu9V+6nniL/YQ3mY6EtgCfiZ
 rRA/37W1EoF6b99D/SOUAVInAq5S5GatKKGKkrje+vW8M45YhYt8kX9fd9ww0RO8ONpv
 yC6kSV/LUa//iTKF231V2e0dvOSvh63r4iwpCan7xxReAOts/eLz5zsLqPQ7MU0LgSDN
 08KVA/c0+Solopqjc39E9VuX/dFO4KjwIzgEt1jMKAoydOJcRJfid+M640bCVQWVPiAR
 opDrVk3May4sudHiyhlHsQTnqdC+oNMTgJQOo8RB5FRqE1uI17svSOWoq0ax0gSNQ7Ta
 GZ1w==
X-Gm-Message-State: AOJu0YwZaqV9HiVKBJMKFuNuenOiJPxlCVBSrBgAK6k94RTnOdNcYCP/
 F/UJzbSSmJJsnthsWMEBqUH9dOqj7pF6Bl209MqaO7OtPXaiHTggROu1r5oVvBITxhn2bKtE2aT
 ASwuc
X-Gm-Gg: AR+sD12tXp2I6kF61ZqJb+JoTYfx0n9qFYoRlutS9kms2PFhdS8icEA8vuAU0T2UT2H
 TqQMYtTKWd73UW1uv0jTtoiix39BU1wp2qDChRKk/aWjq29DgBTytZcn4eoy4l654WY2PWNl3w+
 9Y5NbyDBdYmXIN7rH/MMz+LLvHdXiCZG0a25ilU/krWEa+iO0x8JRrzlaepp+pOCH5HrVUrvozN
 63N/VBgL5xU/Zhb4xjkpnYEnqjMNpQKqZbQGlbH6t+cPsRbVqr62yOEW5bXZZRRd4zhGXssNsmw
 wGtGOW+5F1PdthJlHa7DC7MBjs3vm3BRYwF1188h3GCZe9GSAMheWBRinZ6D4es9N2cq5Jm33HJ
 +40Uq2VlmVwyAki3kylGEHXpuvx+/qxsDDbzoMPyBtg6qQrFj+cOX8L36D229sNOuprhE4BRgdf
 sMuvFtKkphEA41K/i38uz6AGtXVBADBIIenlf5z0+Q
X-Received: by 2002:a17:90b:3e4b:b0:38f:1dc:672f with SMTP id
 98e67ed59e1d1-38f6a4597bamr2716762a91.18.1785249486136; 
 Tue, 28 Jul 2026 07:38:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc415eafsm46108985eec.7.2026.07.28.07.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:38:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 2/2] net/ixgbe: replace memcpy with structure assignment
Date: Tue, 28 Jul 2026 07:38:00 -0700
Message-ID: <20260728143800.148509-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728143800.148509-1-stephen@networkplumber.org>
References: <20260728143800.148509-1-stephen@networkplumber.org>
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

Where possible use structure assignment instead of memcpy
to preserve type checking. Found by cocci/struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 39 +++++++---------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..7f1241951f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2866,9 +2866,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			memcpy(&ntuple_filter_ptr->filter_info,
-				&ntuple_filter,
-				sizeof(struct rte_eth_ntuple_filter));
+			ntuple_filter_ptr->filter_info = ntuple_filter;
 			flow->rule = ntuple_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
 			return flow;
@@ -2890,9 +2888,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
+			ethertype_filter_ptr->filter_info = ethertype_filter;
 			flow->rule = ethertype_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
 			return flow;
@@ -2912,9 +2908,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			memcpy(&syn_filter_ptr->filter_info,
-				&syn_filter,
-				sizeof(struct rte_eth_syn_filter));
+			syn_filter_ptr->filter_info = syn_filter;
 			flow->rule = syn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_SYN;
 			return flow;
@@ -2949,9 +2943,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		fdir_info->n_flows++;
 		fdir_conf->mode = fdir_rule.mode;
 
-		memcpy(&fdir_rule_ptr->filter_info,
-			&fdir_rule,
-			sizeof(struct ixgbe_fdir_rule));
+		fdir_rule_ptr->filter_info = fdir_rule;
 		flow->rule = fdir_rule_ptr;
 		flow->filter_type = RTE_ETH_FILTER_FDIR;
 		return flow;
@@ -2969,9 +2961,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				goto out;
 			}
-			memcpy(&l2_tn_filter_ptr->filter_info,
-				&l2_tn_filter,
-				sizeof(struct ixgbe_l2_tunnel_conf));
+			l2_tn_filter_ptr->filter_info = l2_tn_filter;
 			flow->rule = l2_tn_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
@@ -3124,9 +3114,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct ixgbe_ntuple_filter_ele *)
 					pmd_flow->rule;
-		memcpy(&ntuple_filter,
-			&ntuple_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ntuple_filter));
+		ntuple_filter = ntuple_filter_ptr->filter_info;
 		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, FALSE);
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
@@ -3134,9 +3122,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct ixgbe_ethertype_filter_ele *)
 					pmd_flow->rule;
-		memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ethertype_filter));
+		ethertype_filter = ethertype_filter_ptr->filter_info;
 		ret = ixgbe_add_del_ethertype_filter(adapter,
 				&ethertype_filter, FALSE);
 		if (!ret)
@@ -3145,18 +3131,14 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct ixgbe_eth_syn_filter_ele *)
 				pmd_flow->rule;
-		memcpy(&syn_filter,
-			&syn_filter_ptr->filter_info,
-			sizeof(struct rte_eth_syn_filter));
+		syn_filter = syn_filter_ptr->filter_info;
 		ret = ixgbe_syn_filter_set(adapter, &syn_filter, FALSE);
 		if (!ret)
 			rte_free(syn_filter_ptr);
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
-		memcpy(&fdir_rule,
-			&fdir_rule_ptr->filter_info,
-			sizeof(struct ixgbe_fdir_rule));
+		fdir_rule = fdir_rule_ptr->filter_info;
 		ret = ixgbe_fdir_filter_program(adapter, fdir_conf, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
 			rte_free(fdir_rule_ptr);
@@ -3171,8 +3153,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_L2_TUNNEL:
 		l2_tn_filter_ptr = (struct ixgbe_eth_l2_tunnel_conf_ele *)
 				pmd_flow->rule;
-		memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
-			sizeof(struct ixgbe_l2_tunnel_conf));
+		l2_tn_filter = l2_tn_filter_ptr->filter_info;
 		ret = ixgbe_dev_l2_tunnel_filter_del(adapter, &l2_tn_filter);
 		if (!ret)
 			rte_free(l2_tn_filter_ptr);
-- 
2.53.0

