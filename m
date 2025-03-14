Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22DC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 10:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53B05402BB;
	Fri, 14 Mar 2025 11:37:01 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
 by mails.dpdk.org (Postfix) with ESMTP id 2E75740289;
 Fri, 14 Mar 2025 11:36:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6Wp1BCanbc9pF/jpTL9qNmeMV6svI5x9JAO4XZiuhejzg5YkK0GS7KeIIuxxw7uDIeOvnZVPES5G6c/nI47/3svI8Vd01Vzlgj8A3t9aqAO3U5CL9cudPw1wXNfZ/rZQpPan5U2oAPTOPnOmzZh125mxegNFF19eg+WOmlmi4wBO+jeKBAc44CrsKZdUo1JcUW37AE6REDDmLEHsWlNRoahABayFYn1QKvg+6Wg4KmvRdbtnVUVhiwul95/umw+CTXID8cv4he8yH5hEz1VtShn0H4mYGpHMl+0bWgxjEuOMbs1J8Db1mHxva4gYsFj6lgOrnijFtq9mVScV0P4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbSWkC2c7LRR/eFKxIzm+h2XeoBzFUwyzwsbzzuVTT8=;
 b=b+uwm9n4bdM1flkr6RKYvLjniiSMyhh/1KHOdgs4U5orvCEqDQYBtPlIzarB0r1huzuGT5HAcOffafPREGXtPf2ZiZSTClDWMQxDDHqcTu6ohmBXfPdoyGtPLeozZMt6GxQi77gV8bR0zN9w1aHJlfoOOs4WJi+fUzvVftfLgucwRqp3+SiU3mU3Uyp5ffoPA6UhlLYbqItEELHbeZjHPjZQbqBL/SIle+U7bbef3fPwPKbVOZeVR/IunbFJcni+7Om30S29sZ7DDtDvZ+hjebShFpX+F8JtuIEogX3agUWvT5agObUi7Bg0uY8vmrZIP0o7ubiIFstnrUcZubhhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbSWkC2c7LRR/eFKxIzm+h2XeoBzFUwyzwsbzzuVTT8=;
 b=TEoNNqjwbZsO1f03ik44zQrEqzGBGOkl2sPvEeAXmatN80PhNkN2GuHPbBt9VLvwJaC/LFYhF1tcYCMvUdbe5ROQRAwNq+2DJsjif68Zc5RSwNznrJ10WZrEo3vvdRjaLk73BBF/QgEQ/dGutw0nuK6gBxHiHjrXz8z96Ws8ZYUSAIRiGrWjK1LHHIQmfFMMWm9ugHYLvz64gjm44CkSh+5AEJpUqUP5fhOnfzozqg3CuOcsEuXn7jmyMkBIzdIhhBTe46SdcezcJ6uCVUzRL85Mx2XkdzwHFe5L1iDh/KSrApt16OTKAmIVN0XBro8CWooDKCoCsZNh8plyfHVvSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by PAXPR07MB7968.eurprd07.prod.outlook.com (2603:10a6:102:13e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 10:36:58 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 10:36:58 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Cc: dev@dpdk.org,
	Yang Ming <ming.1.yang@nokia-sbell.com>,
	stable@dpdk.org
Subject: [PATCH] eal: prevent socket closure before MP sync
Date: Fri, 14 Mar 2025 18:36:38 +0800
Message-Id: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|PAXPR07MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 44510214-b302-4088-bc15-08dd62e425ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8lkmBN7nSvr7L9d59k2sg4hgXXjB/0LJdM+vohK1tz49MHZhArcSmFgMzW/u?=
 =?us-ascii?Q?8AbSCVQyMparzR8nv0jznZ02WcBNx7+UQa3M3SLoWvQVjavbmW46OtZt3vXT?=
 =?us-ascii?Q?jeoMCpnxZstNEr51h4sLovP4OoPZsKAiwIkR8wB+21xRWZIbBs8hxozMh/tz?=
 =?us-ascii?Q?JnYokWD2GpyM6dZZact1ZAArWzR/lwT4eiQgUh/cUon4+6H3RSKpxYBkgeR8?=
 =?us-ascii?Q?eOcUuipuWTirQDh0XLze6SiRX/utmoVq+Ftcli8rOIaZk/56r2G481E/Ga7n?=
 =?us-ascii?Q?w48jRserdh+R5JiWffiiBojcyYeNzX0xh8DSf9BUBHiLfMcIszLOAPWbGZMm?=
 =?us-ascii?Q?1akSkMuE2YyprLy2j8PZBi0fNTuNrkN5jnkeIl8rxnSVED2S5SMfLMNJFyUd?=
 =?us-ascii?Q?S3MvAjiBNPqm0PnAQGXull211gUOtERJLPZI4UxyrFOZPpaINytyzWMzhuzM?=
 =?us-ascii?Q?lRfJFmadsMXMOC3mkei0Ckinb5MFxj+u/V2tJsaRGjZhQZbPT/FBUsA1bGwL?=
 =?us-ascii?Q?ykMqxHkNH/EswnXX5O7xJ3DBU4NOBWiRSTYyI5eXbx5DD+O+Lp4VuD8LDU7N?=
 =?us-ascii?Q?VqjzCQ4CkIR5PIyWTpuws2ZZiBPO+dDeieMcUbpJtc3xOnncjkLVzaCaZUUz?=
 =?us-ascii?Q?wYEAWpDQerVPl0H2JA7thDkfSOu/BF921CuKIw+asfiagTazTVYCHnvD3+F7?=
 =?us-ascii?Q?FqPLLTKm0oBkIAN3tb5nmOQuFp6o/12WSoWEQ0ugAzwJ6eBywBX0AXu0vFNr?=
 =?us-ascii?Q?lbwYiWVo/ULz/dmOWz4X9aRzltP6bVuqVFWkydKA+hHOdZrGZrstb7YPvYwV?=
 =?us-ascii?Q?oSNNi5bCwNcmlR5uujP/IUzA5sr2nID1nsWIkzSnHDryq/PmY8x4bSRecIgi?=
 =?us-ascii?Q?M7Ji+y9bOJ9MfA9d/OcBLNjxs53/W1mKE0n+SYyVfOHB0jop2bDsfpCJ9NqB?=
 =?us-ascii?Q?wHQn8vUPqT1SfE0aONkfJrAELBbVmR8w1x5ej/+m7q111Q5IjhAJ8zHZoNsr?=
 =?us-ascii?Q?MVKwl07L+UpqcZZ307OLTGY1msTcki7VZ1E1wkGlkzS+PkL4QTt2xsKLlMcG?=
 =?us-ascii?Q?TGKkarzt6T5BnXulWRPzM9XxBXQq9LH8uV3fuhvmofHBaheiQgIN26Svg9XC?=
 =?us-ascii?Q?xffrOEPebeJksJ4sTlyO92LOI2bie2pYadnMAdCBSWydEQ1fWZ5XQ6FM4kUe?=
 =?us-ascii?Q?C7j+Raxo2OTBB0FSkIMZrTeslGWv4R4HjiI3XQ/ex1f5DDQANP+vzYdkkHLR?=
 =?us-ascii?Q?XUm75O2JQHWXjO5frx1u0Lrh/LIcJDh8XLbxTOzT3iXo6BJ3iIGSlyGZcMa7?=
 =?us-ascii?Q?/WOh/E7f49YEzKM/QHD+idwAXb/jiC7HpmV90fofk28UHTjclIgNFvU24phx?=
 =?us-ascii?Q?0m7vWhfHBJ9nsMZE1ClbDLIGLgoE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnIobeAN8/hv1WWDL1D+yxwFxLX4kfYJiZYDnAd5zZ+eC8xjDkLhFNUeqULn?=
 =?us-ascii?Q?Le304rZ2bS8Ac9wy2oN33hktlDIP4JYniAaaGz3TXFV2TBVTflYhesDxYANa?=
 =?us-ascii?Q?mJ99JOcWFB5APp92on6xlqLX79if57cwOwKRgaDbr+UYlkzqdaQ3+znXzFmv?=
 =?us-ascii?Q?kJpGIi26ZdyHHXImdAJhUQt8EbVEicBn7MIpX80uU5vundhaPx/V722MlpxE?=
 =?us-ascii?Q?8KDrUIWqOL2Gqkk9j7d9ow9vANYIEcr8RH3h+Gm0rUr5+HS8hGvf9Jd4C8qV?=
 =?us-ascii?Q?rCpRYOm8HwgLyRRMZaJoAZnmg0TY8cUO0OYCQDE2/feig/l8+O7fYDsJN68E?=
 =?us-ascii?Q?Km27lTON/Bv/e899DNLh26cLwBj5q9OqzlIvfdo42WZZ9bNd4HiotDwk8wtu?=
 =?us-ascii?Q?NEbWsuDBZlQwrD326LAZlS8Cb09sEysJb4pyfs4eaegEccTXRArsWc1WHurb?=
 =?us-ascii?Q?9NsX/lcL6Jg84IhEqSmQaGTZ7RrPz8cYWu+Y6QEdrzDuClMzT2y2Tw211OtS?=
 =?us-ascii?Q?p2q5m+XmM2mDn1UXRckoIgeSIxu5pVAdN0u8l42D+Hh21Q/BmKKOfNkhiKH5?=
 =?us-ascii?Q?KLpxg0NcXrXrUEseQOqz70DTQiWw/dM29QAZRRJLZTHR/ZfESkgYzi3GNMgk?=
 =?us-ascii?Q?0+eQkvizoejC+ZKiV75zPrvSrxdcMmovhKIKrh5sY3OBnTDa6tWzt+kZY0Tg?=
 =?us-ascii?Q?NrZ66t+w7ZlrLnW0dOB0PAhtqBcmFLb7RN4QADygsdXiewngjpizTgoR1frz?=
 =?us-ascii?Q?j1BxBWZH3wjaz8Pla7uf1ybfFswg7RUArLas1jkIczfd3XRSmtm+5/pUeJWk?=
 =?us-ascii?Q?m++6TBtHk2+N3uevZ8OX/TNP2EyNT9KzM33/dY5OFeRUW9q9WFo4wBpupVDA?=
 =?us-ascii?Q?hCPLcmSuw3+UqOainoq8RYRKcj8REh4fllHE+VJEYrYlN6CiJ3hdxJ2zw1nQ?=
 =?us-ascii?Q?MHAPzJ7214bpBVcvP9zVlKktx0gb59yT1FM7zZKmmC9FGky4ULnN0NvAHLB2?=
 =?us-ascii?Q?6RNwQ94/wiKlxbA+78W261om5FAJdYOaB9y73h1gdn7P79vrjuaehQC77WsY?=
 =?us-ascii?Q?pJ+tuhgk6X3k1iNs+GUny1FJdBf6bO+08bcmjM07sv0WhTMOtECx62OURuGu?=
 =?us-ascii?Q?WrfyHUFv2VRotjR8ufYh7nR+oQAFuQ886hTtKoHSf7qt4wIVSGrLw8BvBkjT?=
 =?us-ascii?Q?lUObc7jDoRlJ0kVDGlC/IN0f61vnAbPGfZp8kBXe3/mmI92PFF8q5sUj9Hfy?=
 =?us-ascii?Q?qAg6GXf0+Imc2CvEBzqSmKJdoTDrZsB8hGcEK9MtE4MM+KNn7TPcuZtsDz09?=
 =?us-ascii?Q?6tGJqHySULRO4+41uRXdiXOAk6T+tJS6HlXrzf+wk6PwCzbLHiUgGARrzS7O?=
 =?us-ascii?Q?xzgPkE4L3sJ6R3OmXKl7m9jY/vxy2UMbzs6MnEfe1px9ZDqKxeBcxBOVbXnP?=
 =?us-ascii?Q?AMPuOwTqiaDFam0s3s3iTnEZKNVbI7S4vb3PxbrUhcccMRnHnH3pQ0TiCN3U?=
 =?us-ascii?Q?Vy221sx7/UHZZORAo/iGgpa1YK8tqixkPDnl7R9/iMnvyLUcsCa4F8Jf+20/?=
 =?us-ascii?Q?/Gum1iuKiTivEb6LS+zL8J229M4dPx9OOs4o/jkAYqKCKtWjLl6wUFhtG3ys?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44510214-b302-4088-bc15-08dd62e425ca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 10:36:58.5996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGboedxdfJZHdaqz130gym9vwzdLroi8hLJ/TDhUmwKdobDTD3npM9bDYjijEalj3KuC0Qy5twibdT15tJeNSC54wYjXw7nGBpHnlrcNpOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7968
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
 lib/eal/linux/eal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

