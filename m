Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA1CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 09:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FBC4068E;
	Wed,  7 Oct 2026 11:17:08 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011038.outbound.protection.outlook.com
 [40.107.130.38]) by mails.dpdk.org (Postfix) with ESMTP id 2B25740274
 for <dev@dpdk.org>; Wed,  7 Oct 2026 11:17:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1M4i8BkwU+teg+mKJJZ5Ka8n70+oh1x9FQ+6XvlAguiQRPq/7k/z/dQVCh3boyvqgvlBHe3idlNJTeTKHlIfPygHLzGRVJ/NELeVkkYF6bn7sIFLsfJSPAO3uMNXIafbKKk+Oxj1RVKORQuDdRPrgRAXnJvPRt8uzJ1jbg/nrtWGgzwIzxoKb8t7mkpp/21YfauZxU1uqFosUQk0YQXHU3ldCl8PntLKVmnhIthMbpZuvWd3gVgjZR553qoKhFse1ljx8/fN7Yofae81Tg7X02W9YLhNzwKZcr+sEW8Jl8C2YYG2cfdpPleGDPBnJqGqPZ185Ovs4q9Fpbw/YYJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp/2RQDh7vuAiA2fBaDmLu0iKiU4zl0QcNN0GkBuoKI=;
 b=dW4Y+vlt0bvnGmUwKvSt80jpOar/HCfV0Q5WBCcYnNmOCJXZEMdfxPkzqZW5uD97c96oJRYfYaj5VaCWxa7rk6VTxp0OOqvJyLZ6DENsiJCa78phtuOPFwBWo86MhckZK/lLnfKrl2V5C3lT0F+XqH3hJwZex+H18DVgaMEI5/c6/QdZcpnL7xc5ofCQlDbVemHt0x9VIDvzxQgCQBSJmVIc/2CvXS/d+B/Sq/oyljq+AMnRvDub5ihB1NqY+NSCZxnQXJ99Xd43En0IIs6XT9902rszqSM2ACkIhANjzRGJv/l7VswRFWiPxAgroIjiDcDUZi9VAmYWfkOe4pwucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp/2RQDh7vuAiA2fBaDmLu0iKiU4zl0QcNN0GkBuoKI=;
 b=VcoW9ytEJsp/Fa89Ws/CPg9IAPDMm/Te6GuWMXuB7BAuMfXt+bQRmwCKn+aDnDVtP+Jt7s0SPthnokBUvLzQOQiipdeIxW7V3u42kLj14UPirUgWPYBiySk2lk9sMZ7jksfR2G6KWiIums9QTE8wWUjU5Hiak292Z70n/3prAKIj0dXzFbvuRP//gw9RlPPaKGQQ/Iegh2JRGZ+17CmqeZ0CHAwJXx6y6mXUKOC+URjoSchSrtDNImWsFOwffovYe+FjF8ZIn9Gu//7IcwmVRDfs+LU0eIdqWj5BMsQ5Nc+l+A0EZu/s9hsY+8MxiOelF74O9NzG4rCHKQ2ZHxYKlA==
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:17:02 +0000
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418]) by AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418%5]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 09:17:02 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: "dpdklab@iol.unh.edu" <dpdklab@iol.unh.edu>, "aconole@redhat.com"
 <aconole@redhat.com>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: Issue with patch application (Depends-on ignored) -
 pw169600-169609
Thread-Topic: Issue with patch application (Depends-on ignored) -
 pw169600-169609
