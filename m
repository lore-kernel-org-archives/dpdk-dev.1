Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E70CD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DA92402A9;
	Tue,  2 Jun 2026 14:37:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id ACF2040150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 14:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780403863; x=1811939863;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VU2y/ZaRgg/1kBmvGLe4FRwwcUkanXUXcmyDq49kaLY=;
 b=lTj+I6eOt8doNKLBvof4KzncpFXWmG2MNdXhiOHKBceIvbRl6guL/axz
 PsEBBBuOlw4JrmsFwhzfZJTLhIEravkGn/LGoDO7GJ89s6Et9ly3UBLCn
 Wb8Vr2a8NhBXu4lobS5+9HrMImJXF7nNVpST9CR3oHZssSfr17QDRkcCe
 ZjqTIrZYlgKv7V+1hSi/5B/PTKYPDZrOJVqvIl6p8qdmEHhPLuhLY1YXq
 jvy5E3npIR1hmET0+WxsAWLn0nwTU+vSj0hft48FX7HcfkgK3APKSbdS6
 kmpyx1xO8Z3WuJzsAEF7eVQJpZnIRrB+XrS9AwWsEA5aw4C71plMRtJ+o g==;
X-CSE-ConnectionGUID: +itfo3C9T/iu0E6IrbBhXA==
X-CSE-MsgGUID: CgWWBMv1RtSESiqcn03T7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80217004"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80217004"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 05:37:41 -0700
X-CSE-ConnectionGUID: 4wJ5ve9uSsK6prjGvdO2EA==
X-CSE-MsgGUID: G+Hi/xQoSZKLeBVy2Aa93g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="247852636"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 05:37:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 05:37:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 05:37:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 05:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQUgmYb2mUS2ojfaKcfcq/IxDH0quhUE8OcuxNk/o3J15quMQ+2SnGNhEUdJjdi3A9eaKv/24Zvo6jMJdznUtYVKqSMaEYupqfkCyNZJbWKCqxSOX9c1wHj46orRETjnh1l6pRC+sNgZ7MH7Zy8vG1iG55CxJ0LMIlRfPjwjhnRqXFGJmhB8gDuZJUov/lZ8gOy6VLoAaSotu2UN6RK6hwurhAfQqKrE91y0w8VA8ZFF3wC/F1B8AXnV+hmBu5kCuaNBQ88lk7D7VL03BnaRNDb4iSEmMzvokOEdAcbVXkJaCpk4D8IH60HQM8BvjGSD5DB6jScH1oeSrZFk3dK5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCzgQCoewpsyY4fRWhpWE+iUQ/0iII63Y5sTVhnM5w8=;
 b=B9Vdpt0LCdG6ItwKZKYGxFGEUiiEP3p5+HqyuAIY0460A9a34xvw5nMESd3KbPYd3v61/+e2R7QI+9bXNxzj/IRCFxhXwCJqUKdTCpJukO0iq5U2CrkZvhB57kZDRK10LJtNesTHVR98pk0IHbOZzw48AO1ENlQXZ0Ylz5SzSimwb6rLWRYip5tACHkEKocsk8YLY/hHg8BUDX3PfxtjkMva47CXsfsqsHXEPH0NgwgDxhz9WgyxjvxXjKg8OrnD9xeBM8Ygd2QHoamllictv3MxXTB/byr4jwSHCZvGvKMrtsj9eKEDg0ZTi2tsLDxUBZHYF+tjHHNUqxnxyiom/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 12:37:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 12:37:38 +0000
Date: Tue, 2 Jun 2026 13:37:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>
Subject: Re: [RFC PATCH 3/3] build: deprecate HPET build option
Message-ID: <ah7Ojs3dqBrXuLIq@bricha3-mobl1.ger.corp.intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20260602090847.905721-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658D8@smartserver.smartshare.dk>
 <CAJFAV8x5_JihAXe_bruriVu01b5wmF4fJ7vD42yFfNwpJQwDtQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8x5_JihAXe_bruriVu01b5wmF4fJ7vD42yFfNwpJQwDtQ@mail.gmail.com>
