Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12157CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 09:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A172402D0;
	Fri,  9 Oct 2026 11:03:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1DA934021E;
 Fri,  9 Oct 2026 11:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791536610; x=1823072610;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Hh8puAYxcxQ3eM20ly1G+3gaQlbOxOtrOI5FngYx2I4=;
 b=OKK2a63UwNJX/SpbkgkdyxgHIBd9RCUG/P5YalC/aWYN7NojwbGWoSK3
 JbgIZNh8vbl7MuoRVLA4jL1xi5heTXtQNNXR02C22esozwnxbXgl85UUG
 qELmuqr774/fdbW3wksDbKWjYiHW3ADUOOv03kWZvashQI9RdQgj7by6I
 1RvAg54/5lhIKhvPbK5rp9Sov1g33sVyEgREZjSOCiipaEB1ORXYwpg/7
 uB369I/Cguufi3iyqVrOLbUXnC6Y6AJugrWMINLvIwRMA291KlOegKJOE
 GHE4qDKUUmGYzG/w35WpKCxDo//bTWKege/0wIBqItkws8uTPX7oc1ZoM w==;
X-CSE-ConnectionGUID: xikHCRK3QAObrpChaDOZGg==
X-CSE-MsgGUID: z9MGDS/pR2GktCVbZNCgzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="360522"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="360522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 02:03:28 -0700
X-CSE-ConnectionGUID: n/3k4D9XRiugJjzmhDaS/g==
X-CSE-MsgGUID: wHU4GXnLR4ivjBPl0zq5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="600909"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 02:03:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:03:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 02:03:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 02:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZonUE4kmPkMBZt+O3eZssP1h5F52zO3SMc3uJb24RgGT7otyO9mlv5VRlqjrWYlfVGjQiISK6zF7w3ocTp0Ta1t+u5+9s/13d+g0jS89FfjE1Qvon+jbwv1dhNjzP/3IHUGrHwqdxc1JqaTH6xo+tzvc6OR6LZKxdB7LdMPVAujLJk5Mj8Z6SqvwJV8dD8/cRsaZZ57vbODFdhK5qPhz+sv+IorYWi00EdoVnWdNtxQrY5DsMi+BK+UMAe3gLo98l2VkyLogyLOmgxp3Yy0NjzbtP1DI48W9gRlVezn/rGSt0q/zwlErxkM1rfoDUMa9MbTQDmt3aQ202l/CQUKiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idUgeNGD5rWciBQMNSp5CG1g8gzxNZI6tkbOkx2hgPk=;
 b=LFcNTAXGGjVTBo5p2l5H6Hk52iNl4qFORcyUYpSqbRQFhNTSVtF1g/qr1j2ARcv97ZxJQof2VIoHJAXCOy4n4JQtMPLBh5spjb1wKNePqzap6zq1xrNRXqeIYFk2GWld3N6RBSJIRKydFg7RpHokeUDu57z5I+RFZnyYXtvv2WM2sJj1uztdgsWZjiaa83Km8VBgH4SrSxAKZoUOTwJmsWlu1GsqB/sTlnh38TwqD58tSY0o3joNUXSqoVTrtm6JW2x+vAErcqFH7QsXAiaqUGtYuFlcBi5/0OVJa2+xvhFzP+Yv8Kyl/lkc/1JhSc352787XZ/aph6I1S/sbfs80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 9 Oct
 2026 09:03:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:03:23 +0000
Date: Fri, 9 Oct 2026 10:03:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>,
 Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>, <stable@dpdk.org>,
 Conor Walsh <conor.walsh@intel.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH] dma/idxd: remove experimental on whole driver
