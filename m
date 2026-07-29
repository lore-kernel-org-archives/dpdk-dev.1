Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FECC53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A25AB40279;
	Wed, 29 Jul 2026 19:57:20 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 4041840144
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:19 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so836755a91.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347838;
 x=1785952638; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPAODk5NtEYj8aJJLDI6aI8IzL531+EgVzhvMEIwFo0=;
 b=RxSW5/vspT4HViOZcC6KQe4ckHAK+sNWuewcW/euY6ZXxXMgpcbA6IDVd6llAQZRnH
 qu3ZWT5yZxveTLouK7fgw6e7Ql4uxU13oTAA2a0YY/+7O1pZ3Ag/nOtf3DNLzvgqqZdv
 4dIG6bQWLrFrRy6Ot9r/s/D24JFyd6bCdJoT/EAKKVUlPsC7ytFtB6hx4DlJPnNJLxB0
 /sNx38c7GOYjvW4/aeldA8EPrWsHuH3l50EbYQHzC1A7Dg91OBNjtlV/+1WltG3Qt/ab
 BkSDTb+XrTRN7cNd/1zmfH0Hl2JRAO7NJmpjmcGiV9W391Hfx4k94d9YnFPEtfgzCmp4
 HATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347838; x=1785952638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPAODk5NtEYj8aJJLDI6aI8IzL531+EgVzhvMEIwFo0=;
 b=H0koDSZB7IG0MvFMT+AI8Qr/J9A8uoP39xEmOojNOGQYtgEpKspMadHa6QKGY0K5cQ
 HCQYiYH8tawE7yf44gTZ2r1fEzS9ddzdFZwthWpGi6lwjJlGAtFoae5fnLB2h751fcSv
 tkwjoTiNkI5tLMIeqHVfGyjHUIFANcKrfsND5jCnnTEkgXj/9gSidnNM4o+LBcd9FENQ
 093P+pUkAAaS8HgHLaTSI+emDIAJDufYxBCFi+/RiRqloktVm++fpRuokGBdF0B2ig1o
 EcQPawJk0gkLoETR7vO5+T1723TIRxq0BwQntGHxhQRKtFjM52ktRCI0sXRbHqB2MJm/
 tH+g==
X-Gm-Message-State: AOJu0Yx10FJBtKs+ife+b2L0fcWlgtjLJrf9FTdwa4/cTl8iUk4+xqyF
 qqZw+nrec5bNtUjXEWBii2iuTve7SvT9n9DeCFFJOv9D6+36qFZ3TMpvlCdpjoAOpPlNCGTQXDW
 mJoxi
X-Gm-Gg: AR+sD11inI/9eiTgQ/Q43W8N/gqi4IPBp3T9ijnAf2fWizNB7s7Rrt8e56iFkYg5q5W
 ZJbeyr+xlXGV+8oVvASBK/q8007m97eniUP1BOc+Nb0fEkasZL9imR7dfT+CCydvPSZ/TQceZTH
 uhn29irlc73zCsSMZYWEHEpjqR3iJq6Oln4rd3QOuPh11wzvvdPP/jIcasFT9uiMLUt/U+tH8Mv
 g6Eav4nEsgR/bJFFldvH+PynsC/vhp9JrHGUCKxtSeIYbUE8rgd4UrQoN3TcSdi8JBU+U3pwIuS
 UUdamjMJxCvFsAy5T2jDRCaUwSvGMplPChXJH1TQXsgaP09c5LDRrPrCIJKv09/49mxBHCNmoqP
 9pmp+aYZIO+df+z8t9iQmMAr1FDTZdwtQrXrmoSVz9hyGFPDQUIJVAlVnxKXY0amUQy1nFADjlv
 oVANsX8gKQMikh8cQ6XZtZ1G3WuvO1cUtLE0txz9243MTrELxXabybzXsXniLrGrSzUhR2VKP91
 4VhwazrrwY9EML2YSgGCCfnwWw=
X-Received: by 2002:a17:90b:4c0e:b0:387:e0db:bc26 with SMTP id
 98e67ed59e1d1-38f6a5aa0d1mr6595568a91.38.1785347838101; 
 Wed, 29 Jul 2026 10:57:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 00/32] remove rte_smp barrier functions
Date: Wed, 29 Jul 2026 10:53:53 -0700
Message-ID: <20260729175715.165120-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This patch series completes the removal of rte_smp_XX barrier
functions that was announced over five years ago (20.05).

Most of this is mechanical with AI assistance, so strongly
encourage maintainers to take a good look.

