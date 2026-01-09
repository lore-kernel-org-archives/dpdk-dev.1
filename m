Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE790D26D69
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 15:27:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4228040B90;
	Fri,  9 Jan 2026 16:27:05 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by mails.dpdk.org (Postfix) with ESMTP id CE8F9400D5;
 Fri,  9 Jan 2026 16:27:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCMUCzDWG0rTvad383eKaqC28+CDzuGtmtY4vpK4iddoKd7nds/e126CY8Pvv77cxORsnKoCv76bMTKlqAmQVnCiid++BrcZyCf/XUPEHl5Ng2fUfxid5Qsmfwr4ReSnkQuweP0UgD0KCmKYjC7p/F+hM4F/p9+xRQf6OHY0AgalwTnOBJXNm6ZpOCrRbzfjYD1alhuP8UwYHz3y0+tNBIyACDGi6oXEHhakmt/vxuguinymvcdiVmGOK09Uw0TpO1xq430zb57UFD46T/XfuPd8gdOD3E+kNmNkjMJ4o6ceL8SBupjrU5UCORlNjyQCJcCOxM1jz8CGWCEDBN2bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSvX9v2PPApZPMlNtfaL9eYRSYPbn24hthfegwTyBYY=;
 b=l5yFxMF3YTfPKwwDm8OrXjZT+mXC3ixeGp8np1CPtHA+LkbkRXds3U4dunHtzbUW1sqdv0W4uYZgxNt3EkALaR0OUN6fEgqz8SgxkraK+z3OghWE9lN5HvBng9eGmlxT/z9Jqi8McM+qiDoqgPHegS1QwLsQ9+aS0jBHh+EEGOYW3dtHgTjMpI+vCI0VEYDa1cZ1RNSqm01XqzwvIXnsLJ6vARIohAeoTiHjDIRRUfDwM7KGA9YsUOyqLscwYnLrX0frvdIOsXeDWK36npo0p/ZM67pVlSil2WsaDGrvOtmWP/+DjJJJer+wFF8GquSmJCGzw7CMi1jYGpGuq9iWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSvX9v2PPApZPMlNtfaL9eYRSYPbn24hthfegwTyBYY=;
 b=LZZcYPObm6uBaEPWuFyyd1zafVV5SpFV0JA5QJg+LPlKYEwvEFIdcUCH5/FSOxb5IEFvx1Mv8iEPflONPsYFabWR85oz1cQdRskmE1mEGo5lVw/Sc7aCWkN7WXiE/lVcRaZbY5NMYeP0wm0scGKM2YT9HXEf/xra+pfuA2RHHGvMxouzlHaNdFqANG83TiEwf5yxOn7q4b2WHoaMqcvdwLsh3En/nHZETPttktXJoB8rmSVwdjkGbzgslcSDJNXhPJuvpwVU55ZjMgEKaXrAq2wE45AdE+C/mgqidHM+goYauHfLprljcu94iSvsXRqyjQWqrZyZy+0HA2gwAB0e1g==
