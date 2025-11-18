Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04992CEE339
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:30:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED2440665;
	Tue, 18 Nov 2025 17:29:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 98DFF40648
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483376; x=1795019376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RAC/x9wNmuqq7xYeMaQVsDNiNMVPZHgy7KHh5LP5i2s=;
 b=MwiNMhEykxYg2pzxNk5q7HOVWleoVpupAiCL/KkGU+A4BTvCdnP7U9Hb
 fz6fhXqEDyLX4OxD/nhOPuD1LoQZ6Se58FDIybmIKwY7hqV8XWclO+tm/
 ruUNvYjGOGK7RPXXaMF+iOZRSl0aQLur/2+n76yHTrV/28GnOD/Xo5Z+V
 hQf4bohd+dOQt+1Oyk3bUl7TMx1ShFVc/LkGKu6HmdBUXCWmC1P+fFj1l
 dK3Pa6PJmdXDGG6I7QN3uZk2lSnEkAzItVA5YOQPwb/Tc39hQLyqlhRP4
 Z9z5ADcdozWEU2q18vpBqbz9EllyGHgqggg9WSVHjBOhPeYmZANJdBh0+ w==;
X-CSE-ConnectionGUID: Z3oNRGnGRzqcYKmDQTCa+g==
X-CSE-MsgGUID: /w0qbtGBSfeb0SZr9eqyIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550603"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:35 -0800
X-CSE-ConnectionGUID: otW2UCNTSEegi/9/aHodEQ==
X-CSE-MsgGUID: J/DKwURFRVu6m/8N1vlm7Q==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 06/20] vfio: add container device assignment API
Date: Tue, 18 Nov 2025 16:29:07 +0000
Message-ID: <ddcdabd2905480103b3152fc04560011e2629aa3.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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
container, such that when `rte_vfio_setup_device` call eventually comes,
VFIO will pick up the correct container.

To remove dependency on group API's, add a new "container assign device"
API call that will do the same thing, but will not depend on managing VFIO
group fd's.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      | 10 ++++++++++
 lib/eal/include/rte_vfio.h | 26 ++++++++++++++++++++++++++
 lib/eal/linux/eal_vfio.c   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index dea32ae428..a7360db7a7 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -936,3 +936,13 @@ rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 	rte_errno = ENOTSUP;
 	return -1;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_assign_device)
+int
+rte_vfio_container_assign_device(__rte_unused int vfio_container_fd,
+		__rte_unused const char *sysfs_base,
+		__rte_unused const char *dev_addr)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index fb666141f6..e7e2ee950b 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -271,6 +271,32 @@ __rte_internal
 int
 rte_vfio_container_destroy(int container_fd);
 
+/**
+ * @internal
+ *
+ * Assign a device to a VFIO container.
+ *
+ * Doing so will cause `rte_vfio_setup_device()` to set up the device with the VFIO container
+ * specified in this assign operation.
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
+ *   <0 on failure, rte_errno is set.
+ */
+__rte_internal
+int
+rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
+		const char *dev_addr);
+
 /**
  * @internal
  * Bind a IOMMU group to a container.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 47c973e49a..02fec64658 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -2102,6 +2102,38 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_assign_device)
+int
+rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
+		const char *dev_addr)
+{
+	int iommu_group_num;
+	int ret;
+
+	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
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
+	ret = rte_vfio_container_group_bind(vfio_container_fd,
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
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
-- 
2.47.3

