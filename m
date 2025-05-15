Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431ECC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E97340E3E;
	Thu, 15 May 2025 14:59:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E0C56402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 14:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747313964; x=1778849964;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F0alkjVg6j+5ZoRvEEQ3p9OYkR8SJqRV99BkqGeDC2Y=;
 b=kApJdJsZYr0fSY+otu12kR6YgHbBnMmDlFwDyt1XK1ITPDpymM8Psslh
 0FYw4rZbN/ievDkHJE8o/1XQzybQDmZ7CeXPi6dziHhsLnDQVwqTntsh3
 dSZ0FstYap+x/Rhs8WOvsFFY4/54lDCNRInkz+V1EjPPGOi4uSLKc0R9v
 RR7zCGHESMXI21ilP6KG5sUmLm0XwYipvKd72qPDlcf8JyRHfeG6Pfu3+
 kwxxL9WcYz2TVA04WhkpLIWDcTxDtVsamCOaEAYoKd/7MWzpeE+aut9M1
 Hh6NJ7gShZiWYo93ZcTi4p4DLq8+QwREry+rdwouQbn/V7IhJwka2dyKj w==;
X-CSE-ConnectionGUID: rSBZnecLRPSQJrK32pgjlA==
X-CSE-MsgGUID: Xtliof76RvOkQxAvT3CumA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60584977"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="60584977"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:59:23 -0700
X-CSE-ConnectionGUID: paFyJ/ZlSKmI3Spdu/MMXA==
X-CSE-MsgGUID: cBid3uoXRmCldkCrcmrgdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="169427638"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:59:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 05:59:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 05:59:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 05:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nifeCUTvz+AXb8qyijHBOMzM2d1HrVpOvtxNujJisERznxc/MeNUIUBDiucxjIJIgxBK5pj/Zc9+gBhFZvpdHKRFmnqbSIGHQqr36FR+TdDkUhZtflyFfJQTHrfJqdYiYtn9Y1CrAfmMSd2jK6IsgWQ773pD9/ALT3ebnVTUIrw4AnTndsrl/0Ma+n5KNU7O7KjAa9KuHPoCgr7t4LNLUloQYT5n55LsOuQuFYJkjgVXiQMA9yMvJ0J7NCHJlMLVgJK9RgHTqVvW8scyoJWPFVqws4bYtmBCMaSR5KMrOqSkbVXMC91pMtKlOb8PjtwAnXFGbS5iCXtlQeXuaBWtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTAzcNxwUksb15SyNhR0U+pM7N/c72Ii9rvxYqUoTnQ=;
 b=WS/5Nkw8Wg8BeVU6NSWP1Ml4wWEZDaRYRLKhVqKKKhp1K74pope+eXXLpkH41i3g0cP0PTwiHAFKznchW7Ft6FDYYiOWeOwqcyO+cBXy+ac+YwVzNs6bbR2xvKaIMUeHjkBj5EXMFqLev6dQJOAkDTrvZXTWbIkwvNFrPmzaF+h+H7sPWFCpEU5V1lbK78FGM4bFR1geIsqsxlgIBZuIDMnvP6a1P3DVdRBYUqidQoouQ4ocy/uX8LRlaJ+BMnzRgplGJFdkdi02TOixYs9oAtG6KO3z4pBRB6Kllk4sHG97X2Pz0NWhMOojGVRTfLjriyHwN/kWG77ln5x09/mR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 12:58:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:58:53 +0000
Date: Thu, 15 May 2025 13:58:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 01/13] net/ixgbe: remove unused field in Rx queue struct
Message-ID: <aCXlCZXL6j0XQwn-@bricha3-mobl1.ger.corp.intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
 <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <aCTFhfkYJUbYALMm@bricha3-mobl1.ger.corp.intel.com>
 <6e507daa-a34b-4e3d-94fa-1560fc9cfdc6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e507daa-a34b-4e3d-94fa-1560fc9cfdc6@intel.com>
