Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21A6EB48EB
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 09:43:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9D624027A;
	Thu, 12 Feb 2026 10:43:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7276040268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 10:43:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770889405; x=1802425405;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=QAn8WUMm7cdteGYIzIZ+/IbSNj3v/hdCmUurL3NxDxI=;
 b=PCQh+nz6k3850Bu+mQgXUsgO56hqFPGqMnRiY1b4QBx7C0dlSxWyc+rj
 nzVmTvwNKTHO+lTTCwdPWTdQvoXzVAPzX4Kl9g0o4jdoFIwJG01JnFa/v
 lUNSBqTiM9EbY3rAW7plcZ+k1wmUXgQv+F9Ii1J/cdUrCjsh4cUwOf+sP
 vamy9Fdy3xSYMJhbYcw3qOWqki9qvZgrq8E0Z2GFCTFJDuy+tRiGk30Sq
 xYidgTxdRf6yZeklrL5Z8/g9J3uFHduUWGCORdU8nqmK9NoHsbhScaRHF
 S55GoHidTqnqQSBAXN589pgA7RammdaJVilJbe52ZMsB0jM5vgGgGsVV6 w==;
X-CSE-ConnectionGUID: sdJT9xbHQCGEpCuZGdTWVQ==
X-CSE-MsgGUID: DGPkHqiJRa6lqX5iMZPC3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72241816"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="72241816"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 01:42:46 -0800
X-CSE-ConnectionGUID: 2JjhPZxcQa6fvIF5JI331g==
X-CSE-MsgGUID: PiRMVqPFTmSOvTdQA6t1Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211379641"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 01:42:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 01:42:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 01:42:45 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.14)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 01:42:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFio5T4l0gEkSIytuVOljLfmfT+nKFVyZrfbbMtmH2jRDoedhTFts4a1CdkK/pMuOeGUySRPdpTXgMb07T3RJuT7I32IO3Fo5lPCqCSM/0AVn6ohHndX09bNzkTid8/nO36ISke5D+Zch+Djx1YrnzZmxh4GMy8uHxjR+aOt0Q49iVhrUpv85pnp7psSd4FrcGVCiukHc644BH5ZsUHxQswtvQiU0L80X9Q+WHKs/PHGErX8AYYLVdHzfqoEXTR8U9jtReQ3E4Jjs2YL+xt0o/oOP6XddnrzInTdNdYQRY28FHSG/O+5Q0kzvhZLqWMb0q6iKVq7MMrbQmjcgDRXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXSSPe8Al8vJWyZrVYfkOmNPPhBTQLgokBFJ31WFaFw=;
 b=L/uTmSBJidwQdG7bq1Q5/owvfHTHlpvuJ7UD3BIN62Vk7pI8szIYEnxlh26xOFxJiX3gRusofE9JC0zteRnc1ipM08bXfEaAzR3HIAbt37q8tUXIccfKK+UlOCw/NHOJyZ4T5f1XPmLNxduxRndslxVE0zmfsE3I0Hb19oQvIxrXrsdbqNAZeohMTsRzB5GIBsJ5ah5F+V4gxa8gDBWFWfXBwh0zONCGvKSKDYj1iCgC69eHYd/jMNB1oDB/+8g2mrWR6N5CCNnFWN/VsRnPkyACyltWnOAi1WNoTouy/1Y5xT7uqaE0GWs6Tcx9UHPFMrUmiENsngFeLHdeCz9gBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4812.namprd11.prod.outlook.com (2603:10b6:806:f8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Thu, 12 Feb 2026 09:42:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:42:42 +0000
Message-ID: <07f4657c-7e62-4931-9b35-8f86852898ae@intel.com>
Date: Thu, 12 Feb 2026 10:42:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] net/ixgbe: split security and ntuple filters
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <1d6d12f5387fb70df51a4a9bc38abced0e915548.1770817884.git.anatoly.burakov@intel.com>
 <a98fea87-6860-412f-a7d1-e49a10f484df@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <a98fea87-6860-412f-a7d1-e49a10f484df@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f853bc-335c-4dc9-8841-08de6a1b1141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUowQ2hCcWNsYTFicVFLdXQ4UWhqVnoxajN4Y0VpSThFNDE1L3pxb0VZb3F4?=
 =?utf-8?B?T25GeXVjMHNlNlIvVjJzT3lkaFNXOFNUb1h2TkFPb2RrUHdxQVFYMnhBUTNW?=
 =?utf-8?B?SU15NHhxcVo5S0tkOVJ5ampCSHhrZ0t1ZWxWenFKK3NsUE5QR2hNZFFtbEJk?=
 =?utf-8?B?eGgxOVUrVjBXdGZSb1FhZkNyeHhpTyt6eVBpdFUyZi8ydy9uVm00NFdVVGcz?=
 =?utf-8?B?MndKNjgxaDgvTjMvbGJvK01uWmN3UW42WU82eWJ6dHArOHFidHpZdnRTQitE?=
 =?utf-8?B?cDNXNEhoRjk1QXJ2ek1HMG42T3dJSU40U2lWWHl1Mk8rdFExQmFpUERkWmZI?=
 =?utf-8?B?RFE4TjBaTGZWR21qbFFwVHZQKzBFa3VvOTlaSStHQmxVM3pBSnY5dXNiVmd5?=
 =?utf-8?B?NlhkY01FVzNnRDdodWpLd0p4cXkyZWJHNE1WUHRzbmxHOHF5U1p2djFsUm0w?=
 =?utf-8?B?TURtN3JONEdvaUhkY29wcXJWK3lSUG9ZWTIrNHkxL0VSME9DUnltbEQ0cTdL?=
 =?utf-8?B?VzhCbklyeHNSSWRhN3BoYmdBV1BibDF3R3FOcjk1ZXNDYWRObm5iSzd0aVRM?=
 =?utf-8?B?ZmdBVlZCVHdpTXJxTEVnOEcxbXQ2T0M4ekt1UnQ2bysxN3JTUGRLaWUvUVVk?=
 =?utf-8?B?WlhMZ1lyQW9SdmxYMWNKRTVvMnhMc3FLZXdYVnJZdTUrU1Q3dmVtY2RZb3Uw?=
 =?utf-8?B?QzZ0QU5oNnd6WjJlU28zMXVLUnRtVW9aREk0UzBUeGpKdFNidnh2dHlIeWJC?=
 =?utf-8?B?UmwvNkVXZFVsOTJaQTFoSE9mTWdXeSswU2c0VVNGblIzZjE2V05WMDN6L2RB?=
 =?utf-8?B?RldZQkM4b3hIMjByT0kzdDF2dXVxUnREbHB0NlFibUYwSXJVRkgxN0IzR29B?=
 =?utf-8?B?R1FxZkIyRkdQOC83Wm9CVnZkc3NzUmFyS2lCaXdQeUNIZi92NklvTHpKZUlq?=
 =?utf-8?B?QVZHeXM2d25vRjdZQ3BUd2N5RkxvZXJyOHVtV2JWQkp6TW5OMC81S1hBVThZ?=
 =?utf-8?B?Z3UwOTdFNkpiN0pQWnI5R3pESjdKRm9KNE43aXBKbFFZZytZQU5lZ3kzNnlk?=
 =?utf-8?B?WlNTL0FrTWZQMTNTOTR3VStTZFdjYTVLbllBRGFKRlNyRThVK1hFSHBZaXF2?=
 =?utf-8?B?QzRGdkZndStNMTJEdzdxTDRyZXFKaW4rVTZ1TDFkTjJnZkNqcGRIamI0ek0v?=
 =?utf-8?B?emtRRFhaeUJpcVMxQU5jRnk5RHp3ZjBDN01CUXZ1Mk0yOTMwMUQ5b0hIUWVm?=
 =?utf-8?B?aW9lR2JlRTdpM3dVRjEwbGRILzEzRGRRMnhNWm1XbEV2ODBxQk8rVVVCMmdm?=
 =?utf-8?B?enhoL1ZPRENaSXpLV2dVSWl1SHVPYVQ1MVM1TFFLSUFiUTlsdTRFZUVxRW1I?=
 =?utf-8?B?aElHMFY1eFd3M1FWMDVJWlUxdkVKd0V5VlRBYk8yTThDcWgyeElTM3loL0dB?=
 =?utf-8?B?ZDJZNFFoeGU0WmxML3lSalNNQmxvdThTeW1tV2dQTm9MWGFmWlI2YStQUXIy?=
 =?utf-8?B?S3h2UmhuVlpjYktYQkRGemJxNE5BRDljb1dpMjE1dEo4UVp4eWtVSXQybU1Y?=
 =?utf-8?B?TmhldTc3Zmwxd2xQeXZ2bjVibUJ2SFRUTnBOaXQ5VWszbks4S0hwRElGbXl0?=
 =?utf-8?B?a1pPMU13bXJ0UVNKdGkxckhnbXRVWWttSVZlM2lVQ3U4ZTUxUDNBb3NVb0tU?=
 =?utf-8?B?a1BvSnlhWm4yUmZpNkN2WXhGQ25uZVpDY0VZR3g0dnhpeUhYSmtmSjFYdVFX?=
 =?utf-8?B?MHFrYStyaUxjS1J2NVBNbG4rTk5aTm51cnF0cHp4NnFFODdkRm9tcE4zcm5V?=
 =?utf-8?B?TjRTTUdWY3FwelFmNG9sNnUyMlhEYXQ4WFcxTkphUWNMQnZSMVpqZU9kWEFG?=
 =?utf-8?B?cml3QnNvcmF1a3dqKzJpYk81Tll0SkdiNjR4MHk5SHNhUjkvVmtiMHdXL1lT?=
 =?utf-8?B?UHhYbVV0dU9QK2RWZHJuR1ZWN2lqK1loblhxSDFoQkU3Q05SampQNWV5ZllT?=
 =?utf-8?B?eVd0UlFCeDUvSEd2SzFJTnZCcFJScUZtQzJqUmJQSjE3cWRCdEsvWDVmQndP?=
 =?utf-8?B?OXdMVXpnZWpOODFwUmFVdDR0OXBpT0hPWGxnQUZZWDNOaFlwSjlOOXdrRUdu?=
 =?utf-8?Q?NtPs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pqdE5OSmVmekhVL3RvaTBpTHcvaGM5ekw0S05WdjZPRUp2L3VQUDY3ektw?=
 =?utf-8?B?RndvRDlMYUtFVzdkNTQyN3I3bnMvVXI2SGs4UXNBdEw3YlBIWStPNnYwTGV3?=
 =?utf-8?B?bVdGMytmMWF6VlRldTV0Nzk5S2d4c1pDZ1JJcHN2Y1grV3lPS0drZG40elFU?=
 =?utf-8?B?N1NYajlHOGhKZ2F1amlGdWZEQTF4d3lOY3hTVTdZMjRpNDdYblBaVWdzVzZ5?=
 =?utf-8?B?NktXRHpIYTg1Z1hkOGpFcVphL0FpR1g5dm5hVnhrTk9zZ3hiOFkxaWJwVnVC?=
 =?utf-8?B?dDY4NTRnSjJQSHlTWkRSeXhyT3dzNVJFMlVkcjNZc2FRZ3kxMUpCRTd4MGd4?=
 =?utf-8?B?Tk9yME4yb2lueDhYcDNOa044MnVIV2xHVkh3WE10ejZkU29wUnVOVGQyV1pU?=
 =?utf-8?B?UHJ1Ri9zWkdsQjE0b2VUK3o3d3hvTW9ITGxwaGRKUnh1YWZ3SW1wNWY3bmxH?=
 =?utf-8?B?cTJzNm1HbzJhWVNISnh1YThMTjN2dEJZVkFCZmdIVHVFVHk2Sk5CZldXKzJt?=
 =?utf-8?B?dm02RzRkOHg2Y0xPbllDYUR1alJxdmMvOFEzMTdwWFU4anRpclRoYnFPWCtu?=
 =?utf-8?B?OGdBUjdZRjBFcmxudlZwZnVaRXo4aThJa2htUi9sZXRBSnJnNlhaWlVKODh4?=
 =?utf-8?B?V1lSUlhXYzRGQXdYbWIyZERCbWdvWkd1SkwxOHY1VGlDS09jUVBOUDdNNUFZ?=
 =?utf-8?B?aGtFNStJQVFlc1p5SHdEMHlKY0h1bHIyYU5SWXdRMzdhZ2pVanlJUzhwR2xB?=
 =?utf-8?B?RWg5NmxidnNic0dVdEhEMkFpSitRY3A5dDNSMXhwazYxcGVjTUVrSDJYZGcw?=
 =?utf-8?B?Rnl0c0R4NXpVT2E0R3hsSHdKZWFaeHVBUCtxQkR1SVZ4bE1iSERIVmNaTnJl?=
 =?utf-8?B?VkJCaVhVVDFkRmVoMzBtNjZOME81ZndDWEg3eko1c0JlLzhoNTM3TFZSZEdz?=
 =?utf-8?B?eTF6Q1NDM21lL1VVekVtL1V0MVlYRXRJN29jWnUySitjSG1keVZFcU5TK2M5?=
 =?utf-8?B?Z2FHV3pLN1FMYW9QTmxaRlJwZk55c0hjUnZuMml0SHF0UWZBRzJRY00wZXlC?=
 =?utf-8?B?alR3SHNVU0dnamxUSlBub20vVEIzQXVBNFUrR3plTkJoL1pEd1piNmt4UC8r?=
 =?utf-8?B?aC9yWkt0ellRT3lCZmw3eCtLc3VYcjdmUjc1Y0FGQW5UcVViSzRrS2d0Q29o?=
 =?utf-8?B?Qi9PblFLdjY1eVc4b0hCYXlMeElvanY2VlhkbWcrMjdta00ySzRtMWRvK2pi?=
 =?utf-8?B?ZkVjNW5vUHNBTStSak05bDhMZ3JzQi9KRUxCSG9zSzY2TWVseFlmZ1JzMWJr?=
 =?utf-8?B?eTU2M1JNUk5pbjRYWWk1dXZsUXY1cjdUeFFqdjFPR0RiczVZYWozNmF4QzhT?=
 =?utf-8?B?QkRqY0dTMFF1YkxjMHBNdFNLS3hxYnFtbFNvUHlqR09rRDZ3R0ZrSEVlNUhE?=
 =?utf-8?B?SEplMlZjeG5TdW16UE5vMGJKRk94dWNab2xhdEpGSXZ4NFFFaXQrWm03dGVB?=
 =?utf-8?B?K3ExS2FXQjJsbTZJekVHRXdKYkpwclg0eWxseWpaVmJIU2xucGhCcG5SdkdD?=
 =?utf-8?B?Mit6ZEVLL2RmYUtHU2RHVldYY1RyRy9GNWlmRzEwdkpRQUIwYXVUejV5ajB5?=
 =?utf-8?B?cDNGTHZNWG5uZGQzU2J3SWE1dEZwNW8vQTNYKzR6QjJiMHNxNU9XYWZWYm5J?=
 =?utf-8?B?QlkwYmtQOUFueXNDWjZUdEM3cnY2bDhpSkVIa0d2OEZISnErVm9wSE0vdlJt?=
 =?utf-8?B?RGlzbzNPdVRLZElDMnBuUmpPL0IvYThFMFVTQVpnY1JxN2VnZ3AyT1IrdThn?=
 =?utf-8?B?NjBNTm41VVV3Y21iOG13SEFCVGhsSnhxc3Z5RU1ra3VCb0xYeGZFSDBVdWhD?=
 =?utf-8?B?djZPUWt2YktLckhkYWxOSkc4TnZmWS9BckUwYThreExna1BBa3hhNVBBOGly?=
 =?utf-8?B?L0dLVzJzcWlwelpmdUtlMndicjVtYUV3bVY4bHhDSko1ZHBJZkh0NjlLcWpu?=
 =?utf-8?B?VkNleTNydEJkRWFPcVgyUE0rK1cwb01tR0dxVUJOMHFnYi9kamw0TFdKRlVx?=
 =?utf-8?B?dHJPTjNBbmJ3c3RBY1RuL2tlR1ZDR252NmhCYWxMZm5GS0JFQVFEZW5qd0xN?=
 =?utf-8?B?ZE94TGZOTzd3ajJaREdCb1ovZlN0YXkvbnhOaU1wMjhZeExTdFFWWm9mMmR4?=
 =?utf-8?B?WTlVd3VqcFJ3OGV4aGZQbkVvTUdMZzgvZll3UTU2aVlYNlJRYkN2ZjlrOHB4?=
 =?utf-8?B?VGdEQnBIMXpuMXB1MkpVZzUxcjB1OHNENCt4bi9vN2xTTkh5M1NBb1Vrb3pE?=
 =?utf-8?B?MHhwTWpCcUJvREFKWVZjNEJpRE5HUndNNW5RT3djUUcyZENrdjFTamIrTUJo?=
 =?utf-8?Q?n1JHUsU/pA8dQA18=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f853bc-335c-4dc9-8841-08de6a1b1141
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 09:42:42.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsPXQDo40WnZqmsFyryTH9+A04NijI0H0BlhFh5jJEU6VQbGDAIAosjSjzIHGzC2dhqWJVONcQ57ELqgp7k+T8UeP6Ifl5tZKhJpPZQ/VUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4812
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

