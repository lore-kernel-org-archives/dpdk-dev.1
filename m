Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092EE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E66240395;
	Wed, 18 Feb 2026 11:06:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BFF7F402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409176; x=1802945176;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8rYOcYPmEiFyOLUHr+FlzLlROyhqSy7djRpcoYS4Q0I=;
 b=RMJLw0gQhiVaewHg1t92kU7s2PSbmhUu1Uqg7wR+yAS+mXd+L4nukZ5C
 zqXvnFpkkrKSWAbOTK08/BMcti7KXR7pKwR+aeschxkc+1EU35ZpcTReC
 NcJ7YLttdq8RL4PIF/U9N1QJsmyRZ+YzP/L839iBzZ0DOX84egfp8jLRz
 hNFefSh4thjusCFy/Zh691aHXcgpP2N0ufuK3oMWW571M10DruGuwAOUJ
 JRga4a/TAmTZNL8ZKzfVPElYJtrb6r8lEIU1iYK23n7oYA4ZV4lC6wFrS
 ZEcoyWelvKWmY7L8aNzxp9qglPsTxw1pLQrNM9Eu4+Ru0nNUBE5cCE3bh w==;
X-CSE-ConnectionGUID: z28gNfAqQ+Wx+Pt/miPAPg==
X-CSE-MsgGUID: WeLzJdkGRx+tGzCYOD7ULg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60051935"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60051935"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:06:10 -0800
X-CSE-ConnectionGUID: hWpCmHK7QH66lIpti868YA==
X-CSE-MsgGUID: VWYw6GXQQjCWT2zhkEC8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214005741"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:06:10 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:06:09 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:06:09 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:06:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEDSHP/Jhwubf2mWdA8CQ2Ek5RbeyYW/9ocl861OVf7nG993tUuvJWi3FhcvJ89sN/EmZb4iCH/xn/1loEl0rDi8b02uVXv6SKsxa2eN6ILBiqQh4zgSox+7z/ISEtcSXY+hpsboh2eLI3BwWC5zSlYX9teno9VaigMPDPznvIa8WW0zj0lr+fTrsfygGUuNL8BPTaNU++wwNYtokZRjGbcdu8wohJPYYswUHy3Zx8xxUdMSXQiTqkoJFF7FcFPhtLElueWyQjAKuJKTnXBnPfaTPqAep0iXfVpNQio+dvXM4EWCaDJxaQIzkddhd6T6RHoyE+tTIwwQCiAiU+SMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZhxZEGM7nzOJWG/sG519GPGpLNg1GCQlAb3r8y6YXk=;
 b=JHmQK9QFuNvnKogVGU2c/sXSx5XrtKdGEp8eiWfvfpw5Vc+K3VwWULJEjQPb9/Hum+YW94Ab/hUT+E0sVzCxYuQA/II5KWTlB5T2xvzQe5Zfh+erRgfmUTInQ5y28DSvohHV8muJdpGBjHm/R5CC1l2UdGNCIz3XnzaxlTuWqUhwXlaR4WDc0/pGFx7TJg2Jtw6izX0ivWWvCqIld0sQltFAs6yz9o3TlxuDrTTREcv9eSpbe8d7mJQL2ZVHiaIjEdP3326FNRj8BojF1EjyzA8bgul09YDdkQauWqFOjkl2kZ0SwHocqHyMdu1lH0+ePR+ZG6nvvjfvcESW6R6afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:06:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:06:08 +0000
Date: Wed, 18 Feb 2026 10:06:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 07/10] net/iavf: permit secondary process Tx path
 selection
