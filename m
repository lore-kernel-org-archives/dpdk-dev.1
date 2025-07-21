Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B6C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6896C402DC;
	Mon, 21 Jul 2025 11:06:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id BE3CE4021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753088761; x=1784624761;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xKyONVD+kQA7URGbTsVTaXJg+TUGPdF0DBYtUZQpnqc=;
 b=LHXN4DB7B3yMGt9F+3K5KJ+xqRWuuSxV2030J3sIly7CQxQvCfHitPCA
 4Ub4xTrIYI78ilqav22KGdj/2ewQdi3eo94QH+lH5IBv9HDL7ufMAhEm/
 sSKlmg9jJCc/F73ECVm57htKdCmX9JqZSopOgsTHK8LZxDQ2MKIzhCRXN
 Jbva21cNhKrN0saDUrzLp7viWJ3UWxEx7HmeTAiCOgdewkOJCS2w8uFY8
 BF9Qmte+rvUi0j+La7ehFHvXGtZ6+Rdmts08oVBmA2tNKb/M3P+GZxMX3
 fqgnEa+/KFpTcUOV3Uxk+z7Iz7tlsacE+h8ZCnxEawwkCtaRSJShTskL5 Q==;
X-CSE-ConnectionGUID: wDMBngfET5qJUaY6P2R63g==
X-CSE-MsgGUID: FDnbnOfKQd+cz/MIFxLzWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55446740"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="55446740"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 02:06:00 -0700
X-CSE-ConnectionGUID: l0IxDlSXTaa8DDlOqX6GjA==
X-CSE-MsgGUID: DEQaMzq1TjyJjLNpB4qbAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="163080421"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 02:06:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:05:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 02:05:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue8oCyhGu2WD1AzE4yDkdh6x15R+s0v5bo/yLoIJ5Wo1GUTB8V259QnMETlwaVrHQH/KwI1gNjbgukGY4sVmut2+4joLoHTTh5agVMfta8za5/LDD3I5fxp7R0HOvmTsY12viTBosbQaIlqp33zhW9KB10d5auSZ4oCYZBRSa1rMw10wNOLfamo7MU3Sj/Q1qYzZx3zGoSXGrPNfQIqjLlug8J0jPDABVWFqlMVXyK4VpG1kBVJdzuROo3bzZwLVhf6P5M/ev6asmiWGvDTLLlHM/e0a5ancgVnbP8HwllV6qSWwUYms6z+PDVwgMtfRFRmc2YksIKcDwptQhRfSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbdpejSwHpFrz4AvAXUvKmoK0V2HB4rNOgIGpeQ5yvc=;
 b=H9dMEqUmEfm03WOlKVQU5zzV2IyVdmuta3Itfx1mKcgaXY6YAeyUbeCSGshMgNbE9ZyETXb5l0EObP3Jt8TCyV1giPy/voQuac+jlTjlVhEjF59yzZzAlToZGXU6h2dr2qXisuTlmA+tLHc90ZbBOMyH7zl+rxk6NIp//TyHgcTjzZAIhYH/BGhsIhmkry8bYBI3XZibfVGY1gYmXnJCM/djCSZPpr0ZTlWp8C2PHOYx3/MsL33lYP46nhLCyQDbOGlVWZdWK3d0NoItY4BRzzgb9p3GiPcB2VLDY27r4XVpAU2ls1cXm3XsFuL/NQAEWIEVTa5SbUc7ezX0HO8wEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:05:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 09:05:28 +0000
