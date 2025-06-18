Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E827CC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA124427C4;
	Wed, 18 Jun 2025 11:37:41 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id B9F2540EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:37:39 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55I9bXHv93934826,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1750239453;
 bh=UteE+B3ZV/OJC3GitaiDVfKogv9vZuoF/AQKxR4GBQU=;
 h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=MJvIT+pS1a+gzoMh37+ch6pe6YGTOjF4CO9cg1gcUDEM8R5m0FQhH6hJYv7Rk/vdj
 +n/xKV7aVjjNMMDKO83oL5medJacw9MV2ISRlrpTFBhu3B0VJNvxfoXKOcvHtxjtGQ
 3fkcILsiW2Bdp/g8MGeaVEdL37WYGCS5HIxo5gWKTv+ievC8YYGLrhhMJ4x+txWBkV
 E+frrl5NwPMzXjXpvE4Fes8dQViaPDXnLXG335/6bQharlNxrgVCfxsjTpepUrUdeM
 d3mRe7ufQCdX3pJPOXmDXAbWbF+xRJBbkcfq6AwlgvIdQo9AxhasOLIaCb4NDKPqYv
 hQHFrwVX3eBGA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55I9bXHv93934826
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Jun 2025 17:37:33 +0800
Received: from RS-EX-MBS4.realsil.com.cn (172.29.17.104) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Jun 2025 17:37:33 +0800
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) by
 RS-EX-MBS4.realsil.com.cn ([172.29.17.104]) with mapi id 15.02.1544.011; Wed,
 18 Jun 2025 17:37:33 +0800
From: =?utf-8?B?546L6aKi?= <howard_wang@realsil.com.cn>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Andre Muezerie <andremue@linux.microsoft.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjMgMi8zXSBkcml2ZXJzL25ldDogcmVtb3ZlIHVz?=
 =?utf-8?Q?e_of_non-standard_array_range_initialization?=
Thread-Topic: [PATCH v3 2/3] drivers/net: remove use of non-standard array
 range initialization
Thread-Index: AQHb3pGg7EZo7W5je0mVPSEZvbv2ELQIInuAgACJZ7A=
Date: Wed, 18 Jun 2025 09:37:33 +0000
Message-ID: <1d5377af85fe4025badbf8b717a8a877@realsil.com.cn>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-3-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8yxnGmBKJhTQp3js4QObjwaySHxTS9MekSmwgkVkY9xdg@mail.gmail.com>
 <5034944.6M6d0yLqnL@thomas>
In-Reply-To: <5034944.6M6d0yLqnL@thomas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
x-originating-ip: [172.29.17.210]
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

