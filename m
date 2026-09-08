Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239DC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2C34026E;
	Tue,  8 Sep 2026 07:49:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011046.outbound.protection.outlook.com
 [40.107.130.46]) by mails.dpdk.org (Postfix) with ESMTP id 3C3454026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 07:49:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8YN/gMyAkcUXB34gdsRzZSwx6WyAwPqsgGP9bCMWMDUivwtInpWo7cHR1HvuVlCNDHWe3hcI25/Y/5+Duz4wDxdbVJ+3YC+MHsurkfyr+QeNS0LCc2AxBGv9NN2XA9n9avKOe1nuyaJ26a0ov+QfNqBpYazGUo2TwDuq8tkrrH2nP/rI3nSet9KwhZ0N257ZLfqCRsxp+/dBpOkKRN3+2sXvRvWFtoRT6Oor/YSndCKarM5S7m57E5flojfwakt0QLlFIBI1mlp/XgKVEu3DN3LHKma6xsSe/y0VGyjw4ypiiPIN3/mZhHtQgVP1ULH7gevamUglKVRuWC5P5SZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLGwMxWCv+eCJLIaCa8/H+d3j+pLIPjl66liZN0eCr8=;
 b=ym7jzjAcIEMW+c3xr2LX3o4fKeTEi7zKnjEsAS/ZTDO5TacJuqBVCGGuuIGd+E9ncNg/FkSxcan0Kw0n5Hd/ijaHeeix3P1r10LHM8/R2wBR3YBTK0XF93A/T767afHqyOFBw5VU+BTFHwW272+u8g4H8NldiJBuJF2NHii86YWzjU21supSh6VwVCmVi0mlFKpPvSFgFW9FyQYybuGnAvfuQ3e3xEmS194hKPD8pe8VbR8KSmBLdpbLIdnZjq6q0nLENlAL6xJcnzijBJX8ohuSLHh/5nPqlS2PMRmiw3KlGPs+8XUflWDAwYAOa+lTxyOa+I23Rt/XSi9Cieatww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLGwMxWCv+eCJLIaCa8/H+d3j+pLIPjl66liZN0eCr8=;
 b=TACuiFh26Pd6rOUf2pE0oNzjjXoiGUjByhxydMEKXS2+ZSzTopCpDx69CL97uD0zQyK4UV3ljYZa1FXLCWrvnZmSRH6zmdOYW+A7DFm/uKRmWecEUqKuxstdworv6fHuZOtxg0cXqJUVvF2p9KsTYmGlPA6QAiEiLF3G/f/cZuFJf5BmCAC4QTNLynQtEXdJRd5X2f7Cqz1Vs3bZ8cikyIHNy3U8+y9xlJvGMoY+dTb1sBWm6TC6Ra+iY+HLJn+NQ/neDJoP24p6wK9tWe9TPvPXklN4Uu5RzdLc4jdOlYmaBKWpu0pe6WA8ZrqqNQY53PSPfECY/Prh9yYTS4JW9g==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by BR2PR04MB471499.eurprd04.prod.outlook.com
 (2603:10a6:2c8:4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 05:49:45 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0382.007; Tue, 8 Sep 2026
 05:49:44 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for VF
 rings
Thread-Topic: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for VF
 rings
Thread-Index: AQHdMTHeOSKL59i9V0adrOoD+KelAba9PysAgAW0fjCAAH54gIAA1uzA
Date: Tue, 8 Sep 2026 05:49:44 +0000
Message-ID: <AMBPR04MB1228142D0ADA7E5E4A75A88CCE1B12@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821055643.1359277-16-g.singh@nxp.com>
 <20260903111938.6164ae05@phoenix.local>
 <AMBPR04MB12281ADC78B3A57B4DAC360A4E1B22@AMBPR04MB12281.eurprd04.prod.outlook.com>
 <20260907095935.2e025e86@phoenix.local>
In-Reply-To: <20260907095935.2e025e86@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-09-08T05:48:51.0000000Z;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public; MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|BR2PR04MB471499:EE_
x-ms-office365-filtering-correlation-id: 992075a6-fb7c-4b58-9160-08df0d6cfc3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|10067099003|4133799003|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: KYDChKGH5yeNRJP569eqsyIllFutk9gKBUMof1UciRuf4hf7lu7zcoklia4kAERmO50U34KhMuGtxDBIQuI4aXwKcBXwGA9cFzUUG6PSRUHJhuXHbTRVhltFjPRsrG/LO+CH5MHRP0vkS2tCwd2WKGe1zl5oHqxBkdgZpWBapPvTvCtffN0uivwnD9SmxsbSNTz44kVKYNPgX+4oRbLIOTrA6XTMztAT/zirbUIOQoDqQGpXqOe08puselQ9OB3x7hD+EBnPjWZVWBUTib+5yeOp8E5JE3HrR/IJNdn555g77+nvG4Z5kX5zTttWd0+q95btBgFAsTSfRneNb2w/ZssiYMPHJSqWXX7gQpUyGqGgeAjhStIJCBOJtCgod7NW+sIPnqIaKvfHdabUD43JwQZKFYxjS189XGfTuyF0ZNCFMt2QMay5wkOtpuhy6B5QCBxW/I1t4dAWSf/Cel+/8Dzod94A4IAwbuS6eUYupzgVuN1LC5Z1+XsZ6e2L6hDWRMX2fdAH7xlWSXlZKTt0tYstKgSFueCMiA/aeAdUjB+A0DPGgVYtcErwjMOEGyl9D4CQCn0EOkcDY4THPM5M9TnZTb+jEM7o8+LSgL9FrVNltLtlDS6V8Dq8reCljQLvBGiMdm5UCaKFzvNZ+UK3YLpsK0bv9X1xVIKK1t2j/wiq3tAc8XDeQ3P3cP7+VnkoWxdtVkXiqOiz8Ky3ZuXhf8ZJCBWQwhPsFS7gZXIfIM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(10067099003)(4133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxDNE1GT1hRdU5ZazZLUGVmVFdsTGV2S0F3c3p2VDRpZDkweThEVVZYU1hF?=
 =?utf-8?B?aTkxeTdsMUlVVURLeHQrNFdiWmIrNTBPNWo0VXhLNk5NNUo2U05Sc2dQQXFy?=
 =?utf-8?B?SDFVaXdRUW1jM2ZBWng0VlNHQzVrWG0rbG9Ya0JNOVh0cFVNLzZnZlo2NENO?=
 =?utf-8?B?THBMbWl4UkkxNzcxK1BMcXE4OEpwN1dTWmRiM2t5N0ZJRFJXSjdYTkI0d3pG?=
 =?utf-8?B?dm8vc0VQbUhQWldpeUZtU1FscStTWVFUeER3Tno4OHlIMDFPeTB2eUFlNnFE?=
 =?utf-8?B?VmxxallXay9HZ1hTaFF4MldpeU0xWXcxK0xGZGFQSDZMZFMzM01MMjU2MFc2?=
 =?utf-8?B?ME5Xb0wzdGw5RVB5c3ZQYXF5Y3ZqNlo1VTFCWGZtRkNUb2NnL1lWKzJGTFRK?=
 =?utf-8?B?eXNHN3VJemJvSmhLeGpUM2d6YWNsUWRld0hOcExtQzFpQTlaU1JERFFWTHcv?=
 =?utf-8?B?OEozSUpoYjRwNElFMDZLZm1kaldjd00vZkZDOGlWVEl3dnd3QlA3a1NmNnJ3?=
 =?utf-8?B?UDJzenpSL0t0cEdkMlRqTCtqN2NQa1pVNEQ2U1lITVcvT1Axa2pWSVRsMlgv?=
 =?utf-8?B?MzJQS1BWOU13NHIrNk9RZVMycWpFNHJ2bTVFV1NFbVdZdEVLTlRKU2p1aW5D?=
 =?utf-8?B?MklJQXBvcXhFcHZya3ZkYkxiT2p5azA1ZkF3akQ1cWdyV1Rhc3lmNGRSNnA0?=
 =?utf-8?B?V1NNblBtNjk4N0tMVUVIMEFsSUxqalRQY0ZvUnBKbEk0RFBCNDVCOXBzRXpQ?=
 =?utf-8?B?Q0NxNWZGZERxWTltV0g5ekc3dlJkU1hPY2RJM0Y3Zk9kVGFOTE9BZG9LNnRy?=
 =?utf-8?B?VEdQeHg5T0dXWlRFcmlFc0dReVpoMGJMUTFVclVGUGhpL2JDZWdYSWh6QVIx?=
 =?utf-8?B?U1RsbEIrZ0NOQXlCbXJWMHJ0QlpSWkkrdkhpSGRUZmx2clE5TnJ6WDh4TGdo?=
 =?utf-8?B?TmVubWpLNEtuU0tKQ21KN3BnYXEvNHBUcHJjYU5NcEk3RlpsNUZlUXkrTjA0?=
 =?utf-8?B?OXFhVGQvMU9qRmlscFRHa3pYNFNFaE1wdFY5NWNwckVSNFh3eUpzVVBjSDVF?=
 =?utf-8?B?SjJnU2lYZWZ5VENobEtjZmZET1VJMjBSTUNteFdVYVBZcExaMFgzcU1MN1Nl?=
 =?utf-8?B?d0x1UWJIeUw5OEc1SURiUERCNmtrS2VpQWJpZFkrYXlZZXJuRlZoSjJpdUxo?=
 =?utf-8?B?TFFuZU1rVW11TksvSk9LOHYwckN5WVp6dXM0aGFwcTdvUWNIL3Z1Q0FrZkdh?=
 =?utf-8?B?OGl0bk9qbzdOQ3E0SWZaYUo3UzJZc3JxS0lYOC8yQ0dzTWNZZVVrWGdBaWxD?=
 =?utf-8?B?T2xqTXZCamJ6NXQ5QmVQVnpvbXBQaC8zY1Zxcy91a2RPTHpZd0UrZ0xtcWJk?=
 =?utf-8?B?RVZlalVXR2RJbEg2SUtObUFPVndnMTNOUkI2eFMrbTNQMTRiTk13a0c4emw4?=
 =?utf-8?B?bjlLZlBXYWV0d21sN2xvVlh3THQ4M0VVWnhFclRCUjBwZUJwZHZNdTQ2SnU5?=
 =?utf-8?B?NUJwUGx3SU8yd1lEY0ExRDR4ZnhNOWxBKzFrb3NHRDlEN2NDWitXVEQ5NHNC?=
 =?utf-8?B?MDBvcjJnTitBaWlsamJrci91OWFKRW8yMEZwUkw4eEI2Rmt4dEVXbVM3a1pm?=
 =?utf-8?B?RUxxNlkrVVVOL0ovNGkycDRjeTdiUnM0RUMvaVpraCt2Z2w1SGg1RytUT294?=
 =?utf-8?B?NThscUhaRzc4clRFYzRKeUVPNUZmMUk2SU5kOUNwbFRIeE4xd2svU2FHd3BW?=
 =?utf-8?B?UHlWQ09HMlFUL1VqdHQvc1BFZWZNZFMyZjl1ci9jcFUvc0ZhejFhbVlpR1Ez?=
 =?utf-8?B?Ulh5Q2x3RDQ0eXJtaXlvVlFDLy92ay9LcENPdlN2L25ob1FrVjl4SGVWWTZG?=
 =?utf-8?B?WDJYTjlVNGhlWDJ2S0s1Q3VSK25CSS80a08wZHpmdlRTRTRHT1FHSW1pZG1P?=
 =?utf-8?B?Sm9WMkpRNFJWbS9aQkNHL3NMaGZkWno4bCtkZVFUOWZHMUFlQkJBUDR6Zng1?=
 =?utf-8?B?ZVl2NWVxMm12dXlnVHNUQTVkb3labU4wNm9ocUlTdURoMXdmSk9VZm4wUFJL?=
 =?utf-8?B?VUthL2dKYUFWK2QrbXhjN21mLzZXUjFmNjZqSUFnWnBxbTRib1JPZE51M2tW?=
 =?utf-8?B?cTJFUUx4NGNodmo2RlFsVjBpR3RJSytINGNJMUJGUlRSbE1EdjN2TTdZbDFk?=
 =?utf-8?B?azZpQUN2VFRxVDVQam5XNkEvdU01MjdoWGhSNXdLcFdWemlZNnBjS1UyZEFn?=
 =?utf-8?B?VWtyVGxXOGFrMDB0Z0tHZ2RVcUI1Vng5YXdQTGdwTjc5ZUw1QUVuWWhWeGdD?=
 =?utf-8?Q?EmeNF6DxYiy9A0drM4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992075a6-fb7c-4b58-9160-08df0d6cfc3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 05:49:44.9099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiIeKqpGX+78pKT8lIdeyNIthhjvV0OGCzJQw/Zlce/yTZ9p37M+oS5eujGwpTlu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB471499
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

DQoNCg0KTlhQIFB1YmxpYw0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
dGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IE1v
bmRheSwgU2VwdGVtYmVyIDcsIDIwMjYgMTA6MzAgUE0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8
Ry5TaW5naEBueHAuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBIZW1hbnQgQWdyYXdhbCA8aGVt
YW50LmFncmF3YWxAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMTUvMTVdIG5l
dC9lbmV0YzQ6IGFkZCBXUlIgVHggc2NoZWR1bGVyIGRldmFyZyBmb3IgVkYNCj4gcmluZ3MNCj4N
Cj4gT24gTW9uLCA3IFNlcCAyMDI2IDA5OjM2OjExICswMDAwDQo+IEdhZ2FuZGVlcCBTaW5naCA8
Ry5TaW5naEBueHAuY29tPiB3cm90ZToNCj4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHRo
ZSBsYXRlc3QgY2hlY2twYXRjaC5wbCBzY3JpcHQ/IEkgdHJpZWQgdGhlIG9uZSBmcm9tDQo+IGtl
cm5lbCB2Ny4zLXJjMiwgYnV0IEknbSBub3QgYWJsZSB0byByZXByb2R1Y2Ugb3Igc2VlIHRoZXNl
IGVycm9ycy4gSXMgdGhlcmUgYW55DQo+IHNwZWNpZmljIGNvbW1hbmQgb3Igc2V0dXAgcmVxdWly
ZWQgdG8gcmVwcm9kdWNlIHRoZXNlIGlzc3Vlcz8NCj4gPg0KPiA+IEFsc28sIHdvdWxkIHlvdSBs
aWtlIG1lIHRvIHNlbmQgdjEzIGFmdGVyIGZpeGluZyB0aGlzLCBvciB3b3VsZCBpdCBiZSBzdWZm
aWNpZW50IHRvDQo+IHNlbmQgb25seSB0aGUgdXBkYXRlZCBwYXRjaDoNCj4gPiAibmV0L2VuZXRj
NDogYWRkIFdSUiBUeCBzY2hlZHVsZXIgZGV2YXJnIGZvciBWRiByaW5ncyI/DQo+DQo+IEkgdXNl
IHRoZSByZXBsYWNlbWVudCBweXRob24gdmVyc2lvbiB3aGljaCBzaW5jZSBpdCBjYW4gYmUgaW4g
RFBESyBkb2Vzbid0IGdldCBhcw0KPiBsaW1pdGVkIG9yIGNvbmZ1c2VkIGJ5IGtlcm5lbCBvbmx5
IHRoaW5ncy4NCj4NCj4gU2VudCByZXZpc2VkIHZlcnNpb24NCj4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2h3b3Jr
DQo+IC5kcGRrLm9yZyUyRnByb2plY3QlMkZkcGRrJTJGcGF0Y2glMkYyMDI2MDkwNzE2NTgwOC4z
MjA4NDAtMS0NCj4gc3RlcGhlbiU0MG5ldHdvcmtwbHVtYmVyLm9yZyUyRiZkYXRhPTA1JTdDMDIl
N0NHLlNpbmdoJTQwbnhwLmNvbSU3DQo+IENjNjVjZjgzNmQzMTY0ZjcwZmU3NTA4ZGYwZDAxNmM4
YSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjMNCj4gNSU3QzAlN0MwJTdDNjM5MjQz
OTcxOTA3NDk4NzIxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWA0KPiBCMGVVMWhjR2tp
T25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBi
Qw0KPiBJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPVJFSEUwblVUQlY1M01p
YUI0QUxsSkxGWUxMDQo+IG9objF5c2lEeUwzWWhkWnQ0JTNEJnJlc2VydmVkPTANCg0KT2ssIEkg
aGF2ZSBzZW50IHRoZSBWMTMgc2VyaWVzIGFmdGVyIHRoZSBmaXhlcyByZXBvcnRlZCBieSB0aGlz
IHNjcmlwdC4NCg==
