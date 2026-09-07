Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781CAC79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 441D7402E8;
	Mon,  7 Sep 2026 05:48:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B847B402C8;
 Mon,  7 Sep 2026 05:48:40 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6873l5ZE1878773; Sun, 6 Sep 2026 20:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=zCkq71k5LQiPE5pCgAVpz/d
 6B1ZgPrNi4McHg+CIi0I=; b=CL16NPouR1UQZ0jxDzJiqnV13R+sEQ/LcmVKSwt
 dL/kK2mtS8TtRJFcfBAV1IfUayyEz+s32XW33Lw8GHeVjR0vIIuHiiX9eEvsO/ou
 mNY8vvGIlmj7Fy8y/y5K3zfN8g6xKH21/V6TAw1276BZfJ4LYoETjrLxGF68ddUU
 9SCiAZQih3Z6yrsz1pEIf0KHJNpzcVH6FhnzEUPpPVnqKficQbLD5W7wS2UbxUxe
 ASNnEJgNmV7a9A8CFldwsN4/6HDgmj4VQpC7fLwFvuwDlSfqGtgZw0U9r2lyu9rj
 lvzPdXokwdPabHy/h51eVpHzobuwakHn2yUPs7X54BOVCAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ggjkhttx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 06 Sep 2026 20:48:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 20:48:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 20:48:37 -0700
Received: from cavium-System-Product-Name (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 9A5713F70A1;
 Sun,  6 Sep 2026 20:48:34 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 Alexander Kozyrev <akozyrev@nvidia.com>, Adrien Mazarguil
 <adrien.mazarguil@6wind.com>, Olga Shern <olgas@nvidia.com>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] app/testpmd: fix error handling in flow API commands
Date: Mon, 7 Sep 2026 09:18:31 +0530
Message-ID: <20260907034831.791724-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzNiBTYWx0ZWRfX9g6QhbKKb6Fw
 b7dHScrQhmusazco3oMCzydSR1jAae7awMQKL/68UWfhtiSQC4LWUrdpdmzJz10VL8e3HVh/gGP
 hiI/RA621XN28zmUat7Ae7UuMEJMG6xS6fQeHorfrzzUCvAZ00yv1vueNUsUuupWGU2cijDnpAP
 gXzdK0B8FMgBLe+2mgD6UEceBykJYD3IyIqOnws4atxAzD25CETvYbw2pAKYDNoxKO0n1xXi9Q0
 ewA0QoVghMqbLKtioazJ57vMqk9jiCA14P81Kblss/+AaeZjS9IOFp2J3ohJxg4ux2mfVbM6enI
 CTd8HPCO0NVghyVvmUDE69tiSKTmFCyEow6R8Y43GyXVLdxwVpEuD0klnruEPZ93ig55gRdIQXK
 EovEFIFlIG/s/IMVs+st7L0jFMy5hMbCYcwxKoTX1KXjuhvl5+7E4AgpYPo/xaiTdBdL1r8npDp
 KZCRZmAWASwISTk5VTA==
X-Authority-Analysis: v=2.4 cv=NNvlPU6g c=1 sm=1 tr=0 ts=6a9e3416 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=hxAz15p0Q1vmOP2fUDgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: v9Hv5TLxtxSwn2JL6w487j_lZQo3RYR9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzNiBTYWx0ZWRfXw4datNx65bx1
 /uh9v/X+yHh0XSRr0YY0SoVOfv5wtnjpJ08Ng14HzqcdOa5nIFUHKnQXxDnGhJV4F3jc1Cyi4MQ
 Z1tCGseaXZaCWPrnCcC3CG1/2luqhAI=
X-Proofpoint-ORIG-GUID: v9Hv5TLxtxSwn2JL6w487j_lZQo3RYR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

Fix two robustness issues in the flow API command paths:

- port_flow_configure() committed the new queue attributes and job list
  before rte_flow_configure() succeeded, leaving the port state
  inconsistent on failure. Build the job list locally, free it on error,
  and update the port only after configure succeeds.

