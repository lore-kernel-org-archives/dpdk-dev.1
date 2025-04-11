Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C5DC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 15:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C8FC40A72;
	Fri, 11 Apr 2025 17:39:11 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by mails.dpdk.org (Postfix) with ESMTP id 927724025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 17:39:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA/bzxWIAtKa9pyiILld0ELrRV/iDfpEVxp2KdZThy/RQOtbFGvbR5qCvT5McirE57XKGjlMxyjy8ft0ZcqRczhP6M3TS/pBrTjN1eX0f3M84QpyA0IVodzWFzsPeCgMsf84+7LZ/sjaZNPTqVqFmCh3M9QPvc6MAMofr1GQealrSggleOJHKdcrDJTNXlSd2qyYHv+thfiiEhW8SSL0Kc5fOQDBlpPo8AxlRBENeKc4NR81ABKKPNtEy06RXiQcPvKwuUcQI9Yl3S1EEEEm8djKVrzs5gYyfeWA9FYBBCdKLX/8x16u1vXkjQroA4SrWmIYxn0nBacq9s4PEmyICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jshiHTHq5+JC7MrXB2ok5pxkanrA0CGs03hSsJcaYo=;
 b=LwE+8tII2NDU2xUXBBoLBLvGYtLJEgOuZ82S7p16rKz5qs+01HB1kAP/YpB9l/t88BS3ZlRFyQNWTxJAJFELNrQSAEi9pyWpsC2YpPXTMeQvOfNQB58pdIVHqVnzlACWaETQDevulj4H99VDSeV4gdZhgc3ygTTZj8Iiqw+YJA0yVqGyNj4DiDboMMmMzaNU6JC22cfYJmtw5zo6FW14AqT+5U9X/d/K1740NL7lEhUKpjoJkMI3uS0jWPW2o1zcw+HbPK8B4wzeWWwdCWOyHcY2FX9wvLzvZHsm/4I1TQB0QfL/dHMdzgyBpIs5+4dwKjg8oTtBRZb+b968gZbCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jshiHTHq5+JC7MrXB2ok5pxkanrA0CGs03hSsJcaYo=;
 b=LbEdjND2K7TzFH4jgnKKKYbe8KDIBDwhJOGOBt+P7CuFDWgodqIzP0EBP/q96/exG5zEoqfr//lawOS7ExBGY2bDR7cf2zj3orpyY+D1qKOtdKPXOLWe+PGbCq0UrNsORsuY9MOfMLAbwjEfVjwnfxbh63vN+F0CP6XOu1tS0ePijeX8yqPEnHNirgwW02RrnN8GCQiLuVYfOSSLTKI6ndCEfMuZe6otnet2znSNsiLQjwv6ulnGNQx+/b02FbNz+33FpF9lbZxjchvLto0uxhk8kqLjp226XW/wl26CNe220j7b+p8QrBBty0c6XK7/wrmkjup7k73eBBPhD4LYPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:39:06 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 15:39:06 +0000
