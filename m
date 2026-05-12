Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D4CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971FC402C1;
	Tue, 12 May 2026 04:35:18 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 8B9DE40264
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=NEyISZCbHE2kUXaXnNkSVSSlqXCU2KN6UshuPmWavNA=;
 b=HYLUpHcivL9HADXRzAqV8aajdJBGXLAX4GuhLHw6L5jMFp/w8hU+/IY/CyO6FwWTsWS7Zs9nV
 rPSBeEKgytcOztH/IFVVLCYeQDmohOlSc3U0UOxtd5LAx7A4zn3KkhE5vh6VDL0itI/fL6BS6mF
 N6dz+RCJrnLaah9/RDHhWT8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qX2R71z1r0yp;
 Tue, 12 May 2026 10:27:36 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 345AD4056A;
 Tue, 12 May 2026 10:35:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:14 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:14 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 0/7] power: simplify the use of uncore library
Date: Tue, 12 May 2026 10:35:06 +0800
Message-ID: <20260512023513.460169-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Currently, the uncore power library requires user to manually set
environment variables and call rte_power_uncore_init() one by one
in their applications, which is not good to use. Since these steps
are essentially part of the driver initialization, they can be
encapsulated to one interface in uncore core. The uncore core should
be responsiable for detecting and initializing the uncore driver on
the platform.

In order to reach above goal, this series has made the following
changes:
1. Some cleancode and rewrok uncore in l3fwd-power.
2. Add automatic detection of uncore driver to support more uncore
   drivers when application use RTE_UNCORE_PM_ENV_AUTO_DETECT.
3. Introduce new uncore init and deinit API in uncore core.

Note:
1. The patch 5/7 use package-0 and die-0 to probe uncore driver is
   just avoided to break ABI. The good way is to add new probe
   callback in each uncore driver to tell uncore core.
2. We plan that the new uncore init and deinit API will replace the
   rte_power_set/get_uncore_env() and remove them in 26.11 version.

Huisong Li (7):
  examples/l3fwd-power: fix uncore deinit for non-legacy
  examples/l3fwd-power: support to set power QoS on any  mode
  examples/l3fwd-power: fix uncore help and log info
  examples/l3fwd-power: relocate uncore initialization
  power: support automatic detection of uncore driver
  power: add global uncore init and deinit interface
  examples/l3fwd-power: switch to new init/deinit uncore API

 .../sample_app_ug/l3_forward_power_man.rst    |   2 +-
 examples/l3fwd-power/main.c                   | 272 +++++++++---------
 lib/power/rte_power_uncore.c                  | 132 ++++++++-
 lib/power/rte_power_uncore.h                  |  20 ++
 4 files changed, 275 insertions(+), 151 deletions(-)

-- 
2.33.0

