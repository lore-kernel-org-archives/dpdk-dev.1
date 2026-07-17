Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354EAC44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 10:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A88F40270;
	Fri, 17 Jul 2026 12:15:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 671024014F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 12:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784283300; x=1815819300;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wKk2sKZZ8xVWWow2jJ3nsc1TDFnNCWomL8qpdjaiPNc=;
 b=ex4kbxK5+5YtPXB2rTQM1K8sYJ8/4tg0c5JFHNr0rN5tgUzGj2s6BAiQ
 hzJA4ONcSo5KCCJ6OFnraHuQdbBV4kEPlq5ts514g/xH9y6D1KPdhw+QY
 iKHiISWUpnplbuVX1wz26Q2+YPTawUq+bOqI3lPK/4Du9hSo7g5fkvyoO
 UwiSp38Ao7CcvwnQHOcnYCTVS/s8LQ3Nlv5pAgOmeqdG3RY7fCeQ/YWwX
 iGhng3LukJuHe0GuIWxQdgW0umqo7YiR+PAeL3fD9UOP3/6oaFkmneF+0
 a7JQQ2yZT4noxjKRU6shVpDv0oPaB3P24IbzBZfAxW4AmGrgAjlnExnO2 g==;
X-CSE-ConnectionGUID: 13jNAbA+QmOMySyC8KFo0A==
X-CSE-MsgGUID: g9f7hidmRS2riFAvlVZ3Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96465687"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="96465687"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 03:14:44 -0700
X-CSE-ConnectionGUID: CNafY8qyT9unHH03xou2Aw==
X-CSE-MsgGUID: /ma9wEbRQmeeaMc34sSl8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="261711874"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 03:14:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 03:14:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 03:14:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 03:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEjU1prw4MLW1dn4C+Vubm0Mwx+11RYTHERdWIbS82L/WjeSfRCYx/Jb3+59dsnS3mf2Rt57q111sSZWNjmGk/y9kkrLn2KINwa4yPQ1NzN9TDXWq1lSPZpauLL+1bgREMDckOxI1qBnt2T3otWXXCkVPGO5iZ2c9IhutJKMv+d9t+dOtevEmF4ve2vTjoN2SHDewMP0a921g50B5RiaBDkgdkD0IL33zUs+dxazxmD1rD/IfEr7bd65JjxT9ci/pmIWqA3En+VZgcX7OfsyEx6lXb36LV6s65vB7X9snYJHIAntNIuIosIVkNTsWi0G2ICAccJLKnwZvwTlzrv2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5gmGPidcCDh2aoxUOFeeQOtSjm092GVy6wxQtyDpzM=;
 b=PCLtlWPco7wTzyvU2c80ucs0v+eLE7bXrDZOz9/QG7kLDb0YiplcySZLAmr2zVxmz5xZrIsKqU62ur+kZu4wkwE/x+lxBxPeWWKWPvsgugwKbrMbY8Mpz0T2zFSTyHGdSuWDPmdizs1im7b/0P5pMyhavfSTuFFXMExbLAmE5AdK1Ee654YEqsPDfc6rhPKXQgFyIq2TKaMGfsXFEx7qbtWL09guMNU25pOY4q50v+7EUw5YNnnFz1PYVf0zJpIuVjWZBqwFA0Q8fSaGz84K9SRXFNy6YVsWVckgJa4KD02MH5cchsoZM+Dp3qhWMx3ARk7UpZQ0ax5369RpXO4W5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::838) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 10:14:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 10:14:25 +0000
