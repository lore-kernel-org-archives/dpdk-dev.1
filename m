Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8888CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 16:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E29840280;
	Mon, 10 Nov 2025 17:38:11 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B0B1B4026D
 for <dev@dpdk.org>; Mon, 10 Nov 2025 17:38:09 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4wLq20jszJ46BG;
 Tue, 11 Nov 2025 00:37:39 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id CAEE414022E;
 Tue, 11 Nov 2025 00:38:08 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 17:38:08 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 10 Nov 2025 17:38:08 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Thread-Topic: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Thread-Index: AQHcUbTTQ0Sz/b9pTEyJ8a2Nx5TSDrTsGpug
Date: Mon, 10 Nov 2025 16:38:08 +0000
Message-ID: <34f3ae46b0744bcea63bd4031cb8d4a5@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
 <20251109200854.45942-4-stephen@networkplumber.org>
In-Reply-To: <20251109200854.45942-4-stephen@networkplumber.org>
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

> diff --git a/app/test/bpf/load.c b/app/test/bpf/load.c
> new file mode 100644
> index 0000000000..a4d3d61d7a
> --- /dev/null
> +++ b/app/test/bpf/load.c
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + *
> + * BPF program for testing rte_bpf_elf_load
> + */
> +
> +typedef unsigned char uint8_t;
> +typedef unsigned short uint16_t;
> +typedef unsigned int uint32_t;
> +typedef unsigned long uint64_t;
> +
> +/* Match the structures from test_bpf.c */
> +struct dummy_offset {
> +	uint64_t u64;
> +	uint32_t u32;
> +	uint16_t u16;
> +	uint8_t  u8;
> +} __attribute__((packed));
> +
> +struct dummy_vect8 {
> +	struct dummy_offset in[8];
> +	struct dummy_offset out[8];
> +};
> +
> +/* External function declaration - provided by test via xsym */
> +extern void dummy_func1(const void *p, uint32_t *v32, uint64_t *v64);
> +
> +/*
> + * Test BPF function that will be loaded from ELF
> + * This function is compiled version of code used in test_call1
> + */

Thank you for this clarification, now it makes more sense why we use these =
structs.

// snip

> diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
> new file mode 100644
> index 0000000000..b4f54aa976
> --- /dev/null
> +++ b/app/test/bpf/meson.build
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright 2025 Stephen Hemminger <stephen@networkplumber.org>
> +
> +bpf_test_hdrs =3D [ ]
> +
> +# use clang to compile to bpf
> +clang_supports_bpf =3D false
> +clang =3D find_program('clang', required: false)
> +if clang.found()
> +    clang_supports_bpf =3D run_command(clang, '-target', 'bpf', '--print=
-supported-cpus',
> +                                     check: false).returncode() =3D=3D 0
> +endif
> +
> +if not clang_supports_bpf
> +    message('app/test_bpf: no BPF load tests missing clang BPF support')
> +    subdir_done()
> +
> +endif
> +
> +xxd =3D find_program('xxd', required: false)
> +if not xxd.found()
> +    message('app/test_bpf: missing xxd required to convert object to arr=
ay')
> +    subdir_done()
> +endif
> +
> +# BPF compiler flags
> +bpf_cflags =3D [ '-O2', '-target', 'bpf', '-g', '-c']
> +
> +# Enable test in test_bpf.c
> +cflags +=3D '-DTEST_BPF_ELF_LOAD'

Sorry for not noticing it earlier, we probably want these tests depend on=20
RTE_LIBRTE_BPF_ELF, otherwise they fail when libelf is not installed.

// snip

> +static int
> +test_bpf_elf_load(void)
> +{
> +	static const char test_section[] =3D "call1";
> +	uint8_t tbuf[sizeof(struct dummy_vect8)];

I still think alignment may become an issue here.