Date: Mon, 21 Jul 2025 10:05:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH v3 5/9] eal: define the EAL parameters in argparse format
Message-ID: <aH4C06sBOa7q_tlg@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
 <20250718143356.1578988-6-bruce.richardson@intel.com>
 <CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com>
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b80f532-280b-443e-e2fb-08ddc835bce9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpwbVRXcDJPNjM0N2x4NUphMHM3SW1FbjhmRVkzUlVPUFhmWWZqSThQU2VG?=
 =?utf-8?B?cWtvTkdudzhBVlZQMFF0bnBOcUt3bW1hOGVHby9lV3dQN0dqbVZiTWw4OWZW?=
 =?utf-8?B?OTVnaVoxek1NRE51UVdSTS9wTTVJNGdlaTJtUnR4b1JJY0lOcFR1UWtNQkNv?=
 =?utf-8?B?dzRxeWhGOUMyd1E2SGY5SFdNRE93SFdlTms4eWpTa3ltLzVPdFMrb0NGRkF6?=
 =?utf-8?B?S29hd0Q0SE5GS3d4V2J6ekxXcERYU3RkY0Z0SE1ES2xuV0xZaklSMTFrNTlC?=
 =?utf-8?B?UnNtbTlqN2Z2ODNOc3VSTndRNWhBTWhyMmVhYldvMzlGbUZha2RpeWgyUzRF?=
 =?utf-8?B?bGVCMnRKeUhVZTlWQlNnVjhZN3A5Qm5GQWs1R2tpRlpEd0xrbEg5ajNGQnBx?=
 =?utf-8?B?YnhVbmhQWGlBUWJuRTBScWNoVlYwSlRZY3hwR1VQTDVxc1RZM21Bd0xPMWZL?=
 =?utf-8?B?UXpYeXNNUzFyTk1vUFFabTJJR3M3WkgrUFdYYmtFcm1MYVltN3lBdGtxT1lI?=
 =?utf-8?B?ajl6eHkzTFA3R0dhQ0RiU1hXU0NuSUtDUGVsOHpiWHk0ckxDVVRmNjFCRFFV?=
 =?utf-8?B?cnVDTHZHdHQvcXZOQnl3KzhqTlAvZHQ5cE01bXM5RUNyMXRCeEQ1aUZ5SzVY?=
 =?utf-8?B?RVJjYjkvYmFRempIZ1FEUTZHZjlLR1RaL2dmc0ZSYWZ3UWllNVFaNlUzVlkv?=
 =?utf-8?B?aVVtV3FncmM1V0VnczBLRGkzMVJSNmtMVW1jL3JnUDB2RmROYUttbkZOU05X?=
 =?utf-8?B?YnNIbldXMUNNNzVNaFJIVzNxOStrbzFTSWt6ZHUxeGVDL3NjMmI0VXRnM0pD?=
 =?utf-8?B?RXFxRjQ0UEw2bURhOE5MaEoyb3RaMHV2eTQ3Vm1uSTc2Sk1ONEZtOG1oL0pG?=
 =?utf-8?B?THlEM3hSRWhpdERxODF3T0J0REZML2FLdG0rWnlZRWJXT1BUaTQrYjM2TlNk?=
 =?utf-8?B?Q1doaGdhSndmVHdhSUVqQy90NXRjVCtIUExvU2M3QmwzcjQxWUs2cVM2Rjh0?=
 =?utf-8?B?azdOaXQ1V2xOZEJVanR6aTE5bVpnOXp0dnk5TnZGQUVrbkIxY3RSYjFGQjVu?=
 =?utf-8?B?dWFURU9FQ0VjTVhKblp4d3ArcThNZGVYK3dWTU5FbGhWMjFvaHk0cjUwMVIy?=
 =?utf-8?B?WjFoT01ZWnJRRkc2VS9CVlhOTGxqNDdETVBDZ3hwTG9QOHRzaGk1WVBxRFdF?=
 =?utf-8?B?U0VnZmY3MlpNcEx3K2ZnUTE5MFFleld3eGxTcHBmMlp4MlUrM3Z0SkxPTVdq?=
 =?utf-8?B?UTJOMjBnTk1hc2FRalludXA5ZUpuNmR5QVAxVUhiUzN3dlVzSU1zd1NTYlFi?=
 =?utf-8?B?aUl0SlRuMHpTY0VERVFhQVVmYkd5YndDekhQcDQ0Y21oM1FoaTNLb05ncE91?=
 =?utf-8?B?ZHQrN3lLYnRtb05la0tKbjVtaGN0NXNiNFBWODNXWWZhYlkrV3Q4a1BDM1RB?=
 =?utf-8?B?VUZnRGlKVkg2bFdJclVGVWpwdGdCaFJOTU1EOUxmZE5CalY1aXNWMDVPTXhP?=
 =?utf-8?B?RHJUTXUrbytuZWs5SERUdVdyWlkySStTZUtyQ2Vnc0IyYWJpVFpNY3dORWlK?=
 =?utf-8?B?eWFZYVRockx1ZmpLKytDVWpybEVWWFhQWkRUS05ob2NvN3hWeDVBN2UwMjFR?=
 =?utf-8?B?cmRLNm1LWnprczBiV21JYlVrWVpFNzJsT0tCcTJmVERVWjFGR1V0WENMUVBu?=
 =?utf-8?B?OEE5cnp6Z1pGMEU1S014bEEwTWJ2T3dkcWdnREI3UUVSUFFWRjVoZ0JGeDVv?=
 =?utf-8?B?TUpGRkxTanJLT0Nyb0JycnJVYkJyYnNTZHFQNHRTWXF4ZExFR3c4R0ZiZmI2?=
 =?utf-8?B?QU9lN1REY0FidXVPdXozOG52V29jT1NheEw1WjBMRTVZTHVPOXdscWxycUhr?=
 =?utf-8?Q?sqM5DCX0YyTcH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25mKy9ocW5nV2JXZmpxanJEb1YvS2grZG01MmZwK0RDR3JZVE0zemtNemlC?=
 =?utf-8?B?M0ZUSjNkeXMzZ0FVQ0xHaXR2N1A3K2ZKWkNESk1GUk5VM0g2dkQ4SWZBWVlr?=
 =?utf-8?B?MjBzOFRsM3dwR29HczkzVzhJRmRzNVEvM1hzTzRNRllhWTFWblRRTXZtWjJX?=
 =?utf-8?B?TzdpOUdVZHR3eERjT3MzdjMzRzlrajBTTGVEem4wOWovLzVnTVBaSkFZL254?=
 =?utf-8?B?Ty93YjVieUYrUUtkeVVGeFBGWm1pc3lqQTZwUkNTOWNwbU5UUEsxUmM4M3ZO?=
 =?utf-8?B?V211SCsvQmtJMTVQZmVtNmVVV0F0WlR6N2hPWjB2bHA4Z2d0emsrbG5GQUw2?=
 =?utf-8?B?b3JJTkEyM2lGMWI2cXp5dnU2Wk5ZRWZUbU5MWDZyNXdYN3ZqTitjdjVCYXpi?=
 =?utf-8?B?TFBZUmFBa09KNnlWV3BVcnNOMllBWVVQLzdzYThGVHd1TGtCQS9IeC9yOEVk?=
 =?utf-8?B?TVZvbHd3WlJKdUVMbHlaTDhWTmtPckdkMk5PN1JqclRnV05weStGVnNJclM1?=
 =?utf-8?B?OEJxaUdYZ1RkODYwVDZGN0M1aUtvYk8yWVdrb25zdFNQblFEek5sQTBkSDlW?=
 =?utf-8?B?b05iSFg3c0l6R3dGdkdXMzBGSmpPREV2Y1BXTUgwdlpXV0haQ2s1cWVHQzNy?=
 =?utf-8?B?QUhIQldma28rTDBSZ3lGeDlnNWdqNkJ6dG9sVHRGdmxSUHdqaEo2ZGU1SFIx?=
 =?utf-8?B?MHJLaDVFc3F4Sk9mWTRhMVhMN01GL2RxQlZnQysvam1kNnBHWEdVUXJ1amVp?=
 =?utf-8?B?UTE5ODhyaGpJTnRGM2NWZXk2dVdyZ1NSNktXdnJaMmJZcjQ5ZGZSem1IcCtF?=
 =?utf-8?B?Tng1d1F1NlVmem8rQ0xmYzMrK0YzU0xtelpSMVgzNVNMMHJMR2dzM29RbUdP?=
 =?utf-8?B?bmFYbmwxVkJlaCtwOGtMaVZ4QUtteGVSN2Y5TUsvdkN0aklvRGZBdHM2eWZV?=
 =?utf-8?B?SkhDakk2Y1htb3k0YTNoY0Qya2hNd2JYNVZlUWE5Tlg4TWJsNEN1Q2RlSEh2?=
 =?utf-8?B?TWxZbHRvNG5xRFJwWVlZVW53c0NFUHNJUWhMMVcydGR0MUo5OVFQTEtTUW1k?=
 =?utf-8?B?V3UxaGxlSlVvQ0JheUNwRHp3TS8vdm9BcUs2YlVROFlzL3ZLLzl2cGFubjFr?=
 =?utf-8?B?T1JRemsxbWVKY0ZXK2pvblYvYnhyQk90bTAwUmV4dlAydFZwWThjTUVJT2F2?=
 =?utf-8?B?aXJCS0NsNk90SWFSRUhGekpacHkySGxJb25ETHV5TCtiaUptd0V1anl2c1Zm?=
 =?utf-8?B?aGZNU3pKdWpKN2Nyc2ExaGFZZ014RGdNaHIyWU9iRDk1R0Z2MS9laEltalIw?=
 =?utf-8?B?RFRyaC9wRWpXVG00Vys5MHdlaE1iU0o0ZWQ1b2NOQ0RDeitqUU5oTzhwQitz?=
 =?utf-8?B?eDErQXRzWGVJekFTMnQvT0NLRWhad1pXQlhBb1FUNG5sL2VUYWxLUmV2aXN0?=
 =?utf-8?B?dENQcFg4dmNBK3VMMTVoZnJYeUhSWk0xazlCTHJFZVRCNDhrTm0xS2VZWWRk?=
 =?utf-8?B?Q0FkRlhnUStVMUM0cDQvRk1BVER2STJCVXl2UXRYTnRIak16bk8rQ0tMTDRK?=
 =?utf-8?B?S3I0cWo1L3l4bksrY0I1VU1yTE5LVVJmTHJUSVlkUzRQTmxMZ3FFMHhQL0NI?=
 =?utf-8?B?aVZyOHVvZjdTUTJTclZNVzYyZmVHdEdJeUFscmZhK1N5K0xkaVBaOHVTMU1L?=
 =?utf-8?B?MmNVT2NYbkx4SlVnQmJBMG5keCtLV2R1bElGU1c5RVdPcExhMm41UU5lYnYv?=
 =?utf-8?B?eFdlVS9kZlV5WVZzTlJFbUtYOVhKK3lHZE9WN2M4dHNBRDZUaFVDVWJGdytl?=
 =?utf-8?B?OERuNlQ2aFo4cDZiVmhXUHZ4WTcrQ0x1TXdqRTVQTmxUSi9LRUswTDZIZzhx?=
 =?utf-8?B?NGc3UlFWZEd0ejk2a3FtUEo5TlcxbDVMZWRKZnFiOG52ZytmbEoyNkU3aHhO?=
 =?utf-8?B?Zy9vLzNYbWZjUEdBZVBtbUFVUC9Jck9JRFIycFg1eVFLNzZadUs5T2Y0NUFJ?=
 =?utf-8?B?L2xIVy9UUTF0V0FoRDdHSG02OXhnOElEenpISG5RNEo1NWpYalRxNkFmVWZw?=
 =?utf-8?B?dlZ4Z2F4TTk3Vk9lcXBhaVFHbHVnMGpMNlYyUlNhd25tejZVYjhnbGZhZC9B?=
 =?utf-8?B?N1k5RVAzUUVYbWYzMXJhV3NjR1dBVkZIRStQVlU2dUVlT0dvd2ZOTytMZkdM?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b80f532-280b-443e-e2fb-08ddc835bce9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 09:05:28.6586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3Sy8hFzwXDknFIrDb7C3RQlb9O9RUkVlvXwm0Lov5TcUfLwD9MdTSoxXRdzbL5rLMaQ1deAyNyWgPYtHbtYknvpAwqJpyU+hTF4sLbohIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
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

