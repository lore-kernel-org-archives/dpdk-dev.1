Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E0BC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 17:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDCEC402E2;
	Tue, 15 Jul 2025 19:40:14 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by mails.dpdk.org (Postfix) with ESMTP id 6F3654028C;
 Tue, 15 Jul 2025 19:40:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNkKn/oHwBSzhCsni0zfS/da37UERSNjuQVTNSMvprQEv/XerdoYt0+aNsoZiQ4m2nG48xFcc+PcXV3RYk6K0a2AsV/xHSOzKsI4xoGUz3m17jTY1spZ+L5OnSG49KssoMFCNxBNQMK9zXzrp/91RCBG3ujIvq4Xcl4CSVAPJqaf7BgQv5oF8GxtWLZZ8vh8q0t2+q+b65GCnFTCuNslJAENZibvkWSG6VkPmZli1bCqijWg0DaEWDf+kTBTXVcduftMjWiNhR8mHl+sTO8XEOZ/5dOEziWQVtI1Hyi4ZcjO/F4LlbgXnQjdghHyfiPRHoCY/oyTYyZO+Q0kqLMZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCNBT4wg4QPrqIQq3cIkoMGUz/y2wR7VHl3xtKnhpP0=;
 b=bts0hpmElr4P5HC5KFPdzc3VA0qOJIKNtzD3oE59wSbRj8BdxLmzBsy/7eYLwIewmI4UBEEkkc23lzHKZWucRco1dJeKY/GDrNKF164ge3IOv+rW1oAcR3KTOJT4e8WM79atSkF0pUVTT2baETb7l6fPCvItwn3gn/FRdm9Y2UwP2Imx6Nxdv3jX2Ijon/vYTHdzd2F/gavV14p5mCZhvExHbr6W0M9s5f6cg5iOSBm3YCNwGeC9PX6dX+AQLksVAk09pS9Gm8fFkzHRVZfaq+zFijPs/FNkjOe9743PwmFi9XotpVjj6D2EEgKsumZ/t+9+TrsP3sVdO+wcknEfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCNBT4wg4QPrqIQq3cIkoMGUz/y2wR7VHl3xtKnhpP0=;
 b=oFdT18qjMXES05DPXo0QoLr64HYN10yFzTOHXLuA52BBhiyo0symUE6rU6sJVUkOPcebJ+X/aeGQobJn0VvNBIMJ+R7fZ2UvG7BlFP+FRu4CxURlZFXIpSEqivRGiGXU/YYnMpe6VarWkg5vWmnxmY+T10/574kTU2rO/rZqEmWR6+wTZrPKxfUv7pg+lOSyKcwejtdBaxSfTDKjeYBbn+isfe+es/+nntRAeAAJlj6J5TQM5wUr3ikdvepXjBPF5xqQzh6/dCcyuB7tBrMLlMe1WdQ+ughoP98izzs4/IEL7Ry2ox2HaQ2VeeKGIhkeTV97d1D6w4PvrNS/sPk3Gw==
