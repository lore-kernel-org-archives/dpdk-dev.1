Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55865CD4F25
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 09:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60BBB40276;
	Thu, 14 May 2026 11:38:04 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3A4E24025E
 for <dev@dpdk.org>; Thu, 14 May 2026 11:38:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gGQGg2CNgzJ4680
 for <dev@dpdk.org>; Thu, 14 May 2026 17:37:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F27A40577
 for <dev@dpdk.org>; Thu, 14 May 2026 17:38:01 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 May 2026 11:38:01 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 00/10] bpf: introduce extensible load API
Date: Thu, 14 May 2026 10:37:02 +0100
Message-ID: <20260514093713.90118-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
 frapema500003.china.huawei.com (7.182.19.114)
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

This patchset introduces an extensible load API for the BPF library in
DPDK, addressing current limitations regarding ABI stability and feature
constraints.

Currently, `rte_bpf_load` relies on a fixed `struct rte_bpf_prm`, which
makes it difficult to add new loading options or parameters without
breaking the ABI.

To resolve these issues, this series introduces `rte_bpf_load_ex` taking
`struct rte_bpf_prm_ex`. The new parameter structure includes a `sz`
field for backward compatibility, allowing future extensions.

Taking advantage of the new extensible API, this patchset also adds
several new features:
* Support for loading and executing BPF programs with up to 5 arguments.
* Support for loading classic BPF (cBPF) directly.
* Support for loading ELF files directly from memory buffers.
* New API functions (`rte_bpf_eth_rx_install` and `rte_bpf_eth_tx_install`)
  to install an already loaded BPF program as a port callback, decoupling
  the loading phase from the installation phase.

v2:
* Fixed a potential segmentation fault in `exec_vm_burst_ex` by deferring
  the dereference of `ctx[i].arg` until it is confirmed that `nb_prog_arg > 0`.
* Clarified documentation and code comments for `RTE_BPF_EXEC_FLAG_JIT`
  requirements and fast-path expectations.

Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

---
To the AI reviewer:
Thank you for the review. Several of your points were very helpful and
have been addressed in v2 (e.g. the potential null pointer dereference
in `exec_vm_burst_ex`, and documenting the `RTE_BPF_EXEC_FLAG_JIT`
expectations). The remaining points were investigated but do not require
code changes for the following reasons:

> Can the macro [RTE_BPF_LOG_FUNC_LINE] be enhanced for type safety?
> Does string literal concatenation support logging format modifiers
> consistently across all call sites?
`RTE_LOG_LINE` uses compiler attributes (`__attribute__((format(printf,
...)))`) to strictly enforce format type safety. Furthermore, standard C
preprocessors inherently support string literal concatenation prior to
format checking, ensuring it works safely across all macro invocations.

> Does `bpf_load()` always set `rte_errno` to `ENOMEM` when returning
> `NULL`, or could it mask other errors by hardcoding `-ENOMEM`?
By design, the internal `bpf_load()` function only returns `NULL` when
its internal memory allocation (`mmap`) fails. Returning `-ENOMEM`
perfectly accurately reflects the nature of this failure.

> Can the loop go out of bounds? When `opts_sz` is larger than
> `type_sz`, does this code read beyond the allocated memory region
> pointed to by `opts`?
The bounds are established by the application-supplied `opts_sz`.
Standard C semantics dictate that if a caller declares a size larger
than the actual allocated memory, it generates undefined behavior on
their end. `opts_valid` iterates exactly within the declared limits.

> Does the `memcpy()` handle the case where `app_prm->sz` is larger than
> `sizeof(load->prm)` correctly? Can partial copies lead to inconsistent
> state if the struct has pointer members?
The call to `opts_valid()` happens prior to `memcpy()` and guarantees
that any extra trailing space is definitively filled with zeroes. This
implies the application relies entirely on default functionality for the
newer unknown fields, making a truncated partial copy completely sound.

> Can `elf_end()` be called with `NULL` safely? Does it cause undefined
> behavior if `load->elf` is `NULL`?
`elf_end()` in `libelf` is explicitly defined to handle `NULL` pointers
as a safe no-op.

> Can this logic handle uninitialized or out-of-range `prog_arg->type`
> values? Does `RTE_BPF_ARG_PTR_MBUF` have a specific numeric value that
> should be validated before use?
The function utilizes strict positive equality checks against valid enum
values (`RTE_BPF_ARG_RAW`, `RTE_BPF_ARG_PTR`, `RTE_BPF_ARG_PTR_MBUF`).
Invalid or uninitialized types simply fall through and cleanly return
`false`.

> Does the `malloc` check for integer overflow in the size calculation
> `nb_ins * sizeof(load->ins[0])`?
`bpf_convert_filter()` acts as a strict gatekeeper and enforces an upper
bound limit (`BPF_MAXINSNS` = 4096) on instruction count. This extremely
small ceiling makes an arithmetic overflow in `malloc` mathematically
impossible.

> Does `bpf_eth_elf_install()` acquire any additional locks? Can this
> lead to a deadlock?
No secondary lock acquisitions exist inside `bpf_eth_elf_install()`. It
executes standard initialization logic and callback registrations
without touching threading constructs, ensuring a deadlock-free flow.

Marat Khalili (10):
  bpf: make logging prefixes more consistent
  bpf: introduce extensible load API
  bpf: support up to 5 arguments
  bpf: add cBPF origin to rte_bpf_load_ex
  bpf: support rte_bpf_prm_ex with port callbacks
  bpf: support loading ELF files from memory
  test/bpf: test loading cBPF directly
  test/bpf: test loading ELF file from memory
  doc: add release notes for new extensible BPF API
  doc: add load API to BPF programmer's guide

 app/test/test_bpf.c                    | 325 +++++++++++++++----------
 doc/guides/prog_guide/bpf_lib.rst      |  75 +++++-
 doc/guides/rel_notes/release_26_07.rst |  20 ++
 lib/bpf/bpf.c                          |  32 ++-
 lib/bpf/bpf_convert.c                  |  97 +++++++-
 lib/bpf/bpf_exec.c                     | 129 +++++++++-
 lib/bpf/bpf_impl.h                     |  53 +++-
 lib/bpf/bpf_jit_arm64.c                |  18 +-
 lib/bpf/bpf_jit_x86.c                  |  10 +-
 lib/bpf/bpf_load.c                     | 200 +++++++++++++--
 lib/bpf/bpf_load_elf.c                 | 189 +++++++++-----
 lib/bpf/bpf_pkt.c                      |  65 +++--
 lib/bpf/bpf_stub.c                     |  46 ----
 lib/bpf/bpf_validate.c                 |  94 ++++---
 lib/bpf/meson.build                    |  15 +-
 lib/bpf/rte_bpf.h                      | 199 ++++++++++++++-
 lib/bpf/rte_bpf_ethdev.h               |  54 ++++
 17 files changed, 1252 insertions(+), 369 deletions(-)
 delete mode 100644 lib/bpf/bpf_stub.c

-- 
2.43.0

