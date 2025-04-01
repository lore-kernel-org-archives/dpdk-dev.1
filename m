Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7DDC36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 07:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5CB240DCF;
	Tue,  1 Apr 2025 09:55:34 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
 by mails.dpdk.org (Postfix) with ESMTP id C259D402EE;
 Tue,  1 Apr 2025 09:55:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFQ5Iq+LpFzx8zq2rhcNRj3/U4W1C135Ypa0edeH/EpnFV3aK8boQvC/mMv+l2APHlxtcxpEzlZEpG3zuZzo8+hQSgOrb55uHpABeKWtBdMNIuMufhdJVJZc9UmhNjSIGcemFhplc3OzVjh1W7MnRBt1uPKWwIRqJJbRNrDi5cdXm2fG0QbnlFVMOcp4Aoj6TttEhve4mHJ25DRj00D01XoJ3ytrppbSZsDLwRKobmLC+G/IMZbnGG7c4Nbc4Hg8o4CTki/ni9N7BY9fgMtAQNiYqP3+qu1AJmJwumrAkqu7NfB5lBwQPdPfwfGcpCkoHRgGXzJoQp2ay0vCvdKLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRV8FrybAH/hMCRgUMVycMBk96KR49TySPI6sJFRWPk=;
 b=n1vveU8GJG05anfJSebBghn5JRG6bqHR85KFa90FJNCondWjMhBmgASy3RFeOZHNJHyMIohix/G4Na4d63d2zhcQ5eoYaiXcOuuZ9X0x/a0aiEa8e/KxR0bMuCRBTZARq9+imRlJKYoTjDtlbeigqYIf68Cmjt/WDLWuGARWJg37wTo7HAa1679mAgOxhxnWkxMlG0TCKN7FwgLZA75KW5XtmJD4HuO2XqN4Og4X3C8AUYM0uaok0ZbrUblkALH6RzMDY5hK6CPQtispWQ3bfcrk8lYpYM9JWCaCWyMKxCPbcUYLtvYcOr33cOjcsiXfUZQhEF0X2EQ/UFmdosXFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRV8FrybAH/hMCRgUMVycMBk96KR49TySPI6sJFRWPk=;
 b=NHGZZcqjcPa/FGfsseVaGVqRTnZJAZcxle96oJ3+rZkhubE/SiabMTEtN7BbRvwSmXwn+Q10/zkWrYAdhUSBor/XFyWIZfH3JqmGIR32cxQD4zZqFM32KTw2r8CKpZW1OnUttBryv4XTSW0U0dfevMt3SJzbndqic1xDgjW2tYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA0PR13MB3950.namprd13.prod.outlook.com (2603:10b6:806:9c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 07:55:31 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.030; Tue, 1 Apr 2025
 07:55:31 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 stable@dpdk.org, Long Wu <long.wu@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH] net/nfp: fix one coredump caused by RSS hash key
