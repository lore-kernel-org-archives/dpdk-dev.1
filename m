Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E6CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D59174069F;
	Tue, 13 Oct 2026 17:11:15 +0200 (CEST)
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [34.218.115.239])
 by mails.dpdk.org (Postfix) with ESMTP id 910B240682;
 Tue, 13 Oct 2026 17:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904273; x=1823440273;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=3PslACmFJTYDgoCMeaaRvRkkybXtFFq4SdTSMcIJqFE=;
 b=HH6/BYz+lodzmGrfdjW3VDNHBj3eDnmytoOZVwP+Euv1ygNangs69gP/
 gDd57JmAP+pH/WUklM4NWlmlKedVdlX2tK/VaFxp1dFbxqGyPnRjsu5s/
 e9pio9jAZdi5VbQya8fm8Ng/eO1V7brs2LsBGXbJ1dR3HRfw/j+G6Z2F0
 7EfF/DpV7jkPZIIOVoKT5Xta+cyrT7VGpA2gWSvcnFg/3GeHNxUtefN44
 s9fie/RRMCpcqegHoSMHa71scksn2mkGIQZ2FTUrhUdDq0ISEsbdYOVxT
 2CPuQ1ACVMCcvSbkfktNaT/h2h2P51+Pex1+fLXmUDXpO/WKXkj6x6xIa w==;
X-CSE-ConnectionGUID: Eaoe8TIyR2ed6TUDzezuhw==
X-CSE-MsgGUID: narp+6blRIetvzt4MGR4JQ==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="30917485"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:11:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:13830]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.115:2525]
 with esmtp (Farcaster)
 id be657559-759f-4adc-a025-7f2d2417a3aa; Tue, 13 Oct 2026 15:11:12 +0000 (UTC)
X-Farcaster-Flow-ID: be657559-759f-4adc-a025-7f2d2417a3aa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:11:12 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:11:10 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 10/13] net/ena/base: fix LLQ config failure flow
Date: Tue, 13 Oct 2026 18:10:53 +0300
Message-ID: <20261013151053.9727-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

ena_com_config_dev_mode() computes tx_max_header_size directly
into the ena_com_dev structure and only afterwards rejects the
result if it came out zero. The error path therefore leaves the
device with tx_max_header_size == 0, overwriting the value the
device reported in ena_com_get_dev_attr_feat().

The failure is not fatal to the caller: the PMD logs it, falls
back to host placement policy and continues, so the zeroed value
stays in effect. It is then copied into the per-ring field, which
sizes the Tx intermediate header buffer to zero and clamps
header_len to zero on every transmit.

Compute the value into a local variable, validate it there, and
store it into ena_dev only once it is known good, so a failed LLQ
configuration leaves the previously negotiated value untouched.

Fixes: b2b02edeb0d6 ("net/ena/base: upgrade HAL for new HW features")
Cc: stable@dpdk.org

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 7ec36b8814..9030b0f2c1 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -3581,6 +3581,7 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 			    struct ena_llq_configurations *llq_default_cfg)
 {
 	struct ena_com_llq_info *llq_info = &ena_dev->llq_info;
+	u32 llq_max_header_size;
 	int rc;
 
 	if (!llq_features->max_llq_num) {
@@ -3592,14 +3593,15 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 	if (unlikely(rc))
 		return rc;
 
-	ena_dev->tx_max_header_size = llq_info->common.desc_list_entry_size -
+	llq_max_header_size = llq_info->common.desc_list_entry_size -
 		(llq_info->common.descs_num_before_header * sizeof(struct ena_eth_io_tx_desc));
 
-	if (unlikely(ena_dev->tx_max_header_size == 0)) {
+	if (unlikely(llq_max_header_size == 0)) {
 		ena_trc_err(ena_dev, "The size of the LLQ entry is smaller than needed\n");
 		return ENA_COM_INVAL;
 	}
 
+	ena_dev->tx_max_header_size = llq_max_header_size;
 	ena_dev->tx_mem_queue_type = ENA_ADMIN_PLACEMENT_POLICY_DEV;
 
 	return 0;
-- 
2.17.1

