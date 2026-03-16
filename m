Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D135DF53D69
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3690240652;
	Mon, 16 Mar 2026 16:31:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BD5AC400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773675095; x=1805211095;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QXOu9uLbR8AAzji2rU8VT5w+5LdPwdW7FI1XrYZaWkk=;
 b=W7AJh7zdiMg+X6MCqrmcyIjiqzsPZIvgcXo670FN3pxbJeDylOO7OYzf
 xGdi4wyLUkR3siKKX5Hp/fdQBBo3mJLQO39xXgY3bE/FYy1wGegBWFT4Z
 ATot/OF04pgT0Dwn6H+MaIPmdXdUMXzywHTvzEgHCx78FllSSqangotxC
 juVLDQnv2kSr9cipUXN94bE2nUtUFfxXvZmOeUB275dPcxNwg9Cwvszb7
 QYGID5lMrqOteSEvrJhSEarZwz0OHpQf+MeO1GepsKM4j2b+Dtq7+ePQB
 rUvjFYPolhMYBLmo183dkDkkNwBbw9qIRbry+d0IY90ly+zGneyeiDiQy A==;
X-CSE-ConnectionGUID: CndTrtSaQnaaiPPaU8xASw==
X-CSE-MsgGUID: B9b7ESvyRFWPez80MSIvFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="62262570"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62262570"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:31:33 -0700
X-CSE-ConnectionGUID: q3JImtC/RTSwp2A7dqoR+g==
X-CSE-MsgGUID: q1ANgTCHTnOeIVjjbi4bhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226937324"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 08:31:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:31:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:31:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:31:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxMi/TdfFyRDojzLKso/vcwUtFGiwkxQOBaaNvbSZfBy40ygWez04uf7vSf2YAnQSUXWSMSNPl6GkJJCURfgQ9R+06klG2MGDc6MLOKvXaNrQsCu5M3jSs2DT1Ix3vKf43BYvBZFJg7eTSVzqksU0XJx+X6E5yAaSOak3k1OBc+62T/rUlJ6C57rGrxIYMJXDrMh9UTeXV7dZZZEx/Bmf9d8lZflpqTj3qT84glJcKdW8/7fLLWggdUuHOAoEFb0q+u5Cr1ZcaBOr80RzpBBuq2oHlepuxF/73dwzjSnYeuWNJJTnB4qxovUb3w+f5enWJ4S/RfztHcVBxg9JTvpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtARLA/wNIJQ6T8ZZhEsK2TUwmG/vIjORCDb2TzB3uI=;
 b=XpeP6LFmnCbjsC7ptQJx1ECg1EJ3IyP7XZZYRZuqFsuCJXqEf9NfuSJQhY1NtznIn8OQc7SvG1bY2ZFxlx8S4SKx4Mx9eOnr3BuyyNX6fvpPbA2Tx6SulLSAn79AaFyvnaNvu7zypFJ4wKOXs347mvLpFnsC9Uz7cLFWebm+i2RM2BCbKujN5xXpq81+m7l1Pw25moDaK+zzpO2vhCeUdMJWH9rx9MAyPldR8Y3t9VwLKZRTjdUMQAb8u3HB/4Jpiop6gRhx5i7/J6M/fh/J9S2RxrsqOGDM0k06jxtNcIk89AsHWRQ7d4J03GC3sD/xRot8xOFasbcE7qOBr2EotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM3PPF01A5BE19B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Mon, 16 Mar
 2026 15:31:22 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 15:31:20 +0000
