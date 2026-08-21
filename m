Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D0C5DF97
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 16:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D034028C;
	Fri, 21 Aug 2026 18:24:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2C4E44027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 18:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787329472; x=1818865472;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1Vytl8b7ET6wRqYl4977lZjtGjoEqOt7cYAr2L5a+Nk=;
 b=UvPE84WGTyEnZWBDkLvuOX+kQj/9ZmoiPLKffyHFdc1DPOg3U+FXz9F2
 ft8u2/IwS3a87tmA3kiKabT8HSlYyXIAnXOUjpaios5Rz1eP8wTpZNO2T
 yG55+P+jvnVk07d5gM98N13WGZEp2OLlduTxgj+LMpjU4zSxkxac6J6wT
 mSWQwpzWuxFWY8slYi6DCWUpRgEk/eblA4ajkxMhQkkue4muayVnAPqtn
 GTovogWLIDAOOd48XjMooEjb5OdTwqbcNPRrEK2dtSxDR4xOtnotninef
 pV8/1YYHf+oEKhEoPmF3kj/k42jhpwagfkLPG58mDdfEZ2CHd0Ljz0SCP g==;
X-CSE-ConnectionGUID: KaN1ZwtESLeamz1/y3FS2g==
X-CSE-MsgGUID: Gs0l1zQ2RAm4gxrlYc34Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="113419846"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="113419846"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:24:31 -0700
X-CSE-ConnectionGUID: AyPEIqmMT7in8K9TteSWyw==
X-CSE-MsgGUID: ctZf43OdQYyERd6DN/XbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="266450365"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:24:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:24:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:24:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvvqvtqoIL8pCSEtyQAzCHlIfazZ9grR/Td0JvPtW4aQ6yI9Km3UkqqVPNEaCrek6tQP/LXEKqXU9hZFc6sKmu0GZTZACTz+0ytRW49hlKyywOswTBHbEBx7tGlscgCdV5RnAeM3H0rADXfp6dx21qfQqxGdTlhr29B1aquEE2uKjEZCdgbI9X/whzIXRMFSzWa6UHT0Ey8lLJ1ONfzm2lSpSM2p4hMqIRIJelv0PzrpyXRK8AbKDWeCO11W04OS3twJUDSCu2CZekXy6g8TF52uLoZH2yXodLf8M8KFbEsx0/NOSpUfr6nI6wlAVb14XtoxwqeyZH6EqWhaSyA1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ns8m61kZ5EVtZgXU+z/p9TozQ+TlNY0xAN6oLO5U+w=;
 b=JUKi7wYJGkzOu7YiMzIT7LgclR78+k6fzr1+GD29//tHBrBkhu+rk8fOrAotl1QtiA+yxzQ7hxJEXk3hs6XhaEBh41yvKbsAW2krMzIBQcQHb8iCKWB55yespxQ5JSj1A07echol0CWyLtYkoUfmWFV1sDGv6TcHNHj9k8+cy8uUU0ccA90xzbYeyP7/JQPmP6PmImt5EusM2y6ZCcIuIaP/GXz1FY6jHrUAdLfh7m14zliBumi3skAnXV9LjlxUGHW5NjN0OGVsAgmG95CoyHMRRh97Y5wg83IHOMHnDVfhZ7/eJseX+oxS93Sr5kgPEwFn1Rqx8RIPiwKBmqvUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:24:27 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 16:24:26 +0000