Received: from BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 15:26:55 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::2b) by BL1PR13CA0348.outlook.office365.com
 (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via Frontend Transport; Fri, 9
 Jan 2026 15:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 15:26:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:26:42 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 07:26:40 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>
CC: <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH v2] app/testpmd: fix flow queue job leaks
Date: Fri, 9 Jan 2026 16:26:07 +0100
Message-ID: <20260109152607.206389-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118104518.1714166-1-dsosnowski@nvidia.com>
References: <20251118104518.1714166-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 36adf26e-2772-4f69-71e2-08de4f9385be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQ3fSlqr5myc3NTbDITf1kHT6X7QjPi47wTstbRl+SywU7+wqsRRPsKKl5Fl?=
 =?us-ascii?Q?dEkdLpxIFIijWGEJiZqVvSLjPKD/GNxC4IWciMK3WDJUG4rkG61VI550IWWA?=
 =?us-ascii?Q?gfs5IT34TVRJjItookovJxPaz83WfdF50rN/J9CU8LvH3VTy2YPijoCU/AEo?=
 =?us-ascii?Q?vrRi4mILFpmEonVqmGerhDTSmjqqobkiJFl9nxJkeOEZDJP2LOVOL9AO80GW?=
 =?us-ascii?Q?ZjHqMujUxdfQZJC6Y0Mvm1I3hmRxxWh70OFSnZ79VIiWLE3o/bxZpC06n82A?=
 =?us-ascii?Q?G9npqdof2ctZm/1xh/JrzNQqO+O11DDtxcB2z+TZvH07XU8XpLQfuEsDKpL4?=
 =?us-ascii?Q?X/CSFL56sjE4XkjLjFck798s4YF2CiGtd/WIO/3b0KzuZ2v9yAjYZuBb1qpC?=
 =?us-ascii?Q?J8q48mlKRrYsiFE3fMr0I3GuGHuww+XcC92uuXYvt7fV04SxIte+h+Q3Rtly?=
 =?us-ascii?Q?MklnQ86Dj7IJYFRIt+8heZhpxs0wyKoNk2FsYrXwReQx8PKThGW+kBcvYwMJ?=
 =?us-ascii?Q?dCUlRxxrQ/XqT4HYM8TUIUum+qYQSNUiE74DMV08k7QCFF5JbBvqc4iajge5?=
 =?us-ascii?Q?GGI4S/959PnC0m26zMDUD03qH4esEm5Zex27XG480V7ZygtghoUa47VnVF8e?=
 =?us-ascii?Q?sexGV3k9SEpWIZXdtoe62BOui75sDkUiChRnKztG5IthSKlw2e60qrGuu4/q?=
 =?us-ascii?Q?9VH9BKFWoT1kHO90vXHrb3vkgFspdSnFkOyRkKp7Ju8WTLL69dpcxW+Mdwjh?=
 =?us-ascii?Q?6YYRbULGpgir+c/5aeueQJ5/cg/4r2mi24q+PbQss83J31G4EqNGTGsCTqUJ?=
 =?us-ascii?Q?LzBw97ZvCKnmaa4EPXEO21ro+I/lOXMYLeXU855wDIIjnGMR6q8kD6paySPx?=
 =?us-ascii?Q?4BVB87zXu8SJNe0nghRAboCTPy3E/ejG0EwuHBZgPyTudjYbuD1h/AjjSXu8?=
 =?us-ascii?Q?oegD2Kaud7D0GOcsb2MZ6bae2naz3AQ5R7CZCDAxqOHbChkkiyqv8hrEonPh?=
 =?us-ascii?Q?euVnl1YuRNKNlm48tp5YOHXMmvcLqEINqz96+sFigo6sTAuxchLllJJeeSed?=
 =?us-ascii?Q?3JhUMELSw+Yfnwgs/Fqh8G2+fanWYeVLqaDAv6/j/GZ9O1FnqSs3VLLs8rNr?=
 =?us-ascii?Q?n6t3+yaoDDMiXaeXa5cU8KsVsbsRNPZCurAOrdXZ6ELEnFz3Oi1takRiEiq3?=
 =?us-ascii?Q?ytWGwjemuiL7evYI10tbpQme2/4eNXKGBubawd2x40PRTNAsTxUYZGdbol4b?=
 =?us-ascii?Q?EvtsC+S62itIfKL9+U/8QjyfC2pJyS7a9qM3KtSeiLmpAoRDJJEH3eanjGp7?=
 =?us-ascii?Q?+xV8LuvukvwPNgordlf3cYuc3MDUmEPIidoZhS61YtZ0nXlFA0i4DVYz8SID?=
 =?us-ascii?Q?iRvqXEnYQYOUcuhFjqfAV/M0rqSwydHscwgjivhcYLK1W0LSRSMBDjOvHeqo?=
 =?us-ascii?Q?9HR+kxshyt180Q8ymMSEwfJZHBZDQ+6w+Qsak36b+csG6gso9r/BuZfBkgT3?=
 =?us-ascii?Q?Fj9xKKIBkOC3yTVQHRI+wwh5ZKiXfoaW0AjHE+HjB2IGUj5BIL7ahust3W3Y?=
 =?us-ascii?Q?w/3ZsGgktiUiqHWe4+k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:26:55.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36adf26e-2772-4f69-71e2-08de4f9385be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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
