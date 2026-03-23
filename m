Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09208F4613F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAF11402D6;
	Tue, 24 Mar 2026 00:24:24 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11022102.outbound.protection.outlook.com
 [40.93.195.102])
 by mails.dpdk.org (Postfix) with ESMTP id 25D854027C;
 Tue, 24 Mar 2026 00:24:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZg/5A96MWSOazjUitBi/gn2iW5xj0l6cEkeuzo/0oYS3IlmkEkhLprPw2Cf3ufEKqz8HvPZALGfK2FZV5XFxGoLTriX7/DW/vdjNId//Gavw9JuDjPtkE4QFY6hSllCFhmI2p8aucNR9VcHmqVoF6igrmtqHJJqHbAtRAs/ZAZ87iYSOpuTQm+6nZeIM+F4Npm8nYN/T9Gy+B7wpOGcpld4jKyv0k/onPzzokEtAsZd7tTh1gVibDFMglYpC2JpnuaTrRl+yHpD5dwowApqDuLil19oKjEFxfJ0VdmTy9k52s6fOO0ItzBt+WPQd8Dzoh5yHOZWtS1IX76GHmmx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tOkpcWooHQ/ftfRrAjxzhSTZIjqBnzI6nA+k4cm6DQ=;
 b=iD+xULJYm57GkitHJYv2enZXRNymz+OLust4IAMHgmNz4Epa6hkih+GIMKE0ltJMY1oGocGuZgWmybTdKKvQlwLvbiMSZuEzEPmw/tIwQZ/g4yRl1UjePsZ4mCgxjDMb6dydqz7LmeBIGhxMjBdCRscOaFQ8F57/EPUMJIe/ddXaBnt8z/k9pi4qNUOeY3dmPQZdBk/6HYolKs7I49RtgD5FQ4eXcV1XtyLxAx7Y+/q/HN7WjPRy5TuV/zUYt8ky8bU5WN14FCmBPBNKYZsff5RHZCbI+mB+QmA5HUzsy0IJOZgZLyyLpsPi7BNPUI8PtI2ncKDFx6WwG/4w1DHdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tOkpcWooHQ/ftfRrAjxzhSTZIjqBnzI6nA+k4cm6DQ=;
 b=OnFhKdmi4K07SHZsm/RDG5XgO/4+LsSFZYFYh/7/HbemqYHcdcgCsNZHc7oyqpLM6gwMKksOlBcRqGSvkbov52Mw7BvIbrH1z5B55Hih7CbRQfTcj9RWHPpMhFSDukc5d1sk/r57f7AdJiBgdjKfFl0ZVPyPEsUpaf+L7tBWFjo=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6538.namprd21.prod.outlook.com (2603:10b6:806:4a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 23:24:20 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9769.004; Mon, 23 Mar 2026
 23:24:20 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/netvsc: switch data path to synthetic
 on device stop
Thread-Topic: [EXTERNAL] Re: [PATCH] net/netvsc: switch data path to synthetic
 on device stop
Thread-Index: AQHcuMvHx1JPkcZUikGxa5yKNke4lbW5QzEAgAOCzoA=
Date: Mon, 23 Mar 2026 23:24:20 +0000
Message-ID: <SA1PR21MB6683943FC6714FE7408BBA94CE4BA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260321004337.1608222-1-longli@microsoft.com>
 <20260321104440.7e853b61@phoenix.local>
In-Reply-To: <20260321104440.7e853b61@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=620ff64c-8020-4386-8589-bcd0269fe6d9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-23T23:21:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6538:EE_
x-ms-office365-filtering-correlation-id: 80850800-62d3-40a3-3683-08de89334f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: xvA7eAFGxcZC5WaumKZskTdU4XsMMDNsp1ApSaGG/J03+hcu3Y/CqPlys68ON0+9AGuovDEWoj/o1iCRVYY+j+uTep3vWn8B8vQkXEPX761aSxqHTbuOawbJG58kJSZ2Gd4a7QQn0kJB4hkRfZ6HMDM8N4Afudy5StTnHKtrb3955spAYAQVvDjgO+gi5CeDCAjFm9vFMt11xYJ08RfFUyi0/aPu3wmry0tXCwBVbInRy0WGL9TGzngaI0GCGMvaablDgYtvTO+GSX5D/qyeTq7pp3D2E40zykOgIc1WFz18oYXHekl9IupFbQEUMWo+SBMaphhD9wI8qoJYQ1e54IdCTi587FqYQM8ET6qfALs4cEg1jv9hbDFqhjID//JjLpkx86rLnKHh6bQYEvyjNh7XUYrOynPNNfFhCY4h9WtKaxcaG9Qy/vilcp+4QuEpoNtjnUw/vXwo3Lrg8ybnTSH+paEGnVi/EzfbPE03eOdEnQclX2lORBg/j997dT9MvZ56s18chKft8FeuQvJdq5sp6av/lCJ/LRu1rINvGDULW1TUVfas9uN/BMF5sbuGRVgeW/21fwvAkJoDdXDXr8dhMzZwoGamnc/WTlrfzGESidPIGaxMJUxX2u0bqApRNCmLsY9dknqAhMxI8+8PxkSqfO02InqYvxSX79kQ1dhDGoVUZOvHFY2TZQrRBe5GmYlXILdegCEpyltg0fE1XiMRuX7zVNDaVoRBHkbhuJaENQgWyLBYUNi1lxi2aDm5HoePL5Oe48Zp/UqjTCTQspE9wCx7QQGe7lL5bSw37A0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWFNOUFhS1hCQW5YU1k0SzlNaXIraDd0dmNIRnNmcFQ1a2lWZUJvZXFDQWpt?=
 =?utf-8?B?M253TnFHZzQxbEZLTnR3dDJwY1lvUFBlYXVvazFFc242Wkp4TnZLTzRMOXdI?=
 =?utf-8?B?SjFTNjFyMGs4Ull0NU5aRHZ2Q1RZNHZtSjNza3FJeGdKTFpXU1dvUFpldlIz?=
 =?utf-8?B?YW9zM1ovbkxRbmJoQzA0V2V6OTZFYWRMZkYxZUEvSjRTZ28xWnc4OEw5M1c3?=
 =?utf-8?B?Q29Tc0R1d0FUWTg0UE85ZlpGa3NvaWREL0ZJRkFzcVd2c3R1b1c0UUwvK09E?=
 =?utf-8?B?VTdRVEFIVzJCVUI5bWlTNmVJNC9NSkhoUTZhcFVtc0dOb0JHaGRicGRQRDNR?=
 =?utf-8?B?M2RjemJJWVQrem1zdk1icmFZUlNUM3BSYXhvSTVvRzB0QW0vbllaWWdjUmtS?=
 =?utf-8?B?UG4xVHFnR2VIajVXdVZKcWI1UUZzdUJjWFZPWXVjRkk0UDFmS2ViOVg3dzdI?=
 =?utf-8?B?aG15S1hxbmdpUmE1cnlqZHF6QU02QzhhSnNoZDgvcXNFM29aQkNsdVg5TjNk?=
 =?utf-8?B?OExGZUpsSE5HNUxSSmZ1UEhQN1hKUis0TUwrOWNuc0YvUnlOOGhPSzFYSFpi?=
 =?utf-8?B?NHc5bzVlcVBwR3kvRkZBNU91clI4VTNWdFhnT1QyYzg5WUxsWHhSdzVLQ1M1?=
 =?utf-8?B?dFlPK2lHbUpKc2hzSC9LS1ppMEQrSDF4b09RWFpPOTEvZlcvR29JY0lYdy9h?=
 =?utf-8?B?eCtDVndSRWxJQm1ZREVqdjJPR1Z3UW4yejc4SFgwSXBZbzNGNWpFREpaeVli?=
 =?utf-8?B?eWZZaXRwM3dLeUl3WnV4U3BJZmM3c3FDUGoyWEVQZERYSXM3a3FVQ014N3dh?=
 =?utf-8?B?bXE1dFVQWEp5MlJwQ3BsVmlsTjlPZ2lDQjhvZXpTdXFaWmFkdXRyME1ONWZN?=
 =?utf-8?B?SGp4WlZXcHhiMDRZR1NUTEI3akFOWktvaDU0VVMrTnF2MkJpaXJsK0RiRmZL?=
 =?utf-8?B?UHl0bTZIYVR4QUxPMno4czQxN1kzUUd0NDdDYmxxcXUvT25jWkFlUHZlZlhS?=
 =?utf-8?B?UXNMdWFjR0M2dHRDUTV3RnZOSGtIVHFJaG1UWHlUMS96Q1MwWkZjaHVPVGZj?=
 =?utf-8?B?ZlBybmNDWm5ZQUFQV0Y2QitjZm5kTEtibUtMZEZpdHlwRkFWMnZWd1JEMFRC?=
 =?utf-8?B?L1lzVkRwWXBVeHNhT2JGTmZFUmdIL3JWelBBYVJzMm5DcWVpaUVLK1NLSWFU?=
 =?utf-8?B?RHdHUzhpV2NocDZkbWNsNm5vMDVsYldKU1hmNzNHWmZlUkplRXZEMnVsbTNM?=
 =?utf-8?B?Q1VLeVlNd1IyZGVXTXpOYTg3U1dCT1lPQ3d1Q3lXVEVBUlBuZlQ0VzQvRVlB?=
 =?utf-8?B?d0NjbUFmVVdrQkQ3T244anE3eDRqUWtkVTdTZDM3RmJkUnlacjZBS0pnUmNT?=
 =?utf-8?B?OW5YSjg2Y3hJekl4NWFEZEhjVFp6Qnh1blNHbTlwZkZSTUExYU5iZUZYT0JF?=
 =?utf-8?B?U245dUZQOWExWk5CSHlvVGN5YUZETDZuTG5XZVVQWkJjVmZJYmFicERHdDJR?=
 =?utf-8?B?NERUeUNwOFRmV2ZJTDc4L1R5UFR6dmkwWW1HMThQUko4SEFBa3prZjdIbVlv?=
 =?utf-8?B?ZXArL2RVZnFyU0VGK3VzcVFTM28yT0IyaEI5NVVpb1N1VGtocFJuTExCRGFQ?=
 =?utf-8?B?eFR4ZTF2bVBBQTBNeWQyVG05bVBBb2t5NTZDR3JtMFhYTUpqcnN4QWRzc3Zh?=
 =?utf-8?B?QnNUU094QXVYSjBDK2tuMWJoU043eU9BVXdMa3MyRzBnbWoxRTZEcHA1SEx0?=
 =?utf-8?B?VVplRE9CMU5TNnBXd3drS2poSi8xTTBINVN4bW04NHBxbjI3NHpDWHpOYUxT?=
 =?utf-8?B?amtUdUlDOTcxU0k5RFZuWWZSMFpubjdUZXVxRjB0eDA5cVpaUlAxMndFVS9p?=
 =?utf-8?B?elQvaTRIYmpETUlEVms2UnNpWmc2cUFjSllmRXBFemxpNnNnNzZxTStDcHhV?=
 =?utf-8?B?Z05KSmsvMmxoaGlLNnpJUTZHQ3F1MkxxaFBoNlNQRHNXVnlpdHFJeVlFVUw0?=
 =?utf-8?B?YXQvMDJ3NVpObW54RGI3NDE4akJtbWU1MmZXdE16RU02NGpIYmpSSVpMSSt0?=
 =?utf-8?B?Nk4wZDZyenRxV2hkN2hZY1JLcnBxYjU0RW1IVHFVZ2JlRGd0Q05TMEJ3KzJ6?=
 =?utf-8?B?NGdFUDdrSnZzOWVJRldSN016QWJnLzRmb1JlYTMxa1l1SEJWVXJtMWQ4TVdU?=
 =?utf-8?B?SnJJY1pPRlVOSGlTMldFK1BhcXNkZWVDQ21GV2xNN2E0dFhsOTlaQmM1Mmwv?=
 =?utf-8?B?RDkyLzc2KzRqRVN6SEpIN09oOWJqWHZLS2NZdmJMWnk3THlDMHRvekZ4RmN3?=
 =?utf-8?Q?Dlo4q/MDp05bSchlXz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80850800-62d3-40a3-3683-08de89334f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 23:24:20.4519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAXccJ7GRL/vZvVGTEnNjHa01lHj0Gw+mZTylpuH/Heyz6MFCcUBX3RQspLGL4J0IEeRZba4jEUuCwOvO647yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6538
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

PiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+IFdoZW4gRFBE
SyBzdG9wcyBhIG5ldHZzYyBkZXZpY2UgKGUuZy4gb24gdGVzdHBtZCBxdWl0KSwgdGhlIGRhdGEg
cGF0aA0KPiA+IHdhcyBsZWZ0IHBvaW50aW5nIHRvIHRoZSBWRi9NQU5BIGRldmljZS4gSWYgdGhl
IGtlcm5lbCBuZXR2c2MgZHJpdmVyDQo+ID4gc3Vic2VxdWVudGx5IHJlbG9hZHMgdGhlIE1BTkEg
ZGV2aWNlIGFuZCBvcGVucyBpdCwgaW5jb21pbmcgdHJhZmZpYw0KPiA+IGFycml2ZXMgb24gdGhl
IE1BTkEgZGV2aWNlIGltbWVkaWF0ZWx5LCBiZWZvcmUgdGhlIHF1ZXVlcyBhcmUgZnVsbHkNCj4g
PiBpbml0aWFsaXplZC4gVGhpcyBjYXVzZXMgYm9ndXMgUlggY29tcGxldGlvbiBldmVudHMgdG8g
YXBwZWFyIG9uIHRoZQ0KPiA+IFRYIGNvbXBsZXRpb24gcXVldWUsIHRyaWdnZXJpbmcgYSBrZXJu
ZWwgV0FSTklORyBpbiBtYW5hX3BvbGxfdHhfY3EoKS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IHN3
aXRjaGluZyB0aGUgZGF0YSBwYXRoIGJhY2sgdG8gc3ludGhldGljICh2aWENCj4gPiBOVlNfREFU
QVBBVEhfU1lOVEhFVElDKSBpbiBobl92Zl9zdG9wKCkgYmVmb3JlIHN0b3BwaW5nIHRoZSBWRiBk
ZXZpY2UuDQo+ID4gVGhpcyB0ZWxscyB0aGUgaG9zdCB0byByb3V0ZSB0cmFmZmljIHRocm91Z2gg
dGhlIHN5bnRoZXRpYyBwYXRoLCBzbw0KPiA+IHRoYXQgd2hlbiB0aGUgTUFOQSBkcml2ZXIgcmVj
cmVhdGVzIGl0cyBxdWV1ZXMsIG5vIHVuZXhwZWN0ZWQgdHJhZmZpYw0KPiA+IGFycml2ZXMgdW50
aWwgbmV0dnNjIGV4cGxpY2l0bHkgc3dpdGNoZXMgYmFjayB0byBWRi4NCj4gPg0KPiA+IEFsc28g
dXBkYXRlIGhuX3ZmX3N0YXJ0KCkgdG8gc3dpdGNoIHRoZSBkYXRhIHBhdGggYmFjayB0byBWRiBh
ZnRlciB0aGUNCj4gPiBWRiBkZXZpY2UgaXMgc3RhcnRlZCwgZW5hYmxpbmcgY29ycmVjdCBzdG9w
L3N0YXJ0IGN5Y2xpbmcuDQo+ID4NCj4gPiBCb3RoIGZ1bmN0aW9ucyBub3cgdXNlIHdyaXRlIGxv
Y2tzIGluc3RlYWQgb2YgcmVhZCBsb2NrcyBzaW5jZSB0aGV5DQo+ID4gbW9kaWZ5IHZmX3ZzY19z
d2l0Y2hlZCBzdGF0ZS4NCj4gPg0KPiA+IEZpeGVzOiBkYzc2ODBlODU5N2MgKCJuZXQvbmV0dnNj
OiBzdXBwb3J0IGludGVncmF0ZWQgVkYiKQ0KPiA+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiANCj4g
TG9va3MgZ29vZCB0byBtZSB5b3UgbWlnaHQgd2FudCB0byBhZGRyZXNzIHRoZSBlcnJvciBjb25k
aXRpb24gc3BvdHRlZCBieSBBSQ0KPiByZXZpZXcuDQo+IA0KPiAtLS0NCj4gDQo+ICoqUGF0Y2g6
IG5ldC9uZXR2c2M6IHN3aXRjaCBkYXRhIHBhdGggdG8gc3ludGhldGljIG9uIGRldmljZSBzdG9w
KioNCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcmVzc2VzIGEgcmVhbCByYWNlIGNvbmRpdGlvbiB3aGVy
ZSBzdG9wcGluZyBhIG5ldHZzYyBkZXZpY2UgbGVhdmVzDQo+IHRoZSBkYXRhIHBhdGggcG9pbnRp
bmcgdG8gdGhlIFZGL01BTkEgZGV2aWNlLCBjYXVzaW5nIGtlcm5lbCB3YXJuaW5ncyB3aGVuIHRo
ZQ0KPiBNQU5BIGRyaXZlciBsYXRlciByZWluaXRpYWxpemVzLiBUaGUgZml4IGlzIGxvZ2ljYWxs
eSBzb3VuZCDigJQgc3dpdGNoIHRvIHN5bnRoZXRpYw0KPiBiZWZvcmUgc3RvcHBpbmcgdGhlIFZG
LCBhbmQgcmUtc3dpdGNoIHRvIFZGIG9uIHN0YXJ0Lg0KPiANCj4gKipFcnJvcjogYGhuX3ZmX3N0
b3AoKWAg4oCUIGB2Zl92c2Nfc3dpdGNoZWRgIGNsZWFyZWQgZXZlbiB3aGVuDQo+IGBobl9udnNf
c2V0X2RhdGFwYXRoKClgIGZhaWxzKioNCj4gDQo+IEluIGBobl92Zl9zdG9wKClgLCBpZiBgaG5f
bnZzX3NldF9kYXRhcGF0aChodiwgTlZTX0RBVEFQQVRIX1NZTlRIRVRJQylgIGZhaWxzLA0KPiBg
dmZfdnNjX3N3aXRjaGVkYCBpcyB1bmNvbmRpdGlvbmFsbHkgc2V0IHRvIGBmYWxzZWAuIFRoaXMg
bWVhbnMgdGhlIGRyaXZlciBiZWxpZXZlcw0KPiBpdCBzd2l0Y2hlZCB0byBzeW50aGV0aWMgd2hl
biB0aGUgaG9zdCBtYXkgc3RpbGwgYmUgcm91dGluZyB0cmFmZmljIHRocm91Z2ggdGhlIFZGLg0K
PiBPbiBhIHN1YnNlcXVlbnQgYGhuX3ZmX3N0YXJ0KClgLCB0aGUgYCFodi0+dmZfY3R4LnZmX3Zz
Y19zd2l0Y2hlZGAgY2hlY2sgd2lsbA0KPiBwYXNzIGFuZCB0aGUgZHJpdmVyIHdpbGwgdHJ5IHRv
IHJlLXN3aXRjaCB0byBWRiDigJQgYnV0IHNpbmNlIHRoZSBob3N0IG5ldmVyIGxlZnQgVkYNCj4g
bW9kZSwgdGhpcyBpcyBhIG5vLW9wIGF0IGJlc3Qgb3IgY29uZnVzaW5nIGF0IHdvcnN0LiBNb3Jl
IGltcG9ydGFudGx5LCBpZiBzdG9wIGlzDQo+IGJlaW5nIGNhbGxlZCBvbiB0aGUgcGF0aCB0byB0
ZWFyZG93biwgdGhlIGZsYWcgaXMgbm93IHdyb25nLg0KPiANCj4gSSBub3RlIHRoYXQgYGhuX3Zm
X3JlbW92ZV91bmxvY2tlZCgpYCBoYXMgdGhlIHNhbWUgcGF0dGVybiAoY2xlYXJzIHRoZSBmbGFn
DQo+IHJlZ2FyZGxlc3MsIHdpdGggdGhlIGNvbW1lbnQgIkNsZWFyIHN3aXRjaGVkIGZsYWcgcmVn
YXJkbGVzcyDigJQgVkYgaXMgYmVpbmcNCj4gcmVtb3ZlZCIpLCBzbyB0aGlzIG1heSBiZSBpbnRl
bnRpb25hbCBmb3IgbmV0dnNjIHNpbmNlIG9uIHRoZSByZW1vdmUgcGF0aCB5b3UNCj4gd2FudCB0
byBmb3JnZXQgdGhlIHN0YXRlLiBCdXQgb24gdGhlIHN0b3AgcGF0aCB0aGUgZGV2aWNlIGlzIHN0
aWxsIHByZXNlbnQgYW5kIHdpbGwNCj4gYmUgcmVzdGFydGVkIOKAlCBwcm9wYWdhdGluZyB0aGUg
ZXJyb3IgYW5kIGxlYXZpbmcgYHZmX3ZzY19zd2l0Y2hlZCA9IHRydWVgIG1pZ2h0DQo+IGJlIG1v
cmUgY29ycmVjdCBzbyB0aGF0IGBobl92Zl9zdGFydCgpYCByZXRyaWVzIHRoZSBzd2l0Y2guIFdv
cnRoIGNvbmZpcm1pbmcgdGhpcyBpcw0KPiBpbnRlbnRpb25hbC4NCj4gDQo+ICoqV2FybmluZzog
YGhuX3ZmX3N0YXJ0KClgIOKAlCBlcnJvciBmcm9tIGBobl9udnNfc2V0X2RhdGFwYXRoKClgIHJl
dHVybmVkIGJ1dCBWRg0KPiBkZXZpY2UgbGVmdCBzdGFydGVkKioNCj4gDQo+IEluIGBobl92Zl9z
dGFydCgpYCwgaWYgYHJ0ZV9ldGhfZGV2X3N0YXJ0KClgIHN1Y2NlZWRzIGJ1dCB0aGUgc3Vic2Vx
dWVudA0KPiBgaG5fbnZzX3NldF9kYXRhcGF0aChodiwgTlZTX0RBVEFQQVRIX1ZGKWAgZmFpbHMs
IHRoZSBmdW5jdGlvbiBsb2dzIHRoZSBlcnJvcg0KPiBhbmQgcmV0dXJucyB0aGUgZmFpbHVyZSBj
b2RlLiBIb3dldmVyLCB0aGUgVkYgZGV2aWNlIGlzIGxlZnQgaW4gdGhlIHN0YXJ0ZWQgc3RhdGUu
DQo+IFRoZSBjYWxsZXIgc2VlcyBhIGZhaWx1cmUgZnJvbSBgaG5fdmZfc3RhcnQoKWAsIGJ1dCB0
aGUgVkYgaXMgcnVubmluZyB3aXRoIG5vIHRyYWZmaWMNCj4gcm91dGVkIHRvIGl0LiBUaGlzIGlz
IGEgcmVzb3VyY2UgY29uc2lzdGVuY3kgaXNzdWUg4oCUIGlmIHRoZSBkYXRhcGF0aCBzd2l0Y2gg
ZmFpbHMsDQo+IHNob3VsZCB0aGUgVkYgYmUgc3RvcHBlZCBhZ2FpbiB0byBtYWludGFpbiBjb25z
aXN0ZW50IHN0YXRlPw0KDQpJJ20gc2VuZGluZyB2MiB0byBmaXggdGhpcy4NCg0KPiANCj4gKipX
YXJuaW5nOiBgaG5fdmZfYWRkX3VubG9ja2VkKClgIOKAlCBjaGFuZ2UgZGVmZXJzIGRhdGFwYXRo
IHN3aXRjaCBidXQgc3RpbGwNCj4gcmV0dXJucyAwIG9uIHRoZSBkZWZlcnJlZCBwYXRoKioNCj4g
DQo+IFRoZSBwYXRjaCBtb2RpZmllcyBgaG5fdmZfYWRkX3VubG9ja2VkKClgIHRvIHNraXAgdGhl
IGRhdGFwYXRoIHN3aXRjaCB3aGVuDQo+IGAhZGV2LT5kYXRhLT5kZXZfc3RhcnRlZGAuIFRoaXMg
aXMgY29ycmVjdCwgYnV0IG5vdGUgdGhhdCBpbiB0aGUgb3JpZ2luYWwgY29kZSB0aGUNCj4gZnVu
Y3Rpb24gd291bGQgcmV0dXJuIHRoZSByZXN1bHQgb2YgYGhuX252c19zZXRfZGF0YXBhdGgoKWAg
4oCUIGlmIHRoYXQgZmFpbGVkLCBpdA0KPiByZXR1cm5lZCBhbiBlcnJvci4gTm93IG9uIHRoZSBk
ZWZlcnJlZCBwYXRoLCBgcmV0YCByZXRhaW5zIHdoYXRldmVyIHZhbHVlIGl0IGhhZA0KPiBmcm9t
IHRoZSBhdHRhY2gvY29uZmlndXJlIHBhdGggKGNvdWxkIGJlIDAgZnJvbSBhIHN1Y2Nlc3NmdWwg
YXR0YWNoKSwgc28gdGhlIGNhbGxlcg0KPiBnZXRzIHN1Y2Nlc3MgZXZlbiB0aG91Z2ggdGhlIGRh
dGFwYXRoIHN3aXRjaCB3YXMgbm90IGF0dGVtcHRlZC4gVGhpcyBpcyBmaW5lIGZvcg0KPiB0aGUg
aG90LWFkZC1iZWZvcmUtc3RhcnQgY2FzZSwganVzdCBub3RpbmcgdGhlIGJlaGF2aW9yIGNoYW5n
ZS4NCj4gDQoNClRoaXMgd2FybmluZyBjYW4gYmUgaWdub3JlZC4NCg0KVGhhbmtzLA0KTG9uZw0K
DQo+ICoqSW5mbzogTG9jayB1cGdyYWRlIGZyb20gcmVhZCB0byB3cml0ZSBpcyBjb3JyZWN0KioN
Cj4gDQo+IEJvdGggYGhuX3ZmX3N0YXJ0KClgIGFuZCBgaG5fdmZfc3RvcCgpYCBjb3JyZWN0bHkg
c3dpdGNoIGZyb20NCj4gYHJ0ZV9yd2xvY2tfcmVhZF9sb2NrYCB0byBgcnRlX3J3bG9ja193cml0
ZV9sb2NrYCBzaW5jZSB0aGV5IG5vdyBtb2RpZnkNCj4gYHZmX3ZzY19zd2l0Y2hlZGAuIFRoaXMg
bWF0Y2hlcyB0aGUgbG9ja2luZyBwYXR0ZXJuIHVzZWQgYnkgYGhuX3ZmX2Nsb3NlKClgIGFuZA0K
PiBgaG5fbnZzX2hhbmRsZV92ZmFzc29jKClgLg0K
