Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102ECCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E2ED40672;
	Wed, 15 Oct 2025 09:41:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 62DE9402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760514085; x=1792050085;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KJYapFfmOZah8QdouwiOPahM6XbSJ8Lf6M8hhfinlhA=;
 b=KsuB56wB6A2gSUmsSELwZKfBEkBPZ6zKFk8O9aI/tfB8FV6LRPYqw4Mx
 GKlo3Nf27bpCxOnW9g61YWs/Q6qWjE/4gdwDyGYvHeyr/XpNVhFQbg+fj
 yyeeGLq5396Q63AaSDOhOxt1Y+qDm1pd9tL+807+XmIZYhpkj1xjEC/eg
 um3dZiHN8cjTR8vGmB4G6X20OyTxhlNmbM2Y7om+qX9c8yLc75zgBQQ9s
 /Tm2eITcFjcVJRpSlkS6xdob3/KBA85511BguyEHkuIC1R/n70VLwyETA
 N9pr+swWvla91c9GoS+ftN6Eh4VRIwTzOoO+w88oAgWiCLp/jEhGHujTR w==;
X-CSE-ConnectionGUID: UhsSBFmFSbyEQGN1LUT9+A==
X-CSE-MsgGUID: drhCHN/ESKyfiN5FRuT1lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74131712"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="74131712"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 00:41:24 -0700
X-CSE-ConnectionGUID: ybAMZIegQpSUczw+4Ef9AA==
X-CSE-MsgGUID: ZZgZDJ7aQJCxjK8Sf+3NIA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 00:41:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:41:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 00:41:23 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 00:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVP8P1GixPjWNnmsk/ePE4LosfMVI4Nyq/31Xm2gwdOt8fXg4WALFTFiej6T0HBM8ohz1kxnEh9YUHyz4Pw3LuxUOaSOcMtJ1KQrQU8yN+AixWrcwiCaua5JTpDIvLCWLBRYikBKOpPdYKFYOD3ix8BZM3HTVCqLJ9aVbbc2/SLmgyPwA7WJEPiIiRfqJ60qLWbtyB2XWx/cKKJLlGnPdu9BbHXlIVYybBenF0lfb46FO/p1BWwUiOsEk5SibSwJzmnBJm+zUQQFesqtV17ZJ9aJOwd7DAJTOvy1PDnChs89xOLo46nYqorlxIno+PrkupUBQx4JnBCpbDedxrvTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFHP3StKC0VKftpUV8uppke17Gfxq/iLegixttukcCI=;
 b=tfOu7FZ/wPIrjAT0vebtRmzi6Yf4UYlKucEb0X3lMvhnADz2Yg44SYyamihStaXMj8cNayHYrCM2/EHx1uRB9gVG/36qR+b8uitVhzMvfs9micP56nvKprmzSHQ/S0nxsldPII1TMeDojVpLQvq8P+QBauIVT2DyDezd9LpHu1dIRGXSOmglEPCx+qwajP9lTlyc3SSBfxgamLIhjbs7+7zF8IXBz7qGE6Edo0WQbs1XjTVDNIvFA7a1pIjRcfIKjof/lGYMJRKjl5aE/FmCK9zGxhqg3J8A/PBm8iWqw9INUjwsUxv3UnYd5OB3W2WYXBNSbvvlXmdGCn3hVvHA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 07:41:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 07:41:15 +0000
