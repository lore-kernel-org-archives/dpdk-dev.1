Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C307FCCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2E2C40656;
	Fri, 16 Oct 2026 21:59:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
 by mails.dpdk.org (Postfix) with ESMTP id 7E59C40291;
 Fri, 16 Oct 2026 21:59:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXVqC9S9SfIMYUbYYA55cxjFE0g+xr64bWSCjWn2uir4mSD/qXCMlKPkrKCCZT6qt/ZUi2A+Z0NOfXG6wcy6glt7M4l7tacvu8UXkj51fErTIwnPCZJiay8syKTzckf+5fsyy3UJtoF57ZV2qBdLF6+9HwNZFhM30MpU//nTN7d3hXnDFfo+Uo0d64Glbqvi0WIXTzxE6Sqr2wI7pN9Sh5C4GQHvHiTgsgyZnfbfDuApFnXCZSn3JZfLBrkHwwKvco6lMtTcpbIrDUlJhNLcCEh0Ijeh9Ls8HYd6h9ICpokWGgovRE3C7yVHXSKt+ClgONn7t+Y6kmD6OqoeFjczMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wP6RfPfyC10W7VcCJSKKPPFvcLrBn6ZrpPIdf1iwDc=;
 b=EoUXbXdUxNrPFVfqRcsZR1eWDLyo0WvxavK2WhJhSU1UtLGzpE2q/Lzyxr48LOGUJEFR3k/j2gqiIfyLGxJ0NFSfISFRs5HlIYjScDIqB1Wvt6x/z5qTi8m6hWOZsIaEE58DjhbJbmZuTEdrKFWEqYZEy+X0ikzbDExo1hZVBTiYp7ufsqMdzf+ydPJsRnYkXM6kExs0Mc+jTkLtjOl5HF6akWeVGA1ms82GQJafSwdhkAOzKSRaIK5dcn0+U+YILKQBE5MWz3TOCQY7OB0KGOUjdhCrHy9P8CoIbAWWpKUBYlw7RzMa8TL32nV2CB6YVkZzpo9DHbU87NrIhbphjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wP6RfPfyC10W7VcCJSKKPPFvcLrBn6ZrpPIdf1iwDc=;
 b=d9ap5Pw3vFWlxEN9gKRsUuJt96Rl4RpZPhJelvMMms+2Acp0q/cu9o/1lIP057Y7acfMR+Fr0RskjEjicCF6SgE17LxFI7pVLDBcidmaRL0JaVQc6BikahJOTrecmtrLrmBHOgf1FcJ6dqXKsQ2oWMEzipz86Kn5CdxvywOUbOUCwy/xi78gOqnVP0mAItH02hyCwp1/lwQO6gP7e3G1XDaDsx6tjGvwBWJfvslcakzcKHo2ypf/RLc8PBpHWeDxmPa2sik2mBbR7t3M02sKs07Doeovd/yUyZ6fzqST3QvA4A7JIm/cEQw8s0s5lWm5HleBFCEvkmLI5Gg3pSACwg==
Received: from PA7P264CA0263.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::14)
 by GV2PR07MB11299.eurprd07.prod.outlook.com (2603:10a6:150:2cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 19:59:01 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:102:375:cafe::2d) by PA7P264CA0263.outlook.office365.com
 (2603:10a6:102:375::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 19:59:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:00 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 937374020B7C;
 Fri, 16 Oct 2026 21:58:58 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id CE316628589E; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 6/9] net/memif: refuse connection on stopped device
