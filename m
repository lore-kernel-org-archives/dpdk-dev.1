Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D1C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 10:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06174410F1;
	Tue, 15 Sep 2026 12:19:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 2ACC8402BA
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789467555; x=1821003555;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MJi9nYGYpDYcsdWr3QeKaXQAN1wOTs8LSiYDqfjEP7E=;
 b=D2PAbkPAA5ZTZEbLewcCn+WUYKqOMpLpADP/rO1bKzf3Ib0KhOqYAi/P
 4PhTwiq4hGOjlJ0BAki3IjKgB5sMFqOtOOWbMaHBrNhTVCUtd4Y+0bBLp
 lev8QPzpsvSel48AdNY9vH6oEJD5v05Xltx1GXir6Odr7WOjraRHZKkq3
 PeJgaS4mYt9rdb4uzgRVgXCZBGmUoiOpEVh/2wLzMS8kGRjaLH/kJares
 UO1APjE6XhWB5TAuAX3e/fUo4aCX+t30SZdGHlsYFBJ0h2wlF+JF8Hghf
 W0ZaFWybcq7CZBSUdJ6/zbmaYc99IfoyZulA/dTh+KPwhVHxDsvDYeRbe Q==;
X-CSE-ConnectionGUID: wQjkfEHmTmqyPDuEDCduaA==
X-CSE-MsgGUID: n+UiQawuSM6DMSYCTcQDYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="335477"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="335477"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:19:13 -0700
X-CSE-ConnectionGUID: M8e0mU5ORo+mdofkadDAUg==
X-CSE-MsgGUID: YMFDxsnDTnOqU85R8nsPMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="302839193"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 03:19:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:19:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 03:19:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 03:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/iP/U0mq5ngpS/rBbqkh1wsG+UPqywhUZNSX8y75dUtkJak8nBhnIMdb7ORYUVzNsT3TboXxwDBEnuldpXFwJp4zfq7zA26hZJ3K7w3rlw5iuXpSVtl/2+mOYSbiLA1gc9ipCoxpVZvwMwNFFj7efuXOieNpPA556bVoTu7rEjwp3VbkrKJefYq8eCPZkMVVxGe3U5eWrJ7ZZkmYWPD/t+eq1WUQppwKT6txkxV+QbNYP2IfhVnB/jprWq+NfzHcN5q095AP7fbXV50BoVADFtdaDEH3mn7YpomFJ/qrJwADZxLBUW7e9LE0+jfZnWYLEA0GwGO69YECE2HM1HIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/827Mdsdws+dy4VLfRTKk+uOqEFuO2kpLvCo3yCwpk=;
 b=W9wxZ6vvd4zKEXJArFUJzs+O2eAffSS++QDKjVIXgIphDqnWBVSzhgG40kRz4OJ6gEg+A52+CCCqtGKl8PJPp5CjHLOCEo3LPDs9x9jw+dfw9fGOAx6L9Hfgfd0P/QMCJD4yP+pDA4qplSjXcgS2ZMAg3Ewibt3xnsTVp40ruAbr7CVopuFbveqw5edMDnP/JUK/e7z2tpSPAX300S8END6k9SRKanezctKUw7pluulxmF0YOZZrsymQKBtn92SbvUHH8K5olWZpk52MepI0sM3m75JK3t0E9u1FiFc7uAXGdCMFYu0PqcFNcesR6BefPF6JVqPYM/WiVtlwktrJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by MW4PR11MB7079.namprd11.prod.outlook.com
 (2603:10b6:303:22b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 10:19:08 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 10:19:08 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/ice: add per-queue Tx rate limit support
Thread-Topic: [PATCH] net/ice: add per-queue Tx rate limit support
Thread-Index: AQHdQQt/mEEgr3dwOE+/3zpwKRLUSLbHnIqAgAfQZPA=
Date: Tue, 15 Sep 2026 10:19:08 +0000
Message-ID: <AT6PR11MB044526A42C6B7BE8BBFDFA1C35E4BA2@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
 <aqKGofPyWqWVWEwK@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aqKGofPyWqWVWEwK@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|MW4PR11MB7079:EE_
x-ms-office365-filtering-correlation-id: 12968012-8fc0-4a55-e099-08df1312c760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: sZABdl9Ei9n38++XKblWNC/r9OOc7DFwhMDobw+87u22Y7w21ckOpcd4dvAQ5uRPJ0mQWiwIarfz61VYrjbYjyX0WURF1nWHiv8lg5ysAQxMK534bq02fOqiNSaxSgJMh9/l4IQVrVWo0scHKydXk3XoJb7YIFDDFM2umu3zIXUJWnpkEAazT4cmz7m5qNxV3F7WQ3a/QGag1hnZaAroRgZIh3f+l5j76QwR3chN6RiwcVoWHugGwL9uF48GTSC7D1ZM7NPdeGfXNyulqM0DQis6GlKuWq+bbQMMd0yHpOA23ggnncmHhzFpd/Qi91FTcux4WZCThfzaKYNSSaucGRmbrTu2dkmYjRa2bSD8KK1336lqwqFgVLsWmnS2APmP3YtEP+/cG2vX4NtPku0DWHYIMQtQUF9sAL8414KpSAvQTxqT/EhqB8ZguSSaWehUcN62I6e2tj8ruA1LOcbWHiuHmD42oO2rneSxx5xxYuVtnJaf08+3kSFTCYXZSUPLtPk0C4beEBuzG0Sev/F3I+R8bDqor33KKE2GG8jz0NZlNNWLx4JqWYS4SEWIWb+lDQpAAlZiPKdxG0LsMmKZ+AsqXyhogEnzvSjXzJBxU6KJvzUDsUXwIDCHtVwFuQhUgeQDVODFVN0eCkDZzJFGH5lMc1JnfH+KI9l+1a5hRFDO/p0KzH9N9JaVO+YP02IfiHRelaV9zWqMD4c+xmcD4JfY3xlNaPd5XwdzDyTsR/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?St2sob8R8PlEQurBWThyohfq8xpaLcoGkzF1hGzxyNek6HKJn3qSsY9Yp01r?=
 =?us-ascii?Q?CVxa065vX7/Lch3Et6GSeD0vPSxO4XR0/GysQzB4g1o6ZzkE1DNCWat7Z1jQ?=
 =?us-ascii?Q?wXPNe/2zTZHaBzTXkE2YKbrrPUTr89DSP4YsdAScLlOmKZ+ye/GaHPbLSvEh?=
 =?us-ascii?Q?wYJnLU3+UHRDsSmlQXNO6Ol2MyZkFrF6ucdkRZr9/v/IzBHOxdjDmxqp9ach?=
 =?us-ascii?Q?OETNsGgL0XIUm8DQrLfSHqCR98lzSxUyK/IlWtrfEPznRQKDeJFQQls9C/KS?=
 =?us-ascii?Q?MzVpZnoXXLwf63Uz2L6k48U9tkC1Ym5jI7QaDHlLkdCS8mrC55vc4fZqqrYL?=
 =?us-ascii?Q?883BT+9rWCdY8VLqxSXlEFIu3SDxndohQtclTe+JymufkPHBGlNRVbtB71kd?=
 =?us-ascii?Q?Z1S7YPyN97kAI3exWWq2dPgG3Y5/4VR4msx59PGdw6dkpR+9GNz3/M6ZZZLP?=
 =?us-ascii?Q?0bprWNGCAXImK/GOHrkNWT3DBLxm4asm6MC4+kUXA+DeB69lnHZ4Gz4h3OAZ?=
 =?us-ascii?Q?l0uv00CYz4VJTZgHgsw0OZWIcZNjeLG3fCoioDxB/iCEZR//AuvrwnPmQwHJ?=
 =?us-ascii?Q?9dBPfuaicxc9dC0gpewmoQJqSqlxY2jycYq1BthDTp9WV3Vs2qUUevBTmBfY?=
 =?us-ascii?Q?pLZ82p7KxacYmBYdd0h0wgrl9XnqXpm/eDttDGLojcG/A7QOPUS2IycLVhNX?=
 =?us-ascii?Q?GSJtbmWZTY/8H+E9jQglv+vD24EkNxz/61h7QkJ2QQYJ665l7lPEB0yrPU5g?=
 =?us-ascii?Q?Au2MOl9AHhGRLir/F8gVExa9OtTVa7PEbu0tiVzwOw5/lIF98+qVw/EUTcrD?=
 =?us-ascii?Q?swesXgms3wNE4dxR7x1UlmdGtFsdAiPGrYdTvSfK+/FQLrbtpUDc7gW//pDG?=
 =?us-ascii?Q?aalx/2f/6c6HaiFRYzFxbMgaxx7lSCKiqL+kGTnd2EAlFyjR9aAe09V75ZQh?=
 =?us-ascii?Q?f69oxzISDTPdS49zVALUUQYwCHvVqO8RNFsymjIyzrcJUQlP3NOAaryUsT9r?=
 =?us-ascii?Q?gkfR/9/JEnZ0xP1oP9A/oCJkznDYV3dYIh2F2Uv9FqaeJboPvDsXdQxygbUq?=
 =?us-ascii?Q?gQ2UpjrAgt5MiMVeHqdJ+7AKJgQqUGms7ubDvHg+FtRu/jOka31hBRD5MliP?=
 =?us-ascii?Q?z5ctMpathTkcLBWC4N0k9uhW8g2NLcc70ebNd8U9UxBNMsVYtDu4nY6My3L/?=
 =?us-ascii?Q?4qV7wZQxUs/kXoY2Ntj1zheJDynp0kKtOy9m5t7Jbp3c/3FiezTOVOXAuLtl?=
 =?us-ascii?Q?Kmmqal/Y8dFlPU7dB6m9a653xZPMwLtIkkyvhh+0vEkZx8nIN4ooKS4FUwLW?=
 =?us-ascii?Q?Z/X3VXhLvAMxwTplUWOW6dutEnEa+x8psZyLXpHP0BbBhi60bgTGEzeLLHBb?=
 =?us-ascii?Q?sfzxwzFIcJi4YoIemP3ARf3pAG5VbOy2eHg+d1+pB9MPq5foEfgbgMDkYZSL?=
 =?us-ascii?Q?ovrNRhehYH42m6W4XoYuYr/M5tGd4vkigyt3uy1MAywEJAFXseLjlgrVldSK?=
 =?us-ascii?Q?e7i7MxWflxyt8/vqe+vO2MKaaFp/Z/3Siiz3lOl9kjFBexmFL+rTw7XXB4rr?=
 =?us-ascii?Q?xq0Pf4lnyNG7CS3hFmiinnQ2WBOHIb358eWorigKAaYv+3h7cAujXXcLOily?=
 =?us-ascii?Q?+E3ZbMTdowS6MguHpTsvXIn9GjdkY2Z8osYyq2EN4aFjNj5CNhykU/QUhGcV?=
 =?us-ascii?Q?CRUsLeLfBc5q4ArESjOMwVncUfxjmcYnaqSee3l/UK+txYM/kMPjDNMsuUDN?=
 =?us-ascii?Q?CkeMukCWJw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KKikwb6Fr/jxTIrilLXtG6v7e5IvbED5/ebaRaIgQxSbBK+dUSiQ4+6rdxj9p0JF2TmFvm3u5+rk8PSnmD+mHI9mhI/CUNYB+SAGKt+NIHpYQ9rx4rBNPlVkspmL9eF8XZ7iwcmU9inU7Devsqo4eJ4Lu828wl6tO/S1/dVpP/hX6yZfjDlb9gA7FXpPVKk814+9OdtfbjJqXI50hmZqmHckVIkoX2tSWdHy/BC2nR3525+bxURBByGR0h6Cld1wRMZnmrWN4WATh28dvhRqGvuIHwmvzRz57d1T0HOXWVuEoWOeiXvnm6Ld1nWCM+8gzIJwDhZlNSBiU0hi9FitiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12968012-8fc0-4a55-e099-08df1312c760
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 10:19:08.4653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zprOjRoXLl3C3sGKbH+NBbnbWUNHZ54CIlGYbhrSJI6E0HxqVXF+mv+63o0fyvoEEs4DWD7sfSnW1+o096PRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
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

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 10 September 2026 16:00
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Burakov, Anatoly <anatoly.burakov@intel.com>
> Subject: Re: [PATCH] net/ice: add per-queue Tx rate limit support
>=20
> On Thu, Sep 10, 2026 at 10:04:32AM +0000, Anurag Mandal wrote:
> > The Tx rate can be limited per queue with ethdev operation
> > ``rte_eth_set_queue_rate_limit()``
> > and can be read through ``rte_eth_get_queue_rate_limit()``.
> >
> > This feature uses the hardware packet pacing mechanism to enforce a
> > data rate on individual Tx queues without tearing down the queue.
> >
> > The rate is specified in Mbps.
> >
> > ice_set_queue_rate_limit() applies the requested rate as the EIR
> > (maximum bandwidth) limit of the queue scheduler node using
> > ice_cfg_q_bw_lmt(), converting the Mbps value taken by the API to the
> > Kbps expected by the scheduler.
> > A rate of 0 removes the limit and restores the default bandwidth via
> > ice_cfg_q_bw_dflt_lmt().
> >
> > ice_get_queue_rate_limit() reads back the value cached in the queue
> > context by the scheduler on a successful set, and reports 0 when the
> > queue runs unlimited.
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> >  doc/guides/nics/features/ice.ini       |  1 +
> >  doc/guides/rel_notes/release_26_11.rst |  3 +
> >  drivers/net/intel/ice/ice_ethdev.c     | 77 ++++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+)
> >
> Is this functionality not overlapping with what the rte_rm APIs provide f=
or
> ice? Using the rte_rm hierarchies, it's possible to rate limit a queue, n=
o?
>=20
> /Bruce

Hi Bruce,

I am guessing you meant rte_tm APIs instead of rte_rm.
Yes, the two paths ultimately program the same hardware field.
But, there are few reasons I still think the ethdev op is worth having:
1. rte_tm commit bounces the port. This does not.=20
    So adjusting one queue's rate through rte_tm drops traffic on every que=
ue and bounces the link.
2. VSI subtree is rebuilt for rte_tm :
 	a. Stop the port if running
	b. Walk the VSI root up or down to the new layer, freeing sibling subtrees
	c. free_sched_node_recursive() - tear down the existing scheduler subtree
	d. create_sched_node_recursive() - rebuild it, ice_sched_add_elems() per n=
ode
	e. Recompute pf->main_vsi->nb_qps, then ice_alloc_lan_q_ctx() to resize qu=
eue contexts
	f. Restart the port
3. ixgbe & txgbe pmds also implement both.

Thanks,
Anurag M
   =20
