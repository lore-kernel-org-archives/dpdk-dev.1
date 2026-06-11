Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF7CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D53A4327E;
	Thu, 11 Jun 2026 17:09:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C409243276
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190577; x=1812726577;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3mqeqyqvTwfR4MOw36NsxnAZBAoQRptnJzNgO/9+wTM=;
 b=b0p2XZ6XJnB91PrBYfF3t90JKvH14V2lWUPj3IDbTptVAsiW7Wv/gops
 8w5ax5wNW7QJ1urIxuTXQIr4k57rxzQMkV502Imubm6D3N9iZN4Ia+q4N
 qahMa5LvM5DuQQH8k3erH73g2xWloUqmrJC3E9WhOlr0iCEVAilp9FHTV
 FwS7yz65usFArdOzPw42wMuZKdwKzIQT6eMPCdrxOrHcYE0q6dmLizrqx
 GRWBmNnr4aJSL8lhINoTgdW5muixPOxKc+IURs2a5qpkt2aOO+NOO0Hdm
 nOCKjCwhfen8/NKjJ/VC1nzh5xgHPA6+Gkf4zvTjzOxh7aQhwYwzTfV7s w==;
X-CSE-ConnectionGUID: 5aP3VdhCT+u814ZcJb/omg==
X-CSE-MsgGUID: q9Xh1FYISv67zQmAayJaLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845366"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845366"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:29 -0700
X-CSE-ConnectionGUID: AyMl4u0dQ064qCYikpdsbQ==
X-CSE-MsgGUID: tXJeBKTQQgO/Ld+O42250Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625187"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 04/18] vfio: add container device assignment API
Date: Thu, 11 Jun 2026 16:08:56 +0100
Message-ID: <540fcf5cb36f3771b2013b0f1a48e952ea5e1eb1.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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
index f8ab932962..0c64a62c5a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -944,3 +944,13 @@ rte_vfio_container_dma_unmap(__rte_unused int container_fd,
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

