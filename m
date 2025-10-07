Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96741CCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 16:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA538402DD;
	Tue,  7 Oct 2025 18:16:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0F054402D1;
 Tue,  7 Oct 2025 18:15:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759853759; x=1791389759;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=azAdUZYdXHhu38vuM0qxs30aH+cXMOnYVgLjziStHEE=;
 b=fvYQKvWVbuXORqlAryCJnruTeHAquzHTYoSf/DoAdOGzf2XhxuG6aTlw
 a5R7QoLhBpr/R6doryu+eyaqtwo0cDdRWNT+LVdhWmnDqumliQMaK4b9e
 62NN66PmQhCtURvcRk4f7FrpdIs9FT4/hME0yjPitbuVhv/pSwllCJ2Vh
 xGnS827jeL+quIpNxYsZlBBlX1YilXAODEuoqxTEUFc+C/DIjuMTLmjEg
 utUxCxQOEVpCkDBf586bpBKmtIh7jFVscacb4Q4zuesfMm/4AaSdmMuFT
 of9j96JuWaR8HqhnpCC5LLcELCZctmO9ogiW+Fklz8Kz4jaW2UownqApY g==;
X-CSE-ConnectionGUID: 4TGHAM0eRPmbqceIcVs7jQ==
X-CSE-MsgGUID: pL5zoeFiSwmrR+Zq4Z2vFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61946246"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="61946246"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 09:15:58 -0700
X-CSE-ConnectionGUID: PtVfZkh4QeaxKKEvU0DyIg==
X-CSE-MsgGUID: /xZVJ2UxREqrMKhqROv+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="180608700"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 09:15:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:15:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 09:15:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 09:15:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUzfNLX49G7xCAZ7+A360Bv8O4ywh+jXbOzGyvcXGzgrqE+W0OXs0wlzOqVNeXiT74Q80y0Q/7i5w3JM1vYpamNCBbHdIwP4njM42egjVGEXIYBAvWx1FqOSXGra7wQVQFtPHptMZAEA+37IIjpg7JKBQiRi99cHDujzDRYZrZRy6bOoRGrz7zKA7eN5xRl+Wox825TVCpC17wHA2luhk3KF9oI6GjwcH/HAqwbg0MmiCOuqv0BB70LRjuBL5J4pZLVk+vRz3lrXJwnlOf+1OF77yaPh7S6PFl69vpxo9RKJLw4VPmnlyZccH/ibhJRcTtKVpMUEH7ygBRYF1pi0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBLcPGh5Q1bfdcmJ7BrTu0j0fNQtF9O1JRVIv7VeOlU=;
 b=NkBpVkSiaixGUqE3DXE8SM99bGASd6HZt3WDMons7UGz7hRw5O3jqGskLBkOPojbaGDRrshDRSOdqXCCONk2+/d4BnSeJ9pyIXSPI2zp1f21ODvEseslN2CmLC9L5ynTG14imlGNWG9UyGAKsHkGXcbf6Qo4D6tXF8P2YFzkKi6lU70Lg+enwiLInVe6syFinViHY7XIVWcmazSBtNRtTxN7Y/9XwxcbAzDGa+VhgbSdPOJ5KJd0sPWu/cowPxpPzv6+tExR9vlJ00z/DVAR2u1Of0JBJ88TNKHjTGE7UvQ79yhaBeoocc327E5ATsutCSGHhAoRhqv7aZilXKkCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:15:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:15:41 +0000
