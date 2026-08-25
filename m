Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99221C5DF81
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 04:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 799BB4014F;
	Tue, 25 Aug 2026 06:10:46 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013030.outbound.protection.outlook.com
 [52.101.83.30]) by mails.dpdk.org (Postfix) with ESMTP id BAD00400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 06:10:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8D20+VM3UHoVwgQZhQXp/QCOeQRNXLO7Y1tm/du+hRaFvJbl7PO+sZgztgrGiovpG3oX1sigz3JbSLtsThduiYlO1ao3mlMf4Lz67c19+HX4DdfMFcvrOWCKwzl2PAwU2eLVBcb4rQFnqMOg2afuRueaIgu8/nvgpEdvZTyg65gkU9aRh/PUYEou4xM/Af4qajB9Uuo5UXfY/yLa6w5jDb6stMlIWknSqvRRD4gwiVpamRpx0myh1T0pvkWSDS0bwJj3tNCleFEnNCU7138O3rpfr50oth7VLWmYQC2WZ+9SZyQHfNwgnTKJCDlxeuCcX6nnlxJFOiOwLBS3yR1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+bWVZePy6wic6KTIoOAvAUZWKi5pxW3Bq3egRGK/7Q=;
 b=KxNqqQD0UO7sCiyxz4ZeYgjEUaObHlWMzbKO/UX1nk7mNhLHnz7+ONFA3JmpCpy5QVZkfyBxP6MwPhHP5/8bS9UBAmu51ABXWkjNOn0VDui7IiSuCUZibRnFNSJTc7al+NlgDMW9IHr8kXfViXO2lBHOgHx5n2FKZj0mqEBSjLf24ynPhLK76WiVCaxBn8/HxNocMrEZtRQF0zbO6ACIdgt/AygQ8Tl8Vc+qEhHB3oveMCdAhLyRdIfXKcNnDCn7T12M0WMn1QvS4FkLmESj8D+W9aanCX9iajodW7R6sKJm+Ddm6BxkKGDJwnVgXTcyrXrn97RVt01KAQ74AkOYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+bWVZePy6wic6KTIoOAvAUZWKi5pxW3Bq3egRGK/7Q=;
 b=iYxBAUA3plSLO0VnRLVg1yjQyIV1XBm+Q0XjrhqR9n1XqkYgz5VWmbED7/kS50RVmgRdNLr2DGpnOteLJh5kdLA4QwadBSsAz+lsas+fR2ZSGvT48C25kVZqxOd4d1kMrs4UNTtQVwpHQehvj55fnAzKdqFrZEMbxNT8xJzcQEpz/T9rmT2dltlRKaBy7YODRnrGwFqnMIbs0EyW3Usu1ihhFh75xZOob4qBGNI1AgAXnAmn/HkDl5Hlkkjj63VpCDgkQ1ly64YmkMn4+9PINk4s+YBezE42zP09iZPfrCWgD6t2lkjc64YohCyR/wP31gX6pT33h/02T/beQsQH8Q==
