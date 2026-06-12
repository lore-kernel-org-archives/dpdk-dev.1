Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE6DCD98CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 16:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE4D4353D;
	Fri, 12 Jun 2026 18:06:42 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 26B9240279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 18:06:42 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-13809223fd4so1248520c88.1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781280401;
 x=1781885201; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZS29sVpiDUqPPOPxvtmeQX5InHaqAVCXntZaEqGlls=;
 b=tu2ez28pW5wn2FoKODvHTGZQ7vwjE9SsLVOvEC6hhjEGRLowoiutbtSrXxfuMX9Ek3
 l4756G5o9s2hslolOfiprSJBy6lU5crZJ+LCffdniwDFACGVMooO5tb3lRf4mMKoV+jD
 aahMUHOUq8Gopjmh7zkad253YLbeTAi9DiOZgc0yjSr/aANdn8sarp5TU2gzIkHpf2hZ
 Joq7b6Ga3JR3UT0knzq6jU8UIj7hpflzMBbUmY7OFkNgtl3jLruxdg6P+NBTbIwZdfTR
 jhXnnLThYpFnHzGCCDxKSMP6oaQzJxuVUydrW+hkX54geV5DrCp08yF6OWINOUMB2Qfy
 83jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781280401; x=1781885201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vZS29sVpiDUqPPOPxvtmeQX5InHaqAVCXntZaEqGlls=;
 b=r+jQvkRKUIfAbLn9uRAviehBweVUbMYfOQoFA6pHHET3IlC3SfX0gFEIwqNe4fF+CM
 ijgjCC2pPFCl5KBLuCVr5nnx4Lil0f/QXDlKCx7FHKeJETGpe/HCUoEMPyXKI6Pxh77a
 ONnbyqS368zwV9u9A0uWWKvPmZ3noXwWniXfWoPF6omtXQBl/lcjtD9LBhdPXNMXogsW
 q+2l2iSAMjUAj4T5OrMnR6e2Pd+uEojISTAiRCjju4ypbNNRcZ4Ikf7j0qxecNgPWM5B
 5mPtQoNk8suDmRrCZnS8HWK0Xdg2Vjp1LriOPfODhaxMs1FyhC9P9V94BAtobieFl1di
 lhgg==
X-Gm-Message-State: AOJu0YyZ/R/0WmGLG5Q2LIBKsbg5XsvJUWvDnAw45EDZKgycwCmxzlMq
 wWYpfldCEfxyLWvBmGND6aYXEztDX7iNOvnnQp98faUXOSYlj0ODviADAWwQ3sRc7iY=
X-Gm-Gg: Acq92OGG9VJeCt9hVLcu79Bn3GouEwt5F4+NCuSh0a16Bfy/kupbZBykohQ4U4pwVNl
 jkSz+eBydyg5DcFT7Q/wPR3TZ11g+XwgAkVYrIoCUNhekEWYlRtUggp+gjL3lztwgTnWdnRQsnl
 AhtqTfNLvQADi+hcMV7LZtDBxQjl60PlZcHZpb4RfzIq6G5p+/zEKl6Un9UjHjNUOAGCC1es56O
 ejADUzOpltJwM92XJCcvu43U258rLtCwc86zIqFIDQXlI31t62FmrWYh2ywlJjny5ZGDc7fUPTQ
 1AafAFO1ModZWPm5g5WIu8M73H5cxxV8AISpwwKsyw4+27B4QISwanOG2Ai+IhtMG5oELabD9Y3
 yXCzihAgWlY/tSxJcXrhwbeYiLwahtwuOyaItdlHwhjsdrx79FeZQtxnBWZ50MG//JHkmeW5Xh1
 8iVjTiVqxiEe26Q4iKtiNeDWEY6Z8znT4fuQJnonFNpun0mmweJcybYX5SBnZR3koK
X-Received: by 2002:a05:7022:620:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-1384bb68541mr1665013c88.23.1781280400850; 
 Fri, 12 Jun 2026 09:06:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b964862sm2667953c88.10.2026.06.12.09.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:06:40 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:06:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v5 00/11] bpf: introduce extensible load API
