Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA505CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:27:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75FC240268;
	Sun,  9 Nov 2025 15:27:10 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23]) by mails.dpdk.org (Postfix) with ESMTP id CE42C400D5;
 Sun,  9 Nov 2025 15:27:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7yXpS/NoYfkGpEIsKwqinCXh+92xbv6wu8jJfjDDPcEyu/2dNwuj5WXX1yixWDrPInjam5rJWU7VzFqzaac+PNcc6rSibfk+4x251wIj/7PdUdOQusY66fvIjnTnB3ddkN+HDNmCY5WbE5VM08rvYsyKeaJx8WMGxahURRMq34M14X4ugdeHTwKHkDQv7b9a7fuI8dBIFX4AWAN1zwlqv88l6qotQNA4su4WM3Sf8bECq616sc7JNw9dKXUzSmDfNSx+N3L9Q203l7m58wNXfsAJ8cMQ0+lLuHMfoHl90zAcr5Szwm9HagJejHO11KKXe+xRiZJzodkHL76/rHF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHaRt6kA/FGmO6UMyAgLJDkbNY9kGi61ful53tNJXeE=;
 b=uFU7pb/s8Oug3PTdFgnW1NXDHD0D9s/QEntqTUfERh6NrUp5KAaqXFzI7nbXTOkPM8/INHDcsmRz+Nfie8GTqgOvlEl0VIrLsIVhMGEYi44XCskPwT/lc86Jg35kHyOTYksm25ldECfnUWTJfa/Cqoi7OjnZ8FanImRLSI4fkL9FwwbhjQ8LUg2kogV3M9wxoD0pmwiCJePUFa2GwtdK/L/khBwMY05DfaygL1AKG7w9Y7xyFDsjeBBEc0Crv15WlUWvRFZgp5L/LsbQRMfdquhkXkrzfGFUiA4u/34KZ/Tf+BFTs9fKsKElMBJppd4hWLXvcImhVxIhNCeT6mJY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHaRt6kA/FGmO6UMyAgLJDkbNY9kGi61ful53tNJXeE=;
 b=b2WFbgI1/9286oBMqL2/I5BVVJk67HmHD4X6YiHbG3Cf4PNNUL1y/Fg/9RvNdGRZEhRiywAZH7hXh0moMB0It10bt/5ctGkLD1spl7TV16pSzw05UYZUYZOjNRMMSg9SX+Qn9BHGQaISTbzt8CxiVAPyr/YhvQMqteauXRJuXoYsB7mTIAQC7j2erPlLNZ7z3U99LLkK+wIDzM+IxhwozZ9KvzIbCHGb8oftNJkvxBvlkAbi529nPArcHk5vzGijuGLVJDXowyGXEEJC0l8pHvYAzI5wzj8WVG80K/ZxEw851XRWWQkxeWfeYnBehzoOCW+RVHPxgsVoHYlYnKqqEw==
