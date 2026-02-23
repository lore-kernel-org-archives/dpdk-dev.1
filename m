Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ABDEC110A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF234025E;
	Mon, 23 Feb 2026 18:00:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 72447400EF;
 Mon, 23 Feb 2026 18:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771866025; x=1803402025;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=L3BfFj2rMbana3q0KaLLXq0iM1PvCzCU5sWw+ziSvqk=;
 b=Zd+uPBtBobRYRIw6pJHeK32OQMX4BZAAHKL6OmER+0lXYek8Gzmefwwb
 nMCyRLtkOMvPb+ZWrQh+ujTrs/H5o35H088qJdIYy/FNMXzplthFHWoTH
 uKS8W8lv9x5MiPVZD/ANh2tYa3HmRDIo8JUH6LlzlZY4BDCT4AybO4LxS
 T8/kRVxhYwELe5jcixF4ZV/dpNaEX/uJdiUJqQ0i5/lnrrQdsHy+f5esY
 3qerWLV/fjQCiT9DNym3rYJe6PKW2qJL6ygg0vA2sk1U7/dfpgjXBTk5Z
 rVSVUUFNEzNBMcu8uGYtlvyV2vSjoebzaaOCmN/9iMoofyNfykTG2TJPv A==;
X-CSE-ConnectionGUID: x8mgC5rKTxSbvjl1BjrRPw==
X-CSE-MsgGUID: 8wtu9OnYQwmyy3MwOtXQRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73045547"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="73045547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 09:00:24 -0800
X-CSE-ConnectionGUID: xdJYzV1YQGyR9seLotRTrw==
X-CSE-MsgGUID: A1Lgrx5YQuKLOLi625gn6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="253346586"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 09:00:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:00:24 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 09:00:24 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.18)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:00:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1Da+oidOBdofxQLNYXqxKNFeBJjB262PnuvmnT0O7p0xdPb4kC1uTFlvu3SPStIfFsnRmu2bXWy5Jtjlpzpbo1SKPaObTAQdL/D7DVjIIT+4dymzTuAXCmcRRAHjIOQ+4k5TLS39anCBkT0KQXgZec38eEVSjzw7Dhdj5id3jT++Vh/PaHzBvdT8d1rBtaO+TXANtmnN99nQCJ/5FQPzQuzLw0BYxXjX08gcB/E26eXC/diYIrOug7vaQjmeH9Y6E39utJ1H1+RphTUhaLK6K+jn/Wz/BfurCVbWF3VVv7Y4gOEGPvG+b9TLZvTnINY9tfaV2KSZcBYYmTqq3wrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCGWSv9ZRJS3zdODVA586lfLecibozhU85lj0k0w1LM=;
 b=jI1PCnqXfrf90472p8u3k73tLRqFJJGVaS3qupq91HPmwiRbrsipxgCk0EzHg5tuLyaDGdYIOtPd/M5WeNfCyLqCAtoshCohfwFbGnRUG09w9e8tozgghAOITwVlwUoOd+P8KPH5DtP2Gn2gE3pqflmm5t2dCDFlEq64YMeGlaCqomt/ohdslApceC88hi0jzgKs0yerUHCDkxTCZ0GpchaGMR9nqJzpxo0xM/9P/w66CeVTZfppszALNsNarQkLkxde5JhSBC2hcvxlnXi4kwRbFKH+k+NP3FzEknlxG/g3a0Qrcg2pMY1dWscYPf8Hp4HbGX6lVR2dOnrXIwEezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 17:00:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 17:00:17 +0000