Date: Wed, 15 Oct 2025 08:41:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 2/2] mailmap: sort mailmap
Message-ID: <aO9QFopivyfSCal_@bricha3-mobl1.ger.corp.intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-3-bruce.richardson@intel.com>
 <PH7PR12MB8596E4E3C090C148BA8A528582E8A@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB8596E4E3C090C148BA8A528582E8A@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0309.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: db996c4a-052c-4d96-275b-08de0bbe38b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8MulS5ToxYzHexjpjW+r87xOL7CDzTSQnlcHNfwpOvzPjxXht5A6kNlVU/0v?=
 =?us-ascii?Q?CbYpdwyih2xt8fsm3TjEnJb/LTfZZ+imRPuwmZwfWRH2wa6I1tcZg3SHi6D2?=
 =?us-ascii?Q?3E/i9vfoNpgCbE9++2ickdNabuY2hFgVtMd6xEDh10EyBXsh0D7Y1yUp2AZu?=
 =?us-ascii?Q?CdOMZBEL+9SOdFivcaj4F07FQtcrgLzCfukUP+y4IXNba1qEFcJ32kdSyaiN?=
 =?us-ascii?Q?sfbcsxphTwa8aRCRDrzj7UUF70l2vyWAvwihN45HH3Eo7x/xLR6eCS053K5G?=
 =?us-ascii?Q?XZSqTyxEXJRE6bgCT47TnMQ6K5kXKVFzfGutElAKt8NRvwi/PsYlcc9bhFbx?=
 =?us-ascii?Q?ZDHXchfWRU3FGW1FQz3hzjRPqKtrxpJ1jak58JlSMr92uA+EQdYbCCRYUzkT?=
 =?us-ascii?Q?HR0dz3Wpx2LfMdnQ6QhXSsWC2sQ74a72cuwe8TbktbGibnH5J0LSAbZ8T+38?=
 =?us-ascii?Q?a7p5UTtRCHdqP4KT4YgyMnilYusy5QZ2IwpzbHorwjb5DAG8zb8l3MFkE0rf?=
 =?us-ascii?Q?LNDhas/00ebV1OPUAwlbLH3I/blMa7LLIABxBPwIkaCGu+IrB51HowXC7EJM?=
 =?us-ascii?Q?y0i2jcXheR6Yqp1O8RyEE6Q3aBOuTQx2QK9ifTpgY7hUfdnHqjNHLrUWlMOt?=
 =?us-ascii?Q?B4fpkyrxBbYnXXW+j1L5jy1szi5u4O9P7H4mrF5KGcRD9jGOd9Bt1WHGVDwg?=
 =?us-ascii?Q?2maK1hn6locc7O9keTpYmxMPXsSeVT75ctKuodbfXs5mGhnmuR57lTG0p0IR?=
 =?us-ascii?Q?VxfQvGr7YY7fmy7h2YxiNdTFzBm7tr4ohcDze89vjOWb6msP6t0EYNjz0lZx?=
 =?us-ascii?Q?XXx2fxCau2lA/g12HYzwurxzA+vwNvkbOrjYQutjmXmB35uozAVUZz/FuOmr?=
 =?us-ascii?Q?IXgZzfMSk5HnZqG/pwO8SPCvTFFgJ2UWLQvjBZ/09Mrg/iuuoftc/c41aNEt?=
 =?us-ascii?Q?YwBQWa6k+uio1Nl1V561FkqmbUp5W3FLaWO5Kuev7+LtmWL9zLUYhKReLyaq?=
 =?us-ascii?Q?45aLYQl0TXegPz8TIHLA7f0TVDMoRUhgGoyfTmxMoOU9VjlzAyS9ra/9dwHf?=
 =?us-ascii?Q?rkk0t7ZNmK3bFua6sbiIh9xhMrkAXcf7b/Y4/dxjVcxaQeAabNxMilYL1FxI?=
 =?us-ascii?Q?P/NpziZsNZI/ov7lCHnqaUEi1hdu8QliYIBNvInhKX6Rio+kElXOWvW9jaH/?=
 =?us-ascii?Q?skUKLGGcxVBtBBqnMwS8hgT/XrepbqCvNkMTpwlcuJ16xXf1k+aW8mRMb+My?=
 =?us-ascii?Q?f9h9vhoRbCAth1hrtRsHi4CuHlb6ahrBq7nPSRDZjp0ZoO6P4o5/xKqTHAgx?=
 =?us-ascii?Q?YMtn6FXpDVWcf9bqFY71gmTjiG2JddKXjgOXJDbZON+TfYi4v4uLMLb3DI98?=
 =?us-ascii?Q?s6jMNjhqR6mJAc2XVfZ16qFld1MPkYEdFTfdI4II3wdqsTpK5p8hAMbxhQtQ?=
 =?us-ascii?Q?NY4X3TJyo8PRVSnukduh14QX/Lt0wr2c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2nJLd94J9UAAqIHCwz0z6yFo2WjtCLmI7pK2jytDflOYQeHVGo17lwV7j3Y6?=
 =?us-ascii?Q?QbRbugQcPbLFsCip8ltJb84kzymZ/GO44WIVSn8v8zbQN6GOLyAWwS1pkLhf?=
 =?us-ascii?Q?Jmy5Oaku/FgC5xrxOZ4v7LEACmdv3YLVsOoX8ww9mEGGFL7dlfM4Ppfzx/1H?=
 =?us-ascii?Q?KX65HuOS7JroVMjForIIPOLmFoaqBucWt9zxom+6OaE+jSGAlOmxo9JlpjUA?=
 =?us-ascii?Q?3Sn4SXw/fMAu4jcwyslvUa281sRG4SO8pfdbhMxF25LnBc36qdG0dCmsVe4Q?=
 =?us-ascii?Q?Dds9dYGUAkxhvhCg1dJmxagcNqpMlsKT45l4Cwgpp3k2UHTs46bPhU5BhFrY?=
 =?us-ascii?Q?nGu8UNiQAeXRkkIiNe7L91jVkku0izcS4wIo2SGdrGJ90CeD2Esfi+fsKSXM?=
 =?us-ascii?Q?vbI0T8YqXm25mv4tFoMGCfVQYpBsWmeytKp7RrMLs7cBP6SN+cZmHVZ/lKc9?=
 =?us-ascii?Q?dKQs2EgmJcjA1xphTfGDR1gv14/Dv+553HcKlD2VGWB27sf5KSJh203hcso3?=
 =?us-ascii?Q?Y7KYkW5oyiuuQhT6zUGZ+jcV87CNceHcBWqHH7Dpqw/NQevJulpbyICsHbZg?=
 =?us-ascii?Q?3/XdnemcHkQcLBKbqJBWYd7ViVtmqrKLNwnwpCIhuWfnc0VMFaocwPkOF2ee?=
 =?us-ascii?Q?eH7W+ZoEA1hF25w4QzfaADqg1UxWKZZtB1OrAwojE+rE9FLfwYxFxfxZGuGr?=
 =?us-ascii?Q?pX00H8H2+4KiZMJNX/5z04Wv/IH6oh9RpLDgOvHWWvBqrO8BjQHy+QN67CEw?=
 =?us-ascii?Q?02nC9rldnA3Auh0K3kuuwXqUas9T3wDZgjY0uUkP4mDX3TGheuX46mwr1tUz?=
 =?us-ascii?Q?ifY6/a3ys0zUcVkfSj4YHxn0atlu7YfBBAmDLJhzWsb9uMPQ/0RBqybkBPxT?=
 =?us-ascii?Q?uwZE1TSxCO0h8MjWnFELnVjAFWzBWh+SrXMTWoYSQfcGC4EmqyLKXPDLs/5r?=
 =?us-ascii?Q?iBVTpZSDb361JzktWPHIHUnIuFoOmSTxkXwgFYJGvc5YN0o2BZ9C87ifk5BJ?=
 =?us-ascii?Q?U9qO7zYvefc3pTuy44F/DeKhg1TrRQGTbLr40xyxMxCbrwFQcSIw4zQD+Rqh?=
 =?us-ascii?Q?PxAPBkNyi5XYzDKYSpdH1e0ORUAz67d8py/zzV5H6DgGtFraq4TzZrnSXObe?=
 =?us-ascii?Q?/U+jVep71dYZK/fQwNvzQoB21D0r/cKMQNpSGh+yXy991kGslx1FBbL/KEF/?=
 =?us-ascii?Q?MjYicp+7FV4dPuFhRBkklxBHhSnczcAyg8ERULB3fkjshIIWbwxIlaGv1DUV?=
 =?us-ascii?Q?1Se8GGQ35QozDin/nHenNLCfrGNNuT8c/9qqUCuwuDOBVeNbianAgvgzj78o?=
 =?us-ascii?Q?RfkWVgp2a2c5nB/JETYjRFvOpnK2PsPubQxLrv1io9xr8zz/w7OQJZXaoLVE?=
 =?us-ascii?Q?vyVwzq1NPAsxwT0Yl9JiM9xJUR0GzD5QEru+SubvqJyR6o/OZVADc8LmqE6e?=
 =?us-ascii?Q?g1pXWS7M21k0XBnOThN4tNo6RZIIDkmHxGXhbC8/ITaDXpY0JjPRHPuevycQ?=
 =?us-ascii?Q?JVVzGETKjbmR8geGqYrlAnCjGh5mtHcOXWa30Ud5730ejVI2KAZNQTDp7UX1?=
 =?us-ascii?Q?x8vEjB367ndPnG5d2B8RjahHmiAhEcfhF+9/1OTaQQpDIhIxFiWnzmp1/K/+?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db996c4a-052c-4d96-275b-08de0bbe38b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 07:41:15.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7fLAP4AmxkWNcsAyaaxgASk5ZCVKRycwXOHJZnoDSGSTjH4PxaJKIDb17RNtoa3YCqDvF66OuYSrn/7b55nLqZT2OvPR5NVGhZ21MmT5c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
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

On Wed, Oct 15, 2025 at 07:38:32AM +0000, Varghese, Vipin wrote:
> [Public]
> 
> +1 for the change
> 
> > +Vipin Padmam Ramesh <vipinp@vmware.com>
> >  Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>
> 
> Should we update, ` Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>` to ` Vipin Varghese <vipin.varghese@amd.com>`
>
I don't think so. That would result in all your commits made under the old
email address being counted as written by a different person. The map entry
is to map the old email address to the new one.

/Bruce 
