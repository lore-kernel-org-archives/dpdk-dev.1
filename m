Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C5C35FF3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 08:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7798C4066F;
	Fri, 21 Mar 2025 09:35:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1987240276;
 Fri, 21 Mar 2025 09:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742546122; x=1774082122;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=IkJ4r03sWFFLjLMK3lrRLproPGGfauXrNMr5xx3Xe8Q=;
 b=LqKPd28QJx4lh46zelinDjHMiKYoZIQcVsqgyrLqApphwHVmpMVZo8cw
 M/mEu/ZaKWIh3GtW7xmtcHeNCllVmVC9NjxihTkqDH6JSvaTdY7dhPtQ/
 YIZBQpVf48cBAW5GBRUa+SSR2ppLl3XyWtMPlF+CLAUbs7FcIrWYoAbTn
 KqS4Zz0A9DXoyp+I8GBUCYmzqc1za05rkNL1Y72LRgufLy2dqB7A8hvSK
 ZLqKn1lCafXeppSLUvfoWy9739mhnh8Jt7OxVs7irxxYF/xGCEFnhMprk
 xDYhdcfQILQgZAjdeOMMh+gzi0t8C04DB+eK+usECXTSStBC4HILbCowL Q==;
X-CSE-ConnectionGUID: F1NfvijLQvCdqHaEzpFjrg==
X-CSE-MsgGUID: ixC7DgA4Q8qMVKKm+ftoRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43934841"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="43934841"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 01:35:21 -0700
X-CSE-ConnectionGUID: ZAOoJjlgQW2yq1wR4aw5EA==
X-CSE-MsgGUID: C6VSClwrS1arps9GTG9A7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="123798460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Mar 2025 01:35:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Mar 2025 01:35:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 01:35:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 01:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5/dbFpvK4/729tm4UFGJf9u1JPgYLJm4uzor5wDSD+u3lar6rKZHm+fCL3AJHGjvo33koFGSBkePM2q4ag9W9xMa9+2fbPkLIT3BNGCFrrKH/tMB90XKgjSCqon66LawzMpqbp9YZyiBlwXBkoqEZDmcLFg9CZ99X5tD7ZcSOggdC66fMDdHzyv6rm7jsTFTDQT/SjKsgSbAGhRSmUg95d2/a/bxwP13B6sFOiNy5pS9oa+3wZ/8/aclFVX8P7Nc9Mlbm6xP4Cnwj9ySpymUur0c4agAa1+odhLSuW5k2cNrSBi46Gh6LWaLaoMnEt7irU+FSy9Wr448DksBaM6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek4E3B2gEL2mTiOYP1BHyCONo5je0ZqcQNvwebCxNp8=;
 b=O7jGiYe2U8yIMAhQJ0YzAK3ZsphH31L9hOaiytSlOP6WpQkUnNNpSTGxcvorah0lVOxNV0gzyMpFtwLIrquV56KsAXDoGyteWov3nOkMvc3BAk8Se8cvyeKnMcmwrnlTkvljPoTS0Us7jJZnEmTU2m2yu2hCNj3570bcyrjGUyjCpyeeUPkbi4fGx18Yw2HZlhPoLiw73SRLdHzGB5W/P5URjiluPV3LtgpvS9juNcDI5T1t2VThMPazsRK+PaGKUsDXa3IQgx9SdN4qTspKbilH2ZiKQsRwIQ5vHExVrQmmHxhE7QvNQ1VyAgtGEKIybfgclyVXYo5c0TRIisWZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 08:34:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 08:34:49 +0000
Date: Fri, 21 Mar 2025 08:34:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Cody Cheng <ccheng@iol.unh.edu>, Kevin Traynor <ktraynor@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, <techboard@dpdk.org>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>,
 <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, <galco@nvidia.com>
