Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7039106ACC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06ABD40613;
	Thu, 12 Mar 2026 17:28:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5BDF0402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773332915; x=1804868915;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=P4CG8EzKmR2mdNsryfiSZeVsmAzLzyOGvttHMf4+TfU=;
 b=JvTB4WxbF4MmTA2xR4yZCuFNnSrQ1rXBBJPJYsmQhRLM7FPg1RKaVJp2
 78E6GZWFfvTkYBVp6HqNBzoSrPZHXsmczZuXSydWWHoAN53OLBvCu4EqM
 cDzPs5gVGYivm6vGCFQZLEksUyLJq3striDfxgdFCGKILHaxis1v1245M
 VrklS55TwhyWCw9cWUvxBt8Oj/CgLJR0YTQL5MbSqwpTkef4SXcAVp0w+
 VxSB7xb4fcXFevFUyRQgVnaw7W1hpXloj2YhsfZ5+9U0QdxZMEajIV5jN
 s9ZW3zU4XdulRQqu7oVPQjgWBChwhUHUSG/BnvvTZB7b9Xv+ovreigWEJ Q==;
X-CSE-ConnectionGUID: uEWkP2AURby0iK5EXYUetQ==
X-CSE-MsgGUID: s02u9mLMQy6PkQE4QHctzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74324962"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; d="scan'208";a="74324962"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 09:28:34 -0700
X-CSE-ConnectionGUID: AwwTZrJhROavuX0zs6Rnxg==
X-CSE-MsgGUID: Kc/EDiKfTKeIUfvh0q+Kzw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 09:28:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:28:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 09:28:32 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHfWIIHLRiM3AwGkhX7TZkxkyvHIwtRPwAYlzsMWBv59jQ7vOXggalvGXGhAU3RABacJHSBuhs6SCVce8msvZ84uAxeuheNFeHLg+bdO9IZtb83OgUV4k7l5/nPP8HDEVQK05ayHyhb/HKVmoxTVEJiSTLnRbqqcivTxc414vMfoQFjRC+G6zXbA2Hnge8A927l2YxsgxYXsIGjSvniHwKiHxxYm27+AVGINfcR0Q93lyMXqr5iOA9SjWqbuy3oKzNAk6/vHpy4Ro7oi/2r2T0o13tFXpNWptUZFYugMvl0sn9MkVlgNppNqh/8Ww+fwKeDTMJpEl2i04BY20sA4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjzZ67EoSJy+ZO5P2/U66B7PoU4Yj5kV3Wag2L1Awrw=;
 b=LKgo34jOGV7MuqA8UePXkdh4ydvMi7YvSm6EL7jqsXm7ftOPCWdmSsMeLltxugM8MUuKdrzodPjFKb9yVc7hRPIuxfv57tMVNgUJ13fNAuGB85v+UswHTaNB08+Pb28zxlX+0mN0YscM7zgiqG9xs/Cxk+Agnl/kxbPmoiJGAjSykmDDTAnFWysCiu0YAg1ffu6E9oMxwvGFS0kWlIuZbiQQakRulE00WB8JqGhIXmPYYeB6aHh2+GFq99KU4V+zN+Obp1sMDRbbns9a9ucboBmBFfq9dPK9woHs6NjnIMXbAQ4ICQ3jg0HSUvsLgkC+JDsh5NpC6ZZUBQc/aqGCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 16:28:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 16:28:29 +0000
