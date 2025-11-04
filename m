Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1ABCCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 08:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7E54066E;
	Tue,  4 Nov 2025 09:10:03 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by mails.dpdk.org (Postfix) with ESMTP id A2A3740651;
 Tue,  4 Nov 2025 09:10:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbLwm5LoaX2dNDJ1l+Xdah6yaRl7RLsBzh3JTjw4bOHrbYVePgmQVUTA93WNB4gYNpuW+t13PeJqm6IF6fn7lbwV8TpQO9413UQXZZNc9ZnNyf05XCPatcG0yR6C5s98iV2wdAxokzTzuQJignb5ZUV1Pb/nOujtp6pFA5OqFFv+P7QXJLoY/IA8PzhA3GA94AmEwoflp+y7XkFx/3vEMTszzhp48sqWWxUhHQ38Ojx1BME0lTsjWixOuS1p/711YZ5P1eHM/ZOe+/KiLS6qNo0RNc8wh6yjaCzaVt99YJv0u9xlqng9qX7AyttxyCRRbF2cbZLsoZ3fyBGf8F0d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UG9On9hGpM6kE926ckqfsBARgyolDAx0Kip1m3FgzMg=;
 b=H722qGWYaKoaBgXJ/GQR24C7K1l410lqz5Qbu1f0hiDhpGxbEJMu5V5AtNeZXOBMf4P6+FW96DokNjLkvu5Y2fW72+7JDFLfgcZvTx5OxxUxSHIHRMisEzx4nXk5gzfQuL9lkA2IFBjtyZ4QZAwcRDJz7iA4bvZqwK8j3yFR8iMEhFJND9IOuC+Xoc/grako3n9WwNa+NAy1ejZh5lCJ4xhdWwVmgiTO9qksFasWn3Vc7QPhX/9L2s9XOxU/KKoCFg81WRSj3NBkRABYvufXgoHE6QIH9CTiV5TwGyLeUeGGrqms853CziUA5WBXrlHnnx8faEFDrncPbydZ0tF2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UG9On9hGpM6kE926ckqfsBARgyolDAx0Kip1m3FgzMg=;
 b=lVonfYozu2kLQljrDK6u757FB8m6qrigq7JgmkmQtN5S/91EAn2X/zP2KBCCcUIydrcG0MBXsfoYNcBAdhFp9O8GG8/1wvCofvtSgBQtclt60TcCXZ83cTFYunhyzv89da94OZEHr8l8CUC9G1cPhwLu98ncAwvi+M+yuxtDekHdkLKpTJx+qVjif8xz0bm+ZhpwuY2aSgsstS4NLIN5OCC8h9vWkUrR8Zkkt5CtHx2xOIyucFROUdH3hAWym+o/OyPviHC66cBV6FaSFL34eWMojAQqfxls/nws8GKqx021p2YCmoof2EFw/8i6v6vMlG92vJRibTqSW3OeJJ7EGg==
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:09:57 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::df) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 08:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:09:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 00:09:37 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 00:09:36 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 00:09:35 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, David Marchand
 <david.marchand@redhat.com>
