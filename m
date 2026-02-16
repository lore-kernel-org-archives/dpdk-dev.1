Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53DE81A36
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 15:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E008240289;
	Mon, 16 Feb 2026 16:23:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5A72D40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 16:23:23 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 132EF20FCA;
 Mon, 16 Feb 2026 16:23:23 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 16 Feb 2026 16:23:22 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v3 0/2] mempool: de-inline get/put unlikely code paths
Date: Mon, 16 Feb 2026 15:23:18 +0000
Message-ID: <20260216152320.105312-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216115813.103515-1-mb@smartsharesystems.com>
References: <20260216115813.103515-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Feb 2026 15:23:22.0538 (UTC)
 FILETIME=[2FFDE8A0:01DC9F58]
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

De-inline unlikely code paths, for smaller footprint.

Morten Brørup (2):
  mempool: simplify get objects
  mempool: de-inline get/put unlikely code paths

 lib/mempool/rte_mempool.c | 112 ++++++++++++++++++
 lib/mempool/rte_mempool.h | 239 ++++++++++++++++++--------------------
 2 files changed, 227 insertions(+), 124 deletions(-)

-- 
2.43.0

