Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85231CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B7C402F0;
	Fri, 16 Oct 2026 16:02:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B5B9740291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159347; x=1823695347;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DEdYAcB4uTwyu1ciFZRNkPrnOmehhGVJ0Ed6t1sCcZM=;
 b=al21qIoRvSuIcqs4k58sS0hlqdPB71Ufok6HFcUDhYjM6ks3rXOvj/7E
 vpRBJuo3JIR1BpkcEoClhlxQPu2XcBRYm6hX6RswRZ4DYTGTpt1Peojb3
 2NTkGbeqMY6U3ah2DVyU0bAbmcTA1Tt+0UnFUh4dShHuVnc8Et6YnYP5h
 EytuLPapmEIf98uMM2K/Rk5PCaw+dWiilyAspnsNwsw/CByfeMnMvNAht
 OtGSTSkN996YrEv6hwy6/m5Q20t9xN6Cmgh160Ty/egOxVIqkFzWG+fYU
 gI65Cqsv+y1lwutYKjSHq/83yHmSuqbW4ufnIT9/KSCoadCMiqZr4ilhS A==;
X-CSE-ConnectionGUID: Am+gxFqvQTe71hfeV0tMYg==
X-CSE-MsgGUID: HP1LFfEJT5yW9Oj7eCSNOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043665"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043665"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:22 -0700
X-CSE-ConnectionGUID: cfU03n/UTZix6B/qYiYXKw==
X-CSE-MsgGUID: IkB6K1MYS1iwNyCP0mzW4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951657"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [27.03 RFC PATCH v1 2/8] vfio: use usage counters
Date: Fri, 16 Oct 2026 15:02:09 +0100
Message-ID: <5d03ffc85e61600f1433291fe493921c9a33d1cf.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
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

Currently, resources in VFIO (such as groups or devices) are tracked for
first/last usage due to things needing to happen on first/last reference.
Use EAL usage counters instead of manual arithmetic and checks.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio.c       |  7 ++-----
 lib/eal/linux/eal_vfio.h       |  5 +++--
 lib/eal/linux/eal_vfio_group.c | 11 ++++-------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index fdf500cd5b..056795a6e4 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1125,11 +1125,8 @@ dev_vfio_release_device(const char *sysfs_base __rte_unused, const char *dev_add
 		/* close device handle */
 		vfio_device_erase(cfg, dev);
 
-		/* remove device from group */
-		grp->n_devices--;
-
-		/* was this the last device? */
-		if (grp->n_devices == 0)
+		/* remove device from group, erase the group if it was the last device */
+		if (rte_usage_count_release(&grp->n_devices))
 			vfio_group_erase(cfg, grp);
 
 		/* if no more groups left, remove callback */
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 980bdae0ba..8aaff4f335 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -7,6 +7,7 @@
 
 #include <rte_common.h>
 #include <rte_spinlock.h>
+#include <rte_usage_count.h>
 
 #include <stdint.h>
 
@@ -42,7 +43,7 @@ struct vfio_group {
 	bool active;
 	int group_num;
 	int fd;
-	int n_devices;
+	rte_usage_count_t n_devices;
 };
 
 /* device tracking (common for group and cdev modes) */
@@ -66,7 +67,7 @@ struct vfio_device {
 struct vfio_group_config {
 	bool iommu_type_set;
 	bool mem_event_clb_set;
-	size_t n_groups;
+	rte_usage_count_t n_groups;
 	struct vfio_group groups[RTE_MAX_VFIO_GROUPS];
 };
 
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
index 7c879830ac..55ada5046b 100644
--- a/lib/eal/linux/eal_vfio_group.c
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -508,7 +508,7 @@ vfio_group_create(struct vfio_container *cfg, int iommu_group)
 	VFIO_GROUP_FOREACH(cfg, grp) {
 		if (grp->active)
 			continue;
-		cfg->group_cfg.n_groups++;
+		rte_usage_count_claim(&cfg->group_cfg.n_groups);
 		grp->active = true;
 		grp->group_num = iommu_group;
 		grp->fd = -1;
@@ -527,10 +527,8 @@ vfio_group_erase(struct vfio_container *cfg, struct vfio_group *grp)
 		EAL_LOG(ERR, "Error when closing group fd %d", grp->fd);
 
 	*grp = (struct vfio_group){0};
-	group_cfg->n_groups--;
-
-	/* if this was the last group in config, erase IOMMU setup and unregister callback */
-	if (group_cfg->n_groups == 0) {
+	/* if this was the last group in config, erase IOMMU setup */
+	if (rte_usage_count_release(&group_cfg->n_groups)) {
 		cfg->dma_setup_done = false;
 		group_cfg->iommu_type_set = false;
 	}
@@ -880,8 +878,7 @@ vfio_group_setup_device_fd(const char *dev_addr, struct vfio_group *grp, struct
 	dev->fd = fd;
 	/* store backreference to group */
 	dev->group = grp->group_num;
-	/* increment number of devices in group */
-	grp->n_devices++;
+	rte_usage_count_claim(&grp->n_devices);
 	return 0;
 }
 
-- 
2.52.0

