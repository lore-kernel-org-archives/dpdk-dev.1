Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28330CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 815BD406BB;
	Wed, 24 Sep 2025 16:35:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 383DB406BA
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758724507; x=1790260507;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+/cTIXcaccr0Ke2xBZdZgSg66BG/M90BdPcZqgJtnz8=;
 b=eWfcT8OdSzBRVzLCO8LWL0k4loetiOuPbqir0tv9KidKLzlW2GGmL2mY
 KkFgevGAHQK7mbqZ7LDoIIoo6zM43cT4qVQvBzxiM8zNux9M/RUsWCj6z
 ENHqLzJwohsYbDktS2zVNW47u8WecCkDPZVYHV4IfvlvOv2skQftngWJH
 fQ0YvmtObmjBvFkgwdEADhesG02IHZMl1bDPl/5vEqkbLwupkicL/5PhU
 cDihOOwWSrbljVSJWoiZjh6YtKnEZwFDDgv+YHqEG/YFcEPY3qS4wxQLf
 1jjhnsZnW3EQrzk4kG7jvrYtabHkePIDuKqt0X4dWO7PaZkgVYWCA8gRj w==;
X-CSE-ConnectionGUID: Vyjq6+llQZ63acvuxYUg8w==
X-CSE-MsgGUID: UxORuxd6S0OGjjpzsW6T4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60725009"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="60725009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 07:35:05 -0700
X-CSE-ConnectionGUID: pHfKNDXASKmlM2hcHuxdLg==
X-CSE-MsgGUID: twzrN0VsQ7KqYFjRGZ3FFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="200747723"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 07:35:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 07:35:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 07:35:04 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 07:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC7LXJ4ChAs6V9kL/PZW98GZQGGEI7qcAqvcqqGD3G1QOUObPazC36L4LSFZNQBFqQwVD1j5IqpdYhwqf1IXkD3DJG/sdyX4V8NxcVW83KPiejtaLYUE2ljlwjq0jmgqNcqsLmRsw4qo3LboFY3U5Yg4dOtGS3ezUcTDtn9jWea1WyshnSCD7l3mmK7gZAMTJikzyNavmEN7i8E/sMfOAl8ykof+SXiol9qFF1bNluJfa+CjLs8uNKa67pVxFHcfVj7R9F7Q0vmGxAtiHoe/10MBLSlpC+xBYvQSn+hDr3/qsiTDg5RoZ4w/ollHUrYD9tp3fVdNzTh8gWdPS6rUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O45ksWQhFvPad8GhOfq5asc/9NfKuufIwwpo9a3pmYM=;
 b=ysaaty3hZyMDji2Y/7gMbNBmctyuWThieKyiEvpVWfXSu7EOfCGQ7j6OBx7w3CmDd1AGu1rYqnMCzDM5w4nk/YinMWJdztqmXsvPftQQnO0xHQ+wdq5oo1g6fWKVDhDii6q8UawSD6EZLtf+PBSkRq5fUIaYyqefGJgFxMPXfWJQ/GDvKI4KxIidVOPka339J4Le6sHQ4n9NvZOV3IXNcNtw+5jdZbqDhZSTan1ZqWF9ED839GLpt1HCJwiDJ5ibiG7xqqRV3d7sGDNsABAN/9fgyDpJBXPn+4NMBPZ7XCKra2RNhx69GT6ZdM+87MyqMC/NVgrE+tiRLOlu5STGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 14:35:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 14:35:01 +0000
