Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2952CC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:08:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 649F440E15;
	Thu, 15 May 2025 13:08:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B1CE440289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747307285; x=1778843285;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qt9ngDHoSa4yslBzJOy3rjxEmd1CtD6JGcVfK+fmPcI=;
 b=VyUWEgahkleCt87SlmHeLfgJQdEh/RU9HHsmbKdIr0MjdQJiqMsQ31SO
 xtzRlvxhxYPO90uS2Q1lIpSkpAn6ToYoMXF3Wk5i9jMphnSfG5Vqk4ece
 xKoBiJ6uJ0ZmguvIT6R7YkOixZWbSQGuIlqAAaKFBn7zatsXdfUS99/Mc
 rXwnnwGveOE00VYzlOcEDbsaxX8L+4lExwnzmzXW10WPSUJs9D2ZwZoXs
 AmZxVoTzIEGb1/OKyrO2N5H+G/urkT107/oPyaFOIbj8j6eGxy92T20jH
 600AC54gAvnzqFSJ5JeLwTPwSMrw6mLAqpsjMzUfmnIjtD7eltJZOHf1K w==;
X-CSE-ConnectionGUID: 3rELXgLkT9uvFz36+ZyKYA==
X-CSE-MsgGUID: +wPlJqynQJi5n0R6Ceo3Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49396722"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="49396722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:08:04 -0700
X-CSE-ConnectionGUID: fDo0G3NWT4msraWOIme2pg==
X-CSE-MsgGUID: gzq0Jgw/S0ulavPg0Ov1EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138236535"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 04:08:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 04:08:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 04:08:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 04:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlJUjtIXr43juL6P7+9OVa+rDe60nY/6pF3905IXdrhh6wPfNAi6n5/skuiek9udyKtHF9FdVv+M69lMJG6TerbWkiJe3Xw3XTLtPg+H8W6YyqM0KXGTo+caM607puUvxzXg1J0ZITmtoNdoOJfe811lPSzf4DzJenRTCAsJRXmlcCB1wYYhdKjlzsTrdRfZVcl/OwDMNMxoKfIOIRsYNMdW7927wAM8mYvJvG6rZJmnnll5gcP4QroNp/gU62zH1yJZrkMKm3s/QqS75FsQSFvKpjLiOUv4NO30xe44x+BkMfyMtkaiQCpapttYPnosEYeklH1JK0Om1ZujNdrmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK1f5F5sbbnlpn8RokcD9eOYpNNU1LW/o6P1H25gvmY=;
 b=Yoy6TSop7DEwuCYzOggntxKkYIeY8zzEg5EMqeDPNdjNQbsNaNGZO2YmdU8tRPXRISTw1D9yhR74GYVj5A5qbuga1Su7Lm31XcGZl5szpJSS0vbJ/B+FQaB5gf6z8V8FfGpr/MobYDoONyJjUA6xUa6ckQ2jhOLoEzOPMnNOynLP6MP5jYCS4dLy6h5DsC/o/NKSOlOKS5RCiOeDNvoM4v5BbUZ6qbfEr/z8tbuxTNync1Hk6qRM/I8FwIVLeZjoQQygAUPVG/CIO14remzO9yfRWYB+aFd2s82ioyDJh7NeQZ5v0cxzXhSHoZkum/TyIuGJg8zrjVcpMTmwxN/c7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Thu, 15 May 2025 11:08:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 15 May 2025
 11:08:01 +0000
