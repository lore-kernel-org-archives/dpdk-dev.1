Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F9E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2310940654;
	Wed, 18 Feb 2026 17:41:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1C148402F2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432902; x=1802968902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7nDkG2VtWZjSK0gCWJmV/c4Z7US6APo9gd8TMQx7WQ=;
 b=nz1kelabf+mWFrvrll9X1NQIbJtVV0EHHKYGKAyLvdS7Vy6LDj48KhyI
 qawXBMKoVVNnbvQBzFygtcZoEu5gIkChrPa5SARhNxxSLQrKiFXISFfq9
 p694xDBp4at0JUumjn2+o4+xmDVW7RRLZkkJK8x2GVhcxAFRbnKZMMBXD
 PPy+RNVoDPlFIO5VfCAcLnSq+pMFsZiMNMeswnHDeV9gWYt38UAgfX3ux
 dGnJSzQafw1QJke/mLN4nanMyQWSIBhcSFqCwX7gI2GnorXNVsWvWn/Vi
 EC2dJcDMdhQRxlNtjpBa9r1Vh+RP0dHEh/yxJBGOUI1tMOS01XxvM+w3f w==;
X-CSE-ConnectionGUID: U1tXiiu0SIu1eyzQwB1ejA==
X-CSE-MsgGUID: QkDRCGttTeyleZTVEXYw1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72601852"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72601852"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:42 -0800
X-CSE-ConnectionGUID: sTiLq91yQbmWC6JSelJ3Vg==
X-CSE-MsgGUID: JM1LPeHiQNm2BDholxMU2g==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 08:41:40 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v6 1/8] net/ice: add L2TPv2 PPP and PPoE data structures
Date: Wed, 18 Feb 2026 22:07:43 +0530
Message-Id: <20260218163750.1408973-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218163750.1408973-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260218163750.1408973-1-shaiq.wani@intel.com>
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

Add data structure definitions for L2TPv2 PPP and
PPoE protocols to support Flow Director (FDIR) filtering.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_fdir.h b/drivers/net/intel/ice/base/ice_fdir.h
index 3dd03f93f7..3d3b05da4a 100644
--- a/drivers/net/intel/ice/base/ice_fdir.h
+++ b/drivers/net/intel/ice/base/ice_fdir.h
@@ -230,6 +230,20 @@ struct ice_fdir_ecpri {
 	__be16 pc_id;
 };
 
+struct ice_fdir_pppoe {
+	u8 rsrvd_ver_type;
+	u8 rsrvd_code;
+	__be16 session_id;
+	__be16 length;
+	__be16 ppp_prot_id; /* control and data only */
+};
+
+struct ice_fdir_ppp {
+	u8 addr;
+	u8 ctrl;
+	__be16 proto_id;
+};
+
 struct ice_fdir_l2tpv2 {
 	__be16 flags_version;
 	__be16 length;
@@ -279,6 +293,9 @@ struct ice_fdir_fltr {
 	struct ice_fdir_ecpri ecpri_data;
 	struct ice_fdir_ecpri ecpri_mask;
 
+	struct ice_fdir_ppp ppp_data;
+	struct ice_fdir_ppp ppp_mask;
+
 	struct ice_fdir_l2tpv2 l2tpv2_data;
 	struct ice_fdir_l2tpv2 l2tpv2_mask;
 
-- 
2.34.1

