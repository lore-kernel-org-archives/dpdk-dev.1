Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC010CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 05:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCE94060C;
	Thu,  7 May 2026 07:42:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
 by mails.dpdk.org (Postfix) with ESMTP id DB71040265;
 Thu,  7 May 2026 07:42:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJKtp5AXjEII1qlaEBlp075C6vL1ozbig1pfq2+h+3gKZ7bEbf4p8R5Xs4o2QE8o4SqzyNkOdnHFaZWEpD0EkfiH7krg4AdPHcO0yAyY6nD4U+vEhRe6Ai3hXJNOUROVLMDn4e1ceqnlj3I/UFlP2O+8g7UJ4O+6TYdpNcynvFQg1Y9QVuKQlx529h6/ZhKA6BHYx4HyVLZ3NZQwz2RU3e4cdHkYHwldRiPwS0nKQsX/OaB8CbR3m7pcffb4HckCoHX/GfsbEP0woKOPpuKhs80Sv0TuwmiOOYVFIDU2dXJWlN7kTUh0hRy+VsK/krQ+MkZzEJgE/tr/+g89SXyNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QArzXmBiylmW5rFvskYNCOTfCjQvuPN2eYvbolxL7Io=;
 b=Acaxs5vEmkcMDhmGJ7eENQwxJsH7QxLN7vtuQVaKsOe24GPT73d46Nc40sSnfnkmAEKo6JVnACk6hDPCTiZcKuqsFls5Vh+Sr6BvqcnG2u9iOTqZ4YiH8di9J8ycmVI6Ri3TCFrwGOcbI9pQom3EvT+wvTr9x5nqbuR0wM3OY0u5u+L9Yxat7WDf/yMU9CAvgqhki6IUE6wzopPO5u82OwR0vkGzRl24ZkTLX1hRLD5rwfVZ4HrC0w/mcOWO58XIxIQIBK+yZrIq7FcTl8GhYRdhaquzXwd+D+qysXGWzByCJFw1/GjkPOe7rPiEWgi91AU/qST6mutFicuxf6uEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QArzXmBiylmW5rFvskYNCOTfCjQvuPN2eYvbolxL7Io=;
 b=JsovnSmFCfTmSd/VCIS4yNYLBO1qXwDmHxCB/qveZhQ0/d/wE1/EDW9NYz4qxM0nWbst78xHBZDD4ejVFZ212/jAh5tnN8CN6kQ7FrlfMjVJQPHpxNiFrWEYLCgtppryrJtmFtfgfCA4HGxinAdyuv1z3Qy0qUHNFwp8ZzoAC7xBcLFa+GRVhQxBmsauOSSKPYzR3L8eCnk/SwEwZ22FO8BYtG+Xx1kwhZt+Czq9ZKoRUr4G45bo2MRkt3a+1s8t1MS2nEzR5JF9Inv0jFwuwsDfW6xH0bCeWt6dQBxKk2uWTkuaqf2hSIXGxdiAlWBRTxcv2D+aznDTNNOHGpz6Vg==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AM9PR04MB8875.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 05:42:53 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 05:42:53 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev <dev@dpdk.org>
