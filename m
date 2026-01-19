Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC482CCF2EF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 11:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05836402E6;
	Mon, 19 Jan 2026 12:43:34 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 965014025A;
 Mon, 19 Jan 2026 12:43:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvpVj4F7bzJ46mQ;
 Mon, 19 Jan 2026 19:43:09 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 5E16D4056B;
 Mon, 19 Jan 2026 19:43:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 12:43:32 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 12:43:32 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 4/6] test: fix unsupported BPF instructions in elf load
 test
Thread-Topic: [PATCH 4/6] test: fix unsupported BPF instructions in elf load
 test
Thread-Index: AQHciLbQVoxJ6ukvGUicIe9Aw7CGGLVZX/qA
Date: Mon, 19 Jan 2026 11:43:31 +0000
Message-ID: <ab9dad7c5cb44b6b9258e4cae99dae93@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-5-stephen@networkplumber.org>
In-Reply-To: <20260118201223.323024-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday 18 January 2026 20:09
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Kons=
tantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH 4/6] test: fix unsupported BPF instructions in elf load t=
est
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
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
