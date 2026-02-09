Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14816E7E0C7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39397402B0;
	Mon,  9 Feb 2026 12:16:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 74B9C4027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770635797; x=1802171797;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/BhxDpm/dwwsyrqcdLfKdIHv0UzZz+9C1KRjelaAdOs=;
 b=DgFSMq67jQGe8FXnIzJyTQAPBKB3gbVZyr2nvB/1C6aHOkRMCRZ2tHTz
 3DEvY0jJuwsfH9zStm/UUjt/bFn/8mcPHM7LlLDXirQ0kWGAjjT3WwNlK
 qLtMRsKwAXrgsRENbD0rFhVzJQ9hTsJw5oai9rxeC6HHc2mvLQaWDb64W
 7BYlS3v/ZSIoi9wSYzg8+hr8FxKdIOtrVF23luXL9xegS2bWfwSoxnWzA
 Gn8OvNOtvff5ZrwYdyNqKzDikBGxecjUodJFF+wtJIqT9PsxWuUGraKfw
 0qHJWzDDWSRLX5czQTwsP5BoG6ElNy16baMlhPrKszoCQCY/VuKp/xjlI w==;
X-CSE-ConnectionGUID: HCEC4zZBSBufacYWdanP2A==
X-CSE-MsgGUID: 5kgJTQXsTKyABVmj/k/22A==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="89327589"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="89327589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:16:36 -0800
X-CSE-ConnectionGUID: KM81P+6lT0im5wEKgp6b0A==
X-CSE-MsgGUID: LZxP25gtRSGeRZJRgzS2mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210717572"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:16:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:16:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 03:16:36 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVSC+Fa+j1DCXh/cC1sPS8LOqcDqmTV8FCd1Gmk4550SIfcR6cz+/joif2tWAiQhUHlpgXjs1HWlpR/W1CsuCuQ7nvDEb6tbnADK8gSGtbF+RuykO/Lqw8Jt7HoboC5OnzIkRqEFy01GMu4P0fdl/OScCuUGGei8vuzglfgE6AJuBq13+hIEtUrZgu8leNs3ZjglVjyZTyV2SZn8V7aEQ++ZIm62LQ7QsyOvz2INQxT4qyhVTNQ5I2Hv5kZn7Tav+tLgm8xsb3/1IDdk2oU7vToW/pqVcZL8Ucg8QIoqPtkM0ogm5AnGQ96iFLdZarxpaNyGL/zay9Jii4nTsk5ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvqRcJz6DwSgd2xHsE5zSp6ubKZzEcpK1l0SBX4LJPQ=;
 b=CbslhpIWEBE7fff4Xl0lMVPaviQv4g5GP5Lwkbl1g99tbma9xnGYW5OgrROCjdWGD2hzKm5+gR7Dnvw9cV0jJ7H3m4GFUjDWH+tU6PtvR8g5P+X+Khn0oQ6lXu4Xj5JxFVz0+mtwXYUml6qY9h0ibUYVvcjfuteJlPOrt4yHVDt2+bWW5o9EGtYNMM03kEK2+VylgIk89utrM86c3x7ZY/5RQ6Iotsrc7UsMnmJALuyCtRD03dTxag3QtzvkMWeYCZhmi4o8aO6sIfVnbBQvXqBAHmuPLaYziAtiqqha8qIDY8mLCSF/K+/KreFzYxPDj7N3gWnYza7N5pQhqQrJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 11:16:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:16:32 +0000
