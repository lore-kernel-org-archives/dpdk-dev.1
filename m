Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A34CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 08:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4A3B4026D;
	Wed,  6 May 2026 10:06:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4B776400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 10:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778054798; x=1809590798;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o6ksD6pJcVi/aiPtWNb6waN9l7w2wOlbsn/Oh2sLYO8=;
 b=c7oXIArY6AYzXh3K1BKXHCuWSOszhUzttRTmcdCa/QoEycxHnWLk/Ge2
 p0MI8SyDFc5yZg+j3NtbWKNeUawKwv4oD+sAbUdPGRHsT5aWuUTbmUVEo
 oKTuglzugqsEFomfnlS4ZAMrSwldCCZt/702C993MJ3u06S3LgLj+4FP8
 Uc+LmxmcBvHAuyc0gdvE5fcsDgsfmsVB5BesxGyVuh9dx2HLuUYALUcdP
 JK7xkDKGjFGDSFEwYSgzzV4mSOt4duM4GxB4qBU9ULxZIeCHIhG+iQorR
 NcZm0nnuoMGXmUqLH68uNrq7KtKbLU6eMBMXmax6/TgLA6TznH3/SqTG+ g==;
X-CSE-ConnectionGUID: SzRnoYBiQN+pO3iLe7LYXg==
X-CSE-MsgGUID: L7I3m9/rRW+Hg4q9bxhfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90355399"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="90355399"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 01:06:37 -0700
X-CSE-ConnectionGUID: DT9CxVH3T9OzcHWAF/iKtA==
X-CSE-MsgGUID: k9BtlSVdST+0EM22K8Q/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="231520604"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 01:06:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 01:06:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 01:06:36 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 01:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/HyfiCSF0leo5G6KUV7Hvw/77uLLsh3asvGG+fsZxppuJWq9hXyolr3JEgdRxB3xyhJXgyrnkYwqkuPWfeWZrEtXHk7z2t+KMQutP5Yujg2OQfmoeQ1sLDnIMKUJ3kLXXrC1y7FQbzRgz71IRFfBzrZFjCG3vVZ1nIdrjBE30uLXD5fOLYTwCaisBf8hpA+AYzkvL6BhWqWTP2YIvVnWc2GzKyBwK+WltQC2jTwtJytUiwJ9Jgl7DW53OSMl78zG6mqlvBPSYaCGlZ2SeSd/v7SVXKRGjzOGddha2D2OsLxehHE1tguu1E1QOAZ9DjpCypxbIBt8OkuKpSXP4b6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy49OvsYAoCehrHTQfgpgkD0HHT+FaKADk1vQqUkFpE=;
 b=eVSQi1Q8NOn6ZRPIFjD/u3FaUd7dUvU0FNk6twm/U1VLUR19lKi89ce7B9VBzRl1TTdjDBtIfnZHCgg3Fx/pPab4dmd0VSoSa4lffh3LhlPMfUf3SKJ/MWRDUG7eL22qoaBzrIOE9iBOAOTQToL7Qi7AUWCqy2ZPPcXr/q/3AocQTap2vAeLDNRq+fV0sQFeKC9jb2RMdjdtU11zc2suszYGsH1uvMF2Mlxz4LzTWg3Knw3F77TvVG5kXyeD+2L1EZ5AaMUdMy7gTIJ5zMPTODZNqTdOBmZ8fyOouE+c9mqxeczATbokWrdVEmT+h85MrHOfF7b2+4+u4PlqHqVfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF3D6E0544B.namprd11.prod.outlook.com (2603:10b6:f:fc02::1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 08:06:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:06:27 +0000
Date: Wed, 6 May 2026 09:06:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 1/3] flow_compile: introduce textual flow rule compiler
Message-ID: <afr2frTWMC3kGKxq@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <20260506033338.480610-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506033338.480610-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0193.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF3D6E0544B:EE_
X-MS-Office365-Filtering-Correlation-Id: c9631029-ea24-48cf-c54b-08deab465f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: YxBqgiNQN5EdybHnRM+Umu+B+TedzMcPxzcDuu3qk/Jrwq3bcYwIt+7FP6rAFQmjkLQsfxJEW+uc749T/jkbIcxfhHKxSkSsUBTlbynXLJH1VcVjvf5wvfs/8t54mXKNFQYEqP/VhWW70Wot9JrLkbJWZRubsOLxXXmmmF+VHrobUvC6P4tK+Wmlqn5hHWWQOwIIfcuFqJAAqv9khg0tKuME8F2QdqYDZfaZYErsd4aZtnzSAPfxdtkQ3btJ4NsWAEipYw/8mEYqqNt1VQh9j2wi14JgePidhfgklPVhf4HCwj/+8Pv1IRPwUF2VhYFXDtXp08r15sa20P/M0AGr++qpa2CedPS70AvxTKYKxi9YPgXB48IMeJ3hjusVdfY2HSWlppD5qbfe/QvlVkMZI57MgXqZQnaNgWejKsCeHPUueY7AuFcIAb6svnh0N7yNONTKR5aWvjLuohRA/RTbTMm3HNxYCLaWz44Us2YHb3NkM2x69+uUJzb+oNfyf23EPJwnfJ/A3GyIbPA2TGecMYDM/7lAS+2gVVVEQjn0M/2lhIq77RwvSz4QDFkWXS2ltYoL/qrGV2IH+q1nXatUDE8YN1T149dQn+DmaYcM0QRg73G10qT42rB8ugvMtdfP0+FacsUOHiKX476r6rg7pAgLGKM1Wb+8NRcXnRhkejc3SdpLElfo0vFdfIhU9kTw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXZ+PEeBcz3eQKpVamlcZQB8ajkWQVqu3QBVr5O1FgCdahEkSNa5n47hIWT7?=
 =?us-ascii?Q?sNXr/T2CTUd86+bf2enziF4LZQ3I3j7LJUvHefig6wwZ18o8wVQDRhZmN+rB?=
 =?us-ascii?Q?t7iAGzqE851KwjU5Hs3OaO0ZkY7hN4+AI0idIDnJQGwWfZrVzHTIOMrbBvmD?=
 =?us-ascii?Q?N3yYk1L01hD2qMTL1Qrqi3RNj8J4l1I/kg4vaNyOstGSu3zSMU0AfoBMCSif?=
 =?us-ascii?Q?jlW7mH5ez2C9FK8bF5AzuqLcuibj6GLJqA/X0AEKA6cEIMv755CXtfdmfksi?=
 =?us-ascii?Q?+uz9PeQOUdBQqSvOXC88HeEL35AoXRMkntQKEMeeFGQLyC5BocHqDubXAvO8?=
 =?us-ascii?Q?VR/AtbtfJ7A+BnihXJ/IsJJNkuD9smjBBlDZ0jOpnED2MAc0PCIFq6LGmcKB?=
 =?us-ascii?Q?ANyHCB7+J10Hfc6IbM6KrODd8rvLde8irK8AO+xeFMiNSlKx7OrqzyyhzQ4D?=
 =?us-ascii?Q?XceniPWvrd0cltn/9tP+5E6JrQfzSTa777MPG+JRDBmJJd/QJmireVoViG3t?=
 =?us-ascii?Q?x6w2f2sJ/7NYWf41P4ESrqZyBaK8fbZvxIuN1hHN+qb6pI+r+inB37b1sL6A?=
 =?us-ascii?Q?pgaoRzFJ8p5PqgExfA2DLT0OyC2zdv1+jZMFhPJmcIf3Q/VI/yuHVA/kXQjL?=
 =?us-ascii?Q?bGN/LikaZFEWPbRKu7ERM7EQelrU3YcVgsKRkwrPuX/mCMAO0N4Ff2LECDGh?=
 =?us-ascii?Q?+pOlC44Z6e+EomKzavJq4Y5qcwCVWhKqMnNZEKtnSDF8NB14WH4QyEYRKzGb?=
 =?us-ascii?Q?TcxdSE89G5z+S+2EJh+kGKK+TlYfqxq31Z0+weiyT1YtoZO3IIKdKVLl5ITE?=
 =?us-ascii?Q?dfyZtHVlcOQVHyB6nUmDJfpz6f/SAY4MYK6uSmyPhm/m8HUnYeLicDpzPmA6?=
 =?us-ascii?Q?1vgOx+6oR2eFp+P/X2fGVgZym46FSQNzL4NZ/tgr1xNkJTgiIa3qIOoV25RU?=
 =?us-ascii?Q?q49NPyUm8sYndri/PFLJDCY7Zi1c7ZYhzRJ8621iOSg14y6f8hR9K9FUGEPF?=
 =?us-ascii?Q?XEfVKtKoCiPiRS+4wfxbWx47GnD56ZhlCFy6F0TJPmL7VMGQueuQtfANUZ4A?=
 =?us-ascii?Q?Hk2MBWfMcL0UFKI37cdtzsLqow2+/FzOK+w0jvQ21Wp5+d8av8KTAd3PX+u6?=
 =?us-ascii?Q?MkBXQw6X4sPHMgyptGUz1z+S0vorCI12w//2jQNoxP/BT9mInGt5y9MI0c9r?=
 =?us-ascii?Q?7qAH2GeFYGqconlGE+BSrQVEwwX+tTu7WF8ZN9C01kiitJLA7oQ/fzg/p4HJ?=
 =?us-ascii?Q?dgKwcg/OUCdwiUp5ppYHINZ/gMZl+Qtd/UY3Ik7LpfO+kBibZKHZV83DJ9+h?=
 =?us-ascii?Q?oN+XjG0UbFeNJCOnJ9PKOPMyD/GxXJQHzJeRw3hptUE+cwseIrGxp+EyfCcF?=
 =?us-ascii?Q?ds4aoxcfRlNwLfHGNhiDC14STTy0UXiVHYWIk2IItuqXnEY90lTU1T+aEdjq?=
 =?us-ascii?Q?RHbalIRTrpw5/Ch7VKdfdmgZkzeEq36Q4gjNiu4Z2+TOCU2QrTxrTKQns9ga?=
 =?us-ascii?Q?GvvwKAJNmoFUTmBPVLwdwaRm9OCx59LLuA0RnDzPPJ0gMJEGJYb/HgMMFWwU?=
 =?us-ascii?Q?HdE1ZJJnVHODEecUEOlBOXJs+fZiqYC94Kff3dFMp7HNpJXNV7nHJcjuN9xb?=
 =?us-ascii?Q?c9ZHVNqF2T5ilNxI5PHvIq5HVLY7fwkMjCnzDrrYClNXYFoOd0xVqc9ycsQT?=
 =?us-ascii?Q?TfRtfd1ahK/71/vCLdcW7+mcRA1hAQlYFJgx9H8dm+ElE/EuAEa0eDfD2aHh?=
 =?us-ascii?Q?fsjcMI0RniOj5GOW9TKrjnNDnzp2gBw=3D?=
