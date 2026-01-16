Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF951D4898A
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 11:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC17E42DE4;
	Fri, 16 Jan 2026 12:52:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 10D934279E
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768564364; x=1800100364;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Bh4K56SyoWxzLquUC/PHodJkkZfXImPwvYzjeQYDI70=;
 b=JQOkP3+z98s9W4mfntN7gbfFst/hNCrCFtCdgwG2gv3QsvYLF666n1dP
 xKdR1H9ELSAp0QMM+EO9m1ye4GuKcj8H3yGOSGcb3eXMQW3yx7+UHOxu7
 hmtxR5cSK8OGZi/oG/oc1Ci0J7Vp/U+T2cmkt6Kzx0v9wN+/A59nDSU4g
 PUR5xfunuf8BV5YLgaq2ox4xVRL/gye95Tt5KjqoHadtCc4FDo4SkFeUA
 64sPvOING/jZ0JO+9fwqq1Nk1RW5P+bJRSxKZCacKaiHgDwdE324yicw1
 6To3f6hZuthrrfd+Uvb/tvhIulx9YWg/QWABQjrBf8S1wF28PToK517jQ Q==;
X-CSE-ConnectionGUID: Ern4crFvTUK+pEMgQloWww==
X-CSE-MsgGUID: bWNpqk8RTVmt4vmqg2HvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="87297057"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="87297057"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 03:52:43 -0800
X-CSE-ConnectionGUID: Nixn/Jp0TFiPNHr1U21HGg==
X-CSE-MsgGUID: +TYlFk0dTyGM8paylEuNDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; d="scan'208";a="210249470"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 03:52:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 03:52:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 03:52:42 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 03:52:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBHGfY/Q4xhtetX7p0rKd0HttqyjcJn2N7rMu1HpcERYV5IiL9AcZgc2WvA4ALWg+h3Zebe38CkHjeZKxbUxfXJPnx2cyuw1LqTRbUgrd8cXEq7C+2lv9sYL+WGiDf+7EyrkvLqVvxYddeD099kFoPNqHzepAbHiGGvJmbSB8jNqcnnMGUKF8fbRl5VwOI7QusqswQW9WlJQ1qqw63dVFvYnqGBVoEflGnJjRTf6MnsrecUT8Y76FVGg6mnL4HKyrasE2Fg+TDPyIolj8CIpHpOJ+eIVizLR9n03rYHZ1++F/ggnR8kbc/EMd0+HEkIQNSOUHDc8PedNMQlkL2v0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C86Gvm45IOjr7ku7SaJG0vKLuTcW5eCGqsS99Z3/To=;
 b=i2vH5sbO7xD15QdKGIp+NOs0onS8A7J7zBzWUe0c6SE7ad7F5B6ywBAah6EK0MtjBXZr7BzSUbF0EQ0s8xbe8+agmv5mi1voImc8BbjKDgaHQZfDOXIXlf0byR2Z16MI3HgqMBD9dxkH5rB72UAtxEB0d+OwJPWuULxpH/1PiMZPj+FMrmjawu+EAOvT+LF++4Owtw673wgqiY+sm7uJsBUkWM+1MOSMGNlEzKH8WSlRxCO8dDQxQoFSg/1SKh6DOwwTDjQFozdM6ojMOLn07c2cgAzkuLr9Z+YiyuEQdAdjqtOaE2RzvF2IrOkb0beQ92Olba+lG2fx4T86ExoiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 11:52:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 11:52:35 +0000
