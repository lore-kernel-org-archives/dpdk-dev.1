Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C33C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 04:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEAD740289;
	Wed,  5 Feb 2025 05:50:37 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5327140270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 05:50:35 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5153UIVr020824;
 Tue, 4 Feb 2025 20:50:34 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44m04s03n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 20:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq/09lmo9afq3bGi3IVCqPFQZq+cXFLN4h8NfJPmM75viL3kiDsvKaOFvagWwcgDwwqOZyUYm11ubtVBuJQuuhSBIj8mmNyKsZAv5pIpkZq9KhYsLQqGfD69ZNroizu0f5bgoblz/hVgVYEAN0sSwOZREAcNCaSzGPzDaS/nHDmGwz1pp2hzQV6rj/yucBZgCRq9Nx1mmpYco5OFYoV+toYXJnfkNbKHQEWQwZ+fdmHS52+fuC7bXbHVRhgihomcTLU6bnP0BVf+Mnrez/+9Xj9GPqaj4aGkckbdWn/tv4LmQzCWferY/ZH+eHoq7uByWbBgHNIt30SML/WWmpWkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NUrPDYOEUZC4PhJEDhOUTCtwi0R9SRQPbQnH1QPZWk=;
 b=NHOaiwamVwvBz3mGfcD41c6lnry40z3Zno6SpI7d5VPK7oZwXNtWAwzLoflEzfWbThqoVVIBLDUD7+j0WftEGqC/J9o+2bVzvMT1D6dEpcs7u26twgvoMr+fkhNbZ61NlEOPURRX1I+ERcP0mtVq+PUxDmgZXkarnwfzz1x45sPyeTFaJFr1V5okrdM+sZkCW2xFc7rVfu6O1GbXKjTSKfBKX8DhNg4ijam235vwlmY3yyU5GnTm1PVNZJFV0dJg8B7E2P/Mn9JmGM1RP2FBDPEcsZHwBW6+4Y5Dz9IKOnPt0AoT9xo0PzXMu1MMVJ5T6+/s1x1E0Oe1DkmI5G3afQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NUrPDYOEUZC4PhJEDhOUTCtwi0R9SRQPbQnH1QPZWk=;
 b=e6WS6Vt9WLso4sMB6ev6uF6DuXS0kASk6uub7UrwQe0aLIMDBsvuSwze9lNNnQHUTwFaeUz18kddGVlKz/CqNjBUQ4iMyLptx59CPH6dYt+srWajABFhusS2g6UaAm4vYYcuDa3d7A0+nBXopPErqctDJH4pk7FY6YFAIWx+S/8=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by PH0PR18MB4767.namprd18.prod.outlook.com (2603:10b6:510:c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 5 Feb
 2025 04:50:29 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%2]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 04:50:28 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access
 content of __m128i
Thread-Topic: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access
 content of __m128i
Thread-Index: AQHbWMcSf5EBk7JKdUCXHUt6PQF5CLM4X+cA
Date: Wed, 5 Feb 2025 04:50:28 +0000
Message-ID: <MW4PR18MB5244483B1E4E5BC7D58A452EA6F72@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <1735328684-10684-1-git-send-email-andremue@linux.microsoft.com>
 <1735348983-19590-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1735348983-19590-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|PH0PR18MB4767:EE_
