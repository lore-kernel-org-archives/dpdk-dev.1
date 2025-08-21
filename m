Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BECA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 14:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EA064042C;
	Thu, 21 Aug 2025 16:26:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2FBF1402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 16:26:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D373520F9F;
 Thu, 21 Aug 2025 16:26:26 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 21 Aug 2025 16:26:26 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v4 0/3] mbuf: simplify handling of reinitialized mbufs
Date: Thu, 21 Aug 2025 14:25:41 +0000
Message-ID: <20250821142544.16211-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Aug 2025 14:26:26.0684 (UTC)
 FILETIME=[940AB3C0:01DC12A7]
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

This series contains three changes:
- sanity checking a reinitialized mbuf (a.k.a. raw mbuf) was de-inlined
- reinitialized mbuf free and alloc bulk functions were promoted as stable
- resetting fields of reinitialized mbufs was simplified, so fields that
  are already reset are not reset again

Morten Brørup (3):
  mbuf: de-inline sanity checking a reinitialized mbuf
  mbuf: promote raw free and alloc bulk functions as stable
  mbuf: no need to reset all fields on reinitialized mbufs

 lib/mbuf/rte_mbuf.c |  61 +++++++++++++++++++
 lib/mbuf/rte_mbuf.h | 141 ++++++++++++++++++++++++++++----------------
 2 files changed, 150 insertions(+), 52 deletions(-)

-- 
2.43.0

