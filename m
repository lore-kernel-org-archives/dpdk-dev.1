Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05633C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA2AB40285;
	Fri, 14 Aug 2026 14:22:16 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id C9A57400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S2;
 Fri, 14 Aug 2026 20:22:12 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 00/13] net/sxe2: fix bugs
Date: Fri, 14 Aug 2026 20:21:51 +0800
Message-ID: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3WryfGw4DZF4DurW7Jwb_yoW5GFykpF
 48Zry3ZF13JF43Ww1fXaySvFyYgF18JFyjkrWakas3XF95AFyUCrs0gF1rGw1qyr1fJF1S
 yrW7Ar1UGan5Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRVbDUUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Jie Liu (13):
  net/sxe2: add Rx queue buffer split fill support
  net/sxe2: update switchdev repr VSI ID display format
  net/sxe2: add ACL engine event statistics support
  net/sxe2: enhance device cap and res management
  net/sxe2: improve representor device initialization
  net/sxe2: refactor flow tunnel port handling
  net/sxe2: validate IPsec key length against maximum limit
  net/sxe2: enhance repre event handling and  MP code
  net/sxe2: optimize vectorized Tx/Rx path
  common/sxe2: allow munmap during kernel reset
  net/sxe2: clean up duplicate function declarations
  net/sxe2: clean up structure definitions
  doc/sxe2: add acl-stat-type parameter documentation

 doc/guides/nics/sxe2.rst                   |  33 +--
 drivers/common/sxe2/sxe2_common.c          |   5 +-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      |   8 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           | 215 +++++++++++++++--
 drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
 drivers/net/sxe2/sxe2_drv_cmd.h            |  47 ++--
 drivers/net/sxe2/sxe2_dump.c               |  10 +-
 drivers/net/sxe2/sxe2_ethdev.c             | 203 +++++++++-------
 drivers/net/sxe2/sxe2_ethdev.h             |  38 +--
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  13 +-
 drivers/net/sxe2/sxe2_flow.c               | 259 +++++++++++++++++----
 drivers/net/sxe2/sxe2_flow.h               |   6 +-
 drivers/net/sxe2/sxe2_flow_define.h        |  13 +-
 drivers/net/sxe2/sxe2_flow_parse_action.c  |  37 ++-
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ---------
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   7 -
 drivers/net/sxe2/sxe2_ipsec.c              |   5 +
 drivers/net/sxe2/sxe2_irq.c                |  27 ++-
 drivers/net/sxe2/sxe2_mac.c                |  10 +-
 drivers/net/sxe2/sxe2_mp.c                 |  65 +++---
 drivers/net/sxe2/sxe2_mp.h                 |   3 +-
 drivers/net/sxe2/sxe2_queue.c              |   2 +
 drivers/net/sxe2/sxe2_queue.h              |   7 +-
 drivers/net/sxe2/sxe2_rx.c                 |   5 +-
 drivers/net/sxe2/sxe2_security.c           |   1 +
 drivers/net/sxe2/sxe2_stats.c              |  10 +-
 drivers/net/sxe2/sxe2_switchdev.c          |  12 +-
 drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
 drivers/net/sxe2/sxe2_tx.h                 |   4 +
 drivers/net/sxe2/sxe2_txrx.c               |  19 +-
 drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c           |  77 +++---
 drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 123 +---------
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   5 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 215 +++++++++++------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |   8 +-
 39 files changed, 993 insertions(+), 692 deletions(-)

-- 
2.52.0

