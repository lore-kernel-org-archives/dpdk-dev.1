Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A339CDE010
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 05:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A59F40272;
	Fri, 26 Jun 2026 07:36:18 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 424A340269
 for <dev@dpdk.org>; Fri, 26 Jun 2026 07:36:15 +0200 (CEST)
Received: from LAPTOP-ARGRBVTN (unknown [101.207.145.153])
 by APP-05 (Coremail) with SMTP id zQCowABXrdDMDz5qu85YFQ--.7876S2;
 Fri, 26 Jun 2026 13:36:12 +0800 (CST)
Date: Fri, 26 Jun 2026 13:36:13 +0800
From: "liujie5@linkdatatechnology.com" <liujie5@linkdatatechnology.com>
To: stephen <stephen@networkplumber.org>
Cc: dev <dev@dpdk.org>
Subject: Re: Re: [PATCH v8 00/23] net/sxe2: added Linkdata sxe2 ethernet driver
References: <20260625055021.63243-1-liujie5@linkdatatechnology.com>, 
 <20260625131936.205040-1-liujie5@linkdatatechnology.com>, 
 <20260625155036.25f856aa@phoenix.local>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Mime-Version: 1.0
Message-ID: <202606261336114750460@linkdatatechnology.com>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart765023518382_=----"
X-CM-TRANSID: zQCowABXrdDMDz5qu85YFQ--.7876S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF45AFWDCrW3XF1ktrW5KFg_yoW8Gr48uo
 WxGrW5WFy7Zr1fZr4Dur97uFy3W39rCr1rJa1rAa9xuFy3Ka43tF48X3y3XFs0yF1UZrnr
 Ca4rZ3WUJrs2qFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYq7k0a2IF6w4kM7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG6xAI
 xVCFxsxG0wAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
 CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7IF0Fy264kE64k0F24lFcxC
 0VAYjxAxZF0Ex2IqxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
 026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
 Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
 vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
 14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VACY4xI67k04243AbIYCT
 nIWIevJa73UjIFyTuYvjxUg8u4UUUUU
X-Originating-IP: [101.207.145.153]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

This is a multi-part message in MIME format.

