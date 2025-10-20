Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1ECCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0223C40E18;
	Mon, 20 Oct 2025 18:36:49 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 26882406A2
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023097.outbound.protection.outlook.com [40.107.159.97])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xotnyLOa8QFoX24VAGWoMdQiC0fXddn/pCa3y8WQyPrNXeFLn8k2iwfrrF2v3r1QkOBVjmz+gJmh+eJFjgABlMZk/G7UUCoYWLCFJskZJSU8f7cpXdTNInPHhic7RqVg//uTv5+xsJn8FC/n38UMo4JE8esIqMkbtOubCQAGuo9XOZkRmpsLDCHTAMdc6jtXhfH046m26chNuZzwE2NmlED/TUbZ2RCf3QWZdkpTI+Iik+G5A4ulOy6uYLoT/YYRJFfMmsZsdR0j38bbtvyEiguI7SC0xc1q8MXYJbVjhjvtOaBlekHvXCL+MyVsixuxxdXFgEMXJ92BtRp15Zd9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uabxCkQ+2lapaaAvscqq+uG3y+Rff60BbjbE7oJRzI=;
 b=t+cUCDTNF9P5OESAqRVsz6vnL/8WAUCNQp8u34RIiXONk4qIiaQ+cmYgXzp3Q/RGeLppYYK+zT7MSUIHtt9NXEy/bLvVnIjYofN+Dt0dPXzv5ChqrrToedMMOAmbNV7iUDhnqMZipDHjz0s37qTARBSVaG/PXD8djC7xKB1FnZaVkWJXV/u4KTZrTVAAuS7aeH9ozQ6FvczPX5KaxcOSpgNQVAYPFcwJl44TcUijovg80pg/puIZFytUntCgnINW1ZaOjqSQVUL4Ro10Ynpfi9lYS5XlIfvyRkVWtLP3N2RbGlcGY7O9MWyZEj176eKCL4YN8t0HoEO/DVexXVkzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uabxCkQ+2lapaaAvscqq+uG3y+Rff60BbjbE7oJRzI=;
 b=VNzr6UF3HpCuaSTzLye9yyxPn5YIYHcnbpxNsnpkq64wqkT/TiGaSKlezl+1YRVJFwiuPAem7SQNRRin6G2PntH7nIj3fbUtvBpXSCr4VQrVCAJF06sKJ0VdWba3cF9HK8NFfYqF2whn2hC7B8emz/I5Qtd92EHmH5rQZl3N0uw=
