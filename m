Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3BC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C678640270;
	Mon, 24 Aug 2026 18:36:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 34D0C400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787589363; x=1819125363;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=caiM4i2h9kBbQlA7fWCmnTtJCTDCyBKdptdEAXig+iU=;
 b=bOQkgXToDjNq9ayRYyP/XCnSKSO3oHRynUrpLVb3B9BKse/NwKpA0jng
 5d+yeFq/Jmz3aJNLl2oDGxbsyoQlI4FZupAKBCzoT8MGdMy1WERtcClFM
 YRTzOL1n5+96vfYgPuDro1o46tWBFkHA+yLUPkul1CDuJlJOFOFB3ln+Y
 6kyPKEYkJvVYjhU485+V/ripGE64TsEfQnp9KIR1Ha7zUSi4dvjVSHMLF
 AsCiOltduI1ZbEwl+qN7TXKAXSesTPwjlVJ+6u1XyMCP6Pee5KqGOOcN8
 fsNTPZJstODVT68PKPjk7pgoacBgFe8QViTLMi49p5P0Un+MW1UoLRwbs g==;
X-CSE-ConnectionGUID: 2AYyOAzuR1ug/7dhx1cB4g==
X-CSE-MsgGUID: 0Ib4Gc1/TkWeGTFdWgnPww==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="90562881"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="90562881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 09:36:02 -0700
X-CSE-ConnectionGUID: 41mFr7bhQoqztcPJMXxHBg==
X-CSE-MsgGUID: VdQouxfgTFGHEGj1YQUjNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="266523548"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 09:36:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 09:36:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 09:36:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 09:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHRBr3v0mKtwto+zr4pjUk0BW6LXWzQmHhLUQK2sa/ccn1pRJfows88gSsucG6wmGVUJOStflfpRvm0X2WOaxnYbXCAHM07Oz7q+52IYZCqvSVH4whGpEpdP4a4eW0d7hvd7HXSjlEKxvty8lG/oezjVuKRLzszJ9z4syLSYN89ae3v9ZLXTpCwo9a2iwWOg9I7LMH3pZF6nlGhjmSlVyeHp0ArZX7yVgUQZ46xi6pkiyBa3bB7IGZm9yotPeWgd8dFS+rSALUuie6Oxd3+BhWGFRqngvacpbgcgG5DNivD7Vs9BF7geRxk+MBfwTb/IUh6DO1eBXxcijUiLNaPT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmLzuKyYldlHgOPp12SNoMoYmEd1arj7FHULYV8GZOs=;
 b=ZcMsb28OQjqH2QRttfUwgoUtIN9mX8gQkVIO0BRbETdFVDgUt37ZkP+PCQxaJz+MwHRarbfVKCtlhVbu7zEAAuDzWK438wpKiFT4wXTgGCjrqeBdHApn1BhAmW/I4eDWdKKPY7ZiXVRRnYHWbTAGytL4vJe/mAXNF5cNSEa/KZFLLrhbKDh2/gxqYJpI1wkFVqsRSGXIaZFtXGv6cdT8wyO2mCqBiZ3z1CSIy7aK4+Mpu3eUiMQWyhvfCr4ybH8XO+igXTUJjHOPmkingUHD1/73a+AcYg0ZIRpEgSkaBqPiY+aCLBTaup72RoodkQtRYI8PwqLHiVk2417lpAtIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM3PPFD3EB37DFC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:35:59 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 16:35:59 +0000
Date: Mon, 24 Aug 2026 17:35:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 7/8] net/ixgbe: move editable files out of base folder
Message-ID: <aoxy6_XNdpBkZHQ7@bricha3-mobl1.ger.corp.intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260814153755.940302-8-bruce.richardson@intel.com>
 <CAJFAV8zYSCsbKBJPYc_bH-QhJoZff+vU-va5Po5NJbptX9Q9qA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zYSCsbKBJPYc_bH-QhJoZff+vU-va5Po5NJbptX9Q9qA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0245.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM3PPFD3EB37DFC:EE_