Date: Fri, 11 Apr 2025 18:39:02 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: "Richardson, Bruce" <bruce.richardson@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
In-Reply-To: <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
 <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: LO2P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::20) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4f8a36-3ed1-478b-f76d-08dd790efe53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IguB4EU9ipkhycRBB8QE3p1skb8krxID9PcwpPeSowKdEQTGYQhNJouY8Gvq?=
 =?us-ascii?Q?EBCFV99/XnH3HcOwH+5mwPTvtZWvrKrdrTtzPqgbBRY4JmGfR3Ia2CGWhTZ/?=
 =?us-ascii?Q?JBzNxcePvL6Xl38zoyRfkLfP+v8X7HKphxUVg+uqvHV25p+0b4hmedJqug6y?=
 =?us-ascii?Q?c74TatdaF+KHkJf2YEZLY8oUIKp/gKi7nOPgcYp5iNuP4Sgj3SOUin6DcnXO?=
 =?us-ascii?Q?M+Is2mnKc3au5iIRuBBaLzILn0vNYvpeUZiDcLTw70Vaexo15xlZlu/UVTgs?=
 =?us-ascii?Q?Oikj/mQy/2vDhMipB8leKumahf1rVyK6SLPV8/CKQO1ChAaJojAqPkoar0Q2?=
 =?us-ascii?Q?lAkqDz75I55G+4R6KKAVqFf/jaLfbKwCWl5eDuPJlZyIQcjoeVUiBB9pfAKY?=
 =?us-ascii?Q?gHFVZfcP92WA9wVb6TF2Cx9qyQffpaqGZ5SJ5x3/uF2+jbAKpLxDzwrHNO2G?=
 =?us-ascii?Q?DLQiVDgusKWozazKzwMxmnyReqR52tMmDTc5OHr6bRlZzt9X9d4iUINpe+1L?=
 =?us-ascii?Q?rv8H5L7POxBvUu13N+uDTRjo1pcpywVOpafOdUAT8eQBZZjygF6733yVFrp5?=
 =?us-ascii?Q?PLsTjXy45zWzvRIkdAwnmOsUmx3EYjzMtB0x48U67sxRwFXLITKJVjwhN9l9?=
 =?us-ascii?Q?ZWx/7dhpBajcruwuEmmZBo+52dOhAVVXTcjHsoZmj6EK3tUtWiNpKTY3YO9K?=
 =?us-ascii?Q?gu/aJUbfpfX11k40eofWkEfaFMSWfGfScrDqLs1t5X2d5odIE9InbmoQz88G?=
 =?us-ascii?Q?lp0fIDz1AGTBuuIXL2WstbtFiCx7fY2sB5Rs8bs8Gxm9YXIKhmY8bJSDGHZO?=
 =?us-ascii?Q?0mTzWElvqEcfznz+ZZHO0xED9G1xLn9mA8cxYGGHa98+/SmmcfgnmnD5Yfwj?=
 =?us-ascii?Q?SQv/t4DAsDhmPAfjz/TY3bLO/OQlJZf0KbToMBISVAfTMRb2Sju94BVUnUHi?=
 =?us-ascii?Q?J7pIEtEQ6OrVYR8ALgXPH50ozg1caY27M6B+oCHVNZKSuVwoMevtpKagS/aI?=
 =?us-ascii?Q?ZIYJdX7VlK8vJGy64jRfAo/AXXJHXH0CWGYk/5VOccHUPyRWJz0Tmnc1ItEr?=
 =?us-ascii?Q?svC00I/p9ITik/QbKKMhsjlxh7chiCJs5PgtHzcb/JQFcSU/6BLoc035Dq+n?=
 =?us-ascii?Q?soDYA2cUtG0bpSRKEyFR+9YuTa4gDmwM/BGjr33O2+FHAUa/5t3sjGOJAMcz?=
 =?us-ascii?Q?9nQt2gReiwaU/P5FyXR128P9MkssZnY0mjpX6gWQjqEJpr03Xrjfh3hOAk8A?=
 =?us-ascii?Q?jgJa/xcNPdNET+/tn4nE5e1q8rwHYZ8Y4wcVzOggUX7wwmeET9Un9JJVY5wl?=
 =?us-ascii?Q?SkxazeSYhMZRp27j7vonM6eH0wuf1DKXb7EIqF9gTK/WmGfmrvulOl4cc+LE?=
 =?us-ascii?Q?6hLwwHfTMSCjsZ/rZGierzae0Wotj+XfndH7a8PpLsOW08493EEjVGO35YcU?=
 =?us-ascii?Q?GDqAqAnz9os=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMvk4TUklsCaEELhIlQ0pw+gD6WU1M/HI4PakuDyOk1KPFiGXdMfAQ/+pbXD?=
 =?us-ascii?Q?oumRA3cXqbet52ygSpvIfdZqHb0oYD3gxVkxuqTDXHWnoFOzAtQlTw+DRsBI?=
 =?us-ascii?Q?j+jft+qzFn8Sj/szBgda/S5sB2DsQA2sZVGZN0IHGFThjNxwc93VHQngDdx6?=
 =?us-ascii?Q?DCUZ+bc4m9AV0wTkf3NASuU9p29yj2oYz3RQ9j9bVs71R1oGTwX0Rj4sbPu9?=
 =?us-ascii?Q?ZZlr4pVLDhmj5L0qvagKjhInZ52DVBSgRDKpAC+DOULa/l/4rlknQjVp8ecF?=
 =?us-ascii?Q?baIAOA3oFLyU5au8hS2n++wqdqOMpaHv10nHi+m05kADvdvkdB4GCI3SjIju?=
 =?us-ascii?Q?sKybL4XCoPDXgZxzBR656aBOldynDx069z84rhjJeIXww6hK+WLvDdfmbgNC?=
 =?us-ascii?Q?nm7tlG8nVkQUPae6rD5ZhSSeWlCKtbGgsRhGzmGazNfWcIIA64nq00/4oEH6?=
 =?us-ascii?Q?FzFnRox1JImsE323Aw31DtQWPg1yrD7QBQOgsO9DhSixk4R/UjizKz7LaKoK?=
 =?us-ascii?Q?UqqcvQ5gvyJRM9SyjNDRn+3zZc6h8M+TtNj3KiBFOl9VjY4InK9bLm95upxb?=
 =?us-ascii?Q?U0PhvAI/IYQXlH/IcxwTxgw2wr3pgMb1JkvGYCe98IGPlmH0c9CcUTaBDlI4?=
 =?us-ascii?Q?w+XEpqIp1DBd/5lxaEcQPMIC+4TkBsD5pQN9AkoRhrNBaZoN8drAmRHJ09k8?=
 =?us-ascii?Q?SyUua7IuKtDNueZeWorKazfr84EPpTkAyxz/qxDoeYjVeQYNfqJImucszDpq?=
 =?us-ascii?Q?wOzWtMIDjB6A3/PtxFrEbYgWZZLEb0mb8RiGM3yLi924wWTUCbf7+m6SbHIk?=
 =?us-ascii?Q?MJrfz96Wu7rzFFZFsRocTxg1TvDAwr2EaQgvHq7NdGz8JXflF4uuzhVkI0mG?=
 =?us-ascii?Q?xBFG32TP11CT+P+3kV3lOD9QJfHTUNLqOCos4e+GXIvIk1p5UJfnrK09Zx+z?=
 =?us-ascii?Q?l4Ab0BX2Gi9zJ9fIFVXv8j5Z6PsT0wir+/am0+nxCu87rSKbDuL7tvLyxZwF?=
 =?us-ascii?Q?V5FwCGdIQLMtirE/EY9VdmATLz2Ing7eLFVSagyzi975uWMQPHdndyrJ3irR?=
 =?us-ascii?Q?1+xfn+6FE8TMQG78Jw3X6M3gGXNvAxVq5CvXW1CgeK359fhrXzbq6P5SwaZu?=
 =?us-ascii?Q?sAZmIuodssR0RPnGguASIeR+wW9zEjUJ4fGk9a/pUKKRBY5ry5pYtMl4FPEZ?=
 =?us-ascii?Q?9xLcwujD2yab+NQerECk1pJ1/S72ve0rYMrkxKNlDd/NdotQKc5JGTKAqUfX?=
 =?us-ascii?Q?HTez7Y39c/WCK/QZJDlhbJ44OYsF7gD9yGWa8DHz4AXWnG9+U7T759LtrTYy?=
 =?us-ascii?Q?5T5+Po+McseWRvKuwm+omN22EbqDYQxvPiH+Te3eVhZ6Zehtgi55SdQYoE0o?=
 =?us-ascii?Q?X56bakuj6lVNopUKobHgdu06ukER8Vq38/Rv418gOzIEPI9kGNuAf8vp8A15?=
 =?us-ascii?Q?ffENkjIFz+gT+iW4KiI5Dv2mhNMoiMJy6BwInoPSbQ3Yvdsh7Y9PTae/r+RA?=
 =?us-ascii?Q?OScTJw4mbihjFsIKZCE3t+ATkVnM0JIOlvsHzgHvRFzqNZZz2LNAjm4OLpPS?=
 =?us-ascii?Q?oi4fSzoXHXPGEVR7ueYFiMxFqE1G5l2Hij53pp4B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4f8a36-3ed1-478b-f76d-08dd790efe53
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:39:06.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x944wofyLZMMmm+ccKU5CoXzk8Vh45uPLTvs559/PRNGXYNubF966AS1k5WcMZUuQo7brR2vIFh5u8msYsfQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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