Date: Fri, 16 Jan 2026 11:52:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <anurag.mandal@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v5] net/ice: add MAC anti-spoof option
Message-ID: <aWomfnhNOtRDtAn1@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251230114828.6156-1-anurag.mandal@intel.com>
 <CY5PR11MB61160E26A3AFEA280405C580E486A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65625@smartserver.smartshare.dk>
 <aVu2BltXSe6IlDaL@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVu2BltXSe6IlDaL@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0219.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b62d9b3b-2efd-4493-8eaf-08de54f5bd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bUBJ3ZV2KgJgsWNcEOGHyPKoI/h0Sj4PkXrAk3hD52QiXZI21OhGha7ExU?=
 =?iso-8859-1?Q?TCRbDIxj2Gluu4XNSjVfkqRcYiGT8TM0ofWcgAr44OWwrokppsxMjxJUTC?=
 =?iso-8859-1?Q?tUSZ1HnpfOYh8y+MiUD131W1o7IpofsMllbVq9PgpbaLlbCjfK0vqwZfni?=
 =?iso-8859-1?Q?ccGklIDpZMyNy9qjs8CweqXbJUsbt4nfz2LFsyPMfixJLmNfj1Mee8Mq5a?=
 =?iso-8859-1?Q?kvI9uKROW9v/XEoWbTJ+0NSp9EyVuiaBqK3c+pFHm7Ji8SB+EVBiNB1nOr?=
 =?iso-8859-1?Q?DSmlpfuW5rb0lXt0yYXfFpmKVNQ0/KbxqamqUeJ7t4VuiYXQzCxU/TThpQ?=
 =?iso-8859-1?Q?1On5gGqHbkQtljRL7yiAKXkahxjuIqgvN3S6XyxpK16VwFbPy+JTLcDtC+?=
 =?iso-8859-1?Q?/54SxjgOiDHzXsinFcrOXOMiVKcsnC2M7/DSsMQQ0Mv3jt+MHFRnfOQTaq?=
 =?iso-8859-1?Q?c3PV8CsNhoXZ33JYNYRs/nwhUyuOlF8y49RVk+EDGLC2cUUoEbenWUf8J+?=
 =?iso-8859-1?Q?YAeMq3WYZWJ0uRIK2eXzrfIfyVPCUTdstXfBGie9zuNYODHcrtf1CBDOCj?=
 =?iso-8859-1?Q?0jS6eiSzKlco84JXoJ3/SpG3cc8okWL2QDvQQGNjgod9vM1QMNjCp5yLdk?=
 =?iso-8859-1?Q?Mgy2mEgpSe0JQMNmuTkYh3ZjoOWqijBGvAROr+HLr0w52u5ixxlOYVeM4k?=
 =?iso-8859-1?Q?ZQZKFqt70zmuj6OfX5v/lqlehzbQQf2eekhGK5pkL1KlWujPEn4WUuqLuY?=
 =?iso-8859-1?Q?CWJC+hro+BXKCnkK5OqdTbxVyOo7D1Y+674Da3fAGesYSjhb+Rb69lpOBY?=
 =?iso-8859-1?Q?MmS+SfM2Zg+BjEgJsnYZ650jBcr6HSv/2pruBI/Lg7enCcW0bcXllsHvlf?=
 =?iso-8859-1?Q?IPDFL5+fA1GdYSmc2v4u66h1OW3Jge6ilN1Sg4UksityeI+TLmhcZs5w57?=
 =?iso-8859-1?Q?XtJBaawouuWz6sP65CQj++jjfWO8JxIvogEsJKq8PpapNxhCMnjIqivf0U?=
 =?iso-8859-1?Q?tXIDw3RQmjscUypvtHc0v/UgNc7OF+mBfnDMNCqDkVa3FTtYyn8ZWwSRjM?=
 =?iso-8859-1?Q?r8+yeGHlGfqT4i5Y+cjpIaAZTAExzCpAlwvcHKRwkLsSPPpCBd2mjJov+u?=
 =?iso-8859-1?Q?MKx6QqmuVG1eVzCDbGrRtdR1RjfSZ3GpZ3UeGFCCdUsB3HW0UHIBwnPkCK?=
 =?iso-8859-1?Q?cLWPf4BmuJu+Q9kxAJDm92FTo8wdfwNN+p0rO4tiOFAo7g5mKdcXbf+g7p?=
 =?iso-8859-1?Q?Uj8NbHCjXApO9sw5Jh8PbY1bGBksZXg9OCVsf9tHCXoGlxtFe4m4mmSizD?=
 =?iso-8859-1?Q?MGE6gJdhX3BDhOmr2lkffaam3+7TKqNkdo4nlhhnBsa0ZIVF9fSmWC2Jzw?=
 =?iso-8859-1?Q?5oRbjvnKSv4PK1VM22ke3RiuAyLg4K+Vb31uoqkK+zJ2l6hVZvskc9aTbs?=
 =?iso-8859-1?Q?aFpqAiivzprz4ux2IVSYfLsKEg++Sq6VvwBai7U9e5myVlTIpKmkzeXNwK?=
 =?iso-8859-1?Q?UBb8d18sLuDCpg/eV5Bvo+XpeJ+/+BgZjPgZzhgMwQoWL7TDnOV8bQ8fkC?=
 =?iso-8859-1?Q?CMF29/AtSvuTn+SC1VDwaaBm6ylLvndefJb6UgFas2fNVNOlyNj8dOmeet?=
 =?iso-8859-1?Q?Q7732OuTjUQ6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sx4qNLv27f351LLDe/a/SunjG2urOzTPsxmAOsTDvXIQf7MB8lrBpPUOaM?=
 =?iso-8859-1?Q?a4AGeRWMSnE4Sov/cb36yj791b+w8xQ2Nh7wuy3UNXZLfdww1fkFW7aVoD?=
 =?iso-8859-1?Q?ic/fNpIlyX+1/NAGiZezp3o3vXmNznmriM1fv1nZ6FN6vKw0gzRxNHd6p/?=
 =?iso-8859-1?Q?nlUy7Tx94vkMVKro+74Udq2OpPaS+HPEnS62iHV1xuIL9QTEEcO7p3wRJE?=
 =?iso-8859-1?Q?9b0A6WKyTEhDwy5Rug6E350AHGvd85bM3THE6kjSU9u2e+lldzcoSNNR3F?=
 =?iso-8859-1?Q?iYItRBA9u2/8KHLqyvkNT8f4IyvLFntUkhzDSqLTiMf+FZjp53/uweBDi4?=
 =?iso-8859-1?Q?kEBj+YwiT0tork3HddEnLOY3a4QbjWq40lQuBhu2FJImYiYtL7lo0wxjox?=
 =?iso-8859-1?Q?qLphKwg7yKTPrPBADjFnVV43R7gvw+oiSxMKnMQx/0zfxCQqFNvrNAmXfk?=
 =?iso-8859-1?Q?tjd96klDFZpDtHz3zO1xRcHhYqXdbNOgu6x99Uhp0ArfWUsyB0MEzoHgQH?=
 =?iso-8859-1?Q?dW5aCRGB7Irsen+82sWWHAE4dj5/0oX7GhJ0/SanyBMSKQFP9UoBFL2lGh?=
 =?iso-8859-1?Q?t5W7Rt/UxcTveQPUVzd1t35Hg0yjw9gyPc6pusaxFF+zmak0g5pPXrIDzu?=
 =?iso-8859-1?Q?97GO7kxpY9qx6HzozkXg8VDWFMGXSdMzKbbzSHCdXlY4aSH1X3p0M82KPW?=
 =?iso-8859-1?Q?FeiTgE3XowauLW1VDa0Tk0aNJa6uo1X25ydBMRVJTfAYP9u72LwvkE7ZWv?=
 =?iso-8859-1?Q?JkgaIou+2vEJ+dDtooWX+Rw/KlkvvNHLchkiYsvhgHW6m0YnIKpn0MA2dx?=
 =?iso-8859-1?Q?MF5Mr0d1QntqepuLqlJvRu3s9mFKatzcC8Piap58N4MTDyxRnLnJ5ffCii?=
 =?iso-8859-1?Q?MYNDfuOLxD7SOy6+UQElrxX+Gx9p/sf/t69Fu+jFGlOemPzfOkJ5rdxXT3?=
 =?iso-8859-1?Q?y9Q9b717eCqD7UvbF8S+cTWJbf2xoSVPS0nmVxzuFfAzYHDLUr4vcU8Qmc?=
 =?iso-8859-1?Q?J67dYyBQWnFBwubU6uY1D5ZyarRs8lFtOfzQ7lBx13IVu3Z6X6UFJ/PIr9?=
 =?iso-8859-1?Q?CGMeetZbsDL0wabVJ1k/k8MLuxwlvaM5alXdb2DX9zcerwfhIXbsGCl0MX?=
 =?iso-8859-1?Q?LmueEFzcl073VYdKRPGr7jDNSR3zmTM7FhMAzXYBPCXbe/wiePNV9afyHA?=
 =?iso-8859-1?Q?8h4wbdvyG5DHB4RF6yIANGM3MB+N6Q91j9pfdasXlnlxeQ3OIHUThygLIi?=
 =?iso-8859-1?Q?DNfpTywjh5JA/HKEZQtn3b+piMFBytyrDThQLERvYneNZhJtfkYwli3FP7?=
 =?iso-8859-1?Q?MFzq42AKi0A1vF22J02BsA3HYUK6wLTkQjRQXToVyF1opMdLjOF3QYpjjD?=
 =?iso-8859-1?Q?8jnBBL2jIQKdfCJRzPdFvD55COX4uBaQxf/4mirlB1FnqyP1V6IPvg0O7h?=
 =?iso-8859-1?Q?O7+xB5bB5wVOdYyBQhf06Wb3birofgWtBX5J/07siZIk2zuxTP9aaC0bfT?=
 =?iso-8859-1?Q?6muAGX8zkfBAM/ccE0+nE5gxMcl8LXJGQOV/iWOY3O/bJK/B2zOlNBBuQ2?=
 =?iso-8859-1?Q?d3FODW1WZkAg2UOtSQhHq1pmmFcuZq/P6MaogvOkr/W0IXmaaIPqRN/kAy?=
 =?iso-8859-1?Q?FHUqs3IXvEp4skNk/4zswQTw+sHRULlgyXQnvOj3ssIp0TYSRn72yX6y4V?=
 =?iso-8859-1?Q?CBkmN+gleQQCspy6MlZUw4kPg64pRym4iq+DEk5x80wNbZO2wSajg0LhGd?=
 =?iso-8859-1?Q?Tw0V/gwUgkbNBuzWTEGViyh9GMxU6LwBw8j5XBGdOgjQZ9LiLs7rCQ1B8v?=
 =?iso-8859-1?Q?v4Lj+EJUgoS32MdLWbTQbp4flQ7IRQg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b62d9b3b-2efd-4493-8eaf-08de54f5bd0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:52:35.0912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLAWytU6BqLr4f6jKhXpDPQe+bnWnFsFIAQvEVSrsvUXSvQCEwpm11zVxeWxCX2lxQeqo6/9E2F4J+JTt6x1nV21G6Vf93bzABCrc8ZoAoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
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

