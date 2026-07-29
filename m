Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD5C54F55
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FB6D40609;
	Wed, 29 Jul 2026 04:54:55 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id B336240272
 for <dev@dpdk.org>; Wed, 29 Jul 2026 04:54:50 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=cfqcZfaCJ3o0YawB4NhS3ISgUTrGB2HAfJ28Jd1Ki0w=;
 b=dC4mCWZqhcRSa8MQH+zid+NdNYttb3J6OO4SWTRhF7N4NsV8ATiP2FkLp+g4pkEBIdpqoVY/m
 lc8iLYQMdWt670VbWZZxkV6/KKG/zPh4DQyDEx9yvM51R+EX9Oc5CUtPJ66G7X34sv6cRi5FyFV
 zAzQqsbSVR+WnO9IaHUekCI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h8xWw1snDz1prNF;
 Wed, 29 Jul 2026 10:45:16 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 2A26440561;
 Wed, 29 Jul 2026 10:54:45 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Jul 2026 10:54:44 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v4 0/6] power: uncore power improvements and auto-detection
Date: Wed, 29 Jul 2026 10:51:43 +0800
Message-ID: <20260729025149.2158868-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

This series improves the uncore power management in l3fwd-power
and adds automatic detection of uncore drivers in the power library.

- Fix uncore deinitialization for non-legacy modes.
- Enable power QoS for all modes (not just legacy).
- Fix uncore help text and log messages.
- Relocate uncore initialization from arg parsing to init_power_library().
- Support automatic probing of uncore drivers in AUTO_DETECT and delete
  useless code for auto-detection uncore environment.

---
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
 lib/power/rte_power_uncore.c                  |  78 +++---
 4 files changed, 185 insertions(+), 157 deletions(-)

-- 
2.33.0

