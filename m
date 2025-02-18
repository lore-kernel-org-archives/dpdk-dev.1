Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8234C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 04:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D3634014F;
	Tue, 18 Feb 2025 05:44:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F0A0E400EF
 for <dev@dpdk.org>; Tue, 18 Feb 2025 05:44:27 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HNjCd3017906;
 Mon, 17 Feb 2025 20:44:27 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44v4ev1eav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 20:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSdSOw/txVYRwoE/0tSI05IoNGEFVA4/mAkTxpxSFqZ/5XQN/0DH5D4XiZ0Mf+m/izxvwecmwKuWyDqD193kKSBj9+eRTtEymEwp50LDSATKPJ1QycFfYV/5QtSVdCUkYh00oKHn9be2+TaeGOqFbD+zzWh3Glco4FSlXx0zusvATieZmF8En7xgENK2veZcKevUI1irxtcy5CvI4pWgpt4IFQwE1TS/3hDT9nA7WpkS0rkxNFTKhr62CejQbs5H+1Ba9lbSQgaAC3ZY85DwZE+xd+jQRJ/kXiYDxIQXwbuIrkjYlPu19kpzyJMYIagCn51tXT7SSwfCna0grt1TBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71QeskYxh0P/qL3P7aX09wI2sUZ2r/DXrPfLs6w4zBo=;
 b=WF3l8h/Y20LgwoeNmUDpy87q5eid/hAMO7jEfbFYRBNEDuT0IajYZ6ZIgGOvOyBJJNMlLE/0bl0/gIeSKVF4IkyHlojnP1Ok+jPtTo+PocyDa8nv0EMAcq64KdJGsym87BmZq/DGg2y9rt7PfNLL7F+osc1xgIQOoGlJlmfWxd31hr+ohD4UBr4a441h4aWW2eefGmD+g71hkB4MBQdlfV6X6+N/JZTzRueIdZq241NRSlhMiX7TJoRfvT/aa4nEShZlNrpbWbFRJw0ZO6GhO/aSAyO/rpzMhNth1XbklCUz+cxyYxLehIJMh46jEqP0YJC6gJ1zUr9vawySMX32Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71QeskYxh0P/qL3P7aX09wI2sUZ2r/DXrPfLs6w4zBo=;
 b=o4wYCejnU7sjMNFGPv5GlKHErYa1NssT5n0xwF/Gmz6TU1cH6BT3v42wo3J939lCDyz/LOxdHlsD9YhFB72mgSd5VCLwBO+BgfTSiy+4BnZ+ebpHJBZJq6tRV4WIBcf9Y6JMQIey1gEeIKFUFPjiUNUnrAmROY9O6H23QVBP9iM=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by MN2PR18MB3605.namprd18.prod.outlook.com (2603:10b6:208:268::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 04:44:22 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 04:44:22 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 0/3] Rx adapter API to add Rx queues in burst
Thread-Topic: [PATCH 0/3] Rx adapter API to add Rx queues in burst
Thread-Index: AQHbeWn9ZqW77L4/jEqXqzb7uXDDobNLu/kAgADQFQA=
Date: Tue, 18 Feb 2025 04:44:22 +0000
Message-ID: <PH0PR18MB44257A14DEDE067AFF032FADD9FA2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
 <SN7PR11MB70449B905B53E5EBFB474F87A1FB2@SN7PR11MB7044.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB70449B905B53E5EBFB474F87A1FB2@SN7PR11MB7044.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|MN2PR18MB3605:EE_
