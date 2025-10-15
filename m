Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E7CCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A52AA4111C;
	Wed, 15 Oct 2025 14:10:44 +0200 (CEST)
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
 by mails.dpdk.org (Postfix) with ESMTP id E02214111B
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530243; x=1792066243;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=O+OuH/hH1AlYqSNVVJdhMOoLxxFwRRiGyKXV161FkEQ=;
 b=QND4Vp0ebsNvPyS6G48Kv3y2QJJ3BYqHz2CNk64PXHQo5AfScZiGLi/5
 q7QdUugx7+1M52hUadmNifnPdYTH0HEQ23PgLLmueusB3uv4MuNenZgGj
 BnORVC9isMzVkfegrIawUIlXIH19TyZlfVLoWcR9C8H4opbxRf69VZWsd
 2c93wQ3inuxbxNK/zt5EP4Dp8fql45cCdPpE5OBsfyQYTgDvOq8O/mTIU
 q7o8NDsFiIJCysFFN2Ydot6sOkUfLoibgBPumSMpsNsPDv6hkqjpqoZQZ
 5LLe7Xs8MIr9VmDsPEud9Tej2q+b5wz3r0rwLArj3jnLqJObzg3rS7vDw g==;
X-CSE-ConnectionGUID: LsiB+MpVRCSjFr8DRNml+Q==
X-CSE-MsgGUID: 6PTd90eJS3u+3rBFbPMtTg==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4719316"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:10:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:11049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.122:2525]
 with esmtp (Farcaster)
 id a2439169-224a-4308-8f7b-27ec9b5905ae; Wed, 15 Oct 2025 12:10:40 +0000 (UTC)
X-Farcaster-Flow-ID: a2439169-224a-4308-8f7b-27ec9b5905ae
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:34 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:10:32 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 12/20] net/ena/base: add phc error statistics
Date: Wed, 15 Oct 2025 15:10:22 +0300
Message-ID: <20251015121022.2779-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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
index 75d89f0b75..3c7860ffb0 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -41,6 +41,7 @@
 #define ENA_MAX_ADMIN_POLL_US 5000
 
 #define ENA_MAX_INDIR_TABLE_LOG_SIZE 16
+
 /* PHC definitions */
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
@@ -1973,7 +1974,7 @@ void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
 
 int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 {
-	volatile struct ena_admin_phc_resp *read_resp = ena_dev->phc.virt_addr;
+	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
 	const ena_time_high_res_t zero_system_time = ENA_TIME_INIT_HIGH_RES();
 	struct ena_com_phc_info *phc = &ena_dev->phc;
 	ena_time_high_res_t expire_time;
@@ -2000,16 +2001,39 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -2017,13 +2041,15 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -2031,9 +2057,10 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -2041,19 +2068,23 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
@@ -2061,10 +2092,10 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
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
index a1121f1a1b..1d024cfea0 100644
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
@@ -286,22 +287,21 @@ struct ena_com_phc_info {
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

