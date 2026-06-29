Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED7DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 11:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22A5F40299;
	Mon, 29 Jun 2026 13:52:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 862184021F
 for <dev@dpdk.org>; Mon, 29 Jun 2026 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782733951; x=1814269951;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=itRq+Osc33TK1fgSNbvtnzSboDUeBRzo/VjQT7ftO4g=;
 b=A68KQ6qJUMGGiK5c8aXINk4qRsswmPxV+j03FysuVihB9ZUyxIebEg4W
 yYaFuUVxRC0p/DEMwEPiTJv6JwKdO95OnvOMM65pO5TAgT7wv2GZPYQzj
 QGdGxQY+g+DW/8/q1MXn3HkFs5kYgzrc4ptWhFOxXI9TJPZvdGZynjUqV
 tQ6P4TqiGNkxGXMUdRNdzr6V/qCOTz8Y05Turdlm5zcDuudOy8qAsAHNx
 MXRmmyWCRbYjb8h1MQUkRkRUZk0kNWHFTj1Kd+sTm0ji1k3iJQO0ep7qi
 FsJ40UQmC7Y4y4SDzj0e0ySVtMtstvS19vN4sKCMemSXiSUE36FE4cv7r Q==;
X-CSE-ConnectionGUID: XyMKOy+4QTmfYq/cze3DSg==
X-CSE-MsgGUID: gzjlWoiqTgCRXyDt6J0nsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="85967375"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="85967375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 04:52:30 -0700
X-CSE-ConnectionGUID: 7udIO4rWTQ6WVqGcVexn6w==
X-CSE-MsgGUID: s+hgiVsRQBW/0mtT3bTjGQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 04:52:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:52:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 04:52:28 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 04:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sebA+BohfnKC9rQh4ItrcqkXXyXJhJ9/eKBS/JSVaDJDxwDFmEeE5vdBHfjLFZD3fSGS7i6viSKZH0q078/qpDkXt+9fFgq7HeqJyWDIbj7Ofc2Rnl885YJ6FsBjdXXE+imVk0rFDfHiiusX9c/qWWYRJ4TEcPTn4vxlzKUn2OHKMi0zeSPV8v+KlNWLt/+zdEjgttW63glFNCUTfHryZrysDUwihyBBTxQLV0hRpmPPQ5ViB1Q2iXjYE2Arh9TGh7PVzprWVAvD2RbuxIIw2CUzX8CClAcy53Oc0hybPGQdPteMfeVgR5pWUKZqhnVYYI1jkjcX688AO3EmMcT4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kmj4DXJrp4gIkxBEv9rAX6kHWpt2HW3MZZ777N6wjk=;
 b=PZwGqTQBBwzagjJi1smjPI2+XM0nizr7Yyv3SlMHgqqQ6JL8LEEWoTM4ZtS2rmcdf6IoUv48r1M59BJXFXDSHTbzgb4J5EFR7ElbHnpvjyM5BlVGZWjuiJAH0CbQGpi8zKEsGXS9w0vIdnE35ruOG0Hmg/QDW7iAZ3J436QeQrPM/LjsaOtbxtHvA4OsXQYiRRi1w7rXWZIlVQqn7B7C+9EzpzCHF9mwBr13lDq+mw5mFyBJf1gXKyq0Xb+C89XbIOZS/F0FxY/+pILefX10/HEvBEtE+virUH+tMgyhm46EmNatF7D6AVEl7bG/gd9UIEDHhh1U7d5zWp7f8XaZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:52:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:52:25 +0000
Date: Mon, 29 Jun 2026 12:52:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] build: drop dependency on libbsd
Message-ID: <akJcdJ9beQ560Opd@bricha3-mobl1.ger.corp.intel.com>
References: <20260624113550.821516-1-bruce.richardson@intel.com>
 <20260625130813.1527333-1-bruce.richardson@intel.com>
 <CAJFAV8yP-Mp75so4qoKqOHUzbgWqBi-e8JDLY6yZDpjhodU-tA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yP-Mp75so4qoKqOHUzbgWqBi-e8JDLY6yZDpjhodU-tA@mail.gmail.com>