Date: Wed, 24 Sep 2025 15:34:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vemula Venkatesh <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <david.marchand@redhat.com>
Subject: Re: [PATCH v2] net/intel: add IDPF PCI class ID support
Message-ID: <aNQBkHHlRXghKY7j@bricha3-mobl1.ger.corp.intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20250924125749.83507-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924125749.83507-1-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DU6P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ffdcbd-ab4b-4e57-bbbf-08ddfb778b35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y30VXGLGkZD35HT+UdC+IClT8vwOVnADbphifW3PWQn2VoCN7GERjOBhyEUj?=
 =?us-ascii?Q?bbmiORc5vHER16ztrfaKNcdVoZp3sXp4mtSkqegEW5hzZ4nRbPrLtaJw3eN/?=
 =?us-ascii?Q?r0pMrH/0iHj9gbggJ+yxsNVZI9SpZJo1UJiRKLFgv0sfGyxCfd7vTU38A+Qr?=
 =?us-ascii?Q?mWAWq7xppi3SCxMAE2N+yYKgkrvzKY4OcoO9w/JGXlvCK8LLKvYmlHA6Nw/v?=
 =?us-ascii?Q?QuBs9IUWl2r/WA8ZXRsknaPi65/2Si5PpkJR7byg6frrayo7K3aTG4csbPX3?=
 =?us-ascii?Q?4l1hmvTIkjXccIqtOGyoPY6uO1WF+DD448lNfBZZupH4v5I+44x8/eV2JHmt?=
 =?us-ascii?Q?gZjRZ1Yrz0ewORKneEgnNxeP0fe4LgOf3z6wmkZzjDh0OmXIblNYNEGUfIoU?=
 =?us-ascii?Q?0BJAObZO/cjhqED88ZbS5QN3RqBVtmqFC9uqNtWv1wMRDL6dWtJ/tuk9UO6V?=
 =?us-ascii?Q?PA7GSTyyeDGB7oxK8BEfao+MQdg3+0Y81wgru/C5fH5Fheenunrq9Eu0g6e1?=
 =?us-ascii?Q?FO+t2SqtFPrxhdz4amnuATrrvvWcm1QUYcCDcxsWiutw0eiZA9bTzaZzYTD4?=
 =?us-ascii?Q?gozO6nMIKKQNWxSdEClp22NgDL75us81eIYG05SPVjICIM3MXxY/7zi3dzDn?=
 =?us-ascii?Q?MOwwh296mRtO//U93Cz1YvxmfX7oVpbJfHG/aSHaFq0tw0F01vDi337OUwHA?=
 =?us-ascii?Q?+9aIGpzdyqZXnED8mQ+M6yOadJdwaI9dManu4GQPtjsxaUepjyCZvtdYaybZ?=
 =?us-ascii?Q?BnDVoF7wHHGrhZ4Y8d3I1JpfDFMmCNtxpoUGLvux/Rw0go4C2LAEYf7yjDV3?=
 =?us-ascii?Q?xy9NxTGf1jKMkjfhA2xr7KfiQL6kFLqF9kZCofaCwVxQj0K3DUrcIitC1B4v?=
 =?us-ascii?Q?1Qw3++Ff46cktG9v4HL0nYFfvpXUaqGlo3IKltAH4VucUTlmcJOBSo0fd+LN?=
 =?us-ascii?Q?E7OM/MQ65DvOud6zimRR4P4mLZB4JcYhy+72DNRWK/Fb6ymRjHtbOw3ANRzC?=
 =?us-ascii?Q?W9VkpOpeC3n1VA7UPlAV0+2/eNWuqkGJsyVNABbLTNCPI/hEOhEj+fLXzieM?=
 =?us-ascii?Q?5SmKJtkFHJXjSvlA+v0uwK4IT+UqFMEi8l6+MgtbS7rp+1Ta03Rs/BUUV8vy?=
 =?us-ascii?Q?+psPuzLJY0Uj5PzpPpmos8L3rGCWQSU3bNgaaKAmxDgP9HHZ5/h7aqd3+qZI?=
 =?us-ascii?Q?VjDTNcblK1Do64B2W8pRbIvxyhqymesCa9+MNYLkKsxNu0d6GyXkHiwCDbJG?=
 =?us-ascii?Q?vlRLAFCSMtNCWNBJcPCzEYu7BYxDMTXWZ795JtLiiHbXOEBW9aTGWnFhRw9c?=
 =?us-ascii?Q?d6eGcF2SaoBZNIDl1+n9avVmybc3RUjcMP+at7Vmn4ddTMGjBY/wEO9SSmpc?=
 =?us-ascii?Q?Vd07f4/0Ow51X3lTcpHqvyeAOCCcqxoJJS02ugeqhnCc5QoX+uBQ7NXGLeAi?=
 =?us-ascii?Q?ag73XWMITms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZI044HmArKdVXm0Ebfy7F+5lb5bRR3nA1su5+G+EqL9sqzReWBb95W6Znx1?=
 =?us-ascii?Q?rd+pI2iKGp1ijkwVB03hVPVt06+aBTX+Np8knuZy9d0eQbBX1rGlXCPbF7nO?=
 =?us-ascii?Q?5FWyFMAel76/cOrfCSj4sULkubgxp2xuwFHSC4U62fcsGdhzXLgp8EWX5ZN7?=
 =?us-ascii?Q?VJP2DcLAxYJzCGKEPrjF9R58GMDWe/ZiYSc9X7GHeqfDb8usmvuIg4eqt0ed?=
 =?us-ascii?Q?Bx7rf9oPH32QTETP8GcSC8DSYeD6bW2I2gy1EYZyRHwcHbC88hFFWypY1Brp?=
 =?us-ascii?Q?9ZYcQzKt3R+FFkYR3OzFUqPwaMHmDpNU6zhpB1G6wKXx+jdRJlUw/X3deosc?=
 =?us-ascii?Q?fK1P7tFkVz+Q/boj4jXKQcQ505jc6kBG7xhc7phxmSPKxMHSDvmH2YRGV46t?=
 =?us-ascii?Q?UE6ikhwREo/ae0NpJp1pQ3c0iixFLNBY3qkZdnm2r6QiIhIpAqsEINBXWByP?=
 =?us-ascii?Q?I0zHuhEyUnRy1LU7RTYJinViH+ezTdSjvbiTzbu7MRiAfReOQKcHRPHq2MzF?=
 =?us-ascii?Q?IqSXcJmMXsSdesCIAxtIGZCNfIf+TekmBqB7qiffw2wdfFogPkT+aTOubjom?=
 =?us-ascii?Q?jwbVLWdcmgxYqn0Xbrd8zoIrnK9w45qDZJ5v6KgAI4ySuGRn+TE6sQXfHpT0?=
 =?us-ascii?Q?gBZIvI1tgeH34Tlwi3l47KzlAKnT71msSvHvr997WT+nWBqqt+Pbf6hvcm+7?=
 =?us-ascii?Q?7AWrzbC6DzIqL/SIlPBPC17dhW9m26W3OMFPnua/g7NMS0PNDK7MHdQeT3k+?=
 =?us-ascii?Q?oFqjzMeQXhsuqXIjvwN8Zvho1tIOubE5dbytGflAemr3O+fPtPmsdUXwqqQt?=
 =?us-ascii?Q?NMT1Vhr+mojSEJFLsEIAiqybD4G306kBx/iEaxIQNvZY11SjgLRPpfJe5zJ7?=
 =?us-ascii?Q?YhopB/ehStbWiHx2N6mBudBx954r4PYGs829NyKKs479C4EBVJTHOfCBYhOl?=
 =?us-ascii?Q?Hv/fiabaH4NrLt/wCLB0F8i397iPPw/1fYaKEpsLzKPK2AGh4W0NQHHAYzv3?=
 =?us-ascii?Q?a0wS3uwnq5gj/sWHN/ws49KsJXLCfNaov0IDJX/BBfa2l6I19Ru9W2baa4vA?=
 =?us-ascii?Q?CNagq8dLXfH0uuPPBsGOOnoN+niZshmTR7DhnQFb/iR5cS0lxmStN1BeVZ2y?=
 =?us-ascii?Q?WmHEZ3u33ru3uKhPfOFEeJpjr4Syk3et1OHHgNEFiIePlydR7247IDc2Ix++?=
 =?us-ascii?Q?xwS+SOpVzJMDGNFf1berdbeeRUHW9y/dry0LB3WDE0onppGSkC1HvmpTwTti?=
 =?us-ascii?Q?lngjJUh1wt8SUtTN/fzThDfNeHrBsrbKa0WC+8NDqulkno0KGanqaUtb21zt?=
 =?us-ascii?Q?vPHVGsAB51cJN+Zf+m82KdZss3jLONzZ4rZmrdFMZ2qAWHO9D19MiHAYvtJO?=
 =?us-ascii?Q?q0Txy2NjP8oNllpF5WjBDHqOGk8BNGuHsF9q/W4haa8bJ0xj+1UNvTJomk+9?=
 =?us-ascii?Q?n1nP4ma8Cx9fC418Ad42UarjMOGanDXQ1qaC24VL7fTRQUsM4sAwk6pK1X12?=
 =?us-ascii?Q?3tR+ig3t0bMFv7rKthuDtMSkDNydtc3mqxU4EK7u5XIRzosVOaw5qPe5XUrn?=
 =?us-ascii?Q?3ivq90N33Ajw3X47d82aczdy0ZQwlgtdNVAbbZxQxySwlAK+SGRMhKVB6WDs?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ffdcbd-ab4b-4e57-bbbf-08ddfb778b35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:35:01.3200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvNxJy8pANVIfZFga02XWcBS5VqhIw8h/CY1oAxk7A93AG67PoHCiwSCuUsqGgtzWHhC4bM43FqKbAjsJvlskw4ELQ8193mkJ+w6soRf32w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
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

