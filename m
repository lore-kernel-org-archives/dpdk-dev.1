Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BECCF2C4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A71540A89;
	Fri, 16 Oct 2026 21:59:12 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013018.outbound.protection.outlook.com
 [40.107.162.18])
 by mails.dpdk.org (Postfix) with ESMTP id A81FE402E7;
 Fri, 16 Oct 2026 21:59:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdzyzdNeX03BZE4qXzLIoEJbV9+X1Z+HhN9weY4c0Gohed+AgNZ2Mk+7BXeuywz4s81ReDQzDMqx+ue6u36/Z66Caer/vwUkwgvIZdUjEOBkmCJBjTsVkOD/8HaOazm+bgxIRCp5LBlA79VJ9VPUXcgY6kGycGnRY6TiNkots+h0K85zscJ5zkrNLxdnwpBpdNFXmGHqt0HlNA0jyEMs/kFWbG+Viz/apDnA80wMATBTQTEUNJCYFMxCzoKs4vqpTOmQd4F7pRHzOc5aBq1K4rvNz8+vZQ7w8Jz9k0cqtX+HNrmSaM4yNKgoAtDXhh6awvaLiY1fHxyahFNWLfRgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9lWZMY8MBmMhpf+VksYFSvSsowgs6Jjh3zbVEeGGuY=;
 b=K3Wyao1vOklqCtuDY5dg3NYwonxlrsK4Y64hNxSrzJgOZurFuVT7N8u6NuF1zB+w/P3A4eFSEsKQgrDY0vYSuHbs/QGv+G0/y8SaqrGk+650EmLApagsS72wVvEsk6hSuSgWU5pJkoTDFVjl2aGttI9K85nHD8w6J6FtnFjWPjyha+DgD+R6NARGN/qeadMez7HbjGb7/woax5IMFcpLsTvy/XtGBPVj/1EVw27hR19jABJo4HIeoQLS9rJbjdBVXoVljg2US4tXKyZEDGng6872H51nbW9wIP4taSNy69YJF/sH9leaMvfivAKvFUaCu5TFtMXshBmbIkdy/rSKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9lWZMY8MBmMhpf+VksYFSvSsowgs6Jjh3zbVEeGGuY=;
 b=G2IPrzFmtWpGotl+4gciAufCxgKP3IrnKNngGI96s7ihZiFKznZK/yWCgkS/aAr8xqneizYWERIUyPCULX4du/s7CkH7hvr56vCZ0NcqL006Y5mdu+vVNkIv93kdNTECIum/SWEkm3NITXgimsxmamIo72gjpY2joOM7nUiR+ZZkYpjIMz9I+4Fh649eH61Iw5DEawkPVfKCY8eEtZbP4gvLbeBzxEllzGbxCSj7CA+lj4dPhNeXQtpZQRc1o2RY2X4GU2WVHbBjB9XRzvAciLzVrFHkPwcBs6Ayt8fm3PdBDqRqYXpq1uPaduLhMi7yv5xuRaim7kW6UBd+rAB64Q==
Received: from AS4P189CA0045.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::17)
 by DU4PR07MB11855.eurprd07.prod.outlook.com (2603:10a6:10:634::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 19:59:03 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::30) by AS4P189CA0045.outlook.office365.com
 (2603:10a6:20b:5dd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 19:59:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 19:59:03 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 21:58:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id EBA774020A84;
 Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id B6A0C6285899; Fri, 16 Oct 2026 21:58:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4 2/9] net/memif: close file descriptor zero
Date: Fri, 16 Oct 2026 21:58:50 +0200
Message-ID: <20261016195857.3258796-3-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
References: <20261016195857.3258796-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DU4PR07MB11855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfc3016-bbd4-4f35-8bc3-08df2bbfed6a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: U4SDLQaNF+untQdg8JQW8fmhF3BIWQ+I6ZQlq0LxKqHKgd7wRKJg/scWVm8Crnw5OZAp1EjvCDBppOxPqjNrkQcCTqiBEbTypLHjSFT8zS+VBfBx9k5lqmiWK6HexKjggzfm/9rYRbW5uWx94naG/C4imhKsWKk5w9AE+UKF6Uut1rKwoB7YscBNgM2+brWS3WNWJzgzK00ap9yzHequl7fRXRkLIedNyufq/z+VqbruQ0fSS1gfk+13VpCNux7fTj5fwO4yP/wIEMKfbM23gtB8o9o//f65/wCxmHK4fz3sENHhTt/A7Bp27HZdcuwJ9NsUEBZsFeKHsgQDnQbbc3E6Bmii1P2X2fCK77ILBQ8YI5FnP+3F3Itm2xMcl+Ym9dT9nvyXxNhHjJH0we1Y9COzb0rAm7MCpPsr5iS2rAo0rkbsh97aVyF0ApV8/6JvigHcs3/DSI2Y1s/32qFxFx7aXz1tkfIhPKw6YyZeoh9mXLSHvWh2fisFrNt95ntC9NNaYFRdepmqMPMbdB2A0/w0fDAFuL4OotfA3mr8DGZWBN3ZDF9rUUxWdGiqtLtxQ8bSeNCnFD5Bty5+FROFB0TTstFzy9TnA/ddmnT01tyWUFlJAhJvgNdFKSq1Dy9bAikXR/Af6VQyQH6i+xD1nA+t7r+kG7vG1WR8WW0RUy45sIq3zgBicHJXsjD5hG9jqY7NM+9DzmQhObBY7kk7Gw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c1Tn6lW6sHrxDxoXtqTy1cg4cYlh3R/mLfH/vOQ8Q9ob6WbKgDPxWGSyiyA5Y16fOomAIoiqN8GujLSiBen1yh94/+rQCDncmueSxBKh7MnGqFjJ2qDxlWfCnQPIseesxuoWFIPDtCCxD2cca/dVsOcS0XiYhorK9zDJvJXzrBP8PUR2c92LENqVQur+zRf23pcKRInl4aSWULuKI5BIlp1GjduSTRB7p/DZjEQU6YC4ivnVyWVhytVznCtavUU0RmLOb/YjCGi4b40tWNGrwOCN1ALtKUI/ffHfH4UyGv1pEhRwgj+TXCLm+JV7svRDVJAxYRzHJHEjfgOai0eDkUA3TP0vVJGC3qWlqaokb4OJ2YDcbFxRYcVPhpKVXFg4+z28zzEXWrRngkXwYhtKhJGF0gj0k7fDJZBWY6I2j59vSJNIeS7vdwTwkdc+Q1q9
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:59:03.0317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfc3016-bbd4-4f35-8bc3-08df2bbfed6a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11855
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
 drivers/net/memif/memif_socket.c  | 4 ++--
 drivers/net/memif/rte_eth_memif.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 87b23aa8b4..550e2e468a 100644
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
@@ -623,7 +623,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 		}
 
 		ih = pmd->cc->intr_handle;
-		if (rte_intr_fd_get(ih) > 0) {
+		if (rte_intr_fd_get(ih) >= 0) {
 			ret = rte_intr_callback_unregister(ih,
 							memif_intr_handler,
 							pmd->cc);
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 36db03a268..1d1d12e242 100644
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