Date: Tue,  1 Apr 2025 15:55:07 +0800
Message-ID: <20250401075507.4127440-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SA0PR13MB3950:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb55468-519d-4944-d5db-08dd70f2936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06OvAgwdtVt0guDquYR4146OzUzIJmP0iZlMog8MnlFRXU125KgK9UGTXDQE?=
 =?us-ascii?Q?CwdW8f0olzZCiVZFcfShjfisBK9i1hUpxktfdStBSUWL7BXi8zry/bKolOQv?=
 =?us-ascii?Q?+Bd6NmKtw5qjD6lG6ZPQeIvjCsEDnAc3ANzAhW9/YZ3JdduZgmoMNDFS4h7R?=
 =?us-ascii?Q?ceBl9iLgRDOCtk+BCAY36T540g9Ji7ouz2mKv1jcPH60Xm6CqZWH92rxOtIx?=
 =?us-ascii?Q?IIhF+mbI2jhb6qENdTu/NuukPADdlyMl2WynNxe4wmHuOnVAdcHiD0rp0h1D?=
 =?us-ascii?Q?kRJifxzV+06U7nsaui6CLTtAOQbfDgKuixKRn+KjXhKfiZUaNXymABi3QE2W?=
 =?us-ascii?Q?q1XWsI/vIzLbEOlRY5Xn8WZf/a7pTtoadMu6fwW9vi4e+0D5zLKtjf3+GMR0?=
 =?us-ascii?Q?RzSVKp1cWlR/QjoXA4ml8rOAX5kOH8Ft/2hbgijFcRR+KwWRVV9D/LD3m8iS?=
 =?us-ascii?Q?QqMJTiFiC/A9Y+f4M4BZ+p19tz12RBUw3jyVB34hjtlOOXlUSkV7jhLm9XKu?=
 =?us-ascii?Q?lJXxwR7JEcY6o1fsQbnVbDoPdUfmR5gEkd1yLG2uyevHAZEypOahJHrmfk/D?=
 =?us-ascii?Q?ESuKKlb+3K//dJt4JAA1fZYX0hiyq/NcKI3+vO/Sw3cpVnc0FYXmIiA9sx/b?=
 =?us-ascii?Q?Dta2W8frUmBoBgpU7AE+SaZnv17QSH/SFTM5oC1B1s22jn3Y6jHfifuQS6jc?=
 =?us-ascii?Q?vSts5Mzglm7I4Kup2tzxsGde45F7qMRPVXOQI+AUA/DW4nQ+WnXcijpL2OI+?=
 =?us-ascii?Q?mpewvwDQWHsWTmaxx0xgI3MRdQm6ucLhKYv7wEhTsB9q5tQwSY1fgvOPTb8H?=
 =?us-ascii?Q?dtfP9OjLxN6KMk4n6284KClDk1JnAv5MUVlljD2I1EH98LKxBF9UOtME+I6+?=
 =?us-ascii?Q?xyoCV9ZgVyiZi0tVYbvimHjJIGlfJn6l/b9nRyWQv+d8rao46QthccGZmFqT?=
 =?us-ascii?Q?tS13v8n46xe82c7VpQNEuBF8IbpnAWsR98HeFFWUKJ2zdDj44iaRzyZt/55y?=
 =?us-ascii?Q?nfqJ0almr9kYLCuF/WAEyN3ipR4fM0tJCvAjG42bcsALVb0pDK894HXVzhpv?=
 =?us-ascii?Q?NekYTf+nqYVyzzeLkAJkzbmK2macvDVxxdIDuxxBICn9po+1BFaGdlMKOavN?=
 =?us-ascii?Q?wa0qfnY7ZGc5TzCyHZqsvIbY7UGAFhJLKrTtNdpuzsbHBCvfqR+uxHDHyEEC?=
 =?us-ascii?Q?02Fa3DtPfw210KbuopWSU9k8KJ9sCsywtd5rHh29628m5HUEYPw12aZT6trS?=
 =?us-ascii?Q?FCy1Nooac1QZ2bdtP9R7yd/jxL0jQrzC4+eMxEWsZvFz83yFkmA+sAtr0UlF?=
 =?us-ascii?Q?YttaQwuKI9nB2YXUlgPSRSbBLmFVttsL3X30ncsQA1Q6TtPiKimPT6wh9Vjq?=
 =?us-ascii?Q?6MBynlj9C91/HIuieNz4vwCBr+ajxV92R7Y2B9r0NhoNCl+zk82vYbzyQ21g?=
 =?us-ascii?Q?tExaCN6YdD/sy9ZR3LJ1JxNK+wU4XdD1Iwpjh19oAS13BSqnpORb1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mIyows6/OiQLjz+qBqbCy47msXkUcXWrPJjeCKWpoUtsznXYxOGC19EjsfS?=
 =?us-ascii?Q?XT59MLdP1KuZ53qcKn/+BsG1VZ3D9ZPk2gai/5smhCf0VKNpCZVaivZ8NVHm?=
 =?us-ascii?Q?OWuTRBOmDRjIJorWYUHR1TmlS/QxdAhnqZkyPdz21PKSQ677BMeiRwMKJgpq?=
 =?us-ascii?Q?TP1lnOiEwYn78PmuxkARCD0yV3fCnJX0vIFf/nRDireSs3TyNEMDvdErqouB?=
 =?us-ascii?Q?B8scC/SD6oWz//TJpgOGVnS3bJNm7kNlWlFBcUivDNBkfd3wlMiQX05cxEzi?=
 =?us-ascii?Q?TSeTgIqJjwUsAXY1m32+ssS8CE6JN+tIcqenI8FmT6XNH+UonS7enyI1v538?=
 =?us-ascii?Q?m00XRK21AUxWeStPUT2+svmUdrU0LTRHLf7t9COaGdy0JVvpfwivuAx48Sqi?=
 =?us-ascii?Q?rO2VaXW6s4MShdwUktH7InkCW4MCrpIqVdJdOZhVCREm8IbfKtfk8mi9NMUV?=
 =?us-ascii?Q?Swjj4FAJWfei1wlRPsHypw9SvBfzpZLeHBI1yRtLVhBfGP8JweScADu8I/Oo?=
 =?us-ascii?Q?PNaFaWhOZUAfDHdYlI4GNzUgWjHz9+RcT/DwmdPKYt1a1vsOTQuhBSCYy9bV?=
 =?us-ascii?Q?XClQXzO+a0ZO1SDANpH9PM74Fks2yeBsdM6xG+utBjj+Q5A5DNSkFtXnDjtV?=
 =?us-ascii?Q?l6l2PuMyZPprF17EpCEqEZfdC8DV13K/jlc+eB3oShNLKOzRI5FvJr+GCaKk?=
 =?us-ascii?Q?xFtnkX4LB9zq1wjjKRtGzA6nbZdDTXTW+MOtMVwVSymcZ+BIZBtsVRuXyrYz?=
 =?us-ascii?Q?CAdDP/qE334k95Zt/clOHtQi8x/3BM+QtIYsqr1w6aABi6ZqylyQvyJ7uZ7R?=
 =?us-ascii?Q?R59ZCQtgtvVRiC7KjsVl7sax9HD6IzVMPdwcWLM2AYapxMVCWIQoAz0I0aDx?=
 =?us-ascii?Q?+lF5wOg9u9nrZDmeynV/vpp+wjgPR4mzmqY0HNy0qqG3mXFYB4PTva6G9O5o?=
 =?us-ascii?Q?uv5MWa6DOmysSR6WOSMjxusTMCKAdDkqAO2PDNgtWecolsJh6IdLCIhoYDD8?=
 =?us-ascii?Q?Tli8OXFX+yDprC9dgnhTJCWZ8ZHYxVcvi7rwy0zjQQ7W/hxxL3RnSgZeAQCa?=
 =?us-ascii?Q?9sNUGpoQP2XOx153cenUX/pdkaq4t8bytlohOpru8WsICakf5r0rKHv/8w4j?=
 =?us-ascii?Q?XPSB5ddLGyjAaKn1o7Yo3tbysrGYgVYZlKvVhy5QnenpCSDNc62npjx9rmfw?=
 =?us-ascii?Q?i+bnlT4ctObnvXS9q7QBLXRnY0rb0JOtZPMLNsDdxQKJ2egHNqd/ues+xM4Y?=
 =?us-ascii?Q?L47n75LvXR5JebEy9EaVHHusyvYMMhhEyKFFbjjMFNBoZcSFeFv3yYtYC4gj?=
 =?us-ascii?Q?wRYDprMM/5NGG8HaclqehPmAXvOlOmm4e6xMEa3LM2FdkKPjuJtAJ9eiZo4q?=
 =?us-ascii?Q?C38qp8aEyFgEBCGWWyOKGPqvuEjcCQ3HhpzXqAQVkrtg7h9mh5NvvFbVmhkb?=
 =?us-ascii?Q?X4pRch/HnXYeT2FX4yw+4SJBYqiJRkqkBmnSWTZVJshF9ux+ExG/JMRGcJOm?=
 =?us-ascii?Q?XoMG/ZbNDfHW8YHfvDrT4dkJeOaGYvIPlXB93ECdMVqKYs3WAjWX7zD/JZMD?=
 =?us-ascii?Q?13QEMDeJGBEOeTukdi2y4OsY7QZg08WsccFjW45BT4v3LqguWUDsIonXGhad?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb55468-519d-4944-d5db-08dd70f2936f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 07:55:31.7928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmNM8QNieLKYRCLhMSWfbzUnxaJ1EnXYFdhmzP/KNmmFy501nRzjSpuPQg7/i2oDEGJSObTltnXbtkbZABHrwBCCdNKAkT7vWJvO2+w6acM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3950
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

