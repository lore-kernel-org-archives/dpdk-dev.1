Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E32C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:49:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD2F34042E;
	Wed,  4 Jun 2025 11:49:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 408474029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749030549; x=1780566549;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CMr04AlD2+MoESfko+cNmtJjExvnBg/jWwIHcCCdDmo=;
 b=O6H5TDzWY7nG2gDF/4uj0ND7ePwbB5aa7w/YzzjuQLgCOB5lRRR4l4PP
 g7F1X0sS4KQ74B2bmdEhuUMq8IuPDMY8/hxmTBOZUsNb/Dz1Jr/6Z2OWl
 IiA+2Y8QTXCa2YTryVE1rDw420yg3YmY7wuetXppRKsX3NuATFgu/2PUM
 SkxMykaqjTp/a7DTg+2NLXUaAE9S5H7Q2r40Ffnh0lzyXhqViVx/E/a0k
 kRr8d6Ft1UzARHpKeGuwqElNovCvuSWlD84r0YGi/2RTqVawa0iHHf4zV
 BxTtqruYqYvS8c2ter8BFxSmFMCWm3IhNsnajJ2JKsqJ39uJSW+xc6poM w==;
X-CSE-ConnectionGUID: Lr7XyIqTSOahw+v9mocT7A==
X-CSE-MsgGUID: IWL7CGvOQOejdznDqNzC+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68539773"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="68539773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:49:08 -0700
X-CSE-ConnectionGUID: uFZdj+bZRSGzNFRGL2qL0A==
X-CSE-MsgGUID: NZs/+Ab5SzSsb5KomYfFQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="146087975"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:49:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:49:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:49:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUsHJXA2rj/NXOv72/ppy3MAF9XXpuQgQizJXjKzPE4RiAvBOcp96ezjEYLriUy4aAlXkH28ol/eYdriWdAP1VGAuBLlR+raHXuZdUWuWR4iXvNPnlIZ3UqvYnVtkQoLM0zoq+Mb+mHg4YRN+hA6i9plUFydT9F9kKK7oDCCyt7lfR6R/qBrI+UE2keWMRNyjZEDo2wWo19BJMDP4M0bA/EWobP3T31+C7RtA3dd/y6JkKs6fc3CLh66MjxUSXCaeZGXt/JxId/ENvPVN6NDEU1BB5zJuB0R0tWRwyK2JoDyVfO9Y8S8Ps+RnPDZhVbC/d47a22i6zzdMMj2MuKGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnB4jHASuUeDbZAf9Ltc3p+ix7AApcuPtOtKOyn0gFw=;
 b=tV6WIQgViCzdAopTX8Dnsa8ry9nzmjR608Kwl3EoBat58szJQOrT4t0RI+Ez0Yy6g2qp6u8uJmYR8PAzkWnhR7uC+X/9EzcZxRAUctkbWkv5LFG1y8nZEH3oM1nxbWOhB0jFlJ5VahhCHwqfZoaiEVZ/c6Qf9iaJejZMm2T7E1D0irn+WojZc72SVKH8SXKQ9EzILaDSG8aBY5c80EAcWF5VqLagxIDNSK/zEjXKzpcDy/ggKQndU57RcEkZbPwAG0dnb0gU8Mrn9JXD0/q2y/xacK0O/ZuIVhRbyV/V9znNrh+h103kn/PUwic9tH/4AkYosr/BHDOdtpSKkEykTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 4 Jun
 2025 09:49:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 09:49:04 +0000
