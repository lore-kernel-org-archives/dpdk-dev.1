Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86731075284
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:25:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4FFB4025D;
	Thu, 19 Mar 2026 10:25:29 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013057.outbound.protection.outlook.com [52.101.72.57])
 by mails.dpdk.org (Postfix) with ESMTP id 3DE334013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 10:25:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxVeVScbJaYN6Akz0mi1HAjeX4CPGE/n+2tG/R9j0BIeSdMZ5FwpxUryEeWnDtnlkQeXi+Em6dRUK3aZl0tnn/WigtGGvMW8fyv9T6ZacZJ/0AYz2AooY8FqsgFRsVYdhVehL2BqZzbP56A2EFeP9CN8oUVdkcG/UqL83ceqJb8FO0PtVXb98tzCNHjUxmMxyT3Ygue6d5r0F0sHHHEdwmtOQn7h9bt9Ua/I9G47mvwAV7oHcaF2S/L8KmYi7bV91Ie/rGxl2Y5k7wJ6HdTFYTRhPdmW/5e1jUhfDlnSJ45GkGSy2AlqNhsCmCh00znEMpBwM1lRQqCk+uuc30Qd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqnN7FPWokdFsurF7tWHsE91KuRc91Im31WgB0VHDAQ=;
 b=ItAruZ7Jj0ScvepAME61Ax5haKSYkAaHE4dc83ghlOgeTdKPh6jTclgZfCkbwUUglEFTpsq+7FPYwf6c7QAA5qCgnrflHLDxX+UV5tGjqBeIeH5CYc70IBeN32SxR67GsJYK8oUSIEcI+0DxUboac6z01tiNAgrNEYtfvfvPQlLXt9+ZUhGqgxsxpXkpa4dM31xqsnLMkO/W5oSUNIRmqBguERxQfDvl0Iuhp7N80cy7qEXMl+8jNqyCGQJTtXFMUtfCT28LN06F+Ap1w1KbdXm6RfBtCeIXu4u9RvwNnl+VjD+sIoEEQQqrAy+P4UlXjm4fyrv+oH3GVARhdZp7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqnN7FPWokdFsurF7tWHsE91KuRc91Im31WgB0VHDAQ=;
 b=e4LoWV5NcmIYdVsJ1sTa5tVM8osNzi3zCaV+QIfo2JzMdV4YlNOnjaKnH/pmWuCL6wINQH/3WbGwoFqp2LY+6tlwMEQEaEym4wz8m02kRY5LdyW7DTuL7SktYAtPgkgo5bRM4EEb/HsScyvxDB6EFnXLsBweXr7wuc0Tk4IQBYH1aUBMciekQ+eUtBc2aPxhfP1tpbmAgk8Yf36kw10C5MEr3E3n2ZJ5RUanCyRH1EL+AuDZRMQSss9lnKtpG2h7CDx7Z5DjbgIqKeG2wZTQeTk3mbTasyur1e1c3LDFk41UvaG/69lp5CIJVd4FSxSefrJIk0+dQFLLkbyKaVWzqg==
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com (2603:10a6:102:f6::14)
 by GV2PR07MB11151.eurprd07.prod.outlook.com (2603:10a6:150:2a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:25:25 +0000
Received: from PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8]) by PA4PR07MB7280.eurprd07.prod.outlook.com
 ([fe80::e42d:d4f5:1b1a:68e8%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:25:25 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "xavier.guillaume@ovhcloud.com"
 <xavier.guillaume@ovhcloud.com>
Subject: RE: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Thread-Topic: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Thread-Index: AQHcsAgUsrkjy9cDjkaeygeCApDKo7WnzRqAgABkBsCACStFgIAER5Ew
Date: Thu, 19 Mar 2026 09:25:25 +0000
Message-ID: <PA4PR07MB72804E8438761B71B90BC49F904FA@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
 <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
 <20260310070251.17c934ea@phoenix.local>
 <PA4PR07MB7280BF2BBE65E375F5A95FBE9046A@PA4PR07MB7280.eurprd07.prod.outlook.com>
 <20260316090203.0e138d6f@phoenix.local>
In-Reply-To: <20260316090203.0e138d6f@phoenix.local>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7280:EE_|GV2PR07MB11151:EE_
x-ms-office365-filtering-correlation-id: 67cd38b9-ea60-48c6-bee3-08de85997421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: zeFwVYC+hvWhQP3Rx8Fk6CB5JeK5rphY3CMYcPNdMXJDxiJagTcx8RQgWmfOI6d/ZBEtUlmF5SStd7RZj/hcGzMuflFxTN6DtY9Q2KOoOcu0TjGqMLJIvk/au7X1r9OG4P2fDI+NhuffnEMGkrtNzKlSkIPOxdZsRT0Hl9oS84hVlj7xG8ByUKWA7P0uyRlh5pEcQ/+GX+H0gDZ5rYd8RgIK/3A+hrP2lyUAtPJngnlKUXKzy2sQGrYt3YY9Exzfw9JpHAZDWhaTwSIJ5T4QzeZMi3CW/LWqGMDDb3NnXC4ie9Jk2YEDUeS73ZMQnYatuewVMU29e+zxcSZpXK4ziGKGWzkKp4ATata7n92OX1yrN0xUBr5V5qcjNnREr+Zr+jH0fRbJh+Ymz0HnWSNvk+FcUhiuadYgdYwoCK9bw5vyvYTifiq0pW8RZUftFBE7Xy41+tjzcaHSECiGGcgYLwr1xkRxwPc6frP+YasKnB3V752ouhsrTWzZxte/A68VRZn4ZAm5PtcJRuzcuviakeZxtgBc2A/BhTftHwsZCxIHjGitApaykvr9ntHB6TXI193BWbXKamF3oA8KnQRSdiycumMPqu7ryFwL6zo8VY+wXlSpQaWgnj0dFqk3tzjG+ZgYDI7jzYCtSuKU2muTAqbYLP4x7JHKC+iahNPjt6ZmtBrGuE3jXPfvEjUFa684ruyKEWNHRSxPKcVeL9osuf/FeNzDEOHkFZMFmY4EYsVo1g5qK8hQPDrg8A+mTNEzRbHTksZAYns8M/XIFjSW/vPvp3IuRbKn+KqctGS4XTY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7280.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDYxaGFGWkZJZllQdW1LeGRtSWhXRTNoY2grWlp0ZFBEd3hSTFRRa1lZdzFh?=
 =?utf-8?B?Z3NPMnNKeVYyVHhuM0hMaUZ1cW9JRitycmNyb3dtVU5adnd1V0NmRTVHQmFz?=
 =?utf-8?B?a2R6TnArUkJsOGY3S1V3MklobDZUa2N6Ky9ERlNUZnFyekJBZzJxM054Umtj?=
 =?utf-8?B?c1Bmb2FZSnB3c254bWppV29pWlk2SjNYSEF2b0NQZjhtYWFjMWNKamNIR1RI?=
 =?utf-8?B?Mm9oYmtUaVV1Qlh4aUNIRGppMlE4SUs2VjRLblF2eWFMeWlubEdpdkpZdVha?=
 =?utf-8?B?UGZKYzBCcXltd0JFZjlkMVpQeHJXQUdZelk2THhRcERENDI5WW16U1VQQVlv?=
 =?utf-8?B?Y0VxcXFCMzRZRk9wRDkzeVFMNm9YdndRQU1uRy94MFptb3JyS1AyQU1TUm85?=
 =?utf-8?B?dEhzdEhGb0gvM3lJb3BwVW9SZzRpTGtBaWdqZklURDhuMHdheTBHZ2IwRFVt?=
 =?utf-8?B?cVRESWRQMWlTTTNJM0NPVFhpeWlENVFqZEMyYndpRUptSzFoYkNaMWtqdmhH?=
 =?utf-8?B?cVZ6TC9MaTI2V3RmWTVtTjgxTHQreGdwZlQwMTZscFZYSDE0QU9Gb2g3Mkw4?=
 =?utf-8?B?QmxORXRyWXRTNnBKWFQ2OS9uaUY4MlVmQzhHUmVoT1plUGErZ05jLytPVXlo?=
 =?utf-8?B?cm1NVGJEYXV4U2oxTUFYa3lMbXpCd2hoWkhkbmtnMkZLZy9KNzJJV0JyNG1Q?=
 =?utf-8?B?bGF5RDBqcWp5anZqWlQ0MVRwbGVJM05KK0ZFTVNVczhTbzlFRzNzYmFTdkNN?=
 =?utf-8?B?ekJkS0hQaVdrTEM5OEJsZ3NTYjZUdXpOak5xdWYxa2ZXaHdqWnN0Qi9XYWVj?=
 =?utf-8?B?YldGTjg0N3hBY2dUbVZCUkZPc1B2Z2hFS0VTSzBiUzdha09jcElDMk1VT00w?=
 =?utf-8?B?NU91VnNZVlE3REpyNE9pdjVKQ29ybzJrZis0dWRqWVZHMno4UlhiVGt6aU04?=
 =?utf-8?B?ajFPMnQ0M25Qam1KTWlKQkpCdjJoR2k0N2dZYzh5MDRHNEVzMGg2alVTTm1i?=
 =?utf-8?B?ekpia29GWmhlbXlTQWhxSlk2bkg4QmRlVDFlNERPVHQva0xJOGhmRGpuMmRQ?=
 =?utf-8?B?RTFKNDZRaEhmaHZ2dUNxRnBucHlLd2RQei8yUi9XWGFEYkk2d3ZHN3dxVjZk?=
 =?utf-8?B?NkNXb1hRaUNESkV3cWt0SXBxbVhkK2wzVW4zNWVYMnFtYzJWTVVENHpwQkkr?=
 =?utf-8?B?S1FDZkEzaC93enFMQmtlbDFwMDlkNzhkSEZ6QkppNDJyOFl0Ti9BbWRDTEEr?=
 =?utf-8?B?TTNWRXdxZ0ZtaGZmZjU3dHBMTVBIRXB0ZlJtbG1wMWZROE44Q2xvQlhacVds?=
 =?utf-8?B?TFV0bkZlWDBoUWF3SVVlWlE0TnJETEovTmtWUFV0Ymt3U3hBc1V3aHVUWmxU?=
 =?utf-8?B?S1k3S2l4K2k5MW5XWjdIUlF1dDllN3ZPdXAyT1RUeEZXYloyWXRVeHIvd0lk?=
 =?utf-8?B?aDFuRHJvSnpNanN2MkN1K2FMOGIwZ05VaTlJZXRMSTlaelAya21KeVpSRkc2?=
 =?utf-8?B?UFhFUm9uUzdySTNWWU1wak9rNkQ1L25vT004aVU2QldaemtDd2JIRzI3UEc1?=
 =?utf-8?B?QjNxUTNuM2xwbkNEQUsxODkwTmJWMTVmd2RzN0xPSGRNQWkxN3Z0MWhKbEcy?=
 =?utf-8?B?NktPYWhvdmNYZHE1d0VlY0ZaUjNWSDJuOTBhWG5hL0lOMkZ2cmQzWngwTFVZ?=
 =?utf-8?B?RGNJaWpZVHk4SThoMzZNem5jRjlDcno0UHhmN0MrQlJZNyt1Mzd5ek5ZRzdQ?=
 =?utf-8?B?bjlkazNVNk00aDZRTjVZK05VQVJLU1UzMldBaXY5aVJGQVpXejRmZXIzblJT?=
 =?utf-8?B?b0N6SGJQMnFXM09XbWFUY0lWZ3NwMlBpQTZ5MlNZV3p3RnUrYVBGK3NXekJz?=
 =?utf-8?B?RXJsYmd1VlU2dmN3L2hMT2pseG82T1R3UjhxalBRTFg0Z3RrMDVBZVVWTDhB?=
 =?utf-8?B?NkF2NE5UcHZud2hnMFMvbkFXL3E4OXNhM0pYMmhOR2RmdlpvMVREejVOeEtq?=
 =?utf-8?B?cHlkRjd6dm5ublhSWU5BbUpNeHN4WGJvUmRoVGlFM1VPanNOYlVHdFoyUjJt?=
 =?utf-8?B?MUpSUVk5MTdIUzhUd3JqbmVoeDIrY21XZ3h2ZWh3NWk4dkdXL2FIMnNjNVdF?=
 =?utf-8?B?MTI5SUw3Nm1DdGtwTUdhaE9ILzlrRnhuQW1mK2NkV1BZMmJ6elV3RXpFckJv?=
 =?utf-8?B?YXRlSGZ2TjBGMHZZckxhc3ZCWFVGSlV0bnNVdUVHM0tJc2svdFlGRDJPZHYx?=
 =?utf-8?B?UW5Vbm1jUDcwWjFTbzNVR0xIaUNrTTJUNkJObFBXekUrQzAxVC9rRXlIY3Jk?=
 =?utf-8?B?d3ZYOFBtVEovY3d6aklLWm4vaTZVYU1Hc3FEaE16M3ZSVlFZa1AwRUN6OGhr?=
 =?utf-8?Q?uFdTtMN0D7qoIjog=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7280.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd38b9-ea60-48c6-bee3-08de85997421
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:25:25.7451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FTWYdGR/grBLKxgtdv4ujIZS0tta5WV/z2SrHy2e5dIusJIf+XZO880of+UFaKHunkZqoA8hdKYKVbD+yr8je5UTft2mihqo6gE5NuX78k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11151
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBNb25kYXksIDE2IE1hcmNo
IDIwMjYgMTc6MDINCj4gVG86IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBl
cmljc3Nvbi5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IHhhdmllci5ndWlsbGF1bWVAb3ZoY2xv
dWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG5ldC9hZl9wYWNrZXQ6IGFkZCBtdWx0
aS1zZWdtZW50IG1idWYgc3VwcG9ydCBmb3INCj4ganVtYm8gZnJhbWVzDQo+IA0KPiBPbiBUdWUs
IDEwIE1hciAyMDI2IDIwOjAyOjQ5ICswMDAwDQo+IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0u
eWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3
b3JrcGx1bWJlci5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCAxMCBNYXJjaCAyMDI2IDE1OjAz
DQo+ID4gPiBUbzogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNzc29u
LmNvbT4NCj4gPiA+IENjOiBkZXZAZHBkay5vcmc7IHhhdmllci5ndWlsbGF1bWVAb3ZoY2xvdWQu
Y29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBuZXQvYWZfcGFja2V0OiBhZGQgbXVs
dGktc2VnbWVudCBtYnVmDQo+ID4gPiBzdXBwb3J0IGZvciBqdW1ibyBmcmFtZXMNCj4gPiA+DQo+
ID4gPiBPbiBNb24sIDkgTWFyIDIwMjYgMjI6MDI6MTAgKzAxMDANCj4gPiA+IFNyaXJhbSBZYWdu
YXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+ID4gRW5hYmxlIGp1bWJvIGZyYW1lIHJlY2VwdGlvbiB3aXRoIGRlZmF1bHQgbWJ1ZiBkYXRh
IHJvb20gc2l6ZSBieQ0KPiA+ID4gPiBjaGFpbmluZyBtdWx0aXBsZSBtYnVmcyB3aGVuIHBhY2tl
dCBleGNlZWRzIHNpbmdsZSBtYnVmIHRhaWxyb29tLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgUlgg
cGF0aCBub3c6DQo+ID4gPiA+IC0gQ29waWVzIGZpcnN0IHNlZ21lbnQgdXAgdG8gbWJ1ZiB0YWls
cm9vbQ0KPiA+ID4gPiAtIEFsbG9jYXRlcyBhbmQgY2hhaW5zIGFkZGl0aW9uYWwgc2VnbWVudHMg
Zm9yIHJlbWFpbmluZyBkYXRhDQo+ID4gPiA+IC0gUHJvcGVybHkgbWFpbnRhaW5zIG5iX3NlZ3Ms
IG5leHQgcG9pbnRlcnMsIGFuZCBwa3RfbGVuDQo+ID4gPiA+IC0gU2lsZW50bHkgZHJvcHMgcGFj
a2V0cyBvbiBtYnVmIGFsbG9jYXRpb24gZmFpbHVyZQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGFs
bG93cyByZWNlaXZpbmcgOUtCIGp1bWJvIGZyYW1lcyB1c2luZyBzdGFuZGFyZCAyS0IgbWJ1ZnMs
DQo+ID4gPiA+IGNoYWluaW5nIH41IHNlZ21lbnRzIHBlciBqdW1ibyBwYWNrZXQuIE5vIG5lZWQg
Zm9yIGN1c3RvbSBtYnVmDQo+ID4gPiA+IHBvb2xzIHdpdGggbGFyZ2UgZGF0YSByb29tLg0KPiA+
ID4gPg0KPiA+ID4gPiBBZHZlcnRpc2VzIFJURV9FVEhfUlhfT0ZGTE9BRF9TQ0FUVEVSIGNhcGFi
aWxpdHkuDQo+ID4gPiA+DQo+ID4gPiA+IERlcGVuZHMtb246IHNlcmllcy0zNDU2NyAoIm5ldC9h
Zl9wYWNrZXQ6IGZpeCBNVFUgaGFuZGxpbmcgYW5kIGFkZA0KPiA+ID4gPiBqdW1ibyBmcmFtZSBz
dXBwb3J0IikNCj4gPiA+ID4NCj4gPiA+ID4gTm90ZTogSW1wbGVtZW50YXRpb24gZ2VuZXJhdGVk
IHdpdGggQUkgYXNzaXN0YW5jZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3Jp
cmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNzc29uLmNvbT4NCj4gPiA+DQo+
ID4gPiBVc2luZyBBSSBwYXRjaCByZXZpZXcgZmluZHMgc2V2ZXJhbCBpc3N1ZXMuDQo+ID4NCj4g
PiBUaGFua3MgZm9yIHRoZSByZXZpZXcsIEkgd2lsbCBmaXggdGhlbSBpbiB2My4NCj4gPiBQZXJo
YXBzLCBJIHdpbGwgd2FpdCBmb3IgWGF2aWVyJ3MgY2hhbmdlcyB0byBiZSBpbiBtYWluIGJlZm9y
ZSBwb3N0aW5nIHRoZQ0KPiBuZXh0IHZlcnNpb24uDQo+ID4NCj4gDQo+IFlvdSBjYW4gdXNlIG5l
eHQtbmV0IGZvci1tYWluIGFzIGJhc2VsaW5lLiBCdXQgd2FpdCB1bnRpbCB0aGF0IGdldHMgbWVy
Z2VkDQo+IGJlZm9yZSByZXN1Ym1pdHRpbmcuDQoNClRoYW5rcywgSSBhbHJlYWR5IHNlbnQgdjMv
djQgYmVmb3JlIGluIGEgaHVycnkuDQpBbnlob3csIEkgaGF2ZSBub3cgc2VudCB2NSB3aGljaCBp
cyByZWJhc2VkIG9uIFhhdmllcidzIGNoYW5nZXMgaW4gbWFpbjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvZHBkay1kZXYvMjAyNjAzMTgwOTQ3MjYuMTI4NDQ1NC0xLXNyaXJhbS55YWduYXJhbWFu
QGVyaWNzc29uLmNvbS9ULyN1DQoNCg==