Date: Mon, 9 Feb 2026 11:16:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 07/36] net/ice: refactor context descriptor handling
Message-ID: <aYnCDDpCXbDKQjCI@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-8-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1224BFADE205E81D651D98E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1224BFADE205E81D651D98E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU6P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: c88780b2-0513-4015-8bb1-08de67ccae0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oryam/WkLctdV8QHkXi91yv6JjZFdle6tcvc2GD2/gm2kRNeArwbBvsQOLAy?=
 =?us-ascii?Q?xQkUUXy8uipsZPq+Qla3sxtA/mDvE4Gk4wETQ+WWJi+0k3zBjCjyjIbLKnxP?=
 =?us-ascii?Q?s3nLX8Bd6O9D+R600EUKmI7lqXoWKb+VhCDnW0QUZ0QVxZ0YShb0PqO7QeRZ?=
 =?us-ascii?Q?FDI1weGr2X10zlVKMArRtP6ic0974h19ww1ieEYf2O2atINWeEZVJIx8jd6y?=
 =?us-ascii?Q?Zh2ky/ZtsWVbsFG1oVCB81ArA89sUsi39i6xPWSq0QgJDlyVYeL7XyCYTgQ5?=
 =?us-ascii?Q?+2cTf0HIWVw+OwVbKvk7Mj+w3mi5ZWZp9CvbGG91ubNV/mN992lHGT5PDS81?=
 =?us-ascii?Q?1euGHwislyL9Pez36UgS+xyMXK1/unQcuUheRnIkKyPH/kVCX/Y8F3cHpAlB?=
 =?us-ascii?Q?EtGZwdntR67zL3yaIeKsFnheRlO1h5OOZXYgiQ3OgUrB9ht7FKFdLf95nQED?=
 =?us-ascii?Q?QNrFw54xx7ChBkzIca+VTm73DyyRc26bl+FMj0lilqAnDJnqzvRwbRAtfPvR?=
 =?us-ascii?Q?yXi8/cv8anaxIyP0ea1y+QtjBMPbiVAZUtSI6w4Qb0Id7QbuPTqUJ3qUw7RB?=
 =?us-ascii?Q?NNJK8GQ3pgLbEzoPskoWeWqjP+CurXDNa8Kk9DWVf2D9U462R8NbTNB45Jok?=
 =?us-ascii?Q?bMSVtkUW251m10k7xgoY7EZ6+BlpNdGqzj/8cerLIhhEDTBAJ1A1uZPgxjGf?=
 =?us-ascii?Q?qyx+w9MiSlM+dgYFuagPdDXyf57b4uiGW+/gqC7emORh5ZhylXLX7jcWvG08?=
 =?us-ascii?Q?AFCYaK2STgJaFcZojwO+fvK6EN1Q1KRAx11dcLGhJa/vCC9nsPp87b7QpgMV?=
 =?us-ascii?Q?RrQtRSGcfflLYB1sIhs6ou14GL2UHO3L6SJlA8ELZxglThxUwM3tQiswMzSd?=
 =?us-ascii?Q?e+EhRBtPYvESN5OX9JWTUzcAROlpJmuxqlwmtG6+H5O39nJBa/tZhhvbKBe1?=
 =?us-ascii?Q?VI3HAajZWydn68ikfue1HWqzSOcE5eAxWWKsalwpEmr9H0/gZwt+cChoJAql?=
 =?us-ascii?Q?30S+8fCMajO5X4j8TE/IlYlHxnfzyYzsR69Jo4D93upzFX7NVYbJKVum/6xb?=
 =?us-ascii?Q?H8RptrHH5CLx9j5kWRRKKtp5OIYZywtDJ3BG2I9zBhKFRKfR3vLlEBP1Wqcc?=
 =?us-ascii?Q?KsQIGJqbKdpCCHCouuX2OHGGV7rwwzN07RitEO2IAbH8TL0i6NRFIzRC/w9N?=
 =?us-ascii?Q?bmQWXJ8eU7g2s7rtfj+s/uQOo1+NfM547wiWjqiJLA3Xn5NebzWf6PRKnJ5e?=
 =?us-ascii?Q?dhtSw3GmUHZy3LH7C0YQsJ1VdfFL5ruchPSzm63H1TD8mUz5FWV9U9xI42ld?=
 =?us-ascii?Q?P5LI/VBBI9vKM2kO9gusBf3bZf1qFSbtwt0WcSk2BaAl2m5QilCKm0FyOO18?=
 =?us-ascii?Q?5Lb43Bvx+s2S7WkXqrohxPxB6/ZoSjy27qWqKDdNEVsNPLfVSYXH9jP/+piN?=
 =?us-ascii?Q?oTgo5sIfyvjJzB56AB9n4iZTQd0LBxgzliIyG0fmTvBRpGsyR0MYwYN4vBC4?=
 =?us-ascii?Q?HsXUZ0ZMjSnfbLwYdUQPzb12n9Qk6tyfARYqy0+OEoK11KKizZ/cv/W0rndK?=
 =?us-ascii?Q?DdrAOzWuADx4OVeeMYA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tw5ajsHajzWUYb3iJ1LJP8kXjzZHeRiTEPQ0sThmqmeDIBnebFLKxQDncoCl?=
 =?us-ascii?Q?PRkmI5zXCvAXijGTfhih4uE7DOzFGu05DdXvzadcXdtmxNeK3bUTyUA035De?=
 =?us-ascii?Q?UhcG7CNKr5nslIi0wXzOytC0Sd1Pl7sQixnHSFUNmRNsrWLhBD7szR2EpmYF?=
 =?us-ascii?Q?t7v8QinW+obsKdJupzfHaDVcImWRxcAuChHlIQYN05dExmuxMRsxxs5RYQQG?=
 =?us-ascii?Q?FiFBRH8UiF0T5qX+65nGuklyn2uBPs323NE8ITqAmMPEKwHOCVVrKdpomZEP?=
 =?us-ascii?Q?pvpD35wOuVX/ca0hEldoepR/MDeLLlZPXQfxqUaOIHAMkc+/UT9WY/qvZGUy?=
 =?us-ascii?Q?thUoDBn5nmMGeVeWgkN+YpIB1AgwQAaRBhSMdgBFoPKIpc2xkV+98QL7wGOJ?=
 =?us-ascii?Q?rYJnEpU6iPwcnTC1QRqyH4TpKtw7uw1TtKQYYB9h8WSkz9bfY8bcg4LArHAy?=
 =?us-ascii?Q?IW57bQm3pyUdeUDcz91aslGCBpVc9QYX1n9uCRp9b0yWLt6uOOJylKmkiPNs?=
 =?us-ascii?Q?hlyepYpmesO9z1BNV/UGogtejLqHUUWav/exdfm2S3gnr8ufIjUQcPHZOUhS?=
 =?us-ascii?Q?iaKb7p8ZtEUy6iu5Dytqnr44g6UWrmGcUkSQpH4rchlVs6PNUz9brlgt9c9t?=
 =?us-ascii?Q?vWQCXBTp4X3uRhgaycUN0YNPClAnhPFmDRoeIIPP9M/S2bvd4a8GaNZeR6Vi?=
 =?us-ascii?Q?CzoXV1ahvQjdvQO9cnC0C0QssBM9iwa6uYx69pRI/gdpP8wbJttOqARo/uBp?=
 =?us-ascii?Q?ZzvYX8ieKdVEoqjkJTzjGMQ5K9/PYPY1BGcOjjiQHb4yIeHYpwHN1vZLH2hP?=
 =?us-ascii?Q?cQsxzHTvhvOcLnCKoTA8wgTrb7rpMTv+W3WchHVmdED6Z70wJO6ywmsr/O5F?=
 =?us-ascii?Q?9lllrAIwXlRJB98VfbmeSrt3otcYY3bgyninG0DwvSafEgDUqZEgb2afa/N/?=
 =?us-ascii?Q?7x9gCZ45D+IZlLFJuuqPZS3XzQ807F+Qw7pr2yQBUJeRaZnTSVTUDmTJv2Yn?=
 =?us-ascii?Q?gkRLucX3zSw7vWyemFQ8miUZwYaWFTgBu/CRB2PPAxl5HEB2xFih/iCuxuK/?=
 =?us-ascii?Q?gNfDwp7pY5gJork2HFvu3fCbUSUyH26bWr3nWkPYyevDdL/dJ5Ty+RO1ZE1r?=
 =?us-ascii?Q?sfh9mR2kL76m8bj33BkN49gOUIyKlIODo7IDBdmAWXUqnC+VR4WNwWhiRI8x?=
 =?us-ascii?Q?63hIjHPauAouHec0/mYPyA+/iOhClOIqW3MbQQ6KgVgBvdWiur4MlPYlKMOl?=
 =?us-ascii?Q?jTWMsoxWeTd/H8xJ30D+RMS09CIL2kI0iZlUD+jrfIjIFT9KkMahsUjdILoq?=
 =?us-ascii?Q?+lu7XF2RzwIbKuCyaqKFtn8fLhHk357CA90fHJR/HXVBBmmhPc4ATuQWHJeG?=
 =?us-ascii?Q?Q5igNi+G0kqdtlADxBGaHRV2tJBpjtlCjijtWthJYU/6GMvVgp5LhjyT0tn8?=
 =?us-ascii?Q?+THCGCI5G6F5+poYgnFr0TT57fmof8kNcmBpafycwAPcPRXpbg2HEsL2ND80?=
 =?us-ascii?Q?wjyvYgixhyW0g+LrxoQGt0dhpzAWI/PqZYH4H6qsVmoZkxIis7SEYMh7sbTX?=
 =?us-ascii?Q?IPu+TkJ1HDRy7/PnP7eziFU0/2y0JHiGgVgGLnObUXlfwI3gW7HXmYDhXH3v?=
 =?us-ascii?Q?fZMrRX6B1UvJvKnGrEEvd4oyieNnSBXrrF3f6VDVoXf4LMU56+Jum4JCfzpU?=
 =?us-ascii?Q?ezR8+B+TOssigEjk9gcQrxhA9Fu0o6biv6hnOwDff7+T5TNDFSRih9poiq+O?=
 =?us-ascii?Q?N/YKlqu1iQw/NGk4usGvRYKdQv9Xwzg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c88780b2-0513-4015-8bb1-08de67ccae0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:16:32.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IxR+hItE/Wgp2l9dgaE+32cX/8aZNbAksoLF41gtxmRuTpwYhFWvkV+oqH/ldjHBCujx6AH8lnH6RZXcsctDRVU5B5xOrwvcpbdkl1OnnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
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

