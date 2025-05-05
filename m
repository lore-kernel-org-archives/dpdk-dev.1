Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A0C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCC43406FF;
	Mon,  5 May 2025 09:13:40 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id D1E4E406BA
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:38 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2045.outbound.protection.outlook.com [104.47.11.45]) by
 mx-outbound18-65.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfp1wgu7BbUA/ybM/HOfO1KT0IaufugNZVMW7S8PCJjJ1wJ4CP/NDYhu544RrGIfKgrYTXzdaAGfJ79/qYRp08GV2dSAXmoRgz4OkpCTHe1htTpwKbgha8OKBAhJDg3ptblAW/QzjUiWS+c62zPU/aSYKmE/xbjTPriaOqw0WBzCTfT8c5WCvFj1jgmaTkB2h0oONeuhg1/6vidgR2uzvsme4ifJ5cyEikrcdLD3WvqxFoYNraZRYjxf7PhGKktHW+7cvoMqOXM+05NJKEfSUPitoa/4GO3chDgKhk7V6BXXfOJLkfNj2n1Jjt3iNiH9vtG9HQjVfAeJmh6H+f6u8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZWnWK7UMDkOovJxrg6iNhOn3iHIUMYvfLB3loQtDAM=;
 b=wGx2Aqa7uXrRmnHHzoVrudfqoxPVBH3YCUnqDMHUD0Xaxydlbggv4Ii7gf3hqdOoB24+6SmG5Szuf+KPCVG5UAZbir8oR3qiFA0xksYzk79zW0gkrI9fKfPHY6Kf3RREOVwzBomr1jnl9H0aiIexyNPbveFGdKi8SCP34Bm9/crsH9Hdz/1+zvbzjhMS/w/XbdtjTKS17jQ5OWGW5C82rxcd75ct6T2avudWd08AfZwD2ay5i3QN0mvL2NsopL42d6t+esIeSUnz2YLx0gFgvIFuu79g6MsKiCBajpujxmSWl1e8fWYOBvN/7wyf2Fb6DAHl6TbJwCQIlKISZo06xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZWnWK7UMDkOovJxrg6iNhOn3iHIUMYvfLB3loQtDAM=;
 b=KXjFno+sHMvGtZ6rsBV8vPoQMywIWh1f5uIHmUswRW+mYQmV7SXVV2UO3HohqOPJbx2MKlHukqJxSVlyUWjWFXUM2BbD2g8K8IZwB0BTwbPk1CVKqCBeh49euRHpthaTjqwSeuy6pynaeEdHh+O2nX+gAQ5YAcd+yE8d/4ju+W4=
