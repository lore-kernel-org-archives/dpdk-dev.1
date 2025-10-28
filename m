Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE2CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75DCE40649;
	Tue, 28 Oct 2025 17:43:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 584AE40652
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761669816; x=1793205816;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mPae09HeAxWGic4PJdS6iqd84dB09SWZWB53MvX4Cdg=;
 b=EtlNCODlOeuxIY31XP4yzRP+CLVSmgiZFkpbrxsAsveuU+7nlyb3ltrg
 6zH3MZr4A4+ABFSBpSY/anweg7LQ2AzFgA58lCrTjzHWFAJ+YlUFom+bK
 WpBZf1eyB45xc4ofm38zr9pwgBnDQhCDxDU926rT6U1MTypre4Nerzmmg
 LHKZsgUhul+0QvjzyMTxQxlve3UtwuQPdCmOfbR5yyu+RPKe39vj46RlY
 Jivn9WdfxKYhp9J42CZg81kugAdWBYRDATWDYi72OU2m1r0WThzpuuy1J
 VIIIS72QoUmjQYGrFSRgxcwnpgUezyWUstaKibeuLQ5qd6LldT+lzCK6W g==;
X-CSE-ConnectionGUID: TsxTLSngRSK5dggRRIp+fg==
X-CSE-MsgGUID: EulkaEwYTCySYwKNIGvR8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63663633"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="63663633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 09:43:36 -0700
X-CSE-ConnectionGUID: B+Pre+3YT7yo3oWbSb2RYQ==
X-CSE-MsgGUID: bs7A8qFKQ3qav+FYXgflsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189452776"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 28 Oct 2025 09:43:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v1 4/8] vfio: do not setup the device on get device info
Date: Tue, 28 Oct 2025 16:43:17 +0000
Message-ID: <cd00f3fb3aa4cafe3eb666df0df56d267d7c95e4.1761669439.git.anatoly.burakov@intel.com>
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

Currently, if `rte_vfio_get_device_info` is called with fd == 0, the device
will be automatically set up. This seems like a counter-intuitive function,
and the only purpose for it seems to be code golf, and the only user for it
only calls rte_vfio_get_device_info when fd is in fact zero, meaning they
could've just called device setup instead of calling device info.

Decouple device info function from device setup, change its API, and adjust
all usages of this API.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c |  4 ++--
 lib/eal/freebsd/eal.c            |  9 +++++++++
 lib/eal/include/rte_vfio.h       |  9 +--------
 lib/eal/linux/eal_vfio.c         | 23 ++++++-----------------
 4 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 8562fdcc6b..d7c838d4b2 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1194,8 +1194,8 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
 		if (vfio_dev_fd < 0) {
 			return -1;
 		} else if (vfio_dev_fd == 0) {
-			if (rte_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
-				&vfio_dev_fd, &device_info) != 0)
+			if (rte_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
+					&vfio_dev_fd, &device_info) != 0)
 				return -1;
 			/* save vfio_dev_fd so it can be used during release */
 			if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd) != 0)
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index fe2b017bba..bfc28a9acb 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -947,3 +947,12 @@ rte_vfio_container_assign_device(__rte_unused int vfio_container_fd,
 	rte_errno = ENOTSUP;
 	return -1;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 26.02)
+int
+rte_vfio_get_device_info(__rte_unused int vfio_dev_fd,
+		__rte_unused struct vfio_device_info *device_info)
+{
+	rte_errno = ENOTSUP;
+	return -1;
+}
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 2eba736249..07f49b0255 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -170,12 +170,6 @@ rte_vfio_get_group_num(const char *sysfs_base,
  *
  * This function is only relevant to Linux and will return an error on BSD.
  *
- * @param sysfs_base
- *   sysfs path prefix.
- *
- * @param dev_addr
- *   device location.
- *
  * @param vfio_dev_fd
  *   VFIO fd.
  *
@@ -188,8 +182,7 @@ rte_vfio_get_group_num(const char *sysfs_base,
  */
 __rte_experimental
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info);
+rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
  * Open a new VFIO container fd
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 3b3290927f..2cf24ec290 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1243,28 +1243,17 @@ vfio_set_iommu_type(int vfio_container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 26.02)
 int
-rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
-		int *vfio_dev_fd, struct vfio_device_info *device_info)
+rte_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 {
 	int ret;
 
-	if (device_info == NULL || *vfio_dev_fd < 0)
+	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get device info, error %i (%s)",
+				errno, strerror(errno));
 		return -1;
-
-	if (*vfio_dev_fd == 0) {
-		ret = rte_vfio_setup_device(sysfs_base, dev_addr,
-				vfio_dev_fd, device_info);
-		if (ret)
-			return -1;
-	} else {
-		ret = ioctl(*vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
-		if (ret) {
-			EAL_LOG(ERR, "%s cannot get device info, error %i (%s)",
-					dev_addr, errno, strerror(errno));
-			return -1;
-		}
 	}
 
 	return 0;
-- 
2.47.3

