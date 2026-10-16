Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861BFCCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F44402E7;
	Fri, 16 Oct 2026 18:48:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
 by mails.dpdk.org (Postfix) with ESMTP id 2C2DA4026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:48:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va4JT2nZhBX+cbBatxTuEKn0q9gMZKW/7o/+as8fZhQPW85yvBNVe5X2sL5fk0zc6MiductUi0gTlcdllr6VsqV05SpA6lwhe87zLTIHj0lof2k7q6EHFDtIvNE7/Uc3XxGp5Gw27UQROfc87iHojsmZu5VsR/WKC2EEgFS9Apc7NMt7CHs+A1AvdeNed4TcymU0Lb9Jxess8PyBFhI8983dOlzmcL3FmDAcKDv/SYD7VO+ZUK63pf9Kl8SJXDqE3n91bmFb+HpgpuXa8m55WMimhEgRqsHD8YhHgkH1tvzcBGMZhwhfm6ReqtwtSMuDa4OVi8kgsPSjPpHY0/o4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg+gSQ5cBTwo/QG4S7MRRY6Rut0ztXqAUWxMIhw9wYw=;
 b=DOwNdLrbh55wQIIUu48h53Fl0LTscT0g1Quz1osFJq0RtWBu01AFBgVYTSWpVMXdx8Izo1bv/f8VNsznQqgEB9cR8JIM7WnhU+MUTzIo9k56G3gxdpVoZUAA4wDW6t3qJoKG5h97/aAH4b1BLfnl+spNU3HM/ZB1dI9uHsdkuc1jLsaIHf/bH5zkjuejfCLA9taxHjGRix63BXpbu94NICBKYMoCPs7JUcT5f+D0PvD6Lo8YMPbeksNXyvX/+glmlA11H36O05bBxiuFhXzjmfkh1UVVMovQkctZMBweKOw+CoQiqv4iTygl3wgio3dKQ3j9QVsXNr7ZEbxR77jV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg+gSQ5cBTwo/QG4S7MRRY6Rut0ztXqAUWxMIhw9wYw=;
 b=kyYvQQCrkiufLHSasw5zP/ds4daEgR3oFRw7qfxrid7nhv1655GPTOHqkrUEisyqXGmQCmtUbROTHE7DtFGBd8tFqn4C994rTSTHrpboYEgRBknCf3/w5hGmmGxqLMGhVwQHpb4/7ouzfA+IqPTaGJZjetsSkxZqQBfsWqwP8NUVeQ2+ZGrg70dJBtwvixpfKM9ev2gBLbFdJlLnt+saGfpElZCRDCmJvGrCrYvano8zhlMUkY51fdUatTqwl2Ro4UkKqSZq6VuUP/PJKCsDm5jIku15bnQkyD4O2Z0uIdSj/Bmq2opQacuty3Gk6cXmQe7UaPHQs4jv3GN6e7iciA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM0PR04MB6931.eurprd04.prod.outlook.com
 (2603:10a6:208:17e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 16:48:30 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 16:48:30 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v27 00/25] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdXWBMnOwr8hhdk0Si6YK9HoxH8LcAXvaAgAACLDA=
Date: Fri, 16 Oct 2026 16:48:30 +0000
Message-ID: <GV1PR04MB10750670E599D034FA89E627A899B2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
 <20261016093848.7dbe6c73@phoenix.local>