Thread-Index: Ad1FsUVhaDVkU5FMQqOFx0R9FxyRVwQiwp2g
Date: Wed, 7 Oct 2026 09:17:02 +0000
Message-ID: <AS8PR04MB8293D01C39E0F7EEC9B0FD2FE5942@AS8PR04MB8293.eurprd04.prod.outlook.com>
References: <AS8PR04MB8293B2670DEEEE8B780143DCE5B92@AS8PR04MB8293.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8293B2670DEEEE8B780143DCE5B92@AS8PR04MB8293.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-16T07:56:05.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_|DB9PR04MB8156:EE_
x-ms-office365-filtering-correlation-id: 39236fa0-0b75-4912-ebbc-08df2453bfbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|19092799006|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: dPTidpDIAc0uhzjc19sEwi+pvalTCKCagBFlfVwkkVDcVkxrBW3FswoSfkFb9aeQHi8lNS/8/zLKVm3Gk8SKArOGHsPtdvEEpIHcRZGlj0mg+b/jWJGRV7WkgXXfOYUdv2be2lanaGGIv3kxhsInlg1LPaPVtVo05SUIQeqLk8+6az6WNGiHFRf6yEX2LZxk4OEW1PLpwHCyW5HwYqca+r87fSXZaD9cjjgNG3x+aOlyoFY7fB60OF03OgPf5SMlUF+wAEjMRz3BcJw0+igPa/H00Grcy6L27QLril0sMGE1x5PDqtHgn1cA0EZZUVWC0mwnMJvpp6RbJEzb9+Wfh3hMR+dx/rp5fKQkqqxPUMWjYXdDDZzlgmBQXPamN3FbUn3ppIzd0CMGQwUck0eXcM93vcQag24As6ynluE/SySkH0s7FdE24YB3l/auBYjpYz0ETSxdNMBwtD5+O1+a1Qvxz+UNqRTdLSBXmwwoa1VXMK8vuLkW1LZT2+WaGTdoKQ6lHeRbz1lutmgNmrfHe86VKWA6nSV9J0xhThj4X1EMLU9Bk4wVITj2O+f8wsZdbIHRHZeF0uHmYVaSE/tSUtT/ohRuDwSFShQt/2Wx/fxbwtsARGWRdU1nFZi3QdrfO8OzATt2VHt3YuzLbUR92m/7z5ogm7ZBCmiG0K+PC0M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8293.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(19092799006)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNFRVNwOTBoa2V5MTZRdVhKN2tsbHJVSEkzeGZWaXpEb01vSXVPc0lrRVQ5?=
 =?utf-8?B?RWJCQnFRNHNZbkg2NEtyYmF3N2hIeXJZdXE5azBjN3VoN1FJVkVWRUZMSmh2?=
 =?utf-8?B?SE1FZWZRcTg1REtoQXFVeGlFSUVqYkRadnorRDFuWFNFTFRaVXVTcGs2V055?=
 =?utf-8?B?ZlRmeWl5YWZkQXcxM2lKK1VKNUtpNThCVmViUnE5NDJSbWVOb2k0UUQ5WGtG?=
 =?utf-8?B?VEFYeHFLVHJ5NGVTck1SRWxqUzJLRC9CN3JvVUljajV6TFJnM2VHQnl4Zk96?=
 =?utf-8?B?VFlnS1FaUlA0RitmcG5mY1RFNnc1VWN0RVdHaGtGUVhTZ0h6TCtpMjJVM2kx?=
 =?utf-8?B?QjhYalV5MnNPdC92Z05DNm5NRDgvbzFycU9xZjF6THNwdEpyVG1iQThHMk1S?=
 =?utf-8?B?S1Z0OTNER1g3TS8yb0djMHFYNERvTW1pbjZXZGxHZkhqK2VQblIzd2psRnpO?=
 =?utf-8?B?akZnOFA5RmMvdlU1RGpMWEw3dTk3a0hkOWxjcnN0cW8vTmpLQkJRRzhBb0R0?=
 =?utf-8?B?Z2RwT0Y1RnIxaEFheGtnd2lVT1VHbHBad0I1cGpMcURVS3duY3JxeWRJYXgr?=
 =?utf-8?B?OWNWWUpOMkhKRHFpZ2xyazl6N2hXaXFtYUZDbk1WTmp3T3ZZT0hZY0Rva1FB?=
 =?utf-8?B?R2VNS0gybldJR2hRNGF5UHFobEIzQWczcnNFQVNYNGg2TlVLYml1U1QvL2xj?=
 =?utf-8?B?MzdrYmpyMVRHZW13YlhsYmxyNGdiVGdiYTlsT2d4RVpkSVBVdU8wTnNXWWJq?=
 =?utf-8?B?clp0SzU2NEdvcktkenlwTmdBRDhEV012Rm0yMm1wTEFSRmoyNndpdm1PQUhz?=
 =?utf-8?B?ZWRLT3o2OUt4ZkJNTGswR2hjR2x0emkrUTFqclNxQmRXRWoxSDNqTmgweG93?=
 =?utf-8?B?Rit2VEM1cVY1Y1hKMWs0bXNRSC9hTGo1MVhxU1BMbGd6QUFHc2FlRE1aaHpl?=
 =?utf-8?B?RlphMThnSFRRcFNBWi81eGJkRUZXSlNKMUVhcWJsR2gyOE41Q2QyMVliUVNo?=
 =?utf-8?B?V0V6TUZJemtxQ25hR2VraUluaWcwQXhJeGl5d2Uxd0VFc2lsN1Q0Rms3eTE4?=
 =?utf-8?B?WjBoLzRjWXBydVRuRFNBVnNXOVpIRTd5eWo0UW53bkJBaHdiV0xKdEN6RDNy?=
 =?utf-8?B?aTFoRzlmQVdLWlNsUDRSQ1F6VUMxaFBEczg3ZXRZTmd5WldDaW1NanBJa3F5?=
 =?utf-8?B?TlduMlo2ZlVUUzZaRnEzcEhEUVU0MXRjVEhuR0hkTGF0TnhWRXExZUdOaExX?=
 =?utf-8?B?b1YzV2xCL01wLzY4ZXNzN0FYMTUyY29ORFdHdWFHb3hBVXQ4bTIyRHZ1dEFV?=
 =?utf-8?B?QlY1MEE1ZTFTdCtlUXFHUHhhVi9JalpxenpoOHlDc1FxY2gwd2d1Nk5xQXRN?=
 =?utf-8?B?TjlBOUxsMXF0NXJiaHJDQVMvdHNlcE96aytkUHlha0dxYW1udmpLbWphZ0hy?=
 =?utf-8?B?U2MzNnEzR2xFWGNtTUdKQTc1NmNSTmErRUpwRnpVdVBUT3A0dUViRVR5UFVk?=
 =?utf-8?B?Qnh2M3ZiSURGNnJlbVZsTEt1OTZ0ajd3a2pzNUp2K0lsY3NMdGJuUHdpTUcr?=
 =?utf-8?B?cnVWTG9kN1A1MkYvT3hSV2NuRS8zMEJLY3ZLRFZ0ZXQvYnRzL0QvODcxSndP?=
 =?utf-8?B?MHBCTUpWUnMwMjN3NGpEeE5uaTA5VnhVbjVhUEZwVFFVS3R5K2dXKzhXak44?=
 =?utf-8?B?TjNhUElZM08vcmp0c3FBV3kybllzVjZXMUlCYzcweGVqNFd6STMwNDlqMjU5?=
 =?utf-8?B?dDFkSUpqcFg4aVNmOHpTRE1iMDM1a0FkT0pyQm41UmJzcC82MFpaYnBDdnM5?=
 =?utf-8?B?OStzZHN2bzlwYkFhUVJYREJTYjJsTzg0YmQvaDNEUW9vN0l1WExwK0hkcWpn?=
 =?utf-8?B?ZkVmeThsOXNkT1RJQXJHemlaaExNT1ZjS0RNSGVLQ240MzUxY2YvbkZKZmdq?=
 =?utf-8?B?NmNBa2poS09iUE0veU8zeTlNQ3B0bE04ZVA2UXMwVUVTSTJKQlNSN3labWo3?=
 =?utf-8?B?M2VKOEVUTGRPTGZLTHRhdTV1bDFZc0d3MUlVQmpPQks0TmkydjBNVEVnRFRu?=
 =?utf-8?B?WFpNeitZWTVwU1ZEa3pDVWZNSE9WSFZ0SjRZdnlrVHA4UC95ckVhcFprcHpw?=
 =?utf-8?B?RHEwajFWSTdiNENsY2NTOFBlVE9xK3kvbTZ6TkoxVUVieVYxeUxzZGhxWEFn?=
 =?utf-8?B?Vm5KaitPNlBlZFAzZ1doWG5naEZwWDF6aGZFMnRwS0Z6djAxL3FYeUh0MXEx?=
 =?utf-8?B?Nm91eVl6SFRZa3dNaWNYdHBGbDh0OWhEanByZGQ0aGs0TkZma0hVK0hTUVlY?=
 =?utf-8?B?NDBpZTVLWUJNaUN4OXZ4RUVrNlcvMjRiWlJFNjM2UEYyV0VrVUNnZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8293.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39236fa0-0b75-4912-ebbc-08df2453bfbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 09:17:02.7113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 177KXujKkWuM884pJMHAercucoJY+N8syluYxdYBCHeHMYnZqWOFDhwhKB8d1W+XcUT4SdAm4mJa5Ak0PBWjfCk9EnAsG4W6MFp2gq/lSMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156
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

