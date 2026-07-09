Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811EC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 10:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CE7C406B6;
	Thu,  9 Jul 2026 12:54:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C947E4060B;
 Thu,  9 Jul 2026 12:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783594451; x=1815130451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2fylzbKqbOGyGCOtzaie4PWEO1slDG2c+JeHWkDMoNY=;
 b=LZ1weSF42trrnW4JK0Iopxij8c6gVXnCjPtQsrLHcsRco6Xo5wMycl8b
 /zGBjcSggziRvHyRXgf32CnfbdkFPaK7KqYuLarXnZsKT6QU2hUz1pGzd
 73DdFdrFNu4luoNVirg8EVbrsXyHFW4mDYal+ydYrNj1c1ajnzAp6xhok
 DA1UNioE3niE1wq7pm/dnJXfp7E+ms1wozF4oa8aPvMY2vNagU2DSK5cr
 BQk6NkO65PIQqwksZ2T5Kkup+QWvKkj0T4QdRvevVbe9FVeoDYnMetMVN
 vplER1EHvarkoPQeXDoqxySU5Qo4tbj5mbuOVDE/pMlzF4gH8E8JWcEJF A==;
X-CSE-ConnectionGUID: YxTlEPU3Swqt+OBDOtSZXA==
X-CSE-MsgGUID: j+pw//i9QvWLjWM11o5eAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84150415"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84150415"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:54:10 -0700
X-CSE-ConnectionGUID: Cpl5HAPZTNCZv+B4fmbjhg==
X-CSE-MsgGUID: PRIcwEJeSUagLRzmTCy5Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251192259"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:54:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 03:54:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 03:54:09 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 03:54:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXw8AiFJMTa/H0FWLdfK+qzKiohVwcxWHJWGP846vHEa2LABDWAX0KKOwoDWxoaN0BXwU2EURtx29ImHFmQCeiOxPXHjsSI/DMxEH5RgxPca3jKdpTi8PEY5Qhak8fiqTvym6f8/anJHFvHiLkfQxW5XGMuz4/QXSzDSbTdimxArd4oKZyQGImhMvpLN3fiA/OS1ggmPc7VyKChDBRR0nao5NGzXFW7QA6jIYvFgrsAuCk6k5AYdHgUG8evHGkGzUON0vr0zXN7Np75A22iYbxYJOrCwxkN8HwwAp0ZH4OqLz7n+zQLKsMmyYIn4KCo7NB7SHnbtVzrg2jvWkIUdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS5NX1LxPHdlOmLZS7o+u4TMbXPugqQxTw6kSViXnxk=;
 b=y+5crA/GlbINrAIFPI75Cz1WyApeqc9VGrsiWoe6ujlG3JPdbRuDbPKOVMWUx3WLUispTHyTZX7j4lGrKRleERCFzIJ/PFMtZkDZqs79+1GJWGngoj5WVIFMo+EKobab4wD4ByPQ5MRYN82KechahvWXkQhAtAUHxLif8l6Jw6y8elmrzSfDTM3Dc0OsUFFO4Uw67iR/4+LtsUShmVRxFL+YDpSzaw/toBCIm0CmzFFW0hlwyqSMRZPBRMBfiXnMJ2KOX8sWMXTlY6ehSBJ5zA8AYgim/lTsj6mKdRk+cRbFO6Tpdz1HX5BoaXajbYpnWquZLAAGSd5BH4ExJN/M8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:54:06 +0000
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9]) by DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9%8]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:54:05 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 1/2] net/ice: poll AdminQ if interrupt delivery unavailable
Thread-Topic: [PATCH 1/2] net/ice: poll AdminQ if interrupt delivery
 unavailable
Thread-Index: AQHdCJsbQTqD2hQJykeqA73Bpx4azLZYh7CAgAyI5eA=
Date: Thu, 9 Jul 2026 10:54:05 +0000
Message-ID: <DS4PPF6915D992BD5C59441A77CC2852E208EFE2@DS4PPF6915D992B.namprd11.prod.outlook.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260630141627.1035420-2-ciara.loftus@intel.com>
 <akT5YUCBeqqcDxie@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <akT5YUCBeqqcDxie@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF6915D992B:EE_|DM3PPF7D18F34A1:EE_