X-ClientProxiedBy: DU7P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a89ae5d-ed68-4666-17f3-08dec0a3bb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: sI9IPn9lDNvaxXjk2HmEDGauypgUaIUqn7omqrk4XBsZ8iPN7PC9zbczafDsbJHYrRdVeDBo6v29pnNay7xyoPPA9+B5DMMdmOWZMLUHRF41Vnum02og4uXvxGDoUTu8gz3t3+jW9B+wfK/a10F6OpA28tLNzq/St4sDB9QD1X9vB7Ytjik6e9VaTR3OhB99dQP3fmTVCzEAu21fdy7txZPWdUvhmjIYTN3n7jk4knVKHsPT9aIiX98BMFsbjoUnNwq473DlOG6QvaYEDdGf5LcGdK8wFJeblRAllAXXUo+LtpxWFeuA3rM5KrTOe6vFiqGVdgwChuZkEqNwNsIO8SMqWlABUL3N6Wnl7Oc8Y3m8XuTKTQ29PwLETHxubJrdnMWsF4ORp63EkrFlfkXOblAmD12GaHaHfdA8qzxQLzHEiztvKZWN5xYr5vdmzvDlhyYbtktnVIslQI59HFHlXN/1LLmRYgi7Bg6cEFBld0swWSJDvksTSKl75BaZyQXLjMo8YqviYfj0XM82Q3rlBgjft9i3hymYvlBypaVGNTlWQRfn7ZP7wfMgChszUtgfis1Zg7yt6mowqlPpJ+sM9/OatujPtVXljYY6LnDTwVFd3gZo8ypv9XUdjzWtuGknIUYNAb29bl5qnqJdnkiW4MHIibY5UbLbLE1sSDP301BDcq12fdsoyfGgd0FFBIcR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rOdZ7Zpfc8K1TxGddcAKbA14dX4g2CWHKFlH2SLk0lk8so0hHQG/XObq1G?=
 =?iso-8859-1?Q?9JVSO41BGtLuzFOABAeqY6WUZWkgHpvKwjRtySTeL57xTmsNLnEyW0hHZX?=
 =?iso-8859-1?Q?j2JaoLNCp5f5k1l1LrMqBHA+hInGRXIh0XzRE0DyRbalrRAp0ezbBvGdVz?=
 =?iso-8859-1?Q?me0Z7yC2cAWWrZ0LVF3dtOY/UE8MktcRK/7QO5AswFatpJrQCjEYNQx4eQ?=
 =?iso-8859-1?Q?qJ5IVQTtL6TM8Prt97bmPGB8tp9dEI16COXsWvBT8QJmEsqgk+YtZdcgTn?=
 =?iso-8859-1?Q?fhh7aqsj/Qbil2vi7QUr8rk06H9PhY/EsaHIYQgCLZn517TsxDeenb92Wx?=
 =?iso-8859-1?Q?Wb6VT4VNyaenAIdaGcs9j+fzGvYyVSb/xKt7cubilF3FQf+BfpFtwX+cL8?=
 =?iso-8859-1?Q?hQR+Qo3b1TTSjY7V/GfFfUPXtqCjd3Y1qUF5amZrxkcEFujE07fMi7/8IX?=
 =?iso-8859-1?Q?uyG8ucRSz3SD8ZudL8W61273ckknKpwOSbnjCddDb0Yq5mnBz5w0nTi/Np?=
 =?iso-8859-1?Q?LYR3R1xGIZop+rvA/MRAncEDYuCzJ3aiUg8eGP1l61PJAibgUhmYWaqUfl?=
 =?iso-8859-1?Q?t0SYFamCGeNsBsdthcMMl/pmqeBnUbTJQnvAf+UQNjFyC4zhwuE7J/SW5K?=
 =?iso-8859-1?Q?nZq+DenhGheOZgI/6otQe+ReZj+B2o13d/JWu6VhTYY1aEBKXpQbacxzzs?=
 =?iso-8859-1?Q?KaPGBejh3TjAyyq1Sj9cOJRGCNvIYrw+75Tsxv+WmBpFWp/xKjC4lgyzm1?=
 =?iso-8859-1?Q?G8GVH/Y7/B0dFEMJv1Kpo8P60RyKwiuZGXkq9K59BYyo076yWGJNXaEzu+?=
 =?iso-8859-1?Q?xHDXdq1masMj50Ev4dbKLdlPbTPYEuQT2Kkl69UMeKfguI7aF5vRkLjE4J?=
 =?iso-8859-1?Q?P+dwxzRF9BVRBOO1a1VEhuTF477pALUlWnHoF4ShFv5W69HN6PW3/iG7cV?=
 =?iso-8859-1?Q?DtmltSoT0hl8hjyNjkKmPjw3BsmqEdjoIHhMPILf4E793OVIydoy3l0456?=
 =?iso-8859-1?Q?uqIUqZZOonaf9wN19L1g3wMvTecGp+XyHzXwGlNBqGw0OYywQkBnw2tnJw?=
 =?iso-8859-1?Q?ep7YfSIy8flZI0n/d72tBMkGa4UR6fLITCTM2dd5sIW92moeRNVHsplxTU?=
 =?iso-8859-1?Q?AO7UPJbxtsk9CHH7qhgUkee8LR91iHmye4tSn+kadcb4pDVezS3x3R+9Cs?=
 =?iso-8859-1?Q?5XFv5bMHDv2sxcd/G1/QyqmfcoMrSna3JJaVGvLislyCvWH+1p+pSIUARY?=
 =?iso-8859-1?Q?/UJ3wMq07avEaq3ui8oMwSRCtbb/gIMWWsTcrz4fG9vBiI93FzXy5QNLxK?=
 =?iso-8859-1?Q?zMTfufa8wYBXtqMzb8vW3ZJ84ypwG78GmM1eGGXvykhJIbSm8KbLu6iHYO?=
 =?iso-8859-1?Q?CHQEVBvRCP0X7YjHbaQfZb3GDgeDbqtdRO5PrWakdmgqTK+ebgMLcqux2m?=
 =?iso-8859-1?Q?k/p9EZqw1iUBRgf2sPKR7K8RqjitA1gGdilspBBHWF+4+LBNWTeOWi5HfJ?=
 =?iso-8859-1?Q?qO+JhHJ5ft6s0KgDG15o81Kh1HfB3+W3/HsacJWuTZzKBul7dYSMq+eSoZ?=
 =?iso-8859-1?Q?kPOXSU1E+81zX44njzLMODvVIMoVw9gF1cd6JqJjNpL5cT3dSSNaeoh0fm?=
 =?iso-8859-1?Q?xwSz7y2mwWy4+2CQ6JXW23Cf+sLtO8Kv7roYv+EyBeF3JgwSXRZM4tkUq6?=
 =?iso-8859-1?Q?9dyWU6WbvrbNgdDyT0u7Ymi7Z79F5LAC+T6Bi/HD7F3a7I/aB1Twi1jwPH?=
 =?iso-8859-1?Q?UPBWQ7e1vKUg9rgMtTv2mVXvU9syhs6Zx6J7Tv4WUAEoOOpBQPRqKkWVlT?=
 =?iso-8859-1?Q?yMfeSlscULG1follFb4KrXXVpeRaLTs=3D?=
