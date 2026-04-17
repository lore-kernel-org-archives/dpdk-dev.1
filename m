Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF9F43697
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 13:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF9AD402A7;
	Fri, 17 Apr 2026 15:00:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 10D4C402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 15:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776430806; x=1807966806;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+XIMHIq9ReyWOvVujjROaoPtsBaF5tS1FIbwzxXUMZI=;
 b=HfU5PlMgDKdOHvp1ciGMntCnTljvNEf5LkChRQWQxZEGvWBN3/Pel5hl
 0aKCZuIjwg5EuoZt2obUVg9wH9nt5SGKhyJrl6HSuCBT7FAXHbyAzzWS6
 +xtG/fsRwM55F0zPF8vHCsAyBdDQDtySNL/tCgn3rW33D71Jt8OP0ljjm
 OTz9pIV+uA20YONxmWwk+SvQ4LDd+zCBQF9W+QnnTFEtZ4MFJRZtCejfX
 JfKRX/QVcyEQeIhWKQunXfh1KuHpHlFqVuGMIeiYfqA8bsNoj08B8aQ96
 Y0+QE4fDkvFxFzx5uFom9+gknaRYwdnXzcPzVBMN5pQ+c1ohe1201YQ9i Q==;
X-CSE-ConnectionGUID: 2DvSCIhtS0O4l9qV1OYNDQ==
X-CSE-MsgGUID: j5vIUuAYSUWpNqiSouFVpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77454355"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77454355"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 06:00:04 -0700
X-CSE-ConnectionGUID: B9DiLqhrSjmtEaqtFw2auQ==
X-CSE-MsgGUID: VZe7WXrETiu2Bn5LrbbMBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="235024270"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 06:00:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:00:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 06:00:03 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 17 Apr 2026 06:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWs3+YPMha3u1CZ28o1bDCkWSG+CmxVvVret1ETGdMsljl9Jn4LnOv8vtx0ufwmTV1IWIO4tE+3F+IyZBvaVNH3P6F72mij+4tt7IXNEAiD4QRPq1DUgd+/oCVUp5KbW1HaNRmuBBaVcFc/zRb2zDVxgZ994tjr2kznJp0C/BsvArtrzvTpmPZUUis+x333FpMcFFJTJygR5k9Y68Zqwyoc0rc/WwMHMahGvf9fyrN6OJLP4Wqa/ueNFTCeITvEyme1A9RiJKhe1oEgauaLGKq2s1EK8DI74N6DsL9qEU4+uSWYIEIB4Oi2gaX/pfluv78R4PPLVs2T+A8YsgCtmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OZyxPUFFrlb38iT+bdQdt4SYWY6XnWiiO3hmeCsegA=;
 b=RLHLnWDwU8nTbkeR56kt+XlfQLRfUmyzQZYNov6QFmToNmzaveEg1LhrtZnY414xFdTRPu41Zfzam8YFl5vZMP0R45c94K18pvuC6+XGwDx7nmV1gnG6sVFSwuDPTYH9gKodHxxhNdGSEXc6vHElaJe+sZA4M/dIEIjbtbkB9vFePEhFzuRCua7RTCsAZ+ou3y4og6ipdiePxhVB9eF9Y/54fBo+5PR7lkhjDcOXXrT+xQ7fK2tOvkHO8vtZjRwYTAqnQfrrh36HNZuWpHSekGaZHz5RhpSJlmI+d58/tnT5+9+d7vJ3K5fd/Y+1pxd5t1BXOEHny4OnhlU7HNl4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 12:59:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:59:59 +0000
