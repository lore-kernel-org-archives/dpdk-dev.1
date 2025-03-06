Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15027C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEECA40B94;
	Thu,  6 Mar 2025 18:29:00 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by mails.dpdk.org (Postfix) with ESMTP id 70D7740B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 18:29:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMFR/1QWcxvmLsO2YZ6A9+jN8ylqib0q+fQ7etPKD/ybXBhE9fHRBjSFCHuzMBTj8xP5e3zhBxtWuTonSRan8TqsDb0O33bXLoAoIMoM51/MFgSWz2u1lHZExH/yr+ndExEL12yhxG2M4ArWqWaY4k+koDfBtnn7kj5euyOdCz3NCN0gHRsbq8tgOH2coHuYoj5THmU0d90XVGn68eNaOnoKcM+eQ7C4dcvVMV/q4CRLnWEaJYHBe14NVSLXQh3LvvHMUlG0HFm3ApPwoifigpNLCblLzdcrtz5ErhZmu4LqFJj2E9fHTqvrWSSGfQUsjegr3ePwqfpVAaDpFTvyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98lAv49oxX5GhvlgigqRGGCj9F3hq6NrXAabnilhQ84=;
 b=UIBNMcGf5cztxYE7XFRJzyytOJw3fqCkNq59eexgxVVTdHPk4O7aLP7fvtGzyNunHaPuZhOwcTKqnjLtns7HjyvSh2mR2fUASVELsOSv+bxgZkkPmHZCihbZbLyVYsKeEdK/bYgfqPbcOxTMUiheVVaEpUX37UpOeviSpzz3Q0+hVRlml8PKlf4iNQ436MF/M7jPB5+32eXJ/rFG/W8VGSHGLAcKVk21TW43+nF6nj1z48LLqnDYMMRV1NPmaYHaIIf3ipxfTfFaD02xVrqq69D27KHVIvGFWgTxB05W4aGWZBPxbUhQe35C9ywZMbJ+EmjU6/IXUlbUH07dcrpJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98lAv49oxX5GhvlgigqRGGCj9F3hq6NrXAabnilhQ84=;
 b=Udp8y+gzJfqcmKAZIyTOgB5ZTnRm2SgdaU7ejiP2yrR4B5Tz3O9fE/ZllMvrpU6rObMXO2ju1PDA/777MXttxXL3a27u5EmDv+jZ4tUa8/MgPZF7hZhyGQgV6hQXWXgrRN2oljT5CdibO17wwd0s5I+EW2tDcPQK6q7xF1FuwezrMensOfFWdKEgk0rC/eLhLOW7TT1An3/v0KzZPtefu+IRsHZp8ldfFs/kHWvl9TlqbvqTB2S07hienHVyVAck9syRw0wVScI2gjTFNqnkeQFPUH573Sr4LVG0YCrrd9PpUE0gcZW2eWmjkQmWei8J1MBeVMSHl2wocl1AdwS31g==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:28:57 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:28:57 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Plague <4plague@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Maayan Kashani <mkashani@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>
Subject: RE: [PATCH] doc/guides: Mention needed kernel option for mlx5
 multiport e-switch
Thread-Topic: [PATCH] doc/guides: Mention needed kernel option for mlx5
 multiport e-switch
