Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F6C88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E9240269;
	Fri, 11 Sep 2026 11:58:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 69DAB40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120716; x=1820656716;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fSeqMYzk8oIDqo6hT25veVpaiOU+JQJpN0+7ZbapxO4=;
 b=Zx5ClrmMbkykL+S3FRkL5i4rPyQDkBODBqbVFzndtvxrmgzMtv8lig5a
 b6dwMk5oHNVxlVgzmqp2GF0B4LwULpt14jxzA0ki2YWFkh21XNt/yI4+d
 4whkxV0Tq1i30405runJpa3j0spXUGIDN5QdFyVN/IoR+FOaL3+/ZK46o
 VEd46FD6PVzDYcmjbE0/SuWYqtrzfdeK1rQLZ8NOAgg4vd/xn6w/9FWsn
 ALRikr/DBGIJC3A2kaOZxEFH400eHuhCLuF97IEpjJ4k1X8b18+zS2Iww
 2kr66uXNkCU5ZpKpkHnSyNq5eHO2BTyHnW9jLll/qFiiLmcuQVLzS+QZt g==;
X-CSE-ConnectionGUID: SgJcMMKMQRGWIcBsbQpEzg==
X-CSE-MsgGUID: uYMY+FHrRmuIHoCiO3G80Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88525781"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88525781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:58:35 -0700
X-CSE-ConnectionGUID: eMMHNpz+SFO0HZ+Zb3bqiA==
X-CSE-MsgGUID: 7GfsmYAjSj+Bh1cygo23AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="295356870"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:58:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:58:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:58:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3X6pTu/JNvJFgl+DIap6sHClb4Ow32XUJROYYvwzcIdiMBckSIqrek+RSQ/OZga0yl/eTl+hS2fT37+ko9WechD3Sn2PBfIESPSBDm9SMMIM1fx/acTs4+ZzSUcy9ZwzGH/WV5BvlZsgNDzqqHkBNv3D26jb06BV5Mpwf948K5EUVQidt3bEvBhvrbgL3KFhNY0k3LnOq28bGbcHNtquWBVIP7jYWs2ZcVcj6dEdE4JTk7Awp8DdMWYuVMaaw77jTOKlyq9ZHG6WqMh3Qt/6tQhmf8ovDW/7Zl2cGZa28exai4woF/f+Fxqr2jyueJOK5LHtNxS+FRJ9ZXvLAwUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DILjq00VFx3sTfTWrndqrGQYimDKouK0716dJW+8DuU=;
 b=s+s2O0RKCUUxVWc/DqLvubdnYkl6xoWYqy4+o2+CmieYx3HrFWa+YjDaOJaeaNep7ysmZw/Fb2Rp41JTE+u1ITdx/AAyo8M/SDiLUDKJqHijAhT6NHeg+UmFIZbp20n6lZOMqvJMtfN2VirBxicFPjhlgxIxNVFosBU7VFxmrKlxuJUdNZDm7DSb0SaT0fQu/ICWGhyZFVFYY1Ha1k7hvGCDdNXdRlvZDC0OAdw0a+FuHFctE380jYEzO/a6gIqYnclAA3kv9aKcTmGzwxq44VfyK4Bae9u7375S5a8PuxRJfGu6k9y46MrybKmqZpasjW7qoNWGdIe7MatK8f2QLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:58:32 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:58:32 +0000
