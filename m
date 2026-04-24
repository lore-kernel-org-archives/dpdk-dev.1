Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B99FED3F1
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5B0402A0;
	Fri, 24 Apr 2026 18:56:11 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18]) by mails.dpdk.org (Postfix) with ESMTP id 6DD7D40274
 for <dev@dpdk.org>; Fri, 24 Apr 2026 18:56:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaMclM00zS3ax43gp38pKvv3hODGdC3IcI55zOhbjy7EkAALVD55VZbNVmd3ENDD80pHIoa8yGN/NtYgr+e9I3s5S4b8LeC4SY1ctMlseNiFU8tQSFsMdx+1BgfgFG2394clXyKC36Jjx0PQk7rUlwy83KW+tO93+qgsY63pNjO8iTtW93xfZyPR9nlvTzjbfL+jkD7Py61t85eQVEsg/3eizQVhRvnwd02z7T5v4ImNuAp4B8cum+4DWLY1P/2qcrUcgli850cKxD8T8YRv/PfVVh0k9/+kNUkbAhCxk/9APCjFCecm2wC33GykpYhJadQYvwfhF/THWbfBfDx7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REEWOi+2EwtkxaiK6bXUCfYBWSq1xUvaeYv9Fu7yylw=;
 b=BLS6m+7bfkeOGYKt/P08xC+Vc0wwLspRsXY9dEOgt/AmXMK8cHhw6oSPKXbiWdoL3JJ5gUEF11XY1nNF1wnHKIiUY9T6E7mKImNxu0EgVrgT1bCOgV0J/XrbwcXTXe02XhalhEPu7z8Qz8E3BXlVc3b3L6VmJA5Rf4iwdf4VOv0rrW45ZD1tppqF3RU59b6ZAVLNe/hTanYYurMTv5kA0H6dYdt8kCcVuWo8U6GHwVK7BDYlQaLTCyLDMtC4dXmZ0lQBLgWIWv5txdAFlCL4SZ0GwwpCtyQwkTTpiYYjuhJfcXxYORM57nteovtTgcL4z1nbBmFa6GQbGYXLB/pWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REEWOi+2EwtkxaiK6bXUCfYBWSq1xUvaeYv9Fu7yylw=;
 b=UFUYk02j7dksncGJPV80cuvAhRpLudGycE8en1eOtiKeKnMpvS+aEYDqvFiNjbgh9HF317ULZRwi0H5AG0un7MIIA1aTuO4qVU6AbGL2SMs+B2G2VaMFNApcn81TIbK+uULoLeJ2oLHBhGbCLPBQzOq7Rz+ZoxC/y+IKumhAzhBSqkJWCrJr4jkW1RFy9Ny1M6+bf+CbIw2DuSBB/UUZBUd76B1ct9Xum9t3VIQK66LljRZroqmLnvWvvxBhwfyhwFfWxp3x0WE0jVKxEBwO0rlMdHGBRLrTuvu0HOE2eMtenpDDF5iFW+r6InIZqew4/OOzdtPJrDFvd/WYWw6DbQ==
Received: from MW4PR04CA0271.namprd04.prod.outlook.com (2603:10b6:303:89::6)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 16:56:05 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::57) by MW4PR04CA0271.outlook.office365.com
 (2603:10b6:303:89::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 16:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 16:56:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 09:55:56 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 09:55:55 -0700
Date: Fri, 24 Apr 2026 18:55:54 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rayane Boussanni <rboussanni@gmail.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <rasland@nvidia.com>, <suanmingm@nvidia.com>,
 <viacheslavo@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: query hardware capability for max lro size
Message-ID: <72dvdehfoyasv3kjeiky775apxge7utih775a47rdg2hrklswy@orbx7gvj57p5>
References: <7z76boxf6nf3hzvspmc76ldy6idbynhusjcvlik2trkccupfiw@5ldoyqampej3>
 <20260424142732.1904-1-rboussanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424142732.1904-1-rboussanni@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e90f0b1-ce54-45ef-594b-08dea2225fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: O6t1xXyHEMk5GD+6BQNQdQ91JgQuLIkcNqxozhUlLL4s0RTAYaINbxRDpiI8fSobDhVk5M+LJVBLtiRfa8v0oAB3SAWx838L7rreNO0qvu0/XrebdJ5zY2x34W5L9CqsQlQckt7MrQBOvNi31CBPUC93qj6qearvR+ovzbtpmIwlKIVTMfa8g8FqJwisFEPF3VWURqmB+1apl+HkydL+EhjRvYFaDybIYKcR6BwzM5vfsFZlCAILZXmqmVqrkyn/sU22I4/2YogSe8AJBvlkDE9J3gcHP3o96a9svTT1X+PWKhIoq9DCz531efswZrLTJCEZYZN19MOPaX8VUt5kygjRbZFjYebqe9rOS//oKqrpAbKsqrX9nQRapAJar06klsFJqqVDjrSdvSfqB9UcCrRcoiBzbO4CDiN3iVkZwJuAvOteaXXLJvXdQVo1iJoa7BYcLT/Q78dDGBZNSq7bybUTG7yPvzd4pp24C7sm281E+ca00wRcZS2h5pN/aMAG/TocJH0VBN8bh8HhCPBI7puFiotvw/jGAaYRy58GLQ/5fChlwiIHYvAwC5kfIAtyzXLuryXR1dzX3CA+ypm8I314h/8fN8NuvapPZJVZxk+1QGc88xHgYzfDKq1X9pPkUdQ+2JIEQj2VrIJQ7+mYoyBFKfGDleyQam0mOnYNGddPLo/2WPOGgnU4gB+HvF8gDnr5dOx2frboLklCIhVDhYNskTV/WgXHENcJXRU/hY7ElGLaFv6YsQzIEZSxXFO3rHM/XFtltBS1fT6ZT+i7cg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xEz7kFru5+w8D42UWy136YR/6JeJUaYNiD4A7TSvalxY0SQkyOsDjqTFcI5eUZ0rNd+yIXh8Hu/LvS6XmpWup+uINWeAvdxothvUYFrOGsrh1xdrYH+zMlXwyQx43T5nVwUPLAGaPqAmT6BnRf17+BQrLPc/AcL5AjWYBnKwJniTH4Coe9Gx8J4E0fbXUvDC9usBs9YPmyqrQk33SGkDAA9Sm0PIqGTaqhsf22grFCOieZzmxryCBWo8tBR7q/LPkHa6wKKpdIyM8lC3b7BqrrJ20mn/uUFlNFSr47+ipUeioYMGyxo3j+y9oN4lNJkFj/rBPzwTaFYgEWpoFlP2fiKH0sMfH2d1RgFq2kp5AZBr0h78jsvEAu2P8SvJD4Rz/86H/272Zaf++lYtTOt1xViCPFXWzqEV9h7x/SXjb34v1h/lKkYUvE1cXRxVrlUU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:56:05.0449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e90f0b1-ce54-45ef-594b-08dea2225fbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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

On Fri, Apr 24, 2026 at 10:27:32AM -0400, Rayane Boussanni wrote:
> Resolve a FIXME in mlx5_dev_infos_get() by dynamically checking the
> lro_allowed flag instead of unconditionally advertising
> MLX5_MAX_LRO_SIZE.
> 
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
