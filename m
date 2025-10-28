Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C070CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F49640A81;
	Tue, 28 Oct 2025 17:43:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0201E40A71
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:43:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761669824; x=1793205824;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hNB4XafPg5wb4WwT2gzjq/y9yWksAh0sz7FCjrTshog=;
 b=HG6KwkYdFGjU4HCpYld5rek3QQ3ew7LXlyUKLfCmVuO7yONeA48rBCjs
 SfrQtKZg8XP/P6U4hqj3U7AmvF5TwzZFupKNk4769o3Nislv74og9Znlf
 +H3SiiiiCJ1rIccgzEqcV/YxSeVU0578G54kbfTw3eBe785zGBtcvG5ue
 RYCEDFVmV0z6yRJKHq/p24vWODY4b/BHKcZ+xxabPJNBMq+jx/h/TqY5B
 iRnclrDLwrYW0816bJEqm6mZAw4BrXfyH43115qjJPWFw3vUxf6wEK0TB
 7X9Xs57NBaAIje9yOXvsMWKppVuRE9/ZeJMNqRfSGRd7tBAPs+Z6Qr40T g==;
X-CSE-ConnectionGUID: m6tXMAKFStKwgaD+HN+FcQ==
X-CSE-MsgGUID: MMYpdSCTQC2fuW92E4Pk6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63663649"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="63663649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 09:43:44 -0700
X-CSE-ConnectionGUID: mMuzbLkNQNmn0tU2bFvz/Q==
X-CSE-MsgGUID: vl/Cbb+GTAugadhAyO68sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189452801"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2025 09:43:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v1 8/8] vfio: deprecate group-based API
Date: Tue, 28 Oct 2025 16:43:21 +0000
Message-ID: <b38fa7fb795eb68ace0db9b66a9b50c59db8bea8.1761669439.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1761669438.git.anatoly.burakov@intel.com>
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

Aside from "get group number" which is a read-only API, deprecate all VFIO
group-based API's, and steer the users towards container device assignment
model.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/include/rte_vfio.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 735e67a54c..c57067f054 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -151,20 +151,28 @@ enum rte_vfio_mode
 rte_vfio_get_mode(void);
 
 /**
+ * @deprecated
  * Check if VFIO NOIOMMU mode is enabled.
  *
+ * This function is deprecated and its use is discouraged.
+ * Use `rte_vfio_get_mode()` instead to query NOIOMMU status.
+ *
  * This function is only relevant on Linux in group mode.
  *
  * @return
  *   1 if enabled.
  *   0 if not enabled or not supported.
  */
-int
+int __rte_deprecated
 rte_vfio_noiommu_is_enabled(void);
 
 /**
+ * @deprecated
  * Remove group fd from internal VFIO tracking.
  *
+ * This function is deprecated and its use is discouraged.
+ * Use `rte_vfio_release_device()` instead, which will release the device and its resources.
+ *
  * This function is only relevant on Linux in group mode.
  *
  * @param vfio_group_fd
@@ -179,7 +187,7 @@ rte_vfio_noiommu_is_enabled(void);
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Operation not supported.
  */
-int
+int __rte_deprecated
 rte_vfio_clear_group(int vfio_group_fd);
 
 /**
@@ -276,8 +284,12 @@ int
 rte_vfio_get_container_fd(void);
 
 /**
+ * @deprecated
  * Return file descriptor for an open VFIO group.
  *
+ * This function is deprecated and its use is discouraged.
+ * Use `rte_vfio_setup_device()` instead, which handles group management automatically.
+ *
  * This function is only relevant on Linux in group mode.
  *
  * @param iommu_group_num
@@ -292,7 +304,7 @@ rte_vfio_get_container_fd(void);
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Operation not supported.
  */
-int
+int __rte_deprecated
 rte_vfio_get_group_fd(int iommu_group_num);
 
 /**
@@ -379,8 +391,12 @@ rte_vfio_container_assign_device(int vfio_container_fd,
 		const char *sysfs_base, const char *dev_addr);
 
 /**
+ * @deprecated
  * Bind an IOMMU group to a container.
  *
+ * This function is deprecated and its use is discouraged.
+ * Use `rte_vfio_container_assign_device()` instead to assign devices to a non-default container.
+ *
  * This function is only relevant on Linux in group mode.
  *
  * @param container_fd
@@ -399,12 +415,17 @@ rte_vfio_container_assign_device(int vfio_container_fd,
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Operation not supported.
  */
-int
+int __rte_deprecated
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
 
 /**
+ * @deprecated
  * Unbind an IOMMU group from a container.
  *
+ * This function is deprecated and its use is discouraged.
+ * Use `rte_vfio_release_device()` instead to release devices, which handles group cleanup
+ * automatically.
+ *
  * This function is only relevant on Linux in group mode.
  *
  * @param container_fd
@@ -423,7 +444,7 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
  * - ENXIO   - VFIO support not initialized.
  * - ENOTSUP - Operation not supported.
  */
-int
+int __rte_deprecated
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
 
 /**
-- 
2.47.3