Date: Fri, 16 Oct 2026 21:58:54 +0200
Message-ID: <20261016195857.3258796-7-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008496:EE_|GV2PR07MB11299:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a994d69-bb86-4c82-3a76-08df2bbfec17
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gTuhGVbXVFBCR/BJk4QhbCP/50SLNtJ894a56gjKBCBzxRl/ezu5RP6MT4oC+p/jgeGOrHlYh2tepCSWZKwPNOXHvnefGXrdMpyxEwb+4rphhHMNAlxGQ+peG1OgIgoiMe00mND4nAp8jZyHwqXQ/HSvrd8qmwmI8K8YzUHYgmWnzGEmp7PUp8phLdRlnI4wIXVMYA9Iofs/iAAPJxLBidRGOdJL1p9v7OAja3YH6xR1xkrs7MT9kadNQrrUeulRz5SZ7JLBa81zo7YCfYMChS/U/l0mQmqeqt3JYB4yhmPu9fJH8DcPSDCaF20kZLMV9XNwRTM4cOxjiRYAn6TDPb28A8s1vl5nKHPhAtpEZZuCqPoF3CfAAORFO5fPcL7AKo/CoAbP5To3Uxcf9xqi/XLuGuAd63Fw+xWAsjYF2V7/B2tNhY4+kPhY6QHT8gHpv+qgH2jetI3S4xVy49T91OdOmS5IpuQehYrC1tTGYuXIg0Xb5Zs+am1nHM6eJEvgCY042qQnsTM5vvQSUqjLmV3e0i5ZdQg0daUE8uYEHdT9VWv7ETOizyaemRiRAp99sS5SB7O/L239ASYogVHYFnfEAfm8jeqxl5oSfFTuvXoIBBNf1P4xEuEX5x9VufW8OyTN6iKGvbvj+KBEcWWEv9s5KQhy0EUhv69rjL6gnqmXk60+roJt62BSq9bSxWgRRQzzGhXXGT8WSOLoe5n9Rg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S9QuU2Tn8rvzQruTIo93RaX0+QCpqQ59aComfT+fgUY5ObMWLhrA8SFxCGPyxQpr3zt+AEVqrv95vYyN+hSOk244wOmSRp3pKkaem79ShPjASkxRK8qA2461UY4A5eEsdXri4h3+62vloMicjw2s0xj67ikpDH9SEyuD5jsE1bwF6wlNoZIwKCKyHWxfLITBoIiSRgGLdz5GHyB+mh0AsILYUoBbR2BhAcryUvl0fqEqZyKx3rOoENBIRrvXTqq05xpwS95hkBIZownNmb/A5e4vMJeRpZahE9IiSrTiVtBGyIrEaqXmuznCgv0JYU086ssx8daIyIPP5ahdDYw9RbPEbkiTBRf8d0wVeXg9Eg9RpaFzc5yQfBuFTveCtXZGEw2Bx82ozPVy3JVNcA3ihfTptGK10MT+sn8RmCY8TrliM63jcAPCsbVUFvRXsUwU
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:00.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a994d69-bb86-4c82-3a76-08df2bbfec17
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11299
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

A memif server cleared ETH_MEMIF_FLAG_DISABLED at dev_start (in
memif_connect_server()) but dev_stop never set it again. memif_create()
sets it, so a never-started server rejects peers, but once started and
then stopped the flag stayed clear and memif_msg_receive_init() kept
accepting connections. A peer connecting to a stopped server bound
pmd->cc and, on the CONNECT message, memif_connect() set
ETH_MEMIF_FLAG_CONNECTED and reported link up on a stopped port.

Set ETH_MEMIF_FLAG_DISABLED in memif_dev_stop() before disconnecting so
a stopped server refuses peers.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index e70443976d..852a7e2e8e 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1699,6 +1699,12 @@ memif_dev_stop(struct rte_eth_dev *dev)
 	rte_eal_alarm_cancel(memif_bad_desc_disconnect, dev);
 	rte_atomic_store_explicit(&pmd->bad_desc, false, rte_memory_order_relaxed);
 
+	/* Refuse peers while stopped: a server must not accept a connection
+	 * after dev_stop, which would leave a live control channel on a
+	 * stopped port.
+	 */
+	pmd->flags |= ETH_MEMIF_FLAG_DISABLED;
+
 	memif_disconnect(dev);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
-- 
2.43.7

