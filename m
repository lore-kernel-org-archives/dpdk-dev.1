Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFFCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:52:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E5414068A;
	Tue, 19 May 2026 16:52:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 885FB40665;
 Tue, 19 May 2026 16:52:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202365; x=1810738365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8NvhC0Jjlqu6I5fGbgC826X2lqRbjCtRgVIgAhC5xE8=;
 b=TPUiYknzYUVqp2pNIJVQF/1cfLZmKoN7xPsfCQZVoyyzRwLF9vehxbku
 R8+IG64oQHqRRPR29BceMOOcgATB9qEsFR0+e1K+vCqDl31GGkBTPiMxM
 9wh26O2brt4jK43xaJ+FFaFHfeRs94e/DR7lXEm256P6UBYUwlcrhu9oj
 tPGg/BGjCiyJij/u4CrSReT/tZbkXbUDgLc85143RjSTXVLvUvLWk/k1F
 3YLdMJIDtojJRzdIWfM+zJD1U61mRqvWBXNe+CjUQ4L1zXQfpfpxBp3Cr
 t30x9QB5JistGJzDOzlhBLZOxCtRJWyhs6YCfjfKxmiqdp1Y2vGuMDI5d Q==;
X-CSE-ConnectionGUID: pjyuDbeiTzmFSzWGCsQgzQ==
X-CSE-MsgGUID: zojj9l1uQIimcjJWTgCm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90383759"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90383759"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:52:45 -0700
X-CSE-ConnectionGUID: s87MIGo/QEONHSIn++wsPg==
X-CSE-MsgGUID: XAAGMpKtT/S2ZnO6m+vbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238794395"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 19 May 2026 07:52:44 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Deepthi Kavalur <deepthi.kavalur@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/3] net/i40e/base: fix loop counter width in DCB parsing
Date: Tue, 19 May 2026 14:52:22 +0000
Message-ID: <20260519145227.308814-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519145227.308814-1-ciara.loftus@intel.com>
References: <20260519145227.308814-1-ciara.loftus@intel.com>
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

From: Deepthi Kavalur <deepthi.kavalur@intel.com>

Loop counters in i40e_parse_cee_app_tlv() and
i40e_add_ieee_app_pri_tlv() are declared as u8 but compared against
numapps which is u32. If numapps exceeds 255 the counter wraps,
truncating the iteration. Widen the counters to u32.

Fixes: 166dceeeeafc ("i40e/base: add parsing for CEE DCBX TLVs")
Fixes: 0d9d27bb8684 ("i40e/base: prepare local LLDP MIB in TLV")
Cc: stable@dpdk.org

Signed-off-by: Deepthi Kavalur <deepthi.kavalur@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 .mailmap                               | 1 +
 drivers/net/intel/i40e/base/i40e_dcb.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index f3130df686..6121833c25 100644
--- a/.mailmap
+++ b/.mailmap
@@ -371,6 +371,7 @@ Dean Marx <dmarx@iol.unh.edu>
 Declan Doherty <declan.doherty@intel.com>
 Deepak Khandelwal <deepak.khandelwal@intel.com>
 Deepak Kumar Jain <deepak.k.jain@intel.com>
+Deepthi Kavalur <deepthi.kavalur@intel.com>
 Deirdre O'Connor <deirdre.o.connor@intel.com>
 Dekel Peled <dekelp@nvidia.com> <dekelp@mellanox.com>
 Dengdui Huang <huangdengdui@huawei.com>
diff --git a/drivers/net/intel/i40e/base/i40e_dcb.c b/drivers/net/intel/i40e/base/i40e_dcb.c
index 04322ea034..c1d97fabab 100644
--- a/drivers/net/intel/i40e/base/i40e_dcb.c
+++ b/drivers/net/intel/i40e/base/i40e_dcb.c
@@ -364,7 +364,7 @@ static void i40e_parse_cee_app_tlv(struct i40e_cee_feat_tlv *tlv,
 {
 	u16 length, typelength, offset = 0;
 	struct i40e_cee_app_prio *app;
-	u8 i;
+	u32 i;
 
 	typelength = I40E_NTOHS(tlv->hdr.typelen);
 	length = (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
@@ -1169,9 +1169,9 @@ static void i40e_add_ieee_app_pri_tlv(struct i40e_lldp_org_tlv *tlv,
 				      struct i40e_dcbx_config *dcbcfg)
 {
 	u16 typelength, length, offset = 0;
-	u8 priority, selector, i = 0;
 	u8 *buf = tlv->tlvinfo;
-	u32 ouisubtype;
+	u32 ouisubtype, i = 0;
+	u8 priority, selector;
 
 	/* No APP TLVs then just return */
 	if (dcbcfg->numapps == 0)
-- 
2.43.0

