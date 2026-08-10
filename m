Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC341C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 16:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F40A240272;
	Mon, 10 Aug 2026 18:10:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 57EFA40144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 18:10:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EDE4D22827;
 Mon, 10 Aug 2026 18:10:00 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC v4 0/3] lib/fastmem: fast small-object allocator
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 10 Aug 2026 18:09:59 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659D1@smartserver.smartshare.dk>
In-Reply-To: <20260530092634.46218-1-hofors@lysator.liu.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v4 0/3] lib/fastmem: fast small-object allocator
Thread-Index: AdzwFnC6PcqguVQGTcO68QT8O8iIhw4yvN1Q
References: <20260527173042.93867-2-hofors@lysator.liu.se>
 <20260530092634.46218-1-hofors@lysator.liu.se>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>,
 <dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>,
 "Yogaraj Baskaravel" <yogaraj.baskaravel@ericsson.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

PiAzLiBQZXItbGNvcmUgY2FjaGVzOiBib3VuZGVkIExJRk8gc3RhY2tzIChubyBsb2NrcyBvbiB0
aGUgaG90DQo+ICAgIHBhdGgpLiBDYWNoZSBtaXNzZXMgdHJpZ2dlciBidWxrIHRyYW5zZmVycyB0
by9mcm9tIHRoZSBzaGFyZWQNCj4gICAgYmluIHVuZGVyIGEgc3BpbmxvY2suDQoNCkkgaGF2ZW4n
dCBsb29rZWQgYXQgdGhlIHY0IGNvZGUgaW4gZGV0YWlsLCBzbyBmb3JnaXZlIG1lIGlmIG15IGNv
bmNlcm4gaXMgYWxyZWFkeSBhZGRyZXNzZWQuDQoNCkkgYW0gd29ycmllZCB0aGF0IGEgbm9uLUVB
TCB0aHJlYWQgY2FuIGJlIHByZWVtcHRlZCB3aGlsZSBob2xkaW5nIGEgZmFzdG1lbSBsb2NrLg0K
Q291bGQgdGhpcyBjYXVzZSBhbiBFQUwgdGhyZWFkIHRvIHN0YWxsIGluIHRoZSBmYXN0bWVtIGxp
YiB1bmRlciB0aGUgd3JvbmcgY2lyY3Vtc3RhbmNlcz8NCklmIHNvLCBjYW4gdGhpcyBiZSBhdm9p
ZGVkIGluIGFueSB3YXk/DQoNClRoZSBMb2NrLUZyZWUgU3RhY2sgaGFzIGEgc29sdXRpb24gdXNp
bmcgc2luZ2xlLWxpbmtlZCBsaXN0cyBhbmQgYSAxMjgtYml0IENBUyBvcGVyYXRpb24uDQpUaGUg
c29sdXRpb24gaXMgcXVpdGUgc2xvdyAoZHVlIHRvIGxpbmtlZCBsaXN0IHRyYXZlcnNhbCB3aXRo
IHJldHJ5IG9uIGNvbGxpc2lvbiksIGJ1dCBwcm9ncmVzcyBpcyBwcmFjdGljYWxseSBndWFyYW50
ZWVkLg0KDQo=