Received: from DM6PR02CA0162.namprd02.prod.outlook.com (2603:10b6:5:332::29)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 17:40:11 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:332:cafe::e0) by DM6PR02CA0162.outlook.office365.com
 (2603:10b6:5:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 17:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 17:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:39:57 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:39:56 -0700
Date: Tue, 15 Jul 2025 19:39:53 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Message-ID: <20250715173953.22wmyand7eltmevp@ds-vm-debian.local>
References: <20250702123617.1814996-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250702123617.1814996-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c0583a-3f8e-4844-f7e3-08ddc3c6a569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLQh53dcSP2NxYR5HMVGTzVanqmJwQMoOdTCd3PDt1jYdulxx5luXkQU5cPl?=
 =?us-ascii?Q?pk+PyS0PafKvTsywMkxyAbnY9Mv0+hijL/9iTBhiQhtucAA/Y1tOawf5mlSD?=
 =?us-ascii?Q?vNiArNMzEUOVjOeia16KK/WMXbntIyitnaKRuRKUcvz6isyOSyTcEcx7+ql+?=
 =?us-ascii?Q?H/cQtpMADK2ziQR3AjvxeTS6OmxQsPdKVUpWtZOv/HxQkjPFGIKelyq5I4XD?=
 =?us-ascii?Q?rSYTLg4VTrlNoE4sYL62f+EAsFI5wivBdafHUw6lQW6/vy1vitmPjsSOycmE?=
 =?us-ascii?Q?wf04yUtxIdX8LUrzsoAPTdu59b8Yr+7ITHSCK0XXG8LBVmpIq0MX8w/0RNw0?=
 =?us-ascii?Q?Q0XSRMe8eUe4gHgqozY4dv5tFjaOAmZaF5AmWYs1eNWHRAYpzYxn+Zrxfbk0?=
 =?us-ascii?Q?XB5V6j8IE0QWFOcfFDEFmAW9DTbv4pnttpOJChR0LPQE+2I5lms+Gv62hSG/?=
 =?us-ascii?Q?nNnJYk/NMbxGWq20NUDA1t77Nx4AOf5Cst2M+i15s6e33T/ZRdsjzkprVY4U?=
 =?us-ascii?Q?bejSgMUOqx1GfjHkUlaLm5nYVQi20lnX+E49+zWs8wceeElhbi9hCWsOzJJ4?=
 =?us-ascii?Q?SIzQS5bscdRPpVTNqviyoMkkAhDUyahh8uA8p9fPGx4vqwrcd9Us7IF1gihJ?=
 =?us-ascii?Q?Ed4T6/FOTnd15w/dJ9DXYJyXtMx4x1kReLJTPfrblLDZ7iKwCCPV+oOfdLTI?=
 =?us-ascii?Q?fgUSJy0vM07LcLEhPy+BedGFSdm/QnoZeV0Cpcl0pSkgdQP6WmZNiddr55nc?=
 =?us-ascii?Q?OmQ+MF/zsCdWUIM/e1szsh/YDUU29Q34ZrMH2OnKVyWFgfra+l/qiNGtFJ9y?=
 =?us-ascii?Q?HcOq86QE+LYygq5RC1ShlFXlLG4qVp307BXWlK2CcvT4i0CkB7V5HZnCG/mA?=
 =?us-ascii?Q?w3+FWrK3Jz2i8qFfaHEVZ2RI8/vLHHnfVeKTndhu0FVWbpJ659ahK89Ay6aq?=
 =?us-ascii?Q?hiOlHl2P0x6Bm5MzOgyiYVYDhCaK78Iv0vrVjunYnwMpv+H+R3vzHWzEDu03?=
 =?us-ascii?Q?VYPpa6VMagm6j6+rujd22tKMD/4yh3zU0kXfaDWg1pa+q6VTBu1Pu8xPjDfK?=
 =?us-ascii?Q?LsDzW91T2Zi6NbIvv5R5xMlYvogXmvxZOKQ9X17+dxWebizl+M4IsLNRI5xi?=
 =?us-ascii?Q?s+PhQ3i7ewXJqpjsus/BKqDnZ7VW54o374AgHqDVKb7i1JYLuuiEO0Itx2YW?=
 =?us-ascii?Q?+I9YZkD5EzyasSQIncsm/260GMoDMrnsX4N2hMCt/iJyYVd7/pK+d7kuRidO?=
 =?us-ascii?Q?vWAbYVQBHadCgzZhtzNJWhMngvXk3c9oDg+lUg/diMJp3n4vCaC4lSvHX7RN?=
 =?us-ascii?Q?FcbXMC+skJD2k6pDvoYl8y9Fa78fsD/xMqa/nmaHrzrsIXAiIU4qm/lVFOLg?=
 =?us-ascii?Q?DuyhdpJcgA8iC7VbKhAwdul1keIy3t9jfsMciIr9RIfB9wCvENbGukTxHNLR?=
 =?us-ascii?Q?JM5BZAB6FE7VXAKrPDYky2MNpDmx/l1w+yCz1fxFzOp0DBxdeib43CEIBieV?=
 =?us-ascii?Q?xxf66iyKHWasHAo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:40:10.0196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c0583a-3f8e-4844-f7e3-08ddc3c6a569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

+ mlx5 maintainers

Thank you for the patch.

On Wed, Jul 02, 2025 at 08:36:17AM -0400, Khadem Ullah wrote:
> When creating a flow rule with the transfer attribute and a meter action,
> the driver did not validate this combination and would crash due to
> unsupported handling.
> 
> This patch adds explicit validation rejecting meter action in transfer
> flows with an appropriate error message.
> 
> Fixes: 46a5e6bc6a85 ("net/mlx5: prepare meter flow tables")
> Cc: stable@dpdk.org
> 
> Steps to reproduce:
> 1. Launch testpmd:
>    ./build/app/dpdk-testpmd -l 0,1 -a <PCI BDF> -- -i --rxq=8 --txq=8
> 
> 2. Inside testpmd:
>    add port meter profile trtcm_rfc2698 0 0 5 10 50 100 1
>    add port meter policy 0 0 g_actions mark id 3 / queue index 2 / end /
>       y_actions mark id 7 / queue index 3 / end r_actions drop / end
>    create port meter 0 0 0 0 yes 0xffff 0 y 0
> 3. flow create 0 group 0 ingress pattern eth / ipv4 / end actions
>      jump group 1 / end
> 3. Following causes a segmentation fault:
>    flow create 0 transfer ingress pattern eth / ipv4 /
>       end actions meter mtr_id 0 / end

I tried these steps on v25.07-rc3 and the segfault does not reproduce for me.
rte_flow_create() correctly returns ENOTSUP for that case.

Similar case was segfaulting recently,
but it was fixed by this commit: https://github.com/DPDK/dpdk/commit/c30b356a4d48542fe99c47aa470afc8cd1ced9f5
This specific fix is available from v25.03 and is included in v24.11.2

On other LTSes - v22.11.8 and v23.11.4 - segfault does not reproduce
for me as well. Either ENOTSUP or validation error is reported.

Which DPDK version are you using?

I see that the flow rule is created with transfer attribute.
Are you using a setup with switchdev enabled?
(https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.html)

> 
> This patch ensures proper handling of the meter action with
> transfer rule to prevent this crash.
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  drivers/net/mlx5/mlx5_flow.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
> index 8db372123c..a7b793ef29 100644
> --- a/drivers/net/mlx5/mlx5_flow.c
> +++ b/drivers/net/mlx5/mlx5_flow.c
> @@ -7993,7 +7993,17 @@ mlx5_flow_create(struct rte_eth_dev *dev,
>  	struct rte_flow_attr *new_attr = (void *)(uintptr_t)attr;
>  	uint32_t prio = attr->priority;
>  	uintptr_t flow_idx;
> -
> +	if (attr && attr->transfer) {
> +		const struct rte_flow_action *act;
> +		for (act = actions; act && act->type != RTE_FLOW_ACTION_TYPE_END; ++act) {
> +			if (act->type == RTE_FLOW_ACTION_TYPE_METER) {
> +				rte_flow_error_set(error, ENOTSUP,
> +					RTE_FLOW_ERROR_TYPE_ACTION, act,
> +					"Meter action is not supported in transfer flows");
> +				return NULL;
> +			}
> +		}
> +	}
>  	/*
>  	 * If the device is not started yet, it is not allowed to created a
>  	 * flow from application. PMD default flows and traffic control flows
> -- 
> 2.43.0
> 

Best regards,
Dariusz Sosnowski
