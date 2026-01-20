Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DAED2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E72440268;
	Tue, 20 Jan 2026 12:22:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 54EA04013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:22:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6DCDB20D99;
 Tue, 20 Jan 2026 12:22:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Date: Tue, 20 Jan 2026 12:22:43 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uDLBHaOyG5bUy6tdTsisR14rVQvruAgAouhgCAAAgkMIAAAOag
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.v.ananyev@yandex.ru>
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

PiBGcm9tOiBWYXJnaGVzZSwgVmlwaW4gW21haWx0bzpWaXBpbi5WYXJnaGVzZUBhbWQuY29tXQ0K
PiBTZW50OiBUdWVzZGF5LCAyMCBKYW51YXJ5IDIwMjYgMTIuMTkNCj4gDQo+IFtQdWJsaWNdDQo+
IA0KPiBIaSBATW9ydGVuIEJyw7hydXAsIHF1aWNrIHF1ZXJ5IGluIGZ1bmN0aW9uIGBydGVfbW92
MTdfdG9fMzJgDQo+IA0KPiBgYGANCj4gKyAgICAgICBpZiAoX19ydGVfY29uc3RhbnQobikpIHsN
Cj4gKyAgICAgICAgICAgICAgIGlmIChuID09IDE2KSB7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJ0ZV9tb3YxNigodWludDhfdCAqKWRzdCwgKGNvbnN0IHVpbnQ4X3QNCj4gKilzcmMpOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICBydGVfbW92MSgodWludDhfdCAqKWRzdCArIDE2LCAo
Y29uc3QgdWludDhfdA0KPiAqKXNyYyArIDE2KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIGRzdDsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIGlmIChu
ID09IDE3KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0ZV9tb3YxNigodWludDhfdCAq
KWRzdCwgKGNvbnN0IHVpbnQ4X3QNCj4gKilzcmMpOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBydGVfbW92MSgodWludDhfdCAqKWRzdCArIDE2LCAoY29uc3QgdWludDhfdA0KPiAqKXNyYyAr
IDE2KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGRzdDsNCj4gKyAgICAgICAg
ICAgICAgIH0NCj4gYGBgDQo+IA0KPiBGb3IgYHNpemUgMTZgIGRvIHdlIG5lZWQgdG8gY2FsbCBg
IHJ0ZV9tb3YxKCh1aW50OF90ICopZHN0ICsgMTYsIChjb25zdA0KPiB1aW50OF90ICopc3JjICsg
MTYpO2A/IENhbiB5b3UgcGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCB0aGUgY29ybmVyDQo+IGNh
c2UgZm9yIHRoZSBzYW1lLg0KDQpHb29kIGNhdGNoIQ0KQ29weS1wYXN0ZSBidWcuDQpXaWxsIGZp
eCBpbiBuZXh0IHZlcnNpb24sIGF3YWl0aW5nIG90aGVyIGZlZWRiYWNrLg0KDQo=