------=_001_NextPart765023518382_=----
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcgYW5kIHZhbHVhYmxlIHN1Z2dlc3Rp
b25zLg0KVGhlIHJlYXNvbiBJIGludHJvZHVjZWQgYm90aCBGSUZPIGFuZCBMSUZPIG1vZGVzIGlz
IHRoYXQgZGlmZmVyZW50IGhhcmR3YXJlIHZlbmRvcnMgaW1wbGVtZW50IGRpZmZlcmVudCBuYXRp
dmUgYmVoYXZpb3JzIGZvciBkdXBsaWNhdGUgZmxvdyBydWxlcyB3aXRoIHRoZSBzYW1lIHByaW9y
aXR5LiBTb21lIGRldmljZXMga2VlcCB0aGUgZmlyc3QgaW5zZXJ0ZWQgcnVsZSBhY3RpdmUsIHdo
aWxlIG90aGVycyBtYWtlIHRoZSBtb3N0IHJlY2VudGx5IGluc2VydGVkIHJ1bGUgYWN0aXZlLiBU
aGUgaW50ZW50aW9uIG9mIGV4cG9zaW5nIGJvdGggbW9kZXMgaXMgdG8gcHJlc2VydmUgdGhlIHVu
ZGVybHlpbmcgaGFyZHdhcmUgc2VtYW50aWNzIGluc3RlYWQgb2YgZm9yY2luZyBhbGwgZGV2aWNl
cyBpbnRvIGEgc2luZ2xlIHBvbGljeS4NCkkgYWdyZWUgd2l0aCB5b3VyIHBvaW50IHRoYXQsIGlm
IHRoZSBpbnRlcmZhY2UgaXMgaW50ZW5kZWQgdG8gYWxpZ24gd2l0aCBtbHg1LCB0aGUgbWFwcGlu
ZyBiZXR3ZWVuIHBhcmFtZXRlciB2YWx1ZXMgYW5kIHRoZWlyIHNlbWFudGljcyBzaG91bGQgYWxz
byBiZSBjb25zaXN0ZW50LiBVc2luZyB0aGUgc2FtZSB2YWx1ZSB3aXRoIG9wcG9zaXRlIGJlaGF2
aW9yIGFjcm9zcyBQTURzIHdvdWxkIGluZGVlZCBiZSBjb25mdXNpbmcgZm9yIHVzZXJzLg0KVGhl
cmVmb3JlLCBJIHRoaW5rIHlvdXIgb3B0aW9uIChjKSBpcyBhIHJlYXNvbmFibGUgY29tcHJvbWlz
ZToNCjAgPSByZWplY3QgZHVwbGljYXRlcw0KMSA9IEZJRk8gKG1hdGNoaW5nIG1seDUgc2VtYW50
aWNzKQ0KMiA9IExJRk8NClRoaXMga2VlcHMgdGhlIGNvbW1vbiBjYXNlIGNvbXBhdGlibGUgd2l0
aCBtbHg1IHdoaWxlIHN0aWxsIGFsbG93aW5nIGhhcmR3YXJlIHdpdGggbmF0aXZlIExJRk8gYmVo
YXZpb3IgdG8gZXhwb3NlIGl0cyBjYXBhYmlsaXR5Lg0KUmVnYXJkaW5nIHRoZSBlcnJvciBtZXNz
YWdlLCBJIGFsc28gYWdyZWUgdGhhdCB0aGUgY3VycmVudCB0ZXJuYXJ5IGV4cHJlc3Npb24gaXMg
dW5uZWNlc3NhcnkgaWYgRUVYSVNUIGlzIG9ubHkgcmV0dXJuZWQgaW4gcmVqZWN0IG1vZGUuIEkn
bGwgc2ltcGxpZnkgdGhlIGVycm9yIGhhbmRsaW5nIGFjY29yZGluZ2x5IGluIHRoZSBuZXh0IHJl
dmlzaW9uLg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIHJldmlldy4NCkJlc3QgcmVnYXJkcywNCkxp
dSBKaWUNCg0KDQoNCmxpdWppZTVAbGlua2RhdGF0ZWNobm9sb2d5LmNvbQ0KIA0KRnJvbTogU3Rl
cGhlbiBIZW1taW5nZXINCkRhdGU6IDIwMjYtMDYtMjYgMDY6NTANClRvOiBsaXVqaWU1DQpDQzog
ZGV2DQpTdWJqZWN0OiBSZTogW1BBVENIIHY4IDAwLzIzXSBuZXQvc3hlMjogYWRkZWQgTGlua2Rh
dGEgc3hlMiBldGhlcm5ldCBkcml2ZXINCk9uIFRodSwgMjUgSnVuIDIwMjYgMjE6MTk6MzYgKzA4
MDANCmxpdWppZTVAbGlua2RhdGF0ZWNobm9sb2d5LmNvbSB3cm90ZToNCiANCj4gRnJvbTogSmll
IExpdSA8bGl1amllNUBsaW5rZGF0YXRlY2hub2xvZ3kuY29tPg0KPiANCj4gVGhpcyBwYXRjaCBz
ZXQgaW1wbGVtZW50cyBjb3JlIGZ1bmN0aW9uYWxpdHkgZm9yIHRoZSBTWEUyIFBNRCwNCj4gaW5j
bHVkaW5nIGJhc2ljIGRyaXZlciBmcmFtZXdvcmssIGRhdGEgcGF0aCBzZXR1cCwgYW5kIGFkdmFu
Y2VkDQo+IG9mZmxvYWQgZmVhdHVyZXMgKFZMQU4sIFJTUyxUTSwgUFRQIGV0Yy4pLg0KPiANCj4g
djg6DQo+IFJlc3RvcmUgdGhlIGZsb3ctZHVwbGljYXRlLXBhdHRlcm4gcGFyYW1ldGVyDQo+IA0K
PiBKaWUgTGl1ICgyMyk6DQo+ICAgbmV0L3N4ZTI6IHJlbW92ZSBzb2Z0d2FyZSBzdGF0aXN0aWNz
IGRldmFyZ3MNCj4gICBuZXQvc3hlMjogYWRkIFJ4IGZyYW1ld29yayBhbmQgcGFja2V0IHR5cGVz
IGNhbGxiYWNrDQo+ICAgbmV0L3N4ZTI6IHN1cHBvcnQgQVZYNTEyIHZlY3Rvcml6ZWQgcGF0aCBm
b3IgUnggYW5kIFR4DQo+ICAgbmV0L3N4ZTI6IGFkZCBBVlgyIHZlY3RvciBkYXRhIHBhdGggZm9y
IFJ4IGFuZCBUeA0KPiAgIG5ldC9zeGUyOiBhZGQgbGluayB1cGRhdGUgY2FsbGJhY2sNCj4gICBu
ZXQvc3hlMjogc3VwcG9ydCBMMiBmaWx0ZXJpbmcgYW5kIE1BQyBjb25maWcNCj4gICBkcml2ZXJz
OiBzdXBwb3J0IFJTUyBmZWF0dXJlDQo+ICAgbmV0L3N4ZTI6IHN1cHBvcnQgVE0gaGllcmFyY2h5
IGFuZCBzaGFwaW5nDQo+ICAgbmV0L3N4ZTI6IHN1cHBvcnQgSVBzZWMgaW5saW5lIHByb3RvY29s
IG9mZmxvYWQNCj4gICBuZXQvc3hlMjogc3VwcG9ydCBzdGF0aXN0aWNzIGFuZCBtdWx0aS1wcm9j
ZXNzDQo+ICAgZHJpdmVyczogaW50ZXJydXB0IGhhbmRsaW5nDQo+ICAgbmV0L3N4ZTI6IGFkZCBO
RU9OIHZlYyBSeC9UeCBidXJzdCBmdW5jdGlvbnMNCj4gICBkcml2ZXJzOiBhZGQgc3VwcG9ydCBm
b3IgVkYgcmVwcmVzZW50b3JzDQo+ICAgbmV0L3N4ZTI6IGFkZCBzdXBwb3J0IGZvciBjdXN0b20g
VURQIHR1bm5lbCBwb3J0cw0KPiAgIG5ldC9zeGUyOiBzdXBwb3J0IGZpcm13YXJlIHZlcnNpb24g
cmVhZGluZw0KPiAgIG5ldC9zeGUyOiBpbXBsZW1lbnQgZ2V0IG1vbml0b3IgYWRkcmVzcw0KPiAg
IGNvbW1vbi9zeGUyOiBhZGQgc2hhcmVkIFNGUCBtb2R1bGUgZGVmaW5pdGlvbnMNCj4gICBuZXQv
c3hlMjogc3VwcG9ydCBTRlAgbW9kdWxlIGluZm8gYW5kIEVFUFJPTSBhY2Nlc3MNCj4gICBuZXQv
c3hlMjogYWRkIG1idWYgdmFsaWRhdGlvbiBpbiBUeCBkZWJ1ZyBtb2RlDQo+ICAgY29tbW9uL3N4
ZTI6IGFkZCBjYWxsYmFjayBmb3IgbWVtb3J5IGV2ZW50IGhhbmRsaW5nDQo+ICAgbmV0L3N4ZTI6
IGFkZCBwcml2YXRlIGRldmFyZ3MgcGFyc2luZw0KPiAgIG5ldC9zeGUyOiBpbXBsZW1lbnQgcHJp
dmF0ZSBkdW1wIGluZm8NCj4gICBuZXQvc3hlMjogdXBkYXRlIHN4ZTIgZmVhdHVyZSBtYXRyaXgg
ZG9jcw0KPiANCj4gIGRvYy9ndWlkZXMvbmljcy9mZWF0dXJlcy9zeGUyLmluaSAgICAgICAgICB8
ICAgNTYgKw0KPiAgZG9jL2d1aWRlcy9uaWNzL3N4ZTIucnN0ICAgICAgICAgICAgICAgICAgIHwg
IDE2OCArKw0KPiAgZHJpdmVycy9jb21tb24vc3hlMi9zeGUyX2NvbW1vbi5jICAgICAgICAgIHwg
IDE1NiArKw0KPiAgZHJpdmVycy9jb21tb24vc3hlMi9zeGUyX2NvbW1vbi5oICAgICAgICAgIHwg
ICAgNCArDQo+ICBkcml2ZXJzL2NvbW1vbi9zeGUyL3N4ZTJfZmxvd19wdWJsaWMuaCAgICAgfCAg
NjMzICsrKysrKysNCj4gIGRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9pb2N0bF9jaG5sLmMgICAg
ICB8ICAxNzggKy0NCj4gIGRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9pb2N0bF9jaG5sX2Z1bmMu
aCB8ICAgMTggKw0KPiAgZHJpdmVycy9jb21tb24vc3hlMi9zeGUyX21zZy5oICAgICAgICAgICAg
IHwgIDExOCArKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9tZXNvbi5idWlsZCAgICAgICAgICAgICAg
IHwgICA1MiArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfY21kX2NobmwuYyAgICAgICAgICAg
fCAxNTg3ICsrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9jbWRfY2hu
bC5oICAgICAgICAgICB8ICAxMzkgKysNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9kcnZfY21k
LmggICAgICAgICAgICB8ICA1MjMgKysrKystDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZHVt
cC5jICAgICAgICAgICAgICAgfCAgMjg3ICsrKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2R1
bXAuaCAgICAgICAgICAgICAgIHwgICAxMiArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZXRo
ZGV2LmMgICAgICAgICAgICAgfCAxNDg2ICsrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9uZXQv
c3hlMi9zeGUyX2V0aGRldi5oICAgICAgICAgICAgIHwgIDExMSArLQ0KPiAgZHJpdmVycy9uZXQv
c3hlMi9zeGUyX2V0aGRldl9yZXByLmMgICAgICAgIHwgIDYwOSArKysrKysNCj4gIGRyaXZlcnMv
bmV0L3N4ZTIvc3hlMl9ldGhkZXZfcmVwci5oICAgICAgICB8ICAgMzIgKw0KPiAgZHJpdmVycy9u
ZXQvc3hlMi9zeGUyX2ZpbHRlci5jICAgICAgICAgICAgIHwgIDg5NSArKysrKysrKysNCj4gIGRy
aXZlcnMvbmV0L3N4ZTIvc3hlMl9maWx0ZXIuaCAgICAgICAgICAgICB8ICAxMDAgKw0KPiAgZHJp
dmVycy9uZXQvc3hlMi9zeGUyX2Zsb3cuYyAgICAgICAgICAgICAgIHwgMTM5NCArKysrKysrKysr
KysrKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3cuaCAgICAgICAgICAgICAgIHwgICAz
MCArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19kZWZpbmUuaCAgICAgICAgfCAgMTQ0
ICsrDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9hY3Rpb24uYyAgfCAxMTgy
ICsrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfYWN0aW9u
LmggIHwgICAyMyArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9lbmdpbmUu
YyAgfCAgMTA2ICsrDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9lbmdpbmUu
aCAgfCAgIDEzICsNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X3BhcnNlX3BhdHRlcm4u
YyB8IDE5MzUgKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zs
b3dfcGFyc2VfcGF0dGVybi5oIHwgICA0NiArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfaXBz
ZWMuYyAgICAgICAgICAgICAgfCAxNTY1ICsrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvbmV0
L3N4ZTIvc3hlMl9pcHNlYy5oICAgICAgICAgICAgICB8ICAyNTQgKysrDQo+ICBkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfaXJxLmMgICAgICAgICAgICAgICAgfCAxMDI2ICsrKysrKysrKysNCj4gIGRy
aXZlcnMvbmV0L3N4ZTIvc3hlMl9pcnEuaCAgICAgICAgICAgICAgICB8ICAgMjUgKw0KPiAgZHJp
dmVycy9uZXQvc3hlMi9zeGUyX21hYy5jICAgICAgICAgICAgICAgIHwgIDUzMCArKysrKysNCj4g
IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9tYWMuaCAgICAgICAgICAgICAgICB8ICAgODQgKw0KPiAg
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX21wLmMgICAgICAgICAgICAgICAgIHwgIDQxNCArKysrKw0K
PiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX21wLmggICAgICAgICAgICAgICAgIHwgICA2NyArDQo+
ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfcXVldWUuYyAgICAgICAgICAgICAgfCAgIDE3ICstDQo+
ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfcXVldWUuaCAgICAgICAgICAgICAgfCAgIDE1ICstDQo+
ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfcnNzLmMgICAgICAgICAgICAgICAgfCAgNTg0ICsrKysr
Kw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3Jzcy5oICAgICAgICAgICAgICAgIHwgICA4MSAr
DQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfcnguYyAgICAgICAgICAgICAgICAgfCAgIDkzICst
DQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfcnguaCAgICAgICAgICAgICAgICAgfCAgICAyICsN
Cj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9zZWN1cml0eS5jICAgICAgICAgICB8ICAzMzUgKysr
Kw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3NlY3VyaXR5LmggICAgICAgICAgIHwgICA3NyAr
DQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfc3RhdHMuYyAgICAgICAgICAgICAgfCAgNTg2ICsr
KysrKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3N0YXRzLmggICAgICAgICAgICAgIHwgICAz
OSArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfc3dpdGNoZGV2LmMgICAgICAgICAgfCAgMzMy
ICsrKysNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9zd2l0Y2hkZXYuaCAgICAgICAgICB8ICAg
MzMgKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3RtLmMgICAgICAgICAgICAgICAgIHwgMTE1
MSArKysrKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl90bS5oICAgICAgICAgICAg
ICAgICB8ICAgNzYgKw0KPiAgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3R4LmMgICAgICAgICAgICAg
ICAgIHwgICAgNyArDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfdHhyeC5jICAgICAgICAgICAg
ICAgfCAxOTU4ICsrKysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4ZTJf
dHhyeC5oICAgICAgICAgICAgICAgfCAgICA4ICsNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl90
eHJ4X2NoZWNrX21idWYuYyAgICB8ICA1OTUgKysrKysrDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfdHhyeF9jaGVja19tYnVmLmggICAgfCAgIDM4ICsNCj4gIGRyaXZlcnMvbmV0L3N4ZTIvc3hl
Ml90eHJ4X3BvbGwuYyAgICAgICAgICB8ICAyODQgKystDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfdHhyeF92ZWMuYyAgICAgICAgICAgfCAgIDQ2ICstDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfdHhyeF92ZWMuaCAgICAgICAgICAgfCAgIDM4ICstDQo+ICBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfdHhyeF92ZWNfYXZ4Mi5jICAgICAgfCAgNzQ3ICsrKysrKysrDQo+ICBkcml2ZXJzL25ldC9z
eGUyL3N4ZTJfdHhyeF92ZWNfYXZ4NTEyLmMgICAgfCAgODY3ICsrKysrKysrKw0KPiAgZHJpdmVy
cy9uZXQvc3hlMi9zeGUyX3R4cnhfdmVjX2NvbW1vbi5oICAgIHwgICA1NCArLQ0KPiAgZHJpdmVy
cy9uZXQvc3hlMi9zeGUyX3R4cnhfdmVjX25lb24uYyAgICAgIHwgIDY4OSArKysrKysrDQo+ICBk
cml2ZXJzL25ldC9zeGUyL3N4ZTJfdHhyeF92ZWNfc3NlLmMgICAgICAgfCAgIDM4ICstDQo+ICBk
cml2ZXJzL25ldC9zeGUyL3N4ZTJfdnNpLmMgICAgICAgICAgICAgICAgfCAgMTQ2ICsrDQo+ICBk
cml2ZXJzL25ldC9zeGUyL3N4ZTJfdnNpLmggICAgICAgICAgICAgICAgfCAgIDEyICstDQo+ICBk
cml2ZXJzL25ldC9zeGUyL3N4ZTJ2Zl9yZWdzLmggICAgICAgICAgICAgfCAgIDg1ICsNCj4gIDY3
IGZpbGVzIGNoYW5nZWQsIDI0NzYyIGluc2VydGlvbnMoKyksIDI3MyBkZWxldGlvbnMoLSkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NvbW1vbi9zeGUyL3N4ZTJfZmxvd19wdWJsaWMu
aA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY29tbW9uL3N4ZTIvc3hlMl9tc2cuaA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9kdW1wLmMNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZHVtcC5oDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2V0aGRldl9yZXByLmMNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZXRoZGV2X3JlcHIuaA0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9maWx0ZXIuYw0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9maWx0ZXIuaA0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93LmMNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvdy5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfZGVmaW5lLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJzZV9hY3Rpb24uYw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9mbG93X3BhcnNlX2FjdGlvbi5oDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX2Zsb3dfcGFyc2VfZW5naW5l
LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfZmxvd19wYXJz
ZV9lbmdpbmUuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9m
bG93X3BhcnNlX3BhdHRlcm4uYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4
ZTIvc3hlMl9mbG93X3BhcnNlX3BhdHRlcm4uaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbmV0L3N4ZTIvc3hlMl9pcHNlYy5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
ZXQvc3hlMi9zeGUyX2lwc2VjLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9z
eGUyL3N4ZTJfaXJxLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4
ZTJfbWFjLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfbWFj
LmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJfbXAuYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIvc3hlMl9tcC5oDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3Jzcy5jDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3Jzcy5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvc3hlMi9zeGUyX3NlY3VyaXR5LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL25ldC9zeGUyL3N4ZTJfc2VjdXJpdHkuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L3N4ZTIvc3hlMl9zdGF0cy5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvc3hlMi9zeGUyX3N0YXRzLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfc3dpdGNoZGV2LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfc3dpdGNoZGV2LmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25l
dC9zeGUyL3N4ZTJfdG0uYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3N4ZTIv
c3hlMl90bS5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9zeGUyX3R4
cnhfY2hlY2tfbWJ1Zi5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvc3hlMi9z
eGUyX3R4cnhfY2hlY2tfbWJ1Zi5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQv
c3hlMi9zeGUyX3R4cnhfdmVjX2F2eDIuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
bmV0L3N4ZTIvc3hlMl90eHJ4X3ZlY19hdng1MTIuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L3N4ZTIvc3hlMl90eHJ4X3ZlY19uZW9uLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL25ldC9zeGUyL3N4ZTJ2Zl9yZWdzLmgNCiANCk92ZXJhbGwgdGhpcyBpcyBjbG9z
ZSwgSSBkb24ndCB0aGluayB0aGUgZmxvdyBkdXBsaWNhdGUgZmxhZyB5b3UNCmFkZGVkIG1hdGNo
ZXMgbWx4NSBhcyBjbG9zZSBhcyB5b3UgdGhpbmsuIEFkZGluZyBhIG5ldyB2YXJpYW50IG1ha2Vz
DQpzZW5zZSwgYnV0IHRyeSB0byBrZWVwIG9yaWdpbmFsIHZhbHVlcyBtYXRjaGluZyBvdGhlciBk
cml2ZXIuDQpNeSBpbnRlbnQgaGVyZSBpcyB0byBoYXZlIGRyaXZlcnMgZGl2ZXJnZSBhcyBsaXR0
bGUgYXMgcG9zc2libGU7DQppdCBtYWtlcyBpdCBzaW1wbGVyIGZvciByZWFsIHdvcmxkIGFwcGxp
Y2F0aW9ucy4NCiANClRoZSBBSSBjaGF0IHJldmlldyBzaG93ZWQ6DQogDQpbUEFUQ0ggdjggMDAv
MjNdIHN4ZTIgZHJpdmVyIGZlYXR1cmUgYWRkaXRpb25zDQogDQpUaGUgdjYgaXNzdWVzIGFyZSBy
ZXNvbHZlZCBjbGVhbmx5LCBleGNlcHQgdGhlIGZsb3ctZHVwbGljYXRlLXBhdHRlcm4NCmFsaWdu
bWVudCBkaWRuJ3QgZ28gaW4gdGhlIGRpcmVjdGlvbiB5b3VyICJhbGlnbiB3aXRoIG1seDUiIGd1
aWRhbmNlDQppbnRlbmRlZC4NCiANClJlc29sdmVkIGZyb20gdjY6DQogDQotIFRoZSBtYm94IGlz
IG5vdyBpbiBjb3JyZWN0IG51bWVyaWMgb3JkZXIgKDA2IGJlZm9yZSAwNykuIGdpdCBhbQ0KICBi
dW5kbGUubWJveCBhcHBsaWVzIGNsZWFubHkuIFRoZSB2NiBidW5kbGUtb3JkZXIgYnJlYWsgaXMg
Z29uZS4NCiANCi0gQWxsIDIzIGNvbW1pdHMgYnVpbGQgZW5kLXRvLWVuZCBhdCBldmVyeSBjb21t
aXQuIFRoZSBkdW1wLWluZm8gcGF0Y2gNCiAgd2FzIG1vdmVkIGZyb20gcG9zaXRpb24gMTkgdG8g
MjIgLSBpdCBub3cgcnVucyBhZnRlciBkZXZhcmdzIHBhcnNpbmcsDQogIHdoaWNoIG1ha2VzIGl0
cyByZWZlcmVuY2VzIHRvIGRldmFyZ3MgZmllbGRzIGNvbnNpc3RlbnQuIHN4ZTJfZHVtcF9mY19z
dGF0ZSgpDQogIGFsc28gY29ycmVjdGx5IG1vdmVkIG91dCBvZiB0aGUgZGV2YXJncyBwYXRjaCBp
bnRvIHRoZSBkdW1wLWluZm8gcGF0Y2gNCiAgd2hlcmUgaXQgYmVsb25ncy4NCiANCi0gVGhlIHY2
IGZsb3dfZHVwX3BhdHRlcm5fbW9kZSBvcnBoYW4gc2l0dWF0aW9uIGlzIGZpeGVkLiBUaGUgZmll
bGQgaXMNCiAgbm93IGFjdHVhbGx5IHdyaXR0ZW4gYnkgdGhlIG5ldyBzeGUyX3BhcnNlX2Zsb3df
ZHVwX3BhdHRlcm5fbW9kZSgpDQogIHBhcnNlciwgcHJvcGVybHkgZGVmYXVsdGVkIHRvIFNYRTJf
RkxPV19TV19QQVRURVJOX0xBU1QgaW4gaW5pdCwgYW5kDQogIHJlYWQgYXQgc3hlMl9mbG93LmM6
MzEwIHRvIHBvcHVsYXRlIHN3aXRjaF9wYXR0ZXJuX2R1cF9hbGxvdyBpbiBmbG93DQogIG1ldGFk
YXRhLiBUaGUgc3RydWN0IGZpZWxkLCBpdHMgd3JpdGVyLCBpdHMgcmVhZGVyLCBhbmQgaXRzIGhh
cmR3YXJlLQ0KICBwcm9ncmFtbWluZyBwYXRoIGFyZSBhbGwgY29uc2lzdGVudCBub3cuDQogDQot
IHN4ZTJfcGFyc2Vfbm9fc2NoZWRfbW9kZSB3YXMgc2ltcGxpZmllZCB0byBjYWxsIHRoZSBleGlz
dGluZw0KICBzeGUyX3BhcnNlX2Jvb2wgaGVscGVyIGluc3RlYWQgb2YgZHVwbGljYXRpbmcgc3Ry
dG91bCBib2lsZXJwbGF0ZS4gTmljZQ0KICBjbGVhbnVwLg0KIA0KVGhlIGZsb3ctZHVwbGljYXRl
LXBhdHRlcm4gc2VtYW50aWNzOg0KIA0KVGhpcyBpcyB0aGUgdjggcmVkZXNpZ24gaW4gcmVzcG9u
c2UgdG8gImFsaWduIHRvIG1seDUiLiBXaGF0IGl0IGRvZXM6DQogDQogIGRvYy9ndWlkZXMvbmlj
cy9zeGUyLnJzdCwgdGhlIG9wdGlvbjoNCiAgICAwID0gcmVqZWN0IGR1cGxpY2F0ZXMgd2l0aCBF
RVhJU1QNCiAgICAxID0gYWxsb3c7IGxhc3QtYWRkZWQgcnVsZSBhY3RpdmUgKExJRk8pICAgICAg
ICA8LS0gZGVmYXVsdA0KICAgIDIgPSBhbGxvdzsgZmlyc3QtYWRkZWQgcnVsZSBhY3RpdmUgKEZJ
Rk8pDQogDQptbHg1J3MgZXF1aXZhbGVudCBhbGxvd19kdXBsaWNhdGVfcGF0dGVybiBpcyBhIHsw
LDF9IGJvb2xlYW4uIEl0cw0KdmFsdWU9MSBtZWFucyAiYWxsIHJ1bGVzIGFyZSBpbnNlcnRlZCBi
dXQgb25seSB0aGUgZmlyc3QgcnVsZSB0YWtlcw0KZWZmZWN0LCB0aGUgbmV4dCBydWxlIHRha2Vz
IGVmZmVjdCBvbmx5IGlmIHRoZSBwcmV2aW91cyBydWxlcyBhcmUNCmRlbGV0ZWQuIiBUaGF0IGlz
IEZJRk8uIFNvOg0KIA0KICBtbHg1IGFsbG93X2R1cGxpY2F0ZV9wYXR0ZXJuPTAgID09ICBzeGUy
IGZsb3ctZHVwbGljYXRlLXBhdHRlcm49MA0KICBtbHg1IGFsbG93X2R1cGxpY2F0ZV9wYXR0ZXJu
PTEgID09ICBzeGUyIGZsb3ctZHVwbGljYXRlLXBhdHRlcm49MiAoRklGTykNCiAgKG5vIG1seDUg
ZXF1aXZhbGVudCkgICAgICAgICAgICA9PSAgc3hlMiBmbG93LWR1cGxpY2F0ZS1wYXR0ZXJuPTEg
KExJRk8pDQogDQpUaGlzIGlzIHRoZSB3b3JzdCBwb3NzaWJsZSBhbGlnbm1lbnQ6IHN4ZTIgcGlj
a2VkIHRoZSBzYW1lIHZhbHVlIHJhbmdlDQp7MCwxfSBtbHg1IGhhcywgcGlja2VkIHRoZSBzYW1l
IG5hbWUgcm9vdCwgcGlja2VkIHNpbWlsYXIgZG9jdW1lbnRhdGlvbg0Kd29yZGluZywgYW5kIG1h
ZGUgdGhlIHNhbWUgdmFsdWUgMSBtZWFuIHRoZSBvcHBvc2l0ZSBoYXJkd2FyZSBiZWhhdmlvdXIu
DQpBIHVzZXIgd2hvIHJ1bnMgdGhlIHNhbWUgYC1hIDAwMDA6eHg6eHgueCxmbG93LWR1cGxpY2F0
ZS1wYXR0ZXJuPTFgIG9uDQpib3RoIFBNRHMgZ2V0cyBGSUZPIG9uIG1seDUgYW5kIExJRk8gb24g
c3hlMiAtIGludmVydGVkIHNlbWFudGljcyB1bmRlcg0KaWRlbnRpY2FsIG5hbWVzLg0KIA0KSWYg
dGhlIGhhcmR3YXJlIGdlbnVpbmVseSBzdXBwb3J0cyBib3RoIExJRk8gYW5kIEZJRk8gYW5kIGV4
cG9zaW5nIGJvdGgNCmlzIHZhbHVhYmxlLCB0aGVuIG5hbWluZyBhbmQgZGVmYXVsdHMgc2hvdWxk
IG5vdCB2aXN1YWxseSBwYXJhbGxlbCBtbHg1Lg0KU3VnZ2VzdGVkIHJlc29sdXRpb25zLCBpbiBv
cmRlciBvZiBwcmVmZXJlbmNlOg0KIA0KICAoYSkgRHJvcCBMSUZPLiBEb2N1bWVudCBhbmQgaW1w
bGVtZW50IG9ubHkgdGhlIHR3byBtb2RlcyBtbHg1IGhhczoNCiAgICAgIDAgPSByZWplY3QsIDEg
PSBGSUZPIChtbHg1J3MgdmFsdWU9MSBzZW1hbnRpYykuIERlZmF1bHQgMS4gVGhlDQogICAgICBu
YW1lIGFsbG93X2R1cGxpY2F0ZV9wYXR0ZXJuIChtbHg1J3Mgc3BlbGxpbmcpIGJlY29tZXMgdmFs
aWQgLQ0KICAgICAgc2FtZSBwYXJhbWV0ZXIsIHNhbWUgdmFsdWVzLCBzYW1lIGRlZmF1bHRzIGFj
cm9zcyBQTURzLg0KIA0KICAoYikgS2VlcCBib3RoIG1vZGVzLCBidXQgcmVuYW1lIHRvIG1ha2Ug
dGhlIG1lYW5pbmcgZXhwbGljaXQgYW5kDQogICAgICBub24tb3ZlcmxhcHBpbmcgd2l0aCBtbHg1
Og0KICAgICAgICBmbG93LWR1cGxpY2F0ZS1wb2xpY3k9cmVqZWN0fGZpZm98bGlmbyAgKHN0cmlu
Zy12YWx1ZWQpDQogICAgICB3aXRoIHJlamVjdCBhcyBkZWZhdWx0LiBtbHg1IGtlZXBzIGl0cyBz
aG9ydCBib29sZWFuOyBzeGUyIGhhcw0KICAgICAgaXRzIG93biB0cmktc3RhdGUgd2l0aCBub24t
YWxpYXNpbmcgdmFsdWVzLiBUaGlzIGlzIGNsZWFyIGJ1dA0KICAgICAgc2xpZ2h0bHkgbW9yZSB0
eXBpbmcgZm9yIHVzZXJzLg0KIA0KICAoYykgS2VlcCBjdXJyZW50IG5hbWUgYW5kIHZhbHVlcyBi
dXQgbWFrZSB2YWx1ZT0xIG1lYW4gRklGTyAobWF0Y2hpbmcNCiAgICAgIG1seDUpIGFuZCB2YWx1
ZT0yIG1lYW4gTElGTy4gVGhlIG5hbWUncyBzcGVsbGluZyBzdGlsbCBkaWZmZXJzDQogICAgICBm
cm9tIG1seDUncywgYnV0IGF0IGxlYXN0IHRoZSBpbnRlZ2VyLXRvLXNlbWFudGljIG1hcHBpbmcg
bWF0Y2hlcy4NCiANClBlcnNvbmFsIHByZWZlcmVuY2UgaXMgKGEpLiBUaGUgTElGTyBtb2RlIGlz
IHVudXN1YWwgZW5vdWdoIHRoYXQgSSB3b3VsZA0Kd2FudCB0byBzZWUgYSBjb25jcmV0ZSB1c2Ug
Y2FzZSBiZWZvcmUgYWNjZXB0aW5nIGl0IGludG8gYSBwdWJsaWMNCmRldmFyZy4gSWYgdGhlIGhh
cmR3YXJlIHF1ZXVlcyBydWxlcyBpbiBhbiBvcmRlciBhcHBsaWNhdGlvbnMgY2FuDQpvYnNlcnZl
LCB0aGF0IG9yZGVyaW5nIGlzIGFuIHJ0ZV9mbG93IHByaW9yaXR5IGNvbmNlcm47IHRoZSBkZXZh
cmcgbGF5ZXINCnNob3VsZG4ndCBiZSBlbmNvZGluZyBpdC4NCiANCkEgc2VwYXJhdGUgc21hbGwg
aXNzdWUgaW4gdGhlIGVycm9yLW1lc3NhZ2UgdGVybmFyeSAtIHN4ZTJfZmxvdy5jOjgwOQ0KcHJp
bnRzICJEdXBsaWNhdGUgZmxvdyBwYXR0ZXJuLiIgd2hlbiBtb2RlIGlzIG5vbi16ZXJvIGFuZCAi
RHVwbGljYXRlDQpmbG93IHBhdHRlcm4gaXMgbm90IGFsbG93ZWQuIiB3aGVuIG1vZGUgaXMgemVy
by4gQnV0IHRoZSBFRVhJU1QgZXJyb3INCnBhdGggc2hvdWxkIG9ubHkgZmlyZSB3aGVuIHRoZSBw
b2xpY3kgaXMgdG8gcmVqZWN0LCB3aGljaCBpcyBleGFjdGx5DQptb2RlIDAuIEluIG1vZGVzIDEg
YW5kIDIsIHRoZSBoYXJkd2FyZSBhY2NlcHRzIHRoZSBkdXBsaWNhdGUgYXMgYQ0Kc2hhZG93L2Fj
dGl2ZSBydWxlOyB0aGlzIGVycm9yIHBhdGggc2hvdWxkIGJlIHVucmVhY2hhYmxlLiBFaXRoZXIg
dGhlDQp0ZXJuYXJ5J3MgZmlyc3QgYnJhbmNoIGlzIGRlYWQgY29kZSAoaW4gd2hpY2ggY2FzZSBy
ZW1vdmUgaXQgYW5kIHRoZQ0KdGVybmFyeTsgcHJpbnQgb25seSB0aGUgcmVqZWN0aW9uIG1lc3Nh
Z2UpLCBvciB0aGUgcmVqZWN0aW9uIGNhbg0KaGFwcGVuIGluIG1vZGVzIDEvMiB0b28gKGluIHdo
aWNoIGNhc2UgdGhlIG1lc3NhZ2UgbXVzdCBleHBsYWluIHdoeSAtDQp0YWJsZSBmdWxsLCBhY3Rp
b24gY29uZmxpY3QsIGV0YyAtIGFuZCB0aGUgY3VycmVudCB3b3JkaW5nIGlzIHdyb25nDQppbiBi
b3RoIGJyYW5jaGVzKS4NCiANCk90aGVyd2lzZSB0aGlzIHJldmlzaW9uIGlzIGluIGdvb2Qgc2hh
cGUuIE9uY2UgZmxvdy1kdXBsaWNhdGUtcGF0dGVybg0KYWxpZ25tZW50IGxhbmRzIG9uZSB3YXkg
b3IgYW5vdGhlciwgcmVhZHkgdG8gbWVyZ2UuDQo=

