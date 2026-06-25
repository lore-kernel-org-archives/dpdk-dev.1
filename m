Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05527CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 12:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC5F40430;
	Thu, 25 Jun 2026 14:35:09 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by mails.dpdk.org (Postfix) with ESMTP id 879B040280
 for <dev@dpdk.org>; Thu, 25 Jun 2026 14:35:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaFMOshFReXdqVkulsEjo8MlheIYkvzAHoGQupt9zpxTqhnunsnM1vMPjpMviUUZ+RzndnCYgRxsY66FVjaS0IxFf97I5Z4cJq6mghGO2N03o27K8WmdZQQ6nsv7zGi0nkLZkEydLsZ76HeaHKz5mDrvBTvXjSSHh/hDgmWsja60ZU5sl7jPZ//37ycyY0ug00vBlkvABhqnUh5VVASXxuTbev0JXPbcskBmmc/9/A7KAS/6ChqZxMO0DjJ+E2jfNAFXV6zIhffgABn0S/BqpSqRwlLTOFa7W0E4IPa7LASnHmLLpOuMskREwR+kbg62TqWD7sxvgdyWeBDuVOD06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ainf9tDMaQCMnFLD1AUZq4a7Ag5mkum/8yxHdwmlBZk=;
 b=WZy2iBZc3Zx7M2YJTgwXm02UCvFqNEPUMAPHJztHr7Hw9t7pHC+thLiEM58Wd8jHxJidodqTtTSHuSra2GpNOj32wSWOSLL1jgfSbux/C88k/oapCJnpPkiWNOWUlt/skzJrwM5K3rgZomQqzkqQkSN7SLseCvA7R2GKHOm9KlQJ3HXO8ur6evMHHQIjtRgjuEoMnj17uw2dn7pDsjjZFe7w0iS42yHhvRX1NyYhYBwWcQbpW9O06+uu/Jl9cAfKE7G1b0sXbVQITFEhNzbqxyAvAIjzGMQACMW5W+tzFHPuxLZm4icasfUibTxXvEc0woMitdoByxgTwEX2AhOADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ainf9tDMaQCMnFLD1AUZq4a7Ag5mkum/8yxHdwmlBZk=;
 b=fvTvuhKdhpleC/Cki2K06ijg/8XdiLOFdBItOVGVAjzpW2Mt5CtzzxHmYkqP3NndQOEpELcadheM/eQAWT/JhdYuPoVh6+/sXlMWE11++UQreBvci3z2V+pDXV1VaOtGWjnQWCnpaiZK4J06hnfZQTi8Sl1ac566PvldiJzcCstzPpwok7RpXoXn6SJQZquV6Y9v/7ykbHf/2DRFqDhWr5W03w6BFxH8uihJru+M6xJDaVXX2E0XjGEU3Zm+gGB/oSnnm28tSeYdAehgtiq+335t3VfIaN3O9UXS2lANk+HINrDl91Z+c4zSeCFrnmu9FjZ2Wa7YYb0PLRXzL7OX9Q==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 12:35:02 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 12:35:02 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: RE: [PATCH v2 2/4] build: support function versioning for drivers
Thread-Topic: [PATCH v2 2/4] build: support function versioning for drivers
Thread-Index: AQHdA9uCj7/85xa/pkmZQif+HeMCZbZO45KAgAAdDSA=
Date: Thu, 25 Jun 2026 12:35:02 +0000
Message-ID: <PH0PR12MB70776A69D0A4D78AFC3A33ACA4EC2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-3-dsosnowski@nvidia.com>
 <CAJFAV8xDOvg_DSLj8Ah1agTGSLxk1sn12_cw_7wbCv86J4KvUA@mail.gmail.com>
