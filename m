Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE6C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 04:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9B5A402AE;
	Fri, 27 Jun 2025 06:03:35 +0200 (CEST)
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
 by mails.dpdk.org (Postfix) with ESMTP id 99EDA40277
 for <dev@dpdk.org>; Fri, 27 Jun 2025 06:03:33 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [182.255.32.10] ) by
 ajax-webmail-APP-12 (Coremail) ; Fri, 27 Jun 2025 12:03:30 +0800
 (GMT+08:00)
X-Originating-IP: [182.255.32.10]
Date: Fri, 27 Jun 2025 12:03:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Cc: uk7b@foxmail.com, dev@dpdk.org, 
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: Re: [PATCH v5 3/3] riscv: override machine_args only when default
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <CAJcPQBra-tp_66-R8L7Yd0MFOZ5rG4tPv4kMVv3RhbNpLiiqCw@mail.gmail.com>
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
 <20250611145915.854026-1-uk7b@foxmail.com>
 <tencent_A06B260C88274A75C9E26748A3F8612E1005@qq.com>
 <CAJcPQBra-tp_66-R8L7Yd0MFOZ5rG4tPv4kMVv3RhbNpLiiqCw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5212ae9e.172bd.197af8e0a17.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowADXVvwSGF5oDn0IAA--.46775W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBg0GAmhd3xLM6gABsQ
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

