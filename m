Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C6C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00E3640156;
	Thu, 26 Jun 2025 14:49:32 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by mails.dpdk.org (Postfix) with ESMTP id 1F895400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:49:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJIe+F4e9V5VjQQOHevVKRE+8a3vPQPpJtxjBSUcWFdS8Uy5xehHeVsSbbxyIP0DQOXmRjQ09KR9MqU0VMu0Hn38u/jGycyiMGcROFF3/PBU42eQbc3rKbk+XE9W5rS/wZO1fKFiOnGUvJzt0unNfXpkM06q3jbj26sRdyYn+97tnN/UmNSgLDXRvyRBsL/3ueVKRyoN/MQY6o2mTBQ/y4vIKj25MpPKrFDleVYm+HYMinFN5bC3Al6pcKDV2Mj5/dL9r08RAawSreYjMhL0F61D3/byOqHjvDDzFwQZYPa1qrNhrekcP4sbR22GoGTdW1On/xnsw8fH9ou8GGaADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l7HZOEnl5L688rFBj+VgsKy04y53KVi7mQiYi3Dgu0=;
 b=tWt2x36+oglM3V6oW2li7sPUmGKS7eHd2NcC5yDf1NZcCPy3G2lvAEZS+bn4DRwQVucEc8eb+IIffNYA5qYM75t3br8rYfEOmz0rgYQfqEIN/2lF1a8MUrnaqJ1PA/AlKrmIDSBj6SZokG6CMD6xyv6lojq6VUfp1MMxxAppX7O3rC4y7kgjcBSOc9S41ZYt2P1zbPwUaoBhTQTR8o4nn3eUvb/tcd27w7pA+t/ijZKwEqYE6x/WeJ4fh8OVxUlmGZCFaYa/sA20vUq79kWXqEiE2BHqzq1LfozMT33RI+fG3nTLpa5zJmgM27wiFh+k6NhlEonQ9/0pd9ud0m0ZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nokia-sbell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l7HZOEnl5L688rFBj+VgsKy04y53KVi7mQiYi3Dgu0=;
 b=Xd/kwzcNY8CoemSeRq/+I5AQ5Pi7hQyEwbluIeMzQqafK46ZV9dWESgTJjYgWuGu7CVFluQ456PlT96QquNGf35Fk7zzw6WkIK8luxL19duI8qHE5EywGVpT6HxB5k8CMAflJFRO5P62PI2ldNYUFSyplsqiZpI/FKnEiXwP+kqGHhJSMVQFWL4LGMiki9wTj8FDzh3vGnzW7QvnjIK5k1sFZGwUe8ln0y9dG9iVgSPOFbxRYko3NWKztsWfEiqZZRuKeU4DXwFcQJKwKTKyCTT3/H0tOcG8Hj4F23IHxTQKpRCvIymK/F3lciQRKmzBj+fz4QFvMKUcJoDxLw1CFw==
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 12:49:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::5d) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 12:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 12:49:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 05:49:10 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 05:49:10 -0700
Date: Thu, 26 Jun 2025 14:48:42 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
CC: <dev@dpdk.org>, <bingz@nvidia.com>, <stephen@networkplumber.org>,
 <julien.meunier@nokia.com>