Subject: [PATCH] vhost: fix use-after-free race during cleanup
Date: Tue, 4 Nov 2025 10:09:31 +0200
Message-ID: <20251104080931.8102-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: f2be1ba6-c6ec-48b4-6b11-08de1b798b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PsmE2fagLtcEq3q29TmEnB1AAmO1R3/BNWN+L0YbzJs4/XwAH2xM7+xGeJja?=
 =?us-ascii?Q?/bG1cHxegsA18BcAFAl51ytcLGmxON0NE4SHvGVV6jLIVlZVmyshycmHZDlW?=
 =?us-ascii?Q?xyt3rgz6/txhnXFwspiMa63a7mneZMEeGe0MySEVn1wlSE6o+5VSb99GB7Du?=
 =?us-ascii?Q?mY1VlkYrz1oZJI6rr12jOzff6RJ6LGlZNRqTeykDHPYSyr3w/E+5iMNjOJkY?=
 =?us-ascii?Q?OPk6SHfmVIqkzAEHMX1GScrydb1LPDyuBArj8JfkAmUlw0+JaAESdfAhq/xn?=
 =?us-ascii?Q?XuRsWADh3CnifUQPkEyOsgB9SdITm8clAl561LK1I+u77TXmtARs/llKeeF8?=
 =?us-ascii?Q?KjA8CtSADA0UaJPDAuhkhb6X8BU4wFaziDyBVKHVYNnH4qR0ZmNHEmy8Vm5S?=
 =?us-ascii?Q?ujjavMxDlocMxv+kZg4ZmBujwBRaWSUGcUFowORgBfVrTqMM5eFJbqPB6vMs?=
 =?us-ascii?Q?yBZlJxj3Y1gPTSe80V5HNE41ihRIi8MDyb2iaecd+F6NbWsJshBRpBsPebcM?=
 =?us-ascii?Q?Xaq1lXE8WKyquVr1GA34C4VQy517XOqdtSzf/j9g98NmXThKYsA+OkGBRF4V?=
 =?us-ascii?Q?+p2aIg9nY8hIINNqt5AfvXiHnmlJIajvqul+PK1Y+jn9VfEuycrmeSzafIbj?=
 =?us-ascii?Q?VpTwjeAow7tWB+UlkAeNe7LzTnOUIB3TmG0tZSndFjVfg0ib+DWdUf6jNC4m?=
 =?us-ascii?Q?RlARYbWXc8pLS10PzZG70B4ffoNXmjZ/0CKj4fZJRqD+hJxb6HMIVIWg1PvQ?=
 =?us-ascii?Q?LVVVFP2lK7ZasReiHgQ0/3YNuafrg8P+JJ7IZd/IWtWwwssE/m0Hjhl9pYQC?=
 =?us-ascii?Q?wIPP2qMRJQkaBi6CpKfjWK1CQygG/6pNX9NZIfrssyeJIVkNk0a06SfbaS5r?=
 =?us-ascii?Q?VeqF6Q/IzOJJzBg49Htl4ACsKpNVVflTZT0xLREr6w7vF02lXf1BmlsDPsqa?=
 =?us-ascii?Q?rsclXeNEEuT7i8KAJ9TZMCGLtboSfDv1FOkTYBVS+JrTzB8eKzvHTOgD16dC?=
 =?us-ascii?Q?fd7iEMj2SsscZVQJ/7piGgN3ciKgeYeZi1036SJDJJouOCSs/60NS3mGSyim?=
 =?us-ascii?Q?4NIbc2T8cF1vS/M543I5pYhBu4ITTyUvL9N+SAPUlfC5QQ7Pz1RUrlUq7CNf?=
 =?us-ascii?Q?w8si2oTc1/zK0tRnfcNokruQjxRka6sDE2K2XOQSJgir15QTf5DHWMMN7aYF?=
 =?us-ascii?Q?j4kdWditsKzEih/3BQvGzyubnbDrEcf05/pR46jpLXiwNk+pQggEArU/dgxS?=
 =?us-ascii?Q?661ozlLyM7M7rqRsOzk9Iv/DVlKYyZ6BuCqHV0j8p0hws7cCwwXRDEjm9XUO?=
 =?us-ascii?Q?ufW8C1zn7b8JIPxLeZ/t5V4Y3NdYX60Z6RqTPDa4aUYYdazoUg7k9Kp1R10l?=
 =?us-ascii?Q?WI1YpTxaFMzvggzwlJCVWu61JltZ+Ph+wkPGqC7PUYrI9s8duYtXn25+GL9y?=
 =?us-ascii?Q?wQttq/4JWcZ80gcgz613EFoquvhFzJ5ODvb1ijWICKol4RFd/5jGZDRrxUXr?=
 =?us-ascii?Q?Sv8YM/xhqiMO375VPHPz2FGK5r7R4rMjIhdmOvycp7bsVgH7mxbrQCMgTpiu?=
 =?us-ascii?Q?HgxaL/m4jjlC+G6kV04=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:09:57.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2be1ba6-c6ec-48b4-6b11-08de1b798b15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

This commit fixes a use-after-free that causes the application
to crash on shutdown (detected by ASAN).

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

The main thread would free the fdset memory while the background thread
was still running and using it.

The code had a `destroy` flag that the event dispatch thread checked,
but it was never set during cleanup, and the code never waited for
the thread to actually exit before freeing memory.

This commit implements `fdset_destroy()` that will set the destroy
flag, wait for thread termination, and clean up all resources.
The socket.c is updated to call fdset_destroy() when the last vhost-user
socket is unregistered.

Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 lib/vhost/fd_man.c | 38 ++++++++++++++++++++++++++++++++++++++
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..ba1b2ead86 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -393,3 +393,41 @@ fdset_event_dispatch(void *arg)
 
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
+	pfdset->destroy = true;
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
-- 
2.34.1