T2theSwgdGhleSBoYXZlIGJlZW4gdXBkYXRlZCBpbiB2Ni4KCgomZ3Q7IC0tLS0t5Y6f5aeL6YKu
5Lu2LS0tLS0KJmd0OyDlj5Hku7bkuro6ICJTdGFuaXPFgmF3IEthcmRhY2giIDxzdGFuaXNsYXcu
a2FyZGFjaEBnbWFpbC5jb20+CiZndDsg5Y+R6YCB5pe26Ze0OiAyMDI1LTA2LTI3IDEwOjMxOjE1
ICjmmJ/mnJ/kupQpCiZndDsg5pS25Lu25Lq6OiB1azdiQGZveG1haWwuY29tCiZndDsg5oqE6YCB
OiBkZXZAZHBkay5vcmcsICJTdW4gWXVlY2hpIiA8c3VueXVlY2hpQGlzY2FzLmFjLmNuPiwgIkJy
dWNlIFJpY2hhcmRzb24iIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4KJmd0OyDkuLvpopg6
IFJlOiBbUEFUQ0ggdjUgMy8zXSByaXNjdjogb3ZlcnJpZGUgbWFjaGluZV9hcmdzIG9ubHkgd2hl
biBkZWZhdWx0CiZndDsgCiZndDsgT24gV2VkLCBKdW4gMTEsIDIwMjUgYXQgNToyM+KAr1BNIDx1
azdiQGZveG1haWwuY29tPiB3cm90ZToKJmd0OyAmZ3Q7CiZndDsgJmd0OyBGcm9tOiBTdW4gWXVl
Y2hpIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+CiZndDsgJmd0OwomZ3Q7ICZndDsgU3VwcG9ydCB1
c2luZyAtRGNwdV9pbnN0cnVjdGlvbl9zZXQ9cnY2NGdjdiB0byBlbmFibGUgViBleHRlbnNpb24u
CiZndDsgJmd0OwomZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogU3VuIFl1ZWNoaSA8c3VueXVlY2hp
QGlzY2FzLmFjLmNuPgomZ3Q7ICZndDsgLS0tCiZndDsgJmd0OyAgY29uZmlnL3Jpc2N2L21lc29u
LmJ1aWxkIHwgMiArKwomZ3Q7ICZndDsgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
Jmd0OyAmZ3Q7CiZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvY29uZmlnL3Jpc2N2L21lc29uLmJ1aWxk
IGIvY29uZmlnL3Jpc2N2L21lc29uLmJ1aWxkCiZndDsgJmd0OyBpbmRleCBlMzY5NGNmMmU2Li4x
MDM2YTg2ZDA1IDEwMDY0NAomZ3Q7ICZndDsgLS0tIGEvY29uZmlnL3Jpc2N2L21lc29uLmJ1aWxk
CiZndDsgJmd0OyArKysgYi9jb25maWcvcmlzY3YvbWVzb24uYnVpbGQKJmd0OyAmZ3Q7IEBAIC0x
MTEsNiArMTExLDcgQEAgYXJjaF9jb25maWcgPSBhcmNoX2NvbmZpZ1thcmNoX2lkXQomZ3Q7ICZn
dDsgICMgQ29uY2F0ZW5hdGUgZmxhZ3MgcmVzcGVjdGluZyBwcmlvcml0aWVzLgomZ3Q7ICZndDsg
IGRwZGtfZmxhZ3MgPSBmbGFnc19jb21tb24gKyB2ZW5kb3JfY29uZmlnWydmbGFncyddICsgYXJj
aF9jb25maWcuZ2V0KCdmbGFncycsIFtdKQomZ3Q7ICZndDsKJmd0OyAmZ3Q7ICtpZiAoY3B1X2lu
c3RydWN0aW9uX3NldCA9PSAncnY2NGdjJykKJmd0OyBQZXJoYXBzIGluc3RlYWQgb2YgcmVtb3Zp
bmcgZnVsbCBmbGFnIGN1c3RvbWl6YXRpb24sIHdlIHNob3VsZCBza2lwCiZndDsgdGhlIC1tYXJj
aCBmbGFnIHdpdGhpbiBmb3JlYWNoIGlmIGNwdV9pbnN0cnVjdGlvbl9zZXQhPSdydjY0Z2MnLgom
Z3Q7IFJlYXNvbiBiZWluZyB0aGF0IGp1c3QgJ3J2NjRnYycgZG9lc24ndCBtZWFuIHRoZSBkZWZh
dWx0LiBMb29rIGF0CiZndDsgU2lGaXZlIGNvbmZpZ3MgLSB0aGV5IGhhdmUgLW1hcmNoPXJ2NjRn
YyBidXQgLW10dW5lIHNwZWNpZmljIHRvIHRob3NlCiZndDsgYm9hcmRzLgomZ3Q7ICZndDsgICMg
YXBwbHkgc3VwcG9ydGVkIG1hY2hpbmUgYXJncwomZ3Q7ICZndDsgIG1hY2hpbmVfYXJncyA9IFtd
ICMgQ2xlYXIgcHJldmlvdXMgbWFjaGluZSBhcmdzCiZndDsgJmd0OyAgZm9yZWFjaCBmbGFnOiBh
cmNoX2NvbmZpZ1snbWFjaGluZV9hcmdzJ10KJmd0OyAmZ3Q7IEBAIC0xMTgsNiArMTE5LDcgQEAg
Zm9yZWFjaCBmbGFnOiBhcmNoX2NvbmZpZ1snbWFjaGluZV9hcmdzJ10KJmd0OyAmZ3Q7ICAgICAg
ICAgIG1hY2hpbmVfYXJncyArPSBmbGFnCiZndDsgJmd0OyAgICAgIGVuZGlmCiZndDsgJmd0OyAg
ZW5kZm9yZWFjaAomZ3Q7ICZndDsgK2VuZGlmCiZndDsgU21hbGwgbml0IC0gdGhlcmUncyBhbiBp
bmRlbnRhdGlvbiBsZXZlbCBtaXNzaW5nIGFyb3VuZCAjaWYtI2VuZGlmCiZndDsgCiZndDsgJmd0
OwomZ3Q7ICZndDsgICMgY2hlY2sgaWYgd2UgY2FuIGRvIGJ1aWxkdGltZSBkZXRlY3Rpb24gb2Yg
ZXh0ZW5zaW9ucyBzdXBwb3J0ZWQgYnkgdGhlIHRhcmdldAomZ3Q7ICZndDsgIHJpc2N2X2V4dGVu
c2lvbl9tYWNyb3MgPSBmYWxzZQomZ3Q7ICZndDsgLS0KJmd0OyAmZ3Q7IDIuNDkuMAomZ3Q7ICZn
dDsKPC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC9zdW55dWVjaGlAaXNjYXMuYWMuY24+PC91azdi
QGZveG1haWwuY29tPjwvYnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+PC9zdW55dWVjaGlAaXNj
YXMuYWMuY24+PC9zdGFuaXNsYXcua2FyZGFjaEBnbWFpbC5jb20+
