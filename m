Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208EC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:57:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69A740395;
	Mon,  2 Jun 2025 10:57:14 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B238B4025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:57:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92]) by
 mx-outbound19-117.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 02 Jun 2025 08:54:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhF5ChN/CEAHWvDj31J4Mg67PB5L0geYDjyiszs0VTq20xPHxKXg4ulAnARPebMVoLDPrhV0rTMbAYxTw62Uk2I0RKB3QK52vSaH4JbDKtjrEOxub6VbsuXImrGddev/60kPTg/EbGUKa6k3qm/SeIlf2+7TFYYV3zFo3/AV8vbnS79D2iS4hcH1Yi3U+8g01PJkU7u2jX1LntdJt4EIHarux/x4KXNPmseWPJQPKdD9lYq3Luor+8Lc2bXozwe97kZdZCSEhTIW5WaYiClyMSXXGLcd3nJooUTKyOpX7mNvtJ3ADsbqn9WCZ6Dbn2TsmxfpyFDvmZ8yCFIddx1low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqnD17c3Uo6zAgXhIbQuPqe0mdLFXYSZXgdXpCVj0JE=;
 b=prebqeZX7QmlNrNEHj8KRwgVqhnShPHcS9wJt12VW8bJ5wtcSQolM/13hCZKoDSkroayweDoM9j3oorBWD9m+gslp3VsdN6EuwwU1cKRGHL6ui+NVPZHmk3BsKFbyTrUGJfrNO7fbb2fCGEzkyZ/8hKOYbs3T1yfAglyZpdHgbIPl7aFiqghkUme7zxMUeAeqG2V1IZqASYzTY0OP7yvtcCM2oKmt8F6CddWLDoTjdloAsKmRVK4AteIv8LDaPTFVz6ogXBVs6l6kWSfM9H3ijFXa7ye03tOdv62iDNz2Aaw4fEx7NYu+mGrhkWgXcVB9JnS0Z41XnORRo2+kO9lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqnD17c3Uo6zAgXhIbQuPqe0mdLFXYSZXgdXpCVj0JE=;
 b=GQzqh2LrSPr3t6SwbrouZwCp5IkvYolbVwt+ef+iUldQ/BMvEEYX5SFGw9xH8MiOjXaRVXC52HfIa+Nm5BN2KKeIVVt0Hpey0SkNRrYoxO3MpEOFX3pYuL8JDTEqIP+wnLXqY9NcNDNhXIZ5IRrYecEOLxzfDXiapfsYdOK6T5c=
