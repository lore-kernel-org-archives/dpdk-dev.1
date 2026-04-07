Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E1AEDB7DC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 09:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8334640265;
	Tue,  7 Apr 2026 11:20:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3CFBC40150;
 Tue,  7 Apr 2026 11:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775553600; x=1807089600;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=s/6uPPcjDlP833GeLcLZVYuZQ3h7N9X1nzRmYa8J5h0=;
 b=CxkkWp30QJpG7qPkpYCEdIz3+f8hSghvcUVF51APg1N43uZtK9YH2ium
 7eeb5KB038++3rCuiMycy2hxTvVg5C/et0qiAXm8Zpqo5I5UroRDNkaFi
 cFfgU6FYbiVhvhWTw0lVbi2/etE+ahCPwUnl7Pk03UeC8gRXwkUouN3DM
 HFfD2UzaPg8w9VgeLSXaagaR6Bc3itZdrKCn4wipCbatN0/QKeJ/2sXXz
 RtaqPqHsQewE1JFbl2Bw02grgvQIdnB1+xuiXCb4tEBbf1kUAzeUIIIh2
 zFNM5E7tnNSVS2W3Hpu+4jPT5aSZEF3icK0JPApFjV5EjSWRAqlYy415J A==;
X-CSE-ConnectionGUID: plJA3XLzTUy3Muj7yNGuTA==
X-CSE-MsgGUID: LhH2aNL+Tvq2HPnrXRSryw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76524351"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="76524351"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 02:19:59 -0700
X-CSE-ConnectionGUID: gZ2fB8FsRGGnYnqnotUriw==
X-CSE-MsgGUID: qmmzzCaURzyQ84WnHfeW8w==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 02:19:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:19:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 02:19:57 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 02:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjtgizmFz7LhiC6nvFzpsgT3KM53guK6WPw7aVZxU4JT93M18xbmIz5IRhbxGg7Xr1HUGFDrV8RB0r8w2UxuHDL6VXT4D8aybGqacA63GvNCDrOzKnTmdaBrsHoFAp4quLM4J/Mkm/MVDuSQLRmVeSIXW4rTze3LkhJBYpyBCTljHIElv4uJ47qh5mcB7ZW31/GuSi6MLjANPWUuQxgkSHHOU9VVWJxmgcpuAcEeDKU9qWzcpjwrbx1wKLTtQ4DT9V7efKlMDChBE3u0I9ejxRhvSU5duhX6wO9mTYXnCCj59+KchuZsXToA5vJ5yL1ZGgz/YmBLYtY5DaWhr96wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xQ2C4WzTNSfanV0/GwFjKCJo+zXx/O3EvtVw2aGNAU=;
 b=Vv3wvVQavcvkl+xyhevTw2ipPfwcMOar5aEtI6o43jRmvcB7zXJVyieF8wf2PlvTP6YRKd4LUjVN3sA3XVXgtzT4wYeVfj5zgVlRJnH5LmDRYgtRijYfyrDEPR+3q9SWg2DYPu8NBr1rhrIlreYHE2MSBRJIABiTGTV7xBKxX+BbrZhp9e53R4epRMH7EK541ttJzzaGCT/5AZWXMk5mbWyIjAn1Fh1IJH/AuFqmrtII/reXUL9HY5P/trPBoAYYbW8KwkGkAxBHPi0daDJc01Xv+l7uAUfwjnmGXrQxTlyvXkkfO6ZCrfQAs5gYURPM35XR+xKiF9DKId6FURCQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 7 Apr
 2026 09:19:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 09:19:54 +0000