Date: Mon, 23 Feb 2026 17:00:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: Re: [RFC] test/eal_flags: suppress vdev_netvsc auto-probe
Message-ID: <aZyHm4EmcMGe4ylr@bricha3-mobl1.ger.corp.intel.com>
References: <20260222221542.804546-1-stephen@networkplumber.org>
 <20260222184944.0b43ea22@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260222184944.0b43ea22@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0276.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: de8d4a46-1941-4824-c657-08de72fd052c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RPuS2g32okf/UzkdbESEENFatudZoX/XtcALMWX0TWKYt2oLwbZE3LhbG+oz?=
 =?us-ascii?Q?zjI2EWrTG6o8ftmh5SjW7urPx1Ohkuc1ahuy4tRq3F3Me9lNNen12Ds1dxVx?=
 =?us-ascii?Q?Xr5gl9tSaTLV9pv9Z3OOyPq9eWnx4uvpfxBSde9eNhSXbjkAsDPADVjHsI/q?=
 =?us-ascii?Q?Uirnc0FKtWrhcDCd5u8SepUqyfybIk6ZOCiqy3ztRcenUu+csIzABvf9WCEO?=
 =?us-ascii?Q?4149Om2PNwQqAfTMh4n7WkGbc6t6EcMJQDeMzMUBfsVaKOIH+ObHI6S+fPKB?=
 =?us-ascii?Q?uxsFtrj2A/1dRAW/hU8TMIxw2KZ5T51MvcgMhFCj/lBpxoh7vzxMUrlwb9QS?=
 =?us-ascii?Q?VEzc72m3mYl8R24FzoepZfLpGm9KMNpDL4ZoBIX94Qi8Kk/sXEVohb2hlBeb?=
 =?us-ascii?Q?L0DXgtV8hpHsQY6NgBDg7xd35Y5alKDQhUJFQ89MjrT6WzXWFXsStfCnouHW?=
 =?us-ascii?Q?+4Z5Bg51o+DEA/MYiEk5SmuRp2NDg0QMDFgQ45psXoEs2rJAKCiphO1Lc7Re?=
 =?us-ascii?Q?Y0GhVayEXLE3Sd7ZgIKwjJ7Rk8wHB+VsY/XvUlRVtnV/U8K1wIUx2MY2on+o?=
 =?us-ascii?Q?dje4ZBBRILp3U6bhHkIjJsJoq9+5GcT59xIvLdEwLY0D2rfc/Jzc2e1MIvDw?=
 =?us-ascii?Q?bNdNrZDOKMfJgfxAVLBxlOuga3RxombOtu8oHvNYkfgz3+LJ2impCaDqVgeH?=
 =?us-ascii?Q?otl/3O7qDDoKo6k1W3osFfZdmdJ58REP4NFkCg/d9PROu9rcSU9MJqfzOlWl?=
 =?us-ascii?Q?3L7+WMuE5Gn0LBmyx/xyJmzx/oSVNxwVA9UMEEdVU5YEeznvGvzCybG/c6TM?=
 =?us-ascii?Q?p0k4otMUmRnM/YhiFbfTWNTiRGH98124Eg6IdueCg9n+CBJ8cpRyaSTtPUiN?=
 =?us-ascii?Q?fms894+WL7+y+FKsPy6w3Ph5oCQ89zk/HnCjh5ZOHN/nZ2d/ffdlS2dfYKqT?=
 =?us-ascii?Q?bQJYuK7FpWYtVPUP+0nf2en1oy+UGBm1R5cGpGaMIcf/RKKLjHZqJsAVOfW2?=
 =?us-ascii?Q?gOwWvKTEAviDSHQ56iAoJQsh478IHypGJ9/TViqxKh/tCg1MjF8ATEK4Mwlv?=
 =?us-ascii?Q?ovjoMT8Gocbvgr4GUqKSQXm11AyKRW41l4jZWe5j7dYiGWX6+YucKZCzigvy?=
 =?us-ascii?Q?hi5ex6rOn9blBUmZxReuM8TKzPWu8AChygDYBAA5RBmZ/GRq3S0d+09K7Qye?=
 =?us-ascii?Q?7vZdqBrToS+A8FNbsSZ2jz22XnFJNotJiPpRs7180U/nn5xoW75hoge1Ycb8?=
 =?us-ascii?Q?G2iewA9FRbUHW0hOyG//952lN1Wmcpm/g/+7/7Zf3i2JHlLD+2oZveDWPlFS?=
 =?us-ascii?Q?a5KGaFEaoCMDGRtojM4GxR+m18un2stuxQYv3xDsEYlN64Druwp5vcOzu+ey?=
 =?us-ascii?Q?JZTc8RfF8LcKmzPeF2sfZ6IyrxBNQP4wMJKjPd8PMT20aKZguOAF1PryVZ49?=
 =?us-ascii?Q?S6Hlwe1vjNfnA5edyI5kNRWJCurvSqrF+5i0npf656NUpdYYdwAaur5Jn0kp?=
 =?us-ascii?Q?KxV3eOOJpmXCNWO6I784/t7mMBjzwsmR9tY/uGOQDrAQplGbppuDE6LvQ9n6?=
 =?us-ascii?Q?ChW6jhvrV4WuLowKBCQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyZB2XLeEkBaiAwkU4ZOfcPYP9iB+/3LtpC/LpbxxfNfwfV/YJ4n/PWHjWvW?=
 =?us-ascii?Q?SBIHIRTiEhJ4uxy8EwLLSHxV8voW4Nx4c1N2a6ZMnCWyzWPldZ3PmT/V/Bvx?=
 =?us-ascii?Q?HZCzb5adX1x62r3dPHqr51gQc69NTzqf0OePYOvO9VLmvOc6DpINx3eY8pI/?=
 =?us-ascii?Q?8hR/P2BfWn/+wKvea2IjUXBCR+4pwDMc1EkuFmk3EHvJwF9IgUPwtc5Rxu0l?=
 =?us-ascii?Q?g2whXG8tXYeseDxlJWJ0tCMr4+ZlQkCuMAPVjheuTiHf90iuGenXUu0kqXAG?=
 =?us-ascii?Q?Wcfhok0UELfAwQwhLS14UZMho5uQwsSl36FNzMGd7gPCva5BAzQykLnbB55w?=
 =?us-ascii?Q?VIVOd9llpYN1YW3uCVYLBeJHQbeCDMBI0Hr2Idrcbjd8OdZYDX0oNWzvqRVJ?=
 =?us-ascii?Q?/e441Z8aTw2EQtwkJ/IO3NehAqsqF1/gLW1Ym7xRYjZ1+1HqJWhrF2V6C1ea?=
 =?us-ascii?Q?NO7KSdj/K6XQIKUopHB3FEAqBb/BEvorSfKlZB7xVN4j4b/6/9PjJNk4FbdW?=
 =?us-ascii?Q?VCTw6xIDKvcVkuG1/MNFfuqmB6j9CVCcCdHYXFR/HxiZhuyT56Z/UP/oiwVo?=
 =?us-ascii?Q?S/EqITW01gRbcQ/Nf2GuD0DRqoH+ZPbOdT7m4gEw2c70ysejF5+ecqg2NC4G?=
 =?us-ascii?Q?8OZFSqff8tC1+OHEPjyoIEZ9Ha974fbS8kdmL2BXFg2mlLZXE293XCrLCE05?=
 =?us-ascii?Q?o75QeNI1vkvgFswAvcRUJO/EcrwuY084zL972twiYqwyEOy3OF1rUzPaosxn?=
 =?us-ascii?Q?yBLhom2lJLjEqe6XYAclgMHNEh1WMHw4Q3+OT0QIHAW+GlZQ1ROhtpZ1NMjB?=
 =?us-ascii?Q?7xUrAVNiGZiMK9aIvpvkQYwsfvx1vSiIMR/R31TqTLUzN4ceOANFYnWV1IDH?=
 =?us-ascii?Q?wLliVjNEQyPBvRITDrW3tqhv5WWMDpxt8s0PRbEFhw3/R1q5FWl5mbksYMWA?=
 =?us-ascii?Q?GBKVmUzKLBP5n9q1lL1ATBPb47nBK5iR3ZExHRlHDggU2gWQcM+ZWH24S6r+?=
 =?us-ascii?Q?/iTzeUkIRx5G8r6Ae4RCYk0oPPB6BsYOU4sAhAVl0BJrquwFxgPZ+Mwt9Lfo?=
 =?us-ascii?Q?fdbXrjbZky6e4DJDyhCf6DFPikdIopwohdff7rhUAocfElamiG7FWyAN4PKl?=
 =?us-ascii?Q?HhUalL2WI9eAzU9wNP4rAmp2z8qikgWtyUMcWDDAjduolGEA8RxVzP1NsbXu?=
 =?us-ascii?Q?grPD+J3N6wbLAmZr55cZgeGHYya+rXFHAY79D2IJkahtCL0cuKVbMPVamilm?=
 =?us-ascii?Q?+t8mV0H5P+Dme3VfNJPv7tBmQvz6GKpn7/xZaju4GyWTz3EfcIpdkt4Tl02z?=
 =?us-ascii?Q?56G+axW1jvPG6mB6o2vhxWDRx34M0cHAi5CLQIKjRVpI+0c3p8gotupJGLuq?=
 =?us-ascii?Q?ZduObBhNlu0rF0W8tdJpmQ8D4WRq8rPnVO2bTrGfwtaepnqElJuLyVG75tmE?=
 =?us-ascii?Q?W4W8nj6NJU7JZj/CaMfeQm2RpERA1EuVEbGZZ4g8fwzkT/LX0thzEstC0bmo?=
 =?us-ascii?Q?5xbanU4Nk8mWHEd1HVM5EX/4ADTbYFOZGa9L8JGt33JNJA0YexbsYUSRZjYV?=
 =?us-ascii?Q?kFgO0sygXE++Bo0BTeqhgo+JUibd5Azgbfn2jfVTDitTdW5LIQcilQ3Z7GBg?=
 =?us-ascii?Q?MTLh6Kq/mFk3w/CYdrcAYse7XOArUWvFtfVWAfUjrqs995clk3dW3s96xJQu?=
 =?us-ascii?Q?vcsG1Cis4OqZPxgk8oRbFvgYEIdUjv0EBFDvmQjUalnunczrOeAAp4bLjKWC?=
 =?us-ascii?Q?q29P9JV5qR4K810Qg1rz4OEPSE8JknE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de8d4a46-1941-4824-c657-08de72fd052c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 17:00:17.4590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eerf7BkiPLLsT5IOrg7TgEm4OHXc3E4FbV+ivG/HVnzbiIVXuMXqVogDj1xmYt/dY84PQ6MB6u2xK3LpZTQN9ZW7JXQXyNbomJI46dMKr2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
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

On Sun, Feb 22, 2026 at 06:49:44PM -0800, Stephen Hemminger wrote:
> On Sun, 22 Feb 2026 14:15:42 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
> > driver auto-injects itself during vdev bus scan. This interferes
> > with the vdev flag test causing the nodeaction subprocess to fail.
> > 
> > Suppress by passing net_vdev_netvsc,ignore=1 in the valid vdev
> > test cases. The scan callback sees it already in devargs and
> > skips injection; the probe honours ignore and does nothing.
> > 
> > Fixes: 0d684a783088 ("app/test: fix and separate --vdev unit test")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Self NAK
> 
> This is not the underlying cause of the test failures.
> The issue is likely parallel test invocation overlapping on the file prefix
> which is already addressed by another pending patch series.
> 
> That said, something should be done about vdev_netvsc driver and github
> interactions.

I don't think it's parallel invocations - we don't run our unit tests in
parallel in github actions. I'd also note that the current issues started
appearing when we patched in support to pass through the drivers path to
the secondary process calls so that they could match the primary instance.
Therefore, I still suspect something in the pci or other bus scanning to be
a problem. Do we need to disable the netvsc as in your patch and also pass
in --no-pci to the test cases?

/Bruce