Date: Tue, 7 Oct 2025 17:15:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, dpdk-techboard <techboard@dpdk.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v9 00/18] Simplify running with high-numbered CPUs
Message-ID: <aOU8qESdjcs7Qkqi@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
 <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: f749deab-d2b8-46e5-9d15-08de05bcc2c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfD7H2D2a2UqD2JUqhHTdyKHGPH2ucwlO+PDE0WZJ8RdbwHHx35k3l5EQB+l?=
 =?us-ascii?Q?K8YkLG2UiunjOc5sVeHJLNXfd0K4T0vcSlR2jhkME9ULjrGKmUD7tlc0tS4Q?=
 =?us-ascii?Q?WGhPhi1nLVZI/Ew1WjRAjOgtgi50uZsYHz8X1LGurpmNz5Lbo3/8epLMUvjH?=
 =?us-ascii?Q?3EYKqROvVwhXofrSvneDW+zDuQ6kfUnb+tL/kHMs5t5mEfJqWL47qPrFBzNP?=
 =?us-ascii?Q?X5q9o5ZwWGXB1+mdiPV9UQVk8cFuhzTKo+c4hB5wBfXAEVRxZrWddA53rVTp?=
 =?us-ascii?Q?R01xKa+FCZQdtdribZP3ADhnvLd20nXUQyVdcvnmx7y842lM8d/pRyCgic1j?=
 =?us-ascii?Q?sb9PCJYLAgKSs9hhNhwWdauLaKs6eNR2iWYksJ0KrXPU4pHEvZ3y0/DrPizE?=
 =?us-ascii?Q?TOSwQZbNl8GIMqCCWupWjUSiHLEo4dLadTD1sNvd/ILMBW44nDNtL7hCBc8N?=
 =?us-ascii?Q?lB9EtBEbyVCEz69vEB5XQAbkqv1A7jbwl6fS85hPJAT4TMYFVYkTjMSQ/CXO?=
 =?us-ascii?Q?2jdqO8gFjAF6u4AdpoWmvs+6Cn0Ly4OPaGSSsld9bh/udgi1H3TnDRpY9aNa?=
 =?us-ascii?Q?k/XL/JMBELDM527tWLaVQdiBEteX5QpMDU08eeK4OO7FeUNzYn3GoOsXxa5o?=
 =?us-ascii?Q?Nd87UmzXP87nUAfddkb/MdtItYENLuvA4jLV7AUaBQKXF5GaC0MiSC1nFHU6?=
 =?us-ascii?Q?9BXy8H50IvIrXsK0dew9UGLnehgWIkoYlD5ZTOd+HS/uNHouxMiZepZPIRv7?=
 =?us-ascii?Q?7R0kxHC7OOpdm9aswhNZIEEc0A49PE2GMVZNJn6hoOoLHQdEIeyfdFyg72qV?=
 =?us-ascii?Q?9FwO+baku+RxsTZ5QNJYkJCVg8ffTbramkCuDHSwwygt85moDWexGfEzVFWf?=
 =?us-ascii?Q?7Le3BGMWxMDCv4kY8MYAUwKXvv1XnLrOsy9lGxoITadHJj88oRgjiIBpZkt/?=
 =?us-ascii?Q?xb5tvpHdLfiDapXvMCzxZvYYWE8eRdQeoqllVN0xDCtwrFkeKSq8OBpILNUP?=
 =?us-ascii?Q?a6tENkHAmCIUfF+eW7GytzZu33n4MH8lAWTEbXhpwX1bThO1q5o5zOMR2fiu?=
 =?us-ascii?Q?u5SKkfsAu3TTABIWkRI9xdCGD9u9T0rghQl3VLZzVCE1Zouk5xlLZXOHHYkk?=
 =?us-ascii?Q?wzsGBJN5Ckq10bWbkvDDTvQ6+Lntd4ldWq9XHvu9VG7Pbhm7kUG9y3Lraa3v?=
 =?us-ascii?Q?BSCIxAdkIuqhzine+rMdqOkvbsfPX8e21xo1tqe4GGpCcGsTX+EYzSMfUEYK?=
 =?us-ascii?Q?+yMfe09cHP4On1uHqBDKLDZYBQNfVdixR0ik94hN+qvKil+LZIAR0448b5tl?=
 =?us-ascii?Q?z96XvgzY1OJxcvBNOEeHVaaXilG/uWO/iyNX4vKLNAeotecWjpSZOuuCoBtg?=
 =?us-ascii?Q?LphKCmZ7r9RnvKwhz/mZPlHiWnsnvr8GwHXwQOOivxi4A3mDrBgX2OCzlQzh?=
 =?us-ascii?Q?HphdSOigjKTFEP230zMyDS8bhe6TVLXh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZVosnhvzUgwIg+1jJSdZ3NwoKosvFpk6trQXCqPy1d3dF2t+UXDZFaWpWqY?=
 =?us-ascii?Q?cH4oSjnmomZlqyAzKbdXxL4D8wFJeY3hlG2s94BRB1ADem45BH9sQ+sXgpba?=
 =?us-ascii?Q?JQAuyOC5vNc0MWwWjTAdTr8KOe8BXS4rer+DixgKQKBJj+auQ+gr3NH8wbOv?=
 =?us-ascii?Q?vAmhNPv93YQAdKecYiDA+xG67BiakkbdrT5F1jYKpeorLF2+5VGNfoPT7c80?=
 =?us-ascii?Q?gH2S4vTRdcn2xpO2JrXj1V+TicGMofOfAB84zIvCxer2tC6Ao0y95NFyszLR?=
 =?us-ascii?Q?nHZP52xrVT0R/FPAM2Jv/m7/mCfpKPOuFQwWZGMJz88cv0AWR+2TseEO9h1B?=
 =?us-ascii?Q?jkA2yhk0zlVeQCRHmznuIKHWH09TFk5a9Mxoy0S4SkUq3skrMUD5LvTUMWjC?=
 =?us-ascii?Q?8M4NoIIaVuovj5c3zkRtN/KCzJLn2OYtPbp6cRhkxesny7kAwHYAMokK8plA?=
 =?us-ascii?Q?EfaO28LhHCg3b7itPsWYbsGlPZs8q0yQv6nVM2x5l8SYYe4K0wS5wP4upLDv?=
 =?us-ascii?Q?L01UpQQX8yx2rvbTIl3nRWygJpyHATwoIONd2VbJr046tlaoem2y4KRYp0nh?=
 =?us-ascii?Q?KIlbXQy4Iz1R2Zlb2FG2d37KE40Ds1TgiMVYhCB/SW8bULA45cdwXdJaKSvq?=
 =?us-ascii?Q?skzNYootO/u+obYGFjJOLm87L+8V0cKr8YrYPhE2H9ftCoecJoPS/MSOFZDs?=
 =?us-ascii?Q?EDmZYU8MlXggg8S0vLE5G1K5BF7eRi7tyGfc1Q1PCY7BNe6xvi5/UJd5Z098?=
 =?us-ascii?Q?XTSkt8iBqyTFw12cw2Iln/V6QX/wn3pKMBn8VHfabEjTzcHsi8Z5H6e95Z21?=
 =?us-ascii?Q?x4Zl8k/n/PsNryf9taUsMg9evpzD2Eqo2oyAkBkPTZdK9M5F3AE0KU1M+xyT?=
 =?us-ascii?Q?zM7cT5pxEnAWOwdDSVrkj7z2XvwGJZ3RXKJGBFxTpdMnfX9b5PFgvV6AtoA/?=
 =?us-ascii?Q?KYEBOrHwcQ2p382LnpY5luCYLOGbQorWFZHkRQqMhSj0GbyBYc+eJPRzO2cG?=
 =?us-ascii?Q?EE8px9e7JS/EMGvvBm6tseLsKk7uMAm9IBv6vQaMemDnTQ080mJsWBCx8bys?=
 =?us-ascii?Q?o5OVQZR6m1HZjTVjMOyDG8aeSPvb/iI4OkvmbH/zMkVoApbmIcQKr8L9M//x?=
 =?us-ascii?Q?CSdjFyEK/hzuTrb+ZYaDHy/kPswY37qXoJM74n+RQY95nPErGkOes46QyzjO?=
 =?us-ascii?Q?girLTWJOYr1k/jwHzWkSGMDYqjJ7nJVHl1K4ANHd+v85p9XwP2pnmhhEaEYy?=
 =?us-ascii?Q?Rmentf7JG9jyjSeNfj3CiU1zVWRK9KLRhUCPoAXswo9Te/Ap0+4uDOlWr7MC?=
 =?us-ascii?Q?P4Bj9khb/vzBhbXR9lYjqJAANG9buta3e5+d7FYr8Py4aGK0oYzWvc8k9Vha?=
 =?us-ascii?Q?JdFTH+dCroD4iQ1YWVVHoetgdB9IY9l2RrqxnafSLQ+uZizJbVYVLXp+RIXb?=
 =?us-ascii?Q?6PDxIimzmEGY1rr4pnITwRNk9eadwG+WeX3S8zvQ1jP8IjwkfYsPqgYMcTyN?=
 =?us-ascii?Q?BMojIdow7cnMx13gwP1U+aGlVcv5Na6w5dgbX0wqqdoMT6XVALDGEH75Hqu2?=
 =?us-ascii?Q?icqzHKnjlVERLa8WhLSS8YimKKoJdFqvoTY1XKxkm7i//LaT1doKexjtYlnE?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f749deab-d2b8-46e5-9d15-08de05bcc2c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:15:41.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrERGy1l51CNx37UFxYCpKy3GX7RSByN9JDxSLBK9amC4NOBmAKR4Bdxj1BJOlYywI+47I0NJWacua5nETHymihCJ1/Q09+9tpI7nTxGb9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
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

