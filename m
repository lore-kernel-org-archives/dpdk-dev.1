Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44889C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 08:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB067402ED;
	Tue, 27 May 2025 10:59:05 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by mails.dpdk.org (Postfix) with ESMTP id 70088402D6
 for <dev@dpdk.org>; Tue, 27 May 2025 10:59:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDk8fcRp+PNVWLo7nSH5eNQ5GKg7oHj/oLuDI/TiAP2i4RifDz4ShxP1YAihrhKgJEwOW29SuPiolxXXEsckT+7Z7c+PQD2+b9qN8Xa674DBnZbAgv2ABLQIYkrfS7kRtaEDRG3ju4YX/PeoovjpOr/SsduFhtokUldRDl2JJ7aXEhJQ6lwcbAT0WLAyp1K3RkGYXjnKeJEiJ+DZFVC4HsmkbBty2Qu96GyrIbTYpVOLaitnbORFmoq3neYegmsS8fHGIegFXq1wE1lboi1C8EZF6u/+KDS6W9TWJyTjf15ZKJoLULF3z+8cfz5ja5QcqYtDmNQFO18k/gK1cIfRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY9+oOfDxVKrRgdCqTi3Irz7+PBfgXsybKfQg4uRKqc=;
 b=l7pEI/lAtqsN5xoNn0sjxoWvnkFrcDhnYvvLbKWjoko2viyyWPH+NRkqx0tEbclSBe/pJ28rUAH9kTSpOGAopsvDo87V7N3NqDqmrGPZ0TolJfec5MD5dVpw68koYPaJPWYjqIXuqcNbL2CNAvcFHQ/1noa+v56YMEyYSArthuUpQuaoU13fgmoXBO+1qts6uOV9xjlCh8Zxrzl/A2ByfRfk3EprIhdjnaBQBns20vz7KwIy5NZ3CfmQgJzVrBvrOK2MECzxDdCmo1dZK0X0IIJil+Byg0waNZaBsY60ZOjNQNVjdZn+QU0zBpRNXhaU3IWy8NLe9W3rjrW4RnSIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY9+oOfDxVKrRgdCqTi3Irz7+PBfgXsybKfQg4uRKqc=;
 b=J+W+826BttLHIvZmL/DHqqQufx2yRF94aB7AuhQ0A5ijdGaI8MfuHbyKFm2QkTKjo7fWviLd+NGT2jD2llbyGKa04UW6NLfZLgdZ9wd7eQt6wIHViBjqfaRWYqv040W6J6g1Lq52Pp7wSohlXi1cjKhUtSK37B/kCTp0QfF5CB+Erv6N6L2w2HFJ79bXRhZEO1umFt7440j2b8yxBeMBjKpbY+YjeFerkGrNyXd97nFJGRxRmR2QwLQe1vtB10Gncg2tLVfcfvaiUn974eqoNm2Cdjl+8KuK/fvmqGlBQCXRgm1WX8sBdNVwl8EAKTGvWGO6mFfESY8ObYbXRfR+0g==
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 27 May
 2025 08:58:58 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::5cff:1844:4c17:a0e3%4]) with mapi id 15.20.8769.019; Tue, 27 May 2025
 08:58:58 +0000
From: Maayan Kashani <mkashani@nvidia.com>
To: Raslan Darawsheh <rasland@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH 1/2] common/mlx5: read SWS capability bits
Thread-Topic: [PATCH 1/2] common/mlx5: read SWS capability bits
Thread-Index: AQHbt2ZIOOFXiCapNEiltoig3LAzt7PQMDQAgBYroUA=
Date: Tue, 27 May 2025 08:58:58 +0000
Message-ID: <PH7PR12MB70184619A31E72598704E8D6B264A@PH7PR12MB7018.namprd12.prod.outlook.com>
References: <20250427111916.108276-1-mkashani@nvidia.com>
 <c50dfa76-8d39-4f76-b4d1-aa118e29f267@nvidia.com>