Received: from MN2PR04CA0031.namprd04.prod.outlook.com (2603:10b6:208:d4::44)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 14:27:03 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::9b) by MN2PR04CA0031.outlook.office365.com
 (2603:10b6:208:d4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 14:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 14:27:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 06:26:56 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 06:26:55 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 06:26:53 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, David Marchand
 <david.marchand@redhat.com>
Subject: [PATCH v2] vhost: fix use-after-free race during cleanup
Date: Sun, 9 Nov 2025 14:26:36 +0000
Message-ID: <20251109142636.225031-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104080931.8102-1-shperetz@nvidia.com>
References: <20251104080931.8102-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 38329461-a4fc-41e7-2e26-08de1f9c0d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RN1FSGfnJkQXZXhTIwRI4lOgtbLRSwz2WezDfeuYzW9SlNgNEJtqrbQXd3l4?=
 =?us-ascii?Q?CfhZvmGNlmqCVSjKhf6R4zg4ysPIizZQievioyazHzrVPfaH0sLfgoPTldsW?=
 =?us-ascii?Q?IXXZuQacFkUsR8CYlIyBeWMNybNvwqibiyE4W6pWKLpZ4Mil/nAu+62RhaLj?=
 =?us-ascii?Q?ggv62mOes5lpihvv9yVcIYZjW46FDEKGUuFvIlY6BxOHJ6MRA5dznytR8gmF?=
 =?us-ascii?Q?HzCCZJIXC59FQIqpdM4ukO/mGYk/ZkohmnkSVHPoZdvTYJGGEPImW/xmpw8U?=
 =?us-ascii?Q?omYfBD1fcVtX9HqmihH+LL4PFS6mkt7vv5owfn1ThQ2/SM5hxMX8udHjsISJ?=
 =?us-ascii?Q?L17PZYkT+//Qm6nTQOQZROO4L308F7LZZoxW7hnpvZbCQg3uG4Z8Chp+7c1o?=
 =?us-ascii?Q?xNF5ejJMQ6ID9CqIKJ1qtM3fG/OTt3A0yi7h/ZR905Sy/A389ieue8dEFFZp?=
 =?us-ascii?Q?Ab4LvtRtBndkjjZlYJQd1j+4dri7XOo26yY/0gxV2MpD7AuYUp7wjJR5Juql?=
 =?us-ascii?Q?MQjRBKiJDQJShUMtFqULsqDh5zCCFoy1XVaFFL4EHXCGwiCe09DdovtTvpxw?=
 =?us-ascii?Q?+dvozgS+Hn1IUx0IikqOYmYWetN7NLmThhDcPbPii5WFgpx3thSRsBJi+Ul2?=
 =?us-ascii?Q?SOy7cxEJD9vpqTMgJQjvQW4TMUXVnByR0soqNDoNVk3XBgF6yTGFnbYmcPvh?=
 =?us-ascii?Q?m03fCixXFlc02KOWEqkT2Q7ZMYb5gLCoGk+X1/Di6/d2+bOHz+USw5LIjXKF?=
 =?us-ascii?Q?4+VZQqAzKwLDPz+s98erJvW07/iCyVK9k7o/M/dSk3xKgIrZbSATy6ERIZh8?=
 =?us-ascii?Q?8Eiq4b41ceFaZKiEj/A/zXflY08hk5s3wNODVYL9UR65BbQpohipFajpV7vz?=
 =?us-ascii?Q?Qj3KxFu1ftTqHwelNabh+ypd+sBsg3BFZx0sI1x/ogSM+NIwI2L/d3gpfHYP?=
 =?us-ascii?Q?fpdDkPK2H9N9XBgxAt6X6tdi4vueFFylr6ec+fkAO9tHbooGgC067SYClaUH?=
 =?us-ascii?Q?zuXxAXacSHm2C1kZ76nhQs6vOOQ53fWNCDTE+HlsN0yGf0OHm5RjRTizHnCt?=
 =?us-ascii?Q?56NaSs/iQ+7VmFkQ4E1t/9tHUksZRwhfYsEVGInHL6dvdsuPOAcn7dODKJ6v?=
 =?us-ascii?Q?n2NPY2pCmectx1gEyHuxziPJFYqZWlnS3IUW5+jUJu/LP2O7fTXzF5pk46/u?=
 =?us-ascii?Q?NGyikFWhRmv2hj5reIyTGa0oemQIwJBGZLyPpLnfo7cEtsisLK34lilrga0T?=
 =?us-ascii?Q?NOUNQUdFGiPd9Tm+G4AU3/mhsVi0QmObGVfRRQmdrnBMCy3TpaBmcJohUKdO?=
 =?us-ascii?Q?GLkBdWNDpL2/Ou40GBdmV2CnmLg8kYm2Q55EitsESJLd+mqmKdKpdcR+HFwm?=
 =?us-ascii?Q?PZxibMBM3cYwjmywuh/RE7o/KVY3Fo4T02jvW+8Tr63kM7d135w6HahWQLtw?=
 =?us-ascii?Q?Qv5fzUUnZ4n/Slz565Rd1lUnG9FBLlXu8m55mZrPlc1gJE6X3c7tdwsvi3o2?=
 =?us-ascii?Q?LM9WlExn5gloZmb+zw6zlzto5jbuw+wLNBxcO2K5AOcq6C8EaymP8jQ3bzox?=
 =?us-ascii?Q?boVPsViV7Ut2YZNS29w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 14:27:02.5246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38329461-a4fc-41e7-2e26-08de1f9c0d06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

This commit fixes a use-after-free that causes the application to crash
on shutdown (detected by ASAN).

The vhost library uses a background event dispatch thread that monitors
fds with epoll. It runs in an infinite loop, waiting for I/O events
and calling callbacks when they occur.

During cleanup, a race condition existed:

  Main Thread:                    Event Dispatch Thread:
  1. Remove fds from fdset        while (1) {
  2. Close file descriptors           epoll_wait() [gets interrupted]
  3. Free fdset memory                [continues loop]
  4. Continue...                      Accesses fdset...   CRASH
                                  }

There isn't explicit cleanup of the fdset structure.
The fdset structue is allocated with rte_zmalloc() and the memory would
only be reclaimed at application shutdown when rte_eal_cleanup() is called,
which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
Meanwhile, the event dispatch thread could still be running and accessing
the fdset.

The code had a `destroy` flag that the event dispatch thread checked,
but it was never set during cleanup, and the code never waited for
the thread to actually exit before freeing memory.

To fix this, the commit implements `fdset_destroy()` that will set the
destroy flag, wait for thread termination, and clean up all resources.

The socket.c and vduse.c are updated to call fdset_destroy() when
the last socket/device is unregistered.

For vduse, reference counting was added to track the number of devices
using the fdset. The fdset is destroyed when the last device is removed.

Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>



----------
v2:
- Extended the fix to vduse.c, added reference counting and mutex to vduse
  structure to track the number of devices using the fdset
- Call fdset_destroy() when last device is removed in vduse_device_destroy()
  and in error paths of vduse_device_create()
- Added mutex protection when checking/setting the destroy flag to prevent
  race conditions in both fdset_event_dispatch() and fdset_destroy()

---
 lib/vhost/fd_man.c | 45 ++++++++++++++++++++++++++++++++++++-
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c |  7 ++++++
 lib/vhost/vduse.c  | 56 +++++++++++++++++++++++++++++++++++++---------
 4 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..b4597dec75 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -387,9 +387,52 @@ fdset_event_dispatch(void *arg)
 			}
 		}

