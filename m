Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA658CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 10:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15F6943517;
	Fri, 12 Jun 2026 12:48:40 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 652CB43579
 for <dev@dpdk.org>; Fri, 12 Jun 2026 12:48:38 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gcGT964N5zHnGg3;
 Fri, 12 Jun 2026 18:48:29 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DB5F40569;
 Fri, 12 Jun 2026 18:48:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jun 2026 12:48:37 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 12 Jun 2026 12:48:37 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v4 02/11] bpf: introduce extensible load API
Thread-Topic: [PATCH v4 02/11] bpf: introduce extensible load API
Thread-Index: AQHc6Fc+klzS1Yq0NkK9U/ssCLSym7Y33b8AgALvRiA=
Date: Fri, 12 Jun 2026 10:48:37 +0000
Message-ID: <0610e3575ac44cf9b62e7f38a4b5c2ab@huawei.com>
References: <20260518084912.57006-1-marat.khalili@huawei.com>
 <20260520124922.42445-1-marat.khalili@huawei.com>
 <20260520124922.42445-3-marat.khalili@huawei.com>
 <n9qJkNlCQDazx_P9i-5XTQ@monjalon.net>
In-Reply-To: <n9qJkNlCQDazx_P9i-5XTQ@monjalon.net>
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

PiBVbmZvcnR1bmF0ZWx5LCBjb21waWxhdGlvbiBpcyBmYWlsaW5nIG9uIHRoaXMgcGF0Y2g6DQo+
IA0KPiBsaWIvYnBmL2JwZl9sb2FkLmM6Mjc0OjQwOiBlcnJvcjogJ3N0cnVjdCBydGVfYnBmX2pp
dCcgaGFzIG5vIG1lbWJlciBuYW1lZCAncmF3Jw0KDQpTZW50IHY1IGZpeGluZyB0aGUgaXNzdWUs
IGFwb2xvZ2llcyBmb3Igc2VuZGluZyB3aXRob3V0IGRvdWJsZS1jaGVja2luZyANCmNvbXBpbGFi
aWxpdHkgb2YgaW5kaXZpZHVhbCBjb21taXRzIG9uIG15IHNpZGUuDQo=
