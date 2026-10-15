Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134AFCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:57:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A7C4402DA;
	Thu, 15 Oct 2026 14:57:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1F01D400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:57:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19CD514BF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 05:57:40 -0700 (PDT)
Received: from KDFJ2LQKPJ.cambridge.arm.com (KDFJ2LQKPJ.cambridge.arm.com
 [10.2.197.114])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 024D93FB7F
 for <dev@dpdk.org>; Thu, 15 Oct 2026 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1792069063; bh=URQIP2YKh/uy9ECKQJD3aMW0i3hjHAAirT25SOE3kdI=;
 h=From:To:Cc:Subject:Date:From;
 b=v49YQLHGrrecijeceSBTb+l/54WeV0WhgE2jcN3ZXRMPCBqxDnvKddARCUULU+jgw
 BbbIbdi4Dp72c1lU0iN3iT6K7/WJpLPXwuSKcQTNlxWt0a2dgzxlWdzTQ25jAk7KtI
 9P25RhIgHnaK604Xu18wJKw2XZKN9TL4CAQLLVA0=
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: 
Cc: dev@dpdk.org
Subject: [PATCH 0/2] fix minsize build errors with GCC
Date: Thu, 15 Oct 2026 13:57:38 +0100
Message-ID: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
X-Mailer: git-send-email 2.54.0
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

When building DPDK with a "minsize" build, GCC is throwing the following
maybe-uninitialized warnings (errors with Werror):
In file included from ../lib/eal/include/rte_bitops.h:24,
                 from ../lib/eal/include/rte_memory.h:18,
                 from ../lib/eal/include/rte_memzone.h:26,
                 from ../lib/gpudev/gpudev.c:12:
../lib/gpudev/gpudev.c: In function 'rte_gpu_attach':
../lib/gpudev/gpudev.c:290:39: warning: 'shared_dev' may be used uninitialized [-Wmaybe-uninitialized]
  290 |         rte_atomic_fetch_add_explicit(&dev->mpshared->process_refcnt, 1, rte_memory_order_relaxed);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_stdatomic.h:230:28: note: in definition of macro 'rte_atomic_fetch_add_explicit'
  230 |         __atomic_fetch_add(ptr, val, memorder)
      |                            ^~~
../lib/gpudev/gpudev.c:254:34: note: 'shared_dev' was declared here
  254 |         struct rte_gpu_mpshared *shared_dev;
      |                                  ^~~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c: In function 'bond_ethdev_tx_burst_tlb':
../drivers/net/bonding/rte_eth_bond_pmd.c:997:29: warning: 'primary_member_addr' may be used uninitialized [-Wmaybe-uninitialized]
  997 |                         if (rte_is_same_ether_addr(&ether_hdr->src_addr,
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  998 |                                                         &primary_member_addr))
      |                                                         ~~~~~~~~~~~~~~~~~~~~~
In file included from ../lib/ethdev/rte_eth_ctrl.h:10,
                 from ../lib/ethdev/rte_ethdev.h:1483,
                 from ../lib/ethdev/ethdev_driver.h:21,
                 from ../drivers/net/bonding/rte_eth_bond_pmd.c:11:
../lib/net/rte_ether.h:102:19: note: by argument 2 of type 'const struct rte_ether_addr *' to 'rte_is_same_ether_addr' declared here
  102 | static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea1,
      |                   ^~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bonding/rte_eth_bond_pmd.c:972:31: note: 'primary_member_addr' declared here
  972 |         struct rte_ether_addr primary_member_addr;
      |

I can reproduce this in GCC 13.3.0, 14.2.0, 15.2.0 and 16.0.1 - for minsize
builds only.

Neither of these indicate real bugs in the code - this patch series aims to
satisfy the compiler with minimal impact of the codebase.

Jack Bond-Preston (2):
  gpudev: fix minsize build
  net/bonding: fix minsize build

 drivers/net/bonding/rte_eth_bond_pmd.c | 9 +++++++--
 lib/gpudev/gpudev.c                    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

--
2.43.0