Date: Fri, 17 Jul 2026 11:14:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 06/10] test/devargs: check driver presence with public API
Message-ID: <aloAfU6IdpZOMAlQ@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-7-david.marchand@redhat.com>
 <aln8LkIk5q74OlpT@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zaL+CVOaZ7THPc1yzjC-PYn072sUuSF25WngPdRNBLmw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zaL+CVOaZ7THPc1yzjC-PYn072sUuSF25WngPdRNBLmw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d77e688-b614-4ee2-1c34-08dee3ec2dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 45lnuWp9SneXtc3wNFVFw3UQ5XlEkfEpPFY/aqKhLOEVFaF1nhtJMYg0aPe7GDFfeBSSWdZVmkDOXs+RecnJA8Ez5CPJ4FkVE2zOgPQ9+cJ7PgkIILPkbMgCQ/wgCx74Jg5V5+RgwNlct1TcPvAEQqm8xHfhQPZ1ysh2jP0Dyr8BlPOCV4gVE0sUEfWQ0BuBN6AY7H6m6afEXPPmYBEDCte9CWpQ7sm96/XGHD0NwdLFYxTIfWVW7uz2Byqh8U35OmxLsbD+/91L5hQVWIGhaZtWLOt2xkScZ9dOqU01rGII8U2zbZvQMs9N9MZjHUFRWzec023Sv32mo0imvy6KlfVllyqq6KkxfFPoDQxPQcRBRBANu1B8zIRD+r/tArgJR74k6QJlephKg61bycNWtIh0gg5kO8ZGCT4n7mxlOv9WEma3AtdQGdAreWTu6IXXSIs71DqBKJkDKlq2M8qAZoynm7meARBKHPMhTWMSE7MP4c5hkg9FcmHpBvnI4f6u8AktKM/ZCPUpwznne5crr6JhOwxuHMfGLZgw8FDlyI9WEl5N3IhG67+eWn8jasQCeUHTUP/eN3uW51UfpBxTJ9ggIrj24cht8htdOK/SGy0ADME/YIY9iDngBxa6Ydp/xq5dWObH7uA+ECxhsnIQ6HqE3EMkaufObCAdo8mUwe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xzsJS415fpptcFzLJ1/knR5muXfhLTkJMj5/rul9+AwMmUBuRz8ppz9peq?=
 =?iso-8859-1?Q?TAymRxbyei5sItnq0MZzr/cFEzDkcHtftMUYYt9+L4G8aKr3AbC4KipxOD?=
 =?iso-8859-1?Q?FlwCOX4sUFFuvNNjC5+zgKml3fWdgGyof5wtUpZTaZtZmolizOGjnNKL6o?=
 =?iso-8859-1?Q?QXhGyADSy/FZp7RxFn4tddAPcHjX9hSBQN8kYhj7rGJirARMgISK1H/fjh?=
 =?iso-8859-1?Q?GuSHCAUCiSdV7CpO5A/LWeOc50F14ooYdME9Ip9bcoLcMcNzQZnX/GZzeK?=
 =?iso-8859-1?Q?e38Wg3jQ9lASlwHunjgSFsLFfXATXASmq9yav/j7j7cEVxcxKfbbQLCw85?=
 =?iso-8859-1?Q?uHZlSQIrgqvwG7mDWrGAivQylDH2MMKLjz6MRiY/F3TfFyKrD5TTpk4xeX?=
 =?iso-8859-1?Q?I07kyRyJrN6pNtzA4hVQGDpaqInxeut0dE7mMWgTl7ubT5802Yd8IP7o78?=
 =?iso-8859-1?Q?x/CnZZ4kDKjAJcCvnwa26L1F7Mt6dny2xb8NYbxq/Akg4cwL5a7LZvHsSs?=
 =?iso-8859-1?Q?f7Wo52SM7y4WiAK8uWAhWuy/RBg00/QK1CNrqfcbPrE79vtdIIFNMnvEAk?=
 =?iso-8859-1?Q?xxoqUCmxN7wAx2dzwSKsu4I0vYzKOQ8BveGC5p4BTWnJDyDCPxQDL0Ln1j?=
 =?iso-8859-1?Q?41a4spu6DLPCWdT5QRo6zJyIHo7p4Za5hPVY3e5iAZ8ecfAbElKob/7Q8B?=
 =?iso-8859-1?Q?HoL5wIaaKq/ndzjDOufGXu+p9/q1duqIh8S7/6qOadFZOLnSWRYMpTnjL5?=
 =?iso-8859-1?Q?GHDwvPa7DjkT4OWlvRHusS41mFBDBAolcnR2tbM9Nh/VJbgH0tCoWdfY8J?=
 =?iso-8859-1?Q?yCzgaMrqVQnlDf8L2NqgWjMdlSOy3VuXdSeTounHMobVKUqokZXR37Hohs?=
 =?iso-8859-1?Q?HGml9+OLa1CzDspsVDcjiuS6DmEKq/jCKyVNN7Dvajzk/ISRjKfognV/sq?=
 =?iso-8859-1?Q?OGt3zsfJ1lMCw2xlWGrM8p9U2XJA2/czs5QGuwULrAeOmzO2TRZzf5mh9x?=
 =?iso-8859-1?Q?i1UM3pcYwlG6CrnvAUObfd5QYtAEh+Wce2PDpPb8fknJJWGetP1EwcCyqN?=
 =?iso-8859-1?Q?k4/yrL3IiGQFJOxGF++/LQ9+tTiUamd7gfp492pprnAQw48U7q2pPfnWyY?=
 =?iso-8859-1?Q?Hp3+nJZwrJYQ9DeYn+vmHhrml2+Wh0cHKM8kQo3gnotAiSzCCl3OCpLr9H?=
 =?iso-8859-1?Q?Kx/8DcqYdFOe4lReiAgRtCeJO83oqr7XdAB9H4JjGaJnNJPzhWIsQiEG/Y?=
 =?iso-8859-1?Q?qapNd6HOpotMEMGXeNrVr9G3OtpOJwzeCaNGR7FHel/wl86yXXWpGvEM7v?=
 =?iso-8859-1?Q?kU5JJQriF2AtyjL7VD49V+ElSrYBrrUCIddXeVxXqGhMYVlUA8dJMhegk9?=
 =?iso-8859-1?Q?wVioU70UJKBtPqVWApE0jWMXvOx5jOGP7RObcRYZFPGBee/QlfceGDFGhK?=
 =?iso-8859-1?Q?fpKnV7e9Vp2bFf9eTToG1NOBxKut+Sp4/OwU+b0xAvvVoRdNtMc62GpScm?=
 =?iso-8859-1?Q?vsoFOrKgN5/wn/9eR9i38g9SN1lxCREzBbytXjuWgmL5RyIWteOMFR1e5l?=
 =?iso-8859-1?Q?xVLMoRcnMdS1OtFp0Snv58PG7I3ot/m73g8l43ZR6DQB0GTMLkGfHm5RIv?=
 =?iso-8859-1?Q?J4xx4irt5SM5OqaNvee0sq/YVB9yheXKRJvyblD/5RghvQy8vWEIhpw2GG?=
 =?iso-8859-1?Q?K6ZoILGCAtSHg3WSYgKWEreWPf4jj5YLcrY6iQflDOp8h+ZUMb4Y+mHgOg?=
 =?iso-8859-1?Q?yLK+6iUAkTWK1OeJA5qceIMoxJ+rUYO6mpD+QQbxnxpXNNntsBXh/Z3ZAJ?=
 =?iso-8859-1?Q?zplDOXefohH83IRqTpNXopXsVr+yDxo=3D?=
