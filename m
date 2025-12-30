Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94588EE0205
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 15:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26BE940267;
	Tue, 30 Dec 2025 16:22:31 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2952C4025A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 16:22:29 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dgcJ219kPzHnGkW;
 Tue, 30 Dec 2025 23:21:38 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 26A3E40569;
 Tue, 30 Dec 2025 23:22:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 30 Dec 2025 15:22:28 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 30 Dec 2025 15:22:28 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>, "dev@dpdk.org" <dev@dpdk.org>
CC: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?iso-8859-2?Q?Stanis=B3aw_Kardach?= <stanislaw.kardach@gmail.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH v2] acl: add RISC-V vector extension implementation
Thread-Topic: [PATCH v2] acl: add RISC-V vector extension implementation
Thread-Index: AQHceIao/EyjVvCjZ0CmVfSeHVv8ubU6TdWw
Date: Tue, 30 Dec 2025 15:22:28 +0000
Message-ID: <16712ed73b254bff9795e71a727ff99a@huawei.com>
References: <20251229054559.2923969-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20251229054559.2923969-1-sunyuechi@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.152.185]
Content-Type: text/plain; charset="iso-8859-2"
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



> Implement ACL classify function for RISC-V architecture
> using RISC-V Vector Extension instruction set.
>=20
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> ---
>  app/test-acl/main.c              |   4 +
>  app/test/test_acl.c              |   1 +
>  config/riscv/meson.build         |   1 +
>  examples/l3fwd/l3fwd_acl.c       |   4 +
>  lib/acl/acl.h                    |   4 +
>  lib/acl/acl_run.h                |   2 +
>  lib/acl/acl_run_rvv.c            |  18 ++
>  lib/acl/acl_run_rvv.h            | 326 +++++++++++++++++++++++++++++++
>  lib/acl/meson.build              |   2 +
>  lib/acl/rte_acl.c                |  34 ++++
>  lib/acl/rte_acl.h                |   1 +
>  lib/eal/riscv/include/rte_vect.h |   2 +-
>  12 files changed, 398 insertions(+), 1 deletion(-)
>  create mode 100644 lib/acl/acl_run_rvv.c
>  create mode 100644 lib/acl/acl_run_rvv.h
>=20

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

One more thing, that I nearly fogot:
As it is a new feature, it is probably worth to add a new entry into Releas=
e Notes.
If you'll decide to go ahead with that - pls keep my Ack.
Konstantin

> --
> 2.52.0
>=20

