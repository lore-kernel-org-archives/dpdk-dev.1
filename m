Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5966C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E26940299;
	Tue, 25 Feb 2025 16:43:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A8FBD4025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740498187; x=1772034187;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SehyVUl9X8BgEjareY67isk4at9FlY1p3m5Hx2gkUaQ=;
 b=YpSuhQbTFjWzF3elY2dvONA1rB9OAvuW8Ctf8z9Mj+6z6HQlpoZ4sUEc
 FwIn+lJ6mX0uG33MYezwBWFFzv+GhglFwkzscSA7pdKaiORmlk6YINcxi
 n01+w5XLf87fBS1yfRjemkRrusBrQ1Dfaw8Mn34Q71b4wUeRbZA2vEqb8
 xho7osfZVqIzGSi2r+sk/WeZxSgycoTpi+o4rll/6CnVP0EClYtDgwwAt
 Pwmh6Eof8GvYgj8zLTTSgh2LL+7wW55h1Z5O61o3SgLn75Rc2ErZ6DQeK
 2F/oxgNq+zlCWSVxRQuQG4kL/0PfGgo07E4VXy3uuixkPcIf+HMuz+B+v Q==;
X-CSE-ConnectionGUID: A0xDc/nXQE6KC3axoerR0w==
X-CSE-MsgGUID: k6/HnYLJQAKlK0Kg26Jm6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45094405"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="45094405"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 07:43:06 -0800
X-CSE-ConnectionGUID: Tt3h8H+5QVadO8rEJroFWQ==
X-CSE-MsgGUID: Q2V/dX5tSOCTirzWJiApYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="153606575"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 07:43:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 07:43:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 07:43:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 07:43:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRTABXRVfzVuJlJiX5Bp1UYZA1zLA0I8HExBnYhiUhqPWimpuTYWLi7QsGskptIxJiMQTFUSlEyno6xW4gHcljb9bleJrsGl1zRTHaBXR22Xa8jsY1BvieKkaTfhRqKewCwreiBBtJcy+Qgh3nWLDRo7jEgALhS3hMfAWx7WhD6aDVdaMySeUGwu0aUrjrJT2Xb6wr0etuXsgE4gAAMACd2mxYHYCiwXSEzJjY4Sc2FywmMVpEMSE6ofMpm65e8ROAjbW3OipStdWQIkCU8GGvT/RBQGuOYqF1tLPBZPkCG36dhxHW6y/PeBSBrF0375tBZ73pZpZiKqdzg7I81HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GRs659zaJNJ9vkWKDBqt0VuasmEpayM8kxyp9JtJu4=;
 b=hj8jE+kY8zF30Eiyzwm3R6LCSh+7RA/afZMo/HOfyVWl+Wx2cXOKeuhGz4RiLyuAOj7SnfMfJdwI6nCrdsDq+Jxz/BSb8+vOvrHwnh4ne5dK0fE1VtazlQ7qFA/G065ShClXsMmeHv/WZ1Hb9u/YVSVa8rdBEVcX8+JaBMlR0dpe49zh4Va53aysDWSI1pYeBN84CJ4Z3wlmHoYTreN6wgHi9VPXFyMYuOHkUFwDN8QdfeXp5IGH/MZNzZnmM2jjEi89KRQWtedNLdCGrk8Jm3g3jQu9Bx4J/y+ZPOB6Gkpyw1h1X3jAblT5RQCUps81o+1h35zFL8vO/AFFc0n+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 15:43:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:43:01 +0000
Date: Tue, 25 Feb 2025 15:42:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>
Subject: Re: [PATCH] net/ice: fix incorrect mbuf cleanup function
Message-ID: <Z73k_zxfKwcOEj0n@bricha3-mobl1.ger.corp.intel.com>
References: <20250221160402.855510-1-bruce.richardson@intel.com>
 <e63850f1-cc15-4678-bf91-1f9bdf44b69a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e63850f1-cc15-4678-bf91-1f9bdf44b69a@intel.com>