Date: Fri, 21 Aug 2026 17:24:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/i40e: move mutable fields out of RSS config
Message-ID: <aoh7tk6OboMP-uSY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787303683.git.anatoly.burakov@intel.com>
 <cover.1787303683.git.anatoly.burakov@intel.com>
 <ada10282c8e759aa45d303acd29bc75a5a0e2d10.1787303683.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ada10282c8e759aa45d303acd29bc75a5a0e2d10.1787303683.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 614bcf79-2edc-41d9-eef9-08deffa0ab1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KpU6qfL/mFt20kF2Btxvuavi2uTYaAkNqYKRhdEZQ2gMhX1iA04JCSv6Rb4mLdQaGchJqWYSf4Bx4+/u/Qj/+PWKAu9Tb/KiplYasF5w24KBQnBvoWtZICmAMAitWKhsVKHY8LeIqB4eASjWT2QAhUlEoAKnEODYn0W6LhScLNvMNK6EZYEo+JFBhCtPRdmoDa22L6NZXY7Nz+BM5w+WO0zx6qdUpEqWxahpMwisvynj4GwcwvZFJvb6F1cPDea+d4hI0bjE4dNfoP5/gvoz1v4S+W2QiAzN9fFUXam9HbqEQXB1+rJGGzV5/+PI6IhXq0u8u2fHnF+iXmrhykltpt798c04W5RMdXL0ky9MbFJpeIltPIapf9RBKnOaS4ovJd5kJhfzT4xsQdCK7HqX9RyibBK2gji331aPSrAlAxc8OEuZWIl/wWZXMD7Rlz2SgHtn3HHEvB5SwY9yjb+IgNZ4e+JNYpEUAh7tZ50PJ0rq+HWfB4oisEiVYD4/8FSteDougC5NtHujbwaQEmPIhfHmox7nCg+t4VPimrzfGujeRjiglEnZv4TpTTxHcELOW3/97xzZkqy2D+CEj5oXGxffXpyB96E7jp6jEQZsyrdL1kqeeeU35dW3w2nma8ay5VvjHrKU6LW/gKUXAQm+yq96Y6zgXclYmf6hrpfItr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vzqe5LsbWRj3PJDw02uB7oWhNG7YpZsSZR9p5DiEnyEX2KzPJuLYJN7bA1vB?=
 =?us-ascii?Q?xALTrTuL3ahDWWHtJQGB2RPIWFH/3v045e++3/QsurkF9DAI8Anu2SPZ0/eq?=
 =?us-ascii?Q?FHyKXrHvFZLLEvAjpowHzg4UOSOeEPfY7PsPdYqoQ1d5XxXNaVhcp/vUxByW?=
 =?us-ascii?Q?lgnJw66iNLeoLmr196ZcYdOeiIEALmxPjL0ZTUkmlDs5nhLjevPThzQk4GhW?=
 =?us-ascii?Q?muhN9k3mvTfH5EOlKakY0ddy041s1g72egUfKzqqPkMQ4BmYQH4yNkDX+yBS?=
 =?us-ascii?Q?Qpphxt0b3UER6eph9DQlhu8xausR3Gz5NkK8L/a+3g7LN1BVUwffASQ5TD+Q?=
 =?us-ascii?Q?KcE069IuVbzZw43smE8nlij/qKsTtK/LBljzsDR+8aIy20iIa7uAJSp6sdyd?=
 =?us-ascii?Q?LRKiC/+s2HcC7CQQuxyIT6YxuTrAC5BNg5GtHS6c4bs0o0L/MjfQBPI+tStJ?=
 =?us-ascii?Q?sRpLUOjgdJy3FH2ymcApE9n9CvuR7m0ONm1K0Gy2j/UZ5gItNCtoRVeE43dF?=
 =?us-ascii?Q?x8ICKryOSsAi/+nPkHl1lEE3eQtoypylROQJtue//JGIfQh4k9byCCTsKwFb?=
 =?us-ascii?Q?jvoAXBMgnP5F+t3Qq5CaSqE4DhT1FTYeG6Q+7JeB/JEm2PB4GfmKok+e/Vqb?=
 =?us-ascii?Q?KQrHD/yCh0/fukxyuZ281inj5b2I3HE1/OSQOFOoPhZBiedvmFPEngYRfqoI?=
 =?us-ascii?Q?w00OJ0/a51m3RN0g+5diZQzRdpPP3GiUukJBhmkyXJKV5O6EQRyaE/2OMJAN?=
 =?us-ascii?Q?E3NQD0EoEdWZujFcfhDNeRwPbiy/MFbRweGW6jdpJDDiNnz29mPhnzEZSXmB?=
 =?us-ascii?Q?JBwQ5V/lcu7c5ftsiyrKtnH1dPCLUNd9F0rZI8OWhl8jcJXyL7DFxs8BYSBd?=
 =?us-ascii?Q?l+p+UPaEhqGwlSUDirmt4xGWo3alf9nxsgmbK3UYUde6YIll44/TVGEf6N5c?=
 =?us-ascii?Q?A6233Y3Kgh6e3nGjV97rcc6aANzyYdCIRxFhgRcPJoFlK+/Z5PzP3UgbKkGY?=
 =?us-ascii?Q?nGtyGOQK3XTvDqkA8H+ILVWDJaIsqpNqq94C7ENPWwsy/zTVMT0SBnI0nPcp?=
 =?us-ascii?Q?kOchIsHiFsTzUphTCuPBW1It2JFI8dLiJTD8pMUZOKaA70L06DS5edSFly6g?=
 =?us-ascii?Q?u76MNp7yiK8nseMKTJSmwWkz+6BDDHMu54uXy8S9iaCCpkOnkZc14SXreCRr?=
 =?us-ascii?Q?md61Vxll9X8sHw3LI4mucc2ld/44NoZcNfe2z15ozCrM/pRKI+KugJXx+AHc?=
 =?us-ascii?Q?PxJyhZXwifrSlkpe3D+eu8FV+DMlyoy8uU10HdWfx2Qv5u9J4gYw5BTn8vGB?=
 =?us-ascii?Q?qNvA6oEaGSpJzOeCetyjTHDw5pSXsGtP8zGYasdtNsBSFLmP6rhd4fsn13Gx?=
 =?us-ascii?Q?69FtDigK49JGtSjA1R61wB7m6L0Xn6TfpQdDDp9yxE3Hhnnwertu9bEv7Y8t?=
 =?us-ascii?Q?GL03vJBFWKLPu2BbNEM4kYvTBoqueH/VsR/iUxol+xIxvnTwLlU0DjDEk5fy?=
 =?us-ascii?Q?ar9kVpQrgTny3F8M9N79PReV2KXq4xLQrROlBbRy/iT2eE5fj3hXlcRdxi/4?=
 =?us-ascii?Q?2gzCV77zHBuJXrwmkEaDh+1Agi/iAibpICDol5kDUKS8/p31HNV0KCa3cF3/?=
 =?us-ascii?Q?mD7b4l0Fxy7+XtEifRe9hhvWVWAXVbharjJskF0Za/ZeUG9AJz7BIthi/UWZ?=
 =?us-ascii?Q?3DavuSBRmWANYVI8e8HDFpYo4PDGOlhevyXCemaiZYRqe815eETPM4nzmgWo?=
 =?us-ascii?Q?scFTIK7+cKvPrl0ZNSCBzxuVlR/X04A=3D?=
