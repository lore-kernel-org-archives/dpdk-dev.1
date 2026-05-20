Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D525BCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE8A4029D;
	Wed, 20 May 2026 14:49:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id BD09940144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:49:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gLBDw1LNBzJ46Bp
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:04 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5F9D940584
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:44 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:49:44 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>
Subject: [PATCH v4 00/11] bpf: introduce extensible load API
Date: Wed, 20 May 2026 13:49:09 +0100
Message-ID: <20260520124922.42445-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518084912.57006-1-marat.khalili@huawei.com>
References: <20260518084912.57006-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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


v4:
* Restored missing NULL checks in wrapper functions `rte_bpf_load` and
  `rte_bpf_elf_load`.
* Fixed the burst execution functions (`rte_bpf_exec_burst*`) to return
  `0` and set `rte_errno = EINVAL` on failure, preventing `-EINVAL`
  being reinterpreted as a large `uint32_t` value. Initialized `rc`
  properly in scalar execution wrappers for this case.
* Swapped the Doxygen comments in `rte_bpf_ethdev.h` for RX and TX functions.
* Added diagnostic dump on failure path in `test_bpf_filter`.
* Fixed memory leak of the BPF handle in `bpf_rx_test` upon install failure.
* Added tests for NULL parameter rejection, mismatched execution arguments,
  unsupported execution flags, and the libpcap-less `rte_bpf_convert` stub.

v3:
* Appended Acked-by tags to all individual commits to align with
  patchwork requirements.

v2:
* Fixed a potential segmentation fault in `exec_vm_burst_ex` by deferring
  the dereference of `ctx[i].arg` until it is confirmed that `nb_prog_arg > 0`.
* Clarified documentation and code comments for `RTE_BPF_EXEC_FLAG_JIT`
  requirements and fast-path expectations.


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

> Are we standardizing on this specific format ["%s(): "]?
Yes, we are standardizing on this specific formatting for BPF logs.

> Does this properly handle the error string in all cases?
Yes, `err` is a statically assigned string literal in this context, so
passing it to `%s` is perfectly safe.

> Does this code dereference app_prm->sz before checking if app_prm is
> NULL?
The code relies on standard C short-circuit evaluation
(`app_prm == NULL || !opts_valid(...)`), which guarantees safety.

> When app_prm->sz is smaller than sizeof(load->prm), does this code
> leave portions of load->prm uninitialized?
No. `load` is zero-initialized upon declaration (`struct __rte_bpf_load
load = { .elf_fd = -1 };`), meaning any tail space is already securely
zeroed.

> If the user-supplied paths are invalid, does this check prevent
> filesystem attacks like path traversal?
In DPDK, path validation and access control are strictly the caller's
responsibility.

> Does this code risk out-of-bounds access if the union or array layout
> changes?
Structural changes to ABI types like `ctx` are major ABI breaks, which
DPDK explicitly manages across releases.

> Does bpf_convert_filter modify nb_ins even on failure? Is checking ret
> sufficient?
The code explicitly checks if `ret < 0` and immediately bails out,
safely ignoring the state of `nb_ins` on error.

> Does this code leak load->ins if called twice without cleanup between
> invocations?
No. `load` is stack-allocated internally for a single `rte_bpf_load_ex`
invocation and never reused.

> When bpf_eth_elf_install returns an error, does this code still
> transfer ownership of the bpf pointer?
On error, ownership is not transferred. The caller retains
responsibility to call `rte_bpf_destroy()`.

> Does elf_memory() actually guarantee not to modify its input buffer?
Yes, `elf_memory` treats the buffer as read-only memory unless explicit
`ELF_C_WRITE` operations are executed, which DPDK does not do here.

> Is the graceful rejection of NULL parameters by the load APIs covered
> by tests?
We have now added `test_bpf_load_null` to verify that `rte_bpf_load`,
`rte_bpf_elf_load`, and `rte_bpf_load_ex` return `NULL` and set
`rte_errno = EINVAL` when called with a `NULL` parameter.

> Does the test suite verify that mismatched arguments or invalid flags
> are correctly rejected during execution?
Yes, we have introduced tests in v4 to explicitly verify that
`rte_bpf_exec_burst` and `rte_bpf_exec_burst_ex` return `0` and set
`rte_errno = EINVAL` under these invalid conditions.

> Is the libpcap-less stub for rte_bpf_convert tested to ensure it
> doesn't crash?
A test has been added to ensure the stub safely returns `NULL` and
doesn't crash, regardless of the exact error code it might return.


Marat Khalili (11):
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
  test/bpf: add tests for error handling contracts

 app/test/test_bpf.c                    | 455 +++++++++++++++++--------
 doc/guides/prog_guide/bpf_lib.rst      |  75 +++-
 doc/guides/rel_notes/release_26_07.rst |  20 ++
 lib/bpf/bpf.c                          |  32 +-
 lib/bpf/bpf_convert.c                  |  99 +++++-
 lib/bpf/bpf_exec.c                     | 134 +++++++-
 lib/bpf/bpf_impl.h                     |  53 ++-
 lib/bpf/bpf_jit_arm64.c                |  18 +-
 lib/bpf/bpf_jit_x86.c                  |  10 +-
 lib/bpf/bpf_load.c                     | 213 ++++++++++--
 lib/bpf/bpf_load_elf.c                 | 189 ++++++----
 lib/bpf/bpf_pkt.c                      |  65 +++-
 lib/bpf/bpf_stub.c                     |  46 ---
 lib/bpf/bpf_validate.c                 |  94 +++--
 lib/bpf/meson.build                    |  15 +-
 lib/bpf/rte_bpf.h                      | 199 ++++++++++-
 lib/bpf/rte_bpf_ethdev.h               |  54 +++
 17 files changed, 1400 insertions(+), 371 deletions(-)
 delete mode 100644 lib/bpf/bpf_stub.c

-- 
2.43.0

