Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1211C56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7447240A71;
	Thu,  6 Aug 2026 16:11:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 17D17406B7
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025495; x=1817561495;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yunFJeFZC3LLQGkacybHYz+bakTsf3t4WbauW8nkRuA=;
 b=gd7cMrKzuFie7R/Im7gpuwzdVyJGQ+fBshLnG8yVMKTPwTYg4w8NNjGC
 WpPQgvrEXfiljtItAUTSIU0LtgKX1Xb8KFHi08mk+iYdT6hmPodAdbt5j
 4K/TvgnmmJu/W0UexACu/1rRThNErapCEa1kv94RPSMt19Qzx+dE30Cp4
 b2Iy67xj+KraCwn5bVQQNGgLVc5OAevWnmnx52FglVm4WpQq15ulcUlNe
 XbM1Bc/vIpz3IOn7+ViSxymw5hawznfXgrry0GNLA90RTMpAqKGOWv3nK
 2N9muCmCXM2JkZqhEg+Cnt4rduWie/rCDhmgBFSLi/JKsfGxU8eLeyvEt A==;
X-CSE-ConnectionGUID: fk7k7q2lRROd+6zUAIdjmw==
X-CSE-MsgGUID: wYNXOCrrQlajLxqZyRsViA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85589968"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85589968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:35 -0700
X-CSE-ConnectionGUID: BA8tRptoSAKbhVJOCOYKQw==
X-CSE-MsgGUID: wcSM1peJTJqedJGNIw85qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015163"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 05/20] vfio: add container device assignment API
Date: Thu,  6 Aug 2026 15:11:05 +0100
Message-ID: <d3ed763cf2a744cb88ebd305d510867a4f50083c.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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
index fb666141f6..4890ecf06d 100644
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
+ *   <0 on failure.
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
2.52.0

