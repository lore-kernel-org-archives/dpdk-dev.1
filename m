Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01FDCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 09:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC18640661;
	Thu, 25 Sep 2025 11:22:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 28A2F402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 11:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758792171; x=1790328171;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GgtVlFpAFnMPG6gEkV/Mlb30Taqn31QNcSnco+KRMO8=;
 b=KOVksFj8ukZMpn3OsB0cKFpSqd+64tpaDJ7x/imsJjs4/SnEWCIFrEfP
 ke5dzqxY1Ebak2K0VevBnkMrlWgaU9eV0ogZowOslDiKd8ER+Y+sl5+Qt
 N6u1mYANaVbGII79lO8ceQZo6YUBPpGdO2kb6dA7+YcNiqyvnVI+AKFQB
 4/icRfQy6Mw2gO+JUTtZvgyYvwJjHG2ies3dsKvOGlBCWS0P3UxN/XGXw
 JowmKBWqyXd1RzJNnVka5HIrpqK7M4DrHpeUlU7LpLz8yLZcMqLOQKevB
 g6e5MCT+Q8Hp7EhxVUwWvBIXnURl/MCj8YxtTvN4ae3EChFRjkDM7tJnX w==;
X-CSE-ConnectionGUID: wKdY8hQlQUKXTfHiHT883g==
X-CSE-MsgGUID: zXAmH45eSomRKz+UL6vllg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61212429"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="61212429"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 02:22:50 -0700
X-CSE-ConnectionGUID: +z8Z91I4SGyGbM4nwvF3Vw==
X-CSE-MsgGUID: SV8CxzICRyiT/baBHFq4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="177120088"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 02:22:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:22:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 02:22:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 02:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfK9LHVo/9DiU5dfoXMzyAE4rgyvTRsmcN1NMXT3jcohqY/o/FDY93w7uYZp+XfXyQ7Ia/cKkzr9GLFW2RV/qZYF4vbtJeetg7/AfGpOGfiHouVWTirF0fykh6gu909k+EjbjIIYkoehiGyK3G/f2S8Jyx+VyYbrsfBbwVL/K/vY/5R9PljmS92TsUzV7tcpgLZbm6PW/TV7kcbGak5NeonE/Rlmg2Tsm5uZTWuFVoS9Uaesy6PA/uEuvrvuGEhF+jGOAfy3kTU9/KlI+AXki3QoagHHDCHDm7IYpL/QM7gRegSWvxeYzRnPVygABD2HFnfd7zznDeAtPn6+iBVycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFAgix2ztRhrE87f6z4ZXFnizHRPGwjLN/NPi6qc7bs=;
 b=doAoHyljfQn/IihqFYAX745ovRcfQR+ZeCJG4uJmsVMcLf3q5W9DHaMYozVMxzsqmiIXvVSIMjn4agnCekpoIAAjeyo8IyVFkrjI09zU6onbdvzu4fnMjLe5zTYThS/svCuVa8CtnLjP2TN0RU5ZIkJXFlxzyqGW6wIM/qmMBPEEMoTnrRTObFDUWGkBBhLp7Y6dDnfk7LEVYIl/1rR3aOJPOwrATpsF0EAulJxAhrHvrgHK0tWhtDtrfFUeBCZPKj4TY/3rfknKtJ45TciGLvf89Lv3ViLuBzBlMJuYSasahlKF+J3NpsYwPSAihv6QKd5S1M3z28disRySdPacXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:22:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:22:44 +0000
