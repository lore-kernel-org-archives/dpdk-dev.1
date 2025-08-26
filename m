Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB6EDF032
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 04:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EC44042C;
	Thu, 12 Feb 2026 05:53:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 261DD4025F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 05:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770871974; x=1802407974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7nDkG2VtWZjSK0gCWJmV/c4Z7US6APo9gd8TMQx7WQ=;
 b=NNVsUgBahXejRZT6NP2P9/aX2prhVsZMFA6VJ6nyfdXHyk5GUgD4eId2
 YSQ3E7n/iVcNE1EWFs5H/hcxepezSztJqhh5kZt1dswPuyXvVdoIpeKwr
 627Hh5DwZuP7sZgpDs4t4M/cTsZCCpYk4Q5lB1jkW8tDm+fYHtAEAtYSz
 Xy7DOXFSCSznEl5GYJ6bdMg9GCZjNzS2COVvzbTv+cjUBEDhDJeBWhjWE
 Z4gQO6xoeUKVTLZdpBRuSa1mF51QObyp8f50O8BD7SE3JJHn8bFntrgOs
 e+gCIy3gSJ057do0ns4mbA3uncx4zxUpRYffeTsEUQ4ZLkKy8Dwnv73Yk A==;
X-CSE-ConnectionGUID: 5dWqcsaESkOa2ogML38GjA==
X-CSE-MsgGUID: Fpn7jea3SzSiTB87DJV9sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71940235"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71940235"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 20:52:54 -0800
X-CSE-ConnectionGUID: dy87M/dRS82J6H+t/KQSAg==
X-CSE-MsgGUID: h4rDavW7QxGt379XK2hDeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216715406"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2026 20:52:52 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v4 1/7] net/ice: add L2TPv2 PPP and PPoE data structures
Date: Tue, 26 Aug 2025 21:56:58 +0530
Message-Id: <20250826162704.4636-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826162704.4636-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826162704.4636-1-shaiq.wani@intel.com>
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

