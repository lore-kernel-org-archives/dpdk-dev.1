Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A525C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 17:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47AB3402A9;
	Tue, 15 Jul 2025 19:51:46 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by mails.dpdk.org (Postfix) with ESMTP id 3ECD34028C;
 Tue, 15 Jul 2025 19:51:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxJDSMTGJCVEHamBuoaluGC+eedKgFthZ5WbqRP0ih4+H4Bp/XSAUcBrTAMFnJYmguN5SMOWEqvV3hnn/mi8PhlwMhsTzUfhotMdi2BJHbGk8kCiq4J7zPX3gcAlieGQAaoz0BN2uoXJom/9M2EUANWz2bwRKqANJc4hQqCw7fwNhWGSr7NYpvROXffCDOY0FWgJln9qZnNJGijmOdMiLWChVO0fIFT1eoAvtSE+zsMcolH/QlAFprpvlv6KFXdR1qu0FYjXsye7Wy6mJD7oGRxVCbQ6oBtgbvf3RFHWPzDsTXmX0FCfZrbDX8sLXcI51lYNpOeL9IvGkpwtq28UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZUPfwMlIQnLMcAAUmPs331YF/lqHC1IKL/XwCzrS98=;
 b=Bsmn/+I0gKZ4M1SNvrY8gD9AVaHyVTJj9/MowbgHq+sbbFCBZ21Ls9ElcAEzVYoYhDHUDzoYhmfDE4lH7mYNDhQdFAL6jpmu39nwChe/lb/5nmoRtjyXh2JyK9gfqVfQISFDQ9cEJ6o7cy8ED0Qy6DM3VBXx6dDulGRI/kp2V1+/zTQCsjdHXOnVxRHfRQ4LUHA+uElDW23/leYSnhX/4Hx8OtXwwdjdmXtn/V8kMY3nlFoSvBoyXqD+9BRqXI5OcsI9T/YglSrG0ZDVIs9tN5eBkmSa7zrOYtj2c+jYbcoI2DEhuQ3wUjpRrDIkgDkXT56ij7hYLMByL5kykxGFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZUPfwMlIQnLMcAAUmPs331YF/lqHC1IKL/XwCzrS98=;
 b=RDZwCHzkyQqsriORu2jzs7T+RnTqFffxNN9BMk3+Cj5HdpHDhV9eT1GygpiMIsnPQSByqH4lftEO4FVMlcHCfxr4g0gLcBAAZItsQQAHb5+QU3oDsBtSygAfnQXD1HhbIXuFVXmdA79k3y0AmJIFBRFROCl+6a04pfg98Aqq5WUnz7Y+xNi9Aeb47H0khMdHc2fgqDT8ENZGl8MCOAs8uzkZ7mPFVwTMA4TSQ4AfL7ZToyRSf3bTP6kxMrvgslpW40vWG0Sq8jaitrPFx5dxtg8HyYAQfFa97uuhRTCDIlz4onAZ4cVi64glJxC8hBcYTPBQluoH+8ScPJpL0xa1FQ==