In-Reply-To: <c50dfa76-8d39-4f76-b4d1-aa118e29f267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7018:EE_|BN7PPF9C6E5285F:EE_
x-ms-office365-filtering-correlation-id: b1a32e00-02ea-48a1-12df-08dd9cfcb780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RlJFLzY3YlBhOVorRmxGeVYwV0pTQUY4TmJxVGtsbWM4UDc0Q0ZCWndTYVdC?=
 =?utf-8?B?QW9JZERIYnN0V1VHd1JKUEpUdXVTdjhoN09ZbkQ5VVJ2bXJhTlBSZSt1SmQ3?=
 =?utf-8?B?QnRod1R6d1UyR3FVakJaZlcvQVlaR0JYbmFOZmRRY1ZucmNTYm03NDdBL2hm?=
 =?utf-8?B?b09ydlFHVkg2cWNnQTBpTXk1VWJXeko5bll3cW54WGtQeWNQM1Z0SU9Hck1Z?=
 =?utf-8?B?eVNhUm9aek9DU2V2TGsyREloVVBYQTJVem8xTk1uVzdBM0lXa0thSzRCQjVp?=
 =?utf-8?B?RS81SEtOUk9KQU1QUTlzWnFBY3BLYXVkb0p4ckRUYTAxK0FoeWpSKzRaWlYw?=
 =?utf-8?B?MGIyY3pPaHA5eGw0NmRFV0lrNlptcVJOd3o5eFhUbjJIeUlBKzRGU2pkbnNL?=
 =?utf-8?B?L1pMRThPUkFaM0kwN2FrRlRjVGlaV2M4U3dTZ2c3WGN6WVczUVdTOHB6bUt1?=
 =?utf-8?B?TnRIY09UY0tVTCtObjBvQkVoS21CRTRrMEw0eUVxci84bXhxd0pWWjd5Y0d6?=
 =?utf-8?B?YzBCa0VoNklWYlhyMS81WmJHaEFLUHRFZTRMZ05FNUhJa0tCYlFwYUt3Ukh4?=
 =?utf-8?B?TWl3NnJ3emQxa3c3ZG5xbjU0ZjJTT3FpL3ZPNmVKMXVubHN1TTdvSUJ2Q2tq?=
 =?utf-8?B?MElvQjdEU3g0dHd3UEdSM3REdDZMYkFZd0JqYmY0UlBZZzQxT0I2WFZUR2xH?=
 =?utf-8?B?Ui9NaElPZUxlLzVkUnJWKzROekQrRkp6RW1jcm9pZmVzajZ4WWFnYm5vVGZR?=
 =?utf-8?B?bXNaMmxST2hGRG41ZzRVOTI2S0JjWHNWZ1YwU01BV0ZHdlNTZWVBU3R1MFFM?=
 =?utf-8?B?dXZoTEpMM1lxdFl5MDVyQkpDc0VleWMzZGcrUGtwMTVCYi9JS3ZwQi9MNzEv?=
 =?utf-8?B?Y2QrNlRNZXlRaHQ3K0dFOFdkMHBhbHRzMEJwQktJUXFmQUtoY3VnSHp0STBr?=
 =?utf-8?B?TDhPRC9QSEF1ZmU2c25GRy8rWEc5SFYyaWdlVEVBM1d0VVBxdFd2Tmljendv?=
 =?utf-8?B?NXo4ZUpXSXVKNmYyQ2thL1dJdDJuQ2c2YWFFbnJRakErTVlwVzdhbXlNMVBm?=
 =?utf-8?B?RnlZaVd5VzN5WW93V1ZYVERRTHUwZzJRdnB1NTIzU3dWblVnZ0VUQW5IdW8v?=
 =?utf-8?B?NXM3RHFRZUNrMFowYWQ5YS9oa1EvUEgrWlM3bXdBYlBZa1pONndkak9qWTI3?=
 =?utf-8?B?M29HVFJUMFZYUVFTN0lpbzI1QnZ4VzhXYW1WOElKOVo2TUFlb3N2QWlCcWd3?=
 =?utf-8?B?NytiTkVNeDhPblNOMDR0UzFVSkpNcWtJUTlBYzNiS3p6NHpzd28zYmZuRnpQ?=
 =?utf-8?B?Wmxud0RKcXE5aHh1MTJwY0lxU1ZSb2gzdWNYaXo2RU5SdjlON3VvbDlPNFhH?=
 =?utf-8?B?aG5rN0oyQjJZL0MrLzFBRllUcFN4cDV3YVE5bFpjaUsyenNNOFhGeUFETUJN?=
 =?utf-8?B?RjUwUGRuK1U0SkpVcC9WOC9wQmVoVUw3aEcwQjFodG5ka09PZnMybUd0cFd0?=
 =?utf-8?B?eDZuZjc1Uld6NmkyRFhORkdMUUtWRkRpSnBjNndSZ0lLQlJtS2Vscy9wYkYx?=
 =?utf-8?B?eUZ0cHYxbmlWWWU1ZEZBWWMrb0dsWDh1WDd5WFpRU1RMYU53VU5rSFhZdnF0?=
 =?utf-8?B?UWdYWkY4L0tkSjEyc0FBWG9qNXBVWGdYZGxrZXhtQ2RNQTBQS1ZLN3ZvOTA3?=
 =?utf-8?B?dUk4c2YrS2J2UkdQQmtGVGZlUUpWVlA3OENFV1VvRU1MSVJHNEZzYnBLVkk0?=
 =?utf-8?B?N3l2Q3pVMGtNZnpRcDhpaHBPZWNaRnRoZkxwb1QyWDR2OU9ZV1BhRUVPbnk5?=
 =?utf-8?B?T1F6MVVqSXR3a0E2VnpNYWdmdVpXWUxqcVdqSUwvalZabU5KVll5QklaalpP?=
 =?utf-8?B?ZTd0RGI4VStUQjZ1WVI0dWxpZkp4T0JydjlraEpxbGtWSzNYUkF3ZzNJWlVu?=
 =?utf-8?B?K3g4ei9JSWpzYWlBcU5FL1RqTnBKUHYwZTdwUWlQeW9lY2dsaWhnREVVcWs3?=
 =?utf-8?Q?edDP3kKm/WynCYGoB7M8Tx31XtyZdc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3J1cWVkYnl2aEk1c3RRQWtKNTBPMXNsbVljWG1LM2h0VUFXSFYyWUNUZGxh?=
 =?utf-8?B?R3htNENQZ0RvanRVOEVyR1RtdTRBcXFEaStic1F3TVNqMUhIb2VJZER4ZjRz?=
 =?utf-8?B?VTRwNkJVcFJrZ2xkL2IvQXF4b1R3aXVKMHVkVnZ4cWpBSmxYMW1GcEpOSGQ4?=
 =?utf-8?B?dFQ0aXZwWEpEeGY1ZTlrYXgwVU03Y3hEeUZTUTllTUgzb0pyQ0xSaVFOZEJp?=
 =?utf-8?B?RlhjeUU0d1QzNll0TWM5Zi9DRzlOUDRnZXdwNDJCeW9CU0p4akpWblVZMjBj?=
 =?utf-8?B?K1Z0Mkl4ajFaNmdNV3d0VFBaUjdRVldUenZHNmZBa0tnMnlxWVpKdWk3c3VY?=
 =?utf-8?B?MzA1WngycmJJRk1nT01Td21lSkV5T1lra012bDhaVTZUdVNkQlRsM0g0OWQ0?=
 =?utf-8?B?QzFOM1N4OVQ1WS9LR21pSVZsUjFsV3hKRlRuTVFqeWw2bHVyM2IzQ053M3Yz?=
 =?utf-8?B?Mnp2VUg5YURxUERSYkcvWHJ6M3lGc0RjY25CM2QraG1MeUJvTFEzb1BjY0Ri?=
 =?utf-8?B?WXB3UTcxTVFLZ0lSbnZQSS9OZXhoenpDOG43OHpzdjFPZE1TMStrYlNQV0pu?=
 =?utf-8?B?UStpL0ovNmNBNnRTM1Y0RWRtaytraHdkVmNFYlVNVC8rQVZ1aTh0UVExb2s0?=
 =?utf-8?B?bE9SWk9uK1p4bEY3MkN4NWlySTFFNzduQnlZVW5EU3VCWi9xS2RucHltVk50?=
 =?utf-8?B?M3NBZFNPWlBwMFlhWlBOWDBac0dFZkxEVzduaGdjcVpNWW9JOFliSWx3a3Rk?=
 =?utf-8?B?RFU1NjZieWVmTjl6VXNkMCt1VTZNZ1hPYmxnNkt1aWN1TkQ0WDJMTXRUZlRi?=
 =?utf-8?B?YmZkMERBWHB0NDdhUzAwSzUyT2xmaTUzc1VUNTdDTENMdlZrZWQ0ZFd5eVQz?=
 =?utf-8?B?djB6aXR3MlgyOWVqWFVvZjhrWm9ZYnJSa1crdWE0QXZ6cUNsZmpnZS94U0Vt?=
 =?utf-8?B?TUxOV2V6STdKN0pxVkFHNTZST3N5c2t6Rzl1SDUwRFFmQ3o1MU9iZ2ZKb3F2?=
 =?utf-8?B?em5FZzZyK2J3azU3QzRkS0VYVHN1SXI2enFlbXNsUE91Tm8rLzJpRVNKblA4?=
 =?utf-8?B?NlVFSGc5YWNsbzJBRGgyODZNZWk0QjBIM3FqNElFOTlVcEhZUStTcVBjaEdx?=
 =?utf-8?B?aDdvbHNQenk5OVZJalNRdS9pY09ZbXo5TUJ5RjVBSWliaUVJdmZENFFabjRW?=
 =?utf-8?B?Z0ZXdlNwdXpDRXQwZ2VMbHUyN0JZWTJOYUk0WWVSamkydCtWdkk2NExFN2hy?=
 =?utf-8?B?cW5xNC9zYTBQcEloM21McTZ3VWhwSmc5MVZDckF3TW9mM1NRenlBVVlFRlBZ?=
 =?utf-8?B?dDljSHlUZHIzSnhxdE5SaGtXa0hEbW5oMktHYVBIUlN4RUxac0xnVm9tN2JF?=
 =?utf-8?B?K2JDdFF0VWxlWkx0S2hxMzNhUW44eTBWR2NVejhuZTNYUE5SRmRrZytNVkk2?=
 =?utf-8?B?ZXV5VGIxN3N5VGJPQ05HS1huU2szazc3M3BocmF4cE9ZeEhkc0FuWTZtc1Vw?=
 =?utf-8?B?L1plVGpodFkzSDYvWEh0TjM5RjNQbVp4MWVEakc0c2Y5STMrbDJLRVF2RWxV?=
 =?utf-8?B?cFRRYmlNMER2NFlwekxMbFl4ZCtYZXAremxBbUpDaFZqYk94aytCL3JDdENO?=
 =?utf-8?B?cVpwclhCQkJVREZ2SGp1ZG9OUFBERDgxNVF2cGVRb0hmMmJ1Rmt5bStpMXkx?=
 =?utf-8?B?NVg4NFFUY1BxOXR2MmcrS2tKYlZsS1hRYkpRdlZMMjd3RGdOUGtLR3grcmhB?=
 =?utf-8?B?MGhVNnpFcGF0eUY2U2EzeUw4S0ZtWCtySEwyVEh5ajZiVG1vRDA3eEZFTjdi?=
 =?utf-8?B?VStzWjVTdFRVcTIyTXZ4SVhQcFpYb1RJZDBKSmxRVHY2WHUyeXZZVG9QRkN5?=
 =?utf-8?B?ODh4a290emZ1WE9FUDRZcEJvaVB2S1RPbWVwelgrVGdLWFhOS2dYb2tQRjQ2?=
 =?utf-8?B?MWE0UEU2YXNiZ1VDZmdHbnVROW53V2twaXd5K1NubGIzRU01Q3RhUVlYSnVK?=
 =?utf-8?B?UlZCTWtoeFVvVFhVSHlnNzRycjMyTVduM2hZRGpKSFNnSWE3ejJKdnZaWE8y?=
 =?utf-8?B?Y2VCQkFWTnBtTG95SGJidS9DNzN6WGluT3BmQ0FKZGVZTzVsZ3NZRzRuRnVZ?=
 =?utf-8?Q?gqu/Q16Rg/FcA9xy4lQSsSoKa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a32e00-02ea-48a1-12df-08dd9cfcb780
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 08:58:58.0604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwkrII7CGf5Ceutgpt3BpqSD9Ib4ftcBJmJf3FuUCAx2habqNW9t1ABdZ1H2ADx01oZXYTf1idoQhBXCbLJlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F
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

