Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16BC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 16:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65EB240A79;
	Wed, 25 Jun 2025 18:01:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1F9774069D;
 Wed, 25 Jun 2025 18:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750867284; x=1782403284;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=oR+T6xubToPyacb8chgW2LSf6xxJejuOm1cZDf82JiE=;
 b=VMkCEQiaYDJykCKsYRiHO0N5lfhUnB5l1OXQe4Y7r4gfxmXyT2mIYJgr
 DlNW1gCOeHuM7gP641LwxH+kaI/sHKllB2B2RX9fl3qerx3cXhTXdNKwf
 vT3ZVmS1hu/vt04uO9rbS+koZpw64BT6SLcfMTLwiyn2KfeQ9feO4BBd5
 RFSbSi8SAx7Pq6Zjy/tEI1O5dK4Er/7o116LWFGQ7o4H9Yvd0/8ASc7Js
 eGutcuYCV6FtNw3QfCa+Cd8UkrjT7n/MgevFH6pe8FXzbtyq+GQDTJOuc
 bRpLlUZ3NMPii7Vx6M9fAZVPrrMrfwDUctGEDjN7h0jhu9x1t2CZKrSDt w==;
X-CSE-ConnectionGUID: /ANrFJKRTZ6HDx3220qS0w==
X-CSE-MsgGUID: mRh42qAjR+qWm/rcGLjuwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64204424"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; d="scan'208";a="64204424"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 09:01:15 -0700
X-CSE-ConnectionGUID: H6MOMKLpRLmj1qR1uguczw==
X-CSE-MsgGUID: uwNGBsKSRxKWX9qLRLMlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; d="scan'208";a="152383125"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 09:01:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 09:01:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 09:01:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 09:01:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA41QWuNihXMmigUYzBbSmWHr2iUzO1o+oSU32W9sudKFe+xFM1zxa5zCYCCwT5qpTNNRyv1xUbLRM2CUBNiIypvc73wtSs/g4gXAHKv3EUQ6WWjvgToLMZH8IzzMFKt9JeM1OH7FNvjO1Koliya2ylVm47n22kINeC3nJ/1vVYi7H+T9RooEoSV4EhdafMvTD2MUeGd65tJGTL8lU7u+eTcj/7aYPIkasLrfJNUY7LuRiW7DpHj2bwYgl1pnce//OlVIOYSfhPma4BhLZNh+2E06vPtlQMyAZ2WkFaRYV+xCoSu71tFCTYao2zYnPZw0KpGKrw3w/yfoTfgEjc+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/5VM3IFxvkPmNCkPjebi7IJxJuUO386ObEm2jHe/dI=;
 b=KueXHDtb7tIcVnF41m6QzNTjkII5Xz3o0D8rx+XDoBPLTfjVdil+elqG7pOu6NwQNy4aYwvjhtzPNOxW6XlxNSjjGyyaTB9R5iFMfF6m6iOmoBRcAiPEnp7LIkU+559s524JH8NCDIfEwPWECEXQRC+5qJRbfwCuVEz8AIToAme9Pp6Q8nmXL6aIkrryylkLmkSmY5Ov9Wx3sNPzMNhFI4HSmDjkeCUSh/JFe4Es4jciR1kxisbqr8CL9osCnzu5LJ6NPn0lHRCu6Crlri2uJoUMYBTrFFTyee9Qjv/yTcPqvLnxYx3dMkuB54bE4L3KKliZdYcJyiewZO67cR8Etg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 25 Jun
 2025 16:00:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 16:00:53 +0000