Received: from DU7P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::27)
 by AM9P190MB1090.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 07:13:18 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::c3) by DU7P191CA0014.outlook.office365.com
 (2603:10a6:10:54e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:18
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 08/26] net/ntnic: correct misspelled variable names
Date: Mon,  5 May 2025 09:12:48 +0200
Message-ID: <20250505071309.586015-9-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1090:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df236569-394b-48fb-4657-08dd8ba44fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZK255Elz8gXLOjkkOqe/VlXC226B89femuDbO4pf27B3u35rxoVCM6JlHuMs?=
 =?us-ascii?Q?JZ4LomZxdZzcmBA4MyAEFmf8Fo4ccuWHPedEhBJWLQVEgChaaWnbujRB96CN?=
 =?us-ascii?Q?7t95lGmybSzPnn34d8NiBgHiitrvgQGAoaUCvGew/YpIeKE2y/NybK6x56/Q?=
 =?us-ascii?Q?ni+JMBeifKd3dVNfhF+9cK1U9imcr19luRuAmnhkwvnZYBR6jzDV5et6PkLB?=
 =?us-ascii?Q?xUKSLyl5g2o3vln79xVUz8oxLLQjM4pMpb3SEzOrEs3NvhdVk8qmxj6Q0JZ2?=
 =?us-ascii?Q?u5rerp8wmEYBcfcWxpoMRDaY+AEiVNombVeFhof52R7gQaHRrt+135dQ32/2?=
 =?us-ascii?Q?UziPataCf8SdYm69oWxcCWD+U287UZsdek0ChuAk44/Rz1hRVw1FOndRtyVE?=
 =?us-ascii?Q?gDrrGgx5iWe5oKIhgmlH2UExWfb2EULN9Wp2VG4yNie9T2h2F0vBDWci8WnG?=
 =?us-ascii?Q?alAGP18axDa2O1tn8Hzkok0Fko7UGPENQq9oIWgxj9bnwMZhbWfShO3SlI/d?=
 =?us-ascii?Q?228hnyfJIcGEis6IJBVo8F6+MMNliduH+CfSAHJ1aHyu3J8pP7XoJmVTDPYk?=
 =?us-ascii?Q?z+V4QT3SCeH3cOX4syuEOmeCXmc3aB2Z1lQlpQ/cmdUxvCi1vhfFisv/+nho?=
 =?us-ascii?Q?mEu9HpzrQVLmozia2IKgvuOtbAUY+yf26E/OiCz8ZKtl7t1/mauyxebbFC6R?=
 =?us-ascii?Q?cOtZKUX4H2P1NO4oIYsWsQTtVmJ5vbgxcJz02mr3csPcR//U8cJzh/pQEXMH?=
 =?us-ascii?Q?0K9bWPAF+JeJJS9W4KFHEBzXlujM7JY6r9nlHdytOMMaj9+KP2MVaCZk4OvD?=
 =?us-ascii?Q?OA5aHJ0mAGxHOOdjoWEJ/xrFu+xYRJwBhdBcFGLaYBZRd1zlQjGeXm+Vpi3x?=
 =?us-ascii?Q?3UEZdI7it8QErPMG6ilNS46rcm/L81eV9u1iR08TSQIx/Lno22Lca/ft/wfa?=
 =?us-ascii?Q?QA0yLgggpW5RXE/KC6WQQVax6vNRcbt0Qef8JVBcDBZC2+lqRgeSPIAouAYx?=
 =?us-ascii?Q?gtvXlFBmkxyW5bZ/HtA4PsAZ8/4hWsXClZ2ctotjjminyBD1zbwiXfLnmjCB?=
 =?us-ascii?Q?YphB9lwV5ht3w9afVmKID2oMocselFdb0B1glKP9qsBZVoePv8MGChP7DUog?=
 =?us-ascii?Q?XJ3wXOiHopLQpg6XvfUoFiBk0w3aoFOJLyMK420gmIjQ2azNhDXiyZIl4DEo?=
 =?us-ascii?Q?PhrSlGjFQiK4Oi2V34T3B4QzZT50SldkL6HlrEueHlWg5STJdlpDp42n9Sgq?=
 =?us-ascii?Q?izUS10X2GvttmyJ1yBKyw6YWlKYqBq4/+yA8y2XEVk41paP8YsNyabCi0JCV?=
 =?us-ascii?Q?1fDNpw0FJSsDJCil7oqEFx3m/TBoRRGe1KTS++/kZ2tW5fsyAAVb4nmIu5Ds?=
 =?us-ascii?Q?f/Q1DGaMJwP/VtZJUYUl1DbmAq0mQF/Jz7Zq3hsJUrzpJ2jdDxE0zKUOQUej?=
 =?us-ascii?Q?hFOSLd9q8KPxVjLxOfUvre2qPxn/fWEu2J/XgQq3+oR1mvj8F7JvASiY9rMo?=
 =?us-ascii?Q?OfS6c5Q5vZ72vkRAW8/ZMzojoKtfbaDO7nNF?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KSZIBYo7TH0Fi4qtJN/ZyeBy3v88FU22j24ff6OSZGFjWzcoC4lGe+lP40WcdaiLWDd3qi/xOoPlKS6QxArMpVw1PrI5JbahQWzib77TEjz2sCcQcLNS8T37CU05cjfmpVtQpZaEOH990SRfQnY7biysRmnllnoV7vRKhFo92mkJ9LyIulSuDH70lExeq7gbcuONlV88u+UMOK8GqTOiGnkDWamv+zkB6zbQynW/zB5+/C2NjlsR+AbJ+fwVeIyRh3DpMBOgtlqrEshopcpLrqOEPv+3uq2xwx9Rxx5IF4GkLtPczsdFy2rq72DSsG5HuCBMM4w7ksaSFrDLbC/utCs725XhDZKHDZCEBSAHEAzzoVbgV3UdMvqGjvRGmjAqBO8DCpIzMpfLDDL/XaMhqSJ8/h7qOdtEVo32P5PG/dDE2tl/W20WfLmBuDsjvgfoRZ1sb7WeWwCbgzYL0MGywBresC7/6dXJftQNJM2qeYn8kouHAjqoIsB5N/LOGJDXCGuewuzZxE32plumthuTooGYSLAJzZDyt6tzUoi+L49ixO3MaWtlkFdagHomG9OmvllQIMiUYC2FBrMgGcBmVS6PEkaFkIPr+MPTAM6xEUhg9l8fBQfU8ydF9erYnhX/qWK2jvRKa6PwRn1rrynrmQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:18.3520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df236569-394b-48fb-4657-08dd8ba44fbe
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1090
X-BESS-ID: 1746429200-304673-7659-373-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWlhZAVgZQ0MLEwijJ0tLU2C
 LNMs3I0szSwMzIMNUgxdDUOMXUPClRqTYWACsHzkVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan12-166.eu-central-1a.ess.aws.cudaops.com]
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