Date: Tue, 7 Apr 2026 10:19:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <bugzilla@dpdk.org>
CC: <dev@dpdk.org>
Subject: Re: [DPDK/ethdev Bug 1926] QinQ strip not working on XL710
Message-ID: <adTMNozZwRxHl249@bricha3-mobl1.ger.corp.intel.com>
References: <bug-1926-3@http.bugs.dpdk.org/>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bug-1926-3@http.bugs.dpdk.org/>
X-ClientProxiedBy: DB9PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 841c5d36-6718-4907-e188-08de9486d4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 6VXga7zdNlOjo8ZbQFbVfpebVfj8Ek3wfZRLvx8DLW5FWGtfpi9WYlRMbevzbVowfuiEK0dI05sA15c2TJwbCdqej1Cp5OxBM1rdV1LNN7JgbamSY8SiT20+2cRFhcERQozimXZlC75U4iGUpwMvZRrbW7HHds79taqu3Kn2QXW1rP5jFUHpHcBG4rM0a7ErjRFv5EG1GHJc02Jxlgu8sLieGRnCQossthW1CdpNbzfxCa/rLhxL8eZLBIQJzYllJT+0hsmgw1THU8vXh0coCzJVHcAiY9DV2caYu5DFwMMxT/CEnxcxrmAZGRulEPFr+N5AfQPdIePURZim1CjJdwNM5xJloe9dSx+qcrFX887cfscRNquM72SemRTVo1Ps66+6W1JKO3dVhYg/c9PQX9yAdci7k9n2Wz301soHUz9cVP1uaCEVtmlSRTyWfXLH+sHKRY4y+JDQ/kf+l7vK7RC8lHbuom/Aijx6ANN6lanJZPTQg7Et963pzYlVZGT7wHljjOaV3SDafKi3IrNap0ATGlpL0dd38IZ3Qa+dEtGsE8wv/p4UPg9N079653Oo6zycAuMMLPxktb3L6DrcWoCuEivSPRDBTeNBrgAcPKjbO/Gz9aWwh3VFwl87dFmUU6g2o28k2csVuVFl8+fJyVdDm6PRBO1IAWpjyyEPEyXqT1Gxp9rDt+2Xt+TCjVzl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRUfX0DPmPL5g0vBWrzX/XbDioKCjI4rT11lx3YkY/Ys4N/PqzG/u0fFBiL2?=
 =?us-ascii?Q?9oUoSt79iy0jfiK4Xwh+g2524/7B0qVc9zECah9bILhcUNd/Bu6B/GfBC1Bg?=
 =?us-ascii?Q?7uOll1U2ArpZAVv2M5LMU3BsYGk2FeYKaJ02Dd7yIvBfO9LMZ9HF23sXGOKq?=
 =?us-ascii?Q?FaQzX3iGTi7lin375c/+Hlqd4HGqZX/rCDz/o5wRjMleNbJTY2ud9PEYwJqc?=
 =?us-ascii?Q?0dxx5qOPIrAPjulwFNsQy9/zewK6vD2+l+UkYDI9A9yBb2iinUKTG2B5x5sf?=
 =?us-ascii?Q?sgE+oYcauAbhK88vQTLJXYM7z93cmawqJ/IuQ/SSLnGIV+o1v0i4HtmAFxsK?=
 =?us-ascii?Q?DJs90kek3zNLXBY/6P3EbXefGD3QHqYNf9olOhE3ICxttHVWXG0lwuo7cS8H?=
 =?us-ascii?Q?7YgpkdUO17AOaDyVRRC1wjtTZB3bVEyjpz+vvW/zsNJoOblnhiVz/pNCO2p4?=
 =?us-ascii?Q?SL/o/dttQ3yXzAMxM6NzofIozpK7zrbyyPjKbC/F1pvZ8tkch+0FWoDjRIut?=
 =?us-ascii?Q?uBnlaO7LZlw61OsMNNYZTlQLKCdGQdZFZc0llVXfnEt8atxcGOS1942TnasK?=
 =?us-ascii?Q?0DI8mepZX7dSCdqqxBRLx31icGdV/wWPP9jU/iKRjLCVtiQo4rpSi+Eg7JkD?=
 =?us-ascii?Q?Dmohm0M3bsQy63QfSu050To2W1zWllkgWrrkVRWK3JWCpWBpE/fGoxnNwTqb?=
 =?us-ascii?Q?PjlVeDkV4fAWj9CrwdnjxXjXblanGu5HyLl7Ngz19rY1tzHbbQeKorAQQNCo?=
 =?us-ascii?Q?PS6nyMUnIOxX9l5n9gS5XSBclGC/JN0n8M+f7TpATbRWzJjXQT7AX+MmVLWE?=
 =?us-ascii?Q?xYovI00LkIZe4uujKpj2O1UuOVDRIewX08ZWTomtOpjRR2JdqF0Ei5Zhkj0t?=
 =?us-ascii?Q?JJZlS8QtvLp6nM/JvPtlR9e+O3rd251Lta08EE01GHbs+RNVmgsnF9awW6t8?=
 =?us-ascii?Q?hGap/otSs2+5dgT+utxl/OrlqC7CJdc4gdOaBNXiW25f5Z0fcpZUwedXMiVL?=
 =?us-ascii?Q?xzGgZI5MoSX+h6Hy/aLCt8GIgn3MwqlBCFaanU7bGmWSQe7JYR4wUaJnPsPC?=
 =?us-ascii?Q?+yl4C2gm6qtZ7EE7xdsiHKxZ2znc1n8av+OCRpNoYLdDUn9kdTh8RikTEc9e?=
 =?us-ascii?Q?c4JhxbdG8W9rPqAasNCJE4J3xlj0LJ89xnBHxB0KYnCInBdSrOs3g5IXFSl0?=
 =?us-ascii?Q?CaS/IC8i8EpgX3ONODZU8IH9WK3aVuVaA3m9lQ9xWZ17yk+XXphsIMWc+DdE?=
 =?us-ascii?Q?PDoNFtCc0SVfMzLko5me4HsPLjcdh26TVoQm7vuNhV9Op2nv4hWTSDw0RZ42?=
 =?us-ascii?Q?P0n3CHOv/xwefWT1lcsCBbV89S9Wr6mQaSErn0cHD5N76DdseMapQFLfZe7K?=
 =?us-ascii?Q?4N8ZfNoEo+A54bogszUj1Nw1+AR5bHowCi9Kvn6ri1DJAxnbTGwfu81CgZRt?=
 =?us-ascii?Q?8iiNmTiSd5VfemrsO5lhOSbkKAs/z4dv8sI7CZF3BNGb26NzPsSlb4RLCfpT?=
 =?us-ascii?Q?4xUsHYqUDGSRZA3g///29O6ApPb+ArMBINU2KRJIoLbtc7m5kp3UrmsRZxWP?=
 =?us-ascii?Q?z+rPC3oj4RK1FMqmPprve8eBH8yStrdNNRjwUI2hqv2zNAS8h0A5UmuyHt57?=
 =?us-ascii?Q?v8Gt6I003vwViAsrvp3j9x6aQaiKwODj3lMKm02ZUkuQ9t28rJgNbGZ5DvTH?=
 =?us-ascii?Q?cgoeSTkkIrmoC23lXG+1rT8abZuJLlRJ9RYu6RVknie0w8aQ30k7q8XKvCde?=
 =?us-ascii?Q?h2AuinMWHi+U95rGjEsJjwMXVD6YfoU=3D?=