X-ClientProxiedBy: DU6P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 65730c4c-7023-4fd1-fca6-08ded5d4e2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: mG8Ms6/t9fNKMky/nk9O2WitMAKCPP9fSkPatHb8JmZ+c10W84gsbcHfOpxe0ne19cM5ne3EHGY6rjfaDemKN1HA2sx3owNPIDgA9MgW8tnw15ZsL5bzflI/oDQ6CqBS2N0irPS1W2YXPVxC2Gm5hO3eXZqu0Pn1qOAujsDKjvY2qN6nLwVjuOaesZJGqN1JFYr+K8JV+eQw/5F/1AThxyKuPtGVV8zsy+09LyGV5jh2Gp6iJWGGSCGRPUfosv9DwcroLAle4LCYpwMkFs+CBLVuJoWMnGvpUnv+lh2PFn7qo69HHnGYgAkz/dd1kKLltpUE33nvP+7L2JavT1ljIro4depc+31hjDbPKDEkkAa+GSqoPSQ/qzaTijlzdeo6AqgYtvxvl1EZ6XPngbieFyhJ6+Sutwn2qD7goagL/e+H5WJ4KUs5DbExuPWg8UxnlPRxK/JTVdUGZ3wA9++NXyclHNJduIxF/3bvZnkEnaSJcTcBO1pNv0Upvf47ldgPaSLjRW3Qj4AGx52z6bM2g98MkqsbwUAs920w+ECK8+u2jj8NLzO8b5jzpNCkxhkozqwpZNXwNOjS0r+CH09vCIW3ZcUYXBhH5DpJFyPQjUw1RqpodI57Veq8PKUyBp7+oEdgzNuEsRcGYCv2KL0sxMjq2kdM/GwK9Tw1G7mAeK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esYJxlPNKEwi3ZbvLP5eRHpso9Gtj5e/G+AXysE4s1FtTh2hDCexrvlIwkic?=
 =?us-ascii?Q?qaTGG+LPzct8ynRW8g9Uu1xIXatG+CbSnT87ar703vMV1vRK7RgJRepKtCEm?=
 =?us-ascii?Q?l2f0tdSAHQZUlF5nlbkxaetS+BTgwuhCbCM3UeTIBjjGxJm585A43Khu7UVp?=
 =?us-ascii?Q?7ERrhnRqhONIaUL8voZbQ2h0QfZRKh9DaJmjwGZvvKzRKo0C4NraelGKhQAx?=
 =?us-ascii?Q?dHDjY0Z8mAeWFvbSn+Sdn5YmQuqyrggKrhRf6cEU5KA0F4dzy9C4RZAYxMPt?=
 =?us-ascii?Q?jRitLWSBUOQJSSc7V7zh9W8wZOiPjgW8RQb44ZvNFlBFrxSSbemgWdrk/WGt?=
 =?us-ascii?Q?kELLo4Go5kmEhkrBtXm7z2i6ZxFC6PYlbbSkXQUfWfd26nW0yr3Igegl+Ehu?=
 =?us-ascii?Q?RS4yPpR20Ik79kDjG8nhHuNw20hqK5719ddriNgf3sCduzJ+vDdX1VUqhS3W?=
 =?us-ascii?Q?80SIeXnUkbKM/FI7VJTTs0dwhUiR6sF+M9KOPhg7ruPES1hbvzqZ5dvtVXmM?=
 =?us-ascii?Q?gZTYP6gmDgciH7nMg2IzJ2LooL1q/rH4iddA+ZhVP9CPYXhJ1e8ynn3KWsWZ?=
 =?us-ascii?Q?0rRVniPOlPPGXOe3Z1OAMG/KS2En50C4ChnaT9ea7xF/N3PoetEf/9qZA61j?=
 =?us-ascii?Q?dtY1sfNBB/E0cllVMOsaBNt78vwea+KxTC+TER/Aphp/6c+Bp6G+I3Q/N1Qi?=
 =?us-ascii?Q?2HVQGJVMVfo7r46cKz3h835VwBQ5fWih//IBNep1YSQAre6+//D/vC15AwSb?=
 =?us-ascii?Q?DuWfpana2aLLv2pvZKkSHFFh3nTg1Ddbk0J7qClYCPgJ87futsXflumtPuJs?=
 =?us-ascii?Q?K23vIa+Sv7jE3is0HeCoPLRdMzxEIoEOWqKuLeFCk3oI7auhpnSbpA0k93Na?=
 =?us-ascii?Q?lQGIpfXzQaRgnRyD7k0SqpKg71W2WkVs8DiifojNajSptnjtWxCL9P82QVCL?=
 =?us-ascii?Q?QVYYTMyKBr7aKdJwupJo5LxMaaOO0YspKZbLGasPxY7svs2zm5CibTs0fRAw?=
 =?us-ascii?Q?Cxdio0vhhv5sJOKHPPHDLCVMyPXIahPpup6Sj1ExhX+6iJw7ILy/LCWIzlQO?=
 =?us-ascii?Q?W3URV0ouD4aIO3TKLcUbuLLHB8wpXz03YGnuMbL+vc/BmVVWnsqNa98BnO9P?=
 =?us-ascii?Q?Ns0VpgoDNpwIt1daXC0H03vFkB7xoWpohaj8yUXoNRLzvw5yWJ7/87IFIfWQ?=
 =?us-ascii?Q?73A4zLwWZME6SgwFuqLWwGZv6icVMZYaaCY61xwmhhLIc4F2BywWaom4H68Q?=
 =?us-ascii?Q?LCRNijLQjTfZbA4wwNJwuuwdWZHdcmPVsteuTZKda/boab5GP7vwtyon1ie3?=
 =?us-ascii?Q?rKt3htNZDKMvSIbL1FPzOFVVyOfsmVT3yo1pzZRFFfjWeL5ka+55k1zxGYxK?=
 =?us-ascii?Q?z89y2F4I3c+4dWFvsVqu+Dgxk5Hz8xky2r+8BF5G+R3SS5PeC40vAs3JxgIU?=
 =?us-ascii?Q?4gBEl3tokL98rcjr1Yf+Wl1ySYu+70te1LQv+tzPmIFWPfZ52mGinXw8QJA4?=
 =?us-ascii?Q?JUJO/k9QKe5G8TJUzhezQWcFEMJaB3Hz6Dy1LJ36AFyAEUW13lK6sg80otzl?=
 =?us-ascii?Q?6MDjsTiKu2AuKWNXiCVVWQHFfwu5EiXhbwEVUxl5hrpfI9f/Bt8xJl+iQGEA?=
 =?us-ascii?Q?8qi57VN0vIUqr1JS/JC0dIOAnhLN+r2bk/8ycmIdK+E81nEfhYuc1S9BoFZF?=
 =?us-ascii?Q?Z4zar6Nmfm78lhlDgaxBK+lSQ07bP6XxCoOkDD7dWRZ4LrOOhl/EXMFsaBsw?=
 =?us-ascii?Q?o92LgzhN124F2hF+UjixVhKZ45fg3RI=3D?=