Subject: Re: Clarification on Minimum Supported Kernel Version for DPDK
Message-ID: <Z90kpNrf8HjicUkI@bricha3-mobl1.ger.corp.intel.com>
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: ac314ce8-cfff-4964-8d20-08dd68533e48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wgHpvQAgOdr3TwTEyxo/5oZ+5XD4n9wuIwa7HiZ/OpDqgC8Mnj9jwrRmSD?=
 =?iso-8859-1?Q?EpSDzfawW3Gnx/xF0X6ZYLjnacYNT6vCRK1DEaf7U82Tz50/C2+QScifw2?=
 =?iso-8859-1?Q?upll+I7Pxa1WcNldW2s2rGqIgiiiLFOQjQZb17nPZEU/aF1kZkYNQCjiLv?=
 =?iso-8859-1?Q?1etIHfv9mbSnUd/bGFExB05PbDdCT5NdOqPXdM5pyZsQQaw6WMWdO3pFbx?=
 =?iso-8859-1?Q?KOP2YkYm8pccHOfIH6l4qWQlDkBB3v2ZZetaVlV5GInrVnFxcVe6pYFc1z?=
 =?iso-8859-1?Q?ZHg4Zz0bIzUSGzQ5B0NGTOBZ+onZCkLurl0LSfgxZJh8hjvOHImQI2VnHH?=
 =?iso-8859-1?Q?LBCSf4BBhwzuJVs82eeFoqyk9PO1fjAY6NArx09mlRD555WhxYaP6of2ay?=
 =?iso-8859-1?Q?DDauRohM0UNUy+A88aDQLUCqdfDt5uzmT8Q1uwSdDSlwle49xz/aeyX6um?=
 =?iso-8859-1?Q?zspdSVayaAojYWv7pHmZGWClEXh01PAQ9NYgC+jNEKHROtHF4MRify+hTb?=
 =?iso-8859-1?Q?YdNQ9LGfDRGhDjclpAyOPA5IvC1yg8Jx+RwT+RvlZmRF+3OTqH2W9I1HYk?=
 =?iso-8859-1?Q?D2buZmvQ7aYesRU6kEaolwZLUZyH14IKmGuWwQOC5aOr/KCP8hGnjOIid7?=
 =?iso-8859-1?Q?mka4yI1Wl9maWSjDmCj0uvj1GGX68cCrmNrKKGSKoj7IFBZkda5gyL8mkR?=
 =?iso-8859-1?Q?LGa65jh2/QFLy0RBYvJZ9EeoCoVTjEG7YYR4hVA/SL1UdN1MwCsRtfOmuS?=
 =?iso-8859-1?Q?wNC4YyOM0TletlyGpxgISTvXJmRSKcCiO5ScCYxrU7jJS97WdvTvgYvhPp?=
 =?iso-8859-1?Q?S/duwF7BOkE75wthfF+VdVKJc+xK14ijSZESYyRGGLTTeotJ7Cd5I/NkBp?=
 =?iso-8859-1?Q?jeZsJyXs43Av1+cZVPByQVTSjhjCwq5rFdQ7RnJ3A2uHM3n/J6twUPTt1L?=
 =?iso-8859-1?Q?mBUoBgn0N4kawYVSmQs/6oMcQmWgL75/Wwgm+PU5qfx5zGmj7d8UGHuJ+f?=
 =?iso-8859-1?Q?Tq1USvTAsteiWedwfCiQqH8XcuAkgTUzDRjmnmEiFFz/2tk1mMfDUhDyvu?=
 =?iso-8859-1?Q?30P4hHPTEaZ92jg4HF5l3T+akJzDR0MsPpwWGtJhyhKaMJDZmeWlY1jB9s?=
 =?iso-8859-1?Q?r9w5cozCRU1VE08MPZw3RXjpw2jYg3UNmQxt8eLXiW6EdRIqqwMwkWVsS9?=
 =?iso-8859-1?Q?OkeS4Qds/GnRNRN26ejAk0aSGb2KAqT7ecyfBRR+R34Jm0Mws3sh/26dob?=
 =?iso-8859-1?Q?TxiOINnBIt+ox221nWgKJqgpo8d4zxo9rU92EC/nbP9+IMZKDcHE1QsHOZ?=
 =?iso-8859-1?Q?GO2dwKzIO7SXxOo0RUwL/wf8v4A/Sc7I8PBdO6KFjDISR1J+umo6hWUGRk?=
 =?iso-8859-1?Q?LpazPL+6aK1av/gYvv4oa1+AAo9Ftpto9pVmqt1qEJl0neLcwZc64nXcHm?=
 =?iso-8859-1?Q?OKjgMN/A1JdKgHBz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6swbacRbA9RPU/qNjdUpInGvpp3lBUqF8Ns6fDG/gJwIW+emGmGIYnr32s?=
 =?iso-8859-1?Q?4p2/KNK2ye+mE7s1BWwbNZeNblcPqlNq2JArSoCYLaBB/K7jiLs2F0geeM?=
 =?iso-8859-1?Q?1e6uxKfPv0gkD1CXoi5yDn+0aEo94lcG/Mb18d2DFMZs4ItbkNl/WR0QKG?=
 =?iso-8859-1?Q?mpWZtJrVTciSHBKpgGeqHbAfwImJjF4tNW54kknJD5GyW7/f64bkfb/OOW?=
 =?iso-8859-1?Q?zqk1q+gdr//+LuoyAHrt+xYbIG5mobfSzGBbsQSrmBpI8Jw8TMCiRF1fB7?=
 =?iso-8859-1?Q?1Q0hHfu38/JVW6gANylpJRR/Nj6sHkkejaAxKuqWiwH9cfRJglYlE2Isvi?=
 =?iso-8859-1?Q?nRs6C7cFnpvVZJUt7NyJOC/qwKZ36DLS4x0KiwhAPW6XrwyDnVl6t9F86W?=
 =?iso-8859-1?Q?u4qFqCLE+axVL55mpscDp/sSWPzefoSrWS1bdL8T9dl9t5IxwXj9uE7uUf?=
 =?iso-8859-1?Q?vlgq9kRn/IcWUcC6GnGX+CLuFfUmH00LSaQDG1RVwWsZGS+P2osoqVi6hR?=
 =?iso-8859-1?Q?jW0EesMH1FkZg9aiZetMR+jRXvkFOAGaf3m5Q/WNvzrGKKY9UjalxcqLWd?=
 =?iso-8859-1?Q?X4cAwl7JeLTqf8EiyNyoy/us3b/UkGOGE20QnrW3lm9DlNYgx0si81x7lp?=
 =?iso-8859-1?Q?svPwwC9XuhpA+BTh2fDbViLobN/gzAa7qpnSz5O4Z5cgch+KcxWgpY03W1?=
 =?iso-8859-1?Q?Dqro3NGG+ACs2u44+R8kiw3ceM8OLOr5yk6ZPNRZ/0hHMahAN+qX+/U+M7?=
 =?iso-8859-1?Q?7rBJfbXejM9iZ8OufA20gZEdkedwJIo09guCKlftqUXyU9Opl6X0ytGLko?=
 =?iso-8859-1?Q?ABML77zh064SdKD170jgJb3dCx3Tr3xtL03WmTDxAKDweYUH0/NuzW3Wzf?=
 =?iso-8859-1?Q?r3cKBPZjlvNEG/K7UiP5SjEeaBsmoDP6WdZV1Eq6YFmmrF2zYfBWbj8ca4?=
 =?iso-8859-1?Q?sL0lUVLtysdi1xkwNHfALhWWBNqKmMrUlDRIVEoM2N2ank4XgR0hqlFlmn?=
 =?iso-8859-1?Q?VWvJGyaAwVtxPm6FjqbMYnjlSD46JB002h3jrX4GZ1s2znfWHYZmXaoMdS?=
 =?iso-8859-1?Q?i9asl1/FZqRcnQOji0h3Oekp9rQo9cwwbW+Hj0vr19EEvCp5ExJPBbFdQy?=
 =?iso-8859-1?Q?VeFqLCWkS2V4ynJuCfY+/FRvrT8mFxYc7btQXhTS7LvADPN6GPw3pzKkvO?=
 =?iso-8859-1?Q?/Hk+yyq9X4I7TZxdkGAiFySUSkRBYag6VgmVjyO1Wr8ic+RFWa6goDcIRh?=
 =?iso-8859-1?Q?yvCdI7Y7GX5kmKmuDSaj5//TzkwJtO+JoRD0qQDWSV5ll7WEANFH4X1VTB?=
 =?iso-8859-1?Q?AbrzmWj+d2AmnsltNiUzEOhtg/GCr4zNaI/uyEAd+ZPZIl3GHle0BmSNBg?=
 =?iso-8859-1?Q?1lYBGKrMK3krmM8i/7kO2nn4xU6bE996ukFa6lx2ukiXC2Ej1jF2iiMWou?=
 =?iso-8859-1?Q?ztpGFzUTHjFfidzHPau4gZpQal36KU5LqoAoJSnX8ek4izEbO4qymGdfro?=
 =?iso-8859-1?Q?OZfznnS414LVP/VgQlQU2kcnh6NSkrMXei2UUunLce4ADWik6fgpm6ng3m?=
 =?iso-8859-1?Q?Za6CVg4bm0JKNHXy0hVHcQRU0l9LScePK+B+QMEBq9PqyGn/qCjklZ27C8?=
 =?iso-8859-1?Q?TsiLVOKOx0dXgW2gDOjR0W2l2m0ybygbS1vfFOBesGz9UWyr8Grmk/ZA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac314ce8-cfff-4964-8d20-08dd68533e48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 08:34:49.4493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1POcb24pV2g+Y7J2VCi9tvGnsq7dbltlmoDor5zbYe/vKyZRBRVc1k44DXEKysJqJ9TsFp/mJXGgs2nB16cB56kJXrdu50tAwds4KRbdiS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
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

On Fri, Mar 21, 2025 at 07:28:45AM +0100, Morten Brørup wrote:
> @Kevin, @Stephen, @Bruce,
> 
> I cannot reliably answer Cody's question, and it may need further discussion.
> 
> What is your opinion on minimum Linux kernel version requirements?
> 
> @Thomas: In the future, the DPDK release notes should mention the minimum Linux kernel requirements.
> 

Another question is - should we even have a minimum kernel version? Are we
aware of any kernel features beyond vfio-pci driver which DPDK requires to
run? As a userspace application, I think DPDK should just work with
whatever distro-provided kernel is provided (assuming distro is relatively
recent).

/Bruce

