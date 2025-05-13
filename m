Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A092C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 May 2025 09:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FBFD4026C;
	Tue, 13 May 2025 11:52:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B6C3A4025F;
 Tue, 13 May 2025 11:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747129927; x=1778665927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3ZJ1b/rn/7LfvQq57Dmsm7T1MUZo82gqrjwdBhSGgok=;
 b=ZOprMdqgeWIatclIfTqkhluNB64fewqFM83xnrM711s47t3HMh1nzzfk
 wCd75IGMWGPg+FUZ4ysBHtrujoTmSikG60aMPCjfE8+VYejyLtn6mNLwe
 xpXrm544p0cBRZ4snqSkTyfepkPb85B7juO3DEupyjHHNz9qrO97KGhjy
 sH51USdUgu9E0EjGSbGtwKPmXnmNdw5qpaBq6q1e3txJCQlreC0CciSFW
 q+vlziKpqJ4b7gBCUuz4u+dBKN2oDZpqEoRMTBTu1O5beSLKDbpHjt3tw
 wtvWJEXOqcoVhFKbHEhHcEhBOkbcKeMs0f28LuM+VJ4AuGB/WxDv87ACP Q==;
X-CSE-ConnectionGUID: S61r9oIbRVyAVjmPPQFfLw==
X-CSE-MsgGUID: zSjOtE/rRLC4adJnWkeXGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59604455"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="59604455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 02:52:05 -0700
X-CSE-ConnectionGUID: B66v02DpRg2QzqmiR+PIUQ==
X-CSE-MsgGUID: 8kLwusCPTJGZNw3Q1qc+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; d="scan'208";a="142419141"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 02:52:05 -0700
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] bus/vdev: revert fix devargs after multi-process bus scan
Date: Tue, 13 May 2025 09:21:56 +0000
Message-Id: <20250513092156.1198659-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314093630.1066948-3-mingjinx.ye@intel.com>
References: <20240314093630.1066948-3-mingjinx.ye@intel.com>
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

This patch reverts commit f5b2eff0847d ("bus/vdev: fix devargs after
multi-process bus scan")

With current code, we do not add devargs to devargs list when we add a
vdev in secondary process (because `init` flag is set to `false`).

Because of this, when we do vdev_uninit, we call rte_devargs_remove on
the &devargs pointer (the one we didn't add to devargs list but did save
inside rte_vdev_device struct), but in secondary process, because
devargs were not added to the list in the first place, devargs_remove
does not find the associated devargs in its list and therefore does not
free associated resources. As a result, we get a memory leak, because we
free the rte_vdev_device but not its associated devargs.

Revert this patch to avoid leaking devargs on vdev uninit.

Fixes: f5b2eff0847d ("bus/vdev: fix devargs after multi-process bus scan")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
v2: Modify commit log.
---
 drivers/bus/vdev/vdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index beee8c4033..7d5f862ff5 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -269,9 +269,7 @@ alloc_devargs(const char *name, const char *args)
 }
 
 static int
-insert_vdev(const char *name, const char *args,
-		struct rte_vdev_device **p_dev,
-		bool init)
+insert_vdev(const char *name, const char *args, struct rte_vdev_device **p_dev)
 {
 	struct rte_vdev_device *dev;
 	struct rte_devargs *devargs;
@@ -304,8 +302,7 @@ insert_vdev(const char *name, const char *args,
 		goto fail;
 	}
 
-	if (init)
-		rte_devargs_insert(&devargs);
+	rte_devargs_insert(&devargs);
 	dev->device.devargs = devargs;
 	dev->device.name = devargs->name;
 	TAILQ_INSERT_TAIL(&vdev_device_list, dev, next);
@@ -329,7 +326,7 @@ rte_vdev_init(const char *name, const char *args)
 	int ret;
 
 	rte_spinlock_recursive_lock(&vdev_device_list_lock);
-	ret = insert_vdev(name, args, &dev, true);
+	ret = insert_vdev(name, args, &dev);
 	if (ret == 0) {
 		ret = vdev_probe_all_drivers(dev);
 		if (ret) {
@@ -456,7 +453,7 @@ vdev_action(const struct rte_mp_msg *mp_msg, const void *peer)
 		break;
 	case VDEV_SCAN_ONE:
 		VDEV_LOG(INFO, "receive vdev, %s", in->name);
-		ret = insert_vdev(in->name, NULL, NULL, false);
+		ret = insert_vdev(in->name, NULL, NULL);
 		if (ret == -EEXIST)
 			VDEV_LOG(DEBUG, "device already exist, %s", in->name);
 		else if (ret < 0)
-- 
2.25.1

