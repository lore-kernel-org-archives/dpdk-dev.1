Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26892C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E131A402E0;
	Wed,  1 Jul 2026 12:46:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BC7F040278;
 Wed,  1 Jul 2026 12:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782902790; x=1814438790;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=59PNSN2ispx5rbG+trT3YPli5MagjrDgjpXitApOnKI=;
 b=k4gSbxkRpKH9QGy/iFtd9rzRCJT/O3ELI9gaUomVmsuRBfbvMYs+8cGi
 3lWY8rdeERiDTps+w9SAYjx48p2UmGesCdrzV1R1myocsK4Q4RYF3O6F8
 EX+oQMtR5BX9hITjjRVLqxXqSsgBRJm6L1hkBh5ogpsFtYCE5PinTAyuw
 E6HrD0BYgFenBlyBNo61E1fjoR6SssqtaQeoUyPnibr77kxmLTxTZIufG
 1lVzl/ezZgyP4UXW9GgNzRowS5BRQ82aFTMdAGiuwx8/H+VcNJxkaNhLd
 WOJQEwRqg7BBmSCKE0EvSrJqtEGs9PzGIdxfl2PehO9Bfj/tHlDBcX0cH g==;
X-CSE-ConnectionGUID: uNzZIHwITFygBdRxBj63eg==
X-CSE-MsgGUID: vbDq6nMGT+uE8DOMEUPwDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="109179487"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="109179487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:46:28 -0700
X-CSE-ConnectionGUID: 737eSztjR3Gj/ki/tRDquQ==
X-CSE-MsgGUID: UESYyGTsQaaC9RMp0GQERw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="249170143"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:46:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 03:46:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 03:46:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 03:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkEdH3CryOIT0ErNjfuGbkeptaoHN9DUixXGWE/zp2CKNSRWK+dmcXDFL2A0+sbnQ2rDSebyb0K6ofHwfr2hXfndMeXoQD5VcUIqMdI5WOEnCDVNHVfUPYPSOLBGqA32SrNuvz0UmOu3GPMDoBMx1EiJQMmcm8BLdp/Lu3GlbtMlw9uAMibB8AAKxVADQ/0BVSv9IicBB/sCE4dvNFrN/DP3fvfh8BIsM/ejoE4uHpUcYkHaqryIR/DgO4h7oTcUHBPXPjEyeVWtaE55594vr/8xxTk1sZjkMLc562pozQN765+iCojQEUm/BWB226HfvtY7WoSUOJA1gsA/1SNVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvpDrZCxVJvi2zp8CGHtSyW25zYxZrF4d5lDv2XLt+M=;
 b=QwKqgQAPdSJmahi5hnneiaI7f5MRk/Dsaebv9HbHqotfuP9qFzoc5NWud+3l/2fQZ4Nna/i5iHHrMrOPlWCia/UAzAQkttnUtLwFExD/UW+5z/9Vy6IZQRCYEuBo4zafZR2AeUaPGAuIdzlChUoRYIZX4lb03IsLGRFK81fUrccVaQ0YRuqBDJyG+36jyK002IGuL8ilHsIpQG2+QBz81ZvN+ycSHZmCPZ9/XGaHDD1ov9v9D9K6qvsqJe60guAYv2bc5rIwayMjHwYvxzgJWUT0f0Hul47r9Qa9wR7ASVZ+6UFlW/nAPKllYcoqDgZoWA37KTqPprZimJAnUWfYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DSVPR11MB9718.namprd11.prod.outlook.com (2603:10b6:8:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:46:23 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 10:46:23 +0000
Date: Wed, 1 Jul 2026 11:46:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/ixgbe: fix EEPROM read failure on copper media
Message-ID: <akTv-wISOVqvd8XD@bricha3-mobl1.ger.corp.intel.com>
References: <20260701090703.107264-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701090703.107264-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DB8PR06CA0058.eurprd06.prod.outlook.com
 (2603:10a6:10:120::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DSVPR11MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 738cb4f0-7727-4b5d-cf05-08ded75dfe6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: GKPFDbpsLjf4BEBWOY7idhqzenHdzjJEw6Au9wzquCXsBoMhI1TJ1hq9dweftKGNkJAGGVJeftC5AvnUiKe7b8dbeUuz6ma3kpi9bR/u0X6FlqqlUlZUNvvt1GqvewmdYoXKtpR0QP6DngzJNEot8HYJF0Y+bWWWzyHIyU8Q/iMr0eOYCjn4IF0VrDO85ECTQuEzM7VXE3KtRj6B7JRK9j/fNlJkeccDHMOvh1Ic+gDbZ7AmaQyysKn3pqJkISb2deMhdsmp7XgvbH9s+ODNfC32xmnRwZxH9leib77dJ+Bn6fqKqIALpGLd0i0OVj+tNqhje/pVw1jz/xiGR999DWbcMMuXDxyfCREFycAtTLwf1FnHykdoYCD1eLDTfwFUZMR2V0ckh//Bw7XR/GIoYBCWsdWK4fTMU9p1f3WIs7mAfRa7+/lg8RArMlTKi3ixnZ7O65YgLVshY49mEsJwD3RlKDB6kST7dKWmR8WSKpnArMWxSdtQ4yKVF7NRGOBGO60yJ358GTza8fQGURTjZnLWqstIf0cXMElx2wKMi3DDXIUHCS+6ZgxpacYUa8Dgw93fbsdtwti6DRgKnTQuGzEkF6DhkVPyvruEoRKR9Rpwj35/e8uVYzCSgSmAT2yky8R9puxz+NnJpNADOJvmNPfG9IYuTikzPmpl39mpBzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKcqibFhARn1bUEOF6bk/Xew4HcrRGLJ4NYFyg0pmdPS0ngw5GAxixDZLySM?=
 =?us-ascii?Q?Lz4kex79LqCPYcPburvrIN46HYjwGuHPc6mbXaS5b/MwvUzbnXDVw1wFsB+B?=
 =?us-ascii?Q?THiHnLX01xPK7nOFbJONFfGZjUKVyOKKicsgb+T3bxOeOD8db/f9T7v78FAQ?=
 =?us-ascii?Q?I5gH+4ltCJoPJ03IUt+3WWgrZSU9h/9Go13auGWPxn9UiQbhQ+ACe0568GBA?=
 =?us-ascii?Q?+9ve2uh+eXBd0tAshnEYja7OXZhGRGzTHGl2eR087Kfllnng2lEoVN23vhd+?=
 =?us-ascii?Q?dVZ4Of0fErmCaS3ki4owpUxVqczFfWOzd1ZOJmfKObN9JZExDEDBaihGkCA+?=
 =?us-ascii?Q?bHcY8sbIW6Khd829fxPab4uVo8TjFMZzWPjPgFZ2Bgb9kdBiPef/UzwufJfW?=
 =?us-ascii?Q?HLlHPoLZ2eX+/7WmtzjzcJ4HgrZ4chVs+qYCFO5p5Wvigr8HT1bwJNR2MSV4?=
 =?us-ascii?Q?vERZy+xKx65TeoZ3JDGYeqA/2Sg+xhb+Vj0QvVAD6Ste83KLD2IGiKduzhp2?=
 =?us-ascii?Q?zWWHg8yP1xzv2c03EnQvCIv4yP0lhgFVQ0jm5Ge/S1cdenDKZ/ZHgPGTF4aQ?=
 =?us-ascii?Q?XJ0iUYKcodZQhZOxKxhTNFN64Fa1DPi7WFoKhgWFzmj9c2n/7iaX4Sdjwzut?=
 =?us-ascii?Q?OLFTNFgndmzh56f9I3QzfyMGRmkEewNQFUkZUtjYDGK9Pb4GwDPx1t42OmxT?=
 =?us-ascii?Q?TZVLk+dpx87iCmK74d+ZZ0FaJ+y1brM72UK0N9Tghk6YS4u9f5lnI4gDcGHL?=
 =?us-ascii?Q?dJ3ETfGhv3yHUj8xNduNZV2hTZBC9B8/xGoXidsGC09OKUecsqoqDDeb05SU?=
 =?us-ascii?Q?6Tk8xd4RjN/5vjDn8E9Ed2u37hKi6r8OS1kqFiPYvrfn9NZz62lnn9FWNV9m?=
 =?us-ascii?Q?0FN+/nAmFs6iDYB0lPTboqscGxc1prq8JB5fDLIWvEHO2zKUWU3+Vskifkl7?=
 =?us-ascii?Q?IWIv6ZHMrhfSaajMBenpozG0oGq+q3MC5Hkm5yNLBzi0uLuhM4w6z3k4Zwyd?=
 =?us-ascii?Q?d5IxqJ+2H21y+/jz3UQltUwjCgy/PqfLrXU+6zVrE5P35vzZDCBPqEDu1eA6?=
 =?us-ascii?Q?agEuNbYQU3h1J2KeTAxOg0AQOG/4IMYNZyd2asqIA3Bj0j26VsjZTO1aFJpk?=
 =?us-ascii?Q?sePFYiVRinDU4an9y+x0+TfnC/m6Df9gWiT/G8nhppPRd3nU4l9pVgFPQG/Q?=
 =?us-ascii?Q?/0R3bpa2c91Mvux2gbKCqt0X+OsezCW5sJ/j5P/V2QrFdAcII+vf64VWEcOf?=
 =?us-ascii?Q?s8HBcpXoO2sWGe9yaUvc1Ae/nxzJ+1iFsA/zbzFL+BhGkRdaWgWklhPN3sc+?=
 =?us-ascii?Q?EwyFtxm1Ll1m+h4Zjd+6sEYcKIuh2stIaz8MBY71a0a4rIX4IzDUEVcq8T1/?=
 =?us-ascii?Q?W2uU81Nbdd4r1G4twXjQG/13eeGgu9VUNuvRzHv7znZsMS7PZ8Aik+ZMLUrJ?=
 =?us-ascii?Q?nb3ERaYkVlovJrhIUcL+Lk/Dp1n8pclhsxyaY4+307k5jot+AoTbdE4ZTOl1?=
 =?us-ascii?Q?+bgtVP13hshRzFBQzyXyvEOJsSP75OgW4bBitgna92MwwehEfCEN8LiuSU56?=
 =?us-ascii?Q?mLpa6d8YEWNNnN0DUQOX6WL3iKekoeidkVA5b1exuSCx4A1ztylGXTSarPwS?=
 =?us-ascii?Q?SUyt+Is3cl+Vtc6nMAA2W2rzq3e3qeOtkiZDQJVOFO7AjMWvJCBYHcsCWVMf?=
 =?us-ascii?Q?hP3HtYt2MJE2tSgDTchihwyIj2EZtwoNUmIhunoSnaK68qhbf/piFTx8UEaN?=
 =?us-ascii?Q?uo6zIcWOpY+hwPMbw18wHw3IT5kBUOg=3D?=
X-Exchange-RoutingPolicyChecked: JUvi1We2OgrbK8Gv8gIAaV5mVhIqUBQTQCxsRzEGv0cQGP7GGHEsdN8tWcNEfGA4NpXkFmPhUoMJ5UccH7t6n9WIQyXm88/cUGOwC+FF++dGiDUMzGgeMsvPt0LfWAPQ5Ncuf+hZbF3EWaR6qyfhTMDoXMFDvypAoV/VUPPWyZVlJdr4UO+x4Nukrr5KIYI9bMRBJiVCWd2PvByWccKZ7ciMZy/i1H/n7dWHm5QEio5qvYQpDjx4zfO6RWhmCRCO9K06mTBpIoyb+DlVpoafFPuSFS33Fu2PSfCWx8aYEBJeq163Z0XrY6BaYOMKl5coBL/Ye7XMAu0eOxBty/ysMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 738cb4f0-7727-4b5d-cf05-08ded75dfe6c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:46:23.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpTzGl+2pci7k4jXhpojRlGERiUV9vMBqmWXC7aTK+QVy7oB+++OSZecalRKuie3Fo778+UuDayJ7hEWU5hncV6D6MtCq8OkUqo9u6wYWAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9718
X-OriginatorOrg: intel.com
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

On Wed, Jul 01, 2026 at 09:07:03AM +0000, Mingjin Ye wrote:
> The ixgbe_get_module_info() and ixgbe_get_module_eeprom() functions
> attempt to read SFF EEPROM data for all port types. However, copper
> media ports do not have SFF EEPROMs, causing invalid I2C operations
> and generating error logs.
> 
> This patch adds a media type check at the beginning of both functions.
> If the media type is ixgbe_media_type_copper, return -ENOTSUP to
> safely skip the EEPROM read.
> 
> Fixes: b74d0cd43e37 ("net/ixgbe: add module EEPROM callbacks for ixgbe")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index f9de95e4fc..44c29f0642 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -7424,6 +7424,12 @@ ixgbe_get_module_info(struct rte_eth_dev *dev,
>  	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>  		return -E_RTE_SECONDARY;
>  
> +	if (hw->phy.media_type == ixgbe_media_type_copper) {
> +		PMD_DRV_LOG(DEBUG, "Port %u is Base-T (copper), no SFF module info.",
> +				dev->data->port_id);
> +		return -ENOTSUP;
> +	}
> +
>  	/* Check whether we support SFF-8472 or not */
>  	status = hw->phy.ops.read_i2c_eeprom(hw,
>  					     IXGBE_SFF_SFF_8472_COMP,
> @@ -7477,6 +7483,12 @@ ixgbe_get_module_eeprom(struct rte_eth_dev *dev,
>  	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>  		return -E_RTE_SECONDARY;
>  
> +	if (hw->phy.media_type == ixgbe_media_type_copper) {
> +		PMD_DRV_LOG(DEBUG, "Port %u is Base-T (copper), cannot read module EEPROM.",
> +				dev->data->port_id);
> +		return -ENOTSUP;
> +	}
> +

Looks reasonable.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

