Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B3C44501
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 13:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0652402D1;
	Thu,  9 Jul 2026 15:52:18 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by mails.dpdk.org (Postfix) with ESMTP id 4632E40268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 15:52:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ60dWwYwld7AUhHPiub4LKoFIe8rw3OMz51cK+4v9NxSxPc8/T4aLT1KR5kTDtVre+Lqn94RHEo7D+aCl/S+MdxT67HyZPtZ/jFkZ4/h4BkkBBVdgbexM+xAZTEhKgCdRrUBFh8gPMwJ2FZtiTXlNFE9/UMVnqGLGqEFUaerh8wlwZAZ8RhNFw+Nk8rniuZWDSSmuZVc+foXUtyZP0eDpKm30jpL2JYhVOTLqew4bEImihks6Fn1VKOqpRRDO/mnIA7+dt17DnaJ1j116p0qvOYRiDa5ne+asx79UAH/tCEiZJ44E6F5PcP1Q+mc1CJhwhsdVAnE5fzfgKbkTBZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hUmMLoi5wvdo1xbTFYlsNhPu0HW/btp193zk7P+zcI=;
 b=VuFGisd9dyUAvSuDPWyxX/PUBcVy6Swi9wDK27MLwcj9IZE9x/L405jVRFegp3Fji/ymv7qFl5pMIcw4kS9lw4vbpUub6Y5e552b6nnkyAWZ9gtpYsh9PpLkxOMhwxs5jzIdgeo5cyzZ2do0ULCybbU/wTV3Xyzvi2hq/MDqcbTizVasDRYkOxMWSAF7Z5Ux/eJ6O63ihFucrJMcnz0nnRiLKKx+WGl5W9ULrLxa9ibDS88K1YBg32ZEOAwfTDaeVLcE+4G3j+gMpR4KTTvuKvXNnwwI9VR8we+3o3xjJEZ4GJ0x/yrUZrRC1ty/qsymybYY1wcc17ZSYKgLz4x0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hUmMLoi5wvdo1xbTFYlsNhPu0HW/btp193zk7P+zcI=;
 b=L2fiKFGXAft3ht9WwLoCgKUz36SFrdij02/ivLlgdCCKM5hvNCKjMGJQ27ecTVgQCDIbWOyTEzz3vkHdSShPVn6vEzfFZQprnYQMU9vPCYu2olFX9Ac+MJoUao9ZIu6txiLW7jgqjivpcWP2cSVOsd2lWXqecndF6zoesXmN71yT6Cf+WgeBjBzNxyM1QXM4R4qkf+nl9y5zvvwcK41VZKwUUhpiphhXl/CWMu/d121pKf7RtNJkwfgg72ROlsbRs/ercfWgCkyylBtLgyD7H4kZlJbrWNCNJ34/UdJqazlraM4uKtyXxZPHAEhRrXwB3oO41M0x9uI/IU1aHVGHiw==
