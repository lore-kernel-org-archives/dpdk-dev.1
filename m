Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23899C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF9D540264;
	Tue,  7 Jul 2026 10:51:18 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3477E4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 10:51:16 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gvZg81cRrzHnH4y;
 Tue,  7 Jul 2026 16:50:12 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 161924058B;
 Tue,  7 Jul 2026 16:51:10 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 10:51:09 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v3 0/8] doc: build for all public headers
Date: Tue, 7 Jul 2026 09:50:38 +0100
Message-ID: <20260707085048.15295-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105256.79904-1-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

It was noticed that not all public headers were included in the doxygen
build, and once built not all files were listed in the index file
serving as a point of entry for the HTML version.

Bruce Richardson provided an idea and a draft implementation of the
configuration-time check, which I optimized to avoid repeat grep calls
and expanded to include indexing check.

After all drivers and public headers were included, multiple small
problems have surfaced fixes for which (with one exception covered by
bug 1962) are also included in this patch set.

v3:
* added fixes for typos in rte_avp_common.h that tripped doxygen 1.9+;
* fixed variable name typo in lib/meson.build introduced in v1;

v2:
* switched from `splitlines()` to `strip('\n').split('\n')` for
  compatibility with older versions of meson;
* rebased on fresh main and updated BPF header links in the index file
  (note: following other examples BPF links are formatted as a sublist);

Marat Khalili (8):
  doc: detect ignored public headers
  doc: document rte_os.h
  doc: fix typos in rte_avp_common.h
  doc: fix typos in rte_bus_pci.h
  doc: fix typos in rte_bus_vmbus.h
  doc: add missing globs to doxy-api.conf.in
  doc: add missing drivers to doxy-api.conf.in
  doc: add missing headers to doxy-api-index.md

 doc/api/doxy-api-index.md         | 120 ++++++++++++++++++++++++++----
 doc/api/doxy-api.conf.in          |  17 ++++-
 drivers/bus/pci/rte_bus_pci.h     |   4 +-
 drivers/bus/vmbus/rte_bus_vmbus.h |  33 ++++----
 drivers/meson.build               |  17 +++++
 drivers/net/avp/rte_avp_common.h  |  10 +--
 lib/eal/include/generic/rte_os.h  |  13 ++++
 lib/meson.build                   |  23 ++++++
 meson.build                       |  19 +++++
 9 files changed, 219 insertions(+), 37 deletions(-)
 create mode 100644 lib/eal/include/generic/rte_os.h

-- 
2.43.0