SGksDQoNCkNhbiBTb21lYm9keSBwbGVhc2UgZ3VpZGUgZm9yIHRoaXMgY2FzZT8NClRoYW5rcyBp
biBhZHZhbmNlICENCg0KUmVnYXJkcywNClByYXNoYW50DQoNCg0KTlhQIENvbmZpZGVudGlhbA0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFByYXNoYW50IEd1cHRhDQpTZW50OiAx
NiBTZXB0ZW1iZXIgMjAyNiAxNDo1Nw0KVG86ICdkcGRrbGFiQGlvbC51bmguZWR1JyA8ZHBka2xh
YkBpb2wudW5oLmVkdT47ICdhY29ub2xlQHJlZGhhdC5jb20nIDxhY29ub2xlQHJlZGhhdC5jb20+
OyAnZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbScgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+
OyAnc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmcnIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Zz4NCkNjOiBkZXZAZHBkay5vcmc7IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAu
Y29tPg0KU3ViamVjdDogSXNzdWUgd2l0aCBwYXRjaCBhcHBsaWNhdGlvbiAoRGVwZW5kcy1vbiBp
Z25vcmVkKSAtIHB3MTY5NjAwLTE2OTYwOQ0KDQpIaSBVTkgtSU9MIENJIFRlYW0sDQoNCkkgcmVj
ZWl2ZWQgYW4gYXBwbHkgcGF0Y2ggZmFpbHVyZSB3YXJuaW5nIGZvciBwYXRjaCBzZXQgMTY5NjAw
LTE2OTYwOSAoU2VyaWVzIDM5MjkyKS4gKGh0dHBzOi8vbWFpbHMuZHBkay5vcmcvYXJjaGl2ZXMv
dGVzdC1yZXBvcnQvMjAyNi1TZXB0ZW1iZXIvMTA0NDUyMi5odG1sKQ0KDQpUaGUgYnVpbGQgZmFp
bGVkIGJlY2F1c2UgaXQgdHJpZWQgdG8gYXBwbHkgZGlyZWN0bHkgdG8gb3JpZ2luL21haW4sIHJl
c3VsdGluZyBpbiBhIGNvbmZsaWN0IGluc2lkZSBkcml2ZXJzL2RtYS9kcGFhMi9kcGFhMl9xZG1h
LmMuIEhvd2V2ZXIsIHRoaXMgc2VyaWVzIHN0cmljdGx5IGRlcGVuZHMgb24gbXkgcHJldmlvdXMg
c2VyaWVzIDM5MjkxICgibmV0L2RwYWEyOiBmbG93LCBtZXRlciBhbmQgcGFyc2VyIGZlYXR1cmVz
IiksIHdoaWNoIGNvbnRhaW5zIHRoZSBiYXNlIGluZnJhc3RydWN0dXJlIGNoYW5nZXMuDQoNCkkg
aW5jbHVkZWQgYSAiRGVwZW5kcy1vbiIgdGFnIGluIHRoZSBjb3ZlciBsZXR0ZXIgdG8gaGFuZGxl
IHRoaXMgc2VxdWVuY2UsIGJ1dCB0aGUgQ0kgYm90IHNlZW1zIHRvIGhhdmUgbWlzc2VkIG9yIHNr
aXBwZWQgaXQuIChodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRrL2NvdmVyLzIw
MjYwOTE1MTIwMjA4LjQxODU4NzctMS1wcmFzaGFudC5ndXB0YV8zQG54cC5jb20vKQ0KKERlcGVu
ZHMtb246IHNlcmllcy0zOTI5MSAoIm5ldC9kcGFhMjogZmxvdywgbWV0ZXIgYW5kIHBhcnNlciBm
ZWF0dXJlcyIpKQ0KDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSBjaGVjayBpZiB0aGVyZSB3
YXMgYSBwYXJzaW5nIGlzc3VlIHdpdGggdGhlIHRhZyBsYXlvdXQsIG9yIGlmIEkgbmVlZCB0byBm
b3JtYXQgdGhlIGRlcGVuZGVuY3kgdGFnIGRpZmZlcmVudGx5IHNvIHRoZSBsYWIgYm90cyBjYW4g
Y2hhaW4gdGhlc2Ugc2VyaWVzIGF1dG9tYXRpY2FsbHk/DQoNClJlZ2FyZHMsDQpQcmFzaGFudCBH
dXB0YQ0KDQo=
