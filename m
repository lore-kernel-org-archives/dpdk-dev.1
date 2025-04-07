Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DCC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 05:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECF540156;
	Mon,  7 Apr 2025 07:26:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
 by mails.dpdk.org (Postfix) with ESMTP id C0E3B40150;
 Mon,  7 Apr 2025 07:26:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxx+QaO/xRQXChN4Hz0xlZ/E1NGijjf0hFVK0xDXNLQzlsicFWbdgTP7fyPBVfvYyBlGvqUPw6Tfynlj35398EaOcjYnTpQcDO9CdmGyVGsqe5X7CWURuCj89kb1p/vOf+k/ATsAd1x9Vr5X9X1EnVhdFB5NYVgMbaevUfVwcOd/px6iq1EeDo9dBvpK57pZ/m+5r2bqSAL3+C9MoSik0i+vpfeeK+d6T1N89ZP5dkL64xp2DTRSQgpqqj475iT2w3BYdWBIlkFD6ZU9Lw7Cuq868ibV+QO6e+Ms76VaVFIUZG81NRMpFVqNwTSAgR1aWPypdyKIkzpvvgwdfIONUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wuClB4CRTYGugaB9P787EVOZyvQ3TtkS2l0F+L2nlU=;
 b=WF5e9oiFou9GfeslUco49kl/w0dyOtqIWl0E5+D8Azj8YtgPpdJvaQEbNH5FH0mJHJParBjcp5fyLbk0e8X/wQnwQmuwZF22n9iW5jU5Yus0Rd8NgwEq2nV554gTvtaYkAeAkxIDtObIEPhCJe4Tz/mo9Gar76ovvq6asJPZB8160hQuiT6cPg3tUMKegwIUoJaNSwxluxSYcem4KlMW7q6XOMYj7suUwwSky72x/BmcVST8svK225AvQfHFNEqsgcMsa7FBYo25lMb1GhlUkMIbdM0pZvI5imUnp5QQ3fRWm3xOh1fB/AhoDClxOdrwpc7MkQIvBdDQK03JeJzPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wuClB4CRTYGugaB9P787EVOZyvQ3TtkS2l0F+L2nlU=;
 b=SKHWDoHpRgkHz7SHqYKFihzJsN5WzIjsHM3ixTkRTBX45CIyiz8gJoUtIYn09WJ5LP3ULlCP8iZ1XIoo9hzejQsO8d2fbnHwixvuj2ehcuouuZ+IgW8m9pMnWe+Iaosjq9Wo3S9khIJC0LGqJSOHor7QHGq30nVab86Noa56pvok0ymLy6O+XU/syFcywVzbue/5lvbnwj4HpYT5i4mLByWheSp7Oo3U3KL6vxn399LQAoQE5Hl56zbgukk4Ov99xa1fEjYXS11rb/ckbH68PcMOYH2WgMR7uSJpbZVjyP/py8s5zPZ2c2PT2eKV244O2w/7LnnIIszLWkYX2dbBcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by VI2PR07MB10202.eurprd07.prod.outlook.com (2603:10a6:800:279::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 05:26:05 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 05:26:04 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>, kevin.laatz@intel.com,
 stable@dpdk.org
Subject: [PATCH v2 1/2] eal: prevent socket closure before MP sync
Date: Mon,  7 Apr 2025 13:25:31 +0800
Message-Id: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|VI2PR07MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b295f-7f11-4f0b-063b-08dd7594b121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tbFa9vL4mcvEr3bWJG6wRU3q+IjV7wJPEGRu33L1JLTCE2dFwSv7XH0jZTvM?=
 =?us-ascii?Q?0PnzUSZHVoL/E1Z5hWdVMIVmySFnb95DXXV95RhyQhtaJIr6hC+akbC2dwBj?=
 =?us-ascii?Q?2RNhcWpangL39IynSpIPvb+bqO8Za+U1Pim29BkX5is9pIjoD2tABwM/gJcq?=
 =?us-ascii?Q?gxDPOB19kmkzkMX26eMynfpVoB14HBzSGSFeBR2FDyfvkb1GjZpPIp6ydM+Y?=
 =?us-ascii?Q?RibN6LBUm3Y5g2VuehXb62TwUjLOt/VItFm/7rxOwZ/hNgbcqi8YXFtrTLgo?=
 =?us-ascii?Q?KHujZAUv5D4isJ+pU5/7X7z1JQyQh/yK1HfoN9LG8CSMTMMqXv1qQBnTc+8z?=
 =?us-ascii?Q?40wHEpjijYGTJOssLCroGZKyFbYVX7ciKHzbrPfiukRqmVJ9adY4QaVPQAHg?=
 =?us-ascii?Q?aoMDo8u7BUD768q/jRqV4G+ynp62xIPP0xHz3wmLCNybRngXQQ/dT6eXrY+2?=
 =?us-ascii?Q?d7LGAR1EfBGJDW/zjn0VeXu8jRKDc11777KXVaOvJ4mjFXO9i3WMJ4ZPPSco?=
 =?us-ascii?Q?FbRwP6WLbw20VtQ+mJ4o/i4/mHlg0PZePWk1CEX5mcffjAs5m+z8sKdXEsDw?=
 =?us-ascii?Q?q/xelAuOjAx+OdeBfceAfeTD33hB41lOmD2A7yZZ91U5yAihEXryvUCaI+4J?=
 =?us-ascii?Q?3LIudr9v3UBcZ+kIY37wkIDYo8scB5yK2RU2j3GMBCMFQqeywYfHGBNVrveb?=
 =?us-ascii?Q?4AQ/28UcB1BDKlB2SXQjHQ6ZriH8JQ23ZfTNo89SSBLWkEI+tWsL4n7dxgkh?=
 =?us-ascii?Q?fookjATKdjdCoY1yDSNX9gMZ33F0g3kV1/C8+aH01Lp3CeFmnNhVQ2XRAOey?=
 =?us-ascii?Q?acSrEc/obXQbrMfwqFdQfw2KzDLT17K0ZLgLyZt2Ju02VNaJovatcnFWgLmy?=
 =?us-ascii?Q?ORrD95zoecDXPLLNsY47mfdWh9wphBm6agooJOLP4w8wG1S9Bfae+tQfn7WJ?=
 =?us-ascii?Q?YDtRZIt01vPSO8SspQ35L1XMNoxmztIMAVNYMgaudrRrFC5ZyJ49028zZmDh?=
 =?us-ascii?Q?/xQc4kI8E/vglBS2Cn5PUA6bxrxhkNMbfWXgLrmCeqlEqQx4JsCyr6L5ha+/?=
 =?us-ascii?Q?F1m9uJVc4OyexwaWlIE1Zr6wK/PblgCdc1ykKgjs0S1fMh67t+dGEhuj2A8M?=
 =?us-ascii?Q?blGE82iwBWWAI8t31F7afKu/1G0Envx6vI70fK9pufRqmjR74CahHOvp5Stq?=
 =?us-ascii?Q?XVoYJ+a9+1Vo9LIeR/jBE6yYvG4G/cUCMNEXKiVeSNhQ2YfTyQqKuIP7W7ET?=
 =?us-ascii?Q?rj1R5jKMIYFjZ16s4nxjmJuhSVcxlA+L5h3CAPV108Y6AVQZ0Em4WaNqAN7Z?=
 =?us-ascii?Q?R3FDailMd/0LdO0on5W8MW5V/ysqC9LE05YtxL9lozOShXJXSao0m1W++PKY?=
 =?us-ascii?Q?vs8RwkmJu8ts0IZCIWu/DMYDzhlu3vmNB7Bc7muFbkfyuPDRq6KNkEuwm86R?=
 =?us-ascii?Q?zHzAAs6RflY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyRUYOJulD1qkXGOrtPm/lT/hRw98XSOWDIx6M1ytW174oTZOv2jYKZeQP4x?=
 =?us-ascii?Q?Lhp6MidSWeEutF9EdWuLo4p7zJ1/Ye2N+rUqLKc6yjwQffD1YpamUOjMk/3c?=
 =?us-ascii?Q?f0+QerYhzU076JOaTj9afTGs4HfzgzRG1TGmgiIUjDHKe3D8Fh2nGD6C+e0r?=
 =?us-ascii?Q?gvTEGbBZQrZ4FcIDmCPx1H9TT4QKlTDNPMspNj7ofiBOPgj/9rAJTIsUXvb+?=
 =?us-ascii?Q?ZDO5hQDRoXK16cU+KAEJVjR4jbw0QdrL5KISi11gB7CHZ3szDT7W0bDI9WvO?=
 =?us-ascii?Q?VkwHysjtj0G2/rN568CEC0SNYhYZEQaPqV1N1C1fsPpB0Ud7JeL+7u53iII+?=
 =?us-ascii?Q?bHrFuA2yI5BZh9UzFSEubBBlmzALnKTN2irZrfI02O46NssePOAKXrXVGeFW?=
 =?us-ascii?Q?s7rTTk86j/7YbKnZ6MoaMpjfzGwMO0S1oywDIqBA70OyfrYiGOLondZ60BW2?=
 =?us-ascii?Q?42PrOsZ4W72RPwaqKwK0zf1G1eSTQtxLiUUgIBqa0pcDE365aCKhVqUu3P32?=
 =?us-ascii?Q?NEX7BEljSGvcAUTczmZa0oSRggi6AHqJDiuk44qzaWeRB4ozj6+g+Atk8u4B?=
 =?us-ascii?Q?oW66EjRPbg69UoulXZM3w4kfKkoXzIb0JwGFM8gaMaMQEPCOfOKEPOC6wE+Q?=
 =?us-ascii?Q?TF297BZphPFHJ5IGqTcMIYYG2Fqjpv33s3wvr6t6HMYOB695bIan7tJ4u2nW?=
 =?us-ascii?Q?Ay4VroQFqFpMYcDqLo5ix7Jew1Mae7eU0/uafadLmiu6vKPnzwFteDWmUiUE?=
 =?us-ascii?Q?vIZFol9QKOTBRAL4/5DJuNIYiUl4ekIhFSBvhzfqicvhUYrMV+otiRHBObyz?=
 =?us-ascii?Q?9rl8IPkT8307t2Vx1r1yNnCVBfg6BtqxqNllabMYdG6WPPKWnMMt5HiIuA7w?=
 =?us-ascii?Q?pr0L84S7xwD3e4Z7TUoffd6AjCTqS2w8PqrBAPJJnrh+f3KbPCBElr0mMEUM?=
 =?us-ascii?Q?nqXhLbmJ5mQqWMM6010UChZGVIYjFDkQLJLVJnWm2ABp5Ay+LXcFZan3Rd9N?=
 =?us-ascii?Q?KNezEPqUX8y5GwjS2FlyvVWjzkrznIk0oeV0AiFSbaddsHDE9NkjqelVKqTQ?=
 =?us-ascii?Q?GRePWb+c4ogyEeE+VtsbIHaamK3gF95lXMWT7/PWnMpais1qiPN6qvWofk5S?=
 =?us-ascii?Q?7+tFKKDeG6XcMhvCGJC0LI1y2daN9KQqvyhOSa8HnEzjUwYMLqRXmSvdZpPp?=
 =?us-ascii?Q?D5trHvSyPzWx5wnXAa1b53+m/qwqdYjngDpw7sHgHUsdaxNyt5JlPzn1AHcS?=
 =?us-ascii?Q?cpu9iYNbugEZv/y2v+5lY+NeZ8z2MPfJjRFOHB73DQpOE9AHIB6ly5r/T0i5?=
 =?us-ascii?Q?Q3dM7s0Ip4j5uYCWks20P6zz1xUQEibFmzg2eiOqV3bufyh8FJC/nK8EX8kL?=
 =?us-ascii?Q?BAExA4hYXL0NZ6CM9qu9jb80oyWtsIe+pqWPUlZ65LDpILV5xzgbjuCmRgBZ?=
 =?us-ascii?Q?fu3JI1Bo6c/4/49wCZhof/yQGVQguLdRNRECBmqyJqr6FrurvKjII/PA82By?=
 =?us-ascii?Q?utuLFzzsPX7E7AzCG20rdunyWA62v59m8ZZy1+bqnHX7AjDTgjAvSguHB5U8?=
 =?us-ascii?Q?SlPCkxJVdPsqiC4X2laC9Pe9K2byWOurjrGzaPz9+M+DpJtfQxHdjOJShmCD?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b295f-7f11-4f0b-063b-08dd7594b121
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 05:26:04.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7fHYcDRxgxuGjQFoV5YyMUka7BnbwdAMTQ6oDsv39yW59LujHpN+PPhtVPoVtW/EA+YdDR5Ib60U5a08laRaoRS/6pPM+hMId2PC9tGi4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB10202
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

The secordary process should not close socket file for MP
channel before performing MP request synchronization.
This prevents error logs when the secondary process exits
without any operation on the crypto device while the primary
process starts the device.

Case situation:
eal_bus_cleanup has been added in rte_eal_cleanup. But for the
secondary process, rte_eal_cleanup firstly performs
rte_mp_channel_cleanup, which closes socket file for the MP
channel, making mp_fd invalid. Subsequently, eal_bus_cleanup
triggers vdev_cleanup, which calls mp_request_sync to send a
message via the MP channel. Since mp_fd is invalid, error logs
occur.

Error logs occur as below when the secordary process exit:
EAL: failed to send to (/tmp/dpdk/l2hicu/mp_socket) due to Bad
file descriptor
EAL: Fail to send request /tmp/dpdk/l2hicu/mp_socket:
ipsec_mb_mp_msg
USER1: Create MR request to primary process failed.

Function call trace:
1. rte_eal_cleanup->rte_mp_channel_cleanup->close_socket_fd
2. rte_eal_cleanup->eal_bus_cleanup->vdev_cleanup->
rte_vdev_driver->ipsec_mb_remove->ipsec_mb_qp_release->
ipsec_mb_secondary_qp_op->rte_mp_request_sync->mp_request_sync->
send_msg->sendmsg(mp_fd, &msgh, 0);

Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
Cc: kevin.laatz@intel.com
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 lib/eal/freebsd/eal.c | 2 +-
 lib/eal/linux/eal.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index d07cff8651..d81f12a7b1 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -899,8 +899,8 @@ rte_eal_cleanup(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	rte_service_finalize();
-	rte_mp_channel_cleanup();
 	eal_bus_cleanup();
+	rte_mp_channel_cleanup();
 	rte_trace_save();
 	eal_trace_fini();
 	rte_eal_alarm_cleanup();
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b1e63e37fc..73ea47b12d 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1318,11 +1318,11 @@ rte_eal_cleanup(void)
 		rte_memseg_walk(mark_freeable, NULL);
 
 	rte_service_finalize();
+	eal_bus_cleanup();
 #ifdef VFIO_PRESENT
 	vfio_mp_sync_cleanup();
 #endif
 	rte_mp_channel_cleanup();
-	eal_bus_cleanup();
 	rte_trace_save();
 	eal_trace_fini();
 	eal_mp_dev_hotplug_cleanup();
-- 
2.34.1

