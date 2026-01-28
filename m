Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A4DD3F07A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 15:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FF83402AF;
	Wed, 28 Jan 2026 16:21:49 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DE25C4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 16:21:47 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1Qvt473RzHnGjN;
 Wed, 28 Jan 2026 23:20:58 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 563DB40565;
 Wed, 28 Jan 2026 23:21:46 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 16:21:46 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 28 Jan 2026 16:21:46 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "scott.k.mitch1@gmail.com"
 <scott.k.mitch1@gmail.com>, Aaron Conole <aconole@redhat.com>
Subject: RE: [PATCH] ci: display UBSan stack trace
Thread-Topic: [PATCH] ci: display UBSan stack trace
Thread-Index: AQHckEX/rWx7+vBmbEqXDvMdTGikTbVnczlggAAoMQCAABHgAA==
Date: Wed, 28 Jan 2026 15:21:46 +0000
Message-ID: <f55622b7d5cc426a9ffe04a9d3814b33@huawei.com>
References: <20260128110438.3003192-1-david.marchand@redhat.com>
 <fdf5710e785c48c08cdd42e95aa56895@huawei.com>
 <CAJFAV8ytz4CJh8msWU354J3cbPU0r94-kg_3DWCDh5pvnbfXTQ@mail.gmail.com>
In-Reply-To: <CAJFAV8ytz4CJh8msWU354J3cbPU0r94-kg_3DWCDh5pvnbfXTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

PiA+IEkgd2lsbCBzaGFyZSBvbmVzIHdlIGFyZSB1c2luZyBpbiBjYXNlIHlvdSBmaW5kIHNvbWUg
b2YgdGhlbSBpbnRlcmVzdGluZzoNCj4gPg0KPiA+DQo+IEFTQU5fT1BUSU9OUz1hYm9ydF9vbl9l
cnJvcj10cnVlOmNvbG9yPW5ldmVyOmhhbHRfb25fZXJyb3I9dHJ1ZTpwcmludF9zdW1tYXJ5PXRy
dWU6c3RyaWN0X3N0cmluZ19jaGVjaw0KPiBzPXRydWU6Y2hlY2tfaW5pdGlhbGl6YXRpb25fb3Jk
ZXI9dHJ1ZTpkZXRlY3Rfc3RhY2tfdXNlX2FmdGVyX3JldHVybj10cnVlOmhlYXBfcHJvZmlsZT1m
YWxzZTpwcmludF9zY2ENCj4gcmluZXNzPXRydWU6c3RyaWN0X2luaXRfb3JkZXI9dHJ1ZTp2ZXJp
ZnlfYXNhbl9saW5rX29yZGVyPWZhbHNlDQo+ID4NCj4gTFNBTl9PUFRJT05TPWFib3J0X29uX2Vy
cm9yPXRydWU6Y29sb3I9bmV2ZXI6aGFsdF9vbl9lcnJvcj10cnVlOnByaW50X3N1bW1hcnk9dHJ1
ZTpzdHJpY3Rfc3RyaW5nX2NoZWNrDQo+IHM9dHJ1ZQ0KPiA+DQo+IFVCU0FOX09QVElPTlM9YWJv
cnRfb25fZXJyb3I9dHJ1ZTpjb2xvcj1uZXZlcjpoYWx0X29uX2Vycm9yPXRydWU6cHJpbnRfc3Vt
bWFyeT10cnVlOnN0cmljdF9zdHJpbmdfY2hlYw0KPiBrcz10cnVlOnByaW50X3N0YWNrdHJhY2U9
dHJ1ZTpyZXBvcnRfZXJyb3JfdHlwZT10cnVlDQo+ID4NCj4gPiAoQWRtaXR0ZWRseSBzb21lIG9m
IHRoZW0gbWlnaHQgYmUgdW5uZWNlc3Nhcnkgb3Igbm9uc2Vuc2ljYWwsIHRoZXkgZGVwZW5kIG9u
DQo+ID4gY29tcGlsZXIgYW5kIGl0J3Mgbm90IGVhc3kgdG8gZmluZCBkb2N1bWVudGF0aW9uLikN
Cj4gDQo+IERpZCB0aG9zZSBvcHRpb25zIGhlbHAgd2l0aCB1bmRlcnN0YW5kaW5nIGZhaWx1cmVz
IGluIHVuaXQgdGVzdHM/DQoNCnByaW50X3N0YWNrdHJhY2UgaXMgcHJvYmFibHkgdGhlIG1vc3Qg
aW1wb3J0YW50IGZvciB1bmRlcnN0YW5kaW5nIGZhaWx1cmVzLg0KU29tZSBvZiB0aGUgcmVzdCBk
ZXRlY3QgYWRkaXRpb25hbCBwcm9ibGVtcywgb3RoZXJzIGFyZSBtb3N0bHkgbmljZS10by1oYXZl
DQpjb3NtZXRpY3MgKGUuZy4gZGlzYWJsaW5nIEFOU0kgc2VxdWVuY2VzKS4NCg0KaGVhcF9wcm9m
aWxlIHdhcyBmb3VuZCB0byBiZSB1c2VmdWwgZm9yIGRlYnVnZ2luZyBidXQgbm90IGZvciBldmVy
eWRheSB0ZXN0cw0Kc2luY2UgaXQgbWF5IGNhdXNlIHByb2Nlc3MgdG8gaGFuZyBvbiBleGl0ICht
YXkgZGVwZW5kIG9uIG90aGVyIG9wdGlvbnMpLg0KDQp2ZXJpZnlfYXNhbl9saW5rX29yZGVyPWZh
bHNlIGlzIGdlbmVyYWxseSBub3QgbmVlZGVkLCBpdCBkaXNhYmxlcyBhIHNlbGYtY2hlY2suDQoN
CnJlcG9ydF9lcnJvcl90eXBlIGlzIHZlcnkgdXNlZnVsIGZvciBhZGRpbmcgc3VwcHJlc3Npb25z
Lg0KDQo+IEkgc2VlICJhYm9ydCIgb3IgImhhbHQiIG9wdGlvbnMgaW4gdGhpcyBsaXN0LCBkb2Vz
IGl0IHN0b3AgZXhlY3V0aW9uDQo+IG9mIGFsbCB0aGUgdGVzdHM/DQoNCk5vLCB0aGV5IG9ubHkg
YWZmZWN0cyBkcGRrLXRlc3QgcHJvY2VzcywgYW5kIG1lc29uIHJ1bnMgZWFjaCB0ZXN0IGluIGEg
c2VwYXJhdGUNCnByb2Nlc3MgaGVyZSwgc28gY29udGludWVzIHJ1bm5pbmcgb3RoZXIgdGVzdHMu
IEJvdGggb2YgdGhlbSBnZXQgc2V0IGJ5IG15DQp2ZXJzaW9uIG9mIG1lc29uIGl0c2VsZiBCVFcu
IElmIHNldCB0byBmYWxzZSBzYW5pdGl6ZXIgY29tcGxhaW5zIHRvIHRlcm1pbmFsDQpidXQgdGhl
IHRlc3QgbWF5IGFjdHVhbGx5IHBhc3MgKGRlcGVuZGluZyBvbiBzcGVjaWZpYyBwcm9ibGVtKS4N
Cg==
