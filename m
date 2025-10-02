Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5279CCA472
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 08:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0107640262;
	Thu,  2 Oct 2025 10:07:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1D386400D6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 10:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759392430; x=1790928430;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ty8Y2GtPSaUsOD+Tq/TWgARGe8YXN8K6nC0fd6beqHY=;
 b=Ju5NAAJH/J7hpJRlrze2P3j13AQECfYq/He2GdPgeyhqo2Ny1kFAWEzo
 7dQW8700cenGHXaPWcojhO/ycOLJQCHTWdAq30HM4jms9Gt6uGpXLfgge
 KOIImwZa5f6lcvUxFX+4Km/fY1Jod6HmQ4SGfiA2TT/7lgXurdivqNZMw
 2sW0QW98D+CBi5981ruAUlYu58njw79ItRaRL0L7oPaXG6eqdPCU3ICaP
 qZiyS87VeCv5ulqnt2y2+9vFxuUzVjj49fTfm5ILSaKTUbD1xxT6FpiZL
 5ZklkEo1RznMWD5ecmWKND8aLD4njbBRW8sc0YRCqzBq7A/gLWh5OUIne g==;
X-CSE-ConnectionGUID: gT59KrTGR5mBMbl8l7aJVQ==
X-CSE-MsgGUID: tw4jiy29QF255aDrSLk6zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65525282"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="65525282"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:07:05 -0700
X-CSE-ConnectionGUID: MtM/gPM6Sv2WrbsGarD3VQ==
X-CSE-MsgGUID: sdejVWLdS3G6FKGX2Mn5pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="184183585"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:07:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:07:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 01:07:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfNgOnhbOpQCf4XQVyEtCBG7c22iNWgIkQjs69nSv14COSZXLeKa0njgTtYQ/ab0y/kWzLUbP+9OU+QQifJk9eSZNkGMGckDImhIWPOMDpvO66c/fTpiKIH6j6Ixl7KGp2WofFUNa1+hm+SthAyhZ1h5w1/xeaHqqcbsTu1gwjZNNWGJAJXFCpw252zMzMTTkpHkGcK4n2nDltMNifIcenh/ryzaOBVy8ZEHgiYsG1J1ZzlPp18GznQCmih38ijB6TYEJ0V0TdCFU6/2+i5S6ABBe1Z0gg22KzVJWgEDBzThir/dgd3BCVRKW+BACPH1wBU6y4PsGFDWO+VhP/oXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=susmosHlev5LVVf8TVsLcWE82lq/sxUuFC8hzArIVps=;
 b=O6VInHGK+xEbsA4twOTPQh3XvcqtXvsqdZqd7dJ++CvMXHf6cO6KF1tfst2+xGhViSehvO/1lhJn10NWm/59rZWD16ICU+FvsAp4UT0le0J8i2af/2ccr7E8TVStPwntxJcd2QfD3cAhdo9SOQKIfeA9njPGkXVrpmwQD8cqXP+fcklvfTUyyuDzrkJabHGsQcA1GLbOO62LzL+R2ehbONZ0PWfx1g/REaiYPHcbu1BikL5O6Gu8Nsl3vG4VPyUuHqIXWP6T4RciYAVGjhe4sE7dAo6bYju/IDyyKqvf1j1E5X07Btsszp2lFK9UAtSEyg15XIwX8tPpjqYpjQvp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:06:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:06:54 +0000
Date: Thu, 2 Oct 2025 09:06:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Nicolas Chautru <nicolas.chautru@intel.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>, "Ciara
 Loftus" <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, David Hunt <david.hunt@intel.com>, "Sivaprasad
 Tummala" <sivaprasad.tummala@amd.com>, Rosen Xu <rosen.xu@altera.com>,
 "Tomasz Kantecki" <tomasz.kantecki@intel.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
