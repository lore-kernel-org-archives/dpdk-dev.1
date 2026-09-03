Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF1C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA10402D8;
	Thu,  3 Sep 2026 14:38:28 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 9CCB94028D;
 Thu,  3 Sep 2026 14:38:27 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C750614000D0;
 Thu,  3 Sep 2026 08:38:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Thu, 03 Sep 2026 08:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1788439106; x=1788525506; bh=uW7Xg2dZ6+VVjaZsjICPo
 HBBkps48URcvCVv2bc0Xxg=; b=QBiR/TWFII3tkHXeZWhzYyis/WzQIgK7CIIoR
 0U9+JFo88Fzo0XtrLa4pPrXHQ581vdDwjJmLGcf4YyjMf0XbIECJaqfwmqoJZ9sl
 oc2yWOMWjqAMvvrqM6Ch0dBnk9xawxL2Xb9LnPVqDNHrcAUB6Js/c62BHaqancWZ
 34P3vVlWdbPHe8j2CymPV/eM9y45Hc07G3CUkq3r6BK61zBmu6KF6pNttPoZVTQN
 d8XNVP6UnQxb8oidCxeZEIzFKkIvz1mGHCqUt5jrpH2XV9+f+HvuTZ6Rq5eqEQ8M
 0PW3XPaiVlPgcDpo1hUf53/kXigkzdOVZIGg2twaiKWN0yLtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1788439106; x=1788525506; bh=uW7Xg2dZ6+VVjaZsjICPoHBBkps48URcvCV
 v2bc0Xxg=; b=KdhXvobmh6Wp375Xj+wN7+DQOdqKmDKXJimxxXxmStpmD+UTPyK
 PEifp4t06s5s4bubY9pUHq9frkxtRdxZfHoVjLrgDYBgo6S+e3Ky3ztKgJKiaZ+S
 DpPXJ4UsGHImfuwStyGOVrhjpnc1d0DEA/IOmExRTvEsmy/cyXueDeumz5sUwPj0
 k9Ni7VCxZgqk7iMQKiRAathA/GCNWduekiZWB0dTS35N21J86g2aCsIvLR2xGWZZ
 aU6ZyPTZEmzcxQW9Ma2BLMuVl+5+3LP20d9LcsFnkTE8izAdzNlBx94pUngz+bQg
 nSBMVgHAnD7D2g/0RajL6ptSXKY4BqDg2fQ==
X-ME-Sender: <xms:QmqZausvktIZYnftiJVU015ZpfIjn-mJ7SKm-JlHsOdUelrcTDKYxw>
 <xme:QmqZasbi6_l_XyOyOwHv6DcPoJPMOa4XYHA8jGsDoKmO7OZRJ9vDCqF7JpgkJSzQL
 2eiRPbx1vQ3pV2y_4Ypw_TVyfsv615kkJldpho4t1RwhbvMxHhP0Ts>
X-ME-Received: <xmr:QmqZalW67m_U5ZkdWmap-AvShS7323z2Th5TR8uGc4sGx8-pCYvg609UA4VOXgEBoIsUshHmzS7gBTIL9zQNMiEJZxQTTvA>
X-ME-Proxy-Cause: dmFkZTFpDVNWeuzrMGLpIhYGqRTx4y/COdqVMu7BiwfTkRIpllbclDDc0kfFRaBJLbqR8k
 w3+W/YE18EMBsikVeue1XZLTbaqvx61KRR8Leon41NNs/uVUpftCxTH1ahGxmwJ51CNPzr
 cyvHHPfrp3OrMi1UyLBViyaT6vWuckahl8nwtIrg9widyDePo1tNHXsPcI/X4aA3lcrauF
 Y2nei0GH0ZQKZcoJFHxGAoN5VbJvcjvW4royepsPtmLqbtRkuDsM0xwZ6PjdKecjphkVLL
 H0udHNiTKKtpleyY3UUsIzohHeiNUjlULlnQUFS1ctCZts691gCRZgXbeu/NkXtUzxnfj+
 MmfbpkSP5OpzzJY78rOsb7j2ccgla7/1nyR8cgqrJ6V66Y3p4sYxqyhBxWQn+SyegRFeFj
 ty0r5gO/b7LUDDlU6QaY2BG6qF9FdgPK1gJ0IV+iL6px3YCi1huNm7x1S0FQDKDNFHuAp7
 aaOZoq2we/re2qSpNJxmRXOTBtWVAKGykvzYRzpLsr/LyDMPhYegFx3lMQHBod4NV+xuEv
 MliJe69IZSx+LmbRphL1aw//U2/LqZZn1KxeO/eFnFI1bDNEwuS/JRi8xQOs5ZzQWedC/n
 +whdwzSC0uGmV+Gh4J5mTyulsAIgExPuLjZKWRdXlF8oZ328xSM1/nJtP5EQ
