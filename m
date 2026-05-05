Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9622CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 15:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B80DC4027F;
	Tue,  5 May 2026 17:47:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2CF494026C
 for <dev@dpdk.org>; Tue,  5 May 2026 17:47:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g92v65BQCzHnGjq;
 Tue,  5 May 2026 23:46:58 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id A703140577;
 Tue,  5 May 2026 23:47:54 +0800 (CST)
Received: from localhost (10.220.239.45) by dubpeml500001.china.huawei.com
 (7.214.147.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 May
 2026 16:47:53 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>, <mb@smartsharesystems.com>
Subject: [PATCH v5 0/2] few improvemnts for SORING lib
Date: Tue, 5 May 2026 16:47:13 +0100
Message-ID: <20260505154728.82235-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423091625.123642-1-konstantin.ananyev@huawei.com>
References: <20260423091625.123642-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500006.china.huawei.com (7.182.19.102) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

v4 -> v5
 - Fix formal API comments (Morten, Stephen/AI)
 - Add 2 new test-cases for peek API (Stephen/AI)

v3 -> v4
- Remove too aggressive optimization (patch #1)
- Fix AI review comments

v2 -> v3
- fix MSVC complaints

v1 -> v2
- fix formal API comments (doxygen complaints)
- add section to release notes

First patch aims to improve enqueue/dequeue performance, specially
for the cases with multiple workers lcores per stage.
Second one introduces 'Peek API' similar to what we have for
conventional rte_ring. Also it adds new test-cases for this new API.

Konstantin Ananyev (2):
  ring: make soring to always finalize its own stage
  ring: introduce peek API for soring

 app/test/meson.build                   |   1 +
 app/test/test_soring.c                 | 107 ++++++++++
 app/test/test_soring_mt_stress.c       |  74 +++++++
 app/test/test_soring_peek_stress.c     |  75 +++++++
 app/test/test_soring_stress.c          |   3 +
 app/test/test_soring_stress.h          |   1 +
 app/test/test_soring_stress_impl.h     |  87 +-------
 doc/guides/rel_notes/release_26_07.rst |   8 +
 lib/ring/rte_soring.h                  | 269 ++++++++++++++++++++++++
 lib/ring/soring.c                      | 272 ++++++++++++++++++++++---
 10 files changed, 789 insertions(+), 108 deletions(-)
 create mode 100644 app/test/test_soring_peek_stress.c

-- 
2.51.0

