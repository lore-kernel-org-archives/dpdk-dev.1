Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA7106286D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD39740E1C;
	Wed, 11 Mar 2026 13:01:00 +0100 (CET)
Received: from mgamail.intel.com (unknown [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 484DC402B8
 for <dev@dpdk.org>; Wed, 11 Mar 2026 13:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773230460; x=1804766460;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YGyWBikmiKVTHwER20/VBYB4J3/fcka7BK9qRaBGvlY=;
 b=UXnGM8qgveFJGAqK3A+RhIcxiOGGXwoVLQnEv8H78ApINh7NCSMUXTTc
 fDxFfNOqO9dJOgxAj8SMh+J/N0rf9eDMims5iMQePMEgV8eChcYUlRywi
 MHWyeW+gvjoPwdTWupVjMOxTFNSDTf7iUoG2w7ViWLNQ0N8qyVOwWNOfw
 sDOH1DzbnHFzDfXcO6hzrduKvpOP9CsdWPKE3UNflYBR+xlO92w9UFmlN
 pBqAiB13oPjqazYN/4upywEhWFUAVKuv/s2e20E/Z3beXpjCmi1lza5Rl
 hdokT7UzsHP7KxoKNG+LS3ctIJMyWrfj1D/kWLQ4B0HIpNV3Vj785YENg A==;
X-CSE-ConnectionGUID: JM2MOertRbGGrXZIEaurrA==
X-CSE-MsgGUID: XS9f4PD5RyCT8LBO4gerbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74205442"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74205442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 04:59:26 -0700
X-CSE-ConnectionGUID: /6g99moqRZew/56JGMDgTQ==
X-CSE-MsgGUID: vHCir3/NQQSlKYIKskwKyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="224603486"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 04:59:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 04:59:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 04:59:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 04:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj1E6oSUXzPYwZP3iynbZn0LbPXMHUA4hhHV86ohAk77RkhGrQ3uIhhzECWfuXzbRqwBPeMultNPfubvWyARQ2KBOJo0XMnNmxbITFrDprYBemKv1tir22KXpcq5fWusiDrNpGoQaz0YnaoOXhdmRzGslaRppvuuRZvWHEb/cD+LsA7b2MxfOFEvTn6MMy4la+1gbyJ6J9Gk9r+sUs6/7wzEalVWQQbhF49JUReF6ZRZKtL4NQnhRTIWPW0tGBM3IyUMdsj+Vm/TjvBq7dU/PGzItwAOr1+UJRtI8h0iOG/MJE8S3To4ynnyhU6Zu23yMJ4E/O48tt1DsUwXIuFqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCEpcK25eAXBK7LqMg9XD+LWUl35aQkUoWYm9Pl8VzQ=;
 b=MuZJkE9vYjm9t5G0PjS0T9Bu2mqxc7WwienGthpQC+jsYUFoTPUf00VqWO7ob8ypooKdyvH0bDPSOaMPetxdylOSlqb7HGnagdL50/a2pte1x8uFRFYuw2pLBGgfPS9c1Wq7Ch5bbMVKLXKqGgeKMxb2ZWOxGQZe4nb2X7n0dkwoJERAps60HWuWYyGd2J+lgAj4cedwCZOMWtNkFVc/mv2Yo3Pmjcmv7HWLFhbxBS+MpxcAZppP42U0hXAwQUdaubyzLsrqKvcwgQtHjs+QrkHFd1sM9cBH0bDLIKVIEhWAC2hibAxqXvZWtbmTR9qbylpAn9ODk0m0Et8xcoLK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 11:59:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:20 +0000
Date: Wed, 11 Mar 2026 11:59:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>
Subject: Re: [PATCH v4] doc: improve e1000 driver documentation
Message-ID: <abFZEwRWbfuhwEAG@bricha3-mobl1.ger.corp.intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
 <20260227162200.23972-1-chaitanyababux.talluri@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227162200.23972-1-chaitanyababux.talluri@intel.com>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1a68ba-35ae-4f0b-c80b-08de7f65a0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: vLSaomBANG4a28DSB+akurKGdFKY7g+HM0o/EkPzawQwbiUxC27A2G2HCQ1jQLY5eivnqcTSNLMUvuWqZ1daTgrRiPhQTENO6FDfWeQd2gFXDntEVKgPr5ufvetrkeVK00G/NIFNnQ2+bLiEVu3Mzij5spVhD9A5DSW6VubWIbK+xO4AAN2kNQkRZFM3JhmWmItDq0QMoZel5sE5Rnz2gHM3GcTbFi5wwAcxxvHP4ibSuPmwtsi7BIL5cc8R/ptTyLTXpm9AEGObg8zrZj9gx9aUzDKgQPMepCckgXDxM5494wI2d+fGmDhZ7lIpdJdJ1lYgt3pWGiiOoansIxP4CnanbWCbOae/nXGbViSY0fo+UwrMm4uGPM/ZdiJZ6AJgwDYo81a9FqG7KJvTEc3oRvAnbOy00AxDagJQ3bPTDIQoWe/KukipeEnWPEsLNGU4d4L4LaI7B+uGVv2hEQBVYwv/zXevsC9hWLkZHJ2r7bbOCW0s3LIuvN2hMGXvycfd9MO90AwS6EGd+k/zSniuM/HbHr6BQOepYMZtuiFf+5tEj4D3AK4K+mKD/n1cEkMxp0+HaslrMo5GPlUisLJ6OX9hbf0HX9QkmTJvgUhs5Sxk17MVrr+Y6OioutKdBjV41D3SpeKjkIwRfjc5S15x7eTd30bwo+22GsufRnogfIQI/MIiMYqMiNvZXjhZzz2rv70CZ6HRcA4DYhTK5FWkmqM0pnwvXVQjsHo5O1ReKdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azI2SEgzUExqMXVlQ3pmN3g5enIrRnJiMDNqeUtmTUZ4Mk91dUFlYlBpYjRL?=
 =?utf-8?B?QlZEOGN4UWcxK051R25lMGczemFJTUZqZTRwSUQ5cDVEMzBxSm1BSmxSWkdl?=
 =?utf-8?B?T0RrOGhDMnZRR3lyaXdCQVVObXNYdWFsbjVCRHhtelJDU0h0SGpXNnN6RTFE?=
 =?utf-8?B?UE9haXU1WDRHTEE4bmxnZzdKcVVWS0N6cDhFakZiRmtuMFVmMEhnYlFPaGhD?=
 =?utf-8?B?bXJoUGpGVDZVVk8xa1pFblhCbm1qOWZWMW93eTk3SDNOMVdVWXl1Ny9uRFNJ?=
 =?utf-8?B?eE9wMjdUMER6Q3htakJFTVczQUJBR09mcnMxdFpqdHVrWlZQMEJIeGMxVFkw?=
 =?utf-8?B?UzZLYjdpK1ExQldjRnNMK1JwTUNtYVlBU1BvWnpBODU0UFFRZ2p3RkFvZUdu?=
 =?utf-8?B?UzNCazR1VVIvQWc5M1h1eERzRUs5eE1BZGt2VHBZZ1ZIN2xwZG1iVk10dE5r?=
 =?utf-8?B?aTJ3U0ZGak9FdFFqWThpTlJ1SGxiaTg3Ui84NVg0b0o4RmRmTkRnZTlVNlVp?=
 =?utf-8?B?NEQwOU05TlZyU1JjSWVUM1VweG5QWTRxNDlwYUxYUnpKTEhzei9KOXFqSWhC?=
 =?utf-8?B?Y3hXRk42Qmc1eUxTZmQwSDg5U1FxcDFsVXo2MUdxMDR2eldDM2dWNlc5OEh4?=
 =?utf-8?B?T00zL2VOTnN4endFYzU0WmhMQWJGa0l3TXArR2oybExhU094V0krN1pDSldY?=
 =?utf-8?B?dzFZK3YxUjlKcWpZbWVPQlFveVVCanBWamR4Mm8xS01PR29xbjBPendnU25D?=
 =?utf-8?B?TjVEWHY4eDJOSm9YT1F5RnllSjZQQ3FmbGRuWnBFMXBxY1FxVjVQTUtRMDNj?=
 =?utf-8?B?SzhESmdwcjU4ZVkzdVdKOG5XMnlNM2czdW5GQjA1WEZ5V2x6ZEYySGtCTHNv?=
 =?utf-8?B?QmdaMGFxb0xVaUVTeklkS3ptYVA2YWx0dW1VZkNtS2tuYmUwUzlkNndTaEpX?=
 =?utf-8?B?SHlEbytpZm9pNUd1T0RtVkhoVzZTUjFuYmIwSGZnTFA1Vm15SWRkSFRlOEQz?=
 =?utf-8?B?NDRRaVdPOHJJOTJFYktKbDVPNHVnWjd1azFxbnRDWEpnVTAyS244NkR3d25G?=
 =?utf-8?B?a1RnZHRpamVwT3Faa1pVaGlxRGllZW0wRWFOaUxYR2pqNzRiSWVLS0Q0a1kx?=
 =?utf-8?B?SkVOekJtZUxNNEdpb2wvRGszWTBidUdWb2NrbEQrTFR2dVVybW9lb1ErOE9z?=
 =?utf-8?B?aXRueUhpTmY3akp3NVJRellGV0pzYWp4TFBIQWFKaFhWeUtpTW51cXA0cWNs?=
 =?utf-8?B?aGtqeTlSZVAreVhhWXFoK2tFaXk4ZVQ3WFIra1U0YnZFSDlJZXdIMmNZTExw?=
 =?utf-8?B?dGZUQkpoS0tmcFRwT2RoS0sramUzaDNDc2RhUUlTT3cyWHgrVkJVcDJaMG4r?=
 =?utf-8?B?QW93cWFwaGxCR2FORHl0NlJaK2IrMzlYQzQybTlTREhkSUZwRnd6cmZvSzFz?=
 =?utf-8?B?V2pKWk9LY3R1M2Uwd2diNHBYb3JqVk9vQm1aUTFCRUVuY0dnZldYUkdQNzA3?=
 =?utf-8?B?V1FBaTBob0JjWEVxY0IrdlAwSWJJVmNSQ3l1U2FyVmVYRDB1bTdUQ2hLbVVZ?=
 =?utf-8?B?L2JuWnZibzFvTFJ2UmZvUmh4dFRiZitWNHkzNHBLejNzMkZYTjZtdU1ROXc0?=
 =?utf-8?B?aW5oZTc0YWtTdGZGUUZrcUJlT0VaV0dOVzdhRlI4bXZpb3A0OUwxWXRWYUJT?=
 =?utf-8?B?MVIwTWtnK1pxMHVSRFpRK1lrekpaRzZRWGRRTE9HSjQ5OWdRd2h0ZTFXZm81?=
 =?utf-8?B?TGU3SldhNjRNWi9LQUNKMVd0b2VrYmxSSXR4RHNtYWZrSFlMS1dNNG9qYWho?=
 =?utf-8?B?Mjdad3EyNlRwT1ZoWVlZczB1L0hKMitpbWFuM1Z4ZWhFMFpXK1h4ZnkrOEhE?=
 =?utf-8?B?d1BpS2Z6djcxN1lzbFpGOXhnd1VzU0dhbzg3TzNvK3FwbVJRU0dRVnlUN3NP?=
 =?utf-8?B?NWlTbmNBV2s5VnJrZE5xZFArM1V4Rm4wM2lWKzQ2WFZkcHZvUkREUFhxWkw5?=
 =?utf-8?B?bXVUb2JvaXFuRWprVDJGK1l1b1NRNmlGZzFVYnZlak1IZmlucnJHOWVDdUdv?=
 =?utf-8?B?c2U0K0R2Y0xCNENiYzJLU1owbUhkRzluMWJhaWlaekFDaWdrTHlWeHRkR1lJ?=
 =?utf-8?B?SXhSaS83Q1V0b2l0MnZXSXhGV3dySW1UVzgxMG9SWTdob25vdmhMTHM4NmNU?=
 =?utf-8?B?QXluekhCNW9YcE1vQWw4N3k0UWdDNXphYUpXRVdvYUNaR1U1R2ZodDM0cFN1?=
 =?utf-8?B?bkthaGhyWWhUcFYvNnp2cWEyV0pwVkFuZDVZNHlVN2Y1QmFuVVhwVTY0NmEw?=
 =?utf-8?B?WFIybWVlOG0rWnFqQ2NxTklyR3o0VmE4THV2SzJQelB1NmFkTS9WVW1RZ3Jp?=
 =?utf-8?Q?uk7XYzk6mvTgAROE=3D?=
X-Exchange-RoutingPolicyChecked: W49F8ZcuGdm2oX/ONo4ywM7eiBuRMBk3xSwJ/SixgpdAwQZ+Q/ySAWLLCRFSMfTGXwK166vpwVVDAHGQ87/BOvZ1Uou3Ckl8t1WfyO3iT8mdYSIm66TgKedjfNRzmbD19QTGxzBIhmv7GyyDZgNa57RPXfgTS4Ijg7LZbSA75PL87yhus9xHCre27ysYpWygraT1yikNZM9avf7Yk3COVcXvD21IiAslBzrlcWWuvsn3VxnftDW+TRdC7IzGgBFcpH/mtYHfNOMqvi5Uqo4wWfWrXMt5WDAzqWAybrm6kKqsAC+Q4cAlbomCzDBmqzV7x0Lx3q/ezXEtylbijbp07g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a68ba-35ae-4f0b-c80b-08de7f65a0d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 11:59:20.2313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzLOtMNxSGY/TO5CZMM7jeWCZKNeGomu5feNAzgpGsIT6JyLt+UzW8yLGBKXHG8nFZ3X0qzZnhn+C7pkygmOw5XJ9Mk1hBq179Shm5umJ0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
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

On Fri, Feb 27, 2026 at 04:21:59PM +0000, Talluri Chaitanyababu wrote:
> Add an overview of the e1000 driver for Intel 1G devices.
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> ---
> v4:
> * Fixed RST structure, single top-level title.
> * Used ASCII "PCIe".
> * Adjusted commit message to match content.
> 
> v3: Resolved apply patch failure.
> 
> v2: Addressed review comments.
> ---
>  doc/guides/nics/e1000em.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
> index ed4f57e9c6..95ff68cb9b 100644
> --- a/doc/guides/nics/e1000em.rst
> +++ b/doc/guides/nics/e1000em.rst
> @@ -1,9 +1,22 @@
>  ..  SPDX-License-Identifier: BSD-3-Clause
> -    Copyright(c) 2010-2014 Intel Corporation.
> +    Copyright(c) 2010-2026 Intel Corporation.

Not an issue here, but FYI we don't generally update the copyright lines in
DPDK patches, we used to do so but in recent years community practice has
largely been to not do so..

>  
>  Driver for VM Emulated Devices
>  ==============================
>  
> +E1000 Poll Mode Driver
> +----------------------
> +
> +DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
> +These include:
> +
> +*   e1000 – Intel 8254x family devices, including QEMU ``e1000`` emulation.
> +*   e1000e – Intel PRO/1000 PCIe family.

We still have naming issues here where we have a mismatch between
documentation and code.

Specifically, if we run the pmdinfo script to see what is provided by the
librte_net_e1000.so file we get nothing listed that is just e1000 and no
mention of e1000e either:

$ ./usertools/dpdk-pmdinfo.py build/drivers/librte_net_e1000.so | grep name
    "name": "net_igc",
    "name": "net_e1000_igb_vf",
    "name": "net_e1000_igb",
    "name": "net_e1000_em",


> +
> +.. note::
> +
> +   The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.
> +
>  The DPDK EM poll mode driver supports the following emulated devices:

Presumably "DPDK EM" is e1000_em.

As part of cleanup of this doc, can you perhaps work to make the doc names
and the code names consistent and clear? We may want to look to rename some
of the drivers in the code here.

>  
>  *   qemu-kvm emulated Intel® 82540EM Gigabit Ethernet Controller (qemu e1000 device)
> -- 
> 2.43.0
> 
