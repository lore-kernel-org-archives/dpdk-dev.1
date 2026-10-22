Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE529606A330
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DIssMmGo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C657406B4;
	Thu, 22 Oct 2026 18:52:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E98614067C;
 Thu, 22 Oct 2026 18:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687935; x=1824223935;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WoljWXvBVI6vCQ+EYyebB22O5/dClZvs5144QTU4hLw=;
 b=DIssMmGomqW5gKCjZMDD61lqq7Lcset7L9v6TgBD7HD0tKuw2vjOXXC6
 CWr+JZWebtp1E96freHw9ly7Yd5upiU4Ym37azc7E/trStqmDTnKuW+rC
 dSw1HlnOwOZjZBjbx5nfYqoqw1gZkD+BBX/Dqn9l/uK5WjHThHJuv9h2F
 sl6aMCrt44k9iwlpeRSXOfGL0cG1yX6l4M24C4cnvmgvSvO5MPdstcZR5
 rWv7PBAc9I7Yd5d7Ls4cCO6ailip35xc0WeV5G7vdKflC6RWwnluW8osr
 0iy+N6FkW3QAju26sOw3OAo5XVwWglvBhZV3j01pjrTMBAaQHvJ20BxZj g==;
X-CSE-ConnectionGUID: uJCfqdMYRza5l+kWNJFjzQ==
X-CSE-MsgGUID: 2pJQUftISX6Kgz6AqSotLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341032"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341032"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:14 -0700
X-CSE-ConnectionGUID: uCS6l1xfQ5Kco3KThJjf9w==
X-CSE-MsgGUID: hiH5PvVnTGy8nwQTPbmLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507823"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:12 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Janardhanan Arumugam <janardhanan.arumugam@intel.com>, stable@dpdk.org
Subject: [PATCH 3/9] net/ice/base: fix out-of-bounds accesses in DDP and NVM
 code
Date: Thu, 22 Oct 2026 16:51:59 +0000
Message-ID: <20261022165205.1830735-4-vladimir.medvedkin@intel.com>
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

From: Janardhanan Arumugam <janardhanan.arumugam@intel.com>

The following bounds checks are missing or can overflow:
- segment offset and size checks in DDP package verification
  can wrap around
- buffer range check of a signed DDP segment can wrap around
- package count reported by firmware is not limited to the size
  of the response buffer
- NVM access functions zero more than the size of the output buffer

Fixes: 51d04e4933e3 ("net/ice/base: add flexible pipeline module")
Fixes: f035feb47458 ("net/ice/base: support NVM access commands")
Fixes: c4afa96e4de1 ("net/ice/base: check DDP package compatibility")
Fixes: ed3066a3b1b0 ("net/ice/base: refactor DDP code")
Cc: stable@dpdk.org

Signed-off-by: Janardhanan Arumugam <janardhanan.arumugam@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_ddp.c | 19 ++++++++++++-------
 drivers/net/intel/ice/base/ice_nvm.c |  4 ++--
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/ice/base/ice_ddp.c
index ae80d93656..072d1beb83 100644
--- a/drivers/net/intel/ice/base/ice_ddp.c
+++ b/drivers/net/intel/ice/base/ice_ddp.c
@@ -519,7 +519,7 @@ ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 	bufs = ice_find_buf_table(seg);
 	buf_count = LE32_TO_CPU(bufs->buf_count);
 
-	if (start >= buf_count || start + count > buf_count)
+	if (start >= buf_count || count > buf_count - start)
 		return ICE_DDP_PKG_ERR;
 
 	state = ice_dwnld_cfg_bufs_no_lock(hw, bufs->buf_array, start, count,
@@ -843,6 +843,7 @@ enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 	struct ice_aqc_get_pkg_info_resp *pkg_info;
 	u16 size;
 	u32 i;
+	u32 pkg_count;
 
 	size = ice_struct_size(pkg_info, pkg_info, ICE_PKG_CNT);
 	pkg_info = (struct ice_aqc_get_pkg_info_resp *)ice_malloc(hw, size);
@@ -854,7 +855,8 @@ enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 		goto init_pkg_free_alloc;
 	}
 