Date: Mon, 16 Mar 2026 15:31:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 24/25] test: add comprehensive test suite for pcap PMD
Message-ID: <abgiQzgN7mZaUWH2@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-25-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310161356.194553-25-stephen@networkplumber.org>
X-ClientProxiedBy: DB3PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:8:1::31)
 To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM3PPF01A5BE19B:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf399b4-6a02-43fd-e91e-08de837112b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: swKIfHurAadwg61f/0sBvGL+RK9KBBkgkukAMIIRgFqE3lEIcuJ4SjanCwzvz8da8spTWzK54LlS5I9Vl8kC4mC7Q6K+5Z21U/d881B7wxsnkAnDKU5hPuiV9OC4pnEtN+pIXYHVDJo2F9ACFfXV0jOTp1th42RWaNd7xcdL1hE5aP8XpKh38LlMllopjqpc7fLCvZMFCkqXb76rIEPOXJXZxmLQ5LuMEsBXD0ndkHnwZFbb/h+xA1V1HBjWBaoi0qmlP8rZ6Mzb5MNH6IrJL8maYKL2AdUnEx6eMDAqMG7DpTc/n42dLG9A3ayEbqTe0HsMw69BLLHDhccM7QhKtNK2fliwNHRvGje39yRYpt0QfxOV+0rc2VAxSrprjx05tU4PDQkE9mhUJ+g0UnXd8g7BzEBdNbosrzS+RBF5CJBOb9Bqkt3u6mzPFuDQdWANNqhVoH5Vg+cE+H6YS1/JbbChqtfw7rE1Dskv6gAt2zthvSpuSluh2J7Zql7pGKPoCPYMSEqG3hisQ79bZJ48k7Q103eO9Mnp5O1oqzp5UtPGWh+IrCS3BQTBYZv+F4QOmK9X4BNZrPDDh8XPW47e2cu45E9s1ntFkkBk/MAt6ZkAmB3qJIwylxobP6ZiLjWLWKL2pu9uqIeTUy1sPvNWOV9K6lOWouus8fg+vzSil3F9/JIizSN2S8gjulbUMAYvtiP8dudNICQhZ4rTqE3Rs9cQMGXJgFHcWYJoXLM16+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnVOakNmelNybzBrQ2U1TER6ZjA2dm1iU2ZzUWJjaysrQWpVbU9YV1hwM0ho?=
 =?utf-8?B?ei9nT2hLRW9ZOTZyL0JXQXdoTCtJVGpaV1JZT1BHdW5Oa0NzS0w1bDUxMUZK?=
 =?utf-8?B?R21TNWhsZGdJWU1ZdnY5dGpCS3VHMzMzMjU1Y2J5MzZJNW9OUVhMNGdndWRW?=
 =?utf-8?B?WHNCNGRrcUw3YU10ZVZDRmhndEh5akI3aVBEN2VsTEZBSmt1S1kzV2prRnc2?=
 =?utf-8?B?am5jNGNjYlVycTZWSzJ1VUEyc05MZW5zK2tMTmRVZ1MxQ1lJMlFucmhZYTVR?=
 =?utf-8?B?SkZsb3hGVUloYjFSL3FlSHBodmM1VE0reCtDWTRxWHVDOGsyZVFlOU1OUnhI?=
 =?utf-8?B?OHFIYjVpeEVXeit3cnRGSjF4VElVRkpnanFXQzJOQ0xJZGt4a3hkdU83NEpq?=
 =?utf-8?B?QkJSZ3JlWkQvWiszTW1zWStwRnM1NUhDOUYvRnpVTWsxR1BFKzNMYmRReUJv?=
 =?utf-8?B?eUM5ZTlydmNabHA2TmNtdUxGbGp0L0RwbFppanMyWGZvUFdLUU5VYWI0Z3N5?=
 =?utf-8?B?TUZqcVF3azRaalBMMU14ZWVsdEhzNm5Ba3dnRjdkZVdHc0sreGNrNmFWbFhD?=
 =?utf-8?B?T1BZbFQ5bUpzRUU5SHU4dGtySk1GWUVkR3l5WitkV1BqU0Zzd3N2Ti9PUEtq?=
 =?utf-8?B?eEw2aEpFZGdTcTN3a1FCZWRzVlV1OGNweldraWpSeGFSSUl2OU9XVEp0aHBu?=
 =?utf-8?B?WFQwaEVGcGxISFUySkFYc09KeEVYcVRQSFAxV1hhVlo5VlBHNEFNbWZIbmUw?=
 =?utf-8?B?bjZJYXo2VFU1YTBPUm1KY1lvby9LMldkdkdzVFRQUUhSZUV5b09TanJWRWkr?=
 =?utf-8?B?OERYaURYYUNMTUhJS240RXJPTktPZlUrZktDWnNzbks0TXFtSTIvNEttY2pl?=
 =?utf-8?B?bEhaZUg3Rjd6MzJXMnV4aDNrRU5WdHBXUFVGeWJlc1hOWTBMeGRudURYc29S?=
 =?utf-8?B?eVMzRGJKY0tXUVErc1d4cUh6a3VQRWJ5cUZISi85WXNtbVVuY3pzTU9RM2lq?=
 =?utf-8?B?VEV1a1U2V0pjOThDdXliWVJnYjF0RzI1ZXU1VnRnOEtEeHhhemdjcXRUamxI?=
 =?utf-8?B?YjlBM2lrTlBCSjhPcGdBSXFlYkF1L050WCtsbXVOK1R0SklZQy9YcTFFa1Ey?=
 =?utf-8?B?WVUxQloyVGdyN3FBUzE3R0x3N29QL0orK09KUzVHMHNRZlBTUnlQTitWajdP?=
 =?utf-8?B?ay9mbHhWYjN3V2F3WEduc1VWVXV2RkdKdjVVS1NXZ2tIdVFkNVczcTNoUkVC?=
 =?utf-8?B?K0FLUlcrNTdtYnlHOTZTaWhnRkNWdlc4T0hqWUNXNVUyYnQydjlXL05JMGsw?=
 =?utf-8?B?N3lBN2Nmcko5UXd3dURNQU1VNE1kTjM2QzZrRnB4UFFtTGFxNFlrck55cjFJ?=
 =?utf-8?B?cEYvd2dHc3hlRCtDWWZpYWJFTmtXSS9VdHpZZUZmM0VIWWQ3SEhEZmxYTlNQ?=
 =?utf-8?B?YnA3UTExNHBEOHNlS0xNQTRVOWNFZWsxcGhvZ1ZaMFYxWmdZUTZKK0Q2SFNE?=
 =?utf-8?B?ZnhlVlpaZGJhVXVkODJHU0lzQlBKVGxDNmJNd3owYmNWVHBDNjRQekdJZVQ3?=
 =?utf-8?B?dU03OGxOVHlXMFpGWkErbi9OUlA2QUl0SUw2QlJIYkFvb2pUbmRPK2FTdVg5?=
 =?utf-8?B?bUhqajVudVA1ZFZFMkp0UzZlSTRyMytyQTBERlMyRkw4M210WDZ3djRFMmpU?=
 =?utf-8?B?QzJUYkhZWjFRZUFwRHh1OHFFcFRIVTkxUWYvdWR0bmpoZDZvWVczcmwyVFRw?=
 =?utf-8?B?aHc1SVU4N3VaYzIyQ3RKbnhwaHdWSVE2QWRhSjZvSnVNb1VaRTEvMGtjb2ZP?=
 =?utf-8?B?Qm82QWZLZWFjWm51NXp3dWNicC9WU3ZpMVkwSE8waXVCTzlKSXo1WGtCenRD?=
 =?utf-8?B?YnVJTm1tQW9ZWnpLT3JtYjFXeU1YMVRxSmpIRU9SZmlDNDZObGwvRkkwZjBZ?=
 =?utf-8?B?clc5WHc1QkxPc1M0MU5LYXdsdE9GUndhVDFCZ1dNSWEwRFRZN0RmVjV5Vlhn?=
 =?utf-8?B?Z3NNN1NZNlVSTG14NWZQeXBOb2dsZGdZQXpXL1N3VTNkTUdIUjVtb2wzUGFu?=
 =?utf-8?B?VmNBVnI5K0xCVkowalZPcG1wSUZtOElHZU1LOWFuNzFTSDlRaUFrQ09tYzk3?=
 =?utf-8?B?RVNVRjc3MmVTSnpBaXFKUFgxVFpZcDl4Um4zWVdHYWsyekF2NTgvdGtBTlhI?=
 =?utf-8?B?RFl4MGo5TVByUmozemJwNFBySzhGV1oxa3NzOWZERjFORFcvaEhpMWpoVlBS?=
 =?utf-8?B?SERwSWVreVV6STNyVUt0VU0veFFBblgvWVMyNFRwOWhJTk83K2c0UndGYURl?=
 =?utf-8?B?Z0RwVGNKVUVXY0pva2pRb1M0VENkY3UvMDRmalR4UHZjd1ZYbUlXWGRmUlJ4?=
 =?utf-8?Q?5TC8xdgaT9N+CX00=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf399b4-6a02-43fd-e91e-08de837112b2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:31:20.2777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QedZ8cvNh807kKLvklDYyEMXsJ0apKxNJIInqWj9kj2pxgpOeIXKL1Cql57lWhRVZApU0zKOd6SXFSvR8qqAHXl4ehqfMvHHtvy2K6d2ETk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01A5BE19B
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