Date: Thu, 12 Mar 2026 16:28:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] raw/ifpga: fix comma warnings
Message-ID: <abLpp8jbldpWY8Bf@bricha3-mobl1.ger.corp.intel.com>
References: <20260312002337.867771-1-stephen@networkplumber.org>
 <abKELl_UQ8uLhSTY@bricha3-mobl1.ger.corp.intel.com>
 <20260312090303.359d871a@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260312090303.359d871a@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0330.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e4c022-ffdc-4a00-0264-08de805464af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: luU2vhfZ1dVwTxGpnJsuk2fiPd1fDhB3oEwXjGgOinD5y6UpQq8BUYyTmIaOaB9z2ja/GqmnQpreCatAqkH1CbFgWpQOE1mgjXKmX3ybYIaSBkGhQCDtR7DEOCb4hGAoCwwEA9dcd3tzDr6tNHFNrIXM8n1pMYJM6x9W5SUufTPDyYCzM3ws7H1mHXLuRYyhFbDB4i3ART4Rh6ZL+KBywAxr3OnXt80BLxa8J8aZGBF0F/pxdBb9MhndLc6f/sZIrNTu5tF4nv46/H3HqmpZ+LABjwPwwzFIWtPuhMBDLEFz9t1Gm7jdsMpLuEG7NjaDd7Jn11SIh/q9xXdVag6rMHR8h465cm25PbUE3c3TqIiw3yO34hlg79+428ztla7l8TLonEmnIQ6hbbwhz9x2/Lx8F83hpTIGecHjndocZ/bOZwZ1SQbA3T8jJ3KqbDaus4tuVixSQmox6mQwyVGuMTVfgRV7aBgCZ33twD8Wya//UI5xzcsYJKTQWmHcwdEvUVPRukZuhYt9zg5u84g2hXIs+W6hgKJun2EEiJr5IRPkyOHQQjexJonJdwiswJ2ztA8iAMGAahl+O/UArDZCgeaMfLeTkL37vDHUM40rc2sN/8l5oABDu/kfDYXdxwHv6p07+ZXB7j/Fj2nxFZIHe1Ph3Nd01u/VJeaz/LI0QWYA+E8pxXCMDq/YYzCL0XBgJr/8htJICWrfdGp7DXEaD0G8c3dUD5ylpA84KjLyHLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVLY6r+6WZAJXkgPCAyl6ot0ctG5HavCeDtUE6g6W3IGXemwCXorVC6eg/NU?=
 =?us-ascii?Q?Za/vz3cxb/FCOdIqoL5JzTctnDbqqdKoxvuSYpCaM8D/dh+dRSZch+Hp70gh?=
 =?us-ascii?Q?S47/WXHmCBQ1G1Vp+R5queFe9nt7MaTLdhrSPA7M0vrxU8YOv0nCYF0fA0vg?=
 =?us-ascii?Q?d4T5oZjU2GIr+Vyaw7rwuhdS1s3BM2HWOz2FSqSC0H8HR+nqKZIbA6DGa+KU?=
 =?us-ascii?Q?qu5JZbyXm6pjUtfW1xCOz1QntN3VWNGagtVx2fAO7t9v1a5QURZuCmUap3Lz?=
 =?us-ascii?Q?wI+Lt0LL5JeJLvnglIjbLwdT+315f2LExOnr+jpuvPprgIVWPwhRtL1N/q7y?=
 =?us-ascii?Q?4OowIeiWMteOBj/3oXLbZyn3sRT8JinHdSchaC4cQGvGUcuPLFFoGxvdS+pv?=
 =?us-ascii?Q?W/lb6JS+ZWfCd39plMqcwhckpfgpsXMrsgB4GZdMlj2CUZnhXN8vmvluPvs3?=
 =?us-ascii?Q?UFvEyfI4zLX2+6PgxBuMzo4pG9H1Ujhwyxs2sRI4zPz6ntEvMc1ivAfWXTXO?=
 =?us-ascii?Q?cLnnPBM+4fEg0gQ4KmDF5bVAD33r2bkwiUpJSZE3VjHMl6bcwiKUIyeXGflj?=
 =?us-ascii?Q?CdhhO1BGJbVNBuM15z5pdVUyYEe7QWU6C+R1m3s11V90KJxy1f7CpMA2Cj+h?=
 =?us-ascii?Q?h1loAaJX5ePUdmhVWPtR88dGaByyyxWKl/xXExuCOfk/WNdqkrDVY6b2ZgSS?=
 =?us-ascii?Q?wrf+LmbKDsUbspcazCpMiHizQAvtgdUo8uKAEGtNcA3nSo1EYoE/q8LO4EuH?=
 =?us-ascii?Q?BMLLY4+/qfYAczU++rzWQfeYLcECNYNhHY0o49KYycH0M8vjT20O2SMVZMGi?=
 =?us-ascii?Q?uPVFzdVgq+B4S6prQygrYKn0VDZ/0LmtWfHb0U06OK/1nObJJcgLQ7k43A1L?=
 =?us-ascii?Q?WkIRMQRpni86J1c80u4CrSS0ONyYXfZWbqxdh4NnK00hqm3B0mVnMtJoztk/?=
 =?us-ascii?Q?cVU74mQMEIiOkJou4A3avpSBRPqV7ZKqYmieBANZwevDAKstnpIJdeKiopXh?=
 =?us-ascii?Q?eCKB1xLHk5aPGA19XB4Pb18yyqxn92Fs7VCFO1OPx6jOCOIpicZB1kr3Yxyf?=
 =?us-ascii?Q?5iHH7Juw8HQVHNSzg+X18T0C9VQXJ0e2oHdvdww7XA32H9JCc+b17zID1REr?=
 =?us-ascii?Q?JmZGWU5YfcGNuBAC+uc+KKkxEW5cljxbmolzKbJuH9eDzuiX5VzaARbTUchC?=
 =?us-ascii?Q?n29WIQqSxq9qlYpSOJ1GZUGym7z0t9gcNMtgrwmUb+0GXBkROaUCSmsr5hty?=
 =?us-ascii?Q?Oy9hjen0fnFaufjJHZl0pSBZdAOuKEhmnNSfBdIFm3DLV+gzoKBvnufqHSDA?=
 =?us-ascii?Q?uqIo8/Ek9MbMPlVApSbncSNCU3i0wVjQT9i4TEFJlmLoNPQesokIKWRQj5Uy?=
 =?us-ascii?Q?zZEIPcMFty/u34NElsdoVY1wg3NrClaJRPsmnOREsOTNzFIh6cGyXSarkyCo?=
 =?us-ascii?Q?MnvUFyV/5GtOFse9/P/IOh9JU/eskK1BGVaSlIxm9UNqYITRiriUX7OWNfAD?=
 =?us-ascii?Q?xOGFQkhXsW4ia6TJtZB6FGndsOc1hIKpameorLm1um+/Qs446+L/n6vJX+u0?=
 =?us-ascii?Q?JEG7hoFSFrBmPjI/Eh9pKA8l1HRUQcbkltktRTxGZtNW/WHhjzRHaOZ53T6d?=
 =?us-ascii?Q?SUBYDhyFGFyfYo+vY9Zo1CMTGxTisCUIn9mUjo+4DKk8ehhE0arfafiR3ZGR?=
 =?us-ascii?Q?26waBVNKfuiFBpy1652vnlUfK3SfUL3VPyK4xZ5VIBZDNRMlXcwbxAo1s21b?=
 =?us-ascii?Q?sbnML5TbWxoOeVUk3hE8bExzzfJlYZ4=3D?=
