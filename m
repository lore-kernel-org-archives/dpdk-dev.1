Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356C606A326
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 23:22:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 282A340E1F;
	Mon,  2 Nov 2026 00:21:59 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTPS id C622240264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 00:21:57 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1ae18eb9b69so1415007c88.0
 for <dev@dpdk.org>; Sun, 01 Nov 2026 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kev009.com; s=google; t=1793575316; x=1794180116; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lrv31dvGEjQib7HjgqBVNFqgqTmwLEEbLEUh3fPIHNM=;
 b=nVS3gXaX0EBKE5t8Ot/ZVkhe6N5GE/92PJtgATvXXZKfhlsDdjTHnMSI540fJ7aMhh
 JAeyBXvNFWXZfAIaYVNCzkFlJLDrzAlILBwCyel7TBUxeLNLSE5QM32f22tgAnlKRNp+
 7aXSjIkMOUfcQSac8VYfnxaaXiPNuo9gggJ3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575316; x=1794180116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lrv31dvGEjQib7HjgqBVNFqgqTmwLEEbLEUh3fPIHNM=;
 b=tmV1W4DT3VlkqKt1pkVCY9yeGSz6zqMZpiCfbf0KusO5jYcEyrYD08wV0gnKbjc04H
 3zSUg/ixAix9CAS686QlxMp9B1IzqM5KlUWLryOeOVUMvo4n681iC51eeF2UrvY7BB9Z
 jojQqTt56Xti670ML3WCxRT+MILszHPf+0S63d1PIvKwwwG/Rv99cowxY/WxtBPHiF7q
 2R0bINLgGN7RR2JdPmBak7AbK+kpaJgOY3+W66DpssWLAI+r0nqGM0lD1VxgvodabPs3
 yUL4nlsjpEYZeHUEL/oUXpRnrJ+PPVKiZC06HSLlcF9EtqJ1AIyOaO+0JziTVlEZ8SSp
 nbJQ==
X-Gm-Message-State: AFq9FYJmsoIBBCEt7OG4hb9qv/KmHMhosCACRptDY1iN472Np4CPGHip
 sjZ85o7bv4b/6unLjL/T1J9Sm9UBy6iDz+NTiiev1Bzk7ivZoeKkTeGoLN+frOFlnY3nx8yV1ys
 2K1kzA5C9
X-Gm-Gg: AYBFou254jidpxwOi08708C+YP525/Vn8AqUA7fNfEYL925vy2kDnECR2HTn3yKphMG
 GDd3Ic6JwJlf2EoDSzTC3KY+EdwRIHthKcG0h4PtrbCtS++WWA9wfvd3BAKBcHtFImNJCfxX4yL
 Pvy3NQYzmBju+Bd254Xm1bKMwJLwj+8c/kevR4ykyGL4uHkCZ3EcS1Ve39m/Ng9iBJrG4XPAfwn
 ck7gqvqKuJQHEU7YLP/GAh78eyFS9kzkP9KC8+FF5trSv1MrVAQ2f4DaJzWKLEuUO0H0iYVZ7jY
 7ZFZf/Ml+JvPkxssh06aZ6BdLtUHl/AiOJt5esnTcnhJRUzLmyZaUTlGy92Uyd6IJlKecAx770M
 uMmyahQytOBRdjOzhMVJ3MYUUJuCUeq2Ono6TTV+vwIo74jH9YCgCRA4Zj8M7lralX+ndoyiOtj
 EbPCkPg4EwabOU/LDw5TP3n89ypUoFF9dYA8VVk5VY74TFeuRzhLHIQ0hMYEcA+JmFfCGhAtHQ1
 Gbwjoex+yJdpAMxoS49LvRARDWdG51/7Y7cZkZGyYimmYBfsR95JZq903k0T92IWuqvH1KnjBza
 xZ9YGkQzqGDlH3Rue7/YSsegl4zRHYreCNnhYIx7fGkxNhB+Fr6pQuozLzfGoeUnCaj/U4muujq
 TWZRbVJ+szNbeU6n74Ee7aTZdA+H7Uy6fT6BU18C6QwrallsntrAF/fdQNBG4XpZyGf70MnBtPc
 0bGks14Nc=
X-Received: by 2002:a05:701b:2087:20b0:144:fdf0:9d91 with SMTP id
 a92af1059eb24-1ac5da7ad99mr13857952c88.24.1793575315889; 
 Sun, 01 Nov 2026 15:21:55 -0800 (PST)
