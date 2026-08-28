Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCDC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6054540B94;
	Fri, 28 Aug 2026 15:07:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9BD2E40B9F
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922451; x=1819458451;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LsSS4K04/8gx9qpkdJ7KWGwNSmkzZtHLfRkPEnqpf4g=;
 b=Z12SydzYGOtFGkhZuloBCsnFme+k/x59NrHRjKes/0D6ojP+Srl77E50
 PgsfoA2apLjsjNyVZ/st194eXVDfXLL957TsrXJ3KT4q74+OLmKlD5Yyi
 fSiVLYGaC+r4/zlhekcwHjCIYw4rf/0hryhkLIJ2hgIwkrXc9+A8Izq+1
 T9xJoV3kUmufOaVeUU9qoZCFjmMG7b5yQqTvJqRAYbQ51oNxm5GJSAjd7
 34HkN5YkB9Zklec4jIVWnwj/O1N4kfkCjCakDFVqSQcbtXopxlM/1sMka
 R/y/dXNxt4n2kQx/KYEPyOp9qidfYNtzlNX+oGv49zHv6wJv3RPovDdik g==;
X-CSE-ConnectionGUID: jbVIjbORQZylsltW7eB8Vw==
X-CSE-MsgGUID: 4ywuyhrhQOmfoOawHEOBIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964611"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964611"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:30 -0700
X-CSE-ConnectionGUID: Dkh3WqnWTaKDPpaETRNDww==
X-CSE-MsgGUID: APxPtMTkRiKw+dAW6gxn8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271960009"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v14 17/25] vhost: remove group-related API from driver
Date: Fri, 28 Aug 2026 14:06:45 +0100
Message-ID: <7a53f64240a3ed537392b2c3e36dfbe973524f7e.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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
 doc/guides/prog_guide/vhost_lib.rst    | 4 ----
 doc/guides/rel_notes/deprecation.rst   | 4 ----
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/vhost/vdpa_driver.h                | 3 ---
 4 files changed, 3 insertions(+), 11 deletions(-)

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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 71d12a4398..006b1d3e5a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -117,6 +117,9 @@ ABI Changes
   These functions are now available only to EAL and drivers,
   and are no longer part of the public ABI.
 
+* vdpa: Removed ``get_vfio_group_fd`` from ``struct rte_vdpa_dev_ops``.
+  vDPA drivers should now use the VFIO container device assignment API.
+
 
 Known Issues
 ------------
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