------=_001_NextPart765023518382_=----
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DISO-8859-1"><style>body { line-height: 1.5; }blockquote { margin-top: =
0px; margin-bottom: 0px; margin-left: 0.5em; }ol, ul { margin-top: 0px; ma=
rgin-bottom: 0px; list-style-position: inside; }p { margin-top: 0px; margi=
n-bottom: 0px; }.fox_html_content_dummy_textarea { position: absolute; ove=
rflow: hidden; width: 1px; height: 1px; opacity: 0; }body { font-size: 14p=
x; font-family: "Microsoft YaHei UI"; color: rgb(0, 0, 0); line-height: 1.=
5; }</style></head><body>=0A<div><span></span><p>Hi,</p><p>Thanks for the =
detailed review and valuable suggestions.</p><p>The reason I introduced bo=
th FIFO and LIFO modes is that different hardware vendors implement differ=
ent native behaviors for duplicate flow rules with the same priority. Some=
 devices keep the first inserted rule active, while others make the most r=
ecently inserted rule active. The intention of exposing both modes is to p=
reserve the underlying hardware semantics instead of forcing all devices i=
nto a single policy.</p><p>I agree with your point that, if the interface =
is intended to align with mlx5, the mapping between parameter values and t=
heir semantics should also be consistent. Using the same value with opposi=
te behavior across PMDs would indeed be confusing for users.</p><p>Therefo=
re, I think your option (c) is a reasonable compromise:</p><ul><li><p>0 =
=3D reject duplicates</p></li><li><p>1 =3D FIFO (matching mlx5 semantics)<=
/p></li><li><p>2 =3D LIFO</p></li></ul><p>This keeps the common case compa=
tible with mlx5 while still allowing hardware with native LIFO behavior to=
 expose its capability.</p><p>Regarding the error message, I also agree th=
