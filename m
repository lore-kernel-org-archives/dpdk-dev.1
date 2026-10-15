Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3270CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3490E40B95;
	Thu, 15 Oct 2026 16:39:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
 by mails.dpdk.org (Postfix) with ESMTP id 8CB1440698;
 Thu, 15 Oct 2026 16:39:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqV5ovNxPghYeEbuPMhraysEtfm4zgOhVOY4FrXLrP7l6xB+9Mpxx+BY5eeFBYMvnQ+MfB+psXo2HD1RFDc24rpL1h72jkLRS83OE0dN2yk3QdDCle6D5I91ZPuLWndM+kkN6rz8mCG1eyluFGl/lE5OzT0xwg/PUGyOC4ZzGK0MO26bTtl80b6xqDAWhg9R8kLCeqCR4UkJy9HUw/4IP03kB9vB5cT2IcwLAJpSG4ejJ0h+idNB79DjYvuBY/0Xvsr1TQvvHyCZOs2C/4dLy14GF35eENKdN42jYiMgAakiiuj0La9mudcnh+rnPVAMl9bXaUucArcFbSCvwoSbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYhWNWz88VBy/D9DL1yc+Ei+Ej3cgi8ZcEInVgwZsBM=;
 b=Y6YdCMrzsXFaFOquFL8+Kw5riKO0kUDnEudyeNbM9aMV9EAoUBbgS0SLoA4BXtxnc+fHHEPdp8y8nCVWDya4c/coBSOQ2/PxCDGhwdGvY3LCskyIFdVgDs0OwLmdH+EKVMqgz3lYr++s57rR+pXSIHg86GUX+hhdblqZlN4oAfzDzDYP7RrLLoNuRvkLfelpyvMDuliUuchrqH4RcWh+yHc+IiwL6bUv7sifrySkx5J/LF4vWXrEGvLhpj3QzETfoT+TwjrtmMvI4B2HMZhwCwrL0JMAeVFcZTDH/ZDl6kulP44f5mhcpwBQZzThwq3Tfz/U6m9TyYlgLFRnl8vRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYhWNWz88VBy/D9DL1yc+Ei+Ej3cgi8ZcEInVgwZsBM=;
 b=cA7aLfWoILwHxojjryzmSWYSVuX353jwlt60O8wl4CmMeCUy2hsnhD/6WggS2VNb+AoSOesAfX1yOSqqitlMiSKN37ljLdFBIjo4mqXHWTzlmkbW443k4Cf9ZDwKsOCpPAxlLLuT29GoS6D/C07Cn3VMk4xKyke1OP/bCBsXUHgwyYrlpBAyvsZ9eNUO9ouVp56GbiO+kushsD1XaeoGrb7ueBTJk4CFnWuX4j+JHmoaugGPsDQjZy65rlh5TwdN/ufyJXBi2UBiQ77rrQlVbGKQeQzxaO1HhJTgmjkIjP3Xebhf/Z73mnwDAYSCvnjf61xamdrS00xZHWpobEEGYg==
Received: from AS4P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::14)
 by AM0PR07MB6292.eurprd07.prod.outlook.com (2603:10a6:20b:152::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:39:47 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::ab) by AS4P189CA0035.outlook.office365.com
 (2603:10a6:20b:5dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 14:39:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:39:47 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:46 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 7BDA04020B73;
 Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 3944F60B034B; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 2/8] net/memif: close file descriptor zero
