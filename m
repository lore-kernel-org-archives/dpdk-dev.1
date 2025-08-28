Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CAC8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 10:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E3DD402DC;
	Thu, 28 Aug 2025 12:35:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 942ED4025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 12:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756377343; x=1787913343;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dUDQYXHIqrLApFKPNAH65ZwKM3/k/fbxy+/BxQ5JwcI=;
 b=gbPkBcmkiBIOh1YGM3fT+TfnGnbkEXX2tHHGf9gLRwaV6KFWP+J1x+Ro
 vAfbZ0uSIPaxQztTdm6U8QGLxbNNswm6T2rqyzuEpBa0jArhEcKI8Pzv/
 l8Wh4ACFgYeZ/m5BlW9IonEOIM+lZnkLZ233YVXQJYcXKqQFdHiM+5RIX
 wHenIlzzMfIravVqkWSfnmO6R+ZgAQR+119LWtEv6GewSnmMNGiEdDBNC
 u1vYkeX505VxMViykRAbQR6ZSz44aaz4JVcaSrrxInG/yyv1lHCBJE93b
 UI175qdNghWjBbnKz7ruXna+9xIeFgQwZO7Ykjwt2xprELJjNy8IVqiJz Q==;
X-CSE-ConnectionGUID: 9odVmtvVQaCEbwlqwCk47w==
X-CSE-MsgGUID: M26krJ4XQeK/q9rAzLbq6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="76242732"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="76242732"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 03:35:40 -0700
X-CSE-ConnectionGUID: gqLiU/8tT3eOuq5MRNSAXA==
X-CSE-MsgGUID: GUHAZyFnR3O3Tlx/gK2YPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="193742006"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 03:35:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:35:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 03:35:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FilOSy/2V2KJ5TR23w/pw/GhzenWUer7LZ+FS3Lp0oAnnPb3wUO6QwVUEbnEMv6s5YSn15F+KtPwGN33R6AMG/DMwSyG+v3HMKg9d/cBp9RxrkPBwPlCgxBALFi3OeuVmJDTSoUYEa7nnD7bc4qbMHQ87WPt8JlmZ8TYw0bqMVfY+7fvN8kY/pu4GnO8O74Pez0qtTOXJoHAh1+t1jJ2JYlSlvdFeByY/02n0bs9MsS+HaASQad7s2FvuGRGk9dimMU14zs5/ZP61WEVqdU+v0YhlD8w0Hs1dSQxEmWpz+rnh2ppQxR4OJBtxDBKTPJSFvSDNgOs1qoXrM9AiN+4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhy1GQrV0T46Gt34xtw4ELgAk/n7lLz9mJjX3N93mOg=;
 b=iQPOs/GfQ5DK/xUiG5IPu1kXuH0D159VTmmu8UtLVmbqjHP/WnPhEpC5RwoO93cKGPZPDgi0n9rarg5Bj6bavt7W7YRhhgtO8O/0hi57Bk/L2NxdF5MW70GsFTbSday15upbh9H8F3dz9Etuaj2B5p8deAjkGK/6vdxvBj1uF/TA8FbxjWzCOER+3Qj1MNUz7BI/sP4GkVbZlDZewhI+AV17XH8EE8mGLDd1Hw9pUodHffo45YQ8b45ksRxtE679TnC9o6wHkgJqHaCPvTaTcqUrRaRWnQDsxdtJ+Z+k59yT5741s75bVVY4uoFlGtG3quGXcfjHmdk6QT6AQ5G/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 10:35:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:35:29 +0000
