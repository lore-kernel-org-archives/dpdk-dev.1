Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969EEB5961
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 06:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5634E402E7;
	Wed, 11 Feb 2026 07:10:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6E476400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 07:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770790228; x=1802326228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7nDkG2VtWZjSK0gCWJmV/c4Z7US6APo9gd8TMQx7WQ=;
 b=nbAyF9xkKoaNqd0G9xYGXss+i4I1tWGxV5eEBj2kk4v0oeofH5cI5V7X
 WLflaragZJxX6+sil2HPyAw4uF6fVT/Q7YSgejXiOac3vKxIp0hmkSQJU
 opDqPZ7cj+s6z8VLFVYGwg1YZiqbqFMTFWq2bOucIZuClwllokdjrkZFU
 eGrRaiXX26DWAdMjpUSs8GYtxhlFSPBlaMZ72TbY+by1LxUYrDC91v+4Q
 jX6tmG6WO2HMhRzrnA3nio6ZPDGxXmZKblMZ+q/mRkgrEeBFq4RtiBoGw
 2QnYRUPrD84OtP77/zx7K6rqjSdAUv61Yt5+A3s3Gm7ThOeStv05L7jLK Q==;
X-CSE-ConnectionGUID: Eh8RMSMyTEaMn4AGJMn2/w==
X-CSE-MsgGUID: qjlbG8dfR16iILotv7kDaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71829050"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71829050"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:10:27 -0800
X-CSE-ConnectionGUID: FIGvBBVtTnO7EkcyX8RlMg==
X-CSE-MsgGUID: Gg4in4z8RkyMGOSGxLDtoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216655457"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2026 22:10:25 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v3 1/7] net/ice: add L2TPv2 PPP and PPoE data structures
Date: Wed, 11 Feb 2026 11:39:04 +0530
Message-Id: <20260211060910.219419-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211060910.219419-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20260211060910.219419-1-shaiq.wani@intel.com>
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

