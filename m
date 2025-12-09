Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75ED3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 12:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D90A2406BB;
	Tue,  9 Dec 2025 13:11:23 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A51EC4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 13:11:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7DD8A206A1;
 Tue,  9 Dec 2025 13:11:22 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH dpdk 1/2] graph: always count objects and calls
Date: Tue, 9 Dec 2025 13:11:20 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655CA@smartserver.smartshare.dk>
In-Reply-To: <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH dpdk 1/2] graph: always count objects and calls
Thread-Index: AdxpAZN3cZjx5+ojQrCmzfErDJ93lwAAHZSA
References: <20251209085028.115203-4-rjarry@redhat.com>
 <20251209085028.115203-5-rjarry@redhat.com>
 <CALBAE1OMwTX=a5i56G_sPXicw=17ozvb4PBfak0ev2Ps3xwuGw@mail.gmail.com>
 <DETKJKSUL9XG.1CTKW09I3UWSB@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655C8@smartserver.smartshare.dk>
 <DETNTVDMT8U6.307XVRW7VTBIE@redhat.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Robin Jarry" <rjarry@redhat.com>,
	"Jerin Jacob" <jerinjacobk@gmail.com>
Cc: <dev@dpdk.org>, "Jerin Jacob" <jerinj@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Zhirun Yan" <yanzhirun_163@163.com>
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

PiBGcm9tOiBSb2JpbiBKYXJyeSBbbWFpbHRvOnJqYXJyeUByZWRoYXQuY29tXQ0KPiBTZW50OiBU
dWVzZGF5LCA5IERlY2VtYmVyIDIwMjUgMTIuNDcNCj4gDQo+IE1vcnRlbiBCcsO4cnVwLCBEZWMg
MDksIDIwMjUgYXQgMTI6MTM6DQo+ID4gTG9va2luZyBhdCBwYXRjaCAyLzIsIEkgZGlzYWdyZWUg
d2l0aCB0aGUgYXBwcm9hY2guDQo+ID4NCj4gPiBSVEVfTElCUlRFX0dSQVBIX1NUQVRTIHNob3Vs
ZCBjb250cm9sIGFsbCBzdGF0cywgaW5jbC4gdG90YWxfY2FsbHMNCj4gYW5kDQo+ID4gdG90YWxf
b2Jqcy4gVGhlbiwgaWYgZW5hYmxlZCwgdGhlIHRvdGFsX2N5Y2xlcyBzdGF0cyBjYW4gYmUNCj4g
Y29udHJvbGxlZA0KPiA+IGJ5IHJ0ZV9ncmFwaF9jeWNsZV9zdGF0c19lbmFibGUoKS4NCj4gPg0K
PiA+IFlvdXIgdjEgc2VyaWVzIGludHJvZHVjZXMgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQgZm9yIGFw
cGxpY2F0aW9ucyBub3QNCj4gPiBjYXJpbmcgYWJvdXQgdG90YWxfY2FsbHMvdG90YWxfb2JqcyBz
dGF0cyBhbmQgdGh1cyBidWlsdCB3aXRob3V0DQo+ID4gUlRFX0xJQlJURV9HUkFQSF9TVEFUUy4N
Cj4gDQo+IE15IGlzc3VlIGlzIHRoYXQgSSB3b3VsZCBsaWtlIHRoZSB0b3RhbF9vYmpzIHN0YXQg
YnV0IHdpdGhvdXQgdGhlDQo+IG92ZXJoZWFkIG9mIHJ0ZV9yZHRzYygpIGJlaW5nIGNhbGxlZCB0
d2ljZSBmb3IgZXZlcnkgbm9kZSB2aXNpdC4NCg0KSSBnZXQgdGhhdC4gTXkgcHJvcG9zYWwgcHJv
dmlkZXMgdGhhdC4NCg0KPiANCj4gQW5kIGFsc28sIEkgd291bGQgbGlrZSB0byBiZSBhYmxlIHRv
IGVuYWJsZS9kaXNhYmxlIHRoZXNlIHN0YXRzICphdA0KPiBydW50aW1lKi4NCg0KV2h5IHdvdWxk
IHlvdSBlbmFibGUvZGlzYWJsZSB0b3RhbF9jYWxscy90b3RhbF9vYmpzIGF0IHJ1bnRpbWU/DQoN
Cj4gSGF2aW5nIGl0IGJlaGluZCBhIGNvbXBpbGUgdGltZSBjb25zdGFudCBtYWtlcyBpdCB2ZXJ5
IG5vdA0KPiBmbGV4aWJsZS4NCg0KQWdyZWUsIGJ1dCBpbnN0cnVtZW50YXRpb24gaGFzIGEgcGVy
Zm9ybWFuY2UgY29zdCwgYW5kIHNob3VsZCBiZSBwb3NzaWJsZSB0byBkaXNhYmxlIGF0IGNvbXBp
bGUgdGltZS4NCg0KPiANCj4gSSBjb3VsZCBoYXZlIHR3byBib29sZWFucyB0byBjb250cm9sIHdo
ZXRoZXIgdG90YWxfY2FsbHMvdG90YWxfb2JqcyBhcmUNCj4gdXBkYXRlZCAqYW5kKiB3aGV0aGVy
IHRvdGFsX2N5Y2xlcyBhcmUgY29tcHV0ZWQuIEJ1dCB0aGF0IHNlZW1zIGEgYml0DQo+IG92ZXJr
aWxsIGFuZCBpdCB3b3VsZCBtZWFuIHR3byBmaWVsZHMgdG8gY2hlY2sgKHR3byBicmFuY2hlcykg
aW5zdGVhZA0KPiBvZg0KPiBvbmUgcGVyIG5vZGUuDQo+IA0KPiBJcyBpdCByZWFsbHkgdGhhdCBi
YWQgdG8gdXBkYXRlIHR3byB1aW50NjRfdCBjb3VudGVycz8NCg0KVGhlIGNvc3QgaXMgdW5uZWNl
c3NhcnkuIEl0J3MgaW5zdHJ1bWVudGF0aW9uLg0KDQo+IA0KPiAtLQ0KPiBSb2Jpbg0KPiANCj4g
PiBZb3VyIGNhbmNlbGVkIGNoZWNrIGlzIHlvdXIgcmVjZWlwdC4NCg0KUGxlYXNlIGNoYW5nZSB5
b3VyIGNvb2tpZSBnZW5lcmF0b3IgdG8gbm90IG1ha2UgaXQgbG9vayBhIHF1b3RlIGZyb20gdGhl
IHBlcnNvbiB5b3UgYXJlIHJlcGx5aW5nIHRvLg0KDQo=
