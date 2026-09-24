Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4DC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 713D44329E;
	Thu, 24 Sep 2026 18:14:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7BAB2432A0
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266448; x=1821802448;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iNXEFw5n4qIuWn6MX21Z/YpAsLFk+IDsAH+H+d47T9g=;
 b=R9VuWb0K3BgTee3rcHNOEelWF6L5V0BMUqOw0Om265oU3Yn4t+T2hqbc
 BnXk+GmsMD0ddsEnnJBSAMQ8DskaTxM5G14uGQbPLf2bNq4A9vefVs581
 aEptQoy0K8tQFKOS6sUj//fGh/KxpvgDvWgR7q+u8TwZWQqBCPeIgjX46
 A5a4L5Wwvkt95ThAD1WpI0RgKqubLuledVN019YtGojrLV/kOXw4or5ln
 xVCSl0oydUKaVHQKRo+FXmwqG2hO9PxhazuSeSq+76cZlx2zUBze4Yc5S
 zeNlInK+gno9MeNjCmRQtqrzC5mCbb2ReE6w50daay9mRkLnSKoBGn1nd A==;
X-CSE-ConnectionGUID: 0Jx4EhwxRamirsOkrHT2KA==
X-CSE-MsgGUID: tVIpqgzPS92fJyd5PxTZ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000701"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000701"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:07 -0700
X-CSE-ConnectionGUID: LR8jZonqQZqSQlbQTUp3sA==
X-CSE-MsgGUID: m4BebPIsTEuNHciqUO+Hmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830056"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 14/29] vfio: add container device assignment API
Date: Thu, 24 Sep 2026 17:13:21 +0100
Message-ID: <de7ab6223d9be54f45838ef43694507c94eb0aa2.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
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

Currently, VFIO has explicit group bind API's, but the way they're used is
such that no one actually cares about VFIO groups, and the real goal of
everyone using VFIO group bind API is to bind devices to particular VFIO
container, such that when `dev_vfio_setup_device` call eventually comes,
VFIO will pick up the correct container.

To remove dependency on group API's, add a new "container assign device"
API call that will do the same thing, but will not depend on managing VFIO
group fd's.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/include/dev_vfio.h | 26 ++++++++++++++++++++++++++
 lib/eal/linux/eal_vfio.c   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index b7f91ca96b8..ba7773959cb 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -301,6 +301,32 @@ __rte_internal
 int
 dev_vfio_container_destroy(int container_fd);
 
+/**
+ * @internal
+ *
+ * Assign a device to a VFIO container.
+ *
+ * Doing so will cause `dev_vfio_setup_device()` call to set up the device with
+ * the VFIO container specified in this assign operation.
+ *
+ * This function is only relevant on Linux.
+ *
+ * @param vfio_container_fd
+ *   VFIO container file descriptor.
+ * @param sysfs_base
+ *   Sysfs path prefix.
+ * @param dev_addr
+ *   Device identifier.
+ *
+ * @return
+ *   0 on success.
+ *   <0 on failure.
+ */
+__rte_internal
+int
+dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
+		const char *dev_addr);
+
 /**
  * @internal
  * Bind a IOMMU group to a container.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 0acc423ce28..e58f4b8a937 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -2207,6 +2207,38 @@ dev_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_assign_device)
+int
+dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
+		const char *dev_addr)
+{
+	int iommu_group_num;
+	int ret;
+
+	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot get IOMMU group number for device %s",
+			dev_addr);
+		return -1;
+	} else if (ret == 0) {
+		EAL_LOG(ERR,
+			"Device %s is not assigned to any IOMMU group",
+			dev_addr);
+		return -1;
+	}
+
+	ret = dev_vfio_container_group_bind(vfio_container_fd,
+			iommu_group_num);
+	if (ret < 0) {
+		EAL_LOG(ERR,
+			"Cannot bind IOMMU group %d for device %s",
+			iommu_group_num, dev_addr);
+		return -1;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
 int
 dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
-- 
2.52.0