On Tue, Mar 10, 2026 at 09:10:02AM -0700, Stephen Hemminger wrote:
> Add unit tests for the pcap PMD covering file and interface modes.
> 
> Tests include:
>   - basic TX to file and RX from file
>   - varied packet sizes and jumbo frames
>   - infinite RX mode
>   - TX drop mode
>   - statistics
>   - interface (iface=) pass-through mode
>   - link status reporting for file and iface modes
>   - link status change (LSC) with interface toggle
>   - EOF notification via LSC
>   - RX timestamps and timestamp with infinite RX
>   - multiple TX/RX queues
>   - VLAN strip, insert, and runtime offload configuration
>   - snapshot length (snaplen) and truncation
> 
> Cross-platform helpers handle temp file creation, interface
> discovery, and VLAN packet generation.
> 
> The LSC link toggle test requires a pre-created dummy interface
> (Linux: dummy0, FreeBSD: disc0) and is skipped if unavailable.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/meson.build                   |    2 +
>  app/test/test_pmd_pcap.c               | 3755 ++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_03.rst |    1 +
>  3 files changed, 3758 insertions(+)
>  create mode 100644 app/test/test_pmd_pcap.c
> 
Ran this patch through AI for a code review. Below is the output. In
general seems a good addition.

/Bruce

