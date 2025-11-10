Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D5CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 02:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFCF400D6;
	Mon, 10 Nov 2025 03:54:42 +0100 (CET)
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
 by mails.dpdk.org (Postfix) with ESMTP id 09C43400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 03:54:39 +0100 (CET)
Received: from sunyuechi$iscas.ac.cn ( [42.57.186.148] ) by
 ajax-webmail-APP-12 (Coremail) ; Mon, 10 Nov 2025 10:54:36 +0800
 (GMT+08:00)
X-Originating-IP: [42.57.186.148]
Date: Mon, 10 Nov 2025 10:54:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: sunyuechi@iscas.ac.cn
To: dev@dpdk.org
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, thomas@monjalon.net
Subject: Re: [PATCH] devtools: add RISC-V vector in meson build test
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <20251110025220.3319989-1-sunyuechi@iscas.ac.cn>
References: <20251110025220.3319989-1-sunyuechi@iscas.ac.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <11c5f45b.209a.19a6bafd5c3.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowACnxgftUxFp5D4AAA--.3726W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRECAmkRRsU5XAABsH
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

Jmd0OyBNYXliZSB3ZSB3YW50IHRvIHJlcGxhY2UgdGhlIGdlbmVyaWMgUklTQy1WIGJ1aWxkIHdp
dGggdGhlIHZlY3RvciBvbmUuCiZndDsgSXQgY291bGQgYmUgZGlzY3Vzc2VkIGluIGFub3RoZXIg
cGF0Y2guCgpJIHRoaW5rIGJvdGggc2NhbGFyIGFuZCB2ZWN0b3IgYnVpbGQgZGV0ZWN0aW9uIHNo
b3VsZCBleGlzdCwKYmVjYXVzZSBJJ3ZlIHNlZW4gc2V2ZXJhbCB0aW1lcyBpbiBvdGhlciBwcm9q
ZWN0cyB0aGF0IGFmdGVyIGFkZGluZyB2ZWN0b3Igb3B0aW1pemF0aW9uLCAKdGhlIHNjYWxhciB2
ZXJzaW9uIGJ1aWxkIGZhaWxlZCBkdWUgdG8gaW5jb3JyZWN0IGNvbXBpbGF0aW9uIGNvbmRpdGlv
bnMuIApTb21lIGNhdXRpb3VzIHByb2plY3RzIGFsc28gdGVzdCB2YXJpb3VzIGV4dGVuc2lvbiBj
b21iaW5hdGlvbnMuIFdoYXQgZG8geW91IHRoaW5rPwoKCiZndDsgLS0tLS3ljp/lp4vpgq7ku7Yt
LS0tLQomZ3Q7IOWPkeS7tuS6ujogIlN1biBZdWVjaGkiIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+
CiZndDsg5Y+R6YCB5pe26Ze0OiAyMDI1LTExLTEwIDEwOjUyOjIwICjmmJ/mnJ/kuIApCiZndDsg
5pS25Lu25Lq6OiBkZXZAZHBkay5vcmcKJmd0OyDmioTpgIE6ICJTdW4gWXVlY2hpIiA8c3VueXVl
Y2hpQGlzY2FzLmFjLmNuPiwgIkJydWNlIFJpY2hhcmRzb24iIDxicnVjZS5yaWNoYXJkc29uQGlu
dGVsLmNvbT4KJmd0OyDkuLvpopg6IFtQQVRDSF0gZGV2dG9vbHM6IGFkZCBSSVNDLVYgdmVjdG9y
IGluIG1lc29uIGJ1aWxkIHRlc3QKJmd0OyAKJmd0OyBTaWduZWQtb2ZmLWJ5OiBTdW4gWXVlY2hp
IDxzdW55dWVjaGlAaXNjYXMuYWMuY24+CiZndDsgLS0tCiZndDsgIGRldnRvb2xzL3Rlc3QtbWVz
b24tYnVpbGRzLnNoIHwgNCArKysrCiZndDsgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKJmd0OyAKJmd0OyBkaWZmIC0tZ2l0IGEvZGV2dG9vbHMvdGVzdC1tZXNvbi1idWlsZHMuc2gg
Yi9kZXZ0b29scy90ZXN0LW1lc29uLWJ1aWxkcy5zaAomZ3Q7IGluZGV4IDRmZmYxZjcxNzcuLjRm
MDdmODRlYjAgMTAwNzU1CiZndDsgLS0tIGEvZGV2dG9vbHMvdGVzdC1tZXNvbi1idWlsZHMuc2gK
Jmd0OyArKysgYi9kZXZ0b29scy90ZXN0LW1lc29uLWJ1aWxkcy5zaAomZ3Q7IEBAIC0yOTAsNiAr
MjkwLDEwIEBAIGJ1aWxkIGJ1aWxkLXBwYzY0LXBvd2VyOC1nY2MgJGYgQUJJICR1c2Vfc2hhcmVk
CiZndDsgIGY9JHNyY2Rpci9jb25maWcvcmlzY3YvcmlzY3Y2NF9saW51eF9nY2MKJmd0OyAgYnVp
bGQgYnVpbGQtcmlzY3Y2NC1nZW5lcmljLWdjYyAkZiBBQkkgJHVzZV9zaGFyZWQKJmd0OyAgCiZn
dDsgKyMgUklTQy1WIHZlY3RvciAocnY2NGdjdikKJmd0OyArZj0kc3JjZGlyL2NvbmZpZy9yaXNj
di9yaXNjdjY0X3J2NjRnY3ZfbGludXhfZ2NjCiZndDsgK2J1aWxkIGJ1aWxkLXJpc2N2NjRfcnY2
NGdjdl9nY2MgJGYgQUJJICR1c2Vfc2hhcmVkCiZndDsgKwomZ3Q7ICAjIFRlc3QgaW5zdGFsbGF0
aW9uIG9mIHRoZSB4ODYtZ2VuZXJpYyB0YXJnZXQsIHRvIGJlIHVzZWQgZm9yIGNoZWNraW5nCiZn
dDsgICMgdGhlIHNhbXBsZSBhcHBzIGJ1aWxkIHVzaW5nIHRoZSBwa2ctY29uZmlnIGZpbGUgZm9y
IGNmbGFncyBhbmQgbGlicwomZ3Q7ICBsb2FkX2VudiBjYwomZ3Q7IC0tIAomZ3Q7IDIuNTEuMgo8
L3N1bnl1ZWNoaUBpc2Nhcy5hYy5jbj48L2JydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPjwvc3Vu
eXVlY2hpQGlzY2FzLmFjLmNuPjwvc3VueXVlY2hpQGlzY2FzLmFjLmNuPg==