x-ms-office365-filtering-correlation-id: d85f4f2d-e015-4171-aee2-08dedda86526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|38070700021|6133799003|11063799006|56012099006|5023799004;
x-microsoft-antispam-message-info: iLfdQHbRohKb+aPkINna8I8GHSKKGBpYLI5oZEdMAv+PQOv57CS7u1PraTgNfFjMb5Q3KmZjmJ9j/Otbb8Sag1lZDwfIezIY01qdG7vFQm9bo/HLEbiO5Esq/ab3/bLozktD9AqGtLrKWeGw9MiNB6y91ZFJEH2v75f22jUPGSE4FgiKajMNFd4QjEcz06eC1yUBz7r5hU8qT4ZKHkultk9d4qwdREdE513dFD+i8mnfGB3QXYF6Zv0qRJMNTBzBagcB62n2UDUHUkgdGxtzG4klTLsKlbDo2uZLVLQbJzSVDg15jfaYXt+6fretSDE19Cz/I1Q7HoGXX1AeAP1T3V1cgekfYAtBQn33stn50mrgd5vTwWlix7OBI61EsnPc4+QshZR/orqg5CehoiD6loNCb5wsvEHXPrNWeSmAAG2pU1itx1CQPI/8EL3keMQZ/21MoA6ZRVQhJQWrTHJknEh4UDILkHpwA/Y2ytphQMSpxuV2k3mb1mtn+qDz7me7m44slhY0ToQWBquR8W6G5jQ8W7HjOgPf5MJOA0oVOai6mWyWhbbNs8VrEknUrGkdtKB/htfyd9rz1lcAv7kTWE4Ll54JGKgoc2u9aUfiPoZa3n3dgL1HzOr9X1ULG3fKt3W+JIX52pjJOIpgI4AW10hGLSE9mgXQWoy1NduOqwZbRWpB1zjuF4EvTXea+WnvkyNUY7zpAz911AboO+Lbt+l8cbkVN5/tEpOXURbhmMw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF6915D992B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(38070700021)(6133799003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f3WLL2AhP2AfFjcdN/Ssja/aI0ffyo0lK6xpUCMvErjwCdBq4GxjT6Mxrv93?=
 =?us-ascii?Q?VUQjaMkul3S805cMEh/TmLqzjcRAGSsxMDz3HQEPemIpdt8eYfBxHyJ9w7fj?=
 =?us-ascii?Q?VyzDoCc5NaL8ARbzbCnV7qd0s74e8Ciof33EhntFQS/gZovxqiuTK7GgQsuV?=
 =?us-ascii?Q?g0eHg8RLtn0uUJwLvM+GdO4igHSbQgAoi3yN60tfdPOVrY5FLhYwifgmQse8?=
 =?us-ascii?Q?e+XOHMeRicL4cODQBf18XHHlqFExztIuGGP62NRKO0VgP1sDJHnSkAwlOoMI?=
 =?us-ascii?Q?Rbj0DApSgMlZ3MCvOhdET/Cvet1wvtZ0b/fVv+Lwg9HnK8cQQUO2YGq+M0RP?=
 =?us-ascii?Q?iIIKyJTcS3y3ucPC1EcVwu/8gCT1J7x8xspt6av3lsZQrBPC+nsRw4hOjHqQ?=
 =?us-ascii?Q?3khi0niMWTDgzMseZr9knP2AMjNOdDY8qq5qWIgw/JT5NWboGubiQ21GQUOs?=
 =?us-ascii?Q?hu6wyNWq9YeZwqbDp9+QOjqfDgMF2+fuyLl+Gn4WJXq/VzoAGzTM+Y0IJvZh?=
 =?us-ascii?Q?1knsaGaqNvIeaChh2npgq/9iwo0Xl9jOb6iNpN5ya26KZjT6Fcd9iWCYW1tP?=
 =?us-ascii?Q?YSWns84GnNJ/L6jOlO+m/AlwH4s4+16DNPNXzS4p/6nqVRU1LaANpcvlA5Vo?=
 =?us-ascii?Q?O2aoytoQLFSGtkCoSGGbKrHAxaakOxmCc0oDJu6KfCekskUVB4QrtD+nukzc?=
 =?us-ascii?Q?e55fs8vp0NyUymnyUYDRDG8kSLAlOg4z1vFEsWkw00nX2M0t7p3nrL071KVH?=
 =?us-ascii?Q?MtW3l+s6UYBSP+8L+UH3RPtfAxYz77p4UzxgMyXt666xVmnZmGuntX+MK3Az?=
 =?us-ascii?Q?GwC5c06TBAB0JJNojhns666Bk/duRnR+wIXVIPCR3OuukOa9MsvM1mFkbWii?=
 =?us-ascii?Q?4lZ1krIlgzzAAYVyyL6/Svr3pIiTRnvfyBIgkDGDgi2zXBGACaXr0+1hkMFG?=
 =?us-ascii?Q?E5TbdpIQQbwWudNGV6AZVrQzmyyoOgj2ZKN05X6q/WRTPZ+vbMKYQy+kPq8a?=
 =?us-ascii?Q?Cjj3ryUlPqQU5lvd3uMv6F8ZE6xMVBZnwJwf/Be7PuLZZ5gRKzZA1sCrsdIk?=
 =?us-ascii?Q?6QMTWgHO4FiKDd8b2RpPCEP/aQpESMd1wGUW99UWD6PRwbkW7f26aREm9Du4?=
 =?us-ascii?Q?A65gakWe5Lqq+SADdj6XC/G46B5fRiuVNoVhZBdRnY6s3U4yL53zBqobM/t2?=
 =?us-ascii?Q?r9cVO25zSgOyD5Co9qntBcYdKNln1ZskaCKKJRquIzfTQBpLUHb8ZZfUpsSi?=
 =?us-ascii?Q?h27A19A8/quHBIgno0KgfJAmEuVhjKxJQ89pzo5ZpF0qxttOl2/oIMZSh46i?=
 =?us-ascii?Q?CIGgD/xpGXl3vuw/21fVZG5pJjgNuTgubPfTHVnSVgMHlorAfGTIpw7JlEO4?=
 =?us-ascii?Q?khX0QNLM4HW3eDx/jPI/PuiE/vdsE9TjBqYhoUolOtKG8BPmx74BIXD5G6x+?=
 =?us-ascii?Q?oHafOv/HRE9VTkHndg/+M+cEH6AfccyML6QVj8qBuhZsSwsNeoTLw7qPHTi8?=
 =?us-ascii?Q?LJySz9Gs+YRHUSEGxCo96cV2TDZE9pwBJkkYCiel2UeW9tn6zdOnaHiBENIj?=
 =?us-ascii?Q?jfgqjdGzCUynD/Z7GRYoCzmB80I6Bo4sjgqzyPXPYd8QcVE1pCd+8BGBJgeB?=
 =?us-ascii?Q?bRwbAx/oxWQE+MEXSuIkX3Qzv+pcFzu+a35FNGFh3V1h2jiDtcfFcmLKd9mj?=
 =?us-ascii?Q?dXlN6jfBRsMseQezorm/vh0djg0k4v1UcB301s2jS2FAscMQ0LCy7XKZ+Lww?=
 =?us-ascii?Q?M3WOe4NJtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hSp6f7rghsuyT80ScEANSytMBGL9ZOjbX5DOZCG0H6xYHdQUvn+kJ0DqEd09V9CNjaVxUEd8IyLgVcY5ZmuhEC+CLGm0GpG2pI1RVUW1oeF+T9CBiSvfR7gI6LlXb+bRmRVgbwfSUwtYpGwW2ZauZ85YNSfcw4Wc5S35SuXLgOHuFXmRIipCXUYDeYe8VQ1Ckht7628VXJtKnpeY/znNqwFQ8j8yzoiRttzwZs5z08Nl/leUHOrPn9xvdOjyLBcOCEUIeDjoBs/7eWmwoaHStHXHM33nx6eQZUNNFPNAqfjE7XXDCc8NzFVs3bGVhMdVg9W+DVSl0txAxoWfwtP6eA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6915D992B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85f4f2d-e015-4171-aee2-08dedda86526
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 10:54:05.4372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cec9EOPEbms+8ZTWeqv8xtMf8zy1N8/0PKuNpfJGwbsueBOAAMK6WKjz5auQEPFQ/JqbPcEzc59jGZc9+JR/yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7D18F34A1
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

> Subject: Re: [PATCH 1/2] net/ice: poll AdminQ if interrupt delivery unava=
ilable
>=20
> On Tue, Jun 30, 2026 at 02:16:26PM +0000, Ciara Loftus wrote:
> > If interrupt registration fails eg. on FreeBSD with nic_uio, the ice
> > interrupt handler is never called and AdminQ messages, including
> > unsolicited link state notifications, are never processed.
> >
> > This gap has always existed but was partially masked by the blocking li=
nk
> > status poll in the ice dev_start function, which would delay some time
> > until the link was up before returning. In this case, the link status w=
as
> > typically correct after dev_start. However after that delay was removed=
 in
> > 2dd7e99855 ("net/ice: revert fix link up when starting device"), the li=
nk
> > status was often wrong after dev_start, and there was no mechanism to
> > self-correct.
> >
> > Rather than restoring the blocking wait removed by that commit which
> > would re-impose a startup delay on every platform, instead activate a
> > periodic alarm that drains the AdminQ on a 50ms interval, replicating t=
he
> > role of the interrupt handler on platforms where interrupt delivery is =
not
> > supported.
> >
> > Fixes: 2dd7e99855 ("net/ice: revert fix link up when starting device")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
>=20
> This solution seems reasonable. Some thoughts and comments inline below.
>=20
> /Bruce
>=20
> >  drivers/net/intel/ice/ice_ethdev.c | 45
> +++++++++++++++++++++++++++++-
> >  drivers/net/intel/ice/ice_ethdev.h |  1 +
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> > index 022d92a2f6..447742ff8d 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -3,6 +3,7 @@
> >   */
> >
> >  #include <rte_string_fns.h>
> > +#include <rte_alarm.h>
> >  #include <ethdev_pci.h>
> >
> >  #include <ctype.h>
> > @@ -108,7 +109,11 @@ enum ice_link_state_on_close {
> >
> >  #define ICE_RSS_LUT_GLOBAL_QUEUE_NB	64
> >
> > +/* Polling interval used when the interrupt path is unavailable */
> > +#define ICE_AQ_ALARM_INTERVAL 50000 /* us */
> > +
> >  static int ice_dev_configure(struct rte_eth_dev *dev);
> > +static void ice_aq_alarm_handler(void *param);
> >  static int ice_dev_start(struct rte_eth_dev *dev);
> >  static int ice_dev_stop(struct rte_eth_dev *dev);
> >  static int ice_dev_close(struct rte_eth_dev *dev);
> > @@ -1473,6 +1478,28 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
> >  	}
> >  }
> >
> > +/*
> > + * Alarm-based AdminQ polling handler that drains the AdminQ to proces=
s
> > + * async events, then re-arms itself.
> > + *
> > + * @param param
> > + *  The address of parameter (struct rte_eth_dev *) registered before.
> > + *
> > + * @return
> > + *  void
> > + */
> > +static void
> > +ice_aq_alarm_handler(void *param)
> > +{
> > +	struct rte_eth_dev *dev =3D (struct rte_eth_dev *)param;
> > +	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> > +
> > +	if (!pf->adapter_stopped) {
> > +		ice_handle_aq_msg(dev);
> > +		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL,
> ice_aq_alarm_handler, dev);
> > +	}
> > +}
> > +
> >  /**
> >   * Interrupt handler triggered by NIC for handling
> >   * specific interrupt.
> > @@ -2913,6 +2940,11 @@ ice_dev_stop(struct rte_eth_dev *dev)
> >  	rte_intr_efd_disable(intr_handle);
> >  	rte_intr_vec_list_free(intr_handle);
> >
> > +	if (pf->use_aq_polling) {
> > +		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
> > +		pf->use_aq_polling =3D false;
> > +	}
> > +
>=20
> Do we actually need to cancel the timer here? Since the callback itself
> only rearms on started devices, we can let the timer expire and become a
> no-op, rather than needing to explicitly cancel it here.

If we don't cancel the timer, it may fire after device memory is freed on
exit. When dev->data->dev_private is accessed in the handler, it will SEGV.
So we need the cancel in dev_stop.

>=20
> If so, and based on other suggestions I have below, we may be able to
> remove this block from stop function entirely.
>=20
> >  	pf->adapter_stopped =3D true;
> >  	dev->data->dev_started =3D 0;
> >
> > @@ -4434,7 +4466,13 @@ ice_dev_start(struct rte_eth_dev *dev)
> >  	if (ice_rxq_intr_setup(dev))
> >  		return -EIO;
> >
> > -	rte_intr_enable(pci_dev->intr_handle);
> > +	/* Fall back to polling the AdminQ via an alarm on platforms where
> > +	 * interrupt delivery is unavailable.
> > +	 */
> > +	if (rte_intr_enable(pci_dev->intr_handle) !=3D 0) {
> > +		pf->use_aq_polling =3D true;
> > +		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL,
> ice_aq_alarm_handler, dev);
> > +	}
>=20
> If alarm set fails, we should at least emit a warning, even if there is
> nothing we can really do about it.

