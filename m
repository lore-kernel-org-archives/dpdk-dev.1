Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E9AC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 11:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6642C40268;
	Mon, 10 Feb 2025 12:37:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BF80540268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739187422; x=1770723422;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gIbpVOwk7JkNbmsLEzsOqs0hs6AG69hUHZ1S4/Wtzkg=;
 b=avKx4TZ8TLjj6/94GjxvCL1b8KLOz+gPGwCYiVSYB7AWswWuy1ALEYMa
 N6jUEYJIWrzfmbBxRfpb/9E9MBuyO0jr0FVsh1SWCei+aM8gjl4G5s2Ay
 KF0erW/4RAaZ8DH6hS/TB6vWHC9rew3PjpkZ39EVGAYkAAhXInmRKipPM
 8uiVuPRwgrLNomOBGwMjZrsWrHi7CN3ot+kcFsWhswa0jLzaBhbD47ulR
 rA4VwiJsHw2wyeyy1PafiyKl3DNbpIkhx15b2DeLb/Y5fa9WBtGaJaJvA
 nb6EXVyQKb9aDqzTjFcy6iz6bBDmih90+0TpUDaifSnq74BJCn6ygzMbW g==;
X-CSE-ConnectionGUID: oBCHIpHxQNyVt3LPlpPJrQ==
X-CSE-MsgGUID: t/bvwXHWQiel40G2bcLLoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39675885"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="39675885"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 03:37:01 -0800
X-CSE-ConnectionGUID: a0+B0vdgThuQm/ZsAhniLQ==
X-CSE-MsgGUID: mPlyufu5TQ6MWCdCd45Z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117101212"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 03:37:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 03:37:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 03:37:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 03:36:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0j3A/R9CZPP+XSv7rS6McHs3Ev2nUcBZILaGk5dvg2j3pnSfNiD1grZ3w0wix/phKGYyG4MomlII+TwPdlTTHf4Eat5u77YryU/4VdW23o+Ri5RMeAr0vR1ST0xp7R1vBD1sUmJw29TgtG4dtdK4U3L4mnhpInSoLtN/vmnPk8/YKP/9a19oKokhK9n4ezXT6g18340W4Jjps0zRPgoyok2OYT3VbWMSX0jHnb8m5ZdAHNIeUGyHNEG7D6MDbJzgk+AxzDnGnP4wQLKZ2dlEgocfjQlbgQeY56k9c6b7p18vR6pSdBfUczr3Uz8umHYLRC9CHseFDaKx3YuxHj2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOe4sSlG+xw6sCCDvmnjuJzP7ENAS49a9tr9eOWLpjw=;
 b=qGVl0P5wK++v6Gw+tng6Nzh/8tW/IVz6GXySDG+TAHZT5FE8ZgemCSn1lHOSbTzlfCMPeQBTwK4q29/rdejTZbTVOc8mg9T72nLTFm0DlJt0030n+cPDOnU/KsQuBRNL6Cr5q/lg9An2aIpqvOI/bnjRVQAiarBNGHMh9F8JaH1M6blRVxVWxwca87UBEfXm34nsBfkrCOF5UNXy63bU3vkeHmuvuzVn50Lqcv/f78aKdY/Dw2afreTXEH/8UZiIwW2URGzBe4yQfoTWckLylh4GKbd5lOsvg8lT1iY3zj9D6aPKStKskM/Jvnh48HKSaa/Lw3b4+y1bgCyV5q231g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 11:36:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:36:39 +0000
