Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787BE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9080402A3;
	Wed, 18 Feb 2026 11:03:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BC6C840299;
 Wed, 18 Feb 2026 11:03:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409013; x=1802945013;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WhQ2J5cIOEX1oTTXeKjRf0+Vbx8yIKsI/vnA+IE/60Q=;
 b=MYfoV0QN4h16FHyD7FSZZID2z0L444x/8fwC81nfgxfq6B5jTLkR7ZPL
 j/HA9+Vcs1He0zt77QVzfY7uL2v1FIiLdTmvBU4vM/mCdAhvxlYAP/PNT
 Z6mRUzJWUjYKqKLNP3UsNlM18uaRCbJ9Y7TuC2Bl3CxjnG/Fj/Chz5Au/
 cSFPeJdAozYh+jMr2ca1UwqhtUbivJY/B4pfdHdZ2ioEr+SSWYvZ8YJ+q
 W6eJcNnCpB5Q74yVxeKHcu1GadVmC2htnTZDibI9fJX/wgYqgDUf8sDIr
 dIMq4Jb8cA4KMdC15nOzBnxj9qBjFxgvn9xRBGOQqEXziSzdLAmtGgaNM g==;
X-CSE-ConnectionGUID: 7lLZYqnURgiM1JhmZMmo/w==
X-CSE-MsgGUID: NdXcJhh6TQKby4fD8NbxmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="89894711"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="89894711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:03:31 -0800
X-CSE-ConnectionGUID: LOK8sC7hTCeioRNClSuARg==
X-CSE-MsgGUID: q58mHr0vS16DWWdjahleTw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:03:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:03:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:03:30 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:03:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq9xSJ0WUhaFAY3naA3Yz6qFI3EJHTaBDxnbuTGlX+Wt1lRXeW/XO7j5Kl7rfq56QTCnxEtBZoirDpWmf/cKJ4B271Nq3T/FgDr26NfGBdbk4kM3+9M4uR71thx8p0FrkwMeJOLzgZ8puFAFRykCU8dkac93j9LBgwfsZ0Bb/w54rJv3X1AfNrSraH74WxJ6DebS1IQRGbD426Izr8xvZR2lHq8CJ+S30VCvtTkhqLvPdhVRTIt2quZ9fdLYi5drGhpLbfXTtfUUTDLIuQmWBjAmZ993p+owNnYHGIS/+5GsNfpzt1tw4tlXU1XwVnZXajsFxrlOP88SLBnTXyjkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dVlEwCeIuzrZxDi8ETFBK6nvz5HTK9YySLcm9va69E=;
 b=MNHS/i5Ci3mBTjgue+zj/fYO5t0TssM+pRWp4EL7BsGz1ENFXsCZL5Ktcb2huOoPmGkelTED6S5pWlh7oMsj1Wa40nWkmWE0mr1SdvCKDS6+ja1rpyqPWpqiI+Sv3bnrxFQgrEQvuuOIInmM+X0gntjKsd9CQCzvqonKS4NRTaPgReunOJyKQsNWddzvu4xjMlQeApwcBDVu4FebIYFotf5fOKFuRGc+NErIYVs/yIolqxHxNdEvdTB7aMq8ZEkEEShMDuL4bjDfVETfTQNn0QfCrT1HxX8Tb4Iv2FAGX+szj8kIob6vRRZvU9MCVl3eNSY3h+Ti904w2LWXt+X69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:03:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:03:27 +0000
Date: Wed, 18 Feb 2026 10:03:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 01/10] net/i40e: permit secondary process Rx path
 selection