In-Reply-To: <CAJFAV8xDOvg_DSLj8Ah1agTGSLxk1sn12_cw_7wbCv86J4KvUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|IA0PR12MB8748:EE_
x-ms-office365-filtering-correlation-id: 38943e55-da46-4afa-55be-08ded2b62d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|10062099007|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: wFsAu9fbVgD4RWeJtWLqX+cZlnCqtj3189OIRSpwxYH2eqSRikzm89QH+bf0EW0hVuXmDMD85r4CXm+tP48hYuFJuZRp7NooJZyzJrCRE+5LfOry4MUaSp89Fudn9q6uFx8y2eUVcxUU6KT/kavOUTfwLdZtS7z8DL21kPweLsnDSRGGShyy2z4wOC2HP9kWA7A2b2bhzUXqxNnbNMZo7QA1vSrJp2TIjeXn1lrCKRS+H+1UE9nWwVI9TVDkhiKhW8t9UBDErgvYhaorcTPLy3gQXF3pswJViqeN7V11Uv+IRGLHObqRv4zsWuDjY46Kz6mGBkLfPTW3Xek4b4uqp9Ofoz0QRdJoPaMs/YHsRL/J9yRHTuewEFBgYP04LmeUBbeIo8zlvj82c7fP5VTclJm9PNo36AhJCrUJDKM5qBB4INbqP3DJXZAf+z2WZ1hDnxbH/VgtEzddVeZO9z0zcHCfVsGaA+Phv9m2JS2UIsUV1y0SGTGkKDsr3Dwfn4fzvU9z2s+MXsoHueVRgSr0ahpb58XtutKujNJYVd9yhZbdOkrjDjDLTmcSk0nmGkgtS1DO9ucIv4NidnHqLh8cGhUzPKhaeVszlAwIvo4++LBC76/9hwPwT+xfNz/zAQoWR2zpwkN7n7dju2bh5mnvu1fz6S1HiFfziia3+Dme5Y/vfF6t3Z2S9y+ylI03jfbUBOAq9fZYayLC2nYcHK6ivKlGCH3TMws0gYmTvYAqHJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(10062099007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FBaHF3WVhMODBoZEJsTTVkWUF4VFppUlBMN1IrTm8yUkNKSlVoY2Z1bjBt?=
 =?utf-8?B?V2p2M2xMZDZaZFNXZUMxa0hITllWRjVraXVoQkhjbisvV3o1ZEFIUm9JamlZ?=
 =?utf-8?B?VXJlclpWbWZvbUJDZmpzVEhSK1hWTVlUWkdJdTZVcUJ2NFhtRTNxVXJ0OGhQ?=
 =?utf-8?B?M204blZITjRraEtTazlsQmlvQUFNT0szak1VbHg1SmJ2aTJVQ3RVY1htZVBD?=
 =?utf-8?B?cGNlb3JxNE1TUThpQ052SllGS1JGbllUSkgwcnoycG84eHJzNFVadCsyWFhJ?=
 =?utf-8?B?b3RFNklvQ0d4eUNCeFZ5cUtUVGRnMmFDU0oxZlJwOHJWaUEyUnF4RDlXVFJJ?=
 =?utf-8?B?UXVzMXZCMWUvdHlBTGRsQWV3YmwwZXFjZkpENzF3d0I1bEo0akNlbld3azcv?=
 =?utf-8?B?a1FxUldMcmV3QWx5NlVvcXFDMFkxRXBxUnZubzJXRmE0OHZqNVI0SFJOaDIw?=
 =?utf-8?B?Wm5odzgvYXV4MVhhRk9EYXB2UGk0akQ2RnRqRDg1bmJreFFML3lVWlBzK0tk?=
 =?utf-8?B?MWRQb0srRWxjQWlJVTlrSXovaVpBRTV2a1l2QkJUZkM4YTZZL3loQ1o1UXhv?=
 =?utf-8?B?MytaTHpRRmU2WGc0MHRLRlhST2VhUStzN29ZTCtUbVZUL2krNTZycitNNlls?=
 =?utf-8?B?cStyYWVkeXBMcjlmelhSanUwV3BSamJjYWVnbkZpc2pBeEluQTNQNTh6RHIy?=
 =?utf-8?B?aXhXR3FOelk1OUhTZ2Z0YjBBb1pkeXhXRUV5MHhOUzJiM3hEM1lkNXVBUjI3?=
 =?utf-8?B?M0xsUkdFQ1REYW1TS0xqeE82azhFMzRlaEVmQ1BsZ0IyZjV0MDVMelI1dVhN?=
 =?utf-8?B?aEsyaGRFdENnNE1sb05ZRGl5YkxFd1VkMEpxZUF1dCtvcllac0VkeFo3dEk3?=
 =?utf-8?B?d29TcGpUTGYzcGU0UXpCSXVRUXRJeEJBVm82L1dtU0s3WVBCMWFaU1RFanls?=
 =?utf-8?B?M2lGV2RPOU5hOGFaVEhYaGdEdjJtSlhSZmR2YS9PdGlnWXFFbXhkeFVCdy9J?=
 =?utf-8?B?SThucWlSQm0xK0VRU0RGc2pYcVk5UXpTbU9tcjlnem1ZNzlVNmdlUHlJajN3?=
 =?utf-8?B?SWltUGJEeDJrOWFUR25kMTJ0M0FYL1NxbGtUMHQwT3ZlN25uRlNCeERMUEV5?=
 =?utf-8?B?SEdiYWF5SnNiejd0aHh5TEpsRnBrWFZJZmM3clBJUkgrbmNMYk5UTWFpRVl1?=
 =?utf-8?B?b2tDVVlXUEJqRlZ1S3EzaEFycE9IZUpUSk82ZU1CZDl3ZXhPRGkwdGI1K04z?=
 =?utf-8?B?eW1qVUVtRlZ4eHhJUGV4cVBuYUhmektMdnoraklUdi9XSHNyeUVaOHV1U3VG?=
 =?utf-8?B?dFpmdTNjRjZZOUNnZmlSZUtZOE5JR3hhYm9xYWphZE9vQUhDY1hzQlNkN1JF?=
 =?utf-8?B?NTRkY2Z4MjVYWDA3cmVndXdMcERyN3NrVU9XWEJsN01pdVVKNlNQRGZoMUZm?=
 =?utf-8?B?N2FteTVGRHp3bXpPSHBsaC9RVUhBMEJpRjlFemhieGd3dkJIQkxOMUlnai95?=
 =?utf-8?B?MXVMRHd5SVlqQW1ZSnNSWHFVYTRqWklVMG5qcmEzQ3hyaENOK09WcTVhQW9U?=
 =?utf-8?B?YlA2M0lOcEw2V1JCejJqeHJ6MjVsc0MvOUFJK2VVSVI0aWpudzN4cG5HTDdH?=
 =?utf-8?B?MkZrdmN5dmhhVGNBL2VTZ3hwVEJYSzhzRmJhdm1oVjlWSmFnWDNMQ2cwc2Fk?=
 =?utf-8?B?b1M0SzVZMEg3KzV1YUFNUndHZEZRcHMwbnVIVlhsaGZJVVBYaWEzVk9pakpV?=
 =?utf-8?B?V2FXZk1NWm4zalFKSGJyaUU2RHNVZjZDTThBRXlZT3lyNHNaZVlSNmNPWEtY?=
 =?utf-8?B?c1Fna3hCZVE3VGhrTWNxbXNOaEVERWZZKzBrNkt0WU1Mb0NTSkRYakk0U3Np?=
 =?utf-8?B?a0FVWFJ5a2s0MlhuQ2Qwc2J6eFUrNGNTclZTN3N6YUpQbEpJN25Hd2NEeko0?=
 =?utf-8?B?WVdiVTFJZVlJTUR4Q0RjbDFOaThMSkhUU3FUbThXbGRGYXJOZ0JXa1BrcDBn?=
 =?utf-8?B?RUFlV3pIbmlVcVBlcXFibXhWTnJTKzg1UTg1L3grcytJMXZCRWpCeEQreFdO?=
 =?utf-8?B?ZHFmVC8wK2ZGdy9lTkRpVFdWQndvMDkxVzN2SDE5czJmRnlNRFhlYno2NFhT?=
 =?utf-8?B?V0h3RVM2ZXQxdVdHNVdCSlR1NWFiek9acW8yVVBqLzNKeHdkMURGWGVwc2lT?=
 =?utf-8?B?dE51dUt0U296d1N2WlFGT1EzOEVCeHlBcGxmVDFTVHJORzZUN0VOVGVabkFG?=
 =?utf-8?B?Y1ZZQ1c3ejZnS2kydWJKOUpFRXZ5WjRUTHBzWUtuUEt5ZTFNRURVdDVpWDM1?=
 =?utf-8?Q?rCnZQ3zX7/pN1A6irO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38943e55-da46-4afa-55be-08ded2b62d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 12:35:02.1206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eeoBXsJMmJhKNJgFICzTdx9bo5eEWojY3zy7rEukRrs2MwjmPaY4n95b1omCfkZXfRqzB5FrOQCGdUsJrDC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI1LCAy
MDI2IDk6MzkgQU0NCj4gVG86IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5j
b20+OyBCcnVjZSBSaWNoYXJkc29uDQo+IDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4NCj4g
Q2M6IGRldkBkcGRrLm9yZzsgWXUgSmlhbmcgPHl1eC5qaWFuZ0BpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMi80XSBidWlsZDogc3VwcG9ydCBmdW5jdGlvbiB2ZXJzaW9uaW5n
IGZvciBkcml2ZXJzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFdlZCwgMjQgSnVuIDIwMjYgYXQgMTU6
MTUsIERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGVuYWJsaW5nIGZ1bmN0aW9uIHZlcnNpb25pbmcgKHRo
cm91Z2gNCj4gPiB1c2VfZnVuY3Rpb25fdmVyc2lvbmluZyBtZXNvbiB2YXJpYWJsZSkgZm9yIGRy
aXZlcnMsIHNpbWlsYXIgdG8NCj4gPiBsaWJyYXJpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21lc29uLmJ1aWxkIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZXNvbi5idWls
ZCBiL2RyaXZlcnMvbWVzb24uYnVpbGQgaW5kZXgNCj4gPiA0ZDk1NjA0ZWNkLi5hNjNkOTMzNzJh
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVzb24uYnVpbGQNCj4gPiArKysgYi9kcml2ZXJz
L21lc29uLmJ1aWxkDQo+ID4gQEAgLTE3MSw2ICsxNzEsNyBAQCBmb3JlYWNoIHN1YnBhdGg6c3Vi
ZGlycw0KPiA+ICAgICAgICAgIHBrZ2NvbmZpZ19leHRyYV9saWJzID0gW10NCj4gPiAgICAgICAg
ICB0ZXN0cG1kX3NvdXJjZXMgPSBbXQ0KPiA+ICAgICAgICAgIHJlcXVpcmVfaW92YV9pbl9tYnVm
ID0gdHJ1ZQ0KPiA+ICsgICAgICAgIHVzZV9mdW5jdGlvbl92ZXJzaW9uaW5nID0gZmFsc2UNCj4g
PiAgICAgICAgICAjIGZvciBoYW5kbGluZyBiYXNlIGNvZGUgZmlsZXMgd2hpY2ggbWF5IG5lZWQg
ZXh0cmEgY2ZsYWdzDQo+ID4gICAgICAgICAgYmFzZV9zb3VyY2VzID0gW10NCj4gPiAgICAgICAg
ICBiYXNlX2NmbGFncyA9IFtdDQo+ID4gQEAgLTI3Myw2ICsyNzQsMTMgQEAgZm9yZWFjaCBzdWJw
YXRoOnN1YmRpcnMNCj4gPiAgICAgICAgICBlbmRpZg0KPiA+ICAgICAgICAgIGRwZGtfY29uZi5z
ZXQobGliX25hbWUudG9fdXBwZXIoKSwgMSkNCj4gPg0KPiA+ICsgICAgICAgIGlmIGRldmVsb3Bl
cl9tb2RlIGFuZCBpc193aW5kb3dzIGFuZCB1c2VfZnVuY3Rpb25fdmVyc2lvbmluZw0KPiA+ICsg
ICAgICAgICAgICBtZXNzYWdlKCdAMEA6IEZ1bmN0aW9uIHZlcnNpb25pbmcgaXMgbm90IHN1cHBv
cnRlZCBieQ0KPiBXaW5kb3dzLicuZm9ybWF0KG5hbWUpKQ0KPiA+ICsgICAgICAgIGVuZGlmDQo+
ID4gKyAgICAgICAgaWYgdXNlX2Z1bmN0aW9uX3ZlcnNpb25pbmcNCj4gPiArICAgICAgICAgICAg
Y2ZsYWdzICs9ICctRFJURV9VU0VfRlVOQ1RJT05fVkVSU0lPTklORycNCj4gPiArICAgICAgICBl
bmRpZg0KPiA+ICsNCj4gPiAgICAgICAgICBkcGRrX2V4dHJhX2xkZmxhZ3MgKz0gcGtnY29uZmln
X2V4dHJhX2xpYnMNCj4gPg0KPiA+ICAgICAgICAgIGRwZGtfaGVhZGVycyArPSBoZWFkZXJzDQo+
IA0KPiBEb24ndCB3ZSBuZWVkIHRvIGJ1aWxkIHdpdGggUlRFX0JVSUxEX1NIQVJFRF9MSUIgZm9y
IHRoZSBzaGFyZWQgbGlicmFyeQ0KPiBvYmplY3RzPw0KDQpDb3JyZWN0LCBpdCBpcyBuZWVkZWQu
IEknbGwgdXBkYXRlIGluIHYzLg0KDQpCZXN0IHJlZ2FyZHMsDQpEYXJpdXN6IFNvc25vd3NraQ0K
