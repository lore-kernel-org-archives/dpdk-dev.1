Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440BE6816B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A6D40269;
	Tue, 17 Feb 2026 13:32:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 29A7F400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771331535; x=1802867535;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q0nAbuolytD0ZfUekFVtOlKmj3xei4MlWKiUtE1IX00=;
 b=MZi5F6BbyTgtxcYFcFqTlGMoUN5eXGfof05N9J4FHT1HDmUFgnB0+gvk
 yNG39RVzRjwXtdrfXShOKw67plkg0t/wR7Npo8Ni4yb+Q2x1rYVyYnnFp
 tKD+QvRcReDuyGNPyPo4PiVBAYQhwxfCB55TLKt3Wt8jLC7PKLnmhnz9V
 KQPz1do6EJmx1DNYcf0r6EkeANTIGf5gu94KlpJo6CKf54wIVWq0A1Vyr
 gmyNvXq5PSK94uBd4oySehVBrduddTnY9ThW5Uc8z4y7zZKlgyX4qzFd4
 g0NQRt8QQUyNr4HLmngRXmBSM+H21A/Cve3rBAcHAghRzlVSnOeBb0sR7 A==;
X-CSE-ConnectionGUID: dKcItuJ+T4K6z1GXkErSdw==
X-CSE-MsgGUID: u6lm/BHDS8GiuGOqman3DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72285699"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72285699"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:32:14 -0800
X-CSE-ConnectionGUID: u118+TUqT/GPQlrIo1mWGw==
X-CSE-MsgGUID: gtaOp4idQUuXfSPZJQ5JoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="251555190"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:32:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:32:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 04:32:13 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=occvTXHX9dbVpZ5dVVP0vMQMq0y7qEuJBYsjUlrUtnZou9kZ0mRlW7r13qoVRvWpOmIzju1cxz7ONoFp4TMU5GY89N0fzcsJaiONuTHUgJsoPK7inmdgzl77ddcKrPrTE0GkNq/ET9uMOUP0dAgBuI7W/LOI8A3E4q1ZEjqoZG73RB5mpfiTLqxY8ikX5yNv6EWR9FpVEPNwS8oD+lPcqwt3r/hmgvQTthB5So1ScsmZ2p8hGwvTld04LrBMOVcmUrX/WI8eejFcSMm0eyRVstoMOFAzVZKOkzx0wAVyQPGExXqQOkP3/bCO7sIl64wvT2ds0Ys7a1G1EiS0nUvM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eorgqBY8i53eP5LArY85RJM5eNjUOlyvO4gcyyv7tHQ=;
 b=GC24g4fEbp/KUrkqXS0VHkwvRR2Wh7DEzsVzjS4OUyTdML3qp6ykq5caAbp3B6j5oBCYd/BwyqgmlcZCjKcNdmyBLq9qTlfJLsXd0XzO+a5ZC5MuuRrwPIVv8iJs4gurv0E9/Z5AtIa1UgbFZ69S+1Y4nLq1fX9oraRFZAA8ipvg2OUX2kBVZUDiYdF4lbgQhxVpj9aHw+jvMHllxGxsRhwDhK5uBmXjZI7e/6Rzio1YZfsyI2+Xec3OOTXXbAea2c3kV8PeQa8MEK7+KxVvC0XZTbTLev1hcFMvJgtEwjz+fS6t6q2SFF9YSzc9VWIyXpB7LGC6o6Wpz9oqHHX0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Tue, 17 Feb
 2026 12:32:11 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 12:32:11 +0000
Message-ID: <ad1ce316-2694-451e-8a51-2008a65cd8b5@intel.com>
Date: Tue, 17 Feb 2026 13:32:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/27] net/i40e: avoid rte malloc in RSS RETA operations
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
 <aZNOm5EGcN7uSeVt@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNOm5EGcN7uSeVt@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:10:36::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH3PPFBA2AA2BA3:EE_
