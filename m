Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8B9E7314E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDC5640A6F;
	Mon,  2 Feb 2026 10:44:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D49114027D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770025441; x=1801561441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dNzK2bVQit6BLRGIjVeNjkbf2dWxylULZniaPjLjz88=;
 b=JdR+gtQkHZn/tnIVC1+wEv3sN8B4XUiBfoQlv9m+6wQ135Ofz8M4UraI
 xJ8I2FdSb0TX5esQO1ImnoqYUvXo9B0ayNp97oAIyP3jMxvFPqV/U4fKX
 ETKGWiItlhlfdFZzAzqOYZJmKyLsos9BBCxcAM14yUOtTIyDsMJrDiFt0
 Yl9KJpI5llk7SuB9uXAAs8Va/R2vEH0obTLiFfCfeNoPn4buJicI78Vxd
 ozC+2hinNJDSpSd4bOgEJdvOokT4Zhih5WN6FOliUVjLBjnJGFhgjgD+P
 YWBaDrK9gCr9PRzmYt4mnbEVg1ncaloS3xyryQ8xf4NJ+lFSt9Fo7jKF9 w==;
X-CSE-ConnectionGUID: F8IcMswmTciPh68hJ0ZN5A==
X-CSE-MsgGUID: duxkVFYBQXW9d93fLhQz/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81917706"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="81917706"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 01:44:00 -0800
X-CSE-ConnectionGUID: xEedWgpUTo+8zffPSfx+HA==
X-CSE-MsgGUID: JyIhdrroQkKkrGM1Od7WYg==
X-ExtLoop1: 1
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2026 01:43:59 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jiale Song <songx.jiale@intel.com>
Subject: [PATCH 1/6] net/ice: add L2TPv2 and PPP data structures
Date: Mon,  2 Feb 2026 15:12:39 +0530
Message-Id: <20260202094244.447966-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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

Add data structure definitions for L2TPv2 and PPP
protocols to support Flow Director (FDIR) filtering.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Jiale Song <songx.jiale@intel.com>
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

