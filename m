Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78713FC591C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 993BD4021F;
	Thu, 26 Feb 2026 10:43:00 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35]) by mails.dpdk.org (Postfix) with ESMTP id 7FCAE400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:42:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU/OKzDPN0dneuE/2Ztd3NLeHMmP62CklhGq9sAWJHjhad4isnuOkdenceBxDDrGAvmo4BOB5biMTTEEnhfXQzH5va+RxmVLhOaV0z8A8kixypuFvJZGpCQt80fUILqQzZ/iNzHi5BsjNvquH/NvaA/srveRt8Gb1TlPjUAfvQMxG7+iv54QgaJuiZG5ayoavpYbASMWKq5I6aJXRShInaD/W7+bN2rWS/FhxHH4aziT0fQ6eSMCMaYGLEGTRNAAs/ZxkzksYrUYnvCIVHZ7hVYZWqwrEUs6vLhwSbsd17bmUBXIUvaMlcpPpx202bTxBcL1ErrNtqWug1l470jjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0vg5xaZWLEGbXzIf5p8j3q745Aqx+F8kMtqRHlQfSc=;
 b=px5GlPfi6v37KYvXkLD5yUOWBGxftFeZRUfz7IA2qGggItBEHf+8Opgs6LzviDpa6p66SCJtnDkFFwPpGcaGs2hnYGBh0YzwdxZYdpf/f+4Re+8nZ8NyINjLa9Bk9t5p68fENe+LxjJ3IAW427AL1/DDt6JSHQXMyPiTvpw+FpEtsXJfmJ2r1y0rC+B0MlIXOlDJyyPlDGpEF0HTL6VMYRtUEtr+Uwmw5qguTZurtkvkFcmDj2wmopPKEpNSmWi4FGNzLxSFJL265IH+0JXqSL3hrgU0AdT2yteSmrwBWvrRBveufhYcekXZjH/kllKJO+BpMe4QfjXek87gIzXiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=akamai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0vg5xaZWLEGbXzIf5p8j3q745Aqx+F8kMtqRHlQfSc=;
 b=E/h1RZLrhddCgZs3w4iRtM3/hnuA2zxSPHW0kUTJUpDXuRz9rV4cwOW/c5TSOqNNTQeg4lqis0DTxzPefT4bNlVooVvldn5hDTKQ2gEvkYmIp6EOv5rQnOgpjsEx1SgwTmzGEz3y9ldqGvKlM9IZOoQQlk3DQKNE67ICkuc2WKMTdBjXhrtsc4XSoSAlxkRw5YWwSsbfFpuY5LLoN8IFB1hi5rjTBJ1QRNvUagGomp1KEJYGGkuDgNEcyNMBC1VH/aXbitu3lPwoUPsAcDRxfXGYqLk5sSyhhnC2rC+A5xDumP7EdLuc6KPbDCCDSLkFAtZmnJEHsEYKDMQlFSlGzQ==
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 09:42:54 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::73) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 09:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:42:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:42:41 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:42:39 -0800
Date: Thu, 26 Feb 2026 10:42:33 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Max Tottenham <mtottenh@akamai.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <johunt@akamai.com>
Subject: Re: [PATCH v2 2/3] net/mlx5: fix vport metadata for auxiliary bus
 devices
