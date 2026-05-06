Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E19CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3249402D1;
	Wed,  6 May 2026 17:59:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 08BDD402B9;
 Wed,  6 May 2026 17:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778083170; x=1809619170;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4jeAkt2ZQxgr30D9I8iD72/U9uZnO0FBdisb0T7/NRU=;
 b=Cvls/UxsgSrTefc7Brm4UelP5WuV8kGJVhXi6xlx4Pq75fEr/8LJ9bDP
 3fTsV0MDpzBqSOkqi2eIGGucgi90QpWgy130VfGAUzTBqWyAXihzcVN4j
 bNXSMe9DeTB+BbWRJaLUO4xfDFWanlPrhIXjqbYpkx7nRY6+mL0JMsnVB
 /GQmmlddq8MrB3G1tpGiu0ZJHXiGfvGe8RC4U9J88eF+AMdZT4IMPGkAK
 h4NYUvb4bjqmHVFgNK3fArUytJIW4KpsfkWwkyQ06XPhfTKPT9/8vO7ZA
 GJ4qnrauZthEn34pw1JP4mBYkAaTYDjq+r78iovHUJ7Mms9qC5JZhZzyn A==;
X-CSE-ConnectionGUID: E/j9NFfaS0ulDYzjyc/FMQ==
X-CSE-MsgGUID: rvdIxkjTQzKqxkVcS7aXRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78047014"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78047014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:59:29 -0700
X-CSE-ConnectionGUID: n691paGnRAuyX3DgQ3R8fQ==
X-CSE-MsgGUID: Q2FA7AU/Rj+i+/WVuJwTkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="240522530"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:59:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:59:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 08:59:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLP9JwhPb+675+OCDvFezzhakmUqOwx2/8iQNg3JybvqobsNhqQqmlsx1B3uVqobtLFDYi3IiGLI2Su1K530aQfqDKHXqLsIuIXTqaU0ggKVXlrsKU/xMCyHM5iYK2SYdUjGx57QGmbw+fP/khcB134zQEUES5ojDyMY14rKDXXy3UCnbHdsr+X+evQBKW+MBaUBFX8QI4AojQNEs4GruVdNXfUPq1LGDBJuMnJGCS2/tpaBNjclV9GdfCvyYPXXIqNDOwN35ZhmiTZyj5+S264t4lQ0r7x+5CZ8EmyppnNk0FfXhyyQJoYYbf8QmqNhbGSRGAnE66psM0VQxQ9AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjw9PhuD5LovZ4rx99aneZq6vfJjFqI4O79TOfS5CnM=;
 b=Jqd8ue5O0UnWReRWbMFLEepPb/e5w40kR2m0kir9LPh1zwITtxY9QBoIAzZLhplqI3cZEMzI7luvHs6ui6gcNshk2nWsXg+6ae5VwHNf/I3zpA4EA9mJ6or9wuL8ePFy0WBfzbA3+pUttBvMfnmOEGYElcZnJa/zR4YDQJ9ljkzCihXsG5yCQV3H41BSWox7ulS5c6DW3uurQQwYYk863kJCLe/xwC7x60HuBwMb3931sIs9crFeQ1jUtJTER0b8F9CaCyPZLBiCHpEmPFTsbdxDL3W0xCybhfoVNVY64EdgMtO3Jp8P+l6EsynGCFTEOUGA+JhT499dyPtxH5OGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4640.namprd11.prod.outlook.com (2603:10b6:806:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:59:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 15:59:26 +0000
Date: Wed, 6 May 2026 16:59:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: fix queue received bytes CRC adjustment
Message-ID: <aftlWPd7gVmOGJim@bricha3-mobl1.ger.corp.intel.com>
References: <20260504122623.37067-1-dish@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504122623.37067-1-dish@amicon.ru>
X-ClientProxiedBy: DU2PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4640:EE_
X-MS-Office365-Filtering-Correlation-Id: e0413086-35c1-47ed-32ed-08deab887287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 0RaQTsUv7Y5Rj2tRX4olTtQ6GCtKB4z4QUg1kgt8dMAXvGiAQdWQ3KAVfkzLexvIcz+QfTXlBZnTmnc7BD25SECQY3kxMu7kJooWn32Pz8EFSvMw3eH2T5FVPoj7G4YrvF3c3tLybFJDYOJOjOtaysMvvu6RbAeM50qV+KAVDU8PCm8JB9UjfeoTgXO7hvgMc7W3ojCHtkOhfOUQ8FMkeKI3x0rZ8YqBQfuUGj/itib2EhtOeU8ldAdAhpZKm7FGxaKmGxjqcFp9aZZcYEyRRzuEa5UkH3cq/bzYArTV+3pXC3Ot9Ziqfk4Blwo/M4thl5HuAqb2Y1sCkcwCwwoWiSMfPLtvMqkbI1dGdFczvJgRmr02+QjWYmsnA5QZUAWiTG2Gj29/BGv2cBODNRiLVTYQ9QNa7b6oPpe2H39Oh5Tns41QJgUktgJTMnBthXLKjlcCjCB5tHogbLGG+Ljen0kE1V6ACl4Oc+NVBQp5qdex1c/ZSb1/Y9GXxYagaC1D/TV+7t/YBsJyIB4nSSUSArbZ1DvuiBUnsVRSRSE+rrXioHuXcHG8tA4QdbcCUTKqx/TUQS3Z+x5Gv0VEku6OZXFi4ofSlzw8M1vPn1TWbnvKcNSdx1Z5fJomFXNv4aFgONYZaLwbNlgQYjYzaOfG8w1/KdL0Q424fSY+WGiteOpBNQyk/B/1LJtWtRaiDkCe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Wuq1Rf9S7Q/bWwwNbu+G1euOLlpFQVw86b7gca8kyEovog2IbWDzuGpJqb8?=
 =?us-ascii?Q?JiDbQDkWa4cSxU13fFaD9mhXK5ARAg8i5LSxNEb5hcRoMVKggPp0sOrzufqL?=
 =?us-ascii?Q?069VFcoFHhDC+q2NY2WXgcnTJCoNfJH1XObvtfsFtbrCKXHCF+YLVJchQXOo?=
 =?us-ascii?Q?gtyy+dvPG0oFaAo3ooGDtmp4yvKjq4E06Z3Qz7TopFmqQgP2GQNEpydLzltr?=
 =?us-ascii?Q?SD3yFQC4WfIY89A22BTw0zvcnJBGhZHHNYSzpWfNgm8444H4xncwWLCd+rl4?=
 =?us-ascii?Q?z7RkCfAKvjzHJsdPVzKZ3TTbV5UEj2yFMpbpeny06KizCGrYSmoa/AtOY0qq?=
 =?us-ascii?Q?cjomOQ2JWO+J4qguNt2eNVBbkUEBPUW5qaWrGjnHBzHRkKSA7ylchqycd22R?=
 =?us-ascii?Q?j2xma3qSGlpuUTOVX80SygMfTzykgiwrZBmSF1TtSei67n4JmzqC4K9B73go?=
 =?us-ascii?Q?NAkCEwF8A+BQxSGsACOwAVCSyIJ6Cgy+umQ4dSezNOORnybQLJonw6MEu0JR?=
 =?us-ascii?Q?+orfkLUT6UY6qJMGIezzAhcI6m6D7h1/pGjCNWo7+xpHqKE/10YsmcHoYb8X?=
 =?us-ascii?Q?OjV3JIAU7M/TKNa/dQZI6XQlbTYVsIoZXg9DmWi+L/UIBgPC13xVyqn/UxSc?=
 =?us-ascii?Q?rPV5dKW6ZxKTNrkGFrMDwfr7hyh7RcblF8v9MmouRdP3Di4QLFeWKn60+OxV?=
 =?us-ascii?Q?n1MFMjSZJCHZeHs7GfyQz2EONkx/7l9Hk+phGWmtdWIYzBxqwYoMst09ocTg?=
 =?us-ascii?Q?WlNFq0wrwEzq27fg6UCtPMz88ZEb1NvLLbVE4vWNPOuiZ+ard9R94HobdN06?=
 =?us-ascii?Q?gJsfQoNGWfo28Iq5l1X90SsgAlDdPnbDbZeaih9/fCvv8KcHpm7D3Mg8IylW?=
 =?us-ascii?Q?Ghhq5PpVH4wuV9mcPQ1A0dDZ63gLb8MUVeLzPb1TFwa9MhGXvgUDbAD5pZEo?=
 =?us-ascii?Q?v6/aJnkG7lW4STyRYVip8pBZzdaFfeHTTo0Ip/JdnQ8BfDxfEFG9TU3MkIOq?=
 =?us-ascii?Q?G3W/SSrovCQf+6t96vnJ63Xia0funtuZELB83zOZgNPYBhTRh33+fy4/zu62?=
 =?us-ascii?Q?9GkhBBn3WgEJ487gurk8fcxcHzsLZLwHU9/xZ7ynNqZol5qs4btuvThZFiy/?=
 =?us-ascii?Q?P4bcYelzQGcROu8B1BqFnWxXsHisl+NUcg8QtJ8oJBrkGY4lh+IiKokcdzr0?=
 =?us-ascii?Q?LxYCuLKgkcjjwx35JujBtvxzIPJYwz7Nvge/x4uGbdXC0Gyg7aOHDeJLKxoE?=
 =?us-ascii?Q?bcNG/BJhZTaY7P/2EA5nYZp17uhPXBW0mzumPpkj/xWivASD+p5vyDVCg+wL?=
 =?us-ascii?Q?9xlQzwbDCFNyhbYWYcws0zgo1OzEZP57Ysj/nIVUuBCRrXrgurgYjILnFVvT?=
 =?us-ascii?Q?kJ4Rz1duO+JzyhurfK7hP4Fp3rhlSJfLa4GzbnX0ab/xLSCrVco4YyIwnX51?=
 =?us-ascii?Q?I/vIpuk2Klw5Fo+srJVqUE79CUECWdBKRafK8IkZzlli2A42oPTtNvp/1KV1?=
 =?us-ascii?Q?wx0bnjR9n7eztD+pwSARq4fVVI2zo3PJN4Tailps3FO1UHQf99BGUBBxAhOs?=
 =?us-ascii?Q?U4e2cK2jc6PXjq4a5vxyKPBAUSfxbfv8XmwnO20rlcuaEvQmt8d2JCXh88mA?=
 =?us-ascii?Q?c+UBEGrZw+9Y8NLdLQlpgC7yuFMb83DsDozaY7FJW9yZzsQGaxepmrzVT7BT?=
 =?us-ascii?Q?uyldR3nMHPFi7BgbFOqBwWuXyjYKzGnM+/9j9xAYimDyyvtpWJAKxXHIzN3t?=
 =?us-ascii?Q?+moRgrSFVLCZbvsSxbRpCk/nyccXuMg=3D?=
X-Exchange-RoutingPolicyChecked: G3QAHFUYp3YBopziXzuFvfsjwKTDKPNmo0l/ykNIMUvb9LaeBKbSt5FjUuSNSAl5lS3wgbTDLQ+QpDW+bWnQz0PxvV9L0ZBCsXBxC1HD0u3jr51LlO4blV8BQ966SBGxFAAEtN1IRC2VDNOya18OreUP34C6HpQN8Ii64f5qLmaoBShrs2L8Y1VKPXpI4CTzxgQL5Oi2ysYiyOkk6j435u3962hu4Nbfnb4bXqENFMKW5/OmzQ+irR0DNfRABjmEPuvANPkAf3/jUFib4OneX73Wt4ARdKEjRFgLic7zgfd8PEDw0Qpy5JLfqDlEmV9Rv5FqSkZGT0/0alvXbN+nDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0413086-35c1-47ed-32ed-08deab887287
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:59:26.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOvMWErMOhX4tHADDwVeDKpp1PAmbKdED+s50j0MszDZro7Ex/rnM31Psv1qAHaXOZk5RWjhwdwj0pK+3iflrJfOoLb9gWG2liHPQtdgcT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4640
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

On Mon, May 04, 2026 at 03:26:23PM +0300, Daniil Iskhakov wrote:
> For 82599, QBRC is a 36-bit clear-on-read counter, while
> QPRC is a 32-bit clear-on-read counter. ixgbe_read_stats_registers()
> accumulates QBRC in a 64-bit software counter and, when CRC stripping
> is disabled, subtracts the CRC bytes accounted for each received packet.
> 
> The CRC adjustment is computed as:
> 
> 	delta_qprc * RTE_ETHER_CRC_LEN
> 
> Since delta_qprc is 32-bit, the multiplication is performed in 32 bits
> and may wrap before the result is subtracted from the 64-bit QBRC
> accumulator. A full 32-bit packet delta needs more than 32 bits to
> represent the CRC-byte adjustment.
> 
> Cast delta_qprc to uint64_t before the multiplication so the adjustment
> is computed with the same effective width as the byte counter.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c03fcee9abbd ("ixgbe: remove CRC size from byte counters")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