On Mon, Oct 06, 2025 at 04:10:52PM +0200, David Marchand wrote:
> On Fri, 3 Oct 2025 at 10:15, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The ultimate of this patchset is to make it easier to run on systems
> > with large numbers of cores, by simplifying the process of using core
> > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > shortened to ``-R``, is added to DPDK to support this.
> >
> > However, in order to add this new flag easily, the first dozen or more
> > patches rework the argument handling in EAL to simplify things, using
> > the argparse library for argument handling.
> >
> > When processing cmdline arguments in DPDK, we always do so with very
> > little context. So, for example, when processing the "-l" flag, we have
> > no idea whether there will be later a --proc-type=secondary flag. We
> > have all sorts of post-arg-processing checks in place to try and catch
> > these scenarios.
> >
> > To improve this situation, this patchset tries to simplify the handling
> > of argument processing, by explicitly doing an initial pass to collate
> > all arguments into a structure. Thereafter, the actual arg parsing is
> > done in a fixed order, meaning that e.g. when processing the
> > --main-lcore flag, we have already processed the service core flags. We
> > also can far quicker and easier check for conflicting options, since
> > they can all be checked for NULL/non-NULL in the arg structure
> > immediately after the struct has been populated.
> >
> > An additional benefit of this work is that the argument parsing for EAL
> > is much more centralised into common options and the options list file.
> > This single list with ifdefs makes it clear to the viewer what options
> > are common across OS's, vs what are unix-only or linux-only.
> >
> > Once the cleanup and rework is done, adding the new options for
> > remapping cores becomes a lot simpler, since we can very easily check
> > for scenarios like multi-process and handle those appropriately.
> >
> > V9: rebase to latest main. CI complains cannot apply v8 patches.
> >
> > V8:
> > * dropped the final two patches from the series, dropping the new -L
> >   option in favour of the -R modifier.
> > * reordered patch 11 to be with the other argparse patches (now patch 5)
> > * added patch 12, which uses macros to initialize the args structure
> >   from the arguments header file, avoiding potential issues when we add
> >   new args.
> > * simplified and consolidated lcore mask and core list parsing to always
> >   work off cpusets rather than arrays of uint8
> > * enhanced debug printouts to also work better with cpusets and handle
> >   core values in those sets >= RTE_MAX_LCORE
> > * for completeness, ensure the new -R option works for coremasks, and
> >   for cases where no explicit core-list or coremask is specified.
> 
> I was planning to merge the first part of the series (before reaching
> the cpuset rework and addition of remap option).
> 
> I am facing two issues for which I prefer other's opinions.
> 
> 
> - First, I see a change in how non-option arguments are handled with
> the switch to argparse.
> $ ./build-mini/app/dpdk-test --no-huge -m 2048 -l 0,1 func_reentrancy_autotest
> ARGPARSE: too many positional arguments func_reentrancy_autotest!
> 
> Passing the test name after -- does work, but it was working without
> -- before the patch, so we are introducing a regression here.
> 

