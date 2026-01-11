Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217ACD2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 17:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D34374028F;
	Sun, 11 Jan 2026 18:57:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4B1344013F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 18:57:57 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5B40D206E5;
 Sun, 11 Jan 2026 18:57:56 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
Date: Sun, 11 Jan 2026 18:57:54 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6564C@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAFn2buCsqH5DR9k9rZFek5OyEC3q26G_Cm_u9dUG1=YuWXrgQw@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
Thread-Index: AdyCwpJDdtHF8UquSZW/2zcjU5pgOQAYNQng
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-4-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65648@smartserver.smartshare.dk>
 <CAFn2buCsqH5DR9k9rZFek5OyEC3q26G_Cm_u9dUG1=YuWXrgQw@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Scott Mitchell" <scott.k.mitch1@gmail.com>
Cc: <dev@dpdk.org>, <stephen@networkplumber.org>,
 "Scott" <scott_mitchell@apple.com>
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

PiBGcm9tOiBTY290dCBNaXRjaGVsbCBbbWFpbHRvOnNjb3R0LmsubWl0Y2gxQGdtYWlsLmNvbV0N
Cj4gU2VudDogU3VuZGF5LCAxMSBKYW51YXJ5IDIwMjYgMDcuMjINCj4gDQo+ID4gRG9lcyB0aGlz
IHN0aWxsIGhhcHBlbiBhZnRlciB5b3UgcmVwbGFjZWQgdGhlIFJURV9QVFJfQUREKCkgd2l0aA0K
PiBuYXRpdmUgcG9pbnRlciBhcml0aG1ldGljIGluIHRoZSBjaGVja3N1bSBmdW5jdGlvbj8NCj4g
PiBJbiBvdGhlciB3b3JkczogSXMgdGhpcyB3b3JrYXJvdW5kIHN0aWxsIG5lY2Vzc2FyeT8NCj4g
DQo+IFllcyB1bmZvcnR1bmF0ZWx5IGl0IGlzIG5lY2Vzc2FyeSB3aXRoIHRoZSBwb2ludGVyIGFj
Y2Vzcy4NCj4gSSB1cGRhdGVkIHRoZSByZXByb2R1Y2VyIHdoaWNoIHNob3dzIHRoaXMgY2FzZToN
Cj4gaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vU2NvdHRtaXRjaC9iZjIzNzQ4YjQ1ODhlNjhjOWJk
YjhkMTI0ZjkyZjFiZA0KDQpJIHdvbmRlciBpZiBzb21lIG9mIHRoZSBtYWdpYyB0eXBlcyBpbiBy
dGVfbWVtY3B5KCkgWzFdIGNvdWxkIGJlIHVzZWQgdG8gZml4IHRoZSBhbGlhc2luZy9lbGlkaW5n
IHByb2JsZW0gaW4gdGhlIGNoZWNrc3VtIGZ1bmN0aW9uOg0KDQpzdHJ1Y3QgX19ydGVfcGFja2Vk
X2JlZ2luIHJ0ZV91bmFsaWduZWRfdWludDE2X2FsaWFzIHsNCgl1bmFsaWduZWRfdWludDE2X3Qg
dmFsOw0KfSBfX3J0ZV9wYWNrZWRfZW5kIF9fcnRlX21heV9hbGlhczsNCg0KDQpbMV06IGh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2RwZGsvdjI1LjExL3NvdXJjZS9saWIvZWFsL3g4Ni9pbmNs
dWRlL3J0ZV9tZW1jcHkuaCNMNjYNCg0K
