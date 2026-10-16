Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCDBCCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6C6E402EB;
	Fri, 16 Oct 2026 16:16:04 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
 by mails.dpdk.org (Postfix) with ESMTP id 43D7B40291;
 Fri, 16 Oct 2026 16:16:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agutSzO/WNUBO6vJuGwtsXQcf6TB+XfQvI+EG46gvrBK3kYaa4S+x6TZPMLLWPqehKvQnImXsjgBkenP+RkFrraV0L5cAB1t7Eae46IBaH4rxnXYrxZGYebFdpv0k7tPf3gD6gHLSwkiKoKoj6QjKJFpPzqmoMmk+iFBgmGhhMYcJFOAcyRii7DyCQcC9wYRE9h2Tgejr8k77YqEK8INneYY2pnJC8n0CDqF3eLEp24tEhyzOZA2qGeGxxpm4gu7lGzbwJ9RWGXXv67jS5wdDXD59hkKwvY2b4BBYlGg09Vi/SymBsWlvc5wRkubHonl7+lwP6HfvcDbaaHLBmIUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9eGwPV0lXJ98ZrMutRRREYE5oUCziWWcacpeIPzm4I=;
 b=sakpj5aR21g/Eein0FRJvkm4f5cuYKETkI2AVq8xeMh2bqLH30IJQHBpOyhLUfi/gI/BTGTUucUK+0F4gykQkeGYLa0HD3ElXonT1TBECpBf9EvUX0BGP5o6Z66WSy9+rtDdQTSqdkc8xKnaQpe8Q2WHsk1tweunMskoAitJfyV0gBkO9ksEepHioWsh/XQpouQKB+yAykJwniRkkOXuO+Vyh95rky8SMND5DBqOf4+lyT+mdkEKMREINLo+n7h/1TOzIteK23ucCKmLI2AnSm6uFOf0jMET9E7Z2AM5xqWsfmwsk7v7nbIO1DBcHIvhTMgDbGXd20JiKZL3rDBeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9eGwPV0lXJ98ZrMutRRREYE5oUCziWWcacpeIPzm4I=;
 b=CSbdleAitYgFXxKR73hVoRRxgz2ghTt0bEPLIahrUrj1PcsCxem4QZc4dlFk3vnL2Q2WqnpmFCQH5boxN4/2BDlc9vwuJbILbdt3aLiGoqa3N/ZR9Z0ZrO785+CjXhJWauxiAWnP+o/3yjBuKMHcgbOof8zsit9LOOPAV2J2vcCaAG3yqm8uHr6EKLPSvlPb5V8OdismuTEhmUQbr9eqstKXZh20EszJhTrYub3w3OJd9MRomlJCyxAYp0YZvnW4ebXROrBn8ibTsnvUSkd7V1lTuLtW+cMwha6FU188Vyk0GMCH13luWnclybPRkjn1WTNVuCmH/l3wc/MksAD0kA==
Received: from DUZPR01CA0228.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::23) by AM9PPF26ADBAD90.eurprd07.prod.outlook.com
 (2603:10a6:20f:fff1::94a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 16 Oct
 2026 14:16:01 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:4b4:cafe::89) by DUZPR01CA0228.outlook.office365.com
 (2603:10a6:10:4b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
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
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:16:01 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 16 Oct 2026 16:15:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id B22534020B73;
 Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 84BF8628589D; Fri, 16 Oct 2026 16:15:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Jakub Grajciar
 <jgrajcia@cisco.com>, <stable@dpdk.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3 3/9] net/memif: do not close EAL-owned memseg file
 descriptor
