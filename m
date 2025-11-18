Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B630BCED24E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 09:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8552240281;
	Tue, 18 Nov 2025 10:49:28 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by mails.dpdk.org (Postfix) with ESMTP id C735440150;
 Tue, 18 Nov 2025 10:49:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysu8659fawkNFx+IRE5IkT3cw8uIwyzIE1nTFEITTBmza8pLqKwLoMaI7gagVMST3BSHnfWVZD4kBpG+lnO62vC10hGbac1VOSW6tIyCnMSZ0dVpKpeTyPvhM2kpcy2IK9FIcc96A8SWx59Palz85/drZqmckMwOZMHskYup4IlCNfGW9nTY1/aQfi6IW23fdFlBlxDhfmg1lR0MIXtHD2AtlAo0J76NAyAtXsALc0EjF4UobEvh3h3Y211yP2X7SzYEQ9hue2Dx+LuL2k+OLUTlEtsbTsoQFlwXrdUOxGrWQZBjFOk8MKvMELERBTCXJ9s+gxVE/j73lbQVTtvdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3KJMFIgmx5rydyoVR2xa5oKZsWLs24MFjCtDnPUuMY=;
 b=bMV0G/cWS2m3JgNI6/puDcwceSXcGT87quv5UfqkFsLOBhYiQIRYj44MkZ2kpVIXHOzo17hHO/gupc4O8uQwMLtgranscVYiPKqz35mz/+nm6jpq3qPv1worxzX2BBlwSKX4jrFtbLiP8/Zfd+GbqLQBazMavAbruvE4bDxH5C0FIRo9PdQosYmHJtIXT4qH9zpyEFa60qi6UG4uBUq8J6VHYatUHZwIkH4nitbf5tU/V77dPPk4UUjVOPzkScFzKhU2cQyKQhg38gHBijeQnIN972+hnx/4aramkuCqXJlIRU6Dmnguhgym3taUdH+xbgf27K5+mrDrrimGHiOpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3KJMFIgmx5rydyoVR2xa5oKZsWLs24MFjCtDnPUuMY=;
 b=AVaVJUroEVDnE7s4YP5Lf+WKwebLNOFtCHdx7XkdxBh+ZQ5jdgZjSh9EfyPIvqGaXWc1gdw2lw/F2EkDkiWE19V6lpwCyUDrD0xenD6QWYYvoW/bVICdLY3J/v0XEva2GHT9yb35aeV723DRnIvrazi/kPcx1GAi9dghRKXrArGL99DsoCrrZE0i7Gr3UkweScdghYlyBhaP0OuzSJikwjL9ZzRvZZycZVhyRcfsDgbsfEkb5cR4YUiEKhVDdovXexbzHB+4rpnggjNyKMBTJfV5hF41cERStcXVqvRddkqGm5iB7vFx5KabjD3fCFSisqKwqRixaUHKUo6UuDfGYg==
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 09:49:22 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f2) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 09:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 09:49:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 01:49:07 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 01:49:06 -0800
Date: Tue, 18 Nov 2025 10:49:04 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "Itamar
 Gozlan" <igozlan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Message-ID: <20251118094904.7vubnbfaaa23kukc@ds-vm-debian.local>
