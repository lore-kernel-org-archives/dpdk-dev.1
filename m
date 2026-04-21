Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F317BF8FA8C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 15:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9A274029D;
	Tue, 21 Apr 2026 17:26:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0622F4027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 17:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776785166; x=1808321166;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TZZ2vsDYahhV7FeS82if9XjoTZPNt3KPo044CYcKf0g=;
 b=UxxfhSmhOMulANIrUCeitVk83WwvcBIPCveHVAyt0wqzlyF0WDCrmvuH
 jGNXrj1gsSeXqd7UyOK4rf1nP6vLtLnHfG8qqGuFgoEL6hCIL7cIh4/oF
 UYx8QsUTcCuoxt7Bb3Gezz6nf4S6Bfx8xEnv1+lHGdgL9JvP+nRQpEbJ7
 CyFov/VlTpfD21lBpB7VsUfs0mB4gE81JLgvHpESKlQSPFfKx6bAs3dph
 meUVLSKHlsaczYxx0X9+QKY34SaZWWZdG7Es5pIkdqjXxaONJyU3PyXFo
 9Vw2LMfSdFuqB/0DowX0vjzHTQKMAItUz1a4t02t7NcY8GZw1DVVhKiFz Q==;
X-CSE-ConnectionGUID: AVMBpqnmTSSYVGSSiO3PKQ==
X-CSE-MsgGUID: igXrPc1RQBazFN7VnKML6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77423933"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77423933"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 08:25:33 -0700
X-CSE-ConnectionGUID: uIgflMTASxGCA37GfZVtLg==
X-CSE-MsgGUID: cn+OXq7KQoKoeur0dzH2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="233847769"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 08:25:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:25:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 08:25:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvR3jbuNs24Yap+CvclKiJVtco/zNmOn7aVvyymYfVMNFx4tk3rV1mFTd+uMszIftwQZXmJFKFR1D8QtQBArQRmn2yRhK95gNzc5NqxvpLk822kWxTVTTS5nrhhCReDV3WbicEU6Fi4N6JZ4mtRv3z4BnY+OYlz5mzeUjGR0+MLG0aRcKmZUBjCsYOyZFftWByxQcdOfuL7kej6VBhfvpKgtbGBcgrhHlhFkUo1gHShNV75jFviDdYZQ+J51+d0C4vBN5jqucL/XtUiCX75Sptaa+mJ6ZHSzuzdqkdXy7WxAz34RS4INVuj/6SeoGUnvqENwExGvwL/lVKzsAtSZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8geICs9gILzSpc02NXFHXaYk1L0jsoKylJdgYAGgRZY=;
 b=Rokk27yo014e0Tc/ZdjbXOI+C1MumTs6QjCb76NLWPC8VmUsCXS9ej8UwBYYkgGppasE9+5mabN9vHbdQIo0T1SAvH302zB4Ir74P64QySh0B/Wl0eGaAIIJWgEYvwhsZLmUuMum9s4wnuW2u1DTe+vMjQ1EQwqcVjmsxJdfCazb7BOmhYoG13a41pyc2TdvKBTGCyJEJtfEOaZVwgvwgaFQ+hDrNtJnXH51CZ8hGKcInvwA8T0aYLh0rs4uY5UZ3V/Ag+pjO8eXr3VUfCV4hA8mx7SeVB+Az+gjNrPv3cSCLwe+Ay4rOZH4VHxvryF9SmxeXDfYzut7jBGnc5HsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 15:25:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:25:28 +0000