X-Exchange-RoutingPolicyChecked: ZDJ+bsjleZSbblVyHkZtNwzdJXch5BGAY1Jgr9eZIg4kINQjpMrXQVHxicelfqIHDAFtvFXEAof2eMKmcVFU3jLjyxOEGmxJD12BIhxWIjkmWukOIoJgpgh0NobdPoWPQaktORTvEIt+h54APIQoe5KSYpmSbM86ZBO7oKDn2zyBrBAF5JBIlG+2lOzkcPK7jlu+5YR9hp4uLWmp91i8vQKOdyrTEy1br3KKZqc1hObwPFTcjSAc+N+zLk02GOCHHkwXwxImwZQxFUX3E91TH9tU4MCjVeRC3OjfEkUhOnDsRSQZZ562uqlDT9AbOrpinskVa6a6QmJrUb5hiffahg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 614bcf79-2edc-41d9-eef9-08deffa0ab1d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:24:26.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNWZ5q4A7KjndRYlUawv/ppP0+6cu9R4Cis5Wv0a/fVy8fp7Jv0KrndJZ2CI/qGs8mDC6A1sC0qfnoYl39K6YYcDy+qhsMVwUn/MKPb+K7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
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

On Fri, Aug 21, 2026 at 10:15:31AM +0100, Anatoly Burakov wrote:
> Currently, the RSS filter configuration structure contains both data that
> is received from rte_flow API call, as well as some metadata for internal
> use (to decide on whether to reset the RSS configuration when removing the
> flow).
> 
> To separate these, move the metadata out of RSS configuration into a
> separate structure stored in RSS filter node.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.h |  7 +++
>  drivers/net/intel/i40e/i40e_hash.c   | 86 ++++++++++++++--------------
>  2 files changed, 50 insertions(+), 43 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