X-MS-Office365-Filtering-Correlation-Id: 1295363e-8803-48ca-5808-08df01fdc73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Oi/tGQlenR2KWVbuHI7IWczM0T/hCMJG4H1yUiTtdlVT+tXtBiKQqpBzpsvw0gY0TyzhK9ZXPfJ4h+rEn6rBEgv3J0yL0JEfkHI28bs1ntAIeV2QIDfvFqfuwgF3yWAiuDV+0E+7jy2rAzL3dv/wl26VYKpKpBL2zK+WdCfedFuD6UBRkiKS5JLe2+mr3lAkvH4HPG2hISyujnWWclqG3bwmO4BwEFkVRMJGZoDe1jd4VYei8XXussFikYKKBH8pBdhQBrRtWs3fqf6TkncGIqTXexSzDPRN0ssub4aqgWpEW4nzGAjCA/VaxFRqJF11KL3fJfwp0BZObz5ShIF/4tj5Dydwlb5tP8/RME+UC+fWVA+JO7dflmid8arMbTabr2O1xblTTZTPQSI7MzgCuafeOMSIWiofE7FIrdwnq0GpUmkd8MhlwFnP1qPyFm4ICnQ13oM6OmYZaEQp+wRj2oLdD5LMIUHFTjQoZlOOXq/4dA0Jp3ogxqqqQSld352i6ydhOSobb8YkZmVkO2LogNYeBcpcKFGCt2Wkoo56y3WZE6awZ9lkynCB9M6OOiIdlIBHZTwYiP91G3SVxvsFF0gXNS9C+Bi0Of3vtIGfXXpe2vojhpldrVUH832SYB/phsQDcehJ6oCrZdpZJZEq3AbOD52N4UhK43fAib8K52k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGVtCz029DCb0JsTjV/QOlV5lKtslHfoiePvKp3LeIOgsg5OXz//nrjsCIrO?=
 =?us-ascii?Q?MTEQI/cwtHM58iD75J/PbZP+UhfJKOu+qwW9UdKzU8qKYC6mLUPpSDv3IRst?=
 =?us-ascii?Q?HeGDhLvWXzu2gOiEu9CWBE8IZuTHGHEP2EK0oA3/NsUkpqiOBshnENaT1Slr?=
 =?us-ascii?Q?t2VoJpAWEsG9wE0SB7BJyDQIvZ/48qktpKNrSco+R9oUG4ZNVJetXwjTnBUd?=
 =?us-ascii?Q?bH402UA14Ndf4nuQ5BPpR257jcU6uMdtzeNUjOGEtSB9Jdg7S9qW2yypkI+p?=
 =?us-ascii?Q?gbwyHK3a7F95veuv5UGd5ynsApX/k/DFsaSbOOv4DKj2wb8vgxRhB+7wZQxc?=
 =?us-ascii?Q?TuhJiP40KKaYcbFE5meCQ2MVIY/yvataT5DZ8ADFYb4YrxdjWOulBORanQvE?=
 =?us-ascii?Q?wyGoG35rlkp5wGNtmw4XTAqaiV7Hr2V+ntSPcfxdhSbM9N73xjz4iNQV6+vu?=
 =?us-ascii?Q?DGD7G0hgGvQGw71QAC655j6qK4ro7jGfP3Q86nhAeypcUGNX9FL9dAhLP6j0?=
 =?us-ascii?Q?riXmeau3S7oQLxk+f6uPPwzlFqC6ZRn21lS5JI2Tm/dlAV+uNJXUaEFaWzu4?=
 =?us-ascii?Q?37wB6j+hCUC7KGjjTPzfRSL4qopjHF+Kprc+vw7N2evgCB1n1vUOVwklz3HX?=
 =?us-ascii?Q?+zgaKRGjNaqrDoM9flQq9/icWyt1Wx+zVDLWC61iuY0xlv90l2JZFxZf50vj?=
 =?us-ascii?Q?zzN4+saA8ZaRF6jIrv5McRIu8it4nK3ijZTyT/3O5Ikeb6YUD92uFPZsHU4Z?=
 =?us-ascii?Q?GjjvKsk9nd112k3U3HOceYlGbgkBGsPc4SNng0PGPF/kmboFU4N2dA5NHBZ+?=
 =?us-ascii?Q?/XvKxsEqPDNttt8kYdHXD1nw9IA0JmpOPDc83S1PNphPen2fzA3kRuReR3UK?=
 =?us-ascii?Q?55UOFG5pXwy3WlZkaVxSU5JJaKF1raOYEuJbNk4NKQ1jrOVXdeZRe4QCRGI7?=
 =?us-ascii?Q?b9JuFAQXyU1OugdSGm7syiMSfyJyJ7oUEkygFyJ0MGO5qOxSRKMURB4Fbeiu?=
 =?us-ascii?Q?DgfeqbneN/1mbLXqI0oq/hzM0/nc4hcwxeGaT9JYhV63havDzptrtFa2YxC4?=
 =?us-ascii?Q?0oFYaize1h7kN1g3Nz2yaDxqhs8K+SgKfvj1b8f9THchoY7G/z6ixamZ2+Hl?=
 =?us-ascii?Q?Se/thZ9/VuzpPw8dAlTPoUK6+qeH5V1IFSh6rjPzAwzBWBVWW3UVkY8CdGfK?=
 =?us-ascii?Q?6mp+xraryeIchow8oN3slNoAahs0Vxbfyi3s/3/8Yof0rqP9+u7p7/wXV78I?=
 =?us-ascii?Q?0mZYfhfyILFO8iYe8FM6dg9Wc9YKiFthtBh5SZZOKdoX3jJ94q2Ibfp9W4AZ?=
 =?us-ascii?Q?RnvA+Wdsq2v4gfcCwMF8cGIQPe0SVHAAfvWxjjnu0uiRkiMxpePf3AfSWS8r?=
 =?us-ascii?Q?MymTWs7M2n52oqEm1N3BjlfibRQiE+npjISkHDfsgwuHbNEq7iwLpC73vhTE?=
 =?us-ascii?Q?UBqzO6UEyPZmIWXrNJxdtmcHCD/QSNjE8N1tVdoLKZUH1wWSTEHSyXcX+usB?=
 =?us-ascii?Q?ZJD6Uc9Y2C42VtI5pgGm3H8tBMbjM4RcqWZVf/KkRcNupN0Rn7fjIvyUpEUW?=
 =?us-ascii?Q?yR3eH/7q2WE8TJGq14tfimJHYNuv0hsva5POGF8WrWhD68o+XvTrfN5McRi/?=
 =?us-ascii?Q?Fa6E1PkJaVlMV3iNx9vgP1xngCpZFiPTMWDeyvdPmvQl33guMKvGULcv2kay?=
 =?us-ascii?Q?iRrLSeZCxMTg0Gu3OguGWabZG+R6BVvriwLvgPco2ssCt5wVs86lSHT8UyRm?=
 =?us-ascii?Q?ldk6AVI7hoYdyp7EoWlQuXY51O9MzLA=3D?=
