Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9AC28B28
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 12:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A258D402C4;
	Tue, 18 Mar 2025 13:35:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7C48340291;
 Tue, 18 Mar 2025 13:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301351; x=1773837351;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wyykrI60s5eLOb78BtoWHy8pfb2zMP8YxMqEpBthvyQ=;
 b=Etv5yfK9CNcg3t8KoasP7KA9ClIYHA6uBbU/5TBZ7cWc1fS/iCvR9KC2
 Alqm+pSt3BrKX2VqicGY6QIzvEd4JzfiOLb/B7D11Hy4KC5h3TAh1KZUc
 j/2S/AZmWzNyc/mo2LvQKq0WbKP48o/wYoN8Ir+lIEfVZBKijpUrB9TDu
 HSxq35KZzSM2Aio4IXaFTDHj1lGwA0kCIxkJ0CwO+u/x+cnHeub4bAiRx
 TOsCFq9A3ae/So7fCJyrgaljvZf9+s/7N09oazWwA6Vu1jkm71M4HHDpJ
 JBiFLcvggHzYzzc1lwSJwaW8wcHpbxif5ddRTTJNthvdceXg417k62FL2 Q==;
X-CSE-ConnectionGUID: W3OuUR+QTVKO2QCAPuzPZw==
X-CSE-MsgGUID: 9UtGCDQsSb2vXUC/9LyHIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="60830627"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="60830627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:35:50 -0700
X-CSE-ConnectionGUID: GCZCWZAcQcar0DlllzqsRg==
X-CSE-MsgGUID: OgngZT5UQ8iqZKCRhouirg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="153237297"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:35:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 05:35:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 05:35:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 05:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA7s1fpnWY0oJLVy/2RcKv3laqr4zT3I/l5H7bXNC4vFFD3VHgNLpyzDzZ2JH0pKo9xsp1AB6ebGsYUNykn/Gc2xgDf4AlFL3Vt7YWG+pl+abapIzrdwpyZUnb3JfCcVBzNL/x/wkvlAwhff6LwnaSYz75RxbBw0Q1r5WjesSimZfKzOb9QEdSRhXDFPMkZDfrHgfs+BGK1kGAdOZmLdF9ofILCaT5aEiuQJlG6SmL7Nty/o4qCYDP4wdwS9I0Z+3ML+RgT//7fBqqVREbAtIVmrY7pNYgQ5INY6foqIJysXVD+v23h78IUxk5Ge6KWRqFzBbGQVukit1crlJD+PPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL0DE4LyMONLmSezDq5r4Di6hTLXUApA7G7i5I7t/NM=;
 b=BzEhB4F2ccdTgvbsqX0ApzaQ4CeJOac2KeAEuGVZPdNPYWQ9SIbR1/3w2EUkz5qmS3DyWQHNviRyFbB0XDIPJitAk5JicBWh/qPffZF/iLejd0pC1siboSs5VF0Z1fBwB7mjHWHSzx2Sq0k9diN9mZhea3STbIKLuxwLubLM99VDWp8DzJoRCRWKYp59iRTpYK5HQVuP/Iwst1alZlohiAcOeOfL2ylZ7bqQZ6pKA5ixBhaQ0fPPoCDUdg85GZGzo9VLNJcb0KW7lvFzSbDrc52yxu6ZZ2+d38TWfbWp/X9UAEy7jnbJn6nPKsMdMEtCS+j5pmRdAhWqHoanAQw6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 12:35:15 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8511.031; Tue, 18 Mar 2025
 12:35:14 +0000
