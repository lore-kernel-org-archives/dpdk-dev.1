Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79B1C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:33:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEA0D4021F;
	Thu, 22 Jan 2026 11:33:44 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8604940156;
 Thu, 22 Jan 2026 11:33:43 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxcpg3S0hzJ46d2;
 Thu, 22 Jan 2026 18:33:15 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 0C0DD40571;
 Thu, 22 Jan 2026 18:33:43 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 10:33:42 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 22 Jan 2026 10:33:42 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Marat Khalili
 <marat.khalili@huawei.com>
Subject: RE: [PATCH v3 07/14] test/bpf: fix unsupported BPF instructions in
 ELF load test
Thread-Topic: [PATCH v3 07/14] test/bpf: fix unsupported BPF instructions in
 ELF load test
Thread-Index: AQHcizmoXmOYHTR1nk6qIcPwL7J68rVd/pwg
Date: Thu, 22 Jan 2026 10:33:42 +0000
Message-ID: <f0de0c766bee441c8be0037a241c765b@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-8-stephen@networkplumber.org>
In-Reply-To: <20260122005356.1168221-8-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.244.196]
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


>=20
> The DPDK BPF library only handles the base BPF instructions.
> It does not handle JMP32 which would cause the bpf_elf_load
> test to fail on clang 20 or later.
>=20
> Bugzilla ID: 1844
> Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/bpf/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
> index aaecfa7018..91c1b434f8 100644
> --- a/app/test/bpf/meson.build
> +++ b/app/test/bpf/meson.build
> @@ -24,7 +24,8 @@ if not xxd.found()
>  endif
>=20
>  # BPF compiler flags
> -bpf_cflags =3D [ '-O2', '-target', 'bpf', '-g', '-c']
> +# At present: DPDK BPF does not support v3 or later
> +bpf_cflags =3D [ '-O2', '-target', 'bpf', '-mcpu=3Dv2', '-g', '-c']
>=20
>  # Enable test in test_bpf.c
>  cflags +=3D '-DTEST_BPF_ELF_LOAD'
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.51.0

