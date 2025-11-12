Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A7CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DFEC40A6E;
	Wed, 12 Nov 2025 16:03:40 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6FD06409FA
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:03:39 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d668p21v9zJ467H;
 Wed, 12 Nov 2025 23:03:06 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id EDED1140371;
 Wed, 12 Nov 2025 23:03:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Nov 2025 16:03:38 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 12 Nov 2025 16:03:38 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v6 0/2] BPF tests
Thread-Topic: [PATCH v6 0/2] BPF tests
Thread-Index: AQHcU16X8sjFU1rxUEK8wro4vgi1nbTvImsg
Date: Wed, 12 Nov 2025 15:03:38 +0000
Message-ID: <cdaef00a411443cc86b54e464c49e7e1@huawei.com>
References: <20251109200854.45942-1-stephen@networkplumber.org>
 <20251111225719.540140-1-stephen@networkplumber.org>
In-Reply-To: <20251111225719.540140-1-stephen@networkplumber.org>
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

With this version the new test succeeds or gets correctly skipped for me
for all combinations of installed packages.

Series-tested-by: Marat Khalili <marat.khalili@huawei.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday 11 November 2025 22:56
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v6 0/2] BPF tests
>=20
> Add missing tests for BPF file loading functions.
> This is subset of earlier patch.
>=20
> v6 - rebase to main
>    - make sure that -ENOTSUP is handled
>    - remove duplicate includes
>    - combine all of the elf tests into one test instance
>=20
> Stephen Hemminger (2):
>   bpf: add a test for BPF ELF load
>   bpf: add test for Rx and Tx filtering
>=20
>  app/test/bpf/filter.c    |  53 +++++
>  app/test/bpf/load.c      |  51 +++++
>  app/test/bpf/meson.build |  53 +++++
>  app/test/meson.build     |   2 +
>  app/test/test_bpf.c      | 476 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 635 insertions(+)
>  create mode 100644 app/test/bpf/filter.c
>  create mode 100644 app/test/bpf/load.c
>  create mode 100644 app/test/bpf/meson.build
>=20
> --
> 2.51.0

