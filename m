Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00610CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6253A402E1;
	Fri,  5 Jun 2026 16:45:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3C840652
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780670713; x=1812206713;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rJO1ZKrYIB+/BpIPy1nlM/jcM6yABQbjCR4vR4mdLuM=;
 b=A20zzSY8uT982KlvYDlwsO57uGxb9+DVED+8qMdJKJitW2FkeeSdvEh5
 O1MJOjwYx+hSAYalWPn/ko8w3dJVW3CANB3konau7CgtaZ6cXXNNywtmd
 CS8Yp1GbH1IPPbAos474/W93c936omy3fAzJEGFZMJ3pipmBpu+A6P6MU
 huhMbCxU5+k4o65v+eLnlaNyMnLo94KTBp5ld3TdF2xkPb/QcvnTHwVFM
 ZJ8n3m8MY8Ey03B2LvoyunTl7SbDxuNvuI1St3diXLoZuIIzx394FK2V0
 IcPeDWkMPaSXSq/23NWhP+rrHbZ3kz4ayj0g5wAJY9dzW+w566xvvuYb1 g==;
X-CSE-ConnectionGUID: 6L2pPMqmRgSATUwiGAb9hw==
X-CSE-MsgGUID: lFF3n6XeRvquvSAAG3AVmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92879238"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="92879238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:45:12 -0700
X-CSE-ConnectionGUID: uP+TSRivTuyTuAKKFe+1GA==
X-CSE-MsgGUID: DtMbXH0MRD258WzrM3DZ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244026094"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:45:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:45:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:45:11 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLoZ9XcubUTaYne83pC3C4WTRbZ9UmGhcY92tE7J6SjG1iS5uPFvgMG6Lr1nqQFq9l5viGnibfJAi9EY/GH2tIy+cpiwiV3rCCfnZZ+B2xhT7WtHE/H7MqY1STsRobAr9BT/LInTLSE/Nw+ypO+bcE+xSKakGVuP+kosjzVJg4j8adSxqTnTmxKjxy5EwQ49Nd2OPjAjWXP+NFcgsZQxrMY85QzdNhIfuJC/TtCVAMeVcaxtKapg9VoY8ndJd62LCfW6RcKPGl4xdG5kkFINZUkRLCWa+ZeeOLst3K9cLbnuz7Qgb5hphMoj0qS1r1aniEGuxAkKCnSrJfcx+BvKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ0FZi5UxuEUr+PmQH96wXVtpTRkw4t32a1JixjM3dg=;
 b=K0+Nx+JmaWyChZeX3iNDIDOItGELJZ7DiuzDhcI6RCtxWW7xRzDZhOZGtWa0wgwoLxXSgy3Kz3R0WJuuAdjxGoSdsFwCBUVRSa2owaKqBFJ0yusiXjRCRpEm2xcuu880gJJcRzah3uqXRn2Stv9HK6mknDa3JldeiN+O14zxscx1UauMQYFJxXtyPIL4Xu3s0kw4y4rDL5uRcGgEGA0q7Xeu5C3GWlPZ6BwEjbJwIHVpcSd9sVji+pulgiTnbTZDA4S+yJfL6aCmlB3j2U1pRZFv4xROxXRZpoCNJ+olClfj7itOOvW7X3TxtB8KoIHswp+UFF+p1WPd0oikZa2I1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DSWPR11MB9714.namprd11.prod.outlook.com (2603:10b6:8:354::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 14:45:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:45:09 +0000
Message-ID: <aa8dd8db-bc49-466a-accb-463d8ebe6d43@intel.com>
Date: Fri, 5 Jun 2026 16:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] net/ice: add tunnel inset bits to flow input set map
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-3-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0320.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DSWPR11MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4c3c7a-af9d-4e59-30fb-08dec3110a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sji2AtEuCM6+oKAy2jsKcmj390vdhDrXnWZ9esM/Q6vzofbgHdOqiz5iD7iC70aWS/+rQ5XNBnBcXwtCCBAUgdE+M3Wy/hG782aT3iQw5gfWsMbcV6c0rnJvlZvpNCaiuYiaap2aAouhK8YCrXH7sPVCJKDJjFN2cbpp7+PVzyI2ZtMPQfLy8Sy7qZ7oLvfxt7YSessId3BfUH7PqWImSiur245kwVqhmTRJdaRON1Wy/VZlvJq6zWtMLT4to4KGN0xgZD6BZtNbg/QXx3bcgMbuVNDNiBcO45qJcNxyFql6iPAYNuaCbtIt2IBCUIwQXEBFi9atBjG1/kGPaKy19V09xAruk4bXPZTyMET7MTNz0kB8tqHuCVxvsbmnvK5/cwFEDxj80lnCZ4cRxM710RH7V+UtSB8jKkx5RMcLrMudWH/tYeKyEvYzh0AD40qYZZ/iqKqpSgMBnAGcr+eovFIl7cHfg8E6+/qE5p/ThaexHWmOCXmMcDU09Y0cr8qnzEYclIXztXhhPDEK562ysL7ekVz49+JYrqjXuRRCg89ru5BgzrjOcD/kmI7U6lDn7woeSbngVJh7aD9VlDX3PfnuPIrJ6A3+5b2Wxf+tKsTwd4ktc+idvFS75v6dAnuuryUFNeutGqdl1wZfigHATzNr7LjYv3ccWfK3Z/eC93B1/fd+H3ch3zdhnF8tgIvy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU82bFBEVGgvdVFnKzlSSThNeS8yT3ZxVVdmYkpXemtIcWxJVEFxZUlHNm54?=
 =?utf-8?B?aUJQcWNLRTdEM2lWMWxYNW4vNzNUZmtPaDcyYjFFazBtY0xweTYyZEQvQ1lp?=
 =?utf-8?B?UWN3OXY1Vld4YTBlc0N5Vm5WclkvMXMyZkRtZk8zUzJpLzh5Z2FyZkJnMkQ1?=
 =?utf-8?B?bUZrTk03NEtzNEFXTklDWHByMFJpL2RtS0I2eEdnY3czWW03eVBCeXRaeUFz?=
 =?utf-8?B?UkdqQ2k0WlQ3Y2V6RXNNMUdOVGhnazlLQjQ2NCtKdUczNzkyQk92RkV1TlVy?=
 =?utf-8?B?VUJXNlNiZExjYktjZUg3REE5dUhMRGdiVHpvUVVhZDlhKzRCTnU3UlByYmFO?=
 =?utf-8?B?NHRaVWRaVzRQT2lJc3JmREltQ1JTTllIZkRsQURlOGhiL211eFVaZ0E0Y0pi?=
 =?utf-8?B?UkJwTUJDSWd5bElHRHI4Mzl3dmhoL25SYzdPUTBQVllVV3NDMU5xMkNZUVZU?=
 =?utf-8?B?S2JsYi9jdjhrbVRrYWxNK09QN3VDTDJLcHpQS3VMUnUwWW5Bb3VzZ0V4TURV?=
 =?utf-8?B?NVZCWmZFQnBkd0toM3BmR01YSUdSdDlSelFTTElWbHhGaUJZWGQ0Qkk0VzdX?=
 =?utf-8?B?eGVnd0R3cG5ZbDkvWENQNzFoeGxVeDZtek16ZHZUM2p2cGxaNDRnQk9FZktp?=
 =?utf-8?B?THIzRTJsM1dMb1dER0VOdnN2QUZUWVovVk9vMFpwRjJrVy9tS3UySTJKKzdt?=
 =?utf-8?B?Y0xTdS9lVWliQ3hEUDRMc0RPaStjODhzaWw4dVU2UGVKSHF4QTkzZ0hPUWZJ?=
 =?utf-8?B?QmN4MkIwRzFmV2tlOHphNk94TGdUZWxWN25ZVVZBVzR3S1pZYzd1QnlCVjBz?=
 =?utf-8?B?a05aaGYwemZFc2gzTjhOTkJmc1M3WUlKSkREcTdYNE10elRPME1xQjlyWkIr?=
 =?utf-8?B?UmYxd1FuVjlhNVhwb08rRHB4TW5DOFBiY25mZXJMSkRUYVNmNlVjdk5QaUxp?=
 =?utf-8?B?VlpBVkZ4Y1ZZRDZJVHhpaUNRVWEwUkZieWh4b0VDaEVUOGFhbGh0TXpHTDY2?=
 =?utf-8?B?MDNZaTZ1ajl1emRURWRGbTVBbnBqUmdvekJ0MmgwSjN6UEFWYkFQaVZsOGtE?=
 =?utf-8?B?Q1ZZOUtrU0Vnb1diTlloWkVCZXVFSUFoTmo2ZFE0eGhZc2xOK01MWUp2eGs2?=
 =?utf-8?B?MS90ZElUa2ppR21FTElPL2VmTHk2TE5JZ3ZzRDYyQVh1ekFscjBYV1VvK0do?=
 =?utf-8?B?Z2Q1dW5QbUpXT1BTV2dLSnF0Kzg1Y0h4T1JqSnUzbE1ncmJqTDJDMXg4U0hw?=
 =?utf-8?B?OHJwQWRXdlN1TXhtOHpDaTd2MXlpckhSNHcrUUdydlN5N0JRdlJvbkhDeXJq?=
 =?utf-8?B?d3ppMUJqOXYycVdQcjFMby9oMkpDaFRHUWFqaE5sUStjQnczVmUyazMxNEVt?=
 =?utf-8?B?dnM4RlFUUkNlSk9TQ2RCTVNHYnp2K2hjdXpqZGQrcUl0UDkrOEVrT2hRQWI1?=
 =?utf-8?B?ZTNObTJpczNEQkcxWmtiVHpVNnJreEJacUhuckxsUS80VUpZa2JKNXNObUlo?=
 =?utf-8?B?b055TlpuTzZxNzFCR3AyT1VmemRhT3N6Y2Z3N3I3dVBJa2ZYVk5mclVIenNN?=
 =?utf-8?B?MWF4aU1FdDhPdWVDcDFnVnhTR05QN3RreHMrV1dROTdSQmZVczVTZEw1RHJF?=
 =?utf-8?B?dXg3cnNWQWFTUTRkMVdTR1dDREgyQmtrb2h0YXgvbG5JTUFKdFVEdEtReWlM?=
 =?utf-8?B?WHZ1a3FpNFpXL25YczVoWTMyY3lNb3FxYm1VM2dDMVZsMDk3SHRNdmRKZU9s?=
 =?utf-8?B?enc1WDd6ZEdNdk5uekFvQzNKMjlpVVlIR2Z4RDJUcUliK0FMOTJFZ2g2VU82?=
 =?utf-8?B?QWNwb1lvUUdxZklBRDJPR0ZBL0Q1MmJiYkhpeTJ6c2cxOHU2Z3Z3RnhXS3Yw?=
 =?utf-8?B?MmpOT3BlZWtmTGRQU2NQWURxTFlOZStNWU9FUGRWTG9taUQyUG0ybGNMVWUy?=
 =?utf-8?B?VWZBZjFydjhBMkRhUk1ZMUJjUkpHS1ZBVXQwK0FRdkN6OWJqa1UvVlM1VXcr?=
 =?utf-8?B?QTRLQkxpeW4wcy8vSkhoVUNWNFhhNnZlZ0F3emVWdnJ5U01mSGIvdVJtOTFF?=
 =?utf-8?B?SDM4bm9KTUJ1U2wxVUgyblpMWXBBaHBCT1kreS9HekZkUnRPdFZHd0RwV0Nj?=
 =?utf-8?B?Q0hIS2ZoK2pmejdjR3ZXMVBFY2FiWWwzblJISE9EaDNuWWkyYlBWTXZtTEx5?=
 =?utf-8?B?MXVNVG9RZEJad2NFOU1qa1cvMzlxQTN6ZGVjUzBzaitLZjBjaFB5UnMwYkY5?=
 =?utf-8?B?aWdrOXJZYy9Rb3IzOTluSGwrWHdxejEySDJVN25ZMGZsM1A3TW5SUFhmai9k?=
 =?utf-8?B?N2xxazNoUW52cW9ZL0h4WXJvR3F1ZHN6dmZjUm5pU2hBQThLU3R6MnFTK2FP?=
 =?utf-8?Q?D4kQjUa+S/ed4Du8=3D?=
