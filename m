Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6946CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6680340648;
	Wed,  8 Oct 2025 10:14:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2B54040297;
 Wed,  8 Oct 2025 10:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759911242; x=1791447242;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nUt97704XIB62RlKwbQbzK6aF/I+WGS8RRRhzmorEzA=;
 b=X2eY9uyUm01V69O7lDArVns2SypqlTpKKSUllww5j6SocvESRRXdEWAK
 wQMZ31P9ygsroKIdRl18lt5JpExU0jMwb/gxowOo2DB5K5kZyTensHwdE
 jSp33Kz4XufK3F+PokdxhuQAw/t7yd+Et4OXemjKgisju/Ytet5VgBi9k
 ThDt1BOkP4tUc9JF2eDRcXkKQaN8McbDmgCahunl9emknUauiOAqk0k/9
 XGhaCJ7bCHYjp+ZPF/P8vbrR0chvinvIoklcQAmP66CEXrrsqE0D+r4Ab
 tHZgXeTKPmwCzWXcbxN/eGtVgIPY7ENLeo+IQ1BrSIWZNmdrZ42cionNT Q==;
X-CSE-ConnectionGUID: 7AgsmRmZRNyzU8dCLaYe6A==
X-CSE-MsgGUID: xoZmRvhzS4GbKR/Kt9YZ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="65951615"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="65951615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:14:00 -0700
X-CSE-ConnectionGUID: Zy5Enwj0TXyd5kb0peBd/g==
X-CSE-MsgGUID: 12iyJNduTvSz73Uxc9OO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="180048682"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:14:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:13:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 01:13:59 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0a9G8SO3s22Uwt5rvATN/bnV2RiN9aEP8ovnG6OLPYIq4jRk42TWYjYlIBbsNnTxgGAgEDGj8nltNH3sks8wlLuQH4jMkA8SoMlF6Y+deKpTfZfc1zsJl7Gf7JBBCJx9MXT80wql0+lwS5VsTsnI9RtUF6yRZ+uHVCcUFH/YjWhcpj0C8zXT7YFPJyNFUhjxeIONu+14/Op7n80GBWjS3ZoyaQX9ZYSIK3vG1HDWg+gDMS+68UUqq/rZPFQW7/F5Z3RFhgeyIa2kI2XAsV4q1GSyz2TGA53aEFgacusy1Hxr7fMT4/nLL3rxcxOmCmWy6dYGzd7S47QNX0wFfkZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKvCLPC0UxRDTNK1eG1kyEjeXWmKozs4ByhyLJ4vyTs=;
 b=P8p2iGdYOvi6YgF1jdxwTPSi9PetMez7U+baF78ZtcL+S0nTTPTlQkIMKHzkA/7uiNkmCx0Y77fi4EZLd6N0Xq05s+tdgnDuuF/EI0mbUp2y3ycFq0Sp4QuXIgs0lNojGLHVDTZuShxilEsC4x5ucNh0YxqVlpD6oYWK18T5oVxFq0ypwa4XdA+mOAql7/vgy/RdBaChzuqYVAPxKHJ+y0F14C6xv3lDaZzSp0ox14a0l+tRZu49HhujbOnNwtXZ6xXguPZ6KyP3fCqyyebPc5X0V7waX5BG3ocoQd/zMDu/bVq0f3/mC+e9kC6ueEpBHHyuAUE/6z/hHXQql64m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:13:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:13:53 +0000