at the current ternary expression is unnecessary if EEXIST is only returne=
d in reject mode. I'll simplify the error handling accordingly in the next=
 revision.</p><p>Thanks again for your review.</p><p>Best regards,<br>Liu =
Jie</p></div>=0A<div><br></div><hr style=3D"width: 210px; height: 1px;" co=
lor=3D"#b5c4df" size=3D"1" align=3D"left">=0A<div><span><div style=3D"MARG=
IN: 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt"><div>liujie5@linkdatatech=
nology.com</div></div></span></div>=0A<blockquote style=3D"margin-Top: 0px=
; margin-Bottom: 0px; margin-Left: 0.5em; margin-Right: inherit"><div>&nbs=
p;</div><div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3=
.0pt 0cm 0cm 0cm"><div style=3D"PADDING-RIGHT: 8px; PADDING-LEFT: 8px; FON=
T-SIZE: 12px;FONT-FAMILY:tahoma;COLOR:#000000; BACKGROUND: #efefef; PADDIN=
G-BOTTOM: 8px; PADDING-TOP: 8px"><div><b>From:</b>&nbsp;<a href=3D"mailto:=
stephen@networkplumber.org">Stephen Hemminger</a></div><div><b>Date:</b>&n=
bsp;2026-06-26&nbsp;06:50</div><div><b>To:</b>&nbsp;<a href=3D"mailto:liuj=
ie5@linkdatatechnology.com">liujie5</a></div><div><b>CC:</b>&nbsp;<a href=
=3D"mailto:dev@dpdk.org">dev</a></div><div><b>Subject:</b>&nbsp;Re: [PATCH=
 v8 00/23] net/sxe2: added Linkdata sxe2 ethernet driver</div></div></div>=
