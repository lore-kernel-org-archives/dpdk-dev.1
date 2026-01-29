Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2CD358E2
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 08:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3149A4026F;
	Thu, 29 Jan 2026 09:35:08 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by mails.dpdk.org (Postfix) with ESMTP id 647CB4026A;
 Thu, 29 Jan 2026 09:35:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6KgZFpG5h14UNP1xkh2bF2/SHRZJQUKakkb0MN4CA6ba+YW5oiKHbV/wxz7o8aHgAfFcXovD4Fb4ndmvi7fQaKSE4pCbYrBbbbUi4l4S4BwQ/YcM34e6XqBGw0ndsZa1Ro+EMCtSGXxXxTn6Rcin562sCz1lbSFVaY/bS3ViLE6bklLuDamPL1uSOKQYV92Dl3e/wO/v52NpsWwoMHaHxi4QEHsgEK03heSxsnOhLW0rdTNZ1WhLivf/AsMRxt/2TqaRGgMiy5VPy1tpP5XMTvMhs5qiWjAac/uQmwPLd8nsQpUTb9vD2t0F0YwKMWT9VuO2bgg7S1+MoI2ZMfpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1ZYnpa11TAqL4eyTLJNxQB8rY8uv/iINnnLAywq7lA=;
 b=c9ps311i/jzUrduXiThlfo0AV2PEXfIQpbyqGRVK0QbnbI3csCxKUeOArKELX1z8C+4HWa/fClW3iVXhvLIbeExP/blFcprNdPkyWAXdGFyDaC4r4n5HsLgRHDcBpy3dBeUyZHLzWVrdTZLCcOCmRHir2WmCdR8rHBmpjOnlA3L310QU+Qy+2Y5mGF+RpmyQWv9Xg8GEdVRPfUsbRu4vF4EsuQZN6Qj87TpZFamqR66/JPY9+J66jwKLb2YSlEo3J+p/luM+MFPbE/xa8YuvS1eQxTnvDW/HJM2PWKeklzWk1JbyVKQDnDnrSdcP2M2bGMjpUAFwRTUfQYzG9SP0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1ZYnpa11TAqL4eyTLJNxQB8rY8uv/iINnnLAywq7lA=;
 b=NELF/I0cvADaRxpNhuF8HYvb+gJxXb/n8+GKYs1u7g/BmaINK5bGGPGUhv7jX8peHHA81B7cMxlrmWupQiRolZGSCuLTzh9wADEeVAPGNbrbQ3J9UnRrmqO0tH/nNE/Uxzsu7LF03ljBRAAVXl0cMUtYC+0qu+wpiLZfhIfw+0S/ZjLSU5DQmp7mGcfoeyR4iqKwkxMk7vDtIHykEgWIPjNWL72CS1SaiEMnx9ZCR2/1lEcxXGHpCKe7YBFO7r2Tr43K6p+w+4d35mehAX5Q4AZk0BAR/YZdLh8EfGCyESMtEdbsXybjeVXSaxYw1uvGRHUf2/RJLLN8ajz1xs5Ueg==
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 08:35:00 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::fd) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 08:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 08:34:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 00:34:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 00:34:40 -0800
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 00:34:38 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <maxime.coquelin@redhat.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, David Marchand
 <david.marchand@redhat.com>