Date: Tue, 21 Apr 2026 16:25:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4] net/iavf: add support for QinQ strip
Message-ID: <aeeW4U8ij1_bTcFy@bricha3-mobl1.ger.corp.intel.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260409101951.114492-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409101951.114492-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU7P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ad8379-c2c8-4ba2-8fe7-08de9fba37ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: euTcgUtpj+71pxxletjeyLc6EMxrnYcvri1aSLr5e1+i7sUY4uegX9cdLCh/VBps03rVbqlv1Mc34SUK28tswrtl/VtefFu9GxObkZq4qYEEqfBotjbVHtWBlp733giRHzbDjju8HVjxxoVnbCml4hHBlpRDRk4+gFlYhSIGXJFcfGWGM/sr6PNUR9f2dYZ7TeCl+a+nhVBUgJmXWwhI7K4+2qn2KJDC2LuX+GdUUkHorycSZloN/i+LgM7TWRMrTrMU45Bk3A0FkEIVoqeEbrqUwdB7AUvxLHrqr0QFk+qyu6Pp4lxRKFydo/G43HER3hyjp3DtHmU2WgbK2ZUQZMvQMH1d30sdVx3e5eS8W882kZ6CY+AqzLP4y0fBf3V5pCFJg1r3NhsIOVfBYpE0qMaZR3DPs7G/sGMX6QwX8CuX2uyjTpoTKh8mgAwTyBqS1iztZWPXzZKLl/BrORWGE28GPtGXsTgo0IKlr3aiBi/b0TNA3zfcsjm0YOYo+aYooiPNj5EtPqN/cGhQGXB1or5rMTna3sshkJVr+vGsTcgatc/7VQsQEZmfopiTg6v5yBrmG5bT42qqdlwZtNdDO9BI8QfcL/4EXBRa1zBnZMmO4hsZ+3LHc9rlF1u2KF3qq9qou4I9IelSqIvN76+hR9yYoGknIV2cE3j0V1UZuqbMHLVzcANv1dMlS8xBsvGslL2GaP7PJivjEVatUHkp6wIB++7zI2Gj7W6ntsaTW08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H9t5GVAddQwEELK5w6eGn/LIW/GUHoSEao+lK+xdPQje2HjwJbcFcscWxjGG?=
 =?us-ascii?Q?1w/+VEx11vTh+SDULbyfG6Qeu1pWlDeSPxWYz0ZsqeTc2xz5tUjPj0KqaD3m?=
 =?us-ascii?Q?97o2ZTx+qPZjMZUbkNNGS7tggIe7GppHdg238Rw8BTcUYV86sdFewlKeNTRX?=
 =?us-ascii?Q?1Dik5yRLuPaUene1rRj2xtkboJOakzr8o0qLQKmlWXwJhoHh4zSur6oNP0yS?=
 =?us-ascii?Q?WW1cvZdYgJyq3jOl38eAYB5Y3a3O0wf3Wf8I8lXYbFgFhIaa/QxeUnQE5qeG?=
 =?us-ascii?Q?sBQAa6m0yFNHw9UOaQ0uSJTHF9yJw8XtNwiZikPjVeCxB/KOPbxD6AEYwez7?=
 =?us-ascii?Q?f0SkfjQtquPYTpTdaZnO/KkSf37f+Lq8fz/8PVyV2Y59+ZvQePQSxdb5Rn04?=
 =?us-ascii?Q?hTRq0rXZREoZGdQzbgTAMEpGle6XV7UEpmmnqiyvK4WvlOCwc/is4zqWsZ8z?=
 =?us-ascii?Q?SbLLO76hka/kmCbU0iJgVG9evXPU04UWft3E3P5yiFCglNL7dy1WE4by1Rq5?=
 =?us-ascii?Q?9O7NOTh6O7/tJun7QcEUe+qiGH9/Gw81xKLtDKgRIZJi8mSgqCY3i8jcDgSn?=
 =?us-ascii?Q?V+YLVdsiCE2087SziKRQ/eRQ5zUlZVW7Mjh5/O7uxAgn3zC4GKjWnyMroaWM?=
 =?us-ascii?Q?Fs4UUpgkTdMF1nKNlqYyqhEAOE6oLktOSYluaclXV05cCLokPY2PdVKxzk24?=
 =?us-ascii?Q?hQExdS7kDqXjnhIjP4KzgQbDQFjfgFK/k3LKGIHiqNctY7UqoDXKF4QAvdIK?=
 =?us-ascii?Q?W04nDiYPqQsD7dnk87U8kErJa3eTYdEP1zXUn5lStVjuXa45GvlBLOQOhhlu?=
 =?us-ascii?Q?YZATghSzUX6Q+TPUL2Gsi0TuLc/Pwtpp23YdwqA6QoWS4pOUIXo7EChzPsRA?=
 =?us-ascii?Q?nVO+eUUrOdhdcmzSSCV09VrmZbrjY05IZx/muZyLKt54nn2Bxt+IOK6I3xqZ?=
 =?us-ascii?Q?hwu+PnaSzqqBpz9/zHSygCHYnE/l+a216x7nX1W5Xy4QZ61uxCDHE5dnR4Hl?=
 =?us-ascii?Q?c7e7g3PWUqdnTgN6xWGL1/1ZWTIhc79ABEamAGvM9LGRYwXeFoWIWA5GY6aJ?=
 =?us-ascii?Q?yHMIQKXs6Yivrn5POOSc0KnfhE1YWd7FhktIuFXIwdC7eBt1d8SfEE3vVgfW?=
 =?us-ascii?Q?Szpw52H1v4N8ZXUAXvhDkpLCXO8C3POPMxwMiE9rPXxK6QjsN/tIK0f4FM7y?=
 =?us-ascii?Q?7EU11U8Qzsa6711rjGdJSgF6OBEuA6xSL9ywIZqV9DAyOVqBfb8rc2/ezTkh?=
 =?us-ascii?Q?YtvoaULn6mfGBOro8Up+a+OOw9oNbgqKPNhJePWswfdva7nUMpW/Zk+bqKx+?=
 =?us-ascii?Q?SkJy6HQKSqvXQ++YDFv7EO03mg44WtGYNVyS2pOTafVg2XC+uf19tRv8DucS?=
 =?us-ascii?Q?0E9M5ObvgFTLbAIz0W6NykQSZxG0O0DEz4NV9AXQlX1vgTftiha4HCw3hNe8?=
 =?us-ascii?Q?HyO95NSLs87aH8O5/x53BvjT6IFsnoYmADXwALIHB3lPXJC5Y10NHHGZZ78E?=
 =?us-ascii?Q?85xJwPcwjEF3UIxBuPDtaAodpbE5tpzVK9no0LDCv863v1XL+Cs40Z7f2iLi?=
 =?us-ascii?Q?HfkAOpzdqhCTfvH+rMCaBkFQ2n3YwU6LWVPLS2XJQq1faHrraP1/CCGETio8?=
 =?us-ascii?Q?Hc7nxmxDXqJQFKdSLukOgkklVqnUDDVwT1WSd2wydHsF6a30z/fV4YHUvJLu?=
 =?us-ascii?Q?pbvpIV23HwChA4cn1XRyLqIEApPh9WZvdSzOQxfgD1XxETpEknROjqEk8T7J?=
 =?us-ascii?Q?LjFc0lXWEDvVp6YL9CUel7Nf8rwYA70=3D?=
