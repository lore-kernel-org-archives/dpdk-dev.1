Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A76CA101F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 03:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FC8540264;
	Mon,  8 Sep 2025 05:12:49 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 007CB400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 05:12:46 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5883CeOnA1225402,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1757301160;
 bh=eAsU/PDquMtYudwlUg5uhKGvkJ71eITMlBeFu3tHwFc=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=VZy5Ix7CifyRQc6tsuNmjWxJZ5qp1MVQUo9cWMHFKyZwhcQXGjNWPO5vPMzLNcv/x
 ccQKKBrrNMyki8eZZFawcp6E0KrfHcE4CJDJUdOyobhK6/9AgHsNnDsQWfXKxcrqmP
 InVnxOutcIk0nVa1VfADT15JOMkYLMwCT9na8O+912lT+ledeg9jCalVXx3VQegE7u
 Ln+GCluRCjuPxRGT8mq5/uaee1tUByk11FIYitT+kxT3G7jZ0qHAbjiGIxYk/5Azfv
 pTKGfRFkSaaP6v91cD3MQJ+YnXgV9O069y46KWuAdxjexxwWg/YE6Q4e1jWpvzPM7O
 ZTiMKpDrzsk/A==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5883CeOnA1225402
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Sep 2025 11:12:40 +0800
Received: from RS-EX-MBS4.realsil.com.cn (172.29.17.104) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Mon, 8 Sep 2025 11:12:40 +0800
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) by
 RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) with mapi id 15.02.1544.033; Mon,
 8 Sep 2025 11:12:40 +0800
From: =?utf-8?B?546L6aKi?= <howard_wang@realsil.com.cn>
To: Stephen Hemminger <stephen@networkplumber.org>, "hau@realtek.com"
 <hau@realtek.com>, "drc@linux.ibm.com" <drc@linux.ibm.com>,
 "jianwang@trustnetic.com" <jianwang@trustnetic.com>,
 "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>,
 "sachin.saxena@oss.nxp.com" <sachin.saxena@oss.nxp.com>,
 =?utf-8?B?546L5pif?= <xing_wang@realsil.com.cn>, "zaiyuwang@trustnetic.com"
 <zaiyuwang@trustnetic.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: =?utf-8?B?5Zue5aSNOiBNQUlOVEFJTkVSUyBjaGVja2lu?=
Thread-Topic: MAINTAINERS checkin
Thread-Index: AQHcH0oPZslwMenDpUm49DhdFYK6+LSIm7CQ
Date: Mon, 8 Sep 2025 03:12:39 +0000
Message-ID: <c110f94519b849a3b841c8cbf3b9d859@realsil.com.cn>
References: <20250906091932.33d61730@hermes.local>
In-Reply-To: <20250906091932.33d61730@hermes.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
x-originating-ip: [172.29.17.210]
Content-Type: text/plain; charset="utf-8"
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

SGkgU3RlcGhlbiwNCg0KQWxsIGVtYWlsIGFkZHJlc3NlcyB3aXRoaW4gdGhlIFJlYWx0ZWsgZ3Jv
dXAsIGluY2x1ZGluZyB0aG9zZSBlbmRpbmcgaW4gQHJlYWx0ZWsgYW5kIEByZWFsc2lsLCBhcmUg
dmFsaWQgYW5kIGFjdGl2ZWx5IGluIHVzZS4gVGhlIGVycm9yIG1lc3NhZ2UgeW91IGVuY291bnRl
cmVkLCAnRG9tYWluIGRvZXMgbm90IGV4aXN0IG9yIGlzIHVucmVhY2hhYmxlJywgaXMgcmVsYXRl
ZCB0byBvdXIgY29tcGFueSdzIHNlY3VyaXR5IHBvbGljeSwgd2hpY2ggSSBhbSBub3QgYXV0aG9y
aXplZCB0byBpbnRlcmZlcmUgd2l0aC4gSSBzaW5jZXJlbHkgYXBvbG9naXplIGZvciBhbnkgaW5j
b252ZW5pZW5jZSB0aGlzIG1heSBjYXVzZS4NCg0KSG93YXJkIFdhbmcNCg0KLS0tLS3pgq7ku7bl
jp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI15bm0OeaciDfml6UgMDoyMA0K5pS25Lu2
5Lq6OiBoYXVAcmVhbHRlay5jb207IGRyY0BsaW51eC5pYm0uY29tOyDnjovpoqIgPGhvd2FyZF93
YW5nQHJlYWxzaWwuY29tLmNuPjsgamlhbndhbmdAdHJ1c3RuZXRpYy5jb207IGppYXdlbnd1QHRy
dXN0bmV0aWMuY29tOyBzYWNoaW4uc2F4ZW5hQG9zcy5ueHAuY29tOyDnjovmmJ8gPHhpbmdfd2Fu
Z0ByZWFsc2lsLmNvbS5jbj47IHphaXl1d2FuZ0B0cnVzdG5ldGljLmNvbQ0K5oqE6YCBOiBkZXZA
ZHBkay5vcmcNCuS4u+mimDogTUFJTlRBSU5FUlMgY2hlY2tpbg0KDQoNCkV4dGVybmFsIG1haWwg
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIERv
IG5vdCByZXBseSwgY2xpY2sgbGlua3MsIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0K
VGhlIGZvbGxvd2luZyBlbWFpbCBhZGRyZXNzZXMgbm8gbG9uZ2VyIGFwcGVhciB0byBiZSB2YWxp
ZC4NClNlZSBhdHRhY2hlZCBweXRob24gc2NyaXB0IChBSSBnZW5lcmF0ZWQpIGZvciB2YWxpZGF0
aW9uLg0KDQpJbnZhbGlkIEVtYWlsczoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
4oCiIGhhdUByZWFsdGVrLmNvbQ0KICAtIERvbWFpbiBkb2VzIG5vdCBleGlzdCBvciBpcyB1bnJl
YWNoYWJsZSDigKIgZHJjQGxpbnV4LmlibS5jb20NCiAgLSBEb21haW4gZG9lcyBub3QgZXhpc3Qg
b3IgaXMgdW5yZWFjaGFibGUg4oCiIGhvd2FyZF93YW5nQHJlYWxzaWwuY29tLmNuDQogIC0gRG9t
YWluIGRvZXMgbm90IGV4aXN0IG9yIGlzIHVucmVhY2hhYmxlIOKAoiBqaWFud2FuZ0B0cnVzdG5l
dGljLmNvbQ0KICAtIERvbWFpbiBkb2VzIG5vdCBleGlzdCBvciBpcyB1bnJlYWNoYWJsZSDigKIg
amlhd2Vud3VAdHJ1c3RuZXRpYy5jb20NCiAgLSBEb21haW4gZG9lcyBub3QgZXhpc3Qgb3IgaXMg
dW5yZWFjaGFibGUg4oCiIHNhY2hpbi5zYXhlbmFAb3NzLm54cC5jb20NCiAgLSBEb21haW4gZG9l
cyBub3QgZXhpc3Qgb3IgaXMgdW5yZWFjaGFibGUg4oCiIHhpbmdfd2FuZ0ByZWFsc2lsLmNvbS5j
bg0KICAtIERvbWFpbiBkb2VzIG5vdCBleGlzdCBvciBpcyB1bnJlYWNoYWJsZSDigKIgemFpeXV3
YW5nQHRydXN0bmV0aWMuY29tDQogIC0gRG9tYWluIGRvZXMgbm90IGV4aXN0IG9yIGlzIHVucmVh
Y2hhYmxlDQoNCg==
