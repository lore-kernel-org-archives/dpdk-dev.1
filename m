Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E1C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 14:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3862A40DCE;
	Tue, 24 Jun 2025 16:16:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2DCEE4026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 16:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750774605; x=1782310605;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=EZk2sgFvYn8LKsxorgtQ0EfjU11BI1w/BWLX7Mv7vF4=;
 b=YluTaNzzU8K/LQrw/zs7RYDDQ2LE/vPuLvxqYsE0QcH1qaSji75DK/jA
 SN8lzLksxNbZBUDl4gY/G03q+mQ8froCEFdTjJkbDOozs+VijxASlnyFY
 Z4oZ4pwNJEQceeob/DrWWzhb0Suk3IMNlZm/MFDCJTHO4U+EHWj31YJZw
 lzUvCmd1zlkzVkOhqD/MXh+F0hav2DvzrrNFWwSG8ZAhG7TZTIEIEmr25
 creF4fHu2l4QTYsBagvtci/ON9p3aNgHSr6iUEYVUM7oAr9291ZOhm5O7
 YDkF9VwmEcObVY+DZCXsCZ7iKcj+6xwX0IjS3EIXRxKqNTCi+CmlmUIbI A==;
X-CSE-ConnectionGUID: YAt1yMWyTsmfY/eH8sBfIw==
X-CSE-MsgGUID: bt80kTaWSdyxqoQ2xiwPyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="55644880"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="55644880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 07:16:44 -0700
X-CSE-ConnectionGUID: 1InViXM4S9eWATv9phN1/Q==
X-CSE-MsgGUID: Kc04aJSyS8SJaa/pEKWspQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="182965580"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 07:16:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:16:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 07:16:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 07:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9sMr5HisKLFK9tlefVivpq0A4RAmlWdbISHCI/e1g2r54ZbG72MTxFZXHCxKjTENVMETZm9laZY/cOZZuybtHCKbYblSXmN66IqOW0+Jy0BFUIvXa/RIOXgaU5XphijTzrJtHPegcVcBNfZJeOi7nFePo9YVJ9qWvbfUcoV4LdZCqeRQXI2zmb3xd5HVAAVuHI7F8H6iJCBvgr/otjKKqKSOMUOalgyrv8uDspThgnHaYznXoZH4suWuZesh2HMWmhA06BEwY4NBzPqdRnhUecuApMwFLL/+IZEv3D3aW3hsJfwZ4I5CXXr4eiGWJfBu+o/DGBPoZLlJtFcIIF2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmK7jeDp094odEQhjtXP72Sx4J0rrJzu3BFd9XGlSNc=;
 b=APW0zCnjzJRJ6VAmqsyIeRySmYKmpDksKZIiUae9jOfaji/LDQy+3xk0POqChRvG4c4KtUgwaW0M74pLJ+nWxF1AnsZnDibM/oiWzHjplDySfc+qXZTdDEjbYcAeZzaoODm4uSIJKJcT8fZIuWWyxjxF7+Ky0Ht0xi67735a3m9iX4eQxTbmqzjXMyds2JYojmHVRuO11Q82wuPbagvYneQA9n57qGGiKbpJYfkplrJqxT2GHzVqKFsdREtTWuBt98Bk0CX+cYhZt2GT9mnSet7RZpvaRRGFNtzzSd5MW0Hyt+pq1g4Th4lee9s9XrsF1MOlrRdKfVoEJlScXY8jlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 14:16:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 14:16:13 +0000
