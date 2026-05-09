Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91BCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 12:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3246740269;
	Sat,  9 May 2026 14:36:24 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id ACB1840268
 for <dev@dpdk.org>; Sat,  9 May 2026 14:36:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gCQSt2XmhzJ467l
 for <dev@dpdk.org>; Sat,  9 May 2026 20:35:58 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 5EEA340575
 for <dev@dpdk.org>; Sat,  9 May 2026 20:36:20 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 13:36:19 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sat, 9 May 2026 13:36:19 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/10] bpf: introduce extensible load API
Thread-Topic: [PATCH 00/10] bpf: introduce extensible load API
Thread-Index: AQHc3X0OFikWHXOPyUOyj3nwhTtQ9LYFpA+w
Date: Sat, 9 May 2026 12:36:19 +0000
Message-ID: <72a072e1281c4037bbccbff91ec84d2b@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.154.35]
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



> This patchset introduces an extensible load API for the BPF library in
> DPDK, addressing current limitations regarding ABI stability and feature
> constraints.
>=20
> Currently, `rte_bpf_load` relies on a fixed `struct rte_bpf_prm`, which
> makes it difficult to add new loading options or parameters without
> breaking the ABI.
>=20
> To resolve these issues, this series introduces `rte_bpf_load_ex` taking
> `struct rte_bpf_prm_ex`. The new parameter structure includes a `sz`
> field for backward compatibility, allowing future extensions.
>=20
> Taking advantage of the new extensible API, this patchset also adds
> several new features:
> * Support for loading and executing BPF programs with up to 5 arguments.
> * Support for loading classic BPF (cBPF) directly.
> * Support for loading ELF files directly from memory buffers.
> * New API functions (`rte_bpf_eth_rx_install` and `rte_bpf_eth_tx_install=
`)
>   to install an already loaded BPF program as a port callback, decoupling
>   the loading phase from the installation phase.
>=20
> Marat Khalili (10):
>   bpf: make logging prefixes more consistent
>   bpf: introduce extensible load API
>   bpf: support up to 5 arguments
>   bpf: add cBPF origin to rte_bpf_load_ex
>   bpf: support rte_bpf_prm_ex with port callbacks
>   bpf: support loading ELF files from memory
>   test/bpf: test loading cBPF directly
>   test/bpf: test loading ELF file from memory
>   doc: add release notes for new extensible BPF API
>   doc: add load API to BPF programmer's guide
>=20
>  app/test/test_bpf.c                    | 325 +++++++++++++++----------
>  doc/guides/prog_guide/bpf_lib.rst      |  75 +++++-
>  doc/guides/rel_notes/release_26_07.rst |  20 ++
>  lib/bpf/bpf.c                          |  32 ++-
>  lib/bpf/bpf_convert.c                  |  97 +++++++-
>  lib/bpf/bpf_exec.c                     | 126 +++++++++-
>  lib/bpf/bpf_impl.h                     |  53 +++-
>  lib/bpf/bpf_jit_arm64.c                |  18 +-
>  lib/bpf/bpf_jit_x86.c                  |  10 +-
>  lib/bpf/bpf_load.c                     | 200 +++++++++++++--
>  lib/bpf/bpf_load_elf.c                 | 189 +++++++++-----
>  lib/bpf/bpf_pkt.c                      |  65 +++--
>  lib/bpf/bpf_stub.c                     |  46 ----
>  lib/bpf/bpf_validate.c                 |  94 ++++---
>  lib/bpf/meson.build                    |  15 +-
>  lib/bpf/rte_bpf.h                      | 195 ++++++++++++++-
>  lib/bpf/rte_bpf_ethdev.h               |  54 ++++
>  17 files changed, 1245 insertions(+), 369 deletions(-)
>  delete mode 100644 lib/bpf/bpf_stub.c
> --

I already reviewed these changes offline, as part of our
internal patch acceptance process.=20
Current version LGMT and addresses all comments I had.=20

Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0

