Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE8C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06EBA402B8;
	Wed, 12 Aug 2026 11:53:07 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id AB67C40279
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:53:04 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=d2IyQFoGA7zTYvTNOdVRs3XxiCBIMkFZKa4VNofFuGI=;
 b=ndFV/WnrbToNMhcfwIlI3ppQdwMGlT525R60mUvSivwgvl6h89rFm+7WpvIMHSkT6xZf7F0NJ
 1r0xO8HO29HIhzO2ZjUOGaGeKt3m4pc+RKmMT/8vO9ikUF76ySZWz01DMBP+cnLcghk78NpTUkc
 gLbLyWG05BzGdq8JrUtBlVg=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hKk6l5lhvzLlTg;
 Wed, 12 Aug 2026 17:42:23 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id AFC9E402AB;
 Wed, 12 Aug 2026 17:53:00 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Aug 2026 17:53:00 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v5 0/6] power: uncore power improvements and auto-detection
Date: Wed, 12 Aug 2026 17:49:50 +0800
Message-ID: <20260812094956.3356537-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

- Fix uncore deinitialization for non-legacy modes.
- Enable power QoS for all modes (not just legacy).
- Fix uncore help text and log messages.
- Relocate uncore initialization from arg parsing to init_power_library().
- Support automatic probing of uncore drivers in AUTO_DETECT and delete
  useless code for auto-detection uncore environment.

Note:
There are still some power state rollback issues that haven't been
addressed, but they were originally present and are relatively trivial to
implement. These rollbacks will be handled after this patchset.

---
 v5:
 - Fix some comments from AI in patch 4/6 and 5/6.
 v4 link:
  https://inbox.dpdk.org/dev/20260729025149.2158868-1-lihuisong@huawei.com/

 v4:
 - Fix '!global_uncore_ops' to 'global_uncore_ops == NULL' from AI review.
 v3 link:
  https://inbox.dpdk.org/dev/20260728120208.1858832-1-lihuisong@huawei.com/

 v3:
 - update feature to release_26_11.rst.
 - add a new patch to delte useless for automatic detection environment.
 v2 link:
  https://inbox.dpdk.org/dev/20260526081138.1434947-1-lihuisong@huawei.com/

 v2:
 - Remove the patch which add global uncore init and deinit interface.
 - Remove the last patch in l3fwd-power about these new interface.
   Will send them after this series.
 v1 link:
  https://inbox.dpdk.org/dev/20260512023513.460169-1-lihuisong@huawei.com/

Huisong Li (6):
  examples/l3fwd-power: fix uncore deinit for non-legacy
  examples/l3fwd-power: enable power QoS for all modes
  examples/l3fwd-power: fix uncore help and log info
  examples/l3fwd-power: relocate uncore initialization
  power: support automatic detection of uncore driver
  power: remove unused auto-detection uncore

 doc/guides/rel_notes/release_26_11.rst        |   6 +
 .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
 examples/l3fwd-power/main.c                   | 256 +++++++++---------
 lib/power/rte_power_uncore.c                  |  81 +++---
 4 files changed, 188 insertions(+), 157 deletions(-)

-- 
2.33.0

