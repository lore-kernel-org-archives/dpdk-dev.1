Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F003EDF038
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:31:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B56804042F;
	Thu, 12 Feb 2026 06:31:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7D90A4025F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874290; x=1802410290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A7nDkG2VtWZjSK0gCWJmV/c4Z7US6APo9gd8TMQx7WQ=;
 b=iF5IaNw3/smXv+o2kLOeivWlxEof4OD+Tc51MhVlwqpmovPLtgkZv2v1
 rqwaAmvwODU398z4XF/Txz93Z+Lqk7dEN2E3MuHBUUzHBbNBkm/uA2103
 ZDUft4Ipkw4Hkmuv8xO4/q7XbOY0JC1r6rOL3PkrQb3RlvM8+l3ZnWfgV
 VeB8qHUcLdhfmHZSHqH9023zo8eLlC8c/F/cUeRfVaiYOSaoVCliQZuSa
 BcZuY4Hoa7TqJrRTStK9SqW+ZHwPenvJRTBNdf8UvPgSOqpL+jYgF2Ozf
 c+SkH6x3VLwvQv6jJxdYteKxS1/he4+dL2xz5XejS4Wg5122yk8GLEE3I Q==;
X-CSE-ConnectionGUID: EJq69reIQeGeuc6RN4HFpg==
X-CSE-MsgGUID: rpnV72AcT5GkX/hdqahdWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405334"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405334"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:30 -0800
X-CSE-ConnectionGUID: S5QfFGGpRFq+aQ25HqgUvg==
X-CSE-MsgGUID: doQL7fNVQECV3YlXGjenfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581376"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:29 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v5 1/7] net/ice: add L2TPv2 PPP and PPoE data structures
Date: Tue, 26 Aug 2025 22:35:35 +0530
Message-Id: <20250826170541.5010-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826170541.5010-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
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