<div><div>On Thu, 25 Jun 2026 21:19:36 +0800</div>=0A<div>liujie5@linkdata=
technology.com wrote:</div>=0A<div>&nbsp;</div>=0A<div>&gt; From: Jie Liu =
&lt;liujie5@linkdatatechnology.com&gt;</div>=0A<div>&gt; </div>=0A<div>&gt=
; This patch set implements core functionality for the SXE2 PMD,</div>=0A<=
div>&gt; including basic driver framework, data path setup, and advanced</=
div>=0A<div>&gt; offload features (VLAN, RSS,TM, PTP etc.).</div>=0A<div>&=
gt; </div>=0A<div>&gt; v8:</div>=0A<div>&gt; 	Restore the flow-duplicate-p=
attern parameter</div>=0A<div>&gt; </div>=0A<div>&gt; Jie Liu (23):</div>=
=0A<div>&gt;&nbsp;&nbsp; net/sxe2: remove software statistics devargs</div=
>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: add Rx framework and packet types call=
back</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support AVX512 vectorized pat=
h for Rx and Tx</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: add AVX2 vector da=
ta path for Rx and Tx</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: add link upd=
ate callback</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support L2 filtering =
and MAC config</div>=0A<div>&gt;&nbsp;&nbsp; drivers: support RSS feature<=
/div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support TM hierarchy and shaping</=
div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support IPsec inline protocol offlo=
ad</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support statistics and multi-pr=
ocess</div>=0A<div>&gt;&nbsp;&nbsp; drivers: interrupt handling</div>=0A<d=
iv>&gt;&nbsp;&nbsp; net/sxe2: add NEON vec Rx/Tx burst functions</div>=0A<=
div>&gt;&nbsp;&nbsp; drivers: add support for VF representors</div>=0A<div=
>&gt;&nbsp;&nbsp; net/sxe2: add support for custom UDP tunnel ports</div>=
=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support firmware version reading</div>=
=0A<div>&gt;&nbsp;&nbsp; net/sxe2: implement get monitor address</div>=0A<=
div>&gt;&nbsp;&nbsp; common/sxe2: add shared SFP module definitions</div>=
=0A<div>&gt;&nbsp;&nbsp; net/sxe2: support SFP module info and EEPROM acce=
ss</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: add mbuf validation in Tx debug=
 mode</div>=0A<div>&gt;&nbsp;&nbsp; common/sxe2: add callback for memory e=