X-ME-Proxy: <xmx:QmqZapT12pe_Cw412z5Qga-Rvm6y1BKC01QsojdnmK-Y1MpEBrY0yw>
 <xmx:QmqZarPiEGZQLzYsdZP7cCbKHFz0_88ZdfEJy9_XqvLjWaMDRKUq1g>
 <xmx:QmqZavTHzrtBAklQv8Ej3UMNEgQU0CKfq146pUaG_2BwolV0hswSsg>
 <xmx:QmqZahgqFhKZ3eURE04vVqTZMDVClBLIxryMrruh3znhqxqO-3vSbA>
 <xmx:QmqZaq3nse3SJy9oMdFX6gHeEM2-g7Nsi24z0kuAJeg3qtjbbwCX17fI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 08:38:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH] doc: fix API comments for Doxygen 1.18.0
Date: Thu,  3 Sep 2026 14:38:17 +0200
Message-ID: <20260903123817.1677020-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After upgrading to Doxygen 1.18.0, there are 2 kinds of errors:

- @ref func() for static function is broken because of parens
- @ref struct.member with anonymous struct/union is broken

Parentheses are removed from inline function references.
The second issue is more difficult and requires to degrade the doc
by providing a global link to the struct page for the fields.

The root causes of these issues can be found in these links:
	https://github.com/doxygen/doxygen/commit/e1bff01
	https://github.com/doxygen/doxygen/issues/12226

Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eventdev/rte_eventdev.h       | 22 +++++++++++-----------
 lib/graph/rte_graph_feature_arc.h |  8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 4e13a38d89..db730131f2 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -744,12 +744,12 @@ enum rte_event_dev_preschedule_type {
 	RTE_EVENT_PRESCHEDULE_NONE,
 	/**< Disable pre-schedule across the event device or on a given event port.
 	 * @ref rte_event_dev_config.preschedule_type
-	 * @ref rte_event_port_preschedule_modify()
+	 * @ref rte_event_port_preschedule_modify
 	 */
 	RTE_EVENT_PRESCHEDULE,
 	/**< Enable pre-schedule always across the event device or a given event port.
 	 * @ref rte_event_dev_config.preschedule_type
-	 * @ref rte_event_port_preschedule_modify()
+	 * @ref rte_event_port_preschedule_modify
 	 * @see RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE
 	 * @see RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE
 	 */
@@ -758,7 +758,7 @@ enum rte_event_dev_preschedule_type {
 	 * Delay issuing pre-schedule until there are no forward progress constraints with
 	 * the held flow contexts.
 	 * @ref rte_event_dev_config.preschedule_type
-	 * @ref rte_event_port_preschedule_modify()
+	 * @ref rte_event_port_preschedule_modify
 	 * @see RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE
 	 * @see RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE
 	 */
@@ -1524,8 +1524,8 @@ struct __rte_aligned(16) rte_event_vector {
  *
  * NOTE:
  *   In restoring event order of forwarded events, the eventdev API guarantees that
- *   all events from the same flow (i.e. same @ref rte_event.flow_id,
- *   @ref rte_event.priority and @ref rte_event.queue_id) will be put in the original
+ *   all events from the same flow (i.e. same @ref rte_event "flow_id",
+ *   @ref rte_event "priority" and @ref rte_event "queue_id") will be put in the original
  *   order before being forwarded to the destination queue.
  *   Some eventdevs may implement stricter ordering to achieve this aim,
  *   for example, restoring the order across *all* flows dequeued from the same ORDERED
@@ -1537,8 +1537,8 @@ struct __rte_aligned(16) rte_event_vector {
 #define RTE_SCHED_TYPE_ATOMIC           1
 /**< Atomic scheduling
  *
- * Events from an atomic flow, identified by a combination of @ref rte_event.flow_id,
- * @ref rte_event.queue_id and @ref rte_event.priority, can be scheduled only to a
+ * Events from an atomic flow, identified by a combination of @ref rte_event "flow_id",
+ * @ref rte_event "queue_id" and @ref rte_event "priority", can be scheduled only to a
  * single port at a time. The port is guaranteed to have exclusive (atomic)
  * access to the associated flow context, which enables the user to avoid SW
  * synchronization. Atomic flows also maintain event ordering
@@ -1618,12 +1618,12 @@ struct __rte_aligned(16) rte_event_vector {
 
 /* Event enqueue operations */
 #define RTE_EVENT_OP_NEW                0
-/**< The @ref rte_event.op field must be set to this operation type to inject a new event,
+/**< The @ref rte_event "op" field must be set to this operation type to inject a new event,
  * i.e. one not previously dequeued, into the event device, to be scheduled
  * for processing.
  */
 #define RTE_EVENT_OP_FORWARD            1
-/**< The application must set the @ref rte_event.op field to this operation type to return a
+/**< The application must set the @ref rte_event "op" field to this operation type to return a
  * previously dequeued event to the event device to be scheduled for further processing.
  *
  * This event *must* be enqueued to the same port that the
@@ -1631,7 +1631,7 @@ struct __rte_aligned(16) rte_event_vector {
  *
  * The event's fields, including (but not limited to) flow_id, scheduling type,
  * destination queue, and event payload e.g. mbuf pointer, may all be updated as
- * desired by the application, but the @ref rte_event.impl_opaque field must
+ * desired by the application, but the @ref rte_event "impl_opaque" field must
  * be kept to the same value as was present when the event was dequeued.
  */
 #define RTE_EVENT_OP_RELEASE            2
@@ -1659,7 +1659,7 @@ struct __rte_aligned(16) rte_event_vector {
  * should be considered filled.
  *
  * Events with this operation type must only be enqueued to the same port that the
- * event to be released was dequeued from. The @ref rte_event.impl_opaque
+ * event to be released was dequeued from. The @ref rte_event "impl_opaque"
  * field in the release event must have the same value as that in the original dequeued event.
  *
  * If a dequeued event is re-enqueued with operation type of @ref RTE_EVENT_OP_RELEASE,
diff --git a/lib/graph/rte_graph_feature_arc.h b/lib/graph/rte_graph_feature_arc.h
index 14f24be831..aa6495c4ad 100644
--- a/lib/graph/rte_graph_feature_arc.h
+++ b/lib/graph/rte_graph_feature_arc.h
@@ -128,7 +128,7 @@ extern "C" {
  * (like VRF table for IP lookup or IPsec SA for inbound policy etc). A
  * reference of allocated resource can be passed from control plane to
  * dataplane via *app_cookie* argument in @ref rte_graph_feature_enable(). A
- * corresponding dataplane API @ref rte_graph_feature_data_app_cookie_get() can
+ * corresponding dataplane API @ref rte_graph_feature_data_app_cookie_get can
  * be used to retrieve same cookie in fast path.
  *
  * When a feature is disabled, resources allocated during feature enable can be
@@ -138,9 +138,9 @@ extern "C" {
  *
  * If current feature node is not consuming packet, it might want to send it to
  * next enabled feature. Depending upon current node is a:
- * - start_node (via @ref rte_graph_feature_data_first_feature_get())
+ * - start_node (via @ref rte_graph_feature_data_first_feature_get)
  * - feature nodes added between start_node and end_node (via @ref
- *   rte_graph_feature_data_next_feature_get())
+ *   rte_graph_feature_data_next_feature_get)
  * - end_feature_node (must not call any feature arc steering APIs) as from
  *   this node packet exits feature arc
  *
@@ -151,7 +151,7 @@ extern "C" {
  *
  * rte_mbuf carries [feature_data] into feature arc specific mbuf dynamic
  * field. See @ref rte_graph_feature_arc_mbuf_dynfields and @ref
- * rte_graph_feature_arc_mbuf_dynfields_get() for more details.
+ * rte_graph_feature_arc_mbuf_dynfields_get for more details.
  *
  * Fast path synchronization
  * -------------------------
-- 
2.55.0

