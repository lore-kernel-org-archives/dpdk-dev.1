Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB905D167F5
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 09:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E57402A7;
	Fri,  9 Jan 2026 10:58:40 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B39F1400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 10:58:39 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dncfX4lDTzHnHKK;
 Fri,  9 Jan 2026 17:58:28 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A3BE40584;
 Fri,  9 Jan 2026 17:58:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 Jan 2026 10:58:38 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 9 Jan 2026 10:58:38 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC] doc: add AGENTS.md for AI-powered code review tools
Thread-Topic: [RFC] doc: add AGENTS.md for AI-powered code review tools
Thread-Index: AQHcgQkeGvbwx0poX02bYnNMj62+z7VJlVKw
Date: Fri, 9 Jan 2026 09:58:38 +0000
Message-ID: <bc4a13bebde740adb57e80c5156f3cde@huawei.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
In-Reply-To: <20260109014106.398156-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

SW4gbXkgdmVyeSBsaW1pdGVkIGV4cGVyaWVuY2UgaXQgaGVscHMgdG8gdGVsbCB0aGUgbW9kZWwg
dGhhdCBhbGwgY29tbWl0cyAoYm90aCANCnBhdGNoIGFuZCBjb21taXQgbWVzc2FnZSkgTVVTVCBw
YXNzIGRldnRvb2xzL2NoZWNrcGF0Y2hlcy5zaCwgaWRlYWxseSANCmNvbmZpZ3VyZWQgKGFuZCB2
ZXJpZmllZCkgYXMgYSBnaXQgaG9vaywgY2xlYXIganVzdGlmaWNhdGlvbiBtdXN0IGJlIA0KcHJv
dmlkZWQgaW4gcmFyZSBleGNlcHRpb24gY2FzZXMuDQoNCkZyb20gdGhlIGdlbmVyYWwgcHJvZ3Jh
bW1pbmcgcHJpbmNpcGxlcyBJJ20gdW5zdXJlIGFib3V0IGR1cGxpY2F0aW5nIA0KaW5mb3JtYXRp
b24gYWxyZWFkeSBhdmFpbGFibGUgaW4gZG9jL2d1aWRlcy9jb250cmlidXRpbmcgaW4gdGhlIHNh
bWUgdHJlZS4gDQpQZXJoYXBzIHdlIGNvdWxkIGp1c3QgaW5zdHJ1Y3QgdGhlIG1vZGVsIHRvIHJl
YWQgcGF0Y2hlcy5yc3QgYW5kIA0KY29kaW5nX3N0eWxlLnJzdCwgdGhleSBhcmUgbm90IHZlcnkg
YmlnIChhbmQgbW9kZWxzIHR5cGljYWxseSBrbm93IExpbnV4IGFuZCANClBJUDggcnVsZXMgYWxy
ZWFkeSkuIE90aGVyd2lzZSB3ZSByaXNrIG9uZSBvZiB0aGUgZG9jdW1lbnRzIGJlY29taW5nIG91
dGRhdGVkLCANCm9yIHJ1bGVzL251YW5jZXMgb21pdHRlZCBpbiB0aGUgc3VtbWFyaXplZCB2ZXJz
aW9uIGlnbm9yZWQuIEluIGluc3RydWN0aW9ucyANCnNwZWNpZmljYWxseSBmb3IgdGhlIG1vZGVs
IHdlIGNvdWxkIGZvY3VzIG9uIHRoaW5ncyB0aGF0IGFyZSBwZXJzaXN0ZW50IHNvdXJjZSANCm9m
IHByb2JsZW1zIGZvciBpdCBkZXNwaXRlIGluc3RydWN0aW9ucyBmb3IgaHVtYW5zIGJlaW5nIGNs
ZWFyLg0KDQpKdXN0IG15IDJjLCBncmVhdCB0aGF0IHNvbWVvbmUgaXMgd29ya2luZyBvbiB0aGlz
Lg0K
