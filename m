Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC2CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27EB640ED8;
	Thu, 18 Jun 2026 16:12:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id F212140268;
 Thu, 18 Jun 2026 16:12:13 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA2971A0019;
 Thu, 18 Jun 2026 16:12:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A53091A002F;
 Thu, 18 Jun 2026 16:12:13 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B334180004C;
 Thu, 18 Jun 2026 22:12:11 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 15/17] net/dpaa: fix wrong buffer in xstats get by id
Date: Thu, 18 Jun 2026 19:41:49 +0530
Message-Id: <20260618141151.3990283-16-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

In dpaa_xstats_get_by_id(), fman_if_bmi_stats_get_all() was called
with 'values' (the output array) instead of 'values_copy' (the
scratch buffer). This caused the BMI stats to overwrite already
computed xstat values and then the subsequent loop would copy
garbage from values_copy into the output.

Pass 'values_copy' as intended so that BMI stats are fetched into
the scratch buffer and then correctly indexed into 'values'.

Fixes: d2536b006d ("bus/dpaa: add port buffer manager stats")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index eaeb4221c9..a221406cbf 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -928,7 +928,7 @@ dpaa_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 			values[i] =
 				values_copy[dpaa_xstats_strings[i].offset / 8];
 
-		fman_if_bmi_stats_get_all(dev->process_private, values);
+		fman_if_bmi_stats_get_all(dev->process_private, values_copy);
 		for (j = 0; i < stat_cnt; i++, j++)
 			values[i] = values_copy[j];
 
-- 
2.43.0