Message-ID: <aN4yl66c5ftB_EpB@bricha3-mobl1.ger.corp.intel.com>
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8ztEthzEhjCYy-L0T98F7zb2qECG+2Cd0-HavPEBUQnAg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ztEthzEhjCYy-L0T98F7zb2qECG+2Cd0-HavPEBUQnAg@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0322.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 113b38f6-b8fa-4ae2-82a8-08de018aa62a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d6k9lBn0n3PzNOKYiDx86yIRCkpLNEAq++zDCA6nPyzu+hv4WnqxT9LAOa9j?=
 =?us-ascii?Q?HXDWKi+YOhwc6p7Ucnlb9s20vM6gF4TZyC2Lv/NMK2mlsYkvQQReTDiU2Xgb?=
 =?us-ascii?Q?NwIzmtucS4VRMbtGljcap1pKk2mN/T7D6BC5Ns9250bXLPLpWwVEbEjiVBpk?=
 =?us-ascii?Q?lylJY4Q30g1DC3w5egPtJ6oO/MdDMvVtY1I5gZsQcIkY0QXBtTI+Znb51teZ?=
 =?us-ascii?Q?G5N05ERiN5oanU5bII35SIqY4vWpizo+5KX2UNLuyZXu5k18ZspFnqcG8FxX?=
 =?us-ascii?Q?P9TBXXAq/sJxDymVm7CkWDw/NXH72Tpz+qUcal5+ptNayh6fLl0ihyv4mjW5?=
 =?us-ascii?Q?AwPd5TTH4MB9kpXWFDqYndjVT6cFVoDc6IrrIe0W7tz5CloJW6bu6HUAR4Oa?=
 =?us-ascii?Q?VgnU5WDthY0Pxd2bXp9017Mm8SNYt0PGh+4g/2s1KlU9n43sDHNfsI7FwK4z?=
 =?us-ascii?Q?M6BtaD5WSfva6dvZHJB2VzDog7/bDKm1knv94Vm6XzrA9W7hbg/MfcT0K2M4?=
 =?us-ascii?Q?ngSb2/g96EaHX1vihM6afS9rRNB+fHRijkYEVguJqSdf2QodYzy8e6gSNGQU?=
 =?us-ascii?Q?Qlo+/5zYMwbjSK89miRfVFf+1N+Y73/x19leh7XUX3PMHvW4M5wYBoklpXvy?=
 =?us-ascii?Q?jjhM11WC6I8LLAN/wxa9ZSdU8GBM+xmXiEBOm/k0j2a+cqCydD47x3WrfDQl?=
 =?us-ascii?Q?rJKv6ISq3CDAxoyFe1TkrxZqHFOY7YVfIJXok6ZbsxJEuJ34sOtqdXI4AEyQ?=
 =?us-ascii?Q?a2D1sPpD/p52ghoe2ObWeUt9bHRy+oQiZ3ld8iz0NhBKRXeOKx/KAC5RnotG?=
 =?us-ascii?Q?QcrXc0bv+dDeDjOLTxMtO0kQRvZMeiarN3RvJXprmJJf7ce+R2koNQPc5sDG?=
 =?us-ascii?Q?8aBig0dLiEwKm5OWWFECa4teqMWsjEvj8h9OPwEL3BBr7nn6LmUOpX3kehj7?=
 =?us-ascii?Q?jVg3MZ1sJNtzVNbnFFFzDL/OwdzF2Q0Kwhefv0a/ezE4rIxiHMWLhEXu3Eqd?=
 =?us-ascii?Q?eCNI1bXTMD5njJ+cgDkTU2GdTjcaxcEgyBbMpi/c7ii29yeJmM3HytwAP2Me?=
 =?us-ascii?Q?WlnwlUmQiE/8/OVl72Xl0o65smFY3Dbydcd6Q2a6580L57p1xMnRj0B40Ve+?=
 =?us-ascii?Q?p8ebQ22V3yRaz0KsiTq337s/kL1ONONbtEhNILoxCzLa8frw+WzYU8XxWwAh?=
 =?us-ascii?Q?Xt7x9jPPM96fcQi+ZQ4I6CE9LE2M9C74kOuqfp4QAj9uvkAbbsDBskTKAiA1?=
 =?us-ascii?Q?I9JjVe+VYq3FSl/IwxJdePkXdj6YgbqAnvHIeRAzy7KbxB7LJ7mrLLyRkRLZ?=
 =?us-ascii?Q?CvvOUmmNkyaAA7ZznfXICAnmHi/FHLyuhUK1gfI1O7thHlUcCC8g9w+4iD+e?=
 =?us-ascii?Q?M0CXI8posjRg79V8caIpzJnuDSaTr6mNVqkiaVd7OglbaqNuhlQKZBhdeQWv?=
 =?us-ascii?Q?LBA2PLdLsVl4jwlRYuo1cQgYNE4pdkHB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaVA3QjZQQatCYJib8w2uEYKjcbw+tLhpW5EV++LR0NP+ySPNzEMkVOsBw4Q?=
 =?us-ascii?Q?fK/nlDtBQ4gWR7spyKa417K10viawa4oD1EYC+sWsqSrrK4ryaQKfaOsDf9+?=
 =?us-ascii?Q?qn3piIfWXJxbC+axfnVVb3eOVrYsoiKH794lum2yEQCl/H8T2XkNK5WgdM2N?=
 =?us-ascii?Q?aBSb/qUWIcunLlhcKUU5C/LOTtnmB3u6+cn7G//PUX68OdkjNdh3n5XunjFm?=
 =?us-ascii?Q?tU60eAyPZPvNJqbyzbdAnf/J/uRHQCemlgJx6sUdtP30v12P3pa0YhayKbi2?=
 =?us-ascii?Q?AcblbL8edorxiyixp/OzhKcRseOjW4PLrGSQVkPPX0imq8922dDvwtRUpT9I?=
 =?us-ascii?Q?aKE0CYcjsH21WAm8w4bDvSA7Ly+PAAYbByNYkNG37Q3wn5MyUOMGaN+vBttL?=
 =?us-ascii?Q?GY3i58EI/snwhehwXjtYqSmthJpX/g6kzdiIZqhgjHnmgyTV5UH7hm9qaCVg?=
 =?us-ascii?Q?SxffRva/122iNT9+zGFh1bSShlCr3PCB9Fr3IxSRIdkZZTYCVgEmx/q2UTUK?=
 =?us-ascii?Q?bvunetW0xJoKDoj0KjALKenqtJ/O5LxdEywGRXFr8k+Br1SufG0VAvhfqco4?=
 =?us-ascii?Q?bKU1wc0Z1e2iw28qy6Wq/i8FDt0L1R2H/Tn9mS/hHJjj5WiBZUzjuy1p5/4R?=
 =?us-ascii?Q?YwQxmnI1yKBtNYZ/xtJG9Wit0oOx9AutUhPbVxkPaNtCq1zMyAmQhKweEZ12?=
 =?us-ascii?Q?+RXdpNJgJwtWXKjxyiKyrhTinoZkLLmLK2v/M3WHeGGgvN4b6b90yGKFXYJ5?=
 =?us-ascii?Q?PC8WcFGPySvUwqUwpKom8TR0IGRimX4dNzdVhQoOUpli74BmNz4Iyno8WDX+?=
 =?us-ascii?Q?TF1fnfPQF3cmqBMEoqGZDCut5CVmuYVP9ToPX3YYoEdHnnOpJ38SmdfmAwcZ?=
 =?us-ascii?Q?SKEz3GEi1GQB2I0MVNRfiqDnzHo/S3VBTuvpqyQBV7WGA3/JBuI9nsl6ZTcZ?=
 =?us-ascii?Q?W9HKe09jp1NjVf1NOa28tPXlASjQY0kNPZtEjghGRytFpvyDMgrckAIXaTQg?=
 =?us-ascii?Q?8i6x8ZAhMKEVayxf3hArAn39drLoYYlG8vYK3try63kvzrlq6ppyLswF3fn6?=
 =?us-ascii?Q?H8Bm8CkNQ6KDICCFMTzp0cLQWGvyM0taY1z+dCzB7Z/ASpiKXlZhvOtNoBKS?=
 =?us-ascii?Q?sNJh9F2umyvrKtJIqpBX4ZoGvRIAeCPf37TkObnMhuM+sSwLAYOYMg6SKuH8?=
 =?us-ascii?Q?wQzRCL3qowYRg6Ph/Jz/E3wChDRHkpnU9a8ylHRTVvkPYGLJHE+adoPHfMK5?=
 =?us-ascii?Q?qELy3EIJxWiAoNIjbYG54rnEzFH0GTD1p/88h4QFuWQXbqnGwGV3vofk5Ni/?=
 =?us-ascii?Q?sgtrr2f3glQT6qOeSTjO355BSyqgyslZyaMML0B9hQJIIOlefY88MIEddrVb?=
 =?us-ascii?Q?uJCV5lM35WYFR6C07M4iC+tvMImlSBgfe7KKdIZy1PfyJ7B021jRw22CtjXq?=
 =?us-ascii?Q?f9OCqk/oeZJyHwLdvbxOLLFNJBD9OHKY0QaFRnt2rIzvlusv4z1lbzjuHkhi?=
 =?us-ascii?Q?O5U9YCVLGOCFQ+EmXTzL0HMLVvvWUTnCXiFHJpfesm8kheFrntqjqftMsECp?=
 =?us-ascii?Q?nicTFNqX5egW+ZKPjKufZ6BL1GQsmfFf0qIM7JScL0DCDlKDPG8naQW6JUEw?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 113b38f6-b8fa-4ae2-82a8-08de018aa62a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:06:53.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrJwVnPXvGKRFMpCHJySdVLxdnZZG7iKWx8weQklGKJD2svW8+qcnvuoZdV1rUe0OGU/per7UbsidsRfBmEjylb7SUj83jvnBUdpSmPAHMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
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