Some testpmd application commands will use 'rss_conf->rss_key'
parameter with a NULL value to call 'rte_eth_dev_rss_hash_conf_get()'
API, and NFP PMD will coredump at these situations.

Fix this by add a check about the 'rss_conf->rss_key' pointer.

Fixes: 934e4c60fbff ("nfp: add RSS")
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/nfp_net_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index aaa515bac2..600fcd5c0e 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -2062,9 +2062,11 @@ nfp_net_rss_hash_conf_get(struct rte_eth_dev *dev,
 	rss_conf->rss_key_len = nn_cfg_readl(hw, NFP_NET_CFG_RSS_KEY_SZ);
 
 	/* Reading the key byte a byte */
-	for (i = 0; i < rss_conf->rss_key_len; i++) {
-		key = nn_cfg_readb(hw, NFP_NET_CFG_RSS_KEY + i);
-		memcpy(&rss_conf->rss_key[i], &key, 1);
+	if (rss_conf->rss_key != NULL) {
+		for (i = 0; i < rss_conf->rss_key_len; i++) {
+			key = nn_cfg_readb(hw, NFP_NET_CFG_RSS_KEY + i);
+			memcpy(&rss_conf->rss_key[i], &key, 1);
+		}
 	}
 
 	return 0;
-- 
2.43.5