Date: Thu, 25 Sep 2025 10:22:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNUJ3yFwNVpZdGzk@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
X-ClientProxiedBy: DB8PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:10:be::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: fc06ad99-b8e2-41ee-a2a3-08ddfc15157f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b9/MgkaRIPkt7J2RvLQKMRedhr7M73Kor4yNuWi+AeJk0mC5f2Ha02wp/yOe?=
 =?us-ascii?Q?zcXzAn7kBd4ddaw/5CYoLw35kbpv70cmTPmjIrrS2AhHB/lCpsMLsKZpq5M0?=
 =?us-ascii?Q?2fKhjfMTxiSEl33XdqHHHSL/u5zc+Kp13VZMOr9SnT+QgR/qCHyXH0p7+cQ2?=
 =?us-ascii?Q?/SOEw5HHQ5yOcPoaDG9YHeBMA08dkpxM0YCMrN3AbDN776Z17dUQiOfrrMQ7?=
 =?us-ascii?Q?Nk3ytUg9dJ4aVz3BFqJ83x4BYZnrXVwfottGTsQkxwwPJWP0Iwmd0CWEaOYp?=
 =?us-ascii?Q?2iK6YGLr+EltCryO9SFkuhrHgD61o4J48Dk2ck5uQvN3DKjXoyvAuAF/WBl7?=
 =?us-ascii?Q?Klctjj1OLWBCc8g9+cAV4rS+qIEvyUcfJ0/3LCXW7krZdjcpNA5qiNSJMhIM?=
 =?us-ascii?Q?BER9oDm/CKRD+0etGsGivVhw7kwwzR2ZA3k3JWcP6/ea1exMKXWSagdN2iv+?=
 =?us-ascii?Q?RyCiQ0PVjGPmMWiOHEDWWas8QMVEn68fufFYskdCgvwcOqtFXbUgBGauuGPz?=
 =?us-ascii?Q?4u3abDD6nDr2V+izE7i79Ao3Nmj6KttkAsjciaIO9U0gmSfJ1v32O12pvoj2?=
 =?us-ascii?Q?Hd4DTy0AecFJOvrLtFpVw5k7Y6LTV3LcaU0WMDrYzy2Evsgb8Vni2gkysoAj?=
 =?us-ascii?Q?eYfPGSu90jAEYbcAox6Aph+7Ds6NfVd2UhRsrtTTbZsdeI4oQm1xRGmNUzwN?=
 =?us-ascii?Q?fRzf08c9n38W4uIKZhYFmO2SDBHy43i9kiVuwgt6kQYoAOW70cvUxCwNg4p1?=
 =?us-ascii?Q?Dp6zibxqCG6XHQqPZ1xanA3m6cR1NZlaynuC2wUtKiHQuxF46MtRBRwXq8pT?=
 =?us-ascii?Q?xAgVa1Td4gYrp6CFWByRbOeu+bSRMj4oDAFB63KDVf8lLbR5muI+sRcpQVrw?=
 =?us-ascii?Q?+Pw8JDr02oZhVhzYdLPzv9bWvaePRYuJUoTDCG6pycuL2g39WRu5OuL0qP4/?=
 =?us-ascii?Q?NqSBItQemJfZYMhiKYjNHj1UB0guZKLyUQCOqpzQwSwhHOLaU3WW37Q+W4eb?=
 =?us-ascii?Q?bl+02Z7bbYaYIquo+0c3XOIZ3qZKJyRyQAOWm/xRvyfxcKoknQ9H6sKjZIiO?=
 =?us-ascii?Q?Xclr39xOIUXzgMC8Y6F/5S2kdhaP5Ygm0fC8Imp+iQuujiBCrFcb0VMPqxkE?=
 =?us-ascii?Q?QpUnplp5TC5SnCQIkJ+y5HQEqSht785jJeC5L2KTWBOroXBbEcj1cU2/Ysi2?=
 =?us-ascii?Q?ARDFpTMglxWboaOoPHxyDXp8KArFkvjo8F0c1Mf9NzBmVA0cicu84Vbq0Xr/?=
 =?us-ascii?Q?JBg+pdjEnwmuZs3soEYwQXw2aA1oa4ntZgmAmJ9sMeQT7+cBoJYSSk14N8A4?=
 =?us-ascii?Q?xFUMDfVuqOcKAGTIiJ8aj46JvieO9ej9TLkOWgUPdNc1mJubgBogtc0uWQ+U?=
 =?us-ascii?Q?2qzsyVTaaPQi0xWhpAVlBzJXlKpYONjjkm1YZ+zhQxRxRq+ovj91VKomM9XB?=
 =?us-ascii?Q?31UgZihLCFVK2mPLXQDzWaS8CoFEqIZM2Juhpo1bb3wyEY+8ltvAAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkjCgs8fp1t/GdAIVur2EeYJTs03aAMJlPAl52u0ay0AutSvnEVp0fcXiIQ6?=
 =?us-ascii?Q?RulLaSOaWHnHt1GumS9NwjjeHEzhaycoFAo5Y3bgsIubokR8wQldEo95cJ4O?=
 =?us-ascii?Q?iRU4W6kwCZGdiHscfgs/3WbHlff5oMgl13JxXPGVi43XdBp4OSywsUFDZYYr?=
 =?us-ascii?Q?dvau/mfD5tLUTkzq6/cb/e1QtprL1wCe+rISlcwbUvSQ3WbieozGX0qbd6is?=
 =?us-ascii?Q?BLJiIOk0W7g624N3udi5RnsHk2Cn7QIhQvBdSZw3648rfs/1olpkPc5sK3oo?=
 =?us-ascii?Q?x0cfiVN4w09A1SZiHrzGltf7bxOAfFrk1JIu/yXD6257MXyiwOU77aPsCNfM?=
 =?us-ascii?Q?s8o3ES/elgLpsDwAQnRi2o0sjNj8oz4ivwRgdGtmwk93Uhd1ygtR0uKkmJz9?=
 =?us-ascii?Q?jTQ5X5yRCkMoaK4GgGljaRChenWpOZA6ib9Ddn9pXxW7XsxruQy5niL8Nz/P?=
 =?us-ascii?Q?ZDF52gdsaqvuBlrXDDQN8YfVCc9LTvhzeL5+Xce09227BJf+3BcYolZhnG6r?=
 =?us-ascii?Q?tdo9f5jdKnP2sTlGfXp1h7nqi5KUC7kfC9RfE3C/ThJB5ioDDpoyn4x2bA5i?=
 =?us-ascii?Q?F1f69FQzHW1gxp7aT6ly0HgNvO/n0aQFf/vn4hTvH3mJ4UXK63qqnhJAmIUA?=
 =?us-ascii?Q?B9XDfnjojP2ipzqP96aG5mnGEhWddrHVU0mLXwgqBHOslvYxBBKXXzKkXj/y?=
 =?us-ascii?Q?e2Ngj6X88J1aW/oF2DdOw1M7v0rZeluaV4tfVUucXLB4ss6/IPS3tDn06yAO?=
 =?us-ascii?Q?q6kul+dlQuL29Mviz3Bjn5c4wEdOfg2rS44voW5SKqd2VJdsM7gMdEGLVr47?=
 =?us-ascii?Q?I+nuUOApQbj5p+N8QHKbGekaGZmC05kmx5EI4ka0pzKnvyPl313BLv9Gx86W?=
 =?us-ascii?Q?7aQTYryYserSJJeJvxAu5YvdSPkjJEFOWasQfHdjENp+YJU9OG4d++rcadYD?=
 =?us-ascii?Q?EGV/tBeNACgDB7kiI5Ln1pmucb7zFu+RM3Sb3g1MK0nwqgUeqToGuvJMzNHs?=
 =?us-ascii?Q?BX3c3smHjgWDxZUqF4RsCMqM5/vHINZrhInu3hlRev+I1tTL/atS7oVQeOzX?=
 =?us-ascii?Q?BH/Qxtf3HJAzvMSrA3/VNYAxMrtn7zB+veFZAgei16qqd7RBy+C8Eza2NBlZ?=
 =?us-ascii?Q?MwV9kVQ5Sd5Eg54LOj5p7kf4fV+ij7QglVWCerZqqUJM3abOq28wNR6aZ42m?=
 =?us-ascii?Q?MMbAtPexXBiYI6d+cs9nTsLWV1pX9tgI79IVt252ClTzYPHaohZjgu6qePJr?=
 =?us-ascii?Q?1A8U8iT7TLBfcwko2L9iF4ae8A3EiUX+dCP299/7DCXJ2cx5Y+UnS2GKwwWG?=
 =?us-ascii?Q?Ah/xfKlUs+veP6suAqTtdRDkWYR/8MIvZ34NZ36coh6TKYjiabAHJYiKe7aE?=
 =?us-ascii?Q?6ZpbIq+LRYaRnUzccf484QOZJVSb59P0H2h2EG315E22hG39FKTDVM7WkCl6?=
 =?us-ascii?Q?mDEB77ykwAOIxv7A8MJN1E1o7iJzuSPFbDQLHA1jqJCBESw+9EYCJsR7Y9aK?=
 =?us-ascii?Q?8VV48zCmXNvNcfwntMmJw52aUDZOMks4jWQJ+1GNU2+YFEIVdJxYxtfnROO9?=
 =?us-ascii?Q?CWW2nbKb4Huq2I5LdnvZjV+/iHbc33PeNmegMetRDhaSihFmFATnZmw8+Lh7?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc06ad99-b8e2-41ee-a2a3-08ddfc15157f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:22:44.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F5/RsqCWPSjKvetvSvkrRSTD2QjCFdPdqYZxtGwlQIfSQ3VnGshC5SUsuu31YSQZnVutZ32C3436+M9iBpnijeaI7xhj9HALPCC98ArBg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
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

