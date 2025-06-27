Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED473C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:37:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C874060C;
	Fri, 27 Jun 2025 16:37:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 00BA6400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 16:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751035045; x=1782571045;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=h9Ln/gI4jt9V3mVtkzd08eVzTtY4oYPWOG+Kd31Im0g=;
 b=dPH62075GfmgFOteBBltW2LPoAndZFZoLUJ7NIYXAIzhjunxaqO1+r63
 O02WSKFeSsqJLDagXK88e5fZO4ODmcQX8UVQ/q40MRtUq1yemCdhZ+8pA
 PFifH/q0SBOb2mvK6lXDT2QC6XvaBwTo2RNCht5aecRyf3qfSCyNpElUd
 +8vTIySEFTExJ4nEZjX2Cwb8UGioQ/aF/GocZTfpZZW7mPJuHeYZ+Yn6J
 RIoNLLV3LOMA/OvO/13pQYRbydsQXfcUb7IldOMlr0ZFQ+ovehZCeiT8y
 7WBfUJz393n7nSD1T2+9LJ0Kx6MxTZu3cW9akJUI2RuYV9+QVT15JK3Nb w==;
X-CSE-ConnectionGUID: kMde5QvURQ6Oh5qVrBMUOA==
X-CSE-MsgGUID: TLDYIeYEToCmjW1sU2DBMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64788879"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="64788879"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:37:24 -0700
X-CSE-ConnectionGUID: 6qhuzhwfSB6PGRBqHEo65Q==
X-CSE-MsgGUID: y0LZVYr8RMmy5f2LfAU7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="183721771"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:37:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:37:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 07:37:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJHnIZObspKaN3PgFPPmMQrct6mUftkchvbaOb4pztqKv/dN/NRFmYk9uXsizvtF5+9OmXnHHYYP3d+iAyzBJGrFGCfxMvaqzuU5Y0zine3MME9n0mTgj77ZlZfDJyxCW6ywoH/69U8omp0UYL+EeAsFNnTxrcNewswq8XLI4bMzDbP2WSXdyGX7Qtb67+IGCS16BFPlxaLEnhqRBsbkEYruVfFp7Qil3/WflXsCWgtKGUXG1iS46BG/YwCcnNMYLnegm4lTANMm8m0O0yyw7jLLt4TqUhl0aCUwP+ejtn3lI3RdSolJ7eXJ3mDHFx6L4HUJ8ym5VCUmoTHNk+b/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5mu4jKsup4Mw7PC1Easd/EtlQ7RbFZ86TfVXpwc5xc=;
 b=VB30PxyhkZdSFeXYnJoNiXMA5TDs9VlT23IXENvxm80e8i3eyabOuTeYMQuC6VRwzVFMFVECSJUQTiTfLzCdulp0gciWjcb+2RNxVDaOFisPJYtzcvZVMhqdPy7n1b7U4P7q+bmTbVutjr84+vooxqx4dCVOHiKJsjVGdYa+Y8JX9a8nSX6+SgVSa1BlMC51bfyNugvtTeMpidGnwTi10Pa+7LTMecTUxzMYTFetQjsWqQAl98I4MDPQzBty9TKufqxWcgpFrlBzv9AOyQkCcFUBev1GYryUD1VAXkhgjTjefDuXGbnBENvu5QI6uY4jCwie/0mapFd4p1P4lmynTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7550.namprd11.prod.outlook.com (2603:10b6:510:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 14:36:57 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:36:57 +0000
Message-ID: <386d9bb4-f127-445f-adc8-1e15d7cf9ed7@intel.com>
Date: Fri, 27 Jun 2025 16:36:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250527152913.279011-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: cad90ece-44ad-45ae-2be4-08ddb58811e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K01VZERWQm4wNFRVc29nVDJ4MEVIMUhLNVB0UE90aUNGeTdDZmwrUTE1SW45?=
 =?utf-8?B?SmtxUXMvcHcwcUdhcmZQeGhGQXg4VzB0cDNZUjRqajZQMTlBWmVhQ3RzaStE?=
 =?utf-8?B?U0xacjZYZC85dllMbStrRFNzdHNxRnZ6MUF5L0M1QWhCQm42V3VtMVo0RHZD?=
 =?utf-8?B?YUN5RlhnTGQ5ZVU3dC9OODRXWmhwNUVOMkhMUlhPUnlKdTI3R0RQOGZKQllj?=
 =?utf-8?B?djQvTSs4N1daNWdDd2lETGhwYjJWeVlLdXpOd2hIcDVWY0pCT2wxakhvTEsv?=
 =?utf-8?B?LzNuK0ZYcnl1aEVYVTdDYmEzaURkNVVCTTIzVXVVTHF4R0laaVZDWnl6N25y?=
 =?utf-8?B?SWpDbnl1UDFBZHNUQmRYLzVUbytkVGFtYXpNUVh1clVaVEJTMEF1LzhxTWY3?=
 =?utf-8?B?MEFZVjJMM1M0MytBOGNqaloxdjRaMVgxWXlra21ySktROHpDTnF1SndkUncy?=
 =?utf-8?B?ZGV2TEhBbnFuMTBPM1hpd3p6VzlJSTBQMjJpQ3hacUtLRzhoSzNzcVZhMXFV?=
 =?utf-8?B?M1c2RFN2S0IvODFTZFYycm1XWWZOenRqeUlGTG1sdElqL1RTcVFxNWhiTngr?=
 =?utf-8?B?am9FOGRSYVVIQ1B5VXNpcDZUbWJyR3NRTXNrTE9Cc0FqeGRDOU5CZlFNRFhV?=
 =?utf-8?B?c0pZcU55MVZiNzIxSUhXbTZmUkRkUkFpWnB0MEJTUnh0YmlzUk9ndVhVbEZk?=
 =?utf-8?B?TDBNdEE2d3MvSjRnMVJkc3M0ZzFreFhKM0tiK1BoTm1mOW5GbTNNWWY4VmVK?=
 =?utf-8?B?Q0xONit0eitBNEpMeFFzKzdONi84eUxVNVlUMHNZdFpheGpxbmNRTHdVaWJD?=
 =?utf-8?B?amV1ald5ZEZ4MjRCNHU4NzBVb3lrcmRPcjg1ZXdMVkpnWnBEWXZhR2ltTHpw?=
 =?utf-8?B?VzZobzFGelNOM3hXK25sYndHeE14K2M3MEl4bHVRUitFTGFFRWNxVnJmQmtp?=
 =?utf-8?B?a0g3NXI3eDJQckRPdVhqR0JxVnM5SHZjdVJyanR6Q1dkMnIwOUp2c0poMlFi?=
 =?utf-8?B?eTROeGtyL0tnblhHbVNJZ2UwY3FjWFpMbE5sWDJSNmw1emYzcTUvMXdvd0p3?=
 =?utf-8?B?KzI2ZkJWRi9mNU9ITzN4OWJZSjhMaDFOU1FZcXVKSmZZc3U5ZytoVU5mekcr?=
 =?utf-8?B?dW5oU1o5OVdCV3lGdnp0SDhjbENiNXRrODI2dWwxM2Frek0yM3FxV1pzNk9R?=
 =?utf-8?B?aGRFZVZIeTExYXE1Nis3SXJ2WFZhblRBOTRhc25WU0kyZnE3Z0V5NThLYzYx?=
 =?utf-8?B?d0lMZmZEbE5telJ2QXBIdG84M3c4MFdnVG5xWVc4QU52TU10SzNremJnTFFR?=
 =?utf-8?B?blE5dTU0M2pZb2w4TUt5VFVEZkYzTkl4RnF0UDlKZUpXeTVlQ0hOcXNoZGY0?=
 =?utf-8?B?VHh4bTk5b0k3TVVFTnc0VGFtVnJCcEU2ZG54d2duS0d4WVlsL1VsWmtFYm1a?=
 =?utf-8?B?cWNFcUtRZFp5NTE5U0doM0M4MXZFK2ExOXlNSkNQODJlUmhlZzhBRlpDd2Uw?=
 =?utf-8?B?cVh0SGtyL3FNM3J3VytrSVUrTXJqeUxGUzFhYjZHR1ZMRG1FSldRMzhEeWNn?=
 =?utf-8?B?MzJ1SFh0azhZSEk4aFVuN0ZmejRuOUpnNEVsL2w2RmtmVkpickRHTkNFK3NU?=
 =?utf-8?B?WGtsTkFLeWU3ZStYWlBRYTlibWlSak81ZHQxMnVWYk4yUW5OVzFIMWtxVGVP?=
 =?utf-8?B?akgrL2ZqNGN0c1MyRVFTZ1dMWk1vWHFlbDJ4YVJJeVB3Rk9LTGdHZ003UElQ?=
 =?utf-8?B?NldCd2RLK0xSLy9BSGprVzVXZjJNUCsyb2FWbG00dXFVSXBzVnNoYTh6dWlu?=
 =?utf-8?B?ZUwyS05mRUsvQmhhdVU5d2hQV1RERDYwYVp3eTBWM29FNnFnNFUrTUE3dmkx?=
 =?utf-8?B?VGQ5b2VuSFJjb3J0VmlaVEdKQjlILzE4Z1hvUTdZTnE3QTVGVW5mZWl4UHZx?=
 =?utf-8?Q?ZOzWXsTBb/0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRwWWZMck9Rb3B5ZjBHMlM1cEwzZS8rejBnZ0JTNWhIL1FPdGF2MlFKbmRn?=
 =?utf-8?B?MTFrUy9SN0pSMVlwTjl4NWpDUGFYN3RSZmJWejR0OHdvNEVPOUVyaUE5WUFC?=
 =?utf-8?B?dkwrQWlEUTN1NitSVnVEUGlaSVNMWFplRFhRMFduZTRjWE85YjZrMmhaTVZ3?=
 =?utf-8?B?MmpsN0gyQkxGMjF5UDBaY2k2NzU2L2wyMWgycWFEOGtOTEZOZFBpNnRLTnRZ?=
 =?utf-8?B?S1hnTXFjWFkvQW1GbVBPckt6QmNMcGFtK2daUGdQZGpTZUF5REY3SjBxNWZH?=
 =?utf-8?B?eGw2a2dzZUF1bThXZHdoVTB2cm9QbWhYUkpBQ3NTaEQyeTBCSEI4blpWOWpp?=
 =?utf-8?B?bWN6bFVDU2NHRWtEODBUd2RBRTNnWWNJV2p0MkRoMFdMQXdLWUhMR0QxVUww?=
 =?utf-8?B?MTZua0ZNdjhDRmdZbjkxaGFFbFRmNENGMVpXMUQ2ZklucExjN1RRRDhBQzV4?=
 =?utf-8?B?QzkwYkVvVkNaMkNoV044U2wrZUowT3lwMUpuUS9JcjVsY0J6bVVRc05ja1ZS?=
 =?utf-8?B?bjNGWnV5YytFU0d5TEE2Q092VTY4UmlGcE96L2NxSzVybGZORnNJMFM3UkZt?=
 =?utf-8?B?UFY0NnJSZ0NvYzhqT2UyOFh4V3p6aUplczMwNEFvOHBNQ2J6UW1wT01kRG1I?=
 =?utf-8?B?c3grOFZCWC92MW9JWjlkNXRva25nbHpkQUwwYi9NS3VmUkdZZmNnanRBRSto?=
 =?utf-8?B?eWczUlJSVHdNT3hqVElPU3NLOUw5TkJQWVNFZjVkdUs1OGd6RUsvQUNoNlhD?=
 =?utf-8?B?MWluc2xEU2orUjZUVVM5a1BxRjBmYi8xam5LaDZ0dDhBZzRzbi8rUVcySlZz?=
 =?utf-8?B?cDRBQm41cFR1RnUvMDJZVUcrdERWV2pQSS9pNWhZS2dmaGx6NjZtVVJvWjR3?=
 =?utf-8?B?dEtQcXB4cHY1S2pCdkRPWUtxOFhSYzVWUk16dlhZODZoRUczZlpBc3JRcWNQ?=
 =?utf-8?B?WENNaEE1dFBKdXM5TUxGTmtMV0VvT0tBcng5Mi9TODJCVXZnTTVYbVJHRnAy?=
 =?utf-8?B?SE93aDhqelpwTWRjemtwb0h2aUdxQk5BNkk3RE0yVi81RmJJUGFXcUVvTFJw?=
 =?utf-8?B?bW1zTll3TDhEREdjT25PVjBqVk1mWEVJdG1udVl6OEpLdGU4c3NOSU41Qlkv?=
 =?utf-8?B?d1F3TWY4WnppTGhwbW8rK05nbHFzMXRIbkZhenlDRDVwS1hQZkNqOWh2alhX?=
 =?utf-8?B?QUwwQ3FpbmNvY29jK3lMVVZsNlJBUUE0N0NRRjhyVm0wRjFHSTExSUpxYW9V?=
 =?utf-8?B?eEhhc09NcDdSR2lHS0tneCt2RFVqU2dHSjdiUDljRU03azBUNEFXVjNkV1hj?=
 =?utf-8?B?TjB5eHpTQ3dSdTFaM0xHM0Y1M0szRUR6NFl4aURkQmtWNGFGTnByR0dmZUZ4?=
 =?utf-8?B?eWpXUGtXbDNlYS83RjdTdHJib3Q3b0xTTEtJRVJVUHk0OGNvdTZBTmd2Y1No?=
 =?utf-8?B?SHEvSE5uMDVkMGNQMXZzSnpQd1RSVlh5NFNwSDhXYnViQkFzZStXMFNiOTJM?=
 =?utf-8?B?RksxeDhyOVh3WE03TmNHdnFhTlAxbTVuNjhleTZNbWFDczhUbnNjRmVYdm52?=
 =?utf-8?B?cnVhdTVVNDIyaCtCZ3ZWN09WdWJJNmNqNzhRM09wZ0VKUTNXODN5ZFc5UCtJ?=
 =?utf-8?B?MlpHYzIveXpQaE9oNXo4alFWWWJsWjVTL1hwU1Y5V25mZ0V6TDNGN29ORjho?=
 =?utf-8?B?bHBOODNpTFZLR0RTMWh6MnozRDJWOXV1WktYcXpXWjUxM1ovbVkxOWVvQXda?=
 =?utf-8?B?eVFpNG01eVdpa2FSOWt4YlEvN2RkbUIxRmlRdi9NUXBmaXhHTURqL3gwVjB2?=
 =?utf-8?B?VndpYUxGT1pQUm5ENXJaZGV6VVJ6cEtkWmRxMWYvMW42N1RLa1VlQUlWcG5y?=
 =?utf-8?B?WURqeHZjRzhBdVZoOGU4L0s4UGJCc25vZUw5Q0NWcDU3UTF0UFcxR0JLU2Ri?=
 =?utf-8?B?cTRWRWw5NEQ5THNRY0VTUGZUelE5ai9MaGZiNDYrTlBuenRzd0FRRVE0QkhE?=
 =?utf-8?B?QTdwZ1VUYjQ0ZTBKNUlZZWJhd0ZZWUVNZm1vUXYwV2dYNmFLTmttb2Jhd296?=
 =?utf-8?B?czc2eDdVY2ZsS1ROaWI3NzFicmF2dW5nZC81SGVRcTFrWmdybGFuVCtITitV?=
 =?utf-8?B?TlBNVnNNa2dod0dTZzlKSXl1bDd6ci9VZVBOMUtGaWRUNE1CTlFuYkFna05L?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cad90ece-44ad-45ae-2be4-08ddb58811e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:36:57.8222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqMqP5qkQzK3Rhx5N7GKmclbRRc3cY0Izteqad31k58zgpWo6B9KxGLoLg6Bo+dTaE+WGoGY/qugggp1zzNQ/oAYu1nGkVFmUUlmwb1dvjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
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

On 5/27/2025 5:29 PM, Bruce Richardson wrote:
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-By: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