Received: from AS4P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::16)
 by VI1P190MB0590.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:123::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:36 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::2c) by AS4P191CA0030.outlook.office365.com
 (2603:10a6:20b:5d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:36
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 13/24] net/ntnic: modify prefix flow with prefix nthw
Date: Mon, 20 Oct 2025 18:36:04 +0200
Message-ID: <20251020163620.282312-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI1P190MB0590:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 175d5492-f2a7-4c5d-86fa-08de0ff6d626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpTWep/59jKNFNe3aKYvPELlF0u/Nau/BjFzItQnvW8v0++w2013418vByh2?=
 =?us-ascii?Q?W+Euqmr19d1pi9PP4qRuo0kH2vg8H8VFr30GxxEB+XlY0z1bkc8ESOXkKJSK?=
 =?us-ascii?Q?kLK7e6+sVE+COsTjG7F18LWJDbLAgeCxPmV4KSMgpk9p/MAZ1I/kEOYZQR7r?=
 =?us-ascii?Q?afznjgiu7l0LAFvyx999PYuHjFk4i6EuNVr7gr6fr/9NJXNTE+52mDIjRZV5?=
 =?us-ascii?Q?/Ewh0A7Ce4cH9ac128LbM+DBgc1jYPSbmMTzcP/Uupgz2VToxXOrUoi6lWsv?=
 =?us-ascii?Q?hcrtPF2m+4KVq9hFYh7F8r07x8qSVL6ZDYAvXokCjGtcBweT0Y2/XwU/tYxI?=
 =?us-ascii?Q?ZerL0H3v1Et+H5ZXthryamAyz9l6oPEh4IDFAWekGo04OgZ6NguD0VWGoTX4?=
 =?us-ascii?Q?QqftAGWL5uWKAgUmNcrVZYAHrOZJwfmpwFRuq6WENa75MEFYC86KN9NLEq5Q?=
 =?us-ascii?Q?225ZkSvU4+e7Tb3I+W+G9DprxPFG+zLNfOTnWfvh/ZUHfh7j5O2NW3IJcVWY?=
 =?us-ascii?Q?4D6TUrPTDl+4hJMIbJipsUwyqpiYNpu76RLoXiHgqtPwvhu5oPka+uSuq80L?=
 =?us-ascii?Q?jqDgQGqD/w//AlD93P10rHov1MZarbGfxW3g1tD9D0bQIea5tN+1HpLZ58gT?=
 =?us-ascii?Q?arGtmbR/NpKYmUZhPsj9nZEfBtn9o7yobmlALFxsiw85w3cGPuq/SdzCUUt2?=
 =?us-ascii?Q?xsivuvnaUZyIRsMRz/UIR6vemSAZHRmf/kNAq3CJpFlieZ/itesurLlW6C67?=
 =?us-ascii?Q?QZanNZvuyrgAZaL6ZWlV8vnHNuIudDWDIccArhNsIs96WocRZ6pnn9iNIt3b?=
 =?us-ascii?Q?+5XTkzlaJQLGNJQ/m58Zim0x7uzqWVumxyzCq3MJEsLhzCxTk1x/xNis64Nl?=
 =?us-ascii?Q?4Z76yOXbOn/fVGGyVZAPKCkolNNFeY9d5NrMPg0WZ0JNBONRAcesxjsCTkB1?=
 =?us-ascii?Q?/o6Cin7i88TxWJaA0vpFd8zNOEl5Kap85flRA3HcBTLUrv2UAE6fR7McUIKb?=
 =?us-ascii?Q?U39ILpbd2Ir5SCf+Ku1OW+aUFkGU6kaad2Hyfp6CaDEwzFSrw6rJY2+WHsea?=
 =?us-ascii?Q?TKhh1fQFOwP/CaZtyI2YnfYOYu5ey4Qp8W2biyOviMyi0gXg4WwVnytYR6q5?=
 =?us-ascii?Q?mdHgTQC0vDegWaMP5FBmRVUsbKV+SYn03F+kW+AvdjdUykCp0t6+4Xhf6NQj?=
 =?us-ascii?Q?dzVIUZrE6Zc75b2GccwnByXLDgknm1iFnMDp5juFDPFZuaYzmx1aksr760hi?=
 =?us-ascii?Q?Mj0W/m3+sstuEZ1fwnJiMHWFC+DgPFcHJ/Gz6cuwLMvElEEKATCOJqYSOE0i?=
 =?us-ascii?Q?q2R4N/XzuyMlW4vf1pCNkpu586/WrzX85T6YMUqB+rOACq0IP0guoHNy2crV?=
 =?us-ascii?Q?fjbtYGA7AUa1QkfmW/LBJArJaHQskyiekCJ+YmziAxwfGP4uQaw3aqZjmagi?=
 =?us-ascii?Q?mLWYRSinA+tnWJ7RD32jr2HCoTr2uZPZl96Baz3/7k/zQgHyKSoSXfue5LBg?=
 =?us-ascii?Q?cZBrv9Qrwitpr4uYU26lMnuRpuvTTHaIBkrYA6XkBCcyInPZKfm8/2nAtSUW?=
 =?us-ascii?Q?N6nIYsECL0k1EfXzk6c=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t7MVp0jUNT9NOiMXzoMVnMzf7wW9tzMywp+9TqcUau/OJVqnquqfz1mUXJKLfyAfF6ytwCnYTzMXEGMiqFLrvPcopUtlX/G8lHyPXFhmecjk/2+2jVzJseeJOUnWsPyIenRBUDc6AB61JHRtVeJ6kU3eyt2f1Z2eQdX1HIplK+t1RZ4YEOLLcrJjfqKPqYOBOGZarGPxLmWxXGG6ew/hM41vZyjXxznereFIBax9NrqVoXt9Pp6ooYre/+JoOaKSZYjUXSUdBvN8SWOyiOfXkbl1eeqX4i6b1M9ex/wmDFyBW2u6MsNEZTpQ8GsCzQ4V03uc2eYzbTtt3BKgQfVaPReTmrv08lEoowpvsW4XVHYSgxpsPewxL/Ozi7+w6ZTnmmrVlhCA2t1fVYZtvpWTHQP0qkvJ9DGlAZwNUguZO8yQRJFYzF1uPD7R6dwAdD9BBHiOkDWyg2OrGJqahjnScHnzjOoBmyR+Eyb3+viieSFYNFdIDehRiwsXIRsfmnScADhyNymRrtGJHDq4hB/os64+RNk69j5MbsXW3LKKuV+yCxrhQvHetlS19yN2xOn2+IZHn46bZcHVAV87eMAUaFI24gURqBMmuNAwOM3xDYcePrRl+E9bjPWsA9XmqTIB4KGyBQyxvWZelZ9Uwro/Wg5wr40poAWT0E+nku1ONP0=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:36.1316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175d5492-f2a7-4c5d-86fa-08de0ff6d626
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0590
X-BESS-ID: 1760978198-311284-32701-8204-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.97
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYW5sYWQGYGUNTSJM3UPMkkJd
 U0xcjA0tjIxMTY3NDC0NAi1SDNxCDFQqk2FgBDLEf9QgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan9-254.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Change the prefix flow_ with prefix nthw_flow to specify that the flow API
