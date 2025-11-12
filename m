Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F4ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 10:13:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C637D40608;
	Wed, 12 Nov 2025 11:13:16 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by mails.dpdk.org (Postfix) with ESMTP id 5812C402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 11:13:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tyz1Y8c6FsEVE44DolNHvAR3hCRnh6Ur1yGkIUxemigSZZWqR+d3vbK2lxV1p6HB1k1HRT2UaIGIHxfdplDSyrHkU/RLAEQjyzxHwsseuJSbu26QEeO+KZqTTza5dlu9mBrlGEzCDigljf6+uniLFzNioIhLvnHLahIVakLLaXxrvRhYlFlX+6GNP6NkYUv9ljENabWFsCE4WmO+ZggRuO9nj27GSQwxG318dQRavaJNSs8XsqPqUyDOGEtX6l6k98OunZXHmvroo3Zgqx76G6+S4WUc7CpJ6f9XhP+tnZXl1vYEMsbbb8rSH5u9Jrze9RA8CdmyT/C3XBssIs4djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOhyFPsXBU/OdQaVbs/XIzeI4SuXC5DgqkCz7eZX5wo=;
 b=Hp8iYgGSVvEen28o6SnXvoeNyRzlhdC8qz1NcfMShVTRz2HY2CST+I69Jq0N/Zq/vgEymZsd3WxsCYCE/j96kISwDRMZKyE2NqdXcXV7ZhHk5fOVEsFxHb/OYLhINZBEy/Xu0WCRltbPug0/7DOneitgI+c3bChG+OVVh2zH8UiPlwLZ2mh6ftov6jKye6eil0Lh9BesokjcKzUDAftvNt1TbVEbJSXZ5uLyTWPW12DUpVR/NlwGE3tr27Y+gH4a/YkJQtMqxfnKycN3AgrUKaRxTXUwU35MdCZ9V+X6P/EKGqRDRsHP9+6WBrsRanYHRFxDIEEl48QdvPR+b6V90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOhyFPsXBU/OdQaVbs/XIzeI4SuXC5DgqkCz7eZX5wo=;
 b=BvIps0+kv5I1Zuhy5TMCevwE1aLZkkkopTc4daUnU3IGwHjPE5Ba6MRg+zu7/bF/QkB9oHJIPXUVFUa9V2vXI4PChbC778t3X1fEGiu38BPD5qkwReepW72lgtgzlAE8NXSHcdDO0fg6FmYlEuXX/i0y4BDRknfaTOBwstF4Wcjp69hI39DetRyv1oIBjAPCS6Yc4YVeUWo5B+7Ju/73n3nW3eYarDYUndvi3ozcpDewyeybsFsMIwmyyUwTorJdBh7B0c1Gut0xFyu3bE3g77qud7FnI1AmLazJHTGrRGOFr1Xii54KZ9vm1aCa73MtQxDXMVAkTTArWsWwVz/h/A==
Received: from BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 10:13:11 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d0) by BL1P222CA0030.outlook.office365.com
 (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 10:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:13:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:12:59 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:12:59 -0800
Date: Wed, 12 Nov 2025 11:12:55 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v4 2/2] net/mlx5: support PF representor suppression in
 multi-port E-Switch