Looking for input on how much we need to handle here.

The quick patch below adds support for ignoring trailing args in argparse,
which means that the command above would work. However, gnu getopt also
does argument reordering which means that this command works right now (on
linux anyway):

	./build/app/dpdk-test -l 0,1 lcores_autotest --no-huge

since getopt moves the lcores_autotest to the end.

Is this behaviour what we need to emulate too, or is adding a flag to
ignore trailing args sufficient? [I'd tend toward it being sufficient - mixing
app args and EAL args together is not a great idea IMHO]


> 
> - Second, stopping at patch "eal: gather EAL args before processing",
> I see a crash in this same func_reentrancy_autotest unit test.
> 
> Here, I would fix the unit test itself, as it passes a NULL argv[0]
> which is invalid according to the C standard.

For this, I think the easiest (and most correct) fix is just to catch the
null argv[0] condition and return error, rather than actually trying to
continue arg parsing. I see right now that my patches only check for
argc==0 and argv==NULL. I suggest just extending that to also check that
final argv[0] == NULL condition.

/Bruce

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index e4851bd046..de57400e74 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -695,8 +695,22 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
                        /* process positional parameters. */
                        position_index++;
                        if (position_index > position_count) {
-                               ARGPARSE_LOG(ERR, "too many positional arguments %s!", curr_argv);
-                               return -EINVAL;
+                               if (!obj->ignore_trailing_args) {
+                                       ARGPARSE_LOG(ERR, "too many positional arguments %s!",
+                                               curr_argv);
+                                       return -EINVAL;
+                               }
+                               /* check if this is a trailing non-flag argument i.e. no more
+                                * flag arguments are present.
+                                */
+                               for (int j = i + 1; j < argc; j++) {
+                                       if (argv[j][0] == '-') {
+                                               ARGPARSE_LOG(ERR, "unexpected non-flag argument \"%s\"",
+                                                       argv[j]);
+                                               return -EINVAL;
+                                       }
+                               }
+                               break;
                        }
                        arg = find_position_arg(obj, position_index);
                        ret = parse_arg_val(obj, arg->name_long, arg, curr_argv);
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 991f084927..760d59fd8a 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -158,6 +158,8 @@ struct rte_argparse {
        const char *epilog;
        /** Whether exit when error. */
        bool exit_on_error;
+       /** Don't error out if trailing non-flag arguments are present, ignore them. */
+       bool ignore_trailing_args;
        /** User callback for parsing arguments. */
        rte_arg_parser_t callback;
        /** Opaque which used to invoke callback. */
