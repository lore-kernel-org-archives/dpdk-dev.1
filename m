Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C8C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 09:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D8B042D9F;
	Tue, 25 Feb 2025 10:19:35 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id B56FC4281D
 for <dev@dpdk.org>; Tue, 25 Feb 2025 10:19:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z2BpW4qdQz1HM87;
 Tue, 25 Feb 2025 17:17:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2DEB5180044;
 Tue, 25 Feb 2025 17:19:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 17:19:29 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH 0/4] enhance testpmd DCB command
Date: Tue, 25 Feb 2025 17:19:25 +0800
Message-ID: <20250225091929.25072-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This patchset enhance the testpmd DCB command features:
1) remove restrict of number of TCs (currently its 4 or 8)
2) support config prio-tc map
3) support don't adjust queue num
4) support disable DCB

Chengwen Feng (4):
  app/testpmd: remove restrict of number of TCs in DCB command
  app/testpmd: support config prio-tc map in DCB command
  app/testpmd: support don't adjust queue num in DCB command
  app/testpmd: support disable DCB command

 app/test-pmd/cmdline.c                      | 184 ++++++++++++++++++--
 app/test-pmd/testpmd.c                      |  96 ++++++----
 app/test-pmd/testpmd.h                      |   5 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |   6 +-
 4 files changed, 236 insertions(+), 55 deletions(-)

-- 
2.17.1