X-Exchange-RoutingPolicyChecked: rqbBykPL2+tJ5xQ/0/YGawO70t8d1AGsbPdPv1Xp3f8N1SqFH4rZM6olTRQHvZhL3EEYoZfySKjPvAj94SnLbe4gTEI3MOaNu2Rz/aKMgs1A025oJsuUMEDk9/xBbOaXPSIhxeJkBKtaYUYuCXU3rxuDJ1DlwTf9yjFpBp1X1qIZstU5TGINlmmEx7IwQa8WMWiH7DDN0A2myd1DK9wevTIQzDHAlCv4GEjRBpdGoeJ5quv3e9fDuVU2fpEoKOTHH0zV+qQtvqbXPjHisGkhW6Y6HKJULbqWAR0l/pT5+LV4EfsMSZmEAyVvydYNcjqMfKDbkH6/9cryr+v6mVX7wA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e4c022-ffdc-4a00-0264-08de805464af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:28:29.1332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asRE4SWmuRVUh1amUqgMIA0N/ciAT6GS4qA93fobhQPaB4cY/5aBXmwHoRTEOg69rYC7hPRox9mV2aDl5Cg5+r8zPy2XNRjnuzJQZdkd74s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
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

On Thu, Mar 12, 2026 at 09:03:03AM -0700, Stephen Hemminger wrote:
> On Thu, 12 Mar 2026 09:15:26 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Wed, Mar 11, 2026 at 05:23:36PM -0700, Stephen Hemminger wrote:
> > > The driver was open coding TAILQ_FOREACH_SAFE() in a manner
> > > that triggered warnings. Replace it with the standard one
> > > from bsd queue.h.
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  drivers/raw/ifpga/base/ifpga_enumerate.c | 4 +---
> > >  drivers/raw/ifpga/base/opae_hw_api.h     | 7 +++++++
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
> > > index 61eb6601ea..085fb6db40 100644
> > > --- a/drivers/raw/ifpga/base/ifpga_enumerate.c
> > > +++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
> > > @@ -725,9 +725,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
> > >  		return;
> > >  
> > >  	/* remove all device feature lists in the list. */
> > > -	for (dfl = TAILQ_FIRST(&info->dfls);
> > > -		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
> > > -		dfl = tmp) {
> > > +	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
> > >  		TAILQ_REMOVE(&info->dfls, dfl, node);
> > >  		opae_free(dfl);
> > >  	}
> > > diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
> > > index 57750022dd..63cb616731 100644
> > > --- a/drivers/raw/ifpga/base/opae_hw_api.h
> > > +++ b/drivers/raw/ifpga/base/opae_hw_api.h
> > > @@ -10,6 +10,13 @@
> > >  #include <stdio.h>
> > >  #include <sys/queue.h>
> > >  
> > > +#ifndef TAILQ_FOREACH_SAFE
> > > +#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
> > > +	for ((var) = TAILQ_FIRST((head));				\
> > > +	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
> > > +	    (var) = (tvar))
> > > +#endif
> > > +  
> > 
> > I am curious as to how this is not causing warnings but the original code
> > is. Have we got builds where we are triggering this macro definition, or is
> > ever build tested already got the define?
> 
> You have to ask to enable comma warnings, I think it is currently disabled
> at the driver level.

Yes, it's disabled for the drivers, but if we enable it for raw/ifpga
driver, how come this macro doesn't give the warning when it uses the exact
same structure as the original code?
