Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A4606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SL5kLkgf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD470402D8;
	Fri,  6 Nov 2026 15:28:42 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 2A636402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 15:28:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTt45wvGJ+ppSLFgAAVv0xS6gYqvDozX3c2xnIk+5QFGr3CxSq8BSN4iksz5Mzmw8TS4Qmx8Nu9acyprPmxbRBJID3sAixgrm9WVJb5lvDeM99y5aIl0s2UGNrEOtX253AK7Ct9DzEf9gjvVdCv/SuT1KWlrE/pM+71YtXjTvhKnIiRQqEPSOs3EHAWEU9Y6yThyOcGOO/A6MlAs4SrmYsWx4ouBEX1L15uz+dcPqWJdLvso7FO0ur+WZ2gyonRM0dQJXtDbprH7VXgqWCwOk85Lbf6yH+lEm3EAVNlg910t7G6b5dej5X25fCnODqudzBNTj6MsWFMu10nLORCtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPmExVGXtzZ6c8VIw8A7Haa++ecaqffH9es/hKZep9s=;
 b=PFSJehoSk2/iGe1iwWs4n4RhVn59KGBbJQ7uT131sGipB99yYuC/2IhGqbNStV8QExp0XYPvEVGXbQ/5vuGATLcz86YCidBX4nxewRTtmRwH4poCvBSAdZLB5rMVqciKUST2Wcu6uCfk9dbaaGwnsRNaK7YIDxf6zbDnpOu+1mT/ehJ/2eEVRYyHjn0h/SrtD980AFeZu+A1g6c46dsfq1V02WG38sdSiMLTtaNvK2sMAm8S1Ke8DUzFn0yTLR/34H8bAydiyGRWQajHYoOavTUy85EiH/GmSxgIIOobJnC22/dYbcLfEp+4UE91m8nYRvu5K9dRcN+Mo9Y2Q3lutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPmExVGXtzZ6c8VIw8A7Haa++ecaqffH9es/hKZep9s=;
 b=SL5kLkgfOIAIFexiv0NInkd8zRuxtcFJqwk6T+833gCmu6JvZUOF0AfsT3kUTzPfuPosN7yQrkknJUxVjjGXmHBU9NXannfQ1Pdcemp7OSLA8U4BYwU/hTHNwh/6AAb91GNOG5ZK9GzAi+jUkT+VQCalP1mv9F9h5cq6q368DYqHg+foeI2nnJ+1glT2A/7TApMc4pPJskJGtEZkGag3mpZ9cTOnYB7LYoLjLLt/KscPnS8A619eFfKhLbDk0F5XJKQQVShQrjyaO+RdeviPiifZ09waO5OH4VPEOxr4u0ubiYJJuJgCRBwnjGNKjtbVsXABRNVxmHW/b28JOg56eQ==
Received: from PH1PEPF00013306.namprd07.prod.outlook.com (2603:10b6:518:1::13)
 by SJ0PR12MB6784.namprd12.prod.outlook.com (2603:10b6:a03:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:28:34 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2a01:111:f403:c918::1) by PH1PEPF00013306.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 14:28:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 14:28:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 06:28:13 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 06:28:11 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <frank@dressler.pro>, <thomas@monjalon.net>, 
 <david.marchand@redhat.com>
Subject: [PATCH] net/af_packet: fix build with old kernel headers
Date: Fri, 6 Nov 2026 16:27:56 +0200
Message-ID: <20261106142756.241131-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.27.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b32951fb-18ce-4192-0d8d-08df3c123d46
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|18002099003|56012099006|11063799006|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 5KengenLS5JK0ut0rfMhqWN34IF9p/walEBkyq1vR9vAgxjCczQH5oyD1PHav6jQC7F7uF+P71V4HeKcqvZKD88F7V5rDV+sXQX0RyIz7BujbDAxmpKWYQgAbdhsLmHWwiVEcdmqlU5hH/MMYdVJ2Qq40iY9QhLgWmiL7ROfKDI/qoDAlo61neXF5wLEQqvX1mydsak5vSqA9N2r6IA52RCoKnz4ypLUV+4SDsIbro8u6J4TtKvoK0VuWJf9GcLnawH/Fr/egwyKnRQvj+qOoiPJup122hxHfkHKcD8xrT8glEaqKr9elctsQ+xW0q+ZPCvBDnj0t2PEmNQFi9UCa9IhADgtT/rXCqz2xztsY3B/BBb8r0j1CQoC8dc8+WU4AUt8yO2JcMWTcRUrZ1dgCQDVGCKiX9hl3lPG2RsAumDXYGbt7xCChfYFtMrqh4wvlyA3aMNFjzh76hRveBqe7VteIwZQOtz06SWTg7c6Kkd3IKgDhqGcxbgeOjSkKPbODzTtmVu1fA2+XCRacKOUf6xvkAXA88W2BPmhtzVfxk0FINjGIU4xXvXk//Up1q0jNDJEP9rVVHVFX6hNiyoCojJTrBEgQKc4/mUb/jpIIOMRn6wVMjG3d7pIseGfcflcjSE3jZ90wyXeF/lT9Y5G691mZ5k2GZv7v5rzvPtto+330Wt6o2sL8hzZ2VZ+lnpwpuouGDpoje0HCBUTJViGQQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JlxIUmZS7cI4zXxNRZy/Lz/vQshbRPcgiR+xWXJq9smUg8teA5ZRnP/9gxdAQpzzEPi1eQXCNdPgmKo9OHv/pDPM/tw1sLYHqmoU9G6PI3k0c6HcAoo7wwlOpB5QH5RxernZh/U8kUulxNMY8SNEySh1fDG3JebrSSCd1w+dw9M93Mfwuhw0IfZKBNjHvJdFD0ChD7hZ5OLPmdrUuP+82U4zfdQzXwbUiOYpzK2V6pmff55HMCakiZ9jkedaxvFO1qjodmyenfAdu3kfvbxmDn5bHArE3tHZRH/NDOxgr+4xzlAwZesDBvZamswb/g4YSAcniheC4qEOmYNNzyghOqZMbu1EZjl6J47Xtt8vkp1/LcN42xEb/3rpBHi8QaJ5bm72RfVLxfQ/0fhbuLtQN7iTzUElA0aQJGUg1X5R7hUEM2lH1xZbk5JpCxyk133F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:28:34.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32951fb-18ce-4192-0d8d-08df3c123d46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
but it was only added to the uapi headers in Linux 4.20. The build
fails on distributions shipping older kernel headers, like RHEL 8
(kernel-headers-4.18.0-193.el8, gcc 8.5.0):

  ../drivers/net/af_packet/rte_eth_af_packet.c:
    In function 'rte_pmd_init_internals':
  ../drivers/net/af_packet/rte_eth_af_packet.c:1057:41:
    error: 'PACKET_IGNORE_OUTGOING' undeclared
    (first use in this function); did you mean 'PACKET_OUTGOING'?
      rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
                                           ^~~~~~~~~~~~~~~~~~~~~~
                                           PACKET_OUTGOING
  ../drivers/net/af_packet/rte_eth_af_packet.c:1057:41:
    note: each undeclared identifier is reported only once
    for each function it appears in

