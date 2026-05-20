Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE4CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7EE4029D;
	Wed, 20 May 2026 14:58:20 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
 by mails.dpdk.org (Postfix) with ESMTP id C0F1440144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:58:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNiCOTXbqFtH8SuP1RE49Ni904hHXrpHO5ytcyZV8C/OwVWJEpwbUaNoMvKkm1alZok0lgBxDp+pO6Bpw3p6XJiCS0iLmVEN/CZSLwW5/U6ZgepE3PnxbYSufDt75NE8ro8hVGOwwI8GKIsXnqDaqRD7TXEOLFKFkGwHGBpX+Eg3xfW74REy4jdvVxy2AzeZpte9XAb07DXqkBPJ7UhIUdFPiOfWC93nHkXAPdYRl5BoG1U0T84F+zL7wIXQS6r4xJGQB4S7C71oOfLiz3wypktsHsE+tz097dwnLi/abiG5AnwJ1FA4Itqvb0NB8b5KVCmhc/Iy2b/iOVTMzPILXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVlKlovQWEnGfthy5ZeP56O1TuL3lTF3JbKrs4gndU8=;
 b=K7RUemV0MHuiU7KZSeZkTFh4qWk7FMqDra09tVDg55Py4uDCYxQqBz5LzPIJLEN923BhAf72u/fGs6yRA1befSmJSd3Xnbu3KmmK2pY6xXAjE57zR1le4/XXiWQ0wANyG5S8c68v9FXYL7Dg/KUN4X16PDjvGxyRyWGpw+e9G8TKRTOxmhwwlfyPDWTZKic9MmY658L4a/1qq3LeM3pPBYiwjvAysPYrTHgkmW+HDSsnm2nNddAI0MQc41RVq2fXfz6xonsvA7rqo8udMfSDlNe6kP7rH9HffGw5FlmLoRD3FRZjpmwTb85W/xDCDXm+WQ2Q+73NQXN21kOpIs0w4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVlKlovQWEnGfthy5ZeP56O1TuL3lTF3JbKrs4gndU8=;
 b=lLZRTTnjrmHW2oi5oBqwAvtXX1hgDOF09FvIKpkwgDArODum2NIMHAPNHcurHSorcfL7/1OmDMXvJOxsOd8uE7AyTs9RbUziVMvYYBtaxbWA99m9BHaiWUmAa5gGoQyDEBw6+iT9Kn+v/thqGElSkHuETgyQ6XWigF4xTKjyKmym4co/QAfWHAfxpWg5dhTZol1dafhB/pP7rJfOurdBasNaYlhNxQoCSiYj8RvyrOwAMvt6g7PAu9OcWJjqQVkIOcq7p3r29Vggrmk1DQshMIqDgtfZNunFegw0zm6f6pxP7/4t/iKlxxONT2dvQ2hOVjuCKbU7jI7zQ/uvT7c7xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DB7PR07MB4794.eurprd07.prod.outlook.com (2603:10a6:5:34::14) by
 AMDPR07MB11113.eurprd07.prod.outlook.com (2603:10a6:20b:71a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:58:13 +0000
Received: from DB7PR07MB4794.eurprd07.prod.outlook.com
 ([fe80::7fa8:e8bf:b61d:184d]) by DB7PR07MB4794.eurprd07.prod.outlook.com
 ([fe80::7fa8:e8bf:b61d:184d%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:58:13 +0000
From: Michal Sieron <michal.sieron@nokia.com>
To: dev@dpdk.org
Cc: Michal Sieron <michal.sieron@nokia.com>
Subject: [PATCH] linux/mem: atomically prefault hugepages in alloc_seg
Date: Wed, 20 May 2026 14:57:56 +0200
Message-ID: <20260520125756.530808-1-michal.sieron@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To DB7PR07MB4794.eurprd07.prod.outlook.com
 (2603:10a6:5:34::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR07MB4794:EE_|AMDPR07MB11113:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc4f6cb-87d4-4801-60d9-08deb66f7376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: QcmfRIakcm81/dDZHWL1cBfY9MhCVR+za5lMArMWUeYOb4DQ6y4quflQxbUwnhi97P6DSALi6vwXlUDw43850bDck/I+CQVNz/jMI4O2m9WSbmUuBGmeStqvvLZXpFpQNOmOpNuJgXL8Tg2Z4m2U/8ZzK6hRz4OatvXOVibk5HAShW/5uCYH5Eo+8W6WOVMkKuaiTdFJSKgUt6fyz6WwobTriXO9HYNajr/XlrCkV2FQd/VdJaV44DPdNdC4fpbzI8Dej+t9yj0ILpNZuOtuHNaCxWKYOohpCooSsfFBm8FYGVHQ5dFtMuwtflWCX9LVuKJ6HYOg/MKl3KjwIVNb6HAFx6teCEp6Cf7dEx0yc9/4+AaJq5/6BQd8jJDAm1WOwC/DAqRPX1BPYwtLSJZB77GcELrQFxvgYWXGwkgeRG2LNI/JNqYI9p4SE6O8oa1GFOn6n+q60MD4uZNVI3Fos1uAMgvuOL6PFQeStZiVRDcSG6A4MudG6FtHDLoLKx1rdZlB9MW+fA/2ufO/zThENsMxD5GP49qPMsZyhUEkBWtDMQAo/AGO6TldVUbl6PWTMtUXs44+gUZY/3GZJn/cnF+Ad0ZJn79U0hl2QAVFo6tmrY+OXSYD0JTG6R3YF+/br/38VLSCgdoxUGJtYDRFj7/ChDO1L5iVTo6ow1mazha4KfVE7/tAoHS8ty3Dhwqz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR07MB4794.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlP8MtWYeGn53HQkmF2v6ycXPGobz9qgYLZcgo/q4qjsvuRqzUYk7dEA2GPj?=
 =?us-ascii?Q?WBB4Z6tHJCKElMglUgKTRAMn6cNxosjcQE080CjWZ30+We7Lw4rtscGXPHiw?=
 =?us-ascii?Q?9uld+uH4f0ECn7Xi9jSPcoi4CWVm/dkVz1MikPn5UXl+0LOK66+Xo+WDfiZQ?=
 =?us-ascii?Q?P5NKMTSmmzkd9P7bfj9WNrIRCUYmz/dXRCAQr1bkxppoeo6YUE0L5EConSe5?=
 =?us-ascii?Q?un9Nc3XpPkyqhekjge4P0a7XCJbN9FSVFXx4CbAWDDlCUEeZj7N0ck3Tk11n?=
 =?us-ascii?Q?8wH5QGw6UR5gc49COm3GZ7Xq3DXVX8Kw63CVKiQryR+Lwyz91QBOTp+3YPzk?=
 =?us-ascii?Q?uP4LZl1rouIDQdovepd1Q6AU9OyCcOHurT5E7hsVCAGYAREni2mVPCGtoOgl?=
 =?us-ascii?Q?JH8L6Bb1gZMWIBf9yHWV4mgN6orkKclZ+3nL3YTG4RQ7nAZ/DIvdMQxow/LM?=
 =?us-ascii?Q?eVXNCTk2Ph8DfjPXzLvrgOUCbha/N8U93/PkBrQk4fR/rYNjmCWH9W5jWtjD?=
 =?us-ascii?Q?kNeYubwbYNC10ensKjUnfI3hxPBPc+vhxp6YSbmLhXmdstiwF72Anrvz4Jns?=
 =?us-ascii?Q?WT+OToefa9rfBJ3LL9k3Ij1hHuSYQltrj2REuUXc/zO1qrYfsjUhoBQ/PwY5?=
 =?us-ascii?Q?yFL1MZVGwr28vFugpnqHYr6IdL3c6dhRT1+o6wYTeWRqOSbQtxRm7PAttThy?=
 =?us-ascii?Q?oKKc/OTFLLyODRrJDpkeWrzMybybDbkWx+WUIhBmf5WeV6RbzhknJz6bKuwk?=
 =?us-ascii?Q?6Qs4SsNmOCIdZDQugdxZbj8V6QmXCmWpat7CXwN1dJd5BHTjNBkyyZ3JtdAJ?=
 =?us-ascii?Q?j94PLs/H0yzqY/V5IhaV7vzy9rCtDjU+oKIp0cHtGjDIw1hy4mlB3z/vu646?=
 =?us-ascii?Q?4ECXt6OUUX6eTIZoDa+C3WNS4OC+uVOAAAYP9BGrVe7PipVaAsjCm14Zzcp0?=
 =?us-ascii?Q?V/etixcfZRD42CxBH78CyHh6hGlBUMBhRt5Auf3GmhD8kALF4niVvma14t96?=
 =?us-ascii?Q?WBpbIRe/PnEQKKQUbRgJcPqpNBkrmutAMZPEyZapdox9QwbIgfjkcrbocGDZ?=
 =?us-ascii?Q?cEdz7BdJ9ED6PFsCBxUvJOo4SivNZcTvfhL4UXfke79mMLwtECgFX1X8EgCW?=
 =?us-ascii?Q?fFt/7aXNywBV1navoJlwlKqZw/WAJDL6/mHjoESmZvVxm050Z3kMypva0qqj?=
 =?us-ascii?Q?QwWA2ICOVFigJbEy7PZWSkKBI7oCEHpQdLJNZ7OsH7waF7d4bLvT9OLogtrS?=
 =?us-ascii?Q?fNbWGfSAN8gYIzLIxBLmq9X26xhrP4Olpn3I8bJZs90/qhHrpS4X6OeZU5/E?=
 =?us-ascii?Q?8u1qEhbc2VPE+Yj5SOA0CqZq0UAZfTVoFk/mLSsjls3yvm3AX52Sq3OL+ofb?=
 =?us-ascii?Q?Df0DvHF6TYnIKb0SeKyhf+6QgKoRlbdYGBEFr+8Esmz7z43AqMaUgOWBSfYw?=
 =?us-ascii?Q?YMHaQbDo/idS7wJH4poqrUU+THQP8a2krbr8WraW2ZryWmXFVuqoquna7+Qj?=
 =?us-ascii?Q?Mv5h9ukUuoX/+TQCFTSPktVfkD8lT4rQKp1KKe0dgrQdmEPLkTofkufdMsPB?=
 =?us-ascii?Q?3o3n3wfL1FGkDR6syV8JxlAw/ICEDO3UtL6/2b3n89tkE4HlFHQNM2aweecn?=
 =?us-ascii?Q?v5pP3tIdBwcfirou1krJVpQEfLcijdxjNfx7Z5loIQSFmnsy684xmmQoaBLj?=
 =?us-ascii?Q?np2VJGUvB9Bd+sjusVKDJLUnrRrJASoyveqWw0jxaztkijG1vO7VkuT2eyGh?=
 =?us-ascii?Q?nYu+q5W9YA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc4f6cb-87d4-4801-60d9-08deb66f7376
X-MS-Exchange-CrossTenant-AuthSource: DB7PR07MB4794.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:58:13.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8XZwtbhZaqwKi8uk2MPkOXJ26B81V7O4anVjOQ1CuMu/rP6D23LHpdbk/WGkNXkmZ2+sStC+w1jmaLhY9ej5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11113
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

In rare cases, when a secondary process calls rte_eal_init() it can
cause a data race during page prefaulting in alloc_seg().

An atomic compare-exchange in a loop should eliminate the data race.

Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
---
 lib/eal/linux/eal_memalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index a39bc31c7b..cb92fda2e8 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -30,6 +30,7 @@
 #include <rte_eal.h>
 #include <rte_memory.h>
 #include <rte_cycles.h>
+#include <rte_atomic.h>
 
 #include "eal_filesystem.h"
 #include "eal_internal_cfg.h"
@@ -600,7 +601,9 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	 * that is already there, so read the old value, and write itback.
 	 * kernel populates the page with zeroes initially.
 	 */
-	*(volatile int *)addr = *(volatile int *)addr;
+	int snapshot = *(volatile int *)addr;
+	while (!rte_atomic_compare_exchange_strong((volatile int *)addr, &snapshot, snapshot))
+		;
 
 	iova = rte_mem_virt2iova(addr);
 	if (iova == RTE_BAD_PHYS_ADDR) {
-- 
2.43.0

