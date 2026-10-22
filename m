Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C2606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aUZ7vbPa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12466406BC;
	Thu, 22 Oct 2026 18:52:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1DEFF40678
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687936; x=1824223936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=79k7U74S2TYYs8OfTXPkZQfGvP4w0KE8MbfgaNdJ1fE=;
 b=aUZ7vbPa9wWy4rqRbshEuda6qi4503bVt6Nc4luhQrZ6wHjAYqFqHtzM
 mFsa32tkhcgjxWgr7ar3MgWOLK+CdSmhWvIZOtqCuhmN7aX6JPJKkt419
 jAiQwIpHZeI6DNx8FDvrScxS1J0cd6An5OaZF5t9NK94tcy9NHLaqaGGY
 Mg8jupSG7U3xjsaOEUOe5SBpAkpW4rX2U0NG3KmKGJxqXuE1eVFeoaiVg
 R/LGh0mPGPIeFK2kB42Eug5fRtyKtKJ8eT1TyJlxoi3g2GPHdYWybTTIU
 pFaw/tCj/pHp1q+IcRc8tizdnD0YHG8CW2HK5w4Bpi0XdclLvlBZ55VO/ A==;
X-CSE-ConnectionGUID: 1Qy7uitKRnuJb2MItjIvgw==
X-CSE-MsgGUID: D7icMH/CQI610GjFsDDoKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341036"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:15 -0700
X-CSE-ConnectionGUID: BFDoSgOnSM6k+rGR1UjUww==
X-CSE-MsgGUID: V24M5FKoTp+FuPRrdWm0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507831"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:13 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: [PATCH 4/9] net/ice/base: add PQC certificate provisioning capability
Date: Thu, 22 Oct 2026 16:52:00 +0000
Message-ID: <20261022165205.1830735-5-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
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

From: Stefan Wegrzyn <stefan.wegrzyn@intel.com>

Add the PQC certificate provisioning device capability, part of CNSA 2.0
and SPDM 1.4 support, and the Shadow RAM location of the PQC manifest
bank.

Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_adminq_cmd.h | 1 +
 drivers/net/intel/ice/base/ice_common.c     | 5 +++++
 drivers/net/intel/ice/base/ice_type.h       | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_adminq_cmd.h b/drivers/net/intel/ice/base/ice_adminq_cmd.h
index 36656b0aad..7b318b0a1b 100644
--- a/drivers/net/intel/ice/base/ice_adminq_cmd.h
+++ b/drivers/net/intel/ice/base/ice_adminq_cmd.h
@@ -130,6 +130,7 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE		0x0085
 #define ICE_AQC_CAPS_NAC_TOPOLOGY			0x0087
 #define ICE_AQC_CAPS_OROM_RECOVERY_UPDATE		0x0090
+#define ICE_AQC_CAPS_PQC_CERT_PROVISIONING		0x0091
 #define ICE_AQC_CAPS_ROCEV2_LAG				0x0092
 #define ICE_AQC_BIT_ROCEV2_LAG				0x01
 #define ICE_AQC_BIT_SRIOV_LAG				0x02
diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 7d8f677c99..1a8f4e7a6e 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -2635,6 +2635,11 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 		ice_debug(hw, ICE_DBG_INIT, "%s: orom_recovery_update = %d\n",
 			  prefix, caps->orom_recovery_update);
 		break;
+	case ICE_AQC_CAPS_PQC_CERT_PROVISIONING:
+		caps->pqc_cert_provisioning = (number == 1);
+		ice_debug(hw, ICE_DBG_INIT, "%s: pqc_cert_provisioning = %d\n",
+			  prefix, caps->pqc_cert_provisioning);
+		break;
 	case ICE_AQC_CAPS_NEXT_CLUSTER_ID:
 		caps->next_cluster_id_support = (number == 1);
 		ice_debug(hw, ICE_DBG_INIT, "%s: next_cluster_id_support = %d\n",
diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 6d8c187689..83d20358b9 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -756,6 +756,7 @@ struct ice_hw_common_caps {
 	bool tx_sched_topo_comp_mode_en;
 	/* Support for OROM update in Recovery Mode */
 	bool orom_recovery_update;
+	bool pqc_cert_provisioning;
 	bool next_cluster_id_support;
 };
 
@@ -1628,8 +1629,10 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_EMP_SR_SETTINGS_PTR		0x48
 #define ICE_SR_CONFIGURATION_METADATA_PTR	0x4D
 #define ICE_SR_IMMEDIATE_VALUES_PTR		0x4E
-#define ICE_SR_LINK_DEFAULT_OVERRIDE_PTR	0x134
+#define ICE_SR_PQC_MANIFEST_BANK_PTR		0x80
+#define ICE_SR_PQC_MANIFEST_BANK_SIZE		0x81
 #define ICE_SR_POR_REGISTERS_AUTOLOAD_PTR	0x118
+#define ICE_SR_LINK_DEFAULT_OVERRIDE_PTR	0x134
 
 /* CSS Header words */
 #define ICE_NVM_CSS_HDR_LEN_L			0x02
-- 
2.43.0

