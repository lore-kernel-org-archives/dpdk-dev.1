Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF2C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 15:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D078042796;
	Thu, 12 Jun 2025 17:48:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 79A9442789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749743339; x=1781279339;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5/Csg/l3PmZ2Vab9KQ+NioDoN2GC6OwEdebcQvVGqwI=;
 b=NG1BAhGuCWHv2vXImGoHN/bUCg+6W8aiJy9MHHVfO/aYPNAIjCUrtcgC
 S22JxS1wQFD9C4bwLp5I935rhBaiIFJPnQWu0PyUyGmsN/C6CPS5EJWFU
 j0BMcrdaRQhfJOvut1OqYYhHUmM9k1u3xF17U+xV8NCFwbLz4hQlqCYaG
 xjAYIIjV8Ogpl6MdGbLH0R7PxW76WZWsgS6Sz7zdp1UnD4/KLkDS8de+0
 /k/fxwHHvuKMlU73zk3eeH9n0WlZUPUWTKMFdA7unvIw/9COsvWNzu9Ek
 /nWemqC5R2fLeu4S0LoFqBLknSH7r0/NcEFehb0ZHSSWXaFiiJvz4SF7Q g==;
X-CSE-ConnectionGUID: ENZLwl4wRsmIemma3J28Xw==
X-CSE-MsgGUID: Va7xtB9OTJa/fxlUnKp6ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="63342555"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="63342555"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 08:48:58 -0700
X-CSE-ConnectionGUID: EE4b/kZ7TXGbZLaYLcrWKw==
X-CSE-MsgGUID: ujZFegYLSLuIma03LHY5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="152848258"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 08:48:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:48:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 08:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 08:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwkZIJgOoeMJ9wSxI+8vxdK32YJOTVOq9tUeRlXgCxQR0sCg5B8QJ2PMAQECrbq0AwCkS02FbFcoYBJ4dzUsDa3dvIQFF09r73BT3ZDbuKf8JAT4FIbj+XNujA5eAK3sMIRXcYvC2qZUEI4QvHSvSiNBx+7b9W6x/Htl48FFYT4IaSAFF2JArkl4axF30eYCc+0dNpc9XYP0uiVMPPvgsr1Ed+4nVhHWDGfeRlUeGJyfQGZgxvOWQaQXAQqC112FxuXhjn4R0EgJqccyGrXvUnDcHDtmek7jxptjI97cJ82lChx2DK4SVRdnl+BEjpgogWaWuBQepZdEQV6stXsYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAsgDmTt17KUiMHY1EuiHp+ep7gJRAX1eLXHZ3Pfiuk=;
 b=rdIvX8tXes7LvpYRZfJVset4XLuG7xUIwGgdqwjjGIuSgeX4uyv5MMUA0DETqsGyUrWfxl7SMUaP7Kfm8UYlxB0jwGHiZUaeNaO5uQ4X+T35zVbzMniMNOc1YP5MTqrvWoQxd9XdFVL3hB5ORLhPVmk7H5WhB99sgfWsgEyXyavkJOIMkoE4ckWP8eUNC2hejqEwbBWOR7kbVsoYsBQiFfXIS3/mjgQVq8f3wRdsT9DztOYcMUGrbJR8Jv2lbtXT7eOgusctlftet7prQB5ErvF31Io8mdy4C7OXJEUQZD8Wcv5DvnixMzyWDJyStHSwcAMokz6baeAi92BVho+cNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF30373102B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 15:48:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:48:41 +0000
Date: Thu, 12 Jun 2025 16:48:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao,
 Manoj Kumar" <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v4 2/6] net/intel: add read clock feature in ICE
Message-ID: <aEr202MXrf3Mnsm-@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
 <20250610131159.495566-3-soumyadeep.hore@intel.com>
 <DM3PPF7D18F34A1A5202037B5AB7DC9F6948E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1A5202037B5AB7DC9F6948E74A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF30373102B:EE_
