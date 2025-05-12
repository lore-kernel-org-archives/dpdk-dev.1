Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25003C3ABCD
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 11:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33CCB402C9;
	Mon, 12 May 2025 13:59:26 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
 by mails.dpdk.org (Postfix) with ESMTP id 26CD14025D
 for <dev@dpdk.org>; Mon, 12 May 2025 13:59:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie5yhV1gqdQ+91emLHez1imzMKIreyHVXfrIZkuR6canUpfpxinvEKP67bXfos3FoGJtav9T+g99EeQIAiq8fPQT54PUK3JeDch5hzfZUzFfIxCwE0NxMfCKApU1vclDSeEwQOZa/xh8yFlJrEDalv7WcMjrxk5wUUt5iV1pw0+tr4uXyk01sxH/qKKU3llvUTf9BPx7ehpn+KYD4isna4V0nkQMy31Mv/XbfK2XNZkG5aiI7ObZ1L1eg8W1CKnvMHSqnDx/0YS42JcDIOLkjOoTPfiOljatyQmyfWtKD17fMD48vRI/Ng80za3ENCFophN8beaUs5qP/SfCsrkjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soURAd3aRpjSPYxuv1SiG4wQMaW5JKQk4DTbSy1xcmk=;
 b=na7/+tvg+7zziENSu5Xs4c8oJ7N79qL04zHEJm88eT69u5YnIgyd9Jd6JMQu9GRpmsW4JZ1q/FmSOBVmn7chmjWnywqCAZkUv6Mf+ikH/oNOwkYHX5PZPvHBOVgl1C3dHWfYXCaJzKNrC/VicESjBCQacsivGpbfZwSEy5feNXGMA/WvroPlEIMIUNXN/zxun2LV8Q5Wf2se1BtgKJsOdqA/HCrTf+2hwIzrJatTGONGE1ZfORohMJabV6jt6SEbJFsCaOVRyaifZCJ6ErgMXt6g8a/kaxWFHP9cmP2v9XKVxhTlykZ0W19RidPgsVfV92art047FowcWzcuY8Q/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soURAd3aRpjSPYxuv1SiG4wQMaW5JKQk4DTbSy1xcmk=;
 b=a8o0xcvpL9i3aduxBbfk3YqvIpe8PTEJ3P1M5Gyd5w/kqZwCS79l1exFeN0Ktej5YYcMyuzAeNLYKChGJ+51u6abqzDg/UspPkCJrp+QpMEO5365afdhZw4ySEVxldUiMsjW0Zu8ED8rdh4/K5X8AC1WOGDzWYMk5Pb6Y/99XZgdS5h7Zz+0relYq6gql0Nz1M4KE5oqeV0ODqK7QeVj7eUT9fdYmMY8kAGns/AhdIYpdPWr4VYT2LtmZO5BTc+D0yonuUW41lV3+zLg7uOcWPqBkmY5+XRsfYhrkl3tS/xRVJ8pU0HF0YGyau8WH4OkINuu8VFZwlSZgilnCllnBA==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 11:59:21 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 11:59:21 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Nicolas Chautru
 <nicolas.chautru@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hernan.vargas@intel.com" <hernan.vargas@intel.com>
Subject: RE: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
Thread-Topic: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
Thread-Index: AQHbuuXgii2N6kXR/UeiF/el7UnKybPO8vQAgAABuhA=
Date: Mon, 12 May 2025 11:59:21 +0000
Message-ID: <PAXPR04MB9328C192FEE172382D30B5518997A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20250501221031.4569-1-nicolas.chautru@intel.com>
 <20250501221031.4569-2-nicolas.chautru@intel.com>
 <9cc1cc17-0d86-4e0b-b108-980062117378@redhat.com>