X-Exchange-RoutingPolicyChecked: HHJmYf6nVpWnjXjGBuAAMZdXWLmcIbaAkMMGkNGSehLG7zgqpS1dWOqtfTCCSNdXqrS+IF0mJwsRmiupeKPj2ZOTypoOJ95ZrLHvclVAF71h+5WDB7Dbgby4SxARdUBMtcRBQadYH2eGYfkjctJo0K/1sGjQFTNMw8kVYGcpDy6Acpl5SoagxAwnoLK7XxOyai/rim1SdmHCceNK4AxofwsE1zi3n4GyGnJsCFpQr5KxK2EbDFFzDnUW5E3hlv4DMD3qhIjJuUG864tCwuPOH9JB6MQuY+QpBjxnQPgE3YVy+VPZl+5q1nq1lYWB8+vzbYFctCE+3ais8Dfe97wrsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c5d36-6718-4907-e188-08de9486d4ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 09:19:54.9207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3yi+vhzLOPKFqLYAyLAWktF2+H151ilnMLH8FC1A2aMpu60wcMeForOuf4PaRpiR7M+fYCcsR6TUePYT0vxlX9CgKlFm9SXDn/RQa+FxGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
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

On Fri, Apr 03, 2026 at 06:00:49PM +0000, bugzilla@dpdk.org wrote:
> http://bugs.dpdk.org/show_bug.cgi?id=1926
> 
>             Bug ID: 1926
>            Summary: QinQ strip not working on XL710
>            Product: DPDK
>            Version: unspecified
>           Hardware: All
>                 OS: All
>             Status: UNCONFIRMED
>           Severity: normal
>           Priority: Normal
>          Component: ethdev
>           Assignee: dev@dpdk.org
>           Reporter: dmarx@iol.unh.edu
>   Target Milestone: ---
> 
> Packets with a single 88a8 tag, and packets with 88a8 and 8100 tags, are not
> affected with qinq strip enabled:
> 

Is this using the i40e or the iavf driver? For iavf driver, these is a
patch already upstreamed to enable qinq strip [1].

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20260216142128.197050-1-anurag.mandal@intel.com/
