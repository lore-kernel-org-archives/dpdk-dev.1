Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFDDCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 07:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B0AC4028C;
	Fri, 19 Jun 2026 09:54:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7654F4027F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 09:54:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 37EDC201E4;
 Fri, 19 Jun 2026 09:54:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v1 0/5] prefix lcore role enum values
Date: Fri, 19 Jun 2026 09:54:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65929@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <ApV03BBBSN-iQgiffDgXRg@monjalon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 0/5] prefix lcore role enum values
Thread-Index: Adz/vS4KqZF+uvxDTPGRZ+OT0cGXMAAAoy0w
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65917@smartserver.smartshare.dk>
 <20260618190339.2fc76616@phoenix.local> <ApV03BBBSN-iQgiffDgXRg@monjalon.net>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Thomas Monjalon" <thomas@monjalon.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Huisong Li" <lihuisong@huawei.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>
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

PiBGcm9tOiBUaG9tYXMgTW9uamFsb24gW21haWx0bzp0aG9tYXNAbW9uamFsb24ubmV0XQ0KPiBT
ZW50OiBGcmlkYXksIDE5IEp1bmUgMjAyNiAwOS4yOA0KPiANCj4gMTkvMDYvMjAyNiAwNDowMywg
U3RlcGhlbiBIZW1taW5nZXI6DQo+ID4gT24gV2VkLCAxNyBKdW4gMjAyNiAxMzo0ODozNyArMDIw
MA0KPiA+IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gPiA+IEZyb206IEh1aXNvbmcgTGkgW21haWx0bzpsaWh1aXNvbmdAaHVhd2VpLmNv
bV0NCj4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCAxNyBKdW5lIDIwMjYgMTIuMjgNCj4gPiA+ID4N
Cj4gPiA+ID4gQWRkIHRoZSBSVEVfTENPUkVfIHByZWZpeCB0byB0aGUgbGNvcmUgcm9sZSBlbnVt
IHZhbHVlcyBpbg0KPiA+ID4gPiBydGVfbGNvcmVfcm9sZV90DQo+ID4gPiA+IHRvIGZvbGxvdyBE
UERLIG5hbWluZyBjb252ZW50aW9ucy4NCj4gPiA+ID4NCj4gPiA+ID4gLSBST0xFX1JURSAgICAg
IC0+IFJURV9MQ09SRV9ST0xFX1JURQ0KPiA+ID4gPiAtIFJPTEVfT0ZGICAgICAgLT4gUlRFX0xD
T1JFX1JPTEVfT0ZGDQo+ID4gPiA+IC0gUk9MRV9TRVJWSUNFICAtPiBSVEVfTENPUkVfUk9MRV9T
RVJWSUNFDQo+ID4gPiA+IC0gUk9MRV9OT05fRUFMICAtPiBSVEVfTENPUkVfUk9MRV9OT05fRUFM
DQo+ID4gPiA+DQo+ID4gPiA+IE9sZCBuYW1lcyBhcmUga2VwdCBhcyBtYWNyb3MgYWxpYXNpbmcg
dG8gdGhlIG5ldyBuYW1lcyB0bw0KPiBwcmVzZXJ2ZQ0KPiA+ID4gPiBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFNlcmllcy1BY2tlZC1ieTogTW9ydGVuIEJy
w7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4NCj4gPiA+DQo+ID4NCj4gPiBUaGUgcHJv
YmxlbSB3aXRoIHRoaXMgcGF0Y2ggaXQgY2F1c2VzIGJ1aWxkIGZhaWx1cmVzIG5vdyB3aXRoIGFi
aQ0KPiBkaWZmLg0KPiANCj4gSXQgaXMgcHJvYmFibHkgYSBidWcgb2YgYW4gb2xkIHZlcnNpb24g
b2YgYWJpZGlmZi4NCj4gSSByZWNvbW1lbmQgdXBkYXRpbmcuDQoNCldpdGggdGhlICNkZWZpbmUn
cyB0aGUgQUJJIGhhcyBub3QgY2hhbmdlZC4gSXQncyBwcm9iYWJseSB0b28gaW5kaXJlY3QgZm9y
IGFiaWRpZmYgdG8gdW5kZXJzdGFuZC4NCklmIHdlIGFic29sdXRlbHkgd2FudCB0byBwbGVhc2Ug
YWJpZGlmZiwgd2UgY291bGQga2VlcCB0aGUgZXhpc3RpbmcgZW51bXMgYW5kICNkZWZpbmUgUlRF
X0xDT1JFX1JPTEVfUlRFIFJPTEVfUlRFIGZvciBub3cuDQpCdXQgSSdtIGluIGZhdm9yIG9mIHdo
YXQgd2FzIGRvbmUgYWxyZWFkeS4NCg0K
