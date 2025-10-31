Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3ACCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 10:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D5F340431;
	Fri, 31 Oct 2025 11:02:09 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 76DB640270;
 Fri, 31 Oct 2025 11:02:07 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 539E4206E7;
 Fri, 31 Oct 2025 11:02:07 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: RE: Disable SPDK testing again?
Date: Fri, 31 Oct 2025 11:02:05 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65520@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disable SPDK testing again?
Thread-Index: AdxKR0mIqKCrkL0tRiaypgpZkeaWGQABTDPA
References: <CAJFAV8yS3-_RMn-Ln7umJFt+wWVH7Fj7yFnmmjgUnpD1=VX9yA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6551F@smartserver.smartshare.dk>
 <CAJFAV8yn0n2B32W1WUaZSKs1N3DbBPCGZxrT-ats4x0mo0Py-A@mail.gmail.com>
From: =?UTF-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>, <bruce.richardson@intel.com>
Cc: "Patrick Robb" <probb@iol.unh.edu>, "Aaron Conole" <aconole@redhat.com>,
 "dpdk-techboard" <techboard@dpdk.org>, <ci@dpdk.org>, "dev" <dev@dpdk.org>
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
DQo+IFNlbnQ6IEZyaWRheSwgMzEgT2N0b2JlciAyMDI1IDEwLjE4DQo+IA0KPiBPbiBGcmksIDMx
IE9jdCAyMDI1IGF0IDEwOjExLCBNb3J0ZW4gQnLDuHJ1cCA8bWJAc21hcnRzaGFyZXN5c3RlbXMu
Y29tPg0KPiB3cm90ZToNCj4gID4gV2hpbGUgaXQgaXMganVzdCBhIHdhcm5pbmcgaW4gdGhlIENJ
IGRhc2hib2FyZCwgSSBkb24ndCB0aGluayB3ZQ0KPiA+ID4gc2hvdWxkIHdhc3RlIHJlc291cmNl
cyBvbiB0aGlzIHRlc3RpbmcuDQo+ID4gPiBPcGluaW9ucz8NCj4gPg0KPiA+IFdlIHNob3VsZCBh
c2sgb3Vyc2VsdmVzIHdoeSB0aGV5IGFyZSBkb2luZyB0aGF0Lg0KPiA+IElzIHNvbWV0aGluZyB3
cm9uZyAob3IgaW5jb21wbGV0ZSkgd2l0aCBvdXIgaGFuZGxpbmcgb2YgLQ0KPiBEZW5hYmxlX2xp
YnM/DQo+ID4gQXJlIHdlIGluY2x1ZGluZyB1bm5lY2Vzc2FyeSBvcHRpb25hbCBsaWJzPw0KPiA+
DQo+ID4gSXQgc2VlbXMgbGlrZSB0aGV5IGFyZSB1c2luZyAtRGRpc2FibGVfbGlicywgbm90IC1E
ZW5hYmxlX2xpYnMuIERvbid0DQo+IHRoZXkga25vdyBhYm91dCAtRGVuYWJsZV9saWJzPw0KPiAN
Cj4gSSByZWFjaGVkIG91dCB0byBzb21lIFNQREsgZGV2IHdoZW4gSSB3YXMgd29ya2luZyBvbiBl
bmFibGVfbGlicy4NCj4gSSBhbHNvIENjOiBvbmUgb2YgdGhlbSBvbiB0aGUgcGF0Y2hlcyBidXQg
bmV2ZXIgZ290IGEgcmVwbHkuDQoNCkBCcnVjZSwgdGhlIFNQREsgcGF0Y2ggWzFdIHdhcyBzaWdu
ZWQgb2ZmIGJ5IFRvbWFzeiBaYXdhZHpraSA8dG9tYXN6Lnphd2FkemtpQGludGVsLmNvbT47IG1h
eWJlIHlvdSBjb3VsZCB0cnkgcmVhY2hpbmcgb3V0IHRocm91Z2ggaW50ZXJuYWwgSW50ZWwgY2hh
bm5lbHMgYW5kIGVkdWNhdGUgaGltIGFib3V0IC1EZW5hYmxlX2xpYnMuDQoNCklmIHdlIGRpc2Fi
bGUgU1BESyB0ZXN0aW5nIGR1ZSB0byB0aGlzIFNQREsgYnVnLCBob3cgd2lsbCB3ZSBub3RpY2Ug
d2hlbiB0aGV5IGZpeCBpdCwgc28gd2UgY2FuIGVuYWJsZSBTUERLIHRlc3RpbmcgYWdhaW4/DQoN
ClsxXTogaHR0cHM6Ly9naXRodWIuY29tL3NwZGsvZHBkay9jb21taXQvNzRiMWE4MDRlZGEyZWQ5
OWQxZWNhYWU1Yjc5ZGU3ZGY2ZDc0ZThmZg0KDQo=
