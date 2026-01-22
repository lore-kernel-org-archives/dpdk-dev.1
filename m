Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D250C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 929274013F;
	Thu, 22 Jan 2026 08:28:59 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 662EB400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:28:58 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dxXjy2hnPzrWlM;
 Thu, 22 Jan 2026 15:28:54 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dxXjv651dzrWlM;
 Thu, 22 Jan 2026 15:28:51 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 6F18C1655;
 Thu, 22 Jan 2026 15:28:45 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 22 Jan
 2026 15:28:52 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Thu, 22 Jan 2026 15:28:52 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "P, Thiyagarajan"
 <Thiyagarajan.P@amd.com>, "Murali Krishna, Bala" <Bala.MuraliKrishna@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Topic: [PATCH v6] eal/x86: optimize memcpy of small sizes
Thread-Index: AQHcg7uGUjc6AXmKc0GK4d70t8GeYrVQOJ+AgAox3gCAAAU3AIAAAOmAgAGZnACAAUGUgIAAjA2w
Date: Thu, 22 Jan 2026 07:28:52 +0000
Message-ID: <9ac18b2e8f684bb5a9fa91815bf46a49@hygon.cn>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
 <20260113151943.31c58217@phoenix.local>
 <PH7PR12MB8596A21E5892BABF88665C5B8289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB8596F1FE29BA757F8884E7A98289A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65677@smartserver.smartshare.dk>
 <PH7PR12MB8596838852258FB94342042A8296A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB85961D3A7388DF0C0445915A8297A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB85961D3A7388DF0C0445915A8297A@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.19.25.208]
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