Received: from CY5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:930:1c::24)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 15 Jul
 2025 17:51:40 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::65) by CY5PR10CA0024.outlook.office365.com
 (2603:10b6:930:1c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 17:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:51:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:51:17 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:51:16 -0700
Date: Tue, 15 Jul 2025 19:51:13 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when using meter in transfer flow
Message-ID: <20250715175102.ovlhlrhyjzcokexs@ds-vm-debian.local>
References: <20250702123617.1814996-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250715173953.22wmyand7eltmevp@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715173953.22wmyand7eltmevp@ds-vm-debian.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b4c5a9-c618-487a-99d6-08ddc3c83fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZAb+hfML4EnTYEpDbvsHojvUW64DnCO9B7RnbzGIT546v0qorZj4Hw81mfx/?=
 =?us-ascii?Q?mwK1zVVLkZTGVb0eKObo90QrBQWkpH2pUTX8wGbdsHXh0pE3hk+SiAL0Z4M/?=
 =?us-ascii?Q?hbvO5FBNaS5CyOyyjJCZd2QnF7h6N4hEOCi+umIDOCUMKM9FAKI6xzb/x6Gx?=
 =?us-ascii?Q?E6f1iYg/jazLNAR+YWJ70jXvXTeIK4SBFsGAeJBU3smBf3bWD/UopN4yzlOl?=
 =?us-ascii?Q?TvdeU4r6ZDIDYk2ZT6E6OlJNzYnbA5fmjewG81HKuwFOyi7uFon2Smnfzo/Q?=
 =?us-ascii?Q?q+8wg7XxeKG4MeW7xTjuju+93rNusEvddva1muVXN8oUtZgFrgwj0rvHch+Y?=
 =?us-ascii?Q?BHYo5hlbkWveVX7nlSHCttVtpBMiVHtyBwQW17GQP32Y+aEleQPsJVowpCLT?=
 =?us-ascii?Q?43jivlPcGCcCRzgidKkWth1E4vauz/4WAX77SZieCtXOs1GbI4VhfTF50Cfc?=
 =?us-ascii?Q?mESNmgLI8gpD8oOB7KnV+j2oxD2jU3RMOVp3L2mpHJVpsOSbkObkBjZ7tOIX?=
 =?us-ascii?Q?jyy9wAHWgthCq0ACvLpzCjb6wmKk6t7nX+qQsT+O+aQxT+GtztmLY9xSDgOB?=
 =?us-ascii?Q?R9IiYKrUo8C/RgAeKcrr/So36ec9MVqbTZgZQkntfuhdctp1154FAOjo4swx?=
 =?us-ascii?Q?mMp7THEDlzy0XXyNjwUjCtLySCiJWrenoZ5tBK5h5R9QB1N395jI2pM18KtS?=
 =?us-ascii?Q?aHH9r0feQIAEk+rAEm8CrvcLCbctF6VJn9QdK0nlyF3f2Z3VtApEUxxi+QPN?=
 =?us-ascii?Q?EfvzFT8QURu5KWXHV3BEYA6YB94jTphxa97sADjUF9O9TlfOi79cAZjJi8V0?=
 =?us-ascii?Q?OGKNeBQomxAOpdKFeA8L+1VFVqB1QfnTrGjv51dN1+wEVncYuY/lhCJFfuj4?=
 =?us-ascii?Q?1vtHPNBKCzNtAQqoNjgi+M3bOf/0huA4AN5TsDMAaToNyXobSoQajokqWG5t?=
 =?us-ascii?Q?F0i1fsLGcmLGv44XSrgT+2lpfZ0JyNdglmj4FyFlBdrlNZ2p0qOWH93RvDHk?=
 =?us-ascii?Q?sKbjUe+jc3ea0KctF+ycE6jc9mn82UN1RQO22DvgyNHb+BO9nF96Z5wvvrXx?=
 =?us-ascii?Q?2UeooD9S+tflpfCPiRqnOegMgBnEyu0/+522s1YbZW21m/uyavRm/PIQfino?=
 =?us-ascii?Q?Q78JUItvTJ64Prm0fJ1v4zSrkW+stkDyA3V9swams6jtnEIKQeKrtYUEp8+A?=
 =?us-ascii?Q?AT0srfm8pwq3b75zubvaInSZWEN1KYni6pPXy+BncDzSqCbRsEsY+ncJaVVL?=
 =?us-ascii?Q?Wq3D8/pxNoAomQxUhnqXzGR6mYnxH4Z93at4lMlA5ntWbUrRIVjhNSeF+Jjk?=
 =?us-ascii?Q?Q9iPllURFY8B+ngp8j3F8dIDuO/FhkcZDFwZVelyLvH8+Io6DFBQusu1kwuS?=
 =?us-ascii?Q?b59jYjfzYTKnYG2ora7uimOKif5xeYlmu37ol9+OQTYvZKC4mB5R5YC+yIJT?=
 =?us-ascii?Q?WC9t/D9GfEiRfaGwq//IVzCHPqnhVnuEQey0R8Sz1/nSBAMgm3l9tnz6Lfnf?=
 =?us-ascii?Q?2vl86jgybqUBjz7jzKgkXstJGibDD9Dn+8VRRtEFhGDbb92Rn0x49TMN/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:51:38.3865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b4c5a9-c618-487a-99d6-08ddc3c83fa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

On Tue, Jul 15, 2025 at 07:39:53PM +0200, Dariusz Sosnowski wrote:
> + mlx5 maintainers
> 
> Thank you for the patch.
> 
> On Wed, Jul 02, 2025 at 08:36:17AM -0400, Khadem Ullah wrote:
> > When creating a flow rule with the transfer attribute and a meter action,
> > the driver did not validate this combination and would crash due to
> > unsupported handling.
> > 
> > This patch adds explicit validation rejecting meter action in transfer
> > flows with an appropriate error message.
> > 
> > Fixes: 46a5e6bc6a85 ("net/mlx5: prepare meter flow tables")
> > Cc: stable@dpdk.org
> > 
> > Steps to reproduce:
> > 1. Launch testpmd:
> >    ./build/app/dpdk-testpmd -l 0,1 -a <PCI BDF> -- -i --rxq=8 --txq=8
> > 
> > 2. Inside testpmd:
> >    add port meter profile trtcm_rfc2698 0 0 5 10 50 100 1
> >    add port meter policy 0 0 g_actions mark id 3 / queue index 2 / end /
> >       y_actions mark id 7 / queue index 3 / end r_actions drop / end
> >    create port meter 0 0 0 0 yes 0xffff 0 y 0
> > 3. flow create 0 group 0 ingress pattern eth / ipv4 / end actions
> >      jump group 1 / end
> > 3. Following causes a segmentation fault:
> >    flow create 0 transfer ingress pattern eth / ipv4 /
> >       end actions meter mtr_id 0 / end
> 
> I tried these steps on v25.07-rc3 and the segfault does not reproduce for me.
> rte_flow_create() correctly returns ENOTSUP for that case.
> 
> Similar case was segfaulting recently,
> but it was fixed by this commit: https://github.com/DPDK/dpdk/commit/c30b356a4d48542fe99c47aa470afc8cd1ced9f5
> This specific fix is available from v25.03 and is included in v24.11.2
> 
> On other LTSes - v22.11.8 and v23.11.4 - segfault does not reproduce
> for me as well. Either ENOTSUP or validation error is reported.
> 
> Which DPDK version are you using?
> 
> I see that the flow rule is created with transfer attribute.
> Are you using a setup with switchdev enabled?
> (https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.html)
> 

Also, for wider context:

- If switchdev is not enabled, then creating transfer flow
  rules is not allowed.
  Without switchdev enabled, mlx5 PMD cannot control
  the embedded switch of the NIC, so no transfer flow rules can be created.
  This is the reason for current behavior of returning ENOTSUP on main branch.

- If switchdev is enabled, transfer flow rules are allowed.
  There are however 2 important points:

  - Transfer attribute cannot be mixed with either ingress or egress.
    (https://doc.dpdk.org/guides/prog_guide/ethdev/flow_offload.html#attribute-transfer)
  - In default configuration, mlx5 PMD does not support QUEUE actions for transfer flow rules.
    In the steps above, meter policy contains QUEUE actions, so using
    such meter in transfer rules is not allowed and is rejected by the driver.