Received: from VI0PR04MB12262.eurprd04.prod.outlook.com
 (2603:10a6:800:326::13) by VE1PR04MB7229.eurprd04.prod.outlook.com
 (2603:10a6:800:1a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:10:43 +0000
Received: from VI0PR04MB12262.eurprd04.prod.outlook.com
 ([fe80::66ea:7fc2:5d39:e826]) by VI0PR04MB12262.eurprd04.prod.outlook.com
 ([fe80::66ea:7fc2:5d39:e826%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 04:10:43 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Thread-Topic: [PATCH v12 00/15] et/enetc: add new features for ENETC4 on i.MX95
Thread-Index: AQHdMTHf5qHuroLYvUadQtECBFnjw7aopuaAgAQxWtCAAJQNgIAAv62g
Date: Tue, 25 Aug 2026 04:10:43 +0000
Message-ID: <VI0PR04MB12262856BB8CC5CCFA182738AE1AF2@VI0PR04MB12262.eurprd04.prod.outlook.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821084927.6e6aa27f@phoenix.local>
 <AMBPR04MB122819F9F9BA58ABDD22A114AE1A02@AMBPR04MB12281.eurprd04.prod.outlook.com>
 <20260824094101.32d4e42b@phoenix.local>
In-Reply-To: <20260824094101.32d4e42b@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-08-25T04:07:06.0000000Z;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public; MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12262:EE_|VE1PR04MB7229:EE_
x-ms-office365-filtering-correlation-id: 794aeb3a-8ab9-4753-2549-08df025ed50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|19092799006|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: AawFONGIicIMK6keoKqSsOvoa6HwPggf/rvl3Z+6ZCb2VhHVBR+/CPp7Oy7V3h6kX9JRcEXzVNkAFSBpM7F8okaXmREFaYyedTuTJeKCRz9k1SQX1vorDNT8Z903P7zTEG9twMSMTF7GefXgSSN6qmYbXLZ/WqT9+D1aPOI0Ku1YpuzwSANzCsKvhymj405ADzMOnecCpxFMOxC0adEY6kIwrtoLMGSV4NOo9+yG66CC/t/8C/4sRfAR2+/n4YS/VUwVNctf9/O6AVt4fQtrwOQMlJBmkNBWJe8XSp4RvacFGn1Zj9L9VAU/GXcReHAhaGKixaS+EQINHCeAKEVkI6A9/Db5WB0j+7n1dTARanYCpH4Z8MEOhq20kXP65j03h/BE4YUcABSSvjpDSyYIckMA8wlJyb9sUHVWDIl/vQWAp7BzFCrNH0+DDCygijVAOiVfRPQn9FgMiwgW1qC5TmxwpICkfAQeFEs7k8y7YIUiRH2MfffojR2Iv/8YbQ874yAGW6ZnFwv5+PDLsvs9kuy0id3AXPPFeF3wt/EoB1fz7lmnUnqgVq74WEgLvZcJ0bOsJnZDgrkwdEb4l59wfpjEMadb3bxepWiXWhMqb3BNa7DCRuvRSjRDwu/iyMPWjx6tYyShNjBF9h2FvJHFcKtCcTD1Is8YfOe00XgP2hiZr/vADrAOXdGQp5mdSwRgSvbHDFpIiWQh2eWSb1pjjAr4CEisGRRfJvVdRykhm9o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB12262.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(19092799006)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFlBQ242eDZWMm9oSkQ4MlZZMHN5TEZKU0pjSUlPR1JKM1prWUJ4YnNrS1o3?=
 =?utf-8?B?UkNVWUhQMzdlRkJqYzczWks4VmQ4dUdHQ0pZV25ha0F5c2tNK0kwN2c5TWRz?=
 =?utf-8?B?b05ESUJXbm0wd3VOWEY5bWtIaVBNaGx4TnhqeUtOSVJUVU1RU1JZWmdpbjY2?=
 =?utf-8?B?djR6cEU5Ty95WHVuMExBbE1wR04rVXM0NzVOZlQ5d01wcnVtQmQxS0d1Zjdl?=
 =?utf-8?B?S0VmanV6ODFJWktYcTZnc0x5ZTdTbUJTM0pwOWk1aUR5ajdFUkFLMmZiQUtR?=
 =?utf-8?B?N3pSZG1vSGFRYkpPMTdHUVZFdktNSWw3dnczN2lzOTVYcjBuL3JvcytPbmxp?=
 =?utf-8?B?TU9vR0UvS05OZ2lxRGZLK2FxRTBDZ3NKNFplNDc4d3pxeHBkKzJWL3RBdGZh?=
 =?utf-8?B?OG9PY0dIMWgrdWx2UnhNN2tQRzEvOTFNQkhKbWV3VjBXYUhkVHkwREt6RHB6?=
 =?utf-8?B?UnA1Tnh3STlHUzNxQURkOXhZOFJvQ2YvMHVncll2SC9zVytjV21EdGtWeSs0?=
 =?utf-8?B?Sy9uSzM4dkQvcCtNWkdqTG1NRzhwem5PMHVueG5nOXpuSlFoVHFzTWpoVTZh?=
 =?utf-8?B?S01WS3JFU2xxa3U3TmR0dmNnVVh6NWVyTVJhRndScnhIWTVVa1ZzTHBxbERa?=
 =?utf-8?B?S3ZNUkliRFBDc3AwUlFFdDBPTHRNYjZPTVZobWJZV1dvNnExWXBWcDZ6Tnlx?=
 =?utf-8?B?MU0wYy9sWUovdDRpditYdDloeFpOZjB6aW03Q1pDRk4zdlF0S3dmT2RkUnUr?=
 =?utf-8?B?Q3FycGNDQ28vWTl5SSsxMjdGS1MxNmtaTWIvVkhyVkwvVGxDU2w1bTMvSTZo?=
 =?utf-8?B?dlA3Nzh1d2psRXVzSk9rVm1KbXAxamEvY2lzYVN4dmE1ZlRiak96dXdoOStz?=
 =?utf-8?B?OWFrNDhWUnV5MEtldmF2YjhyWFh1ODVncVhoUE92Y0ZJWnlrRjRQMFh6aGZy?=
 =?utf-8?B?MSt6eDN4YVc4bGIvQVJiT01pSTY2MzN5VGJKZjZWOVZDQXh5TE1WMmNxR0to?=
 =?utf-8?B?cmYxakdwMU9jaDRsRklHbk5rVjNxRjhVRHA0NmF3M1pSbG9GRDgyOVc4dldl?=
 =?utf-8?B?SSttU3RZZWU0NjBSMjIrenl2eTNXaDNGNi80MGt4VS9qQi8wVlNYN0dCc2Ja?=
 =?utf-8?B?UDdOTE5mYkpiT2l1TkhhSXc1SmVRYWxoSy8zQTVCMDBWcnhxeTN4OE1CbW9r?=
 =?utf-8?B?b3FCRDhOanNSclNlUTFHMENjMlVZZ3dqZnZrNVA1anB4NExCa0ZVYVBoVG9S?=
 =?utf-8?B?K3NjMDlFRVROT2p6TGZtbEdPQ0xlVFoxTmo4WGpZWUVRa3lpMWhrcThSSEpI?=
 =?utf-8?B?K01vTHZuaUg0bmE3U3hYQ2taRHNpQ282RE1RS1RoM0ZiYlZaaFZ1SHBBdlZU?=
 =?utf-8?B?QzV4R3ZKZTJ2cHhYcDArY0VTVXBXWUg4RjJOVU1VWFpON045UjhIRWFlQjhv?=
 =?utf-8?B?dUhTS1MyUlhHVldKTGtwWWgwaytMYnB0UkZuTzdpcTYrYVNpejc3TjdVcUd0?=
 =?utf-8?B?S3FDWFI0cXpJWkcwVjV4Q0lKZ0NFcCtGREdYYm5idG5Dcit4MHYra01wdzY5?=
 =?utf-8?B?d25rd1ptcm53dlFQM3ZJWGFRODJ5MlB0cmRmbE1JUjgycXI5WXNFWG9taUc0?=
 =?utf-8?B?Z2duT2hGdEIrbzZBT3IyMHA0dzZackgxUTQvZUpDelcxQ2lzWUdRa2JURkkw?=
 =?utf-8?B?ZlRBRGo2M0JjcUNDMHJMWFNCMDZUSnV0Y3JUTDZpOGE2czJOMGlGY25mV2ZW?=
 =?utf-8?B?K2VjT092ZTZyRUl0Wmw1RDBrcWVZQkZCZndTMDdVRVNKbGZBQzlEakRSQ0Jx?=
 =?utf-8?B?dldnQmRXYzJrRlVMZnZGUXBUQTg2SE8zdHRhS2pIK0E4cjBHSUR5REQxMHBW?=
 =?utf-8?B?UUVsMVcycTFvYzRqakZiNU91NU5NTkN1L040NGx6VzdXR1hYU2pQOUtCR0FX?=
 =?utf-8?B?TVZoUGVXUnFSTGxPU2hLTzBwZmZjRStiSHFtd3AxS0ViZUJqQXlyL00wMHM0?=
 =?utf-8?B?WjNsL29jUnd6Z3R1ckN0aG5rWlNkMy9UTWJlZ25LRVUzNXo0TysrWTZybXdN?=
 =?utf-8?B?WExKZmFheVh0ZGh6bGJBL1hIdUpGTnE2MENqMnN4dnVvcWV2SG1HSWdyMGZ5?=
 =?utf-8?B?aVRXTVEwd3pBV0RRckl4U2krc1o5SGJ3MUtrWk43SW9ETnVza1BIN2NML3VY?=
 =?utf-8?B?OXFtMXhSVU5nWG5LYm0xRVVoU2ZrWE1sdzh6QUhPYzUyQ2RGbGZGbUJJam8x?=
 =?utf-8?B?anl6QkRiVitpT3JIL2pHNnFkMkxuSytERjZsaUkrRnFFaU96S3ZkWmgwcXo0?=
 =?utf-8?Q?Ee4gj6KZriEy9nZM76?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12262.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794aeb3a-8ab9-4753-2549-08df025ed50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:10:43.4555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNYUvN/TcdYT4ABL6NYaHZKd2ZoRfONdUw3gOGSYe+GTqtVS5J2uRi2Z2T0Ih1kB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229
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

SGkNCg0KDQpOWFAgUHVibGljDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBBdWd1c3QgMjQsIDIwMjYgMTA6MTEgUE0NCj4gVG86IEdhZ2FuZGVlcCBTaW5naCA8
Ry5TaW5naEBueHAuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBIZW1hbnQgQWdyYXdhbCA8aGVt
YW50LmFncmF3YWxAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMDAvMTVdIGV0
L2VuZXRjOiBhZGQgbmV3IGZlYXR1cmVzIGZvciBFTkVUQzQgb24gaS5NWDk1DQo+DQo+IE9uIE1v
biwgMjQgQXVnIDIwMjYgMDc6NTI6NTcgKzAwMDANCj4gR2FnYW5kZWVwIFNpbmdoIDxHLlNpbmdo
QG54cC5jb20+IHdyb3RlOg0KPg0KPiA+IEhpLA0KPiA+DQo+ID4NCj4gPiBOWFAgQ29uZmlkZW50
aWFsDQo+DQo+IFBsZWFzZSBmaXggeW91ciAgbWFpbCByZXNwb25zZSBzeXN0ZW0uIFRoaXMgYSBw
dWJsaWMgbGlzdCBzbyBhbnkgcmVzcG9uc2UgbGlrZSBpcw0KPiB2aW9sYXRpbmcgdGhhdCBzdGF0
ZW1lbnQuDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQsIHRoZSBkZWZhdWx0cyBhcmUg
Y29uZmlkZW50aWFsLiBJJ2xsIHRha2UgY2FyZSBvZiB0aGF0IGluIGZ1dHVyZSBlbWFpbHMuDQo=