-	for (i = 0; i < LE32_TO_CPU(pkg_info->count); i++) {
+	pkg_count = min(LE32_TO_CPU(pkg_info->count), (u32)ICE_PKG_CNT);
+	for (i = 0; i < pkg_count; i++) {
 #define ICE_PKG_FLAG_COUNT	4
 		char flags[ICE_PKG_FLAG_COUNT + 1] = { 0 };
 		u8 place = 0;
@@ -966,6 +968,7 @@ ice_enum_labels(struct ice_seg *ice_seg, u32 type, struct ice_pkg_enum *state,
 enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
 {
 	u32 seg_count;
+	u32 off;
 	u32 i;
 
 	if (len < ice_struct_size(pkg, seg_offset, 1))
@@ -988,17 +991,18 @@ enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
 
 	/* all segments must fit within length */
 	for (i = 0; i < seg_count; i++) {
-		u32 off = LE32_TO_CPU(pkg->seg_offset[i]);
 		struct ice_generic_seg_hdr *seg;
 
+		off = LE32_TO_CPU(pkg->seg_offset[i]);
+
 		/* segment header must fit */
-		if (len < off + sizeof(*seg))
+		if (len < off || len - off < sizeof(*seg))
 			return ICE_DDP_PKG_INVALID_FILE;
 
 		seg = (struct ice_generic_seg_hdr *)((u8 *)pkg + off);
 
 		/* segment body must fit */
-		if (len < off + LE32_TO_CPU(seg->seg_size))
+		if (len < off || len - off < LE32_TO_CPU(seg->seg_size))
 			return ICE_DDP_PKG_INVALID_FILE;
 	}
 
@@ -1059,7 +1063,7 @@ ice_chk_pkg_compat(struct ice_hw *hw, struct ice_pkg_hdr *ospkg,
 	struct ice_aqc_get_pkg_info_resp *pkg;
 	enum ice_ddp_state state;
 	u16 size;
-	u32 i;
+	u32 i, pkg_count;
 
 	/* Check package version compatibility */
 	state = ice_chk_pkg_version(&hw->pkg_ver);
@@ -1087,7 +1091,8 @@ ice_chk_pkg_compat(struct ice_hw *hw, struct ice_pkg_hdr *ospkg,
 		goto fw_ddp_compat_free_alloc;
 	}
 
-	for (i = 0; i < LE32_TO_CPU(pkg->count); i++) {
+	pkg_count = min(LE32_TO_CPU(pkg->count), (u32)ICE_PKG_CNT);
+	for (i = 0; i < pkg_count; i++) {
 		/* loop till we find the NVM package */
 		if (!pkg->pkg_info[i].is_in_nvm)
 			continue;
diff --git a/drivers/net/intel/ice/base/ice_nvm.c b/drivers/net/intel/ice/base/ice_nvm.c
index 56c6c96a95..19aa150541 100644
--- a/drivers/net/intel/ice/base/ice_nvm.c
+++ b/drivers/net/intel/ice/base/ice_nvm.c
@@ -1227,7 +1227,7 @@ ice_nvm_access_get_features(struct ice_nvm_access_cmd *cmd,
 		return ICE_ERR_NO_MEMORY;
 
 	/* Initialize the data buffer to zeros */
-	ice_memset(data, 0, cmd->data_size, ICE_NONDMA_MEM);
+	ice_memset(data, 0, sizeof(union ice_nvm_access_data), ICE_NONDMA_MEM);
 
 	/* Fill in the features data */
 	data->drv_features.major = ICE_NVM_ACCESS_MAJOR_VER;
@@ -1342,7 +1342,7 @@ ice_nvm_access_read(struct ice_hw *hw, struct ice_nvm_access_cmd *cmd,
 	ice_debug(hw, ICE_DBG_TRACE, "%s\n", __func__);
 
 	/* Always initialize the output data, even on failure */
-	ice_memset(data, 0, cmd->data_size, ICE_NONDMA_MEM);
+	ice_memset(data, 0, sizeof(union ice_nvm_access_data), ICE_NONDMA_MEM);
 
 	/* Make sure this is a valid read/write access request */
 	status = ice_validate_nvm_rw_reg(cmd);
-- 
2.43.0

