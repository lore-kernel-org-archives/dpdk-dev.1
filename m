Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDEF013E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 08:50:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEAEB4025E;
	Mon, 16 Mar 2026 09:50:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013010.outbound.protection.outlook.com
 [40.107.162.10])
 by mails.dpdk.org (Postfix) with ESMTP id E401A400D5;
 Mon, 16 Mar 2026 09:50:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbHw3QvFmSmMuupH0tudu25Yis/i4l4CdpnkryIS//1Glp+q9uVMlHEZIMO2YhoqqCpIVoXvWqzlJq/zu8QGRn/8RdiBZZfJ+u9NpHxf2AEKPKyn1ZlgYL1G7Ieq9e8fhJIRzcJZULTnD2anjn1bVktD3CHGJkb9ggcebLuMvk5YgOHtYapsUUdg6YYI+JuLM6Q9aMR6KFmKFUhbySBQ6VszZObdx3INiWQnTcwR+T84MuSnV/VXiWNgONiXiI2dADvUUziVgm7anKl1gSS8yfA41wBFr+kv/yxy5kifGiIRQxMmJJIbcb7zvj1429hGWWtHpeXOnDOWV5j+bYrjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZhpK+zvaS+8r4CKDsNr8uVn77kJlQV90yJ7J1tEnRU=;
 b=vASwhlByC26AJfankhNGFwSOZ2b8jpusQ0cu0FMir/LL7XSxvIQ279UhjfuPiLXldOUqJb+ZcyyEYk5DWYOmGpq05ONTIyj9rogZNYePrpml6fj20szQmsi8gz/bEZP6yOrgviGd2QRuZ6FvKg5j/B+GvXd8pg1X4ge/Uk+ZxAYCI57Em+A0NHEBxIqqVs/8NSqynlPIgG2psxY2lsk0IlPv+0tMjDlNPOU53e9UPPMa/EhWF53lB9p+gvNmo9QxGKGBuraZqGb6jta6Mh2vyGclC8xWVHevJ4bakg0EeSJ1vcngRBVuT+VvgSgwLPWezBhPIJravNG0NwSJZAvb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZhpK+zvaS+8r4CKDsNr8uVn77kJlQV90yJ7J1tEnRU=;
 b=w0hr3BLrBddJimO3mXqMUu0SfZTYyi0fZeEpDhlCu2R7csh6SrpVtk/0992BeyBCKqH23A3ACGD5fTa1+d3UZFoNfU59d1XyEgvwCnu4GpMIRZakI6bBgi5v8YJm7BvG+pBDRI8NkF+4s5eyA3j1NpRMFex127nE9kwPsR87POAfy9J0gBTiHDsF68OWP9DnkQRkc7JpGA5w/zj+IiX+VglbivSbwiqNd+Ioup3prn9+dsFF86OU9KnfK5LFcA+gIWF70jfInZLntBBHePx9ko1hqgJ9DlkFXKmwEoz8C7imP/yftbdvzF3FXRK64rasVXInNRDRmva3ZLPJtoXGGg==
