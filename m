Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFAFC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F7140DD3;
	Thu, 20 Feb 2025 23:04:31 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 9C76140676
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:23 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzpRw0zduL6emmsQSyPNiy1DohoC2AH4RU122Lx00lcxw51/68LFImuCtOSxqgoR2+6fDDh7pSAnAl2CrDd7tXBj1k+WfvRK1z3Awaq8YqWPv4gBUaoZ2xqVoMcVZlPiOnUVS/b3BqTSiX1FHNqrSvC/YR6j20WxscxhB+kK6rUo+2D0fjKDzpYSIx6FyJCQZ7xJFo0+UUd5rsjsd/1AjOtFhMozK5PKWeeqCvgzqLgUn1aUPse4uwcvVk+95L/U1SbUpKKlMmdj9AHCHz1hrjqz/YkAy6E95pZVaP2dKB1VGxFaqUy8Tz20W2nIfNo/0hFutDVKca4nOEs+s+CezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fof3U68ye8OQI+v8kqz9OKd14vWrfvzpKAGAVvs2dYY=;
 b=iBzm80ByX7PARLq86n6z3LzTjwQoneLqUgUfB5/DFqhjYeVNHVspHLBn3JRo8FjMD5NfoQdkhdlsbmDgK9T54FpKMfwWJ5JoWTTsz8UpZ/HPffomXkneIXyXME0TcQBERYx1Hy3wUIMo+GrQON2MxgL62ZWMAbXzDPctW1kAqFm2syd56+njLrflpamCJMQVqpTnM4gDDTlSbEBJSPtE9/pyd/2YGTYTwWvhDVce8fbEN1gUDLnuUSN+FOf+HX3Wq9RFrbG/1wDp0mlkbT8rRTiO/l3KbTre7pxarXGnbjD2CdyXkXKBdRYhZe8SDIkk6itohb60YfUBsmFL0eAukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fof3U68ye8OQI+v8kqz9OKd14vWrfvzpKAGAVvs2dYY=;
 b=kEMq59ntQo7aeNOHzCgMCyFn6LinvqsTETtQ32chL8Gk9Rf1vooLvjVibZPOnkG2MLLOAXu3B7o5c6DF1D6nGwTGqAGB3CeeATdBdNKbrBKNUFlLW+/g20L9lW6rkjjWkvNVqF0ALr748MrgXJ4BPnWrFZsbYIqSD3Qe5EfNQGA=
Received: from CWLP265CA0499.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::18)
 by DU0P190MB1803.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 22:04:20 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::ec) by CWLP265CA0499.outlook.office365.com
 (2603:10a6:400:18b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:20 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 12/32] net/ntnic: add port disable API
