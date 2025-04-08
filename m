Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A153C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EECC40267;
	Tue,  8 Apr 2025 18:51:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E500F40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744131067; x=1775667067;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l+AwUrnQC0tOWhWTw9imxglV1G3WPyWB6nZb3vwxFr8=;
 b=b4Cqi7tWQJxDyBuPH0qzihWOP6LF9iAqDqejG1yug7yxDe2539ta2df/
 HIS2cTcT9Ntq6sMBrPm4EahDLgm0VDPXtK1xba5/BZG+oQQr7RSeDNJ4E
 laPZKwI9UmVxwX3yKr3HElGQmj0Zmt4oAgumRJfm6BXggv4zWRTzlnkR4
 p06XdamlDgDnZEfsDoJ7Nb7FGyL6CpEP8XTEJnUFld36N6zoQGoGC5eMr
 yfA6fs895GoMqHlqf7dEg3ocQhhI/kJtp6nKdOlWs1WU6J4siB5g8M0OZ
 ivRXTb7ZCZbKGsHCYz7cHyDQ2Gtzu67HQ5YG35cfV6YedLaXs52KcF5bi Q==;
X-CSE-ConnectionGUID: CmfHGXgSQoKrZI1SFmL9AA==
X-CSE-MsgGUID: G+YsWb5GRnG14iEpU+5rqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49374087"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="49374087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:51:06 -0700
X-CSE-ConnectionGUID: PjgSmp5kSjySz7QNe4+DsA==
X-CSE-MsgGUID: fb1bwzk7Tm6j/C5xPB3b8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="151512899"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2025 09:51:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 09:51:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:51:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTHvaCwvHwZuH8VmyAy8V3oUXtFTQA47LcSLF7komIZXOPl0QczhxWwKuEJsuFsWsPW4fsL4MCVcFakzpcflJYuHIdsnw795Z+BnmZXwqGq/D1D3KNzoDvP5iejzfe4wTYNyLSQi6B0CHLQbrLNRTw2+MynpZC4ymwzhsGnIDvYObGG+h5J+GY/0nMq5ZTbx15rF+vfNWynZf0sHOgiYlPHL1/3NKa3e3Z3HmKHHHuM+R4CUG3vJU4l76ZuxGfz1YyltGMyCqkjw/vBUI/Ncu7jNl+GdvA/ZRul+nh75oVZeRkgr80s4z5HNWVNS9nlhjo96qviBzBLSv2oi1FDMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0J9JG4xzGq1tRKFnbCim2FFqC6OyUCvCmYEuLMFgho=;
 b=PxA+q9xDUOT5GAIi40WzeEpHSR5vs+2f323WZ0vtCDOLsprvHV1F80nxo0ETAS6ZWgM32cU7I98+LKREE1P8G+7acJWV0WRyyBFGwXLtk/yQmb9NK5fKIYomlEn07ZijMeBL1WXr0CdHgI/M0p2Fp6BonwYyAhbDR2fhRMGHsOJ+Efeps9u3OvvFXJWEJQuGrwgq5+qV+gmYZRy414Xabm2T1cPc2IoHx0PAJjBmHQavj7GtEW0LAvLt7MBdeT12dSPI1nO50Dd4BRiKX72qpZDNDDzmgzmlRcnTBa6gjGsem/aGk17bHV5BdGrY9b16Tg2dxyRzABSo32hJjEPflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:51:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:51:03 +0000
