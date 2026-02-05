Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50778E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6654240E5A;
	Thu,  5 Feb 2026 15:59:59 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by mails.dpdk.org (Postfix) with ESMTP id 06C9940E09
 for <dev@dpdk.org>; Thu,  5 Feb 2026 15:59:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNyemPHWnVWZGWXspaqnRFA5DjMcF01SZR/ElrF2aft5Rl4sZT5BKiiojZAKOVc65BrOMQSDhfo5qBnqUUwy7F1kP/6mFUgjzUWJTeTU+f+Z/ESR1lEx937lY6NVfCY0P0U3+GgGmDhTUJKSEyDp8dq43ijCRXuzsf2HekBa8H68LqSuf2DEsrIXuzY9znz0yBU4ZpwFcH7RrefjMrTTuP4mIOADKLb5jVKUwBz7lZ1LBIZQCkDiceTVwXX/RHjFtqbgHfto7bjXHcjyeI6vC8LWkA0mhOwUvSbQmBQZCmx7Gk2EH1Mx44u9Pcv1dpW3IooG7lP6wy2tE2zIN+wUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWUc8NGai3i69t8x19/CwZzBiGcb+gbYX2QO8enYXlU=;
 b=o9EghpQRw0Dcyo5TOM+Z+h+DOVjWbmQeV85kO3/02VleqF9uBeksYkor2KpUOwxo/j8qNyl+3lf2OR+3DAH6lIyl5ijdd+UjYplpo4/Ss2f2sPrJpW3CHNrJQ7iYHxOCMeThmwBk3729CiDLqnV3SwxVinbJah+n37xC8zh8ItPMjjeDtkd1eG/VWGCA/mGodhPa3JCSI2kRMXRWN0U/ZifkSoXgyqxXL1enChxFAy8S4+3LZdtGW6aDPXfjMGG5iE4Jf3IXUTSqAOmViy210yyOwfzYPrq+Uu0SfxYzQNoybyAn1MtEOOF24zNpuos9ZWmLCDyR3c2fHpKML09A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=akamai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWUc8NGai3i69t8x19/CwZzBiGcb+gbYX2QO8enYXlU=;
 b=ba/F/38ZyD74LFSGP7kHHIkN30uFIQPrHNpOWx8UzV200uBja9daZioNtMjo1kjSOMurUIXuBQ8/mH7D+Z6v8piUX+MABDtyjd7OruYlUGsJVXlD2nWA1/IccZsFZrkImurHi8CG7kRx0ccMR7bzWYTJsjEfCipVW+aAeLwUf44iBh8mGZvjfI9HKsVEkfmvsuaHwHTKKrd9759w9ROnFpjLpI1P0VQkH/x0yZ6sE1L6SjurrDn/gOnHansix8xRjCIgb2O5x+1TLieOBFDztHQS0UtJzHaZfO+Vn4DaGtnALMFphtrcX7aOoCanVNb0NMeolSGRE5jx/eXAL32Opw==
