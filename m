Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71ECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 337BF40A73;
	Tue, 28 Oct 2025 17:43:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C28A74065B
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:43:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761669823; x=1793205823;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OT4SLRoTQQqL4uGSpbxKxLgu6m8Js0U9+INRiQlRJ34=;
 b=Vgbfua0iOIyXieAqJA5HLTR1Y3aQpimo+i25eLw9sTyp+sTO+a5UDoj6
 BZgGYHnNhp+ICfveoHAXxd7PL/i1DnKtm5T3XpEh5LtYvkuNPt57cyyNR
 CehN+ifE+SBFjzKVAVKn1LyhLlphIsnW+w64KB7Wu90hQaCyi3+NRLHrS
 0pVCanOT85RK1wa0uDTEelWsIKB+MkEH0Ye2kp87iCxCje5lbaToBwCCH
 W0R4SNd5/ERfqdx5jIAqzVBFAL/hXiyNbBQX13S0SeCQvw7W64al8aY+l
 NLGr54CuWzttc+i8fR7jZt7H95zetgLCoeppwh4PkMYgNJ4RFBUMpq1fS A==;
X-CSE-ConnectionGUID: TKVXvdIhSaiZRctZ0HGNrw==
X-CSE-MsgGUID: Rw3FqjTKQDmDzNhKHzPk1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63663645"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="63663645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 09:43:42 -0700
X-CSE-ConnectionGUID: goUyzv3WQ++j4SpPJBI2SQ==
X-CSE-MsgGUID: hLc2p89FQUS0uVjz1/e+fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189452796"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2025 09:43:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 7/8] doc: deprecate VFIO group-based APIs
Date: Tue, 28 Oct 2025 16:43:20 +0000
Message-ID: <a2fa59f3010230ad86f88b0806e88d8d642e0672.1761669439.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1761669438.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Outline upcoming changes to the VFIO infrastructure, including:
- Deprecation of group-based APIs in favor of container device assignment
- Removal of separate no-IOMMU checks in favor of unified VFIO "modes"
- Elimination of group-based functions from the vDPA driver API

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 1e60ac4e82..f54a0fe89f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,29 @@ Deprecation Notices
   without relying on flow API.
   Currently there is no alternative API
   providing the same functionality as with ``repr_matching_en`` set to 0.
+
+* eal: Several VFIO APIs have changed their signatures and/or return values to improve error reporting and consistency:
+  - ``rte_vfio_setup_device`` and ``rte_vfio_release_device`` now return 0 on success and <0 on failure, with ``rte_errno`` set.
+
+    Previously, if a device was not managed by VFIO (e.g., not bound to the VFIO driver),
+    ``rte_vfio_setup_device`` would return 1 to indicate the device should be skipped.
+    Now, this is treated as an error: the function returns -1 and sets ``rte_errno`` to ``ENODEV``.
+
+  - ``rte_vfio_get_device_info`` now takes a device file descriptor and device info pointer,
+    and returns 0 on success, <0 on failure. Previously, the function was accepting a path to device, and would set the device up if it wasn't set up.
+    It will no longer do so, and users of this function must call ``rte_vfio_setup_device`` prior to using this function.
+
+  - VFIO API has been updated with new error codes and return values, all error codes and return values are now documented in the API headers.
+
+  Applications using these APIs should review the updated function signatures and error handling.
+
+* eal: The following legacy VFIO group-related APIs are deprecated and will be removed in a future release:
+  ``rte_vfio_clear_group``, ``rte_vfio_get_group_fd``, ``rte_vfio_container_group_bind``, and ``rte_vfio_container_group_unbind``.
+  These APIs are replaced by the new container device assign lifecycle:
+  ``rte_vfio_container_assign_device`` → ``rte_vfio_setup_device`` → ``rte_vfio_release_device``.
+  Users should no longer need to manage IOMMU groups directly; all group management is now handled internally.
+
+* vdpa: vDPA drivers have been updated to use the new VFIO device assignment APIs.
+  The deprecated VFIO group-based APIs (``rte_vfio_get_group_num``, ``rte_vfio_container_group_bind``, ``rte_vfio_container_group_unbind``)
+  are no longer used. vDPA drivers now use ``rte_vfio_container_assign_device`` instead, and no longer need to track VFIO group file descriptors.
+  This change aligns vDPA drivers with the new VFIO API that abstracts away IOMMU group management.
-- 
2.47.3