Message-ID: <asit1s5cdr_rqCqy@bricha3-mobl1.ger.corp.intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
 <CAJFAV8zdGwbqmKa=oFLDAJWv=7_rRZ1zBy_gtk_=C5NCOUsPvQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zdGwbqmKa=oFLDAJWv=7_rRZ1zBy_gtk_=C5NCOUsPvQ@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::14) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8c3847-d1a8-469f-5ed3-08df25e42c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AnAcwHKN1HKuHMkFdk0gTEZWBZdFlPITLiiX6t5d0sbpw8CLI/8dNKr3MLeP3xqpORa+s2MSrbGljQjRvw0JtFzjQvqlmypjyKA+uNGWOEALLQsWiUlIuaKuErWS1YI7paeuGIo2MpmPAS0SbJXwRevaDNoR6PdNdHnW9mNY8JoNaP2ADamDSG6phM4IjezgwHKmscJHxKOBzIKf1rWoV2gkNHiSPhHOZJsi/xO+tMtcTFpQv24hezTyIGH9ESgO0RCcOPOLdzRFpUOF3Yrn0ysurDsWycaNRn8GmfJIu88L3a7RcUioe8a9kNssvUeeNHaHMkl59nY6QmUBzWHPB/3n1XO4a1y4a2WAR8ETaM8ooJcO/6WE2qtqdoP7YPNjPDlkekx5m6SYcZZEBfuXXMDCS3949dJrJn+zXCNb3cmjH72E5KP+eitpUz6dkln1BUTz/K+dRxBz+qMOKJOqjEva8JQ0GVlIaIqHyQZR1em+U1MMyzBYimAKaLu5j9FKuI7X1pTV+pVh+VVc0CdkXr/U99OCXtMYy9u3LOQA9xRRhP3T5My3YB/su+uQmOGKhXNEjmO11RwRnR+B5tsErJq60N+CjlcQvk8XVYdcfEP5phBFMaT90UPbgyy2HrmPMa1/BlTN/6c6QXz1BnIJe1U2tO0RwF2jxK7fw+OxOMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LqimtA69aOBItHnOdZIqzf6wlHKxvtyiCpsxeryrx217y7kx7y/2kwCKrD6A?=
 =?us-ascii?Q?ZhjZclgBfjXSfM7ZBg4/swduYA4++9/UI5KfE8fhLD1j3o9hWo9GBNOTP+20?=
 =?us-ascii?Q?NxEsynONTWzXeiOe72/GQdrjn5CKcFhVFMZ+EdY8Q+1Asl9t1HpFbFZlRJxg?=
 =?us-ascii?Q?PutplsS+N0AOsGE3wfTKLESbeJyDpYlT8vgPICaXDL0gKB/RSYYxJzsB+YHG?=
 =?us-ascii?Q?VKpKNtN7i1t9Kmacm+NiB6VgBZ5qT21CXKaan68HKKlyHe9ALQKE+VGZYaBu?=
 =?us-ascii?Q?o9cva4NqSX8wrQqwLCZebwwTZq5KMXdEOX9+HANy1mbNyJT05q1Z4/r1hAXb?=
 =?us-ascii?Q?Y1WDLRpB+LcJXYel4aedRpQyYvdwWdNt3M2AySN9eH5T+9Ndar2vb67zLrJZ?=
 =?us-ascii?Q?dPCsq+Y3WBf92xsXKRj91Zgrl7Hs+JAaiul9jnjXhWFQ7vs2r8bpNzjdDciq?=
 =?us-ascii?Q?z4Q21ZZcmvCME8wWtOmIaODIvswlxHFL+T+i8P4LQzZTZDtoVfZS1ffCe0Hs?=
 =?us-ascii?Q?DlIQjao/L3FoeBYQTI7shNxkGbUY+GuuYSVv83yVUtuZB+paYg0kqnqTT1yn?=
 =?us-ascii?Q?pmJ5dWwAQEoJGGIFbWT9c+U1htS8onTQrRhQRL15+3D548f/aK6rEBu7q8ik?=
 =?us-ascii?Q?y2luUw0JjjMRrJKMnoyWzKtkQIP/o85d6Z1h9dQ2P3cVGceHKMOL+mAFk6zI?=
 =?us-ascii?Q?K/x5qpLXnDrO/Kv2U12FB+8w2S7vIKcj639ODE+bSSQlerJgXdXnzY32HjUp?=
 =?us-ascii?Q?H686GjssdhEVBRlMKE842yj/DowPs+pM3Wh3/tarkpxDEHNb7rmMBNNT7yib?=
 =?us-ascii?Q?5XCCjRoacmi9LpnMbGsrTloAB6Kck6+FqmzHrP/Yl7eaUBnltpGbSfv8YHg/?=
 =?us-ascii?Q?44wQ+x1c/miVANuC30iANM6pIk6FKiwwOYwU/PsmknFRGgKbL8m5aaazz2Nh?=
 =?us-ascii?Q?n7idT9RJlbj2MkWr8vVd8BrK8cUy8p9nU50cKkNqfcGmL+CATpDwiZ0ytwWO?=
 =?us-ascii?Q?NANwb+JY/o7NARgoC2vmJg3qRvmbYoDvx1ALI16dl2ENj++W4Fs7R3u46u/7?=
 =?us-ascii?Q?pjMmPOpQp/DZHlWeNbeLmhMck9knw9ph7Rfrro9bNoOMIHikmPIl4eVT+3tq?=
 =?us-ascii?Q?5j8NxWg+gGOK0hpD4H94tPslZR1kbqjpe0UlkTZqjsgMl8dGK9NwIk/TvlTf?=
 =?us-ascii?Q?VLSHjAsKb9Ce2Jhb6ilSeE52ehZ4/bcQKIRLQoccml3UXtPtZj0WwPF2ZN/J?=
 =?us-ascii?Q?ucmTtoxXo6EpLOJjeXVYNQ4q0FlTR9cIWvP/4BUxF5ddvoorrPD0AT8mMhiC?=
 =?us-ascii?Q?W4owqsPeB7ZtLToSV9rVCgDxWssm6+lCKy6KmPNiNAqJ7ZLHj1mXlK1c8n59?=
 =?us-ascii?Q?j02NGWSarvmflDTwYKF2M/oAObrPG6SG5qGMguE+0oFTemgA0dCNbQuT5Hbp?=
 =?us-ascii?Q?JPLByW7OHiWldGpbYafeo+sxIejtv1S2vPBNhOCDTQXi+Qb6YuQ1o3WYm3ZK?=
 =?us-ascii?Q?xg6XqGjbHzVOlCt0BNoazhBfTOli1BEyzv0mURUsQt1Q/O8+yR2pSf2K/TZ/?=
 =?us-ascii?Q?2tQUWpVvyqO8d3/x7lESelUF1hcqusYx2CeKVVRDC7fBiUJN6Rb7PE98hyri?=
 =?us-ascii?Q?ybz0bfFVbcKTGZUDdyBv53rmqLLHcwHEhlLwudQDzq8wV60fblWzHX+rGfjh?=
 =?us-ascii?Q?SJxW3Hc3gnXE+xQj099lGeRpUu3GxoWCEAXwVCSelTgVDoXydcjqMoqdQUMm?=
 =?us-ascii?Q?VIFnHvheJchGV8oCwO9/Yy6SePIOe5M=3D?=