vent handling</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: add private devargs =
parsing</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: implement private dump inf=
o</div>=0A<div>&gt;&nbsp;&nbsp; net/sxe2: update sxe2 feature matrix docs<=
/div>=0A<div>&gt; </div>=0A<div>&gt;&nbsp; doc/guides/nics/features/sxe2.i=
ni&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 56 =
+</div>=0A<div>&gt;&nbsp; doc/guides/nics/sxe2.rst&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 168 ++</div>=0A<div>&gt;&nbsp; drivers/common/sxe2/sxe2=
_common.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15=
6 ++</div>=0A<div>&gt;&nbsp; drivers/common/sxe2/sxe2_common.h&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 +</div>=
=0A<div>&gt;&nbsp; drivers/common/sxe2/sxe2_flow_public.h&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 633 +++++++</div>=0A<div>&gt;&nbsp; drivers/common/sxe2/sx=
e2_ioctl_chnl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 178 +-</div>=0A<div>=
&gt;&nbsp; drivers/common/sxe2/sxe2_ioctl_chnl_func.h |&nbsp;&nbsp; 18 +</=
div>=0A<div>&gt;&nbsp; drivers/common/sxe2/sxe2_msg.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 118 ++</div>=
=0A<div>&gt;&nbsp; drivers/net/sxe2/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 52=
 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_cmd_chnl.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1587 +++++++++++++++-</div=
