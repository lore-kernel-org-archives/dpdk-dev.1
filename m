Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF912C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E92C40A87;
	Mon,  6 Jul 2026 12:53:40 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 336354068E
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:53:35 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv1Qn53QtzJ46BB;
 Mon,  6 Jul 2026 18:52:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 1305E40584;
 Mon,  6 Jul 2026 18:53:30 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 12:53:29 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v2 0/7] doc: build for all public headers
Date: Mon, 6 Jul 2026 11:52:48 +0100
Message-ID: <20260706105256.79904-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702200050.88710-1-marat.khalili@huawei.com>
References: <20260702200050.88710-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
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

v2:
* switched from `splitlines()` to `strip('\n').split('\n')` for
  compatibility with older versions of meson;
* rebased on fresh main and updated BPF header links in the index file;

Marat Khalili (7):
  doc: detect ignored public headers
  doc: document rte_os.h
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
 lib/eal/include/generic/rte_os.h  |  13 ++++
 lib/meson.build                   |  23 ++++++
 meson.build                       |  19 +++++
 8 files changed, 214 insertions(+), 32 deletions(-)
 create mode 100644 lib/eal/include/generic/rte_os.h

-- 
2.43.0

