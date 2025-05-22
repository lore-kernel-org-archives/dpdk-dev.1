Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC55C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 10:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FBEA402DA;
	Thu, 22 May 2025 12:44:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8576E402D1
 for <dev@dpdk.org>; Thu, 22 May 2025 12:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747910688; x=1779446688;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=86xAnWQd+HCZj1HVP6JOETAfr82Aaa9uoA2Y1skEsBI=;
 b=ThCP69iBjVxvwymTLEcqQhPjXSrmDXDAi9V5+huP9UPjHtxipHg1CDEW
 jMh/1PJnXuAl1PNeCL2mxXWU/9EwvrctXROop+nBdpWgHc16MbRVXig3l
 zCyEnNjT0oAmjMk2tJGDnR63kCliac6+ZNMaF3Ufrd7t7P/muPzPBBdSU
 siKZLA2lK16n6X93jhDtOz4BZKQCNO5/3J/do7ubmwnTUgeZizESqf9Sl
 3i1ffFXOfpZLeRld/5IpBk6/u6qCe9g0gjPYGB8iHzLqonsioL+sqgaft
 PIrMv2H5BtwoWjmhqqx+b6a9hV+LFD/ifnXMcdWsWKIE0TqlrsNaVeuzi Q==;
X-CSE-ConnectionGUID: L+Oii1r2Sp6xtb2LXnynPg==
X-CSE-MsgGUID: Iu0hmuBwQDqYaZCTtcOXGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49044594"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="49044594"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 03:44:44 -0700
X-CSE-ConnectionGUID: iDIBRCeqQMiFK3hy8V1YRA==
X-CSE-MsgGUID: kxW9rec0TEyTBBYGjTCSMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="140410782"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 03:44:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 03:44:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 03:44:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 03:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2wr61dtg+pcI6zOLVJm/L8HRIfG8f8dTkEyU7sN/MN5dWbAM2Gk8Pj5ijD47dfv3Wpj5KIXU95T4HieBfmV/4b4SdZh24vUmodC9P8UYec0rYMirDKLKHf8jPv7QHDrE4j27QBkNiUShe3OvfqYuNt6klUnEXHsmLbwZTgdKUqXZKcDNvGmceykdPwrY2gLv8h7BpiWScOWA1AImRo7FvAHEYsh5NOUrOT2sU8VzBizoQbwc0J3Uq5T054zpE4wl1jKFHeWll00aUgsky8Oe02L5eLWXC4eM3K42DPOdKBQcS/tOjMffAqhM1HozH2JpD8tjjWwdKpmDEx/cHHkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiohJVmhCINWW2MvlJ8LGNYUi04EThu559yWW+QrGO4=;
 b=R382RB7Gu+MkLbF/PhoFvwH9L0Hpkj39QO9GCUIUGv1gAUGzhFrvcG/lppBAsSWZlxVDNm2bbs/VR9ykJVwvIpztXvWbwiC0cFwU+33Z05RnYi2GQ5TJkEb2wc2lgH/C4OQ9GJa8MAdCnqh8Qw0G/eUFn1ff5PeU7F7XwuCFepj44/f7XgcyC4oc153ie7/xAMNJdrzrkFid6Yv3z17WDrwye+DDA3PwItA+T3cNSvbEEbHDCiHnp8RtUP4l9Eq5nL9UFsLrx70jIheSdxOrTTsh0Jr6Duc3dSHdrycvhOa60rm8dA2Hvk2/sW8L5Xz7FdHRnturAL5uu3bb1hr4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 22 May
 2025 10:44:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 10:44:41 +0000