-		if (pfdset->destroy)
+		pthread_mutex_lock(&pfdset->fd_mutex);
+		bool should_destroy = pfdset->destroy;
+		pthread_mutex_unlock(&pfdset->fd_mutex);
+		if (should_destroy)
 			break;
 	}

 	return 0;
 }
+
+/**
+ * Destroy the fdset and stop its event dispatch thread.
+ */
+void
+fdset_destroy(struct fdset *pfdset)
+{
+	uint32_t val;
+	int i;
+
+	if (pfdset == NULL)
+		return;
+
+	/* Signal the event dispatch thread to stop */
+	pthread_mutex_lock(&pfdset->fd_mutex);
+	pfdset->destroy = true;
+	pthread_mutex_unlock(&pfdset->fd_mutex);
+
+	/* Wait for the event dispatch thread to finish */
+	rte_thread_join(pfdset->tid, &val);
+
+	/* Close the epoll file descriptor */
+	close(pfdset->epfd);
+
+	/* Destroy the mutex */
+	pthread_mutex_destroy(&pfdset->fd_mutex);
+
+	/* Remove from global registry */
+	pthread_mutex_lock(&fdsets_mutex);
+	for (i = 0; i < MAX_FDSETS; i++) {
+		if (fdsets[i] == pfdset) {
+			fdsets[i] = NULL;
+			break;
+		}
+	}
+	pthread_mutex_unlock(&fdsets_mutex);
+
+	/* Free the fdset structure */
+	rte_free(pfdset);
+}
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index eadcc6fb42..ed2109f3c8 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -21,5 +21,6 @@ int fdset_add(struct fdset *pfdset, int fd,

 void fdset_del(struct fdset *pfdset, int fd);
 int fdset_try_del(struct fdset *pfdset, int fd);
+void fdset_destroy(struct fdset *pfdset);

 #endif
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..0240da8ff0 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -1141,6 +1141,13 @@ rte_vhost_driver_unregister(const char *path)
 		count = --vhost_user.vsocket_cnt;
 		vhost_user.vsockets[i] = vhost_user.vsockets[count];
 		vhost_user.vsockets[count] = NULL;
+
+		/* Check if we need to destroy the vhost fdset */
+		if (vhost_user.vsocket_cnt == 0 && vhost_user.fdset != NULL) {
+			fdset_destroy(vhost_user.fdset);
+			vhost_user.fdset = NULL;
+		}
+
 		pthread_mutex_unlock(&vhost_user.mutex);
 		return 0;
 	}
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 68e56843fd..f255f717ab 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -30,9 +30,15 @@

 struct vduse {
 	struct fdset *fdset;
+	int device_cnt;
+	pthread_mutex_t mutex;
 };

