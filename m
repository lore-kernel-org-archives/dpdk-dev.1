Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBFC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870CC402E0;
	Wed, 26 Feb 2025 10:44:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5971C4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563082; x=1772099082;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uWVW0gi5wSRaLb5FTHJMzLvedr7P8CLUAl626zYLnXA=;
 b=mDeAfIQCQABX8oPC2A+jtc3NFxaPycqEOFkcFhet9+sLWvl/IEOBfbmk
 kCKBQu/ejbRQJbYxFIS2PT0p7oLsH7X6E9atwbAivCXDI3EQNE0ucJ4mM
 QqFrAgkUpp0HquI7LSCl8cYAxGbqY/9qQ43Rv+vk4lJM8Olk0I8mvw6gg
 3c0DOGcibxwbryVPnusdVkMPX/gMIAyV7bElFk2h6nkPIjyLdxiqWelty
 sCnFXBhGNYqtPI0z+UazumEuvMk1g2AiEZ/YvysHHqqzq4XnApmk8MdUw
 gUZEmEOuuS+Sfme4ffSYL4Nf8mBVanvASzJKnz8nCo9f9FsBNWU6GBMDU A==;
X-CSE-ConnectionGUID: I+KkehPtRCWPQ9G+ubP0Xw==
X-CSE-MsgGUID: 9ai1mFBoR2SKWXKgk+c6ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58936473"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="58936473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:44:40 -0800
X-CSE-ConnectionGUID: ka5vDSL6T6WIZNbDEV7DOA==
X-CSE-MsgGUID: vo1V8N9XSL2zMAhuE8j0uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117574787"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:44:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 01:44:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 01:44:39 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:44:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTuex0BE8dKcE+/biIuNZ3qFqEaJMzkV5VYe4s4GPcjVJ7pjEk3YEj/pFZd2vrVHcsvzJqeZgIyPjAjA7oGbE0hukXKpmKG52OFlKWPeIVQd7o27VhXvSES10aNhT/sW9w06oexaGi68juEjmrdVe73AnUVXcqLrcUxaoJyvuPXMCI4OQQZ+gf2U8JqRjrJxe6+r06hvtFYJTu58+vlCUwyS4rQdsgzYRpWOrrcr9Z5JclXUxgRyG23CK6MKdATnsgfh1itjVHaFqkaC8Jceh20Iyu8gcpH1gmu0xqFsyzsTE25qoNTlMekP6plfln0y4+393h3uKp7eJY7fFyZvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WszBZQrEBLcVRMXW4GOgMyfM7I26Q9nj7Jygjg3HgfY=;
 b=yEh6LuQOrT/yIRJhF61cQpkBfOYPGAH9oZlXSSj/y0WamF+uOoTRj7wzc3zYdViPcPzmBF3daxEI+8BFeTPRQkuTJ5ooO/ny16a/4OUnEHDzGlYfHG6lluYQn8dTUmgs0U3nzfE1W4G36psc6IYNIha/awKGav2axbx5vv6Lt87wE/d+HZTONev0fVG0Xj0NNG5StBxIVeMfoFG0GVgvMqP4kwjEx79ZwOx1FJEc6SAamYqmcmQStLirCCbgMZnuikOxq8BcrUJEB/t8kG4f3+RpKjdj3MRPMdoAsRg7/kh/OZHV6jcA3eFhJZ/+YLTGdh4EIb9Yxt8AW21/qwn9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:44:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:44:35 +0000
Date: Wed, 26 Feb 2025 09:44:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH 3/6] config: allow faster instruction sets to be used
 with MSVC