Date: Thu, 28 Aug 2025 11:35:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: make link state configurable on device stop
Message-ID: <aLAw7JMyHARI_1Z4@bricha3-mobl1.ger.corp.intel.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250828102305.1522036-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc1b67c-0755-4b7f-041a-08dde61e9b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bok6chXcLAvtWJg3RHCxrh9nOl7c9kEIBGyT/A0kNqZf5aVgbRY8R1OVkcGE?=
 =?us-ascii?Q?P5JLK80p/I5nnz97ghCQmhHswqT8B6j2TonuZ9nRl4C/DS+qZzCTuovPzm3F?=
 =?us-ascii?Q?VN5PsuRrz6BXTmwVIx6Ot0ZFWLfbrL2fJpSopr0M5JlxzTDGtGyhI/WGOUVe?=
 =?us-ascii?Q?E707kYIAfdaWFs9cPqyJcSAJ0ouVuuL0NzuVC911/9ng0Q6h1rDu8REyqu9+?=
 =?us-ascii?Q?NvUpG8r2VAnG2fcsyqTBX5UUdOe03jkjJ7hyqbPM1wbYt0xWRg/AodZVKFqu?=
 =?us-ascii?Q?Br3UjiJELvPkmqHuzoYk0xT6FitUqNr7ZLMB8Xx33PUhcxaFy6j2Cns8iNEn?=
 =?us-ascii?Q?oyyZserj0+w7/Pz6xtIGfAHLbbWHm6mcrInEjU0g50Ofrp1D2rlF567mYd6O?=
 =?us-ascii?Q?xDLAgIxeZjqZZNCj2xOFsYA6IOWqllpdz6kKQLfuuNtQsHSQe5VGH9Lf9ji5?=
 =?us-ascii?Q?TsnGf1GKINyUtYQShJveD3yAn2saSss6gAzrlOFrc3yBLY26mT5z9a7Btol0?=
 =?us-ascii?Q?JwC1xFniAqYXbYI17VXXo8X76h1OIx5/+BmSQeai8/FacyjHS/+lFUhQQkWM?=
 =?us-ascii?Q?T06TPu2gPFZ98yEkCyi7fhERJR7S1fWY5RkuXxXOMGxyVbIOAdGuxsUsOMr0?=
 =?us-ascii?Q?EyUA0ROH/CMkpXoAncxyV+zPfcBaQ+9WiYPIOoho9UaHwmJ2IzirnkIec7sa?=
 =?us-ascii?Q?zXZCG5WCEIGmiP7KbCdHlxk780ayvUBokwGQmXctPHbY9GgOCdxwFM/0cGsc?=
 =?us-ascii?Q?phbqaxaEwEuyxJSs7Fe7Va+NBGoGTuyz8+AtFPUWjTxiKbmGiglMGHftPUbb?=
 =?us-ascii?Q?hfiSMUxDXoVgco1dGc3RaIF6WxaJvYD3288NkTOGEBfDwKdXmmOBVMSgKGBz?=
 =?us-ascii?Q?dP1wi4sUpMmfvMxaAjPnFpgdX00LT9wFnojn9h4oK+abdJ8CM9uQPZhuYC79?=
 =?us-ascii?Q?XMaIXGIFNWaS5M8TCa+KQUgUQnYA7Fglxw0IsX0NOmumnwl49syERxf858iC?=
 =?us-ascii?Q?IQnQUOOcPzdMZOvOEPhHk5GIBa6knnuQuwylzFIPSc7OjUGtWp5YlXvGPQ4R?=
 =?us-ascii?Q?fEl8w1lyYI1h4EaKiTCHbUn4NX0nABDM98KyTQhYAFCByU1yygc53gbl17yE?=
 =?us-ascii?Q?gCjlVV+0smC6xxxOJJ+b3qEoFEvsHzIUSSkybEe73f5whumu3UBNTNktXznH?=
 =?us-ascii?Q?dN0PdOYUt9A1jMle5FUf5YmKzrvOMshO/tMqig/Qg0rvLX2pzIhBbLqjOuK9?=
 =?us-ascii?Q?aYUwY2RpNVpCUPflAbJnXFppGmpTPcu+760/XwSr9GsBLjuDTJ/hTntccHjQ?=
 =?us-ascii?Q?nChJ1rM8NxujydKCRGOBd6rudllpnTd2V/pbZmPDOkA6HUYnvny2mXl+ZpD+?=
 =?us-ascii?Q?U5bjoZ3Do5yLC98ryA8UxGxD8H4AKO9FldwXkuoChQVc2NqR4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1I3b6HdRQPo2pOzyaFh+wlzVzxKk+f7b7nbLVxkCtzmRjv8gHQV7cwCzkqxK?=
 =?us-ascii?Q?a/alXIZlFsh+m+t11QDY0mikTi0mPBtM7AiCaXczv4PbI5lYVpGseoS+UBb1?=
 =?us-ascii?Q?FQn2eutyldzsyxFB72obbcwTC5UOrzoGjMhJel9Mv+rT+fPo1UKZcYkMWzRE?=
 =?us-ascii?Q?67QWmGhXEk6ZdfL4TAWAsPwsMF5aGsdDy7/kA9r3H913pY3ZrT/jCiZap9aE?=
 =?us-ascii?Q?QS9OAHO/+RnvoEkIDWMFzXGJATDqSlBjJ7lX8n4Al/BPjE/JphATNRi9rHBK?=
 =?us-ascii?Q?t0sczGld83XFQrJJdKxBOdnlu2UIHugF7W6k7RmMxVimllYWSf9yRmEREHlc?=
 =?us-ascii?Q?o5ST7w2KVdtldXwl1y3KoJuCXsl0YGYohN9J0052qtP2H8STu7iHKdu4MZAQ?=
 =?us-ascii?Q?LMJpNr79rP4ZgoondO20oAbKsjPrmLKjT8lPkii+m4skasa3n3CPbrWNEeCy?=
 =?us-ascii?Q?/4X4pl/pYqb14sv5Bi7sLVZU3NOP4hu1b3kM0nA3aUpbRy3G/b+VKpI8Y48h?=
 =?us-ascii?Q?u1fYDNHYbXuHpRSTEKiWqQhYTimB1aroem+QemOx9DAIKUy70I2psUbOScB7?=
 =?us-ascii?Q?VZUOXWaE3CJBIGlsbZIdVM7lwWkQDhXOnpP0ORge9x4pC7YLGPS2Rmb1cwf8?=
 =?us-ascii?Q?yiPY2Uxlg8AVGYHERoJqWSbS/l2diRV86/PhPvB0NzAPYjZGF9CZCwe9Ih4F?=
 =?us-ascii?Q?ip5gKD+puhmxUa69Hv5JG4eAnA0oLD3oeeCrZ7QV1+u1LZoqg1QpU4Ezk87C?=
 =?us-ascii?Q?20974I6EuIglozpn8zbN/V1yq4CgRAq2dNPt4qghVSmJWf6MPJqC4DFhLP0y?=
 =?us-ascii?Q?BqobfJcuLrUxyThMB0j+/vsIhB/NHf/XqiO2HFv4BDD6/mIfpxhCfvhRk3JJ?=
 =?us-ascii?Q?mYyf7fHWGG7sV+0E/Qowh8mRh5gkWNEq9OkZeX9C5j8YkGKVIvhWY/kvIvox?=
 =?us-ascii?Q?fjq8pYHmM1TuvDBCT2GlXyQ6oSWggCHSd8xn4oDs0QRb4IR/wDUcGineWYIF?=
 =?us-ascii?Q?VSd4TGhNiyDiRmw8IaiSa8/r1Q1pYu3A5d/BNeHDzzWpIS30wDCm2Gv+fBjq?=
 =?us-ascii?Q?gWpeH5MtVtdlaaN/tjMdxJrCjtXmaKyfZ8g7LmUPyWlX4pb0dpdsJtWPUulS?=
 =?us-ascii?Q?qvrIof4CbQzwneArMa68M4YL2pzbEZkdJQUFHz74xgw5i7UhiQ+r6qfqYv2/?=
 =?us-ascii?Q?QDo/MnBwNR/QnrtPqDt1MKE6sFJUo09uBBovxcQ5OS+bvyca2aWLJdQp+TO1?=
 =?us-ascii?Q?VNkLeDIIehlLBwmv4HgmvfQm+aSFjXoHO+QruDzeTbCCWxvT93X7ugp2uckl?=
 =?us-ascii?Q?EOWIYLZjepe470CLbLGzwm/9SJX6UxCh+L6Z4pZ1c6LUFlpZK7R78wtWfyMV?=
 =?us-ascii?Q?GvaUUHKk76MB1Z2QySHlpzI9I67EFSg5nYiaMidpysKdYAkITyWmnfElj3Xl?=
 =?us-ascii?Q?qn7Av5dRPFhorqyFmyOwvcPvKFyK2Ez3WuZBgGurlRUseLdV7+uAc0w9ibWj?=
 =?us-ascii?Q?+BeJrHDFwdKf7Ib/W9ybzu1MAWLdkHXnljbU9bBd9uyO6TnCd8w2SB5fnJBs?=
 =?us-ascii?Q?m03ESns/PCnZaWI4ZzwVX1h38EShReRf/BrGt9AnfqEXRVpQpgy0C/k05Ykk?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc1b67c-0755-4b7f-041a-08dde61e9b9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:35:29.3043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkwbUndX89rf+zzlR/TfmF5ZBO5edhQoxyudQB5YqA2xEEuH4Ob+F24lx2PpGc6IkpA9A3Pg61OKKcJFr6x1tTtAUfamGtKC85dgHipo5dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
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

