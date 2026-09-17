Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86991C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36920427B2;
	Thu, 17 Sep 2026 18:16:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8838A42796
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:16:29 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tjmfW5PMRRea9SiXE4D3fXNxtHCqj9kkxJXn/sisejc=;
 b=OcUnDtHuHLUsgF6+md3HetcsS83fmju1M679eaqETzf0Q1/GXt4gAwK7ydhBf0ZFvQySVEdaG
 ndl5VVDlwT6igEUnRUV3PBwvjwVbrs44z/B+SFdRkGtqEfZMij7Ww4iVZ4OyPe5rUpwd7QjXRBA
 yI9ILCYD7jDKKPJHb0bKQ/A=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hm18V62z1zHnH3k;
 Fri, 18 Sep 2026 00:16:10 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (unknown [7.214.147.1])
 by mail.maildlp.com (Postfix) with ESMTPS id 9FC8F40570;
 Fri, 18 Sep 2026 00:16:27 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500004.china.huawei.com (7.214.147.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:16:18 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Thu, 17 Sep 2026 17:16:18 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <qm2k21@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v4 0/7] validate-bpf: add standalone validation debug tool
Thread-Topic: [PATCH v4 0/7] validate-bpf: add standalone validation debug tool
Thread-Index: AQHdRrHzyRWIdoP/DEmojSILhSwFG7bS8ijA
Date: Thu, 17 Sep 2026 16:16:18 +0000
Message-ID: <4f90b8f5788e40fe94ddda11e94a474f@huawei.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
In-Reply-To: <20260917143539.46951-1-qm2k21@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.76]
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



> This patchset introduces a new standalone tool for pre-validating eBPF
> programs and debugging validation problems. Its should allow developers
> to trace validator state changes per instruction and understand verifier
> decisions, simplifying the debugging of rejected programs before loading
> them into a real application context.
>=20
> v4:
> * addressed reviewer feedback from Konstantin Ananyev:
>   * changed variable and array names to lowercase to follow conventions;
>   * replaced strtoull()/strtoumax() with strtoul() and removed redundant
>     SIZE_MAX checks;
>   * changed return types of point_infos_destroy_* functions to void;
>   * replaced %jd and (intmax_t) cast with PRId32 when printing frame
>     offsets;
>   * refactored the inverted loop in print_frame() for clarity;
>   * replaced return -ENOMEM with RTE_VERIFY() for allocations in debug.c
>     print functions;
>   * simplified token matching logic in parse_decl.c by using strncmp().
>=20
> v3:
> * addressed another FreeBSD issue (spurious uninitialized warning);
> * addressed more AI comments:
>   * fail if library fails to set step catchpoint on start command;
>   * fail nicer if external variables are too big;
>   * fail nicer if EAL initialization or cleanup fails;
>   * explain why 9 steps are expeced in the test;
>   * explain that non-zero buf_size marks mbuf;
>   * avoid symbols starting with `RTE_` in the app;
>=20
> v2:
> * for FreeBSD compatibility switched from Linux to DPDK network structs;
> * addressed small AI comments:
>   * clarified patch 1 commit message;
>   * renamed `rte_validate_bpf_logtype` to `validate_bpf_logtype`;
>   * corrected comment to an internal-use-only function to reflect that
>     next-after-last value of the program counter is no longer allowed;
>=20
> Marat Khalili (7):
>   bpf/validate: fix finished status on restart
>   bpf/validate: refactor internal step function
>   bpf/validate: formalize call back requirements
>   bpf/validate: add jump notification events
>   bpf/validate: add get current event API
>   app/test: add test for bpf validate debug events
>   app/validate-bpf: add BPF validation application
>=20
>  MAINTAINERS                            |    2 +
>  app/meson.build                        |    1 +
>  app/test/test_bpf_validate.c           |  344 +++++++-
>  app/validate-bpf/alloc_list.c          |   53 ++
>  app/validate-bpf/args.c                |  262 ++++++
>  app/validate-bpf/debug.c               | 1087 ++++++++++++++++++++++++
>  app/validate-bpf/debug_command.c       |  383 +++++++++
>  app/validate-bpf/debug_command.h       |   65 ++
>  app/validate-bpf/eal_init_args.c       |   57 ++
>  app/validate-bpf/internal.h            |  151 ++++
>  app/validate-bpf/main.c                |   90 ++
>  app/validate-bpf/meson.build           |   13 +
>  app/validate-bpf/parse_decl.c          |  616 ++++++++++++++
>  doc/guides/rel_notes/release_26_11.rst |    5 +
>  doc/guides/tools/index.rst             |    1 +
>  doc/guides/tools/validate_bpf.rst      |   97 +++
>  lib/bpf/bpf_validate.c                 |   49 +-
>  lib/bpf/bpf_validate_debug.c           |   92 +-
>  lib/bpf/bpf_validate_debug.h           |   12 +-
>  lib/bpf/rte_bpf_validate_debug.h       |   42 +-
>  20 files changed, 3356 insertions(+), 66 deletions(-)
>  create mode 100644 app/validate-bpf/alloc_list.c
>  create mode 100644 app/validate-bpf/args.c
>  create mode 100644 app/validate-bpf/debug.c
>  create mode 100644 app/validate-bpf/debug_command.c
>  create mode 100644 app/validate-bpf/debug_command.h
>  create mode 100644 app/validate-bpf/eal_init_args.c
>  create mode 100644 app/validate-bpf/internal.h
>  create mode 100644 app/validate-bpf/main.c
>  create mode 100644 app/validate-bpf/meson.build
>  create mode 100644 app/validate-bpf/parse_decl.c
>  create mode 100644 doc/guides/tools/validate_bpf.rst
>=20
> --

Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0

