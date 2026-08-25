Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69763C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F285540B90;
	Tue, 25 Aug 2026 15:21:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1F90A406B7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664102; x=1819200102;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XygbfWIOBBbTgMyhtYgWtxBD0P1DQaZeLDPR8LtgOYw=;
 b=Gv/JXEivzptvR3er4y7HgFrMn+p02i7M/6zOVNbYurJ9CcwiO6tnccG9
 KrwKVh4ghxDAn29JbSZ0b6j57cbrkZ/dNjhA2abACGbBuQi5CskYnbffx
 YYkcvGVLh7/lxPa88uFadOprCJ9JEvAKbva+ekJzqQAlFhTvcgRcNEg1o
 Ls22bJK3vst4as7+cbxEwLkMgs180eTpWU8SuZ54Sy175VBhdy/odxKVZ
 RF1SMlYCQeC9f2jR7ZA2fGsE7/ydD7STTtRVQPFFYfgmtn+b4ODqLH/Mt
 afcUBWAzQN0c0DAzx1l+75X4iYCihEHVG0bPTamaqK5PReX6xSPuE+zcZ g==;
X-CSE-ConnectionGUID: xRCy+wxqSBWXeihgRdUtsQ==
X-CSE-MsgGUID: MrmzW/PsTGqq/VLsRwak5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332720"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:41 -0700
X-CSE-ConnectionGUID: xWQY/cibQ4Cby1igTGKV+A==
X-CSE-MsgGUID: ycA0gw9tS0StRzdjSMn0aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660893"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v12 12/20] vhost: remove group-related API from driver
Date: Tue, 25 Aug 2026 14:21:09 +0100
Message-ID: <2330e1c4bff539c18626efdd8f45ed9f54c2aaf1.1787663787.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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

The vDPA driver API has "get_vfio_group_fd" in its ops structure, but no
driver is using it any more, as better API's were added and implemented.
Remove this API from vDPA ops structure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/prog_guide/vhost_lib.rst  | 4 ----
 doc/guides/rel_notes/deprecation.rst | 4 ----
 lib/vhost/vdpa_driver.h              | 3 ---
 3 files changed, 11 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 345a621716..99355b8afd 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -471,10 +471,6 @@ Finally, a set of device ops is defined for device specific operations:
 
   Called to allow the device to respond to RARP sending.
 
-* ``get_vfio_group_fd``
-
-   Called to get the VFIO group fd of the device.
-
 * ``get_vfio_device_fd``
 
   Called to get the VFIO device fd of the device.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 8a82c815e3..e4a754d037 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,10 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
-* vdpa: The vDPA driver API will no longer offer ``get_vfio_group_fd``
-  as part of its internal API. All drivers will be adjusted
-  to use the new unified VFIO container device assignment API.
-
 * rte_atomicNN_xxx: These APIs do not take memory order parameter. This does
   not allow for writing optimized code for all the CPU architectures supported
   in DPDK. DPDK has adopted the atomic operations from
diff --git a/lib/vhost/vdpa_driver.h b/lib/vhost/vdpa_driver.h
index 42392a0d14..c7b9be09fb 100644
--- a/lib/vhost/vdpa_driver.h
+++ b/lib/vhost/vdpa_driver.h
@@ -50,9 +50,6 @@ struct rte_vdpa_dev_ops {
 	/** Destination operations when migration done */
 	int (*migration_done)(int vid);
 
-	/** Get the vfio group fd */
-	int (*get_vfio_group_fd)(int vid);
-
 	/** Get the vfio device fd */
 	int (*get_vfio_device_fd)(int vid);
 
-- 
2.52.0