Message-ID: <Z77if3SkegDq84XN@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-4-git-send-email-andremue@linux.microsoft.com>
 <Z73Tcj4VmlNYNoLM@bricha3-mobl1.ger.corp.intel.com>
 <20250226020138.GA16574@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226020138.GA16574@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU7P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 054e65a0-7946-46f0-eb01-08dd564a2df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SPO7AjA9qsLi/kCtix0teJAlcWUHnAFE4vUDXEORRizH66cntCOoBqpmmNFY?=
 =?us-ascii?Q?GHiJMUmkr5pFBukHCkdx3R7GODQYv5qROcgVgTEsy2Rcnqe1yGFSuscVNc9d?=
 =?us-ascii?Q?fn6lP9pWWhZVKlxSosxnXumcRPbHjnuxOvu1i5tp8OSm3FeEm5+Btke16drw?=
 =?us-ascii?Q?irK5RfJKxS/wEMnN/jh9bsxYYZCKuW/QCEn2/rvLSTn2yxNDrGA9oawQcmLz?=
 =?us-ascii?Q?UPV/mrELqSHyIUhEkPMHk3qgZQ3mFEx+vdi5UJzznfuWpXDwAk89XxCDNDMs?=
 =?us-ascii?Q?gUJ0e32oIGMGzsY1QVJwFyJ1gj3yLW1A9X5dS+uRkT0sWdd/DvZ0GG9U2D6H?=
 =?us-ascii?Q?yiYkJS8ZLOGshmHgCq1pObjWp6gKHoGlnA5SOE2AxOAMpIPdyUNmDH0Fs5v5?=
 =?us-ascii?Q?EAaxoxgqEgF//8mfmcsKrxKl/aZV7fcPubiH0Jnd3Cc4VBdh1htIIHCAwTxY?=
 =?us-ascii?Q?UpqyBJeo6KkjwWWNS5MOGy8hlc2S97inIwcqRA5/djANbeHtm6qTegWMweBT?=
 =?us-ascii?Q?Y4I1kW7bhJlvL0CT6EkNfDDtqgInrZsHwBSo/Rdf2Djse8wbRGJGp2iJzDtZ?=
 =?us-ascii?Q?wASaboA9tTw94R4JGatjzLgjF0Vk2I24+34VQNroupakOh9aVzp2LMXO5O96?=
 =?us-ascii?Q?4JP35l912Ug10dxbED2u7x/YoNpYB1xdl05ZXepzcSQ5ehzXybsJ0ew3H8Yv?=
 =?us-ascii?Q?hHj8JfuIbIXF0icbQYroG0VnIh3SUMsDnyd+nBbOoM5efDN4YLyTsSBOSBjn?=
 =?us-ascii?Q?USOD26LZoJP2roVInVtcCMsUxYo/YlCfyBmrMrNuTNQWckvpN8l/uU63s7b8?=
 =?us-ascii?Q?wPgKEaFmJwvWduKq9fvk0bybpI3kNg+ISb0j4ZntS8SdyW/368qpKwxqnQhc?=
 =?us-ascii?Q?6+7D4i5svxFkrcsz9n+MQMAI9eFBHsf3+sO+FHANmZFD+6jkUNAT6iGHWwSK?=
 =?us-ascii?Q?2CTC8sIN+83L2z8GkWH27nDO2exPZytpGzAFwteF0QMY+JwYbhQpFaIMnTPc?=
 =?us-ascii?Q?5CXXqwPNMWh0hBC6nBLmKakJGsfAKJwVy0w1iW6cWlVo5i4KMAFT3MgejKwa?=
 =?us-ascii?Q?9CnzFdt5M5qbVY0tHu2nQuScVYT1wN3DjMqiPRjbFAeTKAUwd0SUf5pMzwQF?=
 =?us-ascii?Q?CUSdnM444oV0nH1L4mLstkvGWvrIJJYI6z6iMGNl8SkidNw+m1OQB09H1x8I?=
 =?us-ascii?Q?BGVEO8e2h47opotPWmwyYC35mhxw5fFkdedMYJZreGeFayZWE0+Igm2ToMf6?=
 =?us-ascii?Q?MSUs1eYvgW4F5qi17BMZPgLOIFSeRAnCcUK3zmnNTsCenTWKXoMBzlDrRc3k?=
 =?us-ascii?Q?gEkka4X5za37DicDNce10OJ9+Iw6z90enwVZ61xgUKC93bR6GI5TuP65ipB+?=
 =?us-ascii?Q?DGehlQlQMxrkHG94jm0FeSaSqbVq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaos8jm1+jsecXPYqt76wn+boeVchCW2Kk96ONMr8z4UaaE95yJSQY+eeES6?=
 =?us-ascii?Q?k+jcr6jEbcxGFFVrD43JxQQaHks/wHyFc//DTmXj57rr4bomemuZIl6kghoj?=
 =?us-ascii?Q?L3MBurMKeTP4qbY6JrQWOX8B28YhjSgxfC6ta4dr6uJklJWh/707Id83oFus?=
 =?us-ascii?Q?bSkHCcNvRrUK+i/nGkAJAJ3lICkvvu7xY5TMg3XCC3NuhzXjFVgJdO66UNHa?=
 =?us-ascii?Q?nPcRCRiEbatC8UGJ/Xexu/24L4X26ZcFaCKxmiJU6RK7s7hqHOrtDwW4Aa3Z?=
 =?us-ascii?Q?e8+g2leCJ1BbVgPwFhhI6fLaEiEaoVaQa8Suux97tOrTTAs1SY+vpp8EOJDg?=
 =?us-ascii?Q?35UGPXtHbFPoMmDU0kt0VmS1eVNITUOUTr66hRD0HouL2CA7g5uJ0YsaWnm+?=
 =?us-ascii?Q?qpOdhm5Ti1ZzYkjrXSDUmp2HnkEg7X4jRoWeQWqdLCXG30/XxDLi6m+mawe9?=
 =?us-ascii?Q?97cRiOpUJEtWVuCpfI4zVtyRQvllpW6/+9Tz5tgPYAzLeH/QaDE8y3VmigvF?=
 =?us-ascii?Q?OTmW7lL45BilrVMUGVlE5XHd0YFYIfeRtYjUXLkNZrXKsmA68g+ZGeEOjAMK?=
 =?us-ascii?Q?YKlQ/7336Cmm0BEQA7uFGXlTSSR0Ge0kwGzXDw9XX6bun9BdFqO4kP06VUGX?=
 =?us-ascii?Q?UqtedMP5FTHz4o7ySb85LpjxGeWZ7xPkD99gwFanKKIyvpPHm294HdgOfxfn?=
 =?us-ascii?Q?wP5jhnWhXJKKticCXn2/9eCC3TbVSqwUS8yoY/RmKO+HEQQ8mhvI8SJ2ltvB?=
 =?us-ascii?Q?pme0od89e3Aw/hsT18jOW3TdAQkn3lBOn7aNDJqah1vo+fj04LCQ9OeQ4+wQ?=
 =?us-ascii?Q?FfltM+N8vcMykDx3pO3PfA6Ua1wtypW+TWUBwbklMDXCOWyAKaE8syai1Kgz?=
 =?us-ascii?Q?Yum4ir+UIuglWew8QoGuTXn0EtSx07ADatXeNLZrKW0oR5FYznkX/VYmthA4?=
 =?us-ascii?Q?bnH2IEnpo9f0Pw417CEqUTcdHDeCRTU8cYRn2DMXInFnUV+1ABbpO32IDV15?=
 =?us-ascii?Q?Dfo7ZKl3mTM37ZnnCyVf1QyKPO6mewTLOlJ7hKti5SdQOWccW5MlO7JXuHg4?=
 =?us-ascii?Q?80EPiQxgX2ktxJ+w9SpF7T6fqSsxoBHIQOUfkKpoSx57Z4VuzzRjYbd7ZcT/?=
 =?us-ascii?Q?vuVlG+BtKNOeWAF1H4Px21S6YzXFPltMP/m/JSSsayn5wXn2x05vvzJsQ2AQ?=
 =?us-ascii?Q?eVuWkZitxQwKUzJisz2oOm09unSRM2ecxmMeqespSqe9EzdDeLrPOCh3mK8N?=
 =?us-ascii?Q?jUEt2LOKiw+RVMTFMgS9fLd/NuyclhSxmxJnS9yzDFlqL2/cEv3uGsHJSXMg?=
 =?us-ascii?Q?PsGwkqAAGZMKhCkDKTTKGz0DStlu5z7AgOo58ldpPaqhVe6n6Ub8FiKAH2v4?=
 =?us-ascii?Q?KaKXKKHFDcc3ttn6p14UyauOenKia75b6FXe58oo1XNuAwCHPW2JJYbLdG8s?=
 =?us-ascii?Q?HDA2ByLx4UMLiI92ra2AmPt6dX2BDSzfcrRKCSu1UDts2BKdox+AFqqGP6wB?=
 =?us-ascii?Q?7BBnO6FWEtJY62+LpJPpgMSjFRzWEmGfanYIbjSxyh7TEJYnp7mZjBWy8ysY?=
 =?us-ascii?Q?HQ6iS3hsuSLKZPdkT4FjdSevRpYxVd4baXhdI126fpp6nb4Fo54z8xVuPb57?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054e65a0-7946-46f0-eb01-08dd564a2df0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:44:35.7297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBJbuMKCAJu4LUzA60T8bTROBEPFjhr+hFWRysBXfkfCiiH/v5gkfzejhbO/P/bCIedS8oxCPO8tBEl4tugc2z2hG8a9YHyPTPWQo3/x1Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6912
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