Date: Wed, 25 Jun 2025 17:00:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: fix VLAN offload strip flag
Message-ID: <aFwdMdNiHftewTi0@bricha3-mobl1.ger.corp.intel.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpOU+q542mGrA+aT+nO8Rs4dtAY==U2SbvYJFvVd1e4qCA@mail.gmail.com>
 <DM3PPF7D18F34A1A1141693EF5A3DDF8B588E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <CAL+mCpMZDed=QQ-RH0Y0GT095Cnyhz2rsvg8abKuM4_U13-eGw@mail.gmail.com>
 <DM3PPF7D18F34A1770F61E83BA4D365FDDD8E7BA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM3PPF7D18F34A1770F61E83BA4D365FDDD8E7BA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB6PR0301CA0067.eurprd03.prod.outlook.com
 (2603:10a6:6:30::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF8622363CD:EE_
X-MS-Office365-Filtering-Correlation-Id: aee3d136-79d4-4d2b-fb76-08ddb40176ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?KnX78fKQdxTzcS8v1X6OnoaNNkw/hn+e7nmwQ/ITPSvwIz8joY0RI5s4Hv?=
 =?iso-8859-1?Q?4w2CnCTJMsWC3g2RcfhBqLdXXRko/FPnr/Mj+MSmmDRLJplSPlY8qWHAS6?=
 =?iso-8859-1?Q?JCxEKC3IyFeGuEen+qvHYxRAOKkYe9qQKU1WtiH9BuFRtTHVQxG/EK9mXr?=
 =?iso-8859-1?Q?FuwegmCDUBfUNr2fWLDeTRMQpbQJVpNKlcwqGM4vJXbBRMpLzokaHUFng4?=
 =?iso-8859-1?Q?dzqLw0MAhmGPy1J4MJX8iiuuNNBJpq1bY0bKvKpijXMKh7X2SsGZXP559V?=
 =?iso-8859-1?Q?rm43ff522Xi4RCYwz1mgjmOemyfDxQr7AN3bBUxOjwzzTEH7VRBqDzWiQX?=
 =?iso-8859-1?Q?ttYRQN8lxX0bxHvF/Ns5xCvmzf5zuGnlRLayatZgUGFR4xk28HVFDGuH08?=
 =?iso-8859-1?Q?cm6GpKz8jAu8MrnIYFIGthTeMpDZ37q+624J/kZZd59aBSglLXPxJSoPh+?=
 =?iso-8859-1?Q?2VB5w+BqhSKn7je8QWyzPp4XpPevLAjTwDiPxmfbL/qMM07umRP67QjUU9?=
 =?iso-8859-1?Q?DR8lJ0xqRTfy+PFA24PBDb0qFPRmGsbds330m2oDTRS27ECPKyrzLjvvrO?=
 =?iso-8859-1?Q?LVXwI/YWBn52Mg5seFbTODSsiahuYKkGfZ+BnGXeBXpxarI43DEEC0Ueo8?=
 =?iso-8859-1?Q?LXSTWf/cpvhWFDG0DcRCwydQgu/j3+HXJG1AG8Mu2iU4bNMJjrrfL41iAm?=
 =?iso-8859-1?Q?/sJQPLPjNZMqk5ekLOfXGrd9ZCAWPdksoRflKc9RVFGOgTO+cmE5qv3kff?=
 =?iso-8859-1?Q?ARa/w1OM+mhoBLJh90EpMRg9AoMtLUvKvjnUZjAJZVOM8q5coWgeeUJ1t2?=
 =?iso-8859-1?Q?b09jaRBjAw5eO88RWnGHOFzdbPhPBFXK2aXf0Y0iS1YBNSA5DGaSISVi19?=
 =?iso-8859-1?Q?NZXoWokS23WA2R4aZJw9WnG1YI0J3VaUK3jT2MyVQY6X7rcdO2G0tTJ7ZY?=
 =?iso-8859-1?Q?oeN/TshCRIzP/zYrZZALqMTqrbeHi7a7bWvm4vaH3q6BynaTs/WHkhIPNp?=
 =?iso-8859-1?Q?08qhEIG4OvmnyKjE5EF3/YASwqJuc0gcYas0YO2SrsZ5F9nZbkFQCrVA4u?=
 =?iso-8859-1?Q?fkDInr84AItYcx+zKzaqZkihI+n8xHoddSnAflybKTyTGEpyWgC/sH6Qwd?=
 =?iso-8859-1?Q?2StWRw/+Iiwo3gUJppK0AtBhBErpuzIw6V6uuWwUXj1sInufy5q6OvWTeZ?=
 =?iso-8859-1?Q?i5OFfprSr+7myUXIVX8zmhxBkB+GmPdS/KiJWyXY4+6pRoZwZVIRz9ePB+?=
 =?iso-8859-1?Q?lGXMwXs4n/0ZrmXdORZz+GFFuUrsbBNneh5iiqq1LB1g9T8V5beHXfFSlo?=
 =?iso-8859-1?Q?yEOcpHdIzMkt39gsTokU5+y2a5UG8ZzO5Lws/Hy61rXZkkyxWDykWEf0OU?=
 =?iso-8859-1?Q?iWletziLOYoKVpU5I9w3tuGTsn19Y1m8fiak7X9gWBGf8owC04ekfhtrQD?=
 =?iso-8859-1?Q?W9TyeI4u0CChGUCMUfWjA/OVEZET1P+90HV0zPTAr+zSsec6zAVVKnV2XG?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6RXJ/uTILLNFP3DI1dcbZ1czKVuakmzP4+Zdk4Z0gwk4oSKPyTsgPuPRp4?=
 =?iso-8859-1?Q?THITBf+DysQkFTf31jsmxca/oZR/OabMlOt3y/HPBE9tlA28XLtawcn/Th?=
 =?iso-8859-1?Q?cmGykPuvwoVwm7LcukhSF3g/0bM67QkL7f8lifDfdT37q+GVdWAe/47BXj?=
 =?iso-8859-1?Q?KbwtTRGgjFoRydzbzeeW1T/MjQbCUXgE/RRR520Sfs217QTQJT3CUThboK?=
 =?iso-8859-1?Q?KauxzG6nX3/f7QrKav5bSoOVyRnVmkTtN6gjD1N5Uni4hqIi15x31KB1Lo?=
 =?iso-8859-1?Q?E5yHvYy7DmET3ZXIHvvu3j/opHO+RGVclOeoK9r7jxOZNJxbh7jGGe7xZW?=
 =?iso-8859-1?Q?Y7k3BVEH4OEnBYa3TU2cRVUaqzrGfQNyq+RBVrVnrDeZkvpX/i3FNIlXBv?=
 =?iso-8859-1?Q?JhFsQlfbYCMTf3P9kX/tg/cvG6OecEvlI2nAG1wE9xInD+d4H+VWwqrHyM?=
 =?iso-8859-1?Q?ahtoUYUXWfpZ/Ex6b0kYlC1tX7RXGdFJBnb6ZNIcvmx1uGcJ3+gqNqw8v7?=
 =?iso-8859-1?Q?WFtTcMmU9eZQsSgxHCRLCdpn7wKcJEXQud6U/MfG2MXPn7vas/8WbFHIZN?=
 =?iso-8859-1?Q?Cyc2gRVqC4VQ0CJLMkLlyGYCnMdqeZ3384+iJ+1ymFr5i1WHYPfDok7RkK?=
 =?iso-8859-1?Q?pMkNnO+HB5nRs0/J4sES8dy18I1nn6YQsH95y/B3xYyclNN0LDE9QLsGEI?=
 =?iso-8859-1?Q?CqMlhKzxOjODwQemf+ATmBNaRrzq8OHnVDpSokcnBgQ+iWmIhLBDxEpzXC?=
 =?iso-8859-1?Q?AiFdn/GWVDKo5Kwkio9VInF7axQUcwjuxkW7ffyRsFwaYgMZOJxuuD+DyR?=
 =?iso-8859-1?Q?OgmHnyhChjV+hnyujbJFK+z87XgoHf/W7PPkU+Gz6bWGtVRiWUs0nZDnJb?=
 =?iso-8859-1?Q?eM3DpDNcBX6fR3/bPhm8HKcsCxcAR7AB+3c1pj0mdkAemAvGZ82bUgLY70?=
 =?iso-8859-1?Q?kNwpn1FiuztsH+B8lv793SLfhAcx6DmpGZZTT35qTsYfazMWnTz7ssWIEh?=
 =?iso-8859-1?Q?NUlzY/Zy7+PEXrbYKh3eaM+a/0zeCPeFGafoKDV8Bc/Jm3PPakcqcVygG5?=
 =?iso-8859-1?Q?mjxlXxnuL7g/G9c4KP06gW/71xvf7THD8CQQEHpBB6Rb8TbycNgHBTNFT0?=
 =?iso-8859-1?Q?zouOseXHKgEv9hb4Lq3/wFZF5ez5wUKC71KGZGej2mwIVGoLXlNI9cxCAQ?=
 =?iso-8859-1?Q?FeMqizkygGp264DcQOo/HzCGjcaI+Npkr47qZIgRWAZbGRzOgxMCN9X0gi?=
 =?iso-8859-1?Q?yzJe0IhHVXOpbVz3d8+mzqDAcqraayNlMBKtn1CRnEFrHC9TY2dL5ZOo6j?=
 =?iso-8859-1?Q?pjncLafaBLXccbWZTtRx74MRmL3DwE2cavFdn/HgCJaXkGIp37fn1U+Hz6?=
 =?iso-8859-1?Q?APiWr8Qj6FEfEoIaNgdRWIX0l7Uo5g/bnG/yShhSBv6AZV2P6tHI6yPNDU?=
 =?iso-8859-1?Q?dF+4RO4nayRmO80xEI6aqzFbK70V7Lgrh72yju2mMneC7V12gXNDFP0GR0?=
 =?iso-8859-1?Q?WCzp/A/Zib6Q6KyijnRd13PDA5ihcD+1pM7kAExClkffvF3xYHlZXW+s/Q?=
 =?iso-8859-1?Q?GKzrBiLH4a6auqcIsHW3DwlQT81a3Hbvga3fEI4KIWAcuPtMp6oPrHTJm/?=
 =?iso-8859-1?Q?0Wz6CkVlY/ZS7jAZxPy3WYaTWhqij+lbssZ1C5Htspz5TbRW+RkPWQiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aee3d136-79d4-4d2b-fb76-08ddb40176ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:00:53.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf+5HttKrIBgi3B0SjV0OHgayU8e54X23qFLz4aYxU3UjFSQEihTbfa3AFXJkY7M7hEIh2nNRrC2I8sDHbSCuUfzoQlQnZO8LzIKanCtMxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
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

On Wed, Jun 25, 2025 at 02:01:15PM +0000, Loftus, Ciara wrote:
> > 
> > Thanks.
> > 
> > Just wanted to know  - what are the next steps of the review and approval
> > process?
> > 
> > There is a test suite "ci/intel-Testing" failing now with v2 which passed in v1. (
> > We know for sure, there is absolutely no code change between v1 and v2
> > except the commit message). Is there a way to trigger the test suite again?
> 
> Hi Amiya,
> 
> There is no further action required on your end since the failure seems like an issue with the test infrastructure. If the maintainer for the intel next-net tree is happy with the patch they will pull it into the tree.
> 
> Thanks,
> Ciara
> 
Agree test failures look like false positives, as they are errors with the
PF driver and virtio driver, while this patch changes the VF driver.

Patch applied to dpdk-next-net-intel.

Thanks,
/Bruce