- port_flow_create() and port_queue_flow_create() indexed ports[port_id]
  without validating the port id. Add an rte_eth_dev_is_valid_port()
  check before accessing the array.

Fixes: 9ad3a41ab2a1 ("app/testpmd: add flow engine configuration")
Fixes: 938a184a1870 ("app/testpmd: implement basic support for flow API")
Fixes: ecdc927b99f2 ("app/testpmd: add async flow create/destroy operations")
Cc: stable@dpdk.org

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
 app/test-pmd/config.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index aa03eb99cc..9d1fa2f4d1 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1844,6 +1844,7 @@ port_flow_configure(portid_t port_id,
 {
 	struct rte_port *port;
 	struct rte_flow_error error;
+	struct queue_job_list *job_list;
 	const struct rte_flow_queue_attr **attr_list =
 	    alloca(sizeof(struct rte_flow_queue_attr *) * nb_queue);
 	int std_queue;
@@ -1852,23 +1853,31 @@ port_flow_configure(portid_t port_id,
 	    port_id == (portid_t)RTE_PORT_ALL)
 		return -EINVAL;
 	port = &ports[port_id];
-	port->queue_nb = nb_queue;
-	port->queue_sz = queue_attr->size;
 	for (std_queue = 0; std_queue < nb_queue; std_queue++)
 		attr_list[std_queue] = queue_attr;
-	free(port->job_list);
-	port->job_list = calloc(nb_queue, sizeof(*port->job_list));
-	if (port->job_list == NULL) {
+
+	/* Build the new job list before touching the device or port state. */
+	job_list = calloc(nb_queue, sizeof(*job_list));
+	if (job_list == NULL) {
 		TESTPMD_LOG(ERR, "Failed to allocate memory for operations tracking on port %u\n",
 			    port_id);
 		return -ENOMEM;
 	}
 	for (unsigned int i = 0; i < nb_queue; i++)
-		LIST_INIT(&port->job_list[i]);
+		LIST_INIT(&job_list[i]);
+
 	/* Poisoning to make sure PMDs update it in case of error. */
 	memset(&error, 0x66, sizeof(error));
-	if (rte_flow_configure(port_id, port_attr, nb_queue, attr_list, &error))
+	if (rte_flow_configure(port_id, port_attr, nb_queue, attr_list, &error)) {
+		free(job_list);
 		return port_flow_complain(&error);
+	}
+
+	/* Commit new state only after configure and allocation succeed. */
+	free(port->job_list);
+	port->job_list = job_list;
+	port->queue_nb = nb_queue;
+	port->queue_sz = queue_attr->size;
 	printf("Configure flows on port %u: "
 	       "number of queues %d with %d elements\n",
 	       port_id, nb_queue, queue_attr->size);
@@ -2881,6 +2890,12 @@ port_queue_flow_create(portid_t port_id, queueid_t queue_id,
 	struct rte_flow_action_age *age = age_action_get(actions);
 	struct queue_job *job;
 
+	if (!rte_eth_dev_is_valid_port(port_id)) {
+		rte_flow_error_set(&error, ENODEV, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				   NULL, rte_strerror(ENODEV));
+		return port_flow_complain(&error);
+	}
+
 	port = &ports[port_id];
 	if (port->flow_list) {
 		if (port->flow_list->id == UINT32_MAX) {
@@ -3858,6 +3873,12 @@ port_flow_create(portid_t port_id,
 	struct port_flow_tunnel *pft = NULL;
 	struct rte_flow_action_age *age = age_action_get(actions);
 
+	if (!rte_eth_dev_is_valid_port(port_id)) {
+		rte_flow_error_set(&error, ENODEV, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				   NULL, rte_strerror(ENODEV));
+		return port_flow_complain(&error);
+	}
+
 	port = &ports[port_id];
 	if (port->flow_list) {
 		if (port->flow_list->id == UINT32_MAX) {
-- 
2.50.1

