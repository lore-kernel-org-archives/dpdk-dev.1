Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACD4CD8CAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E632402BE;
	Tue,  9 Jun 2026 10:09:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1C075402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780992579; x=1812528579;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PnxXeDWxn6s7TQPDQbM2iAJyDUyp4b4I84bDkIVpUc0=;
 b=QjtpwNniFDCwA8saS3JFlIHwJTc9slden8NqQie4CYdGVqqEyBuOrJBQ
 a39oMW0Eo9Voy2lSo6u8pPv5cZV/47lhn2dkk293QMljCnKrso12TeS4i
 +mO5iTp5XrBwqLAuQNV84RTzJwnr9TBXvAUXcAyDfswM0LsPPeYgTWfoI
 7J13EDgDlPv80dFi24mUCllX4mGNj1V4lAbhNtlkbOOFdk0VkeziB28vE
 vfyVTSggFCcPh8Msfg/RCXWDnuOdTwoQfVYI45vq6rGzCb1HAQwYWVeg8
 dtExcE+Az/sekM/ggMN9R18bXZDQypGG+nzfmZq97+oUKlaeR93XvrCcv w==;
X-CSE-ConnectionGUID: w1e6uQSSTHW0qauokjf9Ew==
X-CSE-MsgGUID: cgMWxuoLRcO3OKtpAYvYnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93131300"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="93131300"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:09:38 -0700
X-CSE-ConnectionGUID: ukFRvv1MTNSSOZ34NQANAA==
X-CSE-MsgGUID: XIoVSCOvTviYhp+g9/fhMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="244640850"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:09:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:09:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 01:09:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:09:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTMJ9mHDd3UWnBBlX9ahRtfEYQSXViVAwnMXt5N5bWXmqDh1UAoisxKC37+A54l1Ov/2N2KkJOnHPKqWsOO+9T9uY720AyFR88KVEGR69leKuskQM1Lu7ryuN/7z9HHG2/Fh8MF+m0NZeUsikiBCCjUilK34NzClag4QaHbr9tBRqAFox1wTNY+yPn10DW4G4sxdtJ6fAZ3WQGflwmG/IbYEXPi6unz5vLjjfFAo4TWbNTYcdXl5+ckC6KN8CHliXHTABjyyfRK8R2owYofbOvIjageoHGacO1tNg+//GFTiyylPxO0StnfmnQ+X2xcKuqVqkyIeiBn9TS6e98iJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTUvHUs6uQ5o1pX8YafNaeqkrmpJkx3tfPRowmsKYoY=;
 b=fP96FDeKWEZOCaDt+NEsqAHEcfgQ5kkzVFodRXDYp7RLWA/wHu8EaGtGjUU6GM7/gXFSa73YFgVzZITdp3xmRc66SRNussDC3W/4JPEZwwrhmWsl+Bc1DS0ilugokTGgqZRdRwrvJP+ZQVZdUqfNK5s6R+SLbinKhuPhIJbtGrvcHc+D50SIdlnfE9Jks6vkwJcaq6Tk0GJd7LFz/ubGfONoLr7gY4XGazZQmIY0G3NsTeAlxP2AmQYabO4UaQLo/Qa2doxuL6gkPWilA+RtWlx9NbYXNdpeOk8MypLkwQYB9xIsgBW6mkVHxdVEkisoEkYJQic9kLJ6GjaOiNcFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5302.namprd11.prod.outlook.com (2603:10b6:208:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:09:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:09:35 +0000
Date: Tue, 9 Jun 2026 09:09:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/1] buildtools: remove absolute paths from pc file
Message-ID: <aifKOnqQRhJ4z3nh@bricha3-mobl1.ger.corp.intel.com>
References: <20260609043220.930405-1-syalavarthi@marvell.com>
 <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aifFFS9gvRn9JYKg@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d90fce2-d9a8-494c-8498-08dec5fe7195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099006|4143699003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: OUmiGyijJ+Ux0WDX3m8cJ9/WGFcHNujZSz75wIXJDBwyafO0YsLJiwNBaEQgjx+B6GI+aKvM0B9nloHSeoQnNb/KaBTng0ZsHwp3cAV4J81zQkTNgY6LC/gcEM/kC157lwoW8s/NTU+kHlEhFGqKY1N9SSQ+x4rMpCCGWItQbMV7Ya8/ZrSJJlkb76llEk8kvPgotnk+4HEqPNVY+MiB0RobWuYFjX9FKNS+Q9PKMfL1q29O+85SsQbz/QUcmq2vfzPuHOTvOuHzCnvJzAAABRccbawQlw0OC9K2d8cJInjOidW+UTB+jt1X+NoNxnXo/TvAz6bUyfEdxZ1p9XhKB4NdZsGDC7gLXQ1NaZ8uAb3HYB0qTkEL+bjY0vglerjHuJ02HgRlkpXBbFeiP1M1FcNvJ05fdmzkrNwokhJcv0VadGcX+APrWerHVjGsm05K2aUwksVjsBBq9xVbeSvyz0dm0yqUy08L4+JHFj1I63cDi/LzzjA3SWrP67kvBISIT+e8CqS8VVYPhqp3EeuvX/y+oC3rMxYwTpddbblzLrdUkmtLP5RdIauGtr3LSYL4nU+su91FYAw7tDzFm1HffQiPptNo/djwZFY6hJT4ur6kyEE7yPQBDh/WwdWtBpUkzaFtS+vW2psh4IhnXJuL/cFEnaJI95HaiKWBDlIzGOMxKF2dYXxx7KhhItbA0HW9Pcpn6Au1RD1Nz0rJ2Lqgiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLEOfUVyTgdIPL7Hj3Vw/6kfOUYQWdS8W6sbUJNlq18/F2oLgan0NMBb16LH?=
 =?us-ascii?Q?wy+gJhLGrier/ON5fu+ddiys+uPCjA0nN8OcC+osHKjN8HtcTT6IW6X2oEcb?=
 =?us-ascii?Q?OrUk2uVaJVHkxnRxuq/yBTTS0DuTMrZMC9CY+/2zBpOEvZPagky0qjpJf0s4?=
 =?us-ascii?Q?7MM/1HzcpnD8p5VLc6d+hGEW83b0x6f+ahcVSwWKjkfV3h39K7W277Uap+sK?=
 =?us-ascii?Q?hEB4gFJA1140o4DBDW5C9zmSsRkNReBOxHib5iurYl5XoBOZ+W2VTudhQX/U?=
 =?us-ascii?Q?4+p27rFlzMp9KS2Lkusri/AhAWwfuoE20g6CkYvGeY4TjB6u+R1nYq0ZPvdj?=
 =?us-ascii?Q?JrrYV00LWW94MSL7GAeK81C1a5wGLAMRJOn4MRffgqsdSA9khGFN7N4SmDhM?=
 =?us-ascii?Q?HA+DhMkomEFXSc+KZOLVhPsEVsT+6pRTL2snv24y1xsP211kGbFV1US4yK96?=
 =?us-ascii?Q?6ExJd8JoUSCd+gpx+N0Hu983n4SYZFf4RcXDsKsdzR/O3XFDeae86gL1egq2?=
 =?us-ascii?Q?gVGD+eWuEynheaPKhzkBh9jbWN2ZJCzZSN8g+859ZNFrdVgnarmMcyb1EKkX?=
 =?us-ascii?Q?EPS8nZlQwHwKykIs6rKzc0BD9ttPM6FpPj0a/ckI5YKpBzwBWg6BvCxsX2HR?=
 =?us-ascii?Q?9Zd7GdpU6jEW/SxUP/2ZTSYxUZ/9V3y7x4X7jXsu4b2fXVMUqhuwzJMKT2qN?=
 =?us-ascii?Q?2Xq2lLNmQ/ylByRgEpzj2/YW9intEABi564ZLT5SWLYxPvnTBjJjVu1FhG0L?=
 =?us-ascii?Q?DZu5PQEUyPStiDYXIHTul9eMXetL3+YZYXMgXsOHTSiIRy1MG5K+t0p6bq1s?=
 =?us-ascii?Q?0qB6Z75nXhga+qMQJDs86LjnychqAdWgzwX9YJLGq0xKNKE8/3QlvbCu7k+F?=
 =?us-ascii?Q?ybhA7jpcZ6ZRqyw9snbdSm94eVo45MarviWr0yu/RYNhFAaFG/b9YwsgPmh7?=
 =?us-ascii?Q?Tap3Bzt76tspFOn3V0miCxMHxqi0sdzepNvouc+gHdMXNNMESNYu+mWFJpYS?=
 =?us-ascii?Q?0quF1JCUY9M3x2q9ooC8mzQUdfovRxovjVR4vOaTmcF2SB9go8PszNnItbxt?=
 =?us-ascii?Q?oB4LFUvp/hYJoxDelGyvZ4RFn2NKp6ztojXfp09/J8MWbw4xY6ueZev+DyLI?=
 =?us-ascii?Q?OTaYlh5rchNOS1Qd13KXUKzPQwO1pN2D8YPFOLRKsTTGVj5ZavDTtG5o2SVq?=
 =?us-ascii?Q?yGqhYxZVLkIIBpTyd5bnfPtnOt4MIXGsThWxU4AKCSLzeCE87LXHzjRuRcGh?=
 =?us-ascii?Q?75aW1hwlxFedD/OtDTX68Hb6bL9ZcYpy74r8DFR+9Va/9WjasHB5hzrHv7IT?=
 =?us-ascii?Q?VIgwZXILlz593739gsiY9C2trnMSiFmnOzA30Exy12/WtVPJI638HCPHTpRx?=
 =?us-ascii?Q?0ofmlI/3fnLxra1SR8wUmpLiyKtxtbuAb+HAx80s9s99JTfMHo4Rp0PDj8e4?=
 =?us-ascii?Q?R6ALC2E8PgAK/6kRLB8wUjPJTiD6xWvgvSoAGWYIW9IvPjpwN2JIEbiuDBli?=
 =?us-ascii?Q?ZNVcfM9qVO/JW1ahKoIPFb8m+Woz8SHH7c8HjaGEMBirfwhdxnsUdNce4H+9?=
 =?us-ascii?Q?iNCwZSiA+MiDJ5YLvJU/SUcPeuo/LexAqY9LgntfHPltqkbrrE1ihR7aJ2Tl?=
 =?us-ascii?Q?icww28FAZd5DDuuqCPQGYZZnhDb/vuH+1ayfk1ATyNgHD/agEeu5AM3Su4uH?=
 =?us-ascii?Q?2kPKXnamFyKK9qsJec6TCpNQiHRUD4x6jOp5IWvsivHRI+JrNK2GmHyb/ay+?=
 =?us-ascii?Q?9yYwWGlVq6psJEG0FuLpvsEIBHWpJmc=3D?=
