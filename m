Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56168CA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB2140279;
	Sun, 11 Oct 2026 20:22:48 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 06C934026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:46 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so1828577a12.1
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742966; x=1792347766; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6FOVUv2m/jyb4ZQKx3jEd47f00orV8SaNE65cpr2UTs=;
 b=TngGvMqcrnf9ArozU90umb9GxMCnhz1AqebXF+QqMWF8gYoIbxCPUt8fSol2L4A+PW
 /+t8tsQmWkKTDdgM2LIaBNuSHGT+SOwSg+lpzJ6XLhE5ULp8Yw0QAG01tM9YBLbTtec1
 KXad/BrpYtOoiVVTEajccIJky1OrmkEl+cNGghdPg8+bg97CfCZN1xzzvKUodTi3wwCR
 az2tfenrnGMokJgXlS3uXsZtnr7RcORrssukvJCmwVQctSh/RYrfxnDclcXE2KEl9OQt
 2JuB8FTfdnVqvzyZrGhQSa2H/g9LBDg0D9cOxDfHCgXOy8ZiWPwbzEul7J3kulcmFPb6
 hOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742966; x=1792347766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FOVUv2m/jyb4ZQKx3jEd47f00orV8SaNE65cpr2UTs=;
 b=WNswrQUCyJHx1X0IpPou4jX7iW9+LdHv5Zf568A1U1q5EED1AO3BigtOkVjcVQNEUf
 DdXefrWrANwZihZvp61NH4gvBOJAlM8uwHqKrRt64v1K579v7PNk2i9SmiEJ6MSQR42o
 cR3tPrn/m+LKuVhp4IMd3nQ9rMBgrQe1C1tZQY40p2XVJl3PHr8j6aDOW416QdJEfMSw
 vQZL6QK05XPFC39/Rh/fWNhe7/XEt+vLnan13DK0GLxMKyANzBQ/2TpOtJLCzBm95rXM
 oGNnwTr2ciDQsIcaxm3Y55A77XUofDFxDd2EiwMPZF/bys21sZwty/mdUo63bqYqu3wC
 HaCA==
X-Gm-Message-State: AFq9FYIjhpttayzWBBnEw2pdT5f3RTkvDswiV09Yq7P8itOYBKleTVrT
 G8gyZ6noaGvnxrnJKfHbNtxzp7PAJBgR6J3U8UQR5RG2x0l5yd6Je6+3o9eWI7tt
X-Gm-Gg: AYBFou2Ck0Qok8OA8EE7BOkHJEvf7k7I7cjkpQoS1ZfX50WDJ/HXmw0UDXr0uY/BeO6
 DPxPGA8YMXXwDkGpHSL1KErzipjr/Nctc5jxs9AvO7crNlmEgD6AzSwwUe6wecp3ZRabJIojPY2
 yRR5/Em8bhPRIWYzx29eMypeFHK5WQsBzN+Sy40oYrKEzA31xClfSRt4adkcfM5a0oxfFelMTY9
 +U9ECGSlHVD7Vbhw3FTb4OM1/sIgClUooyAhRlDsGu1FkTRpCVc1DqLvAs1/1TZlou5jDA3VC5u
 xcxUyKPH5q6oYea/1YR0N11YvR4AGfZmv8nkltSBoaSWjkDNdtfYV9C9uWQd1NaMQkINhUGPvN6
 Iu3X+lAKTiQEI0x9G3UthSZ3F6wajItwC744YU7omqrxvcWufHKR3hrbO4YyjvDJ+pt0TfWGKHX
 U6L40MtJ414bCzeqsiW1I/fAxKgtClDMtf5Q8NU3v7Gcf4fNCpyMtrdz2Xh7A=
X-Received: by 2002:a05:6402:21cb:b0:6b1:c355:c7b3 with SMTP id
 4fb4d7f45d1cf-6b1c355cdf1mr515327a12.25.1791742966251; 
 Sun, 11 Oct 2026 11:22:46 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:44 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: 
Cc: dev@dpdk.org, stephen@networkplumber.org, Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH 0/9] bpf: clean up and document ethdev callback synchronization
Date: Sun, 11 Oct 2026 18:21:48 +0000
Message-ID: <20261011182158.124246-1-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DPDK BPF library provides mechanisms to attach BPF programs to
ethdev Rx/Tx callbacks (rte_bpf_eth_rx_elf_load and
rte_bpf_eth_tx_elf_load). Safe unloading of these callbacks relies on
a synchronization protocol between the control plane and datapath
threads, built upon the assumption that each port/queue callback is
serviced by at most one datapath thread.

This patch series improves the documentation, safety, and implementation
of the callback synchronization mechanism:

1. Documentation:
   - Add an ASCII sequence diagram and comprehensive documentation in
     bpf_pkt.c explaining the synchronization protocol between the
     control plane and datapath during callback unload.
   - Document the single-thread-per-queue datapath requirement in
     public API headers.

2. Safety and Validation:
   - Enforce the single-threaded datapath assumption by rejecting Tx
     callback installation when the device advertises
     RTE_ETH_TX_OFFLOAD_MT_LOCKFREE.
   - Add a new flag (RTE_BPF_ETH_F_SKIP_MT_CHECK) allowing applications
     to override this check when application architecture guarantees
     thread exclusivity.
   - Add automated unit test test_bpf_elf_tx_mt_lockfree.

3. Synchronization Cleanups:
   - Remove a redundant control plane memory barrier (rte_smp_mb) on
     callback unload.
   - Simplify datapath inuse tracking (cbi->use) from an even/odd
     counter to a simple boolean flag (0 and 1), simplifying
     bpf_eth_cbi_wait().
   - Switch cbi->use stores to explicit rte_atomic_store_explicit() with
     relaxed memory order, avoiding implicit seq_cst operations in C11.
   - Make cbi->cb atomic with relaxed atomic load/store operations,
     eliminating C11 data-race undefined behavior while compiling to
     identical machine code, and making it self-evident that cb is an
     integral part of the synchronization mechanism on par with use.

Note that a full rework of the synchronization protocol (e.g. replacing
standalone memory barriers entirely with acquire/release semantics
across variables) was intentionally avoided to keep each commit simple,
localized, and non-controversial. More substantial architectural
changes, such as that or extending the library to support concurrent
multi-threaded dataplane execution, can be cleanly built on top of this
work in the future.

Marat Khalili (9):
  bpf: document packet callback unload sequence
  bpf: document ethdev callback threading limitations
  bpf: reject Tx callback installation with MT_LOCKFREE
  bpf: add callback flag to skip multi-thread check
  bpf: remove redundant memory barrier on unload
  bpf: simplify callback inuse tracking to boolean flag
  bpf: reformat packet callback unload diagram
  bpf: use relaxed stores for callback inuse tracking
  bpf: make callback handle atomic with relaxed access

 app/test/test_bpf.c      | 123 ++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c        | 172 +++++++++++++++++++++++++++++++--------
 lib/bpf/rte_bpf_ethdev.h |  11 ++-
 3 files changed, 271 insertions(+), 35 deletions(-)

-- 
2.43.0