Hello Bruce & Harry,

<snip>

>
>> My concern is how to properly maintain Rust crate once DPDK starts to implement
>> it's own API.
>
> I'm not really sure what is meant here. I don't understand what "own" word refers to?
>
> I see it like this:
> - DPDK has the public C API exported (and that stays the same as today, with ABI rules, version.map files, etc)
> - The Rust crate consumes the public C API (via bindgen, as done in this patch. More detail about bindgen below.)
>

Bindgen cannot provide access to all DPDK public API.

A good example here is rte_eth_rx_burst().
That function is defined as inline and bindgen does not translate it.
Also, the function definition references rte_eth_fp_ops array that is not part of the 
public DPDK API. That means Rust cannot duplicate rte_eth_rx_burst() "as-is" and 
the solution can require extensions to existing DPDK API.

I added a new public API that exports rte_eth_fp_ops for a given port Id.

Rust implementation of rte_eth_rx_burst() does not have to follow the original 
approach.
Usage of rte_eth_fp_ops is good for C, but Rust has different methods.

For conclusion, Rust DPDK infrastructure cannot relay on bindgen only and needs 
to provide native implementation for some public DPDK API.
It can be easier to maintain Rust files separately.

You can check out my Rust DPDK version here: https://github.com/getelson-at-mellanox/rdpdk

<snip>

>
> Next steps are to "allowlist" more DPDK public API functions, and start building "Safe Rust" APIs over
> them, in order to expose an ergonomic and misuse-resistant API. As you note, this is where a network ports,
> lcores, mempools, and ethdev configuration are all required. First goal something like "Safe L2 macswap"?

I suggest to set the first goal to initiate a port and run simple Rx/Tx functions.

>
> I will make some Safe-Rust API suggestions for EAL, and send a patch sometime next week to discuss.
>
> Thanks for the inputs! Regards, -Harry

Regards,
Gregory
