Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECCFC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BA2A402C4;
	Wed, 19 Mar 2025 11:59:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9A64B4026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 11:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742381982; x=1773917982;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RlUYOTBVTOu22QgCXyR2lldclyCWc3gvtoUvZpUOTAs=;
 b=a0ZYV7oLGOCuZpvRETfcHqevsgXXlZ4qYUjb/A9+BL5w8DyXcpMK0C7d
 I0D39G/0pF+7YwtuKei4tl9geK7KYEQpp6MYLgHkYl7tVv2tOcQ8W0E7b
 XLfJIYU7PCDfC9ukxy5C8c1dVuUftOQOuv8qsg+SaE53F4vr8ckP6727l
 12gfe0eD2wZBm/Gwm/urC9tuvWl3HC598P5HT0tVcasBdlQo7ZXHvIkzP
 G/NFBNEDAuKYvb1HxG36h4bYE5MArgxabg8RxryhvjZUpL4GgV3gRLt6c
 F3uglPqVdCai8B8mdd9eO4clpFNaeRARp80MhckQ/VqcMGwu8tRZ6c/cg w==;
X-CSE-ConnectionGUID: v1bFb4l7QCSqtcnyXThonA==
X-CSE-MsgGUID: 2LrphsZvRMKHTHbDOuwBSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43666467"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43666467"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 03:59:41 -0700
X-CSE-ConnectionGUID: zwopLZUkSI2PvorpUhgHxA==
X-CSE-MsgGUID: nmCIDkf1SI2MFTW66TD7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="122575230"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Mar 2025 03:59:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 03:59:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 03:59:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 03:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdKmqf14KBO+sATDsHpenVWfKik0yzsP5/SJlmVXTBOcBRLoSKP8hZvi9SYdBEvI70LgpDNr6qzdYeikyhBEjsBMk1sBBg4Y3aDh6B8dnxQpnTs8Dx3zHgVls9nUi5ub5ZjVll2JaDVM6DItqBwQAPDbDk3/Bt8EnEtK4iyxXEF4i4kyQJ9ehRn+urwV3HAvpj3AUuUGojf1z2UqXjFM6vtvGRA2u1simoTCMD2ythWn3QnFQ6jUn6cVzlvtxI3D2+/+lI2qRoRsofdQcSt5sAwFVXxYlo5DtI6MN1qkV1tO2wkLzQkbeA1+MdUXe94wEHnOugJ96mQsrpzgoT15jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFKl9B9G5otSaDRe6kVXOdFYHEz/1vrsbLI3Ui5jU5k=;
 b=xDVrNZ1GRDXudMK+KugrmwZ593+PxMaE71gsLKWFGit4YKMoAVjyCyWSC3z35qDYxnMCHvKD+B+lj+hv0uYwFDL73SQumJSkwhfV3Sj7jyx3Hsvn4Ado3tmFASjB9JMe7NjHcCNqmqPgBoXcLNfR+jKx4j0j9HtMCqTDrPfeYYtI5Yjcj80p4M7Uo5o0Gvl6EwWj0qCWVhuPFHJqNQkpNHArODLQ3W5psCwKPwrxX2Bp+tFK1V2a9Bl5/NL4h8TJPuoXEbIFa+XvW4m1ZnoL0lQgjGJNSaczQ4WoEsu8Y3+uDqmZZXpN8IfW2yJ3sX3Xr3dfqAwGJHzNX3aT/j+lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8462.namprd11.prod.outlook.com (2603:10b6:408:1e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:59:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 10:59:06 +0000
Date: Wed, 19 Mar 2025 10:59:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH v3 07/11] acl: use common AVX build handling
Message-ID: <Z9qjdXM8Uno050tW@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-8-bruce.richardson@intel.com>
 <CAJFAV8wPvQKHNFgPvYa1k-L6Q46WcsRCq8O64Mxb9_AX34CgUA@mail.gmail.com>
 <Z9qbwPNR5g3DLIFT@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8xQvCsAnJ7hn=9NGKv_W1oKvDsdKL9v1sOCSU2noR_paA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xQvCsAnJ7hn=9NGKv_W1oKvDsdKL9v1sOCSU2noR_paA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:10:232::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3bfdd0-3589-4209-c066-08dd66d5115b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WStoTmsrQXpNSTk1R2xWMHd6bWw2UWJLVktxd29GWVp2YkxpSVlUc0lpTUF5?=
 =?utf-8?B?RmNlQXBsNUFXbDMxcTNFQ0ZwejBoalYzV3FRNTVwNUwzd1FOWWVINTVvVFBO?=
 =?utf-8?B?Q1Nob01GdFBwY0RPcDYxeURUU08zTkJlRmdFWUU2a0RvQkcwNGlWaHJpbXcy?=
 =?utf-8?B?OHZRNG03QWlRN0NDUktTRndzbXp5emZ3bUNDeFZSWWt6L2lOSUJjRUZ4dFBU?=
 =?utf-8?B?YW4wR2lxUCtORHgyL3JZTmJMTUxaM1VWQzM1ZUpNeHNaR0NUNjhiY2YzSEhS?=
 =?utf-8?B?Njd0YnlzeFpFUFcySmpXYjZERldWdFN6dkFKdFlPZGR4MXpLM1U1RVlXMFRi?=
 =?utf-8?B?NUN5N1FqeDI3cVRJdVBYNGczUTZFek0yL1BFeVhSR3kxREY1SW00NVN5SnBF?=
 =?utf-8?B?SDhidjFMVTh3SVg5RU9NNWF6VUtqOUdaclg1N2srdFQ2ajcxbzl2Y3ZlRG1M?=
 =?utf-8?B?SFBpL0dpQVZLYmU4anBpamVKUmwxejFsR2VEM1hIMGhyVytQRnRwdTBtSDFw?=
 =?utf-8?B?U1A3cSs4MkJHVWpyV0ZURmd1RUc4UENUVWxqdk5Zcys5eHBUWlpLWm5OMTJR?=
 =?utf-8?B?V2psSWd4ZXFIQlJENGtCU0g3M2tRMEhTWnZKdkJrcnRDT0lqU0hsTU5Vendv?=
 =?utf-8?B?Q1hrdWRQOStaMVpQVk1Td3o3OHhZaU92VzVPTGlTMXFGekdBUEZjT0NMRXNU?=
 =?utf-8?B?STFhaEp4YVc0K253WTRaTmVJRGwyMU00TGxEQnkwWVpkNWRiV0JPbzVaR08y?=
 =?utf-8?B?T0d3aGJpc2JJZ3VYQ1NiMlhVdDFYWWgvVlE5VjNYTHVVSnlXbkhjSEpTdmtl?=
 =?utf-8?B?UllvellZWjVwY1Y1d3lERWZwcmVaNnlxVURFVWtEOVd3R1dNOTB0K1MxRm4z?=
 =?utf-8?B?M0NxQ3Y4ejcwcFg0ZnpRdWpYQk83SzViSzMvME1kaDEwWXRveFUwQkpqVjVu?=
 =?utf-8?B?OHVDeTZCazNaZmVwbTRaMDRnRWJ6cHJwVnFpeS9ZQTVqbTVHMGt2WStvTEp3?=
 =?utf-8?B?bnpIOHF1Q0RMaGZoZm5BdmxuZFJFamR4aW9EUzZsR1ZZa2hQU1RSckJtNm5F?=
 =?utf-8?B?dWVoME4vTVp2ZjJrY3EzL1ZqTEJqcWN2OGcxNEo5NXNtNFd5cnNtTkhEd2w4?=
 =?utf-8?B?UUZyRWNJT0RqQmJsWmtUdmNIR3F3aGJYQ085a2cxT1JVd2dDVEgwaStvWWVo?=
 =?utf-8?B?TGJtUGR3OEtkcW1FdEFKZWMvT3VFMmxnNytuOTVsd2VpenhFQjZOVUltaDlX?=
 =?utf-8?B?L09POStQQmVydHZpV1NUR3dtWjh2WmxjczltTExON290anlNeWZqU2x2WnJZ?=
 =?utf-8?B?NTZtc2dlcTMvL0VtR09XWnhZblVxeGJndHNNTG95V0MwOWExeGJqaVNWRXQ2?=
 =?utf-8?B?akpHdlJHM1M3MktOWmlQTVdIS25ZbGtIdm8yeTRWWFNWSDF0SUJhdmFUcmFD?=
 =?utf-8?B?YXN6b1lwNi9Bd1orb2FVQUh5MGR1VGNYR0c5TTdtRzV3OXY1VUNWZFNlaDdu?=
 =?utf-8?B?bnhMbmFxOGwxQmZOZFhuUGJDbHVFOXBBZ1E4MkMyYnVWQ1daZXZpRkFCb2pt?=
 =?utf-8?B?dGtpL2ROWkk1WTdFZkhVNzVYbnYxc2hFdFpDUDNkdVdlRG9UelZUajlMOTAr?=
 =?utf-8?B?WWs1V1RTQ0FRYkMwczF4dWlBMkpzMzI3bElWb2JtaHdNQ0h0ZVdyRVdpejNC?=
 =?utf-8?B?ck9Fb0JudC9kZEpqVWJCTXNIMkUvK0N3R0VpN0VNRU1zY1lqdjV4eUNGTVcz?=
 =?utf-8?B?b0V1a09HbUhQNlJhNmVMd2p2RW15cVVaYmxTcXdZSml0Nld5ekFBVWQxRVEv?=
 =?utf-8?B?RytkMjQxaVFGdXBLSENtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUpkQm9NcVkyaG0wYlZhQnIwbXVnMWFUMWlNemNpbXZzbjYwdnVhVDl4UERT?=
 =?utf-8?B?KzFHd3pEZzVaR2JyeXBreStFQVVBYS9tMnAvbGgwOXIrTUN1d0F6V1BKUVBo?=
 =?utf-8?B?bGxaOE5lcy9ScllXcVlWenkwZTdJckNjSDBHWk5TWWhtK2kvNCt6ZkM1Yk45?=
 =?utf-8?B?N0g0Uy9zQ2VSNWRra2dBdHlSL3pFNnFDb0M3dXVTQTZraGRmalRYSkNhWS84?=
 =?utf-8?B?TnpxOU40SGlMZ3g1TWZhWUpkeDM4cnJzVGh0eTdRWGZvM054NzJFSWcwTHBw?=
 =?utf-8?B?ZEpQTTJWL1V1YXdjcVBQQmdYa20rSU5PQUl6bUxSS1VwL0oydlhUZFRQRVNz?=
 =?utf-8?B?cjRFNzhZQ2dWb3kzSnhQVFI1RElzd2RoWVdFcDhjSVJLVjJSd2VFZlNmb2ty?=
 =?utf-8?B?RlRoMW5FZUJrMzVWWEhvQ25kbnJkeG9pNFN3WXVhMXFzcFhTL3VpRmRqMXN6?=
 =?utf-8?B?ZE9ROVdXOUlVN3c3RjhmRjlaWkhjSWN6akN6REpaQjRCcUhZUTczNGE3RCtD?=
 =?utf-8?B?eFYxUDB5ZE1DamtWTWpaejdMWjV4K2h6M0xtaUp4dFc2dFBQSWtzRXJUeWZ1?=
 =?utf-8?B?dHlwTzV4SkJoVzAyeWdveTNReTVNRVZpUjg1bFg2S3BpNFBENVJzTnYxTjRj?=
 =?utf-8?B?eCtCcHh2Qi9CRzl6VVUwYUQ2YlhSL0tRajYxN2Zoa0JPSnUwWE1wdTVaSGFw?=
 =?utf-8?B?RTdPUnNLblB2a2VLV1ppRmVIbkM2K2lqS29TR29rMC9JTXh4dVhjWVdFZzlC?=
 =?utf-8?B?d0hOdnN6RXNWZDhtRzViWWZlUzFGT1pmZExoOEw1RUkzd0RYS1gvb1Bubk1a?=
 =?utf-8?B?WUN6V1hqTUNtYURBSU1MQVhjNGdzbFA5bGltK3gzNEdUUGdnSnIvUk5ZV0Vj?=
 =?utf-8?B?Z29aVEhZMXNEelhxdXdYNGJrT3QyV3Fyc3ZnaVcyT2NQcUdXVkZSNDlvcnZw?=
 =?utf-8?B?bEZXRjVkMFF1ci94VGVwYXI5czlUdFpCandtRlBSc2NNemY1RCtsaE9rWTI5?=
 =?utf-8?B?czAzbFB2dGErS3BpcFpWbEM1Q0dJMU5rcjhQdkVjTFRKQ3Z1ZytmTDN4ZjlF?=
 =?utf-8?B?NWdndFd6SytaTHJIQmluUS8xdGMxUjBuc2VjbXB0cXB3eHd1WVM1bHpBZFZJ?=
 =?utf-8?B?VjFVMTVnWVNmakNSMklaQWR3bFZ6dm5vQ3pJZDFueXc4S0hhU0dwclhBOFY1?=
 =?utf-8?B?NkJ0WEdNZVllNkw5NVdoeW4yZjl6N0FpYWdiZ2xvd2dUdHFQd2FhNkd5OGsw?=
 =?utf-8?B?cHZFVTV3UHpyWmFGQXRVKzlTQzBkcHFrRjJZbnNkNVFqY3pWWU90dWtkeW5Q?=
 =?utf-8?B?bWxHdnNNMnQ1TFFLZ0hmV3ZFQXIrVVZaSUJWNTBZbkJKcC83enNQV2dhZWl3?=
 =?utf-8?B?RGRzQWVJL0tUYVV3TVVnS1BRMkdSend0YUxqa0dFVjMrdWdJSWEwT2EzS0JN?=
 =?utf-8?B?aHF0RnpxaTk0YXlkaFY3eHN6dFBxdlI0VFVqcitYeG43bUt4QnhIMkg2WVF6?=
 =?utf-8?B?TVMweERJMkl2eUtMQUJJeHZMaXFKa0ZFczN1ZEN2aXJlMFBWRHRSdXY5L3FM?=
 =?utf-8?B?TzY5ZEtsSE1TeGIxOXh4ckY0UGRCazByRjhKK0FJMlNtSUNDOWdpcjZzMTlM?=
 =?utf-8?B?R2UyclQyUk9IaTM4OHltSG53ckhoZkUwUDdEN2N1TkJjSGg5RjhTZ2Z2OG5i?=
 =?utf-8?B?R2JaK01ldHFITDhsY3VweVlpZWtwZTF2ay81MHAvZmRsMTljL3dvM2JuZWYr?=
 =?utf-8?B?RzJCYVFHY1oza2VkamFBZkRJaEJFS29RZlhQRGxIVlg4R1lFczJoY0poM1Vx?=
 =?utf-8?B?Vm5KSCtYWVQycXBhcmYrOE5TQXloZDJrZ0JVUDlEZEVPeHQ5d0R5UW01dEFo?=
 =?utf-8?B?TGxNTTNRUmJTbUp5ODV3a3FqWmk0MXoybWRlNXM2bkJFTWtQZnkweDBPdnhZ?=
 =?utf-8?B?aktrK3lBcFhNZ3hOSGZsVnJKdGFZSkdWWVp5c3d5ZE9DYnlCNXVSYUxNc2M0?=
 =?utf-8?B?UHlTK0s5QW5icjdteHJEeXpqMTdTdkEwcEQyVjREYmhRRHo1bVpQZkg2VWVz?=
 =?utf-8?B?WTdVK05OSlFudmpobzVRWkNqKzFTWVJCSkZHWklLcGNOa05OWndiblFhaHhD?=
 =?utf-8?B?MkRkd1NDQ2ZHZmU4T29qaEhIZ2ZFWS9zWTFMR0NaTWNuSFltM0NFNGIxSGww?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3bfdd0-3589-4209-c066-08dd66d5115b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:59:06.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBYuc31NB9eNZohysqe1tNXaob5NQcHNuKlujNch6l61VlqA6gymxiYkvwfxms992NKJSFOD8mjZHBHn0ngQ5zgZzcAD4Lpfn3fBQVPs4dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8462
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

