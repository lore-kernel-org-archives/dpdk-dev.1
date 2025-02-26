Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C50C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7094060B;
	Wed, 26 Feb 2025 10:53:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8225A4029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740563584; x=1772099584;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AFwi6VgYJlTp4LAABPUZDUpooo3tHjlgGbU0an0jag8=;
 b=cBtKZp6MuBNtnSvS9fVOEkhJouIhnoR0sgzsmmDo3pYgt14kH1sUb5jo
 Jqlr0u45nj3bbqQVuYHPEBzkexR4JvUr3XCefkVRie1yjzdWSEWX5B/sc
 XlQRzGlzK6+N6jm5Qrn/c/AssIO0963JSPrAZEzssazZZcqGNu3KtSpwo
 D8FI0XSsqS/uqOk6hWWFuTqjwQ7tljA0KdBStEwjQQgQjIhPKqwB0tlb+
 HR0Sss+TwbdMvYK85smJAQ7Gh8BQZPWj0z1a+IF+XwxN+u7EUH33yVAsD
 tigXGxCJ10tjTFO42M7gqYiO8Xskb+eD2Hrq09QwbpEysaT50V3qLnGhD A==;
X-CSE-ConnectionGUID: 28836SRWQJahL6D8qQRa4g==
X-CSE-MsgGUID: nEJV4ZfyQAKHY7UJYfQgaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28994331"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="28994331"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:53:03 -0800
X-CSE-ConnectionGUID: uyqYn4SzSEWWDefH97FCuw==
X-CSE-MsgGUID: qwbuxiBIQ4SYuMUdgeeLlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="116465286"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 01:53:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 01:53:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 01:53:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 01:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/zJldfLy9YGcKwyp2mdt1+AmZybUnzIoBMlRnPkNCxLJb4ma0PmG+EM9Fvap+TGur1Q48g4rcZ79AAd71dGZW1SG23tjwEQynbQr1+X72QkCFHDJYEs4Yw02/4dDulWwyouXmNmcjXVYQc8t6mc7tViD1TnEDndTnszCAxEzMsywZsvMvjKBnFeJNVbd4MSPqK1fQEsnKxk0rFGHvHY/vVY3b0poo1qKuPBf7fd5+F+tH6TKTJoLEfiG/Pvdm6ybVk2YhYAFdL2lZXw0p6utVek25AQ/CXRxkSLzSzGOPK6Djyv5IpWnw35qVWQbcrxC+QgELSRHRDBnRLaNsiCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJUPVPiz/mk35lkmFr4zT0DHLmgNcukYL0QiO8rNw5o=;
 b=eOcDwhiCTRKXyf0yJnQjwJtpWP8IG6xHuCT+AMi3Tl8v82+ZF9ddXchXuwWcTvWgWVWgqdAoPNbcN95dJV3v1eRDW+8TLoVqgmqEeDZNkjXqfS85rtTYvqNj2u7hMRIvcHPPw3DUt2LZbZwZYIXw03JS+/g+6L1JjPhw4DK4nNQNxQ2a+hD0GfNFCIiBfeEnNwt29nBhB7VVIcswWCP4EbxOt3/34oP29RDS9GNjTVOAmfz2XVECfAhf4+7QfOCzqqSyp1JYgYFdSbW3OWmetBLyrX2DdD2J6B1K3bLigenXJz4tLIXtpanRWfYsqUCWoIfmvHjYTs/bjbva3jS4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:52:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:52:59 +0000