Subject: Re: [PATCH v2 1/2] net/mlx5: enhance socket file path
Message-ID: <20250626124819.ualtqzoosiap5vt7@ds-vm-debian.local>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e79aedf-1d34-4cb5-d12d-08ddb4afe254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VtWeMD4PU6CxpVeaPY0hvlYg6cMwRU5h/csNqnZ7cpAiuIejWvyp+XTCsnjJ?=
 =?us-ascii?Q?foCyRaQSVj3pQyvM+9bAFTCNaczKdL9VG7o/EGGSPQYqtl2Y0u2s7gd3JqwM?=
 =?us-ascii?Q?vFSDzZFA4TdSod1kIDYXNDqAj2mR5q6akE6NHUsOZUNentsnPexD0qlDIPbQ?=
 =?us-ascii?Q?sj5wOLzyzqpwSDYzWo0y+F2v/qHSo3J9wWaa1WN3P9NiYrC86LvNabEs9LIn?=
 =?us-ascii?Q?P5guye8MIk9nO+OBy836GEh+Es+DehKz2cPrqSeUMtC/AF9Y+mArpN+JaRgU?=
 =?us-ascii?Q?PUbwnzEz3kA5MRl6ngOB8Eup0UoBWK7H7m5LbGEckLuZ5zS5GdT0kG5p45tc?=
 =?us-ascii?Q?zXwJOKwz0167Jm9tJOyB6YXYIIi5P+C1pz15es1ahGgcomB4TaMcHMy7N4Wi?=
 =?us-ascii?Q?viA8QVNiV3ZIr4KWrVOTn5SmqiU9IG6wezgkMIS290ax/pD1+mfkNuZ0SnS5?=
 =?us-ascii?Q?mCkyyHdUUpGMOAH06vDMbFE0h/T4kQ5lX3JsgkpQYHXwm4vd24G+msCOWnYS?=
 =?us-ascii?Q?WX3zuITH6cuA7XP/qRAOrQs9PuxYh8d0A5iYR+r+uS4OBg2xwvofNzSEpD1E?=
 =?us-ascii?Q?41wrmN2aHyuoTSA3VpWWJZKuW/13RkjnRINA45zKxEoLZwrps0KohTgiiFpy?=
 =?us-ascii?Q?uRiW65KorD9ErwAafUwYioGQI3rYqjyCebe+juHKzs+8fB9rrleI5dhV/4w2?=
 =?us-ascii?Q?jhm+htsufFNtef5YodiuM5KnmSRNzXA3kxs8pIXu/LKG/6ddchpUGEM9898/?=
 =?us-ascii?Q?Sub80tShu898Bel65kqU81agfpJktUTQ2RC/mEU9KaAz4HQzlyWiFbg0BZus?=
 =?us-ascii?Q?Zi0Xx5VEU8Z8Nozn8V2FpeKPpB7YGeKttMlDCpyIlLerAk86N1IDUycM3OGO?=
 =?us-ascii?Q?gP+7QkUEoJzWXl1nLC7wQApnLMP/LvZluH5gxsvtHiHMhw98xOBN6cR0txKY?=
 =?us-ascii?Q?rFKNflhGVGozGimLCs4rTjB8dUi6uAYl1bpwLP0ukFjAhal/OMO4LH8Ejzii?=
 =?us-ascii?Q?WxFyOA61NXA4ALXIWVF1RYdJ3XGUNxeOTDU1FNERG3F6iDDpK5/mqnclsne1?=
 =?us-ascii?Q?et/MIv+s7xzeLhic5HP1qxEmLljz0f/A15EOM+nMqh1mn7hvxL85z9TxSupA?=
 =?us-ascii?Q?8A4jw26V+X3yyk3050rDQG1pJ7P9t5a9tbDuUvnwrT5QTttuLi1LTcktwCwe?=
 =?us-ascii?Q?Db4g3Zh5ATRP/mmlmPdY/B7+MYx2YdN5RjPDuOje+nBcOwtlD4muCTq+P1yI?=
 =?us-ascii?Q?G2WL2pxK1V7QbQv03R09Kbx/KsGPh7FJq9UJQ6mHXiHqGzeR6v5y5vBShBCT?=
 =?us-ascii?Q?qfZjuzE26FVkVn1PcWDOqfD3Jxr8/bxZsyNZWsy65r+C3yAIyOxg0E7Wumza?=
 =?us-ascii?Q?9FGSbVRmlNLD8mBcn2k/BSOOlkI32N5wNUNCPyega735i93t3GLyHK/8PNni?=
 =?us-ascii?Q?3YZlbeKn1fhgf9CxgzHiS/kfLyH7NKtszphGW6ESbVlFQs1fk8yNlCuk+QIN?=
 =?us-ascii?Q?kmL1fZvh7jyeqv4eBKJlkb5cHxQqihrZ5Mut?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:49:26.4440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79aedf-1d34-4cb5-d12d-08ddb4afe254
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
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

On Fri, Mar 21, 2025 at 09:27:49PM +0800, Yang Ming wrote:
> The directory /var/tmp may not be writable in a container's
> read-only mode. To address this issue, use the DPDK runtime
> directory as an alternative when /var/tmp is not writable.
> 
> Cc: bingz@nvidia.com
> Cc: dsosnowski@nvidia.com
> Cc: stephen@networkplumber.org
> Cc: julien.meunier@nokia.com
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
