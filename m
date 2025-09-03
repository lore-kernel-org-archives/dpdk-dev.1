Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1093CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 11:00:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBCB7402BD;
	Wed,  3 Sep 2025 13:00:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 41F1A40281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 13:00:14 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 138B92045E;
 Wed,  3 Sep 2025 13:00:13 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 3 Sep 2025 13:00:12 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: thomas@monjalon.net,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] maintainers: update for packet buffer library
Date: Wed,  3 Sep 2025 11:00:06 +0000
Message-ID: <20250903110006.44202-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Sep 2025 11:00:12.0916 (UTC)
 FILETIME=[EC124B40:01DC1CC1]
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

Add myself as maintainer for the packet buffer (mbuf) library.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..c64a123e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -429,6 +429,7 @@ F: app/test/test_stack*
 F: doc/guides/prog_guide/stack_lib.rst
 
 Packet buffer
+M: Morten Brørup <mb@smartsharesystems.com>
 F: lib/mbuf/
 F: doc/guides/prog_guide/mbuf_lib.rst
 F: app/test/test_mbuf.c
-- 
2.43.0