x-ms-office365-filtering-correlation-id: 03c0bee8-b3ca-48bb-b760-08dd4fd6e9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REpFRHUvV01yblNqcXRtSUlXYmRKaW9YcDFPcTM4M250c1JUNmcwUlMxRkF1?=
 =?utf-8?B?clJFYVpDOVFTa0pELy83NkxUcTY1YnpJdkJsZkZNUzlDcXk5SSs2dXpIMUFU?=
 =?utf-8?B?NUtNd092QmtPdzJoMUJqalUwTWFtVk1xY0lYRlUwNUQ2TktTdG5nbDhaU0Fz?=
 =?utf-8?B?WGdFNnptTlFBamUzNUpFdlh4VEZLVGRHb3pDN3k1b2dISGtxdEhKNXlaMENm?=
 =?utf-8?B?Q3FRMDJWclFBN20vRnpmRzBac1lNL1MwWSt2WHdHQmNyaSttb1NTQ1I2cVBk?=
 =?utf-8?B?WVpOY2hzT3JueEp6WUx0OHYxYk9qNFl2Ukg4VEVpR2RFY0EvOHlrN3VtTUln?=
 =?utf-8?B?NFhHQ3VkSVNQaHdCMzdGZkJoUmdVZ1licE9Cc1JzSlFVUEFoZEZOaUtCNVRq?=
 =?utf-8?B?SUJZR2xzbHZqblRIemtUYTcyb2c4UWppak16UUV4QlRnWXdwK0d1RWlaOTZp?=
 =?utf-8?B?a1NUUGVXaCtBVkZyblVEeW9PNzgveVl5bFVTTXREQXo2dFg4RWxXRFhZUEtj?=
 =?utf-8?B?aWcvYkdtTVJuSHNsa0dEdjNsK1ZBUXZCSmpDMERvNVI2Q3FoNy9aWnozTzUz?=
 =?utf-8?B?emtlakROSDZOVnFCdDRqZzhoS2lVUTBhWEJOTEFqNjF3Z0trYVV0REwxMjdx?=
 =?utf-8?B?NVR6TUR0cnh6TGZOYXBKcU0wMjRoWTRJY0dlTDdiMnF0U1p0dUVGMzgzK0ta?=
 =?utf-8?B?Yk5EZmg3cDJwcC80L3dZMllta2NZMWhmQm55L2xxbDMxcXgwVExrNkRTYkYy?=
 =?utf-8?B?SytnUXVXcmR0SmRaYk81WmFGc2FwMmtwNVZYeEYvbyt6dUkrWWllWmV1blVD?=
 =?utf-8?B?S3ZOM2RMS3M2YnY3V2dIaURQYmdDSTV2L0txWWVkWE9saTczS09ZcTFSaWNE?=
 =?utf-8?B?MEZZdTRwSXdCMitxZVZremp4a0k2bWpOWnpybG1DeHZNRFVzRmg1aXpkZ0lm?=
 =?utf-8?B?UGpxMGdTR3ZqUmR3ZTBvZ3J4RWZ3ajVFcXZ3bkhlMWxlR2tlaFo5TGtkM1Nt?=
 =?utf-8?B?eFVidDl6RFdvNXdWaWh5ZzdmczcrYjE2eWx0UjcxQUowbzhVZlViZkVDRTA5?=
 =?utf-8?B?NkhwTmVkeXhUM0dnSkpwYmpVY2FIN3VtZzFRT21JL0dIOVQyZ0dsOGY1U0sv?=
 =?utf-8?B?YndDZW5nZGlhUXp5QzBtNGlYU0xFV0FPaVZjMkh0SSs1c0E5T1hUdW9zTjBm?=
 =?utf-8?B?MGFMQU5uQTJRb2Zhazlwb0dzQzJSSEFMNVdtaEVnTXBFb2s3K1dqTmJxaXNB?=
 =?utf-8?B?dmJtRDM1T1pLem40MkdUT3Ewck8wMkFWQ0dTWE5KYzNkYklYdXFkZWFrZTNL?=
 =?utf-8?B?WDF0ZG1GOTQ0ZDZqVk5vek52SXhCcjh0Y1RwbnRXdXBKamI0dmVGTWVPMzdx?=
 =?utf-8?B?MUREdkpNQUdxY1ZvQVdCZU9TbTJOVHprY05TK1U4czNtS0ZsZ1RsVDNYd1B1?=
 =?utf-8?B?SFJ4ckFVL2VtaDlpZzRKQ0N3Y05kMEhuUXZJZHl5Z21oM3ZwWVo5RTY5M2Iv?=
 =?utf-8?B?bWhjMTFES0VMWjVhYzJmRG05ZHRpV1BHeWd2eWVJOHNEWTMvM2YyUkdqYm1i?=
 =?utf-8?B?TVFka0xyL0NYUzZrRnFTa1VJUkxFVGlzcXJhdE05SUM0dmVIMHZnQ1NlUnhJ?=
 =?utf-8?B?MUc5ODV6ZVRqM2prNmEydXpVenN6ajNaZnhqci9PaUNWcVdQdlU4S0hnSjR6?=
 =?utf-8?B?OWpXT01FSzhIYzB6eUg3a3VPKzFNd29oa3ZFaU9JYnJiczNXSjR5WHFuanNU?=
 =?utf-8?B?VjIrS0dkTGppaWdYZEpoNWF5TjRlMWVyazZNbm80NlpjdWY5OVRKbkxkNnli?=
 =?utf-8?B?SUJPanUyRE01SnRic1k2NFpVVkNMeDJQdWo5bTNFdG5FWVlGdDF2OVJmZndl?=
 =?utf-8?B?QkwvbjBwNW1WRVpDNHpzdnFGck1ibWc2TGY3S1ErRkpxNExzYUljalBBWmVs?=
 =?utf-8?Q?ZxUwzdozdAl/ssQoIcM6K2Asa4I0KK6P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4425.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnUwSVVOd1JleG1UeU1Ha1dtWDRRQUlqRXFVMGI0aC9QV3pSMTBseU5sKzhl?=
 =?utf-8?B?dHRxbmtvUk9aTytNRmU4MTVTNlVDMkZVMmthc0ZlRTN3SlgxSzEzWnE1R0ZV?=
 =?utf-8?B?OGxnZWNJSHJYSzJXMHc2b1QwUmRTWmZqL25CTkJIaU9tS2pjQ3VlSEhNZ1BS?=
 =?utf-8?B?dlRYcWNOMkhwdGk5L3R5d2w5YmthVDNERFA1SEo5WVZ0UFVMTDB5dEFKRUdt?=
 =?utf-8?B?VXZrV2s1OWpWZUlMOVhmc0lEUkk1UTNFSEdBQlNvb1JDc2I2a1daWTFXUkdV?=
 =?utf-8?B?MHFTYS9MRWd2M3EyZERGVWdZcWZleTJMRE1iN0xMV1RhemtyMkZzUDBocEtJ?=
 =?utf-8?B?aUpmRmxFUUdpOFczRmtNUnpLVnUvZDJZZEJGUGgxdUppWk1IUkZjS3R4bnFM?=
 =?utf-8?B?YnYwR1dzSnp3ZHQ5ZnFIZG5LOU41TFBpdnVUK00wV0F0Z3RWcjVFTDRNaUs1?=
 =?utf-8?B?T1RHMFpTaEZOMGY5bDRINDFkS2pKSFpMSmxTdGk2clBJQXlGUnQ5WGlHaUhp?=
 =?utf-8?B?ZGVNcmxESHFPelNEVkFoOHVNT3V4ZVhHNmU4aGI4Q2ZsRG5KNEFBSzdvNWRI?=
 =?utf-8?B?aU1QZndCODF4Vkg4Z1FSczdzWHBOSXpqRVQwYmU5RGwwYjV5dkh0QzkyY05h?=
 =?utf-8?B?N2QzVUJjVHVZcDhpejVacU1iejFzUXp6eWt2b2lKQy9IcGRJWEt0OHcwU2Rp?=
 =?utf-8?B?Z2VmNGhLTS93WVNxSk1tUVVaY0VHbTU5WExVRUlKbk9FTE1OS3pKdmhkc2U3?=
 =?utf-8?B?MHBNZ0V3MGw4VlUvWDEzVjFKVExiTnlRckk4cjJsTHg1Y0tuQVlBd0VJbElE?=
 =?utf-8?B?czdQNXNvanBjQ3ZjMkN5WVZwZU9rQTRIbm9zTXFaWmJBVHlidGJRLytIQ3pH?=
 =?utf-8?B?ZDBWYUZkelpsQnJkVVp2clQxM0hSZnVQWlpUNlg5ZjZqNDFsOHNpcTN2MDZM?=
 =?utf-8?B?ZWY2K254VFptTUlENEw3bGRjcnBtWmo4OTk3QVZ5Z0VmenZ0OUJ2aWwvTXJk?=
 =?utf-8?B?OVE1SlBSZVVRSUFzZWV5UGtrczlCbFlDYnZmRWN3ZGhHYUFpdWlqZHZqTmtV?=
 =?utf-8?B?Njc4WkF1ZkZVelo2ZHdOWlFWOExXU2xFbHU2NFNLUlhKUWREVG1KTWgvN0Rl?=
 =?utf-8?B?UzBCM0NkaHR5K1Z0UVNUYkpQSG40TncwT3d3UlFFcVBxUkpPK1JsREhVdk4v?=
 =?utf-8?B?NnprbGpIUk45bHBmRWpCRSthUFNrTzFxUWFPOUhkWmx3ZVVrR2FjVDJEd2Jy?=
 =?utf-8?B?TkN2MVNRcGNTK1lEOWlqOC9PN1piT0g3dTVQMmNQcGs4M3NNVjBhRHN1eHhE?=
 =?utf-8?B?b3BiWVpBUnJDT0hQeDdWaVVaSW5KL2NGV2EwbmxQS0pubXVwaThkdVh3Nk1R?=
 =?utf-8?B?QnlKQUpCMnAyYzdUM21ZRVNmeVJ1OEtmUXZSb2g1aWRZblFHa3Y4QjJqVnVr?=
 =?utf-8?B?YlA2OG4vaW1GK0lWcFlkRHVQN3lvMThCenBlaTF1UVlWWDl1V2lnL1VZNzhS?=
 =?utf-8?B?QXpDVGZnODNqZmZ4S21FU0FrdXpIaExhbTd0T0ZJZ1UvMm9wU3hTWk0wa0pp?=
 =?utf-8?B?Q3VKNDUrdTMvUm9YbnAxdDlDZEwxWjd2SkRBei9xb3dPUzVTYVlZWEpoUi80?=
 =?utf-8?B?OFRYbVRNWG1vRXNocU5ZK21QdzBmOUQwOVdYZks5TWNJSnpReUY5eUc4Sndv?=
 =?utf-8?B?aEFXVndRUmt0TjNDMHI5N1pKa0srblMxR2NoUGx0aEZ3VHZ3Y1pBR3h6NGpG?=
 =?utf-8?B?SkxZKzg1dy9ROHZmOG9sbDJZNlp6VW12ZE5GVmVQa1VhZHhwU0p1emxNQ1V5?=
 =?utf-8?B?c0YyTzZwYXo5TU00L0hYMFYrUjI4VW5nSnhoa2xBMUNEK2k4a3pUSmFzZWhG?=
 =?utf-8?B?Y2QzajN1a0poL083UXd0VklKekIvci9nVVFnUndsOEgrR24xVk9uOVhlZ3FM?=
 =?utf-8?B?QjY3UkF2dTJENzg4aVNkcDN0UjBiS2FadzY4UDNnYmJoTCsvSjRhNmM3Zkpv?=
 =?utf-8?B?ODFlTzRFdkcxZ05BRTZnTzdmUWtDL3ZJWjhMMDNXajlhYWZIbXJ2akRXMkc2?=
 =?utf-8?B?UFA1SWptakhaeVJoZm5SeXdxVldRRVowS0tFSlhFa01Gd3NnQTRhYi8xUnE1?=
 =?utf-8?Q?kh17fKbXliJpGEDzNN3t5Amp6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c0bee8-b3ca-48bb-b760-08dd4fd6e9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 04:44:22.3310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SeoSC75K/10XoRYAMMupKoA3ypQTpo799QqzIfy83sJuT84wN8gDRpERI0SiXM1+Dt6BWkYB8U5hs+3QF/f9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3605
