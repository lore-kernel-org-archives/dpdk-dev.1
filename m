Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA78D11719
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 16:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EF6140268;
	Tue,  2 Dec 2025 17:53:07 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F1311400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 17:53:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLRfK72zWzJ46F7;
 Wed,  3 Dec 2025 00:52:57 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 37E5640569;
 Wed,  3 Dec 2025 00:53:03 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 17:53:03 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 2 Dec 2025 17:53:03 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 2/2] app/test: make parameters clearer when adding fast
 tests
Thread-Topic: [PATCH 2/2] app/test: make parameters clearer when adding fast
 tests
Thread-Index: AQHcY6OMMyM4Wg+91U6YgizKWdB9O7UOjCog
Date: Tue, 2 Dec 2025 16:53:02 +0000
Message-ID: <58ce8da5c4094fb4b292fd58d068fc5f@huawei.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251202154948.1757169-3-bruce.richardson@intel.com>
In-Reply-To: <20251202154948.1757169-3-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday 2 December 2025 15:50
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH 2/2] app/test: make parameters clearer when adding fast t=
ests
>=20
> For the fast tests, we have two extra parameters specifying when the
> test can be run without hugepages or using ASan. The true/false nature
> of these parameters is not very clear, so change things so that they are
> explicitly specified as NOHUGE/HUGEPAGES and NOASAN/ASAN instead.
> Explicitly validate the options in the meson.build files, rather than
> just checking for one of the pair of options - which can hide errors.

I like the idea. However, I think that NOASAN/ASAN is still not fully self-=
documenting, and may be misleading. Without reading some docs I'd think NOA=
SAN means test will be run without sanitizer and ASAN means it will be run =
with. As a minimal fix, what about NOHUGE_OK/NOHUGE_SKIP and ASAN_OK/ASAN_S=
KIP?

More intrusive option, to simplify most normal uses and highlight exception=
s:
* 0 (or DEFAULT, or RUN_ALWAYS)
* SKIP_IF_ASAN
* SKIP_IF_NOHUGE
* SKIP_IF_ASAN | SKIP_IF_NOHUGE
