Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B22C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 09:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB5D340156;
	Thu, 26 Jun 2025 11:51:35 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 1C199400D6;
 Thu, 26 Jun 2025 11:51:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bSYqM2GG8z67DlR;
 Thu, 26 Jun 2025 17:51:27 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id 55AF1140447;
 Thu, 26 Jun 2025 17:51:33 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Jun 2025 11:51:33 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Thu, 26 Jun 2025 11:51:33 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Topic: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Index: AQHb5EY4znvM8M6LkkyM82eIHpHGJ7QSdYHggAKKJICAADJ2MA==
Date: Thu, 26 Jun 2025 09:51:33 +0000
Message-ID: <afe059471e604b5c9319cb7312e69c23@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-3-david.marchand@redhat.com>
 <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
 <CAJFAV8wb9ec_O2Dj8vX8YF9ksXzSDgCGefCaNEFs7HfeKhWjMA@mail.gmail.com>
In-Reply-To: <CAJFAV8wb9ec_O2Dj8vX8YF9ksXzSDgCGefCaNEFs7HfeKhWjMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXkgMjYgSnVuZSAyMDI1IDA5
OjMzDQo+IA0KPiBUaGUgcHJvYmxlbSBsaWVzIGluIHRoZSB1c2Ugb2Ygc3Vic2hlbGwgYW5kIHBp
cGVzIGFuZCB0aGF0IGEgZmFpbHVyZQ0KPiBpcyBub3QgcHJvcGFnYXRlZC4NCj4gQWRkaW5nIGEg
dGVzdCBvbmx5IHRoZSB0aGUgdGVsZW1ldHJ5IHNjcmlwdCB3b3VsZCBub3QgY2F0Y2ggb3RoZXIN
Cj4gZXJyb3JzIChsaWtlIGZvciBleGFtcGxlLCBpZiB0aGUganEgY29tbWFuZCBzdGFydHMgdG8g
c3BldyBlcnJvcnMpLg0KDQpZZXMsIEkgYWdyZWUuDQoNCj4gVGhlIG1vc3QgZWxlZ2FudCB3b3Vs
ZCBiZSB0byB1c2UgZXJydHJhY2UgYW5kIHBpcGVmYWlsIG9wdGlvbnMsIGJ1dA0KPiB0aGUgZXJy
dHJhY2UgaXMgYSBiYXNoaXNtIChpb3cgbm90IFBPU0lYKSwgYW5kIHBpcGVmYWlsIGlzIFBPU0lY
IG9ubHkNCj4gc2luY2UgMjAyMiBhbmQgbWFueSBzaGVsbCAobGlrZSBkYXNoIGluIFVidW50dSAy
Mi4wNC8yNC4wNCkgZG9uJ3QNCj4gaW1wbGVtZW50IGl0Lg0KDQpZZXMsIGFsc28gdHJ1ZS4NCg0K
PiBXZSBjb3VsZCB0cnkgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXBwL3Rl
c3Qvc3VpdGVzL3Rlc3RfdGVsZW1ldHJ5LnNoDQo+IGIvYXBwL3Rlc3Qvc3VpdGVzL3Rlc3RfdGVs
ZW1ldHJ5LnNoDQo+IGluZGV4IGNhNmFiZTI2NmUuLmE4MWI0YWRkOTAgMTAwNzU1DQo+IC0tLSBh
L2FwcC90ZXN0L3N1aXRlcy90ZXN0X3RlbGVtZXRyeS5zaA0KPiArKysgYi9hcHAvdGVzdC9zdWl0
ZXMvdGVzdF90ZWxlbWV0cnkuc2gNCj4gQEAgLTE1LDcgKzE1LDcgQEAgY2FsbF9hbGxfdGVsZW1l
dHJ5KCkgew0KPiAgICAgIHRlbGVtZXRyeV9zY3JpcHQ9JHJvb3RkaXIvdXNlcnRvb2xzL2RwZGst
dGVsZW1ldHJ5LnB5DQo+ICAgICAgZWNobyA+JHRtcG91dHB1dA0KPiAgICAgIGVjaG8gIlRlbGVt
ZXRyeSBjb21tYW5kcyBsb2c6IiA+PiR0bXBvdXRwdXQNCj4gLSAgICBmb3IgY21kIGluICQoZWNo
byAvIHwgJHRlbGVtZXRyeV9zY3JpcHQgfCBqcSAtciAnLlsiLyJdW10nKQ0KPiArICAgIGVjaG8g
LyB8ICR0ZWxlbWV0cnlfc2NyaXB0IHwganEgLXIgJy5bIi8iXVtdJyB8IHdoaWxlIHJlYWQgY21k
DQo+ICAgICAgZG8NCj4gICAgICAgICAgZm9yIGlucHV0IGluICRjbWQgJGNtZCwwICRjbWQseg0K
PiAgICAgICAgICBkbw0KPiBAQCAtMjUsNCArMjUsNSBAQCBjYWxsX2FsbF90ZWxlbWV0cnkoKSB7
DQo+ICAgICAgZG9uZQ0KPiAgfQ0KPiANCj4gLShzbGVlcCAxICYmIGNhbGxfYWxsX3RlbGVtZXRy
eSAmJiBlY2hvIHF1aXQpIHwgJEANCj4gKyEgc2V0IC1vIHwgZ3JlcCAtcSBwaXBlZmFpbCB8fCBz
ZXQgLW8gcGlwZWZhaWwNCj4gKyhzZXQgLWU7ICEgc2V0IC1vIHwgZ3JlcCAtcSBwaXBlZmFpbCB8
fCBzZXQgLW8gcGlwZWZhaWw7IHNsZWVwIDEgJiYNCj4gY2FsbF9hbGxfdGVsZW1ldHJ5ICYmIGVj
aG8gcXVpdCkgfCAkQA0KDQpJIDEwMCUgYWdyZWUgd2l0aCB0aGUgaWRlYSwgYnV0IHNhZGx5IEkn
bSBub3QgZmFtaWxpYXIgd2l0aCBzaGVsbCBzY3JpcHRpbmcgZW5vdWdoIHRvIHN1Z2dlc3Qgb3Ig
cmV2aWV3IHRoaXMgZGlmZi4gSXMgYGZvciBjbWQgaW5gIGFsd2F5cyBlcXVpdmFsZW50IHRvIGB3
aGlsZSByZWFkIGNtZGA/IElzIENJIGV2ZXIgZXhlY3V0aW5nIGl0IGluIGJhc2ggZm9yIG91ciBh
dHRlbXB0IHRvIHNldCBwaXBlZmFpbCB0byBiZSBqdXN0aWZpZWQ/IElzIGl0IGlkaW9tYXRpYz8g
SSBob3BlIHNvbWVvbmUgZWxzZSBoZXJlIGNhbiBoZWxwIHdpdGggdGhpcy4NCg0KUGVyaGFwcyB0
aGlzIHNob3VsZCBqdXN0IGJlIHJlLXdyaXR0ZW4gaW4gUHl0aG9uLiBJdCBkZXBlbmRzIG9uIGEg
UHl0aG9uIHNjcmlwdCBhbnl3YXkuDQo=