X-Exchange-RoutingPolicyChecked: dsRGoaufjYVrF2CD4XZyx8ZgmXsqgJhgj5ABhxSWJn4l6ewoIDxF8OKiB7+tKN7zWXHXQLstJAoxLixYP230jYHyHJ60dn2z6xWP9sVGQLzJpZnnvPr9lbF38ms7vWF6Gl+dptZFT/2VZBzQvQd1vion+ReuMv5m/IdQb7MRrkdWSjoeqnEBQwj9dGXaMlp+bt2LEaRT6VAUk/dtpTwFNxUHDjzeMEhv5ZlAdz7h0qSUcsslsMrJBz/rYjfHDh7oKt/ZvCd9re/5OyCl6IVbKTg0cwodUsPI/rdMk6k/u9UwPtTs+GmzPeH/OMZSmy/9TsDmUpFbcwbIfzhhnb/YtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9631029-ea24-48cf-c54b-08deab465f80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:06:27.3768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u5rsUZVEIshLsN4XSwOgBu3GZIf6p4/0tk8Dh3CObD/YCJ6TYI12H4VK/zuocKh/HTtfi4aSWY9/Uca5+FDc2M4CpEXfAsZQqrVxzX3g14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3D6E0544B
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

On Tue, May 05, 2026 at 08:29:55PM -0700, Stephen Hemminger wrote:
> Currently the only way to compile a flow rule from text is to link
> against testpmd's cmdline_flow.c, which is tightly coupled to
> librte_cmdline and the testpmd command framework.  Recent attempts
> to extract it as a library have produced ad-hoc copies rather than
> a clean separation.
> 
> Add librte_flow_compile, modelled on libpcap's pcap_compile(): a
> textual rule goes in, an opaque compiled object comes out, and
> diagnostics of the form "line:col: message" go in a caller-supplied
> buffer.  Accessors return the rte_flow_attr/item/action arrays
> ready for rte_flow_create(); a convenience entry point installs
> the rule directly on a port.
> 
> The parser is recursive descent driven by descriptor tables of
> items and actions, so adding a new item type is purely a table
> edit -- the parser has no per-type knowledge.  A custom-setter
> hook handles fields whose layout cannot be expressed as a plain
> byte range (bitfields, indirect arrays).
> 
> Dependencies are limited to rte_ethdev and rte_net; no
> librte_cmdline, no flex/bison, no platform-specific headers.
> The grammar follows testpmd's syntax so familiar rules carry
> over and is documented in the programmer's guide.
> 
Was there a particular reason to avoid using flex/bison here, or did their
use just not make sense? In general I would prefer using code-generation
tools where possible rather than maintaining (metaphorically) hand-written code.

/Bruce
