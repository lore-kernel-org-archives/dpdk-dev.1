Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CAFCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 419694042F;
	Fri, 19 Sep 2025 18:37:22 +0200 (CEST)
Received: from cstnet.cn (smtp83.cstnet.cn [159.226.251.83])
 by mails.dpdk.org (Postfix) with ESMTP id 5019B402D0
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:37:20 +0200 (CEST)
Received: from sunyuechi$iscas.ac.cn ( [42.177.177.196] ) by
 ajax-webmail-APP-09 (Coremail) ; Sat, 20 Sep 2025 00:37:17 +0800
 (GMT+08:00)
X-Originating-IP: [42.177.177.196]
Date: Sat, 20 Sep 2025 00:37:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: dev@dpdk.org, "Stanislaw Kardach" <stanislaw.kardach@gmail.com>, 
 uk7b@foxmail.com
Subject: Re: Re: [PATCH v2 2/5] eal/riscv/spinlock: add rte_cpuflag.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <40834601.10thIPus4b@thomas>
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
 <40834601.10thIPus4b@thomas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <40a240e5.30087.19962d65496.Coremail.sunyuechi@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: swCowADnHFa9hs1owq4FAA--.62585W
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAYKAmjNcTQw8QABsi
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

T2theSwgSSBpbml0aWFsbHkgdGhvdWdodCB0aGlzIHdhcyBjb21tb24gcHJhY3RpY2UgYWNyb3Nz
IGFsbCBhcmNoaXRlY3R1cmVzLCBidXQgaXQgdHVybnMgb3V0IG9ubHkgeDg2IGFkZGVkICNpbmNs
dWRlICJydGVfY3B1ZmxhZ3MuaCIgaGVyZS4KSeKAmXZlIG5vdyBtb3ZlZCBpdCB0byBsaWIvZmli
L2RpcjI0XzhfcnZ2LmggYW5kIHVwZGF0ZWQgdjMuCgoKJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0t
LS0tCiZndDsg5Y+R5Lu25Lq6OiAiVGhvbWFzIE1vbmphbG9uIiA8dGhvbWFzQG1vbmphbG9uLm5l
dD4KJmd0OyDlj5HpgIHml7bpl7Q6IDIwMjUtMDktMTkgMjM6MTM6MTkgKOaYn+acn+S6lCkKJmd0
OyDmlLbku7bkuro6ICJTdW4gWXVlY2hpIiA8c3VueXVlY2hpQGlzY2FzLmFjLmNuPgomZ3Q7IOaK
hOmAgTogZGV2QGRwZGsub3JnLCAiU3RhbmlzbGF3IEthcmRhY2giIDxzdGFuaXNsYXcua2FyZGFj
aEBnbWFpbC5jb20+LCB1azdiQGZveG1haWwuY29tCiZndDsg5Li76aKYOiBSZTogW1BBVENIIHYy
IDIvNV0gZWFsL3Jpc2N2L3NwaW5sb2NrOiBhZGQgcnRlX2NwdWZsYWcuaAomZ3Q7IAomZ3Q7IDAx
LzA3LzIwMjUgMjA6MjAsIHVrN2JAZm94bWFpbC5jb206CiZndDsgJmd0OyBGcm9tOiBTdW4gWXVl
Y2hpIDxzdW55dWVjaGlAaXNjYXMuYWMuY24+CiZndDsgJmd0OyAKJmd0OyAmZ3Q7IFNhbWUgYXMg
dGhlIHg4NiBzdHlsZSwgaW5jbHVkZSAicnRlX2NwdWZsYWdzLmgiIGluIHJ0ZV9zcGlubG9jay5o
CiZndDsgJmd0OyBzbyB0aGF0IGZpbGVzIGxpa2UgbGliL2ZpYi9kaXIyNF84LmMgZG9u4oCZdCBu
ZWVkIHRvIGluY2x1ZGUgaXQuCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IFNpZ25lZC1vZmYtYnk6IFN1
biBZdWVjaGkgPHN1bnl1ZWNoaUBpc2Nhcy5hYy5jbj4KJmd0OyAKJmd0OyBJIGRpc2FncmVlLgom
Z3Q7IEkgcHJlZmVyIHJlbW92aW5nIHVzZWxlc3MgaW5jbHVkZXMgbGlrZSBpbiB4ODYgc3Bpbmxv
Y2suCiZndDsgCjwvc3VueXVlY2hpQGlzY2FzLmFjLmNuPjwvc3VueXVlY2hpQGlzY2FzLmFjLmNu
Pjwvc3RhbmlzbGF3LmthcmRhY2hAZ21haWwuY29tPjwvc3VueXVlY2hpQGlzY2FzLmFjLmNuPjwv
dGhvbWFzQG1vbmphbG9uLm5ldD4=