On Wed, Sep 24, 2025 at 06:27:49PM +0530, Vemula Venkatesh wrote:
> Current IDPF supports only the MEV device IDs. MMG has new set of
> device IDs and same might be the case for the future devices. Instead
> of adding new device IDs every time, make use of the IDPF PCI class
> ID(0x20001) to differentiate between PF and VF.
> 
> Write and read the VF_ARQBAL register to find if the current device is
> a PF or a VF.
> 
> v2: addressed reviewers comments.
> 
> Signed-off-by: Vemula Venkatesh <venkatesh.vemula@intel.com>
> ---
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  3 +-
>  .../net/intel/idpf/base/idpf_controlq_api.h   |  1 +
>  drivers/net/intel/idpf/idpf_common_device.c   | 37 +++++++++++++++++--
>  drivers/net/intel/idpf/idpf_common_device.h   | 17 +++++++++
>  drivers/net/intel/idpf/idpf_ethdev.c          |  2 +
>  6 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 6d7b23ad7a..8cec977ecf 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -2606,7 +2606,8 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
>  }
>  
>  static const struct rte_pci_id pci_id_cpfl_map[] = {
> -	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_CPF) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MEV) },
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, CPFL_DEV_ID_MMG) },
>  	{ .vendor_id = 0, /* sentinel */ },
>  };
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d4e1176ab1..566b395dae 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -59,7 +59,8 @@
>  #define CPFL_ALARM_INTERVAL	50000 /* us */
>  
>  /* Device IDs */
> -#define IDPF_DEV_ID_CPF			0x1453
> +#define CPFL_DEV_ID_MMG			0x11E0
> +#define CPFL_DEV_ID_MEV			0x1453
>  #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
>  
>  #define CPFL_HOST_ID_NUM	2
> diff --git a/drivers/net/intel/idpf/base/idpf_controlq_api.h b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> index 8a90258099..7c25aabb28 100644
> --- a/drivers/net/intel/idpf/base/idpf_controlq_api.h
> +++ b/drivers/net/intel/idpf/base/idpf_controlq_api.h
> @@ -184,6 +184,7 @@ struct idpf_hw {
>  	u16 subsystem_device_id;
>  	u16 subsystem_vendor_id;
>  	u8 revision_id;
> +	uint32_t cls_id;
>  	bool adapter_stopped;
>  

This is a poor location to add a new 32-bit field, right between two 8-bit
fields. Adding it here will likely cause more padding than necessary to be
added. Add the new field alongside other 32-bit fields to minimize padding.

>  	LIST_HEAD_TYPE(list_head, idpf_ctlq_info) cq_list_head;
> diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..6f083770d8 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -125,12 +125,12 @@ struct idpf_ctlq_create_info vf_ctlq_info[IDPF_CTLQ_NUM] = {
>  };
>  
>  static int
> -idpf_init_mbx(struct idpf_hw *hw)
> +idpf_init_mbx(struct idpf_hw *hw, bool is_vf)
>  {
>  	struct idpf_ctlq_info *ctlq;
>  	int ret = 0;
>  
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV)
> +	if (is_vf == 1)
>  		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
>  	else
>  		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
> @@ -388,8 +388,21 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  {
>  	struct idpf_hw *hw = &adapter->hw;
>  	int ret;
> +	int err;
> +	bool is_vf = 0;
>  
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
> +	switch (hw->device_id) {
> +	case IDPF_DEV_ID_SRIOV:
> +			is_vf = 1;
> +			break;
> +	default:
> +			if (hw->cls_id == IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
> +				err = idpf_is_vf_device(hw, &is_vf);
> +				if (err)
> +					return err;
> +			}
> +	}

There is no need for a switch statement here, I think. Simplify the code by
just adding a "(hw->device_id == IDPF_DEV_ID_SRIOV)" check at the start of
idpf_is_vf_device function, and use that in all cases.

> +	if (is_vf) {
>  		ret = idpf_check_vf_reset_done(hw);
>  	} else {
>  		idpf_reset_pf(hw);
> @@ -400,7 +413,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  		goto err_check_reset;
>  	}
>  
> -	ret = idpf_init_mbx(hw);
> +	ret = idpf_init_mbx(hw, is_vf);
>  	if (ret != 0) {
>  		DRV_LOG(ERR, "Failed to init mailbox");
>  		goto err_check_reset;
> @@ -443,6 +456,22 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  	return ret;
>  }
>  
> +#define IDPF_VF_TEST_VAL		0xFEED0000
> +
> +/**
> + * idpf_is_vf_device - Helper to find if it is a VF device
> + * @pdev: PCI device information struct
> + * @is_vf: used to update VF device status
> + *
> + * Return: 0 on success, errno on failure.
> + */
> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf)
> +{
> +	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
> +	*is_vf = (IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL);
> +	return 0;
> +}
> +

Why pass in is_vf as parameter and return int here, given that there is no
possible error. I would rewrite as:

bool idpf_is_vf_device(struct idpf_hw *hw)
{
	if (hw->device_id == IDPF_DEV_ID_SRIOV)
		return 1;
	IDPF_WRITE_REG(hw, VF_ARQBAL, IDPF_VF_TEST_VAL);
	return IDPF_READ_REG(hw, VF_ARQBAL) == IDPF_VF_TEST_VAL;
}

While only one line longer, it removes the need for the switch statement
above and all the error handling for a non-zero result which can never
happen.


>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
>  int
>  idpf_adapter_deinit(struct idpf_adapter *adapter)
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..51da8214cb 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,23 @@
>  	(sizeof(struct virtchnl2_ptype) +				\
>  	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
>  
> +/** Macro used to help building up tables of device IDs with PCI class */
> +#define IDPF_PCI_CLASS(cls)          \
> +	.class_id = (cls),      \
> +	.vendor_id = RTE_PCI_ANY_ID,  \
> +	.device_id = RTE_PCI_ANY_ID,  \
> +	.subsystem_vendor_id = RTE_PCI_ANY_ID, \
> +	.subsystem_device_id = RTE_PCI_ANY_ID
> +
> +
> +/* PCI Class network ethernet */
> +#define PCI_CLASS_NETWORK_ETHERNET  0x0200
> +#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
> +	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
> +

So the device does not identify itself as an ethernet device because it has
it's class id set as the ethernet-class shifted by 8?

> +int idpf_is_vf_device(struct idpf_hw *hw, bool *is_vf);
> +
>  struct idpf_adapter {
>  	struct idpf_hw hw;
>  	struct virtchnl2_version_info virtchnl_version;
> diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
> index 90720909bf..80bf53db0f 100644
> --- a/drivers/net/intel/idpf/idpf_ethdev.c
> +++ b/drivers/net/intel/idpf/idpf_ethdev.c
> @@ -1201,6 +1201,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *a
>  	hw->vendor_id = pci_dev->id.vendor_id;
>  	hw->device_id = pci_dev->id.device_id;
>  	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
> +	hw->cls_id = pci_dev->id.class_id;
>  
>  	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
>  
> @@ -1313,6 +1314,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
>  static const struct rte_pci_id pci_id_idpf_map[] = {
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_PF) },
>  	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IDPF_DEV_ID_SRIOV) },
> +	{ IDPF_PCI_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF) },
>  	{ .vendor_id = 0, /* sentinel */ },
>  };
>  
> -- 
> 2.34.1
> 
