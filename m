Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A30CCED602
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 10:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98B6140281;
	Tue, 18 Nov 2025 11:45:56 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2381740150;
 Tue, 18 Nov 2025 11:45:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCvLxp+e0y14gjH54dvKW9UfyF5TPfFVGnty57foiIZ5MNXoFFHbMmq7ZM+KbnKYfnJxh+rir/2CyVIaDXGHbk6WKMALIprTooMZCxa5MDQoKYLtrHILZD4u53xzY/5uQPE5OL6r8ufiXhcd7mTzNZkI/ZXboY0IloSB+Gklu88ZQJR9CV16xgXtrg96AhNXoRauLhKOqRFz/cAqi9pqIKJ85JP/n1Ty3wO+Qysbj9zggUn/yihgHQwVS9h/jKIB0YU6BEMhUddg7OIPlHTZ/Q6+2bQ+Wr+b8jxsVht5vljbsP1qS9uflNvpQBZ+jDHB0368CvgYsnTkKUrJkk20DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=datwnI3gg2Ncy1oy4hWfXDCLWJMmP8jkSLZzRKz6+Vg=;
 b=aEP8C2HHIR+i8RosRhvdgLHqZUda5QcjN/lt1kGfRWfKKfdkWK0NYMpCn2gEJebdiphbIBDlXj1jUI5bzsmCf5vnPsbNTPGEP13wDbB3nyuHUqq7o2ZRwesrrNoWUDxySOoZhr9QKwToCTc3wUI55VpWII6qWipMp/ctfXbkGikWbGlJl03DZvzKPncfCsoOYJpoXXfTrRvQDu9lVlrNc7gOlbOEBlR6lQpIBaYGGKTgWpF4Mw2kZSxJZJQSCZPPD4hA0VBHqTEVbtSGAjqL6/fRP9Jzeu5ojvMvrW2YC6UWh2o62Bo7aVWWL5V+fzQ674CaxOsTa1e8m/SSGRsn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=datwnI3gg2Ncy1oy4hWfXDCLWJMmP8jkSLZzRKz6+Vg=;
 b=jwek3mF27IxqGTaW+Dqwcvey69bVmKiMIsuYe4Y56wBGwSg5qDgGx/kxRMl2EJ9l59xkexWvu5zOjkRljrxPLoeGeD2htldb3g6cfXtkO4UpBHDIIWy4mzsHz39MleL2acEq2nYMRyHMddO9dpjygCFwOzeQUWTPwrip3dCRIjjINn18Fw6HzGvSY53VLE+j8L4c+IpPIaaxRQsHGjN9zNS8a4sU1Arae38N+XWptramLsPtPGyE00TNnwA69N22s7ALT+Ia5yqewrkfGOQjAmdLQ3r0Ipv3igOCBI/o4jmOm6OmiAhFleskPTaXqVAaV3lLRWFyzo2YzaX7q+dQqQ==
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:45:48 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::70) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 18 Nov 2025 10:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 10:45:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 02:45:33 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 02:45:31 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] app/testpmd: fix flow queue job leaks
Date: Tue, 18 Nov 2025 11:45:18 +0100
Message-ID: <20251118104518.1714166-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad4ef4b-1d5f-4243-aa35-08de268fa277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wsLgg2m9E1dSuSSgthLBCq5kKk8cWGM9IMs0hGcZsKz3kGQW6VSkvnVeLu/s?=
 =?us-ascii?Q?CNVzGrNeoJ7RP9mTOjOWaxVN5EDUliAINqnu9Mko0nBb/to1GyMA8aThDAXC?=
 =?us-ascii?Q?kFmadXM3+QcNggfFQji1eCeR7ZN5HdinfJCunxrSzhmZRdPdnOLliI0BWpUT?=
 =?us-ascii?Q?qonOx082t7qQEqKqtzhiPA7jQsqyTejOlCVCmKVh6xlOXWxsiCAFWTQISlT6?=
 =?us-ascii?Q?Wn2+IdWiErZa+da1XqUGAWsMNtvi10wjkISIQYik9oW+0tA6DHE/YFBHNg4e?=
 =?us-ascii?Q?8DrNfxHBPN26xXtfHss36xked7X297bJjqD/mrbZTmF5IxG8PorywrKGabmp?=
 =?us-ascii?Q?nxumqDIEHtZurgg2VPDIgXEhe8HLV7OTz9urx2/Jy/yDbdW75zdDslMpdNg4?=
 =?us-ascii?Q?f3Ic/rHJ1cWh+Vu7fGIEyZ+u9WS+HbVEGjLVsH+0ZE/YLDpmVAwD7UoL2VWY?=
 =?us-ascii?Q?dNkpyGiUHliOa4Qp8FEszGbzHpA5nkG99hhkHzflb2KBKkwKpuhHzmbz+b5I?=
 =?us-ascii?Q?/DDvmWO0qdFVQ6PhpnsJ6jtVk9ySpcvkMFMaMt+gvHUlOHctzlOly6NxQ3JU?=
 =?us-ascii?Q?z77xgycCF13dj5xzRqVjplUYzoW7W2AvSiY8g67GasrVb30aon31zwIaVcAL?=
 =?us-ascii?Q?SZuykr3p7F0dRnXsu65xFUd+aiIGeNLfQ4sSnDhBznXxkeEwLnSQsPOokHMZ?=
 =?us-ascii?Q?Viope/rFs8ICI4fGekv79G7eWzaXq2WsucgX2veCWKOntfc3APFPZeQ2fFg5?=
 =?us-ascii?Q?wn+auWDuCE5JjXfzjYq+HNLL4E5Trk4Bj3XxUMLf9GMr+9ePwHz3jI3SpfCG?=
 =?us-ascii?Q?wnqEOyt3cyy4OkrOrX85c6shwYENTlJWNgffp1Zv9HBaf+eZgczBvP1ij+Dy?=
 =?us-ascii?Q?Nguk01QCLIitPGjrl2aOvHSJ7PlslQQDqOO9Sb4ZLoOylmXLLe1S9YENfMGD?=
 =?us-ascii?Q?Gph3WzPNo5BfXGhPYjSk+Nyk7Cd8afFuf061beHOxvG+V4MC1wTF6UpmI4Sp?=
 =?us-ascii?Q?uw7ATvCHgDTxJveL1XSOjiHmXYoc+Y5tAfBYfs5em9+DWVXgnMtlBbynecy4?=
 =?us-ascii?Q?85rvlznAkAXSRDNb38jSbodyMRjYI54l7dcPZIG7J93vLGEb6ZJycA9VsR4t?=
 =?us-ascii?Q?lf7v8I2jIehm5ySZ3lGGXa/W8E19BAxwzHXO1r4uQ1/xBzbVQfJFWUBauuuW?=
 =?us-ascii?Q?AU73tqlsIUyfuuezsOzQpbiauDRwdMY5mg/gbdGAa7uScouS4obMH6/j/m0M?=
 =?us-ascii?Q?n93/DClzBQU/sNf+9ABqu1qDbyhU42zHhSjUUKEMAmRyAOrh0Zghiw3qEH/T?=
 =?us-ascii?Q?yZHwlcU06P5hJjtl2df6bq6JOTWcgNTCGToVdsqQSMVCwQSQeGC4SUL44SeY?=
 =?us-ascii?Q?fSd66AkIyHkq/SQRcMkC9xFMMrRUu6i2ciKykcDX+x/ZATpEEp+SzGdfrWV2?=
 =?us-ascii?Q?XoZMWcJD38KUfrxim16rs6RpzrOHVRo4QKCzDzw+tUIUV2JK4MTGuqFOnBtz?=
 =?us-ascii?Q?IV6T8Ni3mWfRxiDEKO6eYeuyrRyw3l8Dh55plHyl/yYnpjdCy1g7fLEKIH4a?=
 =?us-ascii?Q?srCoKIk4REnpGFQnC2o=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:45:47.9355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad4ef4b-1d5f-4243-aa35-08de268fa277
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

