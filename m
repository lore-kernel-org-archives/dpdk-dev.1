Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE4C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1771340BA0;
	Mon,  5 May 2025 09:13:54 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF7840A7F
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:53 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104]) by
 mx-outbound14-199.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWh1EJ63e7G8WS64OiXA3C0lk1f+GrcQMwwqnr2aqXGtCari/kqJXVCVTJLV77TVCPnDNpa06qdHsM3UMVrXVPNBQ+8DJsDivdQm0D3RMNKkoaXyPip+G2otKkYeQae1EdtP+JII+TTt5yMu6Bsxv27rAimH5/L4AKW/j/JaM/GWd0P4mWLG63emQDfIH8B+88Ev+hQPwdeX9IVa0BooMM/DtThh8xMLN7kcLWwcyTKQY52bp9U7eJAxfBwCV2zEXeBXwfOLY/oGv0GF+7EHGPEZLIuH1fI+Unoh45hQLjRvsAb//elJYec1w/2457u0zuZ+SRvO1cLPZuK0q9v7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SrgTiIZtYKZBmjXsN7kMb5yqLRwnAMB3cMYm67uxME=;
 b=nrOelsWOootdyFC/9spamAH6l8/O46ufBEyPwzRg3d6uAgoKvbErSfrfV/j0uPv9attka8IV44HyT2b6Jec2pdpglk6v20NotsiEl0CqsIfswK2CVm+9pQs65VfNOPqfl6f++lGjxvqpDn1lTS3ycG78WODqL88NXkPRVUIbmCce0fUMNXYUtdtPYxol1dRq67zFmfW5Gu4p79M7nbJV0Spm2BgHf7tlb9OrkeLpmHQQIrxGqATldrGttnqEr81kg8PE689fatwrUj2K4gaUw2h6sAtd1+k5k9kLFDcLdKzmJeFlKhGfVzs4C/raxRZUoO2iHeFXQd0D7IqdJjpeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SrgTiIZtYKZBmjXsN7kMb5yqLRwnAMB3cMYm67uxME=;
 b=LXNpazR173KaimrEfxSpxVZMjMSUSfUyFzS5ea8ldvo6Tq+Aw10En4F24NFOR1prgo2DE8Ot4ZckDsBxyt3V6KmFhclMgIsf3SdYvcxjZ9zNN+mFw6za+aIpIlnT7W411OZu9tePuiRfzeTUEWW1JFSbsLX58rEwBecoyDDgvKM=
