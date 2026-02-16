Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278DE8382D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 19:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB8D140296;
	Mon, 16 Feb 2026 20:59:08 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 32C0D40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 20:59:07 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0AF5C20FCA;
 Mon, 16 Feb 2026 20:59:07 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [RFC PATCH v3 2/2] mempool: de-inline get/put unlikely code paths
Date: Mon, 16 Feb 2026 20:59:02 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65727@smartserver.smartshare.dk>
In-Reply-To: <20260216093542.5dec7c28@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH v3 2/2] mempool: de-inline get/put unlikely code paths
Thread-Index: AdyfarF3P0SBBXZTTKCEh3JVuchcOAAEvn7g
References: <20260216115813.103515-1-mb@smartsharesystems.com><20260216152320.105312-1-mb@smartsharesystems.com><20260216152320.105312-3-mb@smartsharesystems.com>
 <20260216093542.5dec7c28@phoenix.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
	<dev@dpdk.org>
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

PiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciBbbWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnXQ0KPiBTZW50OiBNb25kYXksIDE2IEZlYnJ1YXJ5IDIwMjYgMTguMzYNCj4gDQo+IE9uIE1v
biwgMTYgRmViIDIwMjYgMTU6MjM6MjAgKzAwMDANCj4gTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0
c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICsvKioNCj4gPiArICogQHdhcm5pbmcN
Cj4gPiArICogQGIgRVhQRVJJTUVOVEFMOiB0aGlzIEFQSSBtYXkgY2hhbmdlIHdpdGhvdXQgcHJp
b3Igbm90aWNlLg0KPiA+ICsgKg0KPiA+ICsgKiBAaW50ZXJuYWwNCj4gPiArICogUHV0IHNldmVy
YWwgb2JqZWN0cyBiYWNrIGluIHRoZSBtZW1wb29sLCBtb3JlIHRoYW4gdGhlIGNhY2hlIGhhcw0K
PiByb29tIGZvcjsgdXNlZCBpbnRlcm5hbGx5Lg0KPiA+ICsgKg0KPiA+ICsgKiBAcGFyYW0gbXAN
Cj4gPiArICogICBBIHBvaW50ZXIgdG8gdGhlIG1lbXBvb2wgc3RydWN0dXJlLg0KPiA+ICsgKiBA
cGFyYW0gb2JqX3RhYmxlDQo+ID4gKyAqICAgQSBwb2ludGVyIHRvIGEgdGFibGUgb2Ygdm9pZCAq
IHBvaW50ZXJzIChvYmplY3RzKS4NCj4gPiArICogQHBhcmFtIG4NCj4gPiArICogICBUaGUgbnVt
YmVyIG9mIG9iamVjdHMgdG8gc3RvcmUgYmFjayBpbiB0aGUgbWVtcG9vbCwgbXVzdCBiZQ0KPiBz
dHJpY3RseQ0KPiA+ICsgKiAgIHBvc2l0aXZlLg0KPiA+ICsgKiBAcGFyYW0gY2FjaGUNCj4gPiAr
ICogICBBIHBvaW50ZXIgdG8gYSBtZW1wb29sIGNhY2hlIHN0cnVjdHVyZS4NCj4gPiArICovDQo+
ID4gK19fcnRlX2V4cGVyaW1lbnRhbA0KPiA+ICt2b2lkDQo+ID4gK19ydGVfbWVtcG9vbF9kb19n
ZW5lcmljX3B1dF9tb3JlKHN0cnVjdCBydGVfbWVtcG9vbCAqbXAsIHZvaWQgKg0KPiBjb25zdCAq
b2JqX3RhYmxlLA0KPiA+ICsJCXVuc2lnbmVkIGludCBuLCBzdHJ1Y3QgcnRlX21lbXBvb2xfY2Fj
aGUgKmNhY2hlKTsNCj4gPiArDQo+IA0KPiBEb24ndCB5b3Ugd2FudCBpbnRlcm5hbCBub3QgZXhw
ZXJpbWVudGFsIG9uIHRoaXMuDQo+IFlvdSBkb24ndCB3YW50IG9yIGV4cGVjdCBkaXJlY3QgY2Fs
bGVycy4NCg0KSSBpbml0aWFsbHkgaGFkIGl0IGludGVybmFsLCBidXQgaXQncyBiZWluZyBjYWxs
ZWQgZnJvbSBhbiBpbmxpbmUgZnVuY3Rpb24sIHNvIGl0IG5lZWRzIHRvIGJlIHB1YmxpY2x5IGFj
Y2Vzc2libGUgZnJvbSBhcHBsaWNhdGlvbnMuDQpJdCBzZWVtcyBleHBlcmltZW50YWwgZG9lc24n
dCBzdWZmaWNlIGVpdGhlciAtIGlmIG9ubHkgc3RhYmxlIEFQSXMgYXJlIGFsbG93ZWQgLSBzbyBp
dCBwcm9iYWJseSBuZWVkcyB0byBiZSBhIHJlZ3VsYXIgQVBJLg0KV2UnbGwgZ2V0IHRoYXQgc29y
dGVkLg0KDQpUaGUgY29yZSBxdWVzdGlvbiBvZiB0aGUgUkZDIGlzIHRoZSB0cmFkZW9mZiBvZiBt
YWtpbmcgaGUgdW5saWtlbHkgY29kZSBwYXRoIG5vbi1pbmxpbmUgdG8gZ2FpbiBhIHNtYWxsZXIg
Zm9vdHByaW50IG9mIHRoZSBsaWtlbHkgY29kZSBwYXRoLg0KDQo=