X-MS-Office365-Filtering-Correlation-Id: abf57d94-218c-4d54-9f4c-08de6e2092d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVVYM2Z4ay9VSG5DRlQ4QlJIOXZPTjFFdGRuRnMvR09MeXF3WlhBcFAzOU1t?=
 =?utf-8?B?SHcxdkgxZVNFK2pvTkllV25Jc0c3VCsrSGdPUkNXaHRxWXlaYkdYVHZKaDIv?=
 =?utf-8?B?ZlNQUmIycWIyakZnelhVY28zN3J0K1BSVG1TcU5oVU1DbHU4NFJhWHp0UHRs?=
 =?utf-8?B?OTU2em0xdVA1SzI1QXk0OWxMeC9PdU84THQ1eEdjMzgrNVRBRVQzSzVEOWZl?=
 =?utf-8?B?V0RZTmJZWGhJdHYxM0EzTTR6WG5NWWhZSENLekVJSkhVd2RRZGN3aXBoeXVL?=
 =?utf-8?B?eGF5N1YyZHdPM2ZXYVZVczFJTXFrR2ZTdU5xWGxGbXhIRGpxZ2ZNUEdBb0pt?=
 =?utf-8?B?cVBjOGxOdnlCaTZjY3p6dW83eXl6SXptRmg5ZlliaWRhQXhyWXBJKyswcUVz?=
 =?utf-8?B?QXNMVHFFNWd1SDltaGkzSTFmSFZuV0xHbk9scHdxdit5cXNGMnAyQ2ZBOTVq?=
 =?utf-8?B?ZEJIc0EwWHZjQnZ1dzJGa2dQU1BTRzhDeGpSQUk3TXRLbW9xNlZzZDhSdnZF?=
 =?utf-8?B?dlFrMThRMHlyR3l2bHJqT2F4RHRwTFJnV2EvRWFkVUwxMkpFc25NckpvY1N5?=
 =?utf-8?B?bVY1QWlmTVlkRlFST0xBRUdwUjgvWG9wMlEyNGhwS2UzR0V2WGtkL3o0eXAw?=
 =?utf-8?B?TmVYcmM1SW9IU2FYTDA3eTJKMmM3a3JkWnk0RklCNC9GNDY0dTg4SE1xUEw1?=
 =?utf-8?B?U2JMTVpkUUhtYk13ZlVtWlJDWHRxK3BJakc5Qk9HU1Q1MHVKQkFMYkk4R2g3?=
 =?utf-8?B?UUxZVktoUEVwNnZiTEZ6UlBVRlI5c0F4SFViM0JpZ3haL1B1VlUwUWtSME9X?=
 =?utf-8?B?c2FaeXlBMkFrUWJwMFZxMStWL2c5MHkvN09TME1EcFMxazBjRXVQYWlRazhI?=
 =?utf-8?B?TkdUQkhQa2ZneWJXOFBNZzRZMFI2OU5DN2pVeHZJZHRnSGlDcis0MDd2S081?=
 =?utf-8?B?MDVPcWhwNk4xeGI5Rlp6UUZIYkdreGllQjFHVktZblUwTllkb3JJNkpxd21q?=
 =?utf-8?B?T1lORGJKVUNJM3N2enhiNldXajMvWXV6YXEyQmdiN25OU0xvVzgzR3drNG5Z?=
 =?utf-8?B?Tk8zM0xBMDRXU0k3R1BDMlk1OGtGdlYrNFFjUEMwOXVGVEdKYlNJcnZRVHhL?=
 =?utf-8?B?NHJBRUJxb3VHenhSZlNoaEtCRDlmZ2ZyV3BCSDJCdUUvaTJpVjMzUHMzbVox?=
 =?utf-8?B?dmwyd0NTS1RGbW5ZTld1UERtVEFMTnpsTXV5aHZxM3RlUUVPMWdWTERIY0g2?=
 =?utf-8?B?RzNyQnNwdStVcVdOVE5DTWhObHZLeWNpVFhaK2JONnZJOFd3bVljc0RoNkE0?=
 =?utf-8?B?VHRtUk1tRWg0KzR4RFcwbVA0eHArZnJqZllCVTNoMDl0SFhUTjBZMmJRZEZM?=
 =?utf-8?B?SFNVZU4wS3ExWHdhVTRHa3NpRnJYR0l0cEFrL00rR1l2QWZaWElDUHFVVWhs?=
 =?utf-8?B?Y29lTys5OWV0S0hQZXF3OC9jcUFONFhORUlleGE1VCtPSHF5MDdNaW9Ua29I?=
 =?utf-8?B?SFYzUklaaTl5emJzdXpmYld2M1dvWG5JYnF4V3hWT1pwb09Bbk9DWXpjODFR?=
 =?utf-8?B?c3I5Z2ZHNHl1M2h2U3NEMzRmOTgybTFla2FPNk9DbjVjUmF3TGQwZTVMazV0?=
 =?utf-8?B?RVJ2WGhER3R5eFJsbDhEK1d2c01WS2JweW10SFR5c2pVRDZkYlZDRU5YNFRQ?=
 =?utf-8?B?RXprajJWd0tKaklxVSs1RU5sdUVobGU2emhxV0d6VHVDQTNuTmhuL1BpZzIy?=
 =?utf-8?B?WS91RGdIQ0dibzh1Q1JjUTBncENUaE9oRmJ3M2RyTlN0cFZrcUN1WXpqWjF1?=
 =?utf-8?B?dDBQaUQ3MHIvbXlPUi9pVVJyUHdxY1ZiTFYyQ2xLVjhKTnUwUXRkQldMNStT?=
 =?utf-8?B?Wld2QThCekdHKzVxbXkrUVJoM25uTWVtWGpOZjF4dzAvK05SSTF0Kyt1QzFC?=
 =?utf-8?B?SmFXMUVBR2ZkZUk2Q1hoakpxd0l0TnhXZm9KeDBaTnZZUEVRbTdpQ0FXcENY?=
 =?utf-8?B?NWlSNjl3MEVTNTV2N1RXdngwbWNnNGVpdW0yb0hDTTNaczhSdURuYmMvSHRs?=
 =?utf-8?B?RDBwZnpWY0UyWGMzQXoxUnY0eERoYU81ekFCTEh0Ymx6K1lGRWxacld2NnpU?=
 =?utf-8?Q?A/Qo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFBiYXNKa0I4QXdQZmUzdlVoWC8zQm9LZEN5QnV1Y1pGSTNvYWlDOWNkU3Jk?=
 =?utf-8?B?WU83cVFUc0hxc3p4M2NMVEZlK0hQcmdRTnFrcGhwZml1MktFcWhsUHNaOGlG?=
 =?utf-8?B?MG4rS1pkRWRnb2lnQ2xvYlJET2FpbjhHS3g2Z2xIakliOXUrVk9JWWRubi9l?=
 =?utf-8?B?SnJSQ3hrb2RhLzBXMStkbmRVODlBYXdZMjNnam4xYStKZkt6YTJZWncvV3cr?=
 =?utf-8?B?VC9LT0tIV2FlRnE0Z2E2TTgza2k1bDlvMitPVUloR1BCbm5xTUZaMVpWaExK?=
 =?utf-8?B?K0NaN0x1ZThHcDV1ZUFWVHFyZVgwZUdEMC9hSmY1UXZOdmUwbDBFRnpYZnpE?=
 =?utf-8?B?blYyYWJRamtySkF4cVlpS3NBWkZtdXloMUFldXlBWWF4WWRUUll4NTVmK1pu?=
 =?utf-8?B?Sm1CL2tyaEhmdmgrb3kyK0x2SVMrQ0Z5eUU2VE90NTExenllTHhPeEJkY0t5?=
 =?utf-8?B?aHV6Y054Zk9TV2pKZ21tY25ydmJrMThCVnExZTBuaXpKUFpCTWNqRFM1RUVn?=
 =?utf-8?B?WmR0Yy9qOFg2TzUyTWl1UHcxOHZ4azFhV0VMZis2eldrVlYzN296eGthODBy?=
 =?utf-8?B?UTRjL0FMdDZrNFFKenk1UGU2NW81OGxsWGFKMlN0cEFEanBBL2RhdE5hc1oy?=
 =?utf-8?B?MmNLdEtVd0Q3aW5yaVBXc3MzdTZjV05DQTNUZHczemN1TFB5cUJpNEdNNjJz?=
 =?utf-8?B?eTN4UEJmN2NmT0pyejNzaCtOSGdmb0tJcmx3MGJGZEt3bVVDWFZkQ0ZXc1p6?=
 =?utf-8?B?VWt3N3g5ckV4T0Z3WCtzVTM3MFoycm4zM25UdVliQ2xkR2ZXWENlYVpKVnE2?=
 =?utf-8?B?Z2xWVmt6WE0zVExhajZHMzR1RWpIbG42UXVTbkJoOGZocWdiMnYrLzJxNDN0?=
 =?utf-8?B?d09sK24zTFhmd1BzYThzeHdHaXNUVkZFcDR1WjBRdVdFTmhEMy9MSnlSaFhw?=
 =?utf-8?B?NktXWmluNDNwMFpGTlErdGhKQzNmd0FqUkNpeXlxUmV3UG1iWWVNVGNud0pJ?=
 =?utf-8?B?OHdZN1NkZklQTERuSjVRUjAyYnRNUForeElGcUtHVVNDNmlJTStreEZyTjRG?=
 =?utf-8?B?Z1dsUWlWRGZQWXlrb3RRK3ZLQ0kwcjhVR2p5UG1HbUR0cVFQbDhxTmxiMHVT?=
 =?utf-8?B?aTl4MW80QVVtejZIL042d1dtWk9qNDBNY1ZMRExrSkdBYmFwSDl3czdVZTdy?=
 =?utf-8?B?UUVlaTh0WElhS3Vvb1JlTUpUbVJTWXVMcklCeWx1ZXcrVGtsTndkV2FJRndr?=
 =?utf-8?B?cGthQkFmSE9IQzdWQm9pdmQrM1pqQWdMZ3pCS2IxMVpIVEJuL1puVGdmVjNO?=
 =?utf-8?B?N3M3NHltb0RsWjVyLzBGMmdlTkJBazkvemRsSVdJc3lmb1lnYnUxemxhNDZL?=
 =?utf-8?B?blZSTldiOXFrNkVEaXNXVHQ5b1MwaG5FWXgrM3k4b1ZqUk16cXZ4MlRlbGcz?=
 =?utf-8?B?RlgxN3Z5Q2FOaEU0aWNPYkNSSnpHaDMxakUyVmZZNGJBM0VlM0JHVUx0Y1pS?=
 =?utf-8?B?elh4SEl0OC9GOWZtQ0FXZjczcTNndERFNThaU2FlRnNlSGx1TW5OWmx4WDY3?=
 =?utf-8?B?TnhmeUZpWC9PNllQRlQ3TzFDcFBYRGZOKzQ4U2VaNHZ4NHhJSUtjRG96SWE5?=
 =?utf-8?B?N0tmUVNoOXVqaVgyY2p6RWNYcnhmL2ltRnkxQXdsc0NZKzlicDMyUkM3bldE?=
 =?utf-8?B?c0s2eGk5QWRxM2ZmODhQLzU5TTdTMWY3Zmo4VC9UeXhHU005MEhGMVhicTJC?=
 =?utf-8?B?NFJMS0dDbmV6bnhIL0srV2t4VTVMVzdCOGVlQnp1eTN6YmFjVWlaLzQwK1E0?=
 =?utf-8?B?Mng4NFFtNUI2MWc5VVhJYzVISHFHdFRTYzdib1NUY001NE03UGg0Mld6WDdn?=
 =?utf-8?B?dWRFSjYzcjkzendpSGgxditsb3MrZFVjSk1icHU0VVNORWI0UnRqaDV2UFg4?=
 =?utf-8?B?UWk2MnN0RWMvQXJTM1hNTnFET2hSVXk2ZCtWMGVqYk1vSFBtUktWYTQvNERJ?=
 =?utf-8?B?QzRka3R5VzNHVVZLbi9rdWNGUklJZ1VQaGlLbGNOL2swN3ZaT3hxME1LNmwr?=
 =?utf-8?B?MHFsK1RPWnVPQVRRVXpoT1c1UC9iRW5TN2RvQmgxd0JuS0V6WUFTM2lzS1M2?=
 =?utf-8?B?MDN4YVhEU1FWMDZtN0p2YzkraktnNlAzeW91UlF2OGxNN3N3cDBsMzJnUW93?=
 =?utf-8?B?cFVSOXQ5aXJHeUNsSEhWSGZ6VlUwdUlDRGJNNS9Qc2htRlJnQnQ1cVFaekVO?=
 =?utf-8?B?WjkvY3lVa0tpUVFFcnlKNW0zSFJweE04WERjUFozTDBHZzIwUHJ5LzZXRVIz?=
 =?utf-8?B?akZLYktPdmFZazlsamxLZ1oyTUlXajB2Y285VHhzMHNMY3NYVnFPdTBVKzBH?=
 =?utf-8?Q?FjVt8HFSY2LgDFUM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf57d94-218c-4d54-9f4c-08de6e2092d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 12:32:11.7063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZutmLf1RvpinslBaAtaVvJz2O6gf/hK5KmkwHQAD9APfe4QHFpHiTKIHJ8BaKlvodM9s4hRHvDKSIgdbaeADZ/kShagRPutl1bB3dKL09BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
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

On 2/16/2026 6:06 PM, Bruce Richardson wrote:
> On Wed, Feb 11, 2026 at 01:52:52PM +0000, Anatoly Burakov wrote:
>> Currently, when updating or querying RSS redirection table (RETA), we
>> are using rte_zmalloc followed by an immediate rte_free. This is not
>> needed as this memory is not being stored anywhere, so replace it with
>> regular malloc/free.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
>> index 06430e6319..654b0e5d16 100644
>> --- a/drivers/net/intel/i40e/i40e_ethdev.c
>> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
>> @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
>> +	lut = calloc(1, reta_size);
>>   	if (!lut) {
>>   		PMD_DRV_LOG(ERR, "No memory can be allocated");
>>   		return -ENOMEM;
>> @@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
>>   	pf->adapter->rss_reta_updated = 1;
>>   
>>   out:
>> -	rte_free(lut);
>> +	free(lut);
>>   
>>   	return ret;
>>   }
> 
> For i40e do we not have a reasonable max reta size that we could use for a
> local array variable, save allocating and freeing entirely?
> 

It's on the order of kilobytes I think so I decided against stack 
allocation for this scenario.

-- 
Thanks,
Anatoly