Code Review: test: add comprehensive test suite for pcap PMD
The patch adds a 3755-line test file. The breadth of coverage is commendable — it exercises most of the pcap PMD's devargs. However, there are several concrete problems:

Bugs / Incorrect Logic
1. Duplicate values in test_tx_varied_sizes test array (test_pmd_pcap.c:1203-1205)

PKT_SIZE_SMALL (128) == PACKET_BURST_GEN_PKT_LEN_128 (128), so only two distinct sizes are tested. Furthermore, PKT_SIZE_MIN(60) == PACKET_BURST_GEN_PKT_LEN (60) — the whole point of mixing these constants obscures the fact. The array should use distinct, intentional sizes like PKT_SIZE_MIN, PKT_SIZE_MEDIUM, PKT_SIZE_LARGE.

2. Timestamp exact-match check is non-asserting (test_pmd_pcap.c:2322-2325)

A timestamp accuracy mismatch only prints a warning; the test still passes. This should be a TEST_ASSERT_EQUAL(ts, expected, ...). This is the entire point of having controllable timestamps via create_timestamped_pcap().

Test Quality / Weak Assertions
3. test_tx_varied_sizes doesn't verify file content (test_pmd_pcap.c:1240-1244)
It only checks nb_tx > 0 — it never reads the pcap file back to confirm the sizes were written correctly. Compare with test_jumbo_tx which does read back via get_pcap_packet_sizes(). Both tests should do the same.

4. Statistics test doesn't verify ibytes/obytes values (test_pmd_pcap.c:1462-1474)
test_stats validates ipackets/opackets but despite checking ibytes == 0 && obytes == 0 at init, it never asserts the actual byte totals after traffic. The driver tracks bytes; the test should verify ibytes == received * sizeof(test_packet).

5. test_lsc_iface skips with TEST_SUCCESS instead of TEST_SKIPPED (test_pmd_pcap.c:1981-2000)
Three early-exit paths when no interface is available return TEST_SUCCESS:

Compare with test_iface() at test_pmd_pcap.c:1644 which correctly returns TEST_SKIPPED. This makes CI results misleading — a skipped test looks like a passing one.

6. Similarly in test_rx_timestamp (test_pmd_pcap.c:2308)
When the timestamp dynamic field isn't available, return TEST_SUCCESS is used instead of TEST_SKIPPED.

Racy / Fragile Tests
7. LSC callback detection relies entirely on usleep(1500ms) (test_pmd_pcap.c:2050, test_pmd_pcap.c:2074)
The test sleeps 1.5 seconds twice waiting for the pcap LSC polling thread to detect the interface state change. With no retry/poll loop, this is fragile under load and adds 3 seconds to every run. A small polling loop (for (i = 0; i < 20; i++) { if (lsc_callback_count >= 1) break; usleep(100000); }) would be more robust.

8. EOF callback timing (test_pmd_pcap.c:2229)
usleep(100 * 1000) (100 ms) is used to wait for the EOF alarm to fire, then immediately asserts eof_callback_count == 1. The driver uses rte_eal_alarm_set(1, ...) (1 µs delay), but alarm delivery is not instantaneous under load. The same polling loop pattern would be safer.

Missing Coverage
9. No tests for rx_iface=/tx_iface=/rx_iface_in= devargs
The test covers iface= (symmetric single-interface mode) but completely misses rx_iface=, tx_iface=, and rx_iface_in= (asymmetric / separate RX and TX interface modes). These are distinct code paths in the driver including PCAP_D_IN direction filtering for rx_iface_in.

10. No test for per-queue start/stop
The driver implements rx_queue_start, tx_queue_start, rx_queue_stop, tx_queue_stop. None of these are exercised.

11. imissed stat not tested
The driver has queue_missed_stat_update() using pcap_stats() to track kernel-level drops. This code path (iface mode under load, or mocked via the pcap stat interface) is never exercised.

Minor Issues
12. Shared state between tests (test_pmd_pcap.c:60-61)
tx_pcap_path and vlan_rx_pcap_path are global state shared between test pairs (test_tx_to_file→test_rx_from_file, test_vlan_strip_rx→test_vlan_no_strip_rx). Both have fallback access() checks, but this creates implicit ordering dependencies. The comment documents this, but it's an unusual pattern for a test suite that should have independent cases.

13. Missing rte_cycles.h include for NS_PER_S (test_pmd_pcap.c:2319)
NS_PER_S is used in test_rx_timestamp() but <rte_cycles.h> (where it's defined) is not explicitly included. It compiles today because another included header transitively pulls it in, but the dependency is fragile. A direct #include <rte_cycles.h> should be added.
