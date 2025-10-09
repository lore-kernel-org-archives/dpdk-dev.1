Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AFACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 02:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CCAE4027A;
	Thu,  9 Oct 2025 04:27:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 09E3C40277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 04:27:24 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598M9DFm023312;
 Wed, 8 Oct 2025 19:27:24 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022082.outbound.protection.outlook.com [40.107.209.82])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49p0g6gcpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 19:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltROUhawnHAJ7xJANo4O7353uWbOm+gRZ54+SxqZZ1m9VWgo1MzlpnmBbwT55gsVslS03tTNkqheI17q6xsi7fYuyf8W3PoD8uTwMttytSlWaqj9zb4EHJsBS5vJnxMlqOJRtAvZ5mITAYNPPAQ5jgPQ56HrVb6zDrjtsFg7HWKrxHAO3nFiYsovpp1FB+dVqOhlP6ACKIgdCyucq27DvCA+nm+WNtVr+4qDRryHxPIpLmKSNgmY4GMu15OcVzST8BXLVFYHFYWbiz89vSdKxKZHWgfN/CXkW/jtDWlGK1a9O3Jopiw2w299907wqXmVxxjMqv2ifMmkdNe2R5sFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0955y34cc0GIAldEL+xH3CNSfBtmsLbWrYtXcSKKH4=;
 b=DB22rJmeAJ7a+k/SPH8XXH0aXoKBIIgciQWyqs80IOh/SJQuRb9DtbIYuqf78hRNK4yuE3oIiwDGMs/VMnQ0YdM6mnYxGc/8EWZG5zdFO/Vo2jRfj65R+x+gFGRps3EOTSgsn1v6xwEZPQ/K6tQSFd/73qEYspOAxxMPrCU0Dz6JrmfS96Q5JGLXMrtLpc/66h5TFu8A8gfaFnyga7qIV9SRloozzkVNs/ltTFL0YOT6vxob6FcIm8V11Bef0EcUxLbGv0zE0oMvqTpi07sO7RKjRy4FcavHGx8DPaDmFmC0KQv5JwJ6jIakGgpYpGUqLPV6wZecb2zSyE8xKdCQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0955y34cc0GIAldEL+xH3CNSfBtmsLbWrYtXcSKKH4=;
 b=gI26Ht2Wgvrtg3hXAAmAVS+qHcEr8BUglGtOMC3x6HZzRei42AXy81BhUYt3UoWni/PtBz3vZHapO3DAwS7N+uErmYYfnL8BaVLdaw0L4vrzctpyCfWx+4H4s/RJnMA2jcOya+p8R3m65qAn0be7gmWNwYKWymCkPEQjXxkv2Vo=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SA6PR18MB6201.namprd18.prod.outlook.com
 (2603:10b6:806:40d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 02:27:16 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%5]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 02:27:15 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, fengchengwen <fengchengwen@huawei.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>
CC: "thomas@monjalon.net" <thomas@monjalon.net>,
 "vladimir.medvedkin@intel.com" <vladimir.medvedkin@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Topic: [EXTERNAL] Re: [RFC] lib/dma: introduce inter-process and
 inter-OS DMA
Thread-Index: AQHcGzy5YkOIwkQZ3keJnCVDiFvIxLSaUdWAgATUAxCAArb0kIALHS+AgAhhaaCAA/OuMA==
Date: Thu, 9 Oct 2025 02:27:15 +0000
Message-ID: <SJ4PPFEA6F74CA2538B971F310E1941140CA6EEA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
 <c366cdab-1538-4f70-8854-38f099b8990a@huawei.com>
 <SJ4PPFEA6F74CA2394BA7980AD7F285110BA612A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA2DDB3385FB29756363375A61CA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
 <BY3PR18MB478537EA13F30E686068F557C8E6A@BY3PR18MB4785.namprd18.prod.outlook.com>
 <SJ4PPFEA6F74CA2460870904712F25B550FA6E3A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
