Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E20EC88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 08:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 335E840269;
	Fri, 11 Sep 2026 10:40:46 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17]) by mails.dpdk.org (Postfix) with ESMTP id 40D8340264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 10:40:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9yF/jrLlFFOp9aRAazZPoBcrbGmhxnGr8RlzHI4SR4GSlqrI5f8rJ7e6uXqvdTz/Rdhox6qlZOCBOvrqxD1KfJyg6aL+OQ9B4DqtPRtkfg6a+gP40IgqnEiRPBmWYQbTKTeydq0m+DIXCnGGqJ2ahZpkv0rJUY60rGEyLD25qK1ye51bUFcyaZNnT5lUXH9hizK55Ba2v3Q8Tj0j2BU650BDY5lc5SBUtWvGXwZz6oiiqCP275haPk/APbOYQPLQZ2F7RPO02+Sin1DDmAzW3NKBUcK6osf+Jxa/frdY1WrWRq8v9V+NIUShmWJROqEXDJMdtRm6zeOULUNBD2RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IrI4DXK/nMZ1hprpqr1TJX1xdXoK2SFkYCqhFaXCkQ=;
 b=jyMikDY0UT3SNKwrK+9ayxZr0l6244BEZpi4M8YYvgDjYi0uKXvkpb92usyvpM3DQn+fbAjSAeZY4r2D2CQcXU9mXWDM6tU7XD6V8crBKG8zxiF3Lhw7AETiCOBGObOSJECdzuTc2sM4FguYnucWibfRESkP98IU1CeHxWnSMi1dolPWCQoJwNtN/g1cF3ZdF/gvg32A6yPe9mJwe5IwqwoIznb4i4Ao06yFkC+Z6DfjQNOrGUfN8YcAtEWxq0hmzT2lQyh/5HLAT9uG7JfVmzm7KUtk0XWgjBtVgFeLqnb2LVeI1uRs2VCLJmZkJmEFgvvoCoCj+GF0MWtAZMi60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IrI4DXK/nMZ1hprpqr1TJX1xdXoK2SFkYCqhFaXCkQ=;
 b=Or4NpXGfFlV7S/YKhZaov3Mw1vVvOPlxBOpRN1l0y9Q+Omr0WHSfEX9RDgOFaMM94WXC44c2QoiysPoprloB1LON4hVE9Cc5l4Vftdod3B02ROJmlTKYqfoac5BUQswEjoXv0Hi9GROYsNNSACegHIHPwc+lF3hmUgjkjQDWMCCbvs1w2eo5sHLVLj4aHyXpqMM11dXYXDwghHbx41siy0M0io8dGpREyJp98TrgpdGZOb+xB29s8KzZgTm+o2qHPp6t2bV1gZHuZbyNFqiQdD5jQOfQ0swMMF/sTRkl99IZqZaF3eqfHu6NNsAIaS35pog9Dv8O5/Lq4mX+iR5psQ==
Received: from BN9PR03CA0095.namprd03.prod.outlook.com (2603:10b6:408:fd::10)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:40:38 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::88) by BN9PR03CA0095.outlook.office365.com
 (2603:10b6:408:fd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:40:21 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:40:20 -0700
Date: Fri, 11 Sep 2026 10:40:18 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v6 4/5] net/mlx5: use bitset for tracking MAC addresses
Message-ID: <icq5nyewmnokgfszwbio6rk5jvgfxv75wbr3xwwjmsxuhax6vz@jjhb2n66pw6k>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-4-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908092743.3439825-4-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dedd081-dbb4-469a-0b11-08df0fe05b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: P1KD8FAad/b+OK4/35RoIRjSX4XPChuWUr/JYWXQ0bCsru20HJKuNRGrC0AfDsUzRCL7O+TTkr27DxDwRN2gGMcYrY+XH4IAOvrsCPB3C1q4E6yXlTfx0hWWB9kCtK+bNlgxrtb5zu/a/95zvdDbcL440QfW42Ly6Q6J0HeOiEq6kYQRGVBU1k9ovU3BfCWXRIv3/36mTSASNu9A5oFJEOpOQCJnXQE5xTds+7FXy3DDfZmQUe+dL5C5H/RIAWOOD/5wi1OFI5f6Xrlq0k9t5z0kIdyhdblIRf5SGqaJJpSsZmCx0GDoh6hryWKWesmPbD3h1T4b6pFk3LTx6WpP+JYjyatkwp4MWTeipOdkHmGI49aUgz11WHR/5qmVsxpIUGMB8uB3x/g3gN2ERhXsb2WnbPW4wFuXZ2gqoFsrE0dmpPxcWJATNn9IhIykKtpdnetcExqr2rRh05fKS5TgDDOkAuGbt+gkafMn+2yXuCmZ2ht9UOIN6P0RPR92WOknAf8Gryp6PxC9UgfTe91T6d+6HnP+/BcBZ5wyG09DDDJOnAERhXXB2DpNprpUHEXUlDzCsshjvY9O+1fN7eMTmDltH4I3cjFYzGVowQuRIDflxMayNPEANe0UuUVVzGb4cSWKIu37PtFPVMPjaGHzRPnSxMBNP0f8289beUKBAJcpKpBz/HgIMWtvq7Qq7NvOFeMMaUnplLDQ5lq5W9fBIw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JpVe7NeeNoHUmPaUHpgnQMeIAIW5lOEwrWomTFp5kggKDI22+1AB7nwrk0+BAgXK9hihbxDJjHuzEZvsU2OOIwwXhR3SktOAwDv4kcn8Qyj9JR0pM8YUJ76/YgIdRvzC4mJMoHjLTM4BmQGpVV75h/0GQJK/5GQsd/QXE4b+MjTsKRZ8KIMf3ZmiGWwNW4F3C0uNw/Zx4btml7Jec4pZOyBkJNHDVoxzdaH6WDX3DDPxZ9w86m3f1zYOM7AoKwKJITpUlT5zG04HuR6yniCrXNa9Uys+nqgsForZVBFd4MwlT3ELfe3Sw6kHaHnnJZbSogD2C1EwXxlplGsUhOLOYND9B21HkTqvCvWZV3hKbDmheREBy0cLc/6CcB128QtgykBb5UPrNz5oo0mZD2bapaLpQSsU9ozVSq0JKQaWimEdCFl7E56/NHQALgczpJ4J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:40:38.5787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dedd081-dbb4-469a-0b11-08df0fe05b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

On Tue, Sep 08, 2026 at 11:27:42AM +0200, David Marchand wrote:
> EAL provides bitset that does the same as this set of mlx5 macros.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