Date: Tue, 8 Apr 2025 17:50:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 4/4] net/idpf: use common Tx free fn in idpf
Message-ID: <Z_VT8gUeqAMdlsLM@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
 <20250403112429.2741138-5-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403112429.2741138-5-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0262.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3ee80c-9843-4a8e-9236-08dd76bd8c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8rd/KkaGPoPHnFZzFPv74oV1RRU1IYYb0nOeTmbV8Z1CKhN2fZGMy0evKq9U?=
 =?us-ascii?Q?Jfk4hAKecnL69/5o/6ZIQG5kmjLGEWni/ZBpEia2NeFjQdTJSbD2W2EnxNty?=
 =?us-ascii?Q?DmxQDPBcPOfR85DYhak4WHQmINzr1lWXHd1IX92EB1LWr2RdryB+kvmQt/hg?=
 =?us-ascii?Q?OIE9DMwIpCnKQ2lj6wYvBh9oeGda0j+QnLjNbNicnxkMP1gQCWIYBmJd6+vh?=
 =?us-ascii?Q?E/bRyvshoDTg8cncNvb2WDvC604GVWvZ1TS5jgKwlJHvxIb7QXEc7r9Qjx5M?=
 =?us-ascii?Q?f6BMskNWZoG06fSHm+dq7ydfYYi4om5pr9Bp/4g1lpo4ySzcrPrWNBYxnt0m?=
 =?us-ascii?Q?o36LDscsTdf+dC/TR5cVezuIs18TJIbB1VPRVPpQ/ooDJAuf8VqGCB7NdcUf?=
 =?us-ascii?Q?JasHt54mfWJ2iWlpQ1R3JfFu5HqeU8rr3N3k6898KcNLG5VVuNPs+OWs+6Q/?=
 =?us-ascii?Q?3si0LaKzJoPIuS/8Xf4M5yBLUEW2zd7UYcoM8QHBJDSox27r1cKjq5PXzzj0?=
 =?us-ascii?Q?TOiKJYX14sepL8rw66v+hpcDJNisk9jTMBoAF/e8B1EV61mPYWw5ZPFrO1Qq?=
 =?us-ascii?Q?9tDtGKW8qKsPKZa1FMnRbQQrtfLJLTRNc1rXhEjAdqD6uUh5inUz15C73Cxt?=
 =?us-ascii?Q?ORUoI/NbICmW6wt7iIsuWIzopVJHptOx/T9RrNj0bfTaNps2jChF77DnVjp1?=
 =?us-ascii?Q?NyTSG1DP7SGmnYIb2uljAH1zoUVr+sZ9ez78Mo7lQBZtHslNFPM2BsW54iX2?=
 =?us-ascii?Q?8pKSns2KrqX5qyucs86FS7VXuV3AfyJwRpLKPmqod6kus0qWnJFxnwMmc71k?=
 =?us-ascii?Q?cOwM013P/dpHXUn66E8vV3S49nevFuHfDV7Nktl/pe65aCKSC9yy5CUHszZq?=
 =?us-ascii?Q?IXpCxDf+NMtb8OrTgvoF3wMpzUvAx9MW++lZnLDiOzwp5JwflcZNlLnn1Mfu?=
 =?us-ascii?Q?0IUKIKJXQ2kEY0pmCxnlhHcqRZTaVhzpcnJu8Woerrh6aI5zsOCZF9904Qxt?=
 =?us-ascii?Q?0HWXPUKm7LVVGgJmzt2lCOtiIi2UnDI7iuVxdxBPxNPGCZqSu11IF52lHHaf?=
 =?us-ascii?Q?BRYlYsNV4H1evQseWU1Slmyc4kdpdjQGaC0zi7YD9Sm0mB5o0bn2mIQtrBj2?=
 =?us-ascii?Q?TRz8D4iHzMBgclxJ/x6usgKMSMY99frjrV86CPS7Goohv002CDUQ0tgDesxx?=
 =?us-ascii?Q?HXKFn0oxsDfXJ0uL9rOf1MJjKB7M6HWSdwloU4OpmPMX4hxj4PM4S5kAn0Cq?=
 =?us-ascii?Q?NtK4JYmQ/K8m6mxtUcvZSTSss+gn65H2F9nne7gEgHJHz1pm1Py62gofWb7j?=
 =?us-ascii?Q?pFw9jrInO4omtDEF+cKNceXS2xRlWSGWLursqL3ZK7+YmMf3zM7KJL18ig2c?=
 =?us-ascii?Q?61+fGlpf87R+W6Jad/jRyEO00mnsJfZqbMkMiv/hhg/oIMNSYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQWUY0WQ41qDUq1Hr9rxv1vRYtRBVjzFmGpAmsR1PFhs7Nu/e5TGdXg8tvhH?=
 =?us-ascii?Q?1axQkLtf8MSLDcTgMbsgDjKJ0HAfVUAKx7NlhNE7zqkMwBoBKATQZPwVuz5/?=
 =?us-ascii?Q?M6DL8g7FxyZ0CRDhN7bh4p+VCaBe1NLqavQbxaLDHNqvz5Fdko1D5sO2qGEq?=
 =?us-ascii?Q?XO0mswxmheMHoz37hzgeSQO7B9L5mbCDz8JW9RyRIHadn5q0hDieDn8majjs?=
 =?us-ascii?Q?rNFFkzy7aCLWCBYfZ83zXz+Rf2wz6sGG3qGc3WaXNiTTOv80bt4GWzRkombB?=
 =?us-ascii?Q?haJgmORLXsm9Ugczrv2izSNV5tACoCkQfdwsJsBgg/2lIQlB9RGAYZKKOgP+?=
 =?us-ascii?Q?yrKQcu2D+H4up0PA86zJVbfofZ1sjgRGsqfCeJsN6SWwVFsl75nuU6IkXolr?=
 =?us-ascii?Q?x5rLlTOMtJwu75mjiqpfRniX9rRttKuOpCxhKaBYpiKv4IC2n26JoPtTProU?=
 =?us-ascii?Q?r6SEmL3KIcyzRTLe/QV3Y/OGgvSLoo2QUhpplzyFCWs9A6BX18P2/m7WjmmU?=
 =?us-ascii?Q?eqEMUUUzY/gsBd5BcJWZ05qNAlWHtuxkLdG9ZJXL93bAAc5H2gsYURXuvQz8?=
 =?us-ascii?Q?xTVgZuO3B1L7fzhvrP+TBp5BqE9LlhTpIiFXVRgDv8S40t+FKR5h697iRtMP?=
 =?us-ascii?Q?t++QOuQSbxx331VZMuvyBmq6RORkXhHBfZ2HGb8n2vcaKPTsPn/ElAF2jo8t?=
 =?us-ascii?Q?1gkvKiHERC0v4g6qF0cIzII2HUwIFxNWoT5tFt2pyFJnPBYMa9njqNTYdPE4?=
 =?us-ascii?Q?mHQd1/7QaZBK2V/Hba9k5hYjmLJLifBPfl7dYTW3lQauyEPytyNLdDupcy04?=
 =?us-ascii?Q?D2ixUUNyKDguofWUG5riYPvlt7q760a1GFDBIcdiAhpeG4yjo8z1N9p6/FHF?=
 =?us-ascii?Q?QGnOkNIoKqM1O9d6AaheTREVAkkv61K7vEreaio88xSag3VNUMU5+npsjM0p?=
 =?us-ascii?Q?HJ8cy1yuS8iwFNvldHAginX+7dLVmVdIn2qeW0TAK/hjUAnf/ofw3MSM09ag?=
 =?us-ascii?Q?Zb/fApuQofOJpKeA0Lt1lIMtBmPdCL3+IW3CK4vLAXitETlpOrmhhgsETD3i?=
 =?us-ascii?Q?mEjIDkRtBLY37C0GKluWWw8r6j4/33VuaDHsTFRrfbrFERJN85UJIlM71MqK?=
 =?us-ascii?Q?0IyZFe4oYO8Q/Q0Bxk8W3T5Wp/nxnW2gX2yo3GkPwcTjzsXLMp8g+4tbzeoc?=
 =?us-ascii?Q?5eLVvo1rv2XSZZzpQlfc/ivylO9PxxHlbnNkbE7FKAFSbH9tIIN3MvVjEa50?=
 =?us-ascii?Q?Vnqgpb8dphP7E9EWvI/1jlH9jbn5hlSK52ntNbJwAbdgJrQOy0ltC0GeCI1R?=
 =?us-ascii?Q?zEq4BF9rT8oNIvsYJRtx+aA1OZk6WYhNOeRZ4AscBslDw602K6jFDXP3RzjH?=
 =?us-ascii?Q?G8/zqg0cYNE/Pgn8X8U/O2wRbVL9/SDq29i8QVcS1SzGIjU+s2ZsnMj6DkiN?=
 =?us-ascii?Q?3VewUUJmdRuOEVKEhY9yRsHkytdsJ/xgSlZJbp4i3bpRKWIjEuDMns07cwPX?=
 =?us-ascii?Q?AJpSs2fCAf49rN4hbZJ2jKGLFXhCCFx5T0aXPjBLyTcoc7ffb5P6glGJKaNL?=
 =?us-ascii?Q?Vh9GCazHNsqQlfa/tXlP7mcf7jZLvji/Lrwo1eRRehr4l3siv8hV7t2KxeIW?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3ee80c-9843-4a8e-9236-08dd76bd8c55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:51:03.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgTMsa7ah3HSNoJEJFagdJ9nNdNzLk1R5cTu34ZigsR92dk0pNxoJFwPjiIUrgAHZBmn/RIFTUBm+TbyPSaBNh3VLCdkQ9TUE3No9q1DdYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
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

On Thu, Apr 03, 2025 at 04:54:29PM +0530, Shaiq Wani wrote:
> Switch the idpf driver to use the common Tx free function for
> AVX2 and AVX512
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  61 +----
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 230 +-----------------
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   8 +
>  3 files changed, 16 insertions(+), 283 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

