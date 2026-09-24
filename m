Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD205C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD394327A;
	Thu, 24 Sep 2026 18:14:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B89464324F
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266436; x=1821802436;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vev7SKdnBE0G9IDDX7PV7K+40//LP4H/WRg9Zuiw3Fo=;
 b=IxRNaFvdyxnoPcawWqvJFeUVfZ9ZCmqCzRICltgROnow2s88RjYeDlD9
 WOeXrdwXEnuAUYTXELp8OanHrAbto6liRGAcf9pUKIzSLxWTBO3esr4vw
 3c5UWicb6tk0uNmTDAK/qbCtXCsCqNWNAmjv+JShzsQRnk5HulIvqEsCR
 LhNEgc1luqvEzJzlC+4FIOZdOIqKLlm2T9h50B/W5MdQQpA3ftu3rkhDM
 jq2a4EttCPJ9qxxraAnQPwfyHSJoh6IacUYCireDHaqet7wDWmkYq+sRW
 EjeV1gO3/DcSy0fkD3o/D2jlcwu7LCrHX4wfldf7HYPDPZ91AkJI8Wzqc w==;
X-CSE-ConnectionGUID: l5rY8WCSS1uFOnSEzxY22Q==
X-CSE-MsgGUID: 8and+P85QUW7LTZu3662MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000637"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000637"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:56 -0700
X-CSE-ConnectionGUID: rRP0BAoRTd6v8ILfShedHw==
X-CSE-MsgGUID: PcNDTsZlTd26uyR1tkNqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830006"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v18 08/29] vfio: remove modname parameter from init
Date: Thu, 24 Sep 2026 17:13:15 +0100
Message-ID: <46a46df163c85b58c8a7895a02e945bc2292e2f1.1790266166.git.anatoly.burakov@intel.com>
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

All VFIO initialization always happens with "vfio" module, and now that the
API is not public, having a way to override the module name seems redundant
as there is not going to be a use case that calls into `rte_vfio_enable`
that isn't coming from EAL init. So, remove the parameter, and hardcode
the modname to "vfio" instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 2 +-
 lib/eal/freebsd/eal.c            | 2 +-
 lib/eal/include/rte_vfio.h       | 7 ++-----
 lib/eal/linux/eal.c              | 2 +-
 lib/eal/linux/eal_vfio.c         | 4 ++--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c24990..f3791cce982 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1303,7 +1303,7 @@ pci_vfio_is_enabled(void)
 	int status = rte_vfio_is_enabled("vfio_pci");
 
 	if (!status) {
-		rte_vfio_enable("vfio");
+		rte_vfio_enable();
 		status = rte_vfio_is_enabled("vfio_pci");
 	}
 	return status;
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 991ca450640..5628d60d589 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -839,7 +839,7 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
-int rte_vfio_enable(__rte_unused const char *modname)
+int rte_vfio_enable(void)
 {
 	rte_errno = ENOTSUP;
 	return -1;
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index e76181c83cc..b53ce56a8dc 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -94,20 +94,17 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 
 /**
  * @internal
- * Enable a VFIO-related kmod.
+ * Initialize VFIO.
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
  *
- * @param modname
- *   kernel module name.
- *
  * @return
  *   0 on success.
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_enable(const char *modname);
+int rte_vfio_enable(void);
 
 /**
  * @internal
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 1d0894e7eab..3f92cc32ebd 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -769,7 +769,7 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (rte_vfio_enable("vfio")) {
+	if (rte_vfio_enable()) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		goto err_out;
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index ce247362662..41bf401dec6 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1159,7 +1159,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
 int
-rte_vfio_enable(const char *modname)
+rte_vfio_enable(void)
 {
 	/* initialize group list */
 	unsigned int i, j;
@@ -1189,7 +1189,7 @@ rte_vfio_enable(const char *modname)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = vfio_check_module(modname);
+	vfio_available = vfio_check_module("vfio");
 
 	/* return error directly */
 	if (vfio_available == -1) {
-- 
2.52.0

