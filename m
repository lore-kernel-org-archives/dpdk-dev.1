Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB8C021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 09:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2A6B402D3;
	Fri, 21 Feb 2025 10:10:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 12B9D4029A
 for <dev@dpdk.org>; Fri, 21 Feb 2025 10:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740129041; x=1771665041;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8xjzEFvhtZ51ZWpeyAP/HyQ/ySRh/e8Pgl3IUBtdees=;
 b=gwIDQ3rkznNLiwuJsMyRNSIQStZTdZ+N+BbK3EYBHKJjjpqoC3coaA2L
 JFEpZhs56jQbVVWNVYjHOyCRRlaCkSYmlmfJm6BW7KQ6L7PunpW9qy1NO
 BEH1oTveDBPT3WzMJsnfkevLgHKkjtmWPkEpvJAct7oFw4uWsO2gTCPOH
 8g0Dyz9fYhpaa0LAW63WtSGe/rLkULQWcKRZiOsJqUpxTVNuz9nbkBaUv
 VuV1b0q82IVU4v2BrzLx9G3wABwANNlFgHobZ5Os6HwmFLzT9RWT8or+l
 +wvURAiAae1jb3FV8HWO6GgOiP/v64mgY3VVTVr1/esjWNVVothYyHlC4 g==;
X-CSE-ConnectionGUID: fe0+TDRDQUGZJYwsxNMLyQ==
X-CSE-MsgGUID: qwrIAXoyRACNZvL4ftZwmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40953433"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="40953433"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 01:10:40 -0800
X-CSE-ConnectionGUID: csThh5gnQcSHpYxXpBMo8A==
X-CSE-MsgGUID: 5quk3givSEW2SmMOY937cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115145986"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 01:10:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 01:10:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 01:10:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 01:10:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9g3gbWPQ4cIzlvy5yu5HXAjlTITDan/6eCi/NS29mDL3m7ftBwdPkcpC/nXUNWuAUJS7tFqA6h1Ht+pqhQgYq/Udk1gZqsUxC81CuLcHrnala6jOY+FXuY/LXTHPt3dGDd/4ohIHawfKMHXJv9VLGF9uDgppY2ATs7tAYzPMyzRol9EcIB8xk+WoHJta1EAcO7cN8rc6UL4wuBXB/l0rfv1QhFlXKGHQ/J7wH76PYHb+HJXmhuXSlY4LlB5xkGeaXgMA2yzlMU1qUXYLne2nF/Ruvj17ulHRbLZdortjh9MXtF6phnWGviPoPesc04+DRyVcosbYx7KVuCvfL/rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJW0+98xPJInFY3NulhtuxOmENmslduBBmlbXeH9e+k=;
 b=SINjrrs35jRpMndNlhRuzwfT7cqne+EvUYhM4qgr8Citgbc9Z0okWtzsC7BmLpe8Rrj8ssBPi4tD+b3p9wOi3fTAzguwTklhwwkPreI4Ot7PZZFOimg39dwa2Hoge91waTL2gTq7mvIsEGngAiYNvHFpaWnnuDYTtrVLe8g5oWHMf2kbTc76urs3g9cM6p1LnnMlPxCDONshkou9gJFJXBXez/ZaJ0q1bUItjHgmLqUpSP0tTIpOjtW0OJiRVSO7ZdM/CUity5QPKoMFCNCb8pi9UQhRHE7m/OtHLh/jBnNXe6fyHwxnnOjw8ZlWoHqGM6n3ZjPAMGE2KrUFxFguOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 09:10:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 09:10:21 +0000