In-Reply-To: <9cc1cc17-0d86-4e0b-b108-980062117378@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AS8PR04MB9175:EE_
x-ms-office365-filtering-correlation-id: d1218659-e954-451c-cb20-08dd914c6e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEloaDZ2Y05tckc4WmNwajFDbEJpUUFpRlhHVVhjcWtCcE5iaWMxa3l4aWsr?=
 =?utf-8?B?eGRxMXFQdTZGcUFNQXo5b2ZDYWsxb3VydHBXZGo3RDM4YkplUmxRVWRrM3Mv?=
 =?utf-8?B?eFRpYk1YMExHOWRqNFB0dlJTQmdYbDRLUGRrOXkyL2FiNDNjeG82U3VPR0Iv?=
 =?utf-8?B?MUhTYnRBWE9mSWsrbmRzWVVGZjVlNm9Ya2RnVVdLdlBnWVF6ZkhQYkd1UjYr?=
 =?utf-8?B?Uk1Lc0lRaTZkbXJQTUZ5MEJZcWN0QTB0RmsvcXRiVXVBWTRFNkh3QnJBOHlk?=
 =?utf-8?B?SEtIUjBTdW5aRkVjY0Q0UHdMeFhBTVNPWUxacEpDdzhGQ3podU0zZ0dYajVp?=
 =?utf-8?B?dTRUbFZWcUNBbWpYbVl3aWdoOWhlbElUWFYzdUwwOG91WGpqYkEwWlE2dHdZ?=
 =?utf-8?B?dWhtbzB4YUd5U0o4eUhpUzY0dU1lWEt5clJZYUgxM2dSSVVXS3VVem0yNTZq?=
 =?utf-8?B?ak1Sc1FXbmFJN3pwMmVaVE5kWnpqdllrMThJS2RWbEVvbm85QnRjZ2had045?=
 =?utf-8?B?OWQ1QUUvWjRtSzdOOUlRSjBNYms4RFI0bk1ncHJwbVF3ODVJTWV6V1owaHBK?=
 =?utf-8?B?Q0dTOGZHdHB2cmZiQ1VXbFNlY3ZJZHpkR3BWb2FrSjFUQWNWeWwvRzh6NlMz?=
 =?utf-8?B?QkNrYllEYmZRMjlCV21BcEFoZmVqbnlvSnVWN3R3aGEzenZaK211UmdYM3JR?=
 =?utf-8?B?ZzZJNGMyQkpyM0JEbkFjZnJnb3RWbVRHTDFnT083a1dTczU4WUgrQ1pXSmdG?=
 =?utf-8?B?c0VHUWFLRW8yWWcwekcyN0huTXRXaEluK3Jya29zSjI0SURGelhma1JPZVNK?=
 =?utf-8?B?VHNSS2hJNU5NaDNXSG5oWGtMQ0RmL0ZDeU5ZdWY4Ny9NSFBwdmlZMFgrSWNn?=
 =?utf-8?B?ZGtRdm1mR1RuenYrRExYSUhGZmhkOUJCU2t3MHN1TU92R1F0eGwxbElKVzlp?=
 =?utf-8?B?ei85VFhScUZialpVZVBkcERnVUxoR1FVTk9hSGp3c2ROZnpEblNyUlpFYzBL?=
 =?utf-8?B?TmVrNm5mSVVEOEJzdE44czZMb2NxUjVTT2hXbGVzQi94Zk9sT3pxQXd1b0VY?=
 =?utf-8?B?UmR5a1cyZ05CeVhKUEhVdjJ5cGoxMjhJUzdydW55WVlaZVVjTEJvQ3EzL0dm?=
 =?utf-8?B?ckhlMkZYZnNMUm8wVTJnZVFGRWdjMGVTQ2RwWVM5Y3FoZzdBZnRTM0FZZkZ5?=
 =?utf-8?B?ZFpzN1N3cXpLbXdnZFZPeE1qZ09RbXpNNkJsVTJKZWRIUnhtUjNUNEFuV1p2?=
 =?utf-8?B?Y0VKY21hUCtxR0xRcGtKMFlTckFjUktHajl4TlQrLzZJdmZUb0ZXejBSNTl1?=
 =?utf-8?B?VzdteS83R2s2QnI3VXF3akFqYzZiblFnUGtPdHJhSXVSUWJWMG92VzZkc3VI?=
 =?utf-8?B?a083QXVJQlc4bFFnSlYyMFZyRkFWUTdQTnZqQUlBSHEyYXh0NVJheDBkVWpW?=
 =?utf-8?B?L0dZaS82L0NNM2tEdy9KNUR4Z3lYTzhkbFZpZmVqL3lyR1NuZE8wMWZNL0F6?=
 =?utf-8?B?d0tSYUIvbUVLTkcxM2Jqa1ZsUW1XaHZjR2JrOEx3UWtzQy9rMmpJbjc3TjhD?=
 =?utf-8?B?eHZtemdUS1gvbjRKeEJvZXRMQnE5aTJkSEFsV0t5YWRzcitmZGsrc1dpaTRj?=
 =?utf-8?B?UllwUHN0K2oyVHpPMzVlUWRLVDdNam9wZDVFVERXWnRMWElIb0JJR1RsR2dt?=
 =?utf-8?B?ZVZUUW11dFpYa1lGcEY5cFVYaTVpQ0JuSW9tL2hMRFhhN1BqZ3FEYmR4SjFK?=
 =?utf-8?B?VFFzd1VzV1BXekxJV2c5c1RTakZ5NllPWjFZbmNyZW9kc1pBY2Z2T3FyZnlG?=
 =?utf-8?B?YkE2aVNHR2J4UTJ0TWxZMFJKNGlhM21ic3FVVWtNdUV4N0hQVjhnSk1IRTB1?=
 =?utf-8?B?bHc4Vjg1WUV6Y2FpVnkxSTljRVg2cHNua1Y5cTV1RXR6QU9JeFhCM1RCOUxF?=
 =?utf-8?B?YkpDaEtLYlFMM0lOT3hxK1IrTlloZVNsaTVaYXNSaEtvV1lmOWlQRjZJVHpH?=
 =?utf-8?B?ODRJM0NlR0dBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlsWVBxbXVYekV6bzA0N3FmbS9CWit5WmVwQW5wWk9Manl1Wi8xWWVJSGNO?=
 =?utf-8?B?S21WeElab2ZETk1JclF2MmhCdERFSUw2V1VuSnFVT0VsaW9uZmtnaEo2UmF5?=
 =?utf-8?B?cmxCMnZTU213SEl2SUpDaFgxbm0wSzk2enB4WVNoTkplNkJJUlFDWkJHckxk?=
 =?utf-8?B?VTZsejhqQXF5ZC90S01RZy9RZ1dTUE5NbkFRUmtpTmxmYjAvNVIvdlE1ZEhw?=
 =?utf-8?B?aFhZYnZqU2d6UmNqUmtoVlhiSkQ5Y2g1V3NMN0xpb2VuN1RHOEFtRWQvZXA4?=
 =?utf-8?B?bFBwbFlpS2k5VWxXTURWRHFpZGdRWlhBRk1EWUZVMmVxSUNTVDVGMGlqbHRp?=
 =?utf-8?B?RWJSTGdFS2tDYWd6dGZrZFN2V3BWc1FlZ3BBcUlTRVNtcjhJR0NBQkl0dkFh?=
 =?utf-8?B?TVBiTlJPTUFrQ3U5bm9ZaUFoWEZlazZpLzdhY0hqNEYrQjUxWlV0c0drRENU?=
 =?utf-8?B?RzNhbDNhSGpBRUdCZlY5R2VhLzIzZlQ2SXplejB6NjR0K3pJUmovb0M5VWY0?=
 =?utf-8?B?dGZuQ3ZtQ0p1bXN2QnNIQUt1enZaR3ltVmJ6QnpUa1Q4aDhNcVozN2JQVUNH?=
 =?utf-8?B?WFNnbURXWTI5Sm5WWE9yMkljY25xaTRmU29JN25sUnF6MHM4MkhwL1VPWVhh?=
 =?utf-8?B?c2RjR1M2cUxvbHpYY0dZL01iZ2pyS3hqSXZpckRvNXJHM3NHcU43SXB6VEpv?=
 =?utf-8?B?bDZDQURZL2JpWDg4YnF1REcyUTdMNDNKMWN3Mm81d2V1ZHBoQVB6dVR5NzFS?=
 =?utf-8?B?RW44cmdJS0ljeGdNOTJScmJELzFQbURpNVIyNTB4cnh6L0h1SDN2MnNpcTBD?=
 =?utf-8?B?YkVES3RsclR1RWg5cHpKNjBGZm1wUTFmZ0RxV2pLc2FRbHA2YkdYVFg0b2tm?=
 =?utf-8?B?TEpLc2ZUSFV4VjI1WTFIL2xKbnNJSlhuczRtMzdzck1va3FUMnFLQ0lZYkgx?=
 =?utf-8?B?ZXdNUk5JQnEyQ3lOTzk1ZG41N016Y0Zqd0dib20zUVNzaG1iaFRsWGZQSXA0?=
 =?utf-8?B?aGQ4akF6eXp6MWYwTHRVYkJmN1I4bTM0SEZ5dFdzc3I2V3p6by94RER3SzVL?=
 =?utf-8?B?azliQnl1eStyNjErdFkzSHBMTFl5NG5sNVFJRGJaangrZUUzSXJidVN5SDBi?=
 =?utf-8?B?L0M0V3IxdjhNQSt4MDFTNXk3M2J6L3ZkdkVkRURTRWZlUi85V1NTQnVSTWVW?=
 =?utf-8?B?U0JNU3l6UEFmU1d2THMyWUNHQ3hHMTJSMFY0VlFVMlFRZlZBbXR5MHNJQXY0?=
 =?utf-8?B?MkhOT3NRNlF4NlNkdUgrOSs1ckkyS21XU0d2UmhNMzdmR3o5dDkvWjhXNW1i?=
 =?utf-8?B?VEEwQXZWLy9Ubno4YTU0OGh0U3BBZEJuRGxGYzhDRjRPVFhlcjQwMmlNY2J2?=
 =?utf-8?B?MkdRVlFIVFEwcnZ3Y1psaFZjaUpHS0s2NThTQU1xNEdGRVNYYzFxMWRnNFhN?=
 =?utf-8?B?Smlvd0dDWXMyRGZqOGFuSmZFVnh2ZU5kYkQxTjN1dFZCTjZiQ29weDU2UjdV?=
 =?utf-8?B?Y1draUFZR0tYZG1qV3NZTGtmWWp6NlJMekFTc1JXcDhwbDZBZDNHbzB2MVQ2?=
 =?utf-8?B?UWRFbGpKUVlsZndhaXJDNVpRc1BPR1ZXU0lieGlRZ2lGWW53b0llWkxzSEpD?=
 =?utf-8?B?M2NLcW1nTlRGRUFwUWljNnZPdFZYbERiMXlleDJaYzJjalBwN0R2OWpsQWE0?=
 =?utf-8?B?K2RTNHpJdUg0WE1JVDJrM0hoWWZzcTViU3Jnb2hmRTBUQW9vcFN6cjhnNmR6?=
 =?utf-8?B?U3hkVWxrckx2YW8zYXd4cW8xUWhaQytMR2FpR3ZjNHc5RVFRazVoWUUzaWM5?=
 =?utf-8?B?akc4RjNiNWxXQ2hTM1ZDNUowT3RaN2hPS0p3Y0kwNWV0Y0RhVnNYMjBaNTI1?=
 =?utf-8?B?TVc0REc1YVAwTGxLNS9WSEJ3V0RGMWpQOTQ2aEZONzNpVVZ3UGJCZGRESlVy?=
 =?utf-8?B?UDVjM2xDS2JJMTdaMFdOU1RjOTArTWl1bGwxRGU1ZHNuYm51WFM2T3VpT1o0?=
 =?utf-8?B?WHBLQkFTdTkvMkRENHFucVMzbEcvZlI3TitXK2JnZDJNWkg0Y0VHUTNuQ1pT?=
 =?utf-8?B?TXRaOXdxQnJPSmlxeFBTeE01cEVDOVdDUWRpZnN6Qkptd2lYSVZFTXZrUUQ1?=
 =?utf-8?Q?xmZ8EuaNUQ6zzaHrTeV1Qr5Gn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1218659-e954-451c-cb20-08dd914c6e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 11:59:21.4506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTcQoKXu36uxf9gGhOphTRw7irfLEUJBuhomXeJt/SjrWZLfh6CuNxh3I52s2OvOEfNPkUMJvBjEqlVx5OSHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF4aW1lIENvcXVlbGlu
IDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4NCj4gU2VudDogMTIgTWF5IDIwMjUgMTc6MjMN
Cj4gVG86IE5pY29sYXMgQ2hhdXRydSA8bmljb2xhcy5jaGF1dHJ1QGludGVsLmNvbT47IGRldkBk
cGRrLm9yZw0KPiBDYzogSGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5jb20+OyBo
ZXJuYW4udmFyZ2FzQGludGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gYmJk
ZXY6IGZpeCBwb3NzaWJsZSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gSW1wb3J0YW5jZTog
SGlnaA0KPiANCj4gDQo+IA0KPiBPbiA1LzIvMjUgMTI6MTAgQU0sIE5pY29sYXMgQ2hhdXRydSB3
cm90ZToNCj4gPiBUaGlzIGNoYW5nZSBhZGRyZXNzZXMgdGhlIENJRCA0NTc0NDY6ICBOdWxsIHBv
aW50ZXIgZGVyZWZlcmVuY2VzDQo+ID4gKFJFVkVSU0VfSU5VTEwpLiBOb3QgZXhwZWN0ZWQgdG8g
aGFwcGVuIGluIHByYWN0aWNlLCBidXQgdGhlIGNvbmZpZw0KPiA+IG1heSBiZSBwb3RlbnRpYWxs
eSB1bmRlZmluZWQgdGhyb3VnaCBBUEkuDQo+ID4NCj4gPiBDb3Zlcml0eSBpc3N1ZTogNDU3NDQ2
DQo+ID4gRml4ZXM6IDYxYWEyNWI5NmUxNCAoImJiZGV2OiBhZGQgdHJhY2UgcG9pbnRzIikNCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgQ2hhdXRydSA8bmljb2xhcy5jaGF1dHJ1QGlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGxpYi9iYmRldi9ydGVfYmJkZXYuYyB8IDkgKysrKyst
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9iYmRldi9ydGVfYmJkZXYuYyBiL2xpYi9iYmRl
di9ydGVfYmJkZXYuYyBpbmRleA0KPiA+IGYzNDFlNmYzYjkuLjU2ZjMxM2VlNjQgMTAwNjQ0DQo+
ID4gLS0tIGEvbGliL2JiZGV2L3J0ZV9iYmRldi5jDQo+ID4gKysrIGIvbGliL2JiZGV2L3J0ZV9i
YmRldi5jDQo+ID4gQEAgLTQ0MCwxMCArNDQwLDYgQEAgaW50DQo+ID4gICBydGVfYmJkZXZfcXVl
dWVfY29uZmlndXJlKHVpbnQxNl90IGRldl9pZCwgdWludDE2X3QgcXVldWVfaWQsDQo+ID4gICAJ
CWNvbnN0IHN0cnVjdCBydGVfYmJkZXZfcXVldWVfY29uZiAqY29uZikNCj4gPiAgIHsNCj4gPiAt
DQo+ID4gLQlydGVfYmJkZXZfdHJhY2VfcXVldWVfY29uZmlndXJlKGRldl9pZCwgcXVldWVfaWQs
DQo+IHJ0ZV9iYmRldl9vcF90eXBlX3N0cihjb25mLT5vcF90eXBlKSwNCj4gPiAtCQkJY29uZi0+
cHJpb3JpdHkpOw0KPiA+IC0NCj4gPiAgIAlpbnQgcmV0ID0gMDsNCj4gPiAgIAlzdHJ1Y3QgcnRl
X2JiZGV2X2RyaXZlcl9pbmZvIGRldl9pbmZvOw0KPiA+ICAgCXN0cnVjdCBydGVfYmJkZXYgKmRl
diA9IGdldF9kZXYoZGV2X2lkKTsgQEAgLTQ1MSw2ICs0NDcsMTEgQEANCj4gPiBydGVfYmJkZXZf
cXVldWVfY29uZmlndXJlKHVpbnQxNl90IGRldl9pZCwgdWludDE2X3QgcXVldWVfaWQsDQo+ID4g
ICAJc3RydWN0IHJ0ZV9iYmRldl9xdWV1ZV9jb25mICpzdG9yZWRfY29uZjsNCj4gPiAgIAljb25z
dCBjaGFyICpvcF90eXBlX3N0cjsNCj4gPiAgIAl1bnNpZ25lZCBpbnQgbWF4X3ByaW9yaXR5Ow0K
PiA+ICsNCj4gPiArCXJ0ZV9iYmRldl90cmFjZV9xdWV1ZV9jb25maWd1cmUoZGV2X2lkLCBxdWV1
ZV9pZCwNCj4gPiArCQkJY29uZiAhPSBOVUxMID8gcnRlX2JiZGV2X29wX3R5cGVfc3RyKGNvbmYt
DQo+ID5vcF90eXBlKSA6IE5VTEwsDQo+ID4gKwkJCWNvbmYgIT0gTlVMTCA/IGNvbmYtPnByaW9y
aXR5IDogMCk7DQo+ID4gKw0KPiA+ICAgCVZBTElEX0RFVl9PUl9SRVRfRVJSKGRldiwgZGV2X2lk
KTsNCj4gPg0KPiA+ICAgCVZBTElEX0RFVl9PUFNfT1JfUkVUX0VSUihkZXYsIGRldl9pZCk7DQo+
IA0KPiBSZXZpZXdlZC1ieTogTWF4aW1lIENvcXVlbGluIDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0
LmNvbT4NCj4gDQpBY2tlZC1ieTogSGVtYW50IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5j
b20+DQo=
