Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFEEC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEEDA40649;
	Wed, 26 Mar 2025 17:22:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 870FC402CD;
 Wed, 26 Mar 2025 17:22:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743006135; x=1774542135;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NigcC7vaZp98aEctS497kmlLNxkMKW7j1wdFfl2ILv0=;
 b=kDX1baDO4u/5nS0szNI823NatNWpM6KlfGTjWN8aLvNl2V8Qnjvigcgw
 CGp9f3vCyYDbRRd2zzZu3DaDFcrzAQqU8BTKvbaAgkUAkql8iGG59lJ3+
 U5AYmFu/Ptr7PaOi11l8F6VL5lB1riJYip04EI7FSfAlGGZNIErPq7oOj
 25uFh+UsCtuoJRiPvbR1KhLOAkwhQTphdAEKOXHAfr0mrgwMQ7MyHXqtz
 n2bT+zvR9opxpjGYzzdcaaWK5E78pyIVcj+AEjLeoOxu+5X9m03Npgf0c
 OyUt1L10LqT89hQwN05bHzQ5pm8Zp1ZoYlBwEmJu2CdlyoV42DL/PJdSl w==;
X-CSE-ConnectionGUID: cD0+DnnwRiO5mVprK3oCRg==
X-CSE-MsgGUID: sYVo1pzIRoWfO4CHEE+LAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="31910929"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="31910929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:22:02 -0700
X-CSE-ConnectionGUID: 3558uV5lRiiuxy11kT4l8A==
X-CSE-MsgGUID: F1s+vmJvSPSByJN4Fwt57g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="129862233"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:22:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 09:22:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 09:22:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 09:22:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYBb2KmuoWtRc6CQsTFWfylECpFn7Ejh+V6RMdYNLx+tgmqpBhBpJLyHLIrY/Saxc2UIpr1KCbOzg6O6RB4sp0/c6KiLCY9tLkVu6Hx2KQQc2QQ7dAzCiVnj1/zp17CTKt6afCcQc5VFMvw/dJ1fNBH9pU/XyjzusdKxGm2QqQ/9bsCMcqknE7VI8iwCFa5Zmmje+u2E72vLL7sI3VW4u3I9TmLLQSexmAXSyc0cV2TPFS/BZpOMk78BUUiC6lPXiip6nWvbAZ6pSCaKZBY5q9tpApYwPrOAtqxs7cJ+UWKCWlqc89DvQOj2MlmrsFBF7o3xYVWJ+/Mn6u7bzahCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo9NkkMor8ZIG3uqrRbrwg5kNMXPJNisuSHBuq/GkvU=;
 b=jg5L9CIHoQZ8jfT4/9IwILK3keqTaeY5pmtOcuCZaPPtdB1xDaPkVfp7kEk5t/RSCdzhPYPxxi4gEDHPeFltbFTR5ekcK8u6wZXYA6bRxsNh95eN9ZUZqyr4QKQauSEN2pFl0lvjTgN+yCFfFq963GcQFyYIh5HYimX+IkR8PqKATBMkPB+wOlHGID8LgJWWA/MfkIpPTR0rgbL0JSbytzyY9UB7xETCoHqUgdVYMPrTSKRbr6QtpbB4DHN68qUQ/+r03D8Yh0VFrOh2RQuqwSOCbF5uQ/m3+cG+OTN+x73REKW1YkJsGO8xT2LqehdTIPLSF/xxX1BNRgss3ghSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:21:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 16:21:59 +0000
