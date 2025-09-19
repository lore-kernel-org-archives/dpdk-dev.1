Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE6CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 17:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E3BB4042F;
	Fri, 19 Sep 2025 19:59:13 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id BC3AF4028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 19:59:10 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [42.177.177.196] ) by
 ajax-webmail-APP-09 (Coremail) ; Sat, 20 Sep 2025 01:59:07 +0800
 (GMT+08:00)
X-Originating-IP: [42.177.177.196]
Date: Sat, 20 Sep 2025 01:59:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: dev@dpdk.org, "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, 
 "Stanislaw Kardach" <stanislaw.kardach@gmail.com>, uk7b@foxmail.com
Subject: Re: Re: [PATCH v3 3/4] lib/fib: R-V V rte_fib_lookup_bulk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <4567272.LM0AJKV5NW@thomas>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
 <tencent_DCD86DAE038B30CC8DA74E95C5C27708B605@qq.com>
 <4567272.LM0AJKV5NW@thomas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <79ae2cb2.300ed.199632141d3.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowAB361Tsmc1oQLAFAA--.2069W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCREKAmjNcNhPEAABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
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

R290IGl0LCB0aGFua3MuCgoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R5Lu2
5Lq6OiAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmphbG9uLm5ldD4KJmd0OyDlj5HpgIHm
l7bpl7Q6IDIwMjUtMDktMjAgMDE6NDg6MTggKOaYn+acn+WFrSkKJmd0OyDmlLbku7bkuro6ICJT
dW4gWXVlY2hpIiA8c3VueXVlY2hpQGlzY2FzLmFjLmNuPgomZ3Q7IOaKhOmAgTogZGV2QGRwZGsu
b3JnLCAiVmxhZGltaXIgTWVkdmVka2luIiA8dmxhZGltaXIubWVkdmVka2luQGludGVsLmNvbT4s
ICJTdGFuaXNsYXcgS2FyZGFjaCIgPHN0YW5pc2xhdy5rYXJkYWNoQGdtYWlsLmNvbT4sIHVrN2JA
Zm94bWFpbC5jb20KJmd0OyDkuLvpopg6IFJlOiBbUEFUQ0ggdjMgMy80XSBsaWIvZmliOiBSLVYg
ViBydGVfZmliX2xvb2t1cF9idWxrCiZndDsgCiZndDsgMTkvMDkvMjAyNSAxODozMywgdWs3YkBm
b3htYWlsLmNvbToKJmd0OyAmZ3Q7IEZyb206IFN1biBZdWVjaGkgPHN1bnl1ZWNoaUBpc2Nhcy5h
Yy5jbj4KJmd0OyAmZ3Q7ICsjaWZuZGVmIF9ESVIyNDhfUlZWX0hfCiZndDsgJmd0OyArI2RlZmlu
ZSBfRElSMjQ4X1JWVl9IXwomZ3Q7ICZndDsgKwomZ3Q7ICZndDsgKyNpbmNsdWRlICJydGVfY3B1
ZmxhZ3MuaCIKJmd0OyAKJmd0OyBJdCBzaG91bGQgYmUKJmd0OyAJI2luY2x1ZGUgPHJ0ZV9jcHVm
bGFncy5oPgomZ3Q7IGFuZCBpdCBzaG91bGQgYmUgb25seSB3aGVyZSByZWFsbHkgbmVlZGVkICgu
YyBwcm9iYWJseSkuCiZndDsgCiZndDsgRG9uJ3QgYm90aGVyIGRvaW5nIGFub3RoZXIgdmVyc2lv
biwgSSdtIHdvcmtpbmcgb24gaXQsCiZndDsgYW5kIHdpbGwgbWVyZ2Ugd2l0aCBjb2Rpbmcgc3R5
bGUgaW1wcm92ZW1lbnRzLgomZ3Q7IAomZ3Q7IAo8L3J0ZV9jcHVmbGFncy5oPjwvc3VueXVlY2hp
QGlzY2FzLmFjLmNuPjwvc3RhbmlzbGF3LmthcmRhY2hAZ21haWwuY29tPjwvdmxhZGltaXIubWVk
dmVka2luQGludGVsLmNvbT48L3N1bnl1ZWNoaUBpc2Nhcy5hYy5jbj48L3Rob21hc0Btb25qYWxv
bi5uZXQ+