CC: dpdk-techboard <techboard@dpdk.org>
Subject: DPDK Tech Board meeting minutes 01-April-2026
Thread-Topic: DPDK Tech Board meeting minutes 01-April-2026
Thread-Index: AQHc3eRZBZTRK/h4b0KpJ4jy9wcULA==
Date: Thu, 7 May 2026 05:42:53 +0000
Message-ID: <GV1PR04MB10750969FDC540E27C4C99C21893C2@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <GV1PR04MB1075079DC70ECD65A4C3E900E89312@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB1075079DC70ECD65A4C3E900E89312@GV1PR04MB10750.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AM9PR04MB8875:EE_
x-ms-office365-filtering-correlation-id: 4efe6f17-c64d-4c16-7b64-08deabfb7b97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 971qeCdr0aDVnLnSfY3BSeUYEgQ4qNJGoDuG62mubMzgjs1i+FTJ8W521jbXC4kOpRE4ZKd7Lh6rLFt789nWylCCO/UkjYbI0zcG9F0/ts1s5BRNsZWXHO4BtYzoqYhPdN7+RzprHdIRV33m6jxVRdiwW4f2i0Z3QlzivqAmAuDWO5TpblYpJiKR8hTZpdJyutaUonQPqIb44Dj8rAkH3oAcZtBrr+kh4+rc9EQGwcxexS/yxYdL/ZpnndEVFb4LTfpovlMXWNGfV7UKatvpBSG9oM+IUQtAquE3yofl3aJRc5nqIC2t7haYBCzXxDlwedjOQRJ7tBQ/DCt96MZ3iQJsj011v2Qvzs7EsRkbK+VxF4koqkLswhrT4vtbLCJBAyKyI03i8YtW2OvE1HGJXbpT56HohPDLO1SqgEyTX3OtRawHTdOmB8YNSEH2godFqDLHMpDBuAd6Wyvh/otofXRg7veFo3Q8Oodp4MVaYeK12pu8RS/t8jdvW9twtEM8cyYfi6rFg9WZOAgalYv+BfRrZ/PPSXqBK5ce8yz49Z0Ds9OXvZQiVslQ595k0XA6tnDrxojGGoHzzR/i7EMBRzNrQPKJhqEUukp5uZ0J1kyuki/jhjmqoXyjezV/GT3Nq7mTiie8PTwP6WO6HpZDqinTGLXKfPI92HjLkQ04ZyFk2bTOlQRgR1TfjtsJlgJEY4pNA3CV/T4yQo+xRRj43w1knmP0JRRoLEOmohI3xRD8IyatuJ4TPT4y7/03lWSQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2hWOXV4NWg5MGM1c1IvMUlPN0Fwc3dXNnZiZzRIakxUMDRBREN6Ylk2VUox?=
 =?utf-8?B?Qk5haUV3TTd0N1lEbmRVdWlLODZUMzRxaG9EMHI0dUZIcTNZSDBETVVWS0RG?=
 =?utf-8?B?UTV1Tk5xek1LVDJ1ZUlUNng4WUh1Tml0L0VZWFRhOWt1RTdXYktLQ3YvemI4?=
 =?utf-8?B?N3c3Q0RpU2Nna3o3UXIvY2h6blZFNjRnRkFZSEdtbHM1ejZ6bmV2VUZwT0p0?=
 =?utf-8?B?SFErSFA4bmx3TFFLTlg3Szh0YUg3d0ZhUlVxK1RveDhmc3cyeXBPUmpFTjI4?=
 =?utf-8?B?dHFzMXJkR3hRbFptaHJVc1k3VlpEOGlibkd4NUJQRFo0cTB2bkpwZ0lXUmVQ?=
 =?utf-8?B?Z2xyYlk0Y3QrWTJPLzJkdlh1czE4K2dacUNzYlJyZUFuZjFmbHNCMFVqdkMw?=
 =?utf-8?B?K3lqVGdRVE05RFd4ZndabnU1NmQzMnVpUXRnTFFsT3JRN1lQVXdkUGRKWTJG?=
 =?utf-8?B?UFdac0twaUJkbHJqNW5uZWQ5YXVLc0lMNE50eUFBa0hWeE9RcHJwQXVpSXgw?=
 =?utf-8?B?eDU5T20xUmFYcHd3MDJxSGN0Yi95aFhtbzYxUUJJTjdpVmVzTXIrdm5rd2hE?=
 =?utf-8?B?cm9kRnc0NHNRcnNyNFZ2NnhVTWtFeWIzVm1VZkh5V2dMSlExSERPb3preDNm?=
 =?utf-8?B?UzVTbWc4QXVtNFJ1bGJtS3pMNWVYU2JYQzV3RmZiUXV3NnpuNk80aVVONURy?=
 =?utf-8?B?YzdwNUNUT0xwaVl5VlZFWnNNaUdtck1MZ0RNRDFhN3lXTldUMnFLQndjdG10?=
 =?utf-8?B?bk9HQlFBVGRVRFgyVHl5TGYrTHQrUEs0U3hGbjZkMXJvbGVrYmowaFhUVFJH?=
 =?utf-8?B?bzJLWFhCaTEvOVc0SzVDdTZPVmh3L0xjRkUydU9XSWw3aXF4Njhic1VHemZK?=
 =?utf-8?B?OUMyQUR0T0N1N2pCYmQwaEF2TTgwV0VBRlhzSzM1SXpDZDdWaGhoVnVTZTRv?=
 =?utf-8?B?UTlpSE0vQ1d3N1dQdldiRUhVaVBjcEZiL1N6Y3M3aGV6dFRrdGtlMUhsdElL?=
 =?utf-8?B?MDhYTDFzYVZMUXlaSHRSbFJ1NjJEaDFrOHNacFBvNVlXN0g2VHluaEVKMjhm?=
 =?utf-8?B?U2JnTFRYbzNsazd1VEFxN25vSktSTmc4TFZTeVZEMnlzUlJqaFlMdFpxbHZ3?=
 =?utf-8?B?M2drWDMyN25VTlFxSzFzck9qRFZmN21HS3FTandCQ3ROTnBGSDJydkFPYzhx?=
 =?utf-8?B?aWhEUkdxakVka1c5VjJWNmlSbU8vZFFDck14QVBJQkRyakhjTkRRNVpiSlJj?=
 =?utf-8?B?bUpNWElla2NRNGdSL1ppOGUzdGFiaU5kcnJlQXF2VkFoL0hUdnVpakR0MFV0?=
 =?utf-8?B?d21kSmw5YmNOUXplT1ZlUWZ6OWt5WndDT1l0UXdOYXBzS0g4cFhtQTF2UnJV?=
 =?utf-8?B?Z3dtdlF1dnhzL3F1dU5Lem9ZR1VxWjJxcFlaZGxxU2pQQU8yWXkvNUxnTmNy?=
 =?utf-8?B?aXBmVXVXL1YvcHRRd2F2Ny9FdlpKSm5EN0hQSlRGeFFkVXpja1Z0Y2xjQlYz?=
 =?utf-8?B?dnBjTnZmZ1NWckowcC9Lb01rQWorT1BNZ255RC9yUEI4ZmJBcFhiUE1oZ01R?=
 =?utf-8?B?QUt4R21ZL0xoM3hjVDU4SjcrcTdPU0lwY3RkeGlzQW1RVkFnLzMrVzN3bk5P?=
 =?utf-8?B?MDNrdWJaWlY4NVFsckE0MmFIcHRiMkJqbUF5QlN2MjRoNUhwcjVmM0g0OWlm?=
 =?utf-8?B?TlNoUDNPWjVWRHVxRTFwMGs2UGdZT0FBSmxVb200SnZWTWo3K2c5OWRMbWYr?=
 =?utf-8?B?S2lScXRQSDdoajhpcEJya0RjK013Q2pHb2JzMVlaSDVuTVlNeDdjc2FFcGln?=
 =?utf-8?B?QmJxYWl1di9LalBiNDJRVTNPKzJ1N2FrWHVoa1hsZ0FEVzVhTkNXcmdNSGgv?=
 =?utf-8?B?bmpCWDNDb3oxTW5Jb2dtd0pzVmRyUHU2b29IQnJpNzYzMCtNL2hUbWxTaVNr?=
 =?utf-8?B?NmxxejhNcmtYS3JDMkkvSjZqMk5yOW14d1lhTGg4Vm5hcEs5a1E1SFhMQ2V1?=
 =?utf-8?B?RkI4MC94Ly80RUJ6Q0pWOUFSRG9SQUtpYVpLb3pyNmduTW5IUnRJZUpWOFVH?=
 =?utf-8?B?RWIyczE3ZmhNeXlHWm44TFF4eWtRY1hwVTAxMm03MTBMdEdpTGJBYmhGeTl3?=
 =?utf-8?B?ZDlsNE45UkhaeUl2UVZHUjg5THloRWV5Y0hZMGNqblZBODNUTEJ0SSsxSlRY?=
 =?utf-8?B?M3V2eHJHazZ1ZXN3Z2owMmVrNUVlNmRmRWEvaE5TRDZYZ1lHdEo0cGszZTl2?=
 =?utf-8?B?amRkenlPTEwxQU9Lb0NsdStUZFNPUjdnQThXd3NmSnFhOW5BdmRZVEh0ZWxN?=
 =?utf-8?B?NjBmZDd1Q3JGQnVpVTdYQ1pVRW4yUG1ZcEZReW1XZnhnaWI0dWNXQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efe6f17-c64d-4c16-7b64-08deabfb7b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 05:42:53.1620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk6NYzKdODjIYA0YX2VvY/6x6GrJy6i/myC8X7uHdwCvy51bSygNaAMs37TD9P+HuKvKmmCT6CZkcBc61KFTcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8875
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

