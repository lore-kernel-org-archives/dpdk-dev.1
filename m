Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A0E9DE60
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 07:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD46402E4;
	Thu,  9 Apr 2026 09:59:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 19DA5402D3
 for <dev@dpdk.org>; Thu,  9 Apr 2026 09:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775721540; x=1807257540;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kmPVpTOIBf8vA2Rtrzc9XR1Lg9v31M8Qc7WZy11SxrE=;
 b=e47/HL8HhU5LXnwfs+u3sXQDHRYUTSm8b/lrBqnvkh7nFMzhlXFKxIfi
 /h54B4jAHv8PTxK8lU96tTmeTLmPBJj4gQ53tTWt1ltw/kKtgAoLY5sPw
 gry3uK+Db8UvxIZ9+O8KEPaKVffLBS2q64ql8W9wg7M2jOTSUCvOJIg6O
 8LKH6psC95/K8FylcTqOHi606pEWTfN66LZ8gMmLm8nayw/7uKbIFjXR7
 CeReBS5N6P8LubAQuWTc5fp8loTpdf1m9XTUIwoWf+MAKxELOojoGGAzq
 zrGITUjpCh1I3euLTtwb6BJr8NTLsrDc+6w62CQcbzV082X16z6Dii5du Q==;
X-CSE-ConnectionGUID: mUNwrJxoSmC+xXSviS6+Qw==
X-CSE-MsgGUID: IadhjHmjR0GYZOAnQq7EJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76607614"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76607614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:58:51 -0700
X-CSE-ConnectionGUID: ktYq/iQHT/GzyqWRZyrYww==
X-CSE-MsgGUID: wupxxh2+RkKSnOikcI91Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="266673261"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:58:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:58:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 00:58:50 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.32)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 00:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX1Yt7cvVxm26+WqHG8/HL4XUdqdsXk9GXFIYdzS5aTVEQfDSBP0OGdqofNID1ltADQU9qQlTABkUiKzFTvFC/Nw3YU6EWILJOKJsL6gTJn+jbD46lrebFdR8vby4yiyvEc13cDEbA5ki7CvGjWCzkIWKl2AxTxEdiN//26v8iB8lGB+bmHn61NKD3PMDmZyAWyjlnyIBQgRo7ce2tH+cBweK3Hi6j6Y98ZpCumppo3luTxyDqEMeRalQzwrSVPzpS/GXEoEz8REnRFT5bUQdayWbCxE7AySXtxV2eFrfeWJcs8H8zUs7/9KDXMHp4gNI3VvDTpURLqO44ZaxlpMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g5R5bwJeHKZ/Quk5lU7WeLYOlgU3AKxZ4b/zLkWA7k=;
 b=M7RjOUymqiyRx5DheXiMD5W5RKMncqbKj3/6PAPSkR3p//we1dowkmNAIXRus77uuw+r5x/yzvCgNoTPGBEMQTxMJWMB1/uU+YGTqq9GUjvOWSAKq4AujO5/AFnjSBio4cD4YqfAI0ieGpTQK1nx7dG28ifb3ZcRmxpwFnCLlUyHBGRvN0iH9ieE8TsbaTNIk5nDCyLR+lmqReod+LpC1ofc7PoyOW/9xnhyMik3WFx1m1sS6wWQcXAd1OmhJ3vGQbIp78pZ98mBJ5646X3kr2FUiVQqynt/SRM6cnupbGggOOJtjwVNUKQWauqmepPYc18F095ZD6eOfquw8SSHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 07:58:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 07:58:41 +0000