On Wed, Mar 19, 2025 at 11:40:19AM +0100, David Marchand wrote:
> On Wed, Mar 19, 2025 at 11:26 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 11:16:09AM +0100, David Marchand wrote:
> > > On Tue, Mar 18, 2025 at 6:35 PM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > remove custom logic for building AVX2 and AVX-512 files.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ---
> > > > lib/acl/meson.build | 54
> > > > ++++----------------------------------------- 1 file changed, 4
> > > > insertions(+), 50 deletions(-)
> > > >
> > > > diff --git a/lib/acl/meson.build b/lib/acl/meson.build index
> > > > a80c172812..87e9f25f8e 100644 --- a/lib/acl/meson.build +++
> > > > b/lib/acl/meson.build @@ -15,57 +15,11 @@ headers =
> > > > files('rte_acl.h', 'rte_acl_osdep.h')
> > > >
> > > >  if dpdk_conf.has('RTE_ARCH_X86') sources += files('acl_run_sse.c')
> > > >  - -    avx2_tmplib = static_library('avx2_tmp', -
> > > >  'acl_run_avx2.c', -            dependencies: static_rte_eal, -
> > > >  c_args: [cflags, cc_avx2_flags]) -    objs +=
> > > >  avx2_tmplib.extract_objects('acl_run_avx2.c') - -    # compile
> > > >  AVX512 version if: -    # we are building 64-bit binary AND
> > > >  binutils can generate proper code - -    if
> > > >  dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok - -        #
> > > >  compile AVX512 version if either: -        # a. we have AVX512
> > > >  supported in minimum instruction set -        #    baseline -
> > > >  # b. it's not minimum instruction set, but supported by -        #
> > > >  compiler -        # -        # in former case, just add avx512 C
> > > >  file to files list -        # in latter case, compile c file to
> > > >  static lib, using correct -        # compiler flags, and then have
> > > >  the .o file from static lib -        # linked into main lib.  - -
> > > >  # check if all required flags already enabled (variant a).  -
> > > >  acl_avx512_flags = ['__AVX512F__', '__AVX512VL__', -
> > > >  '__AVX512CD__', '__AVX512BW__']
> > >
> > > Not sure it is an issue.. CD is not part of common cc_avx512_flags.
> > >
> > It is since bce754b5d942 ("config/x86: add more flags in common AVX512
> > flags set") See:
> > https://github.com/DPDK/dpdk/blob/main/config/x86/meson.build#L68
> 
> Err.. I meant the target_has_avx512 variable.  But looking again, it
> seems we can remove this variable entirely after the series.
> 
Yes, though I'm now thinking that we may actually want to use it.

Since we have the avx handling "centralised" it might be worthwhile
looking again at how we might generate the most efficient code in all
cases. In some cases, using the AVX512 flag explicitly, along with
march=skylake-avx512 flag, may produce worse code than if we just used e.g.
the "march=native" flag. While this code was spread across a dozen files,
and newer instruction sets beyond AVX512 were not that many/common, keeping
checks short and to a minimum makes sense, but now it's centralised in only
2 files and new CPU generations add more capabilities, an extra check or
two doesn't seem so bad.

/Bruce