On Thu, Oct 02, 2025 at 09:53:15AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The meson find_library() API call sometimes finds a library that is
> > actually incompatible with the current build, for example, returning a
> > 64-bit library when doing a 32-bit build. To avoid problems with this,
> > check each library returned from a find_library() call and treat the
> > library as unfound if its incompatible.
> 
> meson should have all it needs to double check itself that the "found"
> library links fine...
> But well, we need to live with existing behavior.
> 

Yes, it's annoying and it should be something I think meson does, but even
if it was added today to meson, we'd have to live with current behaviour
for a long time. :-(

> It's a pity meson refuses to define user helpers... so much copy/paste
> in this patch.
> 

Yes, though if we want to reduce it I can remove some that is currently
unnecessary. For example, windows support doesn't have any cross-compile
options and only supports a single target so the checks there probably
aren't necessary. I added them for consistency.

The other thing we could do to help out here, is check to see if any more
libraries can be switched to using pkg-config. I noticed some libs have
fallbacks after a pkg-config call - we could remove the fallbacks and just
mandate use of pkg-config for those.

> 
> >
> > This checking is not necessary (or should not be necessary) for
> > dependencies got using pkg-config, since the .pc files for each build
> > type are stored in a different directory on the system.
> 
> Would it affect the library lookup if we pass has_headers to find_library()?
>

I don't think it would affect things, since the headers are common in many
cases, only the binary files differ (thinking especially of the 32-bit vs
64-bit case here).

/Bruce
