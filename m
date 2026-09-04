Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A95C79F83
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD3924279D;
	Fri,  4 Sep 2026 09:29:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 413CF40297
 for <dev@dpdk.org>; Fri,  4 Sep 2026 09:29:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CAC5020910;
 Fri,  4 Sep 2026 09:29:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: RE: [PATCH v25] eal: RTE_PTR_ADD/SUB API improvements
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 4 Sep 2026 09:29:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A2E@smartserver.smartshare.dk>
In-Reply-To: <20260903231201.871509-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v25] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: Ad07+bMAIuGv0Og2RK6CoZnVNKBTTAARIbow
References: <20260207014517.58671-1-scott.k.mitch1@gmail.com>
 <20260903231201.871509-1-stephen@networkplumber.org>
From: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Scott Mitchell" <scott.k.mitch1@gmail.com>
Cc: "Ori Kam" <orika@nvidia.com>, "Aman Singh" <aman.deep.singh@intel.com>,
 "Nipun Gupta" <nipun.gupta@amd.com>,
 "Nikhil Agarwal" <nikhil.agarwal@amd.com>,
 "Chenbo Xia" <chenbox@nvidia.com>, "Long Li" <longli@microsoft.com>,
 "Wei Hu" <weh@microsoft.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Sunil Kumar Kori" <skori@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Srikanth Yalavarthi" <syalavarthi@marvell.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Suanming Mou" <suanmingm@nvidia.com>,
 "Matan Azrad" <matan@nvidia.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>,
 "Gowrishankar Muthukrishnan" <gmuthukrishn@marvell.com>,
 "Vidya Sagar Velumuri" <vvelumuri@marvell.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 "Shijith Thotton" <sthotton@marvell.com>,
 "Artem V. Andreev" <artem.andreev@oktetlabs.ru>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Potnuri Bharat Teja" <bharat@chelsio.com>,
 "Shai Brandes" <shaibran@amazon.com>,
 "Evgeny Schemeilin" <evgenys@amazon.com>,
 "Amit Bernstein" <amitbern@amazon.com>,
 "Wajeeh Atrash" <atrwajee@amazon.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Dmitry Kozlyuk" <dmitry.kozliuk@gmail.com>,
 "Jerin Jacob" <jerinj@marvell.com>, "Zhirun Yan" <yanzhirun_163@163.com>,
 "Reshma Pattan" <reshma.pattan@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Anoob Joseph" <anoobj@marvell.com>,
 "Volodymyr Fialko" <vfialko@marvell.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>
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
b3JnXQ0KPiBTZW50OiBGcmlkYXksIDQgU2VwdGVtYmVyIDIwMjYgMDEuMDUNCj4gDQo+IEZyb206
IFNjb3R0IE1pdGNoZWxsIDxzY290dC5rLm1pdGNoMUBnbWFpbC5jb20+DQo+IA0KPiBSVEVfUFRS
X0FERCBhbmQgUlRFX1BUUl9TVUIgQVBJcyBoYXZlIGEgZmV3IGxpbWl0YXRpb25zOg0KPiAxLiBw
dHIgY2FzdCB0byB1aW50cHRyX3QgZHJvcHMgcG9pbnRlciBwcm92ZW5hbmNlIGFuZA0KPiBwcmV2
ZW50cyBjb21waWxlciBvcHRpbWl6YXRpb25zDQo+IDIuIHJldHVybiBjYXN0IGRpc2NhcmRzIHF1
YWxpZmllcnMgKGNvbnN0LCB2b2xhdGlsZSkNCj4gd2hpY2ggbWF5IGhpZGUgY29ycmVjdG5lc3Mv
Y29uY3VycmVuY3kgaXNzdWVzLg0KPiAzLiBBY2NlcHRzIGJvdGggInBvaW50ZXJzIiBhbmQgImlu
dGVnZXJzIGFzIHBvaW50ZXJzIiB3aGljaA0KPiBvdmVybG9hZHMgdGhlIHVzZSBjYXNlIGFuZCBj
b25zdHJhaW5zIHRoZSBpbXBsZW1lbnRhdGlvbg0KPiB0byBhZGRyZXNzIG90aGVyIGNoYWxsZW5n
ZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGRlcHJlY2F0ZXMgc3VwcG9ydCBmb3IgaW50ZWdlciB0eXBl
cyB3aGljaCBhbGxvd3MNCj4gYWRkcmVzc2luZyBlYWNoIG9mIHRoZSBjaGFsbGVuZ2VzIGFib3Zl
Lg0KPiANCj4gRXhhbXBsZXM6DQo+IDEuIENsYW5nIGlzIGFibGUgdG8gb3B0aW1pemUgYW5kIGlt
cHJvdmUgX19ydGVfcmF3X2Nrc3VtDQo+ICh3aGljaCB1c2VzIFJURV9QVFJfQUREKSBieSB+NDAl
ICgxMDAgYnl0ZXMpIHRvIH44eCAoMS41ayBieXRlcykNCj4gVFNDIGN5Y2xlcy9ieXRlLg0KPiAy
LiBSZWZhY3RvcmluZyBkaXNjb3ZlcmVkIGNhc2VzIHRoYXQgZHJvcHBlZCBxdWFsaWZpZXJzICh2
b2xhdGlsZSkNCj4gdGhhdCB0aGUgbmV3IEFQSSBleHBvc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2NvdHQgTWl0Y2hlbGwgPHNjb3R0LmsubWl0Y2gxQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gLS0t
DQo+IENoYW5nZXMgZnJvbSB0aGUgb3JpZ2luYWwgdjI0IHN1Ym1pc3Npb24gKHJlYmFzZWQgdG8g
MjYuMTEpOg0KPiANCj4gKiBSZWJhc2VkIG9uIG1haW46IHJlbGVhc2Ugbm90ZXMgbW92ZWQgdG8g
cmVsZWFzZV8yNl8xMS5yc3QsDQo+IGFuZCByb2NfY3B0X2RlYnVnLmMgdXBkYXRlZCBmb3IgdGhl
IGNwdF9jbjEwa19mcmFnX2luZm9fcyByZW5hbWUuDQo+IA0KPiAqIFJlbGVhc2Ugbm90ZXM6IHN0
YXRlIHRoYXQgUlRFX1BUUl9BREQvU1VCIHJlamVjdCBpbnRlZ2VyIGFyZ3VtZW50cw0KPiB3aGls
ZSBSVEVfUFRSX0FMSUdOKiBzdGlsbCBjb21waWxlIHdpdGggdGhlbSBhcyBkZXByZWNhdGVkIHVz
YWdlLg0KPiBUaGVyZSBhcmUgc3RpbGwgc29tZSBpbi10cmVlIHVzZXMgb2YgaW50ZWdlciBhcmd1
bWVudHMgaW4gbWx4NS4NCj4gDQo+ICogdGVzdF9jb21tb24uYzogYWxpZ25lZCB1aW50MTYvMzIv
NjQgZGVyZWZlcmVuY2UgdGVzdHMgbm93IGFsc28NCj4gcmVxdWlyZSBpbmNyZW1lbnQgdG8gYmUg
YSBtdWx0aXBsZSBvZiB0aGUgdHlwZSBzaXplLCBhdm9pZGluZw0KPiBtaXNhbGlnbmVkIHR5cGVk
IGFjY2Vzcy4NCj4gDQo+ICogZW5hOiBCQVIgTlVMTCBjaGVjayBsb2dzIGF0IERFQlVHIHJhdGhl
ciB0aGFuIEVSUiBzaW5jZSB0aGUgbWVtb3J5DQo+IEJBUiBpcyBsZWdpdGltYXRlbHkgYWJzZW50
IG9uIG5vbi1MTFEgZGV2aWNlcy4NCj4gDQo+ICogaWR4ZDogZHJvcCBSVEVfUFRSX1VOUVVBTCBh
bmQgRklYTUUgb24gcG9ydGFsIGFzc2lnbm1lbnQsIGFuZCB0aGUNCj4gcmVkdW5kYW50ICh2b2xh
dGlsZSB2b2lkICopIGNhc3RzLCBzaW5jZSB0aGUgZmllbGRzIGFyZSBhbHJlYWR5DQo+IHZvbGF0
aWxlLXF1YWxpZmllZCB1cHN0cmVhbS4NCj4gDQo+ICogZWFsX2NvbW1vbl9tZW1vcnkuYzogZHJv
cCB1bnJlbGF0ZWQgdm9sYXRpbGUgcXVhbGlmaWVyIG9uIGxvY2FsIGVsZW0NCj4gcG9pbnRlci4N
Cj4gKiBlYWxfY29tbW9uX2ZiYXJyYXkuYzogZHJvcCB1bnVzZWQgcnRlX2RlYnVnLmggaW5jbHVk
ZS4NCj4gKiBlYWxfbWVtYWxsb2MuYyAobGludXgsIHdpbmRvd3MpOiBtb3ZlIGJhc2VfdmEgTlVM
TCBjaGVjayBiZWZvcmUNCj4gICB0aGUgYWxsb2NhdGlvbiBsb29wIGFuZCByZXR1cm4gLTEgaW5z
dGVhZCBvZiBnb3RvIG91dC4NCj4gDQo+ICogcnRlX21idWYuaCwgcnRlX21lbXBvb2wuaDogZHJv
cCBfX3J0ZV9hc3N1bWUoKSBvbiBwb2ludGVycyB0aGF0DQo+IGFyZSBkZXJlZmVyZW5jZWQgaW1t
ZWRpYXRlbHkgYWZ0ZXI7IGNvbXBpbGVyIGFscmVhZHkgaW5mZXJzIHRoYXQNCj4gZm9ybSB0aGUg
aW1tZWRpYXRlIGRlcmVmZXJlbmNlLiAga2VlcCBSVEVfQVNTRVJULg0KPiANCg0KVGhhdCdzIGEg
bG90IG9mIGNvZGUuDQpUaGFuayB5b3UgZm9yIHdvcmtpbmcgb24gdGhpcywgU2NvdHQgYW5kIFN0
ZXBoZW4uDQpTdHJvbmdlciB0eXBpbmcgaXMgYSB2YWx1YWJsZSBpbXByb3ZlbWVudC4NCg0KSSBo
YXZlIHJldmlld2VkIHNlbGVjdGl2ZWx5LCBzbyBpdCdzIG5vdCBhIGZ1bGwgcmV2aWV3LCBidXQg
YSBiaWcgYWNrLg0KDQpBY2tlZC1ieTogTW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0
ZW1zLmNvbT4NCg0K