Message-ID: <otd2qey54iwxcyxm5chnnfhzce7ee2n7g7yweuydiquvinay63@e4sqmaqpnist>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
 <20260209161440.1947052-3-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209161440.1947052-3-mtottenh@akamai.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9713e2a6-c80e-4387-52e4-08de751b6a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: 4HaeZOdnP6YsaLtaCltb+tnAWN8FyNNg7B344dqGcaQQoRHJ56nDm1mAjLLiH43/hoXEwfj1CArFIqe1h1IBtnWZJdlJdZrHsVgqp27O9g37Y3ZT15rDuB9ELOwMFp1mVZzD9VPJrsCJfOrHgtrDjuVlH3beeubW0+mgy1Unbub4kxPavzuO/YxO7QNLxaHv7OeZDwH15MY3/zadJC6MAt42Jj7aHYKvPvGqcUJle3J38sUZJFVp4f/K9c/vFxwVNod3S2DbTUBn16X4FqftAbVCBSMPcVRlan9bFMGqvtdZvir1GdXbU3iXsHF6henOk5YVSKXddlmfr5NHJZLyubejTpWY5JL0/XST1jlSdN8MS6d3Mp36Woxf7afTa2QGAmBUs4Cr57VGKpqyfaIh+3nTkYSvBWIFEGYqHYfxKiEJ6NZgwCK1I7/nML3afMnHvVxo+XjnsX6qkTSyWOIGK8O8pWmaxcESfBDBdU7VDL6UXN8pnpRhU1MRBOTGPRc3TTy1UeTuoAg8jsLEvN2d+KWy26SHeXPJ9odrnuJW3uLGjC9EFyge4O/ul5tA9X4NAEVhq7ONh7MKruUPfSQvYAPcpqarYV/0DWHGlFJR3ihe2u5Y6KeZeIHrSqUvUpB+w51RRvg02ia1PtvG78w7jkqd0ph9JPzQXkI+j0Ex6uzLI9rfN1joK5f3QnNsAmAUpE3L/Ea+ZGusfY/CiObY5ODr48Jbecr33gEtjl8vB21ViDdrXmwkiSWOM0JaLXzOV63986rtJnhdSx7qMLRRi91SGV2G4U3KwXE+heP4Nqo0JiACPDhvQ0ZiHESYyawJR081ztx8j8LXmxSTLFknkQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007)(7053199007)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y3oXHg9p9T8+kFOs/hcDU4AsYeJ0EpHl4KqYwjLwOSUPZH/LfMIj0gU9MzFMgJgH3Cr1/jGeCQ7c4Df0P+/U4gNZ5pVoMNe/DKlze+VB459KPOSbO7O5QORiViBP6GWWBsDKUWdPwvy5J0WeCGLTmzwtsdqvHxtoMz+HekRg/4h/LtTTpC4M+jV9yx76MjSlbE93/3giV4SSgQG9v5X0dGSsI+sOwoS99Y5vvF4qkweG1F8mWcFlAsAqGaoTkuifO+Tn1IMVQDVn4dNCuiHDKQq8KkZCocauschg/z5cjZdWLgYmYaedArYpbPCAgUoSGJ8E2Mr3mVDXhQAxK7XE4h07YfW/ymkcOc7yEkE6xImHR33xfJFoJ1f6VVupaHMZDrqRsU02Edf5gJLI7Hob0j73CcTZNGQsb8zXxQYxRqGYGIw8K93wOL+V3AD2xIKw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:42:53.7254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9713e2a6-c80e-4387-52e4-08de751b6a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
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

On Mon, Feb 09, 2026 at 04:14:39PM +0000, Max Tottenham wrote:
> Query switch info in auxiliary probe path to properly identify
> SF representors. Without this, esw_mode stays 0 and vport
> metadata is never initialized for hotplugged SFs.
> 
> Fixes: 919488fbfa ("net/mlx5: support Sub-Function")

According to style check, commit hash in Fixes tag is formatted
incorrectly. Proper fixes tag can be generated using a git alias
documented at: https://doc.dpdk.org/guides/contributing/patches.html#commit-messages-body

Could you please fix?

> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> ---
>  drivers/net/mlx5/linux/mlx5_os.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> index 7f73183bb1..ec96d11b26 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c
> @@ -2970,6 +2970,21 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
>  	}
>  	spawn.ifindex = ret;
>  	spawn.cdev = cdev;
> +	/*
> +	 * Query switch info for SF representors (like PCI probe does).
> +	 * Without this, esw_mode stays 0 and vport metadata is never
> +	 * initialized for hotplugged SFs.
> +	 */
> +	if (spawn.ifindex > 0) {
> +		ret = mlx5_sysfs_switch_info(spawn.ifindex, &spawn.info);
> +		if (ret) {
> +			DRV_LOG(DEBUG, "No switch info for ifindex %d, assuming non-representor",
> +				spawn.ifindex);
> +			/* Not an error - device may not be a representor */
> +			ret = 0;
> +		}
> +	}
> +

Could you please elaborate on the type of setup you are using
and what kind of issue are you seeing?
How PF, SFs are configured?
How are you probing all ports (both SF representors and SF).

In general, switch info is only required on related PCI PF which
controls the embedded switch.
Switch info for SFs should be queried only when SF representor is
probed and SF representors are based on PCI PF device
(e.g. probed with 03:00.0,representor=sf0).
When SF is probed (i.e. when mlx5_os_auxiliary_probe() is called)
this info is not needed, since SF itself does not control the switch.
In relation to patch 3, switch info will be used to create vport actions
on transfer proxy.

>  	/* Spawn device. */
>  	eth_dev = mlx5_dev_spawn(dev, &spawn, &eth_da, mkvlist);
>  	if (eth_dev == NULL)
