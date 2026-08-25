Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B138C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 16:05:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 865BC402B8;
	Tue, 25 Aug 2026 18:05:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 35A6C4013F
 for <dev@dpdk.org>; Tue, 25 Aug 2026 18:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787673926; x=1819209926;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d02rOYdnmDtcNehf1WvzZGqz+H1TtgVmm7ZKafhYZh8=;
 b=QMECnJnNDvCUEEwwpTECtSf+pJYhrcouV/0idPtPsII4hREs5GLSSmus
 /yNjT5ptGcE7+NYboDr85sKSJuOpIcoISHIDTXJ4cCZzFHXOsaf4S8Qnr
 knxUuMuChwaB4lXWKAG2rR4h9P66+xmjkfuumHOrJ/bGyp88TLAZPjfB1
 coEFugVGRMU7iN7FALqr19ljyGHpEeiuOYK9SoCva6uglAw0/fxFNyY+e
 wwhokQpcV/copmte3qpbQpfJW3VAoMs+Tj1uF9e+KW0rZbVYhwIxsoVCj
 jDzaalj0r58XxHt0qdC9woA2oJtD6V/jl7FHcYassn65UiDQaH7vsjCny A==;
X-CSE-ConnectionGUID: JAQuywchQEisHNuCIIRxEw==
X-CSE-MsgGUID: uD7ylHy8Sw2FyIOlGzjWxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87912132"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87912132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:03:28 -0700
X-CSE-ConnectionGUID: 0PxDOIz/QumL/ROnf+vjkg==
X-CSE-MsgGUID: pH7vEUGxRASUxoJSVY911A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="267358870"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:03:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 09:03:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 09:03:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 09:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbiglgH07rihqNMWCJbZMrXtHZnK1vPSg6NhNpkRStCtkINGUCyIjTgTN+fZWd/EVagkp4pLDZAQKfooDxFq7u68o+wymlqrPuBT3ybCQAmQm4GjisrhSzLZgVx4AUX+7JuKzBJBFOUxwYKxIoyGkrOiejaU/pxOo+2pIIEkCW3gpnMrbW+pxHuwUgLJ0vsfgN7zmjHGb4GnG86k//qEWZpFZEQI5ehniYR3yX0lasWmKghyDQdEN2cKE8PcKh0B5hCOr8zRGOTyO3YArT0lqSd1js8BqXjyqC6P1k7EotGQtmljD5B2uo4xmzTfZ6F5FIbuASu+9BnGVSj9xZBlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlbcks5C4brextNQ7OFnz/4OWd32BxfMb3Vs3vm4wBM=;
 b=lrfivAQ9XNYJeedMwW5QL9ruFPWPzwmtOpD0Q6hRS8mn5Dci+5Nxx6GO02Fnapf2LmOGtREpSv1z+91hAydn2smtjPnaO+v1rtAuwbe3HyP34hnwYnfVRQLiskr69C10a/FDczNAsnhg2rhqUwM399VYkAX82sp33/1EO/Kb8lOeCjPahVFkpHATZJZ3P1cnhHYg7SdZC0DN03uk1neBzc1UOHBFf9VBLHSV6HAztHiw1RC4SszK4FM0K4E04p5tHBFUG1uReZHK4VjhRbcWM9dCqRP5EwMJLFbZmJlBrCT5WkNmJWJo6S0aZeVVg1d5vU+Y08vk42R9yKBTU2T6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 16:03:23 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:03:23 +0000
