Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34040CE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A76640EE7;
	Fri, 14 Nov 2025 18:40:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AAECC40288
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142037; x=1794678037;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yknjs5a1TkdVRwvzvLFRHmvyIm2dUVNfMkm/dqI2PG4=;
 b=fNZT2y2NIV1ZaLrv9HcDn/ZE3XUX0lYQu0NBfKi5+BkifpOTAjrcAF/3
 JqZEDjV9NH560Y3SQyH6NwgH0KZILjx68bpRvH9zKaHNuep+4WUp7Nhbv
 q+C8/IiozBjyW4IJw3MqoZ18b4PZ3o6a2cFtd+X1/0aJWCrdF8S08X67J
 F3NDxjI58lWLBKw8+h57tjTAF5eDwrVaLz1SGtWeLiOQI40sj0/dmsqVa
 2GIoXNsvsg0NN3lzepWR2vGdqYZ6dQNQLqEjBqxuSVNjACYDE8KyMtN/a
 WtUPYIXxdobO/UMXbMBVXATNQiXFMlyCz5QuO1Ik7v5c1XthVTxt6ckjd Q==;
X-CSE-ConnectionGUID: rZsCPUVuSVmDf5fwZ6KQHQ==
X-CSE-MsgGUID: qjS/m1+VRhGOengW6SxYQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864250"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864250"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:35 -0800
X-CSE-ConnectionGUID: /3xyPfgWQiO8kXdygMK4jg==
X-CSE-MsgGUID: JmNkkfHvQQedVLT5/wOGHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650716"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 01/19] doc: add deprecation notice for VFIO API
Date: Fri, 14 Nov 2025 17:40:11 +0000
Message-ID: <60b4075f7b8cb63fc40baa83fbc251815f3b5115.1763142007.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

The entirety of VFIO API will be either made internal and only available to
drivers, or will be removed. Add upcoming changes to deprecation notices.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 1e60ac4e82..5e3df71048 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,7 @@ Deprecation Notices
   without relying on flow API.
   Currently there is no alternative API
   providing the same functionality as with ``repr_matching_en`` set to 0.
+
+* eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
+  Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
+  This change will be made in 26.11 release.
-- 
2.47.3