Message-ID: <20260612090636.10d8bf26@phoenix.local>
In-Reply-To: <20260612084219.38399-1-marat.khalili@huawei.com>
References: <20260520124922.42445-1-marat.khalili@huawei.com>
 <20260612084219.38399-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 12 Jun 2026 09:42:07 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

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
>=20
> v5:
> * Fixed compilation between commits broken in v4 while addressing AI
>   comments.
> * Rebased on fresh main, addressing conflicts in release notes.
>=20
> v4:
> * Restored missing NULL checks in wrapper functions `rte_bpf_load` and
>   `rte_bpf_elf_load`.
> * Fixed the burst execution functions (`rte_bpf_exec_burst*`) to return
>   `0` and set `rte_errno =3D EINVAL` on failure, preventing `-EINVAL`
>   being reinterpreted as a large `uint32_t` value. Initialized `rc`
>   properly in scalar execution wrappers for this case.
> * Swapped the Doxygen comments in `rte_bpf_ethdev.h` for RX and TX functi=
ons.
> * Added diagnostic dump on failure path in `test_bpf_filter`.
> * Fixed memory leak of the BPF handle in `bpf_rx_test` upon install failu=
re.
> * Added tests for NULL parameter rejection, mismatched execution argument=
s,
>   unsupported execution flags, and the libpcap-less `rte_bpf_convert` stu=
b.
>=20
> v3:
> * Appended Acked-by tags to all individual commits to align with
>   patchwork requirements.
>=20
> v2:
> * Fixed a potential segmentation fault in `exec_vm_burst_ex` by deferring
>   the dereference of `ctx[i].arg` until it is confirmed that `nb_prog_arg=
 > 0`.
> * Clarified documentation and code comments for `RTE_BPF_EXEC_FLAG_JIT`
>   requirements and fast-path expectations.
>=20
>=20
> Marat Khalili (11):
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
>   test/bpf: add tests for error handling contracts
>=20
>  app/test/test_bpf.c                    | 455 +++++++++++++++++--------
>  doc/guides/prog_guide/bpf_lib.rst      |  75 +++-
>  doc/guides/rel_notes/release_26_07.rst |  20 ++
>  lib/bpf/bpf.c                          |  32 +-
>  lib/bpf/bpf_convert.c                  |  99 +++++-
>  lib/bpf/bpf_exec.c                     | 134 +++++++-
>  lib/bpf/bpf_impl.h                     |  53 ++-
>  lib/bpf/bpf_jit_arm64.c                |  18 +-
>  lib/bpf/bpf_jit_x86.c                  |  10 +-
>  lib/bpf/bpf_load.c                     | 213 ++++++++++--
>  lib/bpf/bpf_load_elf.c                 | 189 ++++++----
>  lib/bpf/bpf_pkt.c                      |  65 +++-
>  lib/bpf/bpf_stub.c                     |  46 ---
>  lib/bpf/bpf_validate.c                 |  94 +++--
>  lib/bpf/meson.build                    |  15 +-
>  lib/bpf/rte_bpf.h                      | 199 ++++++++++-
>  lib/bpf/rte_bpf_ethdev.h               |  54 +++
>  17 files changed, 1400 insertions(+), 371 deletions(-)
>  delete mode 100644 lib/bpf/bpf_stub.c
>=20

Detailed AI review found some minor things:

02/11: comment grammar nits =E2=80=94 "Any features that not known to
the application" -> "that are not known" (twice); "the size of
same struct" -> "the size of the same struct".

05/11: Doxygen for rte_bpf_eth_rx_install and
rte_bpf_eth_tx_install references rte_bpf_eth_unload, which does
not exist. Use rte_bpf_eth_rx_unload and rte_bpf_eth_tx_unload
respectively.

07/11: stray space before comma in the test_bpf_filter log
string ("for \"%s\" ,").