Date: Thu, 9 Apr 2026 08:58:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>, Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [RFC] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Message-ID: <addcKzXuZYV19F3P@bricha3-mobl1.ger.corp.intel.com>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <c04d3145-d6e9-4583-b49c-82341ea9b0aa@oktetlabs.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c04d3145-d6e9-4583-b49c-82341ea9b0aa@oktetlabs.ru>
X-ClientProxiedBy: DU7P195CA0017.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 402d5390-40f1-422f-0d72-08de960dd0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VAUJibWDlcb89HCm7FIBj/7eMvecr5f5osYiZ1C8DxT+hkUUn/wDmaI/SA7zuN/RO4H4ACOA+r2FynyYgSOepXwHxBWkHvQKPhBu4YKnPRVdFDSf52tFzEjLe1Pl43JixusR7/I1hyu74mVeUYs4QPLT3NPriXtI1UCZIpcwNFA3ZJe1uiztO8essTjBSGQ3E7ZwyJZ4qymslPzNxDLDkNQTWuqj2bwdAnGPJvzts+EIVZIcq8S9xG3UJLBK/eQNgD/dC1HZuU2ygYvq/tmAJVzbHgT69D+jJa9i+PdZs6TZaU2WkxoxKS4Z7WdIMEmIxaOoFXL/smyTlZAG53n7fhJ/9dAcDQf6yakLpXaBa8MPL4/acO+nV7ObgAcMUwp2UYaVDDZAbeZ4aNIKiLk26qTuKvhb88P5mm7iDQYsyclzFnygYYri7QiwO3D7+maoNoPOOCIn7l9eIgdX/pXg2cHEOpqMgVEgoyN++chk7QAlIsBhT3N/oM2MJ22t9kh0iIdLX26nopYJieaE9D0l0VoWfxdbNHstap8kt6aG72DCSXSJDXsxgTZAgmDoLba+Z2d3Tw+K2HkEkt1wzHtMgEec2c1UNpHGHRQobfMq5wRyBKi4MSim3PhIdAFGDl6BXh9oXybtulF4w3CrBqFOltjLK3Xtd2Cv287i9MRVuclwxmlVxwA0+i/0+cNjZxhQr8rYHxJ1VXdTe/9H+cRM7diV2KRBcZKe3IjHu1rrshs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7+yPP2gGaXJCs/RiJxWUV2b2rTBpH8poM7dyvTu7ZuxUlsXUIsjcYXNNB9q?=
 =?us-ascii?Q?MAoftwc/GXFHRMfl8qhPRvDL3ckO47r56Z3Xuuc+k1gWIXiW6uR/ZYQjN4Ik?=
 =?us-ascii?Q?OXsHpm2WPtWHFsdWsI0kRRnEXIgSussgc85D6AkT7PYKRUFmph+9mVPqvmnS?=
 =?us-ascii?Q?LklCsWgMo8wSGSvxjrnuudSASYLAxHbxRzcOs1qi1hoBUg/+VXA1+T94DW3c?=
 =?us-ascii?Q?h3WTO33pHelaKGotr1hDr2IiQq/AjP1DKgoKtLvqybBj2k/VwziPP1ttbRVJ?=
 =?us-ascii?Q?EuZT9Z59K+WIfp0cjnw3LufkRa/YAcEvXFOjgiKW1z/tgNh5YsMHGeGQej/E?=
 =?us-ascii?Q?ZzNYF25b0ZB+yT1vce6Or9qqKJ9+QWydpo+EWGY2kEBVVY2c1owpmMr0dMHJ?=
 =?us-ascii?Q?WSsaddfEwOkfvp0/xoNZ3yIuZ+9/eJRy3//XaoVMtECBozaZsZmIv71ChpB4?=
 =?us-ascii?Q?9tNP4Ijj113E6L/JTAIcs2td4Ee4qQLopDde5i0ILaLwKURRh7xVXbRjuMtG?=
 =?us-ascii?Q?6V+d24jsZTZr6pV1KkJ+RqwfB0LI2PMQWYurQO1kzk2N2D+qUY1J2Kbv7A2g?=
 =?us-ascii?Q?j2QUSpXak7uMOptc7riOQfu8yUfuU9zzGrn1zDNhbwzVdDEaZbYerO5k6PWU?=
 =?us-ascii?Q?2gae4ZRRmLe8kvztyGkuP0b+8QE6ZtX0ro1BxnBm70UJJfVcG6oPp3Fofsx7?=
 =?us-ascii?Q?YERu6BGMiF/EDvUElCnJgyOt0CJIdjAPF7MAi5RLC3r0SP7iY015cLtUzzHk?=
 =?us-ascii?Q?tEEaoBjbm5vpqU5C/3ftCeRV2wxRwp1kPfW1KawjUplK7WMr6Hl98I57kZ1l?=
 =?us-ascii?Q?xNNbv5hmpVS+CopBux+l6/Wk28feZDoVDgPGL3Pfg7AkCWPghbFSyxxN2Kbw?=
 =?us-ascii?Q?Lv/2xtwJ38aUgiSqIilRcXUPPPFt7aCATU4+ufFgNEIe2KMjzh4zfUqNpgPo?=
 =?us-ascii?Q?mpmplUXDn8r2+EHsj2nrFpr1s86rD68SHDR5Sbc8jqKRaI28yiEMVuz9Bz9X?=
 =?us-ascii?Q?aGqc3mwgmydWZpIzCt4HXFjr1IYd+QGlWqES+LpaM00gsHcedYHLRf/xcpvd?=
 =?us-ascii?Q?dW15awk3lD0PJOYsfHcdOrXOJbrFh6QeegpARdoCWdS7bU3GteP2k0OtsEdr?=
 =?us-ascii?Q?vnQsueC362frmIg5/wRQHCepVeK3c3iF+NcmL9GTlVgUmicYqcQzXE1WOgr1?=
 =?us-ascii?Q?Jzu/Ylf7zIgpBGnfROXDJrhVxz3zbtbdaVYU4y+4ltqzcy4IbUbWaTFWQKlV?=
 =?us-ascii?Q?fvhiohwWQhlhnLLK5U1Ew5n5jTDBL9hH2wLvKPu4d8dg0NWq3wjGNlampgYd?=
 =?us-ascii?Q?yD/7Iv4M4tZ7JXqyOsUEPS8qWkc1x73r5bTCHmEuopGI21BvhvmIW1LIV6h6?=
 =?us-ascii?Q?15ZkcPYapOX8JrEDiDZ2ip7uM9QzQtEim9oAIaeysZrESlvKfU7goJN9A1lH?=
 =?us-ascii?Q?hZpPjywSK4YpzrAHTD/CdepJo2r4VOx3PTafzMrzml1BpSkNJpwrWAoRTKd/?=
 =?us-ascii?Q?QMMkLygEM3fHWS6W4EhYvIHmOPnbfhOFVVPjarjzgKrU4osivP2H6/kM6xrX?=
 =?us-ascii?Q?eySoPNVZP9vFOA0+aUkg9fsL/4W98H29x9s/RRUagrsf+/JA/9OI49Pn3VWV?=
 =?us-ascii?Q?ckoAVBZ7tlcC4iIaAVTz4nYolcaNjLGDgbGlOBy3r5AeTWvoFmcw+Iu3qqq5?=
 =?us-ascii?Q?b5kQ/CciFPqKJyls7L7xwzS/++xYHJFHic86K/VdPRFbZVU6QtkYyNP/i9wl?=
 =?us-ascii?Q?9j2C7b6pvMwR2ivI5R7rZKStFzgY6kM=3D?=
