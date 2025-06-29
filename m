Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F4C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:07:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2128940655;
	Sun, 29 Jun 2025 19:07:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
 by mails.dpdk.org (Postfix) with ESMTP id 5C3EF40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrSjzjFrSW/KEp0wu5+eLWDCDrSLFx7vNo1zhWTrbOo/PiMxhHHWvRSACiwKrOasY0K/DCdrSGICm2UYRDlJQMGKcZ7EJcQbObHSrvbj98OguP0Nk6akrpQz0sBSmJKcS8u/voUBjhMwyMmQ0sSVkxHsmnO3WK6sSyojD66SntiUxnkH7i9eyKDp5VN4IB4GQMANceubqUWxYHegX/LHjkhDt6PAyaWFoGocMf9df/Gnkw2A6TlwUO8xPWhmoK+k71hx2cvXFAHkF/PT5gBuL1QzhOSGF6BDH8oXzyJ6A3bJUlhXwA01/limJ1CpTSj5+fLbmmsSgRXp+WnMHKgcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvVUUUHuJIHOCN1k+5fryS2BPcCsvDzJLPn/ADk5H0I=;
 b=ofNUvPqc7mvEZ1pQAFk64jBdT9B/cmnojnv2ggMorhhN5zoIA/4OTm11ueCwulv4MYRgQVNGR263ei4gYyzTrpkA3oU2sd6dSmTAMvBHHSS5H2eORrQV4DqRj2r3QwTOC4pGG4CGKSItD21dqRQ6EdvPXMCHGXa//ACLKAR5MpsLHuYBNSpgYHBQW7vnH69YAxXnOL0NUs92wHh/hOx9QOX1ZZMC46ea6S08I5SPBKfDx7QDJgCr19dbUuifLqwnre3UJX3QmqO9x6Y4maUMVMHVtRxVq0lq+Ze2UnTWG2m9cM2hXa3Gd2+D8juUq8UiYRC9a7Lw3q8NPX1UD7nifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvVUUUHuJIHOCN1k+5fryS2BPcCsvDzJLPn/ADk5H0I=;
 b=k63izRV522DB0rt23Kr6OWltNw8MBK2vSh9hU47w6pyEzfB9slJUNzFUHoc+Xo8chaBAtcuN9CG9lBwNUQRf7yOEGmGwu1pbr1sZCRjvE5t+lkKccBcXYrjdQhZpwy9TkbRGcAk+ijaVt8PT288sCWN+EJ8usQ/RWTZhYFY/EjY08ADDy8gPXZqooUz8frYv8p1DZ8ywFot+2GfhaKwFJFE+9A0rsM0chXttG3CKYBqP9OUrW5IvCLb5I0rQkRmg/MoiRQkq6goGf/RIGzDZJLaGGAwtQ/2AiHWESjCFKEZ0heA6QaCjHTMUjSTKXDpxJGfY/EE5KZZj4j6FeyA86g==
