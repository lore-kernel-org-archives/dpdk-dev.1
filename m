Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF2FEDF040
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49D6D402E2;
	Thu, 12 Feb 2026 06:51:57 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 37F32402C0
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:51:54 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61C5ppzpF3347931,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770875512;
 bh=WZHgixlN4z4a1BnD/LRWQzqz5FKDR8aEB3nIUHv1JRY=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=gBZSFbp+axDlzCk0SQQK01JPVWUeE7BGbB2HiUZSzf8V+hRC7d1VX1NWj/9RXicg0
 AytDWc1hLo8ReHKOtfRh8tWwGu8opoPXG3H/A9atA5QaByApQ/acAIj2FUXAyYnZ0h
 D520Qjf5CIod83Z4FPkKvatyaU+dZgdz+BZCPcCRYDgnlbq0Sbn1SWWugVwZ6qpOSW
 WdeZt6E4jGODhBFZ54QIao3Rwm4fjNP1w/DDDDGBKp91yBn6hM2ymkB9XFB57Jl9pr
 xAOVIHUIBjxITuafn9WRE6Dxb+3IWQmliNU2hHuegqjNdbV0/aiGtXcLZDg5cCPQi7
 hyom5sjRJdQDA==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61C5ppzpF3347931
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Feb 2026 13:51:52 +0800
Received: from RS-EX-MBS4.realsil.com.cn (172.29.17.104) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 12 Feb 2026 13:51:51 +0800
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) by
 RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) with mapi id 15.02.1748.039; Thu,
 12 Feb 2026 13:51:51 +0800
From: =?gb2312?B?zfXyqw==?= <howard_wang@realsil.com.cn>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pro_nic_dpdk@realtek.com"
 <pro_nic_dpdk@realtek.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMDEvMTJdIG5ldC9yODE2OTogZml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBydGw4MTY4ZnBfb3Bz?=
Thread-Topic: [PATCH v2 01/12] net/r8169: fix NULL pointer dereference in
 rtl8168fp_ops
Thread-Index: AQHcmlHUo0FpgRpvUUG/PYFX1sJaMLV9g+qAgAEOQ4A=
Date: Thu, 12 Feb 2026 05:51:51 +0000
Message-ID: <a422d66b5d284415a399bbe8ca5f2b7c@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
 <20260210055511.62382-2-howard_wang@realsil.com.cn>
 <20260211134235.258f347c@phoenix.local>
In-Reply-To: <20260211134235.258f347c@phoenix.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
x-originating-ip: [172.29.17.210]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

VGhhbmtzLiBTaW5jZSBJIG5lZWQgdG8gc2VuZCBhIHYzIHRvIGFkZHJlc3MgY29tbWVudHMgb24g
YW5vdGhlciBwYXRjaCBpbiB0aGlzIHNlcmllcywgSSB3aWxsIGluY2x1ZGUgdGhpcyB1cGRhdGVk
IGNvbW1pdCBtZXNzYWdlIGluIHYzLg0KDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBT
dGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+IA0Kt6LLzcqxvOQ6
IDIwMjbE6jLUwjEyyNUgNTo0Mw0KytW8/sjLOiDN9fKrIDxob3dhcmRfd2FuZ0ByZWFsc2lsLmNv
bS5jbj4NCrOty806IGRldkBkcGRrLm9yZzsgcHJvX25pY19kcGRrQHJlYWx0ZWsuY29tDQrW98zi
OiBSZTogW1BBVENIIHYyIDAxLzEyXSBuZXQvcjgxNjk6IGZpeCBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UgaW4gcnRsODE2OGZwX29wcw0KDQoNCkV4dGVybmFsIG1haWwgOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCByZXBseSwgY2xp
Y2sgbGlua3MsIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNl
bmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KT24gVHVlLCAxMCBGZWIg
MjAyNiAxMzo1NTowMCArMDgwMA0KSG93YXJkIFdhbmcgPGhvd2FyZF93YW5nQHJlYWxzaWwuY29t
LmNuPiB3cm90ZToNCg0KPiBGaXhlczogZDllZTcxYjVmMWJjICgibmV0L3I4MTY5OiBzdXBwb3J0
IFJUTDgxNjggc2VyaWVzIikNCj4NCj4gU2lnbmVkLW9mZi1ieTogSG93YXJkIFdhbmcgPGhvd2Fy
ZF93YW5nQHJlYWxzaWwuY29tLmNuPg0KPiAtLS0NCg0KVGhhdCBpcyBtdWNoIHRvIHNob3J0IGEg
bWVzc2FnZSBmb3IgYSBjcml0aWNhbCBmaXguDQpIb3cgYWJvdXQgdGhpcyAoQUkgZ2VuZXJhdGVk
KSBtZXNzYWdlLiBDYW4gSSBhZGQgdGhhdCBkdXJpbmcgbWVyZ2U/DQoNClN1YmplY3Q6IFtQQVRD
SCB2MiAwMS8xMl0gbmV0L3I4MTY5OiBmaXggY3Jhc2ggaW4gUlRMODE2OEZQIGluaXQNCg0KVGhl
IHJ0bDgxNjhmcF9vcHMgc3RydWN0dXJlIHdhcyBtaXNzaW5nIHRoZSBod19waHlfbWN1X2NvbmZp
ZyBmdW5jdGlvbiBwb2ludGVyLCBjYXVzaW5nIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGR1
cmluZyBkZXZpY2UgaW5pdGlhbGl6YXRpb24gd2hlbiB0aGUgZHJpdmVyIGF0dGVtcHRzIHRvIGNv
bmZpZ3VyZSB0aGUgUEhZIG1pY3JvY29udHJvbGxlci4NCg0KQWRkIGh3X3BoeV9tY3VfY29uZmln
XzgxNjhmcCgpIGFzIGEgbm8tb3AgZnVuY3Rpb24gc2luY2UgdGhlIFJUTDgxNjhGUCBkb2VzIG5v
dCByZXF1aXJlIFBIWSBNQ1UgY29uZmlndXJhdGlvbi4gVGhpcyBtYXRjaGVzIHRoZSBwYXR0ZXJu
IHVzZWQgYnkgb3RoZXIgY2hpcCB2YXJpYW50cyB0aGF0IGRvbid0IG5lZWQgUEhZIE1DVSB1cGRh
dGVzLg0KDQpGaXhlczogZDllZTcxYjVmMWJjICgibmV0L3I4MTY5OiBzdXBwb3J0IFJUTDgxNjgg
c2VyaWVzIikNCg0K