On Fri, Feb 06, 2026 at 10:47:11AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 07/36] net/ice: refactor context descriptor handling
> > 
> > Create a single function to manage all context descriptor handling,
> > which returns either 0 or 1 depending on whether a descriptor is needed
> > or not, as well as returning directly the descriptor contents if
> > relevant.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_rxtx.c | 104 +++++++++++++++++--------------
> >  1 file changed, 57 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> > index 2a53b614b2..cc442fed75 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -2966,10 +2966,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
> >  			uint32_t *td_offset,
> >  			union ci_tx_offload tx_offload)
> >  {
> > -	/* Set MACLEN */
> > -	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> > -		*td_offset |= (tx_offload.l2_len >> 1)
> > -			<< CI_TX_DESC_LEN_MACLEN_S;
> > 
> >  	/* Enable L3 checksum offloads */
> >  	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
> > @@ -3052,7 +3048,7 @@ ice_calc_context_desc(uint64_t flags)
> > 
> >  /* set ice TSO context descriptor */
> >  static inline uint64_t
> > -ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
> > +ice_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf, union
> > ci_tx_offload tx_offload)
> >  {
> >  	uint64_t ctx_desc = 0;
> >  	uint32_t cd_cmd, hdr_len, cd_tso_len;
> > @@ -3063,7 +3059,7 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union
> > ci_tx_offload tx_offload)
> >  	}
> > 
> >  	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
> > -	hdr_len += (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
> > +	hdr_len += (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
> >  		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
> > 
> >  	cd_cmd = CI_TX_CTX_DESC_TSO;
> > @@ -3075,6 +3071,49 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union
> > ci_tx_offload tx_offload)
> >  	return ctx_desc;
> >  }
> > 
> > +/* compute a context descriptor if one is necessary based on the ol_flags
> > + *
> > + * Returns 0 if no descriptor is necessary.
> > + * Returns 1 if one is necessary and the contents of the descriptor are
> > returned
> > + *   in the values pointed to by qw0 and qw1. td_offset may also be modified.
> 
> Regarding the comment above, "td_offset" is not a variable in this function, I
> assume the comment is obsolete.
> 

Yes, it was a parameter previously. Will fix

/Bruce