X-Proofpoint-ORIG-GUID: FCQfPN7BvbG_gHrWjr8tP5G-ER8GWP6E
X-Proofpoint-GUID: FCQfPN7BvbG_gHrWjr8tP5G-ER8GWP6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_01,2025-02-13_01,2024-11-22_01
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

Pg0KPiBEb2N1bWVudGF0aW9uIHVwZGF0ZSBpcyBtaXNzaW5nLg0KPg0KDQpNaXNzZWQgaXQsIEkg
d2lsbCB1cGRhdGUgaW4gdjIuDQoNClRoYW5rcywNClNoaWppdGgNCg0KPlRoaXMgcGF0Y2ggc2Vy
aWVzIGludHJvZHVjZXMgdGhlIHJ0ZV9ldmVudF9ldGhfcnhfYWRhcHRlcl9xdWV1ZXNfYWRkKCkN
Cj5BUEksIGFsbG93aW5nIG11bHRpcGxlIFJ4IHF1ZXVlcyB0byBiZSBhZGRlZCB0byBhbiBSeCBh
ZGFwdGVyIGluIGENCj5zaW5nbGUgYnVyc3QuIFRoaXMgZW5oYW5jZW1lbnQgYmVuZWZpdHMgYXBw
bGljYXRpb25zIHRoYXQgcmVxdWlyZSBidWxrDQo+YWRkaXRpb24gb2YgUnggcXVldWVzLg0KPg0K
PlRvIHN1cHBvcnQgdGhpcyBBUEksIGEgbmV3IGludGVybmFsIGV2ZW50ZGV2IFBNRCBvcGVyYXRp
b24gZm9yIGFkZGluZyBSeA0KPnF1ZXVlcyBoYXMgYmVlbiBpbXBsZW1lbnRlZC4gVGhlIHNlY29u
ZCBwYXRjaCBpbiB0aGUgc2VyaWVzIGVuYWJsZXMgdGhpcw0KPm9wZXJhdGlvbiBmb3IgdGhlIENO
WEsgUE1ELg0KPg0KPkFkZGl0aW9uYWxseSwgYSB1bml0IHRlc3QgaGFzIGJlZW4gYWRkZWQgdG8g
dmFsaWRhdGUgdGhlIEFQSSdzDQo+ZnVuY3Rpb25hbGl0eS4NCj4NCg==