X-Exchange-RoutingPolicyChecked: bYHmkT32fuytaZ+7AhC4DcNQgi67+umuEfFOSRgHHEs2jlVZ2raJZcIX7GvHvYuxcbB8MGf6zZvcZ65XAidnaNifK6WOi8im1oMO1PZHxako1pufUNJpIE7O90AgKwXk/At+PyyLmxl9vD2PyLdfpuAx/Rck75ZzePOhwDLuUtkshAE9kW/UKIeHyJ0p2R0W/eFQeqwTcIFwPDwQ7gKJMLQ2RMT8iwM4g5a5fsafqNVVwMOBPxPOjTB94CZ+P9byhGFrAfaQCiaeTMs0FZTuwE5GQOGQxVWUqIM0IbXjuxZVwI1R6ez3AoeNcylZyMbFS3Av6B1xcbZsbu+74ypzYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d90fce2-d9a8-494c-8498-08dec5fe7195
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:09:35.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8TDBUFkcR25e099Soraqk+6cUz2yd0aD35smMOZUzLIr0go2lkFUUUN2BjNiYvt+RbIwO9LOUtyoWPCLkAZk6Bq6OrunuTTRHelA4bjpHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5302
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

On Tue, Jun 09, 2026 at 08:47:33AM +0100, Bruce Richardson wrote:
> On Tue, Jun 09, 2026 at 10:02:20AM +0530, Srikanth Yalavarthi wrote:
> > When linking with non-versioned libraries, absolute paths
> > of the libraries are added to libdpdk.pc. This patch replaces
> > the absolute path with correct linker flags, -l<libname>.
> > 
> 
> Do we need to check if we need a "-L" flag for some of these paths that are
> stripped?
> 
> > https://github.com/mesonbuild/meson/issues/7766
> > 
The bug report indicates that this issue only occurs for some libs which
are missing an SONAME. Checking the .pc files generated on my own system, I
don't see any libs listed with full paths. Out of interest, what libraries
are causing problems? (Alternative question - how can we reproduce this
issue to check the fix :-) )

Thanks,
/Bruce
