Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADBC83F1A
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Jul 2025 01:50:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9E3402C4;
	Sat, 12 Jul 2025 03:50:45 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id 5A5694013F
 for <dev@dpdk.org>; Sat, 12 Jul 2025 03:50:42 +0200 (CEST)
Received: from liujie5$linkdatatechnology.com ( [60.29.3.194] ) by
 ajax-webmail-APP-09 (Coremail) ; Sat, 12 Jul 2025 09:50:40 +0800
 (GMT+08:00)
X-Originating-IP: [60.29.3.194]
Date: Sat, 12 Jul 2025 09:50:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5YiY5rSB?= <liujie5@linkdatatechnology.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: Re: [PATCH v4 04/14] net/sxe: add link, flow ctrl, mac ops, mtu
 ops function
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <20250709090930.10bb8130@hermes.local>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250709084315.9940-1-liujie5@linkdatatechnology.com>
 <20250709084315.9940-4-liujie5@linkdatatechnology.com>
 <20250709090930.10bb8130@hermes.local>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <740842a2.37f15.197fc53ce1a.Coremail.liujie5@linkdatatechnology.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowABns9Bwv3FoD5cCAA--.30887W
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/1tbiBgwADmhxKK6i FAABss
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

CgoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R5Lu25Lq6OiAiU3RlcGhlbiBI
ZW1taW5nZXIiIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4KJmd0OyDlj5HpgIHml7bpl7Q6
IDIwMjUtMDctMTAgMDA6MDk6MzAgKOaYn+acn+WbmykKJmd0OyDmlLbku7bkuro6ICJKaWUgTGl1
IiA8bGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tPgomZ3Q7IOaKhOmAgTogZGV2QGRwZGsu
b3JnCiZndDsg5Li76aKYOiBSZTogW1BBVENIIHY0IDA0LzE0XSBuZXQvc3hlOiBhZGQgbGluaywg
ZmxvdyBjdHJsLCBtYWMgb3BzLCBtdHUgb3BzIGZ1bmN0aW9uCiZndDsgCiZndDsgT24gV2VkLCAg
OSBKdWwgMjAyNSAwNDo0MzowNCAtMDQwMAomZ3Q7IEppZSBMaXUgPGxpdWppZTVAbGlua2RhdGF0
ZWNobm9sb2d5LmNvbT4gd3JvdGU6CiZndDsgCiZndDsgJmd0OyArCVJURV9BVE9NSUMoYm9vbCls
aW5rX3RocmVhZF9ydW5uaW5nOwomZ3Q7ICZndDsgKwlSVEVfQVRPTUlDKGJvb2wpaXNfc3RvcHBp
bmc7CiZndDsgCiZndDsgRGVzcGl0ZSB3aGF0IGNoZWNrcGF0Y2ggc2F5cywgbmVlZCBzcGFjZSBo
ZXJlOgomZ3Q7IAlSVEVfQVRPTUlDKGJvb2wpIGlzX3N0b3BwaW5nOwomZ3Q7IAomZ3Q7ICZndDsg
KwlydGVfdGhyZWFkX3QgbGlua190aHJlYWRfdGlkOwomZ3Q7ICZndDsgKwlydGVfYXRvbWljMzJf
dCBsaW5rX3RocmVhZF9ydW5uaW5nOwomZ3Q7IAomZ3Q7IERvbid0IHVzZSBvbGQgcnRlIGF0b21p
Y3MsIGluc3RlYWQgdXNlIFJURV9BVE9NSUMoKSBjb25zaXN0ZW50bHkKJmd0OyAKJmd0OyAmZ3Q7
ICsJcnRlX2F0b21pYzMyX3QgaXNfc3RvcHBpbmc7CiZndDsgJmd0OyArCXB0aHJlYWRfdCBsaW5r
X3RocmVhZF90aWQ7CiZndDsgCiZndDsgVHdvIHN0cnVjdCBlbGVtZW50cyB3aXRoIHNhbWUgbmFt
ZSwgaG93IGRvZXMgdGhhdCB3b3JrPwomZ3Q7IAomZ3Q7ICZndDsgKwlib29sIGlzX3N0b3BwZWQ7
CgpUaGlzIHdpbGwgYmUgZnVsbHkgcmV2aXNlZCBpbiB0aGUgMTR0aCBwYXRjaCwgc28gcGxlYXNl
IGRvbid0IHdvcnJ5LjwvbGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tPjwvbGl1amllNUBs
aW5rZGF0YXRlY2hub2xvZ3kuY29tPjwvc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+