Message-ID: <40ac6abf-a243-4710-b8ed-aee4f7194156@intel.com>
Date: Thu, 15 May 2025 13:07:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] app/testpmd: harmonize case in help strings
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>, "Cristian
 Dumitrescu" <cristian.dumitrescu@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <aCSZ-IqhbldWR_it@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aCSZ-IqhbldWR_it@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0332.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 52631f30-4f79-4e98-51c6-08dd93a0c191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmhVQnJUVFlkVFBhOWVRcWN2cnhyUmRVRk43YXQrTk9scTd4RExRRit6VXlY?=
 =?utf-8?B?TC9qS1BkZXFOWlZPOWpCQkwvZXlaNHYyNDNENDNvWHdBcW9Nd2ZOdmJoUkRF?=
 =?utf-8?B?ZlA1QW1CNlk0a0UzTWZGaXBWUElVRlFBVklRcitnTHVrOGhXNWdac0NNc0Zr?=
 =?utf-8?B?dWVPQitnd2ZxZkhyWU1SQUVHRUJrQXRYUmxvekJManVWbUZEcjhmcC9HZHRE?=
 =?utf-8?B?Z1VTSGMwMUN0WlhkbmxuTUlLMmNjd1dOenY3SEE0T0pSL1YrWEtuMXBLTE1n?=
 =?utf-8?B?MzcxeENTbHE4SEQrU2xDNHZsSGdiL1FLa2lnVXhwekhRdmhWUlJaUWxjWFNs?=
 =?utf-8?B?TllZRGlGT1k4QU05NUNZVHlzdi91cHg2YUtKRnF2Rklkblc5TEtNWEp5TVZS?=
 =?utf-8?B?Z3RnQStNZEtKTUZBSUt0a0xEcXl1Yis5SG96Mm9lUVc5ZjJaei83VTJvVzlw?=
 =?utf-8?B?SzZSQk1MQW8rZlBaUzFDUzQ3eUtjbFRVOHZGc1lKa2FUZW96UUZyWVN5Smcy?=
 =?utf-8?B?cUp2V0p1OVJjRzhrWTFNcHMvc0FpUmFUeWtZS3BCZHVYNDNLK1NTWFdsc3d2?=
 =?utf-8?B?VURTVGI0UVQ3UFg5c3R2Z3dOcElGZ0UxdUNlVkFLQVVTMVBKTXFyNGpleWEw?=
 =?utf-8?B?dWdlbzZmdE94TUwvaWMwdXU5aTlEQ04vV2t4REJJenFiSklEN0FSRnNOU0cy?=
 =?utf-8?B?Q0NRS1RudGFPNEp6UFJLdzVFenFrWWZ3ay9kZEtEcHh5YmwxN1kyOTFERUZS?=
 =?utf-8?B?c0trbVRHZnkxZExKVjAxS3JOd21QSTdpTWE5eDRLczQ2SDVBSlgxdzJtL1pD?=
 =?utf-8?B?Vkp5eVJQclhTbDFZNDRabG10KzZUeFJ5UjRpV3dScHpueDl1WndIMUVkZVV5?=
 =?utf-8?B?L0F2aUt1SU13Mit0UUYxM0ZVSzJDK1dSMzJ4d0NXaVRrNy9CMmxqTlY1UEN2?=
 =?utf-8?B?c29YSUFLYVl5NkhaSnpVQm9oeTZ2MFc3a2ozOEtUZDlxTGhlVXdaVUM3Qk5z?=
 =?utf-8?B?dVJVbFV1emFmU2lHL1UxVGkwQzZqMFZCcWdOWUJFNEh4N0YwaGJXQVBieE5L?=
 =?utf-8?B?M3JFcklxNE5hUHFrdzlnbWd2bXFva2g1WXNBZURRVCt3dFdFU0srNHBFOEhX?=
 =?utf-8?B?cEI3bHVLUEFHV2VVb1p1ZENmNXR4T2JNd21SdmZsTnpmL0dpS0QzZGdTS0Qx?=
 =?utf-8?B?SDBIbGhFenRRUEdzSTlLQlBrakdpR3pLaGRDOGwzMDZibWZWT2doTUYvS1VE?=
 =?utf-8?B?d3JUejl1a0YyS3dwd081clRheGRodTZKVCtNLzRUVTArdE9JRWVFRTZBSWcv?=
 =?utf-8?B?QlhuSWcySkJjWm9wSXBVUWlNOXI2RklXR3NUckh4dmtMeEdUVUNXaVh1NDRJ?=
 =?utf-8?B?SU96R29mZE1JVTJTa2RGcFdPdWpoSTJzaGx6a3hLUkJuN0xrZWtta21kaDNS?=
 =?utf-8?B?NysraWNxUDBkOWloZ1A1QnNtbm1TeTdTcGdIRy8rakMxOGZqZlVnT2ZVQ1M1?=
 =?utf-8?B?ZURNUUZaTmVmSU9Xbi8ycWdHNG85KzBUUldPZ25kWW5uMS9HNDh0YVAyeHB3?=
 =?utf-8?B?blNidmxwWFgxS1hPbVlFK3UxeVBwTUR3Um5qSk1rTFU2aERsMGZwWHFqcU5w?=
 =?utf-8?B?ZzNqdXZ4UnRpVmFrc0RNUHN1eVVIQlZMNEFvZHhEN0ZQZjVBbzI5QUZvcmpQ?=
 =?utf-8?B?NlZsencxMkFDRG92d2VWdlQ4WlI2cEh2aVR1L0g2TmZ4OVFiQlVvcU5ZVkdl?=
 =?utf-8?B?OTAwSGZNekpvRU0wYjRDVGhjMnhxc2JCSVdZNDBFZFlZYWsvSmk3UXhtQk9T?=
 =?utf-8?B?NSt3RFRJOTBycEorVmQ3NXoyUkIzYVJyZFhiaVA1am9iY1dIWUNJa1ZmVGVH?=
 =?utf-8?B?YnB1ZEl0QWxXc0twOW5tY2FPYTQ3M050aUxXNHhXeTZheFg3TC95Z1FuemV3?=
 =?utf-8?Q?V4P+uxUEK9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStNdEJwd3V4VnNQSXZLeURVblhzdmdYc3MzNFRIMzYrQ3hINk9Kc3BYYlBD?=
 =?utf-8?B?WTlWREpvUWh2cWtua0F1S0RXK28yWjB3SG1VYUlycEt2YmkxMXRUak5GRmVR?=
 =?utf-8?B?V21SWlhRdEp6SjJTY3J4NkJhTHlTS1BsYWQxTGl1R3NwbnFMdFFrSkMwblhP?=
 =?utf-8?B?OGN5YzczeUlIdTZaendTbXZHMHg0NVVZM3NJaUJQMjhGUFZFSU1JQTZ6d2dR?=
 =?utf-8?B?UTNmVjFrL0RxcjVvTytNMHJsUUQwakVQR3VYM2V6dVlMSnR6UHJKTlp0TEZl?=
 =?utf-8?B?c2NrdjlMOWd1NXJISHhmc05RMXlBdUZRVGhYSlNBSmRTTjNSTDU4alU5ZFFk?=
 =?utf-8?B?NE5YSjBxSmhSa2tUMVU1RVdLeWIyQlU0Y2ZpSmZldWg0M3RXakpkbEF6SVVQ?=
 =?utf-8?B?MkNzWTNNQjU0NElad1VJVVp4OWY4RXRoSlBRY0R1QzJRV3FGRVVJaVNubUxH?=
 =?utf-8?B?dWtHOVNpUjBZclpqV3NGVTRRbU5sNlZOL09lSkFsOUxNRGg0UGZhWVNpUlFS?=
 =?utf-8?B?KzlZenlKVU9zV25mdVpoNWN6dDBEd21Xay8xRmtpU1Y2d1hOUk9HeHVCa2xY?=
 =?utf-8?B?QUU0SGlrY2RRTGc3enNvcW9velJCdWpQN1BpdHhabGdhUFA3blVBWWNpNExE?=
 =?utf-8?B?YWY5RkJTVlY1Z25ocjlKaFZlOXhEZ2FpazV1Z2VIZzF0TXl1enNGdFBtU0Yz?=
 =?utf-8?B?Tno3aVN2VEFic1NMMHEveXpZTjAzTWZScGhpUEhNcDIzOW9STWtobTBVd1ZL?=
 =?utf-8?B?aHZGbjF0TzFMcW1zZCs1cW1rdHlLTlpsbU9aN3pEcnZVNzZiOEhXNUEwSlpn?=
 =?utf-8?B?VmE0WU1MTG5QWUhLRXUwcWNPQkh4UjhTNHFTaFlFRVNNcyttZTFmKzFTNmY2?=
 =?utf-8?B?dVpDNC9PTGFoQXV2UnYwUmlyNWRMVE1lOGlvS2FVVi81SWdPQnhDZDE5M3lU?=
 =?utf-8?B?V0J2TlpUWlQrcW4zV3ZWVEJKdW1UcHJja1hpd0RzU00zMzhLSU5wVWFYMWla?=
 =?utf-8?B?Qkh2d1M2cnZ2c1UxTnVYV0xvWHMySlpjYnZZMkNQRDg2V1lSNXM2dTB5RXJu?=
 =?utf-8?B?OWdtTTNaSmc5ckx4TEt4bUc1OElYa3dKWGFCZEI5b21KTTZSWXh0ZGRJbkhS?=
 =?utf-8?B?cUpIOVhPSlBiejhHZUx1UjkzdmVWR2d4NnRCbit5Q2tJK1FTNU5VVmpKbkFE?=
 =?utf-8?B?Qmc3L0t5bXkrR0xtZ2ZIM1ovOVZwd3pVcEdGc25mekNJNUorVjZDV2NZVkxC?=
 =?utf-8?B?T1A1NlRDRjBKdDl6THM4dDR0UFlIMUEwc1dCSVZjL3lUVnpCbXhhNTVPdndM?=
 =?utf-8?B?ZUJEejZ3VGh6alp4bm10bmZoRGtTNjMyTjVUd0dhN28vTXRBeHdMZS90THFZ?=
 =?utf-8?B?ZjM4Zll6ZHhLQXZORU1QSlovT1Z0Y2hhMUZXaktTUUtuMFNXaEdUWm9Cdmdp?=
 =?utf-8?B?Vjg1ZzJCcUxiQUNSUGpWUVliSS9pVlQzZ1AwdEZQTWRVcm9nTGtydkhCbE5F?=
 =?utf-8?B?dCtWa2I4WlRHdDAwRW9uODk2ZXFoTE1KQ1lPR0JJR1dxL3JUUHBrYnNaN0cr?=
 =?utf-8?B?SDBzQUJ2dEt6NVkyZFFNbnJGd2NrSVhVc1F2YnhNVzhiai9GdmE3ZENPVVR1?=
 =?utf-8?B?cm5kTERWSmo0UkpWRURyNzdZenJnUDdQUms1YWkrVk9pTTczcTdpbWdjaEFi?=
 =?utf-8?B?VmltWkNOaXBmeEFXbFFITm9qdmEvSmc5MzhpRDJMRDUzZGU1MU9Ld3cwTXd2?=
 =?utf-8?B?UVpyd2dORXdENXlRQUgzNFo0bHZnb1FJMDREQkZZVFJYK3hLNDFOc3U3NHEy?=
 =?utf-8?B?ckxZRWlLM2VQYzRFK25nV0hPTS9kaUpSVXNldzRiTmNIem1IOEpRWVFRS1Mr?=
 =?utf-8?B?Mm1tb0k5a2lLa0FCQ2g0RHVzeWFueFNjMmZybHpKTzFid3BUTUo2bXJWbWov?=
 =?utf-8?B?SjVmUWZtS2xuaUw3VTFHTkFuamNYYjl0KzRodHdFZG9Zam1qRk9nZ0paaGl6?=
 =?utf-8?B?RXNlYThTV2VXWC91blRxdC9zS0VWaWVZc1ZodjlZVVRObzdLVzVnQS92Y2d4?=
 =?utf-8?B?cFpqWUZjVytSU3RPN1FjK2wzdyt2ZVNKYUhHVjBYQkE1cXNPNldnR1ZOYUNK?=
 =?utf-8?B?Z2RSY2tuR3dabUdIbUNxOWM0QmFPZWR6cVFidUpRRFhabm9EWUxzTGNPalRH?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52631f30-4f79-4e98-51c6-08dd93a0c191
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:08:00.9954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHPTCrhoUtH53gndTH9cr6XkHQ40ki9KdQyt+/MAQixTYgi4asWtyuqCa21qPxjOy1Nc9uZNBBMAhA7/2dJAfzzhvHjbLAN1JNtFN9KB7Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
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