Date: Thu, 20 Feb 2025 23:03:36 +0100
Message-ID: <20250220220406.3925597-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU0P190MB1803:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b08f8026-cd54-4164-3c60-08dd51fa8728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JTG49RCLLPnMMUg2sqNAkXp2IO9/30fZAlntEkX6Vq5mSHQfWrHLwaGbbWeJ?=
 =?us-ascii?Q?PEDYAw+jjDA3sIgaYm3NusvGMMYXesj1awZT2XSEf9RYn7GRprEIgMYKUZgC?=
 =?us-ascii?Q?rQNphsHbx6W7f9jNd+pqHqRDoe0DHNtsEf1sMi1b9iJq19f7Bdx50dUKHF+G?=
 =?us-ascii?Q?AnqAXlH8+M7z0kA7r3HDwyQigIltlAzJQ5j15S7Ils5iex4Mx5co8J1lDKRW?=
 =?us-ascii?Q?boHoFR4dvd4xAMeQk9EuYaeZH0Ie/aZWS74LsefLhk1LhF8oismctNedpJl2?=
 =?us-ascii?Q?iReqIlDVN8uI/wiNOk7mGkeZaPgXdWz5aV6//yR4UYLBk+5OezoCJisYiQVC?=
 =?us-ascii?Q?x+HBAXaUAPnOc53CZvsCuYRYuM9mwssnmudeXjkif3XkRcGJbylIcA31skg2?=
 =?us-ascii?Q?qthq3N5NLyATMUVFTuS7eUySilJgMy6aRnTW64u0JnH2rqedV/LNDBXJnBA8?=
 =?us-ascii?Q?HwKxxEMoez4FeXJ1N0JlRKJi9gikPmOVxC3jEhzYtLkWV4n8UmddVXuKJ0sN?=
 =?us-ascii?Q?YwpkY208nUk+AkJZIkQxaFR2zeWhQZSPymurfmZEBgzl5L5l1D3b0IKTNiYt?=
 =?us-ascii?Q?2vhqQFKe92ry2sSyZT5Ynmyh/D6443FZgxtHooA2/oSBbJPaSC4PoLclaAm0?=
 =?us-ascii?Q?9IsrNP+0/7Cfa8I6CrNNitVD6YZzX8WQESPKnuX9gkMEEjChzTtLcmRs5zu5?=
 =?us-ascii?Q?ZstuIW13F1ru+spmg2nQX4l+RFGT+EIPXggQrq/S4FvgwDBpmRL60a0x88Lp?=
 =?us-ascii?Q?4LWxO43MnhxHgJjff3wn9nb/Qib319zEVyVLkfUKjv5s0MruGLVKi6A5IWrN?=
 =?us-ascii?Q?i2hhIUrYQBzAEpyQSE1oG8C7G7emWIAzBtNCUachStWqEvfB34UtO0RQggNf?=
 =?us-ascii?Q?YLRGKmYoKjx0QJQmhyEgG2L1vaSWAbi/CkQD1M/PkjFCnXAmyTdBiGR4ePwO?=
 =?us-ascii?Q?l7dnT9uO0tSOut4VRzfqaB8iX9R3LAc59aWdRGRbX00S+lXq5NS4XBGDqw2e?=
 =?us-ascii?Q?G6RKcdGVazm+hTk1j725j1ZUub/Hrm4bszIbpA5tTQHhFZ2juWEvwbxBu05u?=
 =?us-ascii?Q?lSa+nH+GJWvgqoEPBTB2A7SiodP9HWrN8fJTgef9/qtzFM5jXPkxXI9hiLC8?=
 =?us-ascii?Q?RuopSpJI3Rht5nzAlQH4kRRzfLQ4cuWOtTbpPqhM+tvDaUVPPRQHlkomCNdF?=
 =?us-ascii?Q?VJV9fgpwldqvIp4AXhOIFt1hvm1uHD4tfeuGtmtzzT4t0QmKyj03+LuF7e5O?=
 =?us-ascii?Q?fyBao72ZzLNiPt1lyADoBK2Jjjo0pTe04Ne709UBpDcwdds1gjMHOjOQQujG?=
 =?us-ascii?Q?O4AewLmpRbregvWQ8CPYMHb87KuXjC+almKRVyyqf71sggdb6bXQ5JoV8vLU?=
 =?us-ascii?Q?CP0phWh8OW0nySO05koY6ykmwAFXI8FvbUktsnouVHUjCU4l2ocLfW/yKljm?=
 =?us-ascii?Q?jaz2UpHgtjkI426cPpQWBPBiT1x3aONttyKof16fckU45nF8Bq7IoOKAAex4?=
 =?us-ascii?Q?s3YRnpoiR8qnALM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBX6jluyTuEPVYHBvLmrCpcFck8zn14kWbvTwcOcLISqKwegkD/0oSrw8YmR2MAzvSy3Fi/lQDPvJh/yfqys3hsjVu1O0xv/rEY+4avz6piTgtyvr4zzRJQyPwDvwHMRiJJeNCZxUkEUGevsVdMw2NyJ7c5JFmxE4GoDIGj/xryhwI3MF5nHHLdxt0u2Y+prcH0X5ct6Ey/FT0NfTtm4JjZAgndj1yIE8+j2XosHpuUwAqU1NmleKVKnpfTw9yzvEQVf1EZVtggl3COJoNBlgeCRxZbjAPX1KiSng+CjUHZP79v+uzMi1jYT0KXOP3ZOuyFnAmBcjCnhjbZzOkyQDA6ARN6gGmWX4OfIvYsUjMEdAmG6KqUAm8/NsFHyT78PeAKUTSDz5l9Q5vQx7q07JseOrPsRIOngnlS1iTXTZzirJ9bNs3i57Jd9J6nkfbz1Cpg8vqGPn18p5ShmRtmOuHtcn1t3SI7bxwR7h+3AuwxrRLx2J/dHjIiRHmWWGy800n34GSNBfzTmj8wfLmPc7deYBMNq9alkBAbj9OekBeTxPrn6hJsrLB3bVCZe30iPb0kGglJZ9uyXd2yR/tVNkAbjsHhycq8hJBYdEo0tSrMoxXcyM+ybVPXdSSYx5GnTsr7mINt5KBMP4oMYxR23bcGw2hYb9BfjmxmfGAIK6fE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:20.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08f8026-cd54-4164-3c60-08dd51fa8728
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1803
X-BESS-ID: 1740089062-312005-29070-14091-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.232
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmJhZAVgZQ0DDN0iLRPDkpJT
 E5LTklxcAk2STRKNUgzdDI1MLSMMVQqTYWADoi7h9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan10-185.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Added logic to check if the administrative port state
has changed.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 33d39ce62f..3f59c4a6b8 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -501,6 +501,14 @@ set_loopback(struct adapter_info_s *p_adapter_info, int port, uint32_t mode, uin
 	nt_os_wait_usec(10000);	/* 10ms - arbitrary choice */
 }
 
+static void port_disable(adapter_info_t *drv, int port)
+{
+	nim_i2c_ctx_t *nim_ctx = &drv->nt4ga_link.u.nim_ctx[port];
+	phy_reset_rx(drv, port);
+	phy_reset_tx(drv, port);
+	set_nim_low_power(nim_ctx, port, true);
+}
+
 /*
  * Initialize NIM, Code based on nt400d1x.cpp: MyPort::createNim()
  */
@@ -822,6 +830,17 @@ static void *_common_ptp_nim_state_machine(void *data)
 			 */
 			assert(!(disable_port && enable_port));
 
+			if (disable_port) {
+				memset(&link_state[i], 0, sizeof(link_state[i]));
+				link_state[i].link_disabled = true;
+				link_state[i].lh_nim_absent = true;
+				reported_link[i] = false;
+				port_disable(drv, i);
+				NT_LOG(INF, NTNIC, "%s: Port %i is disabled",
+					drv->mp_port_id_str[i], i);
+				continue;
+			}
+
 			if (enable_port) {
 				link_state[i].link_disabled = false;
 				NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
-- 
2.45.0