Received: from LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:52:08 +0000
Received: from LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4]) by LV2PR12MB5893.namprd12.prod.outlook.com
 ([fe80::9ddd:59bc:6bbc:4cb4%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:52:08 +0000
From: Wisam Jaddo <wisamm@nvidia.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 Maayan Kashani <mkashani@nvidia.com>
Subject: RE: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Topic: [PATCH v8] mempool: improve cache behaviour and performance
Thread-Index: AQHc9BgqU5MXD4EJbU6GnkYjz7nN67Y3qjmAgCwI/3CAACj5IIAAEDUwgAASKxCAAT1vsA==
Date: Thu, 9 Jul 2026 13:52:08 +0000
Message-ID: <LV2PR12MB58934E8B54A6462AC9FB81BCA4FE2@LV2PR12MB5893.namprd12.prod.outlook.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260604114851.12586-1-mb@smartsharesystems.com>
 <VxW5gWu4QO2u3TstS3BuBw@monjalon.net>
 <LV2PR12MB589331A1E8F78B5C9F3DC9C6A4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65962@smartserver.smartshare.dk>
 <LV2PR12MB5893086C50C6C4752CBA46BEA4FF2@LV2PR12MB5893.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65964@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65964@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5893:EE_|CH3PR12MB9097:EE_
x-ms-office365-filtering-correlation-id: 5a93f90f-de56-49f4-e1ce-08deddc144dc
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: T500zmdSHsxYWY9xxFW7cdRm5nMGhVxIufyjKLsZI+ufzo/rRKb+EweGkWZb7WY/smdzSTiSpnJWM5bByqDkn89QNynxhM7qNSUg64p+sFuNHETvnnWqpbuGdWGlouGyhpGNrM3jyHmMeRSZW1JBa5w/jKCy2HrPkKhg+p1o3C9ryvoCK0ksx1lHAlbnRt2MnQ3zBWksWVPq7ryyoT1thpkkURjl3a588+jwmePoGuA7ZqIbuHUdFGRPNdDKSrF35Np1hIEn2xEP5Ok6Mfxsydp7l4CxVrjq8jlzU9M2d88v3vSrsnh2zmSil00OU8Embyp6Yv6gPRAXfwOqmnLsYyc1r7+Y0sUo93MdUAWyWf0gsbguIT1gaoeQIe6RbcIHxGgy4ELjgC9pbTL70lO19sQY3JqsXuXJERa6zMzyc2a5vUvlhJvUWCGqBOCYm2IqH9z743qcPQYAY6Oze3/IvjsYBeIaViFwVQZigPn5BomC6alG71a9r4sxtJ1UykJn7nnTNoZZhtdckda3pstg1eVxnSyKpnbKVFDfc83f/LB47IWRvlWA7JeJplJAhwEBqZBmdFhdxfMQaV9kG4blyu580hB9WqmqkA+5VUif8OpnmAy1FgJfcI+W2H1UGHrxaUJFh7HfWi9YY4kufzDVjJhCO15GHEbk3IeTbLHr9ESlkWd6b24gpm3xPW+b8r+SnBw7G7OxGjfxSbwA+9pVDEnEnvXDbCL7ytG2XyU64dc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5893.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlpsSGZFY0tvaUZrMzNCcWV3ODBDT21QNjU5YjR0VkFRTlV3VU10dmlvVWMw?=
 =?utf-8?B?Q1pxY2d2UWVTSmF0UEc3Q0xDRUl1c2hyYll1L24zYkdyVkV3NnhUNnBWUGVY?=
 =?utf-8?B?VmZPYVBIN280ZFVQQTJ0UFJvYTdQOEFFVkM4RExocDQ5bGZ6Z1FqY0hvNzNv?=
 =?utf-8?B?Snp5VHYyQUM5R2ZMMjJ5SjFWcUE0OEUwZnhrbHFOWFplZDY5WHdJcnJ6eUJX?=
 =?utf-8?B?K01ESmt3a1ZPQVY5aW90TDdFYU1Tc3FENG1QNCtlMkRyUEwxTjZ6L1RHdVh5?=
 =?utf-8?B?aWdseThmT0hTWjBNOUFueThzWE1mU3dOM3FOZEVqdWw0WmJHaEtMTC9vaHl0?=
 =?utf-8?B?SVYwa0EwSlhBTitaUE9ReDhIV0ZVQnF4S0pZK0xzWDhPbnZIcktBUGNjaXJ4?=
 =?utf-8?B?QlBDZFh0YWVMWW9TU0tCY1YwcHlST0RDb3l0YjJXVS9LdFhBOEh1MWZpaWtC?=
 =?utf-8?B?YkxXZ2U2a3hiY2s5cHRXMWhwYVZSVzkyZVl1dExvKytNWnVzMDFobHVXNEJk?=
 =?utf-8?B?eDNUdlNJUHNGZlpqZ0ZVMFZjK2xXSmU3MHdseE9mMkpxa2I2NXBJOThRTjBl?=
 =?utf-8?B?M2U1eHFZd2tMZmVabTZjelRITVdWbFNjRTA0WGtkNmltOEhkOElzeWtrVHJ4?=
 =?utf-8?B?WTFyL3VKaFI1MUhJUW44L3l6S2ljbkM1UTUyMGhLOGk3cXFFT3BrdGtBWFpZ?=
 =?utf-8?B?SWMrTUl3c1dRcnEwNjBxTllMNmYramNybUhpc2Ntc0QyTnQ5eTltWXdpN0Y4?=
 =?utf-8?B?dHhlazhSUHlqeGVrUW9rS2ZSUG4wS2liVURzdXVOY1FBSWFSdFZSMGlRVE5w?=
 =?utf-8?B?K0pRcGhGTFVnbmVGYVhFT3RsY1JpRlhPMzRzOVQvTWVCSFFrUlJ6eWhBeDVx?=
 =?utf-8?B?UVRkOElBYVdMUTBubURrTUgwY2l0UXVNZTc3Zy83aWpCZFA5aGxUb0hmdFVY?=
 =?utf-8?B?S2ZlRlhMY0NkUFc0N0orU2lPQ3l0ektHbFZVMDdDZmV1VlkyOG1idldoS25o?=
 =?utf-8?B?Q0psV3RMZWdkNUVIZ2lMQjJXbUdYaXJ4dnJVRmtqZ0hMSUZRMXgralVLZ1JG?=
 =?utf-8?B?aC9Ucm45TmtUYzhkMGkrN3daMXBBS3BBbWp4SWtOcVFISnZ6c0VYZnpUQisr?=
 =?utf-8?B?NDZJQjdsbm1PaUNwb2ltNnIxYXRpTFhXcEkwcWZ0MHpaOFNjem1RRWRvUTZT?=
 =?utf-8?B?RjdEZWZ0UWhyejZPcWZ5R1dhYnhXR2txV2FRbGZDQU95aXpBTWVNV2JoQ3pw?=
 =?utf-8?B?Z3Z6Wi9TY1ZOUklITlVtalRqQzVrM1p3RkRwa0JFQUJORG5CWjduUUIrSmY2?=
 =?utf-8?B?MWxhay9HcEZFSjkyQ0NXWVVrMUFJMDdWZ3ludG5QWWx1Zms2ZkIxQXUxRWNM?=
 =?utf-8?B?ckVEQ1Z0eGRqMjY4UjJNeHlBYS9aRVJuc1FSeHVwendOcGVpaWdZSWtMZUgx?=
 =?utf-8?B?MEtkSGZFWGdnc1FnbGlCN2lYL0kyZ2RLRkd3bWp5K2I1SWJnb1l4REVyT2ts?=
 =?utf-8?B?OEpGdWxobHo4dGRPNVNjYUlqSzVKbjd6S21OamxIWmdZTnVoWm5BOGRNOEtn?=
 =?utf-8?B?NVYzWTZWSnRyWnh3RVhxRjZaZGVwMGRkZ2lnVUdHK1BUQTdxWHB2aGk0M0lz?=
 =?utf-8?B?bE1HZmZVb3p0VExYQ0RRdHYweUozVVh4b1pLcnB5OWVFSjBCcjZPS090ZjVH?=
 =?utf-8?B?Wll1cGFUTG5ZTFRTa2FQdmN4WHl4bTdxK05STkltN3pwaWF1MXQrTG0rVU4w?=
 =?utf-8?B?dGx4eFZxcGRTZTY0NnhyZlF4YVJaTW16TmlIb3E0aWJNVVlHRzNyc3JHOHJp?=
 =?utf-8?B?eVkyUStabkNIb3didWZlSEE5eW82SGV2RTc5VzFRS09DRnFOYm10c3VFSHd6?=
 =?utf-8?B?UDl5eGJ4VW1lQllEMGZyMnB3aHk4eWhiMExtTEJyNU5Iak5jWE54UUNRUTJH?=
 =?utf-8?B?bXVUV043Mm9yWmwyTFFZa2IvSFp0STlYMUJxWXE1SHp4NEx5Zk9nV0tGNFFw?=
 =?utf-8?B?dm1BSENFelJsZm9uTFU4bDdpOExMYmVyTGEvSUJmcmt6QjN4MUtuQlFRa3J0?=
 =?utf-8?B?cnlSZHpIQXJSWUZhNk50TmxxcGc5T2pFMVRabmF3bEpQSjVZLzc3U3loMnAz?=
 =?utf-8?B?QkJLR0kzTVJRT05RSUlQS1F1bEhJM2dqa1pEa0xObmp5R243b2FUd05MNVhD?=
 =?utf-8?B?SUpEWWtXbzV1UVhzM3VJTXJreFJOWEhvWjk0MUpVMlJsdlptWi9QSE9LQVUy?=
 =?utf-8?B?eDBsSE90a2lGY3lieWZvVzRFdzhLaGNuQWpNMnR0VHlMZnRKQUFNNytqMzln?=
 =?utf-8?Q?oWY6Dp1RigBtI6VXJT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5893.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a93f90f-de56-49f4-e1ce-08deddc144dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 13:52:08.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H03v8xDkVOsauW672xw7PaN5uNgBqEb8MdKDgtqOBWltLqB075Gr6NsF0P6pceD93dnjWyUJ7N164RkLFirM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

SGksDQoNClRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZSwgdGhlIHJhdGVzIGFyZSBiYWNrIHRv
IG5vcm1hbC4gQWZ0ZXIgdGhlIG5ldyBjb25maWd1cmF0aW9uLg0KDQpCUnMsDQpXaXNhbSBKYWRk
bw0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9ydGVuIEJyw7hy
dXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDgs
IDIwMjYgNzoyNSBQTQ0KPiBUbzogV2lzYW0gSmFkZG8gPHdpc2FtbUBudmlkaWEuY29tPjsgTkJV
LUNvbnRhY3QtVGhvbWFzIE1vbmphbG9uDQo+IChFWFRFUk5BTCkgPHRob21hc0Btb25qYWxvbi5u
ZXQ+OyBBbmRyZXcgUnliY2hlbmtvDQo+IDxhbmRyZXcucnliY2hlbmtvQG9rdGV0bGFicy5ydT4N
Cj4gQ2M6IGRldkBkcGRrLm9yZzsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29t
PjsgTWFheWFuDQo+IEthc2hhbmkgPG1rYXNoYW5pQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjhdIG1lbXBvb2w6IGltcHJvdmUgY2FjaGUgYmVoYXZpb3VyIGFuZCBwZXJmb3Jt
YW5jZQ0KPiANCj4gPiBGcm9tOiBXaXNhbSBKYWRkbyBbbWFpbHRvOndpc2FtbUBudmlkaWEuY29t
XQ0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgOCBKdWx5IDIwMjYgMTcuMDUNCj4gPg0KPiA+IEhpLA0K
PiA+DQo+ID4gVGVzdGVkIG9uIEFSTSBCRjM6DQo+ID4gY29tbWFuZDoNCj4gPiAuIC9kcGRrLXRl
c3RwbWQgLW4gNCAgLWEgMDAwMDowMzowMC4wLGR2X2Zsb3dfZW49MiAgLWENCj4gPiAwMDAwOjAz
OjAwLjEsZHZfZmxvd19lbj0yICAtYSBhdXhpbGlhcnk6ICAtYSAwMDowMC4wIC1jIDB4MzAgIC0t
IC0tDQo+ID4gbWJjYWNoZT01MTIgLWkgIC0tbmItY29yZXM9MSAgLS1idXJzdD02NCAtLXR4ZD0y
NTYgLS1yeGQ9MjU2DQo+ID4gLS1yZWNvcmQtIGJ1cnN0LXN0YXRzIC0tcmVjb3JkLWNvcmUtY3lj
bGVzIC0tYXV0by1zdGFydA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgZGV0YWlsZWQgcmVzcG9u
c2UuDQo+IA0KPiBBcyBub3RlZCBpbiB0aGUgcmVsZWFzZSBub3RlcyB3aXRoIHRoZSBwYXRjaCwg
dGhlIGVmZmVjdGl2ZSBtZW1wb29sIGNhY2hlIHNpemUNCj4gd2FzIGNoYW5nZWQgdG8gbm8gbG9u
Z2VyIGJlIDEuNSB0aW1lcyB0aGUgY29uZmlndXJlZCBjYWNoZSBzaXplLiAoVGhpcyBjaGFuZ2UN
Cj4gZml4ZWQgYnVnIDEwMjcgW0JaMTAyN10uKSBJLmUuIHdpdGggeW91ciB0ZXN0cG1kIHBhcmFt
ZXRlcnMgdGhlIGVmZmVjdGl2ZQ0KPiBtYnVmIG1lbXBvb2wgY2FjaGUgc2l6ZSB3YXMgcmVkdWNl
ZCBmcm9tIDc2OCAoMS41ICogNTEyKSB0byA1MTIgbWJ1ZnMuDQo+IEluIG9yZGVyIHRvIHRlc3Qg
d2l0aCB0aGUgc2FtZSBlZmZlY3RpdmUgbWJ1ZiBtZW1wb29sIGNhY2hlIHNpemUsIHlvdSBuZWVk
IHRvDQo+IHBhc3MgLS1tYmNhY2hlPTc2OC4NCj4gQW5kIHNpbmNlIDc2OCBleGNlZWRzIFJURV9N
RU1QT09MX0NBQ0hFX01BWF9TSVpFIChkZWZhdWx0IDUxMikgaW4NCj4gcnRlX2NvbmZpZy5oLCB5
b3UgYWxzbyBuZWVkIHRvIHJlYnVpbGQgRFBESyB3aXRoIHRoYXQgc2V0IHRvIDEwMjQgaW5zdGVh
ZCBvZg0KPiA1MTIuDQo+IA0KPiBbQloxMDI3XSBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19i
dWcuY2dpP2lkPTEwMjcNCj4gDQo+IFBsZWFzZSBsZXQgdXMga25vdyB5b3VyIHVwZGF0ZWQgdGVz
dCByZXN1bHRzLCBpZiB5b3UgZGVjaWRlIHRvIHJldGVzdCB3aXRoIC0tDQo+IG1iY2FjaGU9NzY4
IGFuZCBEUERLIHJlYnVpbHQgd2l0aCBSVEVfTUVNUE9PTF9DQUNIRV9NQVhfU0laRQ0KPiAxMDI0
Lg0KPiANCj4gPg0KPiA+IE5vIG9mZmxvYWRzLCBwbGFpbiB0ZXN0cG1kIHdpdGggYXV0by1zdGFy
dC4NCj4gPiBPbiB0aGUgb3RoZXIgZW5kIEkgaGF2ZSBpeGlhIGdlbmVyYXRpbmcgdGhlIGlwdjRf
dWRwIHRyYWZmaWMsIHdpdGgNCj4gPiBkZXN0IHVkcCByYW5nZSBmcm9tIDY1MDI0IHRvIDY1Mjgw
ICJUbyBzZW5kIGRpZmZlcmVudCBwYWNrZXRzIHdpdGggbXNnDQo+ID4gc2l6ZSA2NEJ5dGVzLg0K
PiA+DQo+ID4gV2Ugc2VuZCAxMDAlIG9uIFRYIHNpZGUsIGFuZCB3ZSByZWFkIHdoYXQgd2UgcmVh
Y3RpdmUgYmFjayBvbiBSWCBzaWRlDQo+ID4gaW4gaXhpYSAidXNpbmcgdHdvIHBvcnRzIGFnZy4i
DQo+ID4gVGhlIHJlc3VsdHMgdGhhdCB3ZSBzdGFydCB0byBzZWUgYWZ0ZXIgdGhpcyBjb21taXQg
aXMgYSBkZWdyYWRhdGlvbiBvZg0KPiA+IDEuOCUgLSAyJQ0KPiA+DQo+ID4gQlJzLA0KPiA+IFdp
c2FtIEphZGRvDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBG
cm9tOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0KPiA+ID4gU2Vu
dDogV2VkbmVzZGF5LCBKdWx5IDgsIDIwMjYgNTowOSBQTQ0KPiA+ID4gVG86IFdpc2FtIEphZGRv
IDx3aXNhbW1AbnZpZGlhLmNvbT47IE5CVS1Db250YWN0LVRob21hcyBNb25qYWxvbg0KPiA+ID4g
KEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD4NCj4gPiA+IENjOiBkZXZAZHBkay5vcmc7
IEFuZHJldyBSeWJjaGVua28NCj4gPGFuZHJldy5yeWJjaGVua29Ab2t0ZXRsYWJzLnJ1PjsNCj4g
PiA+IFJhc2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47IE1hYXlhbiBLYXNoYW5p
DQo+ID4gPiA8bWthc2hhbmlAbnZpZGlhLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
djhdIG1lbXBvb2w6IGltcHJvdmUgY2FjaGUgYmVoYXZpb3VyIGFuZA0KPiA+IHBlcmZvcm1hbmNl
DQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBXaXNhbSBKYWRkbyBbbWFpbHRvOndpc2FtbUBudmlkaWEu
Y29tXQ0KPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIDggSnVseSAyMDI2IDE0LjI4DQo+ID4gPiA+
DQo+ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBPdXIgaW50ZXJuYWwgcGVyZm9ybWFuY2Ug
dGVzdGluZyBhcmUgc2hvd2luZyBkZWdyYWRhdGlvbiBzdGFydGluZw0KPiA+IGZyb20NCj4gPiA+
ID4gdGhpcyBjb21taXQuDQo+ID4gPiA+IFRoZSBkZWdyYWRhdGlvbiBpcyBhYm91dCAxLjglIC0g
MiUgb24gc21hbGwgbXNnIHN6aWVzLg0KPiA+ID4NCj4gPiA+IFdoYXQgZG8geW91IG1lYW4gInNt
YWxsIG1lc3NhZ2Ugc2l6ZXMiPw0KPiA+ID4NCj4gPiA+IEFsc28sIHBsZWFzZSBzaGFyZSBtb3Jl
IGRldGFpbHMgYWJvdXQgdGhlIHRlc3QgY2FzZToNCj4gPiA+IEFjY2VzcyBwYXR0ZXJuLCBlLmcu
IHBpcGVsaW5lZCBhY3Jvc3MgbXVsdGlwbGUgdGhyZWFkcyBvciBydW4tdG8tDQo+ID4gY29tcGxl
dGlvbj8gSWYNCj4gPiA+IHBvc3NpYmxlLCBsaW5rIHRvIHRlc3QgY2FzZSBzb3VyY2UgY29kZT8N
Cj4gPiA+IEdldCBhbmQgcHV0IGJ1cnN0IHNpemVzPw0KPiA+ID4gTWVtcG9vbCBjYWNoZSBzaXpl
Pw0KPiA+ID4gTWVtcG9vbCBkcml2ZXI/DQo+ID4gPg0KPiA+ID4gUFM6IEkgYXNzdW1lIGl0IGlz
IGFib3V0IG1idWYgbWVtcG9vbC4gT3IgaXMgaXQgc29tZSBvdGhlciBvYmplY3QNCj4gPiB0eXBl
IGluIHRoZQ0KPiA+ID4gbWVtcG9vbD8NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEJScywNCj4g
PiA+ID4gV2lzYW0gSmFkZG8NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9u
Lm5ldD4NCj4gPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTAsIDIwMjYgMjowNyBQTQ0K
PiA+ID4gPiA+IFRvOiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29tPg0K
PiA+ID4gPiA+IENjOiBkZXZAZHBkay5vcmc7IEFuZHJldyBSeWJjaGVua28NCj4gPiA8YW5kcmV3
LnJ5YmNoZW5rb0Bva3RldGxhYnMucnU+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2
OF0gbWVtcG9vbDogaW1wcm92ZSBjYWNoZSBiZWhhdmlvdXIgYW5kDQo+ID4gPiA+IHBlcmZvcm1h
bmNlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAwNC8wNi8yMDI2IDEzOjQ4LCBNb3J0ZW4gQnLDuHJ1
cDoNCj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggcmVmYWN0b3JzIHRoZSBtZW1wb29sIGNhY2hlIHRv
IGVsaW1pbmF0ZSBzb21lDQo+ID4gPiA+ID4gPiB1bmV4cGVjdGVkIGJlaGF2aW91ciBhbmQgcmVk
dWNlIHRoZSBtZW1wb29sIGNhY2hlIG1pc3MgcmF0ZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFw
cGxpZWQsIHRoYW5rcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQoNCg==