Agree, will implement.

>=20
> Also, I don't think we need to track use_aq_polling at all. Its only use =
is
> to cancel the timer, but all places where we cancel the timer are places
> where we mark the port as stopped (with one exception, which I believe is=
 a
> separate error in the code), so the timer will self-cancel at next timeou=
t
> expiry.

As explained above I believe we need to keep the cancel in ice_dev_stop so
I will keep use_aq_polling to guard that cancel. I think it would probably
be fine to unconditionally cancel but I think it is cleaner to only cancel
if we actually set the alarm.

>=20
> >
> >  	/* Enable receiving broadcast packets and transmitting packets */
> >  	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
> > @@ -4497,6 +4535,11 @@ ice_dev_start(struct rte_eth_dev *dev)
> >  	for (i =3D 0; i < nb_txq; i++)
> >  		ice_tx_queue_stop(dev, i);
> >
> > +	if (pf->use_aq_polling) {
> > +		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
> > +		pf->use_aq_polling =3D false;
> > +	}
> > +
>=20
> As explained above, I don't think we need this block either. If we have a=
n
> error on start, then the port should be marked as stopped and the timer
> won't rearm itself after it expires.

Will remove.

>=20
> NOTE: there is an unrelated bug in the code here - at line 4550 in start,
> we set "adapter_stopped =3D false", but there is still error handling at =
line
> 4564 which causes us to jump to rx_err and stop all the rx and tx queues
> again, but neglecting to reset adapter_stopped back to true. I think we
> need to either reset it immediately after the rx_err label, or move the
> assignment down till after all potential rollback points are passed.

Will fix in a separate patch.

>=20
> >  	return -EIO;
> >  }
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> > index 20e8a13fe9..86b256fc3f 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -599,6 +599,7 @@ struct ice_pf {
> >  	struct ice_eth_stats internal_stats;
> >  	bool offset_loaded;
> >  	bool adapter_stopped;
> > +	bool use_aq_polling; /* true when interrupt path unavailable */
> >  	struct ice_flow_list flow_list;
> >  	rte_spinlock_t flow_ops_lock;
> >  	bool init_link_up;
> > --
> > 2.43.0
> >