X-ClientProxiedBy: DU6P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d18d145-478a-4a6c-b07e-08dd55b315a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cPQlo0Pp+IFk7yk7QwOFU8QfpPzeUlAinstBIQjpEFpKuGwYWm9oyZrUHjoM?=
 =?us-ascii?Q?i25x3miub+f/hH/wDdSAGujyNHQIbnSz/1CEWYXViD5vpqeDxF4I/virY5Bl?=
 =?us-ascii?Q?+fAO9y4j7pnk0D57EAC3acFDAqveQSLK7+herc23OypMW7TnxifhOepU3fbS?=
 =?us-ascii?Q?Zurn/crmcR1csEN6CdOwhW9ZQsAGUq3w+x9bTUX93TfVFaIS6oabIH7WzhHh?=
 =?us-ascii?Q?zODov52JQq3fpsx+RKVUDDoA0j89/jA1k/xwTbbCnhvqToKb+8896O+vxrbA?=
 =?us-ascii?Q?cmNQB6CHWUafKfyLAYBP1/cxCItHm0xRE5n5FpuWKO/GgTQKM6QfRX8NfCp9?=
 =?us-ascii?Q?MmFvVxnKqBZ/Re/seGLftodcILDAnZzvRMmkPHXxv6gNpEO1YbU8UJvTxIS5?=
 =?us-ascii?Q?QdowJOa+D/k0iBMLc66O5litCG7rh4jitBrqd1jwiBWYk/cPWNqBovD8dY2j?=
 =?us-ascii?Q?w9dpmPioyWWn+uBYjv5D0QOwymnWdu1B4QR4rl1XR9DQgMQX4KcioWI7THWU?=
 =?us-ascii?Q?oUlsuOYyBxpKHnSUEkyhOsxteXbFIQXDtwZxff1fCspBBfHC7VMMVD7fmp8a?=
 =?us-ascii?Q?1ci3F2+jZh53Pbkon1Jg0hHgVZQ/CmFh9bQC+o6j6fqIn+usP+cql06brqnM?=
 =?us-ascii?Q?k7DUgTzYH6D2UPyNtYWTHsI9CFG0COroR8vvQS3H/30grxE2rOoq17uP743n?=
 =?us-ascii?Q?vLfbjSEUS/6RConTKCcSF0T04vvp2ndOzgHcBIr6Y+HC+L6CzSuNzxHswwA+?=
 =?us-ascii?Q?M1SatJGoYDPPr4lTTrJeama+SbTUGJSdF17suopG3FeoKhTlRFfhWxD2ZiBx?=
 =?us-ascii?Q?tFfs34J5e2F2FvhnJcsG/WXrOcjp3rIv8EmZOkWAQU6qhzQz0v221CGh7E/y?=
 =?us-ascii?Q?ItcXu4kSfAZRE8hymhB0l2Jlhb6HtwpCRXs+78B+ZJyPSvNE7Jco6Hl6oiKe?=
 =?us-ascii?Q?J7bqn5BlbJEVlUibgHzDb3aW4Ehf25bb1rMuq3Y57UqCyvnh59KgPPtyFRMs?=
 =?us-ascii?Q?RlqVPKQqGQouZnsRXuncHzBeUO+CZ3YZv+bgqBOpATq+BzZpjg9B5wi600t+?=
 =?us-ascii?Q?nVytHrmha8IKs1zuSyWsIdD6FK6cpDXHm8hd5wZJKj35HVdHi2Y+Ry46/Jli?=
 =?us-ascii?Q?CbmAUizrMXVILUZqa0TW7bH2Y5HdRI3I7e4POywY9oSvWThBUPtPkjA3VE8V?=
 =?us-ascii?Q?yFdiIUES8oAZcw9X3hybrvMXJjBfrTtpKaZRPeJbM3P8ex99dsJORHfxhEEi?=
 =?us-ascii?Q?XitzSZAhFr7AzJZ5v6Awsbrk9f33qHLJzwG71RejOttbI1vdHLy8hWIiTbqc?=
 =?us-ascii?Q?Xfac0o6++AXp3aWH+tRBgT8tk3pUoLoy4iRcMT7y61slSwumTw0LevPzRWW7?=
 =?us-ascii?Q?o3BD5Vu9oMyU1phOZ+ScE8emC68+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMXxpVHHc1xrvLqLv9H6D1TTHO7Gz/CUq9a8WsygaQgXsKd8xpI7U3yGp05V?=
 =?us-ascii?Q?Nkcn3S9Lf/enb99IGZ1/JWJYX4y4/Rxk/7q5OpRgQqUhj+aZSvmLgmIudaKz?=
 =?us-ascii?Q?WJG7giXIEmOpEzJ73vQTkCBlCqM+YnMgy1Dqh/g89GzAh7gi5RDJmBOH2rmD?=
 =?us-ascii?Q?w/b4eRCNqkIdpvAz+1h9lW/lUr6imbxxstdGkkFG4UDVP0OzZY2rLEQ+y6CN?=
 =?us-ascii?Q?SVWXZ8yreZguDqpoTbK3O/mVITPajaNs7PW5E5DbHuZ7a1qfdutM0b/w+MW8?=
 =?us-ascii?Q?RaV5iIaG5DGCWTGcKMZIeSgLPiMhw4m+awrDRenmEHPSvFSASTxaDVzZnQe1?=
 =?us-ascii?Q?BEcd59fVERnFaoQcTFk0Pws46RYKKjDQGJrxR5Yei5hlxWOhIPI4N7uNukIZ?=
 =?us-ascii?Q?ylguw5xCfOPxwFSk3Xgg8ey7hKWNhLaWzIZt5ApZ3s/nqJhs2fapRiCGEly6?=
 =?us-ascii?Q?RZ50WkVllc348rtBLhU5kRUI5Iti+KyAvtvt6XstgZihyli7gGytVL//N/uX?=
 =?us-ascii?Q?IrDCCj0le6PXAs3MJ7XKC2wrrPp3DlemFoUXLw8TVtfnuqoR0/k2qtoiRbzW?=
 =?us-ascii?Q?V2I6BfY+Ef0yh9aMw8DhassepPG97AHeIwtZwTCPk+NajaDqPTu/HM2LEbqo?=
 =?us-ascii?Q?857mkfIklu4O9omgw2IsksRf/s6WvBqv9z2Xhu4X7U321T9eBFGYJu8SHst4?=
 =?us-ascii?Q?01uOpkcohZKg/dcpv7Gh2azfF+Bzk3ZK7XwVFD5GwB50ZzQx4Ox4Fr5xYPc8?=
 =?us-ascii?Q?3gUDU4haNVhPSiIoiT2d6nyD1Zi3S6XjJPuOZCs3/fz2wK+WvaOYIdra4Rbr?=
 =?us-ascii?Q?mgrVDAUvGLs0rrozoJdvUdX5zXcOa2l0p0SSzOUClo0i/VkWagDw2GltfmfR?=
 =?us-ascii?Q?SuC9oDgP6O3gJJBlsmwOTZCCQvYeNEzTZ5DhQsY7b6uVdnktlT7dzrc7vVWA?=
 =?us-ascii?Q?LvrPFnVAT9phAV2ZGZK/ri9AY9u07M0B04L6OcWiLjVpoV31qlSSsHyU9p/r?=
 =?us-ascii?Q?IF5yaaSd37koW3fKS/TG8movo0hcJWBd4Q7QfBueban2QckjdKHFuFWPdM7J?=
 =?us-ascii?Q?OHgZf6SZlLbJgMuKguFI4yuhEc20TuFo7gwyoqgHEarfeVC1iMWQUYWOrE9w?=
 =?us-ascii?Q?VJWW0PPs02FUvSbKVuHEgyRW1rtAi31gP/E1lw33iPPoKkSlTLpyD46zA4Sb?=
 =?us-ascii?Q?kcLrEEkhy+STkMF+ELARH6nLwChnj5qomvMY4UjGaDEx1I1vRCBDG0EtaV9P?=
 =?us-ascii?Q?oesjV2l59xOZmF2RT1KmbxwBpPK+8gqU2aYb0i2bwn6vt04dpZU+5LLc8Axp?=
 =?us-ascii?Q?lfSctQ63cmTPM05y2ssMe/GnL+q2/etyIa17eg44qk/LlrCisEFFNZ25bG4o?=
 =?us-ascii?Q?qLIMijXvHLCYkICj5E7PhfQFDEoHrNrhR722PIbZ5N5JD8601TtXbL8fZRF4?=
 =?us-ascii?Q?pbqMdJeptY6Lm1fA8akKkHs6m6fAsZSBPr4ZO9OVgsRzY9d7HrXMXSxSw49l?=
 =?us-ascii?Q?Deu3cyxci09r6IpjJ9BG+u41sjJKsNQ+pcF10o/HlfsqiEa4tY1eQWwcIMwM?=
 =?us-ascii?Q?VDL7WD1nIol7TpsQ3OnxdlL6fQKCTeorsMlRZbYEIHHmiDDp0BB93EpBUJuV?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d18d145-478a-4a6c-b07e-08dd55b315a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:43:00.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xCIkPCdxDbgpO51DkAduDu+WVnzZTA4+8a3+1bv1ZmjW+Y8qjvDu9NULWQeTbaElZBmTn+mDZLKTHlE+8jkG962RdV5w3aYof5KXQEyByc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6195
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