SGkuIA0KUGxlYXNlIHJldmVydCB0aGlzIHBhdGNoIGFzIGl0IGlzIGNhdXNpbmcgYSBkZWdyYWRh
dGlvbihtYXJrIFNXUyBhcyBub3Qgc3VwcG9ydGVkIHdoaWxlIGl0IGlzIHN1cHBvcnRlZCkuDQoN
ClJlZ2FyZHMsDQpNYWF5YW4gS2FzaGFuaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFJhc2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgMTMgTWF5IDIwMjUgOToyMw0KPiBUbzogTWFheWFuIEthc2hhbmkgPG1rYXNoYW5p
QG52aWRpYS5jb20+OyBkZXZAZHBkay5vcmcNCj4gQ2M6IERhcml1c3ogU29zbm93c2tpIDxkc29z
bm93c2tpQG52aWRpYS5jb20+OyBTbGF2YSBPdnNpaWVua28NCj4gPHZpYWNoZXNsYXZvQG52aWRp
YS5jb20+OyBCaW5nIFpoYW8gPGJpbmd6QG52aWRpYS5jb20+OyBPcmkgS2FtDQo+IDxvcmlrYUBu
dmlkaWEuY29tPjsgU3Vhbm1pbmcgTW91IDxzdWFubWluZ21AbnZpZGlhLmNvbT47IE1hdGFuDQo+
IEF6cmFkIDxtYXRhbkBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY29t
bW9uL21seDU6IHJlYWQgU1dTIGNhcGFiaWxpdHkgYml0cw0KPiANCj4gSGksDQo+IA0KPiBPbiAy
Ny8wNC8yMDI1IDI6MTkgUE0sIE1hYXlhbiBLYXNoYW5pIHdyb3RlOg0KPiA+IFNXUyB3aWxsIGJl
IGRpc2FibGVkIGluIGZ1dHVyZSBIVyBnZW5lcmF0aW9uLg0KPiA+IENoZWNraW5nIFNXUyBjYXBh
YmlsaXR5IGJpdHMgYW5kIHJldHVybmluZyByZWxldmFudCBlcnJvci4NCj4gPiBpZiB1c2VyIGNv
bmZpZ3VyYXRpb24gaXMgbm90IHN1cHBvcnRlZCwgd2lsbCBiZSBhZGRlZCBpbiB0aGUgZm9sbG93
IHVwDQo+ID4gY29tbWl0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFheWFuIEthc2hhbmkg
PG1rYXNoYW5pQG52aWRpYS5jb20+DQo+ID4gQWNrZWQtYnk6IERhcml1c3ogU29zbm93c2tpIDxk
c29zbm93c2tpQG52aWRpYS5jb20+DQo+IA0KPiBTZXJpZXMgYXBwbGllZCB0byBuZXh0LW5ldC1t
bHgsDQo+IA0KPiAtLQ0KPiBLaW5kZXN0IHJlZ2FyZHMNCj4gUmFzbGFuIERhcmF3c2hlaA0KDQo=
