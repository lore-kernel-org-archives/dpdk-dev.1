Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C1CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:01:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D78E40264;
	Mon,  8 Sep 2025 13:01:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 867E0400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757329266; x=1788865266;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qPT+3lKiTJ4xWmhjQNRPA8T1hRazJ+ktGdtIc4++pVI=;
 b=Lqg7wmbKE/yFCtx9zKoNHMKNHU0TG2fYqeGqy1XYCQPNOLD18ABUielJ
 v0Zp8LctMbZjZhEAV0raGPg7c+iPBMTeXmCeHZiJutIwqBFhjfaeE2/6o
 tJPmQqAWSnEzOorFuoxC2c6B9P/BWACscDaE00oa+XKLOATrpDdHeUmhb
 sFjExMENsIy4x7xvx5c+jCNdzlaj+TH41oQYSJVFAUQSI0sxCFd8LCSwa
 uldd/87I5XRNNRHdrLdASEkkvhD1vHQcYbLrPMaQMzlvM1yNLsxPfEDxc
 rTXmVUctPuoFXH/o08RWv+Jt4J1wswBfC2MA4WYHBkNqauQZ9cS8aBg9s Q==;
X-CSE-ConnectionGUID: 9fYwZyvaQ42gFN48AvNUAA==
X-CSE-MsgGUID: AwldhNMlTnWbI8oXhPGgqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59440791"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="59440791"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 04:01:05 -0700
X-CSE-ConnectionGUID: TbudQf4dQsiR6V5Q+HRWzg==
X-CSE-MsgGUID: b/oL+qVoQr6qeAHNO/FTrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="196405814"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 04:01:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 04:01:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 04:01:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.87)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 04:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skqOp3AnOVkbizcpSu8fIEEdlajRJWg91rGX9bjqlXNmoJYY21BScuDCBMxGvru5x9EU8bb+EZ2JwsF6wo5c95djiH4oW1tTbvuKXtKSW+09zgkO17SfX9cEA4MYHY8w72FcW2P93jhqTvkzDAx5Be4cVeVzGBbiYZElEf8nEY8jhwdD1rxRh5isd183BRZWxtOrPnPrXOIaTYL8CQeLRxVMNeGbFP1qvh5o07yT8z44a8IXZcGRk1rh58AwRl9RJ7w5tSadIoSGl1YKlv0R+jGBpiWnisheR9vvFRWhT48zGVK9D9fGn+6x1iVh+xCBaxOoUIKxu1ZmNoMLmzHIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8tYSnUEXqT97fjWAqXnOWmxmda0E5ROj5gmSSuY3es=;
 b=JYO2ErKged4PtPYSfdESSoGa9gX7+mIhG6GeMcE3uRUhQ2ElPMItOqEXLsnigtBOtKPWPyxf8JtVqDkgc3HDpXcdQvdnrgSMG4SZ6NYJhs2k2NY0L34gbDJracxJrl6oFWrKdtWKVgje0g/hMCaEuQ9oD9nAr5L2S0c7DMMVyA/4wOF6hpSf/sSbEH6qJ2CP31H2lsc5PlZtFKYM7UTqsgQU0J+eHhJo9tuFZp1ZrBJF+NXX1WdIjJIJ3wnNrZuJDgM37WFFirt9rKUCkQj2pWmynGaYxLrKPRpJP4GWpvCiEmUkDC38Wdq0aV8AseAfgxCDbRGsRvxGbmVIXK4VXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:00:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:00:59 +0000