Stephen Hemminger (32):
  bpf: replace deprecated SMP barriers with C11 fences
  test: remove test for rte_smp_mb
  bus/vmbus: fix ring buffer ordering on weakly ordered CPUs
  bus/vmbus: fix missing acquire on receive ring index
  bus/vmbus: replace SMP barriers with C11 memory fences
  baseband: convert rte_smp_rmb to fence
  net/hinic: replace rte_smp_rmb
  net/intel: replace rte_smp_rmb
  crypto_caam_jr: replace rte_smp_rmb
  net/virtio: replcae rte_smp_rmb
  net/thunderx: replace rte_smp_rmb
  stack: always use C11 memory model implementation
  ring: replace SMP read barrier with C11 acquire fence
  crypto/virtio: update comment reference to rte_smp_rmb
  event/sw: fix unlinks in progress counter races
  event/sw: replace SMP barriers with C11 atomics
  eal/x86: move optimized fence out of SMP barrier
  common/octeontx: remove redundant barrier in mbox
  crypto/caam_jr: use IO barrier before job ring doorbell
  crypto/octeontx: use IO barrier before doorbell
  mempool/octeontx: use IO barrier in pool destroy
  event/octeontx: replace deprecated SMP barriers
  event/dpaa2: replace deprecated barrier in selftest
  event/dsw: replace SMP barriers with release fences
  event/opdl: replace SMP barriers with C11 atomics
  net/netvsc: replace SMP barrier in RNDIS response
  net/thunderx: replace deprecated SMP barriers
  net/virtio: replace deprecated barrier in avail index update
  eal: remove stale SMP barrier in rte_service
  eal: remove rte_smp_XX
  checkpatches: no longer warn about rte_smp_XX
  doc: update release notes about rte_smp_XX removal

 app/test/meson.build                          |   1 -
 app/test/test_barrier.c                       | 288 ------------------
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   7 -
 doc/guides/rel_notes/release_26_11.rst        |   6 +
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   8 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  12 +-
 drivers/bus/vmbus/private.h                   |  12 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  17 +-
 drivers/bus/vmbus/vmbus_channel.c             |  10 +-
 drivers/common/octeontx/octeontx_mbox.c       |   6 +-
 drivers/crypto/caam_jr/caam_jr.c              |   5 +-
 .../crypto/octeontx/otx_cryptodev_hw_access.h |   4 +-
 drivers/crypto/virtio/virtqueue.h             |   2 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   4 +-
 drivers/event/dsw/dsw_event.c                 |   8 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |   6 +-
 drivers/event/octeontx/ssovf_worker.c         |   8 +-
 drivers/event/opdl/opdl_evdev.c               |   7 +-
 drivers/event/sw/sw_evdev.c                   |  37 ++-
 drivers/event/sw/sw_evdev.h                   |   2 +-
 drivers/event/sw/sw_evdev_scheduler.c         |  13 +-
 drivers/mempool/octeontx/octeontx_fpavf.c     |   4 +-
 drivers/net/hinic/base/hinic_pmd_cmdq.c       |   2 +-
 drivers/net/hinic/base/hinic_pmd_mgmt.c       |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
 drivers/net/netvsc/hn_rndis.c                 |   2 +-
 drivers/net/thunderx/base/nicvf_hw.c          |   3 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   5 +-
 drivers/net/virtio/virtqueue.h                |  18 +-
 lib/bpf/bpf_pkt.c                             |  18 +-
 lib/eal/arm/include/rte_atomic_32.h           |   6 -
 lib/eal/arm/include/rte_atomic_64.h           |   6 -
 lib/eal/common/rte_service.c                  |   1 -
 lib/eal/include/generic/rte_atomic.h          |  61 ----
 lib/eal/loongarch/include/rte_atomic.h        |   6 -
 lib/eal/ppc/include/rte_atomic.h              |   6 -
 lib/eal/riscv/include/rte_atomic.h            |   6 -
 lib/eal/x86/include/rte_atomic.h              |  41 +--
 lib/ring/rte_ring_gcc_pvt.h                   |   6 +-
 lib/stack/meson.build                         |   1 -
 lib/stack/rte_stack_lf.h                      |   4 -
 lib/stack/rte_stack_lf_generic.h              | 153 ----------
 44 files changed, 156 insertions(+), 670 deletions(-)
 delete mode 100644 app/test/test_barrier.c
 delete mode 100644 lib/stack/rte_stack_lf_generic.h

-- 
2.53.0

