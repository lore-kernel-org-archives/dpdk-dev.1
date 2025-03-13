Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEAC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 14:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 044C041109;
	Thu, 13 Mar 2025 15:41:37 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9FFA540FDE
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:41:35 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 55B2820FF3;
 Thu, 13 Mar 2025 15:41:35 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 13 Mar 2025 15:41:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB0F@smartserver.smartshare.dk>
In-Reply-To: <3711940.zToM8qfIzz@thomas>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Thread-Index: AduUJSgtEVFeTFOWQYejjlH6fI998QAAJW7Q
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
 <Z9Kdpwgbs9a5sE8n@bricha3-mobl1.ger.corp.intel.com>
 <3711940.zToM8qfIzz@thomas>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiAN
Cj4gMTMvMDMvMjAyNSAwOTo1NiwgQnJ1Y2UgUmljaGFyZHNvbjoNCj4gPiBPbiBUaHUsIE1hciAx
MywgMjAyNSBhdCAwOTowMDowOUFNICswMTAwLCBNb3J0ZW4gQnLDuHJ1cCB3cm90ZToNCj4gPiA+
ID4gRnJvbTogU3RlcGhlbiBIZW1taW5nZXIgW21haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZ10NCj4gPiA+ID4gU2VudDogVGh1cnNkYXksIDEzIE1hcmNoIDIwMjUgMDAuMDINCj4gPiA+
ID4NCj4gPiA+ID4gT24gV2VkLCAxOSBGZWIgMjAyNSAxNTo1NToxNyArMDEwMA0KPiA+ID4gPiBU
aG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiA+IDE0LzAyLzIwMjUgMTg6MjAsIFN0ZXBoZW4gSGVtbWluZ2VyOg0KPiA+ID4gPiA+ID4g
VGhlIExpbnV4IHZlcnNpb24gb2Ygc3lzL3F1ZXVlLmggaXMgZnJvemVuIGF0IGFuIG9sZGVyDQo+
IHZlcnNpb24NCj4gPiA+ID4gPiA+IGFuZCBpcyBtaXNzaW5nIHRoZSBfU0FGRSBtYWNybyB2YXJp
YW50cy4gU2V2ZXJhbCBkcml2ZXJzDQo+IHN0YXJ0ZWQNCj4gPiA+ID4gPiA+IGludHJvZHVjaW5n
IHRoZSBvd24gd29ya2Fyb3VuZHMgZm9yIHRoaXMuIFNob3VsZCBiZSBoYW5kbGVkDQo+IGluIEVB
TC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVwaGVuIEhlbW1p
bmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBX
ZSBtYXkgd2FudCB0byB1bmlmeSB3aXRoIGxpYi9lYWwvd2luZG93cy9pbmNsdWRlL3N5cy9xdWV1
ZS5oDQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBOb3Qgc3VyZSwgd2Ug
aGF2ZSBzZXZlcmFsIG9wdGlvbnMgaGVyZToNCj4gPiA+ID4gICAxLiBLZWVwIHVzaW5nIExpbnV4
IHN5cy9xdWV1ZS5oIGFuZCBhZGQgZW5oYW5jZW1lbnRzIGluDQo+IHJ0ZV9xdWV1ZS5oDQo+ID4g
PiA+ICAgMi4gTWFrZSBydGVfcXVldWUuaCBhIGNvcHkgb2YgRnJlZUJTRCB2ZXJzaW9uIG9mIHF1
ZXVlLmggKHRoYXQNCj4gaXMNCj4gPiA+ID4gd2hhdCBXaW5kb3dzIGRpZCkNCj4gPiA+ID4gICAz
LiBVc2UgdGhlIGJzZCB2ZXJzaW9uIG9mIHF1ZXVlLmguDQo+ID4gPiA+ICAgICAgT24gRGViaWFu
L1VidW50dSB0aGlzIGluIGxpYmJzZC1kZXYgcGFja2FnZSBhbmQgcmVmZXJyZWQgdG8NCj4gYXMN
Cj4gPiA+ID4gYnNkL3N5cy9xdWV1ZS5oDQo+ID4gPiA+DQo+ID4gPiA+IEkgY2hvc2UgIzEgYXMg
c2ltcGxlc3QuIEJ1dCBhbGwgb2YgdGhlc2UgY291bGQgd29yay4gIzMgbWVhbnMNCj4gRFBESyBo
YXMNCj4gPiA+ID4gbGVhc3QgbmV3DQo+ID4gPiA+IGNvZGUsIGJ1dCBhZGRzIGFub3RoZXIgZGVw
ZW5kZW5jeSB0byB0aGUgYnVpbGQuDQo+ID4gPg0KPiA+ID4gKzEgdG8gIzI6DQo+ID4gPiBJZiBM
aW51eCBzeXMvcXVldWUuaCBpcyBmcm96ZW4sIGFuZCBpcyBhIHN1YnNldCBvZiBGcmVlQlNEIHF1
ZXVlLmgsDQo+ICMyIHdvdWxkIGNvbnNvbGlkYXRlIGFsbCB0aGUgcXVldWUgbWFjcm9zIGluIG9u
ZSBmaWxlLg0KPiA+ID4gVGhhdCBzZWVtcyBlYXNpZXIgdG8gbmF2aWdhdGUgKGZvciBhIGRldmVs
b3Blci9yZXZpZXdlciBsb29raW5nIGF0DQo+IHRoZSBtYWNybyBkZWZpbml0aW9ucy9pbXBsZW1l
bnRhdGlvbnMpIHRoYW4gaW5jbHVkaW5nIHN5cy9xdWV1ZS5oLA0KPiBxdWV1ZS5oIG9yIGxpYi9l
YWwvd2luZG93cy9pbmNsdWRlL3N5cy9xdWV1ZS5oIGRlcGVuZGluZyBvbiBPL1MsIGFuZA0KPiB0
aGVuIGRlZmluaW5nIHRoZSBtaXNzaW5nIG1hY3JvcyBpbiBydGVfcXVldWUuaC4NCj4gPiA+IEEg
Y29tbWVudCBhdCB0aGUgdG9wIG9mIHRoZSBydGVfcXVldWUuaCBmaWxlIGNvdWxkIG1lbnRpb24g
dGhhdCBpdA0KPiBpcyBhIGNvcHkgb2YgdGhlIEZyZWVCU0QgcXVldWUuaCBmaWxlLg0KPiA+ID4N
Cj4gPiA+IC0xIHRvICMzOyBpdCBhZGRzIGFuIHVubmVjZXNzYXJ5IGRlcGVuZGVuY3kuDQo+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiBObyBtYXR0ZXIgd2hhdCwgc2hvdWxkIGFkZCB0byBjaGVja3Bh
dGNoIHRvIGJsb2NrIGFueSBuZXcgZmlsZXMNCj4gdGhhdA0KPiA+ID4gPiBpbmNsdWRlIHN5cy9x
dWV1ZS5oDQo+ID4gPiA+IGRpcmVjdGx5Lg0KPiA+ID4NCj4gPiA+ICsxIHRvIHRoaXMuDQo+ID4g
Pg0KPiA+DQo+ID4gSSBhZ3JlZSB3aXRoIE1vcnRlbiwgIzIgbG9va3MgdGhlIGJlc3Qgb3B0aW9u
IHRvIG1lIHRvby4NCj4gDQo+IEl0IG1lYW5zIHdlIHdhbnQgdG8gcmVtb3ZlIGxpYi9lYWwvd2lu
ZG93cy9pbmNsdWRlL3N5cy9xdWV1ZS5oLCByaWdodD8NCg0KQ29ycmVjdC4NCkFsbCBxdWV1ZSBt
YWNyb3MgYXJlIGNvbnNvbGlkYXRlZCBpbnRvIHJ0ZV9xdWV1ZS5oLg0KDQo=
