Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DD6C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9936440684;
	Sat,  8 Feb 2025 21:32:23 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id DE35A406FF
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:19 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so28184235ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046739;
 x=1739651539; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBW5jXPgtEd8AFHB6Vd2JVa+/kle53aIkTQEqhQjZPo=;
 b=SB/6VoA+x1FBu7FSoaIG3wIOGMnOuAAgx4iRTNyahiYrey8jzAcMobFp2GWV1c1g3b
 VSn/KC4y2wI0tfNDQXblClEZUMhLKCGKqkN0sn2pGgQ35p++oNVlJv+1petG9j0zVxic
 Tl//1+80IqyE4g/m5K9vvPIUdPcsY1YhvtKK8cMiSAhNPqSaXBbqe8G4ohZgJAEaFJch
 t//YSemwPAeNHertwLzQnOP8eo8yiX2XtzeqTv7j6Zpo1LbY/7KskCFdA08EoEgHKElu
 EtYEm175IDXc4iV5nLmhy6f3tWnUhkORGcosJHchl/cWFnS6ihGR2qyL6Ze5/D/1tbW/
 m/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046739; x=1739651539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBW5jXPgtEd8AFHB6Vd2JVa+/kle53aIkTQEqhQjZPo=;
 b=WrHYdowpXKB1z6fn6N2fhnRpnNidsyVs+pz+Pzdv5HkrDYFFIXasreyTPo84JrlBJS
 12PHqjp2FYdWiYaCYH3fYkmmtYA2ndwYH08lovObvNP44o3p52IHYXEeALnpvIfK8SJm
 7t/8lJeKlBXn5Im9+5mtkVBlXyIZh2pt7R4Mgy8/gGj4jE184O1OWaUxhTcsMoEXtTlo
 s6j+46pdOOfiw6fgo/qnYwlZheMnqwKWW3mJeHkVEt7NhW0PqKBFFcvUzQxQyA+YxUvi
 OEP9qqEm7VjbUn1uRn9RiHiGk5wYfjUS11/DM88lJHxLjQ9efaTMFU0dAj6WT/D82kEK
 ayBg==
X-Gm-Message-State: AOJu0YzbmUq5jTp8QJKHRblNiCQarVg9EVrgZhWZ6pHFKveqp6QIVMsi
 7+7EbpFvSi99//dQbyfp1cwpH8Y5N/Qbno/PZlkK/Uzr61vM1ju7WJPu9nHh1HRLciOPz744edv
 lVlw=
X-Gm-Gg: ASbGncuxSGGko5kubD+kuwsAPW+RUaEVbe5xtnEj6GaN1Wha72yB8fFoze0qJIgSYPq
 2PC9uY04hLye15lSfFP7OerkG6EFo6MgrDsheauYjNA0TkXeYIO/rBZ+85PcnFDJ2AMZ/PAoNAI
 ujEPLbTtQFSbO4wGqT3f1cbCLmj1zA5i+1IyeKN6N62uBjZHnp4c6B/3bUJ134TxBpQwQynQN5C
 CQsMKZ4cASlpNeJjN5bOQ4xSH7ex/1K8yr1R0G9+TwcxwUCrRLNrWp5qV1C1f6rGKYNvo/8FhJL
 BHN+L7l+Pd/1yLVI2lehvJTVytwWA0mxd8MSjFgCw1GSUC8ZiZXM2Jjat4utV5D+ZX91
X-Google-Smtp-Source: AGHT+IF6BtGu9yXMrrMRNnWL5t81S2/9pnO99q6Q58NhpFF9M8Q7azZ5cknbem+m5IT8X4Sx1anCUw==
X-Received: by 2002:a05:6300:710c:b0:1ee:1be1:79d6 with SMTP id
 adf61e73a8af0-1ee1be17b1bmr3201080637.41.1739046739153; 
 Sat, 08 Feb 2025 12:32:19 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 21/32] net/intel/i40e: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:13 -0800
Message-ID: <20250208203142.242284-22-stephen@networkplumber.org>
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
 drivers/net/intel/i40e/i40e_ethdev.c  | 6 ++----
 drivers/net/intel/i40e/i40e_fdir.c    | 3 +--
 drivers/net/intel/i40e/i40e_flow.c    | 3 +--
 drivers/net/intel/i40e/rte_pmd_i40e.c | 3 +--
 drivers/net/intel/ixgbe/ixgbe_flow.c  | 4 +---
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index bf5560ccc8..8a7afd6dbe 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -5987,8 +5987,7 @@ i40e_vsi_setup(struct i40e_pf *pf,
 			PMD_DRV_LOG(ERR, "Failed to get VSI params");
 			goto fail_msix_alloc;
 		}
-		rte_memcpy(&vsi->info, &ctxt.info,
-			sizeof(struct i40e_aqc_vsi_properties_data));
+		vsi->info = ctxt.info;
 		vsi->vsi_id = ctxt.vsi_number;
 		vsi->info.valid_sections = 0;
 
@@ -6005,8 +6004,7 @@ i40e_vsi_setup(struct i40e_pf *pf,
 			rte_cpu_to_le_16(I40E_AQ_VSI_PROP_VLAN_VALID);
 		vsi->info.port_vlan_flags = I40E_AQ_VSI_PVLAN_MODE_ALL |
 					I40E_AQ_VSI_PVLAN_EMOD_STR_BOTH;
-		rte_memcpy(&ctxt.info, &vsi->info,
-			sizeof(struct i40e_aqc_vsi_properties_data));
+		ctxt.info = vsi->info;
 		ret = i40e_vsi_config_tc_queue_mapping(vsi, &ctxt.info,
 						I40E_DEFAULT_TCMAP);
 		if (ret != I40E_SUCCESS) {
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 349627a2ed..3d0ba25cba 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1252,8 +1252,7 @@ i40e_flow_store_flex_mask(struct i40e_pf *pf,
 			  sizeof(struct i40e_fdir_flex_mask))))
 		return 1;
 
-	memcpy(&pf->fdir.flex_mask[pctype], &flex_mask,
-	       sizeof(struct i40e_fdir_flex_mask));
+	pf->fdir.flex_mask[pctype] = flex_mask;
 	return 0;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index cd598431e1..f130f53ae0 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2364,8 +2364,7 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 			next_dst_off += raw_spec->length;
 			raw_id++;
 
-			memcpy(&filter->input.flow_ext.flex_pit[field_idx],
-			       &flex_pit, sizeof(struct i40e_fdir_flex_pit));
+			filter->input.flow_ext.flex_pit[field_idx] = flex_pit;
 			filter->input.flow_ext.layer_idx = layer_idx;
 			filter->input.flow_ext.raw_id = raw_id;
 			filter->input.flow_ext.is_flex_flow = true;
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 9d39984ea1..e620731199 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -2961,8 +2961,7 @@ i40e_queue_region_get_all_info(struct i40e_pf *pf,
 {
 	struct i40e_queue_regions *info = &pf->queue_region;
 
-	rte_memcpy(regions_ptr, info,
-			sizeof(struct i40e_queue_regions));
+	*regions_ptr = *info;
 
 	return 0;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 33da2f47ec..be8f3072fb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3142,9 +3142,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
 				/* It's the first time the mask is set. */
-				rte_memcpy(&fdir_info->mask,
-					&fdir_rule.mask,
-					sizeof(struct ixgbe_hw_fdir_mask));
+				*&fdir_info->mask = *&fdir_rule.mask;
 
 				if (fdir_rule.mask.flex_bytes_mask) {
 					ret = ixgbe_fdir_set_flexbytes_offset(dev,
-- 
2.47.2

