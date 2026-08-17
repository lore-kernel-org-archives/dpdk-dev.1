Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C9CC5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 02:54:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1749640A6E;
	Mon, 17 Aug 2026 04:54:04 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3CA9F40613
 for <dev@dpdk.org>; Mon, 17 Aug 2026 04:53:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADHn_O5d4JqAwjkBQ--.21980S2;
 Mon, 17 Aug 2026 10:53:47 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 00/13] fix bugs
Date: Mon, 17 Aug 2026 10:53:26 +0800
Message-ID: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHn_O5d4JqAwjkBQ--.21980S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3WryfGw4DZF4DurW7Jwb_yoW5Gr1xpF
 48Zry3ZF13JF43Ww1fXayfZFyYgF18JFyjkrWakas3XF95Aa4UCrs0gF1rGw1qyryfJF1S
 yrW7Ar1UGan5Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6CJPUUUUU=
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
  net/sxe2: enhance repr event handling and  MP code
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
 drivers/net/sxe2/sxe2_mp.c                 |  59 +++--
 drivers/net/sxe2/sxe2_queue.c              |   2 +
 drivers/net/sxe2/sxe2_queue.h              |   7 +-
 drivers/net/sxe2/sxe2_rx.c                 |   5 +-
 drivers/net/sxe2/sxe2_security.c           |   1 +
 drivers/net/sxe2/sxe2_switchdev.c          |  12 +-
 drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
 drivers/net/sxe2/sxe2_tx.h                 |   4 +
 drivers/net/sxe2/sxe2_txrx.c               |  19 +-
 drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
 drivers/net/sxe2/sxe2_txrx_vec.c           |  79 +++----
 drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
 drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 133 +----------
 drivers/net/sxe2/sxe2_txrx_vec_common.h    |   9 +-
 drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 219 +++++++++++------
 drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
 drivers/net/sxe2/sxe2_vsi.c                |   8 +-
 37 files changed, 989 insertions(+), 697 deletions(-)

-- 
2.52.0