On Tue, Feb 25, 2025 at 06:01:38PM -0800, Andre Muezerie wrote:
> On Tue, Feb 25, 2025 at 02:28:02PM +0000, Bruce Richardson wrote:
> > On Mon, Feb 24, 2025 at 01:01:16PM -0800, Andre Muezerie wrote:
> > > Up to now MSVC has being used with the default mode, which uses SSE2
> > > instructions for scalar floating-point and vector calculations.
> > > https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> > > 
> > > This patch allows users to specify the CPU for which the generated
> > > code should be optimized for in the same way it's done for GCC: by
> > > passing the CPU name.
> > > When no explicit CPU name is passed, 'native' is assumed (like it
> > > happens with GCC) and the code will be optimized for the same CPU
> > > type used to compile the code.
> > > 
> > > MSVC does not provide this functionality natively, so logic was
> > > added to meson.build to handle these differences, detecting which
> > > instruction sets are supported by the CPU(s), passing the best
> > > options to MSVC and setting the correct macros (like __AVX512F__)
> > > so that the DPDK code can rely on them like it is done with GCC.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > ---
> > 
> > Hi Andre,
> > 
> > couple of initial thoughts inline below.
> > 
> > /Bruce
> > 
> > >  config/x86/meson.build | 364 ++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 325 insertions(+), 39 deletions(-)
> > > 
> > 
> > There is quite a lot of new code to be added here. Might it be worthwhile
> > creating a "config/x86/msvc/" subdirectory with its own meson.build file to
> > handle all the complexities of using it. We can have the common material at
> > the top of the x86/meson.build file, and then do 
> > 
> > if is_ms_compiler
> >     subdir(msvc)
> >     subdir_done()
> > endif
> > 
> > leaving the rest of the file for the gcc/clang/icx code.
> 
> I think that makes sense, as there's not much common code there that is common to gcc and msvc.
> 

