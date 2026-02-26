Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430EFC591C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F16D402E4;
	Thu, 26 Feb 2026 10:56:33 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by mails.dpdk.org (Postfix) with ESMTP id 53394400D6;
 Thu, 26 Feb 2026 10:56:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEP72g123Mqt6EOUNMk9DiPV5O9rYprQwCHd+barSEO+4cJ8a7KxQtCBZ+08C+eLw1ZMNhB9OEnY46l31clVcT8rzvGGLQDrkdhv6XApFdyevanNXnUisWBciEpuYbxdhgBU1bP22YvK1HC0xn2Lr7kpAwpHxCvfJsqYPTQiQM0zx4IlzqtCnxW9UqiRpdWlsXkYAIvQhoDTGNkDgKv4QYczl9bXmYHUYmlZzDfkqAMhS68mdZcB10bXP/Qcis5uijG1yAD4382LbMm/bFgPi8v/B0U5UJ/LP+bXe0ccSGb63aB/SvhSodheAPrV86k4YZ4FZ80hvj5QHX7BKaEvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW3iB+BkDvOmmdbLhz+pgjlR+6cuRx/qK7oieYDu1fs=;
 b=d0PHmh2mKhFDO7zPY3hFAttijpk3kI9qYBHfAbndyTnoR4w6kP8SYG+VuiXS2pVH1i1q8IF+eKWhnwosWquVU6z8XCI4StpACz+PU9zb63hRU4R+IG+QI0eO7rMITFd5A8z7ye3MuytIgHIRz8356T1cEGqUpdkZLKUQXZkvMiKlv6ke9pbnLt5yEijHPizF9RcC9tv1Tvjd+hSuJA1rG17SXDxaYMNfTlgtlS4phS6QNxflr491uLiYZSrehg55BCjjyhlr34HdqoapdYupRBmn8a7AZ6hejcjsML9ic74u1b49e2U7H3RdhZHwFiEbK17Ahonn2w8AQV1eGBugiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW3iB+BkDvOmmdbLhz+pgjlR+6cuRx/qK7oieYDu1fs=;
 b=PQ94JPT+EyET6RPMLrxPPr9ZQko/ksqZLevl6pcA8FKtG0oeeAV13wCAxkeqkU47NyE4Zu8lFqqj/g+WgUPopiTNv4V7azeVEwXuEbutnK7fzBa0jvz3ZTNpkUyq17pFMiWwi7kgCRPfbpe1umUhzoYylWvl53oR/7IRjqFcOgZllgMfCXiu+fnNTB7MuOfObBuwFC2q+kNoAqQBQTJedo2g1za8cjouyRZysQfbavEz/LwnlFjzIcWqBZ4N2wti+lxHV7Vd8r/PKO7ZiD4W3x8iBAVd1zKFOhH1+b9zbqPNwkpSdKYQUSXmGz6UWE+AVZElC6so8j3VxqpqzneYDg==
Received: from BY5PR17CA0064.namprd17.prod.outlook.com (2603:10b6:a03:167::41)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 09:56:28 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::ec) by BY5PR17CA0064.outlook.office365.com
 (2603:10b6:a03:167::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 09:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:56:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:56:11 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:56:10 -0800
Date: Thu, 26 Feb 2026 10:55:59 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFT 1/4] net/mlx5: fix NULL dereference in Tx queue start
Message-ID: <igzmdyfxvs4mh4et3xbezbczlopmi6fr7qb4dq7ipfvz3tcobj@nif746qxbxvr>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
 <20260217150635.134031-2-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217150635.134031-2-stephen@networkplumber.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: b89d690e-e443-4fdd-e942-08de751d4f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: KbtptYdR43JvwWTfgelK3T6lW3jJvl6zJe1jRXBgCaSjf0HikpiquRaqOuhAWT1VVom3jpga8AO2PlG+T5CDH03bjITNCuxwcLxLebUrIAaTKh92hWh9/+fTjGbuY4rq7FtG/ZxIJpR6EG7aM5RiR1F4StKBMv/M6O/6iBeolPbVbpIeltEzOXTNX1jYg7vb3Y6gAq8xwv1/TQ8fhZvC/9az5AZO9EsX5m8JzuUwDNTZSlpxrqqxRrvbxNqwcIMT9/wh44NTonK6NyjtqQk6NqQxUttHmzYXacPBr61ZtGTiVu717AVRw1FrDaU99zEuQVhZHynaKnmX+q/Ki2k8aPeaZDfZp3AcsZ1Kyg2CYfnCIB/M9ev4UQ1hHv4n/1xcsUd+K/r3Le00AWUlKmIx80YIFvwMfFWn1A6Qp0jGf3zkl8NjAk235IGPnx20+G0UE7jtlb11naCclX6/B9G5n2/A701yGHDfRW/Mu/gYlmQ4xAt9CgSRhYN0NLe2O6OyYllyhefyIKAES+TWb5y3JPmVRQlbFQMLG1c2tu58wTQ2IyKQabZuxAuvR+ewBePnJHIyIZhyfABaPchSSGANw3Y0L2cWGGrDup8U9VDuRwqH+wQpvAMru7lAHlniDsou6IfkvDZlt+LrYhdL/2gUQXFnqIN+Lhvsax0JaCwBAcXkNHYvfkTDkOvMjs8i2z867i560N+izfDazD+vYtRNw20D9qs0jtBoFbxxHBenIwZBe3wJavmu4fXTTowhagPiyP54cO/E7FwbDu/E9qxrtaT2Zc7xIC17F9OyCNpQAye5wwHLM/N009f7nAy1B18RXM4no6Z8dftVYzT1HyFHjg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXpEG+wN/t423t3tC4pekwNX3xWWWFxkNc9+7ZyyUxr6Xf7KTEPCkMu9vrwdfPasCfp7g4DMQiAImD8H3tD+7xqr55DXfQbcV70Jza4QhDusGPmW+3FWR9w/60U97vn/cXNtZFYLJI2wuLIWLcqUDLabtKBt+PAr6AM86PB7WDjC1GKb2NB5lr55MLCCy9zgsEojgxM4ByZY4njQcnh9WWxLuSLqAXyfpTOCHHCf7LTgCzmRipgsVFxXsivD558vOV3VJHeBd7Rntd+l4d69DYMLVwD1lePHlJYHeuVtPfQzW/caJP1wPdNmkRwoaSf/mfLd4e617KnnepXnoDLCJfHJtlgTtC3KP6oP8O57U9zlqoKEsJ/g6wwUDFPAUa8IMqFkgR2oXKOb/R1NQvekEIhCBN52o115xYIhwQjNVsFta84tCmKq4NDRcBWQwCXP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:56:27.6689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d690e-e443-4fdd-e942-08de751d4f45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

On Tue, Feb 17, 2026 at 07:04:59AM -0800, Stephen Hemminger wrote:
> mlx5_txq_get() can return NULL for an unconfigured queue index,
> but the result is dereferenced to initialise txq_data before the
> NULL check on the following line.  Move the txq_data assignment
> after the NULL guard.
> 
> Fixes: 6f356d3840e6 ("net/mlx5: pass DevX object info in Tx queue start")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