TWVtYmVycyBBdHRlbmRpbmcNCj09PT09PT09PT09PT09PT09DQoNCkFhcm9uIENvbm9sZQ0KQnJ1
Y2UgUmljaGFyZHNvbg0KSGVtYW50IEFncmF3YWwNCkplcmluIEphY29iIEtvbGxhbnVra2FyYW4N
CktldmluIFRyYXlub3INCktvbnN0YW50aW4gQW5hbnlldg0KTW9ydGVuIEJyw7hydXANClN0ZXBo
ZW4gSGVtbWluZ2VyDQpUaG9tYXMgTW9uamFsb24NCg0KTk9URQ0KPT09PQ0KVGhlIFRlY2huaWNh
bCBCb2FyZCBtZWV0aW5ncyB0YWtlIHBsYWNlIGV2ZXJ5IHNlY29uZCBXZWRuZXNkYXkgYXQgMyBw
bSBVVEMuDQpNZWV0aW5ncyBhcmUgcHVibGljLCBhbmQgRFBESyBjb21tdW5pdHkgbWVtYmVycyBh
cmUgd2VsY29tZSB0byBhdHRlbmQuDQpBZ2VuZGEgYW5kIHByZXZpb3VzIG1pbnV0ZXM6DQpodHRw
Oi8vY29yZS5kcGRrLm9yZy90ZWNoYm9hcmQvbWludXRlcw0KVGhlIG5leHQgbWVldGluZyB3aWxs
IGZvbGxvdyB0aGUgcmVndWxhciBzY2hlZHVsZS4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQoxLiBTdW1taXQgYW5kIEdvdmVybmFuY2UgVXBkYXRlcw0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoJLSBOYXRoYW4g
cHJvdmlkZWQgYW4gdXBkYXRlIG9uIHRoZSBEUERLIFN1bW1pdCBpbiBTdG9ja2hvbG0uDQoJLSB+
NTIgaW7igJFwZXJzb24gcmVnaXN0cmF0aW9ucyBzbyBmYXIsIGV4cGVjdGluZyBpbiA3MOKAkzgw
IHJhbmdlLiBTcGVha2VyIGFnZW5kYSBoYXMgYmVlbiBmaW5hbGl6ZWQuDQoJLSBzZXBhcmF0ZSBU
ZWNoIEJvYXJk4oCTb25seSBtZWV0aW5nIHdpbGwgYmUgcmVwbGFjZWQgYnkgYSBqb2ludCBUZWNo
IEJvYXJkIC8gR292ZXJuaW5nIEJvYXJkIG1lZXRpbmcNCg0KMi4gUGVyc29ubmVsIGFuZCBNYWlu
dGVuYW5jZSBVcGRhdGVzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCgktIFBhdHJpY2sgUm9iYiBhbm5vdW5jZWQgaGlzIHJvbGUgdHJhbnNpdGlv
biBhd2F5IGZyb20gVU5ILg0KCS0gTGluY29sbiBMYXZvaWUgd2lsbCB0YWtlIG9uIGxhYiBtYWlu
dGFpbmVyIHJlc3BvbnNpYmlsaXRpZXMgaW4gdGhlIG1lZGl1bSB0ZXJtLg0KCS0gUGF0cmljayBl
eHByZXNzZWQgaW50ZXJlc3QgaW4gY29udGludWluZyBhcyBhIERUUyBtYWludGFpbmVyIGluIGEg
cGVyc29uYWwgY2FwYWNpdHkuIA0KCUFjdGlvbjogUGF0cmljayB0byBzdWJtaXQgYSBtYWludGFp
bmVycyBmaWxlIHVwZGF0ZS4NCg0KMy4gUmVsZWFzZSBTdGF0dXMNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQoJLSBEUERLIDI2LjAzIHdhcyByZWxlYXNlZCBzdWNjZXNzZnVsbHkgd2l0aCBubyBv
dXRzdGFuZGluZyBjYXJyeeKAkW92ZXIgaXRlbXMuDQoJLSBUaGUgMjYuMDcgZGV2ZWxvcG1lbnQg
Y3ljbGUgaXMgc3RhcnRpbmc7IG1haW50YWluZXJzIG5vdGVkIGRlZmVycmVkIHBhdGNoIGJhY2ts
b2dzIHRoYXQgd2lsbCBub3cgYmUgYWRkcmVzc2VkLg0KDQo0LiBBSeKAkUFzc2lzdGVkIENvZGUg
UmV2aWV3DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCgktIFRoZSBib2Fy
ZCBkaXNjdXNzZWQgdGhlIHJlY2VudGx5IGVuYWJsZWQgQUkgY29kZSByZXZpZXdzIGluIENJOg0K
CS0gTWFpbiBjb3N0IGRyaXZlcnMgYXJlIHJldmlldyBmcmVxdWVuY3kgYW5kIHJlcGVhdGVkIHN1
Ym1pc3Npb25zIHJhdGhlciB0aGFuIHBhdGNoIHNpemUgYWxvbmUuDQoJLSBTdGVwaGVuIHRvIGV4
cGxvcmUgZXh0cmFjdGluZyB0b2tlbiBtZXRyaWNzIGZyb20gdGhlIHJldmlldyB0b29saW5nLg0K
CS0gV29ya2Zsb3cgZGlzY3Vzc2lvbnMgY292ZXJlZDogU2VyaWVz4oCRbGV2ZWwgdnMgcGVy4oCR
cGF0Y2ggQUkgcmV2aWV3cy4NCg0K