Subject: [PATCH v3] vhost: fix use-after-free race during cleanup
Date: Thu, 29 Jan 2026 10:34:34 +0200
Message-ID: <20260129083435.5054-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104080931.8102-1-shperetz@nvidia.com>
References: <20251104080931.8102-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9623b9bf-6675-4928-428b-08de5f114a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YZOOGE0WltRlmGFOdkwfUI/B5p6aDQ671kjdZ2qimhNCv43oF1Ou5aVJX9Vs?=
 =?us-ascii?Q?Y0IAdk7Rhuwzvwwid6yO2OIF56vI4u0rWpaN0aiGzbkK8VOn09SO2Nr+S9ux?=
 =?us-ascii?Q?yjC4e6TFs3Z2cauJv6qF8SA0cXaw6eyd/D63qGFwPPAFCNNioTDTTlVX3hW6?=
 =?us-ascii?Q?7R42kCCZlGv7EmN3BiCMfn4CR43/p7t9ezWst4Tm/K4hzoNqkz5BeDTwhE99?=
 =?us-ascii?Q?/8Cl2sOHd7HOaw278h+RXkgUbKpK7Ru9fp7Tt7hzYSkWNccnFBRgsa6J4DwB?=
 =?us-ascii?Q?tu4M7fy1jxCcfPCX1B5zUWfbH2ltadQ9UHx4Lwz14raQds6IfxksYp7V9lwL?=
 =?us-ascii?Q?bXNSKpWV2F4N6pMajYOXksM5HUtJfReLOGxTm256fhv1mmOT604fDi6lnJz+?=
 =?us-ascii?Q?tfDt0ySjQbE9IoMAJWYIjvS2Sw4fs3EeKpDnK/YLELEQBJ46/s5MaaLhtpum?=
 =?us-ascii?Q?/MHHiRS5COgwe4LjmSo+Db+DeJCMdpO/PlBr5nDR+PRI9/LdfWEiTr5ZwCjk?=
 =?us-ascii?Q?OU2b/Z3Ih3PYGZbaevwF6czVatph9598A3wF50OnDQ9aAZYyuQugthemwvI+?=
 =?us-ascii?Q?Qq0eE3N/lE7pf/fCiXrrlgY+5LUb160w9jzmHGqvkiaXsE3WAIBTb1rOR/J9?=
 =?us-ascii?Q?rzEEhywUxQBvyJFZjgm7PPRTSCf4W1Ts2ecPMORFBIvFHxmwtLDiU9EDj92J?=
 =?us-ascii?Q?0VACNqZhmsTT8YcIzExRmds/kJWMqpTlfYvvO9huqLMJ5FuwLjPe3pe5DUDt?=
 =?us-ascii?Q?jxUNjq2grmZlPc9SiefPaydcoyNY04fLp899dq3j1/QJlTtqipRLxbTH80hg?=
 =?us-ascii?Q?uUZWksL0mhofOWgEoBgbLfjbgRIVLAZL5JTOt2GTZ0V4JEtAQbbCmdVynGIN?=
 =?us-ascii?Q?0GtPFrJiNmxU70WWpYjKhL9mdZiTXlMs3rM8hH9obsJ+x9DlXkT/k7Ryu7Bf?=
 =?us-ascii?Q?vAn+7iAMLZlXgfsuQS3bDZJdz/lusHOKnzjgj7NwCm+2nrS5ey80ygUC12SO?=
 =?us-ascii?Q?jn/1Na98k8CdQ1HQncqQUlN2QsO1hCAfHVpiUkp96jPUn3OmSNnievdQET4u?=
 =?us-ascii?Q?+0KzvmzTvnMWDJV/wbPlbHDpH9f/m2TNZ6nU3JU4h25pJ/iP4BUYyzw1zREo?=
 =?us-ascii?Q?UaNgRQjGGi6iHhamnePuMbv7ht/tr3qC47jf+SyO1vd332VE7p60+pFZ9jJS?=
 =?us-ascii?Q?FjePZoO4nD9WG53Rp24pU990i3/k3w940FMLQbcr16ARFR14IJSg84tymTl3?=
 =?us-ascii?Q?Sj3oidbc/7avp/ZZvOrbDCRtdqP+9SYm+VohJliIKdRtLd3xwqy4XWk8CGbZ?=
 =?us-ascii?Q?2o8g1FZFwZqspOnY3Vp5TbWJ1SreW0+qYbKhfarL0pQRT7bf4bcxiK7Y44t5?=
 =?us-ascii?Q?FuosPb9BvMhWtHmn02DQN7cpBLNQ4A+Bbew2ZqQ5hIjOCgXt32C3hhu9/wrb?=
 =?us-ascii?Q?ryGHzwxfQaeMvkWN/sYS37chzhqXBCZemoTxsVQeVfDwed5z5L5XCeoX/Xzr?=
 =?us-ascii?Q?nDNYJ0y2LZZo+MONgca7QUqINFaNF/FIasGqkYm+7L28TiA8Mqfsa4cMXaeE?=
 =?us-ascii?Q?jt3cDjysiUmfH6lDUWUnsDghgy70toPzIr1HEfCNjZKbvmQLT/rxNUTvAWov?=
 =?us-ascii?Q?FgF38OlYFlMsqbxTGoVn1EppCn0Vluo7qi0nkzpChiq2CS61SeuTVyQHdj/Y?=
 =?us-ascii?Q?fa8fdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 08:34:59.5301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623b9bf-6675-4928-428b-08de5f114a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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
  3. rte_eal_cleanup()                [continues loop]
  4. Unmap hugepages                  Accesses fdset...   CRASH
                                  }

There was no explicit cleanup of the fdset structure.
The fdset structure is allocated with rte_zmalloc() and the memory would
only be reclaimed at application shutdown when rte_eal_cleanup() is called,
which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
Meanwhile, the event dispatch thread could still be running and accessing
the fdset.

The code had a `destroy` flag that the event dispatch thread checked,
but it was never set during cleanup, and the code never waited for
the thread to actually exit before freeing memory.

To fix this, the commit implements fdset_destroy() that sets the destroy
flag with mutex protection, waits for thread termination, and cleans up
all resources including the fdset memory.

Update socket.c to call fdset_destroy() when the last vhost-user socket
is unregistered.

Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>

-----------------
v3: 
removed vduse implementation from this fix

---
 lib/vhost/fd_man.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c |  7 +++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

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
index ae95e7e6b0..eb01231478 100644
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
-- 
2.43.0

