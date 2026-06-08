Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E3CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BFF6402B8;
	Mon,  8 Jun 2026 09:56:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3BC22402AD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 09:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780905370; x=1812441370;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dhHUDxpv6yhk6R8zUIPPifPx0f6O6Eb2gIXbrOCquUA=;
 b=d1uNdodiEtmiwTes1vmz3wdnC9x3Wy++lDrOGH3c5cUbsjLKWh9/fxJr
 TUKf3Huf6tx5J7lGnOfEuKgCsNXN7gz5B2drLwd050hK5nFCYDBzXaNDS
 Nlgl7cPr7k884L0QJyQOMpAniOQlUEKHiVfSFgq/fMWLPSipAF/RYPQT4
 KKzQ5ChlXqWqAx9D/l16HCHcK2cLkpHXQiWsMjvsLjOKEy0DItfQlr4oY
 UQPNbM2JqfVkc/ZBSz9HP5QJdnBsPaVmfsQGLxk3vaSU0vuQ0dHd0sxqG
 +EPz2cOYNbJVzc3qmY6g2tWMQAOjZsKfmbpjTSh+t9P215gua7eOFV2ww A==;
X-CSE-ConnectionGUID: m11a8AsFQ3S9XSAMTi7m6g==
X-CSE-MsgGUID: De8F448pSj+bMAs/qp8OIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85488697"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85488697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:56:09 -0700
X-CSE-ConnectionGUID: mFmoSeuoTs6RsswxFO3HAg==
X-CSE-MsgGUID: 0x3XZ4SQT2W8PdWnOWLjlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="269175598"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 00:56:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:56:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:56:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDgpvD5SLKQS6coHFiNGZlicM/7PIQbxqVBCS96po3OtVIys6hs2JgtEjaCk+Q0tupHHvnELuSsDnw8McELhHXHuo3gaoXSnTu5wITx7KfVDQ+l/xAlnrSh9ebjVDvDR68Iy7aqHFzt2cER6CJVLeroR7cAfdEg3AqpD5M2ncn358q9nPoqlAz6FnfKAjdNXrIMZEppX0nAsKErb3vkG8Pw5inouAsDFHaFXjb99f+MB765WCzjKjnJTplnh18FlizPcb31TWlSpbmjDVFb/CNj9COmXVxyjgb4oDju1FlKw0jZ7GzLkSYghI5kBHUEzqVL7eJu6Uoj7yU8vhRSGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVKFKXRga81k6+OH/jCyupGLDhEJ7p+kSxaXBEZyU4s=;
 b=cvOpp7gs8z1Wr0CvU+6AdBV+XwkYa0hztdYiZkAYgG1UUjpYBXhY2D/zld130m3TtxCoBZsid4k/8ybGYBPcjdmcf/VSV+od4h0Qs1YgybbZjQwMhwhtNVNrntvTKyCc5sbZs+aIfJprw6RZR/z0rQs9842zFyhQh4yAvRiA3VG/tH5VCjqBmsD7R1zgU3ENcMV6UAtG4yuYJEpa/yeTwbs14TSU1vh1xqSRFzuFML92iEJRfYkXRNaUbdnq8t+denSY6PM2XPChhHmYUfD7vpfoIvyfmeXl+N7nJb18FygMKI/kBS2ZZxmczQ4b/nQwXeQsoSQrAJt4CZ/oqC61xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DSSPR11MB9641.namprd11.prod.outlook.com (2603:10b6:8:377::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:56:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:56:01 +0000
Date: Mon, 8 Jun 2026 08:55:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/8] telemetry: thread-safe and bounded parameter parsing
Message-ID: <aiZ1jB3_MaDP4OTK@bricha3-mobl1.ger.corp.intel.com>
References: <20260605205253.520196-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0067.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DSSPR11MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: e92a5bd1-a5a4-4d45-b6f6-08dec53361d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rD6m5SgxgIIA9dl33zDRvMRJRrXa7E+Nq1AbkyuH01exVk5gKUT38Mi6KMmvz98z362Pt8CNVueJqTaF7704dFxJC+scHSpXbdNNXnNXIKWBiB8o/UcOgLhqyFsU0CM5ycJ5FUL5a/rmu/0t6dSZQSjoZgYGTOYGDUFX+TYfoBSJpTt8ZJX0iQ9L+9q6OI3UsLSYgp9sRBXRb3PaPat5jnkQRqfbTj5ULZiXdmhiq1o8e/7DAOT1a8lS3cziegkBumVytWLRW5Fd8E1LtO8ot+ybVVl3Kl7MX74OOu8d7g901MhPLLz+6M0KzHS16WhdV6C2m2l0LElurh8pJsl9j7fl+gtbFTGW3F4c1/q6/Xh9+p2Xwz87JcYwsN0iPcNzEWcFovMRXtRIk1rmz/5PWT4Gbyf99rEPs64Bjk9W2+zt7gVqrN25nN3m4p2mpM8bhJvDExxJPHpD3uR/pVhVb4Ycp+nr/bESjijO5ccW25vq0mx2IMYjYiHrr2LnCYjyoi7MQ+h9zNulc1JZ/5k0BoGF59C7pt40LCecDQ1QQWxbdOrMLfwKYREQEfUQwDlN0fU3FKpZENdjEGFVFo8aX4Jj+d+OOCy8V9mrSQngVK3kIGlibFNWz48bXHMbVeNRlvJ0FAXI/XewR+gxSqoPoEfdlTagxKYvtsUQl/XNZvb1IjjWRDO2zYRAC6M6EHxc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pe0vMNp/yY7kp+krXVhx4tuxGzkyhCKxJLQj+pvohiHn85mQ+Rm3Lr7i3yRE?=
 =?us-ascii?Q?HnbgtrTZKKeC+nkwZjdilXHvaLZJ5BV8Yjc4fPMeE9+z4S/lexu2A5zfiqzC?=
 =?us-ascii?Q?q6F/43sB44V0o+Pn6bIloUtsZYVDGrdhwS30V02+CnturCQo4PCFZSDEmxK3?=
 =?us-ascii?Q?KuryvIlPkc3X+38HbUwJV6h05fTAN6w+2cyeVQASRapaGD/hjR22MeaCp6cD?=
 =?us-ascii?Q?U35rnuoMvsguJEUsdMgMc6c+F0QVVyEnt39grJ36azpzOmID8LiM3xrHlRx3?=
 =?us-ascii?Q?jlbWC7EsRD5PktVNE1ZFfswi5MAVU0rlp4gHkEIqurkNfySQZht3YFZo/KsZ?=
 =?us-ascii?Q?eetHOpLZ0PdG+kZdCShylpEMW8k74d8YG1F9KhFi61jLrFzOQVNC+kYae80A?=
 =?us-ascii?Q?S6XHfqjk57RK5Ob0v2TNlVV+Co6SIF9pz5AAUyzi6qyGyPOlqxg78E3fF7GF?=
 =?us-ascii?Q?1eEzRe37eUGYckg6yu2Fke3knWyX7oRj1YG4Us/LYQAIWJ6Z3yPtxzWQI26/?=
 =?us-ascii?Q?kSUY0f5yHBTcvMMMY8KXqQP5xIGfQcUAuJ8iI9aWVy3MCeDJvJACH1azfZxm?=
 =?us-ascii?Q?tNxmETVptNB/9ZhivDGdIkrspi6Gtog7LmlU2o/YXC8YJRJY9dnEWPJGxeXz?=
 =?us-ascii?Q?a9/2ek5gC4dBHNIS43qr4vOEVqAgdWR5tvwsb9ROuLnozSnslxXxBmR6ukTZ?=
 =?us-ascii?Q?vbCDty/TdtN2YTl48wUfu7f6UerwOrfMr0upHa4NCzZGx9chDpe/GngLjceq?=
 =?us-ascii?Q?p5924XTeyzPfFZmOey3SjGeTEkjLCYUc3++mFktfYPAJBp0WR5Wz8C+phA0t?=
 =?us-ascii?Q?lN+85//WfZ75yP71oIGW4vLhDR2S1L27dNbogJO2C+pWVdFkv4H2c4BHPspN?=
 =?us-ascii?Q?JlJDBF9MvXYKV99HCk9GJyohODO/lj+zPFGMDNrPofaXqA7RkK2N4jL8Ekus?=
 =?us-ascii?Q?mf53pvdPuZ0tWlgdsv1ipdTUSifiRffrycdCnx4MQqlTOmfTAQS7obaQ/jDv?=
 =?us-ascii?Q?lnOEDH/IBYOmmktdzXMZefnTlG5hJMNiaa5x+fZKGx6rljBLLaEAHjMJ30Rw?=
 =?us-ascii?Q?qFNLpBQeEx5C1Fru/wyKb99zardcLc7tKWNsqOcIRLKbVqFDtszPjAyMLd39?=
 =?us-ascii?Q?qLl8s/jZko6IQMAAI6HCxnaiXNCNOrUWwWRDrWybTOqbC38p1tQJhjDSESVV?=
 =?us-ascii?Q?MR5WFuzF+pUUXPsC+3RMRwChVR/mvS/zi2aQoruyVCnN6m9LUxDhhYXTXP95?=
 =?us-ascii?Q?YfDYLFefDtIrlB/iiCuNMf6vWL3Yk/OZYpLzFdm/7IatfxgrNksgIbuUzGeW?=
 =?us-ascii?Q?QqzIhm/7oSrTLuY58489qcB06JwFLqRfr8KSJh89KTZnmxwxYf8Pf0Adma0y?=
 =?us-ascii?Q?TlAHeISNA4AqbO6/+hGIPS+5vuJICz3AM2Op+knj57EuLMyy0j0NnQwckYct?=
 =?us-ascii?Q?MEwfbJY2ZCj8u+6XwX+OmbenWqfmu9cOljrU7inbmbXhngG7dnFcdVgizQ7g?=
 =?us-ascii?Q?+RYfzbZfXT1Wzk3rxyIopP8AU+VvNRP8490jgLvvpm+3SKnMS/WWwLfZ+OsL?=
 =?us-ascii?Q?GEF9dIJz+Ri226FWp5BJI36bXRJ7hxYXq1ZseZ7o2LDxh8klt8bmQePTe6TW?=
 =?us-ascii?Q?TQfifciiS+k9xnX4poGWACzUdIJuo9Tx808EF5P4LZ+D7p3E0fsKYnPH0T2q?=
 =?us-ascii?Q?e1H3hikM+IrY4TlgGewmMFwCU7iNTvTVcsC5IzqonUpv10OBoMoihnqM589a?=
 =?us-ascii?Q?I1nWXAtGQEiftx3hQETEaApRHekBHmc=3D?=
