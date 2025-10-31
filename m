Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C3FCCF9FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 09:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D765F402AE;
	Fri, 31 Oct 2025 10:11:22 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D097540270;
 Fri, 31 Oct 2025 10:11:21 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A4F8C206E7;
 Fri, 31 Oct 2025 10:11:21 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Disable SPDK testing again?
Date: Fri, 31 Oct 2025 10:11:18 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disable SPDK testing again?
Thread-Index: AdxKQcjcC9RcyHEFQU+pAs7mK3/poQABBZNg
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Patrick Robb" <probb@iol.unh.edu>, "Aaron Conole" <aconole@redhat.com>,
 "dpdk-techboard" <techboard@dpdk.org>, <bruce.richardson@intel.com>
Cc: <ci@dpdk.org>,
	"dev" <dev@dpdk.org>
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

PiBGcm9tOiBEYXZpZCBNYXJjaGFuZCBbbWFpbHRvOmRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb21d
DQo+IFNlbnQ6IEZyaWRheSwgMzEgT2N0b2JlciAyMDI1IDA5LjM5DQo+IA0KPiBIZWxsbywNCj4g
DQo+IFRoZSBTUERLIHRhcmdldCBpbiBVTkggbGFiIGhhcyBiZWVuIHNwZXdpbmcgd2FybmluZ3Mg
YXMgU1BESyBidWlsZA0KPiBpdHNlbGYgY29tcGlsZXMgYW5kIGxpbmtzIGFnYWluc3QgYSBsaXN0
IG9mIGxpYnJhcmllcyBhbmQgZHJpdmVycywNCj4gcmVnYXJkbGVzcyBvZiB0aGUgdXBzdHJlYW0g
ZGVwZW5kZW5jaWVzLg0KPiBodHRwczovL2dpdGh1Yi5jb20vc3Bkay9kcGRrL2NvbW1pdC83NGIx
YTgwNGVkYTJlZDk5ZDFlY2FhZTViNzlkZTdkZjZkNw0KPiA0ZThmZiBhbmQNCj4gaHR0cHM6Ly9n
aXRodWIuY29tL3NwZGsvc3Bkay9ibG9iL21hc3Rlci9kcGRrYnVpbGQvTWFrZWZpbGUjTDY2DQo+
IA0KPiANCj4gVW50aWwgU1BESyBmaXhlcyB0aGlzIG9uIHRoZWlyIHNpZGUgKGVpdGhlciBhZGRp
bmcgYXJncGFyc2UgaW4gdGhlaXINCj4gc3RhdGljIGxpc3QsIG9yIHVzaW5nIHBrZy1jb25maWcg
Zm9yIGV4YW1wbGUgYW5kIHN0b3BwaW5nIHBhdGNoaW5nDQo+IERQREspLCBsaW5raW5nIFNQREsg
YmluYXJpZXMgZmFpbHMgYXMgdGhlIGFyZ3BhcnNlIGxpYiBub3cgbmVjZXNzYXJ5DQo+IHRvIEVB
TCBpcyBub3QgcHVsbGVkOg0KPiANCj4gL3Vzci9iaW4vbGQuYmZkOg0KPiAvdXNyL2xvY2FsL2xp
Yi94ODZfNjQtbGludXgtDQo+IGdudS9saWJydGVfZWFsLmEoZWFsX2NvbW1vbl9lYWxfY29tbW9u
X29wdGlvbnMuYy5vKToNCj4gaW4gZnVuY3Rpb24gYGVhbF91c2FnZSc6DQo+IGVhbF9jb21tb25f
b3B0aW9ucy5jOigudGV4dCsweDE2KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnRlX2Fy
Z3BhcnNlX3ByaW50X2hlbHAnDQo+IC91c3IvYmluL2xkLmJmZDoNCj4gL3Vzci9sb2NhbC9saWIv
eDg2XzY0LWxpbnV4LQ0KPiBnbnUvbGlicnRlX2VhbC5hKGVhbF9jb21tb25fZWFsX2NvbW1vbl9v
cHRpb25zLmMubyk6DQo+IGluIGZ1bmN0aW9uIGBlYWxfY29sbGF0ZV9hcmdzJzoNCj4gZWFsX2Nv
bW1vbl9vcHRpb25zLmM6KC50ZXh0KzB4OTUzKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBg
cnRlX2FyZ3BhcnNlX3BhcnNlJw0KPiAvdXNyL2Jpbi9sZC5iZmQ6DQo+IC91c3IvbG9jYWwvbGli
L3g4Nl82NC1saW51eC0NCj4gZ251L2xpYnJ0ZV9lYWwuYShlYWxfY29tbW9uX2VhbF9jb21tb25f
b3B0aW9ucy5jLm8pOg0KPiBpbiBmdW5jdGlvbiBgZWFsX3BhcnNlX2FyZ3MnOg0KPiBlYWxfY29t
bW9uX29wdGlvbnMuYzooLnRleHQrMHgzNDNiKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBg
cnRlX2FyZ3BhcnNlX3BhcnNlX3R5cGUnDQo+IGNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQg
MSBleGl0IHN0YXR1cw0KPiBtYWtlWzNdOiAqKiogWy9yb290L3dvcmtzcGFjZS9HZW5lcmljLURQ
REstQ29tcGlsZS0NCj4gTWVzb24vc3Bkay9tay9zcGRrLmFwcC5tazozOToNCj4gc3Bka19sb2Nr
XSBFcnJvciAxDQo+IG1ha2VbMl06ICoqKiBbL3Jvb3Qvd29ya3NwYWNlL0dlbmVyaWMtRFBESy1D
b21waWxlLQ0KPiBNZXNvbi9zcGRrL21rL3NwZGsuc3ViZGlycy5tazoxNjoNCj4gbG9ja10gRXJy
b3IgMg0KPiBtYWtlWzFdOiAqKiogWy9yb290L3dvcmtzcGFjZS9HZW5lcmljLURQREstQ29tcGls
ZS0NCj4gTWVzb24vc3Bkay9tay9zcGRrLnN1YmRpcnMubWs6MTY6DQo+IHRocmVhZF0gRXJyb3Ig
Mg0KPiANCj4gDQo+IFdoaWxlIGl0IGlzIGp1c3QgYSB3YXJuaW5nIGluIHRoZSBDSSBkYXNoYm9h
cmQsIEkgZG9uJ3QgdGhpbmsgd2UNCj4gc2hvdWxkIHdhc3RlIHJlc291cmNlcyBvbiB0aGlzIHRl
c3RpbmcuDQo+IE9waW5pb25zPw0KDQpXZSBzaG91bGQgYXNrIG91cnNlbHZlcyB3aHkgdGhleSBh
cmUgZG9pbmcgdGhhdC4NCklzIHNvbWV0aGluZyB3cm9uZyAob3IgaW5jb21wbGV0ZSkgd2l0aCBv
dXIgaGFuZGxpbmcgb2YgLURlbmFibGVfbGlicz8NCkFyZSB3ZSBpbmNsdWRpbmcgdW5uZWNlc3Nh
cnkgb3B0aW9uYWwgbGlicz8NCg0KSXQgc2VlbXMgbGlrZSB0aGV5IGFyZSB1c2luZyAtRGRpc2Fi
bGVfbGlicywgbm90IC1EZW5hYmxlX2xpYnMuIERvbid0IHRoZXkga25vdyBhYm91dCAtRGVuYWJs
ZV9saWJzPw0KDQo=