Date: Fri, 17 Apr 2026 13:59:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 2/3] net/iavf: add AVX2 context descriptor Tx paths
Message-ID: <aeIuyj5mGdEwI8Td@bricha3-mobl1.ger.corp.intel.com>
References: <20260417100804.1143121-1-ciara.loftus@intel.com>
 <20260417105610.1161242-1-ciara.loftus@intel.com>
 <20260417105610.1161242-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417105610.1161242-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc8f7c6-74a5-4f8c-2bac-08de9c813b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WebuGOiMeP/8Wr5pQTp6VVloUNDw2UVWkAf0cLg2rA4QqEI3uiAnL/GTIMarmMxD7wbhmtqEMrsV6ZU8Um13srk72pv341d5HiN2yIuPSz8+bDHLIpyfQGT86XDhYg+wRc33QlpjcReC6P/kGmtgDSL/wJXnyUHDgtS4F6MqkWY5FNFuCdIwUMCz9WhiffOkd4mgFDNrIrHpxFhxChhlStHa6/gp84O5zmN6JR22NNREHMyIUV7BPQ/2SZ6a2bVSPb7dZ94UJdNSU9zBh89hvT8CN5iG+kPvAi8mHgM8yowSYdj+V3CNWGQXC8iBkpT/p/tjSQEakxGMNG5N0xFryph//B5Hj5DrZ1z7Zh7bz1uUt8k2vHNqH41jP6d3GrMflY7P+ec6ULnr35ZPPNERqV0k/gpVldApGwAHq+PGqeFp214cJo2VhAXFng6saDDmaSWPpZ46+/lNFb0OcnktiteKnda+tzDOuM/Lbv70bMEbiRg/J1/Io7o+tQrLX7Vi0iJtnBUPJB2fUqtIgHfEq3dxWT9wuzPt4N9e5TAfjKx9r4YBeql8sy5uSM4eyUZ89HLu3juCVqg8LH5XobEIdM/CXX681p5jnk7BMaNcz6g43XmlSmRdHb68sonsnweYvALsUragSTXNJoCZi+7THZKyQkSnLabqxWmxJH68u7Ebigl0lXY+3inJemWmk8Yh/9MwKOsIFIRjObU/aYVshvD+FqxWEn29uSj9zLFEvCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgEzXnfgyTVbDCYg1m7ovtT84N3aEg6tJBAa1DWn9kS08RdvpdPd61bHV6VI?=
 =?us-ascii?Q?fYOMiq3hDQX3/c19ppiYuLW0z0FQ27KMTXRRVGKq3wef/UwibrivEAV4hjON?=
 =?us-ascii?Q?2Zt5QuDZi8Jwh0rbFU8iiAiEsLnA6WdP1pGEBIVzlarhYkm5QzkFK9tWupIH?=
 =?us-ascii?Q?ZROvAcSm/lWbVTbDXEwzmgegdvilwsbn82S8Lxz35DcjcSDjf1ttSmN3UMh7?=
 =?us-ascii?Q?au+3gHmPK2sMaA9Wceoqdl11XCSJldKcf2Xk8xut3RwEqzXbhB10S/6NMKfq?=
 =?us-ascii?Q?xCEA161gfnqTHYqRpC9iId2dcyY6gPSIr8HngabCz0kBEu4ASXpl7oMBCHrf?=
 =?us-ascii?Q?RXgQyO2gWb2EWwGjJJJHHLbjTPYQ6ZzTpwnB/NVT0CFMLYdihgeW1XjOl9FU?=
 =?us-ascii?Q?STAEH07wxH2b0GnoCCtp24cLaguN8Lz/kRzUIie7aXdoB+D6XILegNHzDOce?=
 =?us-ascii?Q?b4QnnqL3t3u476yODydfMuPhDfLrEZZZ2JVRevQuOCiq7NUys4mhpEHijYDn?=
 =?us-ascii?Q?qkC+kZPJISvblIZi7JDvyo4yonrsArg/+zMVN0WNMBEf+CQ4h4oeByL90/GM?=
 =?us-ascii?Q?zczvYCF/WFCm48VPZtZJ3t/a8D1lBPxXMCJ9f2X3BB2+ePHfph/0VJSgxTNu?=
 =?us-ascii?Q?o7qhmfmTOyLks2dJQDlShmX5eqBIl6atrbW7rdRlqsGFUYQ02T1MIoanqquL?=
 =?us-ascii?Q?uDr1m+/rK3Q/LnXk7+RVgSNmIsQSvegWQRmexUQBNxqUItIcig0iiPAUGzjP?=
 =?us-ascii?Q?CVSQssSno2vjfJuSIgQnltkiZygS1GcVto9U5mJSys/fZnk6K4LdLiNYKjSS?=
 =?us-ascii?Q?bcs7/xaYZ7T5aJDZ+uU4g3mXax096byUr5NXkRbfgzN19bUgGUdeY61T1636?=
 =?us-ascii?Q?sjH14lJyA8YndIbKKUMkySkl4GK8VjnjXw61cJcEYRTFkwLAn/DgsnX5Pu1t?=
 =?us-ascii?Q?VCXHB9DYua/cfn3vjZj2qkAFaKnTfVp+68wwVwcQ/s585ViRXCMOAT6FxMfV?=
 =?us-ascii?Q?28qBuIBvg1bmNXvlBQLUjg0gTc4oxqh5IH7HCVTTpTBT8Naqg6YPVoT+JH9b?=
 =?us-ascii?Q?Eq43yDdED65RPcA1trLndm+o269l9rcke9cSkopRSv0q/JGWK+mxxCymsOf2?=
 =?us-ascii?Q?VzUMEOgAEzunNdXqLnsJlbH0is9AaQvls/MiRGphUcP/BHe6t+XVZuisDFCD?=
 =?us-ascii?Q?UeXcdhvOh48On1qwb7U9nqRx5ehtSO2t/onnDQODZpZbBZghkTWTiBeFQiUn?=
 =?us-ascii?Q?cdjLnmfeFAlmjH6Qc1FMHXze6coMYWpT1/kicprKaali85kK5MK0IZNnigXs?=
 =?us-ascii?Q?QeGYA+U4E5ejhr+7A8vWk483CjLISEVMulymrGaQV56OQheKEcTP3yfsLtqY?=
 =?us-ascii?Q?pdhlRP5khyMBBKcH6UlWn3xDptunVqaw+I+JlRkaH8UXnN/EM7VCtew9IKTg?=
 =?us-ascii?Q?MiQ5jNYkPD0GPyIvnh32v0tPiHxq+wH4WjCG97/fFgQnOecgZ9UQ9Z/vRiUf?=
 =?us-ascii?Q?BLv/HEUGF6asM9/kxZbfsptwdQf9XCSYSHqAL2cDuKCly++8+tvOPPYLMXZ9?=
 =?us-ascii?Q?1/Lgwm8d6chSn7ebG95D6o9BaGyqs9rxFbmkkzv2T0RDKMpG9GPoCFWlqnWv?=
 =?us-ascii?Q?GAZlwGt2PpOMruN1DaSO5ZK3tu+umQ53ChlU44jqsK7PLWgA7CWP5JdwM4fM?=
 =?us-ascii?Q?vFS5HOHJ2aMNXurgN97j3/8gdFU4UNC1AmTeqSod6n0m0nSneYvmkRHATrOl?=
 =?us-ascii?Q?qVXhR6w73mKgn9xHSb0k14nN55KrJ0o=3D?=
