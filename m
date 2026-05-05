Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D86CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86A040684;
	Tue,  5 May 2026 18:05:46 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71]) by mails.dpdk.org (Postfix) with ESMTP id 5ED6A40676;
 Tue,  5 May 2026 18:05:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGrbCrY3hI5Bc5fUYav6U7gE4kS2XXA0EypBOGeoSsMSstVgf5hvEivIfxehG9aHTFLr/ryyeS1Er3OR+ZcUp5ovsvAPlBzt5SBtBjxrqNIkUGP5NUdB4N8C/kUxROntlCK4eW2ra8vCEuzCjaFV9lMGho23M8sZm8xKv4hMX3b8BWTyTNz/jiLz7S+yiC6KUwtjsyDS5O8hX+W0rgxEeIEwGp0l9QNXWB5hYWPcS5XMpm6rfcWJD/BmgMQ8PYR9stM59/8XvyQjHZW8VmLNF+llm/OY/r78SCCibKZKqocv9asHsTbYeXbC052eQfzSxuTUHH9tHnFGkCcN3w5NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUatFWwGyhauHHXBZ6nceOMgJ1OT7z2SPs9JPuEmhuA=;
 b=cb4pHjqfPEKP8GFq0eoSOCiZ1VBEKC/m+W8uecpN4pOyg5nb+XUsNGp49XFnjlcEqOpnosjVZAt8KUfXmtwO2oiEbnuvV8QtiMplJdLfzP3f/+8pgwWSiHcIrA7XwB31XRUcdTkQmCgcobyt7PKCmnnVcN9azkM+0JNbbIT0gDeK7RBNUMxAjskdotwdQ0wgkaoNkf0J1/7+o4rPJBgxy05cLR+RxyKMJNoIAjbPiq6VADvJAmgyjN9GVW3joylAOq5JuaNgnZybT+mt6QF74vbCbda33RzLpHqQIPuoSVeVXoWpiwHKjWkuH4AC4NkWxpr5memeWWoAr+72dJdxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUatFWwGyhauHHXBZ6nceOMgJ1OT7z2SPs9JPuEmhuA=;
 b=aUE2s3k8o9UmG+UOuKJg3/4hICyMsBufKwKvj3zm7ygQcSD/T0/jUXQH9gk014yn21S/h7YLt7Lbo1sJ2YTyJZUss87zYNwSsv5QyNBIqEoqD9GR3f/NLe/rwjnrg6ZG1UUkyTschbP9EBt8gNvYfnHcSoC2PavAaooMkaRI82vpZ28hZalFvflHvnkkGf1MKJQHzuzsEaJk21pK8iyMpOHJfLRKkBIaPX+G8Elx65t3fdvryFM+SeM8TlWaCeZAsmoizeNefNJK7mfyrLsJTkgbFZkBuglhpYB6FkiNmP/EZFGqqd03REQ4v7L6UkVxXfMFc2O/baIFHkx+z4nsMw==
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:05:38 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::b2c3:ee20:6aeb:7f6e%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:05:34 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes
 <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin
 Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>, Raslan
 Darawsheh <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>
