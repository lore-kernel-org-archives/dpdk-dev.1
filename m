Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32867C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 09:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFEDF4026A;
	Thu, 31 Jul 2025 11:34:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5B0044025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 11:34:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EB4B7209B9;
 Thu, 31 Jul 2025 11:34:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] ethdev: Reject conflicting TX offloads configuration
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 31 Jul 2025 11:34:13 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDD9@smartserver.smartshare.dk>
In-Reply-To: <a2542c91-6a37-94c3-98e9-c237dc0c1d5b@arknetworks.am>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ethdev: Reject conflicting TX offloads configuration
Thread-Index: AdwB/WouVSgRRAaVSueUN0ybaPTpcAAAEeLA
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <a2542c91-6a37-94c3-98e9-c237dc0c1d5b@arknetworks.am>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Ivan Malov" <ivan.malov@arknetworks.am>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

PiBGcm9tOiBJdmFuIE1hbG92IFttYWlsdG86aXZhbi5tYWxvdkBhcmtuZXR3b3Jrcy5hbV0NCj4g
U2VudDogVGh1cnNkYXksIDMxIEp1bHkgMjAyNSAxMS4yOA0KPiANCj4gSGkgTW9ydGVuLA0KPiAN
Cj4gT24gVGh1LCAzMSBKdWwgMjAyNSwgTW9ydGVuIEJyw7hydXAgd3JvdGU6DQo+IA0KPiA+ICsJ
CVJURV9FVEhERVZfTE9HX0xJTkUoRVJSLA0KPiA+ICsJCQkiRXRoZGV2IHBvcnRfaWQ9JWQgVHgg
b2ZmbG9hZCAlcyBjb25mbGljdHMgd2l0aCBUeCBvZmZsb2FkDQo+ICVzIiwNCj4gDQo+IElzIGl0
IHJlcXVpcmVkIHRvIHNwZWxsICdFdGhkZXYgJyBhdCBzdGFydCBvZiB0aGUgbGluZT8gSXQgd2Fz
IG15IGltcHJlc3Npb24NCj4gdGhhdCAnZXRoZGV2JyB3b3VsZCBiZSBwcmludGVkIGFueXdheSBi
eSBbMV0gKHRoZSAnIyB0JyBwYXJ0KS4gQW0gSSB3cm9uZz8NCj4gDQo+IFsxXQ0KPiBodHRwczov
L2dpdGh1Yi5jb20vRFBESy9kcGRrL2Jsb2IvYjIyMjM5NTU2MTYzOGY4OTU2MmU0ZWY0MmUxZWFi
ZjJkNmRiNDNkZC9saWINCj4gL2xvZy9ydGVfbG9nLmgjTDMzNA0KDQpZb3UgYXJlIHJpZ2h0LCBi
dXQgYWxsIHRoZSBvdGhlciBSVEVfRVRIREVWX0xPR19MSU5FKCkgaW4gcnRlX2V0aF9kZXZfY29u
ZmlndXJlKCkgZG8gaXQsIHNvIEkgZGlkIGl0IHRvby4NCg0K