Received: from AM0PR02CA0106.eurprd02.prod.outlook.com (2603:10a6:208:154::47)
 by DU5P190MB2068.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:521::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 08:50:10 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::3e) by AM0PR02CA0106.outlook.office365.com
 (2603:10a6:208:154::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Mon,
 2 Jun 2025 08:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 08:50:10
 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
Date: Mon,  2 Jun 2025 10:50:05 +0200
Message-ID: <20250602085005.1882499-2-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602085005.1882499-1-dvo-plv@napatech.com>
References: <20250602084025.1881768-2-dvo-plv@napatech.com>
 <20250602085005.1882499-1-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|DU5P190MB2068:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4c74200-7714-4683-7ce7-08dda1b27b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DJ0ljRqtKdOrh2DrtfbVbIyXVR2Wp6N7EjEetTxiTgMIMGVZITivNvyURqzU?=
 =?us-ascii?Q?/l0px25htG5sZh7zcf1yfIvGeih5RNz6u/uiY7HrsDG1lh3Cs+3/KOa24PYn?=
 =?us-ascii?Q?3rF5oOTGU8KuOMFoPN3TtTQ+FhNugGRygQIgbmjxyANFh0+SVcuoP8ao8OYt?=
 =?us-ascii?Q?5NdDzbz+NKvxedloGmQXOGWByH3MqVAFt2g5Utcb5cSiVZ8kx0kslVS462Lm?=
 =?us-ascii?Q?5+SBsB7qE3u/hLp0kayD+blfbBV/m9zK1MgF0I7im5YXdhrmBLc97KRn4EO/?=
 =?us-ascii?Q?KzQ484FL7UZplygbrqo42/HwECWv/qqjFEkJbzaeYM+nbdvfQeVv5sPQYn7Y?=
 =?us-ascii?Q?ifQpDVSJsGYhdojMhgyd2iTF9+PortfDDK1zN97bzQtYAXOzcmflBnST+zQV?=
 =?us-ascii?Q?nXwddu1HN4Qjo43CIdQL2Rpwnl+dtuXIQd31SlddhQ5UIfQcIJ5QO8BVDEYn?=
 =?us-ascii?Q?0kRuaVepDK4eW/PXUupNOfG3LtR3DoZHRYMMen8ysw2fEfz8sUTx8v44Z7U2?=
 =?us-ascii?Q?flSzfPLPLeRphUydcGawPcrT3RB00RTcYjoH/A8lUOHlkTrgWwoKZP8KoLFi?=
 =?us-ascii?Q?tpDVeiljuxl4G4XSeznaMfldZIsinIyddNvuhDvr+QH7ikB6mONFaO15kw+h?=
 =?us-ascii?Q?QQMiCSf/qryiAM/FeVH+ut1oYKZT+uTjW0ygtQB+I4aTzApIP+7KkbCH6QpS?=
 =?us-ascii?Q?jWxkJYVKCy6KZo4bksdlOYofeeaBnLzb2DIc+KmPDTh51pqjCWMo0EXJUf7M?=
 =?us-ascii?Q?jwZKIVflJ7LZEGLTwOxE6/ZCpkHt/PlCqLdUWfLy6glJ6yUrlsXpz2xDyRv2?=
 =?us-ascii?Q?toc7c/i8bRbhm51vEBRZO8bCRnioZueQbZpsaCBvepkXhfYH1uDkVhxaqpNi?=
 =?us-ascii?Q?AW5QSgk9/5rI6Ccba0omVgsHc+0JPDkf4r86Ii9yCqgS6KyTaZ9vnOEHBMm6?=
 =?us-ascii?Q?mnkrT3KgYCJ/n941dxkhI8ysnOgzEJCOjoonPvrUFRmYox6a6wfovI9rF20i?=
 =?us-ascii?Q?xNvFmktb3/nC56nfkUn38StSKN3I4XT1vukyB8LAp0wJvlLqzY59TCPgOiCr?=
 =?us-ascii?Q?9M0ucNVfj+5ki0V9Vk9wMFuL2qn829TPlA5gyhFuGFHsi6iaoRFhy7BF5HRp?=
 =?us-ascii?Q?XDz97nflPhRmeNivrEnCNR8sF6HT0qL/X4GUdwG3Y+9V+V0v3pDOh8WuR4mk?=
 =?us-ascii?Q?tHW+DfhBV0cRXKKTdrJ0bEbM5hpuCaPTjX/oTRTByBLnIAEVCPwsjNQMnHD+?=
 =?us-ascii?Q?ho7rjpeSgu3aYfcFfLMyJJIllgtvZJ4Ew1SDTfXGQVeNU1L2gCrLH1cvsOIA?=
 =?us-ascii?Q?wrydAguhsBDEI4cSTeMrsSCD0EwzYQT+LkIfggWOLomYyA3SiMLaHu9RaO/e?=
 =?us-ascii?Q?aJWqWMfWIPW1NYzbu7FGq0XTYXZvInEC3ByOEnPXhc6OyoK//q0CFPWTQeO7?=
 =?us-ascii?Q?QOnHOwnMni+IWZsJ+2C0SA7VQHzXXKDlavknrY3BRXErRIIMOlO4e2KYYMj+?=
 =?us-ascii?Q?ifvXkxNASLbDR5U1LbZtzUqXSu3zQz9lIcxLURPSlVdiAd/3WMbnaDzAQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iu+12jgKmdF+jcW+HvLXbqesD7lF7Hp+9lO7sKzaXL0WmMTn2X4FOi4DJCyxp81AikSdVvWab4A3aVI7Cu+0rhLAomN+lDCvIcNfRRAIL8s51LCpmhUDU9FDNh58SmfZ4skUNK9kVwCGwMVUoN6b61gdWAkWrrQ1dgMnMfnc/WjD/91p1ciGbmS2+HefX8lOftr1hIk34SgWFlKgiuxeJprXkHPcBs0ECQbFCgmYjQJT2QekuptgfVK26BEX1ZomFQafgAkLXxok/z9krGDF5HeeR3FEDxCDPzoXiSZOKNo/wV35l+9XGnGMQRuzIJ1lyNG1ZnlTqO3uoHyOE1JhsdiDi85RWhxvkNrOHs6D2m27W9W/U9GsKx3qNxWV/xva/EVV5g8AyEIzEKqi19GKYAjk39Hp5ttRBaXebdHdrGny4/OZLJ0SY+uF9yZmI7pCECwayqafuYyP98T2ovvPRhLHLBITVDPACsPmM6FKzVMiP7HvQQs8kwKN7+zd7EyeRFUa2NHjfG53vHRKtrk8cqD4NTpc7AkHtiQa8sGyhAtdavtDvRafk1wSTagxm3HhwMAsGsN64NIJEtZHvvt/detQyfSxkx2bnuvFnprmZyIVi9aqoocgMORL+qGivWMVaOdUm+kyNTk/dgh1kaRNPw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:50:10.1683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c74200-7714-4683-7ce7-08dda1b27b76
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5P190MB2068
X-BESS-ID: 1748854455-304981-7646-3278-2
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.21.92
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJhZAVgZQMC3VwNQszSjRzN
 jYNM3CwCIxKcXQIjExOTnVwNgwycxEqTYWAH0ROSVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265040 [from 
 cloudscan22-11.eu-central-1b.ess.aws.cudaops.com]
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

For vDPA devices, virtqueues are not locked once the device has been
configured. In the
commit 5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
the asserts were enhanced to trigger rte_panic functionality, preventing
access to virtqueues without locking. However, this change introduced
an issue where the memory hotplug mechanism, added in the
commit 127f9c6f7b78 ("vhost: handle memory hotplug with vDPA devices"),
no longer works. Since it expects for all queues are locked.

During the initialization of a vDPA device, the driver sets the
VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the
vhost_user_lock_all_queue_pairs function from locking the
virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED
flag allows the use of the hotplug mechanism, but it fails
because the virtqueues are not locked, while it expects to be locked
for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.

This patch addresses the issue by enhancing the conditional statement
to include a new condition. Specifically, when the device receives the
VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update
the basic configurations and hotplug the guest memory.

This fix does not impact access lock when vDPA driver is configured
for other unnecessary message handlers.

Manual memory configuring with "--socket-mem" option allows to avoid
hotplug mechanism using.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 lib/vhost/vhost_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index ec950acf97..16d03e1033 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)
 	 * would cause a dead lock.
 	 */
 	if (msg_handler != NULL && msg_handler->lock_all_qps) {
-		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
+		/* Lock all queue pairs if the device is not configured for vDPA,
+		 * or if it is configured for vDPA but the request is VHOST_USER_SET_MEM_TABLE.
+		 * This ensures proper queue locking for memory table updates and guest
+		 * memory hotplug.
+		 */
+		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
+			request == VHOST_USER_SET_MEM_TABLE) {
 			vhost_user_lock_all_queue_pairs(dev);
 			unlock_required = 1;
 		}
-- 
2.47.1