Date: Tue, 24 Jun 2025 15:16:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH 0/3] argparse: improve handling of multi-instance args
Message-ID: <aFqzKPh9xpuPYB3_@bricha3-mobl1.ger.corp.intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616104944.3425929-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DBBPR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d6ef86-472f-4bf7-287d-08ddb329acc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfRiz5B6mhV8e9qjsqENPhiNDWYfYJLLwv9VGdStgK27HJbr9FiLu5AY0R2b?=
 =?us-ascii?Q?cfmxwnfdmiFjTg4CZU/duZug18PJ/s6CYn5scpseZeeBwj4/gUKBEwYUcqhL?=
 =?us-ascii?Q?Kx1Sh7XV/eO0xLNEyRwKBVLsNrhOLbLVTUE2bfSO6JA85yeSyN0+iJXqcUrR?=
 =?us-ascii?Q?0YEm2ljVLT22YV1WzlVqjz9zoa60qB9UJK5S7k2uw6m71JeZPo0gbwShk6wI?=
 =?us-ascii?Q?tiygDFRaCRvj3Xtw+WHu958Uwzk0YJtCQ/k8E69D9jCGqTw50uZXDePoxFDd?=
 =?us-ascii?Q?i2Z5natIudHMoEy4nmJescq9xdiAva6fXSUXT7mlFkPRdu+xTNMuSb+8/Yrs?=
 =?us-ascii?Q?wdZJ0FrVTPE3a42ykc7iUSIO3uqlY/LXuJ5gWM/0EFOeE34Y297G0MkhcScq?=
 =?us-ascii?Q?tfUb1gVNly6AoRrZ5LGWn4eax91emNznOd3nDgSZLm1YwCaXFYZf+TsUi3rT?=
 =?us-ascii?Q?34fRPGNrkq6YnYnwqTvAPSjTnQ89KmaCRA25zkef9ngl5YnV20Div237/4t1?=
 =?us-ascii?Q?OoFlJ+8mbxWVZ9cimO9lRuadUKR38yLPqORQj8GHMP7JSZd2NJEUKDot1OMp?=
 =?us-ascii?Q?t3+nG0hs8/tAObaJpUaBDXxgzYd2yUvMWnAcToJ3fTu1CfvSu+6XY9pVH71B?=
 =?us-ascii?Q?O8/EGP6kYYlYtLIvtVK2AZR1yzteD19WVtkWh47QIvMPlJjk1by2uSHx5F7P?=
 =?us-ascii?Q?2gsbKgcLSNKPoshQj/FDLgfszVZJ7ks/zIpIWph1jE3sgo302Z1Jkvv9+cO0?=
 =?us-ascii?Q?OwlXcLJyh1adLSU5BZgSu9Pm+K+j6rhDulG10m+YjTknsLJDbrmx7mwwhIep?=
 =?us-ascii?Q?/ucevl1Uq0q+SY6fv01UdlkhAQOitDdKkgmYyTruZ5CasRIt+YhKxqsrZMMt?=
 =?us-ascii?Q?inXjIUGRccEboD9e9qm2WaKidykyTvJjORgWSOhbuZRseg/HLeJgUyhQgx8e?=
 =?us-ascii?Q?uz4TIncwrb15JO+CsLoqsESVzBvp8AMVapPUjQhOvAU0Jt3WenM1jVgOZ9mE?=
 =?us-ascii?Q?vxSHIp2hIKYC0IzHBuG7EHWybQdyK+oZRf7Aeoy+Ys7k7kHIOw5nqrCviE21?=
 =?us-ascii?Q?CqssLiDoVXMKrpADU5jhFzBmKFU8aDMEn14DMlI7oJM6gwm0lxegwmAJfCyI?=
 =?us-ascii?Q?hvLBLkKksFUDLS7RKLeOn5RPy/u99VljO6LBx/UY1xTcuP3CIHdHRihXh9TB?=
 =?us-ascii?Q?eE/hksK/INvDvHzwhVcTMKZ247w87/sd4mmvJmYmyAhxVyy2xuP9df4+UOsq?=
 =?us-ascii?Q?BEDsqqeKexzc9uJoGE7zaaHwkuUEl9Y/UymuiSxkXGOP4D7IUbIHZ5d8DMc3?=
 =?us-ascii?Q?7BkqfgvEpwJhjben6dxgXCYgASFf0sIgTJEKSQA5shH59O3V3bVEuBKQMCel?=
 =?us-ascii?Q?57VCCazg9atQsbVfFYi7rlqngeCPmYkwPLSuWkZ4ZCX01becIVALHiKHAh+Z?=
 =?us-ascii?Q?NSFf3KZUi5A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zl0arozfxilNoIyqw4bMuw77DdktmxfyEO1srgQ0aYAzXgEl9EE3f1rMhI1l?=
 =?us-ascii?Q?xMlSGqgu6347F50x8XcrlsUSfQXxhTfI73YayP8CNJ3huDNTsSzctaSxjKB5?=
 =?us-ascii?Q?cTKURmr+UrSNKkPrZsBA9Iw/uvO2tWC+h7J+v0UC4N9gF3D8wFhAhqG1brXh?=
 =?us-ascii?Q?FMdlxqCKak3EflCTwToofqznzZvGClTOxpzjd2dwaj+++u3lS9U+TbBV2itO?=
 =?us-ascii?Q?cHGgJYYwAuuQjLLTtPH+7A14GxHxLZS1yvMROaYFhr2eWItY+Ebs+rvzqv/N?=
 =?us-ascii?Q?38zbMAji3W3UtIM24F7fNxdvb3hj8eFkgP6fsi81w6WGG4K7PEk71v2M2JW8?=
 =?us-ascii?Q?Mh21zFIZK0/fhwGckYkqVNm8SdSRi4VmfgsLDwhklEG/kUZMunIHMcWNZ0VI?=
 =?us-ascii?Q?0gffSG89RjKmdTX2uC+PkFdv6XUT22R5rMYsLme2aqXkKPlsQ6D8cXkDQv5k?=
 =?us-ascii?Q?nFiFyoSEPeSiCPgVSfKk8JLKbn56qYFBDE55sBmo9C3ADop8u/E1kNvAKMlZ?=
 =?us-ascii?Q?rEzlLxnzXULHdtnIeo7dPaGeewpVxqMUkKDAIDaTJuSBKx2fUzLzARgYDoRv?=
 =?us-ascii?Q?XJo3TMVnPMmqZz0N6elbSSwPfRfW8TusnLxgShnB/qUYf04Gl59VzTnLpMCo?=
 =?us-ascii?Q?+WqR1N3QuN1JTuqzOsx9MOxmljyPllCRywoQD1ITFIFXiBkfllZrnLY32CGg?=
 =?us-ascii?Q?z7R5ETTvJ8uA1R6ifojX4szfjdq61WxV2XUWartjAc9GeRDmHSSID6ImH2qh?=
 =?us-ascii?Q?jkNY4q8+G5n4G7tghwxwoc4Iq3BKQFkMfBENxrvJazxOPkrnieuQzs9+m7d7?=
 =?us-ascii?Q?H6x2MQz6RWsUC5FBg2hnrZN/gOEjrEW5rieK3Gb3gT51+xgAmGbRyRLKl0Fc?=
 =?us-ascii?Q?fqyIOkCn59K18cH/MsCsbLMmQjMg6EKqC+kwr0jFrzqkRXWMgMyBKNcCx/i+?=
 =?us-ascii?Q?NNrtUhEip1LwDZ+2X8f3Fd0LOZzNX9Z0Px1vyvwDzZU0dMXNCz7T0ytvynza?=
 =?us-ascii?Q?OoYnTOW+Piz+RkMLDNK8IJhXE32gs6YEB3Uzv4f5CgzetVNK2K505OMM5UGB?=
 =?us-ascii?Q?TFOvOkVFCUiEHsR/CHsD9cbXmZhgP+P9ybv34UPkBI+xVUpmVx0mO5CbfTEf?=
 =?us-ascii?Q?zQsa58dzylzrcynsWpbbuveBgKr05HJ/po0eUisCZsJJ2Irls4NvZTQahVqG?=
 =?us-ascii?Q?KvsRsyQr5/7Z/fpYyLoLShe3l2MzYtV+Nf2lt+GK6c6JPtHKUYCpxcZ1jtjx?=
 =?us-ascii?Q?gkCkXNO4/bPxpepASOBHsSyM6wG26OhjjfsBohOZMedD1h5dqrDTuQfyWHk8?=
 =?us-ascii?Q?o/groEnLhVte2+4nxS0xcMXEHpG344wA4HYmLG8guMSNV8EYHL2MbTZyWYOI?=
 =?us-ascii?Q?a7eAWStJ50BT8J7UYOs9Nk1vvsE+sEf3tXSkw+y3QuT9aBZt7I4CjUfCu4MY?=
 =?us-ascii?Q?dJ6z9G8hA18YvM7v8uPh5agYbn47Vqo6uzC1JzjK3LopzI+LsyiXV1MM7h6C?=
 =?us-ascii?Q?lFOQuTOQifvR+LpyamyisPSYl6ammCaje6RcmlSUO+45iVl2syErd+L2/Ls1?=
 =?us-ascii?Q?aQdgWE5DNzpTzUEodthRE6eaSBw+D27zz/uV0sDlaQ4+G+K7699d6gTuFnVH?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d6ef86-472f-4bf7-287d-08ddb329acc4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:13.2437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/DY7xFdLLfgdlTBfJ6eJ6la3qpzVXo1IxFGVunD1r/SHJBoTrA5Jyq+ekJ+MIFMM9f028f8DcFCyFlDA8RYQWEgKDtW1uQ/oxj8FK9PeOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
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