>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_cmd_chnl.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 139 ++</div>=0A<div>&gt;&nb=
sp; drivers/net/sxe2/sxe2_drv_cmd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 523 +++++-</div>=0A<div>&gt;&nbsp; dri=
vers/net/sxe2/sxe2_dump.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 287 +++</div>=0A<div>&gt;&nbsp=
; drivers/net/sxe2/sxe2_dump.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +</div>=0A<div>&=
gt;&nbsp; drivers/net/sxe2/sxe2_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1486 ++++++++++++++-</div>=0A<div=
>&gt;&nbsp; drivers/net/sxe2/sxe2_ethdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 111 +-</div>=0A<div>&gt;&=
nbsp; drivers/net/sxe2/sxe2_ethdev_repr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 609 ++++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2=
_ethdev_repr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 32 =
+</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_filter.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 895 +++++++=
++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_filter.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 100 +</div=
>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1394 ++++++++=
++++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow.h&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp;&nbsp; 30 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow_define.h=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 144 ++</div>=0A<div>&gt=
;&nbsp; drivers/net/sxe2/sxe2_flow_parse_action.c&nbsp; | 1182 +++++++++++=
+</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow_parse_action.h&nbsp; =
|&nbsp;&nbsp; 23 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow_pars=
e_engine.c&nbsp; |&nbsp; 106 ++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/s=
xe2_flow_parse_engine.h&nbsp; |&nbsp;&nbsp; 13 +</div>=0A<div>&gt;&nbsp; d=
rivers/net/sxe2/sxe2_flow_parse_pattern.c | 1935 +++++++++++++++++++</div>=
=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_flow_parse_pattern.h |&nbsp;&nbsp=
; 46 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_ipsec.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1565 ++=
++++++++++++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_ipsec.h&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 254 +++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_irq.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 1026 ++++++++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_i=
rq.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 25 +</div>=0A<div>&gt;&nbsp; drivers/ne=
t/sxe2/sxe2_mac.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 530 ++++++</div>=0A<div>&gt;&nbs=
p; drivers/net/sxe2/sxe2_mac.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 84 +</div>=0A=
<div>&gt;&nbsp; drivers/net/sxe2/sxe2_mp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4=
14 +++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_mp.h&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 67 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_q=
ueue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 17 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sx=
e2_queue.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp;&nbsp; 15 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe=
2/sxe2_rss.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 584 ++++++</div>=0A<div>&gt;&nbsp; dr=
ivers/net/sxe2/sxe2_rss.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 81 +</div>=0A<div>=
&gt;&nbsp; drivers/net/sxe2/sxe2_rx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; =
93 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_rx.h&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp; 2 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2=
_security.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 335 ++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_security.h&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 77=
 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_stats.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 586 +=
+++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_stats.h&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nb=
sp; 39 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_switchdev.c&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 332 ++++</div>=0A<d=
iv>&gt;&nbsp; drivers/net/sxe2/sxe2_switchdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 33 +</div>=0A<div>&gt;&nbsp; dri=
vers/net/sxe2/sxe2_tm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1151 ++++++++++++</div>=0A=
<div>&gt;&nbsp; drivers/net/sxe2/sxe2_tm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 76 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_tx.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/=
sxe2_txrx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 1958 +++++++++++++++++++-</div>=0A<div>&gt;&nbsp; =
drivers/net/sxe2/sxe2_txrx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 8 +</div>=0A<di=
v>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_check_mbuf.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 595 ++++++</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_check_m=
buf.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 38 +</div>=0A<div>&gt;&nbsp; drivers=
/net/sxe2/sxe2_txrx_poll.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 284 ++-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_=
vec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 46 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_vec.h&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 38 +-=
</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_vec_avx2.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp; 747 ++++++++</div>=0A<div>&gt;&nbsp; drivers/ne=
t/sxe2/sxe2_txrx_vec_avx512.c&nbsp;&nbsp;&nbsp; |&nbsp; 867 +++++++++</div=
>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_vec_common.h&nbsp;&nbsp;&nb=
sp; |&nbsp;&nbsp; 54 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx=
_vec_neon.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 689 +++++++</div>=0A<div=
>&gt;&nbsp; drivers/net/sxe2/sxe2_txrx_vec_sse.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp; 38 +-</div>=0A<div>&gt;&nbsp; drivers/net/sxe2/sx=
e2_vsi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 146 ++</div>=0A<div>&gt;&nbsp; drivers/ne=
t/sxe2/sxe2_vsi.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +-</div>=0A<div>&gt;&nb=
sp; drivers/net/sxe2/sxe2vf_regs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 85 +</div>=0A<div>&gt;&nbsp=
; 67 files changed, 24762 insertions(+), 273 deletions(-)</div>=0A<div>&gt=
;&nbsp; create mode 100644 drivers/common/sxe2/sxe2_flow_public.h</div>=0A=
<div>&gt;&nbsp; create mode 100644 drivers/common/sxe2/sxe2_msg.h</div>=0A=
<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_dump.c</div>=0A<d=
iv>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_dump.h</div>=0A<div=
>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c</div>=
=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h<=
/div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_filter.c<=
/div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_filter.h<=
/div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_flow.c</d=
iv>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_flow.h</div=
>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_flow_define.h=
</div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_flow_par=
se_action.c</div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sx=
e2_flow_parse_action.h</div>=0A<div>&gt;&nbsp; create mode 100644 drivers/=
net/sxe2/sxe2_flow_parse_engine.c</div>=0A<div>&gt;&nbsp; create mode 1006=
44 drivers/net/sxe2/sxe2_flow_parse_engine.h</div>=0A<div>&gt;&nbsp; creat=
e mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c</div>=0A<div>&gt;=
&nbsp; create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h</div>=
=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_ipsec.c</div>=
=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_ipsec.h</div>=
=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_irq.c</div>=0A=
<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_mac.c</div>=0A<di=
v>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_mac.h</div>=0A<div>&=
gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_mp.c</div>=0A<div>&gt;&=
nbsp; create mode 100644 drivers/net/sxe2/sxe2_mp.h</div>=0A<div>&gt;&nbsp=
; create mode 100644 drivers/net/sxe2/sxe2_rss.c</div>=0A<div>&gt;&nbsp; c=
reate mode 100644 drivers/net/sxe2/sxe2_rss.h</div>=0A<div>&gt;&nbsp; crea=
te mode 100644 drivers/net/sxe2/sxe2_security.c</div>=0A<div>&gt;&nbsp; cr=
eate mode 100644 drivers/net/sxe2/sxe2_security.h</div>=0A<div>&gt;&nbsp; =
create mode 100644 drivers/net/sxe2/sxe2_stats.c</div>=0A<div>&gt;&nbsp; c=
reate mode 100644 drivers/net/sxe2/sxe2_stats.h</div>=0A<div>&gt;&nbsp; cr=
eate mode 100644 drivers/net/sxe2/sxe2_switchdev.c</div>=0A<div>&gt;&nbsp;=
 create mode 100644 drivers/net/sxe2/sxe2_switchdev.h</div>=0A<div>&gt;&nb=
sp; create mode 100644 drivers/net/sxe2/sxe2_tm.c</div>=0A<div>&gt;&nbsp; =
create mode 100644 drivers/net/sxe2/sxe2_tm.h</div>=0A<div>&gt;&nbsp; crea=
te mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.c</div>=0A<div>&gt;&n=
bsp; create mode 100644 drivers/net/sxe2/sxe2_txrx_check_mbuf.h</div>=0A<d=
iv>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx2.c</di=
v>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_txrx_vec_avx=
512.c</div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/sxe2_txr=
x_vec_neon.c</div>=0A<div>&gt;&nbsp; create mode 100644 drivers/net/sxe2/s=
xe2vf_regs.h</div>=0A<div>&nbsp;</div>=0A<div>Overall this is close, I don=
't think the flow duplicate flag you</div>=0A<div>added matches mlx5 as cl=
ose as you think. Adding a new variant makes</div>=0A<div>sense, but try t=
o keep original values matching other driver.</div>=0A<div>My intent here =
is to have drivers diverge as little as possible;</div>=0A<div>it makes it=
 simpler for real world applications.</div>=0A<div>&nbsp;</div>=0A<div>The=
 AI chat review showed:</div>=0A<div>&nbsp;</div>=0A<div>[PATCH v8 00/23] =
