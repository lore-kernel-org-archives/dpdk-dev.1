Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE2C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 13:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D5A410F2;
	Fri,  7 Feb 2025 14:13:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8C74C40E45
 for <dev@dpdk.org>; Fri,  7 Feb 2025 14:13:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738934003; x=1770470003;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gVMHecao4z4Du4Vvir1Fuy4pXzej6NYr6VWYGVZFhJM=;
 b=Udmv3S5XqHTj8HjpjMfWvRl5xNB13Oai08I7rGFqk0J/SuVXGbwYBql7
 h6k8DJWIedy2InT4Yla9Pg1FbnNhgnCGTd3kKOnAzakV4el/NyjsuUyBz
 JkVIpaNibEY8qFgvbShhRvnstCIP+MduZ/If4PD+1tM1eLQWG3fHyIE6Y
 RuZZjttnyYYJ3ax3BLDq7BAkqpvPqjvcWeBWIh1T4dAP1B8sMIMbFufRZ
 AA3kMkTqZk10XteLtTNx6T+RO/gRQZ1z1Rmk3PUlKDg9RtpEbFhTXAVRi
 +gh1CtHydG4NUuLSxq1L5K3wE/bcpWEf8MYkFaZL/CIkRSfo0KWgdbnnE A==;
X-CSE-ConnectionGUID: Psc1SJbtSLuMZim4JPpmeQ==
X-CSE-MsgGUID: 7OilG0pwTFS+ud5Fp3RZ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="49815672"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="49815672"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 05:13:22 -0800
X-CSE-ConnectionGUID: sNsS22R0R4Kta9Qum6oHVw==
X-CSE-MsgGUID: 6NShyO7WTJm8TwnXZkjYyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="111486866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 05:13:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 05:13:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 05:13:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 05:13:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my7MhbDdaep2aJHIXpEDoArcnt/gzWS8n7loSZaLuznrYcJSS003h2DxfgbD70i2/A5VWLr76DMAg1s1a3FOYQaeiilhW9tnQlrkYRMtyioPg3Rhbz4KY2oiU+rn0+SGqYuHj3hPBI7Q4jcS6LirBPlBA4rORgZaJd98JhLmJ2A0FhQoSXsF+YkavHGCCR21w5QtHBjpJcFSeNGH0nenqxkV94Zjcx3Azycp3VeG+3Ly6qS8xG/WYvC7StQxu6iss/PN0g28FkGArXmrCdgzcqafdgbsb4mypSaQmfmjG6xo7XYsfcq9NOcwh91u6ukvPHWnKf8Agk2xBkqkjBQPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnekI/1IuUT/tL1nY4r4FTQPaFn9rtIQUmpoQ3aZsos=;
 b=Vi24YAjHethLl40RWUTNS8Sz7E+wOusvdmRmMm5fSPtNh7X0jML4DPXtTeb/wdlux7xD5BXAp5OKCvAlVCaLTu6D2rnmj3lwGT8RPXsKUKIhtmrmGF3UTx8AiVU7ADa0RJUncuPwkcBXFph8WwPLA6Mq04JrF56JktC1zTS3ZB42wfmv1hOd3aCyhkf8A4ZQZ5XU+0uI2G+VGEii75TU45w3JuGCpU9yPcPs0Uw+ECAX7kkqFcWiT3lPIGn/Tvx5AaEr7eG/WIZiJUdusDHtB3pnITBctkK/EtJ6mufCga9FCA+pHZHCpdDWOPCvZ3PLLm7iOzHIRRRlHH7tKETFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 13:12:32 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:12:32 +0000
