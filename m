Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4E1048925
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 01:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01FFA4013F;
	Sat, 28 Feb 2026 02:36:46 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020141.outbound.protection.outlook.com
 [52.101.193.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6086D4013F;
 Sat, 28 Feb 2026 02:36:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtTFmXZ2bWsIlHAmNjIyT/9eCTW6IrROuCDcnPE007ZuvMxPA8b5iFokR52CXnT9q+rYVpotxkx/3OMjOrd2rv4RcLjwjGbjvwiJzZzjPV7rw05MYe5OyON+o7DBtRc2PyyOga2kcifAo0/wnkbBN/Y8one+i+laThAqoeOozpiCNbCWUyBs5cn1QRYiB4G2wb3PV+sJ61UMH7pAGk6lk6QWOtPadpbXl3+Q4jrVdopxRodlo0tdRlsu1noU5VXPI22V3ApNiwr79UgcYsY9YxIj4qLrkEhXTr1HuQDhF4zT0A0WrzwNdlz/3a8PGpocHYAck9icCgTevotJmcrD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2J4BvXt7gduZvf0ieiy29zwKJxyc7mdEUTd/vt6U68=;
 b=RUKcaXuNf927isUoRv8D/EvKi8Jh6TK6xDAYhLKCOBcx6ovn0dZP5dtP/FgRRZ4XzHyfrJRqAwz+QwBotU5sQQfkTtAO59h8cprjs4c+fE4rQcGxooBkUBip78pfgJqsIW++K8cHo6F0RNWhTpIK26TEnW8UZEqZHdxszt0qt1eX8GlKZD0Sp4V++sDCdMgQU65y8VJG16KITzc2VNJJchbdreehaZvbQap1qa1ZGFPU6qdfBBS1d4hwxD8GYgsKI6GzY8L13mswVbqZI2uWB6t+w0tLjNXzulHZ9YhXSOH6ub6/fKaNPrTDJfdvWtpUne6IZueCeQzNAos91RBmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2J4BvXt7gduZvf0ieiy29zwKJxyc7mdEUTd/vt6U68=;
 b=i2YfYEj4PVvgU3QEx2CCoNpH6Bukm4ZKiEeJbMcsZ/DxUggxUdLGsu31r7tnBaeDnuM0euqyFi1nn7znEmqsoqUkfQk6gmyk1LSRbS06HLwpG60Cx3tMzTlp3e/1d5a551HdIVIehIrvkIMWko/k0CmNHVvDI/e8RD0+RnI3qbg=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS0PR21MB6338.namprd21.prod.outlook.com (2603:10b6:8:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.7; Sat, 28 Feb
 2026 01:36:41 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9678.009; Sat, 28 Feb 2026
 01:36:38 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Thread-Topic: [EXTERNAL] Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Thread-Index: AQHcp4y7Yj452+HcVk2GmU8JkxJh2rWXRvEAgAAN7vA=
Date: Sat, 28 Feb 2026 01:36:38 +0000
Message-ID: <DS3PR21MB573583B8E8701988E3967ABCCE70A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260227015928.14338-1-longli@microsoft.com>
 <20260227164148.470898ef@phoenix.local>
In-Reply-To: <20260227164148.470898ef@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1fe4c8f-bbe8-406c-9f9c-0128c49be5a5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-28T01:31:39Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS0PR21MB6338:EE_
x-ms-office365-filtering-correlation-id: 5377ea2b-5c85-4ded-cf10-08de7669d0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: rqDPFnCAnFLnBV/mDWj+9xC5lswNpeHArS0TvxSC2lES7IAaOPF+61n5AM+ZfSdmc9wLltN8G2bRMQIe3kYBoUZV+nwwqpWuC4nZV96G/6IWAr6+3GcQUBT2XOIbrfx07ygFQvWBIezOm2Bi84Cr+IIsIdQuA2BOcHWUKQfuR0l6viqeW4c6oLG7dt0Rbxa6gPnp9yeIut1cxzbzjcneAmJtHnMltffSt9PfrVUlf5C0HX7vp5xavNOT1WQw8y6VmYgv5cqMMLyv+090z9fT0GXFz6ovFCU2gcPJIu0fQjCxpag8jH9nd9atkvr1QJfje7XoIpJHxQtsFv6wYcMH0yYgbu7XT5+ZCo+9YBLmYQmus9i34SCrpKBTGaaWGBl8YrL0sRgeCibwOM1ST8yqUtrbmKa7HJF2km7FKKUH5usuJvjH04E1TNJKDyzSlzsC6b+LvcklAHdhdPpHz0YzgFhwZ8A0lrskWnxDUdf48bki7vIf04EOaOAepD0XHJ30dpqblY/LMqpm7YplBLsn2BXHdnEl5rkHOivtCSDnNDUn2rAz4mhp0KqaRGOnEVqGHWO2Z+Yyok+gh/GAb2DjAeA3r/1RyQsjC0S2ftwWaVbq/92P1AWhVNgjXSiWjn9z9fBTxojJiaBVdPfM7J8MHGTgtq67DsY66JELd/FRQc8e/X3AXjnttUGc4P+egwK8Vex4gNnvlLmskjulv9hx1bZZS5/AHVgC3fTfisTQsHwym8QtwgStw3qhx8cg4efkuKZaoJeNECZtuILwqQafhVYc/BFv5DP+wJNImGdelgE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEJSSFU0dWlFdkJrblNqSVdxYzJYOVdwdCthM1R4NlE1L1MyclYzWVYydEM4?=
 =?utf-8?B?UWlpMjdYaWJHalNKbkFBbENld3ZBWXJYQmY2blF0UFExTFZITGRDUklWVE1K?=
 =?utf-8?B?d3RaeEtmbkV4TWg4cjZnUXhDanlMWnM1aVpIeFhyN1cyTHdiWnJEdHRNV3Vs?=
 =?utf-8?B?aFNYME9aYW5TU3IvT3d0UDNsTVZrZ051aDc0MmRnSC8vS0ZGZ0Z3K0FXQTVk?=
 =?utf-8?B?NWZGK3UzWVcveVZMRkM1OTMyVVFDQmhJMHhyWVhvVmJIMXFPWVBCWUtiaTJL?=
 =?utf-8?B?ZjAxb1llOEdXVHdCOUZUT3VjdzJUQ01LYjdZVHJxdWlTVVpaUlB1YWNWUzFN?=
 =?utf-8?B?WkdGZWJubUZEM2tESHI3SEhuQk0xR09yaHhiOVZaRlJUR0tWN0xVVHNBNnZm?=
 =?utf-8?B?RkpZRHNvblRPdGs0Y3JrOTlsK2k4SDRmTjZkTkVOK1l2N2JSZUZNR0QzMUtn?=
 =?utf-8?B?MmNlNEVPYXArY08rWHpqQ3VmeWkzekF2K0kwQXQxeVliUjQ5Rm5DQlRtdlQ2?=
 =?utf-8?B?MFQvTGZiZThLT2JadEt0M2xQTGxwU1oxbzNZL2p5eTdLdDlNLzFZcWdDc3pw?=
 =?utf-8?B?WHRCeDVMU0xhZ0ZSYXd4Mk9KajZaaXR4YXJ4WW96TytYMDBiUFNtWXIzY0ZP?=
 =?utf-8?B?amliQW5ZQmg3TjRYb2lMK1A5VW1DN0wvWFA5V0NEUExmZ0d3bEN0YUFCaE5s?=
 =?utf-8?B?ZENnY3RGeUh4VnJwK3VrQWoxS0pLaWhSU2RaN1pOdE00SjZpYktLRFNlNXJW?=
 =?utf-8?B?YkFnUTM0VnhLSHM0MU9DWlBKcitKUEpWRHA0M2VhMjUwbStETjZBR1picUJH?=
 =?utf-8?B?Q3U2b3o3cmo2eENycmlxOHhuS2VlUG9DMXljbFAwWU5GNFJweGpoZHhyQzBF?=
 =?utf-8?B?dmNnSENuTzFQS2ZrWDI4WlBNM3dTdVVaTm9Eai9RRGtiM3FGdHRNckR1QSsy?=
 =?utf-8?B?cmJjWFUxeGNCczRlWGpUSUVSOGV5NU44UHFBRjZxT2ZRVWsybCtFcWdhdWRE?=
 =?utf-8?B?S2ZHV0RqdmZRdXJnS08ybmlSZCtJamI2N1RjYkkyQXNscWtQU05LNTc3RHZh?=
 =?utf-8?B?a3VuQU5YMllYK3ArTHZyNGtzUWNzYnpMcGNqZlRPTnVvUmN1UHAvcXNYNGtO?=
 =?utf-8?B?T2VITndEMEV4UDdvUDZPSGtnNy9SaTMweDJHdUN5eFczem0wTE16WWlocGRX?=
 =?utf-8?B?YWovT1hObTN4aGNXemcrbkx2Zjk5TUdpYW8yZTIyVHM2R1lDUHlua3M2UXJG?=
 =?utf-8?B?VllUUjdFby9GU3dwOU8vemw3QmsraVZmR1FNeGJ0SUJYQmVpNjgvejFGcGpI?=
 =?utf-8?B?eXBzVnRUSmgxY2lTdUsxZ2hPcWNVVXRmWVNqUy9VaG0xNHBwZng0TGhiUHdw?=
 =?utf-8?B?ZU9CZG1abHBDSVFFVDhqaTRHTWxvR3h5cVJ1S3Zzb1VEZTkzZGpIVklGaElL?=
 =?utf-8?B?MS9NOXdvNWhuNVh3MndGU0lqR0R0OVkrSENLRkxlazJoTk9KcDQvRjhtd0tN?=
 =?utf-8?B?M0xLQithL3lob2Q1eWp4NVFXM2xNTjkzYjVHbWlsK0FGWU8wU3VWOTVtdDJ6?=
 =?utf-8?B?VXJnWDFZWjMzSWRCZnRXOU8rVzF5T3M3U0lwclcwSFdJQ0lLc2VyRlU2dDd1?=
 =?utf-8?B?QW9nUVl1YzR2RjR4dXd5MzQzSlFaSXBJZWk4dkw0bkJKbUlrMnM2aDMwRVpM?=
 =?utf-8?B?TkFGTCtVdWZ5WG9vbGdvOE5wakk1UXpqU3hjbklWZkdFUGJvNnNOWVBSR01E?=
 =?utf-8?B?bTdCNVZCOVhZdjRRYXV0NnBYVnlQUFBZcDdhTVJYZC84SGdPVTVyelp3VTIx?=
 =?utf-8?B?UUh3L3I2YlJpS1RVKzBNYnoySzgveWJ0NU5qNUpuSG4vUXNhQ1l0cE5rM1g0?=
 =?utf-8?B?ektwQjN5aC9HL3FXVytXdFZkY0FjaUQ1cWlEMEZrbTNQUDI0b0FiN2U4UGhQ?=
 =?utf-8?B?V0pBdzVnYkVWTncwSE01SHp3Tk8vbjdiN3Brdjc5bUIxendPaENDRzdwTmZ4?=
 =?utf-8?B?YWZUcWZMVVFuMVVVZHlkNHZKZlNMcXhETlAyekI2UzNvd2t3YU1rSWpVckha?=
 =?utf-8?B?eXlZZ3lNV0Y0UGNGTVVFazJaRVJwWk8rdUtpYUhteEd4RmxnUFRBeEdBT05z?=
 =?utf-8?B?QVlHV01NY05rRkZZZkc4ekc2TjhyYlpSTXdzd21RTFRZb3d5RVRPeEpZTlB3?=
 =?utf-8?B?Yk11R29ncHByVFBCaGJPMERzVzJnaWp0SGtOOHR0bUxSdlVXcHIzVGhBN2Vr?=
 =?utf-8?B?N0hwSDdseWxZVXd2UjFvbE9xajYyWWRwYzUvRis5L3k3N05MOVUwbFMzTnFx?=
 =?utf-8?Q?pFfDbj91iULyIVgF0i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5377ea2b-5c85-4ded-cf10-08de7669d0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 01:36:38.1642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/wiVDPQB8PiF6O101Dg97I7mIMLDM8H9I7GDJRhZIyPicS6/9vO8tWzK0ovnxdMJCBLqY3PYdnUyoCRD+pImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6338
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

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjUgMC83XSBtdWx0aS1wcm9jZXNzIGFu
ZCBWRiBob3RwbHVnIGZpeGVzDQo+IA0KPiBPbiBUaHUsIDI2IEZlYiAyMDI2IDE3OjU5OjIwIC0w
ODAwDQo+IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gDQo+ID4gRml4
IHNldmVyYWwgaXNzdWVzIHdpdGggVkYgaG90cGx1ZyBhbmQgbXVsdGktcHJvY2VzcyBzdXBwb3J0
IGluDQo+ID4gbmV0dnNjLCBtYW5hLCBtbHg1LCBhbmQgbWx4NCBkcml2ZXJzOg0KPiA+DQo+ID4g
LSBGaXggcmFjZSBjb25kaXRpb25zIGJldHdlZW4gVlNQIG5vdGlmaWNhdGlvbnMgYW5kIERQREsg
ZGV2aWNlIGV2ZW50cw0KPiA+ICAgZHVyaW5nIFZGIGFkZC9yZW1vdmUsIHdpdGggcHJvcGVyIGxv
Y2tpbmcgb2YgVkYtcmVsYXRlZCBmaWVsZHMNCj4gPiAtIEFkZCBtdWx0aS1wcm9jZXNzIGNvbW11
bmljYXRpb24gaW5mcmFzdHJ1Y3R1cmUgZm9yIGNvb3JkaW5hdGluZyBWRg0KPiA+ICAgcmVtb3Zh
bCBhY3Jvc3MgcHJpbWFyeSBhbmQgc2Vjb25kYXJ5IHByb2Nlc3Nlcw0KPiA+IC0gRml4IFByb3Rl
Y3Rpb24gRG9tYWluIHJlc291cmNlIGxlYWsgb24gZGV2aWNlIGNsb3NlIGluIG1hbmENCj4gPiAt
IEZpeCBkZXZhcmdzIG1lbW9yeSBsZWFrIGR1cmluZyBWRiBob3RwbHVnIGluIG5ldHZzYw0KPiA+
IC0gRml4IGZhc3QtcGF0aCBvcHMgKHJ0ZV9ldGhfZnBfb3BzKSBzZXR1cCBpbiBzZWNvbmRhcnkg
cHJvY2Vzc2VzIGZvcg0KPiA+ICAgbWFuYSwgbWx4NSwgYW5kIG1seDQsIGVuc3VyaW5nIGJ1cnN0
IGZ1bmN0aW9uIHBvaW50ZXJzIGFyZSByZXN0b3JlZA0KPiA+ICAgYWZ0ZXIgU1RPUC0+U1RBUlQg
Y3ljbGVzDQo+ID4NCj4gPiB2NToNCj4gPiAtIFBhdGNoZXMgNSw2LDc6IEFsc28gcmVzdG9yZSBy
dGVfZXRoX2ZwX29wcyBidXJzdCBmdW5jdGlvbiBwb2ludGVycw0KPiA+ICAgKHJ4X3BrdF9idXJz
dCwgdHhfcGt0X2J1cnN0KSBpbiBTVEFSVF9SWFRYIGhhbmRsZXIsIG5vdCBqdXN0IHF1ZXVlDQo+
ID4gICBkYXRhIHBvaW50ZXJzLiBXaXRob3V0IHRoaXMsIGFmdGVyIGEgU1RPUC0+U1RBUlQgY3lj
bGUgdGhlIHNlY29uZGFyeQ0KPiA+ICAgcHJvY2VzcyBidXJzdCBwb2ludGVycyByZW1haW4gc2V0
IHRvIGR1bW15IGZ1bmN0aW9ucy4NCj4gPg0KPiA+IHY0Og0KPiA+IC0gUGF0Y2ggMTogQ2hlY2sg
aG5fdmZfYWRkKCkgcmV0dXJuIHZhbHVlIGluIG5ldHZzY19ob3RwbHVnX3JldHJ5DQo+ID4gLSBQ
YXRjaCAxOiBUcmFjayBmcmVzaF9hdHRhY2ggdG8gYXZvaWQgdGVhcmluZyBkb3duIG9yaWdpbmFs
IFZGDQo+ID4gICBhdHRhY2htZW50IHdoZW4gY29uZmlndXJlL3N0YXJ0IGZhaWxzIG9uIGFuIC1F
RVhJU1QgcGF0aA0KPiA+IC0gUGF0Y2ggMjogTW92ZSBjb3VudGVyIGRlY3JlbWVudCBhbmQgbmV0
dnNjX3VuaW5pdF9vbmNlKCkgYWZ0ZXIgZGV2aWNlDQo+ID4gICBjbGVhbnVwIGluIGV0aF9obl9y
ZW1vdmUoKSB0byBwcmV2ZW50IHVzZS1hZnRlci1mcmVlIG9mIHNoYXJlZCBkYXRhDQo+ID4gLSBQ
YXRjaCAyOiBDbGVhciBuZXR2c2Nfc2hhcmVkX2RhdGEgb24gaW5pdCBmYWlsdXJlIHBhdGhzIHRv
IHByZXZlbnQNCj4gPiAgIGRhbmdsaW5nIHBvaW50ZXINCj4gPg0KPiA+IHYzOg0KPiA+IC0gRml4
IHJldmlldyBjb21tZW50cyBmcm9tIHYyDQo+ID4NCj4gPiB2MjoNCj4gPiAtIEluaXRpYWwgcmV3
b3JrIG9mIFZGIGFkZC9yZW1vdmUgbG9ja2luZw0KPiA+DQo+ID4gTG9uZyBMaSAoNyk6DQo+ID4g
ICBuZXQvbmV0dnNjOiBmaXggcmFjZSBjb25kaXRpb25zIG9uIFZGIGFkZC9yZW1vdmUgZXZlbnRz
DQo+ID4gICBuZXQvbmV0dnNjOiBhZGQgbXVsdGktcHJvY2VzcyBWRiBkZXZpY2UgcmVtb3ZhbCBz
dXBwb3J0DQo+ID4gICBuZXQvbWFuYTogZml4IFBEIHJlc291cmNlIGxlYWsgb24gZGV2aWNlIGNs
b3NlDQo+ID4gICBuZXQvbmV0dnNjOiBmaXggZGV2YXJncyBtZW1vcnkgbGVhayBvbiBob3RwbHVn
DQo+ID4gICBuZXQvbWFuYTogZml4IGZhc3QtcGF0aCBvcHMgc2V0dXAgaW4gc2Vjb25kYXJ5IHBy
b2Nlc3MNCj4gPiAgIG5ldC9tbHg1OiBmaXggZmFzdC1wYXRoIG9wcyBzZXR1cCBpbiBzZWNvbmRh
cnkgcHJvY2Vzcw0KPiA+ICAgbmV0L21seDQ6IGZpeCBmYXN0LXBhdGggb3BzIHNldHVwIGluIHNl
Y29uZGFyeSBwcm9jZXNzDQo+ID4NCj4gPiAgZHJpdmVycy9uZXQvbWFuYS9tYW5hLmMgICAgICAg
ICAgICAgfCAgMTQgKysNCj4gPiAgZHJpdmVycy9uZXQvbWFuYS9tcC5jICAgICAgICAgICAgICAg
fCAgIDggKw0KPiA+ICBkcml2ZXJzL25ldC9tbHg0L21seDRfbXAuYyAgICAgICAgICB8ICAgNiAr
DQo+ID4gIGRyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9tcF9vcy5jIHwgICA2ICsNCj4gPiAg
ZHJpdmVycy9uZXQvbmV0dnNjL2huX2V0aGRldi5jICAgICAgfCAzMDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJzL25ldC9uZXR2c2MvaG5fbnZzLmggICAgICAgICB8
ICAgNiArDQo+ID4gIGRyaXZlcnMvbmV0L25ldHZzYy9obl9yeHR4LmMgICAgICAgIHwgIDQwICsr
LS0NCj4gPiAgZHJpdmVycy9uZXQvbmV0dnNjL2huX3Zhci5oICAgICAgICAgfCAgIDEgKw0KPiA+
ICBkcml2ZXJzL25ldC9uZXR2c2MvaG5fdmYuYyAgICAgICAgICB8IDE0OCArKysrKysrKy0tLS0t
LQ0KPiA+ICA5IGZpbGVzIGNoYW5nZWQsIDQzNyBpbnNlcnRpb25zKCspLCA5MiBkZWxldGlvbnMo
LSkNCj4gPg0KPiANCj4gTG9va3Mgb2theSB0byBtZSwgdGhlIEFJIHJldmlldyBmZWVkYmFjayBy
YWlzZWQgYSBjb3VwbGUgb2YgcXVlc3Rpb25zLg0KPiBJZiBpdCBpcyBvayB3aWxsIHRha2UgaXQg
YXMgaXMgZm9yIHRoaXMgcmVsZWFzZS4NCg0KVGhhbmsgeW91LA0KDQpJIHJlY29tbWVuZCB0YWtp
bmcgaXQgYXMgaXMuDQoNCiIgUGF0Y2ggMTogUG90ZW50aWFsIGRlYWRsb2NrIGluIGhuX3ZmX2Ns
b3NlKCkiIGlzIGEgcmVhbCBpc3N1ZSB0aGF0IG1heSBhZmZlY3QgbmV0dnNjIHNodXRkb3duLCBJ
IHdpbGwgYWRkcmVzcyB0aGlzIGluIGEgZnV0dXJlIHBhdGNoLg0KDQpUaGFua3MsDQpMb25nDQoN
Cj4gDQo+IFRoZSBBSSBzdW1tYXJ5IHdhczoNCj4gDQo+IFBhdGNoIDE6IGhuX3ZmX2FkZF91bmxv
Y2tlZCgpIOKAlCB3aGVuIGhuX252c19zZXRfZGF0YXBhdGgoKSBmYWlscyBhdA0KPiBzd2l0Y2hf
ZGF0YV9wYXRoOiBhZnRlciBhIGZyZXNoIGF0dGFjaCwgdGhlIFZGIGlzIG5vdCBkZXRhY2hlZCAo
bm8gZ290byBkZXRhY2gpLg0KPiBUaGlzIGxlYXZlcyBpbmNvbnNpc3RlbnQgc3RhdGUuDQo+IA0K
PiBQYXRjaCAyOiBuZXR2c2NfdW5pbml0X29uY2UoKSDigJQgcHJpbWFyeSBjYW4gZnJlZSB0aGUg
c2hhcmVkIG1lbXpvbmUgd2hpbGUNCj4gc2Vjb25kYXJpZXMgc3RpbGwgcmVmZXJlbmNlIG5ldHZz
Y19zaGFyZWRfZGF0YSwgY2F1c2luZyBhIGRhbmdsaW5nIHBvaW50ZXIuIFRoZQ0KPiBsb2NhbC1v
bmx5IHNlY29uZGFyeV9jbnQgY2hlY2sgZG9lc24ndCByZWZsZWN0IHJlbW90ZSBzZWNvbmRhcnkg
cHJvY2Vzc2VzLg0KPiANCj4gV2FybmluZ3MgKHNob3VsZCBjb25zaWRlcikNCj4gDQo+IFBhdGNo
IDE6IFBvdGVudGlhbCBkZWFkbG9jayBpbiBobl92Zl9jbG9zZSgpIOKAlCBob2xkaW5nIHdyaXRl
IGxvY2sgd2hpbGUgY2FsbGluZw0KPiBydGVfZXRoX2Rldl9jYWxsYmFja191bnJlZ2lzdGVyKCkg
d2hpY2ggc3luY2hyb25vdXNseSB3YWl0cyBmb3IgaW4tcHJvZ3Jlc3MNCj4gY2FsbGJhY2tzIHRo
YXQgbWF5IHRoZW1zZWx2ZXMgdHJ5IHRvIGFjcXVpcmUgdGhlIHdyaXRlIGxvY2sgdmlhDQo+IGhu
X3JlbW92ZV9kZWxheWVkKCkuDQo+IA0KPiBUaGVyZSB3ZXJlIGEgY291cGxlIG1vcmUgdGhpbmdz
IGJ1dCB0aGVzZSB3ZXJlIGp1c3QgQUkgYmVpbmcgb3Zlcmx5IHBhcmFub2lkLg0KPiANCg0K
