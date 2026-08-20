Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E6C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 10:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D51D2402D1;
	Thu, 20 Aug 2026 12:00:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AFF3E40150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 12:00:23 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 81D85207DD;
 Thu, 20 Aug 2026 12:00:23 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC] increase name sizes and reorder structures
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 20 Aug 2026 12:00:22 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A03@smartserver.smartshare.dk>
In-Reply-To: <20260813171418.568620-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] increase name sizes and reorder structures
Thread-Index: Ad0rRzTS15DWuUJGRBuGN5G5Hnl2xwFP9Uaw
References: <20260813171418.568620-1-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Anurag Mandal" <anurag.mandal@intel.com>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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

QW51cmFnIHJhaXNlZCBhbiBpbnRlcmVzdGluZyBxdWVzdGlvbiByZWdhcmRpbmcgQnVnIDE5ODAg
WzFdLCB3aGljaCBnb3QgbWUgdGhpbmtpbmcuLi4NCg0KTm93IHRoYXQgdGhlIG1heCBtZW1wb29s
IG5hbWUgbGVuZ3RoIGhhcyBpbmNyZWFzZWQgYnkgdGhyZWUgYnl0ZXMsIGl0IGlzIHNhZmUgdG8g
cmVkdWNlIGJ5IG9uZSBieXRlIHdpdGhvdXQgYnJlYWtpbmcgZXhpc3RpbmcgYXBwbGljYXRpb25z
IHVzaW5nIGxvbmcgbWVtcG9vbCBuYW1lcy4NCg0KSG93IGFib3V0IGFkZGluZyBhIG1vZGlmaWNh
dGlvbiBvZiBydGVfbWVtcG9vbC5oIFsyXSBsaWtlIHRoaXMgKHVudGVzdGVkKSwgdG8gZml4IEJ1
ZyAxOTgwIChhdCBsZWFzdCBmb3Igc3RhY2sgZHJpdmVycyk6DQoNCi0vKio8IE1heGltdW0gbGVu
Z3RoIG9mIGEgbWVtb3J5IHBvb2wncyBuYW1lLiAqLw0KLSNkZWZpbmUgUlRFX01FTVBPT0xfTkFN
RVNJWkUgKFJURV9SSU5HX05BTUVTSVpFIC0gXA0KLQkJCSAgICAgIHNpemVvZihSVEVfTUVNUE9P
TF9NWl9QUkVGSVgpICsgMSkNCg0KKy8qKg0KKyAqIE1heGltdW0gbGVuZ3RoIG9mIGEgbWVtb3J5
IHBvb2wncyBuYW1lLg0KKyAqDQorICogTmVlZHMgcm9vbSBmb3IgbWVtem9uZSBwcmVmaXggaW5k
aWNhdGluZyAibWVtcG9vbCIgdHlwZToNCisgKiAiTVBfPG5hbWU+Ig0KKyAqIE5vdGU6DQorICog
VGhlIG1lbXBvb2wgZHJpdmVyIG5lZWRzIHJvb20gZm9yIGl0cyBvd24gbWVtem9uZSBwcmVmaXgg
dG9vLCBlLmcuOg0KKyAqICJSR19NUF88bmFtZT4iIChyaW5nIGRyaXZlcikgb3IgIlNUS19NUF88
bmFtZT4iIChzdGFjayBkcml2ZXIpDQorICogSW4gb3JkZXIgdG8gZmFpbCBlYXJseSBvbiB0b28g
bG9uZyBuYW1lcyB3aGVuIGNyZWF0aW5nIHRoZSBtZW1wb29sLA0KKyAqIHRoZSBsZW5ndGggb2Yg
dGhlIG1lbXpvbmUgbmFtZSByZXNlcnZlZCBieSB2YXJpb3VzIG1lbXBvb2wgZHJpdmVycyBhcmUN
CisgKiBub3QgY29uc2lkZXJlZDsgb25seSB0aGUgcmluZyBhbmQgc3RhY2sgZHJpdmVycyBhcmUg
Y29uc2lkZXJlZCBoZXJlLg0KKyAqIElmIHRoZSBuYW1lIGV2ZW50dWFsbHkgdHVybnMgb3V0IHRv
IGJlIHRvbyBsb25nIGZvciB0aGUgY2hvc2VuIG1lbXBvb2wgZHJpdmVyLA0KKyAqIHBvcHVsYXRp
bmcgdGhlIG1lbXBvb2wgd2lsbCBmYWlsLg0KKyAqLw0KKyNkZWZpbmUgUlRFX01FTVBPT0xfT1BT
X1JFUFJFU0VOVEFUSVZFX05BTUVTSVpFIFwNCisJCVJURV9NQVgoUlRFX1JJTkdfTkFNRVNJWkUs
IFJURV9TVEFDS19OQU1FU0laRSkNCisjZGVmaW5lIFJURV9NRU1QT09MX05BTUVTSVpFIFwNCisJ
CShSVEVfTUVNUE9PTF9PUFNfUkVQUkVTRU5UQVRJVkVfTkFNRVNJWkUgLSBcDQorCQkoc2l6ZW9m
KFJURV9NRU1QT09MX01aX1BSRUZJWCkgLSAxKSkNCg0KWzFdOiBodHRwczovL2J1Z3MuZHBkay5v
cmcvc2hvd19idWcuY2dpP2lkPTE5ODANClsyXTogaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
ZHBkay92MjYuMDcvc291cmNlL2xpYi9tZW1wb29sL3J0ZV9tZW1wb29sLmgjTDEzMA0KDQoNClRo
ZW4sIHRoZSByZWxlYXNlIG5vdGVzIHNob3VsZCBiZSB1cGRhdGVkIHRvbzoNCi0gICogbWVtcG9v
bDogVGhlIG1heGltdW0gbGVuZ3RoIG9mIGEgbWVtcG9vbCBuYW1lIGBgUlRFX01FTVBPT0xfTkFN
RVNJWkVgYCBpbmNyZWFzZWQgZnJvbSAyNiB0byAyOS4NCi0gICogbWVtcG9vbDogVGhlIG1heGlt
dW0gbGVuZ3RoIG9mIGEgbWVtcG9vbCBuYW1lIGBgUlRFX01FTVBPT0xfTkFNRVNJWkVgYCBpbmNy
ZWFzZWQgZnJvbSAyNiB0byAyOC4NCg0K