Date: Fri, 11 Sep 2026 10:58:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>
Subject: Re: [PATCH v2 49/68] net/vhost: replace use of rte_memcpy
Message-ID: <aqPQw9JXQgMV5MkL@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-50-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-50-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0184.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: dc541611-6454-4629-f5eb-08df0feb3cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TgwZMiaEJD88Kbo0WgEx4sGKISXEB9EfUvx4DzMAgB1/TDHGA6Rp3DATWu2SyK3uClWn/luPswNnVceAYGA4bp8Tu4lD6mIVWBJxC8/mEmbOKkOOVuHm9mH/cKAb5JT2ToCO7zzJOOiA657k3kl4i1lJ/5byjv8K+LK9TcSeOjMNv40eI910jnC02KCNDAdUSFhAxgf16LNxVNPFESfzlFzfH9WS0uKFAX9zBsEbNS8P+ODcbE7vVIQRwY28ELvC1DUzF7xJTD3qRg/QdX25dmC9py+RZeY9bEuqW27H57Bla+o//4K2m8MD/zfe+ZP/UzZpkaTD9m+rJH+crFngsaOTtLLHcGhgBXnIUdyBNOzdMHzAsIz8Tx62xVXB+Vh43EfID9ZShzlo5TOtOrNxUyB0J7d58bE7tSoGG2OfTLfwUQn8m4S9KZUFkHf8fRQSYSG20clMBPUdFH8X8EbMhtjoStsqBz9HObUXiJSZUoSOtMsjbaCTTPQuJULXtpxuDRGpklVpYOJw6XzbMs49H2JZPV2fMZR3ZrzrCDjECZXSm/xl5NPPOJb1WQvXv0diskGf37tt1HP1om/eSNJICbIn0dlxaQ5kPapwequis51v8S8BNlctPYxQmY7csP66R8dEUFBSiNqvEIiNSVksFy8Hdwmv5NVc1rI/k8FjN7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IlhRNr7peQq/isqM5nq/r2f90UiVsrqP3A7UU+cfC5KeKt7UM8ZLzZPH/Gz?=
 =?us-ascii?Q?zbrs1vpxeZev0BPKxKhIvWR3jzDfr5XV+gJe4bU1K39sdZUw9fU/w8DluVjt?=
 =?us-ascii?Q?bMu2lJnxKPQ2SraT4U89S3fbxXwIiSsP3J46X65B6Iw5/oRI05VVYCyRtbev?=
 =?us-ascii?Q?+0vdHvjurBaiaz6tLk+aAzpDZcSDQmQbTqReSNh+Dr2YUH4T+m75bht1ZEwv?=
 =?us-ascii?Q?53d1mcCr+GrHivwT3guLEBiCaRBMHk/YARSjm1Cl5BD0zqRGSsN36lhDxPsI?=
 =?us-ascii?Q?cR6ITaMxSNwhNzumIxLBoH8FGYeO6hyA7zPW15M6D0bShxY7C1vtXnPihASc?=
 =?us-ascii?Q?zN5osFa5avm4oBsZwPr8phQIsHVAGwFrKJyc2UGCr9co5z92ISgu9VQHiRRb?=
 =?us-ascii?Q?JMp+G/LTnuuwGUHWe8cz/O1jU1FKwf0Ox+MmzXEC7ztUpPz+jAgHh517A+Pt?=
 =?us-ascii?Q?UFFGNKYk8CzFoEgYLuDgR2Bj9cr7zNgKiNEs66J5BOe+ZJaeo20nP3BHTXrV?=
 =?us-ascii?Q?bIlCSpx3ntA+1Lz6wP8T9Qh3Sa3qhgVJ3OnlSsed3ySXx7zeOhEYEp2QPn3B?=
 =?us-ascii?Q?3A4yoWIvgdrjpUnT1VTmkjpIjLjJzXMDkWBOA4KK6Y5dvNdAHNrgn+omwuUO?=
 =?us-ascii?Q?kzXNSjpqgwdJhRIBkMVVpvOXkZ+h/wASHISvPylNTHG++OVBYdwhxxYkcH/K?=
 =?us-ascii?Q?HznTr9MUR1bhICKnJ5La1luoQLXSHF/WOya6N0APTsJgPGoRW9RBFi+zTaW8?=
 =?us-ascii?Q?uW7gjAhDtUuMsEYvox5A8d8CwuX8LmeuyEFCxZUzqtc9w6d4o+Pg+jFAUi9Y?=
 =?us-ascii?Q?7VbEUE1kveJyzmY4JM6z9gRGUEUi7XzYyumlWO9T5oyhk+klEpXl2UancKBF?=
 =?us-ascii?Q?3uJfOY+iMcR7krGOfG184nbt4sDge73rLoBjh+wdbzhC70cyzXseJAEtBDGC?=
 =?us-ascii?Q?6qntiAj76hUEbBkKMug7Du566wUL2dNQrAC14o9xhiOXFcvsh4KfwOKWooeX?=
 =?us-ascii?Q?bVggZ62OGrD+73QfD1nBh905U6V5WZm6TfEeWMxxexAUkjIgkWwMUpBJJ5qW?=
 =?us-ascii?Q?2Mgwez8zLQNE8HDTYlFob4UFDjX+48UA1gmK06oiyQGLyZipGoUcXH/MgTkA?=
 =?us-ascii?Q?Tfz/Tvm02QvuaJxhp/YGIVjAhYEzN87YsqWxY/fWm44I7Pqpz+aAdZYcxQSw?=
 =?us-ascii?Q?FkRUC7P2AHAZM0nuHGcDrspo7jrGVvrRW5n924vL4xXVscmkxshtz4RP3xt4?=
 =?us-ascii?Q?mWyZmYC+NjWVSFJSHtvxWf8njVZRVANuh9ag1KxKwM8r2y9wCY4BiM3WG7Dj?=
 =?us-ascii?Q?PVqasbB1XQosb3ZJvXzaGg3/XdSX2MwjfFCqNoXS5fhPOL/qOsmXpXIIc5Hb?=
 =?us-ascii?Q?q8msS41BSq2B9zK53+a+Oe3S8aavJgfFEcQo60LIjDIyvHwudYn+U2fC2//5?=
 =?us-ascii?Q?N+y2uvdLtLY4fk6hCbpVQRbVIWE0x0SAyeEzmFACg+EEPxv1DdxpWczyuULh?=
 =?us-ascii?Q?Fu5bD9OdmgER7L2wN02uey05DsTCGCkx0DYaNhqRc1DoPE4BGUc5t7aU4pvn?=
 =?us-ascii?Q?QGmuNDy0eYMTwGa1pkSRMRQZb4eGjaN5OV8DT+SwtJReTr/crwS0Lf1HEHYE?=
 =?us-ascii?Q?RuaocGYMhSlEWFetTRE9UMKyCbjD/IfV88nUrlVxjl+ZBB/mHvOiG6qF9etB?=
 =?us-ascii?Q?/EyHUdxo+Je75PJ197BRrK1lq+YJsCxR5ERr3IeBDeJJbjwVxr+3xwGQ99TB?=
 =?us-ascii?Q?hmFfo35mwVj8+COsD/1XL4mYtT3zsH8=3D?=