Each enqueued async flow operation in testpmd has an associated
queue_job struct. It is passed in user data and used to determine
the type of operation when operation results are pulled on a given
queue. This information informs the necessary additional handling
(e.g., freeing flow struct or dumping the queried action state).

If async flow operations were enqueued and results were not pulled
before quitting testpmd, these queue_job structs were leaked as reported
by ASAN:

Direct leak of 88 byte(s) in 1 object(s) allocated from:
    #0 0x7f7539084a37 in __interceptor_calloc
        ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x55a872c8e512 in port_queue_flow_create
        (/download/dpdk/install/bin/dpdk-testpmd+0x4cd512)
    #2 0x55a872c28414 in cmd_flow_cb
        (/download/dpdk/install/bin/dpdk-testpmd+0x467414)
    #3 0x55a8734fa6a3 in __cmdline_parse
        (/download/dpdk/install/bin/dpdk-testpmd+0xd396a3)
    #4 0x55a8734f6130 in cmdline_valid_buffer
        (/download/dpdk/install/bin/dpdk-testpmd+0xd35130)
    #5 0x55a873503b4f in rdline_char_in
        (/download/dpdk/install/bin/dpdk-testpmd+0xd42b4f)
    #6 0x55a8734f62ba in cmdline_in
        (/download/dpdk/install/bin/dpdk-testpmd+0xd352ba)
    #7 0x55a8734f65eb in cmdline_interact
        (/download/dpdk/install/bin/dpdk-testpmd+0xd355eb)
    #8 0x55a872c19b8e in prompt
        (/download/dpdk/install/bin/dpdk-testpmd+0x458b8e)
    #9 0x55a872be425a in main
        (/download/dpdk/install/bin/dpdk-testpmd+0x42325a)
    #10 0x7f7538756d8f in __libc_start_call_main
        ../sysdeps/nptl/libc_start_call_main.h:58