X-MS-Office365-Filtering-Correlation-Id: 04639cb9-97ce-48c0-9e80-08dda9c89a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gx4lfrj4zjOMwVHfzirYdEYqys38f5LmURqRrkdIQXSrDnB9DWPzkqvlIaLY?=
 =?us-ascii?Q?tDNwZkTYl1/4TCHE3T6SjQZRSo+rM8pLIk7IMLUUPBIb98UAfQ3/QkMY5P05?=
 =?us-ascii?Q?SKJVjLiSEPMHJnmslRl91LuhMkqtcchpeXhk4833RHeqi30YXBMc7cKDK1Ap?=
 =?us-ascii?Q?fBr5K/py7lEojOtb2n4Kj1SF71qncLjj8pez2LprgR1gDlSMpVFFoOUXkttY?=
 =?us-ascii?Q?d7On1kV2RfvVpaoZGtqQw5P86Q8IUTSVicwgkJ6e1sxsunICFZdAyJYIRp83?=
 =?us-ascii?Q?qHFIPbROADDhHuosshuYiFmatwbSV0lifU6rS6wGZdzvZRZ3FdtdRl+nIFNc?=
 =?us-ascii?Q?24zsOpTT/CH9idzPaMzrtRRgk8zWwdlP4fcm2i2VUNJFcAN8k5gg0DLwEq5F?=
 =?us-ascii?Q?syWYA/nDgbnL6h9Ba+5Hut2tdNEi4LFOl4ubxnkV0sGHWm+dfiK6KourxBHV?=
 =?us-ascii?Q?2oJiPeOoaZqFnHTL3pYNZO5g45RDjnTJCgV+mBPcvOqz20YeiwNJp8BVz6za?=
 =?us-ascii?Q?zl44BwF3Xa03UdDM/ocfl2PhLgWgrnkChIV/Zzxqz7oWXnzNg+v1lC8frhXh?=
 =?us-ascii?Q?/TW73LmCIjs/roHNhUuTsvFBT5znbHBs5ni2Qy13VBwGWC0WQh60jHsDKV06?=
 =?us-ascii?Q?X+RPeAlUGCsEBmrUKHXA+6zLZd2jgTfe1cBO1b8NkT4+BP8Kr9uzqMTG+3Nv?=
 =?us-ascii?Q?kjR8CUNRAdfO1uqC7f0i6YhkDegyMsa3Jtw6yZJ/pfKGzIt8gFr/Wdrl5g7w?=
 =?us-ascii?Q?ydzaNhCH2mUA6NvYc31/kiI8SJCo9NuaQwiC82s3hHrghk3sR32xMhcV19f1?=
 =?us-ascii?Q?fpofz7Lv8zk50yyLPCHsGr/187oBGDBI5u88oEYyUbjAUlTeM9kzYdmCbiUq?=
 =?us-ascii?Q?+8cqYx+pq7Lb2JxtQxzsWCRDcfdnHQ4Nvy6Y2eS9cDA58IOR2zKUKM0ugMev?=
 =?us-ascii?Q?1VpD0XXOUZLB0UZ1ujmbZICCbsIOUtNwr5bamNZBtExVKKYpaQNMbVBIlHYO?=
 =?us-ascii?Q?NSZMCbgs2flcKkWux0pa2Eic9qkXLfJg3N4ZgoNeb7grwSStpGgjhwMIzzGP?=
 =?us-ascii?Q?m2MmX+Ds5Zls8W/c8UBiCGjMWgwv3d0Y1fVMm3kGUp0ZXpxql+OKIYURQA4B?=
 =?us-ascii?Q?wuHwPTmLBhaxmwdMLKj/RB2cMAuSevxiWj5ZnJZJD3rgWzEsFYJy4jfPCSbk?=
 =?us-ascii?Q?yeO8WYaC2jNvEu23VdWfi7qlVZS6WMNsEKm+aKfycWQrv0djQlmyHzNn334T?=
 =?us-ascii?Q?sIX7UAeUsyXzc4PjZB1v764/OX73KVB9L37vnyjwXTRuz/emTNI18QEtbAB9?=
 =?us-ascii?Q?VY3POnt8paoUylcjtniOYZgV1fr7DT+mOEzQby7rEwdWDOAL7kJ+UYN3npZs?=
 =?us-ascii?Q?RwpKDMdT8LL/ILDimuqLR9pz0oM3E6rx7+eh+p6OHc3szkgTGiFElC9tkNyx?=
 =?us-ascii?Q?9IkTYphUVTA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGSajyHYH3+hktQHFcqRx2VwttTqnnLZDGaJtHsSGDmZAKeOLa3pp175ZymT?=
 =?us-ascii?Q?7R7GI06Ihz0hvQsVc4dJ/d/pEvup5+AOh4rDcxwBTUHoUbixuGarE6ELD87l?=
 =?us-ascii?Q?vjaziGSpuJr+9ghmA/xpnzUsaWpFpvqqNMVDRbK8Wc3VMsoO1BBiJAr6aSrG?=
 =?us-ascii?Q?IQ87lKFwFeN9fGZZdwrSATtaaawdmcN5ijAJx+uGYVotGDp92tOrXPJ+bTol?=
 =?us-ascii?Q?zUPhONfq0I11VIlPNcyJIYoM2K8zPDBbYPjQyuKzShfUpONLf8LavkuA+Nvh?=
 =?us-ascii?Q?Wxl4xzdM5m4mqNnP5j7V2tfJO9lK54MmlLG94z9GZ8qmUnh9ATM4ObekFY2v?=
 =?us-ascii?Q?ddErkcGGxVASJ74tzxV2GlaHcw28nnCqlBcTuwz4KqSb+06dw2hxWJhH30g1?=
 =?us-ascii?Q?OOglKxcsiCYECCZe3T7lB6+6bceqEVnhu1JwNWni04Jig/yXREf+VZ0SGhwG?=
 =?us-ascii?Q?I2hn0dk2xektNkYbN6K62SfPcPFDGix0C8crf4litIrX1BpTvMuMDOK/iiTk?=
 =?us-ascii?Q?WOFNOTsVWKooLCRpHSpPOFkjQjwB1dqvrfgjQNhvBO9p5XAm66p+tUDq76nO?=
 =?us-ascii?Q?mpL8WN70n18pFY6oKMitJJfcTHnz/lr5JOHYiF7qnS/3QUJkwADgxntvW85z?=
 =?us-ascii?Q?VYEduzcrD1wCRcm7CBmaeFqVOG8+Cc11pjYmEXYbPeGI6DaXg80FV6vh9ToE?=
 =?us-ascii?Q?aosySWq8Ri7SD4Can57xg5RIHdfwxdw55/LHte3CnMyEaSPYZIeM7ahAyr63?=
 =?us-ascii?Q?Z5Py77qayNsGnoUapCIcev6JTujEDq26YtegkdA5E26CTUWiyXjhH9Let5Af?=
 =?us-ascii?Q?fHudhJMD97+XngLYQynC1S3avbnULM+Ptvco1cE5/lYBksWduh8JcIl2L0uL?=
 =?us-ascii?Q?oYJ7VJ4rCponw66+giVgerWUJ60+lkKSbEZk6EzHbKOfYjb9A9Gk2oqDkSQJ?=
 =?us-ascii?Q?UPOEeIouxzRgC7+PKC2lOHopurTYZipl9hqYoF9qrsgycoCeh4r29q7wcLsn?=
 =?us-ascii?Q?IS4Rn9UyvMnUJHFXlmkS7Q397KT/eWOgx+VwA79GyhFVWuHKh86yNIJGaWCE?=
 =?us-ascii?Q?1AmEKXaW4qwCNmfL834CIczzXHsPVdUQTQKmb74NNeFepMxNjQGw8PfClMQY?=
 =?us-ascii?Q?9FnicvID3+8Y64QMslwVq0Z4Mxe2H/BMVzn4SXf/+RJLBYLbHhx57NHjHhNr?=
 =?us-ascii?Q?Te03lJfbvUVOe+G3kuO42Jy2Rh5u1Uqz4b6gO8d4IRMJ7Qdw5ClO9ziME/v/?=
 =?us-ascii?Q?fXbG78Eg19RH2hhc5TIvl1g/sm1v2iJkqvdLRgU/1AGUIdeA0J9d8XnmdIH7?=
 =?us-ascii?Q?DbZXd8PyPE93ze0LiQornvecHQgAbNyjlpHbCNvUQh77/8HSWCcy1qTOetXg?=
 =?us-ascii?Q?AzeQB34kEV88oh4d7lALaO3rRKe+Fi8VcAbPJIvj7K82ii5ojhouv9bc2G47?=
 =?us-ascii?Q?eJZzeArbaWy9+Bs06BnezsxCvkykb2XBhmncMeuQxNy2MZIgJXVP22fbiV6n?=
 =?us-ascii?Q?YabS0bwg4D17gpbkgyQCn1QVKxRSlEUGwjWIR+EjwqQwHkOTcBwGf6LkbZoS?=
 =?us-ascii?Q?NFaYl7rs4IlEShUlBORuPiriqgGhNdi1G5DM+n1qzzM7KZ6Akklsz5Ep9t6U?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04639cb9-97ce-48c0-9e80-08dda9c89a9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:48:41.2285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQAajtRqa2/INH5mVHwvai9hPU1JSUD7GJjhFtMAXpp77HDbJ1X5pXxZiNOEotlILoY2l14tcgKvoh7rcHaHkiBqoOrF/1/he+Aa2fXNVDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF30373102B
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