X-Exchange-RoutingPolicyChecked: YXgizIRqjVc86uAZ3agmMjuvOlsLKYNjXcRvKtHUt6LJxPf3f+6uG5XIJsGv7rYdtvTg6/cVEV2bA3TH0KKU8gWotKR4+tGN+YcdePly7i9QLAEK2ZEsSEpj4rghEZtGkHI/ZlwsoAyCEMSKaJt9Ym+hpCMQ0iEbeEqrQFLKtg6NgS89kWPDeGIjuZTKCcalDC4f5NJinGBvoNT5n6fvyJY817WRA4j4m+Pv8FslV8vnll0tPaMcGQMvU6D2scls/3HEPcDXSWgsZqA7nbhxE4tMVeqqbKuz9H3oKKzOE0SoXuVrrBf1mPj7Eu2TMTueHc7ZdFlPjAVy4VLWPjH8fA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d77e688-b614-4ee2-1c34-08dee3ec2dc7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:14:25.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iB7jSOoSkWNi28+LDfFEyI9yU0EjYpt4Z3vzTamJTeQnrDTMjj+/1uPlEQ3nJcFgX04HsJSI/D+pRggZvdWm/n1Ak7MDjv4hWuJo7bjK0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Fri, Jul 17, 2026 at 12:08:01PM +0200, David Marchand wrote:
> On Fri, 17 Jul 2026 at 11:56, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Jul 17, 2026 at 11:30:01AM +0200, David Marchand wrote:
> > > Let's avoid calling internal drivers API.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > One suggestion inline below.
> >
> > >  app/test/test_devargs.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
> > > index 0bd14c24ec..6c194ecfc6 100644
> > > --- a/app/test/test_devargs.c
> > > +++ b/app/test/test_devargs.c
> > > @@ -10,7 +10,7 @@
> > >  #include <rte_common.h>
> > >  #include <rte_devargs.h>
> > >  #include <rte_kvargs.h>
> > > -#include <bus_driver.h>
> > > +#include <rte_bus.h>
> > >  #include <rte_class.h>
> > >
> > >  #include "test.h"
> > > @@ -167,14 +167,18 @@ test_valid_devargs(void)
> > >               { "net_ring0,iface=test,path=/class/bus/,queues=1",
> > >                 0, 0, 3, "vdev", "net_ring0", NULL },
> > >       };
> > > -     struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
> > > +     struct rte_devargs da;
> > >       int ret;
> > >
> > >       ret = test_valid_devargs_cases(list, RTE_DIM(list));
> > > -     if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
> > > +
> > > +     memset(&da, 0, sizeof(da));
> > > +     if (rte_devargs_parse(&da, "net_ring0") == 0)
> >
> > From what I/AI can see, there is nothing in this test case that requires
> 
> (you could write it as "From what A?I can see")
> 
> > the ring PMD specifically. I think it would be good if it were updated to
> > use net/null, so that we standardize on our basic unit tests only relying
> > upon that PMD, rather than requiring a variety of drivers. WDYT?
> 
> There may be a hidden (capillotracté) reason.
> Passing path=/class/bus/ seems to be intended at catching errors in
> devargs parsing.
> No argument in net/null could accept such string.
> 
Not a path string, no, though it can take other parameters. Do we
specifically want/need it to take a path string?

/Bruce
