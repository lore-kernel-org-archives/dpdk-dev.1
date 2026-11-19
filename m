Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1697606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gXY73GW9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A796402EB;
	Thu, 19 Nov 2026 08:32:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTPS id CDC54402DA;
 Thu, 19 Nov 2026 08:31:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795073518; x=1826609518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H/9eyzWpptoirDx/+q7JUasTPD3Hir/ChmDQzFhlR9k=;
 b=gXY73GW9X2Y6Hv4miud7Ujbc54niWSzdvIeILBTfqjdbu/NSm53jEDi6
 kP1hS9fH94g2IlIWA8yG9hKoSz9t03xIuqv2YpnrSl9QZktZYZMTCUk7b
 2jY6VLubB/2HwXOk4jAEQ7Bmc1t72Ew0gA0CaYhtO5RADlJ8EIrkaRDXk
 QAO/s8hVwBPpUwRTAgf/cIoTzqZAD/8DlIE6g+s8Uhsv9a4ICAVJO+UxX
 WpIAm9fcMCwvvyu2DnewRP37xDDlnvSp1gW7XDwYCwoZjdwqztkNWe2hw
 spLItnxLle6mpiGpePEYW5GD30VTtFotFsQWSaPAvJtZSiHIVQKNxYoQ3 Q==;
X-CSE-ConnectionGUID: rFHb/8aoQFa4TYBKAJMVOA==
X-CSE-MsgGUID: biMho03ORTKPB49c0uTcSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3832030"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3832030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 23:31:57 -0800
X-CSE-ConnectionGUID: hrG2Lb2DSLWZXTt/i6wdqA==
X-CSE-MsgGUID: +93DaxwgTXCsI5Lhe/uR0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10356343"
Received: from unknown (HELO srv14..) ([10.190.212.243])
 by orviesa006.jf.intel.com with ESMTP; 18 Nov 2026 23:31:56 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 1/2] net/cpfl: fix function type on MMG device
Date: Thu, 19 Nov 2026 13:01:46 +0530
Message-ID: <20261119073147.71820-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119073147.71820-1-soumyadeep.hore@intel.com>
References: <20261119073147.71820-1-soumyadeep.hore@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MMG control plane encodes the LAN PF and VF function types as
0 and 2, the reverse of the MEV values. The driver always used the
MEV values, so the vport map lookup in cpfl_get_vsi_id() missed on
MMG and flow rules failed with "vport id not exist".

Select the PF and VF function type based on the device ID.

Also use the PF function type and clear vf_id when adding a PF
representor vport to the vport map, so the hash key is fully
initialized and matches the other lookups.

Fixes: 06c585cb0dee ("net/cpfl: add MMG device ID")
Fixes: 7b9395cb7dfe ("net/cpfl: update CP channel API")
Cc: stable@dpdk.org
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.h      | 17 ++++++++++++++-
 drivers/net/intel/cpfl/cpfl_representor.c | 26 ++++++++++++-----------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 49a0979f2c..791b8b584f 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -334,6 +334,21 @@ cpfl_get_port_id(struct cpfl_itf *itf)
 	return CPFL_INVALID_HW_ID;
 }
 