Message-ID: <b703ec08-80b0-454d-a62d-8f7751eda7b8@intel.com>
Date: Fri, 7 Feb 2025 14:12:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/36] net/e1000: add support for more I219 devices
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
 <aa0df2ccd3864c368e93367b1c38b5bc98b53bcf.1738932115.git.anatoly.burakov@intel.com>
 <Z6YE9HWGelGN4ygU@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <Z6YE9HWGelGN4ygU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0185.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 63209470-d977-4deb-76bf-08dd477914b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czFPSUFKUnAyeTg4VldMTk4xUXR4ZTI4Q09hV0VCSFcrWnc5MVc4Uy9oREFw?=
 =?utf-8?B?TlBGSllkVHBTam1JVGhZREc3WVBTZ2kvL2ZaS2JTRjB5OUF2Zm1RQnhUMUh1?=
 =?utf-8?B?bkRHQUhucFkyWk1iQ1MrOExSNEx1YXdmVHB6R1daN0VoT0dzK3JxOXdoM0dy?=
 =?utf-8?B?d3VjeDU2Wnl4cSthTVZZNmtiVGF4bUFGU0xnQlY2RHNMN01RN2x2VVI5TEow?=
 =?utf-8?B?N2c4a2oyVGRRWjJQT0RrUzAxRGZaek1zT2xCS0lkQ0lXejRpcTVWTTF6clFB?=
 =?utf-8?B?ZnRrOFM0aDdSRC9YTERXVTBrNVl6YVVObGc0M09DZU9CejJZR05qMmZZcVcw?=
 =?utf-8?B?bGhrbDBRMUtLWng5dHNWcEp0Sy82Ums1MEtUTlduNVNucXFHL1UyZ1lWSGs3?=
 =?utf-8?B?YlFSZHVUWituWlBCbngzSDlhUUIwWFM5Q1k4VVZiZ1JUaGtLdkRzTFpqOFJE?=
 =?utf-8?B?U0ZMSkE1VHRwczFBUFJoeWJiN0hDQ1dGbERTZ3g2SXdPNjBIY2IyM2pjZDZx?=
 =?utf-8?B?SHdnQ1hkT2FSYlJFTCtGTGlJRDZjREFzcXJpRHBmVm5VVmVkc2hZSW11cEpD?=
 =?utf-8?B?WGIvYTI1bzdhakFVZkxZazd0Um5kdU9Cc0t1Sk1QL0ExYXZmdEFhbkozbkh3?=
 =?utf-8?B?SlluenNncTAza3JJK0xlb0pRdVZnbEZENDdHalZjVldGMDdncTNhQlZuUmpG?=
 =?utf-8?B?eGZOa1poUTE0Y0J6dGYyYVNmc0NFQzU0aUQ2ZSs3OVBMUE1qSnV2MzZ0SDlE?=
 =?utf-8?B?QjVJZS9MU0t0UjBvbnFHbWx1ZUhrVnoxUEVwZXNHRWFkSTloajFnd1Y4a3BC?=
 =?utf-8?B?a0dGZW1nRHNHYktSc1E1WmwyMURkUzhHa1R5bnVEREJCVGxRdFFxV0FQWUJH?=
 =?utf-8?B?M01POHJicGZwaVU1ZndyUkZVWVRiWkZpWDRia084YWExYzYwaTdiU1doOE1G?=
 =?utf-8?B?V0xMcHErRVFjQlM2M1BaQUhBdFpGdjNpWkgwSWRyb0VCQUg2OU9nWE9YVFRu?=
 =?utf-8?B?ekREWTVyUmRqbllGY3JVT3FkbmljTVZyOGo5Tm1DUjRrRHV5MDZ0MHVuYjRU?=
 =?utf-8?B?UWFQM0dTdmZFK2RFTmhtL0NQbWZEckYySG02UXBINTQ2ZDk2aHZEdU0wQ2pr?=
 =?utf-8?B?RkJzZkxGZ2ZWOWVRUnNWMlpzTThEQ0E4dmRHNjY5S096REdhL2dYWkF6bjRP?=
 =?utf-8?B?RlQ5eVIxWExZRFZycm8xUkFBakUyRlIvUXBob1NiM1JFSTl2L0ltNHpiV3Bi?=
 =?utf-8?B?aGhydDBCNXhUU1VoM2FVaXNEU0licm5IS29zZkVxU1JwNEgvNklCQm1QQUVH?=
 =?utf-8?B?M2dRNWlxNzd0RHM2YXdNNld0MDNtRC9qK0lQV1ZRNndUd3BiQkVINnNaYm9I?=
 =?utf-8?B?ZHpJM0drT1IyUjVsRGdKTzNTS3hUVzA1eGJ5cGlBSkZBZzRTTW9qWFkrd01H?=
 =?utf-8?B?WkQvdUVRdW5aakpEMGwrR0psaGRqS1lEczVPRmM3RkxJOGQ5aGNCU3QvOHJj?=
 =?utf-8?B?LzF1V1Z5cmpnQXhIaWRJaXA3b3J6emptTTlnT1E5NkpuQlhydjdVODVQSUZ5?=
 =?utf-8?B?MjFXS0RRMmt6OWFHWXZGWTlIVGdYVWw5UFZhTk41TGQ5R1lSV3pYaVlTVjlm?=
 =?utf-8?B?cFFES2Y3QWhKbFlWMnN6SndtSzRkaXN6blN2OVhRVEtWcWVRbkQrTWkzbE1P?=
 =?utf-8?B?YVJ4WjFUTkpwR3NKWUV5dXhXZzJGQjlqV1BlNFA2K0w1M3dmSG4zNFNqcURX?=
 =?utf-8?B?WktpUmF4WkREZGxpM0NUZ0ZXNWZFTXFjSzN1V3lYUVBBRDlHMlR2MnVmc3g2?=
 =?utf-8?B?RGlSam94SEs5ZFBaaWJRaGJHUWNOZG5TbXU4N1NOS0o0dHMxdjFqWElCd1g1?=
 =?utf-8?Q?sg0Ap8RnS8w+j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3l2c3E4bmlSSHZsaWI1eHEzWExBeGFmMllhVUtQaDFBKzB3d1Q0TTFWZGl4?=
 =?utf-8?B?MFAvV2R6YkVtS0NCTGlXRGI0QldYUm9qVDV2N2dtTk1oZldrOE13cUd6VjlN?=
 =?utf-8?B?c3dGTHhaakxOa1d5ZGVsQktrODVWa3FQWWMvRHV1ZEk2QmE0a1oySFJ4TWhY?=
 =?utf-8?B?a2RVMjNUTXhBMTVDOHR2Y3RNQ0ZFZzJPazJWMTB2KzRacTJlcVhtZmNyalJQ?=
 =?utf-8?B?TkVIb0duMkd6WGVMOHJvTWJ3dUVqRWlndXpuY0ZKd29IWTZiVXQrMERxOE9W?=
 =?utf-8?B?bkNtbC9FeFFnOTZxKys4UGw3RFBtV24zVjQ5NnRWbUdvOFpEeU1DUWpyUFIy?=
 =?utf-8?B?VFRrYUk5NWRDSWUwWTBNTVhXSVp4TDlaWVIveVVmYUljaHpONUR2UTZHSDho?=
 =?utf-8?B?aEV0ZFF4U3FBVi9jL2FCMGRWditKRC9NWXpGM3Z3b0tZbjZhb2lHekdWSjNL?=
 =?utf-8?B?ZkVnMFNHYUg4VDBZRE5JY0xLMndwZVFIQituZFMwUUM2Ym9zMWx3NVY4ZVZC?=
 =?utf-8?B?SGlLVC9jT0VKZlRnRktHODNIZHp1SUhYQVFCMjE2bE8vOFgrQzNXTzFmc28w?=
 =?utf-8?B?Wkc0dmppNzVKRGhRZlN4SStMSlNSb2hYdzIvUXBOMi9XRkIrRDZ3dnJrcDBO?=
 =?utf-8?B?YXEvaUhITzhQT2FjcmpnL1d0S0F0N2kyYnNsaElESWdyM3A5a0NWUS8vRWpH?=
 =?utf-8?B?M21FSnFjQ3YvT1lSN29PNWh6Mzl3Z25RM3ljVW9rMzNWUlIvVGp5N0dFZGtQ?=
 =?utf-8?B?ciszbUZTSlNqODR5dnkxK1hjVzI2eTcraUtGOURobjYzMUlGTXVRMkJudHoz?=
 =?utf-8?B?d011UzJWOGlMTXh0bllFdlE4N29Ub1ZPQXZScEF0cHB2VGZ5M0QvSkYyZzVp?=
 =?utf-8?B?K3RvYUN4LzBwM1BIOGVWUkVHMXN6RDl1TEhLcG9WaUtCOWtwYjBTVFhDa1FC?=
 =?utf-8?B?Q2h2ZDMzNjhpL3lZVGJXOWUveFlud0w1R0lUelJDbUswcWhHMVE4bVo0L1BU?=
 =?utf-8?B?cWN4b3VyWDlFeGJlUWZrVjFOTlJwOTFMVU1yOTdWUjMrWmRKakhTZmZqV21J?=
 =?utf-8?B?NDAvWHVPbGx4SEdIUlBnMTFzL1BBK2djYTI5cjJNOEM2M2EwQnpNV3l2S1Jr?=
 =?utf-8?B?YXpMWFJ0Z2J3THBEK2FGR3Zmand4YTNRaW8xV3U0ckQzM1oxcldTR2FaaGVF?=
 =?utf-8?B?L3JvdHRpMWw2WlFobENDQW9MMGxaQ1FoTXVOZUxKTFlNSUNhemFELzVjK2dN?=
 =?utf-8?B?S1dyVHFnVXh3OHN3K3d0VnF6UW8zaEljNGtIOW94bW5kRGFTNXBtRWMwK3FF?=
 =?utf-8?B?MzNFL1RoNkZlRnNPd21SL04zdUpkV2N4bFpCNnkxTUEzWmJwSDRLSnpERThE?=
 =?utf-8?B?dFArVXZwSHEvNGpnbDJuVE80WnNpZDRoOE9NdEVVMXhVTTZlaExvL0MrM3Ax?=
 =?utf-8?B?dU5PekpEbUZ0NXVCa1BuQmJFL2l4RVRHY205M1E2RFBYQ2NObXNXYWFNR0M4?=
 =?utf-8?B?blFUN0lTL0gvMlJodTIvTEVHWmFvamJEQ0N0bUdiU0ZjZmgvR3g4T0tUa0hp?=
 =?utf-8?B?SVhXaVpOUGdWMXBua3lkSytFenNHeWdBMkgrcmwxUjlGeTk2Z2lVd3QwQVZP?=
 =?utf-8?B?V0lMNEM0d0FxSFhiUk81MEN2YVNqcDh4N1ZjbjhhWjlzVnR3aHVsaWdBYy9v?=
 =?utf-8?B?K3B0ZlEwSkZja0pGeDQvYi9yaFJ4MEdaZHBBbDV2ajl3aWJ6VTMyU3ZYZ2o3?=
 =?utf-8?B?bUFTVGlDb0JCY3hDbHpsRDg3U0dnNmcrMzJkUUZNc2l2WGRYL251Q3RGcE1l?=
 =?utf-8?B?em52QlhMUEZYV1IvemZYMExqQTh6RTl1ejc4ZnpyRmdqeXhOSEI4a1hNcGxw?=
 =?utf-8?B?bjdIL0xQR04zNWxhd0lSTk14blRhYmo2YlVQOGVwSnNBbXdlTEo0RHNVenI3?=
 =?utf-8?B?UFdobllqSUxlT0NZVFBONG5tQnRDU3d5MmcvNUFZVzhRd09taE1HNUo1UHpz?=
 =?utf-8?B?Yk50c003TnVsMUJRQkZsZDhoWC9YZTVubi9EM1gyYUdkUi96Tmkvd2R1SW5N?=
 =?utf-8?B?d1kyYVhQR1lya0xXcmFQZ3p4WXBodndrQVVnZEFSUzNPRDcxRlQ1RkJ6dXFn?=
 =?utf-8?B?NGZvT2psQ0YzUStHdHV3Y3h2R1dNZzEwSXh0ZjlrRi9UekpwbWkvL1B1Z1JI?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63209470-d977-4deb-76bf-08dd477914b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:12:32.2823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLevrE4LIlAxIboDDkE0kOZlHHGSIKS8kaMJsK7M6yZeQMNwLn62tDeN/3KMdu0zmd0ipKU4NNzETQa9MN82H/3EiMSLSVDxEbuNrFGx+FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5150
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