X-Exchange-RoutingPolicyChecked: gEhfJ6zUmTxgrlYXAvbBtHeBzp3bDL9HmppYTSeaTFciEZVDDXtaPNv5mlVF/vlbBMepQqXiYKGg0wunjgezGO3mRCHHpgNElrGliweczBWi8AEvOhvl3MY4I6dEhyTktmyZG9D01kvO/T2jJDu9Lr7pHXNvPSpfvjDOvLA6SYQ+C6YH2SkUD98lID9r1IZsIK+ty+vh5kilTzk3dYDtoq/TJxNhI42eCKDsIDkxyA82vXsu/ANNP5t1w4ELOERfKzYR+GIhr9772rzbhGGkLlWv76O/QMGpnRB5e4xtONdfFzDdo4NJ3eNDj4st4hGc23JKq/Y7Wr2qqS6iabPkWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 402d5390-40f1-422f-0d72-08de960dd0c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:58:41.6648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmV0BD2tdUh60EZZ02K8frDJHqxHjHnKvW+QVmLZ2Pw7bOgybAx/49E4M6P4rfAZUGABPFSuncwGd6FzZ03VZla9exc0D9YqIx6iwpUYra8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
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

On Thu, Apr 09, 2026 at 09:59:04AM +0300, Andrew Rybchenko wrote:
> On 4/9/26 4:36 AM, Stephen Hemminger wrote:
> > rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
> > buffer with no bounds checking. A mistaken caller that supplies a
> > buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
> > 
> > Add a size parameter and replace strcpy() with strlcpy(), returning
> > -ERANGE if the name is truncated. The copy is now performed under
> > the ethdev shared data lock so that the name cannot be mutated by
> > another process between reading and copying.
> > 
> > The previous ABI is preserved via symbol versioning (DPDK_26) with a
> > thin wrapper that delegates to the new implementation with
> > RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.
> > 
> > Update all in-tree callers to pass sizeof(name) as the new parameter.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> with notes below fixed
> 
> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> 
> > diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> > index 2edc7a362e..586a56bd46 100644
> > --- a/lib/ethdev/rte_ethdev.c
> > +++ b/lib/ethdev/rte_ethdev.c
> > @@ -721,12 +721,9 @@ rte_eth_dev_count_total(void)
> >   	return count;
> >   }
> > -RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
> > -int
> > -rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
> > +static int
> > +eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
> >   {
> > -	char *tmp;
> > -
> >   	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> >   	if (name == NULL) {
> > @@ -735,19 +732,46 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
> >   		return -EINVAL;
> >   	}
> > +	if (size == 0) {
> > +		RTE_ETHDEV_LOG_LINE(ERR,
> > +			"Cannot get ethdev port %u name with zero-size buffer", port_id);
> > +		return -EINVAL;
> > +	}
> > +
> >   	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
> > -	/* shouldn't check 'rte_eth_devices[i].data',
> > -	 * because it might be overwritten by VDEV PMD */
> > -	tmp = eth_dev_shared_data->data[port_id].name;
> > +	/*
> > +	 * Use the shared data name rather than rte_eth_devices[].data->name
> > +	 * because VDEV PMDs may overwrite the per-process data pointer.
> > +	 */
> > +	size_t n = strlcpy(name, eth_dev_shared_data->data[port_id].name, size);
> 
> As far as I know typically variable declaration and code are not mixed
> in DPDK.
> 

AFAIK That used to be the case because early versions of DPDK targetting a
very early C standard. More recently, we've started allowing this sort of
use, which makes the code more readable IMHO and easier to work with too as
commenting out blocks when debugging leads to fewer unused variable warnings.

/Bruce