Received: from DBBPR09CA0046.eurprd09.prod.outlook.com (2603:10a6:10:d4::34)
 by DB9PR07MB7274.eurprd07.prod.outlook.com (2603:10a6:10:1fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Sun, 29 Jun
 2025 17:07:34 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::86) by DBBPR09CA0046.outlook.office365.com
 (2603:10a6:10:d4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.26 via Frontend Transport; Sun,
 29 Jun 2025 17:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:33 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 29 Jun 2025 19:07:33 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 18F2B380070; Sun, 29 Jun 2025 19:07:33 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Maria
 Lingemark" <maria.lingemark@ericsson.com>, Luka Jankovic
 <luka.jankovic@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [RFC 4/4] event/dsw: implement enqueue optimized for prealloced events
Date: Sun, 29 Jun 2025 18:52:14 +0200
Message-ID: <20250629165214.3468-5-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
References: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|DB9PR07MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: a0958e30-a23d-4275-331a-08ddb72f70c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkJZNnJienBSdWQxdzNTRnhJeXB1d0NIQmdBNG1OK2h0VzRrVUZxeE53ZlZL?=
 =?utf-8?B?amppNkE0VTl0SzBiRnI2Z2IzaEs2YTJjZXBnbWRYcjFYSUw4c2R3VGRKejVq?=
 =?utf-8?B?ejRDOUorQWRWMDMzTlp0TW5vQ0lMWFJyaGhjd3pIZ3pYazM0MUY0WVZxUFpR?=
 =?utf-8?B?QjhGNG9laUljczEydFdOZENRZGROb0g1WGU2UHhEdjFFcEVVN24ySWc5cUth?=
 =?utf-8?B?bmFld3l0K0JlV3JqWnFxS2RXQUJZRjM4Z21kaVFsT2duelFzNE5EcHFKLzBE?=
 =?utf-8?B?NWY2ckJ0dXJEWUVOU1ZrV29jc3lERVMxQTNrRGtoeEZxaTdmSXFrYzNrMXF3?=
 =?utf-8?B?Q3VIaUhBL2JWTjdnNE1wOTJxM1pSSHZoejhObVBoeTlFM0x0S3lTdStwU0Jn?=
 =?utf-8?B?ZEgxVjNoNkQvZWpTVXIrSm91TGgrQmkrUVlMb1F6WjljNy91akxPclpVQ3pO?=
 =?utf-8?B?dTc0dGxGZkw2MDArcnE4c2tMcitqbVJEWUU3czR2TnBjby9EdFU4ek51VElU?=
 =?utf-8?B?SmlVMXJSOGlhNzd4a1B5T0lKTXV6MkxZeTArUkdFWCtCWDhCb1llN0JPYWhG?=
 =?utf-8?B?d1RXUnN1cjdWZGxGa1kzNzRuemEreDFVeGVNRUQrTjMwR2s0RUxSQVJETjRh?=
 =?utf-8?B?UnI5d2Z1SVI2RzErVUEwTUV6NXd2T1hjU3ZSR21HYnhvL0NWeGczY2wySkQ5?=
 =?utf-8?B?emhFc0t0UTZYMzlCNEF4NEQ1SlA3N093Y2RCMHhVK1V5RlB3WTRxVWJqSS9R?=
 =?utf-8?B?N25zYXkxS0pFQ0tZemVXMitJMlFWcHl2VmFSVDFDZVNhOFcrOXdKM2Jwc0Vj?=
 =?utf-8?B?SCtHeG9rMkVXZmV0b01kNkwyWGR5VTBaNXpjRHExV0hpTVdKMjJHSXRtbHpr?=
 =?utf-8?B?c3FEcDR4N3VDOFBmS3QzQlpwSXdFNG1ReHBVdXI3YXd3SFpZcUVCWTBQZE5p?=
 =?utf-8?B?QWkwd1RMVE50QjdvU0lLK0FoTzRnc2gwR3pEdWdyRzVUWUlQdlp1bHB5RjIz?=
 =?utf-8?B?L0Nwai80YzJ4MEVlcS9IcFo2WEw3ZTJWSTZ6MXp5UTJLanU1Q2xqM3dMREE3?=
 =?utf-8?B?YlhpNFhNeWpCcTllVHV5SmJmSk9UcGgxRERwUUJPZ3c2djg3Z21ycHRjdnlS?=
 =?utf-8?B?a2R5WkVDS0pvV1B5cUJkVDdrcURlcVArR2RUek42U2s3d0VZNUN4MHExZEVI?=
 =?utf-8?B?ay9wNFc1dmxRM3lrKzN4dVowU25pVFRmaDRPWmtwNU1OdEkrdEMyVW4ycitu?=
 =?utf-8?B?NWN4YnMrd0VHNUttb2VzNmIySEtqZWI2TTU5WU5Cd3g2SVVOVXh3Qk1GR3Fh?=
 =?utf-8?B?U2pJbldRWlJxMXU0T1duYzFxT3Y4bGhxUktjeGlNeFd0ZUdLY2R1czYvK2hi?=
 =?utf-8?B?bHBRVWRqWFYwc2NnZVNoRWIzSXl0elZrcXB3aGcwTjM5UzQ5a2xSaWdhUlNw?=
 =?utf-8?B?VXBQVkNBYTBlcEFKdHdNZk9TL1FFN0hqQkMxOXhmNjdIWUxCclRVOVQvR0dK?=
 =?utf-8?B?Mkdtc0NidnZHcy9oWU52S1RTSUwra1RzOHNGYzVzUXZUNityQytjSmFvOG9R?=
 =?utf-8?B?SkhaeHI4WVpiZElpdEIxdG9ZMjg5WFliaittRTFTYk5WUjF2djh0ODhtc0g3?=
 =?utf-8?B?dmRlcEhUeUJsd01kZFJOcEhnSVNqSHJHV0NmbklwRzdKMEdXVHpwYjJhM3hU?=
 =?utf-8?B?SmJCWTJoWTZHdzRVWkNXNFZ2M3F1K1FHNXYyNnRWMjRCSkdBOUtYNzgxVzdo?=
 =?utf-8?B?cGVwSWQ2V1ZleExoRlVlK1daM2VMa1dKNTNEU0RYbzk4ckIwMlZ2cmJ0MkZr?=
 =?utf-8?B?R1cwelpGMkJWK2MyeDFIaGoxT0lFQXN6VGU5Vk5lbGhnNC9XaGwyRVdKdHBH?=
 =?utf-8?B?TjFXeU1oOEdDa0d6K3pZODk5TjREVGpVajlzMGd4Ykp1VVc1MkFmRkFEd1Bq?=
 =?utf-8?B?T1djeXovak42U2xjSS9NUTJqdWxNZ2V1a3YzRGlzSUhXMkx1OHhOVXE0UzBq?=
 =?utf-8?B?anErbDE2eG0xaWhYdGowK3RpYk1pUmM3RHh1Q1diYURQUFJqUUQ2WjdEQWFX?=
 =?utf-8?Q?AjNBrR?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:33.9073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0958e30-a23d-4275-331a-08ddb72f70c5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7274
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

Implement rte_event_enqueue_new_prealloced_burst() in DSW.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 drivers/event/dsw/dsw_evdev.c |  1 +
 drivers/event/dsw/dsw_evdev.h |  3 +++
 drivers/event/dsw/dsw_event.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/event/dsw/dsw_evdev.c b/drivers/event/dsw/dsw_evdev.c
index ecc1d947dd..139f57b5f4 100644
--- a/drivers/event/dsw/dsw_evdev.c
+++ b/drivers/event/dsw/dsw_evdev.c
@@ -456,6 +456,7 @@ dsw_probe(struct rte_vdev_device *vdev)
 	dev->dev_ops = &dsw_evdev_ops;
 	dev->enqueue_burst = dsw_event_enqueue_burst;
 	dev->enqueue_new_burst = dsw_event_enqueue_new_burst;
+	dev->enqueue_new_prealloced_burst = dsw_event_enqueue_new_prealloced_burst;
 	dev->enqueue_forward_burst = dsw_event_enqueue_forward_burst;
 	dev->dequeue_burst = dsw_event_dequeue_burst;
 	dev->maintain = dsw_event_maintain;
diff --git a/drivers/event/dsw/dsw_evdev.h b/drivers/event/dsw/dsw_evdev.h
index c026b0a135..5c5699c64f 100644
--- a/drivers/event/dsw/dsw_evdev.h
+++ b/drivers/event/dsw/dsw_evdev.h
@@ -277,6 +277,9 @@ uint16_t dsw_event_enqueue_burst(void *port,
 uint16_t dsw_event_enqueue_new_burst(void *port,
 				     const struct rte_event events[],
 				     uint16_t events_len);
+uint16_t dsw_event_enqueue_new_prealloced_burst(void *port,
+						const struct rte_event events[],
+						uint16_t events_len);
 uint16_t dsw_event_enqueue_forward_burst(void *port,
 					 const struct rte_event events[],
 					 uint16_t events_len);
diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
index 09f353b324..b9529bd5d5 100644
--- a/drivers/event/dsw/dsw_event.c
+++ b/drivers/event/dsw/dsw_event.c
@@ -1459,6 +1459,21 @@ dsw_event_enqueue_new_burst(void *port, const struct rte_event events[],
 					       0, 0, 0);
 }
 
+uint16_t
+dsw_event_enqueue_new_prealloced_burst(void *port,
+				       const struct rte_event events[],
+				       uint16_t events_len)
+{
+	struct dsw_port *source_port = port;
+
+	if (unlikely(events_len > source_port->enqueue_depth))
+		events_len = source_port->enqueue_depth;
+
+	return dsw_event_enqueue_burst_generic(source_port, events,
+					       events_len, true, 0, events_len,
+					       0, 0);
+}
+
 uint16_t
 dsw_event_enqueue_forward_burst(void *port, const struct rte_event events[],
 				uint16_t events_len)
@@ -1630,6 +1645,9 @@ int dsw_event_credit_alloc(void *port, unsigned int new_event_threshold,
 	struct dsw_evdev *dsw = source_port->dsw;
 	bool enough_credits;
 
+	if (new_event_threshold == 0)
+		new_event_threshold = source_port->new_event_threshold;
+
 	if (dsw_should_backpressure(dsw, new_event_threshold))
 		return 0;
 
-- 
2.43.0