X-Exchange-RoutingPolicyChecked: a3udw3NXD3GfxqVCrsgh/N6AmWUZSB7fwYklSWygIhaU5BY8441/Qp5G+/OktbKi4ikMUCRv9cyxMp/ODmKX0VLLAvFz5l/l6h7IqvaCJSBLPQ3fWKpnDvyuQUbk0gtLubQxYNKqJGWIi134GH4Fda/1Av2645WfI7WR5SbJ7UTNYX3vMyuLs2VQDWnQ8A3rRZsvDEAOMzPDGQPg04MjvnbNPEuKZiAb2rDI22lU7410ObxlHdRvmzul4uPsfkDB58wgVU2I2D3m5YfJY4WX9C3k7ZTIiO43GdoO/SVXbM62SeuJk1V9CF0HLVPVxge8Op4bFRevWCNQrSkwDdySJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1295363e-8803-48ca-5808-08df01fdc73c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:35:59.3664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: li8AeMreaUdwiLqruP1AThO9BdDA1bEBiECV6UlUAAjYSqkJHeToX+ukDWF5J8hxrSCponJw9hSwNB7ROUA+/fynX7+aMgF9p+Tr501Ie8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD3EB37DFC
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

On Mon, Aug 24, 2026 at 06:23:22PM +0200, David Marchand wrote:
> On Fri, 14 Aug 2026 at 17:39, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > index 3d4f4fb7fc..8e44bb3a09 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > @@ -36,15 +36,15 @@
> >  #include <rte_os_shim.h>
> >
> >  #include "ixgbe_logs.h"
> > -#include "base/ixgbe_api.h"
> > -#include "base/ixgbe_vf.h"
> > -#include "base/ixgbe_common.h"
> > +#include "ixgbe_api.h"
> > +#include "ixgbe_vf.h"
> > +#include "ixgbe_common.h"
> >  #include "ixgbe_ethdev.h"
> >  #include "ixgbe_bypass.h"
> >  #include "ixgbe_rxtx.h"
> > -#include "base/ixgbe_type.h"
> > -#include "base/ixgbe_phy.h"
> > -#include "base/ixgbe_osdep.h"
> > +#include "ixgbe_type.h"
> > +#include "ixgbe_phy.h"
> > +#include "ixgbe_osdep.h"
> >  #include "ixgbe_regs.h"
> 
> While I agree with the base/ixgbe_osdep.h -> ixgbe_osdep.h conversion,
> I don't get why you *need* to change other base headers inclusions
> above.
> 
> The rest of the series looks good to me.
>
I don't need to, I just felt that the base specifiers were unnecessary.
I'll revert those changes, though, to keep all files consistent in this
driver.

/Bruce 