This patch addresses that by registering all queue_job structs, for a
given queue, on a linked list. Whenever operation results are pulled
and result is handled, queue_job struct will be removed from that list
and freed.
Before port is closed, during flow flush, testpmd will pull
all of the expected results
(based on the number of queue_job on the list).

Fixes: c9dc03840873 ("ethdev: add indirect action async query")
Fixes: 99231e480b69 ("ethdev: add template table resize")
Fixes: 77e7939acf1f ("app/testpmd: add flow rule update command")
Fixes: 3e3edab530a1 ("ethdev: add flow quota")
Fixes: 966eb55e9a00 ("ethdev: add queue-based API to report aged flow rules")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/config.c  | 160 +++++++++++++++++++++++++++++++++++++++--
 app/test-pmd/testpmd.c |   8 +++
 app/test-pmd/testpmd.h |   4 ++
 3 files changed, 165 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 8557371488..4049bf03c7 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -69,6 +69,8 @@
 
 #define NS_PER_SEC 1E9
 
+#define FLOW_QUEUE_FLUSH_SLEEP_US (100)
+
 static const struct {
 	enum tx_pkt_split split;
 	const char *name;
@@ -1834,6 +1836,14 @@ port_flow_configure(portid_t port_id,
 	port->queue_sz = queue_attr->size;
 	for (std_queue = 0; std_queue < nb_queue; std_queue++)
 		attr_list[std_queue] = queue_attr;
+	port->job_list = calloc(nb_queue, sizeof(*port->job_list));
+	if (port->job_list == NULL) {
+		TESTPMD_LOG(ERR, "Failed to allocate memory for operations tracking on port %u\n",
+			    port_id);
+		return -ENOMEM;
+	}
+	for (unsigned int i = 0; i < nb_queue; i++)
+		LIST_INIT(&port->job_list[i]);
 	/* Poisoning to make sure PMDs update it in case of error. */
 	memset(&error, 0x66, sizeof(error));
 	if (rte_flow_configure(port_id, port_attr, nb_queue, attr_list, &error))
@@ -2938,6 +2948,7 @@ port_queue_flow_create(portid_t port_id, queueid_t queue_id,
 	pf->flow = flow;
 	job->pf = pf;
 	port->flow_list = pf;
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 	printf("Flow rule #%"PRIu64" creation enqueued\n", pf->id);
 	return 0;
 }
@@ -2975,6 +2986,7 @@ port_queue_flow_update_resized(portid_t port_id, queueid_t queue_id,
 		free(job);
 		return port_flow_complain(&error);
 	}
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 	return 0;
 }
 
@@ -3028,6 +3040,7 @@ port_queue_flow_destroy(portid_t port_id, queueid_t queue_id,
 				ret = port_flow_complain(&error);
 				continue;
 			}
+			LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 			printf("Flow rule #%"PRIu64" destruction enqueued\n",
 			       pf->id);
 			*tmp = pf->next;
@@ -3161,6 +3174,7 @@ port_queue_flow_update(portid_t port_id, queueid_t queue_id,
 	uf->flow = pf->flow;
 	*tmp = uf;
 	job->pf = pf;
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 
 	printf("Flow rule #%"PRIu64" update enqueued\n", pf->id);
 	return 0;
@@ -3215,6 +3229,7 @@ port_queue_action_handle_create(portid_t port_id, uint32_t queue_id,
 		free(job);
 		return port_flow_complain(&error);
 	}
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 	printf("Indirect action #%u creation queued\n", pia->id);
 	return 0;
 }
@@ -3276,6 +3291,7 @@ port_queue_action_handle_destroy(portid_t port_id,
 				ret = port_flow_complain(&error);
 				continue;
 			}
+			LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 			*tmp = pia->next;
 			printf("Indirect action #%u destruction queued\n",
 			       pia->id);
@@ -3350,6 +3366,7 @@ port_queue_action_handle_update(portid_t port_id,
 		free(job);
 		return port_flow_complain(&error);
 	}
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 	printf("Indirect action #%u update queued\n", id);
 	return 0;
 }