Message-ID: <f8fe5e57-5e73-48db-af6c-8208e67b4528@intel.com>
Date: Tue, 18 Mar 2025 12:35:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/iavf: fix crash on app exit on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20250310131116.557117-1-bruce.richardson@intel.com>
 <20250310131116.557117-2-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250310131116.557117-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e59cf82-257f-439b-f788-08dd66195536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2VvY1E0bkU0SnpwNGo4QXd4dm56bEhvVVdOLzRNb25Fb1dFTWFUOTh6RVlX?=
 =?utf-8?B?UG94MGdxV1NaSHhpWTRGS2hXUWF4cHkvekNnTm0wdWxsdnI4Y3RBQ0NyQTd4?=
 =?utf-8?B?Y2NVUUVDK1FmSzZ2WDhHZ29OVVJneldFMkRmTjE5RTcvNHljd3Z3R29qR09p?=
 =?utf-8?B?OFJGb29HRnNENERPU2RSNkhPbmJSY0c3Y0tnVjdwcjdlYUtBM2dLdTVEd1pz?=
 =?utf-8?B?TVBncXVNNFJQR3E2SVNoU1NmdU5Ja0RZbjB2ZDNoVnlCN1Ayb1E4WnhXZzdT?=
 =?utf-8?B?YVdHck81cVlhQ3VlOHl2L04wcktnc0RqYXBvODJ1Sng4Z25WbFZtUUxKVVRT?=
 =?utf-8?B?b3hqNVdldzFPaVNPZXlsVTNqZTB4bXFpMm50MnZteXRTNDhPRUFPOFZoclpU?=
 =?utf-8?B?bWdFakoxRko5MWFOV2toRmN5N3o1VHhmTjVsZ3hiMnVrRUJOMzhlQnkzL0p4?=
 =?utf-8?B?TzVkdXNybVpjV2gvQ29TYUNXaUg4dmhuMkhnZGdGRHpuTS94NHcvT1RDTDRW?=
 =?utf-8?B?STJoQlhmdC9aK3IyYnVQS3NmekUxRURXaW1ESThmTUpydEtjT3plblFMa0xs?=
 =?utf-8?B?OWdCTkNsMnlHTWhJRS8rU0dXZVdneWxaNEVrYW5oeDA5QU14ZkIyL21kN1g0?=
 =?utf-8?B?blJhZTV6a1RieS9IZzZwVHlURVN5TzdKa0lzTVlicjJSb1dWZllZZURVUHdC?=
 =?utf-8?B?WTF4c1ozcEx5aFBxaEVkeGRXMTdrcWRScm8ydjNMejIrd1VreFlSTkZQWTVE?=
 =?utf-8?B?N3F0cXlsVHc2RWthdGVoU2s0QmUrb3dROTJhdEJhMmdmRjRxbjVNRVFMN2ll?=
 =?utf-8?B?YlBmeCtJc3JYWTlHaGMxQW1SNnIvNStqL3VWOEFMS3AvdzJZL2c4TldvZTQw?=
 =?utf-8?B?U1RKcVdHODlsUExIKy9zWUxnTWhSa1ZPcmtnZmV3YVFsQURlUE5ScnUyaERY?=
 =?utf-8?B?NTNiRGc3dW1Mc2gvQkNpOGFGL2Z5S2wrNndXbStXa0pjVTJFRElJbmh5N0VE?=
 =?utf-8?B?SGRDNjdaZXo3K05ybEk5WWtuN1RyTitSbHVoemRZOXlMeGFKZ3p3WG9WS1lU?=
 =?utf-8?B?c3hveVZKY0g5WjFoOWZWRUJsWnR5V1FudFIxbWcyNW0vM1l6V01KRGZzenpt?=
 =?utf-8?B?R0x4cFJuUW8ycXVHdkFWc2NDelNLTGVnTXdpendDUjl3MFE2QmhUcG9ZVkdw?=
 =?utf-8?B?QnJUdHVhZVBCR0JUK0JQM2tybDdtblBDT0JwYTNkZDhKRG5kalRHUVV5ckpG?=
 =?utf-8?B?VkFGVTY3Ukk3WVB2OFo5d1U2b1lpNHpwbmpuYms2NU9KbThMZ1NYTVJlRkJ5?=
 =?utf-8?B?cVc4WjJWUmpjT0xSczJFcGhwYzlJMStHQ3NFZGphWlBtUDIrTlVzSkVpamFS?=
 =?utf-8?B?OWs5OXBIUjlsU1ZvUFNsSklvbEJzVVdCLy8wdEo5LzdNQ25vbGpTV2pBcTBm?=
 =?utf-8?B?ZW9ZQTFnQWsxSG1ud1ljWFZhVDRtbmdiY3p3VmpGVU5RT0NRdnJybE1rWURx?=
 =?utf-8?B?NXc1Tnl0blM3SnE0b1orVUJ6WWhXbDlZdE9jTjNDQVZOdTMrMUx6UWhqR2NY?=
 =?utf-8?B?ZGtMQ0FtcTZ1d3dIazhIQnhoRUUrNy9EZW9RbWwyWlY4K2tRU0xyWEc0ZjRJ?=
 =?utf-8?B?SlR2cElxZUNhMGhydEdIemN5eW9aZmlPZG00U3ZUY1JKWXRQYzlLS01jRDF0?=
 =?utf-8?B?L3hteFBkdkx5YzR1TjRiMTlnRjdXSVRyZkE2ZWd1MElCdEJYOUlYTzZ0K1JE?=
 =?utf-8?B?aTlNdElsV1Q0cGV6cysyZSs5ajc2S2g3Nkg0cDljT1NpRWRYMjRuZmMrQ0Ro?=
 =?utf-8?B?ZG5CYS96czI5SnJSYVNJN0t3cVdSNS9pNXp6S1hvdnI0SXBZU1FtOFlTcFgr?=
 =?utf-8?Q?5nPlyokcl7S5m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05yVGMrS1hTV2RhT3JnblVYZlpjZmNqTVI3TjVuNGhXSU1yNGcrd1BNL3lJ?=
 =?utf-8?B?QlB4ZlNCZjVRMHNWOWdweDNBeFRZRGRMaDgrU252K3NJdndZUWJYK08raE41?=
 =?utf-8?B?OCt4YUJsWUNmdGhGOTRuZERNT3Z2U2FuVHdVMkZldWhvVFB2RE5VNi84Vml6?=
 =?utf-8?B?ZXlqbDkyeHI2MyszdHNwTkhEdGd3RUdtVVdjMkJtUEd4bGprZGJzVXJaSmVa?=
 =?utf-8?B?V3I5Q2hNYzZBWVZzRGJnTkZZTGkxRWliOWQ3QkVsRm5tMGN1RlhGUi90TEdW?=
 =?utf-8?B?Ly9ZNTcxKzFzRkhiRytNUEEyU2tmNkEwQ1NYMTExWkkwVnA5SExIcHVmbS9q?=
 =?utf-8?B?c2U0dFBCVjNpMHRlRi8rakF0V3dpU0g3dGtBbFRla2Y0aTIveGhCcUM2REQ5?=
 =?utf-8?B?M1JoeXgwRGxrRy9hZkJ0amVwUWgrTTJvKzdqVHBnNFZLNkFJV25pN3hEZlRS?=
 =?utf-8?B?aGQ3NDJ5WEN5ZFp5anBDMitIUEVOMlhuR2xkWkxRUy9pOTFWeDlTdzZWbGNW?=
 =?utf-8?B?bCtpaWJCc09uUmQvQUFOb3llUkNqbmlpdGVjWm5aZmtEek1YMFE4MTkrVlJ5?=
 =?utf-8?B?TUVxcTlXU3NlcngzaGYrU3hiT1dkOW92czVxNWZNYW12MjhzVVc3N1JZYW9m?=
 =?utf-8?B?VjNxbTE3TjV0cEFpendhbHlVTzhzSUlwOWdXOVdsbU5IUXFaN0RJcnBvcm9m?=
 =?utf-8?B?OHVBc0ZtaFdDNEdrZDNITkd5V3VRWUpoTmVhV2tZbmJYdDc0VUJYVHJvTzVk?=
 =?utf-8?B?cCs2cmRVQ1VQQlByNnRMYUxyYXRNcFl0R2FEMWRsYWJNSEI4K2cwZTBPS2pa?=
 =?utf-8?B?enFrNGhKVDkxTlFsam44akRkNzV4andySHphejRrWFhiQmRuV250Mnk4YlVF?=
 =?utf-8?B?MWRCNXY1MVFHd25wdnYzQm1uL2NGQmZOdHpyTHl1dEI0bjlFU0p5aFh1WWxo?=
 =?utf-8?B?VFpJd1JzS1B3RlZVK2dHMDdzdjJzRnFqZUh3S3FrRERGS0FLUW44YXEzK3dE?=
 =?utf-8?B?czlsd1J5bGV6dFE1ekc1Ym5IQmxQVkl6blJPaCtFNFhFb3o4QlFJQjR3V0s1?=
 =?utf-8?B?dEF4eUp1ZTdWKzJvUWNkK1V6Mi9VRVVicVA2eXIwZGNueEVadnJrYlIzdFVK?=
 =?utf-8?B?NTYyejIxQXl3VERQZGt6MjFkQzF5a3VWVjI3MHZMWXZ5b0w2RnZ0RStZSWEw?=
 =?utf-8?B?ZUxEY1lpdVdoN1F4ZDlacTZGYXd0a1dEK1VRNnlQNHlpK2hzeG80YnBnNjRQ?=
 =?utf-8?B?WEJpMUo3aHprT0lrMXpPbzF3R2tLWVJ1cEIvTWpCOUQzd0ZwaGlOVk5XendN?=
 =?utf-8?B?THE3R1ZuVEJ1V2VyRmdGZHM3UlZwYWtQRU9HelpTODQwRGJDSC9KNlRvaXlh?=
 =?utf-8?B?dk9pNlk4cld1OXNhVXp2Q0crTlhjMlg3NVhqeFBKVHNxcFYzckdMN2JsYVdq?=
 =?utf-8?B?QXZsazBRMThiVURoOG05RFU3eW5ubzhvM2lDdTNGK003L3FncDZla0hxSXhE?=
 =?utf-8?B?VTkxamtsbFhENUtaZzZKU1lTUmxQTTZMQlFoZmRXN2Z3ckZ1eTEvVDRic0E1?=
 =?utf-8?B?eVpobkUzSzR5ZXVZVzcraHBIbEVSUnVpa2plRm1nQUc1OUIxZkwxY3Vmc20v?=
 =?utf-8?B?U3pKUVR6Y1BCc3pwanI0S3NVbGpjZDRTT25pdHlGR3dXdjkrZTZyQWNlUTZR?=
 =?utf-8?B?N2N3cEYxMmtsWHNEMm51d2hVVmgxN3hZbm5sR1pHWEFrcmNFMHNMTGNwNEhy?=
 =?utf-8?B?bjNNZFlpOWwyL2w5WHBQVGFjYlZKOU5yaml3eWpXUmdYZ2VRNHQ2dElmSlQ0?=
 =?utf-8?B?YXJLQ2I4STloOWpZRkFVUjFzbERlYjdjTzFURVRidUdFbWtReWp2Szd3aS9n?=
 =?utf-8?B?M0tUUWszR0ViWk01UjZub0lmQStXZGIxb0tobm5mUFI4dVpnYVA0aitxS251?=
 =?utf-8?B?MFd4UXhSZkQvbWlxZlU0WWluVVJyVWsvTUtQbVhFR1YzOHkyeFd4OFlJaDFS?=
 =?utf-8?B?UlBya0VjV3VINWFvYXFLYlBaWHBUTXR3MFAzOUtzMERFMjlTaktDTFlQWDl4?=
 =?utf-8?B?WDNBbjM0TEI4K0xldktpbkI0TzJxbGk5eEl3WFVrUGNkSC9rK2JvK3RUV1dk?=
 =?utf-8?B?aXZvaXN0U1oyQi91Sm9BUzg2WERQaHNOcHEvR0VqaDk3TnlXSXMvcVZMWWVD?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e59cf82-257f-439b-f788-08dd66195536
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:35:14.9074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeMFBsagD2KwLJflwlHqHOTJczMwMGTFd96+TcAYsxTPhsBMRbc19yXqdACn7RLifQ1S87P4FEJKewNBm93HLtSI4XAq+KKqyx9CEoEFNe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/03/2025 13:11, Bruce Richardson wrote:
> With the fallback interrupt path now enabled on FreeBSD there are
> segmentation faults on app exit, due to the alarm interrupt trying to
> access invalid pointers.  Add checks for null to fix these crashes.
>
> Fixes: cd3b124955d4 ("net/iavf: enable interrupt polling")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 1ab84b0bfc..2335746f04 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2698,6 +2698,9 @@ void
>   iavf_dev_alarm_handler(void *param)
>   {
>   	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
> +	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
> +		return;
> +
>   	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>   	uint32_t icr0;
>   

-- 
Regards,
Vladimir