Date: Thu, 15 Oct 2026 16:39:39 +0200
Message-ID: <20261015143945.2150772-3-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|AM0PR07MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5bad66-d63d-44a7-c3e7-08df2aca295f
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|10067099003|11063799006|260925021911599003|260925022911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: c1v+LVfnDafWXQXyvbDQJ/fO7XaE51r+23/c6UAt0fWkTajEii2ybBj/62cPIo4DHhHrvtz+vNrxshimuKrI61qT8L+I0c7JTjboUHKvGFtwfhtyZsYRNTkv+XLEo8qxhI6hGU89kbpcL6J6s6PGOQ1eVZGVDMn+SShUgVVD+ueDpW9s/pYsg6B79gv7e2CBceDdAKCtAnVL20T5XvKnnCDTUYWyL+M+1rBwlRqiRM1vuBEp9X2pXb+3QvjURj8yTCTEQnmSJ6P7PyTj8oLIuenfGfFMRu14MwORfNA/xONKR4ZSZLd2p7trFdhDqOlNeKzS2TVxXPctxWWWQVnoqL+iP0O+vlkVxAxW/90DpuP7IWkw82msau5RV8UQ1XOHnrsUVLYqbtooxUdeCbO3oLRM8JdDUtszkDc5u91a2APImt85JB2tm1oAkuM9jqLzUirPitvhpk9+4ZBzEykbcRb9vcWfDfg7wc3UbJl6TpKxVTqEqPpa+lnzQwIWKIo+NBWlaCn52PNOBgg840gY621TkMsj2V4REYNNbWJ4B9emrqYs6j/vD65iif788CrFO9hntISTGETu5EVhTENJ5p9kxT+CcV+RfiLMCjXEDAFmje9lH9pGq1CDkxLANmpD1h5Grn2EPcnwPEw9m3cdbV2lebB1JDR3eRyconcBqAT7pN57iXpV7rw0F/IY/PdpHPY6C9TgVdoSM/RmrgVmaA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V6J9MiJZR7BFMJNxFvei+YLoadoMNbqlqm65+em79GypigHTjBFtKEMOCZLSzvXj18r7TUzKrZhBO95IBuHg+Gl4RfrDQxMj5jAcoyvMENk13tGbXjMDFrRYQc/4i0ssX+PKyYr3p5y1nfN2rBAuqSwglLnzjg0Kyp5Bto/HfC3rBtOFEZgXcbc5zLPeIfdlIUxlWixV+nd5v7jz2ELe3GYu/+dTGbTcnLR+8Pji05W2oKVmrekcxRBbGNuXFh8dHZTIuLLz3rN61lUno6WCs8mtTBErsdnVBspZqDmpTKWqcR5cZw98pOMbC0Ix9vbiIrarx4yIbzV7RzmVCHbDt9+o2UsXTFI3V6QyeSWYH5+dx1rI7y53hCwilKeBS9RnLiUd+FPuulLWM2VFeS/dSxB7AZEfoOynld77HiO7xllBAk29j9cG7b9u2XHpmvh6
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:39:47.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5bad66-d63d-44a7-c3e7-08df2aca295f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6292
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

Several cleanup paths guard close() with "fd > 0", which skips a valid
file descriptor of 0 and leaks it. A descriptor of 0 is legitimate (for
example when stdin has been closed before the region or interrupt fd is
created). Use ">= 0" consistently with the -1 sentinel the code already
uses elsewhere, in the memif_free_regions() shm munmap path, the
memif_region_init_shm() error path, the control-channel teardown in
memif_disconnect(), and the SCM_RIGHTS fd check in memif_msg_send().

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/memif_socket.c  | 8 ++++----
 drivers/net/memif/rte_eth_memif.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 8231a936e5..5918406271 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -41,7 +41,7 @@ memif_msg_send(int fd, memif_msg_t *msg, int afd)
 	mh.msg_iov = iov;
 	mh.msg_iovlen = 1;
 
-	if (afd > 0) {
+	if (afd >= 0) {
 		memset(&ctl, 0, sizeof(ctl));
 		mh.msg_control = ctl;
 		mh.msg_controllen = sizeof(ctl);
@@ -624,7 +624,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 		}
 
 		ih = pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) > 0) {
+		if (rte_intr_fd_get(ih) >= 0) {
 			ret = rte_intr_callback_unregister(ih,
 							memif_intr_handler,
 							pmd->cc);
@@ -664,7 +664,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
+		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
 		}
@@ -682,7 +682,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
+		if (rte_intr_fd_get(mq->intr_handle) >= 0) {
 			close(rte_intr_fd_get(mq->intr_handle));
 			rte_intr_fd_set(mq->intr_handle, -1);
 		}
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 2e41eaa459..6d8d55e570 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1295,7 +1295,7 @@ memif_free_regions(struct rte_eth_dev *dev)
 			}
 			if (r->addr != NULL) {
 				munmap(r->addr, r->region_size);
-				if (r->fd > 0) {
+				if (r->fd >= 0) {
 					close(r->fd);
 					r->fd = -1;
 				}
@@ -1416,7 +1416,7 @@ memif_region_init_shm(struct rte_eth_dev *dev, uint8_t has_buffers)
 	return ret;
 
 error:
-	if (r->fd > 0)
+	if (r->fd >= 0)
 		close(r->fd);
 	r->fd = -1;
 
-- 
2.43.7

