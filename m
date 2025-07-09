Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CCAC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 07:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C00F402CB;
	Wed,  9 Jul 2025 09:19:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 012E84021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 09:19:31 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5690UQPX002981;
 Wed, 9 Jul 2025 00:19:31 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2135.outbound.protection.outlook.com [40.107.223.135])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47sd1k0pe5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 00:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNDfS3AwNS6ScI/WAu6QjgcNKF90XKRmeaKxiCt6/5pcXphQdNE3y6zgQXYGcG3Ru3aRstj8dlH6bAByZcEN2bIwVcDewxNg6tbr9o1i4Y1CW1TF5DydXUJsWHS3OWnk2YPxbOOq84nzpbvNRFpQuwsoC5mTzK+skftJ6bA1Tvir2JZA0AZqGffX3a/RuXPiKPBI6gji2NEnPMneNVGQyQw8Y3thblg14yVsRKFN+CU5WCWeB8tvsM3kY2x5nDlPDVHLqZj6w0BOJySm8JWkZdqw2AwhqEslV5u75975hHoGzwW5bxep0FK3hiB406efvfzLscUzXmBOSGdR8BQDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHjWkQdchHb/ymbfLXBsywOQdijZSr24O4gFOUndClM=;
 b=n4OG0c0HozkP0shfUgBRxsPjueMnskhsYOF4T+XwMOR+NrAXWtR/MFVjdMa+fTL1Kk3fcewZZPcN9cH/myTX0Ask8S3/AGJvmQCcUDTcRATk0DKGzURxEdehOZW57t6fpb95XOxyTDjA7pDOCe67Ggs1Zv2+5c9yDU2/rhpLM0t6nMMVeM45Y7lPbLQtXG0bpLO3+TlcOOLDZ1IE+dgejM4YR+zrez7MOx0Jg9lTaAeyJFRw/kCt+DIGYSOZt0TlSf0O7DNvpthkNAW2nV0IRAjw8n8DZHeraD3MF6F6d+MNBXAESHjHWCcK+dCJG6Ii+GT904iNV97kS1EM4HHSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHjWkQdchHb/ymbfLXBsywOQdijZSr24O4gFOUndClM=;
 b=rT/E2YocZQ6qZKn7obztTBkVQ6IKWINOzuNkCt80JxDW8hQ6stIaomiIzq1ni+Bm/jRDIqZi3LPkxJvzIjKaTjY2iN4UG+3XhASIsSmoEHkRCs1uyiRgTgJj9ZQkOSAOFURq999Zfcz8gZVbpgjiCOc5I+ZdnTlGwPW3TzlG3nY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY3PR18MB4562.namprd18.prod.outlook.com (2603:10b6:a03:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 07:19:25 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:19:25 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Topic: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Index: AQHb8J1P4jFxhOyRyEG73mK90XdgSrQpYhVQ
Date: Wed, 9 Jul 2025 07:19:25 +0000
Message-ID: <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250709064701.100676-1-zhangfei.gao@linaro.org>
 <20250709064701.100676-2-zhangfei.gao@linaro.org>
In-Reply-To: <20250709064701.100676-2-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY3PR18MB4562:EE_
x-ms-office365-filtering-correlation-id: 9489c8cd-a644-40a6-43ba-08ddbeb8ef5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THR1MkVSYkxNTG1EdmhUOU5UQ0h1TjlZUEJLZmp2MUJBRy8zdTU2L2FONFZD?=
 =?utf-8?B?WlN4azRLVktEcFg5Ky8yd1l6SnpFbzl5NWY2dm5makt5czlGK1FqMDBOUXp5?=
 =?utf-8?B?dUFDbzE2MkZ5UTJzK1JxVERXK2RUbXNkdDhpc3dpT29HUzRYYWVwZk05amsx?=
 =?utf-8?B?Y0pBR21Mek1WQVE2STZhS0JkaFhySVkySStWS0RKbzEyMVhqSnRnckVkdlQ1?=
 =?utf-8?B?SVhyT1RZN3BPbjlLTnRzU2NZaHVSYWd5MmlKcU14cldFNVpPZ09Rd01YSFdB?=
 =?utf-8?B?VExSU2hXbGs5SWgyVS9Xd08yN1lDTlBJNmo0TjN5dkltRmtjS041NTNXckZY?=
 =?utf-8?B?c2NNQWlmd3Z3ODJEamRFckhYQUJ4Wk9CL3FuWFNSaDdvY3Q1bEJFemxURitj?=
 =?utf-8?B?SVltc1N6R2dQcDdTSWxiTzdPWEVQM1dDMWM4YXZwOVZFdDZQcmNmSk5vUGIz?=
 =?utf-8?B?b3IvTXhIQmxwc0RSOFdveWFhMGpKZVNTb2x6eVVFTkZPZlBhOHBxSmR5c0ZG?=
 =?utf-8?B?M0QzVEtuYXk3b2tUa1c5MHVqMVgzU3JJVWh1UFZzK0g1R3E0WXJvMm52MmpE?=
 =?utf-8?B?WDlSWTkwK1gwaG5OWGJwa3Jtc3p0S3BoWCtMWHRSbEd4TWJma1paaFJmM2U0?=
 =?utf-8?B?YVFDamZ5WGVsSHNnZXh0TUhBd0Z1bTU0S1V3LzRIOW5wRXE5WkU5eG9qVEgr?=
 =?utf-8?B?SWcxVDE2ZVZ1dWxJWDhScnhZWUhxUlRNMnJwQ05ZNk1rUjZlWWZWMnZFM3Vr?=
 =?utf-8?B?dXp2cjIxc21CVjd6Ukc2Uy9XWDZoaXJmQlBWOWFRSlpaQjFvb0pyNWluUC82?=
 =?utf-8?B?WHpaN0VQZXlYZVpBS0pzbnY3cSsreFBLVTB2VzJ0QkIrQU1RZE1kbThSanNs?=
 =?utf-8?B?NEx1QlRySHhWVzFTMDJaUTdVdE9TMnJ4Vkljb3NVQTh1RldHb1p4Zmgvb3hD?=
 =?utf-8?B?bGRUeUpBcE9sSFRFUjc4eEVDL3hoM0RZMDhGSlJaZ2ZEMDlUdGlwTXVsa01n?=
 =?utf-8?B?ZVhoRXpqL0U5MmpmREc3d2g2K0FhWWIzUXd4aEorS1Z4UmZXR05nSldtQTFW?=
 =?utf-8?B?d3VsaTFLZWY2YkNnTVBEUUNrWVpRMnBqNTlyMzg4ek9IaXVQZW02bGJXU1JQ?=
 =?utf-8?B?Qis3YVNocUpRdzYrYjhJTzVqQnM3cTI4TlMxdVdYMlNmb2ZsYlVCTUI2OHJt?=
 =?utf-8?B?ZXE2VFJPc3NiRlJBZmVzYy90ZlY4R1RMRDdKSE45TzZVWVpicnFpckE1M1c0?=
 =?utf-8?B?MjV3ellzN3RUcmQ0RmxQbDg0N3BnamRRMzFyY3d0Z0FHRnpkaVFJY0dzV29D?=
 =?utf-8?B?ZkxxR2lwNW5OYzJMRjd1NUNybTFTMnc0ZTJVZndYM2lKVlNWUFlRRHhYVTV0?=
 =?utf-8?B?dWZoYVpWald4SERrYU9TTjY4eWNPcmk4NC9QMjVGSDN4OXgyMHZtOEk3cEZr?=
 =?utf-8?B?SDhpN2lQZUxDQi9keTBBQ1VGbjJvNEVyVGlXNDZKK1Q5TFR3MTd5NnAvVFdN?=
 =?utf-8?B?V3ZsczRxdDdkUnl2RUdSblU0SFl0TXJqK05yRFVXSEJBRjBvbmw1ZktQRDNF?=
 =?utf-8?B?VFNVaitJYTBDT3BUaVk1VGNDZjJpYmE5MWFkUTNhV0hHcWdUbktCb2tTRHNN?=
 =?utf-8?B?VVMvWm0yUFpaVUxDTnVtT0M2dmZUT2tHTEdscTIrMFNjcmw5T3FzR215aHds?=
 =?utf-8?B?bnprdEZaOG5DbmNRdCtyUUI2eEpRUVY2eTJLYWhUN0FqaEhqZjgvZEUxcDUv?=
 =?utf-8?B?Z3NraDdpYisvbk11RHpGNW9TTkZ4OWhGdFZSWkQ2eER6S0hrQkpBdHk1cDA2?=
 =?utf-8?B?NVdUOE1aMXhsMUxxMVJKa1ZJZ0VkWGpIQTZCZjNncjV5SlBMUHlvdWpmcDUw?=
 =?utf-8?B?aTlLZXN6YmxxZEpNODRzcnh0bHhmTzl1QWJOdTZ3eWxIV3FpZ1JPYkFkL1di?=
 =?utf-8?B?dktqc2JQV0NsOHNyZlBBZ2xnZFJOQTFPN1VqMTNkNW9JUFdlSExQV3o1cHh5?=
 =?utf-8?Q?Ndjke4cr78JTYfhAjMyxgYae0f9Gyc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzJ2SURBVWllRzljazAwTHR4QlVBaFFmUG9XNzdDdHl3eVJaWXFkalJpSEEv?=
 =?utf-8?B?VmdQQ1hrd0VmajVqNjF3cXo4UGUzdk5PMGU0NmxOVGJTaWhURzFNT3dJazEz?=
 =?utf-8?B?blV2K1dvS2IrSzhtSThUZjc4WWg0SG90SG9CbUQ5UXVFTlc0VkxyUnFFUFRw?=
 =?utf-8?B?TS9zZWVKTmRHSWJXQk5vcmN2THZIdjB0ajczM1BMN0tnQUhzck5ic2ZWNG0y?=
 =?utf-8?B?ZXZ1S3pFZjJSNHN1cFk4d3BXZ3JHVU5UOTJwOWZpdExkOXFBaVQ2WjJpQ2RV?=
 =?utf-8?B?STdvVlhhbEVyS2JiTjZwTlh2b2tmNDQwS0hyNDIzWEs3ZklmcVovUlk1ZGNl?=
 =?utf-8?B?YzB0RVNuS2lMUFlGbFJnSWljaDRCd0FWME8zeGVGSU1FZVNNd3Rpbzl2TlVI?=
 =?utf-8?B?RlFNYnQ1aFB1eG90R1VzY0txYnRLUElPUEhKUUJSS1liQmFuK1hjMDdaWnBr?=
 =?utf-8?B?QlZNYmZ1bUtOWTlwV3NrckJ6c0hWYXhuanB6ckVsWHl0WWtPaDVzbzZxbHFR?=
 =?utf-8?B?dHRzKzcvVk9tYWNLMDlFK3ZjeUgyR3FYQlpqV01mbDhTWTZRT1U3L1J3aTA2?=
 =?utf-8?B?NSs1WlBueThCSkp5TFBrNzdKeitXQnM1dmticXdzRWdlbUVQM2ZIeEYyRVlS?=
 =?utf-8?B?VGJMaVh4Q3BteCtmZThjTVBQeFMvYWpsUFR5NVk1TkdrUldxSHBURzVZck1D?=
 =?utf-8?B?b3VDOGZVd1JEL2t2MlZsM2lHd0VlZ1lDU0ROd2EvTUczaGJWTHgzTll2MXJ3?=
 =?utf-8?B?Y29FcEdPZXJOejg3MnRIZGZIT0p2VDhualdyaWQyVW5ZZENpS1RvSTJ3dFp0?=
 =?utf-8?B?US8yRkN3eVhscDJRaGhFNUxvR2JhZGlSeWJkKzBNWWVqVys2bWhMc2J4Njk3?=
 =?utf-8?B?M2VGWnQ5THZVNklKdU9za3BhVTVldnZjaGFtZzU3YUxYZWFDYzI0bUIxa08w?=
 =?utf-8?B?Znh6ZWxOT2Y5TWsyNHp5ZHRrR2thcmVHVTAzTzJPSlpzK1JyemdXZnNKVTRo?=
 =?utf-8?B?YkxCeUJhbWpxNDE5NXV5SStaQzgzUWZyTUdhRHVWZHVuc2VHaFFJUzJBbDho?=
 =?utf-8?B?ZytBYWw1dDB2U281MXhvZkFiOTVnU2ZYY2E5bmFQeWRPUDUycDJPMWdmOUU0?=
 =?utf-8?B?cnpoZnovSHIrdU1uNFBETklIWmF1cHRSOEtKc0srNkgwYnlKTE56Z0hVbE5h?=
 =?utf-8?B?cTJKYkd0VkU0eXZkbjlua3JKRVpnSEVjeTlmOGVQTnltQTVuMCt5eUEzclRW?=
 =?utf-8?B?ZWxZeHFldkpNd0tGQ3VEWmp1bEk5ZWNCcFhJRFFjZFZIYXF2TENMTWNPa2xu?=
 =?utf-8?B?K3EvdVJNSFZyRUczeUtlNXgvWlB2UWt6WXkra2FZM0dxS3FBbXhhcWRNT2Fo?=
 =?utf-8?B?dXRpUGxUTUE4Q3ZzMDh0VHMrQktOUHQvZmNTaHozYStXYTdGaFFYbkp1RlR2?=
 =?utf-8?B?N0lRM0p0U2VhQVNtZWozL3lBbCs5QTZUTnVEK2plYmR2UkRpd0x1N2N5M1dM?=
 =?utf-8?B?amluS0hpVXJzQnRkWDBLNnowR3lXQzhEM1R0ZnY2SnJEUVV6WXAyUC9tMnVn?=
 =?utf-8?B?em1yMzB6UlZvOFRaWkRPS1RwanNESGVkdG96N2hNcEdxYmFIaG12YVlnMTBB?=
 =?utf-8?B?cmN5bVppVUdhV2orcU9HdXNWaW9DVnQwWEF2bHAyK29VM0xtRml2UHByeFdJ?=
 =?utf-8?B?elVZMFdHWWVHK3Z5YWZnekJQQmZPdEY1VmpOdWkxZ1lCMGhLMDd4aE5iTi9s?=
 =?utf-8?B?bmFZT2oxd1Z6R3dDVG5jN2NISEFqTW5KUkt5TFAxR0VXRkJiUFBRS1NvZU4z?=
 =?utf-8?B?RWhNWjJmZmN5Skcrc1o0N0VvU2UrU25EaVRHZUVZSktYQlZVOTFCTWhreGE4?=
 =?utf-8?B?N0tybUpJUGpWMUU1WUZsdzdCUFBNbEhvVlhzWHdieC80M3JXT1VIYisybTlp?=
 =?utf-8?B?L3kvSUZpcm04WWs4VEZ6dVNOSGtOM1lFckU5VlBOOUJ4bDh0cU9aam51N2th?=
 =?utf-8?B?V0FUczQzeFk2cGhNS013b1M1bzlBZ2Z4WGVRRGRxM2F4T2pUUTlKYnZaVWtM?=
 =?utf-8?B?MWdlS1Z3S2dpV0ozclZoaGtadCtkajNsSCtWUWFKNGpLZ0l3aVROOG4yb0Z5?=
 =?utf-8?Q?/AMo4aT4YigkvZnntc/qYNbEH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9489c8cd-a644-40a6-43ba-08ddbeb8ef5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 07:19:25.4820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2By7wmjPYwy7EdBtWLmgspX9pwFug6HYHni0r9hs1e7Ts9AyIlchEXRdxH7de/gCaJ2zwQwjzvyYssNae0TSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4562
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=686e1802 cx=c_pps
 a=SfKpAED18FmY9QLmYdbp3w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=KKAkSRfTAAAA:8 a=8T4zzsx5lQuiwi4V838A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA2NCBTYWx0ZWRfX6BPIuDjDWjwu
 EGrljXo/r0xB0NOHbaqMfqCHs8WX/7DUYujMnx+gLq30LtYLTvrCjTSSy/EcGPA1Z1/9t+WeThP
 GmmC1S3NI46vWdfKHnVMn5AOjptyET/TUa6QkwgFlvfDmmF+7fLLihEhidKNuFXOf6EupRWMF/k
 kxtDpZX5JrHUeWISaDFh+bma5PMPTQJNZOevyCCt5xCFL56af4agFDEsRB44ZT/SeA+0N64Bolc
 dTALDzvFmDps1zDNirKRPucC7putECqPnQjg447FUx0MYHviGqaxrgUj3j9zEJfT95JcvS9c9tW
 +mDuMTshM5vl8R7fR5dEMd/F9m241L5ySfCZ7rEfZtztfTz23Gz87RNd8UTHl7UNYzSSAHLJEVw
 uc3m5bEEFsbhA/vvI77d0kJ1sNol6CXpkTs8BVM0QXSnc3gSa83q6gvhEsV8tfrFDGsW66yX
X-Proofpoint-GUID: iSknjUHzurHr5WcdaWx284tBw_Q6bhut
X-Proofpoint-ORIG-GUID: iSknjUHzurHr5WcdaWx284tBw_Q6bhut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
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

PiBUbyBnZXQgYmV0dGVyIHBlcmZvcm1hbmNlLCB1c2luZyBhc3luYyBtb2RlIHRvIHJlcGxhY2Ug
c3luYyBtb2RlDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdh
b0BsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3VhZGsucnN0
ICAgICAgICAgICAgICB8IDE1ICsrKw0KPiAgZHJpdmVycy9jb21wcmVzcy91YWRrL21lc29uLmJ1
aWxkICAgICAgICAgICAgIHwgIDQgKy0NCj4gIGRyaXZlcnMvY29tcHJlc3MvdWFkay91YWRrX2Nv
bXByZXNzX3BtZC5jICAgICB8IDk0ICsrKysrKysrKysrKysrLS0tLS0NCj4gIC4uLi9jb21wcmVz
cy91YWRrL3VhZGtfY29tcHJlc3NfcG1kX3ByaXZhdGUuaCB8ICAyICstDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3VhZGsucnN0DQo+IGIvZG9jL2d1aWRlcy9jb21w
cmVzc2RldnMvdWFkay5yc3QNCj4gaW5kZXggYTI5MDQzZTBjMC4uODgxMmZkMTgwYSAxMDA2NDQN
Cj4gLS0tIGEvZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gKysrIGIvZG9jL2d1
aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gQEAgLTk2LDMgKzk2LDE4IEBAIFRlc3Qgc3Rl
cHMNCj4gIAlzdWRvIGRwZGstdGVzdCAtLXZkZXY9Y29tcHJlc3NfdWFkaw0KPiAgCVJURT4+Y29t
cHJlc3NkZXZfYXV0b3Rlc3QNCj4gIAlSVEU+PnF1aXQNCj4gKw0KPiArDQo+ICtBcyBhIHJlZmVy
ZW5jZSwgdGhlIGZvbGxvd2luZyB0YWJsZSBzaG93cyBhIG1hcHBpbmcgYmV0d2VlbiB0aGUgcGFz
dCBEUERLDQo+IHZlcnNpb25zDQo+ICthbmQgdGhlIFVBREsgbGlicmFyeSB2ZXJzaW9uIHN1cHBv
cnRlZCBieSB0aGVtOg0KPiArDQo+ICsuLiBfdGFibGVfdWFka19jb21wcmVzc19wbWRfdmVyc2lv
bnM6DQo+ICsNCj4gKy4uIHRhYmxlOjogRFBESyBhbmQgZXh0ZXJuYWwgVUFESyBsaWJyYXJ5IHZl
cnNpb24gY29tcGF0aWJpbGl0eQ0KPiArDQo+ICsgICA9PT09PT09PT09PT09PSAgPT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiArICAgRFBESyB2ZXJzaW9uICAgIFVBREsgbGlicmFyeSB2
ZXJzaW9uDQo+ICsgICA9PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiArICAgMjQuMDcgLSAyNS4wMyAgIDIuNCAgLSAyLjgNCj4gKyAgIDI1LjA3KyAgICAgICAg
ICAyLjkuMQ0KPiArICAgPT09PT09PT09PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZA0KPiBi
L2RyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZA0KPiBpbmRleCAzNDExM2NkMDhjLi4z
MmNhZGQwMmVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NvbXByZXNzL3VhZGsvbWVzb24uYnVp
bGQNCj4gKysrIGIvZHJpdmVycy9jb21wcmVzcy91YWRrL21lc29uLmJ1aWxkDQo+IEBAIC0xMyw3
ICsxMyw3IEBAIHNvdXJjZXMgPSBmaWxlcygNCj4gICkNCj4gDQo+ICBkZXBzICs9ICdidXNfdmRl
dicNCj4gLWRlcCA9IGRlcGVuZGVuY3koJ2xpYndkX2NvbXAnLCByZXF1aXJlZDogZmFsc2UsIG1l
dGhvZDogJ3BrZy1jb25maWcnKQ0KPiArZGVwID0gZGVwZW5kZW5jeSgnbGlid2RfY29tcCcsIHZl
cnNpb246ICc+PTIuOS4xJywgcmVxdWlyZWQ6IGZhbHNlLCBtZXRob2Q6DQo+ICdwa2ctY29uZmln
JykNCj4gIGlmIG5vdCBkZXAuZm91bmQoKQ0KPiAgICAgIGJ1aWxkID0gZmFsc2UNCj4gICAgICBy
ZWFzb24gPSAnbWlzc2luZyBkZXBlbmRlbmN5LCAibGlid2RfY29tcCInDQo+IEBAIC0yMSw3ICsy
MSw3IEBAIGVsc2UNCj4gICAgICBleHRfZGVwcyArPSBkZXANCj4gIGVuZGlmDQo+IA0KPiAtZGVw
ID0gZGVwZW5kZW5jeSgnbGlid2QnLCByZXF1aXJlZDogZmFsc2UsIG1ldGhvZDogJ3BrZy1jb25m
aWcnKQ0KPiArZGVwID0gZGVwZW5kZW5jeSgnbGlid2QnLCB2ZXJzaW9uOiAnPj0yLjkuMScsIHJl
cXVpcmVkOiBmYWxzZSwgbWV0aG9kOiAncGtnLQ0KPiBjb25maWcnKQ0KPiAgaWYgbm90IGRlcC5m
b3VuZCgpDQo+ICAgICAgYnVpbGQgPSBmYWxzZQ0KPiAgICAgIHJlYXNvbiA9ICdtaXNzaW5nIGRl
cGVuZGVuY3ksICJsaWJ3ZCInDQoNCkkgYW0gc2VlaW5nIHRoaXMgbm93DQpEZXBlbmRlbmN5IGxp
YndkX2NvbXAgZm91bmQ6IE5PLiBGb3VuZCAyLjkgYnV0IG5lZWQ6ICc+PTIuOS4xJw0KDQo=