<snip>

> > 
> > I really don't want to have tables like this to maintain in our code if at
> > all possible. We used to have something a bit similar in DPDK IIRC, but we
> > found it a maintenance nightmare and just switched to using the compiler to
> > do all the work. In our existing builds, we just pass the
> > cpu_instruction_set parameter straight to the -march flag of the compiler.
> > For MSVC support, I believe we should just do the exact same.
> > 
> > Maintaining lists like this will be a problem as new platforms need to be
> > constantly added.
> 
> It's great that when using gcc users can just pass the CPU type to it and
> that it will set all the macros corresponding to that CPU for them. I
> would love to be able to rely on MSVC for that as well, unfortunately MSVC
> does not provide that level of granularity, that's why I came up with the
> idea of having this table.
> 
> Initially I was also very concerned about the amount of data to be stored
> there, and the work required to maintain it. Then I decided to throw away
> all the CPU types that do not have SSE4_2. That reduced the table in half.
> Adding the entries manually was still a lot of work and error prone. So,
> I decided to write some code that uses gcc to build that table for me.
> I'll polish that code and add it to the patch. With that it will be almost
> zero effort to maintain that table. All that will be required is running
> that code on a setup with the latest gcc, providing a file with the CPU
> names. Assuming gcc knows about the latest CPUs a new table will be
> generated and can be pasted in the meson.build file.
> 
> I assume this does not need to be done too often. In the worst case, if it
> happens that DPDK was not updated with the latest CPUs, people can still
> pick an earlier CPU with similar characteristics and have similar (if not
> same) performance.
> 