Received: from kev-ws-aurora.cv0.bbox.io ([172.83.102.10])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm31982675c88.13.2026.11.01.15.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:21:55 -0800 (PST)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH RESEND 0/3] FreeBSD: add MSI-X control interrupts to nic_uio
Date: Sun,  1 Nov 2026 16:21:50 -0700
Message-ID: <20261101232154.94354-1-kevin.bowling@kev009.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	TVD_FROM_1,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resending unchanged after subscribing to the mailing lists.

FreeBSD nic_uio currently supplies BAR mappings without interrupt
delivery. This series adds an optional single-vector MSI-X interface and
connects it to the FreeBSD kqueue dispatcher for AdminQ and link events.

The first patch fixes a pre-existing dispatch cleanup bug and is suitable
for stable backport. The second implements the module interface with
serialized IRQ/resource lifetime, writable-only control ioctls, and bus
mastering tied to writable open file descriptions. The third integrates
the interface with EAL. Both EAL and hardware lifecycle tests are included.

The series is based directly on main at c981dcfe134e. Older applications
retain BAR-only operation; older modules remain usable with PMDs that
support polling fallback. The separate iavf polling fix in PR #125 was
present in the hardware-tested application but is not part of this series:
https://github.com/DPDK/dpdk/pull/125

The polling fix was sent first in a separate thread:
Message-ID: <20261101232140.94324-1-kevin.bowling@kev009.com>

Validation includes Clang 21/GCC 14 static and shared EAL, PCI and iavf
builds with -Werror; normal and INVARIANTS/WITNESS module builds; and the
FreeBSD interrupt and alarm tests. E810 VF hardware tests on FreeBSD
16-CURRENT cover 300 software interrupts, 60 masked/pending deliveries,
ownership and descriptor lifetime, and three active-traffic SIGKILL cases
including both primary/secondary exit orders. Bus mastering is checked
after the final writer exits; reopening needs no external PCI reset.
Follow-up current-DPDK runs deliver exactly 4,512 frames across 45 queue
restarts and 21 device resets. Older polling-application runs deliver
exactly 2,688 frames across 36 queue restarts.

Checkpatch has no errors. Its eight negative-errno warnings concern
positive errno returns required by FreeBSD cdev methods. Full-tree builds
encounter an existing contigmem SYSCTL_NODE_CHILDREN API mismatch; focused
builds pass. Optional Clang C11 atomics encounter existing EAL type errors;
validation uses the default non-stdatomic configuration.

Scope is one control-event vector, not per-queue Rx, MSI or INTx. There is
no IOMMU isolation or guarantee of draining transactions already issued
before PCI bus mastering is cleared. Hardware coverage is E810/FreeBSD
16-CURRENT.

GitHub review and CI:
https://github.com/DPDK/dpdk/pull/126

Kevin Bowling (3):
  eal/freebsd: fix active interrupt source cleanup
  kernel/freebsd: add single-vector MSI-X support
  eal/freebsd: support UIO MSI-X interrupts

 .mailmap                               |   1 +
 MAINTAINERS                            |   4 +-
 app/test/meson.build                   |   4 +
 app/test/test_interrupts_freebsd.c     | 203 ++++++++++++++
 app/test/test_nic_uio.py               | 140 ++++++++++
 doc/guides/freebsd_gsg/build_dpdk.rst  |  25 ++
 doc/guides/rel_notes/release_26_11.rst |  10 +
 drivers/bus/pci/bsd/pci.c              |   2 +-
 kernel/freebsd/nic_uio/meson.build     |   2 +-
 kernel/freebsd/nic_uio/nic_uio.c       | 364 ++++++++++++++++++++++---
 kernel/freebsd/nic_uio/nic_uio.h       |  33 +++
 lib/eal/freebsd/eal_interrupts.c       |  46 +++-
 lib/eal/freebsd/meson.build            |   2 +
 13 files changed, 787 insertions(+), 49 deletions(-)
 create mode 100644 app/test/test_interrupts_freebsd.c
 create mode 100644 app/test/test_nic_uio.py
 create mode 100644 kernel/freebsd/nic_uio/nic_uio.h


base-commit: c981dcfe134e4c641951ee15a76de0b56aafb05a
-- 
2.56.0

