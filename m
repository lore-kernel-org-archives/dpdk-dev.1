Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F218CC88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 08:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21AAA40269;
	Fri, 11 Sep 2026 10:36:54 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71]) by mails.dpdk.org (Postfix) with ESMTP id D291740264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 10:36:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5WSVx4toUC2wBQ3Z77ecKQvjOGfAbpxsPNZxSzB8O/siUAMIXdNGSr0ioCCJLKMO7IsBc4jl1TdtOovt9KwyTB3KcRBCvTH1k+4FYyBASM8mijUhnQabe/CLJW+ByJsEbt2EX7HZTkZ5EjNV+WemqaWxTtF8pwjCXv2TU9jV6u0ypvqJr3On/rzvgSAPXUisVAeFM349rletANhj1mRlmYCVm+sumA26pVBFeJWGExyDhqabLaECGLZEOtd6ETaYpxLC1NSVmSbxnFzyDQYUBxkvlhTzWo9uNxkfbT9IOXSUVFEEUISW+sPu304KYdTDmjRPgiAs3QkpXw2uANSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h23yQvZJAhzkxqeaHPYNATuPPuLlQK0hf2kUa/0gkBY=;
 b=vGAqB22DSOQRptzh5Xh11D1XvjCnCgL8XBugBvj08frT7vh0oa9q2HfsU1Qc6wL9zBXQg/PVX0/IEamFrWOfXEndKwifHrVuKbRxZ0rhGSgDQ/iY/u6CTL9CpKulFSBGXdMdvYQzwWB8hnzhwq6OJtsRIlrSVNtx/iGHxu+CSAsHoGkl250G1laUbMLlJYWkiudsJoPUnIMYb0M/H0YOqA4cEPSej2OrGfdS6chvgpGNPTrjQrBYAayX7BwsLBzdC5pw6wLKq1oH7drZGHpBJOBwQNFF601LLrXXhm4GhWilDa6Fp1ino/yhsq80gmyUAM08eP5v5kopoRjUsn783w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h23yQvZJAhzkxqeaHPYNATuPPuLlQK0hf2kUa/0gkBY=;
 b=bCOpJ0dW3w7cRvIM48Xqe05Z2bEE5pWYFQOxyI+J/cOqJRxdX0JEIoZKj13mIQkEDyjN7wI6dVfk6TBtO1x/v7fUp299wC1QHdtTMP5jyUQ/vS/CEFIfRevZQVJ8wfF3cCjSVjcbLazmRR1zE9PObvuP+p9g6RjfiY31OXtpbW1TenZvk40QP4X+nsGxfXlbCFlGfBaz65n3dC7kro7esI6el1coH27ca0dGuS+Kl5nTys1rChZgHRYGt9UF4aDrUihCmuw4B1WSvpvQCTbqxb5Vnhb/ZYDg43LapRTKn9TlbSXh61AS8sHragucFckTbqHU6NRLyAQBFE/V8VMfgA==
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 08:36:45 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::5b) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 08:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:36:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:36:26 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:36:25 -0700
Date: Fri, 11 Sep 2026 10:36:23 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v6 2/5] net/mlx5: remove redundant MAC address index checks
Message-ID: <2nrdgvh6ew5txpfuis3ci72az6wsccjk2hh2rcrootcwxczc77@7ultpeczpbdh>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908092743.3439825-2-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2f3069-ed18-4b67-fdfe-08df0fdfcfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M2PmItN7lg9bv5cP6+toTVdUSfDRUwSI7s4deKAR/o0pHDhyoTKe9VwlCJsXdh57JhmX5FYAkDnkZa4dw/fTUViDgHmBwscZf+1KCwh6nlbNZUWvj/TuzBL3PlSDKJGsYcQXDp3Jo/xB8jYWiehaBMW4cKLEC/S2h4p2XYMuEXVqkQ00Gz3Ew7qbYkJreSFKkkVPy9HknoTwqzc8tZXVbDMO3K2V0VWqHcxIhwq7j3UuuKyWcSXpDN1lf8vD1/62gKc2/aqDSCpaCvXGwlnvjvODfE/gCx7CapgiSqb8fCEujS+H00Ijsv1fE95IQ+LSNFUMO3/BOHZmDRnoVfNIAvSa/HqKVmTibIjpRUWYxQTAch/vF9LayP1yguHqaklHvjAiPredPTbNh8velj0/EPBV3vYw0Ln3y2xh4Kx5JNI8cIlEYpPk5dcbn26W/1x9pehyq3bqEesBP4TWgWKGb3MloGgrd3FhJ9ImIkqvdAy4dNuw5rh1+lDSf5BcZjnoiKIFjB3NYlwhqt2dwQpgDxBYoIC4AMUSDo4QlUlZr/hBkzRJdVqXh+CNvWaTTlkwsrm9vlGYdvdVT4FusVs4e8F3ANp/AtpjA5JczRglNsuDUvL64YyxSrPuvG7e2U3J+b44+DS68JwG/NiZ+rpRIwzG7o5T9Ou+NnCxZVzl5vzd/aXlzh8fthAAts/0yyYP77xYUm6arqgdow3ZBsrgwg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a/9ny01b8ooj2ZwrOFDQqE/H4OxLTk+ADHJADuo4zOgfWty8ZCvpg7f0fjphrNybaMAIpfb1QUrAXMiXChEhz0t6lcsLXicbNGY0IVj3OlD7d+yz+mgSsctH69HVmnGX9bcENV7oOvQUhpPJ8+Y06TXueNHfSgGHUfdESbAeWc4v1s4Hnk1T34jL1QYMo9ol0JusNcCwvLJzkN0004xRCm3f1VbBKudX01jltB54B3twn510RZzSpSOIAWkBrEYdr5BR6kpg38qIKMm+FxnWlfyENLFjX4D3T0y8iXTeJIRtVTtATv2100QbmxinmDLZd1/yWiLrLvrSO3seEYWCN9WaMCb9FLjkQFN3SxT2zB0IkZ+861A8fm1QSi0VUCJY9SbcpiRX0WI6a1AenPQ99NX78X/unfet8BiiNGu19SBRanDG5eXPY/+3/e4hsKmp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:36:44.7332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f3069-ed18-4b67-fdfe-08df0fdfcfd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
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

On Tue, Sep 08, 2026 at 11:27:40AM +0200, David Marchand wrote:
> On the net/mlx5 side, mlx5_mac.c validates that any MAC address and its
> index is valid before calling the OS specific helpers.
> So those OS helpers do not have to validate again the index.
> 
> Cascading this consideration, validating the MAC index against
> MLX5_MAX_MAC_ADDRESSES in common code is also redundant.
> The common code only deals with netlink, remove any index concern.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