Rename alloced_size to allocated_size.
Rename num_queues_alloced to num_queues_allocated.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/hw_mod_backend.h           |  2 +-
 .../net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c  |  4 ++--
 drivers/net/ntnic/ntnic_ethdev.c                     | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index fcf9ebef8e..f7d4085e5c 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -145,7 +145,7 @@ enum km_flm_if_select_e {
 #define COMMON_FUNC_INFO_S                                                                        \
 	int ver;                                                                                  \
 	void *base;                                                                               \
-	unsigned int alloced_size;                                                                \
+	unsigned int allocated_size;                                                              \
 	int debug
 
 enum frame_offs_e {
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index 299b9b913a..da126fe853 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -79,14 +79,14 @@ void *nthw_callocate_mod(struct common_func_s *mod, int sets, ...)
 	va_end(args);
 
 	mod->base = base;
-	mod->alloced_size = total_bytes;
+	mod->allocated_size = total_bytes;
 
 	return base;
 }
 
 void nthw_zero_module_cache(struct common_func_s *mod)
 {
-	memset(mod->base, 0, mod->alloced_size);
+	memset(mod->base, 0, mod->allocated_size);
 }
 
 int nthw_flow_api_backend_init(struct flow_api_backend_s *dev,
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 6ba6769e47..f511d91e49 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -967,19 +967,19 @@ static void eth_rx_queue_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 	deallocate_hw_virtio_queues(&rx_q->hwq);
 }
 
-static int num_queues_alloced;
+static int num_queues_allocated;
 
 /* Returns num queue starting at returned queue num or -1 on fail */
 static int allocate_queue(int num)
 {
-	int next_free = num_queues_alloced;
-	NT_LOG_DBGX(DBG, NTNIC, "num_queues_alloced=%u, New queues=%u, Max queues=%u",
-		num_queues_alloced, num, MAX_TOTAL_QUEUES);
+	int next_free = num_queues_allocated;
+	NT_LOG_DBGX(DBG, NTNIC, "num_queues_allocated=%u, New queues=%u, Max queues=%u",
+		num_queues_allocated, num, MAX_TOTAL_QUEUES);
 
-	if (num_queues_alloced + num > MAX_TOTAL_QUEUES)
+	if (num_queues_allocated + num > MAX_TOTAL_QUEUES)
 		return -1;
 
-	num_queues_alloced += num;
+	num_queues_allocated += num;
 	return next_free;
 }
 
-- 
2.47.1