v2:
- Bound the cleanup loop's iterations count and
  remove sleeps on empty iterations.
- Add missing return on error handling for rte_flow_push().

 app/test-pmd/config.c  | 180 +++++++++++++++++++++++++++++++++++++++--
 app/test-pmd/testpmd.c |   8 ++
 app/test-pmd/testpmd.h |   4 +
 3 files changed, 185 insertions(+), 7 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 6ea506254b..ac716dd1e9 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -69,6 +69,8 @@

 #define NS_PER_SEC 1E9

+#define FLOW_QUEUE_FLUSH_MAX_ITERS (10)
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
@@ -3960,6 +3999,128 @@ port_flow_update(portid_t port_id, uint32_t rule_id,
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
+	int iterations;
+	int ret;
+
+	port = &ports[port_id];
+
+	printf("Flushing flow queue %u on port %u\n", port_id, queue_id);
+
+	/* Poisoning to make sure PMDs update it in case of error. */
+	memset(&error, 0x44, sizeof(error));
+	if (rte_flow_push(port_id, queue_id, &error))
+		return port_flow_complain(&error);
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
+	iterations = FLOW_QUEUE_FLUSH_MAX_ITERS;
+	while (iterations > 0 && expected_ops > 0) {
+		/* Poisoning to make sure PMDs update it in case of error. */
+		memset(&error, 0x55, sizeof(error));
+		ret = rte_flow_pull(port_id, queue_id, res, expected_ops, &error);
+		if (ret < 0) {
+			port_flow_complain(&error);
+			free(res);
+			return ret;
+		}
+		if (ret == 0) {
+			/* Prevent infinite loop when driver does not return any completion. */
+			iterations--;
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
+	printf("Flushed flow queue %u on port %u (%u failed, %u succeeded).\n",
+	       port_id, queue_id, polled - success, success);
+
+	if (iterations == 0 && expected_ops > 0) {
+		/*
+		 * Driver was not able to return all completions for flow operations in time.
+		 * Log the error and free the queue_job entries to prevent leak.
+		 */
+
+		TESTPMD_LOG(ERR, "Unable to fully flush flow queue %u on port %u (left ops %u)\n",
+			    port_id, queue_id, expected_ops);
+
+		while (!LIST_EMPTY(&port->job_list[queue_id])) {
+			job = LIST_FIRST(&port->job_list[queue_id]);
+			port_free_queue_job(job);
+		}
+
+		return 0;
+	}
+
+	/*
+	 * It is assumed that each enqueued async flow operation
+	 * has a queue_job entry, so if expected_ops reached zero,
+	 * then the queue_job list should be empty.
+	 */
+	RTE_ASSERT(LIST_EMPTY(&port->job_list[queue_id]));
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
@@ -3974,6 +4135,11 @@ port_flow_flush(portid_t port_id)

 	port = &ports[port_id];

+	ret = port_flow_queues_job_flush(port_id);
+	if (ret < 0)
+		TESTPMD_LOG(ERR, "Flushing flows queues failed on port %u (ret %d)\n",
+			    port_id, ret);
+
 	if (port->flow_list == NULL)
 		return ret;

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 1fe41d852a..51ae2fd418 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3275,6 +3275,13 @@ remove_invalid_ports(void)
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
@@ -3285,6 +3292,7 @@ flush_port_owned_resources(portid_t pi)
 	port_flow_actions_template_flush(pi);
 	port_flex_item_flush(pi);
 	port_action_handle_flush(pi);
+	port_free_job_list(pi);
 }

 static void
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 492b5757f1..f319471c73 100644
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
2.47.3