Date: Mon, 8 Sep 2025 12:00:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/ice: make link state configurable on device close
Message-ID: <aL63ZoyNsi1hKyyC@bricha3-mobl1.ger.corp.intel.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
 <20250829094523.1582102-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829094523.1582102-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: e865de6b-a11e-4df7-3152-08ddeec6fe23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C7VyRyf7jHUWG1mXE6p0dBvTTlp1NNJRYUzDMnffGf1oCoDfRPrJ4B3eoSfu?=
 =?us-ascii?Q?yDh2fn9g/xFu0QgwxsrsVCCICU1smnGcp/uTY0QEpSbm6Sn5czCzeaMZeZJn?=
 =?us-ascii?Q?0s/XD2I3dMkRQgw7lUjtYM5dskA+Fl9gBVtCfLnEGKScGYoD0ImfBdBJ6eCV?=
 =?us-ascii?Q?0IXcZdbYJDPwc9Tkv8yUmZaDJ/SLZoDEKyFZTjpNz3Qwi25BFZPTxJIgXZKr?=
 =?us-ascii?Q?EkWdPZrp89vWzyPerOevyr0NKyCmppNzn+9r5aXiClDw+KNrPil/MjO5wJ/d?=
 =?us-ascii?Q?Ovtv1N9NqfJSqpYi1mJZOjIHKTF59wEqdsGbispE1iiQc6yA6Yyi6gy9EMYt?=
 =?us-ascii?Q?O+1wzHI0ztPvLEcAEhE+6WKxJlpPNY4GFX4hD55h1UafTkVBtMGOK1ct8zIL?=
 =?us-ascii?Q?WaXM7M1W1oU1nSvb2qAURYfr6/i8wq3vVnA9CIAAHbB1BJxA2nXf9IEaniv8?=
 =?us-ascii?Q?7Rj1OI8rzUK/Iqem1v7fuw5pDpvxNflzqYsPYZN8amjcE6vKVhnyUAWwFP+N?=
 =?us-ascii?Q?Cht446ti6zZbxeqIa5JpBWu7jqMtoFRPeCceC7xBgQTuHKJMFTA9OfqsZPSS?=
 =?us-ascii?Q?OMlL9fFk0I95g/EdzzPRJB5amr4HD7vWMTxBfMvI61CFvnYwlJbtZ5x2fDwW?=
 =?us-ascii?Q?GIzNz8Z2BXMDa/I03vLhFYOUxekPqtFhugDNQGScNCFJ0Jv7+X7p8aQtMMUO?=
 =?us-ascii?Q?eHKQ2OkptOn2jf2PLZv9KlrFrzoBLUlieStML4kbdLCPAc92tXKYF4wu2VLj?=
 =?us-ascii?Q?IKLQqCGV0svqeCQijh38ASe/NA0q2SjLfbMmDjk9sQjM2jJHBHk3jTZJjEKm?=
 =?us-ascii?Q?rcQLe1rEPEjnZvAv4Mt7bqDrM7jDfZQ7d3iRLCXfRwnpomxHG/Ys/WUxqhwg?=
 =?us-ascii?Q?ZXnsIuhXXn4k1jsN/vqy3WuocpV10eh8mH+85BqcZh1AbyAerV6jIhQuxE+B?=
 =?us-ascii?Q?FMMxiqdxpiJa5yx51VkTV9eksYrrUfmWpbaZwj+oOSvAMyweFmdHvS/L86QQ?=
 =?us-ascii?Q?tlFUQfx5pvLaRzFKcd+FbHi/vsVQ7zXC1fGZQtNaAbr0LW5YOlp01044XjUG?=
 =?us-ascii?Q?j64ll7nUHSeiSjoARqHmP+HWgXWdVhSNl2GYYEYdp57xbA1yMJhdH2M/aLEm?=
 =?us-ascii?Q?Rn9C3Ge0Dzx7ciFICW12cKcLTEDL5a0DlcR2A/7Kr88P5YjFh423qlxJYSIs?=
 =?us-ascii?Q?RHpofb9BOI5MA7KDThDlcbWkXb9W5Fofvl1UWpSdtdRnrocaW2ZysvBoDmJD?=
 =?us-ascii?Q?FypgRom15rezzfllM7qhZHmER/k/p3dxI5sRMVuEwVq8sPjj/CVsaTfVcXb/?=
 =?us-ascii?Q?Hk6m0L2XvOxcavdghGn0yAVmQmZyCDLWzP9aeA/xJYqYX0MJ18R4/e+ZfQOT?=
 =?us-ascii?Q?nAm5N05Mlm5jyjnO6Y7nHv5e4XivBQLK6h+dhtWkk8ZsqWoFylyBaDcQvGmx?=
 =?us-ascii?Q?cxYYF1jHkxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0mY4/Ppgn/dCj6ugM+Fo+6F1fYyZukz2I97DGiCQjef3JM4QCil/khtaXiXW?=
 =?us-ascii?Q?x9lbZ96H2Z+HY3j72UuJk/UNcsUM06YkuI1IQf4L5NrCmw1FUo89Tm3RmpUv?=
 =?us-ascii?Q?/QUXu21WVzYdJU5G5cX7V/WD96bPLVb5F99rX3K1fn/xbfIHn5htaCAOGEOS?=
 =?us-ascii?Q?w0URbc9dpDPtP3UJi1aPdyPNjdbZ/pYr4cZ7RsNrtNAfBJvZgGgkwWxmEiCo?=
 =?us-ascii?Q?BMRtMo1wTNLI3tg5oCBtyFtcEVYMH6kCz39yhTgQOPrAeT7ycjCBXG6i1cvH?=
 =?us-ascii?Q?4EFbJVpk6WO8ipjsKttwWYQyrpWYiqaZ9HoIGzww1ilbBKViqn95uXj37v1v?=
 =?us-ascii?Q?kIAiyysatgiTidBTn0Lx10FXDQTQQaAmuj5L7yMIgI4LnVjWiW66mrWmv/Gs?=
 =?us-ascii?Q?/W+DzpjCm/+cEouBm8OoRvvQhxoieGw3vN710Vdct33Sh8qh+ibPdtR6/Bcn?=
 =?us-ascii?Q?TGaIZwVHTExy7K361TyWAE2nZ7ubP27VFer+iFIp61U6CnXJPMwVaU7+Zp8w?=
 =?us-ascii?Q?vEEPvaWGskNYjiPoTwOL9ekveVTtrWarWmyKozJPzyW29HanseNuIgD7YLdS?=
 =?us-ascii?Q?bhUAkcTeVXRDRvnbPadjkLpp/AzAjAw8K/QVrfraWafLca39f7DTnApS8Wss?=
 =?us-ascii?Q?I+OOaW8eK+IUX8Ld7oFdZ1DCJUc5UqytaEq3bMgoKJ1mCd1j/SaePaq9vg5d?=
 =?us-ascii?Q?1umzaBVANQd/aeXUax47+qkgUYZ3Wl6F7aj9zsDT+0vaDEaZoRXaIjdEao4H?=
 =?us-ascii?Q?HQ9QT6f1sJtWPoVyiJBzwzW/Cka91sXbIOAwAh85jU/L4MTM48dFUPtNbTzr?=
 =?us-ascii?Q?/lFXnCPqJQqG1rjONYeb00ot0CFkPanZWTn2W8lUge5w9MPC4Vv7jg+HqTOP?=
 =?us-ascii?Q?wTl5aS/bRIgPM5Ai8ZkPlmiVrnBKTmsezIDmDeQoq3/kEuBDA2WCRrT4kwuf?=
 =?us-ascii?Q?nG38QUoK0VuobUDOcYfrzsh6XwQZg52tohu5+xsdaY5nJc/I/skTN4H/yslB?=
 =?us-ascii?Q?UHyqkPMSZRM2CPMEtD4yiHXLhv+DbjXRDRvT6ToDPOH+m8KpOe3cataCMbeX?=
 =?us-ascii?Q?vMVUjvVmLUHj0dU4d639yoLPT7jmSjwtnD811hIU34Dxgssma9mYZmoqNstk?=
 =?us-ascii?Q?L0YOckcOSwGbolnN6PaqwPyJ8L8LiGIzG8Q3RI4uG71us+ZHTWRmWYnVa47B?=
 =?us-ascii?Q?QNleRwxZgh197N3SLCgaDnbPTrOd7QbTZZezWFLJKlxxVbX2lowHEukYfa0J?=
 =?us-ascii?Q?vI8ENltzh7NUrOQqHImGVl8CldM8eT/dyS9U1ASd/D+y7Hasi04RwVaVCXdB?=
 =?us-ascii?Q?S9n1P9hpGmEYoKQ9zBg/1ZH6sW52oQpqrDEbED6ghVaDjXcZ88tu7q7iqGIJ?=
 =?us-ascii?Q?PFjxG6VHmzRumAD48YlJcGmOJ966M5hssIHPMoTya6OepdZZ2yJK2QB1HdqS?=
 =?us-ascii?Q?GwtM7ZRuGV2HTZh0lYmyA4HX++u2LP6yxdNlQRNy4tfnxSzxIQN2f5XGNla6?=
 =?us-ascii?Q?KJ8gThdcB7xAnS6M40Ra4K1JsnIgIjuiiMo2wMomFoXFfXOicKwgsj4IzaUx?=
 =?us-ascii?Q?rQjucrnet7Yybtk02NSXBzExF8t1yJ3oe395pjbhA4Mfootngll7z1GjekLd?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e865de6b-a11e-4df7-3152-08ddeec6fe23
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:00:59.4063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik7ak38kc1aiIDNYpb8Y/R52JWArcQhyZol7Y+BvtG5BJXTw+b8bJMQ3WnoMOHJGHSEUDRfuXD7lNZRgMLY19/eDvftdlh9oAbjbAh6nRJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
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

On Fri, Aug 29, 2025 at 09:45:23AM +0000, Ciara Loftus wrote:
> Introduce the device argument link_state_on_close for the ice driver.
> When the device is stopped or closed, the link state will be configured
> as follows for each of the three options:
> 1. down: bring (or keep) the link down
> 2. up: bring (or keep) the link up
> 3. initial: restore the link to the state it was in when the device
> started.
> 
> Prior to this commit the default behaviour was to always restore the
> link to its initial state. The new default behaiour is to always bring
> the link down, which is in keeping with most other drivers.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

