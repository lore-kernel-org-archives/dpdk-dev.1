Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D900ECD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 15:28:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAF9B4060A;
	Mon, 18 May 2026 17:28:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id CFC8D402D9;
 Mon, 18 May 2026 17:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779118117; x=1810654117;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xCxTAN5Jb1T1AJPZP+NVinzyJpUj3KYCb1bp6JGUTfw=;
 b=KVnlgMdOfTaCVbg9E8hjwDeRSsPiCJ40RNy0w5bjVtqB+3pmTEiwznfr
 10Y9SDtZgHzXmw8UmNBFqj8MgJmiTXJAA/zVgNt7zb60vxarJBt9om9rP
 yuesbJ/TrafC3935bmSs/rST7rTgBNkLCY1bE14Kdvw4PJ0ayYiM9GHkx
 HuPC04qT5bfNsj7rVatNPFC4ZI94hJjMwwu3Yg/rAh/WH3ZZMBem7XZyB
 mcpzYwcaJjMYIlCRZq9DI+Ez6Bl4VKGBOkX/mvqyQ1uzGtLrhIEQm04rK
 yl+0793hVPoOFo/dv7/bg18yFSjUG63X2ZODo+tGkTLATtiCcRw3Yb8/z w==;
X-CSE-ConnectionGUID: yugigiwmRfOZkJj9fcAnDA==
X-CSE-MsgGUID: W/OJEnc4Qsqe1WwOzaq8fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="102646882"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="102646882"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:28:36 -0700
X-CSE-ConnectionGUID: 8Kr29+qBTOSFg3ipUMJbMQ==
X-CSE-MsgGUID: xaEPmsTXTiWmy49eliMfVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="243759702"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:28:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 08:28:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 08:28:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 08:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWLXNSMeXgxNgkgnSv6qw6TROqlNEMB24ZAd1UxrNVvX9MKsRP6et9T+XLjrk2CZ8CfUPsEhzl7VYjoy2P2OKfC/n6ipVC9MHNVR6li0e+JSVmYsuWkR0cI/CauxGUyZNxjQTDBu2RDTmNLAWorU3bkjldZa2md/2pJjudN+IEmCoBxA1VoKGmHpuo16fgMhqLZtyhgXksJHbjBy7Xo3S09AIeqB46jeTEWncMo50ZCaV9zB/TL+kkeHdZuGANMXzvbAcRZtGskTUBdjaiX3swuCqLX+I9uXNExIMjLq7O3M/X2ROcq+OWbNFTZEcc87xdSTH1HLvId4Hte5ihEvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjldT+GLTeQdEevpScN9Jeg/W8750ZcDfTL51JZfdSs=;
 b=lnU9PMAOK6ub9RsLX8alFgMdhM6K16aCbr74W039h2Qx8DBoHGl/1ZiW07eK6p/WIGmTCXIMLVR61rKvBMhfw1+/JAzKzUO04wi8+SjoA7+NqMfOV9tHdyDftLtxCRR92/h3stP30H0Oarc2cNvZEh3haDEBPkDl0GXwCUHOozei9r6mO5qlsKRHS4YN1LTm8g/2FFEN7coACbWwQhmtFEyEu9g2XWmEBvkWTQWtXihav0aExutroY4h2IotcrSdWrAqqr8pEW9vOPnJfp39XhkkFMoh5V10JV0KRs3EGYdD0ml+J1jBQli8ZA3Dw9SfjmX+h2FAeBMCKtOXEvdZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SAWPR11MB9897.namprd11.prod.outlook.com (2603:10b6:806:54a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 15:28:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:28:32 +0000
Date: Mon, 18 May 2026 16:28:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Message-ID: <agswGt0gN-edMzjZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
 <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
 <kagkiNyiQQ67llvhX0AB8g@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <kagkiNyiQQ67llvhX0AB8g@monjalon.net>
X-ClientProxiedBy: DU2PR04CA0316.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SAWPR11MB9897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b39b56d-87a6-4af2-6fee-08deb4f21e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: f8CzJTHIFrjyqWJBtznd1C0YVRSHj18TCboSF3dBDWuQdgp/hMpa+8WkVSAFGTFsY/bGJh3RQhymwDCJtR3BN3HoppNiyJcsGTyZ8+4PFNROjYGBH3U/NnCFefEHakLBLfp6kCAmrulShZwfX0+QEkEm9HSTa7zwJ6EX4QesjQzNJ7TMcDRMJ3MmzU2pJ66SI3Dh1OLzLtvR04TgXkNPRv/5wmm7H9ySn5BMesWWGAa70nUSl8gOY4Za4tMsSb1cCvbM+ZdPTXo8VYqAHG5UZ8/HmQVI4ZNZKzsxDPOo0zF8LwCWk+l1b9bWgkyAexur1QLRaJekNV9JDVd4XM8f3KC8sWMzcIm25PpCGsEYIljuCMR+hSJPup/yQvNEwuvYf8hpb1OQTUjB5W8lsBXuBiXQIxZjTGgcLsHdmmeRDCxtsSls9MfkRY73G8+T31eHgk2tr86A+3+FcAd5FMmM4+mOJZYS94IL+Nlu00lC9vkbrtGLJjBj/ev3hCyRSKoi3MksMi85HNPKw/hWpZ4GjjqgA9RbixRCijRMR6cnHXRRQp37Ep9I4/1rocQL27qF6l1sQH4k3kbFWKgmEq2p9RqnIFNB2FgCYLd3jpO3NYcyzRagTMIwJQfb5Qj10akhvc0jhq/mbPNM3xUB1Nl/5wYmwPcQs4WE7TKyIyYmgq9DSZpEooe0APYk8jocHME7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/awdvfiFRg4DrQh0wjQxephtu3jI4rNMKnWbvNWJReUYPMsUQi6R2XdwofG?=
 =?us-ascii?Q?TAsTdMK6s7TNcdMZ4ySKGZhnH7bSYwrFRPTUWlR2QwKkZeHnTvstXJAjkYGz?=
 =?us-ascii?Q?gQnTtz18Fpch+b1ek3ACXNvRzpuHNOLMmRUbEVgjY4KHlkFyFxl/Am5rrwHv?=
 =?us-ascii?Q?FlfMqN9mIPI/0T9AwblZC3atvTJXHiatRf1bWwdtW734SkPMozAqhrVHV4Q4?=
 =?us-ascii?Q?9H0hfFvZ+sqgUDT5aTfxuPGwABk+MIpO7dqFf3luA70XrckfCBbhKJ/jCvwD?=
 =?us-ascii?Q?XnrZ/M5i/0aVq3HRMNWTqy1XZihis0N4t3A0fWs0KBilbipRl2DMqADwHK34?=
 =?us-ascii?Q?D2XBmoMlHvnoWsIGcf33sqi/5+qp+9+MpvfHVmilDAfM3HGKGdBz3BXL+oeK?=
 =?us-ascii?Q?OdofP1ACydqegukZUKUJJ/4PbuRP7IcK/fJiYNHiAibcMTE/2ue/KO3yEaIe?=
 =?us-ascii?Q?x2kVfLyrDqD9rxOCTcd/cBajAwtXRHUdUuRVWWAJ6t3b3TLzwWkL1U1KUFx3?=
 =?us-ascii?Q?jGhQfdIomvNc1CU9cOF7jj9ztVKDJ5T5FM/YlU+cxHtK2u1TMPcHBy0R1jR9?=
 =?us-ascii?Q?YmFAvw8fI0h8vez3u0WtYPLnhRcX/+zIsJBKejs2rY9M1rbSlGD/8PMIfAEI?=
 =?us-ascii?Q?q0XCht/CdcBTRjOip0WFyDvzvVr3Q2HhQu8hPc/4O33HjE6zk/33K9r0fg5s?=
 =?us-ascii?Q?bVf1D+bAhxmpr9J6ZQCPjLLF76OomQQSFZr/YB5P5fRMyIqnIvGUbzVH3Zox?=
 =?us-ascii?Q?BcUHvi3fOX2lPNHed6SFqOJunplBrzOLIBCyqH9kgkyxhJ3KGYY54hfYLcCE?=
 =?us-ascii?Q?ETgouXssMrGIPIiNu4eSfQz83YsiKpWJvBOlQtiE20lLRAH6Cyn85GGp5n31?=
 =?us-ascii?Q?EnImePr1xGnhc2wyLmyIHIwquoM3TFP8m7NGxoFZlbtUmF6ayNiQbhGNIqnl?=
 =?us-ascii?Q?T1/GJnX31+QNCVK6udCN51syIXCjCj+aVrkLs2UojKb+7x5WwpeDIhnlkbwO?=
 =?us-ascii?Q?AgAsqX92ESMN4Jt6wKg95xUHMhiZhqGmUJj3unwyfZQBExtzKX+NqDfA0fN/?=
 =?us-ascii?Q?PQSqXwzfAWO00qnHE+vSYlHZ7DMQfIH7dnBeHyBDViAbjSvolhAVbOk1xZ+S?=
 =?us-ascii?Q?Occre2ovvwL3pcqRnyYfZWpbdXTtS0cHz+zAmzCTYkdWRVDvManXL3ZhzLCG?=
 =?us-ascii?Q?lBvH+QHnpP7AeyySBGO1YFen2WJ6LfDQ+ZaFQXJ2mJ7bulFy/+y/Em+GbI4G?=
 =?us-ascii?Q?zqmEIo9dsy4jEbN4amxnSpTJO+FoqXDBuvhxu9M1XlAHCBSQ9D1RbS8FWtX4?=
 =?us-ascii?Q?X0O4BkebuHNF/VzdGdA9MOx2AekKdJCJ2iyQdxmJjyF4s8O8jt6YfCW1gaaX?=
 =?us-ascii?Q?qnGEeO6mYpbxTDUVdJ9JV7up8PV7eREIY0E+iG60gdDMy1dY8nDlV4xmqgcl?=
 =?us-ascii?Q?j1W3EP0L0MBgUQE1gKEW2uuMZQsyRuEt0VXzwb+UU13OlLysL+MPxmPOwECv?=
 =?us-ascii?Q?/JTC6bYvannWdTSutt/NL6JYsBGxzlDu11k8ejlM75d7eN1AKxXOHtfj3hMs?=
 =?us-ascii?Q?E9wgrmTprulFl3d1OibGSCJNmFf3n9nBuO9thgK45bVNThVkE0mGDu3DWgMC?=
 =?us-ascii?Q?zCH/h9EMFxMpXZxzaVwQy5ElwGRkm/LzjFTOBShVTsXLPRCUT8Magp5FhXwu?=
 =?us-ascii?Q?wqCS1eizE1APQqZqoGsULm5k03sDW3TmYmaEhApfO9DsegpDeFfifuD9UrC9?=
 =?us-ascii?Q?KpqbaeUt0LRYzgEUqNH1BOXC5FICOQk=3D?=
X-Exchange-RoutingPolicyChecked: UAXSVx0xYiN77ZBaIbYxgsBiQy3ct9Lq2qwaOZ05hhK0pgUkswMOwNOhyLr3XKgk9API7n8xEBDGevt1mRB0D/sahrTjGbfC3je/p/k7CEQU4xUEOwWmYbSPaBsqFTRnKq2Kk8tNQ40gvLaK+AWlJBbGURaMDwdKYFNYI3Jn9ceAb8CqyZU9iJxBCjroD50kcYo8VryF0iqGYp7R8mkdKbPq3rHqpc4DYhQrC37IV+THUGVj6gendcigKOejXCTeZnaxcqQin9FgTdjKOHGG7H+RmWCZK+Usipi2wS6Yt2IchSBcgRnqIllUY0IRIKE1P8AAXsvP/fnzsxGi5Ta5BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b39b56d-87a6-4af2-6fee-08deb4f21e51
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:28:31.8661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60rCC2dIvVAiCMBzIlsY4iw0NevA64ZrwVNVRQNw8+oTJ50qKW//myKI2LQeXpjYlYT4fGkYzhoHwtTypoEqKc3KxuRabQvskYv+j72tyKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9897
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

On Mon, May 18, 2026 at 05:25:43PM +0200, Thomas Monjalon wrote:
> 18/05/2026 17:14, Robin Jarry:
> > Hey Thomas,
> > 
> > Thomas Monjalon, May 18, 2026 at 17:07:

<snip>

> 
> [...]
> > > @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
> > >  	__rte_no_thread_safety_analysis
> > >  {
> > >  	if (--(slr->count) == 0) {
> > 
> > This code is completely broken. Any thread can unlock without any check.
> 
> Maybe, but I don't intend to fix recursive unlock in this patch.
> The subject is "remove volatile qualifier" (and unblock GCC 16).
> 
As with regular mutexes, threads should not go around unlocking when not
holding the lock. Therefore, I think this is fine. [With regular spinlocks
we can't check since we don't track threads, therefore I think we just need
to assume a well-behaved app.]

/Bruce
