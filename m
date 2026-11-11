Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10752606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2fkO5JZi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847E4410EA;
	Wed, 11 Nov 2026 08:11:15 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by mails.dpdk.org (Postfix) with ESMTPS id 746C54029E;
 Wed, 11 Nov 2026 08:11:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htCYoF/mWUC2hS3KXBdCxBiZydoUp6GmVr6dOvahsTLPEyj/w4x7nh2E+SHHOf41aA93tLtNLUCUbrOMzqIxULLT6z19d/Mv2jA6J11sDGLKFLJpQsqjAqP/NUcjzNVDHxI/4gfOXj+U6K9YzOvnoExhfs5hGwvlY7/Qz6n6pxYtBEhyV7WaQ0ekqm+FOyHdfMtOvj60kGODcuo2QFzJ3UL7R+EdyRjNnOr/hd5xkUQ3EPSRxdHfzl9EfS+8T7kHInt5Jj1TESfr4Zm4qobKFgSdjDYbEVgSBbI2hIjs3OzcNRoYCgWbF4lJc5iEzjaxDBWDPLV2ZnOjw6U4WcSJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0htR+K7Zgu+mag1oywbxBNE4guijH53kAFYRBvszOI8=;
 b=TQMQ2Yh+6ILCT/XKOdVWgl2orGUyST4tapePPhDvE/pIyjCK28lLSLiLSVv4uOESypxQTsAy56jrByX+VwHZ7kH7znEZaoE4ptEyDsLPVKub/7OYI0OhGhrrHo3dHuDhwgxTjDLooGAaS86DumBCTniwYtB72ZjgRQmOSRnB0rndGIUEap+qvC+49yc9mV4VZ8M184z6Hk/1ottAZmi9/LvWNo8eKZ/ONMeGC+nz3IBcYVTh4rcMdEmlF1Ek25YlXC+RqoVVwoQRcWh+0GChwOtYc0YcBVLluj0ytcknGZInxiF5SjXlq7mAM/lBqV/3Nn2j++2DrkxTCOv4W+GziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0htR+K7Zgu+mag1oywbxBNE4guijH53kAFYRBvszOI8=;
 b=2fkO5JZiR8LbA33E5ZvqaB2dK49vB1g3hm164IfRrJNQjxjfk+BWM5qYIN0YMKEQRSpsQBrfIosZyuI3WDyLDMSWC8Roq/lNAvy0YL5TEBG0kvWYaGGLVXhgghiSnqn5f3y33GnTTI2buQlD/H7L5CBweq63cP3JBUBV491/eKI=
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by SADPR12MB140239.namprd12.prod.outlook.com (2603:10b6:802:101::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:07 +0000
Received: from BL2PEPF000352D6.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9c) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 07:11:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D6.mail.protection.outlook.com (10.167.254.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:27 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 09/16] raw/ntb: fix double free of Rx mbufs on stop
Date: Wed, 11 Nov 2026 12:36:43 +0530
Message-ID: <29897026d4667020f43f088362acdc51b995c563.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D6:EE_|SADPR12MB140239:EE_
X-MS-Office365-Filtering-Correlation-Id: d72c3d41-7881-4c40-3a26-08df3fc2f471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: ztRNXnjAtrPCT6EshL0KLbqui06Ih6NuQuSEfODgEjoEJlDz7hvHm0smjK5vruL98jQ6x3KgUEl0Gb9raT8qXuaNM3rfuunQeUpBCnKduIoyP4ZzS13Do1Q5WpwYZs+rpVU4likbKcuUZqbYVRYJktlCPIRYawf5M7Q9556vcpQCtgbd423GSjQMk1X8emtOylSFgIAm5ojcXSEAAvm7IDv3Qlva6oAPcEla/ktZiazu2RQtrkmrUtVZIOMoeZoPUl0X15Muw4NUx0MGD7uffpBIJbskb95Mmhwb2PYzF4WW/1ZEFn+Re4+piRMy5bEwTUNMsRIGK9yMQU4CZuTo8UOBn6gGoW4fTgS0RBEa/aGBMXlcOz25eU40AQgvgsm/qaUl+k1Gy50sDe6vg3YDcqA5l09vDdBelAJN/oLBiAF9QvQDXSsbJC1rZxtIKeecZrTMRyLlyy28P8sVBbqaeJuReSqPSnr22qvDO7bqYm2513L/6muQxlk1qN16aYS5P/kXyRJDFcOImIVDMRrkfar2IbmnGP5QD3Ct7gsiT9L5Qf7oB0z1+jG7Oo2BOFBE9y1lVVOy77sa0hf+RW6MIwkIUkgIA0ptgxkkOX2Lp2KWs4qIVv2LCjtFr21p2VH+FFMEsuu6b6MSaVnVeuqg/Le2KBVMey7G8M867JP/KfMf1oOj9QZemzZk6ZP4IylOnDJwVb8swH4LzSm7BRScdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S2INqBNwcby8Ew+vDN/F+pdeAEsEDB9d2kLy2lztIYDvoFZHlSUlyVwZCL5wMy1N+lKF3vEv4g0vUyMY0huwAi6AQYjVZ/IWT7TyoZSmuQnEbJh8NLH2Vda7z/iEnRF6bP5OgMheE5Vy3xmqV5wgwR30pqMl+9TutlgoLQ2odlHf/GZe9wUHCUTxPAxR0ODrA/7sYzrtCBiMk1aVxE1oKLcXRKGzVe+qurw3qmocBdfddKnjnBs+kRF1VLUNDsmgZwYuJ1TdlK9zUGqQLM5ht85L77e+xZ+vNgBhP3r1V30j+1kFTLklhB4VFzsF5MBTOpxbuNhNnmNzC46faDtE0/ZxFcvUZLkhW4ZXh/P/JaNS13J5oZXYquCJUB5QKaCAg3dB4m6xtRdZy8I9PXrViqL6Dilk2cEIjSncfwn967iX7/sncRv3DrEBkZQblKTq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:06.6721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d72c3d41-7881-4c40-3a26-08df3fc2f471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SADPR12MB140239
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

Once an Rx mbuf is handed to the application, its software ring entry
still references it until the slot is refilled. On device stop, all
referenced mbufs are freed, including the one now owned by the
application.

Clear the ring entry when the mbuf is taken.

Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index eb562052d8..5b3abcb008 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -694,6 +694,7 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 		for (i = 0; i < nb_segs; i++) {
 			rx_item = rxq->rx_used_ring + rxq->last_used;
 			rxm_t = sw_ring[rxq->last_used].mbuf;
+			sw_ring[rxq->last_used].mbuf = NULL;
 			rxm_t->data_len = rx_item->len;
 			rxm_t->data_off = RTE_PKTMBUF_HEADROOM;
 			rxm_t->port = rxq->port_id;
-- 
2.34.1

