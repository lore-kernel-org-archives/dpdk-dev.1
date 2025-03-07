Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58215C28B2E
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5190C40EE4;
	Fri,  7 Mar 2025 22:52:07 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 88A1540ED0
 for <dev@dpdk.org>; Fri,  7 Mar 2025 22:52:05 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound18-33.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 21:52:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0Z2uwB7/ut3SoxyklGYc0KIwBeRCKvAXSLaweGivmpNssWP6hl57N8B/koU1sMg/sX2u/LC7051XLYY7truhFp+/22XsHqNoKD14Zm4awUf4gYvWl/c7dEqyr//aCiuu9g1Q7GB05ZwlzmOhEgiDZXtcEp9a/Ioc+IKsJk4kXlTRjWta6zOK7fFC/o9nEnkoJrrngoYkYmE6vuiM7/RP0zfDhqX74KzvZmCURyT1mRikbQM5ttiTLiFCTF2P87cqDWc0AwawhKtnUayixJJEixdtgm0nzzFn/mLblG8wPOiT43eo3vkI7cSrZfkpjuovoYWMLDXlF6POZU4efu1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIVoI3RUqYFnwV01YR4JJWgZ3aWlFa8VIxvr48CS4uM=;
 b=A8gYip5dHb91tDaDLQb5bXSuYf1yI/9nqq3gDbT+a0ZAKdqk7Tvf1kJx2xmNsEz7Y3sVsSx2ZjqSG3zstVvVQzOCWsknyz1EUbB8x97MGg/J3kRYXbeDYUPKPAAXH/+0CBUVLlT+U5cG23AxH6nXEnmCBY1Sob3RgLmncIfDyfKIIBe71l6JybWxhpJ+x0rw1fdHbyvvtuxYvvJ1r3zQR1hP3nZ1oNu3xd02qBsTBPt1RoUW0H9taaMJbuP6JIcrWk21NNgDwh2f+9UcnLua3gy/4I1TpGM3GiBaamxsZdZnQE4v89AZSEuatIajznalUYGbzeMFrszBddgc81IDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIVoI3RUqYFnwV01YR4JJWgZ3aWlFa8VIxvr48CS4uM=;
 b=PzWP4HSShfhOCxpaB07DSSf89Jo2HYVsrV9LTJfXQAs/ix8hc/76FBbirN43eq3GRmohjECg+DVgT868dPG3armkmZElhs/EbqUVOAExC9Z1B7aw6U54AHDPQ4mslKr7gd5EnRi3yMB9NoEQpGyO+Fkga29IY012w8uZQ8p/bs8=
