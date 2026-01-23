Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BDD72372
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 10:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817E74026F;
	Fri, 23 Jan 2026 11:44:23 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DB4AE40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 11:44:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyF0G4vNYzHnGfT;
 Fri, 23 Jan 2026 18:43:42 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 373864056A;
 Fri, 23 Jan 2026 18:44:20 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 23 Jan 2026 11:44:20 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 23 Jan 2026 11:44:19 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [RFC] test: split up BPF tests
Thread-Topic: [RFC] test: split up BPF tests
Thread-Index: AQHci9bp9kmav7vUUUK9uo9eJzqFlrVfj5Ww
Date: Fri, 23 Jan 2026 10:44:19 +0000
Message-ID: <7207dfbe4aa74311aee79389af885703@huawei.com>
References: <20260122193923.49253-1-stephen@networkplumber.org>
In-Reply-To: <20260122193923.49253-1-stephen@networkplumber.org>
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

> The BPF tests have two sections. One is doing tests of the
> BPF interpreter and the other is for testing the ELF load part.
> The latter requires the null PMD to work, so only build it
> present.

Splitting BPF tests into multiple files makes sense, and not just because o=
f
dependencies.

Coupling ELF tests with the presence of null PMD is strange, there might be=
 a
lot of BPF ELF tests that do not depend on null or any PMD, and there might=
 be
other BPF tests depending on PMD. Maybe we should call the new file
test_bpf_ethdev.c instead (following the header name rte_bpf_ethdev.h ,
regardless of what one thinks of the name), or something like this.