+/* MMG control plane swaps the PF and VF function type values */
+static inline uint8_t
+cpfl_func_type_pf(const struct cpfl_adapter_ext *adapter)
+{
+	return adapter->base.hw.device_id == CPFL_DEV_ID_MMG ?
+		CPCHNL2_FTYPE_LAN_VF : CPCHNL2_FTYPE_LAN_PF;
+}
+
+static inline uint8_t
+cpfl_func_type_vf(const struct cpfl_adapter_ext *adapter)
+{
+	return adapter->base.hw.device_id == CPFL_DEV_ID_MMG ?
+		CPCHNL2_FTYPE_LAN_PF : CPCHNL2_FTYPE_LAN_VF;
+}
+
 static inline uint16_t
 cpfl_get_vsi_id(struct cpfl_itf *itf)
 {
@@ -354,7 +369,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 		if (!idpf_is_vf_device(&itf->adapter->base.hw)) {
 			vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
 
-			vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
+			vport_identity.func_type = cpfl_func_type_pf(itf->adapter);
 			/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
 			vport_identity.pf_id = (itf->adapter->host_id == CPFL_HOST_ID_ACC) ?
 							CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
diff --git a/drivers/net/intel/cpfl/cpfl_representor.c b/drivers/net/intel/cpfl/cpfl_representor.c
index bb28c0b989..4bb4d9e418 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.c
+++ b/drivers/net/intel/cpfl/cpfl_representor.c
@@ -349,12 +349,12 @@ cpfl_repr_link_update(struct rte_eth_dev *ethdev,
 	if (wait_to_complete) {
 		if (repr->repr_id.type == RTE_ETH_REPRESENTOR_PF) {
 			/* PF */
-			vi.func_type = CPCHNL2_FTYPE_LAN_PF;
+			vi.func_type = cpfl_func_type_pf(adapter);
 			vi.pf_id = cpfl_func_id_get(repr->repr_id.host_id, repr->repr_id.pf_id);
 			vi.vf_id = 0;
 		} else {
 			/* VF */
-			vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+			vi.func_type = cpfl_func_type_vf(adapter);
 			vi.pf_id = CPFL_HOST0_APF;
 			vi.vf_id = repr->repr_id.vf_id;
 		}
@@ -450,20 +450,21 @@ cpfl_repr_init(struct rte_eth_dev *eth_dev, void *init_param)
 }
 
 static bool
-cpfl_match_repr_with_vport(const struct cpfl_repr_id *repr_id,
+cpfl_match_repr_with_vport(const struct cpfl_adapter_ext *adapter,
+			   const struct cpfl_repr_id *repr_id,
 			   struct cpchnl2_vport_info *info)
 {
 	int func_id;
 
 	if (repr_id->type == RTE_ETH_REPRESENTOR_PF &&
-	    info->func_type == CPCHNL2_FTYPE_LAN_PF) {
+	    info->func_type == cpfl_func_type_pf(adapter)) {
 		func_id = cpfl_func_id_get(repr_id->host_id, repr_id->pf_id);
 		if (func_id < 0 || func_id != info->pf_id)
 			return false;
 		else
 			return true;
 	} else if (repr_id->type == RTE_ETH_REPRESENTOR_VF &&
-		   info->func_type == CPCHNL2_FTYPE_LAN_VF) {
+		   info->func_type == cpfl_func_type_vf(adapter)) {
 		if (repr_id->vf_id == info->vf_id)
 			return true;
 	}
@@ -481,12 +482,12 @@ cpfl_repr_vport_list_query(struct cpfl_adapter_ext *adapter,
 
 	if (repr_id->type == RTE_ETH_REPRESENTOR_PF) {
 		/* PF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_PF;
+		vi.func_type = cpfl_func_type_pf(adapter);
 		vi.pf_id = cpfl_func_id_get(repr_id->host_id, repr_id->pf_id);
 		vi.vf_id = 0;
 	} else {
 		/* VF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+		vi.func_type = cpfl_func_type_vf(adapter);
 		vi.pf_id = CPFL_HOST0_APF;
 		vi.vf_id = repr_id->vf_id;
 	}
@@ -507,12 +508,12 @@ cpfl_repr_vport_info_query(struct cpfl_adapter_ext *adapter,
 
 	if (repr_id->type == RTE_ETH_REPRESENTOR_PF) {
 		/* PF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_PF;
+		vi.func_type = cpfl_func_type_pf(adapter);
 		vi.pf_id = cpfl_func_id_get(repr_id->host_id, repr_id->pf_id);
 		vi.vf_id = 0;
 	} else {
 		/* VF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+		vi.func_type = cpfl_func_type_vf(adapter);
 		vi.pf_id = CPFL_HOST0_APF;
 		vi.vf_id = repr_id->vf_id;
 	}
@@ -533,11 +534,12 @@ cpfl_repr_vport_map_update(struct cpfl_adapter_ext *adapter,
 	vi.vport_id = vport_id;
 	if (repr_id->type == RTE_ETH_REPRESENTOR_PF) {
 		/* PF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+		vi.func_type = cpfl_func_type_pf(adapter);
 		vi.pf_id = cpfl_func_id_get(repr_id->host_id, repr_id->pf_id);
+		vi.vf_id = 0;
 	} else {
 		/* VF */
-		vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+		vi.func_type = cpfl_func_type_vf(adapter);
 		vi.pf_id = CPFL_HOST0_APF;
 		vi.vf_id = repr_id->vf_id;
 	}
@@ -632,7 +634,7 @@ cpfl_repr_create(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapte
 					(const void **)&vp_id, (void **)&vi, &iter_iter) >= 0) {
 			struct cpfl_repr_param param;
 
-			if (!cpfl_match_repr_with_vport(repr_id, &vi->vport.info))
+			if (!cpfl_match_repr_with_vport(adapter, repr_id, &vi->vport.info))
 				continue;
 
 			param.adapter = adapter;
-- 
2.43.0

