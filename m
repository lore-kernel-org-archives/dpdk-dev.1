Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D285C43602
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 439CD402DF;
	Fri,  3 Jul 2026 10:48:40 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 44B91402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 10:48:37 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gs6p813CMzHnGhr;
 Fri,  3 Jul 2026 16:47:44 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 0B06F40575;
 Fri,  3 Jul 2026 16:48:34 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Jul 2026 10:48:33 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 3 Jul 2026 10:48:33 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH] test/bpf: remove validation tests from CI
Thread-Topic: [PATCH] test/bpf: remove validation tests from CI
Thread-Index: AQHdCpOjP+hLcrkGmEaD3wdn4zMoLLZbee4A
Date: Fri, 3 Jul 2026 08:48:33 +0000
Message-ID: <2751fd1fa6d648a9b7f95797f13ef28b@huawei.com>
References: <20260703022738.2574548-1-thomas@monjalon.net>
In-Reply-To: <20260703022738.2574548-1-thomas@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

> The new tests for BPF validation are triggering a strange issue
> in GitHub Action: the last tests are killed by signal 7 SIGBUS.
>=20
> The series fixing a lot of BPF issues was merged
> but the related test has to be removed from the fast tests suite
> which runs in some CI jobs.
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

I think I know the issue, it's tmpfs exhaustion. After some recent changes =
each
test consumes 25MB in the --file-prefix directory independently, easily dri=
ving
small VMs out of space. My ~30 new tests were the last drop for the CI.

I will try to prepare a fix today, of course please do everything that's
needed for the CI stability meanwhile.
