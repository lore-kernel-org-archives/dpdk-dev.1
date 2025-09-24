Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D23CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BE0240A67;
	Wed, 24 Sep 2025 17:51:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 664A840613
 for <dev@dpdk.org>; Wed, 24 Sep 2025 17:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758729058; x=1790265058;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=voUvx5Qo1lDOXbk5WAZ+UdjEdGieT4mpV8tpzutuYYk=;
 b=Hf/Emq688RN4CM+Y06jxerNCjw5rfAq+fX8mPHcZ1xoSLaQ/OYxDyOqF
 B7DnxLohNhdCnrdLFWJEHZwLX0fkzNuGOJxNFkAdSPHu/FQs0C6ol5UhF
 StDBZ8ThvKO9ZguhUm9hEO15CuzUIPpnnKEKwjJiug+mzggHHZqWdeINv
 FRZRCcg3VLMPUj4pD7Wij9F70wTJMdLRBEB84IL1PrS5o+Zmeto2gX8Jp
 EEhdxmP07dKZ5CdK6+4i9l3Uxe6SuaxALo4WTydW5/x9nKxkDcS/aCSix
 Ht5Lo/7ajK4oPkA2aU71SH1mBAYatwCqvO3pM1GsUxXEW0auOCdvM1kc7 A==;
X-CSE-ConnectionGUID: 9/dxW6JaT5WdQnI1ng7RqA==
X-CSE-MsgGUID: T6C0rjfWRceIDkajGN0oUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60955314"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="60955314"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:50:57 -0700
X-CSE-ConnectionGUID: t7G6bRCHTYuhUje7+yepQQ==
X-CSE-MsgGUID: oCBTv0EuSp6ZieRqjiZZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="181459148"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:50:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 08:50:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 08:50:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 08:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWTLxwLXdU9gzcNgdkhKzy1xC6/z9uu7NJjbdSfedqzwa12axwNPTILgRAc/DOztf6bRhiSkm/H56Lyd509YLCty4KkbWNrSUBNZJGgtPhoxgRb4DZEKJ4XZig+MxiwQ9hqsHMJ+p8yJDB7lhXrnFKCRRiw2XZJa3dra8B1IpCI83bkOZwWZXcx5ySQIa8kwJXpY8V7DE4RjweVUPmvUCpTaKBaa2ondD7QYwc8k5HdlhXGp2nsBDkmm0X9B0H27bQMIs7PRXxbi19areNkmARxMkCFOJUMu1AeA5Fn3PtoUw3vfUyhVGY8PHhG8V7EBYhFSYGFeDilF10WcKJ8unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um/1sXA2tHXNIIV/wfiDqbIFMNCK7v9y7fkweI8a+h8=;
 b=jfbj2GpkhH3gqxjNnbDIU4oPZSR9xIqIEzDJOn4jJO9TXN+S3yVxEo/RD9iuC2NDuk5jQ729z+Q/+5E/WdHzxF6D0bONQdVPeqM801hoDsRYzWi7uJBrjt9vqtVA5nlvgCOlz6U7DZGWW2OLxytcMg/Y9LHWTXXOQHjJMACYuK/ndBL9adEZ4JFUQDNNde66fk7W6GaZOM+zG8n9zijB2c4uIBQ2BKq9cedyoUl5jdLv5zbpy3XqnXZrvYDk9TiEgfxPySo0x/7YSc/X7c+NS3khunYHhqebUeo5yL2zgykNL3Gv4V2doa+Puy4/wJy1F5O/sjwwOAhNTHD3uMs6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:50:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 15:50:45 +0000