On Mon, Jan 05, 2026 at 01:00:54PM +0000, Bruce Richardson wrote:
> On Mon, Jan 05, 2026 at 01:48:22PM +0100, Morten Brørup wrote:
> > > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > > Sent: Monday, 5 January 2026 12.31
> > > 
> > > > VRRP advertisement packets are dropped as TX-errors upon transmission
> > > > from a vsi of ice PF due to MAC anti-spoof check, which is enabled by
> > > default.
> > > > There is no way to disable this security check in the Tx direction to
> > > avoid these
> > > > packets being dropped.
> > > >
> > > > This patch introduces devargs "mac-anti-spoof" to allow user to
> > > disable MAC
> > > > anti-spoof check. Disable MAC Anti-spoof check in the Tx direction to
> > > send
> > > > outgoing packets even when their destination MAC address matches one
> > > of
> > > > the MAC addresses assigned to that same NIC port and avoid getting
> > > dropped
> > > > as TX-errors.
> > > >
> > > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > > ---

Hi Anurag,

can you please do a respin of this patch with the few things highlighted
previously fixed? Specifically:

* Remove "disable" from the doc headline for the option
* Add a log message about it being enabled - though I disagree about it
  being a "warning" - I think "info" level is probably sufficient.
* Put the log message about anti-spoof and source-prune on a single line so
  it can be found using "grep".

Thanks,
/Bruce