On Mon, Jul 21, 2025 at 10:41:33AM +0200, David Marchand wrote:
> On Fri, Jul 18, 2025 at 4:34 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > +struct eal_init_args {
> > +       /* define a struct member for each EAL option, member name is the same as option name.
> > +        * Parameters that take an argument e.g. -l, are char *,
> > +        * parameters that take no options e.g. --no-huge, are bool.
> > +        * parameters that can be given multiple times e.g. -a, are arg_lists,
> > +        * parameters that are optional e.g. --huge-unlink,
> > +        *   are char * but are set to (void *)1 if the parameter is not given.
> > +        * NOTE: List is to be kept alphabetically by option name
> > +        */
> 
> We will have to be careful to keep this struct below, in sync with the
> options list.
> Could we construct (at build time) this structure via the options list?
> 
> The rules above would be enforced at the same time.
> 
> (macros + #ifdef for Linux/FreeBSD may be an issue for MSVC though...)
> 

I wonder how much an issue keeping them in sync would actually be? When
adding a new option to the options list, it takes a reference to the struct
field, meaning that we can't forget to add an entry here when adding the
option. If we add here but forget to add to the options list, then obvious
the option just doesn't get parsed so testing quickly would show up the
issue.

I suppose the main concern would be around renaming or deleting options -
though in the latter case having an extra stray element in the struct isn't
a big deal.

I might have a shot at auto-generating the struct, but I'm not convinced
the complexity will be worth the benefit.

/Bruce

> > +       struct arg_list allow;
> > +       char *base_virtaddr;
> > +       struct arg_list block;
> > +       char *coremask;
> > +       bool create_uio_dev;
> > +       struct arg_list driver_path;
> > +       char *file_prefix;
> > +       char *force_max_simd_bitwidth;
> > +       char *huge_dir;
> > +       char *huge_unlink;   /* parameter optional */
> > +       char *huge_worker_stack;  /* parameter optional */
> > +       bool in_memory;
> > +       char *iova_mode;
> > +       char *lcores;
> > +       bool legacy_mem;
> > +       char *log_color;   /* parameter optional */
> > +       char *log_level;
> > +       char *log_timestamp;  /* parameter optional */
> > +       char *main_lcore;
> > +       bool match_allocations;
> > +       char *mbuf_pool_ops_name;
> > +       char *memory_channels;
> > +       char *memory_ranks;
> > +       char *memory_size;
> > +       bool no_hpet;
> > +       bool no_huge;
> > +       bool no_pci;
> > +       bool no_shconf;
> > +       bool no_telemetry;
> > +       char *numa_mem;
> > +       char *numa_limit;
> > +       char *proc_type;
> > +       char *service_coremask;
> > +       char *service_corelist;
> > +       bool single_file_segments;
> > +       char *syslog;   /* parameter optional */
> > +       bool telemetry;
> > +       char *trace;
> > +       char *trace_bufsz;
> > +       char *trace_dir;
> > +       char *trace_mode;
> > +       struct arg_list vdev;
> > +       bool version;
> > +       char *vfio_intr;
> > +       char *vfio_vf_token;
> > +       bool vmware_tsc_map;
> > +};
> > +struct eal_init_args args;
> > +
> 
> [snip]
> 
> > +
> > +struct rte_argparse eal_argparse  = {
> > +       .prog_name = "",
> > +       .usage = "<DPDK EAL options>",
> > +       .epilog = "For more information on EAL options, see the DPDK documentation at: \n"
> > +                       "\thttps://doc.dpdk.org/guides/" RTE_EXEC_ENV_NAME "_gsg/",
> 
> Options don't change that often, but I would prefer we point at the
> right release doc, rather than origin/main.
> 
> diff --git a/config/meson.build b/config/meson.build
> index 40f33816aa..c3c054bae9 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -70,6 +70,7 @@ abi_version = run_command(find_program('cat',
> 'more'), abi_version_file,
>  so_version = abi_version.split('.')[0]
> 
>  # extract all version information into the build configuration
> +dpdk_conf.set('RTE_VER_MAJOR', major_version)
>  dpdk_conf.set('RTE_VER_YEAR', pver.get(0).to_int())
>  dpdk_conf.set('RTE_VER_MONTH', pver.get(1).to_int())
>  if pver.get(2).contains('-rc')
> diff --git a/lib/eal/common/eal_common_options.c
> b/lib/eal/common/eal_common_options.c
> index 787f759196..e11d76589f 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -196,7 +196,11 @@ struct rte_argparse eal_argparse  = {
>         .prog_name = "",
>         .usage = "<DPDK EAL options>",
>         .epilog = "For more information on EAL options, see the DPDK
> documentation at: \n"
> +#ifdef RTE_VER_RELEASE == 99
> +
> "\thttps://doc.dpdk.org/guides-"RTE_STR(RTE_VER_MAJOR)"/"
> RTE_EXEC_ENV_NAME "_gsg/",
> +#else
>                         "\thttps://doc.dpdk.org/guides/"
> RTE_EXEC_ENV_NAME "_gsg/",
> +#endif
>         .exit_on_error = true,
>         .callback = arg_list_callback,
>         .print_help = eal_usage,
> 
> 
> -- 
> David Marchand
> 