belongs to the Napatech hardware (nthw).

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  54 +++++----
 .../nthw/flow_api/flow_backend/flow_backend.c |   4 +-
 .../profile_inline/flow_api_profile_inline.c  | 113 +++++++++---------
 .../profile_inline/flow_api_profile_inline.h  |  49 ++++----
 drivers/net/ntnic/ntnic_ethdev.c              |   2 +-
 drivers/net/ntnic/ntnic_mod_reg.c             |   2 +-
 drivers/net/ntnic/ntnic_mod_reg.h             |  46 +++----
 7 files changed, 141 insertions(+), 129 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index dd25b51e14..4c7bb4a60a 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -299,7 +299,7 @@ static struct flow_handle *flow_create(struct flow_eth_dev *dev __rte_unused,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_create_profile_inline(dev, attr,
+	return profile_inline_ops->nthw_flow_create_profile_inline(dev, attr,
 		forced_vlan_vid, caller_id,  item, action, error);
 }
 
@@ -313,7 +313,7 @@ static int flow_destroy(struct flow_eth_dev *dev __rte_unused,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_destroy_profile_inline(dev, flow, error);
+	return profile_inline_ops->nthw_flow_destroy_profile_inline(dev, flow, error);
 }
 
 static int flow_flush(struct flow_eth_dev *dev, uint16_t caller_id, struct rte_flow_error *error)
@@ -325,7 +325,7 @@ static int flow_flush(struct flow_eth_dev *dev, uint16_t caller_id, struct rte_f
 		return -1;
 	}
 
-	return profile_inline_ops->flow_flush_profile_inline(dev, caller_id, error);
+	return profile_inline_ops->nthw_flow_flush_profile_inline(dev, caller_id, error);
 }
 
 static int flow_actions_update(struct flow_eth_dev *dev,
@@ -340,7 +340,8 @@ static int flow_actions_update(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_actions_update_profile_inline(dev, flow, action, error);
+	return profile_inline_ops->nthw_flow_actions_update_profile_inline(dev,
+		flow, action, error);
 }
 
 /*
@@ -405,7 +406,7 @@ static int nthw_flow_delete_eth_dev(struct flow_eth_dev *eth_dev)
 	while (flow) {
 		if (flow->dev == eth_dev) {
 			struct flow_handle *flow_next = flow->next;
-			profile_inline_ops->flow_destroy_locked_profile_inline(eth_dev, flow,
+			profile_inline_ops->nthw_flow_destroy_locked_profile_inline(eth_dev, flow,
 				NULL);
 			flow = flow_next;
 
@@ -471,11 +472,11 @@ static void flow_ndev_reset(struct flow_nic_dev *ndev)
 			"ERROR : Flows still defined but all eth-ports deleted. Flow %p",
 			ndev->flow_base);
 
-		profile_inline_ops->flow_destroy_profile_inline(ndev->flow_base->dev,
+		profile_inline_ops->nthw_flow_destroy_profile_inline(ndev->flow_base->dev,
 			ndev->flow_base, NULL);
 	}
 
-	profile_inline_ops->done_flow_management_of_ndev_profile_inline(ndev);
+	profile_inline_ops->nthw_done_flow_mgmnt_of_ndev_profile_inline(ndev);
 
 	km_free_ndev_resource_management(&ndev->km_res_handle);
 	kcc_free_ndev_resource_management(&ndev->kcc_res_handle);
@@ -656,7 +657,7 @@ static struct flow_eth_dev *flow_get_eth_dev(uint8_t adapter_no, uint8_t port_no
 
 		/* Initialize modules if needed - recipe 0 is used as no-match and must be setup */
 		if (profile_inline_ops != NULL &&
-			profile_inline_ops->initialize_flow_management_of_ndev_profile_inline(ndev))
+			profile_inline_ops->nthw_init_flow_mgmnt_of_ndev_profile_inline(ndev))
 			goto err_exit0;
 
 	} else {
@@ -1021,7 +1022,8 @@ static int flow_dev_dump(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_dev_dump_profile_inline(dev, flow, caller_id, file, error);
+	return profile_inline_ops->nthw_flow_dev_dump_profile_inline(dev,
+		flow, caller_id, file, error);
 }
 
 static int flow_get_aged_flows(struct flow_eth_dev *dev,
@@ -1043,7 +1045,7 @@ static int flow_get_aged_flows(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_get_aged_flows_profile_inline(dev, caller_id, context,
+	return profile_inline_ops->nthw_flow_get_aged_flows_profile_inline(dev, caller_id, context,
 			nb_contexts, error);
 }
 
@@ -1058,7 +1060,7 @@ static int flow_info_get(struct flow_eth_dev *dev, uint8_t caller_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_info_get_profile_inline(dev, caller_id, port_info,
+	return profile_inline_ops->nthw_flow_info_get_profile_inline(dev, caller_id, port_info,
 			queue_info, error);
 }
 
@@ -1073,7 +1075,7 @@ static int flow_configure(struct flow_eth_dev *dev, uint8_t caller_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_configure_profile_inline(dev, caller_id, port_attr,
+	return profile_inline_ops->nthw_flow_configure_profile_inline(dev, caller_id, port_attr,
 			nb_queue, queue_attr, error);
 }
 
@@ -1093,8 +1095,8 @@ flow_pattern_template_create(struct flow_eth_dev *dev,
 			return NULL;
 	}
 
-	return profile_inline_ops->flow_pattern_template_create_profile_inline(dev, template_attr,
-		caller_id, pattern, error);
+	return profile_inline_ops->nthw_flow_pattern_template_create_profile_inline(dev,
+		template_attr, caller_id, pattern, error);
 }
 
 static int flow_pattern_template_destroy(struct flow_eth_dev *dev,
@@ -1108,7 +1110,7 @@ static int flow_pattern_template_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_pattern_template_destroy_profile_inline(dev,
+	return profile_inline_ops->nthw_flow_pattern_template_destroy_profile_inline(dev,
 			pattern_template,
 			error);
 }
@@ -1126,8 +1128,8 @@ flow_actions_template_create(struct flow_eth_dev *dev,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_actions_template_create_profile_inline(dev, template_attr,
-		caller_id, actions, masks, error);
+	return profile_inline_ops->nthw_flow_actions_template_create_profile_inline(dev,
+		template_attr, caller_id, actions, masks, error);
 }
 
 static int flow_actions_template_destroy(struct flow_eth_dev *dev,
@@ -1141,7 +1143,7 @@ static int flow_actions_template_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_actions_template_destroy_profile_inline(dev,
+	return profile_inline_ops->nthw_flow_actions_template_destroy_profile_inline(dev,
 			actions_template,
 			error);
 }
@@ -1159,7 +1161,7 @@ static struct flow_template_table *flow_template_table_create(struct flow_eth_de
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_template_table_create_profile_inline(dev, table_attr,
+	return profile_inline_ops->nthw_flow_template_table_create_profile_inline(dev, table_attr,
 		forced_vlan_vid, caller_id, pattern_templates, nb_pattern_templates,
 		actions_templates, nb_actions_templates, error);
 }
@@ -1175,8 +1177,8 @@ static int flow_template_table_destroy(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_template_table_destroy_profile_inline(dev, template_table,
-			error);
+	return profile_inline_ops->nthw_flow_template_table_destroy_profile_inline(dev,
+		template_table, error);
 }
 
 static struct flow_handle *
@@ -1193,7 +1195,7 @@ flow_async_create(struct flow_eth_dev *dev, uint32_t queue_id,
 		return NULL;
 	}
 
-	return profile_inline_ops->flow_async_create_profile_inline(dev, queue_id, op_attr,
+	return profile_inline_ops->nthw_flow_async_create_profile_inline(dev, queue_id, op_attr,
 			template_table, pattern, pattern_template_index, actions,
 			actions_template_index, user_data, error);
 }
@@ -1209,8 +1211,8 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 		return -1;
 	}
 
-	return profile_inline_ops->flow_async_destroy_profile_inline(dev, queue_id, op_attr, flow,
-			user_data, error);
+	return profile_inline_ops->nthw_flow_async_destroy_profile_inline(dev, queue_id,
+		op_attr, flow, user_data, error);
 }
 int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
@@ -1220,7 +1222,7 @@ int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t
 		return -1;
 
 	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE)
-		return profile_inline_ops->flow_get_flm_stats_profile_inline(ndev, data, size);
+		return profile_inline_ops->nthw_flow_get_flm_stats_profile_inline(ndev, data, size);
 
 	return -1;
 }
@@ -1233,7 +1235,7 @@ int nthw_flow_get_ifr_stats(struct flow_nic_dev *ndev, uint64_t *data, uint8_t p
 		return -1;
 
 	if (ndev->flow_profile == FLOW_ETH_DEV_PROFILE_INLINE) {
-		return profile_inline_ops->flow_get_ifr_stats_profile_inline(ndev, data,
+		return profile_inline_ops->nthw_flow_get_ifr_stats_profile_inline(ndev, data,
 				port_count);
 	}
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index cb6489b3ac..8144e25540 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -1972,7 +1972,7 @@ static int free_rx_queue(void *be_dev, int hw_queue)
 	return 0;
 }
 
-const struct flow_api_backend_ops flow_be_iface = {
+const struct flow_api_backend_ops nthw_flow_be_iface = {
 	1,
 
 	set_debug_mode,
@@ -2248,7 +2248,7 @@ const struct flow_api_backend_ops *nthw_bin_flow_backend_init(nthw_fpga_t *p_fpg
 	be_devs[physical_adapter_no].adapter_no = physical_adapter_no;
 	*dev = (void *)&be_devs[physical_adapter_no];
 
-	return &flow_be_iface;
+	return &nthw_flow_be_iface;
 }
 
 static void bin_flow_backend_done(void *dev)
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 71b9bcd3d7..32aae24499 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3898,7 +3898,7 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
  * Public functions
  */
 
-int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
+int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 {
 	if (!ndev->flow_mgnt_prepared) {
 		/* Check static arrays are big enough */
@@ -4086,11 +4086,11 @@ int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 	return 0;
 
 err_exit0:
-	done_flow_management_of_ndev_profile_inline(ndev);
+	nthw_done_flow_mgmnt_of_ndev_profile_inline(ndev);
 	return -1;
 }
 
-int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
+int nthw_done_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 {
 #ifdef FLOW_DEBUG
 	ndev->be.iface->set_debug_mode(ndev->be.be_dev, FLOW_BACKEND_DEBUG_MODE_WRITE);
@@ -4166,7 +4166,7 @@ int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 	return 0;
 }
 
-struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_unused,
+struct flow_handle *nthw_flow_create_profile_inline(struct flow_eth_dev *dev __rte_unused,
 	const struct rte_flow_attr *attr __rte_unused,
 	uint16_t forced_vlan_vid __rte_unused,
 	uint16_t caller_id __rte_unused,
@@ -4266,7 +4266,7 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev __rte_un
 	return NULL;
 }
 
-int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *fh,
 	struct rte_flow_error *error)
 {
@@ -4332,27 +4332,27 @@ int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-int flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *flow,
+int nthw_flow_destroy_profile_inline(struct flow_eth_dev *dev, struct flow_handle *flow,
 	struct rte_flow_error *error)
 {
 	int err = 0;
 
 	if (flow && flow->type == FLOW_HANDLE_TYPE_FLM && flow->flm_async)
-		return flow_async_destroy_profile_inline(dev, 0, NULL, flow, NULL, error);
+		return nthw_flow_async_destroy_profile_inline(dev, 0, NULL, flow, NULL, error);
 
 	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
 	if (flow) {
 		/* Delete this flow */
 		rte_spinlock_lock(&dev->ndev->mtx);
-		err = flow_destroy_locked_profile_inline(dev, flow, error);
+		err = nthw_flow_destroy_locked_profile_inline(dev, flow, error);
 		rte_spinlock_unlock(&dev->ndev->mtx);
 	}
 
 	return err;
 }
 
-int flow_flush_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_flush_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	struct rte_flow_error *error)
 {
@@ -4369,7 +4369,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	while (flow && !err) {
 		if (flow->dev == dev && flow->caller_id == caller_id) {
 			struct flow_handle *flow_next = flow->next;
-			err = flow_destroy_profile_inline(dev, flow, error);
+			err = nthw_flow_destroy_profile_inline(dev, flow, error);
 			flow = flow_next;
 
 		} else {
@@ -4383,7 +4383,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	while (flow && !err) {
 		if (flow->dev == dev && flow->caller_id == caller_id) {
 			struct flow_handle *flow_next = flow->next;
-			err = flow_destroy_profile_inline(dev, flow, error);
+			err = nthw_flow_destroy_profile_inline(dev, flow, error);
 			flow = flow_next;
 
 		} else {
@@ -4394,7 +4394,7 @@ int flow_flush_profile_inline(struct flow_eth_dev *dev,
 	return err;
 }
 
-int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error)
@@ -4566,7 +4566,7 @@ static void dump_flm_data(const uint32_t *data, FILE *file)
 	}
 }
 
-int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	void **context,
 	uint32_t nb_contexts,
@@ -4615,7 +4615,7 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	return idx;
 }
 
-int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	uint16_t caller_id,
 	FILE *file,
@@ -4687,7 +4687,7 @@ int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
+int nthw_flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
 	const enum hw_flm_e fields[] = {
 		HW_FLM_STAT_FLOWS, HW_FLM_STAT_LRN_DONE, HW_FLM_STAT_LRN_IGNORE,
@@ -4729,7 +4729,7 @@ int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	return 0;
 }
 
-int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
+int nthw_flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	uint8_t port_count)
 {
 	/* IFR RCP 0 is reserved, port counters start from record 1 */
@@ -4747,7 +4747,7 @@ int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data,
 	return 0;
 }
 
-int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
+int nthw_flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 {
 	if (port >= 255)
 		return -1;
@@ -4808,7 +4808,7 @@ int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu)
 	return err;
 }
 
-int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error)
 {
@@ -4830,7 +4830,7 @@ int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	return res;
 }
 
-int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error)
@@ -4905,7 +4905,8 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	return -1;
 }
 
-struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_pattern_template *
+nthw_flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error)
 {
@@ -4949,7 +4950,7 @@ struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct
 	return template;
 }
 
-int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_pattern_template *pattern_template,
 	struct rte_flow_error *error)
 {
@@ -4963,7 +4964,7 @@ int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 }
 
 struct flow_actions_template *
-flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
+nthw_flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_actions_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_action actions[],
 	const struct rte_flow_action masks[],
@@ -5023,7 +5024,7 @@ flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	return template;
 }
 
-int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_actions_template *actions_template,
 	struct rte_flow_error *error)
 {
@@ -5036,7 +5037,7 @@ int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-struct flow_template_table *flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_template_table *nthw_flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_template_table_attr *table_attr, uint16_t forced_vlan_vid,
 	uint16_t caller_id,
 	struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
@@ -5109,7 +5110,7 @@ struct flow_template_table *flow_template_table_create_profile_inline(struct flo
 	return NULL;
 }
 
-int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error)
 {
@@ -5136,7 +5137,7 @@ int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	return 0;
 }
 
-struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_handle *nthw_flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr,
 	struct flow_template_table *template_table,
@@ -5346,7 +5347,7 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	return NULL;
 }
 
-int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error)
 {
@@ -5355,7 +5356,7 @@ int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_i
 	(void)user_data;
 
 	if (flow->type == FLOW_HANDLE_TYPE_FLOW)
-		return flow_destroy_profile_inline(dev, flow, error);
+		return nthw_flow_destroy_profile_inline(dev, flow, error);
 
 	if (flm_flow_programming(flow, NT_FLM_OP_UNLEARN)) {
 		NT_LOG(ERR, FILTER, "FAILED to destroy flow: %p", flow);
@@ -5374,36 +5375,40 @@ static const struct profile_inline_ops ops = {
 	/*
 	 * Management
 	 */
-	.done_flow_management_of_ndev_profile_inline = done_flow_management_of_ndev_profile_inline,
-	.initialize_flow_management_of_ndev_profile_inline =
-		initialize_flow_management_of_ndev_profile_inline,
-	.flow_dev_dump_profile_inline = flow_dev_dump_profile_inline,
+	.nthw_done_flow_mgmnt_of_ndev_profile_inline = nthw_done_flow_mgmnt_of_ndev_profile_inline,
+	.nthw_init_flow_mgmnt_of_ndev_profile_inline =
+		nthw_init_flow_mgmnt_of_ndev_profile_inline,
+	.nthw_flow_dev_dump_profile_inline = nthw_flow_dev_dump_profile_inline,
 	/*
 	 * Flow functionality
 	 */
-	.flow_destroy_locked_profile_inline = flow_destroy_locked_profile_inline,
-	.flow_create_profile_inline = flow_create_profile_inline,
-	.flow_destroy_profile_inline = flow_destroy_profile_inline,
-	.flow_flush_profile_inline = flow_flush_profile_inline,
-	.flow_actions_update_profile_inline = flow_actions_update_profile_inline,
-	.flow_get_aged_flows_profile_inline = flow_get_aged_flows_profile_inline,
+	.nthw_flow_destroy_locked_profile_inline = nthw_flow_destroy_locked_profile_inline,
+	.nthw_flow_create_profile_inline = nthw_flow_create_profile_inline,
+	.nthw_flow_destroy_profile_inline = nthw_flow_destroy_profile_inline,
+	.nthw_flow_flush_profile_inline = nthw_flow_flush_profile_inline,
+	.nthw_flow_actions_update_profile_inline = nthw_flow_actions_update_profile_inline,
+	.nthw_flow_get_aged_flows_profile_inline = nthw_flow_get_aged_flows_profile_inline,
 	/*
 	 * Stats
 	 */
-	.flow_get_flm_stats_profile_inline = flow_get_flm_stats_profile_inline,
-	.flow_get_ifr_stats_profile_inline = flow_get_ifr_stats_profile_inline,
-	.flow_info_get_profile_inline = flow_info_get_profile_inline,
-	.flow_configure_profile_inline = flow_configure_profile_inline,
-	.flow_pattern_template_create_profile_inline = flow_pattern_template_create_profile_inline,
-	.flow_pattern_template_destroy_profile_inline =
-		flow_pattern_template_destroy_profile_inline,
-	.flow_actions_template_create_profile_inline = flow_actions_template_create_profile_inline,
-	.flow_actions_template_destroy_profile_inline =
-		flow_actions_template_destroy_profile_inline,
-	.flow_template_table_create_profile_inline = flow_template_table_create_profile_inline,
-	.flow_template_table_destroy_profile_inline = flow_template_table_destroy_profile_inline,
-	.flow_async_create_profile_inline = flow_async_create_profile_inline,
-	.flow_async_destroy_profile_inline = flow_async_destroy_profile_inline,
+	.nthw_flow_get_flm_stats_profile_inline = nthw_flow_get_flm_stats_profile_inline,
+	.nthw_flow_get_ifr_stats_profile_inline = nthw_flow_get_ifr_stats_profile_inline,
+	.nthw_flow_info_get_profile_inline = nthw_flow_info_get_profile_inline,
+	.nthw_flow_configure_profile_inline = nthw_flow_configure_profile_inline,
+	.nthw_flow_pattern_template_create_profile_inline =
+		nthw_flow_pattern_template_create_profile_inline,
+	.nthw_flow_pattern_template_destroy_profile_inline =
+		nthw_flow_pattern_template_destroy_profile_inline,
+	.nthw_flow_actions_template_create_profile_inline =
+		nthw_flow_actions_template_create_profile_inline,
+	.nthw_flow_actions_template_destroy_profile_inline =
+		nthw_flow_actions_template_destroy_profile_inline,
+	.nthw_flow_template_table_create_profile_inline =
+		nthw_flow_template_table_create_profile_inline,
+	.nthw_flow_template_table_destroy_profile_inline =
+		nthw_flow_template_table_destroy_profile_inline,
+	.nthw_flow_async_create_profile_inline = nthw_flow_async_create_profile_inline,
+	.nthw_flow_async_destroy_profile_inline = nthw_flow_async_destroy_profile_inline,
 	/*
 	 * NT Flow FLM Meter API
 	 */
@@ -5424,10 +5429,10 @@ static const struct profile_inline_ops ops = {
 	/*
 	 * Config API
 	 */
-	.flow_set_mtu_inline = flow_set_mtu_inline,
+	.nthw_flow_set_mtu_inline = nthw_flow_set_mtu_inline,
 };
 
-void profile_inline_init(void)
+void nthw_profile_inline_init(void)
 {
 	register_profile_inline_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index 98aba07515..2c2d0e2fbf 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -22,18 +22,18 @@
  * Management
  */
 
-int done_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev);
+int nthw_done_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev);
 
-int initialize_flow_management_of_ndev_profile_inline(struct flow_nic_dev *ndev);
+int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev);
 
 /*
  * Flow functionality
  */
-int flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_locked_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *fh,
 	struct rte_flow_error *error);
 
-struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_handle *nthw_flow_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_attr *attr,
 	uint16_t forced_vlan_vid,
 	uint16_t caller_id,
@@ -41,26 +41,26 @@ struct flow_handle *flow_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error);
 
-int flow_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	struct rte_flow_error *error);
 
-int flow_flush_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_flush_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	struct rte_flow_error *error);
 
-int flow_actions_update_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_update_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	const struct rte_flow_action action[],
 	struct rte_flow_error *error);
 
-int flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_dev_dump_profile_inline(struct flow_eth_dev *dev,
 	struct flow_handle *flow,
 	uint16_t caller_id,
 	FILE *file,
 	struct rte_flow_error *error);
 
-int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	uint16_t caller_id,
 	void **context,
 	uint32_t nb_contexts,
@@ -70,9 +70,11 @@ int flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
  * Stats
  */
 
-int flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size);
+int nthw_flow_get_flm_stats_profile_inline(struct flow_nic_dev *ndev,
+		uint64_t *data,
+		uint64_t size);
 
-int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
+int nthw_flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
 	uint64_t *data,
 	uint8_t port_count);
 
@@ -80,49 +82,52 @@ int flow_get_ifr_stats_profile_inline(struct flow_nic_dev *ndev,
  * RTE flow asynchronous operations functions
  */
 
-struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_pattern_template *
+nthw_flow_pattern_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_item pattern[], struct rte_flow_error *error);
 