X-Exchange-RoutingPolicyChecked: rFkm3OpPI66QkA6XNezcY19JAxe1w6Ic32T/CaU3oAqOc6ovCkBfJPf3txGE2qs6uM4MgvelVAkutMvlVgQOGhBvrgYGXvKvQ8g8/EaqM8yixfSw2blxATsVPvtCnMdKMOWXKDMOXAuqFi0OhElnd/nD9xeDDWD2kdQIlbxvUd4A12abaH5BZHo8ifwatKbX/1ObM8WMrmhSWxRLOdBXxwsSFRJe1EID4PMc2YtwXVcgMuP+gz94oLQ0hjgKOev7vOh0R+nTzKxUr/BgngcKNn7CJJxw9jYyMMiguGHyG0W2KFJtK+pbXe026f4ELwZLf1uCQpsVKrBnKgRcI1OU1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c3c7a-af9d-4e59-30fb-08dec3110a5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:45:09.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4R6qw4VT7S6loMrlg3Jp0NsDnfhGM9QHuD5+O55GwfZ+vdKn+BupJlix1Yn53fabWxiPl+zrRwaEEbpR0rdSqa9oM/4/UJNTwJOsqFoFGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9714
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> Tunnel inset bits (ICE_INSET_TUN_IPV4_SRC, ICE_INSET_TUN_IPV4_DST,
> ICE_INSET_TUN_IPV6_SRC/DST, ICE_INSET_TUN_TCP/UDP_SRC/DST_PORT) are
> absent from ice_inset_map[], so inner IP/L4 fields for L2TPv2/PPP
> tunnel flow rules are silently ignored during field parsing.
> 
> Add the 8 missing tunnel inset-to-flow-field mappings.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
