Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320ECA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 09:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A8C40E0A;
	Tue,  6 Oct 2026 11:27:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1D14025F;
 Tue,  6 Oct 2026 11:27:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C2C720023D;
 Tue,  6 Oct 2026 11:27:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CAC6320023A;
 Tue,  6 Oct 2026 11:27:07 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 44983180006C;
 Tue,  6 Oct 2026 17:27:07 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v21 02/27] net/dpaa: fix probe success when FMC init fails
Date: Tue,  6 Oct 2026 14:56:38 +0530
Message-Id: <20261006092703.2138929-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006092703.2138929-1-hemant.agrawal@nxp.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
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

dpaa_dev_init() jumped to the free_rx cleanup label without setting ret
when dpaa_port_fmc_init() failed:

	if (num_rx_fqs < 0) {
		DPAA_PMD_ERR("%s FMC initializes failed!", dpaa_intf->name);
		goto free_rx;
	}

ret is still 0 from its initializer at that point, so free_rx returned
success and the port was probed with no Rx queues at all. The adjacent
"not configured by FMC" case already sets -ENODEV before the same goto.

Propagate the error from dpaa_port_fmc_init() instead.

Fixes: f5fe3eed5122 ("net/dpaa: support FMC parser for VSP")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index a5b02cc9a8..10b90417de 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2259,6 +2259,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		if (num_rx_fqs < 0) {
 			DPAA_PMD_ERR("%s FMC initializes failed!",
 				dpaa_intf->name);
+			ret = num_rx_fqs;
 			goto free_rx;
 		}
 		if (!num_rx_fqs) {
-- 
2.25.1