References: <20251114201720.1639238-1-dsosnowski@nvidia.com>
 <IA4PR12MB9763D2FCFBED63E2F52C7A2CD0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR12MB9763D2FCFBED63E2F52C7A2CD0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: de507da0-7a14-446d-99c0-08de2687c002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7AZa4GqECXz9IN2HZkYe2H1jjzn5ao4HBSgcnLiaVD9lM5CovzKyk9PJ63ya?=
 =?us-ascii?Q?q5O97DqXbzrrss1oOE7GoeI+LIRdn3eVnIvnDgjdtOwaDYkixX/52s8qrw7v?=
 =?us-ascii?Q?8RhV4LOjA2RU07RiZX3XJZhBR+PtQBg0J8iyyFM+AM+VYU+Z5wiYGSTpEy2V?=
 =?us-ascii?Q?XHxiIehCyNd4EKPFAldldwWa5dzkEVIbjZ8T/SZqZJdXdLMGqP1jrO1a/D8K?=
 =?us-ascii?Q?hdTuHewo2FPDGhPuEe1f/MOUCcnc1+y4G4LTGYPyeArqSrHb+WtiqnYWaBI+?=
 =?us-ascii?Q?qOhCE+PmVAPIKnty50kAiSyx1+J3dpG4Z2HGnrnEbvIIVXGgpoHV/X6YARWg?=
 =?us-ascii?Q?mqBT4gASNAtuE3O2bdr+XpeiV77qdsuY9ZY+TkAtIRIuzuiGUoQaT8W2GgIK?=
 =?us-ascii?Q?fGHGY0cXe9ShnXSYaDrOX8MJUn/81ZOQXDDhagzdXNoJPc0erUQykVdnmRNy?=
 =?us-ascii?Q?GsGSxkilYQ2xtNya3WEj9ZxvHGZMa9gjjh4soeiEx89FCW0b8b40WLJMdOcZ?=
 =?us-ascii?Q?LnVh/BpKp46uHU7knh52BGzf6awxb/zwfEMHGTK5pqCvzBkLp6v5XVWd7vQE?=
 =?us-ascii?Q?spAC8/AJX9Fqgkvoeh0Yvg0UB14YNwkBymg2FNRneDEHkLE9vuBt+A07eIG7?=
 =?us-ascii?Q?9f4Zd23dSaiOkSXJVCAn9d6OV9TUWEvQc5Fm4QcTroOnDTlWU0tyms2RQjWF?=
 =?us-ascii?Q?8OEPYqtqmTYMPojr+fbV9c+cu4fCRYJeyuG+jEuoha2rilpLZTsGO6INaIcy?=
 =?us-ascii?Q?5JpEa/gcB9sBuSIITDDpnKuGe2aFkLsvik1nbJYNHKN6J9myO2oI4k5IpLsZ?=
 =?us-ascii?Q?XMX/OoLSEs/cgNk0VZ5rVa/RfKzXTb57KG/pKz/sFQo9SlqbCJi7WO9gWD9J?=
 =?us-ascii?Q?EMNtx8unNacmip84x10dmXHz1lCpyuKdWe/8LeHy6135qPvCJo6+zjOPKKk5?=
 =?us-ascii?Q?qc8iUpHGvk1ghXU5SX1QF9wClFSxeTzia6Q2yNqswyms+MPSNEje1w0lXnbe?=
 =?us-ascii?Q?6sHoayQYBvc14l/lHjZ2HKFWfUuUcYX5HInoCWGu1wSpdLZ/lzhKbGUOYSLk?=
 =?us-ascii?Q?Zm7ZLPK/wb2EIgY+4ubIO1gIDHcIqFERSrA3B8AAEVeBSOZeFjme0yea2itG?=
 =?us-ascii?Q?kbV/eDaDRlZ+c5wwELf8SB1/IkNzpzEhbxsARJ7iQxB2lx4VHamv5WnoNYOV?=
 =?us-ascii?Q?5tP5WEDdlM2dJBczBEjkKG9++6AoH9IBi2AhK5jKER9G6OwFHZ50cTgE3rJd?=
 =?us-ascii?Q?YCjH5uBrLUgdC5aAjvGLrmCUbwGkesP1eUXzhjalEHij7W+hy9/Q35UF9YvG?=
 =?us-ascii?Q?4OVaKdQAtjAKhsRReMoWkLKHS2baKzcFFU+Unwx+KLRvpdO3XHhbTk//ApuP?=
 =?us-ascii?Q?1VHfqAHvuug3WbNggwPZpPQGp5b2HtiLdbgrRq3T0L8wHEdMDeW0mQliJgzZ?=
 =?us-ascii?Q?1onogwGGdWVAzFuR69yfwbiWdRk7S/bWq2EMQ3DROfyssHrfZq9m9oaM2EiX?=
 =?us-ascii?Q?kyW+rs4R//0+3Y5Njdy9bz8av4cFxYqpJJYZCsCtEDvftf7gu+0YOrbRwfiB?=
 =?us-ascii?Q?jy2ve8K3DvqdsCbwpWw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:49:21.6889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de507da0-7a14-446d-99c0-08de2687c002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

On Tue, Nov 18, 2025 at 07:44:37AM +0000, Bing Zhao wrote:
> Hi,
> 
> Code LGTM, but I have 1 question. Does the root group really supports so many TAG registers?

