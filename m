Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76958CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 14:37:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C29A40288;
	Thu, 18 Sep 2025 16:37:11 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id 40ADE4027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 16:37:10 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [42.177.177.196] ) by
 ajax-webmail-APP-09 (Coremail) ; Thu, 18 Sep 2025 22:37:06 +0800
 (GMT+08:00)
X-Originating-IP: [42.177.177.196]
Date: Thu, 18 Sep 2025 22:37:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: "David Marchand" <david.marchand@redhat.com>, dev@dpdk.org, 
 "Eric Long" <i@hack3r.moe>
Subject: Re: Re: [PATCH] test: raise fast test timeout to 60s on RISC-V
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <3616255.BddDVKsqQX@thomas>
References: <MW4PR11MB8289B816B08C6E19716B8F82D72C2@MW4PR11MB8289.namprd11.prod.outlook.com>
 <CAJFAV8xjcsip9dxKW3PdVtmv_-HYfbe7h9H+-8x816i=z=aL8Q@mail.gmail.com>
 <MW4PR11MB8289AF4AB84FB5FA14BE3FC3D7282@MW4PR11MB8289.namprd11.prod.outlook.com>
 <3616255.BddDVKsqQX@thomas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42d5a086.2c8ee.1995d41f1c7.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowABXzFUTGcxon0wFAA--.58781W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgoJAmjMCysWVgABsC
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
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

SSB0aGluayBpbmNyZWFzaW5nIHRoZSBSSVNDLVYgdGltZW91dCBpcyByZWFzb25hYmxlIGFuZCBz
aG91bGRu4oCZdCBjYXVzZSBhbnkgaXNzdWVzLgoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0t
CiZndDsg5Y+R5Lu25Lq6OiAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmphbG9uLm5ldD4K
Jmd0OyDlj5HpgIHml7bpl7Q6IDIwMjUtMDktMTggMjA6Mjg6MDcgKOaYn+acn+WbmykKJmd0OyDm
lLbku7bkuro6ICJEYXZpZCBNYXJjaGFuZCIgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+LCBk
ZXZAZHBkay5vcmcKJmd0OyDmioTpgIE6ICJFcmljIExvbmciIDxpQGhhY2szci5tb2U+CiZndDsg
5Li76aKYOiBSZTogW1BBVENIXSB0ZXN0OiByYWlzZSBmYXN0IHRlc3QgdGltZW91dCB0byA2MHMg
b24gUklTQy1WCiZndDsgCiZndDsgMjcvMTEvMjAyNCAwNDoyNiwgRXJpYyBMb25nOgomZ3Q7ICZn
dDsgT24gMjcvMTEvMjAyNCAwNDoyOSwgRGF2aWQgTWFyY2hhbmQgd3JvdGU6CiZndDsgJmd0OyAm
Z3Q7IFlvdSBjYW4gZXh0ZW5kIHRoZSB0aW1lb3V0IHZpYSB0aGUgbXVsdGlwbGllciBvcHRpb24g
KGRlZmF1bHQgdGltZW91dAomZ3Q7ICZndDsgJmd0OyBvZiAxMHMgKiBtdWx0aXBsaWVyKS4KJmd0
OyAmZ3Q7ICZndDsgU28gaW4geW91ciBjYXNlOgomZ3Q7ICZndDsgJmd0OyAkIG1lc29uIHRlc3Qg
LUMgPGJ1aWxkPiAtLXN1aXRlIGZhc3QtdGVzdHMgLXQgNgomZ3Q7ICZndDsgCiZndDsgJmd0OyBJ
IGhvcGUgdGhlIFJJU0MtViBzcGVjaWZpYyBleHRlbmRlZCB0aW1lb3V0IGNvdWxkIGJlIHVwc3Ry
ZWFtZWQgdGhvdWdoLCAKJmd0OyAmZ3Q7IGluIHRoaXMgd2F5IHdlIHdvbid0IG5lZWQgdG8gYnVt
cCB0aW1lb3V0IGluIGV2ZXJ5IGRpc3RybyBzdXBwb3J0aW5nIHRoZSAKJmd0OyAmZ3Q7IGFyY2hp
dGVjdHVyZSAobGlrZSBEZWJpYW4gWzFdKSBvciBldmVuIG5vdCBydW5uaW5nIHRoZSB0ZXN0cyBh
bHRvZ2V0aGVyIAomZ3Q7ICZndDsgKGxpa2UgT3BlblNVU0UgWzJdIGFuZCBGZWRvcmEgWzNdKSwg
anVzdCBiZWNhdXNlIHRlc3RzIGFyZSBmYWlsaW5nIGR1ZSAKJmd0OyAmZ3Q7IHRvIHRpbWVvdXQu
CiZndDsgCiZndDsgV2hhdCBkbyB3ZSBkZWNpZGU/CiZndDsgQSBzcGVjaWZpYyB0aW1lb3V0IGRv
ZXNuJ3QgaGFybSBJIGd1ZXNzPwomZ3Q7IAomZ3Q7IAo8L2J1aWxkPjwvaUBoYWNrM3IubW9lPjwv
ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT48L3Rob21hc0Btb25qYWxvbi5uZXQ+
