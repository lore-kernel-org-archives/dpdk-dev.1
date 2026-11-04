Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC35606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uxXt+FM8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15A8D406B7;
	Wed,  4 Nov 2026 12:20:31 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 58A76402D5
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuVvAsCUpKRlbI47VqbxELhiQ287vCzzyo/mTSUU4fz8moyESjZNkiQ3u+rZpFZX4zrhZi4eQ/TNllRI5oFlp8rDSvP1Bj+aBdncDdv+NncjCTF66pmLcCwxjR7ZXg7rD5Q6tNrFVJCAMf2VxmwyQQxMqOq/ieWSz43l7mNVfxDNu85V4wp2Ni7crAug0C9ihTU/qvamnJeW9Not0tg9nJYfnFx+jUQcBVfT8Vagajg0MPeekN9U31k/Yf5U1TSBkLtOvsgOksuqJ/T7is0m0TNUPC+/J9YxujDDZiq/fLgZArWUA5fAjAq0wvGJMooTtLVwkMrSE3HnpZ38JwAzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=ecyoO3KoG7t9fo2gpcn06SC4o14Fq9RGawQPVcsx/mB+2cbvMTQBL6HJQbraqhdiO3l5bQQQ1JdokGMa8+pVwycBk0u7SdI8x1g876tLk6z4xTgvtKBJAHdzbM8K/Pneo0FM216DUiN5dqA+PGt5CVNdlSQqa9MR+ebHwGiz9Z9tKB60PDjyFIrb/JJ274OIcrqWExZEq1nB90AeWRKGzv+ywooLm6Z/bHfnNAR+EtGcJ33Q3Se/Ye1o5KQDlu/U0NgNcmQSv3YTXyim9lVIn6rum/QMGY1jVx1b9XB9j7ZW7/iCECQLPPfRbgFLO67hWxZ3HP0+L0df2Tw/GrBoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=uxXt+FM8oywBMT0yYe9jPicZvuhFe0j0QRErPZKxGtVD/zAnne6Ff0Mq+PwHX/mNmCojCi+uoSzkCfx+W7eYzxSqHkhGNK4J8CExB4z1u058GDnjynM/PZscnu9NW5E06sUzuz4EQb9CuSGZl6bIJj2y+KWwH/p5R8JK0TjEjwY=
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:20:22 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:610:1ed:cafe::53) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:22 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:18 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 01/13] raw/ntb: fix device check in memory alignment query
Date: Wed, 4 Nov 2026 16:49:49 +0530
Message-ID: <20261104112001.661769-2-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: a0cc4713-47db-43b5-b3b9-08df3a659dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: rzKQ1i3vWLQ9oGBnAFVJnTYDXtAQ5VwpuCDw5nXTuqvNU9PufwQ5AhthCO/CyII3ekd1u4MySIvTp4kH5COESQR01KqV12fEaQDwzDgjoOH6PqOcZ65LcNUEGp42W/9C+yVaCfFhisPyaBPd4ofypAxe4yT1FckOJYcJ7R9JlKLFCSuR0m72ppPL52hUsnvEQz5M8CCq7k6CTcXfZwHAboLZJoBbPlDU+RZBER4TaYcXoXFEJZIpWmmQ7pIGJopQ5t2bGnqo0aoL733zReW3CmxrS7oliych6jAi+qXwAqeR6jFZhTris6aW98iuHKX00BHgBgauL6uZFp9nZxI5HQ2l0zZyMMpB5gnnSMx/qb5nTaJwmZ1WTeiAfjTbLAkrziEvO54f8akfO3+Z85jiYi1Qtid3m7JhHVET8ANLZagTkvt51yjkRwNe1C31thCSjvt8zlzKp+m99MsvoaFj6yH4eyUCfT+qYsMW6jXmOK4V6Y/Rrqzp8wPO6Hkv2HETlOq6P8feb+SGICBhissyhUODMJ7Ht/hznJafDSmjSoxU1pSH5ej3d8MOQ7YQ8FYGr/bPLqcAC724NbYR415+jfBGl9LavdxvpP0xF/vLSng3gESrcZ7bfb5XKzY4sZTCMsWSi4Znf0SKF97hKe4Gvd+qph0PVDZckAsr+eqbaNtlmiaJo+EXxBwUdGfbfkOV07ErYtEnDrNfTitl/kUYig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9j2aWGlQ6a0dN4nCH4Zuo76KuU1mvGDavT/GvrvwGFfiwJb7xukg5TWyKH/+KGcq8N/b+1VKaUG23B2F+XoWeBzwsNoiGdJQ+w6FxeVxyzrb7J/v/sPUbeAcMS4l+IzB+TH2NjwLY8sXHIUnRmUjkloOSFvbJ5WAYz9Io8WSgKsrRmx3BIDt/AW9siSDTDcwi+9U5msQY0xQIr/YRFcJH4p2AwazDwzixTiMaJoqa8C7oPz4RlShncvYV0Ov60tyuCcpovnUuC99JZN4lTRufSXical3P6DYZxKMby35gc10ceSkPbBAr996LAmn1Y2HWRa+++uQZVTvMNsSZZey7UOx61fHEsIdr+lb6RSfZOTD2G6n2inpP7G4m+Cq7c3qkSTZwL6QIRlTz47lRpPywHz9WjIA0yf8L4jN0Fw8vknYctx2rY6Rb2H9Umhnh6aS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:22.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cc4713-47db-43b5-b3b9-08df3a659dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

rte_pmd_ntb_get_mem_align() only checked the device index range and
the presence of private data before casting it to struct ntb_hw.
Passing the id of a detached slot or of a rawdev from another driver
would then call through a garbage ops pointer.

Check that the device is attached and is driven by this PMD.

Also return 0 for an out of range memory window index, as documented,
instead of a cache line size.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index fe10782ecf..e42af0b9c5 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -33,6 +33,8 @@ static const struct rte_pci_id pci_id_ntb_map[] = {
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
+static const struct rte_rawdev_ops ntb_ops;
+
 /* Align with enum ntb_xstats_idx */
 static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
 	{"Tx-packets"},
@@ -722,15 +724,15 @@ rte_pmd_ntb_get_mem_align(uint16_t dev_id, uint32_t mw_id, uint64_t mw_len)
 	struct rte_rawdev *dev;
 	struct ntb_hw *hw;
 
-	if (dev_id >= RTE_RAWDEV_MAX_DEVS)
+	if (dev_id >= RTE_RAWDEV_MAX_DEVS || !rte_rawdev_pmd_is_valid_dev(dev_id))
 		return 0;
 	dev = rte_rawdev_pmd_get_dev(dev_id);
-	if (dev->dev_private == NULL)
+	if (dev->dev_ops != &ntb_ops)
 		return 0;
 
 	hw = dev->dev_private;
 	if (mw_id >= hw->mw_cnt)
-		return RTE_CACHE_LINE_SIZE;
+		return 0;
 
 	return (*hw->ntb_ops->mem_align)(dev, mw_id, mw_len);
 }
-- 
2.34.1