Date: Fri, 16 Oct 2026 16:15:51 +0200
Message-ID: <20261016141557.3081522-4-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
References: <20261016141557.3081522-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|AM9PPF26ADBAD90:EE_
X-MS-Office365-Filtering-Correlation-Id: 0783d739-b4bd-449f-fe1f-08df2b9001b6
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: hKl5qdNu8zpd9RQdNRUgvqT/b6/ypYQEPXlc79NeTaxvArDVev450Lw/p9eil+HzzfenJDvrgmqyjfA/VAVcYBlmYGnDumYbjc8ysUgzW6yyLGCdVCRSJjTvu1/iJo8mpvp5eemIHYLIi7ykXcGu+bKi9DDpXQhXUetNMyiEO3EypedNboUfbhFsDo37NG0rcZtZLIyQWXQce2oNTe30el+sfgDGlsYchmNZeotJS4ptKF0a6smImF6IvYLHjEwlq2QBfxWy35R6bff49OoZ8e4Bpx0gx9cJzhGBdTUCJ8DbrSeLhIzFvxVDG+Cb9SfbKt9XE2vYxrAuf7rPkNEc6kTMUaHmfYvjx49tyASQzndhuMOytEK+lS0DyfA1qikPi4EytYEeJpBQUSCv5A8x8gq30XVw4BoqI+7xQgAGlLOCltjBTxtXwbA6ux6TuYjlwfK+v2y1BQrpPpHgKbj74i7dTlItVHdrrU/SCBTuJIB1GEAFJ33VwKhn5bLr4daa3ZklDnKSSvduWpvShPZAUX7YQ1eA012pwWKSg1NxfYaMnYFsCrOOmzNas+H1Jrb6ODfGTw+d6qFwdTgdwsSCx830ZMlS3LAoHRX020L80KS76y5f4rYjvfBkMxH357CEO/u8DTFJ6x0o9BK419rxtrrOu/IkxAg8HeHyaCKGmguAGRbRkSlsYVyAghxL1g5arjB34FFYzCPl89MgAfrYsw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1u3GYkZ4jxdyt+KkTgiFtjpV19hEuLIPlB0s/5Cmx1mcCgRAwcEyjQ/zm88wRBraDqd5kD3arA7ELCBzAhuVaznyYiS0zGsH6ofESn3XUHcfjg490c6pgevulxfjeBt4wG7DkzO7GSpRyZP0vv0HmTXs7AEpLi11gMSd2/w2ALWa50/x5QNrugRf8EVwVvuJPdpYoO/Ey06DYykDFODOLUwU3R4buhIeb0ljTyBUguOfLaxLEzLdes5nDk04Qorv01Pcx3PXnV28XJKjyWAnz7bBs9aSepkidA7ttB8Ot5Ijlh+1FLp+lTJ5PeWRc3CFZMXGqKZl7nknxkCIT6aWRJwfzUdcmCcvRttfiiCGtmiN80NwPmTEAptdKvlQnCkHAPtf6WYG42GTqSLb9DaWOpCufq4teiUQcN6fxNmd5cv/HMM8U2l3iHV4xL/ehzOe
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:16:01.2733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0783d739-b4bd-449f-fe1f-08df2b9001b6
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PPF26ADBAD90
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

In zero-copy mode the per-memseg regions (i > 0) take their fd from
rte_memseg_get_fd(), which rte_memory.h documents as EAL-internal and
read-only. Both memif_connect() and memif_free_regions() closed that fd,
so the next connect handed the peer a stale (possibly reused)
descriptor and the PMD closed a descriptor it does not own. Stop closing
it in both paths and just clear the region fd; the fd is not ours.

Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 1d1d12e242..e753243440 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1289,9 +1289,9 @@ memif_free_regions(struct rte_eth_dev *dev)
 		if (r != NULL) {
 			/* This is memzone */
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
+				/* memseg fd is owned by EAL, do not close */
 				r->addr = NULL;
-				if (r->fd > 0)
-					close(r->fd);
+				r->fd = -1;
 			}
 			if (r->addr != NULL) {
 				munmap(r->addr, r->region_size);
@@ -1611,8 +1611,7 @@ memif_connect(struct rte_eth_dev *dev)
 				}
 			}
 			if (i > 0 && (pmd->flags & ETH_MEMIF_FLAG_ZERO_COPY)) {
-				/* close memseg file */
-				close(mr->fd);
+				/* memseg fd is owned by EAL, do not close */
 				mr->fd = -1;
 			}
 		}
-- 
2.43.7