In-Reply-To: <SJ4PPFEA6F74CA2460870904712F25B550FA6E3A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SA6PR18MB6201:EE_
x-ms-office365-filtering-correlation-id: a0e95de5-7c56-4ee2-8667-08de06db5cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?STNvNDBQeEE4cFlNb3VlaDlZU3VoVmF1c3BSdVJmTkdNVWNFTmpNWGpMODUx?=
 =?utf-8?B?S21qYXpRemNlNlZxU0E4Uksza0JBdGxmenBLMnh4cnhkR0wxN3BnQk5mbGJy?=
 =?utf-8?B?Z3FKNFpWb2NSV3lkcUZWMFZxSGU3SHdMZnIzVDc5bElzdEpRN3ZXSkJOVlE4?=
 =?utf-8?B?QjdocnZ5MmdTOVR0VHBna29ObUhwY2VvNFBKRTBUam52c2RKb0pTMVFodWR6?=
 =?utf-8?B?cVA0bWt6eUhGaU5KK1dKZWpRWjlJdTVQeWFuK1Uxd21uc0F5R25LbWV6THBN?=
 =?utf-8?B?TytYbUlyNXRqUHdvaDhwL0V3UURHYlNLUElwUTM1MnlDVFk0RWVsd2MwWGsr?=
 =?utf-8?B?aHVpOEhEekpiUDZzbzd0a0ZYWkMrem9HbTNvYmg0amxJaU1Ca0kxeXd2L1Vk?=
 =?utf-8?B?OVErNUpRaUJjVjJEUTd4Vk1Qd25CTlREcWJXRGIwTHlPWFdReEkrRnlyTGNv?=
 =?utf-8?B?Skg2d05GRVVxQ2JpTzhPdDBPVHRiTEhyZGYraXUrZ1NhVm12VjFGUU9SS05W?=
 =?utf-8?B?eTFQNVpMVGpxZ1l0VE1wcm5DUmJhVXNJN0U2RHBtL3BETEw3cGROY3hYa09C?=
 =?utf-8?B?eXlMSW1zMkx4RWdqRmFVME9HZDdsZjJ0S0dsMDdQc1hiUlYzaWtJU2Jzd1d2?=
 =?utf-8?B?aitVTCtIVHl1ZngzL0RnRDJLQjJRbjU5WDdsL25Gd2pVamxrOHBNQmVUczk5?=
 =?utf-8?B?M2ExdHpOZzFhK2hGenFlcWZtSkFoMTdFYk4rUXpIbEhIRmY5Q2JWdmpoL3A3?=
 =?utf-8?B?K1lmeTh1TlU0QWt2Z2QyWVJ4cXZseWZ3c2Z3TGRKNEJ5bjBoNXdTaXpqT0V3?=
 =?utf-8?B?SW8wcExGZXQ5N0NRcDdoZ09NZ0MvWjNZYUVranp1bkRVeFZnYzlJeDNIbk0v?=
 =?utf-8?B?OUlDL1NBdnl4dnZhZ3dWTERleVVZUWJ5aERqQngwUHdvNVpyczZXM1hBTEtz?=
 =?utf-8?B?NjVRVVhpNUphdXA4Z2dSYVlwV1QvazlFTTRQNE82SHRoTW9UYW1VTXFGMHli?=
 =?utf-8?B?dDN0dERwam9UTW52NG0rdUhuVldNWU1YVVlvcVRna2FhUHB2NmVIN1dnVFdy?=
 =?utf-8?B?YlovWTZnWmVMY2Z6V2crRS82cXc4U1lsSUlmRmk1OVpDQ1laQlErVENrRW9I?=
 =?utf-8?B?MWdhNjZmK2VLak9uM2tVZ3BMWVpqNlhpdjJsd2Nnemt1bGpHdXkrTWlqNEhG?=
 =?utf-8?B?UUJsZGU1ZUpqTjZOZ1V5c1BWTHJYQmZFd2FoOWkxL2d1Vnl6bDFNRG1FZXBK?=
 =?utf-8?B?VGt1VTI4MmZtKzBYY3d6MGZ1YllvaGV0b0dyRWlzdk0vb0EzSW9kamRhTFo4?=
 =?utf-8?B?NHlyNjJlZHlYY3FySWJKa3NtcXJLemJJclRkRFVvRXJtdit1enEzQTBpN2R3?=
 =?utf-8?B?OTNOaHBjL3hLa3U3ZUZDM01YcjVxcm5zL0VLOVFTUjFLdXp5NkttM0FkdVRO?=
 =?utf-8?B?RDJ6cW95YjQ2cmFJV2VwbFNaN2hCUTRzREovbUJoQVBCa05CYXBuMmpVWDEv?=
 =?utf-8?B?RnNTaFY3SERSRDVQYno3Y280WmhwSzJWdktYMUNQdUl5aTFDMHdmMEpyZ05Z?=
 =?utf-8?B?bGFNSEEyd09FVE8vS0I3THNpajFwY3FUOWcyck5hcGhXRGVrc2JFb3RMRWE2?=
 =?utf-8?B?UittYkJKcndvdy9FMlNKV2tET3BHbWpRYzZPVFJaaHpvcHlleWFpdzhkelpq?=
 =?utf-8?B?UFlCcWNkcWw4dEtENmhJK0Vkb3VTR3B5WnFOMGVHY1F2enEvZTJiejUwZGJL?=
 =?utf-8?B?R08yWFU5OWlJanBXMklJaC8wZzVhSUF1WUQxZmpyTFlTb3k3UnBxaC96M01o?=
 =?utf-8?B?ZWhaeE5yU2h4OXlaTlhHTXR0K1BvQk00ME9zTzBuZ2NGSmxWdk50R0VueTM0?=
 =?utf-8?B?T0FrUWt5ck8rbDhZWit2eStHaWMvZkZrbjU2V1o0bDA0MjRmZkVTRWhuNERo?=
 =?utf-8?B?c0pXdmQxeFJIYTNHT3V0WnZmU1ZDbUtCbHV0YThmMy95MkxMemVvbkRyZm10?=
 =?utf-8?B?eU9ER1ludmxzdGRGM3AyUW1KZTNBQU9SZHF0cDd6aVVESWpIMjBpOG05RjBk?=
 =?utf-8?Q?K8VsKP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJxZ0ovaGx3VWtZY3JsaVQxZXk3ZDlEZGRINU4wRXVWamxrYnpUcFlVL3Ni?=
 =?utf-8?B?eDI4RDBLcVplVjFHU2xZMkhvNHYzSlhqMlk5NitLcEUwOWV3aW9FVGxPZ1BY?=
 =?utf-8?B?a28yY0lWM01UZllORFUrWTgwMmUxRy82UGFDZGhVWk5FMFdac25sY2V2cjBy?=
 =?utf-8?B?TFhZYmtERC8zOXVBcVdvVWhXL21ORm45S215Z2N6RkVBaHNqRXl3SUZpRGI5?=
 =?utf-8?B?cDNSTzZJSzA0MVJ4Y2swTzdRMk1BRzhLeGsyTFpkM3NYUm90SHFHZlhyZDNw?=
 =?utf-8?B?eEtMMTNDN09tSkhRKzdyYlpkUUE1UytKNkNJeHhmUW1DQXBRanJtSERpaG81?=
 =?utf-8?B?L0ZNNUIzazMyS2U3V0RlcDRyOFc5RDRFb1QvTmZ5V0tJSFF4TTZ2cXdvMkZ1?=
 =?utf-8?B?WkRtSkc2R3lacHVsNzZZT3U4cHRndkl2aVRrdFhCT2NBeXdUeDlobGxaUmRI?=
 =?utf-8?B?UXprK0NhYTRxa0UrRmF3d2NnaEh5SnoxS3NvSDRxTXhQUWNEQ0ZwcVFOc3VS?=
 =?utf-8?B?MEpIeFVyWW9TY3JHQTZTeFdiM3RZdEZSY0paRWc2ZWtSTTUwUTZWTlE3V3VR?=
 =?utf-8?B?dHFWQ0NyR0Vkam5Yc2wvYXhBY1l6dVN1UGNZM0lleFNMcXRHOHJiTml0dTR5?=
 =?utf-8?B?VnFtUXlkTFYxL1NlK3FDYmYzNnRKcnlSdU1GLy8vRVNGYWw3SWRuTFJXcDFa?=
 =?utf-8?B?VStKVU5UVTJ3ZUJoRXVKYm4zdHdwMFI0RW5JQitiVGRIbVc4U1E5Z2h0THNY?=
 =?utf-8?B?dHFBYTJQeVFEbFRhTnBxUmZ5cVZ0TmRpbWdnTzhOaEhzZ2ZvaisxTGJBY0tX?=
 =?utf-8?B?RGZtYWV4MWxFeURVam1BRDZUSXBPRUlpNUNKVitPQm5GdG5aTmZqZ1VGUEpK?=
 =?utf-8?B?TjBKNDAvL25qZW5kK043OURoblR3VmFIRjAveUZJZ0JMalU0RFVtVHBlc1ZS?=
 =?utf-8?B?TjRmNEpmV1RXbkc1b3FPRUZBSFRXallxeENjNkE3SHBIdGNxRGdnSXJWUVV0?=
 =?utf-8?B?WVlSQ3dRSzNTL1FYeVlsZlUwUy92UkVmdjRIcGYwTUZRdVhJaHcyQVE3OGtU?=
 =?utf-8?B?SzRNRTZXUTFNZ0owcWNKQUpsMWFUcFR3dnEyUUEyWVpVcDZHUWVVR3RqTHc5?=
 =?utf-8?B?YWNZUDJaME1NUGV5YnFsZ3ZwdzFhWDBSWmtmaFlhOHV2KzRNU3FiQU5SNkFB?=
 =?utf-8?B?Z0E5dzIrMDdMOUNacFRZT3pzdGRTcGFoWWRlaUhHaVRQdDV6MUhtN2xlMC9v?=
 =?utf-8?B?R3Y4SDE3WlMyVUd0S0pLcU05ZTBFdlE1aHZDRmx6OTZHSzRxRWp0ZWZFei9R?=
 =?utf-8?B?cGVGYWx6N0RSaktueXpwUGpHb01uV3BjWGRsSG9tZlRqUkRIOXR0d21YL0Yz?=
 =?utf-8?B?YWZHQkRKelIwMEwzNEdNeEVYcFpmditsTlZRRC9UU1NwOTFDRWZwbjJ6K3Bq?=
 =?utf-8?B?MXllbFVwcVV0ZjcvNkxHS1RGOHhLV25QbXZkTjQ0QUlDMWlJZi9qaWE2NXYy?=
 =?utf-8?B?S0h3ZTN0RGRMaExXWWJ0ZXZqMG9HWkJobmtNU2NGWitFUlVtV1RjZFlHdk9r?=
 =?utf-8?B?MW4yc3BGWWF5UWwxeEYxSDNNanlaMGR2ODN3SUh4b1VtY3FWUlhvNUhkMGRD?=
 =?utf-8?B?czltakZaZHVkclhNUVhNNzZHczFXTEo1NjdCbmVCVWhXdkxVYmxuLzE3MkZy?=
 =?utf-8?B?UTQ4ZTdHL3g3cEJCR3FOZGN2MSttaEY0TVdacmJlQVludFhVYlRrekxUdnJs?=
 =?utf-8?B?THpidEZwaWk4TW01N1dKcU1WTHlNdFk0MmVUcFBzRnN2N2k4bEtBR1RxSXR5?=
 =?utf-8?B?TGZKWnRKanR2VWllenpTNlJzT3dLYUN2Mkc1eEVkZkYwVTNCajc1bFQwaEFS?=
 =?utf-8?B?cXVFcVNNMzVORS9xeXZrU0QxUHVDUWxQTEJ0b3lvNlY3Uk5NUkpnYWdtSERO?=
 =?utf-8?B?RDR4d1ExeTExbG8rS0tvL3FFMmVvWFgrc1FpUGwzQVRzSWxSSUNPZ3g1VjN6?=
 =?utf-8?B?bFRCQnBENUJWcXNPNStIWW4zL2NHdDNaR1dJQkd5YzhLL2NpV2xkWGE4Qkps?=
 =?utf-8?B?TG1rZUd5YlVlZTVFKzNCQUpjenBmSjVlc3hhM254VzF2cjJEZmZvWUxDd0s1?=
 =?utf-8?Q?3EcY+1y4MApjGAWKG9mOmVcUi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e95de5-7c56-4ee2-8667-08de06db5cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 02:27:15.8148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYafn3D3L1QrFr0qnG726JNBKZAcWoAj0EJEYs2AJ+EZx3UtPsg6oirmDV92o+rJVXv6RNyIyCUqiU/9B4PgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6201
