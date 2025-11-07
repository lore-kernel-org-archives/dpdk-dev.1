Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2714ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 09:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2080540264;
	Fri,  7 Nov 2025 10:29:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 41D2C4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 10:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762507774; x=1794043774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A3YlN9wV7j12doDWaK7GXHRgEIYb3Xk5RcV7yzSjbgs=;
 b=TT97WYTWKvp9WbEmt95bCpCGRDsP9aKzanGJokdEsVuAFTpLYDMSQQJa
 1NnLNuEo0q778Mm6idQDpnMCkMXvMnVphP1lbJ070XkGY4sbKMVK4iH6S
 rGlYU8Exo8QcTQvyMUXIq17Eut9wmnm0k8u0APb9nzw14Cb1/DCWETkIB
 k+NNq4ZacZ//wi0eP4WKgLTxb+6cSDNL26grg0Y54in1aYgvN3yGdfZa1
 RGD9FQ49k8MQvlQNlWE4aGmhaTFS4I07FT68NLVX+UDnD2or16aoR7Xd+
 iWNZK9CD0KLTo24Z2WRLhImlpL4UPkaw8IdWyUy+egATvWMKKdfT2oAxi w==;
X-CSE-ConnectionGUID: NYsEgQMVS0mxLupIFmhMPw==
X-CSE-MsgGUID: CRyKalqgTaGVqfvvCLtqYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63863653"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; d="scan'208";a="63863653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 01:29:33 -0800
X-CSE-ConnectionGUID: mz2ehx40R0KbrphzjeIARg==
X-CSE-MsgGUID: sS/adAwvS5yDX+Eh0EEpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; d="scan'208";a="188716102"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 01:29:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:29:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 01:29:32 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 01:29:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSp9wuoVSdHlPM/hMZK1gS7t6PhbAR0kL5elvhZxDP1BnGSvpfxWC9gPQVlCoEkPSn3A56ekHYS+i8sHtdXx1ris+UQo9ApeBrgfKWu0DjoJQz52Z6f6rLztx3Gm26B5W0vIPogS/QeUljftS+7SuyComO5E5auysL2cmmzGKE9AgbK6xr6GkN7z7WIOPO0S0ar0Ci6KUtCWeypINYScKF42C458VZ107goh9GPXDQ31DBkrPuIepq9pUf9pbxOMhM/4y5LEhG6QAjX9LnqKIBWymd6Tf8z+R/JuaNeCADoOwwJNo9FpYqpdAWTECXcBJWe11RQdMXBLfj4x7yWVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3YlN9wV7j12doDWaK7GXHRgEIYb3Xk5RcV7yzSjbgs=;
 b=kAW67dtM/Uyu9sn2Ar/O8muvaWb/YpKnKZcCk4EWuptBrCX1MbYD3jxx8OWhCSd2RFiUuX7rNrOpI5Yv7e+Ic2/4orPBlxGwtLuJ2TP1101nZglkVew1A+BjwGbjymT10TC5QdQtvVb1Mph2JBkmAtZJiXcYOu28TjRLt3G9AgB7fGkcx33Y+SVKhYf4HfTGSPfm0xQmB4b8t7tkXg0oLVVzkZJtR355+g9A64FZuzlX3JwTfmAXNH/heN9D3dgw99u0Zc6FpK3Lo0+r5y+mRVJK2J+PfE1w9dST2tDeGNh0eYfNJDBjYSw8IC2ZHe7xaZsTwLjREs2p1GoYm1trIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::806) by PH7PR11MB6428.namprd11.prod.outlook.com
 (2603:10b6:510:1f4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:29:30 +0000
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051]) by SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:29:30 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: DPDK release candidate 25.11-rc1
Thread-Topic: DPDK release candidate 25.11-rc1
Thread-Index: AQHcRPT4KTq62+njxUGbmXTShtJ0uLTm/G7g
Date: Fri, 7 Nov 2025 09:29:30 +0000
Message-ID: <SJ5PPF04AA7285F1DE39B96DA27ADDE2AB59FC3A@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
References: <24022415.5W6oEpyPa8@thomas>
In-Reply-To: <24022415.5W6oEpyPa8@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF04AA7285F:EE_|PH7PR11MB6428:EE_
x-ms-office365-filtering-correlation-id: d0e540e1-69f5-459c-74d4-08de1de02753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dGZaUytUb0ZIZm1naXd2U3pRQkFqeis4aVc5Y1EycS9mWWxmazhuWEsvZHVW?=
 =?utf-8?B?bENwM3VWa3hlaCtXUTlabjN0QXJRVlIrMmgwSlBsN0g5cGV0UVpzSVBqYWlw?=
 =?utf-8?B?cDJSTldyL0VMR0ppUVd4aEhNTXczZGJmVHM4ZS9UeTVOb3dMZFU1TFFJdW4z?=
 =?utf-8?B?WEg4TndRaW1MQ0NXQXFkUDlkV3J5cEEyeWFVb3FBYXR1SjVUa0dxUU1LeXRG?=
 =?utf-8?B?LzdhYnJHNnV1RU85WmtHSjFiTUFLS0pQU20rYzJrZ29yclR6YWN0blRUTW9n?=
 =?utf-8?B?a2gxQjBjTnhKbllUSExjMTQ1VlRBKzJQcm1PUDBvL1NxdFJTakRrTWJEbnlq?=
 =?utf-8?B?RXJQVExrcTdycjFZWWRoaU01UWQ1SkJKSGFwakk1SnkyWnNzYjE0eWUwTEll?=
 =?utf-8?B?QUFaRStLSVdkQ0tFZE5nZnMrSTk3U3J4OHFOakFGU04yQ2xaVzdsbCsxbDlu?=
 =?utf-8?B?T0ZVanBxVnBRU1VlelVKWTFzdzRCbG1HTmtHd0RtZkRxem91b2VmWktKTm91?=
 =?utf-8?B?cjYwbzdXbHZIclcxazZHS0lZbFdHMTFTVlZHV1kvUlFXOTJ5SHZHZUNMRUZC?=
 =?utf-8?B?cUVZU3hSQm1Lbmc5VDVLZkhlYk8zaXVhY211YWszR0ZJYkVTKzA4akRWeVFO?=
 =?utf-8?B?Z2pNRENLTXZrOGVTQ3VYR1o5cStLZ3QwcVB6ZFlVUlFpV01vc0VCQkZ0ZGlp?=
 =?utf-8?B?MFFBSk5IcTh1TCt3a0F3M2p2K0YrUjNzRnplKzRNZG55YnlYZUVhcUtyTXRM?=
 =?utf-8?B?cFFzckJwc3BVa2pQZkk5WEZlVWptZDQrRTZIU0xibzVVaDhZZW5hK0J3WjRr?=
 =?utf-8?B?TlZMSjhlVm13RXpJSXZqRWxOc05pVFRoU3dyeG9lMTB6c0NSOExFRE91TE9L?=
 =?utf-8?B?SHZsQnJVSGt0bno4SFZXRGpFR05pWXVwT0d6eW9SWE5LazZ3MXZjT090WWxz?=
 =?utf-8?B?bkpWYTR0M1Vvb0cySGxmSlc4bVNTQ0tNaDQ3VDM0K3NkYUozMVVKVmcvbkpa?=
 =?utf-8?B?TEJvamRObkY3L1VDRy9QYVJWWVNQNmpucy9sTjV6L1NTM0RQNytPMVNpVDZ6?=
 =?utf-8?B?RTNDRFpHdzI2MzVOcWtDaWhZY3F4TTRjZ0JDZjU5cmFKRjVGRGthK0ExcWlu?=
 =?utf-8?B?cG1aN29Tb3dUVldTUWNMaVFIQkZZK2dPVzNFN3ltMGpjbGtnTm5KT0MyaHdR?=
 =?utf-8?B?enhGMUhJQXR6WVp2dlFGb3NKTldDUTZYWTZzU3BoVUJYWWFGdTB4bjZvSGVr?=
 =?utf-8?B?Y0RNMDUvVVlMVHlsOUVMdFhGU1M4R3BiVXJxb0d2eWE3STRVNXVCd0pKclcy?=
 =?utf-8?B?N082eDZYWXBNYWhMbVFQTzBvakQ1ejdwZkw3R3FZd29iYUp2MXQwcTJ5UXhj?=
 =?utf-8?B?SlRjbTdNajV3QUJ2ZW1VTHVVdGRyZkJ2MC9yZGlDeDZMNnlSWVZGNjltNDJu?=
 =?utf-8?B?RUU2aFpqZFJjdGFPL3IweUhKS3VPSjluSXJxKytXOVJMck5xR1Y0RFVWbC93?=
 =?utf-8?B?Mmd1cnFxWEJpWFVWbGdadzY5WGltdUE1UkRET3VVYVA0WmxxQTRtbHdSbWlG?=
 =?utf-8?B?MnFlMyt4V3lSWWcwaVViN1lLdXdyK2gvcTVOKyt1Y2hzT2V2aHQ2V3dtREZW?=
 =?utf-8?B?aGlQT1F6aVZ0VnRtd1lWZGRNZ0JKRlVBMkJsSGJyUXRYejdXdTQwamRWM3ZY?=
 =?utf-8?B?czdvSXRSL3RyUWJFbE1GR1AwV21LZUlPdUlHT2REYURRTkJIc0gwUi81VlN0?=
 =?utf-8?B?bmZCenQ0RzV6Ti9Ub1ZWVlNLMi9LKzN0cmNSOVcrQWRlN0thRkRzdHhSa292?=
 =?utf-8?B?NFp6b3I1eFlRaHlZMjRNOS91UzY0TmhIUXpmN0FHOXBrWGVpZG1EUkw0bmRU?=
 =?utf-8?B?MG1vSXRrU1g2TE5HNzQzeE1obHpycGcxcklmMk4rSG8vVkVlUktudlJib2Z5?=
 =?utf-8?B?Q0tWOXdRNlhCSG9oUkNiMVFYZmpLb1JCYVN2TUlPTkNwNU1nZ2lDRWJmRCti?=
 =?utf-8?Q?GILRomqlSmGXTny03U7gy7LLuUxlok=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF04AA7285F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXkvQmtMNTdpWFRRL3JDNzVEdVV1ZXM1ZDZyTG1nVDBQaEZaTUZrMFp6M1FI?=
 =?utf-8?B?bC9xdmhIVy9YdHVuYmxER2Zydk93dk8zODhXZkd5TytTSlRYRU9WQWFRTXBZ?=
 =?utf-8?B?T1YrYXZydVVqWlJ4OU9OdmJWZGpwY1JiNXkxclFiRWFNaWZMeGVzTXFzL2ln?=
 =?utf-8?B?VThja3NnOHZtQ3ZvSEs2dlJJUUhWQnM2ZVZwY2prMi84Ly9qUFp4cVFrb1Fr?=
 =?utf-8?B?Rmo2Y0xCNGRxT1NVUEg2Q1QyazNvME5PRFd2WWFQdnFDRkxhYlBHM25pc0JV?=
 =?utf-8?B?TEkyRlhIa2NaZ3h5a3ZmcmRnNXRnOTduQ3JhUjBLR0VJSmtGa0ZJbkhPTklT?=
 =?utf-8?B?NjJXbmpOL2x1NDI5aGRTRkppL0hjbDhUdGVPd1lmbnBqZFVncmMzcW0xSUQ4?=
 =?utf-8?B?bEdoRTQxWGx4NnUzaFVlVEVuUXNJckNXaE05aFlyZjB1Ym80enA3YS8rdkxq?=
 =?utf-8?B?b1N3cE9aT1BhMFBSREM1S3UyNUoyTU5PYy8vSGtyVGQ2R2VtdGliUnBWc1FF?=
 =?utf-8?B?Y24zSFAxeG5lSHU4RXRGRXJyenhZZk9HWmhsZFN2YzdxMGZqRGY4d1IwVStW?=
 =?utf-8?B?YUYvZGo0eUI4c1UvOGJyOUpBUTJtYzJtQzVaaVV4elduTnBzNzM5UnRtaUdh?=
 =?utf-8?B?NnlqQjI1MzVBZXVqcGlZTHRLRXZPNGlBaGJ2eDROclIvd3RxdmQ2QlFvRjNY?=
 =?utf-8?B?Z2cyOE4rU0UwV1ZhbXo3RGhac1QyTjVzL0ZIcCtYbVowWlJ1ajk3a25VWDJv?=
 =?utf-8?B?N1VmeWVLSk10aGNVeTNiejFnc1lkNkFONnd0aERuTWs1OVRodXpqSjB6WXkv?=
 =?utf-8?B?VVREaWJTSGJSdE8yUG92VlNMRjZXek8ycUE5NGtUYTJYY1UyUVhBd2VybVI5?=
 =?utf-8?B?YmlRZUtpNjF3YU1DV09FQTJjMDlZd0pPUlQ2NExqY3NvN1UxMWVaVVoyQzVV?=
 =?utf-8?B?V3VwQkxJSjg2QlB4REU4OUJHUFFpbFk0QVNKbm8yTlp2YVhYRFJjQTc5K0d5?=
 =?utf-8?B?eGNzVmVISTcwVDNueEtVZE9WQXQ3OVg1ZnF0MGpWVVdOSzdWa1phaXVETXcy?=
 =?utf-8?B?WWZmV2FHbTNMNVNwT3VianZPV1VqU1ZvSlZPMSt0Y2tEUGVFSHhGY2doUEp4?=
 =?utf-8?B?UnpSRFRJR3lQU1hVcXMwdTcvNzNhVE1GUXI1NzR2NW9YOWZwYXpGdnFqR2xV?=
 =?utf-8?B?ZnJZd2EwclFPVEhwbVNUU05lT0toQ3k4N3REUG9pYStrYlZsV21zVTBrOXpK?=
 =?utf-8?B?SEpNOXk1aHRhdk95aWdYeXplL05VdElXTDBCQStycFVmMDRvMXdCL0xRL3RD?=
 =?utf-8?B?VzlsdUtJS1Z2SDJsd25IZjAzTlpyRmRJbzMzbDBxeDRweVMwMCtyNCtHYWVa?=
 =?utf-8?B?dGx4L3VNQk84SExMOU9SK3h4M0lIRkU1TmxlcXhCQ1FERTNNU2wzYXhXMThj?=
 =?utf-8?B?Z0JpVUJ6N1F2UkxBNHQ3M3l0VnozN3lUbjlLRHBIMTg2NnZkN2lKQWVwdWw2?=
 =?utf-8?B?cVArWHhPZXRVQ3p0SHkrcjM3THBoQkl5M1I1cVRYbEhpVUlNakpLelVmRCtG?=
 =?utf-8?B?QlJ1OWlMMHBrQ1FTd3RFczZYbGZ6cFFWL09YQkcwM3BKSHlpTXhvU3JpSVVU?=
 =?utf-8?B?TnJ5V2NnZ0pzNGpKbGlLeHNJY1YyN2c3dXA3UzBKbUF6TG43bzVVRzVnTVIx?=
 =?utf-8?B?Sk5kZjFSSUFMREgxZU1LYk5KU3hNelNNWUxMemFLZVN3NjVFVk1mTXZPenNv?=
 =?utf-8?B?TnJTTUFUVkxVRi9oRElOcU1qbytpakhPMFQxUHNweFFVQWF6ZGxjVmtKTnQ3?=
 =?utf-8?B?NFFzYURLL0F1MkpwaFNPRGlqTWxDS2VCK09SQ0VQc09EZ0xycHo2eXVFZWZM?=
 =?utf-8?B?V2tUclNaVCtPUE5iUHRpaHdCWUlhQjFMMmhKUVFUeGtKUTk1b0NESnBJVHla?=
 =?utf-8?B?MUNnOUlUTUdUVUlxcDdldmtwQVZtV3AySU4za0lDUlF1VUw2dUVlRmRjcFlI?=
 =?utf-8?B?OGdxLzNVc1pXcnl4OE1qb050Tm5DVFBpckZPamMwekhvQ2NVWUczWlk5NVhi?=
 =?utf-8?B?UVBGVVd3NHNTZS9tUVB2K0x6OVdCZ0tCOG4zRjRZN1Q0ME10RXR3VW80UTNW?=
 =?utf-8?Q?PXYnW16WHg5ygJMQERJkJRvCS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF04AA7285F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e540e1-69f5-459c-74d4-08de1de02753
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 09:29:30.2326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByCteHajDG4gaTQYD0kcG/TwCh4L3dfq+8vE7TxHOQxV6a9nq6EuRVwmWoRrtCQAYrWpdjdiJT5h3zBiXv1j3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNCwgMjAyNSAxMDo0
NiBQTQ0KPiBUbzogYW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNlIGNh
bmRpZGF0ZSAyNS4xMS1yYzENCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMg
cmVhZHkgZm9yIHRlc3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/aWQ9
djI1LjExLXJjMQ0KPiANCj4gVGhlcmUgYXJlIDYzNCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBz
aG90Lg0KPiANCj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRl
cy9yZWxfbm90ZXMvcmVsZWFzZV8yNV8xMS5odG1sDQo+IA0KPiBIaWdobGlnaHRzIG9mIDI1LjEx
LXJjMToNCj4gCS0gRUFMIG9wdGlvbiB0byByZW1hcCBsY29yZSBJRHMNCj4gCS0gaW50ZXItZG9t
YWluIERNQQ0KPiAJLSBtYnVmIG9wdGltaXphdGlvbnMNCj4gCS0gbWJ1ZiB0cmFja2luZyBmb3Ig
ZGVidWcNCj4gCS0gY3J5cHRvZGV2IFBRQyBNTCBhbGdvcml0aG1zDQo+IAktIGV0aGRldiBsaW5r
IGNvbm5lY3RvciBpbmZvDQo+IAktIEh1YXdlaSBTUHggaGluaWMzIGV0aGVybmV0IGRyaXZlcg0K
PiAJLSBOZWJ1bGFtYXRyaXggbmJsIGV0aGVybmV0IGRyaXZlcg0KPiAJLSBOWFAgRU5FVEM0IGV0
aGVybmV0IGRyaXZlcg0KPiAJLSBXYW5neHVuIEFtYmVyLUxpdGUgdHhnYmUgZXRoZXJuZXQgZHJp
dmVyDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBidWdzLmRwZGsub3Jn
Lg0KPiANCj4gVGhpcyAtcmMxIHdhcyBzdXBwb3NlZCB0byBiZSByZWxlYXNlZCAxOCBkYXlzIGFn
bywgc28gd2UgYXJlIGxhdGUgaW4gdGhlDQo+IHNjaGVkdWxlLCBzb3JyeSBhYm91dCB0aGF0Lg0K
PiBXZSBzaG91bGQgdHJ5IHRvIGNsb3NlIC1yYzIgZHVyaW5nIHRoZSBmaXJzdCB3ZWVrIG9mIE5v
dmVtYmVyLg0KPiBJdCBtZWFucyB3ZSBoYXZlIGxlc3MgdGhhbiAyIHdlZWtzIHJlbWFpbmluZyBm
b3IgYWRkaW5nIG5ldyBmZWF0dXJlcyBpbiB0aGUNCj4gZHJpdmVycy4NCj4gQWRkaW5nIGZlYXR1
cmVzIGluIGxpYnJhcmllcyBhZnRlciAtcmMxIHdvdWxkIGJlIGFuIGV4Y2VwdGlvbiwgYnV0IGl0
IGlzIHBvc3NpYmxlLg0KPiANCj4gVGhhbmsgeW91IGV2ZXJ5b25lDQo+IA0KVXBkYXRlIHRoZSB0
ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazI1LjExLXJjMSBhbGwgdmFsaWRhdGlvbiB0
ZXN0IGRvbmUuIGZvdW5kIDggbmV3IGlzc3Vlcy4NCg0KTmV3IGlzc3VlczoNCiAgMS4gdnhsYW4v
dnhsYW5faXB2Nl9jaGVja3N1bV9vZmZsb2FkOiBnZXQgaW5jb3JyZWN0IGNoZWNrc3VtIHZhbHVl
IGZvciB0aGUgaW5uZXIgTDQgICAgICAgIC0+IGhhcyBmaXggcGF0Y2gNCiAgMi4gY3BmbF92Zl9y
ZXByZXNlbnRvcl9ydGVfZmxvdy9wb3J0X3JlcHJlc2VudG9yX3Byb2JlX3NjYW46IHBvcnQgYXR0
YWNoIGZhaWxlZCAgICAgICAgICAgICAgLT4gaGFzIGZpeCBwYXRjaA0KICAzLiBbaWNlXWtlcm5l
bHBmX2lhdmY6dGVzdF9pYXZmX2R1YWxfdmxhbl9pbnNlcnQ6IHJlY2VpdmVkIHBhY2tldCBvdXRl
ciB2bGFuIGlzIGluY29ycmVjdCAgICAgLT4gaGFzIGZpeCBwYXRjaA0KICA0LiB2aXJ0aW9fdW5p
dF9jcnlwdG9kZXZfZnVuYy90ZXN0X2NyeXB0b2Rldl92aXJ0aW9fYXV0b3Rlc3Q6IHRlc3QgZmFp
bGVkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPiBJbnRlbCBkZXYgaXMgdW5kZXIgaW52
ZXN0aWdhdGluZw0KICA1LiBbQ3J5cHRvXVtRQVQgaW50cmVlXWNyeXB0b19wZXJmX2NyeXB0b2Rl
dl9wZXJmOiBkcGRrLXRlc3QtY3J5cHRvLXBlcmYgaXMgdW5hYmxlIHRvIGdldCBtYXhfbmJfcXVl
dWVfcGFpcnMgcmVnYXJkbGVzcyBvZiBjcnlwdG9fc2NoZWR1bGVyIGFyZ3VtZW50ICAgICAtPiBJ
bnRlbCBkZXYgaXMgdW5kZXIgaW52ZXN0aWdhdGluZw0KICA2LiBzZXR0aW5nIERDQiBvbiB0aGUg
aTQwZSBuaWMgY2F1c2VzIHRlc3RwbWQgdG8gY29yZSBkdW1wICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtPiBJbnRlbCBkZXYgaXMgdW5kZXIgaW52ZXN0aWdhdGluZw0KICA3LiB0
aGUgbmljIGlzIHN0aWxsIHNlbmRpbmcgcGF1c2UgZnJhbWVzIHdoZW4gdGhlIHRyYWZmaWMgc3Rv
cHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gSW50ZWwgZGV2IGlzIHVuZGVy
IGludmVzdGlnYXRpbmcNCiAgOC4gQnVnIDE3OTUgLSBjaGVja3N1bV9vZmZsb2FkL2RvX25vdF9p
bnNlcnRfY2hlY2tzdW1fb25fdGhlX3RyYW5zbWl0X3BhY2tldDogY29yZSBkdW1wZWQgb2NjdXJy
ZWQgd2hlbiBzZW5kIHBhY2tldHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtPiBJbnRlbCBkZXYgaXMgdW5kZXIgaW52ZXN0aWdhdGluZw0KDQoqIEJ1
aWxkICYgQ0ZMQUcgY29tcGlsZTogY292ZXIgdGhlIGJ1aWxkIHRlc3Qgd2l0aCBsYXRlc3QgR0ND
L0NsYW5nIHZlcnNpb24gb24gdGhlIGZvbGxvd2luZyBPUyhhbGwgcGFzc2VkKQ0KICAtIFVidW50
dTI1LjA0L1VidW50dTI0LjA0LjMNCiAgLSBSSEVMOS42L1JIRUwxMA0KICAtIEZlZG9yYTQyDQog
IC0gRnJlZUJTRDE0LjMNCiAgLSBTVVNFMTUuNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0gT3Bl
bkV1bGVyMjQuMDQNCiAgLSBBenVyZUxpbnV4My4wDQoNCiogRnVuY3Rpb24gdGVzdHM6IEFsbCB0
ZXN0IGRvbmUgYW5kIGZvdW5kIDggaXNzdWVzLg0KICAtIElDRS0oRTgxMCwgRTgyNSwgRTgzMCwg
RTIxMDApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNP
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTL1N3
aXRjaC9QYWNrYWdlIE1hbmFnZW1lbnQvRmxvdyBEaXJlY3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNl
ZCBSU1MvQUNML0RDRi9GbGV4aWJsZSBEZXNjcmlwdG9yLCBldGMuDQogIC0gaTQwRS0oWFhWNzEw
LCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RT
Ty9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywg
ZXRjLiANCiAgLSBJWEdCRS0oRTYxMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBi
YXNpYy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExB
Ti9SU1MsIGV0Yy4gDQogIC0gSUdDLShpMjI2KSBQRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5n
IGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRl
ci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0KICAtIElHQi0oaTM1MCkgUEY6IHRlc3Qgc2NlbmFyaW9z
IGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2Fk
L21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2VuYXJp
b3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFB
VCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQgcGVy
Zm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNrL3Zp
cnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUg
RVNYSSA5LjAsIGV0Yy4NCiAgLSBDcnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBD
cnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRlc3Rp
bmcvRklQUywgZXRjLg0KICAtIERMQjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIERMQjIuMCBh
bmQgRExCMi41DQogIC0gT3RoZXI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBBRl9YRFAsIFBv
d2VyLCBDQkRNQSwgRFNBDQoNCiogUGVyZm9ybWFuY2UgdGVzdDogQWxsIHRlc3QgZG9uZSBhbmQg
cGFzc2VkDQogIC0gVGhvdWdocHV0IFBlcmZvcm1hbmNlDQogIC0gQ3J5cHRvZGV2IExhdGVuY3kN
CiAgLSBQRi9WRiBOSUMgc2luZ2xlIGNvcmUNCiAgLSBYWFY3MTAvRTgxMC9FMjEwMCBOSUMgUGVy
Zm9ybWFuY2UNCg0KDQpSZWdhcmRzLA0KWHUsIEhhaWxpbg0K