Date: Wed, 26 Feb 2025 09:52:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 3/5] config: create top level variable cc_avx2_flags
Message-ID: <Z77kd2r-A0-BUQbr@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-4-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740532016-6789-4-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU6P191CA0046.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f1db2c-3692-45fb-6a1c-08dd564b5a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?StHiM2xRtJiEkoO6gO7Yld91wAVJb12EwGgIycsDejUxC7gRT+GA7BXU9kLO?=
 =?us-ascii?Q?1js7GkZR8TAz2bRLb0EHqQmD4DDVomP1u4Q7+pCmEmBWwHx8p+ugFRRt5xpr?=
 =?us-ascii?Q?VfShimegsHCN6sabh2GnOsE/vK2TAZS7eVjWxaQGpyPwf8lhJbu9Sukk/yb5?=
 =?us-ascii?Q?9e2n5Y8cMKuUkAUfN/XMR1EmcgbIKj2gOI/ttgrPJOGjvieQb1kQuaBSU0wN?=
 =?us-ascii?Q?ApnzZV0Q1rUhlk25/I9KLmARlVER98qOygnJ684iET9CDtbZCZdvA4u0WTPi?=
 =?us-ascii?Q?F8w5wGQBIM1lsjwUguHgelCaQbAQeGA7o3Hs8lNHPXqEpzXZv9T5XDfKvOHj?=
 =?us-ascii?Q?/iql5lwD/bWYPaXMp9ZSY6Uh51RFT+HTUqGKBfaynM7MecdJyhCglhFmm6QZ?=
 =?us-ascii?Q?zH53bJ9JXeTPAxyfq0mkK2IILZIrPcNRCNxI4kGdHbcYL35GGana8ZDz/d9n?=
 =?us-ascii?Q?i0S/oFfuD2TYNDXcOcGU+Eii0ocudTOpAnHsLMLWey0YFvHPP+IF6hDWWGRN?=
 =?us-ascii?Q?s6vLe9VF5MYKdeFVCXyTqav0NEdZpNiOt81xqv5UBl9ZSFYzU2EdhamyS68h?=
 =?us-ascii?Q?WoGqK7zCb0oBz6pa6aIMg7H27V21PnNldu7DriZjjHlnm5GzuvziBRSF2OTc?=
 =?us-ascii?Q?MbORcMtDnQ4HN10xtdZrWaUh2yJoI6Z76zluo/kxIhs7pRNN+VmTtrbhRdgg?=
 =?us-ascii?Q?4uMGGz4e6xHFBHrI+xF0oEOadOszav3b5dULJ0BA0Gjae9kP3+72AcmyUeAb?=
 =?us-ascii?Q?73mjlR2A68VDZgdeIZYKXptuNS2p0+tH6vzFC2vk8YroxlSdgdPC2LiyuuxM?=
 =?us-ascii?Q?tXV4rWO46MG/XK7MnwIHEgW/FEPZfYC+0dI7yjuHr3qqxcXzmoWjNXvA1n0T?=
 =?us-ascii?Q?cjcetg8nEUsPHuotYInZNcqqx7p7kz7M8zz/ae6LBq6G7mm+6GT+RW7xGLuN?=
 =?us-ascii?Q?sQEmiCJKCnzvUgTLMcRpCANXdgBGGTp3hokhc7EjOiBE3Ue0DF+Adng08gXZ?=
 =?us-ascii?Q?GSgu/86747J2nQGVfTLBVmfeSIjX/EpdGGE9zJg7+J0rGQh9jcYZ7qYARtsU?=
 =?us-ascii?Q?LW2DdqlUrrcVnb+0Rhs5LvNJvhl8RrZeAcFHTP6gh8nmsrrbI4rkOsL5Mxrs?=
 =?us-ascii?Q?ogyCm7vk6japkNrKGJrjZg/fm8vad8ALuUK0ajHlxyJytyTkYjW3hf/vsqaC?=
 =?us-ascii?Q?C/tUGSDhbNGPg6QyPYfFzaF+Dv0T3Nu9Ew1f6vRfPY7W1aIhhSn8fzHb8xnc?=
 =?us-ascii?Q?FjOtS4yXWNItdZ86iNgXrVvJmN6OOvYA6Djb1AwNfdNq4/cTQpsHBqFPs12G?=
 =?us-ascii?Q?GaRSjOmWHzw4rJ7u+fyZmfYoWX+kbz1qRX+vD6OGbZuPYsB3XLI7+akp4Rwr?=
 =?us-ascii?Q?OHHirp0cxiWASw3u/RdPppu/iR8N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrD7bjrrgBQZd0KVD1Ancpvqwe76ckqh4lLMcpZvgOQJXEG9Tt4qJmYF1Evq?=
 =?us-ascii?Q?psmHSdp1cpwPpFFmTjaakqJmOA+HwyRab3zC1bbBlxkPBlC2dhwIKr3gRHDx?=
 =?us-ascii?Q?3wfUmzq9X8v1ozXfx1PUmPT9RKCDx3j+U8aJn8AIush6S1GpTQuO8NgIMSrw?=
 =?us-ascii?Q?0JlCxxCQscdiuuxvZ4gllluAByNZCVFxhRl852mlFVhV3YU/98DzcDZnHfpz?=
 =?us-ascii?Q?etWWGYxeDJDOH1mSOzpqol3brT8uOWLvrViS41gEx1cnFGO4BapqqW9ei0Wm?=
 =?us-ascii?Q?2/Q4BHW/Af4r+naWTb9YSZJIbeBycuIXngEOrsA60yR8aERhMlS2gIAd8QH5?=
 =?us-ascii?Q?6KivxPcsfouMc4fQAThKJIiU1SbMZ637LoxS+REx//ijDV5hty4fUTnEBKsj?=
 =?us-ascii?Q?Mr80ASPMmq7yyJpcFfmBT/QA6TriC84aZLonnN//eSrvdmVz3X8JspEMZjkf?=
 =?us-ascii?Q?5y33D3Ay2kA3e04jPyebReXKL9/D/Eea05oZ8peE0fW23emUpzuaq1zDOcqp?=
 =?us-ascii?Q?0v1eqZ14bLVsYfmj5odITUFPVqo4oz9v5dczm/KDUyfEH+/OQhfaEzZgOt6J?=
 =?us-ascii?Q?aH19eGMwxf+HWhu51Cl8grkSfF1AUTIilMVYgeAiqQVFF1UIEGmoYp3bcMWg?=
 =?us-ascii?Q?K5N7tM5odVJWwXllNduzPTzNfUvqzEF1aiPv0ZvZRMzGJqgZD1IgTh1C+iDR?=
 =?us-ascii?Q?1h+FOKwuqWsqFI6fyuicc76ntjWFIOFdJ1h7C2vtORwUQFhZ+JDMkXtVBOLT?=
 =?us-ascii?Q?Yn5uVQlz7lrSFDrFjdYTpyXNktqDokWyyWGSXCR14TPZaJYguaX86d2fIPAM?=
 =?us-ascii?Q?1q7o1FtHA3QM9mrYijJATSPLMu0UbqZik1zzIzM8n1Hdj1Ac9Eun+l8HzdBK?=
 =?us-ascii?Q?3SnqQKjv6+7TFUN2uf09BEtfMQ8FehDChpAKLqsuIk3U0P6o621mFiAbZEm0?=
 =?us-ascii?Q?5ZjCx6VYq9SchzC7u1ro9YWcfIyURWSzBQvefpXkHHykfKDroPyzeTrUryLx?=
 =?us-ascii?Q?hdJCJxQmOj4yF70777KsU5LrQs4SydahvOWJI1sroBay+3ZZzaponsflgB0u?=
 =?us-ascii?Q?tkJvR7US/VQymUhGbp8+R939/zdSJ/cyhi5hd+Fpq+TRM5ZcDt89DQhjy1am?=
 =?us-ascii?Q?ol1fN1WDr8410MDGwoXfMQT8xfVMnTuiev5q9woQNzfHi0xYpixt4Ac5dlLJ?=
 =?us-ascii?Q?AHw+cVdKw/yydNhgGZKNiIWIO5l/AYCqVnWNleCQ9+bwVXNEQtAwjr9Fapbs?=
 =?us-ascii?Q?3KXaoB4yeo4pUL3TNuEhOeO2AYKRvkHwMIegv8e4kbB8Y7n3R4HbbBNNV/qw?=
 =?us-ascii?Q?0jIuQ53hYx70MGN9DPu4i48PoY3SGuxs5e8wXQzxjVW4qV7O3iYsTgQ+UaZS?=
 =?us-ascii?Q?PixMfqYWyPkEuB0EhODkbbgVMGp7KhF8++zG1uW19H+L/UzHbDM03y/cGUFl?=
 =?us-ascii?Q?qdwEJnK6OgE9BGq5MkXVhEn7woyK11t7SROGefED5HmXA5mFEVNH0hXCl+Oo?=
 =?us-ascii?Q?Dth1sE7qnbUfd78Vp1kjHQ/jbomLq79MKBQke+LWaCCPt++8zgN/Ipi3tVaN?=
 =?us-ascii?Q?hR0z7zIM6WeEeHibu03XZEUEOpXR3RvkewqRBIV0TBHw2xZ4UaC2Cc9z0YNs?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f1db2c-3692-45fb-6a1c-08dd564b5a50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:52:59.5119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wmad5Q3pVI7WesqGEjN5BaR0aCkKa0JfKEy5mFMyk9PjXhnJIN0oX4/k+iuKyaSNS3o0h7QuJOeh9DyFRQz1WLzPym2go9WvEwV2A4m95E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
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

On Tue, Feb 25, 2025 at 05:06:54PM -0800, Andre Muezerie wrote:
> Top level variable cc_avx2_flags was created and set according to the
> compiler used. It is used in lower level directories.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  config/x86/meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