Received: from PR3P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::12)
 by PA6P190MB2053.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:3cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 21:52:00 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::f1) by PR3P191CA0037.outlook.office365.com
 (2603:10a6:102:55::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Fri,
 7 Mar 2025 21:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 21:52:00
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 4/5] net/ntnic: check result of malloc
Date: Fri,  7 Mar 2025 22:51:34 +0100
Message-ID: <20250307215136.3110019-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250307215136.3110019-1-sil-plv@napatech.com>
References: <20250307215136.3110019-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|PA6P190MB2053:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 53a3b436-7706-498b-aec7-08dd5dc24a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLvBrxpT3igGEjUZBZdJqf4xf6VdiJcATTMv9v81WIV8WwMdnXyFuIHHpzFO?=
 =?us-ascii?Q?TleJpQWn62YN9ckrncpO/T5VCT53EHlxpKNh+7bRQYJ3Vfsi19wp2+hf6m86?=
 =?us-ascii?Q?RrYF2Ww57OR5MpugJoWfTcoakze24Sm7GaLefs+tNdrIyuWOteoMvX1bGHbJ?=
 =?us-ascii?Q?iO99Ax4yav8WfNbF5PiWWS0bGoYaUVAVOPBqS5+jYVoYY2xc23NKm+niJDXs?=
 =?us-ascii?Q?s9hkwkLDVyRwpI4EG9dkYLemXWaE/rZwrA1Phm2uwm8HC2pJQDwBn526Fguf?=
 =?us-ascii?Q?Pim8myHxikIYV/RxW+h/C6Mt19Q1mMZRu2KK7THV6OEeQslfRUmBIAFqsgNE?=
 =?us-ascii?Q?k62mEnVGH9OEGHi6H4Kold6ivbdv6X7E6M63uCVKutu4z9VhFm6jlXbNKvPT?=
 =?us-ascii?Q?qSwBmUdaZJOEHbElg0saJefHLu9M28/821PXvopDh7Q9sMqsdqYG+mZJomvb?=
 =?us-ascii?Q?GRS9R2DFLwiJ/7Lo0OFYxbJXyF0GbOz/Ow1M3X0cZtu7cstWMgPLXdGNnbjq?=
 =?us-ascii?Q?yoqZkzdO6J1posWAk2bt1oXNJIkKdczyxD3KY60PUPvnQ2vcXKN02Kfinpx1?=
 =?us-ascii?Q?NSX1omNY3l91Ryz8kjrTMoMYClLYo80YRYhqBdu7IeqGeIYQ5T1JLgANXXXH?=
 =?us-ascii?Q?YwRxHbyEeQiwy+0mCHDj/+GIc9cW6ClMPDYQlvtio7ikQ8z2n1u9QSGlvsyb?=
 =?us-ascii?Q?aRoumFg5MvlnuFEWOq0MCV7bPhUmESU7TzT9Ru/UvBIGo6Pyf21qSdDF2L9S?=
 =?us-ascii?Q?w91erO1EOA2+SCcQpq2i9Jy0lSlXhYxdbeeRnld1JhQ7F8K8YaFnNE8kECKO?=
 =?us-ascii?Q?IDChn9/FC8w0IbBAh+Sxac9Hg1PxFPeHYKyglFNOb+p1dPo8OmDbbNI0RCPl?=
 =?us-ascii?Q?P8VREFwK1gkUoapD4DALIwTdS53yA5+ZEGBH4yqLB4XWykumZTt27speh5DN?=
 =?us-ascii?Q?MKquHBd2xqqnALHxisJQY0UIk/CV/U1VnGN15v3YnQL5R1H7w+gKaXSRY5iR?=
 =?us-ascii?Q?n7GUeznGSTMhw8jye+f6bVo56bVUFtArRPUiJiQGspsnvyaptcrm+zO4u1ho?=
 =?us-ascii?Q?eeHjVM9ngasarPojh2w8vEfOx7DhNDj9yz8xSN1raDYk+zT/Ag4lWyLseXGv?=
 =?us-ascii?Q?ttfrn2Wwwt66ivbSFGMARrSCAaEA/VPy2Rdmx4C+LQcAGkm9DV/d3DmKzTlP?=
 =?us-ascii?Q?vQ/PQGNU/BjdifrdQeQlIWxnPA4U6ZgQ5psmftVpWdbp8z/pYDFDHJgvJ+EF?=
 =?us-ascii?Q?Y/+1ynMSER2y95qcdcFJIIEx/9rjBuwpx3YTqLtC+UrHObvIY3qrYtZW+0yK?=
 =?us-ascii?Q?pNS/0ibxiR/7LcKGbam9Re3bczAw95tfL6D17IXDTRpYQuwVpGJ/+Nxc/fvO?=
 =?us-ascii?Q?57z1NrBjUeoKXORl1FBMy0CaZ2aSm67eeD+0loFdtSdXe0UwZ1fsna+ONGzu?=
 =?us-ascii?Q?tulu+qgRFDt8rnqbgzSY/JNK6rKqU7eg337vXnm7uI5BmXVLFrA7nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NfkoMVTvVRweWPJnXzVMgPUMeNVWueKu4RK3KjnepVD0v7uLoBvbUwXXrlVK8L//O+3aMax49Skyj64+TlyT31iZgNvwRYQxdvgw7rKPfsKUCTIEmUL2M34pZlS/bqzetZi54MJKYp7/N7C6HNI6Cw/txYloLP4+uN1AkfgAJ6tDl8pFGKDmOyYT0bxy9yISoLOTtQoPIuOpmlzTy4sdsT6G6NC67r++oDSue7ZY8t3zMo/dnJd+DWWcUTeyMsmGRAgMldloHpHuPoiddbQfKuxADIIfqQh4UtnRj9zZwDvkkuy/MNHFfgurlByN2P89IpT1URvCqQO53h3AA50mJunUEWFsk8arTbzHYgNdzpcoK0SmN3xg8/R4mN8H3Sv27qXlWdbM9MAmhyyqKvehh3Lu+Qzn9g2jOSNgguP+2gQn+xyrlNg3R5IcGJbd27JAG7yPqbjmmf/GzQFvZCMstMEbssF39TiZpYw8l1FRyuVsS9a39BRHqbUXigB28OFrwW2wp7Ima8UZ3DEkYmS6tMkF2iAfXvrUqcoilYHfkIS+6OJOxt0QmQuWRIsNPBNSoJzkgupMyCsmmVoHiISHKnEqf5lz/YB6yx+se/lIBjpWvTAEaxL39zy3oLeGH4+k0RJkLCArnBXCjtUAWdi8GA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:52:00.5889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a3b436-7706-498b-aec7-08dd5dc24a3e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P190MB2053
X-BESS-ID: 1741384322-304641-7655-45497-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWFoZAVgZQ0MA4xdjE0MzSwN
 gs1dAwMcXCyMI0NS3F0tTAwiDNzMBMqTYWAPrvIEBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262990 [from 
 cloudscan12-5.eu-central-1a.ess.aws.cudaops.com]
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

Check return value from the malloc code

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 10 ++++++----
 drivers/net/ntnic/nthw/nthw_rac.c             |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 222a553684..6ee3beb7bd 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -822,8 +822,9 @@ nthw_setup_mngd_rx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 
 	if (p_packet_buffers) {
 		rxvq[index].p_virtual_addr = malloc(queue_size * sizeof(*p_packet_buffers));
-		memcpy(rxvq[index].p_virtual_addr, p_packet_buffers,
-			queue_size * sizeof(*p_packet_buffers));
+		if (rxvq[index].p_virtual_addr)
+			memcpy(rxvq[index].p_virtual_addr, p_packet_buffers,
+				queue_size * sizeof(*p_packet_buffers));
 	}
 
 	nthw_setup_rx_virt_queue(p_nthw_dbs, index, 0, 0, (void *)p_virt_struct_area->phys_addr,
@@ -878,8 +879,9 @@ nthw_setup_mngd_tx_virt_queue_split(nthw_dbs_t *p_nthw_dbs,
 
 	if (p_packet_buffers) {
 		txvq[index].p_virtual_addr = malloc(queue_size * sizeof(*p_packet_buffers));
-		memcpy(txvq[index].p_virtual_addr, p_packet_buffers,
-			queue_size * sizeof(*p_packet_buffers));
+		if (txvq[index].p_virtual_addr)
+			memcpy(txvq[index].p_virtual_addr, p_packet_buffers,
+				queue_size * sizeof(*p_packet_buffers));
 	}
 
 	nthw_setup_tx_virt_queue(p_nthw_dbs, index, 0, 0, (void *)p_virt_struct_area->phys_addr,
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index c22123d936..2257dfb7dc 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,10 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
+
 	return p;
 }
 
-- 
2.45.0

