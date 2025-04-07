Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3CC3601A
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 05:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CA47402F0;
	Mon,  7 Apr 2025 07:26:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
 by mails.dpdk.org (Postfix) with ESMTP id 9D49340150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 07:26:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8TtfmY7pHWAi2N6E5nT3mDc7Ut4M/CmtufC9I4dJRM5/J1oMU1fy1J9gqCKGuxQW0qxL56ugK5RtrfjPIy4anv2oGAmYTyJOoeyRNz9hmaYOs64lWFBd931UXYpb3wsKAJIaplWOd2wKFrFLJcmIfXrwXtZxIOQw0tqx01PQM/BVz2G9DdbUGkTR8pemFT9kT1o3O0scqrJ3+NgwOXLIpp68ppQWyN6AQ9tVAIMFDhfUmhwwWTo/Nu3qNNA6sw5NfJs4vbrFHsxKQZhdYepB6+Ho+R/YjloGXD52VA7aRjHFd7IJXIkEmG3BsDO7KqaAEo7vPGrMHaQQ7Cv0mwWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp71rOAsW7fzwyrpJHYzG09yxBF6hXPYs4BYb+BdNgo=;
 b=GMb3Z4S7iOU72U5UmAPxqzqKW4WB6vjE+MAbHoGMAhuKPIBuk5fnkEl7BZbCldVJ1RH8EnSDiggAbMsubjmR9HjenjBhXIKfTlVYxWeZkUmNl/FskhrgiuLrm2Zs6r21nPS7PQj7Pdwiv+jNXxEiv9T5NQGjvdxXbWq9vjBTYBnbJ91SLB6tJ/9v3LUFKhFkIIPN9UTypq7tGV0CE9afo3CFdo44vNY3VSJmiXPdujFZsqNMI5ND9J2BbgSQMkGcamADTMxeSidTfiGBpjhVXVHDss3hIZtksnt1V751Gx3FtcqrATjLpz6SbLnaiCvJfI05cbxk1HvQm0yLceqEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp71rOAsW7fzwyrpJHYzG09yxBF6hXPYs4BYb+BdNgo=;
 b=Do/XqqWBmA2JF+fis6KMrO06W0c2m0++mqfKo2LoVXtJlB+v7XmSKqbaYgOly8cOlJVi3uoTf2ywRJz2nsdXvrh5mK/NizzaD4x2NkGeYp0AJ6bGzuCyezjMzpI6lDESU/Rcs1Wi6w5/hskpe8w/dtizsGXsyt+AeQUzmr8/5u7pWatBeYXXgs5V/3m4m+G8Fma1rbSkkBBWHue46eXvUGiT4KmNtiU/vmCnOneQ4QmTKty6HyBHqyWaH70XtPYavtsf1Jve6CILGbX70+Cji5+lAHSjInqXtlBhnJyQ0J5tLkOJYO0qim+o+l3HoBA9s+4/KMhPMXgr8+P7Fj3iBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by VI2PR07MB10202.eurprd07.prod.outlook.com (2603:10a6:800:279::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 05:26:13 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 05:26:13 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: myang <ming.1.yang@nokia-sbell.com>
Subject: [PATCH v2 2/2] crypto/ipsec_mb: fix QP release in secondary
Date: Mon,  7 Apr 2025 13:25:32 +0800
Message-Id: <20250407052532.1913-2-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
References: <20250314103638.2198-1-ming.1.yang@nokia-sbell.com>
 <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|VI2PR07MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d8541d-649c-4e57-e28b-08dd7594b663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/kClNZ1em76vYt3nEFQvqGLYv6a3vTRPCtKDVyrssxIfeWBeLrz+xLFTub0o?=
 =?us-ascii?Q?6+vQ7RcWXUqdeuVTdMF1qL+KDnyRAyp8NwGt8urgKU4tdoWyYutkvvlf28sx?=
 =?us-ascii?Q?tqfD9oFIK7TPxeASxit7sNmlv3rPrvszMBSF89ZU3STfeSM2hjdtiFV7WC6N?=
 =?us-ascii?Q?II2nS6sv3KjqAxjYv7ouJaVQXcoBjWFgp2FJpSRhDqgT2IiVB9zqUkX76Uat?=
 =?us-ascii?Q?XWpqidEjKWDmFUarSL999+O54rLtrWYJX33CYII67fwSI9dSw5hYk2rfVTsS?=
 =?us-ascii?Q?sd0cG0sKq5LVTMTo0SV+b093Y28V+C72FPR/dnxHN3k/3vR4fDHEc74V65Uh?=
 =?us-ascii?Q?LQklBJO7d5Ag0kS+BANzKs6THhg2xjcUUBcDoh6XrnYKJoRvcVPYZYhyVnAL?=
 =?us-ascii?Q?kurmKvMgoqkC4YsYz1rhF0MfKXzmXFBFew6UevVRvdj0+wpKbhmlL1X3dL06?=
 =?us-ascii?Q?PNjTpabIHLYCBe+s/+2aPCUaA1lSW43ceAZcCai1VJxRFh2ILdKlORHwC4YD?=
 =?us-ascii?Q?hY6+DZV+tkQC29DNqKOr6k8D+icX6GtVpJsjeedoCIcgShV9GjnnZUUrHb6v?=
 =?us-ascii?Q?dqJAi8AfANR5UxFzMHtPs1D9O2uO3/JNyuyhMB9wENiTUg1M3fiuIU8C8N+T?=
 =?us-ascii?Q?HfUHjUcGtL54Mz7Ofp+In+cKzIj5blyoXrEzquyQ9rTZvrYV0utZzZKDTwTh?=
 =?us-ascii?Q?uGBSXw1PAnAkgnRbRz8S3kh0fQE7Z8yt6bE/UCU02aMl8yfoSifDnB/8f7ZD?=
 =?us-ascii?Q?g2sDc60upte9OJLkEPJ7ek17a3XamSuTJh9G1nlo2PN9F2pVV1KhFR1snoFO?=
 =?us-ascii?Q?hfobBkQv/865n3E5873wCEWsrjqGSp0CyadB4rzpVj6M+iGtbZPupULnOdE5?=
 =?us-ascii?Q?Z29K8MB8O6P+sn+lXwaGzUZkw8oTBtS/ao2avwNV47ZaqK38X57FIYd84dCx?=
 =?us-ascii?Q?SH46y5MAHlWt4cifCwqFzQKQJverIhulxWRt1S7inTklhOGjOQrdDS4Fk4iH?=
 =?us-ascii?Q?TKhVdsWwRlHHhrat6oxHVtXRH1NOEYn4Tx+wLI0SX7SDDPYir2qDdz4jJIHP?=
 =?us-ascii?Q?rb5ARq1kKjF1S3TA+uKH8hxWIBldSiyBPCjGbAPSiDq2GnEHGac77lj5NqA2?=
 =?us-ascii?Q?NUUsP/o+Z+ay7sY/tF1Pn9LxW0PqbOA/oTekbiCr+6Q4IdfLAmgP2YrWJtyL?=
 =?us-ascii?Q?ykqyT6BfA8YTc+eC3PuqURwQXtNRHENTECnf8lj/tf8e8k1TzSOScOhXD5hz?=
 =?us-ascii?Q?i1aLp18ZgaQ4+lCVZLOrKnEm1DHCPlj19pxtczx0ZaX6y+pWcMJgrbc65IIr?=
 =?us-ascii?Q?5/NVfZOrPRudVzdFFh3E/7TDYg6VyxEIB15bNNVUArGv6Sw9RK01RHiA+0LQ?=
 =?us-ascii?Q?w/tzDApFdJRj4MiJ8rJvkze5TTTDXThrx3KBCY1G/doPnHMW3QzBzOYGUzuK?=
 =?us-ascii?Q?htc0016/41U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oerG4fuQwA+Bsz+HHc2z3pEOQ5D4xoMkVip2lAC5CEbZCW9yasb+06PhTFb6?=
 =?us-ascii?Q?MoEwp0argCSsc91pdenc55V6FV3nAzO3hEwggkwRM+eFsIVbcGpgbrdsqkZn?=
 =?us-ascii?Q?kP0E1Fufuc4GFc3temjDcchU7S3NVd/eCsuAfddakOATBeD1MrM+W9AG+LPb?=
 =?us-ascii?Q?QMmoivXDajfb7FVavy5MuFcR4K2tXnD6EiGXotLWN8m1FG2ohpnJKlk1MSwe?=
 =?us-ascii?Q?WA61gFZXfhC7tVzO9cSxNJqxQkUo7Hg6uVRu8wCiiq+CE27jdo9dDLw8Niic?=
 =?us-ascii?Q?DaU0OnSzHT1FlVvy0OkrsUbR2xHkQlMYY0zy/CHUCPMMGwLMDuJNonykGeQ4?=
 =?us-ascii?Q?dduVL6OYpz5RQDcB1VAKqch5nkFhk42pvDG5WKdHXUVFxR6fNiEpQOdJ7xN5?=
 =?us-ascii?Q?27V0sG65aXsBsWbNVXWtkmWgD/XYDEImO/z3+r61sVF5nCBUqK76EIKBfRkt?=
 =?us-ascii?Q?hNY2hkKyeUQzdJ/5rlw3Qs0ro+0St+EdIRBx0FMKjAkmoe94cscc6eqjApvo?=
 =?us-ascii?Q?3psUuznV3uiOwD6TSrwUQ7vSxZbwK3RhwrcUoDj3tXKuNJ2uqIyFjhitSsvO?=
 =?us-ascii?Q?6SZdl3d9OTaQn+x2Q43pLNiqLlQIheQNkhf/wV1FpuGL/uHNWM9TIHg4aFEn?=
 =?us-ascii?Q?kHXOQ+/vXJz2KFy8O9oS+usnIXW/Lx3FAJQG+h+Iv5SVpOdfB6I9KpKAw3LL?=
 =?us-ascii?Q?Oik05nmEZ/tuR14o604GjtvZSJUIpcC35oWLdn9JDXb29PVV6Gp3W4xnf6nB?=
 =?us-ascii?Q?Ma/MK6J23FE61QuIi8jCNLki9cZgUCM5yH47kLHtqpTaVRTLBaY6Ve5L8Z1k?=
 =?us-ascii?Q?FEMdWr9jIpt8+3iIoQHOzUyNRp6rmO8ug1ZQED0PDdbZuri3+COB1ilC3nK5?=
 =?us-ascii?Q?yM7KdyD/np5gklKanRaVTu5XDmqaGiKdL6SAArOxTuu+WhVUj3H3zPapT8k9?=
 =?us-ascii?Q?w+joDyvJuCcLMY8EKIHNDhOA4gOl6ZEOfndbZQQmrS5namOdYmBGYNUtLrMQ?=
 =?us-ascii?Q?UjMn/w7cuC6lyC4POXTHYjkC8aiJqdI1pWIRTI+e67KqlpXLoRPjOFE7pl7g?=
 =?us-ascii?Q?YDQJDRbC2Jy74vvhyq3NgqdE/2IQGJyLdCILmYxgkxAm/VEbpxaq+ElNxKBt?=
 =?us-ascii?Q?X6/0vGJ8g5s4Tn6AhfGN4OASAS9zNsY+KoO6hoOmWUqAIuxLfHQZK3zqaDKQ?=
 =?us-ascii?Q?kn8XstFArHoOwvLK+50wNUn4uClahlTKj8ZpJXrP11yC6964vJyvXQlw7PZH?=
 =?us-ascii?Q?qawjSdmTCNEibxLTvaOdVjNygUb7JMYk682OhrsQiKebHKiArJvc4i+Of3O7?=
 =?us-ascii?Q?e8/2lMgvq9qN9PdZoZTKLWNlLJ/oUdWjYXXk1k6IQCOToXFLX1EgRGel/WiK?=
 =?us-ascii?Q?LckbmH+e0hwJvTS+qtpfXJf4fqjM1H7Ueb/MbBaX/QEV6QYJcAjT7WETA41Y?=
 =?us-ascii?Q?tsy8hJwhr75NgyFvylvntwYYqDoD4F/ygJJDqH6Ti5e3ntHg37XWSwiqzRdD?=
 =?us-ascii?Q?zsgdujCAJeNNQFtcnsse2+oq+PZ/ufnOz9+Kn4cQYi3HCS0kZxPAK/xycl33?=
 =?us-ascii?Q?MrsOwGeFo6WwspIA7ezh2ZG8Q9Ogjd9rnwgs80A+NFcllvms3F3k43l81A9c?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d8541d-649c-4e57-e28b-08dd7594b663
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 05:26:13.3561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuH43j4KLzfUdvKAkOfncgKRPJzqbLzYbvp1zSNAUTIysKGTsB8e1daYIVZoC//+Xi/sTX2PybIf2HYyqyNatzA3+sfBm/I7+sSUcT+zAag=
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

From: myang <ming.1.yang@nokia-sbell.com>

When a secondary process tries to release a queue pair (QP) that
does not belong to it, error logs occur:
CRYPTODEV: ipsec_mb_ipc_request() line 373: Unable to release
qp_id=0
EAL: Message data is too long
EAL: Fail to handle message: ipsec_mb_mp_msg
EAL: Fail to recv reply for request /tmp/dpdk/l2hi/mp_socket:
ipsec_mb_mp_msg

This patch ensures that a secondary process only frees a QP if
it actually owns it, preventing conflicts and resolving the
issue.

Signed-off-by: myang <ming.1.yang@nokia-sbell.com>
---
 drivers/crypto/ipsec_mb/ipsec_mb_ops.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
index 910efb1a97..50ee140ccd 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_ops.c
@@ -138,6 +138,7 @@ int
 ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 {
 	struct ipsec_mb_qp *qp = dev->data->queue_pairs[qp_id];
+	uint16_t process_id = (uint16_t)getpid();
 
 	if (!qp)
 		return 0;
@@ -152,8 +153,10 @@ ipsec_mb_qp_release(struct rte_cryptodev *dev, uint16_t qp_id)
 		rte_free(qp);
 		dev->data->queue_pairs[qp_id] = NULL;
 	} else { /* secondary process */
-		return ipsec_mb_secondary_qp_op(dev->data->dev_id, qp_id,
-					NULL, 0, RTE_IPSEC_MB_MP_REQ_QP_FREE);
+		if (qp->qp_used_by_pid == process_id)
+			return ipsec_mb_secondary_qp_op(dev->data->dev_id,
+						qp_id, NULL, 0,
+						RTE_IPSEC_MB_MP_REQ_QP_FREE);
 	}
 	return 0;
 }
-- 
2.34.1

