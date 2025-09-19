Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B4CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 18:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93FC740658;
	Fri, 19 Sep 2025 20:52:10 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id BFB364042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 20:52:08 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [42.177.177.196] ) by
 ajax-webmail-APP-09 (Coremail) ; Sat, 20 Sep 2025 02:52:06 +0800
 (GMT+08:00)
X-Originating-IP: [42.177.177.196]
Date: Sat, 20 Sep 2025 02:52:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: uk7b@foxmail.com, dev@dpdk.org, 
 "Stanislaw Kardach" <stanislaw.kardach@gmail.com>, 
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: Re: [PATCH v3 1/4] config/riscv: detect V extension
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <3159839.72vocr9iq0@thomas>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
 <tencent_FDE91C0DD66F18084FBD6A8F45C3D05AB106@qq.com>
 <3159839.72vocr9iq0@thomas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <39a1099c.30100.1996351c0d1.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowACnG1VWps1om7AFAA--.55984W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRAKAmjNcNhlrAACsX
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

Jmd0OyBQbGVhc2UgY291bGQgeW91IGFkZCBhIGNyb3NzIGZpbGUgaW4gY29uZmlnL3Jpc2N2LyBm
b3IgcnY2NGdjdgomZ3Q7IGFuZCB1c2UgaXQgaW4gZGV2dG9vbHMvdGVzdC1tZXNvbi1idWlsZHMu
c2ggc28gd2UgY2FuIHRlc3QgY29tcGlsaW5nCiZndDsgd2l0aCB0aGUgdmVjdG9yIGV4dGVuc2lv
bj8KClN1cmUsIEkgcGxhbiB0byBzdWJtaXQgdGhpcyBuZXh0IHdlZWsuCgomZ3Q7IEFub3RoZXIg
cXVlc3Rpb24gYWJvdXQgUklTQy1WIG1haW50ZW5hbmNlIGluIGdlbmVyYWwsCiZndDsgd2hhdCBk
byB5b3UgdGhpbmsgYWJvdXQgb3RoZXIgcGVuZGluZyBwYXRjaGVzIGZvciBSSVNDLVY/CgpJIHdv
dWxkIGxpa2UgdG8gcHJpb3JpdGl6ZSBtZXJnaW5nIHRoZSBod3Byb2JlIGRldGVjdGlvbi4gVGhl
IHJlbGF0ZWQgd29yayBpcyBhbHJlYWR5IG1vc3RseSBkb25lIGhlcmU6CgpbUEFUQ0ggdjMgMC85
XSByaXNjdjogaW1wbGVtZW50IGFjY2VsZXJhdGVkIGNyYyB1c2luZyB6YmMKClRoZSBuZXh0IHN0
ZXAgaXMgdG8gY29udGFjdCB0aGUgYXV0aG9yIGZvciBhIHJlYmFzZSBhbmQgdGhlbiByZXZpZXcg
aXQuIEFmdGVyIHRoYXQsIHRoZSBmb2xsb3dpbmcgcGF0Y2ggd2lsbCBiZSBoYW5kbGVkOgoKW1BB
VENIIDAvMl0gZWFsL3Jpc2N2OiBpbXBsZW1lbnQgcHJlZmV0Y2ggdXNpbmcgemljYm9wCgpJbiBh
ZGRpdGlvbiwgb3VyIHRlYW0gaGFzIHNldmVyYWwgcmlzY3YgdiBleHRlbnNpb24gb3B0aW1pemF0
aW9uIHBhdGNoZXMgdGhhdCB3ZSBhcmUgcmVmaW5pbmcgYW5kIHdpbGwgc3VibWl0IHNvb24uCgpJ
IHdvdWxkIHByZWZlciB0byBiZSBhZGRlZCBhcyBhIG1haW50YWluZXIsIGFzIHRoaXMgbWlnaHQg
bWFrZSBjb21tdW5pY2F0aW9uIHdpdGggb3RoZXIgYXV0aG9ycyBtb3JlIGVmZmljaWVudC4KCgom
Z3Q7IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KJmd0OyDlj5Hku7bkuro6ICJUaG9tYXMgTW9uamFs
b24iIDx0aG9tYXNAbW9uamFsb24ubmV0PgomZ3Q7IOWPkemAgeaXtumXtDogMjAyNS0wOS0yMCAw
MjoxNjoyMiAo5pif5pyf5YWtKQomZ3Q7IOaUtuS7tuS6ujogIlN1biBZdWVjaGkiIDxzdW55dWVj
aGlAaXNjYXMuYWMuY24+LCB1azdiQGZveG1haWwuY29tCiZndDsg5oqE6YCBOiBkZXZAZHBkay5v
cmcsICJTdGFuaXNsYXcgS2FyZGFjaCIgPHN0YW5pc2xhdy5rYXJkYWNoQGdtYWlsLmNvbT4sICJC
cnVjZSBSaWNoYXJkc29uIiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+CiZndDsg5Li76aKY
OiBSZTogW1BBVENIIHYzIDEvNF0gY29uZmlnL3Jpc2N2OiBkZXRlY3QgViBleHRlbnNpb24KJmd0
OyAKJmd0OyAxOS8wOS8yMDI1IDE4OjMzLCB1azdiQGZveG1haWwuY29tOgomZ3Q7ICZndDsgRnJv
bTogU3VuIFl1ZWNoaSA8c3VueXVlY2hpQGlzY2FzLmFjLmNuPgomZ3Q7ICZndDsgCiZndDsgJmd0
OyBUaGlzIHBhdGNoIGlzIGRlcml2ZWQgZnJvbSAiY29uZmlnL3Jpc2N2OiBkZXRlY3QgcHJlc2Vu
Y2Ugb2YgWmJjCiZndDsgJmd0OyBleHRlbnNpb24gd2l0aCBtb2RpZmljYXRpb25zIi4KJmd0OyAm
Z3Q7IAomZ3Q7ICZndDsgVGhlIFJJU0MtViBDIGFwaSBkZWZpbmVzIGFyY2hpdGVjdHVyZSBleHRl
bnNpb24gdGVzdCBtYWNyb3MKJmd0OyAmZ3Q7IFRoZXNlIGxldCB1cyBkZXRlY3Qgd2hldGhlciB0
aGUgViBleHRlbnNpb24gaXMgc3VwcG9ydGVkIG9uIHRoZQomZ3Q7ICZndDsgY29tcGlsZXIgYW5k
IC1tYXJjaCB3ZSdyZSBidWlsZGluZyB3aXRoLiBUaGUgQyBhcGkgYWxzbyBkZWZpbmVzIFYKJmd0
OyAmZ3Q7IGludHJpbnNpY3Mgd2UgY2FuIHVzZSByYXRoZXIgdGhhbiBpbmxpbmUgYXNzZW1ibHkg
b24gbmV3ZXIgdmVyc2lvbnMgb2YKJmd0OyAmZ3Q7IEdDQyAoMTQuMS4wKykgYW5kIENsYW5nICgx
OC4xLjArKS4KJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgSWYgdGhlIFYgZXh0ZW5zaW9uIGFuZCBpbnRy
aW5zaWNzIGFyZSBib3RoIHByZXNlbnQgYW5kIHdlIGNhbiBkZXRlY3QKJmd0OyAmZ3Q7IHRoZSBW
IGV4dGVuc2lvbiBhdCBydW50aW1lLCB3ZSBkZWZpbmUgYSBmbGFnLCBSVEVfUklTQ1ZfRkVBVFVS
RV9WLgomZ3Q7ICZndDsgCiZndDsgJmd0OyBTaWduZWQtb2ZmLWJ5OiBTdW4gWXVlY2hpIDxzdW55
dWVjaGlAaXNjYXMuYWMuY24+CiZndDsgCiZndDsgU2VyaWVzIG1lcmdlZCB3aXRoIHN0eWxlIGlt
cHJvdmVtZW50cywgdGhhbmtzLgomZ3Q7IAomZ3Q7IFBsZWFzZSBjb3VsZCB5b3UgYWRkIGEgY3Jv
c3MgZmlsZSBpbiBjb25maWcvcmlzY3YvIGZvciBydjY0Z2N2CiZndDsgYW5kIHVzZSBpdCBpbiBk
ZXZ0b29scy90ZXN0LW1lc29uLWJ1aWxkcy5zaCBzbyB3ZSBjYW4gdGVzdCBjb21waWxpbmcKJmd0
OyB3aXRoIHRoZSB2ZWN0b3IgZXh0ZW5zaW9uPwomZ3Q7IAomZ3Q7IEFub3RoZXIgcXVlc3Rpb24g
YWJvdXQgUklTQy1WIG1haW50ZW5hbmNlIGluIGdlbmVyYWwsCiZndDsgd2hhdCBkbyB5b3UgdGhp
bmsgYWJvdXQgb3RoZXIgcGVuZGluZyBwYXRjaGVzIGZvciBSSVNDLVY/CiZndDsgCjwvc3VueXVl
Y2hpQGlzY2FzLmFjLmNuPjwvc3VueXVlY2hpQGlzY2FzLmFjLmNuPjwvYnJ1Y2UucmljaGFyZHNv
bkBpbnRlbC5jb20+PC9zdGFuaXNsYXcua2FyZGFjaEBnbWFpbC5jb20+PC9zdW55dWVjaGlAaXNj
YXMuYWMuY24+PC90aG9tYXNAbW9uamFsb24ubmV0Pg==
