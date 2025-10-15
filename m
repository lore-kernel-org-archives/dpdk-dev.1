Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AE8CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA4E40648;
	Wed, 15 Oct 2025 09:14:47 +0200 (CEST)
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.34.181.151]) by mails.dpdk.org (Postfix) with ESMTP id B4321402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:14:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512485; x=1792048485;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Kw6nTKuKCORRIGuVhWh/pztKhpmPUUSMsV3cmwwhsek=;
 b=mAmKfwlE5FTIQydwgLrmuWMPRbki1giDbTAslvuygs5u7U8W/w4tILXo
 t9LJwmpRvhoztC9aQmt+JEufKeiyKl2iS+iq0qZ8Fd45S6N3TAywehgDq
 EjRZz8CR9DU6gawPUmfcvQ1YWJw0QTT3WbGRydT8znYT3xA7zg6kiJisv
 fOSWgfcRKkkfFMdJbJDd54cBsrTYViwEW6WwMVE0pzB1Kdfgb6T3ufVqQ
 2h3knQlMjvnXFwECCQDZVt6o5AhTOq5aVH0AS/tt2RTI5OIXbXJWRSN4d
 Xb4iJ7Y4jTswybHTqF3daFGLEoJeUZnQeSl9dvJ+04v4O/5T4QGJtAyNN Q==;
X-CSE-ConnectionGUID: uK/p3bbPSGOFuOLfrfAwaw==
X-CSE-MsgGUID: L0eyoDwnTIaJfVldkYqssg==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="4917291"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:14:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:24266]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.156:2525]
 with esmtp (Farcaster)
 id be1eea6d-3123-4afe-879e-fb1423deaae7; Wed, 15 Oct 2025 07:14:44 +0000 (UTC)
X-Farcaster-Flow-ID: be1eea6d-3123-4afe-879e-fb1423deaae7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:14:37 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:14:36 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH 13/21] net/ena/base: add phc error statistics
Date: Wed, 15 Oct 2025 10:14:24 +0300
Message-ID: <20251015071424.894-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

1. Replace the `phc_err` statistic with 3 distinct PHC error statistics
   for more detailed diagnostics:
   - phc_err_dv: Counts failures due to device errors, this occurs when
     the device fails to respond to get phc request.
   - phc_err_ts: Counts failures caused by timestamp errors,
     such as exceeding request limit or receiving
     an invalid timestamp.
   - phc_err_eb: Counts failures due to error bound errors, such as
     receiving an excessively high or invalid error bound.
2. Add error log for PHC failures. Logging may introduce
   slight delays between readings.
3. Shorten variable names for improved code readability.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c | 81 +++++++++++++++++++++++-----------
 drivers/net/ena/base/ena_com.h | 18 ++++----
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index db0c09c2f9..e7033cf327 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -41,6 +41,7 @@
 #define ENA_MAX_ADMIN_POLL_US 5000
 
 #define ENA_MAX_INDIR_TABLE_LOG_SIZE 16
+
 /* PHC definitions */
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
@@ -1994,7 +1995,7 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 
 int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 {
-	volatile struct ena_admin_phc_resp *read_resp = ena_dev->phc.virt_addr;
+	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ena_time_high_res_t zero_system_time = ENA_TIME_INIT_HIGH_RES();
 	struct ena_com_phc_info *phc = &ena_dev->phc;
 	ena_time_high_res_t expire_time;
@@ -2021,16 +2022,39 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			goto skip;
 		}
 
-		/* PHC is in active state, update statistics according to req_id and error_flags */
-		if ((READ_ONCE16(read_resp->req_id) != phc->req_id) ||
-		    (read_resp->error_flags & ENA_PHC_ERROR_FLAGS))
-			/* Device didn't update req_id during blocking time or timestamp is invalid,
+		/* PHC is in active state, update statistics according
+		 * to req_id and error_flags
+		 */
+		if (READ_ONCE16(resp->req_id) != phc->req_id) {
+			/* Device didn't update req_id during blocking time,
 			 * this indicates on a device error
 			 */
-			phc->stats.phc_err++;
-		else
-			/* Device updated req_id during blocking time with valid timestamp */
+			ena_trc_err(ena_dev,
+				    "PHC get time request 0x%x failed (device error)\n",
+				    phc->req_id);
+			phc->stats.phc_err_dv++;
+		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
+			/* Device updated req_id during blocking time but got
+			 * a PHC error, this occurs if device:
+			 * - exceeded the get time request limit
+			 * - received an invalid timestamp
+			 * - received an excessively high error bound
+			 * - received an invalid error bound
+			 */
+			ena_trc_err(ena_dev,
+				    "PHC get time request 0x%x failed (error 0x%x)\n",
+				    phc->req_id,
+				    resp->error_flags);
+			phc->stats.phc_err_ts += !!(resp->error_flags &
+				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+			phc->stats.phc_err_eb += !!(resp->error_flags &
+				ENA_ADMIN_PHC_ERROR_FLAG_ERROR_BOUND);
+		} else {
+			/* Device updated req_id during blocking time
+			 * with valid timestamp and error bound
+			 */
 			phc->stats.phc_exp++;
+		}
 	}
 
 	/* Setting relative timeouts */
@@ -2038,13 +2062,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 	block_time = ENA_GET_SYSTEM_TIMEOUT_HIGH_RES(phc->system_time, phc->block_timeout_usec);
 	expire_time = ENA_GET_SYSTEM_TIMEOUT_HIGH_RES(phc->system_time, phc->expire_timeout_usec);
 