-static struct vduse vduse;
+static struct vduse vduse = {
+	.fdset = NULL,
+	.device_cnt = 0,
+	.mutex = PTHREAD_MUTEX_INITIALIZER,
+};

 static const char * const vduse_reqs_str[] = {
 	"VDUSE_GET_VQ_STATE",
@@ -683,19 +689,16 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 	const char *name = path + strlen("/dev/vduse/");
 	bool reconnect = false;

-	if (vduse.fdset == NULL) {
-		vduse.fdset = fdset_init("vduse-evt");
-		if (vduse.fdset == NULL) {
-			VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE fdset");
-			return -1;
-		}
-	}
+	pthread_mutex_lock(&vduse.mutex);
+	vduse.device_cnt++;
+	pthread_mutex_unlock(&vduse.mutex);

 	control_fd = open(VDUSE_CTRL_PATH, O_RDWR);
 	if (control_fd < 0) {
 		VHOST_CONFIG_LOG(name, ERR, "Failed to open %s: %s",
 				VDUSE_CTRL_PATH, strerror(errno));
-		return -1;
+		ret = -1;
+		goto out_dec_cnt;
 	}

 	if (ioctl(control_fd, VDUSE_SET_API_VERSION, &ver)) {
@@ -845,6 +848,19 @@ vduse_device_create(const char *path, bool compliant_ol_flags)

 	dev->cvq = dev->virtqueue[max_queue_pairs * 2];

+	/* Only allocate when we know device creation will succeed */
+	pthread_mutex_lock(&vduse.mutex);
+	if (vduse.fdset == NULL) {
+		vduse.fdset = fdset_init("vduse-evt");
+		if (vduse.fdset == NULL) {
+			VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE fdset");
+			pthread_mutex_unlock(&vduse.mutex);
+			ret = -1;
+			goto out_log_unmap;
+		}
+	}
+	pthread_mutex_unlock(&vduse.mutex);
+
 	ret = fdset_add(vduse.fdset, dev->vduse_dev_fd, vduse_events_handler, NULL, dev);
 	if (ret) {
 		VHOST_CONFIG_LOG(name, ERR, "Failed to add fd %d to vduse fdset",
@@ -861,6 +877,8 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 	return 0;

 out_log_unmap:
+	if (vduse.fdset != NULL)
+		fdset_del(vduse.fdset, dev->vduse_dev_fd);
 	munmap(dev->reconnect_log, sizeof(*dev->reconnect_log));
 out_dev_destroy:
 	vhost_destroy_device(vid);
@@ -870,6 +888,14 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 	ioctl(control_fd, VDUSE_DESTROY_DEV, name);
 out_ctrl_close:
 	close(control_fd);
+out_dec_cnt:
+	pthread_mutex_lock(&vduse.mutex);
+	vduse.device_cnt--;
+	if (vduse.device_cnt == 0 && vduse.fdset != NULL) {
+		fdset_destroy(vduse.fdset);
+		vduse.fdset = NULL;
+	}
+	pthread_mutex_unlock(&vduse.mutex);

 	return ret;
 }
@@ -899,7 +925,17 @@ vduse_device_destroy(const char *path)

 	vduse_device_stop(dev);

-	fdset_del(vduse.fdset, dev->vduse_dev_fd);
+	if (vduse.fdset != NULL)
+		fdset_del(vduse.fdset, dev->vduse_dev_fd);
+
+	/* Check if we need to destroy the vduse fdset */
+	pthread_mutex_lock(&vduse.mutex);
+	vduse.device_cnt--;
+	if (vduse.device_cnt == 0 && vduse.fdset != NULL) {
+		fdset_destroy(vduse.fdset);
+		vduse.fdset = NULL;
+	}
+	pthread_mutex_unlock(&vduse.mutex);

 	if (dev->vduse_dev_fd >= 0) {
 		close(dev->vduse_dev_fd);
--
2.34.1

