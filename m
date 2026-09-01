Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777EFC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D560402E9;
	Tue,  1 Sep 2026 08:43:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0DB814027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 08:43:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CDA4520784;
 Tue,  1 Sep 2026 08:43:33 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Sep 2026 08:43:33 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v4 0/2] introduce pile stack and mempool driver
Date: Tue,  1 Sep 2026 06:43:29 +0000
Message-ID: <20260901064331.594276-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812134756.1829613-1-mb@smartsharesystems.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Sep 2026 06:43:33.0696 (UTC)
 FILETIME=[355F0C00:01DD39DD]
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

Added a new high-performance lock-free "pile", using the Stack API,
and an accompanying mempool driver.

Morten Brørup (2):
  stack: introduce pile
  mempool: introduce pile driver

 app/test/test_stack.c                     |  71 ++++-
 app/test/test_stack_perf.c                |  15 +-
 config/rte_config.h                       |   3 +
 doc/guides/mempool/stack.rst              |  12 +-
 doc/guides/prog_guide/stack_lib.rst       |  67 +++-
 drivers/mempool/stack/rte_mempool_stack.c |  90 +++++-
 lib/mempool/rte_mempool.h                 |   4 +-
 lib/mempool/rte_mempool_ops.c             |  27 +-
 lib/stack/meson.build                     |   3 +-
 lib/stack/rte_stack.c                     |  18 +-
 lib/stack/rte_stack.h                     |  65 ++++
 lib/stack/rte_stack_lf.h                  |  22 ++
 lib/stack/rte_stack_lf_c11.h              |  20 +-
 lib/stack/rte_stack_lf_generic.h          |  19 +-
 lib/stack/rte_stack_lf_stubs.h            |   4 +-
 lib/stack/rte_stack_pile.c                |  35 +++
 lib/stack/rte_stack_pile.h                | 359 ++++++++++++++++++++++
 17 files changed, 761 insertions(+), 73 deletions(-)
 create mode 100644 lib/stack/rte_stack_pile.c
 create mode 100644 lib/stack/rte_stack_pile.h

-- 
2.43.0

