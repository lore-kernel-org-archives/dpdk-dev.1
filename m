Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB384606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bXglVNzb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1EBF40299;
	Fri, 23 Oct 2026 09:52:29 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by mails.dpdk.org (Postfix) with ESMTP id A6B7D40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:52:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkYVyuDQ4OWLQqRX1tj8gAcViyf5FLLmx50GlnsouSxpv38GxqGmanCN6NEM/W4f6wZryCDetLK6N8dxlp2YG1SCidz933z44kHpzU7u5dgB+Q65aTE5Nck9uFHnxooKhqLSYJ97DlaaVRXHygrQ3nHSa/kLw67e/ap6gL9Hd94dTTqe2FQW1d9b+mqb1kANQsCb5fO1gx0GJCsVYWIk5is9cXztt9Hs6p8Fm0jsT5gw0hj2EMWUMkMC3eY0/XxwdKdaYZg/+jn86ZY4ACnldREpVBZaE49Q0zi6whWUL6fYT/Ccak3O9spXfRw992tDphfdHmRJl+DQIG+kyppVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JlE3lC+5e7xA0hh80RGEkY31kzv7lmtPX/TtvW0MM4=;
 b=rBscDn/WFPz6A+BPJobI+IeSaSIn8fzoXA8MxT7KmHnZRyYNc6/yaPiDEs6gcXLMxV8lKvOE2ZuzdRsK5FaOWzzqEjtgMhWuucHf+hSmzVJvnDj4etIaPxyyp/3qU3hHVLbVGtEhBaEkac3NCkUNMSoJoP/V+734xkh+7WNMPAh27G6QeqPd3oiT4wGDweJVAkXhmBz5drKySPmuc0HpnWI6ZepOzvfjV/Ok7TiWymYFlc5Lu8hZCoZa6qvtg0GDgIq6mskysB8G5daQ4+VIchBbcmStMCBJt1RIXAWkNiCBtquvdVY0gqwxqBAQsN8YKTfINScQcJji+nKn32FUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oktetlabs.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JlE3lC+5e7xA0hh80RGEkY31kzv7lmtPX/TtvW0MM4=;
 b=bXglVNzb8eJ4eBZMEUqMJmlk7Qu/eEDRDV1fedv29Ce8sMbgxAtDBjq71zK5CjRT5CTa1i9L6+LYlLRgD4FthiLfGuavj0R4z0I0iBpt4wYvjIgCwodChp7pkfkw4vY92JLgHBj0diCYZVn4Fn5uwYDcLDHh8v7hCl3LyC8ffxoXNTU21n6t65qSERhYjF4lQri8JHGhyu5UUzFtInuLgJTJzUuxmZr4XSIvroohKjclvGioCgzORPJZtgZSxPbPex1EIQ+VYRxv7cJqUD+70QSZ0K/TNigorv78OhA+nliTZsPfWkIR7jKdVc+a4xBHySQvPP+acw68lHYGFxhnkQ==
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 07:51:47 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::7f) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 23 Oct 2026 07:51:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 07:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 00:51:30 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 00:51:28 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, =?UTF-8?q?Morten=20Br=C3=B8rup?=
 <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2] doc: remove mempool deprecation notices
Date: Fri, 23 Oct 2026 09:51:14 +0200
Message-ID: <20261023075114.35991-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022164844.34845-1-dsosnowski@nvidia.com>
References: <20261022164844.34845-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: add41e3d-6c57-4c0c-84e9-08df30da7c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|261022075727099003|11063799006|261009223027099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: B2Un5pFzpRQnDvSOTQiEvQA4B9B1vRBCg87z9f7GCWgDuH9l2MlbmXSGcDByNFvxzpF904pvGdOtPvBYbN4JaNiGh6SZrW/PjWomqAOGWPOwFlBEPufOmqbq3rpHKMG0dceL+oxfrOPAieQKUClMrh5Tzqi10iVtX4t7xFxcjDXHn0/EEWrHo/UQX94mVB55koWL2Q9ZZnbXPogN4u2w7scDrW6UAww870DDZoNtQGOTUh+RyOuY2x9VgpdXsEQCLLouJoaP1+OWWTw7pljHNVKMZtHltCNWyck9x2y5vvgO4xHvCGVW4LEvBSkp540Xc8zhYdBwa7CKGp54p4Ii+wi9SMTiO2E1NRsO4mlHsSi7wBPNP09savTcKKQ4+XprFAdUrlN9EUsgzZflYvUo0UUtpkZT/0bA89BMO0+IFFH4kCD5BlOnhu9AjWDVnzoPIdKaKxvc6FCyBNquBkq6ttLcbaPRBBnSNWkx6lvBXL+rDcGjqdo9beYV1kcZywqtZwtjJGaIPrCykFZjnQIz355grGqGoueVkJmODsFnKDbskar8igAA1E69KoYvg8PDB1t7uD+TazlX7lT96gB/PboWnrtXINsbMYiCIDP/hZujgpOYtnxjqU8Z/04ksCH3DM4PEVrZ37xjRF6wyWj8kTio4iqAS7hzrcDHULR6bJqE6lreTtGWqVHYKh7bydiwNT+2ugc/aDJcur6xGXIVbA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(261022075727099003)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VlgFfR8a40QCxEsKrAku8i+DelD6k6IgLEFoB3FIIIe2moPRkGUwWxfh3qNkpZFapTPhQys8gDVZ/3beHlICeqVluGtxhUYunF6f1hnjLbSSSwlSq+28SXF60fffSQnj41dOblYLmfVPnodF9DE+W0mBbIJ5+GuhxANGHuYKxTMkpMBq+A6rgnHpLmhAyNv92LmSUBS9KW2vcWLV9/4JJgGptPw7OkR/rV+bk8OnsIogIQJhQxXHfUb9b17yyoJSRBg9wr3r29eWu0gFprFtuG7NQo3nQ30r6q2H8XsPtZCAnWB2mH0nspLBTmN0WdkI5YTpGTSU+ckiC9ow0HD2Bbh7XKL6JH4AbGCbJaAn5KeDYZ7ZYRI3udX6NCobSu288ZdJ9iAsbi18idWdzl3q1XzlTjx0zBJg5PUo+LQbxQUTOS9EL49MQBz8yXIOJ98C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:51:45.8458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add41e3d-6c57-4c0c-84e9-08df30da7c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove deprecation notices for mempool:

- removal of flushthresh field in struct rte_mempool_cache
- object array in struct rte_mempool_cache is now right-sized.

Both are addressed in previous commits.

Fixes: 7dbec9e69c36 ("mempool: remove deprecated cache flush threshold")
Fixes: b815acfdfc48 ("mempool: remove cache size limit")
Cc: mb@smartsharesystems.com

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
- Removed notice about mempool cache object array.

 doc/guides/rel_notes/deprecation.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 29fb7d56d6..02b495f6a8 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,12 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.

-* mempool: The ``flushthresh`` field in ``struct rte_mempool_cache`` is obsolete,
-  and will be removed in DPDK 26.11.
-
-* mempool: The object array in ``struct rte_mempool_cache`` is oversize by factor two,
-  and will be reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE`` in DPDK 26.11.
-
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
   used by iterators, and arrays holding these values are sized with this
--
2.43.0