-int flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_pattern_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_pattern_template *pattern_template,
 	struct rte_flow_error *error);
 
-struct flow_actions_template *flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_actions_template *
+nthw_flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_actions_template_attr *template_attr, uint16_t caller_id,
 	const struct rte_flow_action actions[], const struct rte_flow_action masks[],
 	struct rte_flow_error *error);
 
-int flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_actions_template_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_actions_template *actions_template,
 	struct rte_flow_error *error);
 
-struct flow_template_table *flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
+struct flow_template_table *nthw_flow_template_table_create_profile_inline(struct flow_eth_dev *dev,
 	const struct rte_flow_template_table_attr *table_attr, uint16_t forced_vlan_vid,
 	uint16_t caller_id,
 	struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
 	struct flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 	struct rte_flow_error *error);
 
-int flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
+int nthw_flow_template_table_destroy_profile_inline(struct flow_eth_dev *dev,
 	struct flow_template_table *template_table,
 	struct rte_flow_error *error);
 
-struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+struct flow_handle *nthw_flow_async_create_profile_inline(struct flow_eth_dev *dev,
+	uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr,
 	struct flow_template_table *template_table, const struct rte_flow_item pattern[],
 	uint8_t pattern_template_index, const struct rte_flow_action actions[],
 	uint8_t actions_template_index, void *user_data, struct rte_flow_error *error);
 