Received: from DU7P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::27)
 by AMBPR07MB11462.eurprd07.prod.outlook.com (2603:10a6:20b:734::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 08:50:06 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::8d) by DU7P191CA0014.outlook.office365.com
 (2603:10a6:10:54e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 08:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:50:06 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Mar 2026 09:50:06 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id B47024020AB9;
 Mon, 16 Mar 2026 09:50:05 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 9CDEC60B11E5; Mon, 16 Mar 2026 09:50:05 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Mike Bly <bly454@gmail.com>, <dev@dpdk.org>
CC: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, <stable@dpdk.org>,
 <jgrajcia@cisco.com>
Subject: Re: [PATCH v2] net/memif: Fix memif-rx buffer linking
Date: Mon, 16 Mar 2026 09:49:06 +0100
Message-ID: <20260316085000.3492548-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAB3eHOwcEg_7A1rsDFm7QuGQXd72XscEkxg0PcgkUqe8-ZVP-A@mail.gmail.com>
References: <CAB3eHOwcEg_7A1rsDFm7QuGQXd72XscEkxg0PcgkUqe8-ZVP-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9F:EE_|AMBPR07MB11462:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cff128-970d-452d-4120-08de833905b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DL32F6P5S/iF8RhOWryMh0uiAMzb4O9EG4ud3Aqtg+639XIKh+p+cNJTMb7xK7uhRHJagTmXQAD8VHtPrfPzbrokznWaCeQz0deBlbyNBnH+qEy6LYG+qLUSZa8puUcndWiwKTrvxyuurfLN6vztjmzs0NCC5Tr57rVQhJ5A6WN8Tw1uVpy9MPkXe23AcbJhe+qczy3vfkQpKe/5YIQns2Xaxt52iWNLMEFXlQtfVQIPc787y3Tsh0e3VCRwzzS4ZSNWdTEMyMGDG2DOKlvf1Y2QMQiGsWe/Uk8mitQhX1hLxJIl5VidJV2P6GvzLacUjwRHS36mjFSbfhD3RMJMdN8kTEqECNI7O3z4tnZbQUyBzBXy4RgVA0F63qQmQyMrodx/227P4Xp48w8/3LK9fpyDM9jJuwQdmf1J1edTOPXoU3gu7NsN7SyhquLcTxQyz7wNtBoTBfB4qO1/msBusZwPY6sFyT0rNV++zhFt2vXw3Tw7t5TGHjr+OKtxMk9soZNpTeEdpqceMxZWwfXj8/b5skLXLCl460to15QHVmmfMLORVHHecDlhqUAMuMtSb5wHQ8P3Hhulo5h9d3uTUp1WSp5ob1IdBwz3ZQdAM0JJAxlWCoqzTde5mnmJx4FPKW32utney4MfAC6/+pOayu5R7ufPoIUSCo9cIdNyiz+KeKBZUHL+o5mDKQTR+d0kc4IKa/sFcXkktmwDLJWNFWHPqOiCvwBsVaBUgcxQdkvVdvB9wYM3dPIlFnCN3eyeJ8IbfiwY+1KXXxPKxV0wHA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 63Pjw+0HtjSl16LhWeo2rDDqJuiir7gacUFKjhXFgMhHSr6d3XmNdrqVFX1n8kMTVeO0mCNtlDRLazE0YVyGb/0vH8tz4Xxkmurnim6UbuO3WAQ/EmrdPowE5fl0CLu8txZnQ30jnmmsETevVxKMrbpKPH9oWW6Zow9g/4zC8oveevwb7iFraduL49vPsj3agpExUGGHYgp0QoVR8l/dm3Pn2GZE/0qdqGOnIP+vfCzqlAGlXf5mOUay24cHol5ku51kbXB94HffwONyIICvvKHgDqiDVBj0SPCDe6f1Y/4OjHjpXTDpnVnvDVO6n19lQVBRXIRSXmWDi2Lsv60eGtPBYLCkbbCVCbT8Rf0PWe45Co9aUttqstEmknz5IkTeYaWLFCG+TgYc+yXmjnRqUdFLlfN2F1KdATTnZLS+8piVL3dTqKF/8+LqfypAcX4l
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:50:06.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cff128-970d-452d-4120-08de833905b6
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11462
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

Hi Mike,

Do you know the status of this patch? It looks like it hasn't received any
review since it was posted in January 2025.

We've independently hit the same bug (dst_off reset per-descriptor
instead of per-packet in the RX slow path) and your fix solves our
issue.

If this patch is stale and unlikely to be picked up, I can send a
new patchset against the latest tree that also includes a 
boundary check for MEMIF_DESC_FLAG_NEXT when n_slots is
exhausted.

Let me know if you'd prefer to respin your series or if I should send
a new one.

Thanks,
Sriram