Received: from SN6PR05CA0014.namprd05.prod.outlook.com (2603:10b6:805:de::27)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 14:59:50 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::ae) by SN6PR05CA0014.outlook.office365.com
 (2603:10b6:805:de::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:59:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:59:31 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:59:30 -0800
Date: Thu, 5 Feb 2026 15:59:31 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Max Tottenham <mtottenh@akamai.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH] common/mlx5: skip ROCE disable for auxiliary SF devices
Message-ID: <kvgoqx45fofbvrlmklfui5cknnaxfa3t6ayxbrbrm2o4ssqrr2@5jesmo5r2mi5>
References: <20260110231510.39095-1-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110231510.39095-1-mtottenh@akamai.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cbbc6a-bd87-4cff-af7d-08de64c7362d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbAFCHzSti3IK5wl9hOfbGQ4dCoALYZCrPZ8RBFi1iRHIpSmPSVkFE1lu4JU?=
 =?us-ascii?Q?p/VaLo8+oylODwcTcK4NTHT5x7K9lT1oF5WLIfzxjtxptjKf8WIS3q6Hkmzk?=
 =?us-ascii?Q?PMkbfpXlhye9FgejlAbMBhe+sYJfP6ytImtAOZszkjQBn2PxNrzWbjO9ap94?=
 =?us-ascii?Q?EgGK4vqp3FRlScQEcEf7bsqZ8ZGB6ovRj0vswK4dazigLSf/OpthV0Oot1fO?=
 =?us-ascii?Q?2QuXdk3HZU+uQJAwen1eDD+l7lTpYOzjDXHbDBZoiuAVGuXRV4KTbHvGIvWQ?=
 =?us-ascii?Q?aZAGn+M0Q7/EhG38s+TuSEvuT1G94NMTIbV+18MzKD/QTtbpPcZJf7lJfZWA?=
 =?us-ascii?Q?33JUm/3JXg1LXxvmFjg+LqS+leJOj3XWaeQMZvqH634ptANzIAVoq9sDgIT8?=
 =?us-ascii?Q?G6M2bJ7gK0MyF7XcJrB+QZnyBK1S+PvWmHissDAA7LgGAcbXqHQZiS2tCdjb?=
 =?us-ascii?Q?Yg0WSGY56Buy9D4NdaYryQvOATobdUsqqi4ltZAY1GpT1ZNfPTUDLBxZpNUf?=
 =?us-ascii?Q?o03OSOfsOsbd0aCG7x9Lpw7wximfJgw7Cw86wFA7h/K0r+wFeLn9r7wrP6af?=
 =?us-ascii?Q?JJN+omPff7cjCNK15ID14DjYJNPsWL2gG/g9cYgTPDWPECpZK0An3MDk4giX?=
 =?us-ascii?Q?5NtxcetRnEsutfTnAAuaZ0OstsGvfwY0arh9DcUWAG686mv/lu3kJtv7G15e?=
 =?us-ascii?Q?MXgZY8jKBlb7iENBe1+bfiB7ymg3E7GAqkcXb62bIaXDO3abUXVzn0GJjqXK?=
 =?us-ascii?Q?DC+OAsKvfuCBz3oxB+bsvaL4Oh+AWw6H7V9ljfJmpDLCIv67ki+sg1fp+36u?=
 =?us-ascii?Q?jIujHNlII/trVeru6siu7zQn7VZVI2iKwqsYigyaePniYveG39ruaZ5hMGE1?=
 =?us-ascii?Q?j/u+prmj5T4vDDX4Xgjg7wLzHqy1BSfqCvl5FrSufY9ZjvyS3AqO4i4lUaB6?=
 =?us-ascii?Q?KsVsAmIpGR3+XKmKkXDbBWo5/+dLcYOgG0MkkKLOe5ENmem7zZalZ118V+Mn?=
 =?us-ascii?Q?4nafpwMjTyZ55PBUqAjxDTqUpkWmU7O9NOPTDC3Nv8Mzh6fuUhWpa06Z13Ag?=
 =?us-ascii?Q?k16Da73SpQo6yZQhyGrvkms4RW/4KFe5yX4dyDe89Y/G7M2LiXoWF10QkJUo?=
 =?us-ascii?Q?Zj+OffsWhhnOc0pVm8CFwCHlS5nwzhn4ymboxxnJCQvBHtWFrW9sdNpF10Us?=
 =?us-ascii?Q?a1M6JlXLWrmCcsYPoGjw+QB50iY54n/hec5Ctm0jlEB/Bv538R/q1F/XUaTT?=
 =?us-ascii?Q?lEs/Ds0nrcwezkQFqCvOGnVjSaKMp4LmzW3KJyQAYk4HgTc4FyNTPP0VAhBo?=
 =?us-ascii?Q?uzQ7/8sfNBPXJEi28e8KeIUpqXGk0vDliBxu/0ubFyqpqHg5JavIzRZrruuT?=
 =?us-ascii?Q?Rntfoo9IEKd75+GbAtEnCQmWVVaF5MTS6bfFPd24kwGKDeJIdnI7l0JsX06v?=
 =?us-ascii?Q?y4nlAZwdjLWlbQIuJgz7FwAGQ7d/grmoo+8pqpH+LWbJ+VMlyc4JjOgD6V92?=
 =?us-ascii?Q?3NL5j0P49sSUzs9YV3bSLYTHnPgYggbB6ZSzql36tuFltnVjDsKzkj+MI1sy?=
 =?us-ascii?Q?ve+mlbxW/WMg1HnbfR3UHQD3mdClqTcBmgr9tLjj5+6A2WKZe9wjPJndSjfm?=
 =?us-ascii?Q?mxKLFFAtSfWD90vjOFDp/bUOwFrdXgh9MUKz+A9nvc/kXExEP60LW6F5WF1S?=
 =?us-ascii?Q?srOOLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1/BNLrc84Zo5LzjwW6TAvqhmJFxuaQ9wXBSP2rSbUgGhZvP5H0c/MFz1gai2n/YKASJUHqzooPcp+V0z6UXc/Tzps+1kiz4fgGNbzy8Gj9X4FpxbvhS61DTMsf+1XnSQN4QSkPLrCLEb45B0BcDBdEgypiZaHYPIhm2IRHFi2+jPabM1LQOYV+SjnODid/P7BkWPXbseY5kcH2iagPNKfoEkfZePU0/xSDJ6byccPg2LabjFMCPB191yiVGhbGS8H83SUZPGbL/1D1264ak3pa5LFu+p6guwjk7hWg/Mp7J56N1woNgQCHFbdqx+I9gDxtDYm91Yl21ahHLSX1TbJ6DuIJS+K/DDjteHIvpHzT4Zbwy5sG/QgRNgNYSQBojkRpo/PcyKyfVvaQTKdOoViMvOT7vjZ5BD8dkYtyYTN3J5wNIgWJRWiVEgWPpcuIiy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:59:50.1844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cbbc6a-bd87-4cff-af7d-08de64c7362d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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