X-Authority-Analysis: v=2.4 cv=VtEuwu2n c=1 sm=1 tr=0 ts=68e71d8b cx=c_pps
 a=yElQ4muSOuhJtI3odKz4wQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=bt5KbKNvAAAA:8 a=iPLb6Wb2H3iw2DYqMX0A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5y_w6M2sPxfU2HAM1xbvDdwoyaVnnmYo
X-Proofpoint-GUID: 5y_w6M2sPxfU2HAM1xbvDdwoyaVnnmYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDE1NSBTYWx0ZWRfX0oezpx/1Oz3y
 ZK2V2roydrWNWSVjI+U2AT80/HPvIMaDXOwNIVYdKqFhCVp/vUEzfZfC4MKhSmEz6SNA54ioBUb
 TGBsNtIElsUnpA2ujyri5yb0Kukg+fpgISJ/t7n9pS7j5agYlv9jGaWL0JsdDpGb6KWLRIt+nfq
 8ZvLyrMq6cHXib5XVkzwZlytHeGams8PtS5L2AKZ5UjjLTCwq0wCzHRxcnqxOUv+61sAcNvMMGj
 WNPqKDOu3m2Ods78zEW17zxY2br1BSQQSNII9X5zG7UVyskgCJNgijJVnibT3AP56VLx+/NXyvN
 gS0c1isneT4NTE5KRBiBWSTysqviPZvAUJ7h2e+7cU1nnaX+3P2Mdx8+aAW8cocnORlh44KRvSW
 Jl+8ao8u+S8zyE0P3uxsbnxpN+VXiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
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

