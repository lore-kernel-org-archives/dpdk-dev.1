Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE647ECD6F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 08:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB5CA4027A;
	Thu, 12 Feb 2026 09:43:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C982240268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 09:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770885814; x=1802421814;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h7D92/V6Q9monVBl6F8/ZpqqXUzh+SW1FEePEAFaIaA=;
 b=NCq07mOVxg/wxw9r/20x+rGsrt2Ie3YhJYIR+EE1GMNN4GdL1ctr9/8l
 mTApEXpP7Yh6Ivu4yKmYdCq4NNi4aK7ksm1A3nzlrJ+TXzHaiVOqtspe+
 D6B5mwadb7rurJzDuxAdXFBHyUScmd8CTlSmVJyhE7qvGNeuyEtPARW7H
 WVbMlEtMJdXXh/lKpkLIIPaeFjfxkFm2CsODV31lOYzxBot9uHFG12cKQ
 tE7JfkwwqFRxn0A+20j4AcSpp05LMo5ckkd3f3Y4JLUJ9SkwTjjD1Cwg+
 MRO4o/j513Yrclo8xhfqfD2MUFxj6KOxBsCTl1+GAf/m9q2NesjmvdWPf Q==;
X-CSE-ConnectionGUID: OegkD8AwRACdkBeHQy1/Dg==
X-CSE-MsgGUID: Wc6/ZjMiREK5TrliTN3bZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="82379013"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="82379013"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:43:28 -0800
X-CSE-ConnectionGUID: BQunIFpXTDOIHhobBZ03Iw==
X-CSE-MsgGUID: 2029o/2nS2S1I6atCjUKsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216753934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:43:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:43:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 00:43:26 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:43:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnFhskqbm2ylI73+8knJu6X3epNLCJWD3vtXjfBP4/Gxdvdln/JxTZz2ix6O3HHs9mIDQafqvjgiZ2JyevPeWTPqV1zsnUhac0J7jeyF4rWXhX6MQsiRvTLWQXlZ4tljez6qtzwUFiowDeBc6M+CO8yz+oScv0DAnqB7NAqZLu/nMIOe84hHHVhz1f7kB0VgN3TOMgoINoN5Gh2tux3V8gqLZO9OwYEXcKaj0x1yji7U69sscPmcY9+buiAEyXaEN447FwFFqzLnilrN3tpUQNkHhQcAJkA7ivgUlGYB+9gDiDcodHkbHwO2ZnSBJQFtVh/aqHLSXRmaNd4me2AY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCPwuELAO+xXnT9NBVocqaZxhAVrAU/lyYyOhixxWqY=;
 b=kQDw5bFWqZgpJy5BkxD0M+c6QQ/h2AzE6dxfUZJSRJnrhaPCKe0p/U+RRO4dYGobosGxr5mAE92TjpL7gcIrsWTYB2l0CsNVfuuu8UNSf48grfyOCkXXFDF7/lLWBGLFD69rUbEuTRsteUfwm+k08z8U0Z7hNwpPPuBLQ7nkBQuAVcBkQjxt7gb7gucv2ugTtmKAqBdkgiN63PkiOu43995vXqatlQPdoYVlotUN7zXYHVgAIhG8MjrIV7jtc7KA2r+hZ+BupDsO/nVQmoxayc4X8KrQCJR+IH0BSuqAxOwuDbNqKqI/krENXuZhMFegnLexgcvkvZhKfE6yEdym9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 08:43:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:43:24 +0000
Date: Thu, 12 Feb 2026 08:43:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 20/35] net/intel: write descriptors using non-volatile
 pointers