x-ms-office365-filtering-correlation-id: 489750f8-d0dc-4b6f-c61c-08dd45a09cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?V3dtMTVnRTI1bjkyVVl5TW9VdDc0QzdYQjBWNTZnWkRQQmJ2ZUlhR01hMDR4?=
 =?utf-8?B?Q3JtclVkbHM0Vng1NGhkV3pOMGl2VjZHWGhyYzBORnpaWkdadmdWM2ZSdWFS?=
 =?utf-8?B?bEgvYWJMTHdLa09ZcG1JR0NJLy9zbTljbVdNNGV0UzF2Mi9RNU8yd0FHaGx3?=
 =?utf-8?B?MjN4NEkrdW1NYXBxa0pUOFE4V0d5TTUzT1lzTkdOSlZJbHI0Y2Jvb2ZUUmJB?=
 =?utf-8?B?Mk5DTThSdEllN3pLZDZLSHBpVS9IZ1RURlVwTmVnTnZ5TFpQMElCNzlJUFJy?=
 =?utf-8?B?QTA0WFJYN0VES2kvdERWWVB0dW1SNHRlQ1N2QW11T21mREhsMEZyV2dpajIv?=
 =?utf-8?B?eFpTMFhQUGpzWE1nMytKdHZyNXkzL1V3SEowZ2I4MFpSWTErSmRuZFZGUDZa?=
 =?utf-8?B?S0JjZm15MWZWUnBhNHBmL0Rnem1ld1l6UDg4Y3NSTlNvSnZ0SWpGQnFHeTlw?=
 =?utf-8?B?TWZMK3lKN0xVcDV5ZUlTc2tGeEtmUEJ2SzY1Mkx6bTQ4YUlOUnlSZ2FobFNX?=
 =?utf-8?B?RjZZS0JUODlQWXZPSzNMZHhiMFJyVkRwWmxseE52NllsVVZCeHZPdzQvbFV3?=
 =?utf-8?B?cGcwck42R2l5TkNZWUpMNENmcUpFQlBGdkszdjJpOThnNERETzM4RitKSHg0?=
 =?utf-8?B?dC81K0JsVlRURGR1TjFPdVVrY3k5Y1Azc2tJc2pTREZHTVQxR3VLZVhGdk1N?=
 =?utf-8?B?ZmFzV3lydndoMEhKbmY2NU8zWHdFTzNPc2tBcXRmeTdpa2tISURydDg5VEFV?=
 =?utf-8?B?ejhrc2N2ZkViRzJSRW1GOHN2NkxxRXhTL3BBcHpON1Z4SktNUlorakwwU1dh?=
 =?utf-8?B?RWoxL0lVeXhSTE94RXEyZlFFVjF4SXpiUVFRVXJpYnhVdFRtYTRSdlNyL08v?=
 =?utf-8?B?YlNudmc5UW1jTmZ4NFptK2lRSUw4eEEyTWwvejVLK2loaUh2YjNFakNkNTJm?=
 =?utf-8?B?QTQyYXBxaGphKzlOZnhkK2VyTStHaHZpUXlOZjkxT29aME1YVmt5UCtVTUgx?=
 =?utf-8?B?K012Wk1sd29VdGtINFh5VHNKbE00czl2czBjU2xIa1dIZXpsditGN3FLaERm?=
 =?utf-8?B?WXZBeXk3M1BuWTM3c0haZkw3dFlTS3NSb1dtVTZRYkl2S0RlT0h3ZmttN05m?=
 =?utf-8?B?eVkvUS9JRTBBSnY0eVJlTjIya2IwTDZEUFJvbmRKNlcyZlYzaEVyUEUrSHNP?=
 =?utf-8?B?UWpMQzhsWmg0Tko3R0tlaDhuU0RFVVVwRzZCYnNMeUhUSXdzbzAwUk1PT3pJ?=
 =?utf-8?B?SzEyL0dEK0FaWm5adGdhZzI0Vmc3NGZPUURoZXl2Umtab3A5cENOK3U0bFp5?=
 =?utf-8?B?Wk5uSWJMVzBCdWRpeU9RWnpDUjJJU2xDeUIwMG05VTIvM3RzdHArTnVYamhr?=
 =?utf-8?B?RFhIYnhYK0VPTjZYYXNlVmVSUHNtQjk5MlpUZVBrVTB2MEY0dXBLSnRaVi9J?=
 =?utf-8?B?MzBGUHNmYU80c1ZjVnZpQ3p0akt6eXl4aUV0c3VFNGxpUEFUUm9uTlRPc21O?=
 =?utf-8?B?eGtEdVNvZU5CcWUzcWN0ZTh0cGtSQjNiR1U4azRSWGFDWkZrd0NPZzREbXgz?=
 =?utf-8?B?WldaaWZObkNzQWxTeFBLemxIVjJUQ1Nxa1ZSQ2RteHhZc0hzME9PMWpkazI5?=
 =?utf-8?B?VTJHLzRKZ0ZrbDg1ZUV1Q2ZrRWI3STcyN3FkbDh6dmFjblFmSFM2TFcyY0kr?=
 =?utf-8?B?MmVtT2o0YjBNRHZsTG9JQmlldTYvcTdjNjRsb2hzSUFsakxRZ3UvZnJ1NFhN?=
 =?utf-8?B?eWdqWEFZZm9sZ2k3dFNpSGZuN0l4ZW5keWZ2NU5LS2Mvd2Jxbmg1S3MvYjdp?=
 =?utf-8?B?TnlpQlpKNkg2ZFNOak1yeXBOanlvSHR1Vk5FcTZlOGZqellMSHdpQk90MlRl?=
 =?utf-8?Q?Unra7yK1eHwTz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR18MB5244.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1prU2NmOWJwV0JnWVE3TTBLQVYveEw2bktJeUF2dk5PVEZWSDkza0I0aC96?=
 =?utf-8?B?ajBzVmFDTU93TmZwa0h2UlV5SEtiaVFlQm9WblA3bUQ2SGNHR0NhejBKelJ5?=
 =?utf-8?B?YVlua1daSW1xc1BCMkFhUWdjbFE1ZEVLYTVLS1Z5U3ZITkVDQ3RqcXhtUzRo?=
 =?utf-8?B?MXB3dHRwWmIvOCsyZVRNMkZWSmtlMERsWU0ySnEwL3J0ajdwQ21PQ0c3R1RP?=
 =?utf-8?B?c3FMSWU5b0ZMRkN1aFNsVHcyNTlwQmhKLys4cFQwT1lLT0dhUGpVdUJYckt5?=
 =?utf-8?B?OHZFaUQyekg0SkV2NzFEL0NxdGpYeW9XQVRkYm8wU2dDdVFhRkJOVXJyU3dO?=
 =?utf-8?B?b3pmbGZXbUliQU13anhKMitabkhpU1JqL1BDSDhJTVRsOEFYQkgxZGt4Njhk?=
 =?utf-8?B?VWcvTkoxNzNoWjV4MHpTUHdhcUVyZFFYNnFCb0lFZlVQWFNRTlFxdUNEMTg2?=
 =?utf-8?B?UU1pYUU2TWtlZysrdExQaHN2c2ZRVGg4NklxdHB3QjRkSm1SNTN1cEFkT2la?=
 =?utf-8?B?dnc0Y0R1OXhJVW9kb1dBK2xMVHlxa0ZNQWN4ejQwVUkvenJ3VmM2QlhBUlVW?=
 =?utf-8?B?Vk9wMWllQXhqclFIbW9ZV2Z4bis1SVdqV1g3dFBYSTVEZEJXMkNMeUx3aVZN?=
 =?utf-8?B?SkZsdzJMMVEreFpCaC9zMXgzZVlTSzNvRnBodW5PUm8rM2tLMGs0NnY0QkhS?=
 =?utf-8?B?SVNDaVRFeGwrdEZmbWo2VCtCTWhIYVNQU1hBUDZvenplajVseS91b3lRNGY5?=
 =?utf-8?B?NUhZZzFoQkdaWTM3aU9YVFhqUlozeEdLdEUxdVp2YjlqZzM1SktiaXFsUkxw?=
 =?utf-8?B?emJmeEk4WWJ3TGdEaFovNmVYcHhGWGZLYXdrTzBDNlk3Umdob0RXcmJFRnpt?=
 =?utf-8?B?a3pkbXBlZnF1L0pQUWJ0UlhMZjRSaE9OVXRrVm02OWJieE5XK2JTUjE0dlFX?=
 =?utf-8?B?bDdrRnI0T1dtbnlpYnZlYUdaZ2dyWHlkRmtrNmtSOWxQYi9Dd1h4RDYxVTdS?=
 =?utf-8?B?Z1Z1bFRpRm5OdEVSL1JUQTZUYTBER1FSMXkyNXRwVzhZVXg1ZFMzQ00xaVds?=
 =?utf-8?B?cmI3cVUrcUdRMWZHR1A3RlpNOVI4TXJqbXE1WFMzZTVCaHFNZllUTFNtOWFy?=
 =?utf-8?B?UkhXbDIza1FZOWI0Z0laZkFlcHN2K3NESnZwNVh0UzcvUkdnc1NINUhVdzNB?=
 =?utf-8?B?eVRPMlpCRXFIeFAwam52eERTWWt0RkdNRlEwU3RLM3l4WEp2dEh0K1ZKZWlm?=
 =?utf-8?B?aGpBN21MTjlISGFacFpkd0dUWncwWkkxa2FINzF2TFJZTmdlUk5qa1pmc0dt?=
 =?utf-8?B?VXVObU9zTFNjOHRUK0U5R2FsM0xxSXNRSGRkRHU5Q3l3eGk3ZnlyMVZaVU1z?=
 =?utf-8?B?MENORTluZlR3WVdOOVljS1RhTXAzVVF4QkFQaVp6NUxyUkd3ZTNad2lrNXZ5?=
 =?utf-8?B?U2pZWjlWbGp0dW5PTUlMWWZkeG1HOFlScjVONTk1MkxmQ0R6Wk40aXpFZEVV?=
 =?utf-8?B?UjdrMERSRmdsQWVuZGxXTlZCT04yUW11WHo2WWdMeVFja1R4aGFneWxEVkdC?=
 =?utf-8?B?bDVWbDk4NlNaVjRIZk4zd2R2eVV1VFdNV0JLZUlGY3VjdjMyNHo2NVk4QU1a?=
 =?utf-8?B?aVNLc1hVK2lkMEZzTU1xWjRYRGkySytQVnZ1a05XVnlXRDBuV2Yvd0lyVXJT?=
 =?utf-8?B?SnUwcEdBUjVURUpjS01BeHNyT3ZPajE4ZzZlOVNXTmRLK1BVSmJZbXlLZ3Bo?=
 =?utf-8?B?L0daMTFiY1dnNkkvZEVEVlZXdlB4OHBucHl3NjBDaVdUUENiSG9NQnNLOUpX?=
 =?utf-8?B?enI5K2ZwK20zNjlyWWhFemJLZGFEdFI2eWJoVUVwemhHelk1ZFY2SW05dDVL?=
 =?utf-8?B?eUpkVElpN3orUlUzbUVXQ0JwZDBoZm5nT0NnWEY5M0VEejVoeVZFcVcyb3Y4?=
 =?utf-8?B?aVQyMDdkZzREZk92L2t4YzdPZTl6c3hwdEF6VHZFMjI3eGRpekl4U0hxbEJM?=
 =?utf-8?B?TFlCNEQ4L2J4UVF3WUdONVdtWUYyZEM0QUViQXpyT3EyNkM5N2xoa242ZEVR?=
 =?utf-8?B?bGxTcnRtbXZsVVViT2FXL1MvTjdZY1Fob2RXTGxBeS81M0JLT092MWxaUW5E?=
 =?utf-8?Q?pgqjJyaO8iwlQSKL3YRlzcdBf?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489750f8-d0dc-4b6f-c61c-08dd45a09cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 04:50:28.5218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlCSsK+6m+lH0byU8yKfEKn/Z5r77BTy/yXn/FDw7E9NC2jwyAJnGSjPcRl12PNCzsgA8k3RpGHLb3c7F/sQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4767
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: kPbyrKfPxPuTGzLVELqKKzMi-UJQ15vU
X-Proofpoint-GUID: kPbyrKfPxPuTGzLVELqKKzMi-UJQ15vU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_01,2025-02-05_01,2024-11-22_01
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