-	/* We expect the device to return this req_id once the new PHC timestamp is updated */
+	/* We expect the device to return this req_id once
+	 * the new PHC timestamp is updated
+	 */
 	phc->req_id++;
 
-	/* Initialize PHC shared memory with different req_id value to be able to identify once the
-	 * device changes it to req_id
+	/* Initialize PHC shared memory with different req_id value
+	 * to be able to identify once the device changes it to req_id
 	 */
-	read_resp->req_id = phc->req_id + ENA_PHC_REQ_ID_OFFSET;
+	resp->req_id = phc->req_id + ENA_PHC_REQ_ID_OFFSET;
 
 	/* Writing req_id to PHC bar */
 	ENA_REG_WRITE32(ena_dev->bus, phc->req_id, ena_dev->reg_bar + phc->doorbell_offset);
@@ -2052,9 +2078,10 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 	/* Stalling until the device updates req_id */
 	while (1) {
 		if (unlikely(ENA_TIME_EXPIRE_HIGH_RES(expire_time))) {
-			/* Gave up waiting for updated req_id, PHC enters into blocked state until
-			 * passing blocking time, during this time any get PHC timestamp or
-			 * error bound requests will fail with device busy error
+			/* Gave up waiting for updated req_id,
+			 * PHC enters into blocked state until passing blocking time,
+			 * during this time any get PHC timestamp or error bound
+			 * requests will fail with device busy error
 			 */
 			phc->error_bound = ENA_PHC_MAX_ERROR_BOUND;
 			ret = ENA_COM_DEVICE_BUSY;
@@ -2062,19 +2089,23 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 		}
 
 		/* Check if req_id was updated by the device */
-		if (READ_ONCE16(read_resp->req_id) != phc->req_id) {
-			/* req_id was not updated by the device yet, check again on next loop */
+		if (READ_ONCE16(resp->req_id) != phc->req_id) {
+			/* req_id was not updated by the device yet,
+			 * check again on next loop
+			 */
 			continue;
 		}
 
-		/* req_id was updated by the device which indicates that PHC timestamp, error_bound
-		 * and error_flags are updated too, checking errors before retrieving timestamp and
+		/* req_id was updated by the device which indicates that
+		 * PHC timestamp, error_bound and error_flags are updated too,
+		 * checking errors before retrieving timestamp and
 		 * error_bound values
 		 */
-		if (unlikely(read_resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
-			/* Retrieved timestamp or error bound errors, PHC enters into blocked state
-			 * until passing blocking time, during this time any get PHC timestamp or
-			 * error bound requests will fail with device busy error
+		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
+			/* Retrieved timestamp or error bound errors,
+			 * PHC enters into blocked state until passing blocking time,
+			 * during this time any get PHC timestamp or error bound
+			 * requests will fail with device busy error
 			 */
 			phc->error_bound = ENA_PHC_MAX_ERROR_BOUND;
 			ret = ENA_COM_DEVICE_BUSY;
@@ -2082,10 +2113,10 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 		}
 
 		/* PHC timestamp value is returned to the caller */
-		*timestamp = read_resp->timestamp;
+		*timestamp = resp->timestamp;
 
 		/* Error bound value is cached for future retrieval by caller */
-		phc->error_bound = read_resp->error_bound;
+		phc->error_bound = resp->error_bound;
 
 		/* Update statistic on valid PHC timestamp retrieval */
 		phc->stats.phc_cnt++;
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index bc8e88c7ae..ed4bac4e72 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -102,7 +102,6 @@ struct ena_com_io_cq {
 	/* Interrupt unmask register */
 	u32 __iomem *unmask_reg;
 
-
 	/* numa configuration register (for TPH) */
 	u32 __iomem *numa_node_cfg_reg;
 
@@ -209,7 +208,9 @@ struct ena_com_stats_phc {
 	u64 phc_cnt;
 	u64 phc_exp;
 	u64 phc_skp;
-	u64 phc_err;
+	u64 phc_err_dv;
+	u64 phc_err_ts;
+	u64 phc_err_eb;
 };
 
 struct ena_com_admin_queue {
@@ -287,22 +288,21 @@ struct ena_com_phc_info {
 	u32 doorbell_offset;
 
 	/* Shared memory read expire timeout (usec)
-	 * Max time for valid PHC retrieval, passing this threshold will fail the get time request
-	 * and block new PHC requests for block_timeout_usec in order to prevent floods on busy
-	 * device
+	 * Max time for valid PHC retrieval, passing this threshold will fail
+	 * the get time request and block new PHC requests for block_timeout_usec
+	 * in order to prevent floods on busy device
 	 */
 	u32 expire_timeout_usec;
 
 	/* Shared memory read abort timeout (usec)
-	 * PHC requests block period, blocking starts once PHC request expired in order to prevent
-	 * floods on busy device, any PHC requests during block period will be skipped
+	 * PHC requests block period, blocking starts once PHC request expired
+	 * in order to prevent floods on busy device,
+	 * any PHC requests during block period will be skipped
 	 */
 	u32 block_timeout_usec;
 
 	/* PHC shared memory - physical address */
 	dma_addr_t phys_addr;
-
-	/* PHC shared memory handle */
 	ena_mem_handle_t mem_handle;
 
 	/* Cached error bound per timestamp sample */
-- 
2.17.1

