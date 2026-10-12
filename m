Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA89CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B32940279;
	Mon, 12 Oct 2026 23:09:50 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 2B15940272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:09:49 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so14933525e9.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839389; x=1792444189; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8z/w9cLUReyi8jXrixw1laCC9vZTujEIstu2cjKQxrg=;
 b=ceHy2ttGzrizZpIvVtBmRyQFtRyBzRwZLdj4hHZZzOmq/RuchMPJIhlOPqRWFC+8jQ
 m7UHQf8xSqyJnSZvS61ryJemwAyMU2gsZ6Ze26/ArrkR7RmOPTjW6OpBkYhWcnpnmQew
 pFxETYEk3WCmHilxGv369HQBSRUQF+819jh/6oZfdD0F5qQasumURBV57M/6QhxP04En
 SE91wg9ATzTYFVAGbQAgFce3ubm7k/rZBsi/vfXIF11VUZ9Dp4qU+2PnLTpcTi+3O8EY
 15Cjq2yX9Uece+dDgFkdeMBvf8LE2parJQJqYu1xgEo1XyDqej9UjBH6Kz15KhTJ85IS
 us9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839389; x=1792444189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8z/w9cLUReyi8jXrixw1laCC9vZTujEIstu2cjKQxrg=;
 b=ycNk8BSo2sTtXD9vNGVayTDI1Ktq7C+sfDRayG7KRAYQ3gP1UosYYKllpsEWATWri3
 r9gKI2kR7wD9SRgprGXRIx3+zznwxGNRntz+1l3X3C8Iyue9vKwx98MGy9d3choRGcDp
 DvDHXiWF5MoCvK9MpQ7NDoD6tn7dhVF6zoF2SLECP50QvbQD14qi3+MQ3mfG27fknnNX
 WVzkz2SuJFEzlpyuDB00pldXFc6jrswtjiEmy2SvfK+Tz+4hr7RgftQpW9Yq3s0j+Po9
 ZqYzMmfl34vFz7vQt43PVRiPU5cTin2c5rRZTCs1t5oQi4i4e2T4q98xwryFwjm6WpWN
 wgtg==
X-Gm-Message-State: AFq9FYJHyi0RPyJo9nHIObvMtSXBEy+TT5vfd6jZTBiJ/YOIQYswKtaH
 WNI+LQ9r5D4Ji7CxjU2TqbasUoL792PsG6AsWFhDzaWnP2fwWroNt5YA8RQ3xjsCDR4=
X-Gm-Gg: AYBFou2VYw3Man4y3fhkp9TG5BCZ0q3kHaO7sfRbpApuHAQi3hzdkEn4qLr/IAz/XzL
 4EAW4yqmiceDmsmqkawFFcmEwSZIUtvXHtUX6BYQ83DQm16gwEDOrmV6EL4EfDJZAzwb2w802N9
 KzRN0izgM3jqnx7O42I8gnAykCJo3UzlMmf51PpmzTsyYHK0joRyMeC+KKL2AjGKvX7SNlQwFBl
 9SDQIhJ/8n6zfYX/brRbXvhSLPHEfni0gT+NIaGNIeT7xwqQz5uNPQ1bl/LmQbLAWhdM+6OhB5i
 Zyh8mJjQ+RjjDru7bK1/EzdP4X3EUkC8IFu1NXzV38yDOVOUW814tCY2Ag0JMpNFt9968N4bNvT
 ZT913BA8zphhhCICjkFAHeFZ1HhsR5kneX2d+FHoEea7zGffNPLIuq/atqKFEWnXOeXTd513IWE
 Udgt9ajY3KQ3sHWIzAm7KGwYWk8yk8jj6IQk6Zo+e8dJHbgFMzxivsl2NL6EU=
X-Received: by 2002:a05:600c:c16f:b0:49f:cbf1:e765 with SMTP id
 5b1f17b1804b1-4a18e3ef314mr189298405e9.0.1791839388604; 
 Mon, 12 Oct 2026 14:09:48 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:47 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: 
Cc: dev@dpdk.org, stephen@networkplumber.org, Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v2 0/9] bpf: clean up and document ethdev callback
 synchronization
Date: Mon, 12 Oct 2026 21:09:07 +0000
Message-ID: <20261012210917.161343-1-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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
     counter to a boolean flag (true and false), simplifying
     bpf_eth_cbi_wait().
   - Switch cbi->use stores and control plane wait loop loads to
     explicit rte_atomic_store_explicit() and rte_atomic_load_explicit()
     with relaxed memory order, avoiding implicit seq_cst operations
     in C11.
   - Make cbi->cb atomic with relaxed atomic load/store operations,
     eliminating C11 data-race undefined behavior while compiling to
     identical machine code, and making it self-evident that cb is an
     integral part of the synchronization mechanism on par with use.

Patches 4 and 7 were originally proposed by Stephen Hemminger as part
of a larger series replacing deprecated SMP barriers with C11 fences,
and are carried here with his authorship.

Note that a full rework of the synchronization protocol (e.g. replacing
standalone memory barriers entirely with acquire/release semantics
across variables) was intentionally avoided to keep each commit simple,
localized, and non-controversial. More substantial architectural
changes, such as that or extending the library to support concurrent
multi-threaded dataplane execution, can be cleanly built on top of this
work in the future.

v2:
- Reordered the series so that the patch adding
  RTE_BPF_ETH_F_SKIP_MT_CHECK is last, allowing it to be easily dropped
  if no agreement is reached.
- Added release note in release_26_11.rst documenting the MT_LOCKFREE
  Tx callback rejection and the RTE_BPF_ETH_F_SKIP_MT_CHECK override
  flag.
- Credited Stephen Hemminger for earlier authorship of patches 4 and 7
  ("remove redundant memory barrier on unload" and "use relaxed accesses
  for callback inuse tracking").
- Changed callback usage tracking variable `use` to type `bool` with
  `true`/`false` values instead of uint32_t with 1/0.
- Replaced RTE_WAIT_UNTIL_MASKED with an explicit pause loop in
  bpf_eth_cbi_wait(), eliminating macro and type casts.

Marat Khalili (9):
  bpf: document packet callback unload sequence
  bpf: document ethdev callback threading limitations
  bpf: reject Tx callback installation with MT_LOCKFREE
  bpf: remove redundant memory barrier on unload
  bpf: simplify callback inuse tracking to boolean flag
  bpf: reformat packet callback unload diagram
  bpf: use relaxed accesses for callback inuse tracking
  bpf: make callback handle atomic with relaxed access
  bpf: add callback flag to skip multi-thread check

 app/test/test_bpf.c                    | 123 +++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/bpf/bpf_pkt.c                      | 175 +++++++++++++++++++------
 lib/bpf/rte_bpf_ethdev.h               |  11 +-
 4 files changed, 275 insertions(+), 39 deletions(-)

-- 
2.43.0

