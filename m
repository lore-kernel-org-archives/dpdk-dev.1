Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE1BC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9066E402EA;
	Wed, 16 Jul 2025 12:56:27 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1A84F4013F;
 Wed, 16 Jul 2025 12:56:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3paTm0lX6r7Ir32fu88L9MReoWhR+k7AmJz6c3B0ArCdpovIT2BWkPIs3W0M46Eb1WRaz3RRTIareIJaARCSAN5nkHWnx7Es7RBzeGMl6t7R0da/vKZbJaZsLSXGkQ2D7ImHh/9VnwW1sF0VwA2WQwdRrDn9qzl0vmgGqmIaVeGEaKtbOzZB0YnbbmWRrnxhDeMI8hFJHDyDqBfl+xEDLDVTXh9VQI8n3kpMS+heFKIJoOklTiWq+hde9pnVjuNFSQUgcsjeqXiipamvTf6+njs39dR0pac1J4NVEcJ45851gcjgnzqlp3KxbZYTJl09SnXZ/1JO2aT89YJCXDfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIuSbBEA3EUwHJZURXgc6QVVFsyCbiHD5v/3TGuzl6s=;
 b=vDqH3OFxQRZYVqXFaQNLhAvnnW43MQ9MxKtkZgtyUE9tnXESZl2M0rl29rOxQSmlPzNebgvuFUoOuweZ3iNXnjBI0rX/2njSTSNhLExgqtG+G8zr7Xq1FWcBp60fkIvcDtSg0k1ox7fTyw8tRzdVrEPJHg7VKPAa+k1o3dDRfjBXaTTKZ5kM3RQ0Ft0z6TSZ1rzMvIZkQXbssELSxUtX9A3ZVuugpfT2gNvihsFnayLTHlz8Snw7LziaBPeu+HMgrLaVu54qjx4eyVGjtNiKHaNDS1wfL053BxgmZInBSVKvKccoPsAECwQp1OiPGH6s5K6nC1jibglxVEjXGS9NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIuSbBEA3EUwHJZURXgc6QVVFsyCbiHD5v/3TGuzl6s=;
 b=oUPADhBr5JrwW0D7Yi7C/jUGvpNztIK00g6C4Y5B8WMTiHk9fp6b4Opjx67wEf23WHK00KDsjyZjTjRqu+fUeCBYK84SdW3E7vHuyLUFgWNGB1JEIpvmEwgv/xzkKmQllXXKBlPezAU+yLZDdSAFSbFpC5FEP3Bi3kV50sqlf4K9zwK34XIC/dZVs4PB7tgI/AvB0+7724bJ8cWrqgQKlj6kxLqMRhnzAKB8s0ODo0oi+3ItkHdqOjCjrxtyEsgM8yzkXZKSmo2TQUs/9zMaVd0kxqsJ5FlVJOIm83CCNeylcLZqWOjK95whUcJRAexPZ3xKZ+HxF9lYgL9QkG9Jeg==
