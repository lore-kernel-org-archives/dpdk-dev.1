Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7741FFCA18E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:19:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D6E4066E;
	Mon,  9 Mar 2026 22:19:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6BDE640269
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091155; x=1804627155;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OVSfF5OLkzswplguiJLnptE9Aan2F7T1c5AnKdhndDg=;
 b=ho0EJ48ookqYAbAlot0G0JunMHQYKtiptcfrq1fq1+MMVJakyxH2DQcU
 XQYyrfqPiM0k0Xo69+isn9owWbe9RXZd42jSthPYkv9rV2Ym6OBQDUW7Y
 N6FrXAYZ8RCsHxo4Ua51m/rs3OpAQlZn+3VLi0VO7UiE1nYMWEC+rfdFz
 dBFs5C06f8nvT3z8hhVmU7SoitaOkKy1+ENXgYeOY3ACkwGHj1YbjBVuX
 PsXr+O75HCyG7zFUm12WKtxbEj2pW0xpe7vFR8JSLpk2jLyPFwqH2NCzF
 L2Y2si7mSxCm8cWWFt2fBhC/knWJcTtZ3namr6aGQyvI5JZrDQZvzGCCC A==;
X-CSE-ConnectionGUID: mVTSJ0kPRS6Gb6dE//K76w==
X-CSE-MsgGUID: sxgXv9xBSc+b+M4a8hHgfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74241019"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74241019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:19:14 -0700
X-CSE-ConnectionGUID: IcOOvXmJQu+btnswRrMAOw==
X-CSE-MsgGUID: fpHiKnCISjOLkRvvE5V/Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219016091"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:19:12 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v1 3/6] net/ice/base: enable LLDP filter control for E830
Date: Tue, 10 Mar 2026 05:52:13 -0400
Message-ID: <20260310095218.703423-11-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The ice_fw_supports_lldp_fltr_ctrl() function previously restricted the
LLDP filter control API (admin queue command 0x0A0A) to E810 devices
only. This limitation prevented newer hardware like E830 from using the
more efficient LLDP packet filtering method, even when firmware support
was available.

Remove the hardware type restriction and implement hardware-specific
firmware API version checks to determine LLDP filter control support.
E810 and E82x cards require firmware API version >= 1.7.1, while E830
cards require firmware API version >= 1.7.11. This enables E830 and
future hardware to utilize the improved filtering mechanism when
supported by firmware.

Additionally, add fallback logic in ice_cfg_sw_lldp() to automatically
fall back to the legacy ethernet filter method if the new LLDP filter
control API fails. This provides resilience against buggy firmware that
may report API support but fail during actual command execution.

The try-fallback pattern ensures LLDP configuration succeeds regardless
of firmware quirks, improving driver robustness across hardware
generations and firmware versions.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 20 ++++++++++++++------
 drivers/net/intel/ice/base/ice_type.h   |  7 ++++++-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 72f84d49cd..7d8f677c99 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -6561,15 +6561,23 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 /**
  * ice_fw_supports_lldp_fltr_ctrl - check NVM version supports lldp_fltr_ctrl
  * @hw: pointer to HW struct
+ *
+ * Check if firmware supports the LLDP filter control feature (AQ command 0x0A0A).
+ * Different hardware families require different minimum firmware versions:
+ * - E810 and E82x cards require API version 1.7.1 or later
+ * - E830 cards require API version 1.7.11 or later
  */
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 {
-	if (hw->mac_type != ICE_MAC_E810 && hw->mac_type != ICE_MAC_GENERIC)
-		return false;
-
-	return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
-				     ICE_FW_API_LLDP_FLTR_MIN,
-				     ICE_FW_API_LLDP_FLTR_PATCH);
+	if (hw->mac_type == ICE_MAC_E830)
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ_E830,
+					     ICE_FW_API_LLDP_FLTR_MIN_E830,
+					     ICE_FW_API_LLDP_FLTR_PATCH_E830);
+	if (hw->mac_type == ICE_MAC_E810 || hw->mac_type == ICE_MAC_GENERIC)
+		return ice_is_fw_api_min_ver(hw, ICE_FW_API_LLDP_FLTR_MAJ,
+					     ICE_FW_API_LLDP_FLTR_MIN,
+					     ICE_FW_API_LLDP_FLTR_PATCH);
+	return false;
 }
 
 /**
diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 4b05a800af..6d8c187689 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -1718,11 +1718,16 @@ struct ice_aq_get_set_rss_lut_params {
 #define GLPCI_LBARCTRL_VF_PE_DB_SIZE_8KB 0x1
 #define GLPCI_LBARCTRL_VF_PE_DB_SIZE_64KB 0x2
 
-/* AQ API version for LLDP_FILTER_CONTROL */
+/* AQ API version for LLDP_FILTER_CONTROL - E810 and E82x */
 #define ICE_FW_API_LLDP_FLTR_MAJ	1
 #define ICE_FW_API_LLDP_FLTR_MIN	7
 #define ICE_FW_API_LLDP_FLTR_PATCH	1
 
+/* AQ API version for LLDP_FILTER_CONTROL - E830 */
+#define ICE_FW_API_LLDP_FLTR_MAJ_E830	1
+#define ICE_FW_API_LLDP_FLTR_MIN_E830	7
+#define ICE_FW_API_LLDP_FLTR_PATCH_E830	11
+
 /* AQ API version for report default configuration */
 #define ICE_FW_API_REPORT_DFLT_CFG_MAJ		1
 #define ICE_FW_API_REPORT_DFLT_CFG_MIN		7
-- 
2.47.1