X-Exchange-RoutingPolicyChecked: Eq/qOkiG5XoPHMTG89vzIG7eBhqwihdNWKL6FY0ww/q9g6nsHTwgjgIU4c2FXLpAUCBOjizSbzmNB7Iz7cpBEw3/AX1g7ytsmpDLe7dDTrGxYV9dkpg6sVH7N+tZa10SeE680/87uY7jd0clg+/EWeY9d69PyfKO/7utUqcV3WbTWtmfZmOTeLqfjgRrvWU7aG+twrChw1fRasmm4SROjTh1zZVZPidZCqxr+lw4rmiQHHH5AAeCZ/gh9M+nmVeRk1pr/ZMkpm5hyTitk6bAC3t1ZT/wfUYRZTVJQ/gscO+uzqKhxObQP2sz5Rc2Y6CqWVOyw5c56q1RR6NKh8CbNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc541611-6454-4629-f5eb-08df0feb3cd3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:58:32.3557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7lxge73JAXw6ORyyFcGGuP571hhviiXI56Wl2m9+WlX4wzGcLC82a2PPmg4+TmCdDCUYCbpy6XkBHxwR+0xFbwQhm66UgEBa8PnX8nPNUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:44PM -0700, Stephen Hemminger wrote:
> Don't need rte_memcpy for fixed size value.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/vhost/rte_eth_vhost.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Change is correct, but patch needs different title and commit log, since
you are removing an unnecessary header here, not removing rte_memcpy use
itself.

> diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
> index 05940f2461..97d60ecf5d 100644
> --- a/drivers/net/vhost/rte_eth_vhost.c
> +++ b/drivers/net/vhost/rte_eth_vhost.c
> @@ -13,7 +13,6 @@
>  #include <ethdev_driver.h>
>  #include <ethdev_vdev.h>
>  #include <rte_malloc.h>
> -#include <rte_memcpy.h>
>  #include <rte_net.h>
>  #include <bus_vdev_driver.h>
>  #include <rte_kvargs.h>
> -- 
> 2.53.0
> 
