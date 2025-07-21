Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB09C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2E9240662;
	Mon, 21 Jul 2025 15:21:45 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by mails.dpdk.org (Postfix) with ESMTP id 07E064014F;
 Mon, 21 Jul 2025 15:21:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg/4nfT3A07e0t6/f4ss/3Fc0GBIhpvplW/jGQSJfiWQ0g4WhgV5RwU6GYYbhy9FK+NjMdSmYFR7w71bjcnA5GT6+sae0M8Py21JqKaqLFkIzLk2cSh5ahXSsaIE+Z7tL2aeaRtLiEh31WOTBzybgIyJHJW48wjehoG3DziKpESfDbLu4OliEFVOwxj8ASzy5qGX2AyRw949PAknOVUjYNz+MvK44H5YCRultNj9114l/rWWrG+vFsXIlSX9hmPBMOzhedEZxe+qxoDEiNldEqF5gcjVqvT9Ww4v5bSK4zoFsBNmpD90AFSGccUc9NXMri194VIl/Ty3OHWiqHysog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0pzaC/0b3EARQev3vSMZ0vItpWNkI0yy6emSUX251w=;
 b=zN96jk9kJF8CHXx2XGQnebZfcUaZ7THnWXn/plC2rL4ryUT5X+a6i6rHN+erNieNjLaA5Q77HoZtbpa5EVJvyGXynHK58tjVMK6ZEXerrEy0EFlnh/NUWz7LbceYmqgu7oQrEDSX88q4XRi/lz9duHkly7xpCYUfjtStFhrOa/Jt3Jx7spkUQqrZWpFILzy8wkhvMgLQM1+l0FBXF7uzrFQvk3EQAPDI3bkAvsNeuI8hO5xuvwN+AGoqKjD8H2B002njyX4E8C9fQwkAugvCBbdRpAxIpSI48oAsLJcPvG08I8FZvsOOf+GZVn/3I/btgH53kJlqvhrHOXU4QX238A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0pzaC/0b3EARQev3vSMZ0vItpWNkI0yy6emSUX251w=;
 b=WXeYz4bft5VnsNKokSQTi1yTl32A+5ogiaqfkRC8n/nqioFe5fueRsL7C3P5HMv/Wbin5KQ+WgelRBjKpFro6hnSltl+GkvaMfOcimrT9sOnG8z6QOwL65PPFSrBdFA9LpgujOPaiHmdadSbRCxM+5QAP1PuU+8lOks4+0X1NlTH30S2vQ9y0rP1yym5tTQDoTdrDK2jfx4dxnUuRZbC+5WBmvKYPxOoUuKGOtlND7MHLyDQbXEgBJ7jDOniNWDV2c23Czy+EQACcXo9OijsgGpt2jcyeRiWxHoNt0RBxUMKO1Mf7SjD4XhP9VeyJsrBEiwzblCN/ljbtAONZxIxAQ==
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:21:42 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::85) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Mon,
 21 Jul 2025 13:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 13:21:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 06:21:23 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Jul
 2025 06:21:23 -0700
Date: Mon, 21 Jul 2025 15:21:20 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>,
 <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <orika@nvidia.com>,
 <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH] doc/mlx5: document firmware requirement for flex item
