Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F32C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 12:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37A40402B8;
	Wed, 12 Aug 2026 14:08:55 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 056A34027E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 14:08:53 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CBADB22820;
 Wed, 12 Aug 2026 14:08:52 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC PATCH v2] mempool: optimizations
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 12 Aug 2026 14:08:50 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659D9@smartserver.smartshare.dk>
In-Reply-To: <20260812095836.1771949-1-mb@smartsharesystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH v2] mempool: optimizations
Thread-Index: Ad0qQSZqyIFluTFeR3Gn8542fswmrQAEepYw
References: <20260812095836.1771949-1-mb@smartsharesystems.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>,
	"Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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

UExFQVNFIElHTk9SRS4NCi0taW4tcmVwbHktdG8gd2FzIG1pc3NpbmcuDQpJIGhhdmUgc2VudCBh
bm90aGVyIG1haWwgd2l0aCAtLWluLXJlcGx5LXRvLg0KDQoNClZlbmxpZyBoaWxzZW4gLyBLaW5k
IHJlZ2FyZHMsDQotTW9ydGVuIEJyw7hydXANCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IE1vcnRlbiBCcsO4cnVwIFttYWlsdG86bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIDEyIEF1Z3VzdCAyMDI2IDExLjU5DQo+IFRvOiBkZXZA
ZHBkay5vcmc7IEFuZHJldyBSeWJjaGVua28NCj4gQ2M6IE1vcnRlbiBCcsO4cnVwDQo+IFN1Ympl
Y3Q6IFtSRkMgUEFUQ0ggdjJdIG1lbXBvb2w6IG9wdGltaXphdGlvbnMNCg==