Date: Wed, 24 Sep 2025 16:50:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3] build: remove deprecated kmods option
Message-ID: <aNQTUBumq7jnWqh0@bricha3-mobl1.ger.corp.intel.com>
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250923144000.13570-1-bruce.richardson@intel.com>
 <CAJFAV8ySAMbErqh_9_gy-6FK+OP+8D4vvsn1iYYNniYGBPZT7w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8ySAMbErqh_9_gy-6FK+OP+8D4vvsn1iYYNniYGBPZT7w@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 95de2ba8-ee79-4c9d-bcb7-08ddfb821fbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CwHRtW8xhTl5oF/mi8cld/Rl3jIxgVf7eLAJ+Ipo7O93IZ5j/DU8ep4tZiFv?=
 =?us-ascii?Q?+UYYwzQHAm9IpKtPVUZFVK7AnRLY/2dFuHscL2Gn3os/ADwVJhSpAgwTZYMS?=
 =?us-ascii?Q?lAKlwzI7YI9jdRPNECw4/q6WvEk/I94NtgjquAb6yg9XgTMxkROpiBQNMVWJ?=
 =?us-ascii?Q?tCRWHAp9s9ndbIAtQfaBNNo20yEiAFqP/6xMgVyw6Ooww2thZw9N638e6Sa4?=
 =?us-ascii?Q?0m8WwVWOFmZxcVOlqKVFdt2+STuO7CWAY3OX39Pu5LgcwrQT9lx7BRtSGJJ7?=
 =?us-ascii?Q?3Pvzxn2MznHmmRuOA1Lq/YjuZ3Wjx8fSe/apXoCzsa09zZrZRGT/AdB0/ytQ?=
 =?us-ascii?Q?Vu9PDKJlbpEWShpuUPyuWu4LEUp3JSspeDDY4PJWz+u0Vu+fo3EkFfgrRiyn?=
 =?us-ascii?Q?qneX+n/2HqpfMKeRaWz//mAtp3lTR4bhQSo4di8WGurfWQkQOil2EYy/EhHP?=
 =?us-ascii?Q?NZwqCHce3nE24wKucr9brjAO+hSc55rm/rIABMCq/z7ZKPsTmT8xJGZfisVh?=
 =?us-ascii?Q?FJFJvVj8wzfBhKZ3imT0bJXwzAnKn08vczGr4SaM2gzu2VZrHte5Bh5ymwwn?=
 =?us-ascii?Q?uKKIhz5gy5ERCkpSloYIpjmNUvzgsXWSOzxLKe0jng0j7p91TlR2lUGknvcU?=
 =?us-ascii?Q?tPT19PTI9bthpHC5/jAahVlgWDtA98DYbthcuDAvob3VqlEnIRmnkhQZMz6y?=
 =?us-ascii?Q?admBI+t0l4TuKs0NoRj/0IG7Bh5VRBPet/Kq3viZGpoGcXJPkz0U5fkDKX9q?=
 =?us-ascii?Q?GLft5kpC5l8hceu+6/z+cWc7veiuWk9MDDHMKVqLLDM7CgJHfD6tx0BDMda4?=
 =?us-ascii?Q?dAY39zE+BxgdEiKD7Jq3bl0sWtLOuEXEcxT2v5esMiewQeLFRz54bCDCVpWF?=
 =?us-ascii?Q?i+WSXnV/p342tAgZFtqQNqKCmZSHvIcrawzrpHMVp3YGkgE35LPo5oeKy3Ki?=
 =?us-ascii?Q?JM7pxhW+xiBOvzcGaPHPTRgrMfdv5OWxyBS8a0TV8K6tgIkFyHWU1/xS3Bqe?=
 =?us-ascii?Q?yEtm20rBZll3mdXsZMqjROavF98WLIqD99q0MVEfdmC8eP/2MlSyD6436o/1?=
 =?us-ascii?Q?Jny5iR5iPYAR4PKKy3dNu80lwFsvJ2bkvuk9V69PbzsTdGdgQauYAd+/dez/?=
 =?us-ascii?Q?B6hI+H2PPU/HqYCbLBZAeFEfywtSFtlX/KaLwbXRV4UpbQNbeiBuHoCoO65Q?=
 =?us-ascii?Q?15W1ilofPAiE+lqv5ZE5ZY4KPcxub6bdOh8qn8GgPXiu+4joeX44lzsy8ddo?=
 =?us-ascii?Q?eDhHggu0r0zlU0yUoOd5gNyHoWeQ7L1laZM/EtrGTgay/AUddFcT8tCwUxgQ?=
 =?us-ascii?Q?eNHnzdtKPx5U27ejqDhnD2uWLOCgWqSz7JhcV1ci2VERuWebEg6Wee8Xkye6?=
 =?us-ascii?Q?JggWT5heL1cdlohsXUric9Esy25B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbSCYy8/eVxe6vOoeESreezDzwgaVBKE0VrFdPGm6wCqyl3Yl4AlpAsYAwLZ?=
 =?us-ascii?Q?f5anJHsTaicJ+OSvYC0MKs4JBCiYT8P5jQGHbaf10B2oaLo8O6JQ8wkqo8fW?=
 =?us-ascii?Q?6i0ZQkdo35DbKTeGnixFOXECJmWT/924YakSX2FcSE9B807zOzSSwzmRKi+i?=
 =?us-ascii?Q?C3lbJZFk/YCodxWZLK13bqbqk7JH4AOPhYx97wim24XjVE00H7YFGWFaA8og?=
 =?us-ascii?Q?U2236W6k9QKKw69j7XX3RlXLwKTvW12tjreBfp3zmqOzkcdTsc4aAdb4gXUO?=
 =?us-ascii?Q?SYzZCk7o9REJYj/1DfTksigI44CSgOMaOwivWYYg+NZs265kEqL4daQTgQSc?=
 =?us-ascii?Q?9IpLmiDWyVe8no7rimQe4R6C7GFcEVNs666SixfstdDu3rftN2ZLxAbilLeR?=
 =?us-ascii?Q?w5NAHyBAyyABBgIOJBsTDN3yq5G9olS0h3DvzIsAEP8IxtiKMoSYnpSgO328?=
 =?us-ascii?Q?YIifJ+nTz2HWZsIi2jriCPACb0a9QMfXyd0fkCaxgdTDWPBA0KKwjYzisVf+?=
 =?us-ascii?Q?LRuIqQvKEQGxGcAlWzexInIIE9avBgbOxnMyjtQbbaGIrfsrivjGelRRLVUp?=
 =?us-ascii?Q?3xKrBCa68wmIPjAljpxqvBfdaVCu6ynQ8okWcnsetGESPNVr/abbr93ZWNki?=
 =?us-ascii?Q?KWYPzxbdB8/aQowLBM7/lNOjYkrHf2+1EZcOr0eqngkq95M5DflJuLcLkAaz?=
 =?us-ascii?Q?/u5oT0tG5Q8EetiYYu1eKZbMxUI7SQ50xXYPLWnRZ50T7h87NEE2y9fFQZeH?=
 =?us-ascii?Q?OiL9tGiZ6yeEvpNDDKHsLlZaC1/broJ28smhOdMNhfQnt5tt6w/r6S4iFffN?=
 =?us-ascii?Q?auRdCf1ySr6eTY37qEMzFRULD0FpM51P0KtPaDJXgMYjgnHbh/dkmuBmfUu8?=
 =?us-ascii?Q?ZqNQpQnOOpfUmKGJ9tl8xgupiwfv13TJh6g06Eb/B1P6n0TxZMmx+kgV98Nh?=
 =?us-ascii?Q?RzcFBSAgVuXdvLMFO3bXPBkOoNT8C9XmOc9a0aNX1B1xlddwcnwJ/JUDYHnF?=
 =?us-ascii?Q?P/MC9JX1FJFqf0JhbSy2Tuv4Z9Ym+1RavRBDnqDvgjW4iojsf9iTI12A3SiS?=
 =?us-ascii?Q?qqXklucinxBDf/hgwFHUPckihsJzoHXUWA1hTlH3Wrrqs3YuAuRcAZI9r6rH?=
 =?us-ascii?Q?V8PFJwL5MlWqiJWKV0bABTizasm7XBZHzeH/N8QjEoglvNT5pfW61Bpzbctt?=
 =?us-ascii?Q?Wsfyw7GYQIsDQZM18z78xCyItzN8SCdXpahV6tq8zfqCvo8Y4ehsOMqUuXa8?=
 =?us-ascii?Q?uomxxG7Az9WG4aR30lLh95mJzPpgI23oFZXtjnFZR/J1af1+sx4/T47kf6j6?=
 =?us-ascii?Q?2RjlMTDk43Vl2OAkK1bf1almkxxMkm9A6WJdRz8+g9vZQT3bh0806qzsIR88?=
 =?us-ascii?Q?RhlEgpnbau30fZoLbMBDtLGwJDqfIE3+YsByw+daj09aN9QdIGBrkP9WtcEU?=
 =?us-ascii?Q?w5HaJLn5YrCGdQitzOMp/6MyoPC5tpS5D3SmnV9La6fAFzme+3Aipn2knB6X?=
 =?us-ascii?Q?ZubGCZbUO2k3yNQXcpeoAmbeF31LjjhNetbwDe5ytXHOZ1J37y3b+jn+lISI?=
 =?us-ascii?Q?d2JyiY95j1hYieeQfrx3OaCf5HrjHMS9mqEwWHXk8hQyBUP5i920yfa8tYK2?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95de2ba8-ee79-4c9d-bcb7-08ddfb821fbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:50:45.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zW5QxyXIu3E/jKupTZ6W+GocOOQUAi2UtSAPtADdw6GZRcGslObb1NGBqgqW2Mk8Q2fkAiSpTQOSqhlNrXVy2NGb+rgpWxvsEFT2IGPOiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
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

On Wed, Sep 24, 2025 at 05:45:38PM +0200, David Marchand wrote:
> On Tue, 23 Sept 2025 at 16:40, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The "enable_kmods" meson option was deprecated back in 2023[1], so can
> > now be removed from DPDK.
> >
> > [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: David Marchand <david.marchand@redhat.com>
> 
> I see errors coming from Intel CI that requests enable_kmod option.
> It needs to be fixed on Intel side so we can merge this series.
> 
Yes. I've sent off a couple of hours ago a request to have that fixed in
our CI. I'll let you know when I hear back.

/Bruce