X-Exchange-RoutingPolicyChecked: TzGcDP1YAm/Qw6J7NOQbbVPMyEQ13aFT8c/8uTvfJeg8j1KjjaAuwNEffGiSVR6ahpo6WN+NZFtEBEn7dFkXVsx1XPF8J9o1Z1r07r2U81ZOFAjfwTdSR1vOQ5yvYkmeyfiuirChg8IG1N8qC69ftrNwlg7bhMeXkgE5d3I9PfJAvwYhKhXDl8CyOR5Y//3upeEAW/zf16h/e+yTeGv4hnlAvDN0UbfOh1/DOjwnb91ScasX3UBYK+MOOHo3hlnaZhFd/8rAB7VPCO9Hgsjywf3OwErhjv6Tu67Q3B0KYRaSUADqPC9Jt9CexQY4P6uZe/fFHUyLofeJDNVI57o9Ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a89ae5d-ed68-4666-17f3-08dec0a3bb29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:37:38.6657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUYubxb8XyJbMy/yAIWIA+3jqDqNS8MyxKNBeUzXkx3ChkGpOJ5CobpWBEJIS83hV1EK1z2N8Os785Bnm3ZQ5wSIPdwIi4Rm6TgWHXaCOAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
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

On Tue, Jun 02, 2026 at 01:39:42PM +0200, David Marchand wrote:
> On Tue, 2 Jun 2026 at 12:47, Morten Brørup <mb@smartsharesystems.com> wrote:
> >
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Tuesday, 2 June 2026 11.09
> > >
> > > We can enable the building of the HPET code by default on Linux, since
> > > the timers are not used - or even initialized - by default. Instead an
> > > app needs to explicitly call rte_eal_hpet_init() to use the HPET timer
> > > APIs. Therefore, let's simplify the user experience by deprecating the
> > > option "use_hpet" and make it a no-op.
> > >
> > > To avoid issue with the dpdk-test binary which was trying to initialize
> > > the hpet on startup, move the hpet init call to the timer autotest -
> > > the
> > > only place where it was used.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> >
> > Careful!
> > I think this patch has unintended side effects:
> >
> > On Linux, it unconditionally enables HPET (and sets RTE_LIBEAL_USE_HPET), which was previously disabled by default.
> >
> > So, if some Linux applications use #ifdef RTE_LIBEAL_USE_HPET, they will now tell DPDK to use that timer instead of the TSC.
> > We can fix the apps/examples in the DPDK repo, but it will potentially change behavior of DPDK user's applications.
> >
> > I'm not opposed to unconditionally enabling HPET ability in DPDK itself on Linux.
> > But I'm worried about side effects of unconditionally enabling #ifdef RTE_LIBEAL_USE_HPET in Linux user applications.
> 
> I don't see a functional impact.
> 
> There may be an impact on performance?
> But users can switch to rte_get_tsc_cycles() to avoid the added branch.
> 

I'd be very surprised if there was an impact from that. Any timers we have
already take a measurable number of cycles, so the extra branch is going to
be unnoticable IMHO.

> 
> On the other hand, did you consider dropping HPET altogether?
> 

I did, but that I considered a bit riskier and harder to do, as we don't
know who might actually be using it. This was a simple way to get rid of
the unnecessary option without impacting apps.

IIRC the main reason we had HPET off by default was that lots of distro
kernels in the past had the necessary MMAP_HPET support disabled by
default, making it awkward to use - the user had to compile the kernel.
However, I was pleasantly surprised to discover that Ubuntu has it enabled
by default so the HPET now works out of the box, and it's interesting to
see the timer_autotest doing TSC and HPET clock comparisons.

/Bruce