Date: Tue, 25 Aug 2026 17:03:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/8] remove non-base files from base folders
Message-ID: <ao28xnm6dq7LxQSs@bricha3-mobl1.ger.corp.intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825151533.535102-1-bruce.richardson@intel.com>
 <CAJFAV8zAQwFzNSPiw+brajW1wh4nvTF-VA20teXEx5qeRxpYKw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zAQwFzNSPiw+brajW1wh4nvTF-VA20teXEx5qeRxpYKw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9a2971-d157-4848-0701-08df02c263b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N32IE/p8srNASJcynj2D0cbPFTQP+9T2PT3kdL8ZZQfqbDaBtyT5DgwOOo8zWGFwd1OnxOXuXL01EWVcA1wFyJ2YECnkJs2WrmFCh6N7MVf2bqajsUOCOLUclpMf/SWW5dk+FIisFkeAAWM+y+vrtW7N2BQUlOJPQrGkIFDxWiGTjawnLkcDSfkMsXTkivfZfE70hs/nwUuixhFh8BLfo8tHL0g4y6bLKEIv1FnGSvijp+qOllS6SgathemZu5HCB0weylOYOYserE9D4sDQLJmh28WHKTDdjDzViifMA+O0T2FHoQ2D/s1GG+q3JmXHsFGuRnC7B0ypW4vwnnEVvjytrjJqPPDkqq2gieSzamfCaj1InTcC0a/n0VdLdGkxdOxfVbDU26ohWkUvWZ/Sf5NlLbzI7t7pU9l47ojkgi8+qEApwwaZdJfiOfu0P4FmK7DWxm7c0P0GdYCbMmoRVgBnQD+S6XFHvJ88CmnC43Z9R3wEdp+y7SQt4nq7VUxc8uPy0jNcXzkQrdHcuxfSt8CSQM0ZStLdJ8ZGtmSmnv+tDVpW203ffmk1wuE9BYQooAuAB+sPXohHNXW26uqnR5kOtWMDkl3RLeM5GSf1QZmLjOc5wcpX0fSQ5YKxMEs7tqLyRSzGaT/4BHi7VLMFGVc+64UKIQK4Ti5JTZOCfz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zxit1az9uFO89ucOVhhs2O/PIPncgUrU6QFmx3LlPUs5C0vCV5tvPN/HM+YB?=
 =?us-ascii?Q?uHJF6KBTWXj9HiNxGILQySjFljHvysF1/tT0kA0JRW9g7pEw0IpMbQnhdjh5?=
 =?us-ascii?Q?AZtTn7OYQes4P0gDW38gHh9D4p5HgexTrxXsTpBnLg380IiefpZEZcGqjRvQ?=
 =?us-ascii?Q?nq4pL7bj+/cacSVDD1eW1OXFn/HIWSwiSvr9NecgFX5n3tV8Sv6rmf+Bbn7M?=
 =?us-ascii?Q?ZlgAQ5rqUauwsKnMndt+e0vSUXqIrbRhNYIw2W/CPhzALYzxz/+c/A3P8Y1b?=
 =?us-ascii?Q?VADX237q0oJ7hL0SdkZRJRJxryOyOXlPs7p7ii6av0eHd+0XWsYu5CTyIwGo?=
 =?us-ascii?Q?ggd2zLV9ndeJPnAplfi+LPnCvnlg4UKzoY6tAqFMi3fVcpndwj8YCybWhmmO?=
 =?us-ascii?Q?e9k3IQCNOsUF+/WjKXpiVK+y3WhQQ4RR7sWb882wYeZjkpii0qS50A65VjNL?=
 =?us-ascii?Q?Oo/Yk7EuR8O/MxcCZtLaat5e0Y380OYPqRVdPBkU23Mp00nw4BOhpqiHsreF?=
 =?us-ascii?Q?BJzKaVm9aWtOpA3sm/QqYd2bWSzqFTYbYeGa+/+WtNcc3uGK2hSFugVojIQY?=
 =?us-ascii?Q?2KW8uy8WUqHD8QYV/PhEWak1T4WMKpBiqZU7wLTJjI+XD5Tf/Fp9NP1weJFa?=
 =?us-ascii?Q?x1KePz4SmNBWMJpRTC3HChqjIfnuc7vfu6CDFtriB2mcOTwLo8LWjSv4v0kR?=
 =?us-ascii?Q?f3fL4hq4mIH99XwxUUDyZ8hM8UuVSedYCtOJl0MrHfm9YWE2I0ZHuS0DayyX?=
 =?us-ascii?Q?1HC/hBjtACG9hrdGY0tRtTZgGzFI2mD31wJPf9ViOv9TgxFu7W35zSErV8vU?=
 =?us-ascii?Q?ZJjcfhF/8+6Ddou6U+quzVijlmFk8g5/wdNQfzF951GMxL7P01YQq4/x/IXq?=
 =?us-ascii?Q?esxb53U4TXO7I4G4iYlk4Pjw9XQj4Fjij3uCfB2dgSLKNMmJ+85aMAvK78/p?=
 =?us-ascii?Q?mmLwRU2lF4Oxq+1jso2+rQzeVBW2utuahFZ9dOBnaylgP/Ak0D77D3dyGrut?=
 =?us-ascii?Q?g32+lDf2BXgio318Vuui6FyClRyCcS4UirvtNU0p0H1WfkRQzocaPVDNA01I?=
 =?us-ascii?Q?T+jAoW7ks3ARqiB/eTePnkG82WC/gPJX5Y+YWKccWcpHEFrSzz8gXFZybkDl?=
 =?us-ascii?Q?Gnfv7QRN3lUDI3AGBCFE0XQotZtBwN9kiuEs2APeRmAZ/e8iS7Fze456uSoI?=
 =?us-ascii?Q?RzDSUkwuWfKgicNM54thlQq/SKVa31LfwhnrKDP7rxEejhREgWRFAkjwOkxz?=
 =?us-ascii?Q?5Ym/tfS+GtpOneS8JQxUrcMDKJ2/KMHwQOWvEDG48qyH0DQqkjlA3i1U5pur?=
 =?us-ascii?Q?DN1LL8qorAzHE8ENsAhT11xP+up4c5phcSahNuR7Cup0vN8YPzqgyWxwjPGe?=
 =?us-ascii?Q?XwQmreKI2Y3qqk3eEr8FT9hSHllxMVXplOUcFc0+mvq+pUFJ8SZiaZtPZMQO?=
 =?us-ascii?Q?hzadhaIuzjgr6NY0t6bXLsx9S+3ABi0VwLVA9POHnPvHqcJq5/r5KZWz0aO+?=
 =?us-ascii?Q?VM4IR9ssO+VPXAyUSwLmOnCAMTcROvtfTRqCUXYobWaSPWtlpbjPKGqGaqoM?=
 =?us-ascii?Q?HjhwYBo9eiGqR+Q900oCcJeQBVvDTKaNkQEvAXsO/KDnXWGbas7KoDBbVIQP?=
 =?us-ascii?Q?z91UPJ287IQeNTnzMLGqfpo5BGHmXE+PIVK7B14LZMksKHP+m+Y/5bPfcrDg?=
 =?us-ascii?Q?tab1xfNLevms2QqxKIaJm3tzL4JQ7TKpTn5sl23jlAUHWhMgjeGhjV0xC5lK?=
 =?us-ascii?Q?yHIj8R+a89wg/0DBwbDCC8eyzc+0AN0=3D?=
