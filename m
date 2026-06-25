Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34021CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62A2440678;
	Thu, 25 Jun 2026 18:12:16 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71]) by mails.dpdk.org (Postfix) with ESMTP id 72452402D2
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:12:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okW4cToRD2F2/1HKNax5ivp3bVrVDVhmILHJ8263POyvu0t2ZVcx0h1ZTOpsgks8Ky1viBi/WNxASkGX87bLuHiB/5mq+VwEyfbk+ohWIhLeYJN9mbykyN8pShxLVYWazkYwgBWjsXLV/Ld3TFNTntTVYFI+9I4nluXbXk/bjQlqtA2KbYtMPxtk6vYKiQNZIKlbWJqr9koLPXOxI3uZLptCUYAPhOPyVB7Ttfm1IrWM3hVM4GApxGugojWxeymU/j/SlTz+vK5b3RCZBYOuaX1GhEz9vDy9bV8/iFVKFNIwHrOJ9RLlFMCkjd4GGlvfVmsaQv9Yabw2R+InYVFK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH3kNc+JBplTsnhSj5OG0rZ7bFquhrlyR7Ha74l4J5I=;
 b=Bd6dBYQ0fr3gUcSDi9BFTZixcOJyLs1KLNzBHBEDQ3y8LM6o08+4qQZWvLIO52NtCm+kQcavSstUo52kF+lw5Vq//6DisFOrfYnjSyKNrtMza5VqhU6EUSnyie3HkvxM3W9i/2DzqUmUWp5osYmLbr88XP5dXCgUANF1fYCxZL0aif47BH69xCEh8JdBvzV3nu4m0JApbZaVwEHqipeTfuSZtrv1k3OemJsCrC8n0yh5bqL78Pu7HP8T0CNBbUXRPEcOC39kpj6aVw15PGa/Esn8HOc7TBtmF1dfSJJIVxoUv2pSA+Bcrm11Phgpj0fnuza5Rh6yqLu7paILKbnbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH3kNc+JBplTsnhSj5OG0rZ7bFquhrlyR7Ha74l4J5I=;
 b=VlciGZZgNTrAsQzutEoaWsGZmwyXebf+PODl+wrtIuqmukA0i2Y8of1clJgM7fTcb3pl/I3iFAXF1PNdnAf9O0TCS82F5aju0VUaox8Wh/5eg5MBeMe9iE5ghONkR+FQVhomoW2FM9oG2Q7GufEyNZbh/FDdj2S2wt8fU1xgP6DahLNz8LfPiVR9M6tqn5z+IgguEcYQAwx74do7tzytkD6rP8sZu+NXZUBVDeJI42CQzhfOFnDB7SOd2gxPhHdjE9KRXadkX5JRxRXL16Uew8sM+69TeY6KOQu+X3bt9hN0cbZlO6MtIcgN5VdgohFgAmX2xuVtQ6GA5lrcH+bXhw==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by DS3PR12MB999240.namprd12.prod.outlook.com (2603:10b6:8:38f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:12:11 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 16:12:10 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: RE: [PATCH v3 2/4] build: support function versioning for drivers
Thread-Topic: [PATCH v3 2/4] build: support function versioning for drivers
Thread-Index: AQHdBKdr4NJYbfb6eU22jsrlLAYaf7ZPWT6AgAAYGVA=
Date: Thu, 25 Jun 2026 16:12:10 +0000
Message-ID: <PH0PR12MB7077831AE926E36769FEAC81A4EC2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625133311.1299705-3-dsosnowski@nvidia.com>
 <CAJFAV8xG+jGPqzEfHOK3vNcezvsQ53sjq3myr1QoMRmE5wNsCQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xG+jGPqzEfHOK3vNcezvsQ53sjq3myr1QoMRmE5wNsCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|DS3PR12MB999240:EE_
x-ms-office365-filtering-correlation-id: da0a87e6-cdba-4eaf-9a35-08ded2d4831e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|22082099003|10062099007|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: rIVWn87DWIkPniUjD7Qbuo4JZJvW+5yUnh0cj/DEVA0bo6Pj78TKi6SIF7YE50X3UVG69a1eujWISa+I4Ak8QzLkuacVmDKsOBOVeZfjjYmV2rxJgJcm8bwG766U6/dXDWPDB1bFRCYtevTpTtQINtE1Rt3ebkqES49kSdoW+4L0pOXUZOrQDtRrACgAzV7z9ehFHZDHm1/PS+Xe8WqhL5X0Ia5HCcYWCAIVQURfPWq6Xok0lZH7nTKDdTW1dVsYHcY/8m8x+IImmm7gHVW1KmnsyzvvpaP9gbDtHGz1pc2ihX2sqJWETWgfElR627g2l5pyd3mul8O+kZIGp3xZQrm7uWtUHedchhqdGnC+vAb2Zo8JuZp8XVwoZY6jTBK7O7w+QUFvRJh0qAvRHubhsmRjaUBloLSRoNHupa6Ar9XLWObsoXng672KZwopaaL37CG4lJ2avtChYk2m/jwDH0AfwbAi2ez+UeVfM0aKAg/2+lLXUOa8XdHzPLRsCk9Ryobvze1gSABzQfnrX5sMknMs3ID6Rrw7Q1YU3i3C9SZydSrXvuFmT85GMHJBzx1I9r3zzj6/Ga2lw998KRXBuwFou/WzFNgM6D6z8xkltWWn+AWDGZ+MPDcUsGZV14lFXM1oPhVKwRyKAnLFWzfF5gChgs/6VqbMaLALjXqGn42leD6HWA6HgfW2mzYc5Y3QIyj88BiotzB03B9e0cGwY8oinudwTQi/7UYFhrgvQSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(22082099003)(10062099007)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1RONFNDd0U0QVN5SUdqMVI5cG5ocEFtdGRtYXNrZndOc0pMYXl3MzRGdGx5?=
 =?utf-8?B?OCtBZ0gzRmNXL1EzTnZBN2tibGkrZzdsL3dYTUc0Z2Zad1BmQTFpb2E4aG1x?=
 =?utf-8?B?YWtzOC8xQ0RQTk5iRWxpWkcya25rMVI2c3dsc01iQ3g0Z2s0eU8xcy9laS95?=
 =?utf-8?B?THM4bGNEazc0Zk9DZ1hkcUlLS1NTOHM5aXNRdUlBRE1oWFR6aTdBNXYyN2Vs?=
 =?utf-8?B?OUZFUWpHbXJybUZQZGYyUVNvVHRrZmRSM3JlSjVKNXl0OHBSYnFDS3M1RlNI?=
 =?utf-8?B?elZNTXY2MG4rVmYzdkNMd3ZaaWhSMGJ4UDlnU1dqRU9rYVQ0RTRXZEd1Ykdj?=
 =?utf-8?B?MnpEMlpwM3FqVk1VWERrUHNMQVRGUDNpdCtPQ054Y0pGM2F6TjN6N1JYdko1?=
 =?utf-8?B?U01Ic3N5L3F6ZTlEaDlNRzlKdHRIVTFqcWRTejg0SXpTQmtlMWVEakpteXI5?=
 =?utf-8?B?N0RBbDhnMnBSd2g1dmFIYVBMU2RnYVd2aXJGc3ZNcWhGa1FTUDNWYUFmWUZJ?=
 =?utf-8?B?ODc5eVZTTzRZQmpveXpkNnpSMEM0NW03ZDErRm5UT2EzOFFTbFc0bWdaczZW?=
 =?utf-8?B?ZDNsbFdHT0tGTGVpbGVlWDFKLzFqcURCWWh2NHJDNy90WmVFRkRGZEg4SjBs?=
 =?utf-8?B?RXlMcUJwejYxN3gvVzYvMlFYUWpibGtHRjNadnk5SmdPaWwyNitzWVZMbThs?=
 =?utf-8?B?VEtLR012UGVMUHJkZ0k5cjZtVVBhOHhvVXhST2ZBbEk1aCtFcGZmd002REdG?=
 =?utf-8?B?WmgvaEpWejhhT050d0k5R0RvSTQwRDBFT2Qxa05Ca3hKa3R4RlkzRmxUL2dJ?=
 =?utf-8?B?a0crTnM3WVpYanJiU2ZRbDdRNmkwWGp1M1c4dVBidjBvangzYTBIcHJGek5R?=
 =?utf-8?B?TW4wSGJtb0lEZTc2NWl3RlpMdHBzTm1nbTR3MlpjbVZuNUF2cGVsYVJnS0FE?=
 =?utf-8?B?Q1N5YTNFaStYc1c3UWRjeGd2T1dzUUVIdWo4SkFQM1QxcXU5Rnh5eUVGY01E?=
 =?utf-8?B?NUN0QnF0Zkx1UlRIQUdrKzhuUnhkanV1bk51U25yM1NWeDF5OWdldHJHSFpM?=
 =?utf-8?B?TENVQVhSbDRyWDBPQkpuZFRSQjJndjBYQmZvYUdHMDRUblpnbkt0bklKUklZ?=
 =?utf-8?B?QkpXVlkwYXo3aVVrc3d0dU9qSXpnVVI0dEEzcXVNR2I5ZWZTQ0RqUmw0K3lN?=
 =?utf-8?B?ci9BcXduT3BWWVIyQkVzZEJNZzhMcUFNTENpTERxNGhGa2srZk5LZEFEWVZP?=
 =?utf-8?B?bWxlS2Y4bXVvdHhCNlhkR1lVNmdoRXMrN0ZBZTY4WGN2M09zL0pySDFPQTdl?=
 =?utf-8?B?MXY2UW9UczkrVVJydWNVenhoMUM5YzF2dTRDellqUHpDcU4vNVBLNldOY2Nz?=
 =?utf-8?B?dnRxWEFGbHZSbmoxeXhvd2ZZZzFvWlpjMGpzcG4wcTdtRzhhMTVPR0REL1Ir?=
 =?utf-8?B?REhoZEpKc3EweEpoSndld0swM2ZMV1VkeGVEcDFma2lpc1VhVm9NQ1ZoMyts?=
 =?utf-8?B?N2l4S2JHbW84REs0VUhkcWJESWZ5eTNSZ3E2RUcvTFVTM3dxdjhjVDNPWXRI?=
 =?utf-8?B?d241ZitzZ1huNG9Eb00reWxyckZLdmt6d3lXNm9VTE1oVU83K1FxeXZnU1dz?=
 =?utf-8?B?ZFNVR3I1Vjd3RENLbVZBblMveTlmcElSY2lJZFg2T1NGV2dtSWMwMFlQSXA5?=
 =?utf-8?B?RzkvU2R4ckxRSTB6N1FicW9JZUh1S2VrRnY0RVNsdFN0a0EvN2k4MVdRZVFE?=
 =?utf-8?B?RDd4S0w1a0pBQ3ZKTUZCSmxFRVFva0t4aHdTMU1oTWVBTmxkVkxSMWIxSXIy?=
 =?utf-8?B?ZlQyb1J0Y3NIMFpzZE9aSlNESTQrZHQ0S095MTBHbjdadmZEaWZGM0lvTENq?=
 =?utf-8?B?akVkaGVCcHJJbUIvVDZZblNxUi9INUU3bW50T0p6d05FTGlxNnNhaURDMzQr?=
 =?utf-8?B?TFcrd1ZYcHhhbEoyYmJmaGhYbUNNcTg1T1F6NU1EUUhydVBYdG5IL2QzNHhW?=
 =?utf-8?B?bmZ6TmhzR2tLcmJVKzZ2U21ZMUMxTTlFREJPODBYd2wzaTMvZitMOHVRSkRn?=
 =?utf-8?B?d3V6QTlPNDRNYjV5UjFIMExPQmkrVHNzb2d6b1d6bVV3c1lVdHJzamlxVllJ?=
 =?utf-8?B?T1RWQjdaWjZGUElqdk1rUkVMelRiZzV6emNRWi81UjdRaVNuMkFYcnkyR1pL?=
 =?utf-8?B?bnVyR2JScjBhZ2JKUjBubDhLRjRSWEZoRFdQZWxheVdvK1ZRMWZEZjgyNXNp?=
 =?utf-8?B?VjZNR0E1UUZMUWRXQkNBNUNENERCMk9iMTlHSktsdTl0b2V1RUEyV21odlkw?=
 =?utf-8?B?WG1tSGIrQzBud09Oc3U1eWNDZ0JySXcrVklCWUZFMjZCb1lPc1NIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0a87e6-cdba-4eaf-9a35-08ded2d4831e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 16:12:10.7685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qmcs+Oe+Dqbrmj1gbuDtP46/Me1cxKqKiD9EHIJkzi2d6ZdJ9vnF3+nsxssw4pndXGO3czBLzKa4syntWtDhqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999240
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
MDI2IDQ6NDYgUE0NCj4gVG86IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5j
b20+DQo+IENjOiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47
IGRldkBkcGRrLm9yZzsgWXUgSmlhbmcNCj4gPHl1eC5qaWFuZ0BpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgMi80XSBidWlsZDogc3VwcG9ydCBmdW5jdGlvbiB2ZXJzaW9uaW5n
IGZvciBkcml2ZXJzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgMjUgSnVuIDIwMjYgYXQgMTU6
MzQsIERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGVuYWJsaW5nIGZ1bmN0aW9uIHZlcnNpb25pbmcgKHRo
cm91Z2gNCj4gPiB1c2VfZnVuY3Rpb25fdmVyc2lvbmluZyBtZXNvbiB2YXJpYWJsZSkgZm9yIGRy
aXZlcnMsIHNpbWlsYXIgdG8NCj4gPiBsaWJyYXJpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21lc29uLmJ1aWxkIHwgMjEgKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZXNvbi5idWlsZCBiL2RyaXZlcnMvbWVzb24uYnVpbGQgaW5k
ZXgNCj4gPiA0ZDk1NjA0ZWNkLi44ZjNhYjQ5MGVlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bWVzb24uYnVpbGQNCj4gPiArKysgYi9kcml2ZXJzL21lc29uLmJ1aWxkDQo+ID4gQEAgLTE3MSw2
ICsxNzEsNyBAQCBmb3JlYWNoIHN1YnBhdGg6c3ViZGlycw0KPiA+ICAgICAgICAgIHBrZ2NvbmZp
Z19leHRyYV9saWJzID0gW10NCj4gPiAgICAgICAgICB0ZXN0cG1kX3NvdXJjZXMgPSBbXQ0KPiA+
ICAgICAgICAgIHJlcXVpcmVfaW92YV9pbl9tYnVmID0gdHJ1ZQ0KPiA+ICsgICAgICAgIHVzZV9m
dW5jdGlvbl92ZXJzaW9uaW5nID0gZmFsc2UNCj4gPiAgICAgICAgICAjIGZvciBoYW5kbGluZyBi
YXNlIGNvZGUgZmlsZXMgd2hpY2ggbWF5IG5lZWQgZXh0cmEgY2ZsYWdzDQo+ID4gICAgICAgICAg
YmFzZV9zb3VyY2VzID0gW10NCj4gPiAgICAgICAgICBiYXNlX2NmbGFncyA9IFtdDQo+ID4gQEAg
LTI3Myw2ICsyNzQsMTMgQEAgZm9yZWFjaCBzdWJwYXRoOnN1YmRpcnMNCj4gPiAgICAgICAgICBl
bmRpZg0KPiA+ICAgICAgICAgIGRwZGtfY29uZi5zZXQobGliX25hbWUudG9fdXBwZXIoKSwgMSkN
Cj4gPg0KPiA+ICsgICAgICAgIGlmIGRldmVsb3Blcl9tb2RlIGFuZCBpc193aW5kb3dzIGFuZCB1
c2VfZnVuY3Rpb25fdmVyc2lvbmluZw0KPiA+ICsgICAgICAgICAgICBtZXNzYWdlKCdAMEA6IEZ1
bmN0aW9uIHZlcnNpb25pbmcgaXMgbm90IHN1cHBvcnRlZCBieQ0KPiBXaW5kb3dzLicuZm9ybWF0
KG5hbWUpKQ0KPiA+ICsgICAgICAgIGVuZGlmDQo+ID4gKyAgICAgICAgaWYgdXNlX2Z1bmN0aW9u
X3ZlcnNpb25pbmcNCj4gPiArICAgICAgICAgICAgY2ZsYWdzICs9ICctRFJURV9VU0VfRlVOQ1RJ
T05fVkVSU0lPTklORycNCj4gPiArICAgICAgICBlbmRpZg0KPiA+ICsNCj4gPiAgICAgICAgICBk
cGRrX2V4dHJhX2xkZmxhZ3MgKz0gcGtnY29uZmlnX2V4dHJhX2xpYnMNCj4gPg0KPiA+ICAgICAg
ICAgIGRwZGtfaGVhZGVycyArPSBoZWFkZXJzDQo+ID4gQEAgLTM2Myw3ICszNzEsMTggQEAgZm9y
ZWFjaCBzdWJwYXRoOnN1YmRpcnMNCj4gPiAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRzOiBb
dmVyc2lvbl9tYXBdKQ0KPiA+ICAgICAgICAgIGVuZGlmDQo+ID4NCj4gPiAtICAgICAgICBzaGFy
ZWRfbGliID0gc2hhcmVkX2xpYnJhcnkobGliX25hbWUsIHNvdXJjZXNfcG1kX2luZm8sDQo+ID4g
KyAgICAgICAgaWYgbm90IHVzZV9mdW5jdGlvbl92ZXJzaW9uaW5nIG9yIGlzX3dpbmRvd3MNCj4g
PiArICAgICAgICAgICAgIyBVc2UgcHJlLWJ1aWx0IG9iamVjdHMgYW5kIHBtZGluZm8gc291cmNl
cyB0byBidWlsZCBzaGFyZWQgbGlicmFyeS4NCj4gPiArICAgICAgICAgICAgc2hhcmVkX3NvdXJj
ZXMgPSBzb3VyY2VzX3BtZF9pbmZvDQo+ID4gKyAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAg
ICAjIEZvciBjb21wYXQgd2UgbmVlZCB0byByZWJ1aWxkIHdpdGggUlRFX0JVSUxEX1NIQVJFRF9M
SUINCj4gZGVmaW5lZC4NCj4gPiArICAgICAgICAgICAgIyBVc2Ugb3JpZ2luYWwgc291cmNlcyBh
bmQgcG1kaW5mbyBzb3VyY2VzLg0KPiA+ICsgICAgICAgICAgICBjZmxhZ3MgKz0gJy1EUlRFX0JV
SUxEX1NIQVJFRF9MSUInDQo+ID4gKyAgICAgICAgICAgIHNoYXJlZF9zb3VyY2VzID0gc291cmNl
cyArIHNvdXJjZXNfcG1kX2luZm8NCj4gPiArICAgICAgICAgICAgb2JqcyA9IFtdDQo+ID4gKyAg
ICAgICAgZW5kaWYNCj4gPiArDQo+ID4gKyAgICAgICAgc2hhcmVkX2xpYiA9IHNoYXJlZF9saWJy
YXJ5KGxpYl9uYW1lLCBzaGFyZWRfc291cmNlcywNCj4gPiAgICAgICAgICAgICAgICAgIG9iamVj
dHM6IG9ianMsDQo+ID4gICAgICAgICAgICAgICAgICBpbmNsdWRlX2RpcmVjdG9yaWVzOiBpbmNs
dWRlcywNCj4gPiAgICAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczogc2hhcmVkX2RlcHMsDQo+
IA0KPiBPbGRlciBtZXNvbiB2ZXJzaW9uIGRvbid0IGxpa2UgdGhpcyBmb3JtOg0KPiANCj4gZHJp
dmVycy9tZXNvbi5idWlsZDozODE6MTI6IEVSUk9SOiBJbnZhbGlkIHVzZSBvZiBhZGRpdGlvbjog
Y2FuIG9ubHkNCj4gY29uY2F0ZW5hdGUgbGlzdCAobm90ICJDdXN0b21UYXJnZXRIb2xkZXIiKSB0
byBsaXN0DQo+IA0KPiBJdCBzZWVtcyB0byB3b3JrIHdpdGggc29tZXRoaW5nIGxpa2U6DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZXNvbi5idWlsZCBiL2RyaXZlcnMvbWVzb24uYnVpbGQg
aW5kZXgNCj4gOGYzYWI0OTBlZS4uNzljMjE1YTdjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
ZXNvbi5idWlsZA0KPiArKysgYi9kcml2ZXJzL21lc29uLmJ1aWxkDQo+IEBAIC0zNzMsMTIgKzM3
MywxMiBAQCBmb3JlYWNoIHN1YnBhdGg6c3ViZGlycw0KPiANCj4gICAgICAgICAgaWYgbm90IHVz
ZV9mdW5jdGlvbl92ZXJzaW9uaW5nIG9yIGlzX3dpbmRvd3MNCj4gICAgICAgICAgICAgICMgVXNl
IHByZS1idWlsdCBvYmplY3RzIGFuZCBwbWRpbmZvIHNvdXJjZXMgdG8gYnVpbGQgc2hhcmVkIGxp
YnJhcnkuDQo+IC0gICAgICAgICAgICBzaGFyZWRfc291cmNlcyA9IHNvdXJjZXNfcG1kX2luZm8N
Cj4gKyAgICAgICAgICAgIHNoYXJlZF9zb3VyY2VzID0gW3NvdXJjZXNfcG1kX2luZm9dDQo+ICAg
ICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICMgRm9yIGNvbXBhdCB3ZSBuZWVkIHRvIHJlYnVp
bGQgd2l0aCBSVEVfQlVJTERfU0hBUkVEX0xJQiBkZWZpbmVkLg0KPiAgICAgICAgICAgICAgIyBV
c2Ugb3JpZ2luYWwgc291cmNlcyBhbmQgcG1kaW5mbyBzb3VyY2VzLg0KPiAgICAgICAgICAgICAg
Y2ZsYWdzICs9ICctRFJURV9CVUlMRF9TSEFSRURfTElCJw0KPiAtICAgICAgICAgICAgc2hhcmVk
X3NvdXJjZXMgPSBzb3VyY2VzICsgc291cmNlc19wbWRfaW5mbw0KPiArICAgICAgICAgICAgc2hh
cmVkX3NvdXJjZXMgPSBzb3VyY2VzICsgW3NvdXJjZXNfcG1kX2luZm9dDQo+ICAgICAgICAgICAg
ICBvYmpzID0gW10NCj4gICAgICAgICAgZW5kaWYNCg0KVGhhbmsgeW91IGZvciByZXZpZXcuDQpG
aXhlZCBpbiB2NC4NCg==
