Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B70F46139
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:27:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637A740268;
	Mon, 23 Mar 2026 16:27:09 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7E4114025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:27:08 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3AF8B20101;
 Mon, 23 Mar 2026 16:27:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH 0/4] VRF support in FIB library
Date: Mon, 23 Mar 2026 16:27:06 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657B4@smartserver.smartshare.dk>
In-Reply-To: <DHA98WR0DERF.T2XK820FGTF4@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC PATCH 0/4] VRF support in FIB library
Thread-Index: Ady61vkDrEylTxnsTXiRWA1J2GnhfwAAKJQw
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <DHA98WR0DERF.T2XK820FGTF4@redhat.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Robin Jarry" <rjarry@redhat.com>, "Maxime Leroy" <maxime@leroys.fr>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Cc: <dev@dpdk.org>, <nsaxena16@gmail.com>, <adwivedi@marvell.com>,
 <jerinjacobk@gmail.com>, "Stephen Hemminger" <stephen@networkplumber.org>
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

TGV0J3MgdGFrZSBhIGxldmVsIHVwIGluIGFic3RyYWN0aW9uLCBhbmQgY29uc2lkZXIgb25lIG9m
IHRoZSBrZXkgZGVzaWduIGdvYWxzOg0KV2hhdCBhcmUgdGhlIHR5cGljYWwgdXNlIGNhc2VzIHdl
IHdhbnQgVlJGIHN1cHBvcnQgZGVzaWduZWQgZm9yPw0KDQpJIGNhbiBpbWFnaW5lIGEgdXNlIGNh
c2Ugd2l0aCBvbmUgb3IgdmVyeSBmZXcgVlJGcyB3aXRoIGEgdmVyeSBsYXJnZSAoaW50ZXJuZXQp
IHJvdXRlIHRhYmxlLCBhbmQgbWFueSBWUkZzIHdpdGggc21hbGwgKHByaXZhdGUpIHJvdXRlIHRh
Ymxlcy4NCg0KUFM6IEkgaGF2ZSBubyBleHBlcmllbmNlIHdpdGggdGhlIERQREsgRklCIGxpYnJh
cnksIHNvIG15IGZlZWRiYWNrIG1pZ2h0IGJlIGNvbXBsZXRlbHkgb2ZmLg0KDQo=