X-ClientProxiedBy: DB7PR05CA0068.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::45) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2976cd13-b18e-481f-fc1f-08dd93b03eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iheonyiwufa+0XVO/NDlO4XMiwoGvHQ2D+beuX3YBubHH9VkVsD2cPh4K4NA?=
 =?us-ascii?Q?XWY85FnY/N0w5B8qkLG9P3I69AS4xg5f9oBz5v3Z7TCWkllA7TAOMX2d7RGH?=
 =?us-ascii?Q?2NaU8hc+AJ7/V2yN+FUneP7oKOV2tqyADa7SurhSGNEe6fs/NIfUJvoUjADG?=
 =?us-ascii?Q?0ZdRvUR+M2g0zp3QbWEXZUoFo393yhDmh/CXEcgcFeUbh0OKJyIe/hkgrE/g?=
 =?us-ascii?Q?G7oc/3/E3I2SciEILDXhcwrRip7xxMAnlqpoeXgKl5yt1jhjc4awaVAQDhNQ?=
 =?us-ascii?Q?aBF9M6RxTxBhW0uede1Qd5jiWBLkTxT9eoV0mV7CJOJqvmpJl/u7t92ptubv?=
 =?us-ascii?Q?PQIt1bC4+DoIRJG2zVmxuPBmEYNDBeWCkjMIsm6/JC4KJGIT/VH4yX7hL4RA?=
 =?us-ascii?Q?BrmLoqEpar65G9Hlnut9CJnscHAsuCArcaUVwSwHqKFkEa1SfOIRGifNwS2A?=
 =?us-ascii?Q?jeAzR4LgG1VZ+DeypfdfVlVZh8Gr2kv/yr6+mntk3YYA1KJR6TzPQb2f8iPF?=
 =?us-ascii?Q?jmDmAq9YcBcQWFjCugrPUB0xXLA+AyiGwY3gBRD4FvI2SVbv0y4FAgCZJtRO?=
 =?us-ascii?Q?oqz71W9DFGFBzvcBmhzZmACtusW7kh6k784UkPGQ81ukvTw+bbs8DUldA9op?=
 =?us-ascii?Q?XXg6xwjniPeGfYo7C9YvRBBbPzZ2CYeS+9xe14q8IJklHkWRtnjlgt504iq1?=
 =?us-ascii?Q?Y8k2goTehmAQ6xzjRiX/ZKaZ5N1BfQMB9LK0YGx6+4Ua8qVszIFLrcllNZAL?=
 =?us-ascii?Q?omIr7dgwTw2LG1FI6O87wXLR+MRQWK0HxY50GVIwwwFW3NyC0V6jw75ByMJg?=
 =?us-ascii?Q?d/e04jctFf9on5m4qDKX1bmxJkC35RT8sUA5m5C68MAsIOXNTzpl2f6VBEJb?=
 =?us-ascii?Q?6jajHXC9AtL3ZLovlKnyCb634sVXTclNHD1XWxHWKH9a9mm0bbYH4z51zU5q?=
 =?us-ascii?Q?TntOaUyPoqHrE5iL1QlvhCK81q7woNlvojdN96r+kyJsfjWRmQJIPk/nnjah?=
 =?us-ascii?Q?h95Yj4I+wEIkeGMLpN/hpsdwckaZzzTJlfNOMS3zETzvEEP/rlBMwVfCB3wW?=
 =?us-ascii?Q?7QVjUxnJcElZKdyL8fzXfg6oKZLwxYDWJaJ2NMmRX9tlzh2taZEA3iFAda4v?=
 =?us-ascii?Q?sXL2QyUk/g8bhj1EUtx7RDf6O3fpF9oHZIk88H7ggpzFhW5fNBZ7IrpkB8RG?=
 =?us-ascii?Q?pZ7WseBpg0QrE5KP/3/TXc4rv23UPRF8J8K0roPd0MfadCOckpHjDsJ85tXp?=
 =?us-ascii?Q?AA57c07HNehMGbeLNIdFV+DF6wv2RSDbPk55rP6eyFgP+5kLK97ijG5b8N4a?=
 =?us-ascii?Q?9AeqUs3707ZnPoFxAYRlyfpHx0xY+Bw0nAoefzQnEvTWRZrQD/sRBaGq7TVN?=
 =?us-ascii?Q?zgqDsgSRFSw+8LNpAvZaXeEJvTzaRPHgkS/j3fpajI4/qkCu/uq68ag+K/yi?=
 =?us-ascii?Q?vO1QROrLVDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwccxBb5vfJUVehOCnH9w29FauvFTydcK5uwurBLxGlvcZ2QsFNFDIz+iktf?=
 =?us-ascii?Q?kOokYteLcUL+hte56S8DrXMJuW11t2PJu5DoKvtr4WOmF2H+U5Kv8a6CBz46?=
 =?us-ascii?Q?+MMMuKHS6gsVpXR6kIwOqsSNzEnUfyCxNnLBso0KMyepweqpXlZol43Of9TW?=
 =?us-ascii?Q?1izwsikQoH4tH+/moKKbkKQcjQGiVJmqizkjGtYeUYSDNv64kiCwDdR+E9CC?=
 =?us-ascii?Q?oF5j6abQg4kce+FLEoVCP+m3M71CeMJSxAwLcFgsS2SB2ORLiMEEwYMNpzFj?=
 =?us-ascii?Q?LyneiJNyhcgGSnXoljrRfw334B4laiWcr9B01wmAHcId/Fl0pk4nhCVPLc9R?=
 =?us-ascii?Q?VzGD+ENtvvcKmRXfpmjJgL9NLqHyMy4NLcz+gGH122Nc4ICZa28zT8TkiV0m?=
 =?us-ascii?Q?ZpKOr+gFDgy0Jw5t6FDxKk1KNttorT3feTVJsS0ZXq/HKK2KuxRu/4uOBbEN?=
 =?us-ascii?Q?XMqSN4kZwCTopLCyQcJXKkm8fmOetnyd3B0uRQqqJBCZQhb1v1PEZF4a0rJw?=
 =?us-ascii?Q?P8nC6wZftc73ukXYTCPSQg5qKZmeZN5UBXfkUCscJ6vmQlJbhgGHeGI3SoI0?=
 =?us-ascii?Q?JDJDemazXLZPypINh5PtTEbeBzorb+O7e+ly/vxYqPEyj7ctKcOOZ/LCcKct?=
 =?us-ascii?Q?I/W1u3P3mCqJEvnG5Zmm60Mbd7YULA1jB/cygWcDDUUErYLaaDWZeIsF51zg?=
 =?us-ascii?Q?vulR//E4c8n4wv8haRwhz1wpwxM21OfIGxL6T8YYyj7DforXFngfHfiMSlmM?=
 =?us-ascii?Q?3uXmkKFF9Pbt/UetXX9dH3QXHqS9iE2VveYxm0gnSFqvQm7jARn+BLBtu6ba?=
 =?us-ascii?Q?NKMYzaUIKygBss7Tp5gUGrOJa8bvcii/Kc509EOvsVvV5HoeZL2y9YB2OeMB?=
 =?us-ascii?Q?aKAuJ0MiK2T6FvNS5ed2jfXJ+Jy2C98LlR4hrO4GoTrvZM7IJAgcMjkAtUJG?=
 =?us-ascii?Q?HwHODuk+Wh3Zxl5j2WYNgPMz03GRMJqg6j4ZRMlgB+RlrdXDKjjZNLnDtQc/?=
 =?us-ascii?Q?Gk7/TRrKiLT6Jj3QEulgtBtVrJe2F3LOUYsLP+GlFCwdKuNEymwmIj/rIKtl?=
 =?us-ascii?Q?LnhTDl4zZTbtBszQVbAhHQ/9iBStExEmwTfeqEpsE/YQttFWRzKiOfoSeskP?=
 =?us-ascii?Q?rq9OcX7TRTD9f4MvPZ72RWQWXB1Swc/rWZKLlauhbcyIcVwSuhpWEtNo6EjC?=
 =?us-ascii?Q?NlsT+C3hY0natUR9j2y8npqluCpOy0TO84gxU63tJj3oQIPz5Gf/s8qb/20m?=
 =?us-ascii?Q?/RahwkoNWbcaO6k42HHvbjy7FBWtr6alg4GhX7ppHiuvIrSYZOFQivrGMsvU?=
 =?us-ascii?Q?LPv68PUtQ7ZaCAn/v3+EPJwznxLA0ahBtchTwFyEhh9nyEMdUWqecbILWljF?=
 =?us-ascii?Q?RZiV2J6Hy7LV6LrwGTcFVZPlgiZD8DohfUFiLCR7G7D3InRKpM0jg656ceTO?=
 =?us-ascii?Q?mgKNw0SwtxOIdz6xVSU1rqXifxfKKj4vaKyNGbe2XWA/naB+iLy/xhSChEmm?=
 =?us-ascii?Q?VFx6/KXjHqVfPewyEe6rHCq3duNtjqwd7AUNntc//elk6MTZz9FotBwhKz/r?=
 =?us-ascii?Q?7Frb5WXhBBiDKp1DjOVFKEFqdWAXaTaZ3yEMqSWeO/M/h8EX996bmdqI7cRc?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976cd13-b18e-481f-fc1f-08dd93b03eab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:58:53.4069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9C5sg7FTQKKovUYCG9ehmdZU66lpUl7+k0d4BFMN8a/jJavpvkyUZVn7D+vCm0wnAJ8BioZpMt9ozpu9IFCrjxuUvItLCS/KPX5Ev3oOZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5296
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

