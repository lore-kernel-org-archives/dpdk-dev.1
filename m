Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08849C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB3E44068E;
	Thu, 23 Jul 2026 15:33:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE1540274
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784813633; x=1816349633;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PcPIlE68s4N2xpXAV+pjMUR8ePAs3U2s4zCvtB2c3Ag=;
 b=LAGjZk02OaJs2R8moGwvOx05qKPGSO2n20NLJSqFqBGfOTfOCr8qYjsW
 gaNF4yYAiP42Sz74GQ9NB5eFgMuiGGle8pnNOYsHomuNj2tOisdeQtEi1
 iuhEbxTa28/hvpu9uDwoaITiXaSHWWg9EC8ywlzf8bpZnsJw+G2bV7jSS
 VyvvaDOcP8CPPz33andqVdw3uSScJwP+GXngcI66UwYrHJtX6IqLfAcEo
 dcfAxLsdpot9RUtDn9R0Eu72XVONa+12h86I4cby31NG9cZrDYMF4Qxr9
 oexsm+vFePB8Qf3GsqxrargSfjfY0NfMaRsXf9jMMv8wzi9LdA1IIKqcD g==;
X-CSE-ConnectionGUID: EGq8w60zT2eM3fPUhPNtoA==
X-CSE-MsgGUID: I5w8Zti0Sv65g6mS3prKkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89290340"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="89290340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:33:41 -0700
X-CSE-ConnectionGUID: vyf/Kb+mRE69SRWO/wQhQA==
X-CSE-MsgGUID: cOCX7aBmSP2lHvOkzklFEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="282925911"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 06:33:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:33:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 06:33:40 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 06:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sINhPpBXxgHXCh37Cv62IXeksV/+OHhQ7QeUkRLxuZP/YGlDhAc+UMxo2mrfuFdMcIqaG7WET7KIKH6V10eK6YqqNz4lfrCWEuQ0mn3gxzyybyRA+raQoricGeEYS9atf0Ljd8aEcBw9HIeTM9i9A4HexzPEt2pXDbcBz39HdawFlYrGcHrO26aYOQ9qwo91MxIED4B5kATc+hhnVoFDnGzwvq1zjuspptSfKi8bhiOVLqBckpjrzRqBSIvKoXpvBneSdhfcRd7/9+juCpvVcHxwhVq0Uo9ZwVabc83s/qXj52EHfMW0jjT53qSVpBeeyl5sP1D1BQz5+DN68n8Urg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkHkoqXvRs1LbhZHBrMaEAB7LoKW8oQ4rfYWzQ+mhGo=;
 b=iKUW+Ynh/+3R/VaGCzZmVVk79rNQNsYnEDIl0aJycNqKNwr9V1Wqe5MV2JtjvWoIB1ne/ps+7DLER7GLElyb7tWoUQS9uwuNzbvBDxtP4ecpyuAVCyXtl/YyfP8CGxXTnzWIcbU9263OQ1EHnMWueVhy5rXBn0IF5W41hYgUrSlfkYHKdosO1KnMDS/21fj7HulVVkr9XwAvlLSYFy7STFYnU+pZibGKkevV9GuK8KvkKLscX9YcZ+hd+I8ju4ApBqTSKGf1Lh6YSWn7WE557sEYIojNSujZ1vNq5f1Zk/JbaZ87ILfYK9+JrKA/56mJu6pkK2d/02D2Dg+6az/Wbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MN2PR11MB4584.namprd11.prod.outlook.com (2603:10b6:208:264::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 13:33:38 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:33:38 +0000
Date: Thu, 23 Jul 2026 14:33:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Reshma Pattan <reshma.pattan@intel.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
Subject: Re: [PATCH v2 7/9] test: limit internal API usage
Message-ID: <amIYLQNKLnMPgHZf@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260723125559.3087579-1-david.marchand@redhat.com>
 <20260723125559.3087579-8-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723125559.3087579-8-david.marchand@redhat.com>
X-ClientProxiedBy: DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MN2PR11MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: df6e03fc-62ff-45c1-93be-08dee8bf00b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XFvyMfQCgXE2ww5pKnwMiqQeLm7gZVSIEj9Q/zlgxGTnnugsL2SHipO314r2zOZmEON1B3Wc1kzj4paWYjHdC9xssVEXPZu7Z1wV9QdUax+z9FYGWS/IVDfh4Z24pbfcQj+c5iTDGVNoWejSR39rqBI9QYXnFzZ3rIpCJXgL52TLzaGxugXa0eF5bfxVl6Q9sWZZ+FAV7A6FfoxxnU2EY62s3YtoM+nE9xeoPivD0wjJr+f7ZwYCTLjWSzgsR1W/TjRf0Naf//Hw/aajlsPn4NY/0UI+QZZAhYypKvQPqkAgBeX1/WpK6XtBmkGz93OnhQqQA+hi42B/POFgzANp8u113a/ReT3tVxhh0587Lfy9Pu7an9CFirI8Ppg7lPuERUqI/+2iPMBEsfpHC2CFNfHdUZSipw4oMu/KDzQzDA8eMEqj2uqWtaDgrh6tKVUoovqR8J2CxCK4D9Df62Q4VfZA9g/aLrz9kek65ARaPSnGlYcEs2YyUKgTXCV7dcQ3VtyPJsmFmwO1SroQTmkqVoWvBCB5aH5XkEEkOthGwN7Zq91P/Jzd1DWK5d/KdPMly+9TxpmKN9T0J49MPszXWek8T2jEvSv+L9HKUehtNSKtu8wuWCaXfWdi1Uf+xBmcCIRGJB74pZER4q/Iwy/GSY+Ct5hUfEl3TSyjz8M7tHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4rAZH4n+dJoNhDAQC9HiTWZ8sThtFII7YScF70Xz6IZwwM6+h32fdqnR7Jw?=
 =?us-ascii?Q?02m34Zkw3a4bHrhn+EjdgS6od49oic9YZqIy+hX6hxucZoshhSHVWFpZ2ANX?=
 =?us-ascii?Q?LpA+64uuch/JoK8AN0cjKFxQfD4snL9cL0RVqgO0TgB2gA0oTJ+xVnRz7xJ9?=
 =?us-ascii?Q?SjxkMD4SWwOnGXYI5w2mNCWeylHnulqhOgcGOLvpQkXVjZKp39zDjvkpRLPH?=
 =?us-ascii?Q?7SrHiRYZXY7IH9cElJjbJQsrSNk0F98ZJGADai/HbifJwOAsEE+VaD02FCiV?=
 =?us-ascii?Q?HFcPcWiKBjJICg/a/YSmllrk4Wn+ypnC+++j6tF6HPJX4R0ptJ5uvxB3CZtj?=
 =?us-ascii?Q?sidF5bcKlq8wd685r9tcpli6Da/sQ1/42gcEsze4rqYS3jexPQyYmlPb3dtS?=
 =?us-ascii?Q?b1STyjysyajfgSnWA1WcjhI8IxSp0tERL+GrC+o58N1yIqYUrvSyXaf+VMuE?=
 =?us-ascii?Q?8pcXac7r79zwwhmcnVrDn0/k+RxvuS/3V5FsZxKx78l53+/2gResJk92HOsA?=
 =?us-ascii?Q?4F4vDfKekTjOuRoyU4P6LUujNT/CnwG5ic4HOyntJq5A1Pc1J/nQPTukLixK?=
 =?us-ascii?Q?jNsnGUIx4rAwZUShF1pdFvok0ej3Dv1e+qm2a9wCAzWtXsIdwrmiJGhTON9c?=
 =?us-ascii?Q?fcXddhskQrSQQG/6q1cz24qBlfrOdtLIQpN/0G9P3cQtazH4JHmDI6A1svp4?=
 =?us-ascii?Q?u2I5gN59ix+nqig3Zyp3cNt6xLKM9It+Nei+SMwvrCT0Lnyd/CS0j7neDFO3?=
 =?us-ascii?Q?vNHncN3P7xGwRdeSyHmrQwxUrzG57dIlm/a+kjKCwFeD+hhVDwBtxNagsiax?=
 =?us-ascii?Q?m0IVbWCVXZlnlw3mYxaq4RDbOukyNxW0syv+ySreN6jQUsdBkuGtjOGGeqvP?=
 =?us-ascii?Q?UZdzkGzlTSbHvTKeDHXyJluTKL3NkTXcl+4PL9mQZeIfto7bZN2yTQmm33nN?=
 =?us-ascii?Q?5WXpG7Jl68DJpGMsp4oXv5oHx37ZlX4jMvlJf+fF7ViXh98CniaZplnUgGha?=
 =?us-ascii?Q?q/MLbndn0fj8bM+AS8A91sxecLXGCQn7GigxkWi+EaAByGjAORRdSgF7frEx?=
 =?us-ascii?Q?ix1DgAru1nJvo3B3DfokIyQRSqMFXahD14uaA4GRs8r7Cw2dOws8+S5gD6Kr?=
 =?us-ascii?Q?P+1jLydioYdmq53jrcsTZmlYj0YBLqt1/FVivhqbUcMclD/paGPxXX16xxsn?=
 =?us-ascii?Q?oTuMDROC7zu5erdygFXayTV43lLzb0NQB5K0OmoJZJvfo97P58i5TQYTyUjS?=
 =?us-ascii?Q?hqMyRXzpEDSI5ucMWFdfMh5CEEef3vM/eQfnbW8TpAjANaEb+7LnB06OZzbK?=
 =?us-ascii?Q?WUBtOgBMnPpkQSD1qwwLV2fB5vHjnhQ66HieYSjNyB3ZVWaXmY0lPf65v8A8?=
 =?us-ascii?Q?45Ujc9iojf54U6OA/XrcRkb0kdwdYpT9cBsJe09aAU18iVFy9ZKTIUTyO5fB?=
 =?us-ascii?Q?C67q7vzZ7+5Th+fJV8Fpnotp4lMf9oSd75X2tv8fJqi436shz6XL2qSZR2e4?=
 =?us-ascii?Q?vu/iFs/wXEf5Q/4fkGsfKJJGod1UUO/OrXD6SNLs+ysa57YZG5vlka247X3m?=
 =?us-ascii?Q?TsuTdp/dGjfNVHKtaloxqQcua+jgAXZaNwc81ZK6ZUI6dA3+Z4dmXXlOUFQA?=
 =?us-ascii?Q?kceD6aw7wkWRg8p1CAM1yJ7+ZxD9BmE1zzaL91tr86JNngm2eiNpnA7aNeid?=
 =?us-ascii?Q?zcsDLbQHEWK8AvIPb2jr0cfFewM6cISz6I3zQYqSHjpAYpgo/7tPKxcewPRA?=
 =?us-ascii?Q?2il1JW45fF48Cs676aCAYT+1PUJGZ2A=3D?=
X-Exchange-RoutingPolicyChecked: n16rW1pbhYm98Bpy5NZgp+Il3KGwcrp/EmYQOR1q0+MN2WdpXqPQXA5qGcxb57bXj7ofMzQpnxTv9WFw4NvLF4CWedXgvkEizjuCgJuTbaW02RBBBz6xZpeCMu0hn8NbEO/26ebaYYMoEcCWEdWvih1Aco6JkSLL4CkEv0tvIsGS51yI2yKK/aeNSMd7tQ9eyd2WbVUaYj2QfD9nGIDn82OGlsA/xvgaBaaVKIOnHApUvRR+l9zgfsCWr3y9zkdHN1H26KWBVSxjaNePKrMnF1mvaCVBt/zlVfmWVBsEyGkzYWmtLgLwN5E/smVluL/kbRabnCg0tFBbKoHl0shRmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: df6e03fc-62ff-45c1-93be-08dee8bf00b6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:33:38.3803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjAoBKGOX0S1C0IUBkAM4qxwJy5zLByIq5xlHZ77tzjXnEUb7OxtPwJnBmXFs/j+ck/+ywRLKk8CA7i5+ielLbPOdBti+em1NwrMtQQRzEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4584
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

On Thu, Jul 23, 2026 at 02:55:56PM +0200, David Marchand wrote:
> Internal APIs may be used for validating the internals of some
> component, but in general, it should be discouraged.
> 
> Let's not allow globally internal API in the unit tests.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/meson.build         | 3 ---
>  app/test/process.c           | 2 ++
>  app/test/test_devargs.c      | 2 ++
>  app/test/test_external_mem.c | 2 ++
>  app/test/test_malloc.c       | 2 ++
>  app/test/test_mempool.c      | 2 ++
>  app/test/test_pdump.c        | 3 +++
>  app/test/virtual_pmd.c       | 2 ++
>  8 files changed, 15 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