Date: Mon, 10 Feb 2025 11:36:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <konstantin.v.ananyev@yandex.ru>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 2/2] drivers/net: fix void function returning a value
Message-ID: <Z6nkwVTdXpGfjrcr@bricha3-mobl1.ger.corp.intel.com>
References: <1735254890-18457-3-git-send-email-andremue@linux.microsoft.com>
 <1737559244-9107-1-git-send-email-andremue@linux.microsoft.com>
 <1737559244-9107-3-git-send-email-andremue@linux.microsoft.com>
 <Z5ETO5PlC0RyhHva@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z5ETO5PlC0RyhHva@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB8PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:110::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b4fa82-87b2-493f-47c4-08dd49c72f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BVMNljw3gxxpKl0sRak3sVM6ycDI6+uFVAuwGVEafBFrh/taJ1QBQdb43VHS?=
 =?us-ascii?Q?s8upCsIoO4SiBpXgTWGuwVu1qvJt6hXm+OuVILFU1nP4wA0/3dhhCxkfJsyC?=
 =?us-ascii?Q?NuMtcTZsgh+tlGGlAJ3JYF8060XcgO966yXFJHURq/vAma8DhrRV3Po0KNMN?=
 =?us-ascii?Q?R8No6dELqMxNXp4xYuW+lXnM06WWXaX+iOlukpKYZIwcf0tBVlGmc/R3L2hI?=
 =?us-ascii?Q?GuiHhA6lHZ9VVy/I2jQpyBPxlvV4KBDNtGYiwq03HHKEarJYJod4/wYP/cTY?=
 =?us-ascii?Q?IXwyRvwGM98a83NL4oWSjegr8qTElUbsDXxtZcoMyib9HZdNKWPzlueKSuf5?=
 =?us-ascii?Q?Fu71cz27veuL2MctSb6zs9ctc6Nx+jbqKUV353caTM5VlKJ34FdaH5h5An8u?=
 =?us-ascii?Q?1N6zR+Pqm0t+eThgo6tcZQHee/1EvbDVGca4NDuR8T+uNKbPrLYa21GKZpJP?=
 =?us-ascii?Q?hynIWraiPmo2t2csk7cnsayB4XMJIxRHMmRFFWHaiW0imQO5lqvlTp4DR7r1?=
 =?us-ascii?Q?QtRBP55fiKgPnx7SgfrnXYMluaIX3yjkhLU3yvkUq2qFNHZOv0350igZ7jVQ?=
 =?us-ascii?Q?Q6hg5yA6gntrNdMNRbWbhEDuxIpsQY8EncZnZKnYRXnjYv/lu3DRJnpmPhqp?=
 =?us-ascii?Q?MRkRsKRaoeQZ+aaH2PIIklUuh+Zv9JlAT9dAFxa1rIogIPQsqkm2kmG9Ea1I?=
 =?us-ascii?Q?JFQU9aNx5/gUvSHlAQ8tsxyK5ay+5+RvaJF+03Iw5WH1DqLRavF/uyKwbleZ?=
 =?us-ascii?Q?RJJYKO8pvKLXyPVJHJjQbgB5RFuHSvQ64DDh9/Xwv8LPdsXzo0lSbgBN9Ef3?=
 =?us-ascii?Q?C6+d+3TWxpoQdHvwSHRUBA97OgWAKUM8n6nVWtPoabKUbd1FTDt2DztWDLFs?=
 =?us-ascii?Q?zThGKN+pOPWk4rssQb/BjLJgfrDgUIpwhnfcUDwsXerwpPYoybjTc/DXZWSy?=
 =?us-ascii?Q?ZXi4GndGdl+zEzKCmRq69z2YJT8SSbkNT2Z+zt1Dd9a44vaMYne7F4ewONGd?=
 =?us-ascii?Q?YIehuzNh5gmvALgbwx9XLcAPR4oYCjAPPOzhL1pkhgwQ9YE9GgDE1LC5Jyhm?=
 =?us-ascii?Q?SXcwb1m4p0ZKPv/uJCvJDvrqqkzD4y3+O7WQ1IC53KBbSF2kC56i1QwYiGR3?=
 =?us-ascii?Q?z5MZSl5YPN1FX6CoGK0C8EoLVM4Wue3N4yQ51Xe2s59UbWdCYUh2DfmEQL1x?=
 =?us-ascii?Q?PvhmhnEOOsfnqnVSURoNmL0va3nvvPBeVJdyWdPZhp4sEHc867NYLPnPOGnf?=
 =?us-ascii?Q?gcRP2wt2ouMoNv7DjSfwRyBKMcRQV5Y9DIYNMkDhjSk641clJX2jhvZC2/9U?=
 =?us-ascii?Q?dAqJhfClG2j6pYkqwnipMJ8NR88FCOQte+WUGNXprW31xsww+09N0bhoQMyC?=
 =?us-ascii?Q?55DBOooHP+vIcSBxn4nSWFwgH9dj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZVrkZQwZpbidgQTvNDA80sa5yHQ8jUiHq/JbWKUJf26xgXFSNg0aEAQpvCS?=
 =?us-ascii?Q?dgCNJgj3rTcUL7zvUM31WOtrgFGJLncba+JUE2C4HfrvTsMzzPnKBz+MmPZp?=
 =?us-ascii?Q?k5+BxTQvBlDn8brKwTxyLWlc2VdhJWdXscmHJOiuVQHSZvVl9GHdMXoX9qjJ?=
 =?us-ascii?Q?oLdqQZX1ICXnDsop7uZiXQw5kazN3fx23K6fHmj0VezOyF75ggoSIvesFfnB?=
 =?us-ascii?Q?Zx+cV0kmV7/oGYXVq99DcjFjIh5PbzDNXX9LY1qa62u47ip3kOdiK+zgPL7n?=
 =?us-ascii?Q?HVuJULXdcWdyQ0QhfZZE1w38v76itpsgTDPvqQ2RWCiyhIRHGnxXi7c8EFP3?=
 =?us-ascii?Q?uX64lPDR52STDOzyfIGzt07oIcHKe7GyRtaaYGi+dHP0HoXqzBLDmzwbbo3X?=
 =?us-ascii?Q?QYzwNqnp5Tfb0CqcKhnCwJQbjgSGtLTa0bc/sNV9JVgbiYAhx5lXRdxE1rKu?=
 =?us-ascii?Q?mr2ygx92DBw0b1bUaxUUq6weEEuhD6j0EqKqSGNbBm68Twq3QPg8fDUUEBsQ?=
 =?us-ascii?Q?+iPitn7bwFq7M5iH2QW5ckQgnNbbdNIDNv61vlOocImi5yniVh6NI5okSCCA?=
 =?us-ascii?Q?qmuMaNOP9IunNGqlNAPAcgdpN7rAbVm7JwTTOLam2ubT74yVxnLAJLu1tET1?=
 =?us-ascii?Q?/z+VeRCBLJ+2/qvri2l3KoNXHLZmBGgyrB084pVnaiA61iJFIG6frqNR4qr9?=
 =?us-ascii?Q?ajeDDy7jeT+cLPKuA7YWNbGqYyg/0+Cj3AqvBBWkQOEScqIIPEhAQaZZGD4l?=
 =?us-ascii?Q?dmdeVuyiuu68GyWx4HOMKAjHh+OC6M0/FX3O0qQVZCVfDxBk913TLK6nCos2?=
 =?us-ascii?Q?BZyKiFLNkKzBZVH8VZRNTAHHKhM1/NmnRLP8QEszpr8MfG/SCfi6CUoTJDHD?=
 =?us-ascii?Q?+Eu13tvDU1s91+su3okH94mhrnlUzXTLDUi/Tf1n8+IAHXNihzfevh2FhAHa?=
 =?us-ascii?Q?YmFh/ezz2NmprOGFjxSS35FxRxaxmSGQh8iwhlOfQLQzV3UoRT4gZj35TBXb?=
 =?us-ascii?Q?qALCmodyweNCxTBDQZiTyjaifkb2l1vb5gdi5IWLkVbHyh+7k1RwjoCusiQt?=
 =?us-ascii?Q?3HpDSMhUxeHXGwfTJVwZqWMoewCzDsvfEFxwzRXFIxZvAazjA87tfu9LuvrO?=
 =?us-ascii?Q?hJ5t3t2MVdza9jGafhqEjlJsv7wDD6Vwdx0T2EUkzD2WEvvpFRXFQAzVRpEc?=
 =?us-ascii?Q?YqWQM4cE9qcG8NkhZOLzcYvLl924GbcwSVCmHTbXN5jJimGvyR1NlQC1WEI6?=
 =?us-ascii?Q?54y/zbecXEXxr2dIB+Yqp8E4vnTEUotP0PSKwPkmFJ79U7LM3k9ZJy0XNKQn?=
 =?us-ascii?Q?vlIFc+AzTTmyfFl9GjGvdyfbekpz1RcLUquRm7V66OWwRKlNjL3AG+Xo4cfq?=
 =?us-ascii?Q?gxEdT76Cg7GfS0aOcZVsOfiL4pE179Nd/u65ITBxQKUxpa70O4GDPSpPPRgs?=
 =?us-ascii?Q?TxsN3tInxJaFkcoYIjywl6cvxLfdfid32RRZuybIdScOLIEDcFaCam1t0h9y?=
 =?us-ascii?Q?gyw7a2C8LrxfvQZkX7/OyHtrUNM6df9WhjZdTaeiMEg4JNIV1A0mmRqPwBp0?=
 =?us-ascii?Q?/3sYth0+tyeRbIIuzn7lMQZjIgkIUwgXJ121EzT1w2lY7f3HipdqWOiUnaf9?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b4fa82-87b2-493f-47c4-08dd49c72f05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:36:39.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAs+cPCr+FHPUxDconEfBFQ29KrwG+VitXRm5Xs0LqfuVZxEzBk7/jCVWEXkElyF/EqgVpU/0ZQq59AUdM/3c68JFUN7wesQqSMCBRqGQd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
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

On Wed, Jan 22, 2025 at 03:48:11PM +0000, Bruce Richardson wrote:
> On Wed, Jan 22, 2025 at 07:20:44AM -0800, Andre Muezerie wrote:
> > This patch avoids warnings like the one below emitted by MSVC:
> > 
> > ../drivers/common/idpf/idpf_common_rxtx_avx512.c(139):
> >     warning C4098: 'idpf_singleq_rearm':
> >     'void' function returning a value
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/i40e/i40e_rxtx_vec_avx2.c   | 2 +-
> >  drivers/net/i40e/i40e_rxtx_vec_avx512.c | 2 +-
> >  drivers/net/iavf/iavf_rxtx_vec_avx2.c   | 2 +-
> >  drivers/net/ice/ice_rxtx_vec_avx2.c     | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Fixes: 0604b1f2208f ("net/i40e: fix crash in AVX512")
Fixes: 4eb3dcce7c5d ("net/iavf: fix crash in AVX512")
Fixes: 20daa1c978b7 ("net/ice: fix crash in AVX512")
Cc: stable@dpdk.org

Patch applied to dpdk-next-net-intel

Thanks,
/Bruce