@@ -3365,8 +3382,11 @@ port_queue_action_handle_query_update(portid_t port_id,
 	struct rte_flow_error error;
 	struct port_indirect_action *pia = action_get_by_id(port_id, id);
 	const struct rte_flow_op_attr attr = { .postpone = postpone};
+	struct rte_port *port;
 	struct queue_job *job;
 
+	port = &ports[port_id];
+
 	if (!pia || !pia->handle)
 		return;
 	job = calloc(1, sizeof(*job));
@@ -3385,6 +3405,7 @@ port_queue_action_handle_query_update(portid_t port_id,
 		port_flow_complain(&error);
 		free(job);
 	} else {
+		LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 		printf("port-%u: indirect action #%u update-and-query queued\n",
 		       port_id, id);
 	}
@@ -3426,6 +3447,7 @@ port_queue_action_handle_query(portid_t port_id,
 		free(job);
 		return port_flow_complain(&error);
 	}
+	LIST_INSERT_HEAD(&port->job_list[queue_id], job, chain);
 	printf("Indirect action #%u update queued\n", id);
 	return 0;
 }
@@ -3541,6 +3563,19 @@ port_flow_hash_calc_encap(portid_t port_id,
 	return 0;
 }
 
+static void
+port_free_queue_job(struct queue_job *job)
+{
+	if (job->type == QUEUE_JOB_TYPE_FLOW_DESTROY ||
+	    job->type == QUEUE_JOB_TYPE_FLOW_UPDATE)
+		free(job->pf);
+	else if (job->type == QUEUE_JOB_TYPE_ACTION_DESTROY)
+		free(job->pia);
+
+	LIST_REMOVE(job, chain);
+	free(job);
+}
+
 /** Pull queue operation results from the queue. */
 static int
 port_queue_aged_flow_destroy(portid_t port_id, queueid_t queue_id,
@@ -3578,6 +3613,8 @@ port_queue_aged_flow_destroy(portid_t port_id, queueid_t queue_id,
 			return ret;
 		}
 		while (success < nb_flows) {
+			struct queue_job *job;
+
 			ret = rte_flow_pull(port_id, queue_id, res,
 					    port->queue_sz, &error);
 			if (ret < 0) {
@@ -3590,6 +3627,13 @@ port_queue_aged_flow_destroy(portid_t port_id, queueid_t queue_id,
 			for (i = 0; i < ret; i++) {
 				if (res[i].status == RTE_FLOW_OP_SUCCESS)
 					success++;
+				job = res[i].user_data;
+				/*
+				 * It is assumed that each enqueued async flow operation
+				 * has a queue_job entry.
+				 */
+				RTE_ASSERT(job != NULL);
+				port_free_queue_job(job);
 			}
 		}
 		rule += n;
@@ -3738,15 +3782,10 @@ port_queue_flow_pull(portid_t port_id, queueid_t queue_id)
 		if (res[i].status == RTE_FLOW_OP_SUCCESS)
 			success++;
 		job = (struct queue_job *)res[i].user_data;
-		if (job->type == QUEUE_JOB_TYPE_FLOW_DESTROY ||
-		    job->type == QUEUE_JOB_TYPE_FLOW_UPDATE)
-			free(job->pf);
-		else if (job->type == QUEUE_JOB_TYPE_ACTION_DESTROY)
-			free(job->pia);
-		else if (job->type == QUEUE_JOB_TYPE_ACTION_QUERY)
+		if (job->type == QUEUE_JOB_TYPE_ACTION_QUERY)
 			port_action_handle_query_dump(port_id, job->pia,
 						      &job->query);
-		free(job);
+		port_free_queue_job(job);
 	}
 	printf("Queue #%u pulled %u operations (%u failed, %u succeeded)\n",
 	       queue_id, ret, ret - success, success);
@@ -3960,6 +3999,108 @@ port_flow_update(portid_t port_id, uint32_t rule_id,
 	return -EINVAL;
 }
 
+static int
+port_flow_queue_job_flush(portid_t port_id, queueid_t queue_id)
+{
+	struct rte_flow_op_result *res;
+	struct rte_flow_error error;
+	unsigned int expected_ops;
+	struct rte_port *port;
+	struct queue_job *job;
+	unsigned int success;
+	unsigned int polled;
+	int ret;
+
+	port = &ports[port_id];
+
+	printf("Flushing flow queue %u on port %u\n", port_id, queue_id);
+
+	/* Poisoning to make sure PMDs update it in case of error. */
+	memset(&error, 0x44, sizeof(error));
+	if (rte_flow_push(port_id, queue_id, &error))
+		port_flow_complain(&error);
+
+	/* Count expected operations. */
+	expected_ops = 0;
+	LIST_FOREACH(job, &port->job_list[queue_id], chain)
+		expected_ops++;
+
+	res = calloc(expected_ops, sizeof(*res));
+	if (res == NULL)
+		return -ENOMEM;
+
+	polled = 0;
+	success = 0;
+	while (expected_ops > 0) {
+		/* Poisoning to make sure PMDs update it in case of error. */
+		memset(&error, 0x55, sizeof(error));
+		ret = rte_flow_pull(port_id, queue_id, res, expected_ops, &error);
+		if (ret < 0) {
+			port_flow_complain(&error);
+			free(res);
+			return ret;
+		}
+		if (ret == 0) {
+			rte_delay_us_sleep(FLOW_QUEUE_FLUSH_SLEEP_US);
+			continue;
+		}
+
+		expected_ops -= ret;
+		polled += ret;
+		for (int i = 0; i < ret; i++) {
+			if (res[i].status == RTE_FLOW_OP_SUCCESS)
+				success++;
+
+			job = (struct queue_job *)res[i].user_data;
+			/*
+			 * It is assumed that each enqueued async flow operation
+			 * has a queue_job entry.
+			 */
+			RTE_ASSERT(job != NULL);
+			port_free_queue_job(job);
+		}
+	}
+	free(res);
+
+	/*
+	 * It is assumed that each enqueued async flow operation
+	 * has a queue_job entry, so if expected_ops reached zero,
+	 * then the queue_job list should be empty.
+	 */
+	RTE_ASSERT(LIST_EMPTY(&port->job_list[queue_id]));
+
+	printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
+	       port_id, queue_id, polled - success, success);
+
+	return 0;
+}
+
+static int
+port_flow_queues_job_flush(portid_t port_id)
+{
+	struct rte_port *port;
+	int ret;
+
+	port = &ports[port_id];
+
+	if (port->queue_nb == 0)
+		return 0;
+
+	for (queueid_t queue_id = 0; queue_id < port->queue_nb; ++queue_id) {
+		if (LIST_EMPTY(&port->job_list[queue_id]))
+			continue;
+
+		ret = port_flow_queue_job_flush(port_id, queue_id);
+		if (ret < 0) {
+			TESTPMD_LOG(ERR, "Flushing flows queue %u failed on port %u (ret %d)\n",
+				    queue_id, port_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /** Remove all flow rules. */
 int
 port_flow_flush(portid_t port_id)
@@ -3974,6 +4115,11 @@ port_flow_flush(portid_t port_id)
 
 	port = &ports[port_id];
 
+	ret = port_flow_queues_job_flush(port_id);
+	if (ret < 0)
+		TESTPMD_LOG(ERR, "Flushing flows queues failed on port %u (ret %d)\n",
+			    port_id, ret);
+
 	if (port->flow_list == NULL)
 		return ret;
 
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b10f6baee2..789f123c6a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3260,6 +3260,13 @@ remove_invalid_ports(void)
 	nb_cfg_ports = nb_fwd_ports;
 }
 
+static void
+port_free_job_list(portid_t pi)
+{
+	struct rte_port *port = &ports[pi];
+	free(port->job_list);
+}
+
 static void
 flush_port_owned_resources(portid_t pi)
 {
@@ -3270,6 +3277,7 @@ flush_port_owned_resources(portid_t pi)
 	port_flow_actions_template_flush(pi);
 	port_flex_item_flush(pi);
 	port_action_handle_flush(pi);
+	port_free_job_list(pi);
 }
 
 static void
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index fa46865c67..2fed7b9e7d 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -280,6 +280,7 @@ union port_action_query {
 
 /* Descriptor for queue job. */
 struct queue_job {
+	LIST_ENTRY(queue_job) chain;
 	uint32_t type; /**< Job type. */
 	union {
 		struct port_flow *pf;
@@ -288,6 +289,8 @@ struct queue_job {
 	union port_action_query query;
 };
 
+LIST_HEAD(queue_job_list, queue_job);
+
 struct port_flow_tunnel {
 	LIST_ENTRY(port_flow_tunnel) chain;
 	struct rte_flow_action *pmd_actions;
@@ -369,6 +372,7 @@ struct rte_port {
 	struct port_flow        *flow_list; /**< Associated flows. */
 	struct port_indirect_action *actions_list;
 	/**< Associated indirect actions. */
+	struct queue_job_list *job_list; /**< Pending async flow API operations, per queue. */
 	LIST_HEAD(, port_flow_tunnel) flow_tunnel_list;
 	const struct rte_eth_rxtx_callback *rx_dump_cb[RTE_MAX_QUEUES_PER_PORT+1];
 	const struct rte_eth_rxtx_callback *tx_dump_cb[RTE_MAX_QUEUES_PER_PORT+1];
-- 
2.39.5