On 5/14/2025 3:26 PM, Bruce Richardson wrote:
> On Wed, May 14, 2025 at 02:02:11PM +0100, Anatoly Burakov wrote:
>> Most testpmd help strings are lower case. Amend those that aren't.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   app/test-pmd/cmdline.c    |  4 ++--
>>   app/test-pmd/cmdline_tm.c | 36 ++++++++++++++++++------------------
>>   2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
>> index d4bb3ec998..a8f1b8ad67 100644
>> --- a/app/test-pmd/cmdline.c
>> +++ b/app/test-pmd/cmdline.c
>> @@ -8078,7 +8078,7 @@ static cmdline_parse_token_string_t cmd_operate_set_counter_name =
>>   static cmdline_parse_inst_t cmd_operate_set_counter = {
>>   	.f = cmd_operate_set_counter_parsed,
>>   	.data = NULL,
>> -	.help_str = "port (port_id) enable|disable <counter_name>",
>> +	.help_str = "port <port_id> enable|disable <counter_name>",
>>   	.tokens = {
>>   		(void *)&cmd_operate_set_counter_port,
>>   		(void *)&cmd_operate_set_counter_port_id,
>> @@ -9034,7 +9034,7 @@ static cmdline_parse_token_string_t cmd_dump_dump =
>>   static cmdline_parse_inst_t cmd_dump = {
>>   	.f = cmd_dump_parsed,  /* function to call */
>>   	.data = NULL,      /* 2nd arg of func */
>> -	.help_str = "Dump status",
>> +	.help_str = "dump status",
>>   	.tokens = {        /* token list, NULL terminated */
>>   		(void *)&cmd_dump_dump,
>>   		NULL,
>> diff --git a/app/test-pmd/cmdline_tm.c b/app/test-pmd/cmdline_tm.c
>> index 7ade91549c..acf86c1ef0 100644
>> --- a/app/test-pmd/cmdline_tm.c
>> +++ b/app/test-pmd/cmdline_tm.c
>> @@ -327,7 +327,7 @@ static void cmd_show_port_tm_cap_parsed(void *parsed_result,
>>   cmdline_parse_inst_t cmd_show_port_tm_cap = {
>>   	.f = cmd_show_port_tm_cap_parsed,
>>   	.data = NULL,
>> -	.help_str = "Show Port TM Capabilities",
>> +	.help_str = "show port tm capabilities",
> 
> Not so certain about this change. Should acronyms like "TM" not be
> capitalised, to make it clear they are not normal words?
> 

Most instances of the same are already lowercase, so if we want to TM to 
be upper case, it's not just these instances that will need to be fixed. 
Also, help messages are pretty consistently lower case for all types of 
commands, so I'm not sure if making TM stand out would be better. I have 
no preference over which it is, it's just that ordering is case 
sensitive (at least when using strcmp - do we have a case-insensitive 
compare?) so some things may be ordered in a counter-intuitive way.

> /Bruce
> 


-- 
Thanks,
Anatoly