Message-ID: <aY2SpmczIfc_l67T@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65710@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65710@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e93893-d26c-4efd-78d7-08de6a12c8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ej1S/feiYDJLAHaxGOKZCtnms0UBVISvBcVhbzDrhiUpC6we7xVIHT9oCA?=
 =?iso-8859-1?Q?F4x0mKZZilP5u1F0Cdy3nc3zfFuLO4+WNODAEHQQAgwQj1Omuyd8PlYAtG?=
 =?iso-8859-1?Q?a/lP68mMlLzL0+dlt3aio3K3a3tqcFbtaDquU6efLNBnPMyTuD0oyUV5m4?=
 =?iso-8859-1?Q?EGpaKwV/HnJDHfdXb7XD69XohTzuPNXJEWay2zcOvNEDin2i5V+1A5nqw5?=
 =?iso-8859-1?Q?rF8LxRFFyCBIco/+sqX+uqZrvDVufKUTN54EbWv4+W0GCE1zURp5xSSCOB?=
 =?iso-8859-1?Q?msdq4tbcQwOO7hl8M1SpHET5LL0+rNdHt4EKhGW5rIZI3hOVF9MtihL8x4?=
 =?iso-8859-1?Q?T0tLbnBqoBe/dx21hMpHaspcoxG+zIwtCsNf68zVuB4qJJEVDTca5ukI2J?=
 =?iso-8859-1?Q?E3/TkiOs2nliqRtwPrm0nSE+WHXQggCRa3eNeS+V3WmPpeSPksvFvIUA6L?=
 =?iso-8859-1?Q?vdJJgOa2swN4zvlY4gbU2n7uauZzSKdjoG0diRFP4AGRYXVtKJOFCv4yCd?=
 =?iso-8859-1?Q?R64D9iaZm1+kHlq0P2hQ73ONl9kon+8yVZITVIlb7+hwXVI1xVEGj76Yhq?=
 =?iso-8859-1?Q?l5uBmPz0yiMIq7N278S4jfuRMdR3mO2FAwpqYLsRyRp7ztVM94FImVhs9I?=
 =?iso-8859-1?Q?adBF3PuEwxnxVo8PpqNLu+pztOgdhYvXCA00rAbvJNVZvNqUw6VVCdclAq?=
 =?iso-8859-1?Q?weqU/tL9zEdJdvE7jBbhcaJ8ulOo6kWbg/2ZJ9mCmoKftObgJrMZdOclw/?=
 =?iso-8859-1?Q?iws9ZsBRsXJSG7IskbO4ViSWtuiLnn+xazGU11zJ58QWQ/PRaBbjyxVjIG?=
 =?iso-8859-1?Q?r0XvYHX1/flhCHgtgaX6Gb/VxJtfkMS8UExSJTzzX75+20cZFrHgRJIcrU?=
 =?iso-8859-1?Q?g7rXGZOq+obu4er3Sw8OJFzousTExBRd8RjNoPOwEoUEIZpRoG6fz7ZBp+?=
 =?iso-8859-1?Q?xSq7mGfJg4D1R5yY8kqzq2pBA76BUw2Ir+MP4A1VOO9XTZAABrIqstxy6x?=
 =?iso-8859-1?Q?k1Q+JH7jfzTkG+j5kQ+48lwrpU/NgddjUSk5GT4zdo5k8XbYkt4Zm73+Cp?=
 =?iso-8859-1?Q?lUoGCjtEFbluFXqVuTfxaMERZuo28v0HT5tumvFgRKgSQyCQPuj+7XSYrz?=
 =?iso-8859-1?Q?V5J2lZFXbMSRSD7nuDqiAEOhqbrhzwm7n67oazqt4iUL+f5suhBK70h2Wb?=
 =?iso-8859-1?Q?RTUJzVxRbwnwJvMAqAvbT9/iOyWMpCD0c7kaeE1Uh6OSHU0ExxO5f+yYGP?=
 =?iso-8859-1?Q?xBVfqgKGMHMXTMGjS793MlndYCJBm/F0v3DAuXq3JyIb1yuCbtofP+6mzn?=
 =?iso-8859-1?Q?DQzUssX68/RhvhjCDvSvvUk3yJ5BmcELePOMHsKi5dmi7fjJIF256qli8l?=
 =?iso-8859-1?Q?EQMv9hDRIbfN+9XJjenjEaVNrc10TZRH5m7/cPFp7eFhu/Q2VwMdbyxBGA?=
 =?iso-8859-1?Q?fCuPyT9l7urbonM8Jy0dbxa0pTsY+rbwBhFr2i2K+QCKmEHIfn0BOWjPFd?=
 =?iso-8859-1?Q?kNCPgTI9uALOgXuzM07X0gStnCEtlMTtN6fy5mWyisG/9ME0f8szQfzUXE?=
 =?iso-8859-1?Q?LlidX3ZUNxZde92Ob6qy3qvmQWHsiwYB/LeS9IqyJY+JShcH4h1G8LF7Pd?=
 =?iso-8859-1?Q?0sglTvBKes+kM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2u2u7i/hQvaRWLsLW+cKdKHW6sCHJqqMWfbkCWsYMl+gFsyovDmxpcsRi6?=
 =?iso-8859-1?Q?rJLdJu0ERazsCc+5KBEAf6fUxBdkEgSAeMgfV15Wb82YC90Cgn1KMvJ6dV?=
 =?iso-8859-1?Q?SKC2dFm/Vec7+F000Pj14YZdqC8DCOyoerp153bNd9QL+OKGoSOIWSAuOL?=
 =?iso-8859-1?Q?R3GxYxx+iJH+C6kV4nQaw/uJJm4UTa/Us7QwjI45RR719qMWhbaSLL5t6U?=
 =?iso-8859-1?Q?zgHA/bB4aNMXskzUzuLuvvMRb15XGjAG++BiZXMEd1I4NGqh2f9QcVtvcs?=
 =?iso-8859-1?Q?iYLMczm5BrjRtdXuViP3VdP3yYsp/ELbGcbQAuFN1XfaZiUhGlavYAXnQi?=
 =?iso-8859-1?Q?F113O++Za9OK3nvihZE6rWhaQRqAkj6c7Tb3nvyd3+DnHjbC7wfaix8f1u?=
 =?iso-8859-1?Q?vwwu+3CtJl0Hgj7yWQ08Lh5T+1wG2MO4dP0kL5rzslb+L8qabWGeNgXo3J?=
 =?iso-8859-1?Q?UngSQL82eB49CGwxfyodQB1/l1k2IZBDZuMllhRJy6VSTQoGLd2vVzOVS6?=
 =?iso-8859-1?Q?1KRlQLZj27FDAdB6W8PE2DCuSd6kH8en2uKB5kXCNOy96Sgy2/i6+Z1yoZ?=
 =?iso-8859-1?Q?6v5yQ3gzPcQbvwm2i/ABZ3d+wyqS8cfRNdInETg420dMrwPXu4MX6RGyKg?=
 =?iso-8859-1?Q?0JM/eSqC98BFCSyh2snTgN+WJzM7bone1Ta2mkpPVG574BudK8HdSXgoYs?=
 =?iso-8859-1?Q?OliNkG3BSFwMLUFgUz+j4F+XwKXQq1g/iJZWY2ZaxQgjDBg1gRJ5qFWDWG?=
 =?iso-8859-1?Q?O8CVxgonemwZlPmskZQJo4rXBTfSfFoHqK0KJ1ZDF8bszF95tt/njijZQw?=
 =?iso-8859-1?Q?vyFgokwW8QtI7V+b61y/k+kOZ6X7aJU60Pbw9wZ2EJyjpVwWlO7k5qFgCa?=
 =?iso-8859-1?Q?eiz7zVihsAUL6UccndLkU6aqQfLmSw/nmayC3bhpBm1goR0H/TUcFROwxL?=
 =?iso-8859-1?Q?u4VIzHDat1WjFs/U8wTi3JLnxog4KdEh76YcpZNz/3h46oNn+pLP+AUFiJ?=
 =?iso-8859-1?Q?MOlgp66/vElUptmKLMmWIxvy69nJBeouCf4eXCb06m+PRzGatP+Gk/WSbH?=
 =?iso-8859-1?Q?RPNuAmp9N0Ang0fbDcjdvf9phlWTlv4qVbSzicxd/UxlZHYdO/YkOrxYhD?=
 =?iso-8859-1?Q?4GbiXDO2Y1kgVrCw1xyPcwo2mzBR98YL+ptL/pMD9amabxeyRlOFbDIe26?=
 =?iso-8859-1?Q?emtgLL6I2fnWi6lkjLiHH7iqzZGB+BI/QBbdNJeu5jhuSDCKonRf+WAo8H?=
 =?iso-8859-1?Q?PKnQp1+fnmNQoSV61CE1eCKEnph6Ek0OPBIrzem4oElF+G1X0cX6cedCUC?=
 =?iso-8859-1?Q?TY9clyYnTtvStARXMy8/R1pbNR/Lv0vi+zg7yOPLRh9NkkXz9iubfcSRa1?=
 =?iso-8859-1?Q?OKWkMCOtFGkkI+Tx9ccj/0Y9Qd8iw4smRzU7KCAWkniDErVE9nQlf7yWiQ?=
 =?iso-8859-1?Q?+lWRBeQA6DhpGLu2YHDYawJldSPrdgpIS7zayyjQdRuNJWqN9WpWq914lc?=
 =?iso-8859-1?Q?HLHGN53kfb1/IOkun0C715XLNqMQbnptUonFOJDTaNqAOAFhAQjSI/gT3o?=
 =?iso-8859-1?Q?pyfLcQpco7kA1v1pc286JThS5NQY+EiWb02Qd8QCVwOFtRig74+EyxQInU?=
 =?iso-8859-1?Q?HDYvsw2M6wAsPvzgKS+CuUXCAbqH8cIrRYKeLcv3/+ETLY1Ychv8XFe6Uv?=
 =?iso-8859-1?Q?g0xhCn6hcoO+GK4/zLVywKIEcsKN8wrzKxbvwWme3JLuvNK62ypSsdY3Kq?=
 =?iso-8859-1?Q?NN3grhZy/zQUrilcgbY6nWZ4ddYY5DzMY7vF6d/ydYDFOqqDvDQSG7mIg2?=
 =?iso-8859-1?Q?TYDtyth3ForMiHo9xTWF2wuT99anbuk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e93893-d26c-4efd-78d7-08de6a12c8a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 08:43:24.2456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyEej4tmccKBDJNpJQCaZ7pdbNVZ8RKbieap0tqsAfdqCGj3iDMXmRD2n8pVU05BURNqv3Vm6fMB0HoPqGbZl1TOA+mwm6RqRHx+zV0b5yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
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

On Wed, Feb 11, 2026 at 10:14:20PM +0100, Morten Brørup wrote:
> > +static inline void
> > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > +{
> > +	/* we use an aligned structure and cast away the volatile to
> > allow the compiler
> > +	 * to opportunistically optimize the two 64-bit writes as a
> > single 128-bit write.
> > +	 */
> > +	__rte_aligned(16) struct txdesc {
> > +		uint64_t qw0, qw1;
> 
> The documentation for __rte_aligned() says [1] it must be between the "struct" keyword and the name of the structure.
> I.e. it should be:
> struct __rte_aligned(16) txdesc {
> 
Thanks. I should read the docs more! If no other patches need rework, I'll
just fix this on apply.

/Bruce
