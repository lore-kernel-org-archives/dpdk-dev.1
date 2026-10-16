Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C12CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6D040693;
	Fri, 16 Oct 2026 16:16:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
 by mails.dpdk.org (Postfix) with ESMTP id AB81D40291;
 Fri, 16 Oct 2026 16:16:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2SNIOnPZpLDoA6GTAKJSKPk+6kaCV1nT3Xd2KggvPe5QC6d9bpgY1Vgt/MtIdrqT1zeTpPKKIzDJG3euKWMEBayOosRy3HZrjLkHxSMOeEcmC3ivpYGe8isu1sUBktvUdbCXmfPmHX+owvdcOWQsJUCOVm+DK8UxySOzqg8t1rwjZZPUM9GB2kXWdYaJz6Pt4QuWFyOrHCQuopZWFN0dxzxBv7/kkAMHzCoMZj5OMoe1yWfCT5NA/R7s2Lmpgpyxg9IXXOC3QY3O45JGPiTjT5j8adAJtCFpZ3UFx/njBNsh20+nm3skzIMtRAHNRgRv8rnmPZmfCJStSazfXgGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9lWZMY8MBmMhpf+VksYFSvSsowgs6Jjh3zbVEeGGuY=;
 b=I1DYYce6QBqpZJA8qfAVGupOLvOxA1fgBrfwVPrtXzEzvx00sXcE28xu8RBXLQAlz/gZixpE1gsllCEmzHvWMkd56308UFToej2mIBGZXb84DyRG6rW7B+927Sp9GonINkGiY/QrNY0uyzChr7yCRW9hKla7AIJ03J5bsbDcZPS7yJfV++uJ3TMsv3N3yFWstWAtvDynlstMr/sQbdU+dGRz/W8oQFNnvPFrMkbbFSWp0lwibWNtHzfApyvrNQBbIYWCkB6U5iSuyf2td0DV9l65lHORiFkB+hsZf+Uf7HZAJO4jUrkiCfkle94q63ntkT/7sDfAfJNw4ltDTinS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9lWZMY8MBmMhpf+VksYFSvSsowgs6Jjh3zbVEeGGuY=;
 b=Xnb5gWTBey6feNv+OPScoaeh2NGdEIovb3Y42crn2vHZSgAwVXtlNCkmyn5MrfRFeg+N1YYtw2QnYhHe8fqpK6mf0Q4ZJjl5bVtPBWPlPFdczACVRtuRC73l3ceFDKcJjBZhFgagGUr3DMPnT7ERx90CyjyEShiAYwaAxvDmsV6u1n7NEwORIlIAoc+XxU6KWs2/2/xbu+KcUCatyCYF2f8EOm1mRqe7td0taUDcC1FeMQpSZns/h83MM0oRoDzhhjiJUKdsVGp1jCG8Q8Kgbzlnhv8CWSngGrtb0+sR8vxs+fkvb5Qetn/jneIcefDvCj2Irucm/IWCjNJHc6qzjw==
Received: from PAZP264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::13)
 by AS4PR07MB9631.eurprd07.prod.outlook.com (2603:10a6:20b:4f4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:16:01 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:102:122:cafe::b) by PAZP264CA0026.outlook.office365.com
 (2603:10a6:102:122::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 14:16:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:01 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:59 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id BB28B4020A84;
 Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 7C857628589B; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 2/9] net/memif: close file descriptor zero
Date: Fri, 16 Oct 2026 16:15:50 +0200
Message-ID: <20261016141557.3081522-3-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|AS4PR07MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df3a4b9-6beb-4276-1d08-08df2b9001b6
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: EHOdzJmbt2x5fLoa+kzJoaUWUOd1Mo+MDq52OuOgc5aY97vN6lx3bLbMuJ0AYjCmJbRgwwy4OvJtL1WRTsFg9vRyNb+Gmk4qc5H3TSFdRdfSXUB9KlvUvAfoJRaWUq/J9ZjvhigriFQoyd1ZpXLVkXFfoQ3f1i3btkpCgLx6LCg7S0JkQaBfdzoU1XSK/Lzk5TKlubFObbn8FXKbEjrnydm/XxYaKRiC6hmbfcGuUtD5EA8/5QcZf5Q9EZ0C2XYj6xKQpIa562XoPu4CaXZcm9rUhCTqtXF2ogTc3lnK+dB8Jv+vmfj+wxVdB6/K8lSEy6hye1NWb5TekTRP5etGuGxTsCCT+TgAIckMowLLIrLikJDus3pv7upBAIoO7fcp6bLRx6uVktewYCoKQzjg/8PIcs0mLb6iHHPdKSGgwQHmiPrfeMkJoSzWXCorZb318sRd93shLn6eQe6CbLnrm7dKFxaVf1/BZXEQ8u3x4O+mY41XwIWwPxMVWKJsS6YL0SkRoqOiWvC3z5V2CoqtIL0DukS2mQS67nPQ0fCb2AaU5ZCn74UtX8Zn07Q3iwLI/e8LIKZAu+AyS2xUfrDedZWcakUpFPXk6BgzrmTt6HG3+6iGFOJ7vJvsNjdu7Wn3lhMQFyTnmCIM9+ZxP1nsOatNAaep6tIK6fyAnsH2HpNj4bkzcGq1lut2+5K/KeeKEw8us5Di/kb8K2TwdvlXTA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: edJ9DRN2/fYa1nCYng/05gPxeC2M+6S4WxpDRFuSc4vGsgFXgmDD3RlwuHLenFRut4PJiJ1bq/5IRx856HJ/GqyckxWdhqWpJKJwie4pwq5yFkVaRMMzdtTCCcF/ivpAhXEB7qCvgl0bngE+g9FD1/XFHA1Ou+VjOFus6n14R/+XxxilmniJdERDamOSN/3vlNlXdDMIq1OWM3h1wvR3yxaetqf4MdtglIOgsRfzGn5VJnphfdlhugcVvrvAXANdookyfhy51aJCNfDuGYLBgm6bh1UshAMRuLMEkREVXIYmnF3uppsUT8TmQbvpcJKITiApChPKla9rl+kvRVQgGIPkWtJKDXzVu6nkN6R4iej8mjGW6eOcXNbzxFpA93XXLZq3C6xKUCzI3YEIuL+p5K8jPOoRpVAJ8T4odfvntz24VvXNDiU2+P/3bXcxMElH
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:01.2406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df3a4b9-6beb-4276-1d08-08df2b9001b6
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9631
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