X-Exchange-RoutingPolicyChecked: QfdqYYOjeVm9umAjwSlLykPTQm+lxKjVbcAuwA1u2R/w58MIngytBC9f3+oQB7NDi/GWDcrNu4evKcn4eQDo3W4w11UTkNKCNjULwPo3n39GEY4su/HH6GH+wkXdWJPy1tgml2mi6dDfZKy0fGDxzvf28dlzJi5FNwNDE00l3ORoMwLDVwb+s6KyTrJXkgb+niCTIynNeADTG7al4n3oam9PzwYdSwBz+RTT+1/7WbEnXnyy4e+rzyUlF69fiFaBJXas63cfMvOuh654kjuAoz38dxT4LeAnM1XxHdgie23KcDbc6clChmVcXR+zIPdQuU18uskQaHOlSQaJHnIRag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ad8379-c2c8-4ba2-8fe7-08de9fba37ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:25:28.2548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpnmViFpWbg2+iPpMheMTG8HYt9XMLuSnCJ9cW2GCAGFal4g2/1M7RT/FPkFHCMxuzJ7woRFSgxS1omH+9Cusi/EafVGIg48WKrRd28UDMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
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

On Thu, Apr 09, 2026 at 10:19:51AM +0000, Anurag Mandal wrote:
> QinQ strip with VLAN TPID 0x88a8 & 0x8100 support was absent.
> 
> This patch adds support for QinQ strip with both Outer VLAN
> TPIDs 0x88a8 (802.1ad) & 0x8100 (802.1Q).
> VLAN Extend should be enabled for the same and Outer VLAN
> TPID should be set properly.
> 
> 1. Tested QinQ stripping with TPIDs 0x88a8 as well as 0x8100.
> 2. Tested Double VLAN stripping i.e. QinQ (802.1ad/802.1Q) &
>    VLAN (802.1Q) stripping simultaneously.
> 3. Tested Single VLAN (802.1Q) stripping.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V4: Addressed ai-code-review suggestions
> V3: Rebased onto next-net-intel-for-next-net
> V2: Addressed Coding Style Warnings
> 
>  doc/guides/nics/intel_vf.rst         | 31 ++++++++++++++
>  drivers/net/intel/iavf/iavf.h        |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 50 +++++++++++++++++++++++
>  drivers/net/intel/iavf/iavf_vchnl.c  | 61 ++++++++++++++++++++++++++--
>  4 files changed, 141 insertions(+), 3 deletions(-)
>

Recheck-request: rebase=next-net-intel, github-robot
