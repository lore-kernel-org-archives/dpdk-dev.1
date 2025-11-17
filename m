Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B9CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:37:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF51F40262;
	Mon, 17 Nov 2025 12:37:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 19DAD4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:37:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763379463; x=1794915463;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ulb6MvYVJ4RVflUlgRjl5qXrRONJocRq++lWxZaQ6uA=;
 b=VtXHH48bb7ezNZlBkoz4kVM7YxbroGJqe2Wow0kxeMxuP8N9Objp0dUI
 6jRxfJhZ7hssTmiwE10QCLyNR7AO0FC+sq9M01LcbbyaRggKBYsMQ2iX4
 G2offeH9F6clp9YwArlG1iAcAFk04hZXY7WJiHH/psqIfAvePPTZTkQbX
 EbpTjYpyftaDwL5t0RAU9QzI1IP9mn0tWwdNM7PugqeaSxorNGW5tJjaV
 Cu0/4kzaO8HTercGf8TRgSLWUXUMCtqdbpjCjL3HiMA74a44fufQUAYPk
 q+ieT43huN63yqaMYmHnJQAx4A4w1ygj3BRJD1Nc5/8YqORg8nJB9WvXI w==;
X-CSE-ConnectionGUID: sF7/pw3PQ7qkGf5WLKPGZA==
X-CSE-MsgGUID: eKdEX3mFReG1KYMyutlX4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65409720"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="65409720"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:37:42 -0800
X-CSE-ConnectionGUID: 1y/ERbxDQBC/ERlgtGUYlw==
X-CSE-MsgGUID: /ZmSCmJHShiAUKL+o3Auxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="194883332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:37:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:37:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 03:37:41 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3J1WJwgve/Qubdm5AOpR0VsLDTQ2B/qPBzSwtl4IDailH4Zs6lW8ETTB10L6qfn4BqZVTvAe3fwYznF2cZ7H+Cn6dwV52yzUYaEVhIJ6/kVAudS0IHuN2WwLW2sYTJXaO5cIhhRQAHR4O9KrDzPMrXqV2tu7kmrYIWqqTz/gklSZsydJLUQs5O5xB31imhjW5YRQzVzse9u9VtIbZqznwcqui0OfU3lV44oKBzDzpQx0h6Zt2kSu3zB/yqyLfclk2c4C6uqy/Fp6H/T36j8IkfBYT2tQSOOxH5PxEIXOr7QPHUfF5T2K7KA7XwJfzACIKUseaWhtNaGtqY2GXXvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFh/SrJJTjjPJwsJ2EZ8zpxWZSA0rAzRgRuxJbO4Qhk=;
 b=AlXgG6q7Kgb17EAeyfby3ykdDClxXekMfkZI0r4K+JmkgohfOqidB8rgfNb4SkzZyYk0wN9S8uilQZ/fYLXIhr/P0X/+5Kbruy5j+Uvo0Vxy+HRp7toIpAi3U4Ff9j9H6cvFh0MYPpD6pq0+mFrDP/VJfAnZ1tO/ozX388JqwYsVWI/AjMEbg9dYcSjAqosWo4axgzg5GBm27lGX5pFu/CCWtFqEBF88c+FuYwro4RjuOd9idaIhwz3ip09T/4cKcHwypMqCyb4l7dSz4G4wbhvqjf+XHYU5zDzhYE8Bkk4Xt/4C9sg9MFgotumOKB4glDP9qtAqnagLRglpcEh6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 11:37:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:37:37 +0000
Date: Mon, 17 Nov 2025 11:37:32 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 1/2] net/iavf: check if PF actually indicates Rx timestamps
Message-ID: <aRsI_E5gIPP4jsY9@bricha3-mobl1.ger.corp.intel.com>
References: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
 <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-1-3d9a0168087b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-1-3d9a0168087b@intel.com>