>-----Original Message-----
>From: Andre Muezerie <andremue@linux.microsoft.com>
>Sent: Saturday, December 28, 2024 6:53 AM
>To: andremue@linux.microsoft.com
>Cc: bruce.richardson@intel.com; dev@dpdk.org;
>konstantin.v.ananyev@yandex.ru; Vamsi Krishna Attunuru
><vattunuru@marvell.com>
>Subject: [EXTERNAL] [PATCH v2] drivers/net: use intrinsic to access conten=
t of
>__m128i
>
>Compiler intrinsics should be used to access/manipulate contents of __m128=
i.
>Existing code results in the error below when compiled with MSVC:
>..=E2=80=8A/drivers/net/octeon_ep/cnxk_ep_rx_sse.=E2=80=8Ac(61): error C24=
40: 'type cast':
>cannot convert from '__m128i'
>
>Compiler intrinsics should be used to access/manipulate contents of __m128=
i.
>Existing code results in the error below when compiled with MSVC:
>
>../drivers/net/octeon_ep/cnxk_ep_rx_sse.c(61): error C2440:
>    'type cast': cannot convert from '__m128i' to 'rte_xmm_t'
>
>The fix is to use an intrinsic instead. This compiles fine with gcc, clang=
 and
>msvc.
>
>Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
