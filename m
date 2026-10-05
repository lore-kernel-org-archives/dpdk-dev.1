Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517ACA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 08:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13E0740A72;
	Mon,  5 Oct 2026 10:53:45 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8D7C8402B5;
 Mon,  5 Oct 2026 10:53:41 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 56A811A0086;
 Mon,  5 Oct 2026 10:53:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20BD31A0088;
 Mon,  5 Oct 2026 10:53:41 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8E0D2180022D;
 Mon,  5 Oct 2026 16:53:40 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v20 02/27] net/dpaa: fix probe success when FMC init fails
Date: Mon,  5 Oct 2026 14:23:12 +0530
Message-Id: <20261005085337.1069213-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
References: <20261001112430.251845-1-hemant.agrawal@nxp.com>
 <20261005085337.1069213-1-hemant.agrawal@nxp.com>
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

Propagate the error from dpaa_port_fmc_init() instead, and clear
num_rx_fqs so the cleanup path does not use the negative count when
releasing the CGRID range.

Fixes: f5fe3eed51d2 ("net/dpaa: support FMC parser for VSP")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index a5b02cc9a8..834476bd8a 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2259,6 +2259,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		if (num_rx_fqs < 0) {
 			DPAA_PMD_ERR("%s FMC initializes failed!",
 				dpaa_intf->name);
+			ret = num_rx_fqs;
+			num_rx_fqs = 0;
 			goto free_rx;
 		}
 		if (!num_rx_fqs) {
-- 
2.25.1