-int flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
+int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t queue_id,
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error);
 
-int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error);
 
-int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
+int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error);
@@ -130,6 +135,6 @@ int flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 /*
  * Config API
  */
-int flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
+int nthw_flow_set_mtu_inline(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
 
 #endif	/* _FLOW_API_PROFILE_INLINE_H_ */
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 276a2dc8e1..6318a32e4b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1192,7 +1192,7 @@ static int dev_set_mtu_inline(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	int ret = -1;
 
 	if (internals->type == PORT_TYPE_PHYSICAL && mtu >= MIN_MTU_INLINE && mtu <= MAX_MTU)
-		ret = profile_inline_ops->flow_set_mtu_inline(flw_dev, internals->port, mtu);
+		ret = profile_inline_ops->nthw_flow_set_mtu_inline(flw_dev, internals->port, mtu);
 
 	return ret ? -EINVAL : 0;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 8dc6e48182..36aee48818 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -226,7 +226,7 @@ void register_profile_inline_ops(const struct profile_inline_ops *ops)
 const struct profile_inline_ops *get_profile_inline_ops(void)
 {
 	if (profile_inline_ops == NULL)
-		profile_inline_init();
+		nthw_profile_inline_init();
 
 	return profile_inline_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 2d5bebda2a..59eb5ab69f 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -297,18 +297,18 @@ struct profile_inline_ops {
 	 * Management
 	 */
 
-	int (*done_flow_management_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
+	int (*nthw_done_flow_mgmnt_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
 
-	int (*initialize_flow_management_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
+	int (*nthw_init_flow_mgmnt_of_ndev_profile_inline)(struct flow_nic_dev *ndev);
 
 	/*
 	 * Flow functionality
 	 */
-	int (*flow_destroy_locked_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_destroy_locked_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *fh,
 		struct rte_flow_error *error);
 
-	struct flow_handle *(*flow_create_profile_inline)(struct flow_eth_dev *dev,
+	struct flow_handle *(*nthw_flow_create_profile_inline)(struct flow_eth_dev *dev,
 		const struct rte_flow_attr *attr,
 		uint16_t forced_vlan_vid,
 		uint16_t caller_id,
@@ -316,26 +316,26 @@ struct profile_inline_ops {
 		const struct rte_flow_action action[],
 		struct rte_flow_error *error);
 
-	int (*flow_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		struct rte_flow_error *error);
 
-	int (*flow_flush_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_flush_profile_inline)(struct flow_eth_dev *dev,
 		uint16_t caller_id,
 		struct rte_flow_error *error);
 
-	int (*flow_actions_update_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_actions_update_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		const struct rte_flow_action action[],
 		struct rte_flow_error *error);
 
-	int (*flow_dev_dump_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_dev_dump_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_handle *flow,
 		uint16_t caller_id,
 		FILE *file,
 		struct rte_flow_error *error);
 
-	int (*flow_get_aged_flows_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_get_aged_flows_profile_inline)(struct flow_eth_dev *dev,
 		uint16_t caller_id,
 		void **context,
 		uint32_t nb_contexts,
@@ -345,43 +345,43 @@ struct profile_inline_ops {
 	 * RTE flow asynchronous operations functions
 	 */
 
-	struct flow_pattern_template *(*flow_pattern_template_create_profile_inline)
+	struct flow_pattern_template *(*nthw_flow_pattern_template_create_profile_inline)
 		(struct flow_eth_dev *dev,
 		const struct rte_flow_pattern_template_attr *template_attr, uint16_t caller_id,
 		const struct rte_flow_item pattern[], struct rte_flow_error *error);
 
-	int (*flow_pattern_template_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_pattern_template_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_pattern_template *pattern_template,
 		struct rte_flow_error *error);
 
-	struct flow_actions_template *(*flow_actions_template_create_profile_inline)
+	struct flow_actions_template *(*nthw_flow_actions_template_create_profile_inline)
 		(struct flow_eth_dev *dev,
 		const struct rte_flow_actions_template_attr *template_attr,
 		uint16_t caller_id, const struct rte_flow_action actions[],
 		const struct rte_flow_action masks[], struct rte_flow_error *error);
 
-	int (*flow_actions_template_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_actions_template_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_actions_template *actions_template,
 		struct rte_flow_error *error);
 
-	struct flow_template_table *(*flow_template_table_create_profile_inline)
+	struct flow_template_table *(*nthw_flow_template_table_create_profile_inline)
 		(struct flow_eth_dev *dev, const struct rte_flow_template_table_attr *table_attr,
 		uint16_t forced_vlan_vid, uint16_t caller_id,
 		struct flow_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
 		struct flow_actions_template *actions_templates[], uint8_t nb_actions_templates,
 		struct rte_flow_error *error);
 
-	int (*flow_template_table_destroy_profile_inline)(struct flow_eth_dev *dev,
+	int (*nthw_flow_template_table_destroy_profile_inline)(struct flow_eth_dev *dev,
 		struct flow_template_table *template_table,
 		struct rte_flow_error *error);
 
-	struct flow_handle *(*flow_async_create_profile_inline)(struct flow_eth_dev *dev,
+	struct flow_handle *(*nthw_flow_async_create_profile_inline)(struct flow_eth_dev *dev,
 		uint32_t queue_id, const struct rte_flow_op_attr *op_attr,
 		struct flow_template_table *template_table, const struct rte_flow_item pattern[],
 		uint8_t rte_pattern_template_index, const struct rte_flow_action actions[],
 		uint8_t rte_actions_template_index, void *user_data, struct rte_flow_error *error);
 
-	int (*flow_async_destroy_profile_inline)(struct flow_eth_dev *dev, uint32_t queue_id,
+	int (*nthw_flow_async_destroy_profile_inline)(struct flow_eth_dev *dev, uint32_t queue_id,
 		const struct rte_flow_op_attr *op_attr,
 		struct flow_handle *flow, void *user_data,
 		struct rte_flow_error *error);
@@ -389,11 +389,11 @@ struct profile_inline_ops {
 	/*
 	 * Stats
 	 */
-	int (*flow_get_flm_stats_profile_inline)(struct flow_nic_dev *ndev,
+	int (*nthw_flow_get_flm_stats_profile_inline)(struct flow_nic_dev *ndev,
 		uint64_t *data,
 		uint64_t size);
 
-	int (*flow_get_ifr_stats_profile_inline)(struct flow_nic_dev *ndev,
+	int (*nthw_flow_get_ifr_stats_profile_inline)(struct flow_nic_dev *ndev,
 		uint64_t *data,
 		uint8_t port_count);
 
@@ -431,11 +431,11 @@ struct profile_inline_ops {
 
 	uint32_t (*flm_update)(struct flow_eth_dev *dev);
 
-	int (*flow_info_get_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
+	int (*nthw_flow_info_get_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
 		struct rte_flow_port_info *port_info, struct rte_flow_queue_info *queue_info,
 		struct rte_flow_error *error);
 
-	int (*flow_configure_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
+	int (*nthw_flow_configure_profile_inline)(struct flow_eth_dev *dev, uint8_t caller_id,
 	const struct rte_flow_port_attr *port_attr, uint16_t nb_queue,
 	const struct rte_flow_queue_attr *queue_attr[],
 	struct rte_flow_error *error);
@@ -443,12 +443,12 @@ struct profile_inline_ops {
 	/*
 	 * Config API
 	 */
-	int (*flow_set_mtu_inline)(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
+	int (*nthw_flow_set_mtu_inline)(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
 };
 
 void register_profile_inline_ops(const struct profile_inline_ops *ops);
 const struct profile_inline_ops *get_profile_inline_ops(void);
-void profile_inline_init(void);
+void nthw_profile_inline_init(void);
 
 struct flow_filter_ops {
 	int (*nthw_flow_filter_init)(nthw_fpga_t *p_fpga, struct flow_nic_dev **p_flow_device,
-- 
2.45.0

