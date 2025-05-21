Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAACDC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E11B427A5;
	Wed, 21 May 2025 13:15:02 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CFE41427A4
 for <dev@dpdk.org>; Wed, 21 May 2025 13:15:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TJj1vXyz6H6ls;
 Wed, 21 May 2025 19:11:49 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 595BF1402FC;
 Wed, 21 May 2025 19:15:00 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:15:00 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: [PATCH v1 0/4] ring: some fixes and improvements
Date: Wed, 21 May 2025 12:14:28 +0100
Message-ID: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

First two patches are ‘low risk’ ones.
Third one touches some core functions within rte_ring library and
would probably requires extra reviews/testing from different vendors.
4th one enables C11 based code on all x86 platforms by default.
The stretch goal for it – make all supported platforms to use C11
based code and get rid of legacy code in rte_ring_generic_pvt.h.
If there would be some issues with latest two patches – we can limit
ourselves with just first two to apply.

Konstantin Ananyev (4):
  ring: introduce extra run-time checks
  ring/soring: fix head-tail synchronization issue
  ring: fix potential sync issue between head and tail values
  config/x86: enable RTE_USE_C11_MEM_MODEL by default

 config/x86/meson.build           |  1 +
 lib/ring/rte_ring_c11_pvt.h      | 29 ++++++++++++++++++-----------
 lib/ring/rte_ring_elem_pvt.h     |  8 ++++++--
 lib/ring/rte_ring_hts_elem_pvt.h | 14 ++++++++++----
 lib/ring/rte_ring_rts_elem_pvt.h | 14 ++++++++++----
 lib/ring/soring.c                |  2 ++
 6 files changed, 47 insertions(+), 21 deletions(-)

-- 
2.43.0

