Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3BED148B5
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 07:29:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 726534028C;
	Thu,  8 Jan 2026 08:29:10 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 25BCF40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 08:29:07 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dmxNc01DBzSj93;
 Thu,  8 Jan 2026 15:29:04 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dmxNZ2wFzzSj93;
 Thu,  8 Jan 2026 15:29:02 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 4952A4B7C;
 Thu,  8 Jan 2026 15:29:02 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:29:02 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <radu.nicolau@intel.com>, <gakhil@marvell.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>
Subject: [PATCH v2 0/3] Extend NUMA nodes limit for examples
Date: Thu, 8 Jan 2026 07:27:27 +0000
Message-ID: <20260108072727.1279711-1-wangliangxing@hygon.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.22.47]
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)
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

This patchset use RTE_MAX_NUMA_NODES instead of hardcoded values to
extend NUMA nodes limit for some examples and test app.

Liangxing Wang (3):
  examples/l3fwd: extend NUMA nodes limit beyond 8
  examples/ipsec-secgw: extend NUMA nodes limit beyond 4
  app/test: extend NUMA nodes limit beyond 2

 app/test/test_pmd_perf.c           | 2 +-
 examples/ipsec-secgw/ipsec-secgw.h | 2 +-
 examples/l3fwd-graph/main.c        | 2 +-
 examples/l3fwd-power/main.c        | 2 +-
 examples/l3fwd/l3fwd.h             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0