Date: Wed, 4 Jun 2025 10:49:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
Message-ID: <aEAWjK2WYvZbBs8h@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <53edc2bd68e42152358d731d51860c8606ef13a6.1748612803.git.anatoly.burakov@intel.com>
 <aEASlf7t4G8s5coz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCBD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCBD@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d93417c-215a-4af6-fcce-08dda34d0abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bb0QzqHIp9xooqujjMpnVNFE/XPoFjq4859Dxpe6oUPp3clbD4NGRfyyUA?=
 =?iso-8859-1?Q?/+3VbwzJfF0rR98CZM4Mj3zZJXdRIfvTTdztP0AeBHINgLmx07EWUPV8g5?=
 =?iso-8859-1?Q?9Pue4glWCDrlFEDMruVeGdIzWs9f/pmj3rBvKORh9ZnJMDrFWKLZIUbTM8?=
 =?iso-8859-1?Q?/mpyDm2jV1aSM1tHYkq8EGRKCm1RBuR2R8G9SocfoODWjqAx4OVfZgN9Q1?=
 =?iso-8859-1?Q?IuNPtX5a1zooz5cJ4abzJwy99WH7PWXvvqc8WP99zHql94VkuurMQKa13j?=
 =?iso-8859-1?Q?bKDNkUenZTssUT7RkBx63DkBD5ihoyt3q2sEU/Se/GcLTcNUCe12AscjKI?=
 =?iso-8859-1?Q?CsJ9lnkVQP9vk97wlIt80Np2zU+Bh465wmy4buoZ3Gxx9PWdRDlTdyPBFs?=
 =?iso-8859-1?Q?LDVVQLeF5QMfbNZBRlpoTaaugzOI2vkSwL3PVdbXaF54NOtIJUk9dKm6hp?=
 =?iso-8859-1?Q?OxQjeNYedSFAKJpQcJB+QR5ooIEmzAYbe1qQoSWQxHBYbFzEgPEeldV4R0?=
 =?iso-8859-1?Q?o5h85x3FpxzU7x9I243je56IQB6EnRMfyy/GfYSEfKXGr01V1kCLIkiamy?=
 =?iso-8859-1?Q?5CYmZduIzSisGEMCUL4y1i+eiTyYWVzc0smT2qIyduJZsPbozeMUwgivHQ?=
 =?iso-8859-1?Q?Ik6LVi4BVMbIjBUqxtvnQ0bkiCL4dUrzlPezSPxSeh7uUDV0zrlfb/InpS?=
 =?iso-8859-1?Q?dOFNAgahp61g58QP96JQgI9e1gZd0Es+cY8ygk+ycFjnb8QhaL3lTr2NtQ?=
 =?iso-8859-1?Q?35jq5ayQzr0FX1CBU8Z+pRUyo69TErhP60X9WK4pLbV/TPGO5W8iAz5sjn?=
 =?iso-8859-1?Q?oJFUmnFeZ37IlDOMz4M3YGDZn58pg3jGG6jSbftzzHXy8bGbiepT1CSKvB?=
 =?iso-8859-1?Q?zk0fuxUt9t0vMKLNJdmCqm/GvjpikfG+ykuLEZZKAqNkHQHgBgh2Kk4ecj?=
 =?iso-8859-1?Q?SxPm+mRpZslrrlISF82pgv2RD3Abk3Etzx4hMTGrvTNVNVZRF+RrwyQVyf?=
 =?iso-8859-1?Q?G90rKnyM0DD+PQOOxhnk9Y0k2HpYi9JYprteZj5xQDPb4OljugfR0pHBTA?=
 =?iso-8859-1?Q?6oLZnpSUdbg83iZg5RVayiWfpFjiu4jdPubnlVUOXVQmgCSJ9YuSfQljHn?=
 =?iso-8859-1?Q?aeV5NLFaW/MNGgFNY1tFc0QUsUswbDI2ZENJyRF9SKacyMIAsW3xyjXcv2?=
 =?iso-8859-1?Q?sSeS0ZGtEz/GVDy8iDhnwCcu7o9E1j/h/J1FlHCsUu8B5wKjELQ/4I7gpR?=
 =?iso-8859-1?Q?e8UKkuFexJrgDVuWFPcY6IevOQ70yz+vTGf18OukJUy1gfLQF6xXYP5Iq4?=
 =?iso-8859-1?Q?pqUzX8uSbWYYe9DGk9UoKnlJslPJZY1OwftR48IZ+rqAKbXa2/+9C7HIjI?=
 =?iso-8859-1?Q?7E3C3qsZ5PQNGLPAgAd7JamwFxrlI63L43zK77ePuDKFCvEpYHF6veHFph?=
 =?iso-8859-1?Q?6kTOm2vO4bLDnAB8GXmnOyj15h7/IzYgO8X+A245qZ6PX5EqQaCAP5pmf0?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VEU4vr3s3nfV/l+5UbJkiGIhIzaI56v+v5PrYO1BN6Q4RsY/MgS7rFCnsv?=
 =?iso-8859-1?Q?PUO/4kZfUGuBCCCzQEG+nh8vFADVihsAe4Rxj9eIRltKYpXra8+Kay2RiF?=
 =?iso-8859-1?Q?VPH7UQISdd11rVEbe2i0Ur+y63JdpLWA4+6v/AFivZDGUnGZ4IpSEb2eDK?=
 =?iso-8859-1?Q?7HC9DwPFnyV0VPJlXaRJaTGvKAdnIZEABFoeiFuLFz0Pczc+uPJCe/HHqB?=
 =?iso-8859-1?Q?PbvHvkAuzT/XlXZro9gs07wComqelXYiPmslG+hefxEuo9W9RiiQ06/Fj6?=
 =?iso-8859-1?Q?HpMk46sMCTFVL2Smmh82pHgoszFxGncOetn65zEwOd/Ua+szIzMi71q9eG?=
 =?iso-8859-1?Q?zTk2yRItdwxWbEZlCUAlR6G/eD67PdKBBv7qXLPbk9FzTX9jvll63q2Pd2?=
 =?iso-8859-1?Q?jtX7y8r8PX5y/3etJR5AEnouF9ORQze3CIq+2x5r9wvHAb/bPX8YuO3KzG?=
 =?iso-8859-1?Q?14cs5VNInFe4m75D06TJK6OxN4RKODc7n8JixYYvCj3+Nv0iosUygqV1CR?=
 =?iso-8859-1?Q?mf4XjQ2z5RPkt4tsiId/O71Tsx1zctijYRRZo1Uz5q5I0qha8eUqAutlJG?=
 =?iso-8859-1?Q?n6dTnv+dk2pHzA73YEI2npqWprDIt7QUj2lhKcIrYBs4XFApeXJcUdnLsy?=
 =?iso-8859-1?Q?MiHobusQANTPQjP3cfwBxj6o0BQYS7a8//+gxx8xlBoe2PZAhVkMuBAPth?=
 =?iso-8859-1?Q?nnHwR3lNhC/OR7h3sUqdJSxGJhB8S3qRRqFU6rXiNL8TjEB2fBLV8UU4tm?=
 =?iso-8859-1?Q?s7x47bczklkr/0fvdIZ8O7lQVZ1tK+AdKqdPomiEWDCmr0iXMeiOTMXRQj?=
 =?iso-8859-1?Q?/c0DjjpgjY/3llQrcb0KCGZJEicH34VZlfZAuLl+XAN1QRBQ1GuuKU0rn/?=
 =?iso-8859-1?Q?B2rEXeeHJrUk6peaEjOboSJUhsvVPshHXYYv9dk52zuTcHGc3dNsazMslD?=
 =?iso-8859-1?Q?3KEMaOnK7Mz0KfbI1rYEhL/2pdXhrmfGCJ6klqyind7ktkRe5+9P6LWDrJ?=
 =?iso-8859-1?Q?HlLLZb1b1L/uaYXGjANCqd67jWglARWZ0C5MJIer/61iPAAGfTZjVN+qYh?=
 =?iso-8859-1?Q?4CcRml49HrrpqV3eWtc1iofn4IeShbbYjSsASdRYz2FU/4e2GygA3uPRp5?=
 =?iso-8859-1?Q?UaxercERV49POLi8Vqpo9E2FeKpTK+iXxYs5401ZHG8ZOBTXQG8jfmOCfE?=
 =?iso-8859-1?Q?5BQoOvYqVCXdpyZkz+hWpDPnY/Kbs6BvlQdcS2Ed1J5CkIch5Mm4pqSDuG?=
 =?iso-8859-1?Q?jjmCMmFHGvnhQ3wRp3fgvO1jA98rzr599UbdzSCeN4LsAUmSM+KPkefTI2?=
 =?iso-8859-1?Q?wMlZUheHLHTYs+9pBGI38wGuF53v6EcEeWFxBpcbmyQv88+0y1uki3cg+R?=
 =?iso-8859-1?Q?hynIzXQplCy8WKfrKQTDsQQsAshvAbnoZpRD6cZKxOiSxwzH+slR9w5/fD?=
 =?iso-8859-1?Q?hhFQNKI8yfpyrrR11sfrXpFZH61pG+k2Aod/r8RVSlG+YI0EU7R8LVhiPv?=
 =?iso-8859-1?Q?BtcjoHThXLbyY3Wsck2gLvJpa7KddHsvEoKKCODXdc1o3vdI6lWe88GdlA?=
 =?iso-8859-1?Q?wCT+C17UmHkf460eMG87wUhl4AS/Wv4uICJCrl97JP5I1Mi0XqNogWVDsH?=
 =?iso-8859-1?Q?DXXPP/TgLNKXsdqvWYSxlMLS/A72yCbaJNR2VLg14croQ2shfAFfq8pg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d93417c-215a-4af6-fcce-08dda34d0abe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:49:04.6469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL9qggDNjK6Fza9tR+XUqpxChlGaRayKplgQuEiy2JFMLwfG90qhMouODHYX6SGuv72eS715blGKVeswwBvdqKYsbZsg8KY4LeRWUv0mPNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
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