Subject: RE: 23.11.7 patches review and test
Thread-Topic: 23.11.7 patches review and test
Thread-Index: AQHc0VqZIgFPFkllCEidwxNFPHjfIbX23uqAgAjQRVA=
Date: Tue, 5 May 2026 16:05:33 +0000
Message-ID: <IA0PR12MB8422BB6E2F76CDF69CD2E443BF3E2@IA0PR12MB8422.namprd12.prod.outlook.com>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <DS4PPF00BBED10CC6595A70B04B9F7704AA9F352@DS4PPF00BBED10C.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF00BBED10CC6595A70B04B9F7704AA9F352@DS4PPF00BBED10C.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8422:EE_|SJ0PR12MB5635:EE_
x-ms-office365-filtering-correlation-id: 2220a1da-808c-44d7-fbc4-08deaac0238d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: bXp+/wJB2We8hCehOiMyjHUHWL3P4dxA+HhjfEXgXmHol9oazg/x4Fvua9o99rJWPkO9uKPXkeCcgyG1/OKTo4wmbJuZjdN38fmZPFHq2cPx4CkGH54L+okFjxg16Gp2348DZH/iryA47Dtthlv0y03lYlqLSM6n/7i0SS/B8hck2Mo+Ao0xoZ+ZxiXwIBGD5C577PgswbHzctFCDD/se4cBUanJV3+QeIrvPkRQbwsA5GXg+BtagTcg8KRcOMFcn7w3dYWmcEB1aGujiZfCEujWJQbIplmeNJe7/TWtjstRJ8fT2cpi6dYeADf5NSmKrpOXHe4WAmJq+A06IZs5JjkR04EiJKanxaTS8PNGE0aPAbjtYvzBLITOwsKgzUmXo3YmCu41d77PPFHeRnBOYWhchSaVeI70lzRHSYMDFdiaOmIQt+6+C9lbUbl96K2n4juiZ6rxNGeKY4pz7PuITv4wtGWAnQUUNbymnmoYkw35k/fTfbkB/KkrxI1Wr6DbctcMUCXbs9zeFXf8WviHmf1XiCd1mEzaTrYEQk9RJ8Ij9sdZsdZERZAl8e+c658slw44TG8MPxY1ytBQfaqL/xhPBlONtkHSytrT4/klRRKuDYFkBDIIICuFjQSM/LOmVbSQDJ4X8ytPofNITTRkeAcGFbReCgW8O9IlIw/6UuQy8wLp8BOPa7c6RF7WLScGiH0VVdDtm7S+EO4ZuLa1GDDRqSIvqyG/aLleTQZYk2gp4QDKN3dh0LssxPfWcCoG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZVYlJtTHlXOGNteDhRby92R2R2MnpmWGJIMnF2OEVuM2R3c24vZVhHU2l6?=
 =?utf-8?B?eExjVkNkWkFyYlVoR3pScWdHOWNHemk4UTBnLzVZZ2ZvUDlZSk9WV25Pbjdt?=
 =?utf-8?B?MlVMbEVrRThPSmtTTkFGMUY0Yis3UHZGbzk0UHZGOVcrOHhOb1RPaU9RVGJ5?=
 =?utf-8?B?NldOMm1GbFlUYmRtZFFzTWc3bkZWejM1TzFkZjJnVTVSK0FXOEplTk9rOHJ3?=
 =?utf-8?B?aU1Td1pTQzBpeXNzVDhmMENKN2QzSkMvSU0wN2dOb0VXd2FGaXR4eWFsUEJw?=
 =?utf-8?B?MkdQNVpPN2ozdk15RDRIR1ZOWDBLK0pwYWZyRTBmWEhDMU12MzI3aHpNNDV2?=
 =?utf-8?B?dmFUbGpiYTdIRkNJZnVnaXZHQWcvVjNWellGM1ZtUmI4R3UycnlCdzZraVUz?=
 =?utf-8?B?NWtacHJxc1dJTm1oM1Y5aUZCMXJFUDVScUdlTGhNNUZaOWtLbHdyUElyNExn?=
 =?utf-8?B?N1U5b2RlVHFIYVg5dXcwZjVtekRGZDlwcUpVVmpuYTNMVy9sVTh5eTJsN3Uz?=
 =?utf-8?B?L3Fvc2YrK2hYZVdOVUtkSXNaZEFqZXlJczUxYlFlVS9HQ0x4MHNRWHJ0WVV2?=
 =?utf-8?B?bUNjajc0US9uQVRxQjdaZlNDdnN1cjdYZmdxWGZDaWhvWkUvUzM2cG0yemw5?=
 =?utf-8?B?U1lUdWdzTFB1SmFBQWhvZjI0TnNDdjIyTVcxYU83aVFPZVFmNnhFZU1NMnVY?=
 =?utf-8?B?bzh3djRYdmFqSDdTTWNobWMyMFhMbnJZOWJQUDlxeG01dTQ1RXVpcVJmZTYw?=
 =?utf-8?B?aHJ6dGZCWG1SN1IrRXhpeVRvV013TEJIejN0UkZVa0hLR0ZpSzdOdU9vK3pa?=
 =?utf-8?B?WC9wMnhyM2ppQXJQR2p6a0p0ektrY01JVkNkRnJDWnBYMTdxRzNLSEsxK1Y4?=
 =?utf-8?B?LzRvVm9KUSt6YjZ0blMycDJhZm1lellKTWJXWEU1bm9qUGtGV3dUSjYveDlD?=
 =?utf-8?B?MzRTUFZvVlo4Z1RKbnNaeHM5Uy95UG56S0JnakxNYXZVYVp0N2dIQ0FjNnp1?=
 =?utf-8?B?c0hnamcxOGpLL1p3Z2Rlb0RaUzZIbHY1UHJGcXBGUWJoWU01UFFMbHIrdk9k?=
 =?utf-8?B?V0hRN2JueUR3dHJxd0dmQlNzbW9FbHNsVFRaTTFuanZOL1hac0Mzdy9iL28y?=
 =?utf-8?B?bnRYZnBkTmdmYXFkNGt2Sm5jQ2V0NkxRemdxVCtLTDV3LzZkVlAwQ2c3UklQ?=
 =?utf-8?B?VFhpZlpydVd1MGtHZ2xwQ0k2aDhOTmZWUERTTHA2b0hPVHFMRkxoUWJvWlpR?=
 =?utf-8?B?ZlR4L0VYSTVuaFM4WDRSOG85cFVLUlBkWklNQXovY0FvUkptY2xTdUU1dHA3?=
 =?utf-8?B?RTBkRlRmVVdHWDR2UEx0TFZ6NHFodXZKZ2hvVmc5aEtEZFJGdldWclBZVmtW?=
 =?utf-8?B?aU1PdlNodml1cHA3d0FHVGdTSHlaaFEvdWw2K0RXbzF2Rm9GbENidWxsSzgy?=
 =?utf-8?B?blF2OFpWZWh2V1BTWEhrNXBCZUVKUCtpcjFxSXQ3dEZGZUtyR2RMUWZUL2l5?=
 =?utf-8?B?Uy92QU83NWowYUpxZk5kUG5UdUZJK2N6SC82VEtFMnBpSWR2RW5KMVNyTzFO?=
 =?utf-8?B?dXZ6ZGpuSFJaY0xXeVZOUEs2QXdPSUZhY1pnd3J5Wi9SZWM0Si8zVmgwdTRS?=
 =?utf-8?B?eW9GWmIyM2oyYk1hK2JhcW1RSWxybGFmUTZWbEJBZS8zTTZkRkhMWXNFaUNK?=
 =?utf-8?B?RkhGRVF4ZldUTGk5Z2JyeUJWYW10amkySE1GRi9wWURiWm02ZHQ1bFNlYmxT?=
 =?utf-8?B?bXZ2Zmt6a3RXVzhhN1cxWUsreHhOTmt5QmVPZS9VRDNjbzVGb29XVlhRMDJT?=
 =?utf-8?B?VkxIVWVBQzAwR3FHY2lRTUJTSks3WHlkQWdhb1NNQVJ5NXJaaDVxQmdodWtr?=
 =?utf-8?B?YUdMYVRod2dzRE1DNmhoZTk2REk4R21aWktNVEMxQjVJbjNHRmhVUEk3Q3o2?=
 =?utf-8?B?RXBxMUozcWdOMmw3ZnZOZ3laRnc0L1NNNEVpbEh3MzVvQzV3VGlJTUJTZVJR?=
 =?utf-8?B?dHR3aXd0cUVEc2RSL2FuVlE0ZG40OXhPV2FpZUJkZExUYU1KSWJkZStzM2Nl?=
 =?utf-8?B?MnczNmhSdTY5cjlnVlBxU2NMTGtHVjFleXo4UThLZEFuQVdKSk82MjJ2OVBu?=
 =?utf-8?B?bkJka0FtTngyMk1sZXpDcDk2KzJ0Tk1oTkxXMlh5Y251bjVPK255V1FGaGVB?=
 =?utf-8?B?MDBkbFBHRms3UzdYVGQzb05oVUF4V1JKZG1hYlZjdjU3aHZwVExLdDJDdmVu?=
 =?utf-8?B?eVUvUzA2aGw4c0kzTlovZCs1RkRjN0Vmc1c4S09EV2FGRWkrbjJSVlJpc3o1?=
 =?utf-8?B?WThxa2ZPendFZFpFMkRSWlAyWkNLb2IxWlJ5aHI3Wlc3b1dDcjUxcnVsTk8w?=
 =?utf-8?Q?oIbvtgtAVylmNxAGe0lScEOkyX0Sm6WNZ6kxI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2220a1da-808c-44d7-fbc4-08deaac0238d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 16:05:33.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/xuFRUjlQvvB/RHOpLz0CEyX1z8WKTZXCDZTZzTNyhIcLysw3CokIE72DqsN1lusQMMVjSRkNKAFdOL+z79Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWHUsIEhhaWxpblggPGhh
aWxpbngueHVAaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgMzAgQXByaWwgMjAyNiA0OjMw
DQo+IFRvOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+OyBzdGFibGVAZHBkay5v
cmcNCj4gQ2M6IGRldkBkcGRrLm9yZzsgQWJoaXNoZWsgTWFyYXRoZSA8QWJoaXNoZWsuTWFyYXRo
ZUBtaWNyb3NvZnQuY29tPjsgQWxpDQo+IEFsbnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+OyBi
ZW5qYW1pbi53YWxrZXJAaW50ZWwuY29tOyBEYXZpZCBDaHJpc3RlbnNlbg0KPiA8ZHJjQGxpbnV4
LnZuZXQuaWJtLmNvbT47IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsg
SWFuDQo+IFN0b2tlcyA8aWFuLnN0b2tlc0BpbnRlbC5jb20+OyBKZXJpbiBKYWNvYiA8amVyaW5q
QG1hcnZlbGwuY29tPjsgTWNuYW1hcmEsDQo+IEpvaG4gPGpvaG4ubWNuYW1hcmFAaW50ZWwuY29t
PjsgSnUtSHlvdW5nIExlZSA8anVobGVlQG1pY3Jvc29mdC5jb20+Ow0KPiBLZXZpbiBUcmF5bm9y
IDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYSBCb2NjYXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz47
IFBlaQ0KPiBaaGFuZyA8cGV6aGFuZ0ByZWRoYXQuY29tPjsgcWlhbi5xLnh1QGludGVsLmNvbTsg
UmFzbGFuIERhcmF3c2hlaA0KPiA8cmFzbGFuZEBudmlkaWEuY29tPjsgTkJVLUNvbnRhY3QtVGhv
bWFzIE1vbmphbG9uIChFWFRFUk5BTCkNCj4gPHRob21hc0Btb25qYWxvbi5uZXQ+OyBZYW5naGFu
ZyBMaXUgPHlhbmdobGl1QHJlZGhhdC5jb20+Ow0KPiB5dWFuLnBlbmdAaW50ZWwuY29tOyB6aGFv
eWFuLmNoZW5AaW50ZWwuY29tOyBQdXR0YXN3YW15LCBSYWplc2ggVA0KPiA8cmFqZXNoLnQucHV0
dGFzd2FteUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiAyMy4xMS43IHBhdGNoZXMgcmV2aWV3
IGFuZCB0ZXN0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiBGcm9tOiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+DQo+ID4gU2VudDog
VHVlc2RheSwgQXByaWwgMjEsIDIwMjYgMjo0NyBQTQ0KPiA+IFRvOiBzdGFibGVAZHBkay5vcmcN
Cj4gPiBDYzogZGV2QGRwZGsub3JnOyBBYmhpc2hlayBNYXJhdGhlIDxBYmhpc2hlay5NYXJhdGhl
QG1pY3Jvc29mdC5jb20+Ow0KPiA+IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPjsg
YmVuamFtaW4ud2Fsa2VyQGludGVsLmNvbTsgRGF2aWQNCj4gPiBDaHJpc3RlbnNlbiA8ZHJjQGxp
bnV4LnZuZXQuaWJtLmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+ID4gPGhlbWFudC5hZ3Jhd2FsQG54
cC5jb20+OyBJYW4gU3Rva2VzIDxpYW4uc3Rva2VzQGludGVsLmNvbT47IEplcmluDQo+ID4gSmFj
b2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IE1jbmFtYXJhLCBKb2huIDxqb2huLm1jbmFtYXJhQGlu
dGVsLmNvbT47DQo+ID4gSnUtIEh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQuY29tPjsgS2V2
aW4gVHJheW5vcg0KPiA+IDxrdHJheW5vckByZWRoYXQuY29tPjsgTHVjYSBCb2NjYXNzaSA8Ymx1
Y2FAZGViaWFuLm9yZz47IFBlaSBaaGFuZw0KPiA+IDxwZXpoYW5nQHJlZGhhdC5jb20+OyBxaWFu
LnEueHVAaW50ZWwuY29tOyBSYXNsYW4gRGFyYXdzaGVoDQo+ID4gPHJhc2xhbmRAbnZpZGlhLmNv
bT47IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9uLm5ldD47DQo+IFlhbmdoYW5nDQo+
ID4gTGl1IDx5YW5naGxpdUByZWRoYXQuY29tPjsgeXVhbi5wZW5nQGludGVsLmNvbTsgemhhb3lh
bi5jaGVuQGludGVsLmNvbQ0KPiA+IFN1YmplY3Q6IDIzLjExLjcgcGF0Y2hlcyByZXZpZXcgYW5k
IHRlc3QNCj4gPg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEhlcmUgaXMgYSBsaXN0IG9mIHBhdGNo
ZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDIzLjExLjcuDQo+ID4NCj4gPiBUaGUgcGxh
bm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyAzMCBBcHJpbCAyMDI2Lg0KPiA+DQo+
ID4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlvdXIgdXNlIGNh
c2VzIGFuZCByZXBvcnQNCj4gPiBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8g
dGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJlbGVhc2UNCj4gPiB0aGUgZml4ZXMgYW5kIHJlcG9y
dGVkIHZhbGlkYXRpb25zIHdpbGwgYmUgYWRkZWQgdG8gdGhlIHJlbGVhc2Ugbm90ZXMuDQo+ID4N
Cj4gPiBBIHJlbGVhc2UgY2FuZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZvdW5kIGF0Og0KPiA+DQo+
ID4gICAgIGh0dHBzOi8vZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxlL3RhZy8/aWQ9djIzLjEx
LjctcmMxDQo+ID4NCj4gPiBUaGVzZSBwYXRjaGVzIGFyZSBsb2NhdGVkIGF0IGJyYW5jaCAyMy4x
MSBvZiBkcGRrLXN0YWJsZSByZXBvOg0KPiA+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9k
cGRrLXN0YWJsZS8NCj4gPg0KPiA+IFRoYW5rcy4NCj4gPg0KPiA+IFNoYW5pDQo+ID4NCj4gPiAt
LS0NCj4gVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazIzLjExLjct
cmMxIGFsbCB2YWxpZGF0aW9uIHRlc3QgZG9uZS4NCj4gZm91bmQgMSBuZXcgaXNzdWUgYW5kIGZp
eGVkLg0KPiANCj4gRFBESyBidWlsZCBmYWlsZWQgd2l0aCBjbGFuZzIxLjEuOCBvbiBGZWRvcmE0
MzogIC0tIEZpeGVkDQo+IA0KPiAqIEJ1aWxkICYgQ0ZMQUcgY29tcGlsZTogY292ZXIgdGhlIGJ1
aWxkIHRlc3Qgd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZlcnNpb24gb24NCj4gdGhlIGZvbGxvd2lu
ZyBPUyhhbGwgcGFzc2VkKQ0KPiAgIC0gVWJ1bnR1MjUuMDQvVWJ1bnR1MjQuMDQuMw0KPiAgIC0g
UkhFTDkuNi9SSEVMMTANCj4gICAtIEZlZG9yYTQzDQo+ICAgLSBGcmVlQlNEMTUNCj4gICAtIFNV
U0UxNg0KPiAgIC0gT3BlbkFub2xpczguMTANCj4gICAtIEF6dXJlTGludXgzLjANCj4gDQo+ICog
RnVuY3Rpb24gdGVzdHM6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KPiAgIC0gaTQwRS0oWFhW
NzEwLCBYNzIyKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nDQo+IGJhc2ljL1JURV9G
TE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+IG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZY
TEFOL1JTUywgZXRjLg0KPiAgIC0gSVhHQkUtKDgyNTk5KSBQRi9WRjogdGVzdCBzY2VuYXJpb3Mg
aW5jbHVkaW5nDQo+IGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtDQo+IG9m
ZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLg0KPiAgIC0gSUNFLShFODEwLCBF
MjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9Td2l0Y2gvUGFja2Fn
ZQ0KPiBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FD
TC9EQ0YvRmxleGlibGUNCj4gRGVzY3JpcHRvciwgZXRjLg0KPiAgIC0gSVBzZWM6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5IGJhc2ljIHRlc3Qg
LQ0KPiBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCj4gICAtIFZpcnRpbzogYm90aCBmdW5jdGlv
biBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcw0KPiBQVlAvVmlydGlv
X2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZg0KPiB0
ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjAsIGV0Yy4NCj4gICAtIENyeXB0b2RldjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9Db21wcmVzc0RldiBJU0EtDQo+
IEwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KPiAgIC0gRExCOiB0ZXN0IHNjZW5h
cmlvcyBpbmNsdWRpbmcgRExCMi4wIGFuZCBETEIyLjUNCj4gICAtIE90aGVyOiB0ZXN0IHNjZW5h
cmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0KPiANCj4gKiBQZXJmb3Jt
YW5jZSB0ZXN0OiBBbGwgdGVzdCBkb25lIGFuZCBwYXNzZWQNCj4gICAtIFRob3VnaHB1dCBQZXJm
b3JtYW5jZQ0KPiAgIC0gQ3J5cHRvZGV2IExhdGVuY3kNCj4gICAtIFBGL1ZGIE5JQyBzaW5nbGUg
Y29yZQ0KPiAgIC0gWFhWNzEwL0U4MTAgTklDIFBlcmZvcm1hbmNlDQo+IA0KPiANCj4gUmVnYXJk
cywNCj4gWHUsIEhhaWxpbg0KDQpUaGFua3MgWHUsIHVwZGF0ZWQgaW4gdGhlIHJlbGVhc2Ugbm90
ZXMNCg==
