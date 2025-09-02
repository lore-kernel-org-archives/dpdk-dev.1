Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA75ACA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EA5140687;
	Tue,  2 Sep 2025 19:27:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id AE5B74066E
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834047; x=1788370047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ujKfZLD92n7WnNyG+kb5+50c+q+BmBCUOB5Enj3QXRY=;
 b=A5ejI/Ux6rBjJTiTagxz5WgCxQrNiDj7tn81LjoO6grv0LI8in24umBM
 +wh1JALGN69l5JZj9YZ/ev1Zzakg0MLhgAOEAk7OUCFfBYau6X4Evp0v7
 3yxpfGMh7lKAg4RjDiogyoSERr9A0Km1SqRn2sNKMEbBkT62BZMm282ub
 P1FRGiBuo+b9FJTK0Gg8RV0retFhPQKDP17apzk0lnvbtElVLoe+8eXz3
 DiIs1eoLRYO/fEAJUjMZ1hHUPYoSHKpXr6UCchMb1QPB1wpbiAp8D55s6
 T6CIIHfdGV0ZxkKHZmZnWFwX6kAzPCZW2KZoDh7KqHGoBIdLXBDZKlIwc Q==;
X-CSE-ConnectionGUID: /xL/LabCR9G6BTbBw4TwZQ==
X-CSE-MsgGUID: UXLXXCijTUCZ1JlG3cxPmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731995"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:22 -0700
X-CSE-ConnectionGUID: p8Jxn4sBQfWMIVRGSGKFsA==
X-CSE-MsgGUID: 0YE616+BTHuTkX4yEiSUWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229120"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 06/12] net/ice/base: add 40G speed
Date: Tue,  2 Sep 2025 18:26:56 +0100
Message-ID: <b5b3a1611701074aa4d14b12e0024f498f5e9432.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
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

From: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>

Added 40G speed for port options

Signed-off-by: Jaroslaw Ilgiewicz <jaroslaw.ilgiewicz@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_adminq_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/base/ice_adminq_cmd.h b/drivers/net/intel/ice/base/ice_adminq_cmd.h
index a5817daca9..34b008f5fd 100644
--- a/drivers/net/intel/ice/base/ice_adminq_cmd.h
+++ b/drivers/net/intel/ice/base/ice_adminq_cmd.h
@@ -1917,6 +1917,7 @@ struct ice_aqc_get_port_options_elem {
 #define ICE_AQC_PORT_OPT_MAX_LANE_50G	6
 #define ICE_AQC_PORT_OPT_MAX_LANE_100G	7
 #define ICE_AQC_PORT_OPT_MAX_LANE_200G	8
+#define ICE_AQC_PORT_OPT_MAX_LANE_40G	9
 	u8 global_scid[2];
 	u8 phy_scid[2];
 	u8 pf2port_cid[2];
-- 
2.47.3