On Wed, Jun 04, 2025 at 11:43:01AM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 4 June 2025 11.32
> > 
> > On Fri, May 30, 2025 at 02:57:15PM +0100, Anatoly Burakov wrote:
> > > There is certain amount of duplication between various drivers when
> > it
> > > comes to Rx ring rearm. This patch takes implementation from ice
> > driver
> > > as a base because it has support for no IOVA in mbuf as well as all
> > > vector implementations, and moves them to a common file.
> > >
> > > While we're at it, also make sure to use common definitions for
> > things like
> > > burst size, rearm threshold, and descriptors per loop, which is
> > currently
> > > defined separately in each driver.
> > >
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > One minor comment inline below.
> > 
> 
> [...]
> 
> > > +
> > > +static __rte_always_inline void
> > > +ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level
> > vec_level)
> > 
> > I think a comment on this function would be good to point out that
> > since
> > it's inlined from the header and the final parameter is a compile-time
> > constant, the compiler eliminates all the branches in the switch
> > statement
> > below.
> > 
> > > +{
> > > +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> > > +	uint16_t rx_id;
> > > +
> > > +	/* Pull 'n' more MBUFs into the software ring */
> > > +	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
> > > +		return;
> > > +
> > > +#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
> > > +	switch (vec_level) {
> > > +	case CI_RX_VEC_LEVEL_AVX512:
> > > +#ifdef __AVX512VL__
> > > +		_ci_rxq_rearm_avx512(rxq);
> > > +		break;
> > > +#else
> > > +		/* fall back to AVX2 */
> > > +		/* fall through */
> > > +#endif
> > > +	case CI_RX_VEC_LEVEL_AVX2:
> > > +#ifdef __AVX2__
> > > +		_ci_rxq_rearm_avx2(rxq);
> > > +		break;
> > > +#else
> > > +		/* fall back to SSE */
> > > +		/* fall through */
> > > +#endif
> > > +	case CI_RX_VEC_LEVEL_SSE:
> > > +		_ci_rxq_rearm_sse(rxq, desc_len);
> > > +		break;
> > > +	}
> > > +#else
> > > +	/* for 32-byte descriptors only support SSE */
> > > +	switch (vec_level) {
> > > +	case CI_RX_VEC_LEVEL_AVX512:
> 
> If you are respinning this patch, add "/* fall through */" here.
> 
I disagree, it's not needed and will only make the code less readable.

> > > +	case CI_RX_VEC_LEVEL_AVX2:
> 
> And here.
> 
> > > +	case CI_RX_VEC_LEVEL_SSE:
> > > +		_ci_rxq_rearm_sse(rxq);
> > > +		break;
> > > +	}
> > > +#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
> > <snip>
> 
> Please try building with 32-byte descriptors; the compiler should have complained about the implicit fall through.
> 
The fallthrough tags are not necessary where you have a list of tags
without any statements in between. It's common practice to have a couple of
values match a single switch arm, and the fallthrough is obvious in those
cases, since there are no statements between them. Once you start having
some code for a case, then you need it, since you need to make it clear
that it's not accidental.

/Bruce