Received: from MW4PR04CA0266.namprd04.prod.outlook.com (2603:10b6:303:88::31)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 10:56:22 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::fe) by MW4PR04CA0266.outlook.office365.com
 (2603:10b6:303:88::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 10:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 10:56:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 03:55:58 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 03:55:58 -0700
Date: Wed, 16 Jul 2025 12:55:55 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>,
 <viacheslavo@nvidia.com>, <orika@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Message-ID: <20250716105555.chrm654eqw4yrgw6@ds-vm-debian.local>
References: <20250715175102.ovlhlrhyjzcokexs@ds-vm-debian.local>
 <20250716072410.3534146-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716072410.3534146-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 157ada78-8da9-4e58-d66c-08ddc45766b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnBQVjlKdVJZQThpWlR5dTVuWjVoTHpmajRtWGF4blJ3WjY1R1Zpb1FoU2RE?=
 =?utf-8?B?U1FjVFBnaGFFYm1tNEdmTVlwaUxWTHVLdll5UlV1SlVPcFZGdnJnQW5yQ0gv?=
 =?utf-8?B?OFhNVUVaVmMrSkdhTnlaVFl2c1hhNk56WENvc25VSko4R29pbWxEYVV5eFV2?=
 =?utf-8?B?RmE1bUcxVURpSEpERjVnNUxzTUdkbFlyV0ZaZDk0TlNLaDhnTTVRZFlkNVVQ?=
 =?utf-8?B?VWp5K1A3SVhJbXZtL2RJNS9IOUtJZTNZcUg1bjRyM2VCNmpIWGorVDAwQkVj?=
 =?utf-8?B?ZTBOcVhWMTMvM1ZCMjAyNy9wYXFhNEZJSzlNeUFLWnB2MFl3TTVBL3NOTllV?=
 =?utf-8?B?RG1SRGE0eFhEeG5GQUg0VHhaZXhJdkpCMzE0S3UrMDY3bG5taEoySUVnenZt?=
 =?utf-8?B?QXNTMmdPaCtDL3VTUDRlWk5PWEF3ZFp6T29uQUx5ckd5TEpFdlltQmlwNVJT?=
 =?utf-8?B?Nzl4QXgzaG9pendpMDdxdU0reDVHaTlsUWhiVm4wdnhIV3o2RDVxM04yMDFj?=
 =?utf-8?B?MVVYWVBwdXBsUlhwTlhmK0pYREVvVkluWjBnL3Rxdm4zcWVQVkx4YjJwbzRQ?=
 =?utf-8?B?NTkyR3dDTzRTT0xqcGtPblpwZkQ2SHFXM2xlZUphWENhR3M5cTdOUTY4eGtD?=
 =?utf-8?B?em1vYVNYZXYzUXdjWGJJSjRTK2tLdVJxdEI1MW9WSHBFZ0xMVVBIbC9RcnMv?=
 =?utf-8?B?OUQrNDhqS1U1WXFYdGZ0S0VjS0w1T0dodFRGQ09PZUNlT2xyN1ZBazZkRlBy?=
 =?utf-8?B?aHROOEVLcTNObWM4OWFTZDVDLy9IanJoVUpNZlBLME1zOFFKQXRUbTZkUHI0?=
 =?utf-8?B?YUFqR3M5cXJ6Zk5ybXpiTm53QS9NQVFsamVOcGpMYmgxcWw3RDEwWlM5bTZw?=
 =?utf-8?B?UmdZZjdkRFRFQU9WeVI1ZTVZUWdCdmZEQkJuejZjT3FDNUZqR253UnU1SUM5?=
 =?utf-8?B?YVV5K2dKcjBmTWg3Q3dDUlVHNVo5bFZvQ0gxc1haWWx2bTdGZEtrV2hmR0lQ?=
 =?utf-8?B?K2ZzZWk2RDVkaTdzcXU2WG9TeUFRM1lXcmtaempaQUU0MXZ2NmpuN2R0OHlm?=
 =?utf-8?B?cEQrWnc2ckIyT0J4Vkl1bUxBdFVmNWMwb3ByUG9icURlN1NzRHlmRDNiR0xD?=
 =?utf-8?B?TGVHL3RlRitoR00zTGJka1ZhUXNRWXoyUEpBTWxmVS9PajdOQzM5bW1GL0t2?=
 =?utf-8?B?TnBLZ1c5UUxjUzVmUTdwTkNHTWpEeUZlOW5rWGpzVGNkbjZtTGkzV0xzYkhi?=
 =?utf-8?B?VlN5ZWJYbWRUdmV4RnJwaWc3dkxJU05EVGRJZVJNV3R6MG81Z2pIajhLVlp0?=
 =?utf-8?B?R1B3TlRpaUhRTkJESDlEVGxkZDYyRDlsNXVFQTFxZ2JGV1BldFlsY1FWU0JU?=
 =?utf-8?B?SmJlZ3dxSlNXeU9jVDVsb1FiaHNreHJrUGtCdEtFdW8xaWo5QTV6Um9MbmRX?=
 =?utf-8?B?Z3ZsOHRzOHNMR1dwQ09GUUxUYkFRSkZDcGtLNmF5eDZ3bGR6UU5CeHBvaW90?=
 =?utf-8?B?QlVWZExmNlB2Q2k4RmJ2d051SUlSdk96bGFmb0JvZU1TV2wxWkJraU1HVGdD?=
 =?utf-8?B?TkRwUmZPajB0NHpiTkEzb29BSU5MTFVVeHordGhxK3lEazhuM2Z0ckc1U3JP?=
 =?utf-8?B?MW5CMzhVdkIwNnFwM2UvQUVzWHA0QkZCUE5QQUZzTTFTcGpTbFROcFJWNjZQ?=
 =?utf-8?B?SURiV2c3SkQxQkpBVGJlcy9UajVudkNBQ0V3M1ArV1creldmM0NQeWJDTVo4?=
 =?utf-8?B?bVk4TWJRUHJQK1gwVHR0a044UDIrUXk3c1NLODI1aC9rc3JGQy9XMW1JRk16?=
 =?utf-8?B?c3dGL2Vxalg3RTNYZStsaDVZSGFzSmk4U1ViR2xOM1FHZ25va2djbDQ3OUVm?=
 =?utf-8?B?bmcrSmwyYytoYjVmUjd6QlFsUnRmSE5MUUkwNWk5UFE2NVNhb2I0K0Z1YnpL?=
 =?utf-8?B?emwwS2RXQjROcUtUUzRMd0Y3N2JZNTltRWpnVHFNNThDUHJOUFp3N2dyZXlS?=
 =?utf-8?B?Y0ZQMVFoVDdpclBDMWV1TW4zV3I1dUpSTjFrTERjNlFkTHFLNzVKRWdWOU80?=
 =?utf-8?B?YWVqelZGWFVscXNkTm5oMi84aUxwV2RJcGV5dz09?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:56:21.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157ada78-8da9-4e58-d66c-08ddc45766b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

On Wed, Jul 16, 2025 at 03:23:19AM -0400, Khadem Ullah wrote:
> Hi Dariusz,
> 
> Yes, you are right — I believe this has been fixed since DPDK v24.11 by the commit you mentioned:
> https://github.com/DPDK/dpdk/commit/c30b356a4d48542fe99c47aa470afc8cd1ced9f5
> 
> Previously, this appeared to be an edge case where a segfault was triggered when a transfer rule was created (even when not using switchdev). But as confirmed, recent versions (v24.11.2 and newer) now correctly return ENOTSUP or a validation error instead of crashing.
> 
> I understand that transfer rules are only valid in switchdev mode, and that using them outside that context is unsupported. I encountered the segfault when testing this specific combination, but it seems the issue has been properly addressed now in the latest versions.
> 
> Thanks for confirming!
> 
> Best regards,
> Khadem Ullah

No problem, happy to help.

Best regards,
Dariusz Sosnowski
