Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69AC44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3B14028B;
	Fri, 17 Jul 2026 10:34:08 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0A1474028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:34:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=t+tNIldYNmUYSfdKsPQy+1+C6JMW8Y0mKCxzf7leKxs=;
 b=buWjaVnxsOYYJ4XW5+RA04f0wQRJUknesE07ohVcFqbXt4oD/Du5LoDNYEGCSPvm8A/I9p5EJ
 0jgPrsFi+79/ndpkSo9w31qJ+BjliTqbINadSJjReyHxiMz6ZZgRWxqVfOTfk5S8PKqIwb67qu4
 xAcDbZ6QXimdo2z1LTQiU6U=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h1jqj33yLzJ467m;
 Fri, 17 Jul 2026 16:33:53 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id BCE414058D;
 Fri, 17 Jul 2026 16:34:06 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:34:06 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 17 Jul 2026 10:34:06 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 2/8] doc: document rte_os.h
Thread-Topic: [PATCH v3 2/8] doc: document rte_os.h
Thread-Index: AQHdDe3YxH2xugTHc0CW/vO4D6GtcrZxSwcAgAAmNxA=
Date: Fri, 17 Jul 2026 08:34:06 +0000
Message-ID: <d118b8d80ba64106ad538a5d214f1f34@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-3-marat.khalili@huawei.com>
 <4fzQ93JqRAO9h6zzYW03fg@monjalon.net>
In-Reply-To: <4fzQ93JqRAO9h6zzYW03fg@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGJlbmVmaXQgb2YgYWRkaW5nIGFuIGVtcHR5IGZpbGUu
DQo+IHJ0ZV9vcy5oIGZpbGVzIGFyZSBkZWZpbmluZyBzdGFuZGFyZCBmdW5jdGlvbnMgd2hpY2gg
ZG8gbm90IG5lZWQgZG9jdW1lbnRhdGlvbi4NCg0KSXQgd2FzIGVhc2llciB0byBhZGQgYSBzdHVi
IGZpbGUgZXhwbGFpbmluZyB0aGUgZmlsZSBwdXJwb3NlIHRoYW4gdG8gYWRkIGFuIGV4Y2VwdGlv
biBqdXN0IGZvciBpdCwgYnV0IHN1cmUgd2UgY2FuIGV4Y2x1ZGUgaXQgZXhwbGljaXRseS4NCg==