Message-ID: <20251112101255.i2475aeecar5likn@ds-vm-debian.local>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
 <20251106055246.360824-2-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106055246.360824-2-getelson@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb6b2cc-523e-4649-9d62-08de21d4156b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nqNkr1sXkiDcZFLUKZfNPIpqQTBEol+nFNCpcIVqFZ0DYze8xOsD53tZKU2R?=
 =?us-ascii?Q?W8fygiQjHJEOwVjpVpg5g1dZw4Oe4buWD/a1lDG5PmDPHBQO5iO3r/nTnYp/?=
 =?us-ascii?Q?cRkA3FmvYLMOrjLclXG76Sy59LqMoS4uG/sIAdyram76VLkX8GfKr0BjI+4v?=
 =?us-ascii?Q?jX7ZoqQce+UUD+eZjJdlnG4k1UanPbbuB6eTeMR9liJ/A+PB7rVheBtRpVN/?=
 =?us-ascii?Q?ruTCpORm/ZN6HbUE4C5Vs/MPCr0B1lls72hT9S+86QfG0UepjWPRU7JA5Gml?=
 =?us-ascii?Q?THyve4sb5qFo5bwaiSfH9e56/YMNcDxuwI356odYFdIy68sppc8v1s02Pcj5?=
 =?us-ascii?Q?dfMoIKxy0/eawezegnzUrj2cJe1GcTGH3lfu7/o9hHFUagk8zfiqws0ouoPe?=
 =?us-ascii?Q?JsQ2+VSo9bGo/bupk7mRywegkIFn36oFrL2u8K6UiMRoJJb6ksTayDdJ4OIU?=
 =?us-ascii?Q?enWBtPC1qLo+UhEerHEqzXzTfM+LgZs9g8ref/i0MZZ76j9QOUqFYOxuCgiu?=
 =?us-ascii?Q?1hImPU2i7lvxsfG/+tUlgLN0oEI2neCWbReZRbU+9AFOck4vamkxQPxufxgY?=
 =?us-ascii?Q?8svljE6Lza1EGPXR2HR0UlSzmXKxBHlZtyvjXDnoRpBFPQwnJOmA/BLLi8zV?=
 =?us-ascii?Q?TyUpH2mKjNOm4fb3omWFcxSTxgnOR+JbmOe7hhBUEu8Fyb0CuiCX7vrgP5MB?=
 =?us-ascii?Q?cGkPUtGkOqgACa3Z0U2JqPcT75iAlpymX9Av+0Wjdl0Qs4vycPKWucfk3Wqz?=
 =?us-ascii?Q?Bypu8ZIbVeMeh5uVkmbvnrazOw9AwDzobjSsIlwUrQyJL87M1I5EhNuHaG4r?=
 =?us-ascii?Q?cpntuhrmzZLBaeUfTKqJfFKajstcKo3yMCv0/hHvPjDPpuuHgU+aHvc1J3re?=
 =?us-ascii?Q?FqCzq6akncRuQrV4nZh0bub0nXFl/LklRzGm4ipGUn+n4WNla94LNuo4z5dP?=
 =?us-ascii?Q?GpE80LT96GP0kRnF6KWtOvYP/BJ1bL3qwMFH48UJuCvyDvVupP5YtwqpX5Fe?=
 =?us-ascii?Q?Dp+MAQld/2wMUr+hePMp6aPaQQg1s3DjYK/6qpnoVHo4ZHxyE19nm/RhAD49?=
 =?us-ascii?Q?0dNzFVBMDhf4pRBs9lRGLfzGnK1+2eJC2Khs7U80qJnOyY6jZFK448eVlh6G?=
 =?us-ascii?Q?29IPxq/r4bCQfDymAKeZ5EDv/QQKbgX2n4Egz7D+How+/dLIIz1yY9FN/f00?=
 =?us-ascii?Q?BpxIRHPbvl4pJizQ5bc6ZayPwPu07r5AyqXHx1Lwoni9OixAzGoKRuJ2GkMg?=
 =?us-ascii?Q?R1gYdiih2uFeiK7cxbJxcJvTbPnmpRV6/GkkVLfPKkDOKgNmGG15PPq2WW5n?=
 =?us-ascii?Q?g/gnnI/LeH5YC5RQ+WzW96Vas/Vcwgrut1T4kVOUoDhrEGcEiBU253vzi9Q+?=
 =?us-ascii?Q?C8ravDA16FAo4VCuFeBMopoUK4cpnDjnGWJDFYtdpZ+NM3whFwWoIkvJMjOM?=
 =?us-ascii?Q?2VnUKAzEk4VUZxmQULcN4J30e/fA2FJf9q7YIkDhN1WZzzAi0C7bfniQOKrn?=
 =?us-ascii?Q?irJylwCURMNFzyPG64TSf/MPfTNhHlwnOrfZECLEdZlICeE/4j9tV+QNH0RL?=
 =?us-ascii?Q?2fJnrcqiXZUCEUQDrkQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:13:10.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6b2cc-523e-4649-9d62-08de21d4156b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9
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

On Thu, Nov 06, 2025 at 07:52:45AM +0200, Gregory Etelson wrote:
> In multi-port E-Switch setup, the MLX5 PMD always added
> PF representor port.
> For example, `representor=pf1vf[0,1]` implicitly added PF1 representor
> port:
> 
> ```
> Port     Name
> 0        p0
> 1        p1
> 2        representor_c0pf1vf0
> 3        representor_c0pf1vf1
> ```
> 
> The patch adds support for the new representor format that suppresses
> PF representor attachment:
> 
> Example: `representor=(pf1)vf[0,1]`
> 
> ```
> Port     Name
> 0        p0
> 1        representor_c0pf1vf0
> 2        representor_c0pf1vf1
> ```
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Ackedy-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
