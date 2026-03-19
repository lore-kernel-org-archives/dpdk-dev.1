Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A021075281
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:21:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 804434025D;
	Thu, 19 Mar 2026 10:21:00 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9354B4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 10:20:59 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6822C205CA;
 Thu, 19 Mar 2026 10:20:59 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH] bpf/arm64: support packet data load instructions
Date: Thu, 19 Mar 2026 10:20:57 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A3@smartserver.smartshare.dk>
In-Reply-To: <78da248e82a54be6882d37efeff23add@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] bpf/arm64: support packet data load instructions
Thread-Index: AQHctXjmQX8WarddCE6NszBJkCRgkLW0Ml8AgAAPe4CAAAOKgIAACP4AgAAgGACAAAvWAIAABb8AgAABxQCAABNiEIABAckg
References: <20260310122045.4057836-1-cfontain@redhat.com><b10d0edcdaac4fd9a4f5a0261205670c@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F6579F@smartserver.smartshare.dk><4942136acefe4fc3b5157191749fe3d5@huawei.com><98CBD80474FA8B44BF855DF32C47DC35F657A0@smartserver.smartshare.dk><CAHVr2NmXSAhKO6EGjh_DDvdaUShPTWH-Eb1y1VrriQBAVnay4w@mail.gmail.com><ea715be437174fa782f3ceb031debe0d@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657A1@smartserver.smartshare.dk>
 <ba8f317961494ce9af15a9108aa3693b@huawei.com>
 <78da248e82a54be6882d37efeff23add@huawei.com>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Marat Khalili" <marat.khalili@huawei.com>,
 "Christophe Fontaine" <cfontain@redhat.com>
Cc: <dev@dpdk.org>,
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

PiBCVFcsIEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCB0byBhZGQgY2hlY2sgZm9yIG92ZXJmbG93IGlu
DQo+IF9fcnRlX3BrdG1idWZfcmVhZCgpIC0NCj4gYnBmIGppdCBpcyBub3QgdGhlIG9ubHkgdXNl
ciBvZiBpdC4NCj4gVW5sZXNzLCBvZi1jb3Vyc2UsIHdlIHdhbnQgcnRlX3BrdG1idWZfcmVhZCgp
IHRvIHdvcmsgd2l0aCB3cmFwcGVkLQ0KPiBhcm91bmQgdmFsdWVzLg0KDQpJdCBtYWtlcyBubyBz
ZW5zZSBmb3IgcnRlX3BrdG1idWZfcmVhZCgpIHRvIHdyYXAgYXJvdW5kLg0KSXRzIG9mZnNldCBh
bmQgbGVuZ3RoIHBhcmFtZXRlcnMgYXJlIGNsZWFybHkgc3BlY2lmaWVkIGFuZCBkb2N1bWVudGVk
IGFzIHVuc2lnbmVkLCBhbmQgdGhlcmUgaXMgbm8gbWVudGlvbiBvZiB3cmFwLWFyb3VuZCBvciBp
bXBsaWNpdCBuZWdhdGl2ZSB2YWx1ZXMgd2hlbiBzdW1taW5nIHRoZW0uDQpJIGhhdmUgc3VibWl0
dGVkIGEgZml4IGp1c3Qgbm93Og0KaHR0cHM6Ly9pbmJveC5kcGRrLm9yZy9kZXYvMjAyNjAzMTkw
ODQwNDguNjUyNDkzLTEtbWJAc21hcnRzaGFyZXN5c3RlbXMuY29tL1QvI3UNCg0KLU1vcnRlbg0K
DQo=