On Mon, Feb 24, 2025 at 02:43:07PM +0100, Burakov, Anatoly wrote:
> On 21/02/2025 17:04, Bruce Richardson wrote:
> > The mbuf cleanup function is not being called correctly on close of the
> > driver, due to the vector_tx flag not being set correctly on each Tx
> > queue. Normally, this causes no visible problems, because the default is
> > to have the vector flag unset, which means that, if vector Tx path is
> > chosen, we only free every second mbuf in the descriptor vector ring - a
> > subtle memory leak.
> > 
> > The reverse case - where we initially configure a port to use a vector
> > driver, and then later reconfigure it for scalar - causes a segfault on
> > close, as the vector cleanup is used on a scalar SW ring, and that
> > vector path treats the extra metadata in the SW ring as mbufs to be
> > freed.
> > 
> > This is due to an inconsistency across drivers on port start: in e.g.
> > the i40e driver, the Rx and Tx functions are chosen before the
> > individual queues are started, while in ice driver the order is
> > reversed.  Because the Tx function selection is done after the queues
> > are initialized, the initialized queues use an old value of the overall
> > flag indicating if a vector Tx path is being used.
> > 
> > Fix the issue by moving the Rx and Tx path selection before queue start.
> > 
> > Fixes: 552979dfb1c9 ("net/intel: create common Tx queue mbuf cleanup")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
