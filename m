Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F9CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 12:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205A8402F0;
	Fri, 31 Oct 2025 13:26:30 +0100 (CET)
Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
 by mails.dpdk.org (Postfix) with ESMTP id D7CE840150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 13:26:28 +0100 (CET)
Received: from sunyuechi$iscas.ac.cn ( [202.96.88.193] ) by
 ajax-webmail-APP-10 (Coremail) ; Fri, 31 Oct 2025 20:26:24 +0800
 (GMT+08:00)
X-Originating-IP: [202.96.88.193]
Date: Fri, 31 Oct 2025 20:26:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: sunyuechi@iscas.ac.cn
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: dev@dpdk.org, "Stanislaw Kardach" <stanislaw.kardach@gmail.com>
Subject: Re: Re: Re: [PATCH] maintainers: update for RISC-V
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <3f429955.1c168.199ce4a76fd.Coremail.sunyuechi@iscas.ac.cn>
References: <tencent_7559D52E8BB321BEE2D7B90CAC9A30759E07@qq.com>
 <50b65476.5d78.19995b2390e.Coremail.sunyuechi@iscas.ac.cn>
 <3f429955.1c168.199ce4a76fd.Coremail.sunyuechi@iscas.ac.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <76c93add.62992.19a3a3bbbbb.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tACowABHYNLxqgRpEn4AAA--.6376W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCREMAmkEg8FYvQABsd
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

UGluZwoKCiZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7IOWPkeS7tuS6ujogc3VueXVl
Y2hpQGlzY2FzLmFjLmNuCiZndDsg5Y+R6YCB5pe26Ze0OiAyMDI1LTEwLTEwIDIxOjIzOjMwICjm
mJ/mnJ/kupQpCiZndDsg5pS25Lu25Lq6OiAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmph
bG9uLm5ldD4KJmd0OyDmioTpgIE6IGRldkBkcGRrLm9yZywgIlN0YW5pc2xhdyBLYXJkYWNoIiA8
c3RhbmlzbGF3LmthcmRhY2hAZ21haWwuY29tPgomZ3Q7IOS4u+mimDogUmU6IFJlOiBbUEFUQ0hd
IG1haW50YWluZXJzOiB1cGRhdGUgZm9yIFJJU0MtVgomZ3Q7IAomZ3Q7IEhpLCBob3cgaXMgdGhp
cyBwYXRjaD8KJmd0OyAKJmd0OyAKJmd0OyAmZ3Q7IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KJmd0
OyAmZ3Q7IOWPkeS7tuS6ujogc3VueXVlY2hpQGlzY2FzLmFjLmNuCiZndDsgJmd0OyDlj5HpgIHm
l7bpl7Q6IDIwMjUtMDktMjkgMjE6Mzg6MjkgKOaYn+acn+S4gCkKJmd0OyAmZ3Q7IOaUtuS7tuS6
ujogIlRob21hcyBNb25qYWxvbiIgPHRob21hc0Btb25qYWxvbi5uZXQ+CiZndDsgJmd0OyDmioTp
gIE6IGRldkBkcGRrLm9yZywgIlN0YW5pc2xhdyBLYXJkYWNoIiA8c3RhbmlzbGF3LmthcmRhY2hA
Z21haWwuY29tPgomZ3Q7ICZndDsg5Li76aKYOiBSZTogW1BBVENIXSBtYWludGFpbmVyczogdXBk
YXRlIGZvciBSSVNDLVYKJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgSGksIEkgbm90aWNlZCB0aGF0IHRo
aXMgcGF0Y2ggd2FzIG5vdCBjY+KAmWQgdG8gU3RhbmlzbGF3IEthcmRhY2gsIAomZ3Q7ICZndDsg
c28gSeKAmXZlIGFkZGVkIGhpbSBhbmQganVzdCB3YW50ZWQgdG8gZ2l2ZSBhIGdlbnRsZSBwaW5n
IHRvIHNlZSBpZiB5b3UgYWdyZWUuICAKJmd0OyAmZ3Q7IElmIHRoaXMgcGluZyBpcyB0b28gZWFy
bHksIHBsZWFzZSBmZWVsIGZyZWUgdG8gaWdub3JlIGl0LgomZ3Q7ICZndDsgCiZndDsgJmd0OyAK
Jmd0OyAmZ3Q7ICZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7ICZndDsgJmd0OyDlj5Hk
u7bkuro6IHVrN2JAZm94bWFpbC5jb20KJmd0OyAmZ3Q7ICZndDsg5Y+R6YCB5pe26Ze0OiAyMDI1
LTA5LTIwIDAzOjMwOjA2ICjmmJ/mnJ/lha0pCiZndDsgJmd0OyAmZ3Q7IOaUtuS7tuS6ujogZGV2
QGRwZGsub3JnCiZndDsgJmd0OyAmZ3Q7IOaKhOmAgTogIlN1biBZdWVjaGkiIDxzdW55dWVjaGlA
aXNjYXMuYWMuY24+LCAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmphbG9uLm5ldD4KJmd0
OyAmZ3Q7ICZndDsg5Li76aKYOiBbUEFUQ0hdIG1haW50YWluZXJzOiB1cGRhdGUgZm9yIFJJU0Mt
VgomZ3Q7ICZndDsgJmd0OyAKJmd0OyAmZ3Q7ICZndDsgRnJvbTogU3VuIFl1ZWNoaSA8c3VueXVl
Y2hpQGlzY2FzLmFjLmNuPgomZ3Q7ICZndDsgJmd0OyAKJmd0OyAmZ3Q7ICZndDsgQWRkIG15c2Vs
ZiBhcyBtYWludGFpbmVyIGZvciBSSVNDLVYuCiZndDsgJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgJmd0
OyBTaWduZWQtb2ZmLWJ5OiBTdW4gWXVlY2hpIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+CiZndDsg
Jmd0OyAmZ3Q7IC0tLQomZ3Q7ICZndDsgJmd0OyAgTUFJTlRBSU5FUlMgfCAyICstCiZndDsgJmd0
OyAmZ3Q7ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKJmd0
OyAmZ3Q7ICZndDsgCiZndDsgJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01B
SU5UQUlORVJTCiZndDsgJmd0OyAmZ3Q7IGluZGV4IDFhMjcyOWJlNjYuLmRmMWQyOTVmOTMgMTAw
NjQ0CiZndDsgJmd0OyAmZ3Q7IC0tLSBhL01BSU5UQUlORVJTCiZndDsgJmd0OyAmZ3Q7ICsrKyBi
L01BSU5UQUlORVJTCiZndDsgJmd0OyAmZ3Q7IEBAIC0zMzcsMTAgKzMzNywxMCBAQCBGOiBleGFt
cGxlcy9jb21tb24vYWx0aXZlYy8KJmd0OyAmZ3Q7ICZndDsgIAomZ3Q7ICZndDsgJmd0OyAgUklT
Qy1WCiZndDsgJmd0OyAmZ3Q7ICBNOiBTdGFuaXPFgmF3IEthcmRhY2ggPHN0YW5pc2xhdy5rYXJk
YWNoQGdtYWlsLmNvbT4KJmd0OyAmZ3Q7ICZndDsgK006IFN1biBZdWVjaGkgPHN1bnl1ZWNoaUBp
c2Nhcy5hYy5jbj4KJmd0OyAmZ3Q7ICZndDsgIEY6IGNvbmZpZy9yaXNjdi8KJmd0OyAmZ3Q7ICZn
dDsgIEY6IGRvYy9ndWlkZXMvbGludXhfZ3NnL2Nyb3NzX2J1aWxkX2RwZGtfZm9yX3Jpc2N2LnJz
dAomZ3Q7ICZndDsgJmd0OyAgRjogbGliL2VhbC9yaXNjdi8KJmd0OyAmZ3Q7ICZndDsgLU06IFN1
biBZdWVjaGkgPHN1bnl1ZWNoaUBpc2Nhcy5hYy5jbj4KJmd0OyAmZ3Q7ICZndDsgIEY6IGxpYi8q
Ki8qcnZ2KgomZ3Q7ICZndDsgJmd0OyAgCiZndDsgJmd0OyAmZ3Q7ICBJbnRlbCB4ODYKJmd0OyAm
Z3Q7ICZndDsgLS0gCiZndDsgJmd0OyAmZ3Q7IDIuNTEuMAomZ3Q7ICZndDsgPC9zdW55dWVjaGlA
aXNjYXMuYWMuY24+PC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC9zdGFuaXNsYXcua2FyZGFjaEBn
bWFpbC5jb20+PC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC9zdW55dWVjaGlAaXNjYXMuYWMuY24+
PC90aG9tYXNAbW9uamFsb24ubmV0Pjwvc3VueXVlY2hpQGlzY2FzLmFjLmNuPgomZ3Q7IDwvc3Rh
bmlzbGF3LmthcmRhY2hAZ21haWwuY29tPjwvdGhvbWFzQG1vbmphbG9uLm5ldD4KPC9zdGFuaXNs
YXcua2FyZGFjaEBnbWFpbC5jb20+PC90aG9tYXNAbW9uamFsb24ubmV0Pg==