Thanks. Having it automated certainly helps, but I'm still not fully
convinced that it's a good idea. If everyone else is happy, though, I'm ok
to ignore those concerns :-). Let's see what others think.

> 
> > Do we also look to backport them, because if equivalence
> > with the linux build is necessary then that will have to be done - as on
> > Linux when a new version of GCC comes out, we can then use the new
> > instruction set targets on the old releases of DPDK.
> 
> That would be nice, and I'm willing to help with that. It makes it a
> better user experience if we can minimize the perceived differences
> between the toolsets. I'm not sure if it's a requirement though. If
> you're concerned that this would add too much overhead, it could be
> decided that no such backport should happen.
> 
> > 

<snip>

> > > +    if 'RTE_CPUFLAG_AVX512F' in compile_time_cpuflags
> > > +        machine_args += ['/arch:AVX512']
> > > +    elif 'RTE_CPUFLAG_AVX2' in compile_time_cpuflags
> > > +        machine_args += ['/arch:AVX2']
> > > +    elif 'RTE_CPUFLAG_AVX' in compile_time_cpuflags
> > > +        machine_args += ['/arch:AVX']
> > > +    else
> > > +        # SSE4.2 is expected to always be available
> > > +        machine_args += ['/arch:SSE4.2']
> > >      endif
> > > -endforeach
> > >  
> > 
> > Since these appear to be the only /arch flags supported by the compiler for
> > code generation, I would suggest that these would be the only instruction
> > set flags that we support on MSVC builds, and that we then build up the
> > actual CPU flags based on the minimum flags to be expected when each of
> > these instruction sets is present.
> > 
> > Similarly with 'native', rather than supporting all the different CPU types,
> > it would be a lot easier to just determine if it's an SSE4 machine, an AVX2
> > machine or AVX512, and run with that.
> > 
> > My thinking is that getting this as a first step should get us a lot of the
> > benefits without such a massive maintenance headache.
> 
> Providing only /arch option at first sight might look simpler, but I still
> like the table approach much better. As I said earlier, maintaining that
> table is not much work with that extra devtool.
> 
> Some drawbacks from the simpler approach:
> 
> 1) User experience is not as good as it will differ from other toolsets.
>    Users will have to learn about more parameter/values (how/when to use them).

This is already the case, in that different versions of compilers have
different march flags available. In practice, I think "native" and
"default" are the two most important to have from usability. For any other
values, I'd consider it advanced tuning and that the user probably already
knows what they need or want and what their compiler can provide.

> 2) DPDK code will not benefit from other instruction sets which might be
>    present (__RDSEED__, __RDRND__, etc.) because these are not set by /arch.
> 

RDRND looks to be available everywhere AVX2 is, and RDSEED whereever AVX512
is, so in a simplified model, I'd bundle those in that way.

/Bruce
