Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20EECCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406B54064F;
	Sun, 18 Oct 2026 11:47:50 +0200 (CEST)
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
 by mails.dpdk.org (Postfix) with ESMTP id 4E90040276;
 Sun, 18 Oct 2026 11:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792316868; x=1823852868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=0PwraB6rIBYuzS9IO+Z4HVtm4k3Mgm/50GzPzwLezfw=;
 b=SVg+hWXaN9eieZwTap3sa08M8DwXqoqpvoQoitXT39IqwQTzI7MD3HxR
 1c/U0ZFl+OJfZ6P56EHWvWe4EV+pYpCatm0ot1C74qIfzgm0EUbmzgD/D
 lW/bsxmjxIuh9w80mS0mpVpT1a/boLll9HUtHG45N4GwaUkcPLwdeJDE/
 bTB5kYHzM1bcCBcwlGpPjPRx7LCBS+3+0m3S4cItgLcCNl0bKpVlRvUbM
 CjeyJxV88f6GC2r1xBrUahogj3zua3pysjE0s1c+o6zrMvPylEgjlz4X6
 6vgn3S23aB0hKpOGsNsYcJpYa9IpVbB/Gaq+7q0MY4V+Kfyrp9RS5Njv8 A==;
X-CSE-ConnectionGUID: nhNzvs0/QI2xCtHn83eOIw==
X-CSE-MsgGUID: k1AOFCOfT8+MTF+PzZrX1w==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31334507"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:47:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:30396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.90:2525]
 with esmtp (Farcaster)
 id c8a247c8-6c09-4ea0-a477-4d612be665aa; Sun, 18 Oct 2026 09:47:44 +0000 (UTC)
X-Farcaster-Flow-ID: c8a247c8-6c09-4ea0-a477-4d612be665aa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:47:44 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:47:42 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, <stable@dpdk.org>
Subject: [PATCH v3 03/13] net/ena/base: fix missing barriers in PHC timestamp
 read
Date: Sun, 18 Oct 2026 12:47:33 +0300
Message-ID: <ae8b367fde124aac5783ed23b2a7fb08a279d9d0.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
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
index 737626bcfa..49818c4bd0 100644
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

