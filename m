Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6454C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE2B242D80;
	Wed,  4 Jun 2025 15:16:25 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id 843D3402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:16:23 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [116.139.97.45] ) by
 ajax-webmail-APP-09 (Coremail) ; Wed, 4 Jun 2025 21:16:21 +0800 (GMT+08:00)
X-Originating-IP: [116.139.97.45]
Date: Wed, 4 Jun 2025 21:16:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: uk7b@foxmail.com, dev@dpdk.org
Subject: Re: [PATCH v2 0/3] Add RISC-V V extension detection and LPM
 optimization
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <tencent_51258569F10CA9965AA00D6D162FCD45600A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <tencent_51258569F10CA9965AA00D6D162FCD45600A@qq.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2d17956c.286c8.1973b15eac2.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowAB3NZglR0Bo5V4DAA--.28586W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAcDAmhABOvtOQACsb
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

VGhlIHByZXZpb3VzIHYyIHBhdGNoIGluY29ycmVjdGx5IHVzZWQgLS1pbi1yZXBseS10bywgd2hp
Y2ggY2F1c2VkIGEgd2FybmluZyBvbiBQYXRjaHdvcmsuIFRoaXMgdXBkYXRlIG9ubHkgY29ycmVj
dHMgdGhlIFJlcGx5LVRvIGZpZWxkLgoKCiZndDsgLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQomZ3Q7
IOWPkeS7tuS6ujogdWs3YkBmb3htYWlsLmNvbQomZ3Q7IOWPkemAgeaXtumXtDogMjAyNS0wNi0w
NCAyMTowNzozMyAo5pif5pyf5LiJKQomZ3Q7IOaUtuS7tuS6ujogZGV2QGRwZGsub3JnCiZndDsg
5oqE6YCBOiBzdW55dWVjaGkgPHN1bnl1ZWNoaUBpc2Nhcy5hYy5jbj4KJmd0OyDkuLvpopg6IFtQ
QVRDSCB2MiAwLzNdIEFkZCBSSVNDLVYgViBleHRlbnNpb24gZGV0ZWN0aW9uIGFuZCBMUE0gb3B0
aW1pemF0aW9uCiZndDsgCiZndDsgRnJvbTogc3VueXVlY2hpIDxzdW55dWVjaGlAaXNjYXMuYWMu
Y24+CiZndDsgCiZndDsgVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgUklT
Qy1WIFZlY3RvciAoVikgZXh0ZW5zaW9uIGFuZCBwcm92aWRlcwomZ3Q7IGFuIG9wdGltaXplZCBp
bXBsZW1lbnRhdGlvbiBvZiBgcnRlX2xwbV9sb29rdXB4NGAgdXNpbmcgUlZWLiBJdCBpbmNsdWRl
cyBydW50aW1lCiZndDsgZGV0ZWN0aW9uIG9mIHRoZSBWIGV4dGVuc2lvbiwgY29uZGl0aW9uYWwg
Y29tcGlsYXRpb24gYmFzZWQgb24gY29tcGlsZXIgc3VwcG9ydAomZ3Q7IGZvciBSVlYgaW50cmlu
c2ljcy4KJmd0OyAKJmd0OyBUZXN0IHJlc3VsdHMgdXNpbmcgbHBtX3BlcmZfYXV0b3Rlc3Qgb24g
QlBJLUYzOgomZ3Q7ICAgICBzY2FsYXI6IDUuNyBjeWNsZXMKJmd0OyAgICAgcnZ2OiAgICAyLjQg
Y3ljbGVzCiZndDsgCiZndDsgIyMjIHYyOgomZ3Q7IC0gSW1wcm92ZWQgY29tbWl0IG1lc3NhZ2Vz
LgomZ3Q7IAomZ3Q7IHN1bnl1ZWNoaSAoMyk6CiZndDsgICBjb25maWcvcmlzY3Y6IGRldGVjdCBW
IGV4dGVuc2lvbgomZ3Q7ICAgbGliL2xwbTogUi1WIFYgcnRlX2xwbV9sb29rdXB4NAomZ3Q7ICAg
cmlzY3Y6IG92ZXJyaWRlIG1hY2hpbmVfYXJncyBvbmx5IHdoZW4gZGVmYXVsdAomZ3Q7IAomZ3Q7
ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgfCAgMiArCiZndDsgIGNvbmZpZy9yaXNjdi9tZXNv
bi5idWlsZCB8IDI3ICsrKysrKysrKysrKwomZ3Q7ICBsaWIvbHBtL21lc29uLmJ1aWxkICAgICAg
fCAgMSArCiZndDsgIGxpYi9scG0vcnRlX2xwbS5oICAgICAgICB8ICAyICsKJmd0OyAgbGliL2xw
bS9ydGVfbHBtX3J2di5oICAgIHwgOTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwomZ3Q7ICA1IGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspCiZndDsgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBsaWIvbHBtL3J0ZV9scG1fcnZ2LmgKJmd0OyAKJmd0OyAtLQomZ3Q7
IDIuNDkuMAo8L3N1bnl1ZWNoaUBpc2Nhcy5hYy5jbj48L3N1bnl1ZWNoaUBpc2Nhcy5hYy5jbj4=

