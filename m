Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9056CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C567B40B97;
	Wed, 20 May 2026 14:53:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6E43940A84;
 Wed, 20 May 2026 14:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281602; x=1810817602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0xc0O2vrqZckwO0dN2eRr+OiMjmq4VoqCy+8dS0fsc=;
 b=NZLdpWgHXUZqPs2igZelkh8r+iAkOar58p8DKZwxS4y8+u/0qk1mr9qz
 0EJ41UaQROKdXUdsV2KARnYt/N9J5+qDE7r+xDMM+F0Z/LQfoNWoPfpdP
 pm12zShMnHLi8hIhCnnPd883PW/hx8V5evULvJz7QUo0fqD6dEKruptn+
 YRhWa/0WssHLXG+TjRY5lMzypZ8JVRRt3xp4hNeri/RVcY2ncYQUVfJXp
 nl9ykw7sNu9wY19VCmzTliY5lCQBwjdtdZRYs4d1WVS6qzVuVQ8xQ6XIb
 uoV5MZpAUiEBQHNGM2II1odlyhKE2wX8o6j2/Nll7riq9hq/CKPUGE1EO g==;
X-CSE-ConnectionGUID: 4TeUd4QwQbCpxSgPbn+R2g==
X-CSE-MsgGUID: oVHBH2bZSmO2E0vwq4ftOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570282"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570282"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:22 -0700
X-CSE-ConnectionGUID: +iNddC5uRsOzLEsKAQWRZg==
X-CSE-MsgGUID: bVWcLmvPSxOtcgElfZltLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908298"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:20 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Menachem Fogel <menachem.fogel@intel.com>, stable@dpdk.org,
 Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 07/10] net/e1000/base: fix NVM loop bounds and pointer access
Date: Wed, 20 May 2026 12:52:44 +0000
Message-ID: <20260520125256.354336-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Menachem Fogel <menachem.fogel@intel.com>

Improve the NVM checksum routines by ensuring loop bounds are compared
at the correct integer width. Use array indexing instead of explicit
pointer arithmetic.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Menachem Fogel <menachem.fogel@intel.com>
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_82575.c  | 4 ++--
 drivers/net/intel/e1000/base/e1000_manage.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index c263f42ca1..8ae2b77d5f 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -2395,7 +2395,7 @@ s32 e1000_validate_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 
 	DEBUGFUNC("e1000_validate_nvm_checksum_with_offset");
 
-	for (i = offset; i < ((NVM_CHECKSUM_REG + offset) + 1); i++) {
+	for (i = offset; i < (u16)((NVM_CHECKSUM_REG + offset) + 1); i++) {
 		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
 		if (ret_val) {
 			DEBUGOUT("NVM Read Error\n");
@@ -2432,7 +2432,7 @@ s32 e1000_update_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 
 	DEBUGFUNC("e1000_update_nvm_checksum_with_offset");
 
-	for (i = offset; i < (NVM_CHECKSUM_REG + offset); i++) {
+	for (i = offset; i < (u16)(NVM_CHECKSUM_REG + offset); i++) {
 		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
 		if (ret_val) {
 			DEBUGOUT("NVM Read Error while updating checksum.\n");
diff --git a/drivers/net/intel/e1000/base/e1000_manage.c b/drivers/net/intel/e1000/base/e1000_manage.c
index 4b81028302..71df2890f3 100644
--- a/drivers/net/intel/e1000/base/e1000_manage.c
+++ b/drivers/net/intel/e1000/base/e1000_manage.c
@@ -129,7 +129,7 @@ bool e1000_enable_tx_pkt_filtering_generic(struct e1000_hw *hw)
 	len    = E1000_MNG_DHCP_COOKIE_LENGTH >> 2;
 	offset = E1000_MNG_DHCP_COOKIE_OFFSET >> 2;
 	for (i = 0; i < len; i++)
-		*(buffer + i) = E1000_READ_REG_ARRAY_DWORD(hw, E1000_HOST_IF,
+		buffer[i] = E1000_READ_REG_ARRAY_DWORD(hw, E1000_HOST_IF,
 							   offset + i);
 	hdr_csum = hdr->checksum;
 	hdr->checksum = 0;
@@ -173,7 +173,7 @@ s32 e1000_mng_write_cmd_header_generic(struct e1000_hw *hw,
 	/* Write the relevant command block into the ram area. */
 	for (i = 0; i < length; i++) {
 		E1000_WRITE_REG_ARRAY_DWORD(hw, E1000_HOST_IF, i,
-					    *((u32 *) hdr + i));
+						((u32 *)hdr)[i]);
 		E1000_WRITE_FLUSH(hw);
 	}
 
-- 
2.43.0

