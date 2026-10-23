Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0D606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D6C427D2;
	Fri, 23 Oct 2026 15:45:16 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 47804427A7
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:45:01 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 277301A000A;
 Fri, 23 Oct 2026 15:45:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE3241A0042;
 Fri, 23 Oct 2026 15:45:00 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E58E81800068;
 Fri, 23 Oct 2026 21:44:59 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 64/65] event/dpaa2: do not fail device creation on DPCI
 errors
Date: Fri, 23 Oct 2026 19:13:44 +0530
Message-ID: <20261023134346.37727-65-prashant.gupta_3@nxp.com>
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

Event device creation aborted entirely whenever a DPCI object could not
be allocated for an event queue, or when any of the parallel, atomic or
ordered link attaches failed. A single failure rolled back every queue
and made dpaa2_eventdev_create() return an error.

This is too strict. The DPNI and DPSEC event adapters can still be
registered and used even when the DPCI-backed event queues are not
available, so a DPCI shortage or attach failure must not bring the whole
event device down.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 68 +++++++++++++---------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 011883bba8..5c36cb9dc9 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -1278,14 +1278,13 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 	struct dpaa2_dpcon_dev *dpcon_dev = NULL;
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
 	struct dpaa2_eventq *evq_info;
-	int ret = 0, i;
+	int ret, i, success;
 
 	eventdev = rte_event_pmd_vdev_init(name,
 		sizeof(struct dpaa2_eventdev), rte_socket_id(), vdev);
 	if (!eventdev) {
-		ret = -ENOMEM;
 		DPAA2_EVENTDEV_ERR("Failed to create Event device %s", name);
-		goto done;
+		return -ENOMEM;
 	}
 
 	eventdev->dev_ops = &dpaa2_eventdev_ops;
@@ -1312,66 +1311,61 @@ dpaa2_eventdev_create(const char *name, struct rte_vdev_device *vdev)
 
 		dpci_dev = rte_dpaa2_alloc_dpci_dev();
 		if (!dpci_dev) {
-			rte_dpaa2_free_dpcon_dev(dpcon_dev);
-			break;
+			DPAA2_EVENTDEV_WARN("No dpci available for evq.%d", i);
+			goto skip_dpci_attach;
 		}
-		evq_info->dpci = dpci_dev;
 
+		success = 0;
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
 			dpaa2_eventdev_process_parallel, DPAA2_QUEUE_NONE_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_PARALLEL]);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR("DPCI attach parallel qp failed: err(%d)", ret);
-			goto err_break;
-		}
+		if (ret)
+			DPAA2_EVENTDEV_WARN("DPCI attach parallel qp failed: err(%d)", ret);
+		else
+			success++;
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
 			dpaa2_eventdev_process_atomic, DPAA2_QUEUE_HOLD_ACTIVE_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ATOMIC]);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR("DPCI attach atomic qp failed: err(%d)", ret);
-			goto err_break;
-		}
+		if (ret)
+			DPAA2_EVENTDEV_WARN("DPCI attach atomic qp failed: err(%d)", ret);
+		else
+			success++;
 
 		ret = rte_dpaa2_dpci_link_attach(dpci_dev, DPCI_DEST_DPCON,
 			dpcon_dev->dpcon_id, 0,
 			dpaa2_eventdev_process_order, DPAA2_QUEUE_LOOSE_ORP_ORDER,
 			&evq_info->dpci_txqs[RTE_SCHED_TYPE_ORDERED]);
-		if (ret) {
-			DPAA2_EVENTDEV_ERR("DPCI attach order qp failed: err(%d)", ret);
-			goto err_break;
-		}
+		if (ret)
+			DPAA2_EVENTDEV_WARN("DPCI attach order qp failed: err(%d)", ret);
+		else
+			success++;
+
+		if (success)
+			evq_info->dpci = dpci_dev;
+		else
+			rte_dpaa2_free_dpci_dev(dpci_dev);
 
+skip_dpci_attach:
 		evq_info->valid = true;
 		evq_info->event_queue_id = priv->max_event_queues;
 
 		priv->max_event_queues++;
-		continue;
-err_break:
-		if (evq_info->dpcon)
-			rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
-		if (evq_info->dpci)
-			rte_dpaa2_free_dpci_dev(evq_info->dpci);
-		break;
 	}
 
 done:
-	if (ret && priv) {
-		for (i = 0; i < priv->max_event_queues; i++) {
-			evq_info = &priv->evq_info[i];
-			if (evq_info->dpcon)
-				rte_dpaa2_free_dpcon_dev(evq_info->dpcon);
-			if (evq_info->dpci)
-				rte_dpaa2_free_dpci_dev(evq_info->dpci);
-		}
-	}
+	ret = 0;
 	event_dev_probing_finish(eventdev);
-	if (ret)
-		DPAA2_EVENTDEV_ERR("Failed(%d) to create event device(%s)", ret, name);
-	else
+	if (priv && !priv->max_event_queues) {
+		ret = -ENODEV;
+		DPAA2_EVENTDEV_ERR("Failed to create event device(%s)", name);
+	} else if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		DPAA2_EVENTDEV_INFO("Create event device(%s)", name);
+	} else {
+		DPAA2_EVENTDEV_INFO("Attach event device(%s)", name);
+	}
 
 	return ret;
 }
-- 
2.43.0