Define the constant when the headers lack it, as is already done for
PACKET_FANOUT_FLAG_IGNORE_OUTGOING.

Kernels older than 4.20 also reject the option with ENOPROTOOPT,
which makes the probe of a single-queue port fail when
ignore_outgoing is enabled. In this case, fall back to filtering
outgoing packets in the PMD, as already done for multi-queue ports
on kernels without PACKET_FANOUT_FLAG_IGNORE_OUTGOING support.

DPDK documents Linux 5.4 as the minimum kernel, but the PMD already
tolerates older kernels for multi-queue ports. Do the same here
instead of failing the probe, for example on the 4.18 kernel of
RHEL 8.

Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")

Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/af_packet.rst             |  1 +
 drivers/net/af_packet/rte_eth_af_packet.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 6282f1e18b..09e79ff392 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -45,6 +45,7 @@ of AF_PACKET for frame reception.
 
 When ``ignore_outgoing`` is set, ``PACKET_IGNORE_OUTGOING`` is set for single-queue ports,
 which moves the filtering from the PMD to the kernel.
+This option requires Linux 4.20; on older kernels the PMD does the filtering.
 For multi-queue ports ``PACKET_FANOUT_FLAG_IGNORE_OUTGOING`` is set
 to achieve the same but this only works from Linux 6.2.
 For earlier Linux versions, the PMD does the filtering for multi-queue ports.
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 44f82c0309..fbaea57615 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -32,6 +32,11 @@
 #include <unistd.h>
 #include <poll.h>
 
+/* Added in Linux 4.20. Older kernels reject it with ENOPROTOOPT. */
+#ifndef PACKET_IGNORE_OUTGOING
+#define PACKET_IGNORE_OUTGOING 23
+#endif
+
 /* Added in Linux 6.2. Older kernels ignore it. */
 #ifndef PACKET_FANOUT_FLAG_IGNORE_OUTGOING
 #define PACKET_FANOUT_FLAG_IGNORE_OUTGOING 0x4000
@@ -916,6 +921,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	int qsockfd = -1;
 	unsigned int i, q, rdsize;
 	int fanout_arg;
+	bool pmd_filter;
 
 	for (k_idx = 0; k_idx < kvlist->count; k_idx++) {
 		pair = &kvlist->pairs[k_idx];
@@ -1053,10 +1059,16 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 #endif
 		}
 
+		pmd_filter = ignore_outgoing != 0 && nb_queues > 1;
 		if (ignore_outgoing != 0 && nb_queues == 1) {
 			rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
 					&ignore_outgoing, sizeof(ignore_outgoing));
-			if (rc == -1) {
+			if (rc == -1 && errno == ENOPROTOOPT) {
+				PMD_LOG(INFO,
+					"%s: PACKET_IGNORE_OUTGOING not supported by kernel, filtering in PMD",
+					name);
+				pmd_filter = true;
+			} else if (rc == -1) {
 				PMD_LOG_ERRNO(ERR,
 					"%s: could not set PACKET_IGNORE_OUTGOING "
 					"on AF_PACKET socket for %s",
@@ -1083,7 +1095,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 		rx_queue = &((*internals)->rx_queue[q]);
 		rx_queue->framecount = req->tp_frame_nr;
-		rx_queue->ignore_outgoing = ignore_outgoing != 0 && nb_queues > 1;
+		rx_queue->ignore_outgoing = pmd_filter;
 
 		rx_queue->map = mmap(NULL, 2 * req->tp_block_size * req->tp_block_nr,
 				    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,
-- 
2.27.0