Date: Wed, 8 Oct 2025 09:13:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Zhang, Qi Z" <qi.z.zhang@intel.com>, Yuying Zhang <yuying.zhang@intel.com>
Subject: Re: [PATCH] net/cpfl: fix display of commands in the docs
Message-ID: <aOYdPOySWEBjivP4@bricha3-mobl1.ger.corp.intel.com>
References: <20251003145848.1675691-1-bruce.richardson@intel.com>
 <DM3PPF291EF9BF1FE2D5C76005FEDDCDA199DE0A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF291EF9BF1FE2D5C76005FEDDCDA199DE0A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0209.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: d89e5bf7-a40d-4a65-d598-08de06429e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zpc9JIh2Gb0KAkowziad246FLasJyIhDC2tykdqp3PfC5yTAkh9eFdrZnCt3?=
 =?us-ascii?Q?ZVHqDxVbLuUnJyVfb99Sk1gLe9G6Km/5p5RSwIp2ehABFNyLEOK5R5sof9+G?=
 =?us-ascii?Q?zgZ5FmZp6Mx66d6mqQ1T1uyHI2uok4+q/AqGHWJsgO9IVR6Fm4SlR0mucdah?=
 =?us-ascii?Q?E7XPxl0Oco4d6NNyaZwV5qLJoRgARJEXvK9bBYR06wMJijtYVEF7CtTEqvf6?=
 =?us-ascii?Q?Bo0vpuCtskslOJUE6WXvDawGgE+2G2+n482U8uS9BWv/MA/kF4LplURkVoNy?=
 =?us-ascii?Q?yzC7d4OXMdlwZhiFmDtPCRBjTpGhI+WlzmynQX7H4DviPoJS5/uzIELjif0U?=
 =?us-ascii?Q?Pio71sdL5iVNEelrin5ZnKVbWrf8SqCEbsHPq1gIVzCxzf7xTLD42KnwUGbL?=
 =?us-ascii?Q?CCR5naaIpKRVgurFUb19CCgEX7K7h+D6awDHOWVxBImhSmMm+FNKHHalAm1z?=
 =?us-ascii?Q?ksQI0KFUODAQY8QGUAXgpHB9zng3FcQy1aVkgHPUNNqeXPenDSEFP977mXTm?=
 =?us-ascii?Q?1LLc/Xmg61y1sykZLKn+tttWwL50vd0Dk6DWIeKlUENSyWvDdwIcwwLmd+1l?=
 =?us-ascii?Q?YbQa+o3GkMmtnFUhy600cEOrOqwRKP1qGKFRs61S9zeFlI6Q9YA+sFupI0mT?=
 =?us-ascii?Q?WCHbS00lCD+VgycFEpasGtxve4hfq+rE8exOEVpCnCQmy7WNcprQUz2qH5pr?=
 =?us-ascii?Q?nd7A3XccwFl4gVByNlV9Ezj9bsD2mUtpS0bVUZ0fyAUPeIAaGMti0Qw5QWpP?=
 =?us-ascii?Q?J700eDE7BFxr6Jz5698iTVuC7I7Lp58TaimfORoT27XI4bus5UWUQbQqo8II?=
 =?us-ascii?Q?gNfM0BJ6/A/6by69nF526VP22O6wsFz3jef0xZJBlcdQP6IM1kym8TQUmO6A?=
 =?us-ascii?Q?BYOzErhtqfvj2AYVqG0XPfuT026eWIZDMhkYZdmmiiVwoqgRr8vBzXv/AE1o?=
 =?us-ascii?Q?CoLRvSVS3ynoGpRXLM4+7S/MyM8npGRwx6bet58SQ7vFX/2LQC05JFgTq7UE?=
 =?us-ascii?Q?Jc2Iz0+ATGrijD8SrczxSQzb8TTc3uB1agbsGJxUYE82UKslk2IlVOtBJRMR?=
 =?us-ascii?Q?mQXbGZcR1+KCJfmsc/UPFnuv6/r/BPayNknuk5JugTl6Z5AFy03Hp4xEyneg?=
 =?us-ascii?Q?0N6+0V7S2Z9ruPijFnOgBVyOaGK7o3OEN6kHaO7ZLiZaqTgGrgBli/g6LriX?=
 =?us-ascii?Q?5RGYl03Zux6n8+gvjpY82UDhgUNuDfq6Ugz8LgTUWMOgH2m8HvnMBCOMEJfA?=
 =?us-ascii?Q?mmzbOiGSzk+e5cNunfp2ZNFWT+895RkUd/oixYAxsAcxql60+HMUHholwB6F?=
 =?us-ascii?Q?fRfZK43f/Na4rTSjvvfpMF/cST/VkSw5m/pQTNRvV5YIBmd6wNUDZzQdMjgx?=
 =?us-ascii?Q?02WDTryIrL4vHeItXowQoIbi0LyLKC0KwXcIw0E530nm1FerUx5GxhgbfkoQ?=
 =?us-ascii?Q?qMrhpaTEQra+Q8j0vdS8yjisw+yHhhaw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Z7hV83bkJCcTYpuLtCCapCsnLbWAvPQsRzE1YHTE8y7uNQYYwcUppGRBDYB?=
 =?us-ascii?Q?e1FSBQ6X691EujyIZ79EZERBHI5OusUoW7T7cBiEm9mBjS30CjVB5XbdvBRz?=
 =?us-ascii?Q?3IJy5KzC0G1LEUG1FLs2jNJr8vZ7YGpiSqWIP/b1lBxLxp5JQdKTxwEzVh2q?=
 =?us-ascii?Q?84mVQuykDRuqx00zfu9YAKrBEkNx0eNuMHMupe1H+6XRDH9mWtrfWz1/AbYK?=
 =?us-ascii?Q?QR0bhJ6taoC/6Ny4OhHEePzL+uoyvSmM6QDIooT1Y1y6mZYn5OZpOvL3OY0T?=
 =?us-ascii?Q?jnFQCevF+u7GJO5CsTco8/cYRpEH+nshoHYS/vD5s4uOPrW8uR/hQTiRZtZP?=
 =?us-ascii?Q?3WHMdVNat2uCq9t1VKQah2u5lhDR6gpinjUA7cj0jmJ2zs98knrhmiCUFCVp?=
 =?us-ascii?Q?dvGWMPJif8LfoFs14TKM8i0/7bLxxAQj7F3xBfhAZH92HyisUcZTKKPdSIBA?=
 =?us-ascii?Q?xJifcOiUMiXS8UBRFXKt1FLOmkenXetjXr7cNgmuYmSYhyyqXwFKYxTVXAVh?=
 =?us-ascii?Q?pPhQTdwAderKUClQg8spnOUaiog2hBHUuevS44ngk+msWYupyjOoU/2EC8VZ?=
 =?us-ascii?Q?lmAouW+icWtIcxUv8t7vD9dJ77L34M9eZpgie6Sv8LTPsLLqCarIVbpJNe7M?=
 =?us-ascii?Q?pgrZ9HNTJiDsQpKBGu2sYWXiZp9/90eCWMxT/N3ohD+b+Tnvdnn0BUwREjzi?=
 =?us-ascii?Q?tO/oI8M0btdqvbdkBgoV1gPcyCYgwMemFGtVz07BZ4AZbJUhYXoHBekD+byb?=
 =?us-ascii?Q?vmL/czPYJ/eQTBjhu+GNXeklC+O/grJDx6/oEQopRDkbn7VSuTj6g6V9Wszv?=
 =?us-ascii?Q?Dcss007LR2NcZOKl1uvfz2cOI0TBzl8cFvUcB5uAHdNGgwWPEdGAu8CxCg1g?=
 =?us-ascii?Q?Wg0ZXKuJIUNgJvYEEGOP+5sg2+EysnXb9fad0Bm479ZUmAhH2ltX+bjb0QRT?=
 =?us-ascii?Q?DIqHcDIphGahlAm1uDdTZxiOM8besiLPK4Qrht8zWefHetPtqp/fbWTzCgSu?=
 =?us-ascii?Q?FpMlpifduEm2A2hpIZBmcPcQnmQklhdj/uZ1YrwSVwx9wn0HVeFbidBA4Cr+?=
 =?us-ascii?Q?W5h/n+3zCb07F7eTB0VJPs5Z5Oe2NccAXs0v/4vg0t9mOSIndYew/JlXhnVx?=
 =?us-ascii?Q?Ua1nOhUYId/QUtNsaszAshMe2cdpY0IEskzbPAhGuAnSwYGce+qdtU+zNpB3?=
 =?us-ascii?Q?Gvb2tpLNPsKmEmRIMNgJ7CQ1ohzHRqDPVQRSNS4l9MpjyCHS1KmnsaM8ct7v?=
 =?us-ascii?Q?IAEXy1ySslvC1ymYuUHYYk9yW6CEnagxY10gAqTAWKE8FJxxU+PIR/RTK35e?=
 =?us-ascii?Q?aSJ3pWUnj2pBJtO71qbzNd5jB8w106uM/xWO0HLHZhnNDPQFWqqA+SHXDX9S?=
 =?us-ascii?Q?/0MhLu9mYx4FC/LEdGZ2KlpZkutzsQnVRC9sBky5Alk0GTPCpBg1553ia6Ha?=
 =?us-ascii?Q?A77oR+0m1qhamR4xMbMJC0wJwNeMtOE5AqmSQcFaSuXH/n4M7JZNUltEg/To?=
 =?us-ascii?Q?uQwyIejfmoLYIUkdjLUuRqFiG85kAwu1Hoyj+MQb42zKmdeHtn7ooKuTG/90?=
 =?us-ascii?Q?vDJ7o/54s6wiZjxNiAn+RxNL8vhH25F7ql51dYfu3KdEG535cqpjfsW3GLhG?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d89e5bf7-a40d-4a65-d598-08de06429e8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:13:53.3206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QsUgdhX4e2G6fN7C5ktmPpDTFg3iZQQDS2jRQWgT5WtNAuaF4FENCSheqLAujhz39zjPlQp3QchnJcYLXjORgiWEisebVOKGFOUaWhE80c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857
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

On Tue, Oct 07, 2025 at 08:47:23AM +0100, Shetty, Praveen wrote:
> The literal text of the commands to use were not displayed properly because of a double ":" at the end of the preceding text, meaning that the ".. code-block" marker got recognised as the literal text to include. Change the double colon to single, and also indent the line continuation in the multi-line flow-create command.
> 
> Fixes: 03f976012304 ("net/cpfl: adapt FXP to flow engine")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/nics/cpfl.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Acked-by: Praveen Shetty <praveen.shetty@intel.com> 
> 
Applied to next-net-intel.

/Bruce
