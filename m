Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA9CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301A440664;
	Tue, 13 Oct 2026 17:08:09 +0200 (CEST)
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
 by mails.dpdk.org (Postfix) with ESMTP id 1A58440272;
 Tue, 13 Oct 2026 17:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904087; x=1823440087;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=o0Fsi41/G95l240lfB8rkazypW1YhYZ3RjT83usbvZQ=;
 b=S5hWoxFMgomMpqnivgcabWJ6OTxEw+SRF3CzvmeK4aJcA6sogZRq2z5p
 FjYZTbKbzTwrGdnQmsZSwUox7KX65ylU3FIOXGqCJ9F2UPKazSeh3RCbH
 smiL1B7izXJJzkrF0mYW1sd6Yq2KwiDDHT300RbKU752mkXO0nV4MaoLD
 NMjvXM+bAG4FWW+lImL0CI8kqPuiDxRjDL62m1QddfmBOQWQ1nlmmUxyw
 jRshxz6TtFSwtSVnOd4EDWElhdp4e1wvvlySlh3d3XE7EP8seiUDmUdcj
 tWrZGul3/WtAvgpa/9i1EMGE7kbxXjRx2dE40+cKgwGmE3LviZGSNPPwg Q==;
X-CSE-ConnectionGUID: wO1Meh+tT96xN/rbcW8etQ==
X-CSE-MsgGUID: jjt2SCDPQNW0pueZw6M8eg==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31142667"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:08:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9167]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.115:2525]
 with esmtp (Farcaster)
 id 9daa0cc1-3345-4e2f-9060-936a27568b16; Tue, 13 Oct 2026 15:08:03 +0000 (UTC)
X-Farcaster-Flow-ID: 9daa0cc1-3345-4e2f-9060-936a27568b16
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:08:03 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:08:01 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH 03/13] net/ena/base: fix missing barriers in PHC timestamp read
Date: Tue, 13 Oct 2026 18:07:47 +0300
Message-ID: <20261013150747.9384-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
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

The PHC read path in ena_com_phc_get_timestamp() polls the shared
error_bound and timestamp fields for a matching req_id to detect
that the device has published a fresh reading. Both completion
checks read the payload without a barrier after observing req_id.

On weakly-ordered architectures the CPU may load the payload fields
before the req_id load is observed as updated, so a stale timestamp
or error bound can be returned while the read is reported as valid.

Add dma_rmb() after both req_id completion checks to order the
req_id load against the subsequent payload loads.

Fixes: a14be4dd8693 ("net/ena/base: add PHC error statistics")
Cc: stable@dpdk.org

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 50 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index f5b3cd70c8..f08d9214aa 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -2037,27 +2037,34 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 				    "PHC get time request 0x%x failed (device error)\n",
 				    phc->req_id);
 			phc->stats.phc_err_dv++;
-		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
-			/* Device updated req_id during blocking time but got
-			 * a PHC error, this occurs if device:
-			 * - exceeded the get time request limit
-			 * - received an invalid timestamp
-			 * - received an excessively high error bound
-			 * - received an invalid error bound
-			 */
-			ena_trc_err(ena_dev,
-				    "PHC get time request 0x%x failed (error 0x%x)\n",
-				    phc->req_id,
-				    resp->error_flags);
-			phc->stats.phc_err_ts += !!(resp->error_flags &
-				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
-			phc->stats.phc_err_eb += !!(resp->error_flags &
-				ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND);
 		} else {
-			/* Device updated req_id during blocking time
-			 * with valid timestamp and error bound
+			/* Ensure PHC payload is read after req_id update
+			 * is observed
 			 */
-			phc->stats.phc_exp++;
+			dma_rmb();
+
+			if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
+				/* Device updated req_id during blocking time
+				 * but got a PHC error, this occurs if device:
+				 * - exceeded the get time request limit
+				 * - received an invalid timestamp
+				 * - received an excessively high error bound
+				 * - received an invalid error bound
+				 */
+				ena_trc_err(ena_dev,
+					    "PHC get time request 0x%x failed (error 0x%x)\n",
+					    phc->req_id,
+					    resp->error_flags);
+				phc->stats.phc_err_ts += !!(resp->error_flags &
+					ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+				phc->stats.phc_err_eb += !!(resp->error_flags &
+					ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND);
+			} else {
+				/* Device updated req_id during blocking time
+				 * with valid timestamp and error bound
+				 */
+				phc->stats.phc_exp++;
+			}
 		}
 	}
 
@@ -2100,6 +2107,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			continue;
 		}
 
+		/* Ensure PHC payload (timestamp, error_bound, error_flags)
+		 * is read after req_id update is observed
+		 */
+		dma_rmb();
+
 		/* req_id was updated by the device which indicates that
 		 * PHC timestamp, error_bound and error_flags are updated too,
 		 * checking errors before retrieving timestamp and
-- 
2.17.1