X-ClientProxiedBy: DUZPR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: a7060055-08a7-40ce-dbeb-08de25cdb4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NB3GuGUJL9gIcrFOVbG7Gm9GW6S5ClZQ8qUEx49MN8mItpD+53KzjnFVZn1w?=
 =?us-ascii?Q?aP3M/T5qxOSCU3+tzLlRiTZqsxLxaMtU1Tt0osOZLD3XhbQpiMHTEQOj9Woo?=
 =?us-ascii?Q?lZMtilSZWHw+bzqUBX1S4s9v0Z7+8VdeSKBHPWG9uo2vzALJoqrPi0YPt28g?=
 =?us-ascii?Q?01yr+hcY/SQOyRHHfoOlwZieRopw5kBnmn7oYig3louNj7ypoMhkEwS6qCsU?=
 =?us-ascii?Q?7YF4G5Gg2Kom9nB56PzSP/VhlMkk4KWf2P0HJjuUEJ7PCg9X1WP7dCq8wkIm?=
 =?us-ascii?Q?z2pcKi8v0nd5LD0GY09y0Yvpk0TjkfSGracAq2oyLZZJGZcNYY1036DTdD5g?=
 =?us-ascii?Q?piDcU+4ZnjeNmnnrMMlYzSIw/BOkP0HjegIq/2+TMpen0x+KLp+a3tuUtxCX?=
 =?us-ascii?Q?trPPq95jZTOl4BpVRorMdxj6H3PaCuA4tXM3hVH5sep+tvh1HdfhXDHiL3kF?=
 =?us-ascii?Q?7eDfs58hMTfNITitrQgd4mzWB22G2/DutNO1Yj1GxrWGfzV6P2I00yBUzQsg?=
 =?us-ascii?Q?G2+Lp+2wnb41xRh0/M7Omu2we2O6TLzlKlTPoIpLasw8TmvBlUXmlf0ZB60E?=
 =?us-ascii?Q?oofSAfvpQuduBvM+3Ze+EhgE19smZPpB9+4gnCzAOqM6tdFZSapre8cGSYQ5?=
 =?us-ascii?Q?fHSW6mqEiINDzwxkDVM9iwd6mY/8m767V5UoOD+9WT6XW9nVoYshwQmf47+l?=
 =?us-ascii?Q?m44/74TPizt0xzaaR6RY4FCz7s3YxirBfL2t5/nwjUW/lcx1+Te+NmuOTCJG?=
 =?us-ascii?Q?j/jjAtZlGQPP+ksAar9sWmdaf3U4TPY/mMuSwbjTt6LlppFXBMeCF86CHr7A?=
 =?us-ascii?Q?MLXonUeDb8QnJGn7qlsUrRlyY+YVUZ6oCD6Ey4/bnOR4A9XNbynCv2i+TPOo?=
 =?us-ascii?Q?G+6a4tqaFmJLPz1f8WcxpaweEhbMoc/RTPG+Yaw22Q+E6PKQcMhXWeY33Okb?=
 =?us-ascii?Q?xavJDcwppYLMBWjBZdthtp5JpJv6Wf4sYYw0qos/DQWFs/7c4T2fymloVBvL?=
 =?us-ascii?Q?12bYSAIZcHmFC+B/DHMVgBiTpr+etWgXWhz2k811eZi9GKHQiiz8njthCh+e?=
 =?us-ascii?Q?AJvzOm0N5JfZrOVGG7ZUWpleuIC7gzRg+PV8KTP2kRf0i329V2Wk0XmctXpg?=
 =?us-ascii?Q?tRDAQUC8XEaCzcFxxyQ9Ad7OScToYIvhmDEH/+/X6EYBgbNNUC2Opj47C4b0?=
 =?us-ascii?Q?T+poX1Z8KZB9KEAkN2Ku6rXbALHRsDfrvYF+ITn3qbaWdt+dOk6rrkyMJ+Ox?=
 =?us-ascii?Q?f7NMHF3lY1qyhPNl0qHAp6h4fe26paQNM/1FD5kJj9S8DZtME6vZ4bAtuHVU?=
 =?us-ascii?Q?5ARNT13Xb12ajigxhf5GNDLGfnFPtAkAXUP9hD8RxB0Xxiz9WIs5owirQCdC?=
 =?us-ascii?Q?z1V601/4uZ1L8hDpi8CE8diHtfnsa0/dGIFs4PLKSBWHeyZL7CD2FGH2zNw5?=
 =?us-ascii?Q?ro4ugYBV3ifEw1jMxAJ6MUIrw+ixyMlb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTv5KrDnfZ6SZx35w7p+jD+c91ufo8RNMBPgSfyTqDNsgRoGMawt8u2bnHzK?=
 =?us-ascii?Q?6ShOjM9L1FW4zl1IjKKen+Vhn+rD/Mcp3Z/YWu3OIyLDL/ELguEtQ39Zai4y?=
 =?us-ascii?Q?OgWpIVja3glz1CadWvrWsbIytGuStHkyYSAkBRQmyfsXOqkZjbgrXajmAErX?=
 =?us-ascii?Q?q4hLIpuJbTfETWdQ0KWeSV0IrBgOTRb0WtK1Ui0pK4MFJZn0BCRnwHfcrhSq?=
 =?us-ascii?Q?KVer8Z7cEPuLmESBI973NZSaGnPEGjKtaZNtL3q+gLmmpd/7r0rYLkC5xYVD?=
 =?us-ascii?Q?WF/OWCa7j6oFVjRx6glQLGTipFqragLkBGNvO9cega38jCuEsA6Vp8mnx4hX?=
 =?us-ascii?Q?9L17fpAIE7k76/4XBCV769oD6eEj3CbwdhJWf08nxc5aIzfpGOduZ5w0dUGJ?=
 =?us-ascii?Q?AXFWx2MuJTkDbKCIdCTTKhKF46NPFRVIMn3xzhUdqGPSG98YRd5ImEwn5Y3o?=
 =?us-ascii?Q?zGrb1rMaWtDVMVpkyp9Q4XSEsoYqp50YYBdBOvaFdsMzVzpIIaYnMLLHyj1U?=
 =?us-ascii?Q?B/mIjhuLLMmn7BT0BILc3KP+igD7mmo8uOj7SgEv9qOAqTdRAwswp4iTVaZp?=
 =?us-ascii?Q?rQWPn7rNrVfTrKdrJbWb/uZQVwI206H+yOI2eLNsygUIDyNbmiXQXgbzIxzN?=
 =?us-ascii?Q?5fU/8lYX/Z4Tv4sADeoK9oQdMLS4JD4j0bkhI9jQUsjBpTqTMQwJU54WzU1o?=
 =?us-ascii?Q?0RK27JeGW2bYPksA/hKjmG/CbWX+8Szd1YQAXOVKYjqKa/rwmM8u/MSudprI?=
 =?us-ascii?Q?P4fM85cuPTZ7Cyjl+/goU556wzTY1aIMdAmh4+uy9bLEoyIOiBhyUad9EAuo?=
 =?us-ascii?Q?3FdUzg7QIMDp37B+FX5gHKP1Rw9gwlNJeNh4+DUB+Kp+DhSLLKmdEGjUQAN2?=
 =?us-ascii?Q?KQcrh1F7Vwa7y1lu0/zVJ8zmOwEezBvm6oTnK1+cIPUeojYp8Ic9HOqENJsx?=
 =?us-ascii?Q?zkD8TdKbxbR1ybVawYlGr1MXNE9fRnnTs6TkN0M1jzcs9WfT39PSVyAv7HSa?=
 =?us-ascii?Q?Gfxl8WA6qvRhQjrYWYVeD3TSodX0K33jt1yAg5QxJJxSbkuV22zK4+qlMbOb?=
 =?us-ascii?Q?o5xKm9oE5eHt3VRN6m7ynV5/1jq+357yJI/8E9Yu4TtymtMaeHpzwJRCfy0A?=
 =?us-ascii?Q?zBISNbdQ7bnLHaHFJ4Byiz5OsAEXUDOH5/xPKKpmN9wrODpJ1bi48D3dc5oU?=
 =?us-ascii?Q?XlMuai/OxPrGJkJsSPSC8DAGMVbbUtX0l8XpsAh67igVHWDmmgOBEFRq92oN?=
 =?us-ascii?Q?DgNcFuuqRnjMw7JaNBKybGcTl1An4S6A5ekBJoftx1KeMwj5oETy0K7bHhC2?=
 =?us-ascii?Q?SbvDnY0zL8WqiQVmqcQl/oL4oe9pve36/Sgm2nWaQbcPR8FM862KCW1R4Bpr?=
 =?us-ascii?Q?3enIov9DtR3Aj7hBIRG2g0oLOS0VarZ1cTjwjfrGAZfKsUov5l3oJz8WC1jy?=
 =?us-ascii?Q?SVu0wytnnMX1HppAcIVC9kNBDN9CIfsOytEmYYiwBQplFVUAyAF6WyL7SeV7?=
 =?us-ascii?Q?xHb9qr686e4faeIRymzJmKlFDIrESdq/CLPrXEXkXjrvaYx8athxMVZnR/9P?=
 =?us-ascii?Q?xEFZwG7rAO9FPQngNNNrC2xFe7qiuDVjyvzHytmVOxVDBlHRL/a+I6zrONTz?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7060055-08a7-40ce-dbeb-08de25cdb4bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:37:37.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sqB3pDFQs8ubwkPzhWbfSwOUEotFksGW4S+mpH1B9K6t8OXpAxh4ZarhImy+9PDL5kHPKqLzkCLmIlcpEm/QgFwdEc6XNa8KnZOPuMqIOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
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

On Thu, Nov 13, 2025 at 01:33:44PM -0800, Jacob Keller wrote:
> The iavf driver has support for hardware Rx timestamps since commit h
> b5cd735132f6 ("net/iavf: enable Rx timestamp on flex descriptor").
> 
> To enable this, the VF must first negotiate PTP capabilities with the PF
> by sending the VIRTCHNL_OP_1588_PTP_GET_CAPS command, with the requested
> capabilities. The PF will respond with the actually supported subset of
> capabilities.
> 
> The PF may not actually enable Rx timestamping, even if it reports the
> overall PTP capability support. If this happens, the iavf driver logic
> will incorrectly report that Rx timestamps can be enabled despite being
> rejected by the PF.
> 
> This is unlikely in practice, as most PFs which support the
> VIRTCHNL_VF_CAP_PTP will support Rx timestamping. However, there are
> some cases where this may not be true.
> 
> Check that the PF actually reports the Rx timestamping capability
> instead of assuming it is enabled. Doing so prevents the DPDK
> application from attempting to enable Rx timestamps when they won't
> actually be enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Fixes: b5cd735132f6 ("net/iavf: enable Rx timestamp on flex descriptor")

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

