Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE0606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D1241156;
	Fri, 23 Oct 2026 15:44:46 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 456B340695
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:36 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 25848200038;
 Fri, 23 Oct 2026 15:44:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C79B1200031;
 Fri, 23 Oct 2026 15:44:35 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6FF0418000BA;
 Fri, 23 Oct 2026 21:44:34 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 40/65] eventdev: fix port link/unlink callback return
 documentation
Date: Fri, 23 Oct 2026 19:13:20 +0530
Message-ID: <20261023134346.37727-41-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

The eventdev_port_link_t, eventdev_port_link_profile_t,
eventdev_port_unlink_t and eventdev_port_unlink_profile_t PMD callbacks
return the number of links (or unlinks) successfully established, and a
negative value on failure. This matches the rte_event_port_link() and
rte_event_port_unlink() public API contract and the existing driver
implementations.

The Doxygen comments incorrectly stated that these callbacks "Returns 0
on success", which is misleading for PMD authors and inconsistent with
the actual behaviour. Update the documentation to describe the real
return semantics.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 lib/eventdev/eventdev_pmd.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index 9309dce5e1..fcf9b6922d 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2016 Cavium, Inc
+ * Copyright 2026 NXP
  */
 
 #ifndef _RTE_EVENTDEV_PMD_H_
@@ -441,7 +442,7 @@ typedef void (*eventdev_port_quiesce_t)(struct rte_eventdev *dev, void *port,
  *   The number of links to establish
  *
  * @return
- *   Returns 0 on success.
+ *   Number of links successfully established, or a negative value on failure.
  */
 typedef int (*eventdev_port_link_t)(struct rte_eventdev *dev, void *port,
 		const uint8_t queues[], const uint8_t priorities[],
@@ -467,7 +468,7 @@ typedef int (*eventdev_port_link_t)(struct rte_eventdev *dev, void *port,
  *   The profile ID to associate the links.
  *
  * @return
- *   Returns 0 on success.
+ *   Number of links successfully established, or a negative value on failure.
  */
 typedef int (*eventdev_port_link_profile_t)(struct rte_eventdev *dev, void *port,
 					    const uint8_t queues[], const uint8_t priorities[],
@@ -486,7 +487,7 @@ typedef int (*eventdev_port_link_profile_t)(struct rte_eventdev *dev, void *port
  *   The number of unlinks to establish
  *
  * @return
- *   Returns 0 on success.
+ *   Number of unlinks successfully established, or a negative value on failure.
  */
 typedef int (*eventdev_port_unlink_t)(struct rte_eventdev *dev, void *port,
 		uint8_t queues[], uint16_t nb_unlinks);
@@ -507,7 +508,7 @@ typedef int (*eventdev_port_unlink_t)(struct rte_eventdev *dev, void *port,
  *   The profile ID of the associated links.
  *
  * @return
- *   Returns 0 on success.
+ *   Number of unlinks successfully established, or a negative value on failure.
  */
 typedef int (*eventdev_port_unlink_profile_t)(struct rte_eventdev *dev, void *port,
 					      uint8_t queues[], uint16_t nb_unlinks,
-- 
2.43.0