On Thu, Aug 28, 2025 at 10:23:05AM +0000, Ciara Loftus wrote:
> Introduce the boolean restore_link_state devarg for the ice driver. When
> set, when the ice port is stopped, the physical link will be restored to
> the state it was in when the device was started.
> 
> Prior to this patch the default behaviour was to always restore the link
> to its original state. The new default behaiour is to always bring the
> link down, which is in keeping with most other drivers.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/ice.rst            | 12 ++++++++++++
>  drivers/net/intel/ice/ice_ethdev.c | 10 ++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 2c0f41c56c..9007b79471 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -322,6 +322,18 @@ Runtime Configuration
>  
>      -a af:00.0,pps_out='[pin:0]'
>  
> +- ``Restore initial link state`` (default ``0``)
> +
> +  The user can request that the link be restored to its original state when
> +  the device is stopped.
> +
> +    -a af:00.0,restore_link_state=1
> +
> +  The default behaviour is to bring the link down when the device is stopped,
> +  however if restore_link_state is set and if the link state was up when the
> +  device was started, then it will be restored to the up state when the
> +  device is stopped.
> +
>  - ``Low Rx latency`` (default ``0``)
>  
I think that control over this is a good thing to have. However, I'm also
wondering if we also need a way to force the link to always be up on close,
therefore requiring a tri-state option, rather than just two as here
(previous or down). How about renaming the option to maybe:
"link_state_on_close" with 3 options of "up", "down", "initial"?

/Bruce
