Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3887606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRUt3WrG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3F5E40698;
	Thu, 22 Oct 2026 18:52:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0CB0540698
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687937; x=1824223937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RW8heQhpBsOVkOgYW0vX5GUYk0oxDHrZ1RR71pyHIeg=;
 b=GRUt3WrG6XSkSKj//LlAiH4m+ElPrlpDhgkF3DZupI5+6yeiV7WzXiZG
 nYHBU2SAdwbBpSRvVD0BIRZkJWBzlRokO2p3B2FjdJ5LviYFmJ1bwGXwk
 4SLaNx4AaU/q+XKRPpOF1YIbXoO2Q/X6yHcX/HGAzDzuqtEP1ShyE3ji7
 gx0N9gm5028GJHFFyiUM5+wy1x/RQq9OtIALobCPaq4IM2nUwxj9gUGSX
 VLVi+I2KcY2w7A5z9f8qIl5LYV5M3RsPUyc93Z/XbLP6cuRZcaPJqeP8B
 8RwKQ5u3H3hktwVfK4pFTxb5JxE55a157zEJfqrjKOLWqQ3/McEAUWuJG w==;
X-CSE-ConnectionGUID: rT9Y+kqdSA6uw8HPQx5WNA==
X-CSE-MsgGUID: msMq94RQSZmbsK0kYUQt0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341038"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341038"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:16 -0700
X-CSE-ConnectionGUID: ieW5oo/YS2OFQ6MwJJ3o5A==
X-CSE-MsgGUID: 1n0BwiKKSZWz0oIsqz++9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507838"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:14 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Chinh Cao <chinh.t.cao@intel.com>
Subject: [PATCH 5/9] net/ice/base: add NVM definitions for Wake-on-LAN config
Date: Thu, 22 Oct 2026 16:52:01 +0000
Message-ID: <20261022165205.1830735-6-vladimir.medvedkin@intel.com>
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

From: Chinh Cao <chinh.t.cao@intel.com>

Add NVM definitions for reading the per-PF Wake-on-LAN configuration.

Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 83d20358b9..28d0387608 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -1585,6 +1585,13 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_PBA_BLOCK_PTR			0x16
 #define ICE_SR_BOOT_CFG_PTR			0x132
 #define ICE_SR_NVM_WOL_CFG			0x19
+/* WoL Feature Config - PFA TLV types, one per PF.
+ * TLV IDs: 0x000E for PF0, 0x010E for PF1, ..., 0x070E for PF7.
+ * Read via ice_get_pfa_module_tlv() + ice_read_sr_word().
+ */
+#define ICE_WOL_FEATURE_DISABLE			0x01
+#define ICE_WOL_FEATURE_ENABLE			0x02
+#define ICE_WOL_FEATURE(pf)			(0x0E + (pf) * 0x100)
 #define ICE_NVM_OROM_VER_OFF			0x02
 #define ICE_SR_NVM_DEV_STARTER_VER		0x18
 #define ICE_SR_ALTERNATE_SAN_MAC_ADDR_PTR	0x27
@@ -1633,6 +1640,8 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_PQC_MANIFEST_BANK_SIZE		0x81
 #define ICE_SR_POR_REGISTERS_AUTOLOAD_PTR	0x118
 #define ICE_SR_LINK_DEFAULT_OVERRIDE_PTR	0x134
+#define ICE_SR_HII_PORT_DISABLE_BY_FUNC_PTR	0x139
+#define ICE_SR_HII_PORT_DISABLE_RDE_WOL_OVRD	BIT(8)
 
 /* CSS Header words */
 #define ICE_NVM_CSS_HDR_LEN_L			0x02
-- 
2.43.0

