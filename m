Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A95C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD4E840E31;
	Tue,  1 Sep 2026 18:15:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id BFDBA40E27
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279358; x=1819815358;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ovCSRWNG5S+b1IUDTO7DTveBNbqGHIjaVnLNYA+9IvY=;
 b=N8dEDqq7RfUpo+poZDeTlMCt0Oi1/1KQnmPM35F4UgpmU/bowKFJnzRp
 WT9iInjJEZTGSvyOX9e8ZelZvJF4qSv74uZsc0W4N5H8JVFrOmwmzmGyn
 9SFm2XG5Aga823H3yWYDXdnxP2UUA7Pu+e5CKpS2ierYSFeIPRCAcHWBh
 rXsrVpD2y9u/au9KrP9kspUShG6aI60pmR2HCEkPEqEnI4DowR5Y9KSss
 clHuA81CqP+W8Au4II1x+nbwfGb7up8cD0iDwVdC9qlm2l7sm568WbWEW
 c5cG2LfOyZUYmcNi4OdZOWr5XYBKQHk/DXkODziwpmhGD82UW/gkSaOqX w==;
X-CSE-ConnectionGUID: wFPBFKwBStypQfVr/equYQ==
X-CSE-MsgGUID: x1wvR81gR3GmwL9tMBzF7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656085"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:15:57 -0700
X-CSE-ConnectionGUID: MslkbUQvRF24A9klbTHuRQ==
X-CSE-MsgGUID: Ff8+jPhUT4Gf7ggkQe23BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032552"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:15:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v15 10/25] vfio: add container device assignment API
Date: Tue,  1 Sep 2026 17:15:16 +0100
Message-ID: <a4100f219d744b097c0b06e19283156a232101e6.1788278992.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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
 lib/eal/freebsd/eal.c      | 10 ++++++++++
 lib/eal/include/dev_vfio.h | 26 ++++++++++++++++++++++++++
 lib/eal/linux/eal_vfio.c   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index b2d902f060..31340bb49a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -965,3 +965,13 @@ dev_vfio_get_device_info(__rte_unused int vfio_dev_fd,
 	rte_errno = ENOTSUP;
 	return -1;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_assign_device)
+int
+dev_vfio_container_assign_device(__rte_unused int vfio_container_fd,
+		__rte_unused const char *sysfs_base,
+		__rte_unused const char *dev_addr)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index 099a35aa0e..eb8697e75c 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -277,6 +277,32 @@ __rte_internal
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
index 0a7e3e9c9b..ae53d95de5 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -2161,6 +2161,38 @@ dev_vfio_container_destroy(int container_fd)
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