On 07/02/2025 14:04, Bruce Richardson wrote:
> On Fri, Feb 07, 2025 at 12:44:59PM +0000, Anatoly Burakov wrote:
>> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>
>> Add support for new hardware ID's from the I219 series.
>>
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> 
> Should i219 be added to the base code README as a supported device family?
> If so, I can just add on apply, if no other issues with this set.

i219 NICs were already supported by the driver. This is just adding 
missing *kinds* of i219 NICs. However, I can see that the support for 
i219 was called out in 17.02 release notes:

	31d4210971c54952afc9a1455ca40861634206e0
	net/e1000/base: announce supported devices

	Document all supported NICs.
	Add Intel I219 NICs support in release note.

	Signed-off-by: Wenzhuo Lu <wenzhuo.lu@intel.com>

It was not added to the list of supported NICs in igb documentation. So, 
yes, I think it is worth calling out support in this patch.

> 
> /Bruce
> 
>>   drivers/net/intel/e1000/base/e1000_api.c     | 32 +++++++++++++++++
>>   drivers/net/intel/e1000/base/e1000_hw.h      | 36 +++++++++++++++++---
>>   drivers/net/intel/e1000/base/e1000_ich8lan.c | 21 ++++++++++++
>>   drivers/net/intel/e1000/em_ethdev.c          | 28 ++++++++++++++-
>>   4 files changed, 112 insertions(+), 5 deletions(-)
>>


-- 
Thanks,
Anatoly