On Thu, May 15, 2025 at 01:15:43PM +0200, Burakov, Anatoly wrote:
> On 5/14/2025 6:32 PM, Bruce Richardson wrote:
> > On Mon, May 12, 2025 at 01:54:27PM +0100, Anatoly Burakov wrote:
> > > The `rdh` (read head) field in the `ixgbe_rx_queue` struct is not used
> > > anywhere in the codebase, and can be removed.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > 
> > With the one comment below fixed.
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > 
> > > ---
> > >   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 9 ++-------
> > >   drivers/net/intel/ixgbe/ixgbe_rxtx.h | 1 -
> > >   2 files changed, 2 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > index 95c80ac1b8..0c07ce3186 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> > > @@ -3296,17 +3296,12 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> > >   	/*
> > >   	 * Modified to setup VFRDT for Virtual Function
> > >   	 */
> > > -	if (ixgbe_is_vf(dev)) {
> > > +	if (ixgbe_is_vf(dev))
> > >   		rxq->rdt_reg_addr =
> > >   			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
> > > -		rxq->rdh_reg_addr =
> > > -			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDH(queue_idx));
> > > -	} else {
> > > +	else
> > >   		rxq->rdt_reg_addr =
> > >   			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
> > > -		rxq->rdh_reg_addr =
> > > -			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDH(rxq->reg_idx));
> > > -	}
> > 
> > Unrelated code change. Please remove from this patch in any subsequent
> > versions - it's not worth fixing this unless we are otherwise modifying
> > this function.
> 
> It was removed because we either keep rdh_reg_addr in common Rx queue
> structure, or we get rid of both the field and all its usages. If we don't
> remove this, we'll have to include rdh_reg_addr in common Rx queue structure
> and since it's not used anywhere except here it would be pretty pointless to
> do so.
> 
My mistake. Yes, this is a proper change belonging here, sorry.

/Bruce
