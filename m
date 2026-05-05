Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DCCD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 17:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F72440684;
	Tue,  5 May 2026 19:05:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 33E4B4064E
 for <dev@dpdk.org>; Tue,  5 May 2026 19:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778000706; x=1809536706;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wjbWt/WkctR/1/1ueLoo0OqyprCZw7OfrE9cvkmyOV0=;
 b=DeTV/0pf2re5umnJwEKBjOCgQsAQeJ3xGQNGGh2YSA0tvTfeJ2G1jHXp
 CUaop6hSBgJp8lI8wlcd0w+UE4tyHN/mKbo9xQy9n1Yh2CRJaEQZSZE6g
 +JtwQHoRa3v7fNYvmi58/xHtDnxwc3c5kMAu+/+B8I2feeAwbJBSSEr6T
 dbRw/G70e3uQmFtExzxVCS4+YfHJUlohVH9xX2SJ7oDnLjITPtPPjDxID
 Y6umtCbHC4KFYs00UGqgLQZ1CrcAyJsp1a1Zu+FinSpIBmlihQ3wk534M
 cWsSU0GErA9G/pdjur5f+rU8WmMiO1+7RYArTq6x2dXdLgkEsj3EkQWHR A==;
X-CSE-ConnectionGUID: 3tBzQZBRRB649a+MHVsk6g==
X-CSE-MsgGUID: xuN1FwjpT7u9D9FYVD2Zyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90336738"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="90336738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 10:05:05 -0700
X-CSE-ConnectionGUID: KzGIZauFRX+K31odDMMMWA==
X-CSE-MsgGUID: DOb+yEfjShOtYfB80F8dTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="236121684"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 10:05:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:05:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 10:05:03 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 10:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZECtFkJfyLAkUQr1K1CVmsqLGJJhrd1/K3YJp2O47GYWBdhN5GxpEvzAYMLLn/5Fy1WKPhms1ChL5tYsWguNgkH5kO8TSeRIkFhux5KiTc/8Dt7BXFAxWFiF1FDtx7y4qPJXKhrRK4BsaYpwDfAvLQWXOOh9CTEb2MNbEqpiU426uq3+rNcNQx/v00MNjwvofIzAOKTtQ8kgHyqjg3SEY6Eea9xDtcq2xRQc9OsFTJ+GmI5dSayuGlAZSGdkB8Mjvy8ivTW6BtnRFk2vVtQ61ZlOg6rcJKzbhqGknVFZ3ib7g60HLB1sJZDjHX+yQxjSPz/n25Ire8ZdkXzg1NY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqIFix6s+iNpp9VzQRVhbkWQ59wcUjTJ7y2yPPnjwoo=;
 b=gEW3N8gddgK3bWj86ysF3n4EjGa76CxRiFX2lcRKjk3AmLRBLxQpbz6p/0qNlIfyb3q1RkGZOPFMv2PIVWwuOxab6QpZ4gc3MyU/NK7Z+ORvHYU2nqmUNczZSDQrkTiKDINNlCqelZf4dMHzpVxueIg5iv5jt4K/K7yGstiTtoaCtPhT23stYs7PCtE1fjmPTtfEbf33t/Sn5ymuueZTJzcQvxixbwK9H50qABNInhmV19O+p5DL5p1yiEdeuYo3BOSgZm4EbwDKAPSLYkKig1R1FYS4gVpbuEyY5hm9gN86MFZFjmxAZVd75/xLgKJ0Zb2KRKnE2t8+GQmqbnV69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9473.namprd11.prod.outlook.com (2603:10b6:8:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 17:04:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:04:56 +0000
Date: Tue, 5 May 2026 18:04:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
Message-ID: <afojM3C73vTAgxlA@bricha3-mobl1.ger.corp.intel.com>
References: <20260430085813.230798-1-anurag.mandal@intel.com>
 <afoS_fPQcRO87406@bricha3-mobl1.ger.corp.intel.com>
 <CY5PR11MB6116EB1F473401DD8338FFE2E43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6116EB1F473401DD8338FFE2E43E2@CY5PR11MB6116.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0316.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: c34352a7-a6c0-406a-3730-08deaac86ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: iTIxqeYQi3w3U0NntI514b5XZEa4VcL0PkiiZgSxzAX6wIjOBG2U6b8SK7GsPwOvjWmlIHC4Fp7RHwtIoeeJzmyw2IRnFY5hicR2NEcQ5HY00XKhGQXYGbKUa+f72C2f9EdhCamQLjXxZJzm2CHAAjse5HdOBylqx1JqsG+dPNMtTKd7Lb0wHvWpZvfJ/nVqcrF0iL2+Ae6QkMalIVc6VCxGVvJ9X92TeQ5kQNNPItBCamvg9spA4/qD3EcA5K5wrKsAJI9lbjzSYrpJjtW1Kay/yHzWESPnLRCc3siBD5+OjLX4TjsyuuDxMTDeX0ncd9/CowgPg+IXLge4EIkqqT9d46q5vYvG2n7eugDKH17DelmwjYRRcNHHIEMZoCebTnh5/Y8jMNYcn/eQBh59XHp22SO1CvypfYIintvbhGRh8xa5GcNYfg4WEpytrDUoC5CUg6eaqfxd25cqfkB2TwnX/qEdmCSiZ4xlcr+zRVNmcgJhiPPacn8WqGX+zYaRTSvUpqctTcpmugTaS5IdfXHk0KxZRoCVDqPpznSiexH9O2mXlwwqi5alTn9VxhvxZrzjxdFXscE6Rb/LxyDgqDk84HDnppeSvKyVpOXseYoCtAdS94tl6ZNS/CPmkccvoxTfnUeYvAMY7sKdb+pGKFrsLAAhMffHNT025CQbA3gZ/CjexmXFg9AEEa2G9XYW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44FyhvlkLO3gdFcCBsRoE9M5Q5JNdPTnAPOwD+f5QvW23M5xAV2ezHg7RieU?=
 =?us-ascii?Q?9XbuDe7VVZ6Gf8BnOrtV+xYSdUy0p2mcZnjYoD+/T/JdU5x2g32mGUM+yQxx?=
 =?us-ascii?Q?Qt5Mz65xSw52rIT/FLUQMnlOR5o8jcNMakTcDxYQDpoI0biA8B8j/JooAB7N?=
 =?us-ascii?Q?CUygC0C1kB2DqKgAO4bl2B61MzJtjXCQqwqaXSPJJC2liFgMUvsycB6CvpVU?=
 =?us-ascii?Q?FZ9dNHnWQGXOmpj+e5O1dcppXtZRos5lm35wYzfUmV7hOStFFd9onksIayq5?=
 =?us-ascii?Q?4GpxqZg86OgSpmzt24JLAU153AK4EuO4Gv47htG9IZe1bKPtVTGSg7ppN0eN?=
 =?us-ascii?Q?oHtpM6Lk6aLD4lMc/AysxQh2XW9c9N7my1DPqRHPU2QCtxBTgqJ0unIXxpkG?=
 =?us-ascii?Q?4rHUS+ea33nHvNKciOzR+3964VMgFfaZ+2wHhzgSk2Ci71Sj/JeGhfMPBxjg?=
 =?us-ascii?Q?m7zzv0g3g2/CODXS34eXKOk2Idve20R6wN/3OoPO/VOLz1Z9dWy2I6ThWNzo?=
 =?us-ascii?Q?mDumv4juix6aKkmWTkIhH5j+IEjHo2OBr3L07IrdA5RnoYjX9VDiLxJpadp+?=
 =?us-ascii?Q?3OknwNfqTADBFF914oE1BoPtkughqTJSnS9UtJuY8n/fuQTWXITCS7AnqEJL?=
 =?us-ascii?Q?MW7WK7yIhszJZW8+NFQV/7sUV2iq2CZqaqgtZUNE0h5WF0TtTAkZYmq5uk7f?=
 =?us-ascii?Q?Hig7zsSfwbcx4k6Wu3BxxxAq+MbSSq0/Otto9rnhNnauiO6FuBJM51vHGH56?=
 =?us-ascii?Q?Yv6POgTVQp8y9B3UXKQOS3x6GIzPslFHqeti2Wzclxe7fZ0NaKG8ggwcwrD6?=
 =?us-ascii?Q?zmu4GEZZMj5YVzyAroc6PLcRhz8pXe0L21NHfkBn0QZnzV6TEHxqr7BaId5x?=
 =?us-ascii?Q?RVKwGUwM4S444WyiLXPD5rfFKQno5MFZRIjnAzJb0sQPhF04wnpN84CpQ62z?=
 =?us-ascii?Q?49GDkYPmBfuo7uibpuR0a10zr5fImw0y4lHs6TPjn38UXU6UxnCriwtpOD9w?=
 =?us-ascii?Q?K7jdTZMQBE9cdM2uCqxY7sfk6BD5l+gYg3+o5bk92DfhdQFQQTVJtJRm0nBB?=
 =?us-ascii?Q?teAVfCidPanJt0l1m5zc74N2uj9CxA7JeiyuX4UP/PcaSemAbDv2wRkeTddI?=
 =?us-ascii?Q?uTylXvSGOUEgVts1djj44JrOgpWXQQsHhMSAY1v1IIoRDmZdzjgIYQFKmmIN?=
 =?us-ascii?Q?bkFU6iH+cL33JvoziVd86hnrHDvIA0MArBJH48xJdjrv/8acXEzIPYPKV++R?=
 =?us-ascii?Q?FIDBrYLsO8Ot6MAu9RZiFIcTQhBkpvmio//AWS53rx6onnxogq3HmJIeWToQ?=
 =?us-ascii?Q?1FbBbaij6aHIUki/S2GiddqeUttpGE+f7m4MpC49syZKXPeGyCjmRQaiJXB1?=
 =?us-ascii?Q?MD/4tY0jFUVqe3kafujCV7oOXrvbCtGiqHURcypArilbBO4fIA/1q8DOM0ux?=
 =?us-ascii?Q?O9jGePviZSrPfriwcwhVDUm1PE0Hsi6xRPWtpJEsAfF1syvIS/qmW4uVYl9B?=
 =?us-ascii?Q?kIaxSY7VNFv6pEtqxGGHtJcVGuTEV1eO3NQvK4yBIdmAAypzwpE3mrMOwEjS?=
 =?us-ascii?Q?IfjntxRL0nypQqetx6ELXJog4McoI/4dY+9Hub818gAL9b+JPST02yt1+nOc?=
 =?us-ascii?Q?cKqwv/2Re2Lc6ig/ygRfwg65pZnq5w4PQcKAQ+qkUmTgHskrF1g3p5prbdID?=
 =?us-ascii?Q?/TnTrf/XBuuO16y+VlmKEZcnYwj78jMWH6VetkMS/OJchrC6qRN97emmSkNW?=
 =?us-ascii?Q?i+A96kXp1g154WwsVe5U560ojiJUoGA=3D?=
X-Exchange-RoutingPolicyChecked: QFDJTV+TWjGEIOJf8anCl7rv6hedLK+Ua/Wbd3FE1PlWReZok38rMPoBxXvxRYL7JEscgAG/vVwCaSbtM9g1mYbdjnOlsK9srChqkZ5FaxAoBKcxumjOPBiDm3Rnrw5MXHk+528w8T96OIRMcp0UIERkh1o0Fmjei0BUpWON5c3fwgO4yBMfPRWiTyZbYglxhMlf8MsxuKQttPinKT+c/9i6LkzlUYohvUQDpTwwU692ALkLs56pqY3M2nXSXrYDW6Uz1UzC8eSDA6rivJ29hfyd8Qa9OK1EvmPRU4cLNx2m9bT1vqubyLhg9nHuY2/j7E8Ga8qy+5vuvu0WjRp00Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c34352a7-a6c0-406a-3730-08deaac86ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:04:56.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1r3/9CUgheku5+dDoWZIidwJJxFnBrwNMIRMgjRgSMLaz7TsTWqkYxhrIhUAKaiaK0HKxwd/S7FXMySqXXWqF8R9Hk+5ATFdeMUkbLT72k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9473
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

On Tue, May 05, 2026 at 05:58:27PM +0100, Mandal, Anurag wrote:
> > -----Original Message-----
> > From: Richardson, Bruce <bruce.richardson@intel.com>
> > Sent: 05 May 2026 21:26
> > To: Mandal, Anurag <anurag.mandal@intel.com>
> > Cc: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> > Subject: Re: [PATCH] net/iavf: add support for QinQ insertion
> > 
> > On Thu, Apr 30, 2026 at 08:58:13AM +0000, Anurag Mandal wrote:
> > > QinQ insertion with VLAN TPID 0x88a8 support is absent.
> > >
> > > This patch adds support for QinQ insertion for both Outer VLAN TPIDs
> > > 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> > > VLAN Extend should be enabled for the same and Outer VLAN TPID should
> > > be set properly for TPID 0x88a8.
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > 
> > In general, looks good. One query below.
> > 
> > > ---
> > >  doc/guides/nics/intel_vf.rst        | 19 ++++++++++
> > >  drivers/net/intel/iavf/iavf.h       |  1 +
> > >  drivers/net/intel/iavf/iavf_vchnl.c | 56
> > > +++++++++++++++++++++++++++--
> > >  3 files changed, 74 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/doc/guides/nics/intel_vf.rst
> > > b/doc/guides/nics/intel_vf.rst index dfff69b982..ce11ea6363 100644
> > > --- a/doc/guides/nics/intel_vf.rst
> > > +++ b/doc/guides/nics/intel_vf.rst
> > > @@ -802,3 +802,22 @@ To start ``testpmd``, and enable QinQ strip for
> > default TPID on port 0:
> > >
> > >     testpmd> vlan set extend on 0
> > >     testpmd> vlan set qinq_strip on 0
> > > +
> > > +QinQ Configuration
> > > +~~~~~~~~~~~~~~~~~~
> > > +
> > > +When using QinQ Tx offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``),
> > > +you must also enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND``
> > > +to configure the hardware for double VLAN mode.
> > > +Without this, only the inner VLAN tag will be inserted.
> > > +
> > > +Example::
> > > +
> > > +  struct rte_eth_conf port_conf = {
> > > +      .rxmode = {
> > > +          .offloads = RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
> > > +      },
> > > +      .txmode = {
> > > +          .offloads = RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
> > > +      },
> > > +  };
> > > diff --git a/drivers/net/intel/iavf/iavf.h
> > > b/drivers/net/intel/iavf/iavf.h index 6a77dacf59..0b6ed221d0 100644
> > > --- a/drivers/net/intel/iavf/iavf.h
> > > +++ b/drivers/net/intel/iavf/iavf.h
> > > @@ -459,6 +459,7 @@ int iavf_get_supported_rxdid(struct iavf_adapter
> > > *adapter);  int iavf_config_vlan_strip_v2(struct iavf_adapter
> > > *adapter, bool enable);  int iavf_config_outer_vlan_strip_v2(struct
> > > iavf_adapter *adapter, bool enable);  int
> > > iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
> > > +int iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter,
> > > +bool enable);
> > >  int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
> > >  			 bool add);
> > >  int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter); diff
> > > --git a/drivers/net/intel/iavf/iavf_vchnl.c
> > > b/drivers/net/intel/iavf/iavf_vchnl.c
> > > index c2f340db81..6dd7d455ba 100644
> > > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > > @@ -920,6 +920,51 @@ iavf_config_vlan_strip_v2(struct iavf_adapter
> > *adapter, bool enable)
> > >  	return ret;
> > >  }
> > >
> > > +int
> > > +iavf_config_outer_vlan_insert_v2(struct iavf_adapter *adapter, bool
> > > +enable) {
> > > +	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
> > > +	struct virtchnl_vlan_supported_caps *insertion_caps;
> > > +	struct virtchnl_vlan_setting vlan_insert;
> > > +	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
> > > +	struct iavf_cmd_info args;
> > > +	uint32_t *ethertype;
> > > +	int ret;
> > > +
> > > +	memset(&vlan_insert, 0, sizeof(vlan_insert));
> > > +	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
> > > +
> > > +	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_88A8) &&
> > > +	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > > +	    adapter->tpid == RTE_ETHER_TYPE_QINQ) {
> > > +		ethertype = &vlan_insert.outer_ethertype_setting;
> > > +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_88A8;
> > > +	} else if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100)
> > &&
> > > +		   (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE) &&
> > > +		   adapter->tpid == RTE_ETHER_TYPE_VLAN) {
> > > +		ethertype = &vlan_insert.outer_ethertype_setting;
> > > +		*ethertype = VIRTCHNL_VLAN_ETHERTYPE_8100;
> > > +	} else {
> > > +		return -ENOTSUP;
> > > +	}
> > > +
> > > +	vlan_insert.vport_id = vf->vsi_res->vsi_id;
> > > +
> > > +	args.ops = enable ? VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 :
> > > +			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
> > > +	args.in_args = (uint8_t *)&vlan_insert;
> > > +	args.in_args_size = sizeof(vlan_insert);
> > > +	args.out_buffer = msg_buf;
> > > +	args.out_size = IAVF_AQ_BUF_SZ;
> > > +	ret = iavf_execute_vf_cmd_safe(adapter, &args);
> > > +	if (ret)
> > > +		PMD_DRV_LOG(ERR, "fail to execute command %s",
> > > +			    enable ?
> > "VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2" :
> > > +
> > "VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2");
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  int
> > >  iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
> > > { @@ -929,14 +974,21 @@ iavf_config_vlan_insert_v2(struct iavf_adapter
> > > *adapter, bool enable)
> > >  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
> > >  	struct iavf_cmd_info args;
> > >  	uint32_t *ethertype;
> > > +	bool qinq = adapter->dev_data->dev_conf.rxmode.offloads &
> > > +		    RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
> > > +	bool insert_qinq = adapter->dev_data->dev_conf.txmode.offloads &
> > > +			   RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
> > >  	int ret;
> > >
> > > +	if (qinq && insert_qinq)
> > > +		iavf_config_outer_vlan_insert_v2(adapter, enable);
> > > +
> > >  	insertion_caps = &vf->vlan_v2_caps.offloads.insertion_support;
> > >
> > > -	if ((insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> > > +	if (!qinq && (insertion_caps->outer &
> > VIRTCHNL_VLAN_ETHERTYPE_8100)
> > > +&&
> > >  	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
> > >  		ethertype = &vlan_insert.outer_ethertype_setting;
> > > -	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)
> > &&
> > > +	else if (qinq && (insertion_caps->inner &
> > > +VIRTCHNL_VLAN_ETHERTYPE_8100) &&
> > >  		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
> > >  		ethertype = &vlan_insert.inner_ethertype_setting;
> > 
> > Is this not a functional change for existing code/apps? Is it possible that there
> > are apps which are depending on the current behaviour with no QinQ support?
> > 
> > /Bruce
> 
> Hi Bruce, 
> 
> Thank you for the review.
> 
> QinQ insertion support is already present in IAVF PMD for TPID 0x8100 (802.1Q).
> Meaning double VLAN insertion resulting in packets having 0x8100 (802.1Q) + 0x8100 (802.1Q), is already supported.
> 
> QinQ insertion with VLAN TPID 0x88a8 support is absent.
> This patch adds support for QinQ insertion for both Outer VLAN TPIDs 0x88a8 (802.1ad).
> So, double VLAN insertion resulting in packets having 0x88a8 (802.1ad) + + 0x8100 (802.1Q) is achieved by this patch.

Right. However, the change above adds an additional condition to the check:

	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100)

meaning that while previously this check passed if the
insertion_caps->inner value matched, now it only matches if the inner value
matches AND qinq flag is set. Will that not break apps that rely upon the
old behaviour?

/Bruce