Date: Fri, 21 Feb 2025 09:10:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 03/10] test-pmd: fix printf format string mismatch
Message-ID: <Z7hC-FjUbDJYC8eS@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-4-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740087064-18680-4-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ae3a00-2dba-4eea-cef9-08dd5257915a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H70FzXW1fIgpP3oecuRwpgncRxuBfjhXOQ6JsM3VAdQwLNeT5ridHE7TfjAK?=
 =?us-ascii?Q?lU6yVv+QDMwkC3YeO/Q7NDJRx0DaVni5sn6bcx1Wtp3gf3IM8LrrwWkuvnQX?=
 =?us-ascii?Q?pCeUarMIEUcdR4g42L95C4heTnPDD08c0GFY2jNFIHEB3qXMhOcfiUIANvK9?=
 =?us-ascii?Q?uA8lvOe/iTxWAxt8QqncPZD+fwE62Z9XTy75gIeAFmmqXMEVJT53/Dx+a6ih?=
 =?us-ascii?Q?sjsZA0imYRl5jXVBK14bK/jQXgTatZu/pPNjAIbvwXXuVeQP6C8OPw6qcNLP?=
 =?us-ascii?Q?A9BrJdTD183sEt9au6PMubF+dDzxjwWywlCnaL3fa8iZRXxRufGhPz6xjLhw?=
 =?us-ascii?Q?1wgpM5u1v29LdQ2zySHiONb/zhd4UGQIsNknjxFHIgrSirYqDbn9d/Mv6Zrc?=
 =?us-ascii?Q?90+pC8ujy966DHT16IO1w0ojO+UjC+mT6kXkB2wau9V5tYXSUfa7NsR7pAoD?=
 =?us-ascii?Q?woNUKfmAUwSPoj1CGlynTizGhgFbyw4PmWllagiXDiBpdHHm2ABej0+3tn7X?=
 =?us-ascii?Q?ivK2aSzV4e0FhsYtJ9sevcqNhsPKg0chnS/fegrBdC7vgnuYRT5tCeFReecC?=
 =?us-ascii?Q?WaiIBr31V67MvtSgIMl+x8z/98+e5zgbEC/y1iR/b1SNUourcJqqFQp4TqZf?=
 =?us-ascii?Q?qH2GqhdGk0zQrax7ydWMG4ubPY9PqMW5/2GB5EJWgInDEtnbQQGJn61H4ezq?=
 =?us-ascii?Q?4L+H0/CgD0SUuigdpfNbXcuWW5jxLPW04+opa7PfqDlCTIaiwYyg2FZb4yyn?=
 =?us-ascii?Q?KP5TqAj9glGV6jeQkr8ZLSvEh/sXWGGevDkAXNK1U7s9Se/6SDp66ehe2zCj?=
 =?us-ascii?Q?t+mAODs4Bu4asZNIei2tM3su9QBM0qrlV+O6S5S3IVZhAYQAextpwnxQ0hg0?=
 =?us-ascii?Q?IvUuGvbWNG6BDraLnygakinf8ZO/IKF11WnYsddXtz6KBoIgpbhlPRa1c8Em?=
 =?us-ascii?Q?Gf2EGAG4zpqQmpaHHSRKOMAZ5SB+SfcLI1Cfq9XPS+ywICKzufSnCkMhl1gT?=
 =?us-ascii?Q?0cEfHS4mDcaPRfxpNyrUwTpf5u/u21q3aescD4sNCV89KELnXzJ1Ln1BaNSi?=
 =?us-ascii?Q?UACrwr2HvFIsmcpGN9PLfUCd4n6pKc+L3Yzt4NtSsz66YYdyr61mJcvQLAtQ?=
 =?us-ascii?Q?3nPPaNZO1pHaXP/jnSChO4fMKyMC8I26UeRgEplL39T0Avchn4KZGWWlUH5l?=
 =?us-ascii?Q?PTY6cNLAlsQhLbYUThmPuW6iGfxst3/Pgw16sVeOZALupHvOYubeYp/aqIug?=
 =?us-ascii?Q?FuiSadTDvBCitwEjz52PtX2RH6pxQQkOmlI5uUbtTB3RQbS7bukzHt8CjQEa?=
 =?us-ascii?Q?I290yRoNwcexOvq8WglgvtXhP0wmwaHBQfAwPDd7BEUYfFFOE8viK4cFfgt5?=
 =?us-ascii?Q?YMicpMbhJIMKQvQcbugSKmcvCNxQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ozWBZ1Po96A8yFqPt/6CG4OoPaiyRtkAqxhZElmp2hujaFuolOY7QGYxdtH?=
 =?us-ascii?Q?Sc7yAhL3I3CXOowbQAaUMPy9Y6Ii33vSUXi32Ipwswv+v9phlGidwQ5Q1bqs?=
 =?us-ascii?Q?8VGjAR6dKdY8YNBKhsoHqfuj3bDsO4FO7OmUvhYyuVMvwg5vmKYztNZzSbe/?=
 =?us-ascii?Q?tITbAUD5GazLIot85ZTEvQIOlWRXLHYRlsWfMAYE1UtCAgs+JkMry2nRiL0B?=
 =?us-ascii?Q?MxTnbKQAyp/elTNmmHODJUpPugiy4dUFrgBd7TcPKsBg051Xy5Drmk1VhMAK?=
 =?us-ascii?Q?N+PipcOJVvaFhdrLALfH3a0pm5zmYv8mzvN4SiWLWzQt0QOgjqHLrn3nHwwb?=
 =?us-ascii?Q?TDjq/GIVy0eY35TMQzDTyx84nGxTgLX3IJRE6kuELd2N2ReG6T25N4bc7sVJ?=
 =?us-ascii?Q?DcMKNVhBOYMHPjMS1x5L1KYZk1vaYdRkrpiaaxSXUPFiYH2jWGyt1M4LO6Ie?=
 =?us-ascii?Q?EbaLyolND6fU4WRrQHbfcfkAqLVNdD8zXyj7SlANxypKxTwOFO1J4xBPTmuj?=
 =?us-ascii?Q?7JbKBsS1f8taZR5h8XVRpl6vBz8m8HFuI+9yh0KgXBfog7GvX4XwnrcyQPtn?=
 =?us-ascii?Q?Lflb1tBEC7RCKbzuYVEtyJQZewNkbbdAMamaFbngmDz8YNe9oz1F3S7EaFAJ?=
 =?us-ascii?Q?jwitSRDv85f5HlvcS4cLLFAjFO8sMXgYzhi27Kn5NJO8H+jnKEVaOF1OJ5NC?=
 =?us-ascii?Q?RElALmQ7/PfRiMOoNxMZQu1Sxmu5/6ohJm1ltzEAv7TpvAkVSGdH0WDf5mRz?=
 =?us-ascii?Q?iyGclmZU7N0oHvUF1Ctn8tkI2zpTeXmkT3owUTSV5enbPFi/43cgam5+nLFz?=
 =?us-ascii?Q?0igxVXgecbOcryIvtYD2R9uuve3n92V05hHXStGDy0kNJka0I1E/bGXHdzPW?=
 =?us-ascii?Q?/7f6H7UHbdOXg5QWp82pT2OPn8oUUkUYGZLgrP57KUUOF5MqqvQ8cxW4I7Bp?=
 =?us-ascii?Q?2wuOiu0MfMju/8HOCtfDEU1kxOyBo9CNzvU4bE+v8/Hjut8zBZhVz7+RSTlA?=
 =?us-ascii?Q?aaavscOEz2wwGsWqtAeEUo88nWSj2AVIc8Jr84X9nhLd9zpAiHWFXBerctG8?=
 =?us-ascii?Q?S9qgJXi3jyLZ7iRRqqDxqYOo45z9bGOSxeSfAk+46RZt5LT8hj0MLQlYDjA3?=
 =?us-ascii?Q?RQYY9gnrf52UFUY1x12HIG8hF7rJGJmfk/Ec9Nox/+uOnn1PPniwOZrmZhOH?=
 =?us-ascii?Q?wEKXbQEYIf2OEKfX4UEeoY1PMts90TRKziRH+kUNFnO8N8bPG8lIdcoEc/S4?=
 =?us-ascii?Q?GdnZnw6LlH2QvuZkI7h91K3TRAhhbQuRa24bJTt4oQpwZrGnABwyoErtc8ZG?=
 =?us-ascii?Q?pazppSKPfakK4Chx0AcMH1YeIAZHTZLTO3PDE9TMQwdCvSU1wRMk8HwOIwKO?=
 =?us-ascii?Q?s2PiZ0ORS2ptBztM5gVvtpYpvejyWMLGN1u+zkV8qw3Tke6/rzvz2NWCmJus?=
 =?us-ascii?Q?XdxHVgqbIc1/K9a28axPNCNwj8NnyhqxWV2AaZZrAJqenlP8zOZoA/fwnyoz?=
 =?us-ascii?Q?7m9fd21rsbriebDcnuwPu+0TQm2JIg23PmODBBASzOUN2AMl003cbw3V1VGp?=
 =?us-ascii?Q?5mBWNJ4tq+sN4ghLsxHT4UfAONqRyUcQ/KXowJ4HvlUFQ7FPNqKo/Oyw5Yz+?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ae3a00-2dba-4eea-cef9-08dd5257915a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:10:21.2323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6znwVLFPtf1gzEbubHSQhOQ63UHsvHMREBKQU2YF6t6cM6LT9e8qlAAGkWxMz9deWZkAau/ab3mAX3APvQ6ryq5Cw5+7PomS0IWV9RlzP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
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

On Thu, Feb 20, 2025 at 01:30:57PM -0800, Andre Muezerie wrote:
> Compiling with MSVC results in warnings like the one below:
> 
> app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
>     '%d' requires an argument of type 'int',
>     but variadic argument 1 has type 'uint64_t'
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test-pmd/csumonly.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