On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > > A problem with the current headers check is that it relies on meson
> > > dependencies objects that come with their include_directories
> > > directives, and all of those point at the library / driver sources.
> > >
> > > This means that we won't detect a public header including a private
> > > (as in, not exported) header, or a driver only header.
> > >
> > > To address this issue, a staging directory is added and every header
> > > is copied to it.
> > >
> > > Drivers and library headers are staged to two different directories
> > > and the check is updated accordingly.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> >
> > In general looks ok to me.  One small comment though - can we not have
> > "staging" as a top-level directory, but instead hide it inside the
> > buildtools directory, or even the chkincs directory? I dislike having
> > too many subdirectories directly off the root of the project,
> > especially ones purely for internal tooling.
> 
> Well, at first I was trying to change the whole build process iow rely
> only on the staging directory and remove all the include_directories:
> directives from the declare_dependency() objects.  Libraries and apps
> were ok, but there were a *lot* of complications with drivers (what a
> *huge mess*, especially for NXP drivers with "compat.h" includes, and
> Marvell drivers to a smaller extent).  I may retry in the future with
> some AI tool that will brute force this :-).
> 
One note of caution here: if doing this, you may want to consider using
run_command rather than a custom_target to copy the headers in order to
avoid potentially slowing down the build.

We used to do this copying of header files in the old make build system,
and one downside of it is that it means that the build of ".c" files in one
directory cannot be started until the copying of headers from the dependent
components are completed. The decision to use the include paths in the
dependency objects rather than copying the headers to a central location
was a deliberate decision when moving build system because it means that
when you run "ninja", every single .c file can be compiled to a .o file
in parallel, because all dependent headers are available at their original
locations. For most components, it's only the final link stage that has any
dependencies, the compile commands are all independent.

On the other hand, using run_command is not necessarily a good solution
either, because it means that all changes to the headers require a re-run
of meson, which will also be slower because of all the copying. :-(

Therefore, I'd tend towards keeping things as they are here, in order to
minimise reconfiguration and build times.

/Bruce