X-Exchange-RoutingPolicyChecked: S/cgxnvJwXJmVW77Qb4DTT34w3+0TIWBhoJoWlcdhOaeH2/von4xfulWYgdhn78u56HGhwZed1usc058qSLCdImsPhLJ2hiC6YXLOkv/vRC7mOjlwhM5u8U9QVvn3528MPcCzdE5f7waH2Ps1zfxTl2e9MVgfxdSJNewGdyN5abP4XsGTj+qCEwHiKUn0w9ScnUr3NqMl9mFV4n3s6wm7PN3WG23yKrJIxv+otkWAxeBcece1W3OLHayTOCVFLWSSmvu0DMEXeCy0+Na+xrjlpSdvZCtEVS5b+tdbjKJk6x0/VrVDBy8oTdGTt+naSdrmc/87XsPwJT+hEz2d2RUkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c3847-d1a8-469f-5ed3-08df25e42c38
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:03:23.6318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDVo5TYw5o7Zat+kWhn3S6w4E0AR1gZoOFzu8l/jMQxzXNPQ/1uSLtAfFYLqDCkY0wpRjb4iWmb1LfTfklNpH52aE5fXn6SPrvpDnB2RgLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
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

On Fri, Oct 09, 2026 at 10:55:49AM +0200, David Marchand wrote:
> On Thu, 8 Oct 2026 at 17:44, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The idxd DMA driver was marked as experimental in MAINTAINERS file.
> > Remove this designation as it's been stable for a long time now.
> >
> > Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >
> > Putting the fixline as the original start of the driver implementation,
> > since there is no good commit point to use to identify the stabilization
> > of the driver. Since this change should be good to backport to all
> > currently supported LTS releases, the orignal addition of the driver
> > works fine as a commit being fixed.
> 
> No opinion on the backporting aspect.
> At least the driver looks stable for a while, so the patch lgtm.
> 
Given that the driver has been around since 2021 and the oldest supported
LTS is 23.11, I felt it worthwhile to backport. However, if LTS
maintainers want to avoid this patch, I'm not too concerned :-)