X-Exchange-RoutingPolicyChecked: QFH1wuM/VweQBJ/24w0GQS8nBRDsHV4pqS8+W3ExKBOWjxhw5Ap2p9AYUhyHrNZdkkMrhVkJWg1kLYrLxIsCPAVEPUH60W4BZWdgjIlIGNtMs+hdxrTpnj53a2dLhRysdUqv3/B+72NaB09vahHO2WEQlN/sZ4RjQQTuxTSLszmlBoPnelRagZXTCpUqKDbQLg/a+sSfh4DtSWmeIzoNzFeCnAdt2+vsq+wSm1iM4ZweIOSD+UVp17qRkY03ZzrVVQQ75OnBtEnwZ2ZjieNSE94PGDlfzXJywk0cpGe55BIAjYmntQC6iTy0GQHzuH0O5s5eO3Z4kRcTEgRzMn5k5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 65730c4c-7023-4fd1-fca6-08ded5d4e2cd
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:52:25.0325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqAVP9ALwT9lnhNxKWihFQE5vx4ouS6MS9nKQQFbL4EqWKVyE2eZCzH54qMLixU0B5zLdwDCIoVUL/wohM1S2WxxxJrOUEx7tTiXpZYz4pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
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

On Mon, Jun 29, 2026 at 01:30:32PM +0200, David Marchand wrote:
> On Thu, 25 Jun 2026 at 15:08, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Glibc added the strlcpy and strlcat functions to version 2.38, released
> > in 2023, meaning they are natively available in modern linux distros. At
> > this point, the value of having the libbsd provided versions of these
> > functions is reduced, so let's simplify the code options here by
> > providing just two options for strlcpy rather than three:
> >
> > 1. native implementation for BSD and recent Linux
> > 2. DPDK-specific fallbacks using snprintf
> >
> > Since the strlcpy and strlcat functions are the only two items used from
> > libbsd, we can then drop completely any DPDK dependency on libbsd.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > ---
> > V2:
> > * took the work further than v1, dropping libbsd dependency entirely.
> >   Now DPDK just supports native strlcpy or it's own fallback version.
> 
> We still have some references:
> 
> $ git grep -i libbsd
> .github/workflows/build.yml:        libbsd-dev \
> .github/workflows/build.yml:        libbsd-devel \
> devtools/process-iwyu.py:def uses_libbsd(builddir):
> devtools/process-iwyu.py:    "return whether the build uses libbsd or not"
> devtools/process-iwyu.py:    return bool(get_build_config(builddir,
> lambda ln: 'RTE_USE_LIBBSD' in ln))
> devtools/process-iwyu.py:    keep_str_fns = uses_libbsd(build_dir)  #
> check for libbsd
> devtools/process-iwyu.py:        print("Warning: libbsd is present,
> build will fail to detect incorrect removal of rte_string_fns.h",
> doc/guides/howto/af_xdp_dp.rst:          libbsd-devel \
> 

Sure, will respin and try and clean these up a bit. I assume from the
detailed feedback that there is no issue with the high-level approach here?

/Bruce