Received: from DUZPR01CA0308.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::19) by AM9P190MB1283.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:272::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:32 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::e1) by DUZPR01CA0308.outlook.office365.com
 (2603:10a6:10:4ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:31
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 26/26] net/ntnic: fix operation with rte ring queue
Date: Mon,  5 May 2025 09:13:06 +0200
Message-ID: <20250505071309.586015-27-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AM9P190MB1283:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 97197edc-24ac-478d-eff4-08dd8ba457c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y3E7yX0VVpXfL0ng5xTRhlP+vvtDwmzCA7qbgR5pAqdNHkZB/OQW7Lo5RqG6?=
 =?us-ascii?Q?Plel2AddU74+Kt+CqBjniKzGsG06IHlW4KxoBERnNRCiHcr+VFhuA/bLCvDg?=
 =?us-ascii?Q?3oQGrEJkTmBWHA19bCH+0V23pQqQEVqglQWtEk8uNSGVcaf62LgcTOkgyG0M?=
 =?us-ascii?Q?c/s+LZ4SmT2RFy9ONR2OfCwjQoR+on+2MOR4rlx2R1FK/XhgVMTJ/w2/rD0u?=
 =?us-ascii?Q?PCgDw7LhaE083FHt4iwZ0xroUYcX2YPY67WvcZ17W7cIZb5jNQb4A8zYY3NR?=
 =?us-ascii?Q?jN2OxY5quhN7s3XI4NePlIF8ZlWpPlBTokmte5SH++uyzuqD/hfMV3d5Z8Rj?=
 =?us-ascii?Q?9ipAn8zQuEHojx4X83MiyNuG7KkfrR0wcgcYGg+wnjeuH48RyobGa6YjwE3A?=
 =?us-ascii?Q?0N73K8Rk6JKbjyF6PxRy9Nsy1qwKKVhFgPP7JlD7vCKe4B2eaKn5cY5K/DHR?=
 =?us-ascii?Q?zqiJbhdpBMtqu34ynyd/sGAYcYlStpWgVI5PoWYAB9Xb3M94TyqjxO9RIWtd?=
 =?us-ascii?Q?ba248J9txBsgxfAQ3VpT5noeAvUkMbWShDCh/GDmIXrGjoQRq2q6M93Scx+g?=
 =?us-ascii?Q?W/kLw1xI1it6Wn/O5yaKaagt8c7H8dpeYgc+FWnkPBD3uC4usZgszU+oblhZ?=
 =?us-ascii?Q?lQaSqk5SVGwDoXoECm39ackTOcmjJMJwpeUlRFu5o+1ch/S/2lKz/eevl+fO?=
 =?us-ascii?Q?JWah53b3o4EdazRNLL2RvxphqNLgYLHjE+poD8a+EmctomEPIFnM6kcpF32u?=
 =?us-ascii?Q?zv7X9q61BEw4JFtXKi8fVjyQduoBrovOlrTKsXPN4iBbOhzfGQG61V6sWJkv?=
 =?us-ascii?Q?PcTNEDaH7/cwscW1hfokxPOxpEGssIdOd93ySty+s8Vxo104sl8MPb0iPHdU?=
 =?us-ascii?Q?RmmsrEJ3WOLVD+ArDsNTKdp90e6mcOtFXgDZEV8/oB3eAz4YLY+H31tBvreH?=
 =?us-ascii?Q?kjaa0dNdSTk7Mz85i1FOoRi3pEoJ/j4iVmqDKq0KKe81vuqXGo/qXgWcTTgx?=
 =?us-ascii?Q?i/8pF0TT+3D0z1ht3vYNNcbuO5rLG2IxfawRWiS3kQPtKqeOUmH9niPRFM3E?=
 =?us-ascii?Q?XLZ+b2KIOk2/VTpV6iHb25T4/1Sd6zelk9ouSzqLYi8/rSvkWKdQXWeZIeQh?=
 =?us-ascii?Q?DsBdaQe5pqMlOnErIBV+Eo3m8J6JYQr6brBory72lRqq7oHZfJmgnVNhOi3G?=
 =?us-ascii?Q?RRY8+EGcUpleTlmnXX00dZa4KDwkvryK/yLd9Z57cKzYcVI6xWblHkVFILmF?=
 =?us-ascii?Q?gYXYqAvqll8o8HRtR+0gya3KVS5yfmD/7VuaMAhNlFASxSqGFiWO4pdsvwE6?=
 =?us-ascii?Q?b4rNYCLfBZ29ZyB+JPvIyblEGJdRv883v/I+yVmUCHcb3hehujUfAejmcmd+?=
 =?us-ascii?Q?f7avl0ZkwkD1O9fRpp6Og8HhdZznrE7U0lkd/NHCqBw6kv1qYSnfN7sQZT3V?=
 =?us-ascii?Q?e96DWB4lHXpr7wVykV8z5zHWsKgI60ONlLWMNgWRSQbbuTy9OqCmMwLE97VY?=
 =?us-ascii?Q?FCOJuypoNGxVyNVP/6xa5r+BIe/adHIZuppO?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 07Qesegh9j4Wr3/cD4X/VWGcY1btYMTE+hOYYEDoGWdHqMV64TsNWXq39vlsRLpr8NAvfLCTgccQaK+cwaeZuO5jwkzhTk7Ezi1fC/wKJQyT5R/5pS4u7CmZ7F5+ojTVFACj3h4Y46JUtBatsLOcWHgQywJIwJJhx7VRDVzEZiHq5tzECet8O5ASJkaso1KIgUZb3+XQ/9+5zXn2UDOapPcBC9Kl9xsDQM2iboKsCv9bLvELJuZuwkFEWcoRhrJAUy1CrOegxevyBRlIJe6+q1rBIAGF1d1MMnB9chsxRFSrqguDZ2hHEoi5zevAx7S/7VY/izRbk3tnmjxyJoVabUB5rWZBXHc7q14fpkWOPMtGHbQpAvQDtmB6j1rUXCKvL/zElmU6Cpb2ync4FnTG+9fbQ27hLaAiYcJXiGPjnq63fFNKlVikIH+rWevm/Q/yf3tY1icunvM6ExObW/vj8yR6gum78qulC/wkec7s18WD5+itJXmW6nN/ePEmsgkEro71ur3dCU2399u0TmFijJxkyiQBEJdFE2qCwzfN4GfMDoTxwKLryWY4nCPxwjmn+FUZG9jzI1hw84AX3Zhds40ubbd2dwU/5FFOqRHmUxaiFNzudgIFEDn/G/DGUCizSPwlJXeAK1kXDojI9XV31A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:31.8325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97197edc-24ac-478d-eff4-08dd8ba457c9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1283
X-BESS-ID: 1746429213-303783-7661-392-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmZkZAVgZQ0DLZNM3MLNUozc
 LAxMDIwtzSMNnY1MAs1TIt1cQ0MclSqTYWAN6aJxRBAAAA
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

User should call rte_ring_dequeue_zc_elem_finish to complete the
dequeue operation. However this complete step if record absent.

This change rework queue read operation.

Fixes: 96c8249be53e ("net/ntnic: learn flow queue handling")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../profile_inline/flow_api_profile_inline.c         | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index cb6a66a061..f78c6fbf49 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -398,18 +398,14 @@ static uint32_t flm_lrn_update(struct flow_eth_dev *dev, uint32_t *inf_word_cnt,
 	uint32_t *sta_word_cnt)
 {
 	read_record r = flm_lrn_queue_get_read_buffer(flm_lrn_queue_arr);
+	uint32_t handled_records = 0;
 
 	if (r.num) {
-		uint32_t handled_records = 0;
-
-		if (hw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p, r.num,
-			&handled_records, inf_word_cnt, sta_word_cnt)) {
+		if (hw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p,
+			r.num, &handled_records, inf_word_cnt, sta_word_cnt))
 			NT_LOG(ERR, FILTER, "Flow programming failed");
-
-		} else if (handled_records > 0) {
-			flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
-		}
 	}
+	flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
 
 	return r.num;
 }
-- 
2.47.1