X-Exchange-RoutingPolicyChecked: pvx02QdQYP/hZAS4juvFYYZGiWBAbhcLeFvTcOl8yPEvHZYj8pF64evJXR9zftPxnkjTfkf4nDACV9zCRY+uqoJ6kHrxLdWxAC9AvkvmyB9/+TFlDfvgtVGzhXTUkBh0UsRc/KBf2d9nQW0dcEw/IqsVWVmfXZkR5tbxjkkn7wpuGBcMprH1+ZNlEYFQGqbzPsMXoflOWWueLyL+JzAfHe19QirxGlFRl2a+iNvvSEGNcFFisHp3JCmb0s79vLnwoRuzEx3e4xJ6bfX+D0e+VrWQ8FvXCDqw5p14UF6EJW9S+1r8Nzd9UioDN2t5q/IzKASMsR43HQIdVNZ93vLWkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e92a5bd1-a5a4-4d45-b6f6-08dec53361d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:56:01.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXYAB/v8GLPvGX9Ddcn3XG3I+asToQwxvpgaE50YgrmP+ngUgwPQ0y5h5lYPsnfCHW9OqayUAZv1sGv1lW0K0G0+Aa+G1ObtT3h/zKG8zB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9641
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

On Fri, Jun 05, 2026 at 01:50:57PM -0700, Stephen Hemminger wrote:
> While looking into extending telemetry for other uses, I noticed a
> pattern of unsafe string handling in the command handlers. They run one
> thread per client connection but parse parameters with non-reentrant
> strtok(), and convert ids with atoi()/unchecked strtoul() that silently
> truncate or alias out-of-range values; in eth_rx the strtok()
> continuation chain can also dereference freed memory.
> 
> This series covers the library code (telemetry, ethdev, dmadev, security,
> eventdev, eth_rx, timer). A follow-up is needed for the same strtok()
> use in drivers.
> 
> They are marked for stable: the races and the use-after-free are real and
> the changes are low-risk to backport. But severity is low since telemetry is
> not a remote interface, but these are the kind of issues likely to
> be found by AI security scanning tools.
> 
> In future, atoi() and strtok() look worth adding to the forbidden
> tokens list in devtools/checkpatches.sh.
> 
> Stephen Hemminger (8):
>   telemetry: fix thread-unsafe command parsing
>   ethdev: make telemetry parameter parsing thread-safe
>   dmadev: validate telemetry parameters
>   security: harden telemetry parameter parsing
>   eventdev: remove strtok from telemetry handlers
>   eventdev/eth_rx: fix thread-unsafe telemetry parsing
>   eventdev/eth_rx: reject out-of-range telemetry adapter ID
>   eventdev/timer: reject out-of-range ID
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