Thread-Index: AQHba0WxZXPFDHA9AUuBvlbuOGTTjbNmoWFQ
Date: Thu, 6 Mar 2025 17:28:57 +0000
Message-ID: <CH3PR12MB84606FEDDD2A64BC6C209D1BA4CA2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <CA++ArTh+qoX6RDUSe6VzpxXmKCSd_YaL-Hmex6ec5ExY-r_qRA@mail.gmail.com>
In-Reply-To: <CA++ArTh+qoX6RDUSe6VzpxXmKCSd_YaL-Hmex6ec5ExY-r_qRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH3PR12MB7548:EE_
x-ms-office365-filtering-correlation-id: b17f0cda-3afb-4ff0-66ca-08dd5cd46060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RHh1QTNCUEpYNVBqRUNuUk15SnQ5c1pVZ2V0NU5tcGFCSngybVlxQ3lnOXZL?=
 =?utf-8?B?cXgrSmxYQU1mTkkrN2dXbEl0QThvT3ZUbmpSZEhLOVVQS0xCYzdPQ0tjUGp6?=
 =?utf-8?B?TDhsd3dRL0I2SWY5WGowWk5NRm9GU0VnSmIwYnRGQytJdzl5MkdlKzFacjB5?=
 =?utf-8?B?MTZoT1o3UEtMMUIwdklrMFpOQTNHQTFQckJta0RKdTFpUmdvN1ptaitGbmVq?=
 =?utf-8?B?SGVTZVdlUkNEbzhEYTFvWGdzRzlDcTZMZ2pscGVEVkFxaEEwMEwxeTArMElI?=
 =?utf-8?B?UEFNNmphK0d4aFZ3aHpDZndGNW5Qblh2YVJsZjFmSXkrS0I2NmFjZ0IrZStK?=
 =?utf-8?B?dDBJazRvam1HYXhIbFFwVUpKOFNUSWd4Znpqbkdpdm1uL2pUbmtyNDlWNlVi?=
 =?utf-8?B?ZVYzU3NaTzB2Q2JzWEJjaDlhK1hWRnpDZklJZDFIMnN4eWUyQ3pmNkRUWEZu?=
 =?utf-8?B?SVpiTnZoVG0zTnNmOVpFK2R5UHBNQW9yWjdTL0VlRFlnbzBIRHd4VkF3WE5L?=
 =?utf-8?B?MTlBS0JWQnlKci80Q1A3TVpqdzJQWEZXVkt4RFFBbHp3Mm12bzAwSHpNK1V3?=
 =?utf-8?B?VTc2UFgxZ3l1TzdXSGZJSVFUdmtKa0ZqMk5mT0hLMGY1eHhmdW12M1pTOHZp?=
 =?utf-8?B?VzQ3RTIzMEljbWZVdzJWbmVmNmJPOVRpbWs3QkxLOTZ1ME16alFXNzQzNVlv?=
 =?utf-8?B?aFgzZzE1dkRtY1JoSjdzaVRjSVpTTEE4d01HbGZkcVQ1ZVBOdExPamRkTGQ1?=
 =?utf-8?B?TVhBd3Mwd0dGY2VBeDJLMkVMRm1zai81dHNucDFQLzArVERzMGgvamtET0lN?=
 =?utf-8?B?eEp2ZnJxYlZMRitOTlh5ckJqNUhIc1VRM1Nad1hWa0ZVT0FYcHZHVmp5RnIz?=
 =?utf-8?B?ZDJaYjhSYnR3Z2tLVHEwY1V6bW1FTjZoS09QT2pDYjc0dW56MU85dVpJSEx3?=
 =?utf-8?B?ZGpuak1FMVk4RWlWOWdyTlBZaFZHWGZubUVTNkE5T3ZqV2ZObnUwMEloNG5v?=
 =?utf-8?B?aWJMRS9maUp5ZHRVN0xXb1NZeWRTTkZPUnJ0bkN6QW1xTXJuNVdnQzY3dk4v?=
 =?utf-8?B?NnQwMkZHeHRKaXdVRWo0QmdDSVVsRGEvU1Fhcml2dDJadWs5ZkF4WmszMk1V?=
 =?utf-8?B?VnE3aHBmRTlIVWRyR2IwbytERVJ6NHhSbS9TQ3hOYjFHVXNIbUYrSGFLTG9q?=
 =?utf-8?B?UEpXMEVaKzdSMWpndDJXVGdocDhGTkU5SFdUb0hFVVZjSnNheEg4MW9sRllS?=
 =?utf-8?B?S1lIbGorZ1pYai9FS2lXTmlIQ0p5UUxFbThnRU9WV1p1U0I4SFdlNU5RQTJl?=
 =?utf-8?B?Z1lNWW5icTJNSXp4Wk4wWnlocWU2M3l4NUcyMkF6TWhHWnNneFhHVmYzd2FF?=
 =?utf-8?B?dklTRTF0azY3U1hDRmhoUDBTZGJwU3NHZ0w0eXB2TjNYaThYazlJTmxTc1hN?=
 =?utf-8?B?c3VlN3NtNW8wNmdUMjhXeEdrTmk1azlRdkZHVm5hLzVRK2FTNmRSaGpuaDlp?=
 =?utf-8?B?dzlDN2xPNnkzN3pYbm4rRk9Wam1uR2d2NjJCczBmOHc0L0lycmFvNEYxMFFD?=
 =?utf-8?B?b0ZTUG50RVlQNWtOQkZuWWR4eDRISlI5Q1lzRmhTYi9aSEJlSUdjNlBUYnNG?=
 =?utf-8?B?Nk1IYm5GQThlQzcwSWR6dFVBcDNDbTFYdkp4emc2ZFo4eit5VFlVcVZSSzRm?=
 =?utf-8?B?T0pmWDY2NGN1ZEVjOXhiZlFCRkc4S005UmxsdE1GUEZaS0JDVk9BU2Q3a254?=
 =?utf-8?B?OWtETFVlWXRLZTNRc0JjbDBCTmlFdDBBaHhGRHVCaHl2NSt4Y2FkYXhkdjhy?=
 =?utf-8?B?MUFZdUJLMFliSGd0QnhkaVdMcktmMXdjUDIzajM3dEhBQm5lbzMyZ3BXTUtw?=
 =?utf-8?B?WXcvb3NYSXZYZ1RJR3Rmc0s0cHFtZlBzTFJ1NnV3UXV0eDN2bTladklaS0M2?=
 =?utf-8?Q?+Rh6YyJ50j5pHKDeJAD33n2tzV5gJBu7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEJqMENxTlIwSHI5YzFhaFlVbjFOeUs5S0dva285dUJDK00rYnlRNTJsdjQr?=
 =?utf-8?B?THBQdFRCZnhNMnJadllDM0pPdFVDZ3h0TXZTamZNTmE4M3ZpVlFSOFNhUlZ1?=
 =?utf-8?B?WjQ3cUIvZTE1RGkzR0xhclA0UEpsbkQyR204NFphdk5mOFpYWXJQV0VuRTFu?=
 =?utf-8?B?T2Vqc2toUUY5Tnpud2RxWkhRNUZ1SHQ1Vk52eUJmQ0pDZ1BDVW9NZmdVQ0RT?=
 =?utf-8?B?ZTVZcXNNL3NBVEViVWZhRGhzM1BWUXY5Y045RzJNZjE4UkFObFFGM2xMa0Zn?=
 =?utf-8?B?TXVqTWU0TEt0S25IQWpibWJoTGlmUmRONi9yaHlOb2xqNHI4bkU2cDhVS0xr?=
 =?utf-8?B?QzRnNTcyWnlEa2kxQnU5VERkc0ZaUEVyUkhvWVlwMDNnRDllY3VDcmxZUTJM?=
 =?utf-8?B?WU12a3JjU0t5eGJ1WnZGYUp0Yk9wcDVTQkJTTlcrTXJ1NGkwK0tOQ3ZpMm5S?=
 =?utf-8?B?c2oyUW45ekpxY2s0dnRvem9POEIrUEREbVVYSEZjK0FWeE9ZeFVucTNOWkR5?=
 =?utf-8?B?M083Szd4RnlVcStRWEZHb3dvT2N2VGc3SjgrQlRlc3FkV1IrUTFEK0pLRjRW?=
 =?utf-8?B?MDhUckJXcmZNTGFCVzJBY0NDQm41MTZXeThRZFUwQjVnMkhTTTMvOVBvQTJt?=
 =?utf-8?B?bVRxSmFyODZOdEpXM2p6TGNYU003UGR3d1NHWXZzR29kc1psTjI5MjZtek0y?=
 =?utf-8?B?S3JhNkdGWjFtSmhRVVRNTFJHUzQ2MEZYZGd4NUFxaEZsRCtLMjlwSW1wa3N6?=
 =?utf-8?B?azd3RlAyVW50WXh6a2FaZjkzUWs4MW9iUmRIb2srKzczZ1FZTDhoMlk5bTBV?=
 =?utf-8?B?T1lzQjNpNXoxZmJVbVRXcWFzaGJzWHdyQ3h5dzdVRlVDcTZQWDdFU0I1ejJo?=
 =?utf-8?B?d3BMQmtrOTgvRC9CeUhCdlBHZDRVdWNHVEx2ekNSQVUzTDEvUDAvaVBvWGFq?=
 =?utf-8?B?YXVvQXJEbmgvQU1RV0tCT0pxbkduQzROUjBFeUhEWlhHVVdqTjVjQndyd2RF?=
 =?utf-8?B?dWVmbGMrMGtsTVNXT3JEL25MTlhESFUyWko1L2NyaTB6MkpSc21qdnc0eU9i?=
 =?utf-8?B?U1VrTjFNZGlrNjRTMmhBWVRJR3VSNFhpd0NSdmtTSHFXd3BzRko5aHlkaE94?=
 =?utf-8?B?TmdRSmV5bjF6c3RwS2xUMXpNdW04alNxdDRXRFoydW01MjA0YlUvOTFzUzJ2?=
 =?utf-8?B?VlAvQjR3ZUdJbVo1MmlSOFJCM0pRUHV2c1l4WVZ5VmE2aWw4UzQwbzRIVThI?=
 =?utf-8?B?NGFVOHYxMTFuaTBsNW53a3BFVWZDQzNvbVdZU2IwaFlWUlhTVmpaRkd6b1Vh?=
 =?utf-8?B?RmlibE5SUnRhTnduWnA4V0YvYitlRjM3cEhibU9PMFNqRDc0WlJlRFNjZ0tU?=
 =?utf-8?B?VTBUSEo0L1JGQWc0aytCdno4c3YxMTJudHM0dWhXajg5Y2Q5MUw5c2ptQnpk?=
 =?utf-8?B?aCs5dnhVcGtialpWRW1ucDJIS0RXbUs1aU4zWHVnZ01zbEN6cGtFVy96ZlNm?=
 =?utf-8?B?ZngzcXRNaWlidTNSeks3VXVtV0J2SmIrZnhTaWdQZVRSUGNPM3h0WTMvR2Vn?=
 =?utf-8?B?bFZ3bHp2Ymtud1NzaXB2QXlnUkU2U2htbXZLQm95WFMxV3FmK3lRNVRGK0dl?=
 =?utf-8?B?UW5oR0ZnYXJUS1l5OXpVU25NdTR4RzV4QTRObmtHaE9YdzhjNlp4YngvdU5p?=
 =?utf-8?B?Sm5sYnlKQUdXejMxRHh2N1JPL2hiMTRmTm53MFQ2c1BkZ2hNUHJIOGd2SWlE?=
 =?utf-8?B?SStaOW9JMFd5Y2RMOWFYelVtUlFtQ1Q1S0dMNWs2V3A2eVo0Y0NHU2Z2TGlL?=
 =?utf-8?B?TWFsQXBGV0V4SXIvWGhCQTlIKzBIcHJtNW1Fenlic1N6amdmclRrV1ZTU1RW?=
 =?utf-8?B?OWg5UkJSSEpPeVNTc2V1T3RSZnpPYTR5WGZWbUJITzRkM3B2a05VcFdERlRR?=
 =?utf-8?B?VVBhc1I5ZG0wUlltVkJTbktnM2lEc3IwZWw5aEd2dFBSTURTWktNVGVENm12?=
 =?utf-8?B?emU3VTZSSDg5UFgvZktDNnFMV2hCelQ3WEI2VHl2YTNhZS8rcy94Sk5BMnRU?=
 =?utf-8?B?d01FZ0ErOFNGTjZCblJmKzVETGh1Q25JN2V5STMyUlBMRTF2KzBHcm95OVpi?=
 =?utf-8?Q?IzmYcgeVSFN5hTd7RoeHw4DMG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17f0cda-3afb-4ff0-66ca-08dd5cd46060
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 17:28:57.6209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFZKlqt1hYVsiMaD3se1EY15YZLIxR3TC4NDcZLenh9Q1ub9dUD0Hl3FsX+fNwqs5uyvYrKAJenbjN9c4fWHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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

SGksDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBwYXRjaC4NCg0KQ291bGQgeW91IHBs
ZWFzZSByZWdlbmVyYXRlIHRoZSBwYXRjaCBhbmQgcmVzZW5kPw0KQ0kgam9iIGZvciBjaGVja2lu
ZyBwYXRjaGVzIGZhaWxzLCBiZWNhdXNlIGl0IHNlZW1zIHRoYXQgcGF0Y2ggaXMgY29ycnVwdGVk
OiBodHRwOi8vbWFpbHMuZHBkay5vcmcvYXJjaGl2ZXMvdGVzdC1yZXBvcnQvMjAyNS1KYW51YXJ5
Lzg0NDUyNi5odG1sDQpJdCBhcHBlYXJzIHRoYXQgc3BhY2VzIGFyZSBtaXNzaW5nIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgZGlmZiBsaW5lcy4NCkFsc28gbmFtZSBpbiAiRnJvbSIgZG9lcyBub3QgbWF0
Y2ggdGhlICJTaWduZWQtb2ZmLWJ5IiB0YWcuDQoNCj4gRnJvbTogUGxhZ3VlIDw0cGxhZ3VlQGdt
YWlsLmNvbT4gDQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAyMCwgMjAyNSAzOjE1IFBNDQo+IFRv
OiBkZXZAZHBkay5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBkb2MvZ3VpZGVzOiBNZW50aW9uIG5l
ZWRlZCBrZXJuZWwgb3B0aW9uIGZvciBtbHg1IG11bHRpcG9ydCBlLXN3aXRjaA0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMgDQo+
IA0KPiBPbiBzb21lIGtlcm5lbHMgKERlYmlhbiA2LjYsIDYuOSBhbmQgNi4xMCB0ZXN0ZWQpLCAN
Cj4gdGhlcmUgaXMgYSBtaXNzaW5nIG9wdGlvbiBmb3IgIlRDIHJlY2lyY3VsYXRpb24iIA0KPiB0
aGF0IHByZXZlbnRzIE1MWDUgZHJpdmVyIHRvIGluY2x1ZGUgQ09ORklHX01MWDVfQ0xTX0FDVCAN
Cj4gaW4gdGhlIGNvbXBpbGF0aW9uLCB0aHVzIHByZXZlbnRpbmcgUEYxIA0KPiBmcm9tIHByb3Bl
cmx5IHdvcmtpbmcgaW4gbXVsdGlwb3J0LWVzd2l0Y2ggbW9kZS4gDQoNCkNvdWxkIHlvdSBwbGVh
c2UgYWRkIHRoZSBmb2xsb3dpbmcgbGluZSBoZXJlPw0KDQpGaXhlczogMTFjNzNkZTllZjYzICgi
bmV0L21seDU6IHByb2JlIG11bHRpLXBvcnQgRS1Td2l0Y2ggZGV2aWNlIikNCg0KVGhpcyB3b3Vs
ZCBhbGxvdyB1cyB0byBwaWNrIHVwIHRoaXMgcGF0Y2ggZm9yIG5leHQgTFRTIHJlbGVhc2VzLg0K
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXJvbcOtciBTbXLEjWVrIDxtYWlsdG86NHBsYWd1ZUBn
bWFpbC5jb20+IA0KPiAtLS0gDQo+IGRvYy9ndWlkZXMvbmljcy9tbHg1LnJzdCB8IDIgKy0gDQo+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKSANCj4gDQo+IGRp
ZmYgLS1naXQgYS9kb2MvZ3VpZGVzL25pY3MvbWx4NS5yc3QgYi9kb2MvZ3VpZGVzL25pY3MvbWx4
NS5yc3QgDQo+IGluZGV4IDMwYzQwZjc2N2IuLjVlMzI3YmU2NzMgMTAwNjQ0IA0KPiAtLS0gYS9k
b2MvZ3VpZGVzL25pY3MvbWx4NS5yc3QgDQo+ICsrKyBiL2RvYy9ndWlkZXMvbmljcy9tbHg1LnJz
dCANCj4gQEAgLTE3MTMsNyArMTcxMyw3IEBAIFN1cHBvcnRlZCBIQ0FzOiANCj4gIA0KPiBTdXBw
b3J0ZWQgbWx4NSBrZXJuZWwgbW9kdWxlcyB2ZXJzaW9uczogDQo+ICANCj4gLS0gVXBzdHJlYW0g
TGludXggLSBmcm9tIHZlcnNpb24gNi4zLiANCj4gKy0gVXBzdHJlYW0gTGludXggLSBmcm9tIHZl
cnNpb24gNi4zLiB3aXRoIENPTkZJR19ORVRfVENfU0tCX0VYVCBlbmFibGVkIA0KDQpDb3VsZCB5
b3UgYWxzbyBpbmNsdWRlIENPTkZJR19NTFg1X0NMU19BQ1Qgb3B0aW9uIGluIHRoaXMgbGluZT8N
Cg0KPiAtIE1vZHVsZXMgcGFja2FnZWQgaW4gTUxOWF9PRkVEIC0gZnJvbSB2ZXJzaW9uIHYyMy4w
NC0wLjUuMy4zLiANCj4gIA0KPiBDb25maWd1cmF0aW9uIA0KPiAtLSAgDQo+IDIuMzkuMg0KDQpC
ZXN0IHJlZ2FyZHMsDQpEYXJpdXN6IFNvc25vd3NraQ0K