Date: Wed, 26 Mar 2025 16:21:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <techboard@dpdk.org>
Subject: Re: [RFC PATCH] build: reduce use of AVX compiler flags
Message-ID: <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250325172215.3360590-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0315.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fb884d-e565-4460-546f-08dd6c82555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WHYuCypzA4vURnnUTUbwJKFZKrxQiytKlcdALgW0nZfmm8quib5qtA3HUzzZ?=
 =?us-ascii?Q?O7oDnmOlaF4L2tRvo1SGt3HcfRNh0D9+JbGI+qBzITGWH+5DaAUX99WSgu92?=
 =?us-ascii?Q?1YBtnZIRE0d0FC73WG3qvGHSn5yPj+4DMy4nucPkYl7X3A30ZfvOjmbx6rNI?=
 =?us-ascii?Q?CY6zdJXuYgNKyZ5j3VSn453/0ktGX34xdeKCBb4TwYGnQDUuX1rf3xlKF1Ng?=
 =?us-ascii?Q?IQIRw44zPgzXShJ21YyWLV+b6SHo15DGCDNqohVXnPjX7R9WstA6jSLbk0dZ?=
 =?us-ascii?Q?9mwssxNYT1LT7YN7y3RKLBloPaApFAEAGy6Oqz3YpI8TxsjDIyT6sXBc9fEz?=
 =?us-ascii?Q?mvQeHeqjhjJqb+QhymNlNCy0vcluWRZ/HzfnKrWM7Q0gjAvGGZL8DICcqEn4?=
 =?us-ascii?Q?tgS+M/CjLXP4GseERNPDdijL9Rjsp4pZwNSsBgjQ9LcZq0WDBMokbSmPQ2lO?=
 =?us-ascii?Q?IH9cBA50cUIvWpaTRi7ykueq2Uus6whUAOFmhavMH3Y+8VBowaejACBDL8wn?=
 =?us-ascii?Q?2zAedCwJmtQboWRHgfa+lG1rZv36MyIDUyqr5Wm/cWW8qWWyGAGYH0iyqCo8?=
 =?us-ascii?Q?mkMKTG7kwe8P31RQJeJukyoDTnbgMgWAbORwZf+yfUXW3BZUJGZYJk7j6hGi?=
 =?us-ascii?Q?e7wv+WJ0Og/qft4Xik+XzeaXU0kWuk7KIbPGUd7qj9iK8l+doxWt3ufukARv?=
 =?us-ascii?Q?CsCnme+2Uyur+mrHgVBfgA8YWbLT8iTq1HJVn2BOGmZZK1hXRSD1vZgdjqiM?=
 =?us-ascii?Q?8bHcDwF368b+9IwWG95/zLCbHz5oHJ8LPcCEH/I2t7N/zspyLhZyaERw9hx9?=
 =?us-ascii?Q?4wtwSU8leWd3Kc0+nBIAifplw7CwJeTREsTVGEoTgFeuPwUuGhJG6dH9UUck?=
 =?us-ascii?Q?UjWKOjeOHpJcyvY3Nn02oL01BISlq3VyfHSqJQEcAMqQkkCpmAu8p2nLrf8Z?=
 =?us-ascii?Q?NITdC4v53namAch/6jWAx1WapLdp0lUPi+I0IbJzLoc6AXEONfJBAG3BZa3I?=
 =?us-ascii?Q?jCkiTNLvagYl7kkhlWge/O+vwtaYjLb6BkgSHXYDw3HBg3vrNzFrNllOhsqB?=
 =?us-ascii?Q?iMxmyxMaMjpcHoGSpvLff2MkWuehrq1DSn8bAzFWPENc1YjnuZqr2g5m7pnX?=
 =?us-ascii?Q?EKdHn1B8hul9y2SMdxjeruOwk8usRaYgoine34SdupMul0bMR/RKRER5RO+N?=
 =?us-ascii?Q?1IOmN7XK8WTmdTx+RZBwEayfcEK/6NusZ95kGtEswI1ROAYWKWC/cm0WB4NX?=
 =?us-ascii?Q?nEFxB3cOdzqROkxh3R1JsgtBk98aL7tkhuia5vbBp3unM6lsk1bc1X20oM/S?=
 =?us-ascii?Q?1BC3ZteK/SZudO+uOitwlqoU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMzdRoyrFBUtqX7/mz6GWdv4FIn+fikqAoAwnN99qQmoeFZ/iWHUxMSkDPof?=
 =?us-ascii?Q?6IeWQprjPX2PFtoWIfSmpGTzGo7e8ApIxHSUwg0uorZIgRKm8b3RDroyOMt0?=
 =?us-ascii?Q?GxCnMxEnTD026n81Ww8fdqOx802WL4Oq/T0A0ULmAo+Acd+h8oCWdyg8D3RV?=
 =?us-ascii?Q?GMVCURj6/cX3B9tMPIWN+qIhYYfiZKkca5AozqQUdcJI6qFgoR2N+3BD2KEG?=
 =?us-ascii?Q?MtuirrdOT5Hq8ahTq+sBnIdHZtP6F2S9Q/4Ip8K2UegzLeg5GLOifi+gdhfF?=
 =?us-ascii?Q?po7/mK+3EpVHplBYSQdZgJOJnneN2K+lmVmcIQZ3zkP848ijW/fWTH5QBfUW?=
 =?us-ascii?Q?RAyqGqVpNCi/IPvDwhRh2oc5NgSnmVFUCPorU1JPgmXQVVWhL/YU4DYjY0GZ?=
 =?us-ascii?Q?FQq+vnCx/2r/PzC7yqci0RJOj1AyaBXLFJ7y2uQmHNk4IHwZcpRtuufqIkPv?=
 =?us-ascii?Q?gqm3sz7KBuKa9YEpkS97EgUE57sJKHZDAKgSMQDZ9TjFN5y75PAKCjSjjA8x?=
 =?us-ascii?Q?Y+ektlHngzY7hUvtuMc0kWfnY6Xdk9SlRVflZ3EtjDABgmEnuZoyavA8UT/U?=
 =?us-ascii?Q?rX0B4EABzpwmoTf4GLiByetd6bNi21losj+8wNl+fZV0gVQRCTHEAPaJSHo+?=
 =?us-ascii?Q?YC79TgsnR73NqWopFMuP7fLyGgORPeqaCHgY7sfpKKvFycyVgMpAkAPfu9Vc?=
 =?us-ascii?Q?rlotRvZqi8EY/rzvxhFJ1kYAOThNPDShSV8ExPifPVJ5sLS3k0Vn+S7jrxbm?=
 =?us-ascii?Q?mxaBBQJbNCtq2gOygt/ZIV7jaYWzyKO3cTH8onT3APXzjBoBV2/I1I9UNEmb?=
 =?us-ascii?Q?O0VJY7d+bxMGzwt7/6KGJBOP2P1gmCXF/47LrsiTpVyxlXs/do0mDlYH8jL4?=
 =?us-ascii?Q?fku3Wa47mQBrIs/+xBW6Jz1b/EHdJjnEEBo7nzGTFZA97xpXdvyRLVt5XiH1?=
 =?us-ascii?Q?TizWUnOy47SHwz6Pbr1S7z1U/wbhMDwbATo3J9EpfyD8zWZnLlCL765lRe4D?=
 =?us-ascii?Q?2WzcXMFTfu/y8JkdVb/iOIGfl1QGow/eNkaRJUAAkp5p6SRffRaE/jP44O+Y?=
 =?us-ascii?Q?daLxy4/DkIm3OVu5SeFCrCACbHi/tve/CEVNUH7tvhdquMdTSXcJsaiehFie?=
 =?us-ascii?Q?EWcf7hhfh1C3g+js+XMzXTxWQvWgUMXH9jg3tFfgK8dV7LbTeFVpbC6Yl8mD?=
 =?us-ascii?Q?DSMoIc0rlbvlzvV3hZk9x1tjereF67cLjB3wJoTozgIRRhiHfEQfIR4gtjD3?=
 =?us-ascii?Q?ai3KzSREdTxTY+ru1Kk9RJSdFd7eNVONbcfeuXX7QITL3GeSZ3Bcf1FzK9yw?=
 =?us-ascii?Q?79k2A2qx14xTLtspyYPDE5z+iH8GZ3bgsMjqBJyaOSohuThIOO+0Ik+R7vnB?=
 =?us-ascii?Q?889RVfLtW0PUCbOFBTvfX2mOWXS7K/I0/+du8kKB1a7fw1d4l6iUnHOhRAZf?=
 =?us-ascii?Q?UToOZVVsSngACndLBKcs5RLK9A5LFSODB5Z5h1U+yjW5ZD6P52auTgGT9c5y?=
 =?us-ascii?Q?8F/x6QU2sezTSEKOdspBv6VHD88g4Ys14/QPSt3IDHPqKvb+VJ5GaehJzAmN?=
 =?us-ascii?Q?k03OE1PWBHq13Mlz5A9IxLacqLmH1MG3HLtL+cYYx/H+yracWOsnHKvZHqgj?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fb884d-e565-4460-546f-08dd6c82555b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:21:59.2964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjSVS6yzIEaTTEcb65C6OmKAA7TXJCPBLK07Fi+iWRgIU6C2OVcx3ITL+HHvqC0zx3JSpq4EjiE7KQHQzVnQ+Br7HdI8VMl4Jx8sDi2zBWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
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

On Tue, Mar 25, 2025 at 05:22:15PM +0000, Bruce Richardson wrote:
> When doing a build for a target that already has the instruction sets
> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
> the default flags produce the desired output, just use them unmodified.
> 
> Depends-on: series-34915 ("remove component-specific logic for AVX builds")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> This patchset depends on the previous AVX rework. However, sending it
> separately as a new RFC because it effectively increases the minimum
> compiler versions needed for x86 builds - from GCC 5 to 6, and
> Clang 3.6 to 3.9.
> 
> For now, I've just documented that as an additional note in the GSG that
> these versions are recommended, but it would be simpler if we could just
> set them as the required minimum baseline (at least in the docs).
> 
> Feedback on these compiler version requirements welcome.
>

+techboard

Ping for a little bit of feedback for this. Are we ok to bump the minimum
compiler versions as described above, or will I continue with the approach
in this RFC of keeping the minimum and just recommending the higher
versions for x86 platforms?

For reference GCC 6.1 was released April 2016[1], and, Clang 3.9 was
released Sept 2016[2]

/Bruce

[1] https://gcc.gnu.org/gcc-6/
[2] https://releases.llvm.org/