Yes, but it depends on the NIC capability.
REG_C_8 through REG_C_11 are available only in ConnectX-7 and up.

> 
> If not, do we have a need to translate them and pass to the driver to get the return error code from the driver then?

There's no need to rely on the kernel driver.
mlx5 PMD queries FW capabilities to determine which registers are
supported.
Based on that, a map of flow tag indexes to HW registers is constructed.
If given tag index cannot be supported, this map will contain REG_NON.
This info is used to reject given flow rule
in case it cannot be supported (in flow_dv_translate_item_tag()).

> 
> > -----Original Message-----
> > From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > Sent: Saturday, November 15, 2025 4:17 AM
> > To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> > <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> > <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Itamar Gozlan
> > <igozlan@nvidia.com>
> > Cc: dev@dpdk.org; stable@dpdk.org
> > Subject: [PATCH] net/mlx5: fix higher flow tag indexes support on root
> > 
> > Offending patch introduced support for additional flow tag indexes with HW
> > Steering flow engine. New tag indexes will be mapped to HW registers
> > REG_C_8 to REG_C_11, depending on HW capabilities.
> > 
> > That patch only handled tables created on group > 0 (non-root table),
> > where mlx5 PMD directly configures the HW.
> > Tables and flow rules on group 0 (root table) are handled through kernel
> > driver, and new registers were not addressed for that case.
> > 
> > Because of that, usage of unsupported tag index in group 0 triggered an
> > assertion in flow_dv_match_meta_reg().
> > 
> > This patch adds necessary definitions for REG_C_8 to REG_C_11 to make
> > these registers usable for flow tag indexes in root table.
> > Validation of flow tag to HW register translation is also amended to
> > report invalid cases to the user, instead of relying on assertions.
> > 
> > Fixes: 7e3a14423c1a ("net/mlx5/hws: support 4 additional C registers")
> > Cc: igozlan@nvidia.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > ---
> >  drivers/common/mlx5/mlx5_prm.h  |  6 ++++-
> >  drivers/net/mlx5/mlx5_flow.h    |  3 ++-
> >  drivers/net/mlx5/mlx5_flow_dv.c | 40 ++++++++++++++++++++++++++++-----
> >  3 files changed, 41 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/common/mlx5/mlx5_prm.h
> > b/drivers/common/mlx5/mlx5_prm.h index 5db8d67cfc..ad3cca5bd6 100644
> > --- a/drivers/common/mlx5/mlx5_prm.h
> > +++ b/drivers/common/mlx5/mlx5_prm.h
> > @@ -1205,7 +1205,11 @@ struct mlx5_ifc_fte_match_set_misc5_bits {
> >  	u8 tunnel_header_1[0x20];
> >  	u8 tunnel_header_2[0x20];
> >  	u8 tunnel_header_3[0x20];
> > -	u8 reserved[0x100];
> > +	u8 reserved[0x80];
> > +	u8 metadata_reg_c_8[0x20];
> > +	u8 metadata_reg_c_9[0x20];
> > +	u8 metadata_reg_c_10[0x20];
> > +	u8 metadata_reg_c_11[0x20];
> >  };
> > 
> >  /* Flow matcher. */
> > diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
> > index e8b298dd1d..fa2af91d66 100644
> > --- a/drivers/net/mlx5/mlx5_flow.h
> > +++ b/drivers/net/mlx5/mlx5_flow.h
> > @@ -1833,7 +1833,8 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev
> > *dev,
> >  	case RTE_FLOW_ITEM_TYPE_TAG:
> >  		if (id == RTE_PMD_MLX5_LINEAR_HASH_TAG_INDEX)
> >  			return REG_C_3;
> > -		MLX5_ASSERT(id < MLX5_FLOW_HW_TAGS_MAX);
> > +		if (id >= MLX5_FLOW_HW_TAGS_MAX)
> > +			return REG_NON;
> >  		return reg->hw_avl_tags[id];
> >  	default:
> >  		return REG_NON;
> > diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> > b/drivers/net/mlx5/mlx5_flow_dv.c index 95ca57e8c4..2a8bdd498e 100644
> > --- a/drivers/net/mlx5/mlx5_flow_dv.c
> > +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> > @@ -10560,8 +10560,8 @@ static void
> >  flow_dv_match_meta_reg(void *key, enum modify_reg reg_type,
> >  		       uint32_t data, uint32_t mask)
> >  {
> > -	void *misc2_v =
> > -		MLX5_ADDR_OF(fte_match_param, key, misc_parameters_2);
> > +	void *misc2_v = MLX5_ADDR_OF(fte_match_param, key,
> > misc_parameters_2);
> > +	void *misc5_v = MLX5_ADDR_OF(fte_match_param, key,
> > misc_parameters_5);
> >  	uint32_t temp;
> > 
> >  	if (!key)
> > @@ -10607,6 +10607,18 @@ flow_dv_match_meta_reg(void *key, enum modify_reg
> > reg_type,
> >  	case REG_C_7:
> >  		MLX5_SET(fte_match_set_misc2, misc2_v, metadata_reg_c_7,
> > data);
> >  		break;
> > +	case REG_C_8:
> > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_8,
> > data);
> > +		break;
> > +	case REG_C_9:
> > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_9,
> > data);
> > +		break;
> > +	case REG_C_10:
> > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_10,
> > data);
> > +		break;
> > +	case REG_C_11:
> > +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_11,
> > data);
> > +		break;
> >  	default:
> >  		MLX5_ASSERT(false);
> >  		break;
> > @@ -10825,8 +10837,11 @@ flow_dv_translate_mlx5_item_tag(struct
> > rte_eth_dev *dev, void *key,
> >   *   Flow pattern to translate.
> >   * @param[in] key_type
> >   *   Set flow matcher mask or value.
> > + *
> > + * @return
> > + *   0 on success. Negative errno value otherwise.
> >   */
> > -static void
> > +static int
> >  flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
> >  			   const struct rte_flow_item *item,
> >  			   uint32_t key_type)
> > @@ -10838,7 +10853,7 @@ flow_dv_translate_item_tag(struct rte_eth_dev
> > *dev, void *key,
> >  	uint32_t index;
> > 
> >  	if (MLX5_ITEM_VALID(item, key_type))
> > -		return;
> > +		return 0;
> >  	MLX5_ITEM_UPDATE(item, key_type, tag_v, tag_m,
> >  		&rte_flow_item_tag_mask);
> >  	/* When set mask, the index should be from spec. */ @@ -10848,8
> > +10863,18 @@ flow_dv_translate_item_tag(struct rte_eth_dev *dev, void
> > *key,
> >  		reg = mlx5_flow_get_reg_id(dev, MLX5_APP_TAG, index, NULL);
> >  	else
> >  		reg = flow_hw_get_reg_id(dev, RTE_FLOW_ITEM_TYPE_TAG, index);
> > -	MLX5_ASSERT(reg > 0);
> > +	if (reg < 0) {
> > +		DRV_LOG(ERR, "port %u tag index %u does not map to correct
> > register",
> > +			dev->data->port_id, index);
> > +		return -EINVAL;
> > +	}
> > +	if (reg == REG_NON) {
> > +		DRV_LOG(ERR, "port %u tag index %u maps to unsupported
> > register",
> > +			dev->data->port_id, index);
> > +		return -ENOTSUP;
> > +	}
> >  	flow_dv_match_meta_reg(key, (enum modify_reg)reg, tag_v->data,
> > tag_m->data);
> > +	return 0;
> >  }
> > 
> >  /**
> > @@ -14408,7 +14433,10 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
> >  		last_item = MLX5_FLOW_LAYER_ICMP6;
> >  		break;
> >  	case RTE_FLOW_ITEM_TYPE_TAG:
> > -		flow_dv_translate_item_tag(dev, key, items, key_type);
> > +		ret = flow_dv_translate_item_tag(dev, key, items, key_type);
> > +		if (ret < 0)
> > +			return rte_flow_error_set(error, -ret,
> > RTE_FLOW_ERROR_TYPE_ITEM, NULL,
> > +						  "invalid flow tag item");
> >  		last_item = MLX5_FLOW_ITEM_TAG;
> >  		break;
> >  	case MLX5_RTE_FLOW_ITEM_TYPE_TAG:
> > --
> > 2.39.5
> 

Best regards,
Dariusz Sosnowski