In-Reply-To: <20261016093848.7dbe6c73@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-16T16:46:51.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AM0PR04MB6931:EE_
x-ms-office365-filtering-correlation-id: 80bf00d1-3d10-42d2-2963-08df2ba54f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|38070700021|4143699003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: trfQ00Gt/pSImrrHD15dkc/MS5CXU557uiBeXvfb5v3FXlJ0bZ+wyy976Q95Xa3CJzuLzSZEJJfEDweWcZHrX54viCSrKAXs1JwEAffqBTRCeMeNaeUzxJbh257h4c6kM09/vC3SF5B8Am/Y7LJHuv+NsT10bjraMtyx2+87kSXLEbwR+d+R6GrjCyorVI0ZVlEvtIExtWFmcpk9KIRbRTW+nVzmkzfspXZEUu5bPhvYWRDYSzcb2awzRB3DZ/fyoeLCyRwiyeEmEYi0/5dSMoEK5ddSMgHgInq5aVCvRN8IEYdN643CJqD1gZoGq6/0dKBC+lPmfKNdX6bP1s12rHGqp42xL12dpDwBBtqt056K4d0eTb3Hgp6frQYYjrEOCrPoU/XdTbxGQPwoLPqxKsKzcbEej1ubgSsQTav7WtC3HbEbOpCuzL/RrcPhngkjj1I5PcshRF+KgArTDuUqcpJNb0i1zN3N+6t23+A1SdcxEs4TCcHNDlHrff2WH5Sa1A6f7EmnfrFvQiQDUZhf9DLaMcFaPWqZnyV4tKMMWIZQ5xUmDcPvrhMBRlf5coXObWeUKXOTbkSmq7ewrzkEmVUjO+q7hU4V/kC57+jm0rfIh4vu81egz9tbklFl2tK0h0o91Qr8nvSZrAAdNkp5090aomHvv/0mgQL8Ls9qwpNynSQBV1fvOVAWDT5lMyYFFP/gXZc46Y46m0yT9iugdjwPTICaftxgdboV6uJ5lhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(38070700021)(4143699003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFRQRnpMK0lTNDFjaUt6YXkrZHhodmVGVHlJYzFJa2IvNG1yYmIrZWNCdG1x?=
 =?utf-8?B?MTJkTnFQSGVDL0RNTjZZY3p4Qk1uQTFBbUdtQi82bWVmbHhoL2ZsdTgxTkxk?=
 =?utf-8?B?UEFsa1A1Q2ptOUw3UkZoSkhEdG82aCtTUmNzcG5yRFpmR0VOeUpSakFCR3Fj?=
 =?utf-8?B?T0VmRGFTSVg2L1ZCei9jZWNUS0kycUhyV1ZYZ1dseXFIR3BNL0VQMlh0NVZ4?=
 =?utf-8?B?Q0xOcWxpQjdPcXEzaWhXZDBTNHFWTHlOOEROSjhzakRMOE5GZ2k5SDJFelBK?=
 =?utf-8?B?SDRWMkgwTWxpVE5qUzdDa3VqSWlwL01ndWg4Y0pOU1k1b0NrQTI4Sll5eW1B?=
 =?utf-8?B?M0RXcHo2SzFESGxJMmNpYzhIc0RuZnM4dkUxWGVQcWo5VFlsQXBpQTJrZWI0?=
 =?utf-8?B?NkhGQloxWnArblNhS1pvdC9NZ0I3QUJpN2NtbDBjQmV6Y3lSSEY3aUZLbkFM?=
 =?utf-8?B?bmpPVm4rZUw0NU9qVW85SFZMQytqMVlHM2JYNWxnUlljSENyWitVTm5adkhT?=
 =?utf-8?B?aE1PTnl4czNJbCt6M2tXY0lGc25aL25FL091OFJudGtEbXdpcWVlaUMvcDNh?=
 =?utf-8?B?Z0RQa1czRjFCUXJNb3YzRmppNy9TWHhMblIvQ1c1NUMyeU5uSjAxU3hzZCtm?=
 =?utf-8?B?NmRTSmNDMGhtQ1ptSjdlYzRFVnhPM3VRa3IwcFRITlB3WElBa1UvZy9UV0dx?=
 =?utf-8?B?Tk1oVTJjQmg3NCt0dS8rZHBRVWtsM0NBMTZ6RktNVEhTZGxFYzRhMUE0TlN1?=
 =?utf-8?B?eFRrSWUwVFFDcE5JYTlFanZjbzB3UURVUjF0aFBmYlBPK2lXeGE4TGZQR2R1?=
 =?utf-8?B?K2V5bFNHdUduS0JURkh6d2dTNitId2VoL1J0eEREL2RrUHFKYnNMNmJQQ0VW?=
 =?utf-8?B?ejVidGJ4NGpzcEJrM3kyNWNWY0hMSWwrSU1JZmdFME1HazJPdit4L2gva25E?=
 =?utf-8?B?V1d4NGV6Mm5VdEx1VTFDeW9NaHdRMHNXYmk5dEF4bUE4ZDJSOU9Bc0FiRVZJ?=
 =?utf-8?B?UWtaOWZsMU1sdnJiR2daaFVjTXBkYkNUQSttd1E2Y21objhKbGRtM1VMOW1B?=
 =?utf-8?B?bzE1QWhFWGgxRlRXWHpYQStuZ0doMlNFakF6endUb0FxZWlCUm1kYnB3dmJ2?=
 =?utf-8?B?ZDF5QmR6cVVxVHhxN2NmUHA0cm8ycUlKVzMwSUJldHJvM1VIMCtHNWdIaVR5?=
 =?utf-8?B?b21YYzhVREZRSlVlRGsxRUh0YUhwUFJiSkhzc1M0bXVyR0xhM1VTaHZiQ0Ur?=
 =?utf-8?B?bUduMXgzNGJjclQ3b0pzaWhNVlRBenFBME5ML3lZcjZYUVlyZzZjcTBranI0?=
 =?utf-8?B?VnlRQno3TzdQTjcrVFBaMkZWYm54SmZ4Sjg0S2RPVnQvRmViVXRWNVZhZHlM?=
 =?utf-8?B?bHpQS1FDdHNwMk8rL2l5bnZhSEFMUDcybEVIaHhlTVY2VkprK0dhQnoyUDZH?=
 =?utf-8?B?eCsza01VdjIxNm5ydndzeDA5OENqdTJERDdOWHBVVWVnM3N6OUpSUHR5Zm5W?=
 =?utf-8?B?TktzODd1aXpRNDJ4QSsrQ3VYdDlycS9zOEx6Z0VVY0VhUm1rUXA5S1pJVkJK?=
 =?utf-8?B?dGxwMWZvTnYwd2p2ejFKMzFLdlY4WHRTZ1ZmTE5VTHdYZ0xCWVZkaFhMTkx0?=
 =?utf-8?B?NFVjZlRWb0ZDMWZvNC9KUStsRFY4citZY2FkSU90M2tPYnBNWFFYYXhKcXpy?=
 =?utf-8?B?ZDgyUzNuNjZ5NFlxdTZUVHBlS3dydHB5ZU5Pc2tkc0NxbGJKdy9YcmhIcDZu?=
 =?utf-8?B?NkgwQlFCQWxNcVpkMGE0YnRtV3BvNlBGbnFIUXN4UnhpM0JlRUpoSkhBWDdp?=
 =?utf-8?B?QTNrTjJrL05PWGx1Wnl0cXVSSjlIR2p6d2dJQ1RDbDBFRmhoQ2xYNThsY2wz?=
 =?utf-8?B?VHNDakdKdlRtRDVqYW4rMkFjSUoyR0ZmaU1yMlRoNTFuN2FSTnBobmM3b1B0?=
 =?utf-8?B?ZjJlQzVQVlNlZHJqd0ZVclBhOWVRM255bHhvZFZQaHFaMTRDTFNzamZiR3ls?=
 =?utf-8?B?YVZsdWJQZUxPRXkxcU40WEZjbzFTbFdMU3RwYUtBaGxPZ0Y0b0hTZUV0MldY?=
 =?utf-8?B?TE1lZjlRdVNjc1Y4ZzJvY1hGYU5xS0JzQzhRZnNNMStqZ0RkdG03RXJPNUJO?=
 =?utf-8?B?UVkySDd3STBmRkNnUzJVa2ljaUVvV1NJczRJdHZ3WEdlVEYxMGRKOEhTMk1M?=
 =?utf-8?B?YU1qQkR3ckIvTWhqT1F2bVlVZTFPeWRNR1J5QXJhKzZLbncvN3lZOGNTNnBz?=
 =?utf-8?B?Z2diZ0p1UHNZNjRKcDVYZFNkekhrUTVqQXQxTjNMd2VrNFNSTGZqcERRc3Zx?=
 =?utf-8?B?U2cwNkR6S29XTDBYYityWUlOblFWWDJGeDhET2g2L3BDNzBXclNJQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bf00d1-3d10-42d2-2963-08df2ba54f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 16:48:30.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHzHU/SYXFYLhVM3S3axZum/QLWyOpPQGHQdBDK+2pOgUE9Bhfgo97K+WBx1wl3QRm+GoW8+Tmc+aIijiUKGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6931
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

SGkgU3RlcGhhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+DQoNCk5YUCBDb25m
aWRlbnRpYWwNCj4gT24gRnJpLCAxNiBPY3QgMjAyNiAxNjo0OTozMyArMDUzMA0KPiBIZW1hbnQg
QWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT4gd3JvdGU6DQo+DQo+ID4gVGhpcyBzZXJp
ZXMgY29sbGVjdHMgYSBzZXQgb2YgZml4ZXMgYW5kIGVuaGFuY2VtZW50cyBmb3IgdGhlIE5YUCBE
UEFBDQo+ID4gYnVzLCBtZW1wb29sLCBkbWEsIGNyeXB0byBhbmQgbmV0IGRyaXZlcnMgdGFyZ2V0
aW5nIDI2LjExLg0KPiA+DQo+ID4gSXQgaW5jbHVkZXMgbWVtb3J5LWxlYWsgYW5kIHJlc291cmNl
LWNsZWFudXAgZml4ZXMgb24gdGhlIGRldmljZQ0KPiA+IHJlbW92ZS9jbG9zZSBwYXRocywgbW9y
ZSByb2J1c3QgZnJhbWUgcXVldWUgc2h1dGRvd24sDQo+ID4gc2Vjb25kYXJ5LXByb2Nlc3Mgc2Fm
ZXR5IGd1YXJkcywgQlBJRCBsaWZlY3ljbGUgaGFuZGxpbmcsIGFuZCBzZXZlcmFsIG5ldw0KPiBm
ZWF0dXJlczoNCj4gPiBlbmhhbmNlZCB2aXJ0dWFsIHN0b3JhZ2UgcHJvZmlsZSAoVlNQKSBwb3J0
IHN1cHBvcnQsIGZtY2xlc3MgUnggcXVldWUNCj4gPiBjb25maWd1cmF0aW9uLCBub24gZm1YLW1h
Y1kgc2hhcmVkIEV0aGVybmV0IG5hbWluZywgYW5kIERNQQ0KPiA+IHNjYXR0ZXItZ2F0aGVyIGFu
ZCBlcnJhdGEtd29ya2Fyb3VuZCBkZXZhcmdzLiBEb2N1bWVudGF0aW9uIGFuZA0KPiA+IHJlbGVh
c2Ugbm90ZXMgYXJlIHVwZGF0ZWQgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBWMjc6DQo+ID4gLSBm
aXhlZCBxbV9jaGFubmVsX3Bvb2xfbnVtIGNoZWNrIGlzc3VlLg0KPiA+IC0gZml4ZWQgY29tbWl0
IG1lc3NhZ2UgYXMgZGV2YXJnIGZvciBmbWNsZXNzIHJ4cSBudW1iZXIgd2FzIHJlbW92ZWQuDQo+
ID4gLSBBZGRlZCBtaXNzaW5nIGV4cG9ydCBpbnRlcm5hbCBzeW1ib2wgYW5kIGZxIGRlc3Ryb3ku
DQo+ID4gLSBtZXJnZWQgYm90aCBGUSBzaHV0ZG93biBwYXRjaGVzIGFzIHdlIGNhbm5vdCBjaGFu
Z2UgdGhlIHNlcXVlbmNlDQo+ID4gICAgYmVjYXVzZSBvZiB0aGUgZGVwZW5kZW5jeS4NCj4gPiAt
IG1hY19pZHggaGFzIGEgdXNlciB3aGljaCBpcyBkcGFhIGZsb3cgc28gbm8gY2hhbmdlLiBBZGRl
ZCBzdGF0aWMgdG8NCj4gPiAgICBnX2ZtY19tb2RlbCBhbmQgdXBkYXRlZCByZWxlYXNlIG5vdGVz
Lg0KPiA+IC0gSXNzdWVzIHJlcG9ydGVkIGluIHYyNSB3aGljaCBhcmUgbm90IGhhbmRsZWQsIHdl
cmUgb3B0aW9uYWwsIHNvDQo+ID4gICAgc2tpcHBpbmcgdGhlbS4NCj4NCj4NCj4gRllJIC0gd2hh
dCBJIGRvIGlzIGZlZWQgdGhlIHBhdGNoIGludG8gYSBDbGF1ZGUgcHJvamVjdCB3aXRoIGV4aXN0
aW5nIEFHRU5UUy5tZA0KPiBmaWxlLiBUaGUgY2hhdCBjb250aW51ZXMgYXMgdmVyc2lvbnMgZ2V0
IHNlbnQgdG8gZW1haWwgc28gdGhlIGNvbnRleHQgd2luZG93DQo+IGhhcyBhbGwgdGhlIHZlcnNp
b25zIG9mIHRoZSBwYXRjaC4gVGhpcyBsZXRzIGl0IHNlZSB0aGUgcHJvZ3Jlc3MgYW5kIGNoZWNr
IGlmDQo+IHByZXZpb3VzIGZpbmRpbmdzIHdlcmUgYWRkcmVzc2VkLg0KPg0KPiBSZXZpZXcgb2Yg
W1BBVENIIHYyNyAwMC8yNV0gTlhQIERQQUEgZml4ZXMgYW5kIGVuaGFuY2VtZW50cw0KPg0KPiBT
ZXJpZXMgYXBwbGllcyBjbGVhbmx5IHRvIDI2LjExLXJjMSBhbmQgZXZlcnkgY29tbWl0IGJ1aWxk
cyB3aXRoIC0NCj4gRHdlcnJvcj10cnVlLiBUaGUgZml4ZXMgYXJlIG5vdyBmaXJzdC4gMDggY2hl
cnJ5LXBpY2tzIGNsZWFubHkgb250bw0KPiB2MjQuMTEgYW5kIHYyNS4xMSwgYW5kIDA2IGFwcGxp
ZXMgdGhlcmUgb25jZSAwMS0wNSBhcmUgaW4uDQo+DQo+IHYyNiBXYXJuaW5ncyBvbiAxMiAobm93
IDE0KSBhbmQgMjAgYXJlIGFkZHJlc3NlZC4gVGhlIDI0IFdhcm5pbmcgaXMgb25seQ0KPiBwYXJ0
bHkgZml4ZWQuDQo+DQoNCkkgc2VlIG9ubHkgb25lIHdhcm5pbmcgaW4gdGhpcyBwYXRjaHNldCAy
NC8yNSAtICAgaXMgaXQgcG9zc2libGUgdGhhdCB5b3UgZHJvcCB0aGlzIHBhdGNoIGFuZCBhcHBs
eSByZXN0IG9mIHRoZSBzZXJpZXM/DQoNCj4NCj4gV2FybmluZw0KPiA9PT09PT09DQo+DQo+IFtQ
QVRDSCB2MjcgMjQvMjVdIGRyaXZlcnM6IGltcHJvdmUgRFBBQSBjcnlwdG8gZnEgcmVzb3VyY2Ug
aGFuZGxpbmcNCj4NCj4gVGhlIGxvb2t1cCB0YWJsZSBzbG90IGlzIG5vdyBmcmVlZCBhdCB0aGUg
ZW5kIG9mIHFtYW5fc2h1dGRvd25fZnEoKToNCj4NCj4gICBpZiAoIXJldCkgew0KPiAgICAgICAg
ICAgZnEtPnN0YXRlID0gcW1hbl9mcV9zdGF0ZV9vb3M7DQo+ICAgICAgICAgICBxbWFuX2Rlc3Ry
b3lfZnEoZnEsIDApOw0KPiAgIH0NCj4NCj4gVGhhdCBibG9jayBzaXRzIGJlZm9yZSB0aGUgb3V0
OiBsYWJlbCwgc28gdGhlIGVhcmx5IGV4aXQgZm9yIGFuIEZRIGFscmVhZHkgb3V0IG9mDQo+IHNl
cnZpY2Ugc2tpcHMgaXQ6DQo+DQo+ICAgaWYgKHN0YXRlID09IFFNX01DUl9OUF9TVEFURV9PT1Mp
IHsNCj4gICAgICAgICAgIERQQUFfQlVTX0RFQlVHKCJmcWlkKDB4JXgpIEFscmVhZHkgaW4gT09T
IiwgZnFpZCk7DQo+ICAgICAgICAgICBnb3RvIG91dDsgLyogQWxyZWFkeSBPT1MsIG5vIG5lZWQg
dG8gZG8gYW55bW9yZSBjaGVja3MgKi8NCj4gICB9DQo+DQo+IE9mIHRoZSBSVEVfRFBBQV9NQVhf
UlhfUVVFVUUgKDQwOTYpIGlucVtdIEZRcywgZHBhYV9zZWNfZGV2X2luaXQoKQ0KPiBvbmx5IGRv
ZXMgcW1hbl9jcmVhdGVfZnEoKS4gcW1hbl9pbml0X2ZxKCkgcnVucyBmcm9tIGRwYWFfc2VjX2lu
aXRfcngoKQ0KPiB3aGVuIGEgc2Vzc2lvbiBhdHRhY2hlcywgc28gYWxtb3N0IGFsbCBvZiB0aGVt
IGFyZSBzdGlsbCBPT1MgYXQgdW5pbml0IGFuZCBpbiB0aGUNCj4gaW5pdF9lcnJvcjMgcGF0aC4g
VGhlaXIgc2xvdHMgc3RpbGwgbGVhaywgYWJvdXQgNDA5NiBwZXIgcmVtb3ZlL3Byb2JlIGN5Y2xl
LCBhbmQNCj4gc3RpbGwgcG9pbnQgaW50byB0aGUgZnJlZWQgZGV2X3ByaXZhdGUuDQo+DQo+IE1v
dmUgdGhlIGJsb2NrIGJlbG93IHRoZSBsYWJlbCBzbyB0aGUgT09TIGV4aXQgaXMgY292ZXJlZCB0
b286DQo+DQo+ICAgb3V0Og0KPiAgICAgICAgICAgaWYgKCFyZXQpIHsNCj4gICAgICAgICAgICAg
ICAgICAgZnEtPnN0YXRlID0gcW1hbl9mcV9zdGF0ZV9vb3M7DQo+ICAgICAgICAgICAgICAgICAg
IHFtYW5fZGVzdHJveV9mcShmcSwgMCk7DQo+ICAgICAgICAgICB9DQo+ICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPg0KPiBUaGlzIGFsc28gY2hhbmdlcyBxbWFuX3NodXRkb3duX2ZxKCkgZm9yIGV2
ZXJ5IGNhbGxlciwgc28gc2F5IHNvIGluIHRoZQ0KPiBjb21taXQgbWVzc2FnZTogYSBzdWNjZXNz
ZnVsIHNodXRkb3duIG5vdyByZWxlYXNlcyB0aGUgRlEncyBsb29rdXAgdGFibGUNCj4gc2xvdC4N
Cj4NCj4NCj4gSW5mbw0KPiA9PT09DQo+DQo+IFtQQVRDSCB2MjcgMDkvMjVdIG5ldC9kcGFhOiBw
cmVmaXggZm1saWIgZGV2aWNlIGhlbHBlcnMNCj4NCj4gTWFraW5nIGdfZm1jX21vZGVsIHN0YXRp
YyBpcyBub3QgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBVbnVzZWQgbWFjX2lkeFtdIGlzDQo+IHN0
aWxsIGdsb2JhbCBpbiBkcGFhX2Zsb3cuYzoNCj4NCj4gICBjb25zdCB1aW50OF90IG1hY19pZHhb
XSA9IHstMSwgMCwgMSwgMiwgMywgNCwgNSwgNiwgNywgMCwgMX07DQo+DQo+IFJlbW92ZSBpdCBo
ZXJlLg0KDQpGYWxzZSAtIGl0IGlzIGJlaW5nIHVzZWQgaW4gZHBhYV9mbG93LmMNCg0KPg0KPiBT
dGlsbCBvcGVuIGZyb20gdjI1LCB1bmNoYW5nZWQsIG9wdGlvbmFsOg0KPiAgIDA0ICBwcmUtZXhp
c3Rpbmc6IGRwYWFfZGV2X2luaXQoKSBlcnJvciBwYXRoIGZyZWVzIGNncl9yeC9jZ3JfdHgNCj4g
ICAgICAgd2l0aG91dCBxbWFuX2RlbGV0ZV9jZ3IoKQ0KPiAgIDE0ICBRTUFOX01BWF9GUUlELCBR
TUFOX0NIQU5ORUxfUE1FIGFuZA0KPiBRTUFOX0NIQU5ORUxfUE1FX1JFVjMgdW51c2VkOw0KPiAg
ICAgICBkcGFhX2dldF9xbV9jaGFubmVsX3Bvb2xfbnVtKCkgbmVlZHMgbm8gZXhwb3J0DQo+ICAg
MTcgIEZNQ19QT1JUX05BTUVfT0ZGTElORSBicmFuY2ggdW5yZWFjaGFibGUNCj4gICAyMSAgYm1f
YnVmZmVyX2dldDY0X2Zyb21fYmUoKSBzaG91bGQgYmUgYSBzdGF0aWMgaW5saW5lIGZ1bmN0aW9u
DQo+ICAgMjQgIGZxaWRzW1JURV9EUEFBX01BWF9SWF9RVUVVRV0gaXMgMTYgS0Igb24gdGhlIHBy
b2JlIHN0YWNrDQo=
