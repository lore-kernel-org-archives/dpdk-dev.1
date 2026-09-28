Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7955CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:20:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E26D40E0A;
	Mon, 28 Sep 2026 16:20:31 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F052D40DDA;
 Mon, 28 Sep 2026 16:20:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 49DD5201FB;
 Mon, 28 Sep 2026 16:20:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] net: revert add IPv6 traffic class and flow label fields
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 28 Sep 2026 16:20:22 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A80@smartserver.smartshare.dk>
In-Reply-To: <endP4k7ET0iyFdUNMs3orQ@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net: revert add IPv6 traffic class and flow label fields
Thread-Index: Ad1PU97Bw34nn0l9SqSCKwDFQL5oqwAAEBFw
References: <20260922163640.1144749-1-mb@smartsharesystems.com>
 <20260922111408.3b2c7bcf@phoenix.local> <endP4k7ET0iyFdUNMs3orQ@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Maxime Leroy" <maxime@leroys.fr>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBNb25kYXksIDI4IFNlcHRlbWJlciAyMDI2IDE2LjE1DQo+IA0KPiBIZWxsbywgYXJlIHdl
IHdhaXRpbmcgZm9yIGEgdjI/DQoNCk9LLg0KV2lsbCBzZW5kIGEgdjIgd2l0aCBpbXByb3ZlZCBj
b21taXQgbWVzc2FnZSBhbmQgcmVsZWFzZSBub3RlcywgYXMgc3VnZ2VzdGVkIGJ5IFN0ZXBoZW4n
cyBBSS4NCg0KLU1vcnRlbg0KDQo=