SGkgRmVuZywgQnJ1Y2UsIEtldmluLA0KDQpDb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGUgcHJv
cG9zYWwgYmVsb3cgYW5kIHNoYXJlIHlvdXIgdGhvdWdodHMuDQp3ZSBhcmUgc2Vla2luZyB5b3Vy
IGZlZWRiYWNrIG9uIHRoaXMgZmVhdHVyZSB0byBlbnN1cmUgYWxpZ25tZW50DQpiZWZvcmUgdGhl
IHJjIGRlYWRsaW5lcy4NCg0KUmVnYXJkcw0KVmFtc2kNCg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogVmFtc2kgS3Jpc2huYSBBdHR1bnVydSA8dmF0dHVudXJ1QG1h
cnZlbGwuY29tPg0KPj4+ID5Gcm9tOiBWYW1zaSBLcmlzaG5hIEF0dHVudXJ1DQo+Pj4gPlNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDIyLCAyMDI1IDU6MTkgUE0NCj4+PiA+VG86IGZlbmdjaGVuZ3dl
biA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+OyBkZXZAZHBkay5vcmc7DQo+Pj4gPmFuYXRvbHku
YnVyYWtvdkBpbnRlbC5jb20NCj4+PiA+Q2M6IHRob21hc0Btb25qYWxvbi5uZXQ7IGJydWNlLnJp
Y2hhcmRzb25AaW50ZWwuY29tOw0KPj4+ID52bGFkaW1pci5tZWR2ZWRraW5AaW50ZWwuY29tOyBh
bmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tOw0KPj4+ID5rZXZpbi5sYWF0ekBpbnRlbC5jb207IEpl
cmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+DQo+Pj4gPlN1YmplY3Q6IFJFOiBbRVhURVJO
QUxdIFJlOiBbUkZDXSBsaWIvZG1hOiBpbnRyb2R1Y2UgaW50ZXItcHJvY2Vzcw0KPj4+ID5hbmQN
Cj4+PiA+aW50ZXItIE9TIERNQQ0KPj4+ID4NCj4+PiA+SGkgRmVuZywNCj4+PiA+DQo+Pj4gPj5I
aSBWYW1zaSwgVGhpcyBjb21taXQgY2hhbmdlIGlzIG1vcmUgdGhhbiBkaXNjdXNzZWQsIGl0IGFk
ZCBjb250cm9sDQo+Pj4gPj5BUEkgd2hpY2ggZm9yIGdyb3VwIG1hbmFnZW1lbnQuIDEuIENvbnRy
b2wgQVBJOiBJIGNoZWNrIHRoaXMgY29tbWl0DQo+Pj4gPj5hbmQgSW50ZWwgY29tbWl0IFsxXSwg
aXQgc2VlbSBoYXMgYSBxdWl0ZSBkaWZmZXJlbmNlLiBJIGhvcGUgSW50ZWwNCj4+PiA+Pmd1eXMg
Y2FuIGV4cHJlc3Mgdmlld3MgWmpRY21RUllGcGZwdEJhbm5lckVuZCBIaSBWYW1zaSwNCj4+PiA+
Pg0KPj4+ID4+VGhpcyBjb21taXQgY2hhbmdlIGlzIG1vcmUgdGhhbiBkaXNjdXNzZWQsIGl0IGFk
ZCBjb250cm9sIEFQSSB3aGljaA0KPj4+ID4+Zm9yIGdyb3VwIG1hbmFnZW1lbnQuDQo+Pj4gPj4N
Cj4+PiA+PjEuIENvbnRyb2wgQVBJOiBJIGNoZWNrIHRoaXMgY29tbWl0IGFuZCBJbnRlbCBjb21t
aXQgWzFdLCBpdCBzZWVtDQo+Pj4gPj5oYXMgYSBxdWl0ZSBkaWZmZXJlbmNlLg0KPj4+ID4+ICAg
SSBob3BlIEludGVsIGd1eXMgY2FuIGV4cHJlc3Mgdmlld3MuIEkgcHJlZmVyIG5vdCBhZGQgdGhp
cyBwYXJ0DQo+Pj4gPj5pZiBubw0KPj4+ID5yZXNwb25zZS4NCj4+PiA+DQo+Pj4gPlRoaXMgbmV3
IGZlYXR1cmUgbmVlZHMgdG8gYmUgc2VjdXJlbHkgbWFuYWdlZCB0aHJvdWdoIGNvbnRyb2wgQVBJ
cy4NCj4+PiA+SXQgd291bGQgYmUgZXh0cmVtZWx5IGhlbHBmdWwgaWYgdGhlIGZvbGtzIGF0IElu
dGVsIGFuZCB5b3UgYXMgd2VsbA0KPj4+ID5jb3VsZCBwcm92aWRlIHN1cHBvcnQgb3IgaW5wdXRz
IG9uIHRoaXMuDQo+Pg0KPj4NCj4+QmV5b25kIGFkZGluZyBJbnRlbCBmb2xrcyB0byB0aGlzIHRo
cmVhZCwgSSBkb24ndCBzZWUgYW55IGZ1cnRoZXIgc3RlcHMNCj4+d2UgY2FuIHRha2UgdG8gZHJp
dmUgcmV2aWV3IGF0IHRoaXMgc3RhZ2UuDQo+Pg0KPj5UaGF0IHNhaWQsIHRoZSB0YWJsZS1iYXNl
ZCBjb25jZXB0IHVzZWQgaW4gdGhlIGN1cnJlbnQgQVBJIG1heSBub3QgYmUNCj4+cG9ydGFibGUs
IGFuZCB3ZSBtYXkgbmVlZCBpbXByb3ZlbWVudHMgaGVyZS4NCj4+DQo+PkJhc2VkIG9uIG15IHVu
ZGVyc3RhbmRpbmcsIERNQSBkZXZpY2VzIHVzZWQgZm9yIGludGVyIHByb2Nlc3MgY29weSBjYW4N
Cj4+YmUgY2xhc3NpZmllZCBpbnRvIHRocmVlIGNhdGVnb3JpZXM6DQo+Pg0KPj5DbGFzcyBBOiBS
ZXF1aXJlcyBhIHBhaXIgb2YgRE1BIGRldmljZXMgKG9uZSBvbiBlYWNoIGVuZCBvZg0KPj5wcm9j
ZXNzL2RvbWFpbikgZm9yIGRhdGEgdHJhbnNmZXIuIE1hcnZlbGwgRE1BIGRldmljZXMgZmFsbCBp
bnRvIHRoaXMNCj5jYXRlZ29yeS4NCj4+Q2xhc3MgQjogUmVxdWlyZXMgb25seSBhIHNpbmdsZSBE
TUEgZGV2aWNlIChvbmUgcHJvY2Vzcy9kb21haW4gaGFzIGENCj4+RE1BIGRldmljZSwgdGhlIG90
aGVyIHByb2Nlc3MgZG9lcyBub3QpLiBJbnRlbCBETUEgZGV2aWNlcyBmYWxsIGhlcmUuDQo+PkNs
YXNzIEM6IE90aGVyIHR5cGVzIG9mIGRldmljZXMgdGhhdCB3ZSBhcmUgbm90IHlldCBhd2FyZSBv
Zi4NCj4+DQo+PkFic3RyYWN0aW5nIGFsbCBvZiB0aGVzZSB1bmRlciBhIHNpbmdsZSBBUEkgd2ls
bCBiZSBjaGFsbGVuZ2luZy4gTGludXgNCj4+YW5kIG90aGVyIE9TZXMgZG8gbm90IHByb3ZpZGUg
Y29udHJvbC1wbGFuZSBBUElzIGZvciB0aGlzLCBzbyBEUERLIG11c3QNCj4+cHJvdmlkZSBjb250
cm9sIHBsYW5lIG1lY2hhbmlzbXMgdG8gc3VwcG9ydCBDbGFzcyBBLCBDbGFzcyBCLCBhbmQgQ2xh
c3MgQw0KPmRldmljZXMuDQo+Pg0KPj5Qcm9wb3NhbDogU3BsaXQgZGV2ZWxvcG1lbnQgaW50byBz
ZXBhcmF0ZSBzZXRzOg0KPj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPj5TZXQgQTogRm9jdXMgb25seSBvbiB0aGUgZGF0YXBhdGguIEFzc3VtZSB1aW50
MTZfdCAqc3JjX2hhbmRsZSBhbmQNCj4+dWludDE2X3QgKmRzdF9oYW5kbGUgY29tZSBmcm9tIGVs
c2V3aGVyZSAoQ2xhc3MgQykuDQo+PlNldCBCOiBJbnRyb2R1Y2UgY2FwYWJpbGl0aWVzIGZvciBD
bGFzcyBBIGRldmljZXMgd2l0aCBwb3J0YWJsZSBBUElzDQo+Pihwcm9wb3NhbCBiZWxvdywgd2l0
aG91dCB0YWJsZSBjb25jZXB0KS4NCj4+U2V0IEM6IEludHJvZHVjZSBjYXBhYmlsaXRpZXMgZm9y
IENsYXNzIEIgZGV2aWNlcyBhbmQgcmVsZXZhbnQgQVBJcywgdG8NCj4+YmUgYWRkZWQgd2hlbiBu
ZWVkZWQuDQo+Pg0KPj5XZSBjYW4gbWVyZ2UgU2V0IEEgaW4gdGhlIGN1cnJlbnQgcmVsZWFzZSBh
bmQgbW92ZSBTZXQgQiB0byBhIG5leHQNCj4+cmVsZWFzZSBfaWZfIHJldmlldyBvciBzdXBwb3J0
IGZvciBDbGFzcyBBIGRldmljZXMgcmVxdWlyZXMgbW9yZSB0aW1lLg0KPj4NCj4+QGZlbmdjaGVu
Z3dlbiBUaG91Z2h0cz8NCj4+DQo+PkNsYXNzIEEgQVBJIFByb3Bvc2FsOg0KPj4tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+VGhlc2UgQVBJcyBhcmUgYmFzZWQgb24gYSBuZXcgY2FwYWJpbGl0eSBm
bGFnIGZvciBpbnRlci1wcm9jZXNzIG9yDQo+PmludGVyLU9TIERNQSB0cmFuc2ZlcnMgZm9yIENs
YXNzIEEgZGV2aWNlcy4NCj4+DQo+Pg0KPj4vKiogQ3JlYXRlcyBhbiBhY2Nlc3MgZ3JvdXAgZm9y
IHBhaXItdHlwZSBpbnRlci1wcm9jZXNzIG9yIGludGVyLU9TIERNQQ0KPj50cmFuc2ZlcnMuICov
IGludCBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2NyZWF0ZShjb25zdCBzdHJ1Y3QNCj4+cnRl
X2RtYV9kZXYgKmRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ0
ZV91dWlkX3QgcHJvY2Vzc19pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJ0ZV91dWlkX3QgdG9rZW4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MTZfdCAqZ3JvdXBfaWQpOw0KPj4NCj4+LyoqIERlc3Ryb3lzIGFuIGFjY2VzcyBn
cm91cCBvbmNlIGFsbCBwYXJ0aWNpcGF0aW5nIGRldmljZXMgaGF2ZQ0KPj5leGl0ZWQuICovIGlu
dCBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2Rlc3Ryb3koY29uc3Qgc3RydWN0DQo+cnRlX2Rt
YV9kZXYgKmRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MTZfdCBncm91cF9pZCk7DQo+Pg0KPj4vKiogQWxsb3dzIGEgZGV2aWNlIHRvIGpvaW4gYW4gZXhp
c3RpbmcgYWNjZXNzIGdyb3VwIHVzaW5nIGEgZGV2aWNlDQo+PmhhbmRsZSBhbmQgdG9rZW4uICov
IGludCBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2pvaW4oY29uc3Qgc3RydWN0DQo+PnJ0ZV9k
bWFfZGV2ICpkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2
X3QgZ3JvdXBfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnRlX3V1
aWRfdCBwcm9jZXNzX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ0
ZV91dWlkX3QgdG9rZW4sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnRl
X2RtYV9hY2Nlc3NfcGFpcl9sZWF2ZV9jYl90DQo+PmxlYXZlX2NiKTsNCj4+DQo+Pi8qKiBSZW1v
dmVzIGEgZGV2aWNlIGZyb20gYW4gYWNjZXNzIGdyb3VwLiAqLyBpbnQNCj4+cnRlX2RtYV9hY2Nl
c3NfcGFpcl9ncm91cF9sZWF2ZShjb25zdCBzdHJ1Y3QgcnRlX2RtYV9kZXYgKmRldiwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgZ3JvdXBfaWQpOw0KPj4N
Cj4+LyoqIFJldHJpZXZlcyB0aGUgc291cmNlIGFuZCBkZXN0aW5hdGlvbiBoYW5kbGVzIGZvciBh
IGdpdmVuIGRldmljZQ0KPj53aXRoaW4gdGhlIGdyb3VwLiAqLyBpbnQNCj4+cnRlX2RtYV9hY2Nl
c3NfcGFpcl9nb3J1cF9zcmNfZHN0X2hhbmRsZXNfZ2V0KGNvbnN0IHN0cnVjdA0KPnJ0ZV9kbWFf
ZGV2ICpkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDE2X3QgZ3JvdXBfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcnRlX3V1aWRfdCBzcmNfcHJvY2Vzc19pZCwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBydGVfdXVpZF90IGRzdF9wcm9jZXNzX2lkLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90ICpzcmNf
aGFuZGxlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQxNl90ICpkc3RfaGFuZGxlKTsNCj4+DQo+Pg0KPj5QYXJhbWV0ZXJzIHRoYXQgbmVlZCBleHBs
YW5hdGlvbjoNCj4+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+cHJvY2Vzc19p
ZDogVW5pcXVlIElEIGZvciB0aGUgcHJvY2VzcywgZ2VuZXJhdGVkIHZpYSBydGVfdXVpZF8gQVBJ
cw0KPj50b2tlbjogUHJvdmlkZWQgYnkgYW4gYWRtaW5pc3RyYXRpdmUgYWN0b3IgdG8gZ3JhbnQg
YWNjZXNzLCBzaW1pbGFyIHRvDQo+PlZGSU8gVkYgdG9rZW4gY3JlYXRpb24gdXNlZCBpbiBWRklP
IFBGIGRyaXZlci4NCj4+bGVhdmVfY2I6IENhbGxiYWNrIHRvIG5vdGlmeSB3aGVuIGFub3RoZXIg
c2lkZSBsZWF2ZXMgdGhlIGdyb3VwDQo+Pg0KPj4NCj4+RXhhbXBsZSBXb3JrZmxvdyBmb3IgQ2xh
c3MgQSBJbnRlci1Eb21haW4gRE1BIFRyYW5zZmVyOg0KPj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPj5UaGlzIGV4YW1wbGUgZGVt
b25zdHJhdGVzIGhvdyB0aHJlZSBwcm9jZXNzZXMg4oCUIHAwLCBwMSwgYW5kIHAyIOKAlA0KPj5j
b29yZGluYXRlIGludGVyLWRvbWFpbiBETUEgdHJhbnNmZXJzIHVzaW5nIHBhaXItdHlwZShDbGFz
cyBBKSBETUENCj5kZXZpY2VzLg0KPj4NCj4+U3RlcCAxOiBHcm91cCBDcmVhdGlvbiAocDApDQo+
PlByb2Nlc3MgcDAgY2FsbHMgcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9jcmVhdGUoKSB3aXRo
IGEgdW5pcXVlDQo+PnByb2Nlc3MgaGFuZGxlIGFuZCB0b2tlbi4gQSBncm91cF9pZCBpcyByZXR1
cm5lZC4NCj4+DQo+PlN0ZXAgMjogR3JvdXAgU2hhcmluZw0KPj5ncm91cF9pZCBhbmQgdG9rZW4g
YXJlIHNoYXJlZCB3aXRoIHAxIGFuZCBwMiB2aWEgSVBDIG9yIHNoYXJlZCBtZW1vcnkuDQo+Pg0K
Pj5TdGVwIDM6IEdyb3VwIEpvaW5pbmcgKHAxICYgcDIpDQo+PlByb2Nlc3NlcyBwMSBhbmQgcDIg
Y2FsbCBydGVfZG1hX2FjY2Vzc19wYWlyX2dyb3VwX2pvaW4oKSB3aXRoIHRoZWlyDQo+PnByb2Nl
c3MgaWQgIGFuZCB0aGUgc2hhcmVkIHRva2VuIGZyb20gYWRtaW4NCj4+DQo+PlN0ZXAgNDogSGFu
ZGxlIERpc2NvdmVyeQ0KPj5FYWNoIHByb2Nlc3MgdXNlcyBydGVfZG1hX2FjY2Vzc19wYWlyX2dv
cnVwX3NyY19kc3RfaGFuZGxlc19nZXQoKSB0bw0KPj5yZXRyaWV2ZSBzb3VyY2UgYW5kIGRlc3Rp
bmF0aW9uIGhhbmRsZXMgZm9yIG90aGVyIHByb2Nlc3Nlcy4NCj4+DQo+PlN0ZXAgNTogVHJhbnNm
ZXIgQ29vcmRpbmF0aW9uDQo+PlVzaW5nIHRoZSBoYW5kbGVzLCBlYWNoIHByb2Nlc3MgY29uZmln
dXJlcyBhIHZpcnR1YWwgY2hhbm5lbCAodmNoYW4pDQo+PmFuZCBpbml0aWF0ZXMgRE1BIHRyYW5z
ZmVycy4NCj4+DQo+PlN0ZXAgNjogR3JvdXAgVGVhcmRvd24NCj4+V2hlbiBhIHByb2Nlc3Mgbm8g
bG9uZ2VyIG5lZWRzIHRvIHBhcnRpY2lwYXRlLCBpdCBjYWxscw0KPj5ydGVfZG1hX2FjY2Vzc19w
YWlyX2dyb3VwX2xlYXZlKCkuIE90aGVyIHByb2Nlc3NlcyBhcmUgbm90aWZpZWQgdmlhIHRoZQ0K
Pj5yZWdpc3RlcmVkIGNhbGxiYWNrIHdpdGggcnRlX2RtYV9hY2Nlc3NfcGFpcl9ncm91cF9qb2lu
KCkuDQo+Pk9uY2UgYWxsIGRldmljZXMgaGF2ZSBleGl0ZWQsIHAwIGNhbGxzDQo+PnJ0ZV9kbWFf
YWNjZXNzX3BhaXJfZ3JvdXBfZGVzdHJveSgpDQo+PnRvIGNsZWFuIHVwLg0KPj4NCj4+DQo+PkZv
ciBDbGFzcyBCOiBXZSBjYW4gYWRkIG5ldyBjYXBhYmlsaXR5IGZsYWcgYW5kIGhhdmUgbmV3IHNl
dCBvZiBBUElzDQo+PnJ0ZV9kbWFfYWNjZXNzX21hc3Rlcl8gb3Igc28uIFdoZW4gc3VjaCBkZXZp
Y2VzIGNvbWVzIG9yIHdoZW4gaW50ZWwNCj4+d2FudHMgdG8gYWRkIGl0DQo+Pg0KPj4NCj4+DQo+
Pg0KDQo=