On 2/11/2026 8:25 PM, Medvedkin, Vladimir wrote:
> 
> On 2/11/2026 1:52 PM, Anatoly Burakov wrote:
>> These filters are mashed together even though they almost do not share 
>> any
>> code at all between each other. Separate security filter from ntuple 
>> filter
>> and parse it separately.
>>
>> While we're at it, we're making checks more stringent (such as 
>> checking for
>> NULL conf), and more type safe.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/ixgbe/ixgbe_flow.c | 136 ++++++++++++++++++---------
>>   1 file changed, 91 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ 
>> ixgbe/ixgbe_flow.c
>> index c17c6c4bf6..cd8d46019f 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
>> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
>> @@ -214,41 +214,6 @@ cons_parse_ntuple_filter(const struct 
>> rte_flow_attr *attr,
>>       memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
>>       memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
>> -    /**
>> -     *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
>> -     */
>> -    act = next_no_void_action(actions, NULL);
>> -    if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
>> -        const void *conf = act->conf;
>> -        /* check if the next not void item is END */
>> -        act = next_no_void_action(actions, act);
>> -        if (act->type != RTE_FLOW_ACTION_TYPE_END) {
>> -            memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
>> -            rte_flow_error_set(error, EINVAL,
>> -                RTE_FLOW_ERROR_TYPE_ACTION,
>> -                act, "Not supported action.");
>> -            return -rte_errno;
>> -        }
>> -
>> -        /* get the IP pattern*/
>> -        item = next_no_void_pattern(pattern, NULL);
>> -        while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
>> -                item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
>> -            if (item->last ||
>> -                    item->type == RTE_FLOW_ITEM_TYPE_END) {
>> -                rte_flow_error_set(error, EINVAL,
>> -                    RTE_FLOW_ERROR_TYPE_ITEM,
>> -                    item, "IP pattern missing.");
>> -                return -rte_errno;
>> -            }
>> -            item = next_no_void_pattern(pattern, item);
>> -        }
>> -
>> -        filter->proto = IPPROTO_ESP;
>> -        return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
>> -                    item->type == RTE_FLOW_ITEM_TYPE_IPV6);
>> -    }
>> -
>>       /* the first not void item can be MAC or IPv4 */
>>       item = next_no_void_pattern(pattern, NULL);
>> @@ -607,6 +572,81 @@ cons_parse_ntuple_filter(const struct 
>> rte_flow_attr *attr,
>>       return 0;
>>   }
>> +static int
>> +ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct 
>> rte_flow_attr *attr,
>> +        const struct rte_flow_item pattern[], const struct 
>> rte_flow_action actions[],
>> +        struct rte_flow_error *error)
>> +{
>> +    struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data- 
>> >dev_private);
>> +    const struct rte_flow_action_security *security;
>> +    const struct rte_flow_item *item;
>> +    const struct rte_flow_action *act;
>> +
>> +    if (hw->mac.type != ixgbe_mac_82599EB &&
>> +            hw->mac.type != ixgbe_mac_X540 &&
>> +            hw->mac.type != ixgbe_mac_X550 &&
>> +            hw->mac.type != ixgbe_mac_X550EM_x &&
>> +            hw->mac.type != ixgbe_mac_X550EM_a &&
>> +            hw->mac.type != ixgbe_mac_E610)
>> +        return -ENOTSUP;
>> +
>> +    if (pattern == NULL) {
>> +        rte_flow_error_set(error,
>> +            EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
>> +            NULL, "NULL pattern.");
>> +        return -rte_errno;
>> +    }
>> +    if (actions == NULL) {
>> +        rte_flow_error_set(error, EINVAL,
>> +                   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
>> +                   NULL, "NULL action.");
>> +        return -rte_errno;
>> +    }
>> +    if (attr == NULL) {
>> +        rte_flow_error_set(error, EINVAL,
>> +                   RTE_FLOW_ERROR_TYPE_ATTR,
>> +                   NULL, "NULL attribute.");
>> +        return -rte_errno;
>> +    }
>> +
>> +    /* check if next non-void action is security */
>> +    act = next_no_void_action(actions, NULL);
>> +    if (act->type != RTE_FLOW_ACTION_TYPE_SECURITY) {
>> +        return rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ACTION,
>> +                act, "Not supported action.");
>> +    }
>> +    security = act->conf;
>> +    if (security == NULL) {
> this looks like a bug fix. In a previous implementation it didn't check 
> if act->conf is NULL and  consequent calling for 
> ixgbe_crypto_add_ingress_sa_from_flow() immediately dereference it. 
> Probably it would be great to backport this as a fix.
>> +        return rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ACTION, act,
>> +                "NULL security action config.");
>> +    }
>> +    /* check if the next not void item is END */
>> +    act = next_no_void_action(actions, act);
>> +    if (act->type != RTE_FLOW_ACTION_TYPE_END) {
>> +        return rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ACTION,
>> +                act, "Not supported action.");
>> +    }
>> +
>> +    /* get the IP pattern*/
>> +    item = next_no_void_pattern(pattern, NULL);
>> +    while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
>> +            item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
>> +        if (item->last || item->type == RTE_FLOW_ITEM_TYPE_END) {
>> +            rte_flow_error_set(error, EINVAL,
>> +                RTE_FLOW_ERROR_TYPE_ITEM,
>> +                item, "IP pattern missing.");
>> +            return -rte_errno;
>> +        }
>> +        item = next_no_void_pattern(pattern, item);
>> +    }
>> +
>> +    return ixgbe_crypto_add_ingress_sa_from_flow(security- 
>> >security_session,
> did you mean &security->security_session here?

No, this should be correct.

However, I now suspect the original code was a bug too.

Here's what the original code said:

```
	return ixgbe_crypto_add_ingress_sa_from_flow(conf, ...);
```

The `conf` pointer points to `action->conf`, which in case of 
RTE_FLOW_ACTION_SECURITY translates to `struct rte_flow_action_security` 
structure.

However, the actual function we passed this to was doing this:

```
	struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)((const 
struct rte_security_session *)sess)->driver_priv_data;
```

where `sess` is the `conf`, but it is treated as pointer to 
`rte_security_session` not `rte_flow_action_security`. So, this is 
actually a bug too, and it kinda feels like this never worked because 
this code has been here since the very beginning...

There's also no reason why *any* of this has to work with void pointers 
when this is the only user of this function, so I'll rewrite it and 
include it in the bugfix patchset, so that this patch arrives clean.

>> +            item->spec, item->type == RTE_FLOW_ITEM_TYPE_IPV6);
> probably need to add check if item->spec is NULL

Yes, thanks for pointing that out. Will fix in bugfix patchset as well.

>> +}
>> +
>>   /* a specific function for ixgbe because the flags is specific */
>>   static int
>>   ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
> <snip>
> 


-- 
Thanks,
Anatoly
