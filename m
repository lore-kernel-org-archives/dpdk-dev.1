Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075DC55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2364D406B7;
	Wed,  5 Aug 2026 15:46:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id BA4A140A81
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937571; x=1817473571;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WYoaFU79mdwTt3qGEoek7Ibc5ZWqkq8wj0bp3l1eqvM=;
 b=Yhmgva+T2+bHA46HNhxF9Owzxe7paZthE3frKg3FUFxti1e485JnBbAr
 RjHXld3AgOx3L8/nn4nKUSylSm24nZzH6qSscjksF1hMdt+iFxy150UFV
 GXK8RU1DujG80V0Tr7Qi6KOiDS0f0VhHgThveiV5PkBvccHyy0RR1QuLG
 uJy1HadxJweZrTQgIdDAK8N1vdgORExt8pbUZ07dgCIt1SzKJ/F5e+3y0
 vlqGQeeyIRse7oyD57t64qjZScfoChrGFlw6zTql3arhR1M3u+f+TzNTo
 RdbNqgfEzMqZvPcNEEh0slhdZFGV7h68rsPryAJkEie+czDkwkXzZ4h/4 w==;
X-CSE-ConnectionGUID: +g3uJeLsTj2+cxtanbx9IQ==
X-CSE-MsgGUID: 9IpJDiW+ROOeI6fOXq9Acw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284102"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:10 -0700
X-CSE-ConnectionGUID: 3wuoC7vORky3Ia0fmZomEw==
X-CSE-MsgGUID: pI3IjG9pQ5a4p0a20MY8og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476689"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v9 11/19] vhost: remove group-related API from driver
Date: Wed,  5 Aug 2026 14:45:40 +0100
Message-ID: <1def31a16d9e5c3b59434ad5a4e42a0ecd5d7770.1785937061.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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
index 0c2b4d020a..2f80cf4072 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -471,10 +471,6 @@ Finally, a set of device ops is defined for device specific operations:
 
   Called to allow the device to response to RARP sending.
 
-* ``get_vfio_group_fd``
-
-   Called to get the VFIO group fd of the device.
-
 * ``get_vfio_device_fd``
 
   Called to get the VFIO device fd of the device.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index f2901064f5..c520129ac3 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -30,10 +30,6 @@ Deprecation Notices
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