X-Exchange-RoutingPolicyChecked: S29Rrj+7gRKll3LtIPlNWeNDdLrqYIZzxjIUDpWjtUkUPSpeAMZKo8nV3fpmNQ79ileQkblQMUlX2Xz5aelu2y8VuuNjhn2c7YFCd73mdDSI+R9erR7qhFozvQyZ4bWX9CBTs3AraLe6YDwgxRJiRyKsV2pdlIwFEH/ioG20RVBk2wzWztgG3NDVh+u52mkBknnmveCM7QRa6+O94UScRwsEBTU3PeMwYqb5xGByIPmVo5m0uVdP2C1kj6vjTZEM/2cUIWGj00CH8m42YY7l4KWPgiLLTZ2xHM8L+xF5g84eW6n3HHMkDERum3iRhSoSgRxw06Tmob2jRpDn5HV93g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9a2971-d157-4848-0701-08df02c263b0
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:03:23.0888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idXYZ54Bb/Knf35RB5GxjvVYy2f3SeKpyKXdPCi0fW+3oX6pQCGfilzm7NLMjMnwhO06vjGo5tRFCFaqX+8fKScRc8qRYRbJTq6bgN1XnW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
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

On Tue, Aug 25, 2026 at 05:54:51PM +0200, David Marchand wrote:
> On Tue, 25 Aug 2026 at 17:16, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The base code folders for intel drivers contained the compatibility
> > *_osdep.h files as well as meson.build files, both of which are
> > editable via regular DPDK patches. Although the DPDK documentation
> > allows this arrangement, I (for one) have always found it a little
> > awkward and confusing to have editable and non-editable files mixed.
> >
> > For Intel drivers only, this patchset moves osdep file out of base,
> > and merges the (in most cases trivial) meson.build files from base
> > into the main driver meson.build file.
> >
> > After this patch we have a clean separation - any files in base,
> > with no exceptions, should be updated only via snapshot update
> > patchsets from Intel. All files outside base are normal DPDK files
> > that can be modified by any patch.
> >
> > v2: remove unnecessary edits to ixgbe files, keeping the "base/"
> >     prefix on includes.
> >
> > Bruce Richardson (8):
> >   net/e1000: move editable files out of base folder
> >   net/fm10k: move editable files out of base folder
> >   net/i40e: move editable files out of base folder
> >   net/iavf: move editable files out of base folder
> >   net/ice: move editable files out of base folder
> >   net/idpf: move editable files out of base folder
> >   net/ixgbe: move editable files out of base folder
> >   net/ice: consolidate the sources list
> >
> >  drivers/net/intel/cpfl/cpfl_actions.h         |  2 +-
> >  drivers/net/intel/cpfl/cpfl_controlq.h        |  2 +-
> >  drivers/net/intel/e1000/base/README           |  9 ---
> >  drivers/net/intel/e1000/base/meson.build      | 24 -------
> >  .../net/intel/e1000/{base => }/e1000_osdep.c  |  0
> >  .../net/intel/e1000/{base => }/e1000_osdep.h  |  4 +-
> >  drivers/net/intel/e1000/em_rxtx.c             |  2 +-
> >  drivers/net/intel/e1000/igc_ethdev.h          |  2 +-
> >  drivers/net/intel/e1000/meson.build           | 22 ++++++-
> >  drivers/net/intel/fm10k/base/meson.build      | 11 ----
> >  .../net/intel/fm10k/{base => }/fm10k_osdep.h  |  4 +-
> >  drivers/net/intel/fm10k/meson.build           |  9 ++-
> >  drivers/net/intel/i40e/base/README            |  8 ---
> >  drivers/net/intel/i40e/base/meson.build       | 12 ----
> >  .../net/intel/i40e/{base => }/i40e_osdep.h    |  4 +-
> >  drivers/net/intel/i40e/meson.build            | 10 ++-
> >  drivers/net/intel/iavf/base/README            |  8 ---
> >  .../iavf/{base/iavf_impl.c => iavf_osdep.c}   |  0
> >  .../net/intel/iavf/{base => }/iavf_osdep.h    |  2 +
> >  drivers/net/intel/iavf/meson.build            |  2 +-
> >  drivers/net/intel/ice/base/README             |  8 ---
> >  drivers/net/intel/ice/base/meson.build        | 51 ---------------
> >  drivers/net/intel/ice/{base => }/ice_osdep.h  |  4 +-
> >  drivers/net/intel/ice/meson.build             | 62 ++++++++++++++++---
> >  drivers/net/intel/idpf/base/README            |  8 ---
> >  drivers/net/intel/idpf/base/meson.build       |  7 ---
> >  .../net/intel/idpf/{base => }/idpf_osdep.h    |  4 +-
> >  drivers/net/intel/idpf/idpf_ptp.h             |  2 +-
> >  drivers/net/intel/idpf/meson.build            |  5 +-
> >  drivers/net/intel/ixgbe/base/README           |  9 ---
> >  drivers/net/intel/ixgbe/base/meson.build      | 19 ------
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 +-
> >  drivers/net/intel/ixgbe/ixgbe_flow.c          |  2 +-
> >  .../net/intel/ixgbe/{base => }/ixgbe_osdep.h  |  2 +
> >  drivers/net/intel/ixgbe/meson.build           | 17 ++++-
> >  35 files changed, 138 insertions(+), 201 deletions(-)
> >  delete mode 100644 drivers/net/intel/e1000/base/meson.build
> >  rename drivers/net/intel/e1000/{base => }/e1000_osdep.c (100%)
> >  rename drivers/net/intel/e1000/{base => }/e1000_osdep.h (98%)
> >  delete mode 100644 drivers/net/intel/fm10k/base/meson.build
> >  rename drivers/net/intel/fm10k/{base => }/fm10k_osdep.h (98%)
> >  delete mode 100644 drivers/net/intel/i40e/base/meson.build
> >  rename drivers/net/intel/i40e/{base => }/i40e_osdep.h (98%)
> >  rename drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} (100%)
> >  rename drivers/net/intel/iavf/{base => }/iavf_osdep.h (98%)
> >  delete mode 100644 drivers/net/intel/ice/base/meson.build
> >  rename drivers/net/intel/ice/{base => }/ice_osdep.h (99%)
> >  delete mode 100644 drivers/net/intel/idpf/base/meson.build
> >  rename drivers/net/intel/idpf/{base => }/idpf_osdep.h (99%)
> >  delete mode 100644 drivers/net/intel/ixgbe/base/meson.build
> >  rename drivers/net/intel/ixgbe/{base => }/ixgbe_osdep.h (99%)
> 
> Looks like some update is missing in net/ice (reference to iavf_impl.c).
> 

Yes, patch 4 is missing a one-line update to ice/meson.build, reported by
CI. Will fix in v3 shortly.

> Once fixed, for the series:
> Acked-by: David Marchand <david.marchand@redhat.com>
> 
> 
> -- 
> David Marchand
> 