On Thu, Jun 12, 2025 at 11:14:30AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v4 2/6] net/intel: add read clock feature in ICE
> 
> Since the change is specific to the ice driver only, I think the title should change to "net/ice" and you can drop the mention of "in ICE" in the message that follows the colon.
> 
> > 
> > Adding eth_ice_read_clock() feature to get current time
> > for scheduling Packets based on Tx time.
> > 
> > Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> > b/drivers/net/intel/ice/ice_ethdev.c
> > index 7cc083ca32..9478ba92df 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -187,6 +187,7 @@ static int ice_timesync_read_time(struct rte_eth_dev
> > *dev,
> >  static int ice_timesync_write_time(struct rte_eth_dev *dev,
> >  				   const struct timespec *timestamp);
> >  static int ice_timesync_disable(struct rte_eth_dev *dev);
> > +static int eth_ice_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
> >  static int ice_fec_get_capability(struct rte_eth_dev *dev, struct
> > rte_eth_fec_capa *speed_fec_capa,
> >  			   unsigned int num);
> >  static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
> > @@ -317,6 +318,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
> >  	.timesync_read_time           = ice_timesync_read_time,
> >  	.timesync_write_time          = ice_timesync_write_time,
> >  	.timesync_disable             = ice_timesync_disable,
> > +	.read_clock					  = eth_ice_read_clock,
> 
> I suggest following the naming convention of the rest of the ops here. ice_read_clock instead of eth_ice_read_clock.
> Check the indentation when you are reworking this. It looks like tabs were used instead of spaces ahead of the "=".
> 
> >  	.tm_ops_get                   = ice_tm_ops_get,
> >  	.fec_get_capability           = ice_fec_get_capability,
> >  	.fec_get                      = ice_fec_get,
> > @@ -6935,6 +6937,17 @@ ice_timesync_disable(struct rte_eth_dev *dev)
> >  	return 0;
> >  }
> > 
> > +static int
> > +eth_ice_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
> > +{
> > +	struct timespec system_time;
> > +
> > +	clock_gettime(CLOCK_REALTIME, &system_time);
> > +	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> > +
> > +	return 0;
> > +}
> > +

It's not clear to me why this patch needs to be in the set, since if an app
wants the current CPU time in nanosecond, the app can do so directly rather
than getting it from the NIC.

Also, is CLOCK_REALTIME the correct clock to be querying here. I would
think that CLOCK_MONOTONIC_RAW is a better choice to use, since it's
unaffected by system time changes.

/Bruce