Thank you for reporting the issue and the patch.
Please see comments below.

On Sat, Jan 10, 2026 at 11:15:10PM +0000, Max Tottenham wrote:
> When probing an SF as a vDPA device, mlx5_roce_disable() targets the
> parent PF address (via mlx5_dev_to_pci_str). This incorrectly attempts
> to disable ROCE on the parent PF rather than the SF itself.
> 
> This causes vDPA probe failures when the parent PF already has an open
> IB context (e.g., probed for uplink ports or SF representors).
> 
> For SubFunctions, ROCE is configured via devlink parameters
> (enable_roce) before device creation. Skip the runtime ROCE disable
> for auxiliary devices since the devlink configuration is already in
> effect and targeting the parent PF is incorrect.
> 
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> ---
>  drivers/common/mlx5/linux/mlx5_common_os.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
> index 2867e21618..6fa12e06eb 100644
> --- a/drivers/common/mlx5/linux/mlx5_common_os.c
> +++ b/drivers/common/mlx5/linux/mlx5_common_os.c
> @@ -690,6 +690,19 @@ mlx5_roce_disable(const struct rte_device *dev)
>  {
>  	char pci_addr[PCI_PRI_STR_SIZE] = { 0 };
>  
> +	/*
> +	 * For auxiliary devices (SFs), ROCE is configured via devlink
> +	 * parameters (enable_roce) before device creation. Skip runtime
> +	 * ROCE disable since mlx5_dev_to_pci_str() returns the parent PF
> +	 * address, not the SF - disabling ROCE on the parent PF is both
> +	 * incorrect and may fail if the PF already has an active IB context.
> +	 */
> +	if (!mlx5_dev_is_pci(dev)) {
> +		DRV_LOG(INFO, "Skipping ROCE disable for auxiliary device \"%s\"",
> +			dev->name);
> +		return 0;
> +	}

The logic has a bug as you mentioned, but I don't think
it would be a good idea to not disable ROCE automatically for SFs.
Especially since, IIUC, enable_roce option value is not inherited
from PF when new SF is created and probed.
It'll move more responsibility to the user regarding
port configuration.

In my opinion mlx5_roce_disable() should have split logic like so:

    if mlx5_dev_is_pci(dev)
        // for PCI devices continue as usual:
        // try disabling ROCE through netlink or sysfs
    else
        // for SFs: try disabling ROCE through netlink

This would require some adjustments in mlx5_nl_roce_disable()
and related code.
Specifically, devlink attributes should be adjusted when disabling ROCE
for auxiliary devices:

- DEVLINK_ATTR_BUS_NAME = "auxiliary"
- DEVLINK_ATTR_DEV_NAME = device name from rte_device->name

Would you be able to make the necessary changes?

> +
>  	if (mlx5_dev_to_pci_str(dev, pci_addr, sizeof(pci_addr)) < 0)
>  		return -rte_errno;
>  	/* Firstly try to disable ROCE by Netlink and fallback to sysfs. */
> -- 
> 2.51.2
> 

Best regards,
Dariusz Sosnowski
