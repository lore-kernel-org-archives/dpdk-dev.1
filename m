Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BEC369D5
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 07:00:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB7740263;
	Sun, 27 Apr 2025 09:00:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CDA274021F
 for <dev@dpdk.org>; Sun, 27 Apr 2025 09:00:33 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 63C7C208ED;
 Sun, 27 Apr 2025 09:00:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: rte_eth_stats_get seems slow
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 27 Apr 2025 09:00:31 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC03@smartserver.smartshare.dk>
In-Reply-To: <20250426082352.260b9b5d@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_eth_stats_get seems slow
Thread-Index: Adu2vzrKoxwATcC7RUGaTQF25VgphAAf27pA
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
 <20250426082352.260b9b5d@hermes.local>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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
b3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgMjYgQXByaWwgMjAyNSAxNy4yNA0KPiANCj4gT24gRnJp
LCAyNSBBcHIgMjAyNSAxMzo1Mjo1NSArMDIwMA0KPiBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRz
aGFyZXN5c3RlbXMuY29tPiB3cm90ZToNCj4gDQo+ID4gQnJ1Y2UsDQo+ID4NCj4gPiBydGVfZXRo
X3N0YXRzX2dldCgpIG9uIEludGVsIE5JQ3Mgc2VlbXMgc2xvdyB0byBtZS4NCj4gPg0KPiA+IEUu
Zy4gZ2V0dGluZyB0aGUgc3RhdHMgb24gYSBzaW5nbGUgcG9ydCB0YWtlcyB+MTMyIHVzICh+NDUx
LDAwMCBDUFUNCj4gY3ljbGVzKSB1c2luZyB0aGUgaWdiIGRyaXZlciwgYW5kIH41MCB1cyB1c2lu
ZyB0aGUgaTQwZSBkcml2ZXIuDQo+ID4NCj4gPiBSZWZlcnJpbmcgdG8gdGhlIGlnYiBkcml2ZXIg
c291cmNlIGNvZGUgWzFdLCBpdCdzIDQ0IGNhbGxzIHRvDQo+IEUxMDAwX1JFQURfUkVHKCksIHNv
IHRoZSBtYXRoIHNheXMgdGhhdCBlYWNoIG9uZSB0YWtlcyAzIHVzICh+MTAsMDAwDQo+IENQVSBj
eWNsZXMpLg0KPiA+DQo+ID4gSXMgdGhpcyBleHBlY3RlZCBiZWhhdmlvcj8NCj4gPg0KPiA+IEl0
IGFkZHMgdXAsIGUuZy4gaXQgdGFrZXMgYSBmdWxsIG1pbGxpc2Vjb25kIHRvIGZldGNoIHRoZSBz
dGF0cyBmcm9tDQo+IGVpZ2h0IHBvcnRzIHVzaW5nIHRoZSBpZ2IgZHJpdmVyLg0KPiA+DQo+ID4g
WzFdOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9kcGRrL3YyNC4xMS4xL3NvdXJjZS9k
cml2ZXJzL25ldC9lMTAwMC9pZ2JfZQ0KPiB0aGRldi5jI0wxNzI0DQo+ID4NCj4gPg0KPiA+IE1l
ZCB2ZW5saWcgaGlsc2VuIC8gS2luZCByZWdhcmRzLA0KPiA+IC1Nb3J0ZW4gQnLDuHJ1cA0KPiA+
DQo+IA0KPiBXZWxsIHJlYWRpbmcgZWFjaCBzdGF0IHJlcXVpcmVzIGEgUENJIGFjY2Vzcy4gQW5k
IFBDSSBhY2Nlc3NlcyBhcmUgbm9uLQ0KPiBjYWNoZWQuDQoNCllvdSdyZSByaWdodCwgdGhhbmsg
eW91IGZvciByZW1pbmRpbmcgbWUuIEkgd2FzIGNhdWdodCBieSBzdXJwcmlzZSB0aGF0IGdldHRp
bmcgNyBjb3VudGVycyB0b29rIHNvIGxvbmcuDQpQZXJoYXBzIHJlYWRpbmcgNDQgTklDIHJlZ2lz
dGVycyBvdmVyIHRoZSBQQ0kgYnVzIGlzIHJlcXVpcmVkIHRvIGNhbGN1bGF0ZSB0aG9zZSBzdW1t
YXJ5IGNvdW50ZXJzLiBPciBub2JvZHkgY2FyZWQgdG8gb3B0aW1pemUgdGhpcyBmdW5jdGlvbiB0
byBvbmx5IHJlYWQgdGhlIG5lY2Vzc2FyeSByZWdpc3RlcnMuDQoNCldlIHBlcmlvZGljYWxseSBw
b2xsIHRoZSBldGhkZXYgc3RhdHMgaW4gYSBtYW5hZ2VtZW50IHRocmVhZCwgYW5kIEkgbm90aWNl
ZCB0aGUgZHVyYXRpb24gYmVjYXVzZSBvZiB0aGUgaml0dGVyIGl0IGNhdXNlZCBpbiB0aGF0IHRo
cmVhZC4NCkl0J3Mgbm90IGEgcmVhbCBwcm9ibGVtLiBJZiBpdCB3YXMsIHdlIGNvdWxkIGVhc2ls
eSBtb3ZlIGl0IHRvIGEgc2VwYXJhdGUgdGhyZWFkIG9yIHBvbGwgdGhlIGNvdW50ZXJzIGl0ZXJh
dGl2ZWx5IHBvcnQgYnkgcG9ydCwgaW5zdGVhZCBvZiBhbGwgcG9ydHMgaW4gb25lIGdvLg0KQSBs
b25nd2luZGVkIHdheSBvZiBzYXlpbmc6IFByb2JhYmx5IG5vdCB3b3J0aCBvcHRpbWl6aW5nLiA7
LSkNCg0K