RGVhciBUaG9tYXMsDQoNCk9LLCBJIHdpbGwgdXBkYXRlIHRoaXMgcGFydCBpbiB0aGUgbmV4dCBj
b2RlIHJlZmFjdG9yaW5nLg0KDQpCeSB0aGUgd2F5LCBJIHdvdWxkIGxpa2UgdG8gYXNrIGhvdyB0
byByZXNvbHZlIHRoaXMgZXJyb3IuIEZyb20gd2hhdCBJIGNhbiBzZWUsIGl0IGRvZXMgbm90IHNl
ZW0gdG8gYmUgcmVsYXRlZCB0byB0aGUgcGF0Y2hlcyBJIHVwbG9hZGVkLg0KaHR0cHM6Ly9tYWls
cy5kcGRrLm9yZy9hcmNoaXZlcy90ZXN0LXJlcG9ydC8yMDI1LUp1bmUvODg2ODE1Lmh0bWwNCg0K
VGhhbmtzIQ0KSG93YXJkIFdhbmcNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6
OiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+IA0K5Y+R6YCB5pe26Ze0OiAy
MDI15bm0NuaciDE45pelIDE3OjI1DQrmlLbku7bkuro6IOeOi+mioiA8aG93YXJkX3dhbmdAcmVh
bHNpbC5jb20uY24+DQrmioTpgIE6IEFuZHJlIE11ZXplcmllIDxhbmRyZW11ZUBsaW51eC5taWNy
b3NvZnQuY29tPjsgZGV2QGRwZGsub3JnOyBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJk
c29uQGludGVsLmNvbT47IERhdmlkIE1hcmNoYW5kIDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29t
Pg0K5Li76aKYOiBSZTogW1BBVENIIHYzIDIvM10gZHJpdmVycy9uZXQ6IHJlbW92ZSB1c2Ugb2Yg
bm9uLXN0YW5kYXJkIGFycmF5IHJhbmdlIGluaXRpYWxpemF0aW9uDQoNCg0KRXh0ZXJuYWwgbWFp
bCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2FuaXphdGlvbi4g
RG8gbm90IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0K
DQoxNi8wNi8yMDI1IDA5OjM3LCBEYXZpZCBNYXJjaGFuZDoNCj4gT24gVGh1LCBKdW4gMTIsIDIw
MjUgYXQgNDoxOOKAr1BNIEFuZHJlIE11ZXplcmllIA0KPiA8YW5kcmVtdWVAbGludXgubWljcm9z
b2Z0LmNvbT4gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3I4MTY5L2Jhc2Uv
cnRsODEyNWFfbWN1LmMgDQo+ID4gYi9kcml2ZXJzL25ldC9yODE2OS9iYXNlL3J0bDgxMjVhX21j
dS5jDQo+ID4gaW5kZXggNWE2OWIzZTA5NC4uYzliZjVmYzZhZCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9yODE2OS9iYXNlL3J0bDgxMjVhX21jdS5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvcjgxNjkvYmFzZS9ydGw4MTI1YV9tY3UuYw0KPiA+IEBAIC0xNjIsNyArMTYyLDEzIEBAIHN0
YXRpYyB2b2lkDQo+ID4gIHJ0bF9yZWxlYXNlX3BoeV9tY3VfcGF0Y2hfa2V5X2xvY2soc3RydWN0
IHJ0bF9odyAqaHcpICB7DQo+ID4gICAgICAgICBzd2l0Y2ggKGh3LT5tY2ZnKSB7DQo+ID4gLSAg
ICAgICBjYXNlIENGR19NRVRIT0RfNDggLi4uIENGR19NRVRIT0RfNTM6DQo+ID4gKyAgICAgICAv
KiBDRkdfTUVUSE9EXzQ4IC4uLiBDRkdfTUVUSE9EXzUzICovDQo+ID4gKyAgICAgICBjYXNlIENG
R19NRVRIT0RfNDg6DQo+ID4gKyAgICAgICBjYXNlIENGR19NRVRIT0RfNDk6DQo+ID4gKyAgICAg
ICBjYXNlIENGR19NRVRIT0RfNTA6DQo+ID4gKyAgICAgICBjYXNlIENGR19NRVRIT0RfNTE6DQo+
ID4gKyAgICAgICBjYXNlIENGR19NRVRIT0RfNTI6DQo+ID4gKyAgICAgICBjYXNlIENGR19NRVRI
T0RfNTM6DQo+ID4gICAgICAgICAgICAgICAgIHJ0bF9tZGlvX2RpcmVjdF93cml0ZV9waHlfb2Nw
KGh3LCAweEE0MzYsIDB4MDAwMCk7DQo+ID4gICAgICAgICAgICAgICAgIHJ0bF9tZGlvX2RpcmVj
dF93cml0ZV9waHlfb2NwKGh3LCAweEE0MzgsIDB4MDAwMCk7DQo+ID4gICAgICAgICAgICAgICAg
IHJ0bF9jbGVhcl9ldGhfcGh5X29jcF9iaXQoaHcsIDB4QjgyRSwgQklUXzApOw0KPg0KPiBJIGRv
bid0IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBhZ2FpbnN0IHRoaXMgY2hhbmdlLg0KPiBUaGUgZHJp
dmVyIG1haW50YWluZXIgYWxyZWFkeSBhY2tlZCB0aGlzIGNoYW5nZS4NCj4NCj4gU28ganVzdCBz
b21lIGNvbW1lbnQsIG9uIHRoZSBmb3JtLg0KPiBzd2l0Y2goKSBoZXJlIGRvZXMgbm90IHNlZW0g
d2VsbCBzdWl0ZWQgc2luY2UgdGhpcyBkcml2ZXIgY29kZSBpcyANCj4gdmFsaWRhdGluZyBhIHJh
bmdlIG9mIHZhbHVlcy4NCj4gaWYgKGh3LT5tY2ZnID49IENGR19NRVRIT0RfNDggJiYgaHctPm1j
ZmcgPD0gQ0ZHX01FVEhPRF81Mykgc2VlbXMgbW9yZSANCj4gcm9idXN0IGFuZCBpcyBlYXNpZXIg
dG8gcmVhZC4NCg0KWWVzIEkgYWdyZWUgd2l0aCBEYXZpZC4NClBsZWFzZSBjb3VsZCB5b3UgZml4
IHRoaXMgY29kZSB0byBoYXZlIHNpbXBsZXIgY29kZSB3aXRoIHNvbWUgImlmIj8NCg0KDQo=