Message-ID: <20250721132120.x5knqldvshgfwjl6@ds-vm-debian.local>
References: <20250715125249.hwrzd4aasfjhhyxa@ds-vm-debian.local>
 <20250716075013.3539970-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716075013.3539970-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 27822cca-7775-47cb-8812-08ddc859864d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sn+1Iz5WIdK6y9HnJqj0POqCOMH9wqWpKakr1yi5IpHJpbiJHGz4werQT8aN?=
 =?us-ascii?Q?FRjn3j6+Nat+6nAwPFqnIurN9GwPyYwpOgdK39tVLBFSnIjXJlrHLjYzu3UO?=
 =?us-ascii?Q?B8Now5NJ4AzuB+At0QceYYjSx89rqtFDKhzRW3ABPGU8tuKn7BGN5pxsfaTK?=
 =?us-ascii?Q?rfTMBo7mRbN6P0gsQjwBSIlcCs7VHiieRrqWDAL/UbASTMFlJzFUSggItM+o?=
 =?us-ascii?Q?MrGtfwqrF27Fve3wLhLeg8ia/oTRa/DvXI47u+qlkBls/y1Y1ENQZPEroAMU?=
 =?us-ascii?Q?dbAGP1vmz5Rzr3llIPD38zCFc4QGjsViUxSynayJ3I1HATbSN3SepxAXBu2o?=
 =?us-ascii?Q?J74z2+HC65NayJhW8m+yn9FhlxLfBrRm2gN+bkTRsSM5e9MPzM3+fjcn+OUz?=
 =?us-ascii?Q?pxR832JZdiUD+79lQGfkUmPaUblyAm03ensqFV/mQ/3XQ6MB5R/cN8mx0Ez5?=
 =?us-ascii?Q?uqCZOxWT6UEGs0K+Gv2Ml7u30pDOp476UL0IT/bp5sJ5uJbkNnX2ZSc9+wyS?=
 =?us-ascii?Q?19ruuA1+6NaMPPHGrn6JlJZYnUmTqyaqV1IhpPPCP8LOmirLXmTna2OuCz3h?=
 =?us-ascii?Q?4U+Dr/xXWe5gjET55JvAFZzR8sElu3++iP/aieMe3SMKW+zNKWO/mJHX4EAE?=
 =?us-ascii?Q?mAaSbyWr8BpFC7HqJX1vb67jZquc8q/TxHZVwHEerC+LDUjlnnY4HN3UgkIc?=
 =?us-ascii?Q?eox8Jo5gobi/VRiFWIV0CDBsKjoSV7XRmdh47BkLqTYfL9Agtqeqrf9NzjzM?=
 =?us-ascii?Q?Iic7haMfjmhA85mCq5VtDndnUk0YBwmRqVDenAI+sx9eVnhf/20qV0+GdePz?=
 =?us-ascii?Q?41PpvrjI5c+ywGeFy7d3VzlyqO8WTJCL4A60+PxtVO9+BOuXa+Fx+oCXqXKu?=
 =?us-ascii?Q?/Nngy1fyGc8lkVA9d1+R+u/xTXvBqtKjPml6YY2rzAfj/qu0cFoHqTk2ISQB?=
 =?us-ascii?Q?ich9nLz2zkRos3YOITjuCwKueTS5ijSPS6053d5DQdS8hEfiaLX9D3eHyZmy?=
 =?us-ascii?Q?QTfRYsavCsKvz3/8ttiBcqmLQgO0gyoSP8LVcauDPmbLmiYVmMWoQu1A3+j3?=
 =?us-ascii?Q?ydMnMsG51tVe113cSPVesDpJqdQ+MDba2MPDOXXck/cj/DxTdkerfUZ1e+GW?=
 =?us-ascii?Q?8Ysd8frRGgKFqTkD3isXSq9c8+cxMI5lkoo7TVtdWVihB9LDDqAOw/dzAwcC?=
 =?us-ascii?Q?RgfR4Pecl5PJeiUBrnwruSd4UChI5H+IKHvstcnahtlow23IIVSxmAnL0qDV?=
 =?us-ascii?Q?VIjwfScfjHwtYaTcxFcktm1sULnpVvqlhimQxAV32j2OoH+4drNUontzrrWq?=
 =?us-ascii?Q?Qn3+aD46ekCMUnE+GKA3p5EM1Rafs9ojU2Kz840T+PPqOSd9J3XrwyuwCzoW?=
 =?us-ascii?Q?GqIhSKes7PRVpyItg5AvyyxzvPSQ1en0SIU7wKBQdeVXlZqU22+cov26T9/n?=
 =?us-ascii?Q?dQ+GdeHmjLldxlcS5fZHZ3F+AseMJwr/go9sjCQSHYFkfcopZxPM4mUb5Ntl?=
 =?us-ascii?Q?fYlt3NpHwsULHjwzLKSi7g70+8vZVLy8aZP9?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:21:38.5914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27822cca-7775-47cb-8812-08ddc859864d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

On Wed, Jul 16, 2025 at 03:49:40AM -0400, Khadem Ullah wrote:
> Hi Dariusz,
> 
> Thanks for the follow-up.
> 
> I was using DPDK v23.11 with the following flex item configuration:
> 
> {
>   "next_header": { "field_mode": "FIELD_MODE_FIXED", "field_size": 0, "field_base": 0 },
>   "next_protocol": { "field_mode": "FIELD_MODE_FIXED", "field_size": 8, "field_base": 72 },
>   "sample_data": [
>     { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 0 },
>     { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 32 },
>     { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 64 },
>     { "field_mode": "FIELD_MODE_FIXED", "field_size": 32, "field_base": 96 }
>   ],
>   "input_link": [
>     { "item": "eth type is 0x08802" }
>   ],
>   "output_link": [
>     { "item": "udp", "next": 17 },
>     { "item": "tcp", "next": 6 }
>   ]
> }
> 
> With firmware version 24.30.1004 (MT_0000000704), the following error was produced:
> 
>   port-0: flex item #3 creation failed: unsupported header length field mode (FIXED)

Thank you for providing the flex item configuration.

Could you share what exactly are you trying to achieve with this
flex item configuration?

We investigated locally and yes, FW version 24.30.1004 does not fully support flex item yet.
The error log misreports the actual root cause of the error,
because of a bug in PMD. We'll provide a separate fix for that.

The proposed documentation change would also be inaccurate, because different
flex item capabilities were added in different FW versions.
We will update the documentation with more details regarding that
in the same fix.
The earliest version where this specific flex item configuration works
should be 24.37.1300. However I would advise to use
at least FW version 24.39.xxxx versions (this is the oldest relevant LTS FW).

> 
> After upgrading to firmware version 24.38.1002, the same configuration succeeded.
> 
> Example flow after upgrade:
> 
>   testpmd> flow flex_item pattern 2 spec 45000000000000000000000001020304 mask FF0000000000000000000000FFFFFFFF
>   created pattern #2
> 
>   testpmd> flow create 0 ingress pattern eth / ipv4 / udp / flex item is 3 pattern is 2 / end actions mark id 1 / queue index 0 / end
>   Flow rule #0 created
> 
> It appears this issue was resolved at the firmware level.
> 
> Best regards,  
> Khadem Ullah
> 