X-Exchange-RoutingPolicyChecked: YuC59f0c1r+PKWt04ADsRvU4baZdQlQ5dv6LpbtfzTlnPdZwozl6xKAAxYgrd9KkNJoOuYsrgcF1gOzVtQl0lK3xZvTysNXtL0pbACOEmmsuBH8sNY+HPzGPq+ZYJ5XUlrliu9fNrbPw6y/ogZ8ikXkZI1HlN9Y9iXA72I10DDGFQ+EhaVn9iYk5hYXqPKVT7MUmyBLPqPuWzphtFxwdrch2aqja1qawFpCFiBLt1+9Ca6w/nKBNdVC2fAqzhpcSd2JkFn91/ah/mq4qThIUJXb/d7Q2EVTNbdTbOnYLlVBkKcfxF9UYIyNFrZQzsKDQFrx7pQddCSv6kGP0NXGxtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc8f7c6-74a5-4f8c-2bac-08de9c813b7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 12:59:59.7304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHCfBFroZRCnhduHeEXMkCaO8q+RaPyfyhK6drteGfqiFSBRjOOMu3A9xceb+Joipn3gHqo7kMh631MVkfr2xs8MQsznH048i6eLvQIV8/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
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

On Fri, Apr 17, 2026 at 10:56:09AM +0000, Ciara Loftus wrote:
> Prior to this commit the transmit paths implemented for AVX2 used the
> transmit descriptor only, making some offloads and features unavailable
> on the AVX2 path, like LLDP. Enable two new AVX2 transmit paths, both
> of which support using a context descriptor, one which performs offload
> and the other which does not.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
