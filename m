Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E58EFD207
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B348F4021E;
	Wed, 25 Feb 2026 09:05:39 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 87415400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 09:05:38 +0100 (CET)
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fLRwc1fFWz1YHN35;
 Wed, 25 Feb 2026 16:05:36 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fLRwZ1zkFz1YHN35;
 Wed, 25 Feb 2026 16:05:34 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp2.hygon.cn (Postfix) with ESMTPS id E8A3530A6425;
 Wed, 25 Feb 2026 16:04:36 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 25 Feb
 2026 16:05:33 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>
Subject: [PATCH v3 0/2] Extend NUMA nodes limit
Date: Wed, 25 Feb 2026 08:04:19 +0000
Message-ID: <20260225080419.727470-1-wangliangxing@hygon.cn>
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
extend NUMA nodes limit for some examples and test app. Also remove
unused NB_SOCKETS macro for ip_reassembly example and graph app.

Liangxing Wang (2):
  examples: extend NUMA nodes limit
  app: extend NUMA nodes limit

 app/graph/ethdev_rx_priv.h         | 1 -
 app/test/test_pmd_perf.c           | 2 +-
 examples/ip_reassembly/main.c      | 2 --
 examples/ipsec-secgw/ipsec-secgw.h | 2 +-
 examples/l3fwd-graph/main.c        | 2 +-
 examples/l3fwd-power/main.c        | 2 +-
 examples/l3fwd/l3fwd.h             | 2 +-
 examples/vhost_crypto/main.c       | 2 +-
 8 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.43.0


