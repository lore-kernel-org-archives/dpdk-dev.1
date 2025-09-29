Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0FCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 13:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 271EC40669;
	Mon, 29 Sep 2025 15:38:34 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id 6780A40668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 15:38:32 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [42.177.188.38] ) by
 ajax-webmail-APP-09 (Coremail) ; Mon, 29 Sep 2025 21:38:29 +0800
 (GMT+08:00)
X-Originating-IP: [42.177.188.38]
Date: Mon, 29 Sep 2025 21:38:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: sunyuechi@iscas.ac.cn
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: dev@dpdk.org, "Stanislaw Kardach" <stanislaw.kardach@gmail.com>
Subject: Re: [PATCH] maintainers: update for RISC-V
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <tencent_7559D52E8BB321BEE2D7B90CAC9A30759E07@qq.com>
References: <tencent_7559D52E8BB321BEE2D7B90CAC9A30759E07@qq.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <50b65476.5d78.19995b2390e.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowACXVyDVi9poyGYAAA--.5182W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCQ8AAmjadrkN8QADsG
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

SGksIEkgbm90aWNlZCB0aGF0IHRoaXMgcGF0Y2ggd2FzIG5vdCBjY+KAmWQgdG8gU3RhbmlzbGF3
IEthcmRhY2gsIApzbyBJ4oCZdmUgYWRkZWQgaGltIGFuZCBqdXN0IHdhbnRlZCB0byBnaXZlIGEg
Z2VudGxlIHBpbmcgdG8gc2VlIGlmIHlvdSBhZ3JlZS4gIApJZiB0aGlzIHBpbmcgaXMgdG9vIGVh
cmx5LCBwbGVhc2UgZmVlbCBmcmVlIHRvIGlnbm9yZSBpdC4KCgomZ3Q7IC0tLS0t5Y6f5aeL6YKu
5Lu2LS0tLS0KJmd0OyDlj5Hku7bkuro6IHVrN2JAZm94bWFpbC5jb20KJmd0OyDlj5HpgIHml7bp
l7Q6IDIwMjUtMDktMjAgMDM6MzA6MDYgKOaYn+acn+WFrSkKJmd0OyDmlLbku7bkuro6IGRldkBk
cGRrLm9yZwomZ3Q7IOaKhOmAgTogIlN1biBZdWVjaGkiIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+
LCAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmphbG9uLm5ldD4KJmd0OyDkuLvpopg6IFtQ
QVRDSF0gbWFpbnRhaW5lcnM6IHVwZGF0ZSBmb3IgUklTQy1WCiZndDsgCiZndDsgRnJvbTogU3Vu
IFl1ZWNoaSA8c3VueXVlY2hpQGlzY2FzLmFjLmNuPgomZ3Q7IAomZ3Q7IEFkZCBteXNlbGYgYXMg
bWFpbnRhaW5lciBmb3IgUklTQy1WLgomZ3Q7IAomZ3Q7IFNpZ25lZC1vZmYtYnk6IFN1biBZdWVj
aGkgPHN1bnl1ZWNoaUBpc2Nhcy5hYy5jbj4KJmd0OyAtLS0KJmd0OyAgTUFJTlRBSU5FUlMgfCAy
ICstCiZndDsgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQom
Z3Q7IAomZ3Q7IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCiZndDsgaW5k
ZXggMWEyNzI5YmU2Ni4uZGYxZDI5NWY5MyAxMDA2NDQKJmd0OyAtLS0gYS9NQUlOVEFJTkVSUwom
Z3Q7ICsrKyBiL01BSU5UQUlORVJTCiZndDsgQEAgLTMzNywxMCArMzM3LDEwIEBAIEY6IGV4YW1w
bGVzL2NvbW1vbi9hbHRpdmVjLwomZ3Q7ICAKJmd0OyAgUklTQy1WCiZndDsgIE06IFN0YW5pc8WC
YXcgS2FyZGFjaCA8c3RhbmlzbGF3LmthcmRhY2hAZ21haWwuY29tPgomZ3Q7ICtNOiBTdW4gWXVl
Y2hpIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+CiZndDsgIEY6IGNvbmZpZy9yaXNjdi8KJmd0OyAg
RjogZG9jL2d1aWRlcy9saW51eF9nc2cvY3Jvc3NfYnVpbGRfZHBka19mb3JfcmlzY3YucnN0CiZn
dDsgIEY6IGxpYi9lYWwvcmlzY3YvCiZndDsgLU06IFN1biBZdWVjaGkgPHN1bnl1ZWNoaUBpc2Nh
cy5hYy5jbj4KJmd0OyAgRjogbGliLyoqLypydnYqCiZndDsgIAomZ3Q7ICBJbnRlbCB4ODYKJmd0
OyAtLSAKJmd0OyAyLjUxLjAKPC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC9zdW55dWVjaGlAaXNj
YXMuYWMuY24+PC9zdGFuaXNsYXcua2FyZGFjaEBnbWFpbC5jb20+PC9zdW55dWVjaGlAaXNjYXMu
YWMuY24+PC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC90aG9tYXNAbW9uamFsb24ubmV0Pjwvc3Vu
eXVlY2hpQGlzY2FzLmFjLmNuPg==