Message-ID: <aZWPC2p0DBh0Esek@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-8-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-8-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf07c2e-0862-41d2-2bdc-08de6ed555e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QsVk3dKy2t9U9PPLkFvy6C2XNPJrwBIp5bM6AstWoS5GqWymgYL+/TnDqYe7?=
 =?us-ascii?Q?bijOtO6IDQKRA8rAd1AJ6qDzzPyiKnVF6xXVcfxmuO6P7tjSt3umUja4WaB9?=
 =?us-ascii?Q?XefF1PaGs0inefkj99g9jTv/Js+GRntmOpBQOu/LkpJqlCWJrey5LpZ+cRiC?=
 =?us-ascii?Q?ZPwKFPYBolMseRjUn3N/p88ZVwAcPWMK8rz1Yn+HD22lRquUx6LwAWdnle2P?=
 =?us-ascii?Q?YtKaqPjnN4brSIsXPUH2PGDE9d8iiI+PR2OvHlBbTHeyRGXP8dnDTdR/k1WC?=
 =?us-ascii?Q?c76DkZhB0AjEx44c49USLMYaT8sQmuvJI8I+sQlbcPwEWKkaeqxXX7RbbbJH?=
 =?us-ascii?Q?jlEq9pHrU4UBiGYjyJlWW9Huz0zMF2C393rzalFEVNmZp9zWSCM3k8/Dhny8?=
 =?us-ascii?Q?vKrPj3J48mNFmY0LiF010c4Et7OusgbaoXntf7X/3Z7uvnVNhbEvuuLnHaHu?=
 =?us-ascii?Q?1S33dVB4t48SLoji2k+Cv6KkGA7VmHXW0bPrchhLMVOMqctaXMPt44jXn/Lv?=
 =?us-ascii?Q?z17WW5LFhrEEGyXtrnJLLoQuAd7CLjXl4yVm/+51Q2yYeX26wgI+02SRPKqs?=
 =?us-ascii?Q?yH3zOEjTZOuVuulJ6eYSTyk0KggeCmUEuLjYRgTiH+rHq4v4Jf0WJhj1YXlR?=
 =?us-ascii?Q?xNvma0i9knXXJ6iaC7mJ4Zs73JwG9WcmoY5kTfZX2i6eEStJTHF7F5BLC8cs?=
 =?us-ascii?Q?bslYsl46fvbAZeZmreRUa2EkWkegHm71jseybESxs0ML7unIrU549+EU0Kt2?=
 =?us-ascii?Q?w/RLfEi9DqfgvBRASEtX8brW4vucThl6qjE7rws4d6Wzk38DM93I3WciYrZS?=
 =?us-ascii?Q?Ad8jfxhMJccDHan2FbDA729Spuq6/Lo8JzvVkYts+DOMx0QdUBzKqEu26GPs?=
 =?us-ascii?Q?SG/Kny6ZK1NaQWkTV3nkFchETaGBMq8fcmqoGuKZIa44wJtOk/GRUq7Ymu9J?=
 =?us-ascii?Q?LgrGBSDpGd4zwDkfo3iLy+/mozUYjdWZD7i66G61vSlFnjJbE6il6CE51sM+?=
 =?us-ascii?Q?TyChAanPhvN0yNLMdfjvaHeophZ1hMoDPgbfmJ+hGpHjdUQ8EBaJzVJ1Mb9D?=
 =?us-ascii?Q?PiIj34pvArju4oDnvW2mIvoyRdsw/P1KFA9EUqMDa2We4QjBglai4wvXgp9t?=
 =?us-ascii?Q?I13gwfXFTST+Y6qwpIM8JiQzjcw6/2+d+jEYMmU1DGHtEEuKjsfRW4vXG82S?=
 =?us-ascii?Q?2MAL3eAIKqgUWKw85cadmOm3rqn2V/Y/GOWvMrgggXFdHFUzteOZ3rnyz8KY?=
 =?us-ascii?Q?lNTaeQkNJNp+1+iE9FbpQbibHZhEv7M3DnOcsC8Dloy5pN92nrCsxnfWgLmU?=
 =?us-ascii?Q?XhqxXK+Z/Lb5O1yGca6G/V0NIGwyk7eU+QL+ppEGs+Jrl6++4yeDKESCuyT4?=
 =?us-ascii?Q?7Ip95z7PwxLGpOxbcolqT2mWsRvv4B5FIt6zIJr/Y/oeOzdvUiGsEVPrC/7Y?=
 =?us-ascii?Q?/I4V6gFc1xuGIhJ9YNe6jcDIK/RhAKiTBXqV/vzzYeCcaKE0Xv8bHLv7jFYY?=
 =?us-ascii?Q?bpfA0UZGbX3c/jaI0sYl0r5IGDYOKaS/yEE2nXkZ3ixqJtxdPq2GkqKJ1sWK?=
 =?us-ascii?Q?Ue/8VeK2FdSyS3NuKRQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOZ+iSefZmsd/ezQdVaKWum1Xff1J43vgc4ou9dDvHWsodRA02D9NjdpRjZg?=
 =?us-ascii?Q?bzUbCjwK+H3U/0IiS4H7/9oPnRpNDJwaWmMJ2VnpYndikpLZWFxn7eQVo7XF?=
 =?us-ascii?Q?5XchOcpz5h+tJiJE1Y3iA+V1WLSu19SiWg6icrRtOKHr/qmXLOopbYyDEQTY?=
 =?us-ascii?Q?su9/Uf88uFmi5DgoqXYz069h5l0XU0//KjANxjy8US8A3TQNKLYh92BqjQI3?=
 =?us-ascii?Q?p4blOtJ2sDlMUsP7NGuGjqB7+uBoWj7LZxkhXLJPhBoexM/EoeOXGHgqChmW?=
 =?us-ascii?Q?Yux+uMeZD95h/hsUbFn6q5sauv4I4TZYxwpB85KSjxbz8+xDm/bkmQWEW6W5?=
 =?us-ascii?Q?JQ0qNggrVWvtnxaYsDLgRQ45HeQjdcSHprq3ij79KYBB1KzL2WSBtiQ8jifl?=
 =?us-ascii?Q?Hh8N4yYkAntOLn/GFxrNC3dzi24gmQdq+bIN5LuPHJs+TgUWy8hVoDWcQHDb?=
 =?us-ascii?Q?S4Zqc16sGMZxuZLJLkXTxm32qzMfCfOXbVFAdZFVfE9imvSU2uyW2dvFCX5q?=
 =?us-ascii?Q?H83tokPK+LHCwt9cJ6JoC/g/U1Ojy7YnoXRKUrz4ihOuonzdwOiuArgDPcrw?=
 =?us-ascii?Q?3t5zt2+8re8Io1XB5hh6mbJ/ebGNv4h/TYOHpWnlPLkJ3N/gjkL1jju+H1Kg?=
 =?us-ascii?Q?hRoSgE+42/HR3Qyq3bcDqkIw1BguFkS0iFOtAEITW87Kmr9q4JPZFBWrzHtb?=
 =?us-ascii?Q?l+livaySltLy5UC/w8aLnDXKINUd9wHGaA1yqPwMsKDT2ubYh7CA//p02nQk?=
 =?us-ascii?Q?NRtrrR9AMqJomil4FNEaJUXarkT5d0ZjlvtCRk1Z5fxAcxBJCTWzQOqB8mDP?=
 =?us-ascii?Q?oWnGu+SSdTeeq5ILG5B5Z6M0Rz87/iV2+GXS+NW87i3uyKCJGoXXvpOgnLyt?=
 =?us-ascii?Q?DFsuSH3y9peBWi3J114y6Y5FHo1VaU8oca792eRk2rReJ+LPOklEoYs6m1gJ?=
 =?us-ascii?Q?57rtmM7l6CLA1vxGFlXQmbwyTLgOlfMDt3tEAMp9rv+jKUat1N51luTk/SLV?=
 =?us-ascii?Q?eQmBxGNl7Bwjiu2fXgfa1PECSxSYhC+sFg0siBSLWroJWtPr4DyWEnqxTpLW?=
 =?us-ascii?Q?zm1sOzxIZmRyG/8ydl4cRTes9eojuOkARzjpFiX5uFYLcOLpOh2MDj0vRP9e?=
 =?us-ascii?Q?/KbQUiB+yMFMEpYvXcwAMZhp6R/s/dr5/Ts3mjofiP3n2lby+Q3wUCQP7o+A?=
 =?us-ascii?Q?h7JXVaZuKqPN0gYzXDbW2NSElpG82DzMz+kDltuqwar2IfNSM7Bqlq7npTbe?=
 =?us-ascii?Q?dtF3R/Rznp2bQgSbbIntlFrS9lIohxGoeB37OE2jPXtmmcoRcQnPYK8EDPDq?=
 =?us-ascii?Q?mgKFuCTo254k2t/F6TLVZcDLUGPDcULQmyHWZqfKpMxzt9iQiaI0pGiuHVpK?=
 =?us-ascii?Q?4esF29UfAVTO8uR98DJ1/74NmlD9fBLEqVPTSpYHOghIY4VOa3MfjIZGY7Cc?=
 =?us-ascii?Q?WFYd7Z9k5854WOCKQkF2xf6ASi9/gkZnr+P9AYd98//zbRyCp2cv+tq1z+O0?=
 =?us-ascii?Q?at/RWf4zfJnINt2c1Uo6lGnJ+1dHdLAG6e1+HjTQGUu6ZMmh/YOMqYDy6TGQ?=
 =?us-ascii?Q?T5ygZJIWIYitXblAJiDbmKvsFDNEfP+gz82uYoiyrvPiMnHONctgxd+WikzN?=
 =?us-ascii?Q?Hqf2u5xoeHbYDN0ElmzCfcvvA12UNXn1CcJaMf+na7A12I6zddmmqJaG9H2/?=
 =?us-ascii?Q?7eBnJzlY1jyHPZVDkT9a1T64nw99XNwhXIDGsXjIxuxomjypSv606mnQpmNr?=
 =?us-ascii?Q?cg2BOQF7zrOA0RzenH1TvkN60/TMVi4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf07c2e-0862-41d2-2bdc-08de6ed555e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:06:08.1779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKKC7acYv+LKhhBTwtEoC3ohqNRME6/+aVOZiPMYdl75x/XDexF8L6lZW5nJ+Vr9gCn62jZWO/gYp39koB8oTYLQ2OF2aGqirNH781jad9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:34AM +0000, Ciara Loftus wrote:
> Commit ebcfb039afa8 ("net/iavf: use common Tx path selection
> infrastructure") changed the way that secondary processes selected their
> Tx burst function. Instead of letting secondary processes select their
> own function, they now used the function selected by the primary
> process. However, the primary process only selects the function at
> device start, so if the primary process hadn't started the device by the
> time the secondary process was selecting its Tx burst function, the
> secondary process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> This commit also introduces logic to the secondary process probe
> sequence that ensures that if a dynamic mbuf field was registered in the
> primary process for LLDP, that the offset is visible in the secondary
> process. This also ensures that a correct Tx path with context
> descriptor support will be selected by the secondary process.
> 
> Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