SGkgQCBWYXJnaGVzZSwgVmlwaW4sDQoNCkkgYW0gaW50ZXJlc3RlZCBpbiB0aGlzIHJ0ZV9tZW1j
cHkgcGF0Y2ggcGVyZm9ybWFuY2Ugb24gb3VyIHg4NiBwbGF0Zm9ybSB0b28uIE1heSB5b3UgcGxl
YXNlIHNoYXJlIHRoZSBjb25maWd1cmF0aW9uIGZpbGUgYW5kIHN0ZXBzIGZvciB5b3VyIGRtYS1w
ZXJmIHRlc3QgdGhlbiBJIGNhbiBydW4gdGhlIHNhbWUgb24gb3VyIHBsYXRmb3JtPyBUaGFua3Mu
DQoNClJlZ2FyZHMsDQpMaWFuZ3hpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogVmFyZ2hlc2UsIFZpcGluIDxWaXBpbi5WYXJnaGVzZUBhbWQuY29tPg0KPiBTZW50OiAy
MDI25bm0MeaciDIy5pelIDE1OjAwDQo+IFRvOiBWYXJnaGVzZSwgVmlwaW4gPFZpcGluLlZhcmdo
ZXNlQGFtZC5jb20+OyBNb3J0ZW4gQnLDuHJ1cA0KPiA8bWJAc21hcnRzaGFyZXN5c3RlbXMuY29t
PjsgU3RlcGhlbiBIZW1taW5nZXINCj4gPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPjsgUCwg
VGhpeWFnYXJhamFuIDxUaGl5YWdhcmFqYW4uUEBhbWQuY29tPjsNCj4gTXVyYWxpIEtyaXNobmEs
IEJhbGEgPEJhbGEuTXVyYWxpS3Jpc2huYUBhbWQuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBC
cnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47DQo+IEtvbnN0YW50
aW4gQW5hbnlldiA8a29uc3RhbnRpbi52LmFuYW55ZXZAeWFuZGV4LnJ1Pg0KPiBTdWJqZWN0OiBS
RTogW1BBVENIIHY2XSBlYWwveDg2OiBvcHRpbWl6ZSBtZW1jcHkgb2Ygc21hbGwgc2l6ZXMNCj4g
DQo+IFtQdWJsaWNdDQo+IA0KPiBIaSBATW9ydGVuIEJyw7hydXAsDQo+IA0KPiBXZSAoQFAsIFRo
aXlhZ2FyYWphbiBATXVyYWxpIEtyaXNobmEsIEJhbGEgYW5kIG15c2VsZikgaGF2ZSB1c2VkIGRt
YS1wZXJmDQo+IHRvIHZhbGlkYXRlIHRoZSBwZXJmb3JtYW5jZSBmcm9tIDFCIHRvIDE3QiBwYXls
b2FkLg0KPiBGb2xsb3dpbmcgYXJlIG91ciBvYnNlcnZhdGlvbnMNCj4gDQo+IFdpdGggY19hcmdz
IGAtRFJURV9NRU1DUFlfQVZYNTEyYCBlbmFibGVkIG9uIHplbjQsIHdlIG9ic2VydmUgYXJvdW5k
DQo+IDI1JSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZvciBwYXlsb2FkIHNpemUgMUIgdG8gMTVC
IGFuZCAxN0IuDQo+IFdoaWxlIGluIGNhc2Ugb2YgMTZCIHdlIHNlZSBpbXByb3ZlbWVudCBpbiBN
b3BzIGJ5IDQwJS4NCj4gDQo+IFdpdGhvdXQgY19hcmdzIGAtRFJURV9NRU1DUFlfQVZYNTEyYCBl
bmFibGVkIG9uIHplbjQsIHdlIG9ic2VydmUgKy00JQ0KPiB2YXJpYXRpb24gZnJvbSAxQiB0byAx
N0IuDQo+IA0KPiBgV2UgYXJlIGludmVzdGlnYXRpbmcgdGhlIHZhcmlhdGlvbiBpcyBtb3JlIHBy
b21pbmVudCB3aXRoIGF2eDUxMiBtZW1jcHkuYA0KPiANCj4gTm90ZToNCj4gMS4gaW4gemVuNCBs
ZHxzdHIgaXMgYnJva2VuIHRvIDMyQi4gV2hpbGUgaW4gemVuNSBsZHxzdHIgaXMgNjRCLg0KPiAy
LiB3ZSB0ZXN0ZWQgbWVtaWYgY29weSBvbiB6ZW41IHdpdGggcGF0Y2ggKHdpdGhvdXQgLURSVEVf
TUVNQ1BZX0FWWDUxMikNCj4gb24gNjRCIGFuZCA2NUIgcGF5bG9hZC4gSXQgaXMgc2FtZSBhcyB6
ZW40IG9ic2VydmF0aW9uIChzaGFyZWQgaW4gcHJldmlvdXMNCj4gZW1haWwpLg0KPiANCj4gDQo+
IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVmFyZ2hlc2UsIFZp
cGluIDxWaXBpbi5WYXJnaGVzZUBhbWQuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSAyMSwgMjAyNiA1OjE5IFBNDQo+ID4gVG86IE1vcnRlbiBCcsO4cnVwIDxtYkBzbWFydHNoYXJl
c3lzdGVtcy5jb20+OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA+IDxzdGVwaGVuQG5ldHdvcmtwbHVt
YmVyLm9yZz4NCj4gPiBDYzogZGV2QGRwZGsub3JnOyBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5y
aWNoYXJkc29uQGludGVsLmNvbT47DQo+ID4gS29uc3RhbnRpbiBBbmFueWV2IDxrb25zdGFudGlu
LnYuYW5hbnlldkB5YW5kZXgucnU+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2Nl0gZWFsL3g4
Njogb3B0aW1pemUgbWVtY3B5IG9mIHNtYWxsIHNpemVzDQo+ID4NCj4gPiBDYXV0aW9uOiBUaGlz
IG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0K
PiA+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4gPg0KPiA+DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IEhpIEBNb3J0ZW4g
QnLDuHJ1cCwgcGxlYXNlIGZpbmQgb3VyIG9ic2VydmF0aW9uIHJ1bm5pbmcgdGVzdHBtZCB3aXRo
DQo+ID4gbWVtaWYgaW4gemVyby1jb3B5IG1vZGUgZGlzYWJsZWQgKHJ0ZV9tZW1jcHkgZW5hYmxl
ZCkuDQo+ID4NCj4gPiAxLiBEUERLIGJhc2VsaW5lIHZlcnNpb246IDI1LjExIHdlIHRlc3RlZCB3
aXRoIHRlc3RwbWQgaW4gaW8gJiBmbG93Z2VuDQo+IG1vZGUgMi4NCj4gPiB1c2luZyBubyBjYXJn
cyBmb3IgbWVtY3B5IChydGVtb3YzMikgYW5kIHdpdGggcGF0Y2ggNjRCICYgNjVCIHdlIGdldA0K
PiA+IGAxNS41TXBwc2AgMy4gdXNpbmcgY2FyZ3MgYCAtRFJURV9NRU1DUFlfQVZYNTEyYCBmb3Ig
bWVtY3B5DQo+IChydGVtb3Y2NCkNCj4gPiBhbmQgd2l0aCBwYXRjaCA2NEIgJiA2NUIgd2UgZ2V0
IGAxNC44TXBwc2ANCj4gPg0KPiA+IFdlIHdpbGwgcnVuIHdpdGggZG1hLXBlcmYgYXBwbGljYXRp
b24gZm9yIHBheWxvYWQgc2l6ZXMgb2YNCj4gPiAxLDIsMyw0LDUsLi4uZXRjDQo+ID4NCj4gPiBS
ZWdhcmRzDQo+ID4gVmlwaW4gVmFyZ2hlc2UNCg==