On Mon, Jun 16, 2025 at 11:49:40AM +0100, Bruce Richardson wrote:
> Coverity (correctly) identified an issue[1] where, after the recent
> rework[2], the internal flag, used by argparse to track what arguments
> were previously encountered or not, was out of range for the type and no
> longer having any effect. Fixing this flag to be back into range then,
> somewhat surprisingly, caused a number of unit test failures to occur.
> 
> The reason for these failures is that the tracking of args encountered
> is done via setting an internal flag on the user-passed arguments
> object. In the unit tests, this caused issues where the flags field was
> not getting properly reset between calls to the parse operation. [This
> is only an issue after the rework, because previously information like
> param type and optionality was encoded in the flags, so they were more
> often reset during testing].
> 
> Rather than fixing the tests directly to always reset the flags, which
> is simply working around the issue IMHO, this patchset instead fixes the
> issue in a more user-friendly way by changing the library to never
> modify the user-passed structure - making it completely safe to reuse
> across multiple calls. This is done in the first two patches.
> 
> The final, third patch, adds an additional unit test to check that the
> tracking of flags being seen or not, and the handling of the
> "RTE_ARGPARSE_FLAG_SUPPORT_MULTI" flag is correct. This closes a gap in
> testing, since the original issue of the flag being out-of-range should
> have been caught in testing, rather than having to rely on coverity.
> 
> [1] Coverity Issue: 470190
> [2] https://github.com/DPDK/dpdk/commit/04acc21beeeb78477b15a3f497d3628fd70a6a9f
> 
> Bruce Richardson (3):
>   argparse: track parsed arguments internally
>   argparse: mark parameter struct as const
>   test/argparse: add test for repeated arguments
> 
>  app/test/test_argparse.c    | 33 +++++++++++++++++
>  lib/argparse/rte_argparse.c | 73 ++++++++++++++++++++++---------------
>  lib/argparse/rte_argparse.h |  2 +-
>  3 files changed, 77 insertions(+), 31 deletions(-)
> 

Recheck-request: rebase=main, iol-unit-amd64-testing