Date: Thu, 22 May 2025 11:44:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [RFC PATCH 3/7] argparse: make argparse EAL-args compatible
Message-ID: <aC8AFA425744qaH-@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250520164025.2055721-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250520164025.2055721-4-bruce.richardson@intel.com>
X-ClientProxiedBy: DB6PR0301CA0086.eurprd03.prod.outlook.com
 (2603:10a6:6:30::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: aec9d6c2-2869-4197-7001-08dd991da7f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLApzxaEAaCDVyhO82fZA5WdMYLWytjg1FIm1wOld/RK8h82ug4sEpVRzPX5?=
 =?us-ascii?Q?Kl0AqtnCStwOmfVtu9An4zvdBca6X2FADYd1u+4TqF85G64UewoprjU+x30/?=
 =?us-ascii?Q?RCthTAAEmn6TcflkFTMXnMh1MrcnYo9yPr6fwDTHVeWDNfYY8Qwubj2l9Oyp?=
 =?us-ascii?Q?fTWtw4btVYhBHsVx9Jj71BH/L+ChPSqWClBdYkfIzW/B/36cMW2dM7C1h7Ax?=
 =?us-ascii?Q?BxtZnyAdR4jRmN+wjrXl90FmlSc1QSePmW2RgxR2hU3XTjYJLha5qWH1sv/q?=
 =?us-ascii?Q?cpX+f29xuqZ2s8ldid6DBD/mY13/w2a0/JuNdbvnQrGf9kakPSU5lC/JSjP1?=
 =?us-ascii?Q?Rm0B/bmv6w18dh3lRAQCmadtapwXwds6mmEFqweUyq6tPIk00SDpUvhTb9XM?=
 =?us-ascii?Q?3jTqDWj5xx924M4gBnGnzv5Zl0MPk3O6PRqpu0JpqLhuUzJVQhd584kYcqs8?=
 =?us-ascii?Q?LUAIcOX9uJHcIsdaGgXVg9cGKwxfBNt81P39bTviRCqQi0+VPAAF8LUnTQCi?=
 =?us-ascii?Q?KPJ6JDHPJ4efUhxclFthGNB2x7GimwPBEYRRL/w9y0vg0KqnuKX8tu7kpG5v?=
 =?us-ascii?Q?M7GOxmU/nU03oyn8rY1dQHLM9w5OR4xWnIUW1jbAc0QNzpX0QaqX9jqEzWNb?=
 =?us-ascii?Q?+Dhu67yoTQmamYwfKa28Q2pTMcaSZkEnrbxqmGdqQbgT/kQGWgzz7uxZD7zp?=
 =?us-ascii?Q?eSKeXKBbHtctWtA5PYz4fP42U9fq52oY64+Cbaavdp6yG2SuhdvybD8zxtt4?=
 =?us-ascii?Q?9t/LfNOyICOtR8+PKtxuNCEyam1zV1anaX0KQ8oXKUy4AkTKoh8QwDRoRQ78?=
 =?us-ascii?Q?xfldnyT6BK1kIzQFNUxREhlGChanMjv1tSQQfqFrQEXNi1nXc17Ih56cOjjH?=
 =?us-ascii?Q?+m1Qs1ijmgyGZJNiCvfFlCiBg2us/Yv7cp5+xlMncfjIx55tE+cN+LHckWYN?=
 =?us-ascii?Q?xAntUed18DVqO4io8rdeWtJipAp7QUf6i7/M6JLU/+HKUuqq6NDvFszw43AN?=
 =?us-ascii?Q?T3P82FIAw3lG8Sm0riZLbFuHy6CLidN+XlTnmnVgD1+Vs5cfKfUQvGQ6eErf?=
 =?us-ascii?Q?ol3Xb6ipQsTeXXfMbBah2D29T77ub/nDqMiwmtoouu6M36hUS2r9F2lF7k0E?=
 =?us-ascii?Q?2JA2SG3eWZbHVxK5756j3JWJb+YFvb5FfHE09glMT1/ZMaB4Rie7GEd73wov?=
 =?us-ascii?Q?WzHOcGbjFdJRIg+EOseiQpVkvKg9N5E8PYZvfkO9YaQMmZTMLTq+mAfP1fLA?=
 =?us-ascii?Q?AlGt90erj6uIc5NFleooiWCbwJClgYI9JptsmTWdLwU/tXmuSHOeBwqy/4OM?=
 =?us-ascii?Q?jISxlPUglW8fl9dQdE/ngt/J0vxJwXhlqAQAIBOo0lzgq/IOgj9XiXkIGKPu?=
 =?us-ascii?Q?sbsorCGRDWIDBUU0A7k/EWl/ocksUvASCuLv05+sLURm+8SeJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJgDbX90gX3rXOevcBT9ESSEHnq3fPrt4hn2qEo4XL5G/NI1V4TJVXuNaZ3P?=
 =?us-ascii?Q?65S9KaYYPA65PO2HYaxRrY5ymFVJccBw5Ei7JqbAgPI3QQKvBPmKm52xiXyR?=
 =?us-ascii?Q?ci/Wt3MLCrJh12I7tVPQuDy+UINgV+pXvox8rWpeMTSIS02ydCqepZNbgKDz?=
 =?us-ascii?Q?HFuJrZZZvWoAv/ovCL4CJmcVO65dkyCAyevv3O8eP21btIvtwA5jyJOY8VLF?=
 =?us-ascii?Q?zveziljizU4MnlQA7/e+JDvpVJugFJ1gXf8g91vE+/ITllQyQpt8eTNYKjn1?=
 =?us-ascii?Q?NFSCvc4V5a4RFxkun4EZEWIakEWGONkp80Yiu4GhsvqwXUS/3vM3DjisCnhf?=
 =?us-ascii?Q?DTSjPy0xem84npnDie45WOFREzvHLBkZGzRZ68c9BqAhKh3MptAXGdvlLZYy?=
 =?us-ascii?Q?EM/YeAL/pSgGj1rFTwOVbT0td4z1+q7Wc3n/f23i5kO/2uEz8Gy2QnfuyAeG?=
 =?us-ascii?Q?CNWwphoJMwZaQmh5sF+8ezLnilu1y11LfotxSNXojdtae45I6dyXWdYlilb5?=
 =?us-ascii?Q?fCUy1uq3G4Xq1mBl89vDEbknD3syD3w4j3/YJ8nmb00Vm28bJe9qc/A1Z/gR?=
 =?us-ascii?Q?7vws4YBO4nHaVGOSnBuTaG4QV9kFYAxOPiMGsKFq8E901HaVhvZW1ZqqLNs/?=
 =?us-ascii?Q?MKEs211lF+J6yMfDDP+57EDyAay8hRn37fDMu32n+WtNuWTUYFMjYTwnd6Y1?=
 =?us-ascii?Q?G3t66FS94qI3/lOpfOkOhPyX6rZ294KpZOSlc0hM79DJ6e2bVBxQF1HVNZIw?=
 =?us-ascii?Q?18ePOdLeGNI8fveWgtZmJLl2cFYPFe/RFssJVe1k0ZwI0q6fKzyRtRW0p56V?=
 =?us-ascii?Q?Dbf6rAu2gpi23X7JAXHC2kwiXyqSgRjRBZxTiSARn0kKGO93pN6KDaohSpzf?=
 =?us-ascii?Q?KbX4AGR3B+6OQSzlLv33M0RTcwMRI0SmNAwBUsPxLmtt4ClQ79dwL89zcvOW?=
 =?us-ascii?Q?b0sXCuZZw3o6X0rXx/C1/PIIJ13sjq4fOdfTY9USDcZ5fiYdjj1kUIpwHEjQ?=
 =?us-ascii?Q?0OTCSKwfkvqObbo7ShdP3H9jXjnzVwRevz/u5v7XqvoSo3gHqkPsNJb09oNu?=
 =?us-ascii?Q?99BmjuocsT6cj4gVUxeft6PYDdK/RKa60mKIz/4UxjklgNdPNoOz1C+pgwvB?=
 =?us-ascii?Q?R7amTRHra/kv4J8jftVexq8T2hvmtGQlqu2u/YMI+IxAdnbxv7JeMkQOdo/2?=
 =?us-ascii?Q?YdzJHI6xmPD03EltEl5rPN9cMRA4e+VRFueCsvB3ENwzNAt3RU647rV3uiSG?=
 =?us-ascii?Q?l4xlbjCHba/8/CtEGuG2hgvttkqvsfWC8Fiu26o5qb+O0MYEq9Rg3Scf2E1q?=
 =?us-ascii?Q?WXVihSxQ7kKhxEM42xIrK/kU6d85pzxqn66LIRqAAz9k1VbKgHpMjeRErWrk?=
 =?us-ascii?Q?mUr17/q13y/Z65OI3hZu8oXdzEgNzZlRPzF4y3BVLDaZs2eLTeEu4ZrPVyOp?=
 =?us-ascii?Q?K/CCJjoL1M72JesamTr8FqQRfKhfGWTNpwvH4m7CTF9ZdclH9j9iD7Nx+ibw?=
 =?us-ascii?Q?jZLvyrrryqzW0IT6HXSGXFltlgAyy8nhOU9W8YqrXzXjOtWDqVp8R+FZxr3c?=
 =?us-ascii?Q?puq9G5mXFN723jucE0B91u3n1ZB9nX64UQke0rKjuTZ7w5lX+oUGydaRu4Cj?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aec9d6c2-2869-4197-7001-08dd991da7f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 10:44:40.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpAGVFWuzZKYf8aRcP9TlKv/4FfYFlxLVGiveInW8r4ZS43uagTgV0yW+3g7BvGm+CbzL3RoIgSB6VBubO+Zbyk+qXqndrR2Anao6Aihcqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
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

On Tue, May 20, 2025 at 05:40:20PM +0100, Bruce Richardson wrote:
> The argparse library was missing two key features which made it
> unsuitable for use by EAL or any program wanting similar behaviour.
> 
> 1. It didn't stop parsing arguments when it hit a "--" character
> 2. It never returned the number of arguments parsed
> 
> Fix both these issues - the latter is a change to the ABI, since we now
> return >= 0 rather than == 0 on success. However, the ABI is still
> experimental so we can make exactly these sorts of tweaks to it.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Thinking about it further, for EAL we can actually do without these changes
to the argparse library*. However, this is also functionality that may be
useful in other cases, so looking for feedback on whether to continue with
this patch, or drop it?

Question:
* should argparse library stop processing args at "--"?
* should argparse library return number of args parsed, or zero on success?

/Bruce

*The reason we don't need these is because we clone the argv data on
eal_init so we can return it via telemetry library. This splits the args
into eal and non-eal args, so we can use just the "eal" arg array to pass to
arg-parse, if we don't include this patch.