sxe2 driver feature additions</div>=0A<div>&nbsp;</div>=0A<div>The v6 issu=
es are resolved cleanly, except the flow-duplicate-pattern</div>=0A<div>al=
ignment didn't go in the direction your "align with mlx5" guidance</div>=
=0A<div>intended.</div>=0A<div>&nbsp;</div>=0A<div>Resolved from v6:</div>=
=0A<div>&nbsp;</div>=0A<div>- The mbox is now in correct numeric order (06=
 before 07). git am</div>=0A<div>&nbsp; bundle.mbox applies cleanly. The v=
6 bundle-order break is gone.</div>=0A<div>&nbsp;</div>=0A<div>- All 23 co=
mmits build end-to-end at every commit. The dump-info patch</div>=0A<div>&=
nbsp; was moved from position 19 to 22 - it now runs after devargs parsing=
,</div>=0A<div>&nbsp; which makes its references to devargs fields consist=
ent. sxe2_dump_fc_state()</div>=0A<div>&nbsp; also correctly moved out of =
the devargs patch into the dump-info patch</div>=0A<div>&nbsp; where it be=
longs.</div>=0A<div>&nbsp;</div>=0A<div>- The v6 flow_dup_pattern_mode orp=
han situation is fixed. The field is</div>=0A<div>&nbsp; now actually writ=
ten by the new sxe2_parse_flow_dup_pattern_mode()</div>=0A<div>&nbsp; pars=
er, properly defaulted to SXE2_FLOW_SW_PATTERN_LAST in init, and</div>=0A<=
div>&nbsp; read at sxe2_flow.c:310 to populate switch_pattern_dup_allow in=
 flow</div>=0A<div>&nbsp; metadata. The struct field, its writer, its read=
er, and its hardware-</div>=0A<div>&nbsp; programming path are all consist=
ent now.</div>=0A<div>&nbsp;</div>=0A<div>- sxe2_parse_no_sched_mode was s=
implified to call the existing</div>=0A<div>&nbsp; sxe2_parse_bool helper =
instead of duplicating strtoul boilerplate. Nice</div>=0A<div>&nbsp; clean=
up.</div>=0A<div>&nbsp;</div>=0A<div>The flow-duplicate-pattern semantics:=
</div>=0A<div>&nbsp;</div>=0A<div>This is the v8 redesign in response to "=
align to mlx5". What it does:</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; doc/=
guides/nics/sxe2.rst, the option:</div>=0A<div>&nbsp;&nbsp;&nbsp; 0 =3D re=
ject duplicates with EEXIST</div>=0A<div>&nbsp;&nbsp;&nbsp; 1 =3D allow; l=
ast-added rule active (LIFO)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt=
;-- default</div>=0A<div>&nbsp;&nbsp;&nbsp; 2 =3D allow; first-added rule =
active (FIFO)</div>=0A<div>&nbsp;</div>=0A<div>mlx5's equivalent allow_dup=
licate_pattern is a {0,1} boolean. Its</div>=0A<div>value=3D1 means "all r=
ules are inserted but only the first rule takes</div>=0A<div>effect, the n=
ext rule takes effect only if the previous rules are</div>=0A<div>deleted.=
" That is FIFO. So:</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; mlx5 allow_dup=
licate_pattern=3D0&nbsp; =3D=3D&nbsp; sxe2 flow-duplicate-pattern=3D0</div=
>=0A<div>&nbsp; mlx5 allow_duplicate_pattern=3D1&nbsp; =3D=3D&nbsp; sxe2 f=
low-duplicate-pattern=3D2 (FIFO)</div>=0A<div>&nbsp; (no mlx5 equivalent)&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D&n=
bsp; sxe2 flow-duplicate-pattern=3D1 (LIFO)</div>=0A<div>&nbsp;</div>=0A<d=
iv>This is the worst possible alignment: sxe2 picked the same value range<=
/div>=0A<div>{0,1} mlx5 has, picked the same name root, picked similar doc=
umentation</div>=0A<div>wording, and made the same value 1 mean the opposi=
te hardware behaviour.</div>=0A<div>A user who runs the same `-a 0000:xx:x=
x.x,flow-duplicate-pattern=3D1` on</div>=0A<div>both PMDs gets FIFO on mlx=
5 and LIFO on sxe2 - inverted semantics under</div>=0A<div>identical names=
.</div>=0A<div>&nbsp;</div>=0A<div>If the hardware genuinely supports both=
 LIFO and FIFO and exposing both</div>=0A<div>is valuable, then naming and=
 defaults should not visually parallel mlx5.</div>=0A<div>Suggested resolu=
tions, in order of preference:</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; (a)=
 Drop LIFO. Document and implement only the two modes mlx5 has:</div>=0A<d=
iv>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =3D reject, 1 =3D FIFO (mlx5's value=
=3D1 semantic). Default 1. The</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 name allow_duplicate_pattern (mlx5's spelling) becomes valid -</div>=0A<d=
iv>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; same parameter, same values, same defaul=
ts across PMDs.</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; (b) Keep both mode=
s, but rename to make the meaning explicit and</div>=0A<div>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; non-overlapping with mlx5:</div>=0A<div>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; flow-duplicate-policy=3Dreject|fifo|lifo&nbsp; (=
string-valued)</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with reject as =
default. mlx5 keeps its short boolean; sxe2 has</div>=0A<div>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; its own tri-state with non-aliasing values. This is clea=
r but</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slightly more typing for=
 users.</div>=0A<div>&nbsp;</div>=0A<div>&nbsp; (c) Keep current name and =
values but make value=3D1 mean FIFO (matching</div>=0A<div>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mlx5) and value=3D2 mean LIFO. The name's spelling still d=
iffers</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from mlx5's, but at lea=
st the integer-to-semantic mapping matches.</div>=0A<div>&nbsp;</div>=0A<d=
iv>Personal preference is (a). The LIFO mode is unusual enough that I woul=
d</div>=0A<div>want to see a concrete use case before accepting it into a =
public</div>=0A<div>devarg. If the hardware queues rules in an order appli=
cations can</div>=0A<div>observe, that ordering is an rte_flow priority co=
ncern; the devarg layer</div>=0A<div>shouldn't be encoding it.</div>=0A<di=
v>&nbsp;</div>=0A<div>A separate small issue in the error-message ternary =
- sxe2_flow.c:809</div>=0A<div>prints "Duplicate flow pattern." when mode =
is non-zero and "Duplicate</div>=0A<div>flow pattern is not allowed." when=
 mode is zero. But the EEXIST error</div>=0A<div>path should only fire whe=
n the policy is to reject, which is exactly</div>=0A<div>mode 0. In modes =
1 and 2, the hardware accepts the duplicate as a</div>=0A<div>shadow/activ=
e rule; this error path should be unreachable. Either the</div>=0A<div>ter=
nary's first branch is dead code (in which case remove it and the</div>=0A=
<div>ternary; print only the rejection message), or the rejection can</div=
>=0A<div>happen in modes 1/2 too (in which case the message must explain w=
hy -</div>=0A<div>table full, action conflict, etc - and the current wordi=
ng is wrong</div>=0A<div>in both branches).</div>=0A<div>&nbsp;</div>=0A<d=
iv>Otherwise this revision is in good shape. Once flow-duplicate-pattern</=
div>=0A<div>alignment lands one way or another, ready to merge.</div>=0A</=
div></blockquote>=0A</body></html>
------=_001_NextPart765023518382_=------