Message-ID: <aZWOahR-YBN7HyK1@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0299.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7619e4-e088-4574-b136-08de6ed4f5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dFx9XAOPZsQrGN1JOBobaFz6gYjA7fUkbNFu1XgKRUPrLDUCPU3SuKoXQTT0?=
 =?us-ascii?Q?02GNbDxl1uCfnSaA0wBlBi6GKMKwETmOJoZnBNUIjpjMNNZTy3FJDMiFhuW7?=
 =?us-ascii?Q?kqMKr6m9CcbrcKyPCtajtVpQ0UWKn7G52GQSts9M8JQaS65SArg/CJQRLYq4?=
 =?us-ascii?Q?hPnnLBUfu7FNZXfrpZkbVZVBH+XpkOzOEbpgeJIP2ADfmEPoOebbATIxbmvq?=
 =?us-ascii?Q?pGN30kmenvEWYk9PhNERvp78GZdca5hUI1T09B2SSkm9UBdSAY/AupwQqaS+?=
 =?us-ascii?Q?rOj+zjP5R9NQiI+eyFqwODR2R9mKl1NnRIu0M0I09fPmd8QdoBkIC2vr1tec?=
 =?us-ascii?Q?rz+TIZ0dQyv0WGUwRUY9FX0CBrRzJVpqGJ2mZXvMq9IFpN5hXpY5Q2V9buAr?=
 =?us-ascii?Q?bgpoepK0DnkM51zV7YTu+iFL0BgiRqgy1ShzWv3sFJegKBcIRS/6vULvsaih?=
 =?us-ascii?Q?iRdAaIesCIIZX+44S1tHPgpNkNK/yU+8JLOznuOzLkbyiv0s+0VFQRY7KVQr?=
 =?us-ascii?Q?96h9JlMIF7cXRrBsWGFO5MWPm9nofHy6yzpXpryA6p9Wo9zl/lqMr9BcVdyP?=
 =?us-ascii?Q?/d0U5hwACit6XEOyAXOGdtKQqnAnYA6lNQeilz3YeL+MybJVi/EuIuloNZJF?=
 =?us-ascii?Q?ANViJPvoOsTvo8N4BU+38yNnQ2BngcEVqp636QM+IiTctmP/sP/jpGK6i5De?=
 =?us-ascii?Q?jSlDPX0P4GV9HwSrkopf0ZKslSo92E6YycB89MFpqumySZ2322jjEvVCy2/r?=
 =?us-ascii?Q?Yyez4DQMaqOZqTEi42skFNU0jgnzj9JSqNuPl+UvF9du4INKV2sY2ULz+ShH?=
 =?us-ascii?Q?TFXeeIYDBY5e2aENw+0FvG0Ok+xHmPDN+GfVe45sdiA1ttrRWBG2WpV3Vva/?=
 =?us-ascii?Q?b0D1jqzGzWeARiaX76dwFkLDI+3QSqpKMgjaosa5GtV1R2sYUlI1jFTdmWMm?=
 =?us-ascii?Q?If3Xiygb2fE+/k3GNpn+lquBh/+wbOR5yUVEUnORzuwR4zYTKxK3kbQXxSeH?=
 =?us-ascii?Q?QGP3WReq5Mog71AhEbgInwcsrwPYDqyNE6spt6dK0i2XyW5/NihxC53AYjRX?=
 =?us-ascii?Q?CZTPJA7UJvJqmf0qZZXYBV52eMgjeNhCiKCL6+9GrALvfyOlw6DibTTDaEHz?=
 =?us-ascii?Q?TVQUzPNOtuh/5JJBjE6NSGiYddRQnnK3uIwxmhHfDjE50gAXxNrd9OGNW4X9?=
 =?us-ascii?Q?oGGRPrjsBNewoJk+fcfR/vVV53xrPiTYZ/UX53jd4ccHPGt4ONyNySubJEHG?=
 =?us-ascii?Q?rfaoQcU8EBlTF2UkebmNgwu4gpqWP9MoCYKpucCM/aFwcjyhWBVZrS0IaKv5?=
 =?us-ascii?Q?YHlU/3Q2fiCnVIYhjx4EPAmtAhp4UxrF7Q5EOuVakgHapm2u08YV/Ej5W/NR?=
 =?us-ascii?Q?m39p1RSJwNkYiAIOdnbQp927hXvdTPuJsjqwS+JafqDcyCSlMpBDZ1ZiJVz/?=
 =?us-ascii?Q?F69SD493FpqsLuEMLoQ214K0goE4TfcsPnVNLm4ham1YKx2jiPUqvm0+R8yx?=
 =?us-ascii?Q?ECER/x1mbAbHud3sGAHhgdnIcfRF0ycXk9X+NygNvAiHXsbnnyEGrUBsFigp?=
 =?us-ascii?Q?jtI6NWAhYsOZJsEz1Wk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xZhPlhTYDJRUSI8JvR3mFxzHvfYVmyKXnxeXkOVtOkdTqMTsHFgi+wF1j8b?=
 =?us-ascii?Q?16dAXW7cQGQKZDcE9TcpPojBQwvKfThos5CggxF5pzN5hQBSL+w9lpk3BwF/?=
 =?us-ascii?Q?UJ4k5/xNNkTUzghAvFmPjMg+hWr3jm740TU5GxgGq15+sEzSTIFW3OLK6x4l?=
 =?us-ascii?Q?R4REdZzWBkuru5EoPyIC7SCVTtw/gvzNkectW5o+OnZ2YrV4ijtszM1JC5Xo?=
 =?us-ascii?Q?RH+2ye+Re+wD1ixXNJOmwRv749Q+iKrEhiQST5rdq52wkbd5EBJsmwLZuprE?=
 =?us-ascii?Q?rwYnzGJRBg89DThIgPJNtN5R0E6PjUhqPPrH/RphmVIb3yTnhAajQZTF2BfP?=
 =?us-ascii?Q?HQhSnsr3qqUwPW+uGMiUCUYK129/ugfm1hn+YLp+tXjMpYmMJWlh7cvlS/AH?=
 =?us-ascii?Q?gk+vIiHZg5oC5R0nXokeeePLFzNjOlVK5/pQn95pVcFAUyscknRLHj6K8toX?=
 =?us-ascii?Q?Q0E6bTAFWWWYjtGXRj9aHjiBtRf0ukdLIQ6PqVzYj+rs9wItrv5vcCgkHbiO?=
 =?us-ascii?Q?Z8C4J8KEr0uvTs+Mxv/k98aHYbOX2P564qXcwxXEwrNm+w/e44RkxITZPvtR?=
 =?us-ascii?Q?RIF5ZY4wJ579QKTjMpKrJo4BqiTO+PHtcSh+W8vWkJDl2fgl0KAtawSN0l0U?=
 =?us-ascii?Q?mMfwufgC6jXc+92kYp25b4hj82qkP31b7Q1xqaHgmomo3iyfhAHEedIcXsyh?=
 =?us-ascii?Q?s80mXRqLgaqWeJFyAb+LLoPXNkE6+EfnM0GU74LsL7j/Mgi/JCyBTtEZN+uK?=
 =?us-ascii?Q?Et9TX2H6tlqg5Tw5vxZGWtxhdAZIIkjRiB3P4PhQUs8Gk810KhI5tcxUOZ9O?=
 =?us-ascii?Q?nOHVfK97w8eDABFfPUL4oLv57OEk8Mb8kLTHNI3FTZMITJ4+7ddU5HsECG8w?=
 =?us-ascii?Q?oyRlxnhmt1Fqq+8pkI0AToAEhgrC/JODANGUOjek9wfHIIFjJr30dhouYhCC?=
 =?us-ascii?Q?y5PTKFVamV7Rc0Xr6uoBne5rN+TopFS+N9SpsKtBhGbFtsozi6MQnHkMkziO?=
 =?us-ascii?Q?X7UzX2SJEjwFwFe1xwWlYfBAsMkIbHgPLLMxEv+XNckG0YLg4yb7Xa+AXZDf?=
 =?us-ascii?Q?PQNXEVV9nWt+kjC5AjrT3tQxx7v2ZuHnZ22OimBycSTedtBTlyo5lijhSxRC?=
 =?us-ascii?Q?MFiWRX/9KeonKqzrmNmDtdgT6huQBq8+gNi/LIo+CR+d3TcOgT+AQRe7Ewga?=
 =?us-ascii?Q?H2b+xORY1fn4D2WNjnHwKhm8vBcDIlJrfPN4JxfhKFG7yAhLvfkWJaQlyR5u?=
 =?us-ascii?Q?zaIQfEKPWVIKFheWGt4dfXuzT++o4i8R3G+TFUKkzFRsGlXsxu56TqVqPLGP?=
 =?us-ascii?Q?sKbixmAzH4tF0jSNA3B2Nt3YUNtgppTd4W8XZvbk0ul0jAuwzuFQaX1q3cPd?=
 =?us-ascii?Q?bAM1HjOoFfRTojly6FX0daEKAb+lYy4WxcIsWkEC4TkQjQVdjHBPCeLJoZ2U?=
 =?us-ascii?Q?qzNxUHdQYNpNjA2HJjHo80+XgvP/qo6l1HuYEUTbddpy1EmjjvSGtzUJhEW+?=
 =?us-ascii?Q?5jzxbN/gAlO3fh53I+IkRKAFlk+1H/vinSxipO5qfy6WhOSd+hRwon2SQrs9?=
 =?us-ascii?Q?gPShgzkp85sjTIO+sZAMiR/F3HrMIwxeUr/PiW3U4H95ViZLVejiBaw8tL8F?=
 =?us-ascii?Q?5ttih0IxXD+HRgjRmmlOwteCPcheWifrPXSbqiUWr3G5/oGFzk9mpku03xn6?=
 =?us-ascii?Q?+5eEz9MUJmvMRGmTHmUYHT0K2fsb1sgWjmV8VHh+3KjbGcR/Mlosj1cxUmoz?=
 =?us-ascii?Q?WvGkvRVB325+myKv6ZjHTnhwLZd+ngc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7619e4-e088-4574-b136-08de6ed4f5d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:03:27.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ewgamvdPj4dX6s4KyCswORg8bwVhQfSSV6giUE+/mGKp0b/F9PZ0bNVfFrVXHQuq2qjlXPFQH19lYj/By6CSDS+tck2HlqIq/elo8lwKoA=
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

On Wed, Feb 18, 2026 at 09:49:28AM +0000, Ciara Loftus wrote:
> Commit 258f346f5d5e ("net/i40e: use same Rx path across processes")
> changed the way that secondary processes selected their Rx burst
> function. Instead of letting secondary processes select their own
> function, they now used the function selected by the primary process.
> However, the primary process only selects the function at device start,
> so if the primary process hadn't started the device by the time the
> secondary process was selecting its Rx burst function, the secondary
> process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 258f346f5d5e ("net/i40e: use same Rx path across processes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
