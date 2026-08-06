Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C15C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF7040A4B;
	Thu,  6 Aug 2026 19:16:55 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 76F2A40A7D
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:53 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-902f92b8504so14342836d6.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036613; x=1786641413; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ENCgstaBWrbhEmEsqYPNEC2APxClPpju9+q1izXY04w=;
 b=aB9EAkHmno8iVPY4h1KfonRK89gg+PS6dbppvuBSRANV6/1JPQg6lZSPugIpUTjLaL
 PpBm/cBjDoqMmbWZd30vf2fvZWpho48htmrGdoQbAUfZcQFOXIv9tSbBrVAV0TKsGyGr
 1iZhNjhgaskTfy/+E3uOseCQc2IfYIWPK9huM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036613; x=1786641413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ENCgstaBWrbhEmEsqYPNEC2APxClPpju9+q1izXY04w=;
 b=W+Z1TBlStplEb739lV3H7dRXNR67Az6ThhiGA02oPyzQ93M5EH7/Kbj557MJ9ZmySX
 BkhRw6uWbT6ZPTuO1IsVKfufnjRiajuKXek7vce2rDdr8k/Delj1dDL/I60MaIrME92L
 /o46Zi+Hcz6TJG1h2VP1SQyMmuy+zmyUfQwAC3srTkNqqB9uzaqlfwiRYk1o/2D5Uyu/
 qV9mrw5WIVunp4eYKnxDW1DFbHZ7ToOkPpyOVvZu2dYZgHHDDLMrWDCa9k4BeNODsA2m
 /uncXzepxRXFi4OCQAG6JYx7Iyxc+fmOCyFwHKvm1YOZNorcQnHxZSD2TLaFD+4vBQXO
 qwqA==
X-Gm-Message-State: AOJu0YylTob/trzbDqC3oHFSE313+/gisP3mWvpamK/cZfjB+nMHbSF0
 Nkn7Ly5hdRJMmX7XIUzWoWwqMJclCZazkQgfQSNpePBDCaxFF34U2deoPWIDi3EmZU5MgeKyXD5
 3gWL5g7kCVRIJ+GYEuSEyo4fU8zYky2RDKpsqB0sW2N/4Ds+A668tQcU0+9EFdOEGrM1EZWiJCP
 suAett27h8vVzdgaLCrcuW904RCok=
X-Gm-Gg: AR+sD10rwEoAdLyZOLAtX6OD50qhMTayXI7oIcBBVGgDeo+NxwVNpSqGiUXubnAToTM
 +ZHjqHdqNXgFz+451JdqV8sj1itt9RxPshoHv8HST2An7cxUr0S+geskxA77jCKfREQ2FM9KKZH
 9c4GksxJqejS8k6ePZ0eU/VCwlxE8a80zfX2lPC4nxpuJ5wWlLuQGZZmSADQjv7HPs7KET44xYF
 N9XTXLGZzNsyAzKS1/0vo42YFk6FV2uIUNDlpeS+TubvStF09JIjUsCIkKorYsxrZQ945Gs4W1D
 oLpxwPvXE5XLdSORdfcJxpKfZnyciddmVUhGlugrJ7Vv6o/YLFejzEergpEICXHEwsk6CySTjG6
 WJtffnKQn9A9TCz6nd/ciLBHZIIAur2r2YVEc8FEGPK9h1W3h9p4TdS0io3H96rMfoQl9eeQUjm
 etYEalm4uPeW/+UzXSH7jvld4IC4tmBwKQh4yA3JBNiScbtsIFCLqA2Qn9GlK1/88j8/IdqFe77
 3P+YmmasOzlRWjrQe2hs5MRP5M9jzaVJY/M8ef6
X-Received: by 2002:a05:6214:2c08:b0:8ea:184f:c15a with SMTP id
 6a1803df08f44-9088125acb0mr207124886d6.17.1786036612507; 
 Thu, 06 Aug 2026 10:16:52 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:51 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 6/7] dmadev: fix incomplete configuration validation
Date: Thu,  6 Aug 2026 13:16:35 -0400
Message-ID: <20260806171636.656181-7-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chengwen Feng <fengchengwen@huawei.com>

Add a dma_check_vchan_conf() helper to validate rte_dma_vchan_conf
fields that do not depend on device capabilities: direction enum,
port_type enum, domain type enum, and all reserved[] arrays.

In rte_dma_configure(), reject undefined flag bits and non-zero
priority when the device lacks priority scheduling support.

Add negative-case tests for new checks in rte_dma_configure()
(undefined flags, capa-unaware flags/priority) and in
rte_dma_vchan_setup() (enum values, reserved fields, domain
mismatch, capability enforcement).

Fixes: b36970f2e13e ("dmadev: introduce DMA device library")

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
 lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
 2 files changed, 283 insertions(+), 59 deletions(-)

diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index 1ba053696b..fb2a1afcaa 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -130,6 +130,55 @@ test_dma_info_get(void)
 	return TEST_SUCCESS;
 }
 
+static int
+check_configure_extra(struct rte_dma_info *info)
+{
+	struct rte_dma_conf conf = { 0 };
+	int ret;
+
+	/* Check undefined flags */
+	for (int i = 2; i < 64; i++) {
+		memset(&conf, 0, sizeof(conf));
+		conf.nb_vchans = info->max_vchans;
+		conf.flags = RTE_BIT64(i);
+		ret = rte_dma_configure(test_dev_id, &conf);
+		RTE_TEST_ASSERT(ret == -EINVAL,
+			"Expected -EINVAL for undefined flag bit %d, %d", i, ret);
+	}
+
+	/* Check enable silent mode without support */
+	if (!(info->dev_capa & RTE_DMA_CAPA_SILENT)) {
+		memset(&conf, 0, sizeof(conf));
+		conf.nb_vchans = info->max_vchans;
+		conf.flags = RTE_DMA_CFG_FLAG_SILENT;
+		ret = rte_dma_configure(test_dev_id, &conf);
+		RTE_TEST_ASSERT(ret == -EINVAL,
+			"Expected -EINVAL for SILENT without capa, %d", ret);
+	}
+
+	/* Check enable enqueue/dequeue mode without support */
+	if (!(info->dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
+		memset(&conf, 0, sizeof(conf));
+		conf.nb_vchans = info->max_vchans;
+		conf.flags = RTE_DMA_CFG_FLAG_ENQ_DEQ;
+		ret = rte_dma_configure(test_dev_id, &conf);
+		RTE_TEST_ASSERT(ret == -EINVAL,
+			"Expected -EINVAL for ENQ_DEQ without capa, %d", ret);
+	}
+
+	/* Check non-zero priority without SP capability */
+	if (!(info->dev_capa & RTE_DMA_CAPA_PRI_POLICY_SP)) {
+		memset(&conf, 0, sizeof(conf));
+		conf.nb_vchans = info->max_vchans;
+		conf.priority = 1;
+		ret = rte_dma_configure(test_dev_id, &conf);
+		RTE_TEST_ASSERT(ret == -EINVAL,
+			"Expected -EINVAL for non-zero priority without SP, %d", ret);
+	}
+
+	return 0;
+}
+
 static int
 test_dma_configure(void)
 {
@@ -156,12 +205,9 @@ test_dma_configure(void)
 	ret = rte_dma_configure(test_dev_id, &conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
-	/* Check enable silent mode */
-	memset(&conf, 0, sizeof(conf));
-	conf.nb_vchans = info.max_vchans;
-	conf.flags = RTE_DMA_CFG_FLAG_SILENT;
-	ret = rte_dma_configure(test_dev_id, &conf);
-	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
+	/* Check flags, priority extra validations */
+	ret = check_configure_extra(&info);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to check configure extra");
 
 	/* Configure success */
 	memset(&conf, 0, sizeof(conf));
@@ -209,12 +255,21 @@ check_direction(void)
 }
 
 static int
-check_port_type(struct rte_dma_info *dev_info)
+check_vchan_port(struct rte_dma_info *dev_info)
 {
 	struct rte_dma_vchan_conf vchan_conf;
 	int ret;
 
-	/* Check src port type validation */
+	/* Check invalid port_type enum values */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.src_port.port_type = RTE_DMA_PORT_PCIE + 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for invalid port_type, %d", ret);
+
+	/* Check src port type vs direction mismatch */
 	memset(&vchan_conf, 0, sizeof(vchan_conf));
 	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
 	vchan_conf.nb_desc = dev_info->min_desc;
@@ -222,7 +277,7 @@ check_port_type(struct rte_dma_info *dev_info)
 	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
-	/* Check dst port type validation */
+	/* Check dst port type vs direction mismatch */
 	memset(&vchan_conf, 0, sizeof(vchan_conf));
 	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
 	vchan_conf.nb_desc = dev_info->min_desc;
@@ -230,6 +285,105 @@ check_port_type(struct rte_dma_info *dev_info)
 	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
+	/* Check non-zero reserved fields in src_port */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.src_port.reserved[0] = 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for non-zero src_port.reserved, %d", ret);
+
+	/* Check non-zero reserved fields in dst_port */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.dst_port.reserved[0] = 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for non-zero dst_port.reserved, %d", ret);
+
+	return 0;
+}
+
+static int
+check_vchan_domain(struct rte_dma_info *dev_info)
+{
+	struct rte_dma_vchan_conf vchan_conf;
+	int ret;
+
+	/* Check invalid domain type enum */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.domain.type = RTE_DMA_INTER_OS_DOMAIN + 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for invalid domain type, %d", ret);
+
+	/* Check non-zero domain.reserved */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.domain.reserved[0] = 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for non-zero domain.reserved, %d", ret);
+
+	/* Check inter-domain type without MEM_TO_MEM direction */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_DEV;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.domain.type = RTE_DMA_INTER_PROCESS_DOMAIN;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for inter-domain non-MEM_TO_MEM, %d", ret);
+
+	/* Check domain INTER_PROCESS without capability */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.domain.type = RTE_DMA_INTER_PROCESS_DOMAIN;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for INTER_PROCESS without capa, %d", ret);
+
+	/* Check domain INTER_OS without capability */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.domain.type = RTE_DMA_INTER_OS_DOMAIN;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for INTER_OS without capa, %d", ret);
+
+	return 0;
+}
+
+static int
+check_auto_free_conf(struct rte_dma_info *dev_info)
+{
+	struct rte_dma_vchan_conf vchan_conf;
+	int ret;
+
+	/* Check non-zero reserved fields in auto_free */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.auto_free.reserved[0] = 1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for non-zero auto_free.reserved, %d", ret);
+
+	/* Check auto_free.m2d.pool without M2D auto-free capability */
+	memset(&vchan_conf, 0, sizeof(vchan_conf));
+	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	vchan_conf.nb_desc = dev_info->min_desc;
+	vchan_conf.auto_free.m2d.pool = (struct rte_mempool *)(uintptr_t)0x1;
+	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Expected -EINVAL for auto_free without M2D capa, %d", ret);
+
 	return 0;
 }
 
@@ -274,9 +428,17 @@ test_dma_vchan_setup(void)
 	ret = rte_dma_vchan_setup(test_dev_id, 0, &vchan_conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
-	/* Check port type */
-	ret = check_port_type(&dev_info);
-	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to check port type");
+	/* Check port type and reserved fields */
+	ret = check_vchan_port(&dev_info);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to check vchan port");
+
+	/* Check domain param validation */
+	ret = check_vchan_domain(&dev_info);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to check vchan domain");
+
+	/* Check auto_free config validation */
+	ret = check_auto_free_conf(&dev_info);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to check auto_free conf");
 
 	/* Check vchan setup success */
 	memset(&vchan_conf, 0, sizeof(vchan_conf));
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 822bb7c89f..2311f01906 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -480,6 +480,7 @@ RTE_EXPORT_SYMBOL(rte_dma_configure)
 int
 rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 {
+	const uint64_t valid_flags = RTE_DMA_CFG_FLAG_SILENT | RTE_DMA_CFG_FLAG_ENQ_DEQ;
 	struct rte_dma_info dev_info;
 	struct rte_dma_dev *dev;
 	int ret;
@@ -510,18 +511,28 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 			"Device %d configure too many vchans", dev_id);
 		return -EINVAL;
 	}
+
+	if (dev_info.dev_capa & RTE_DMA_CAPA_PRI_POLICY_SP) {
+		if (dev_conf->priority >= dev_info.nb_priorities) {
+			RTE_DMA_LOG(ERR, "Device %d configure invalid priority", dev_id);
+			return -EINVAL;
+		}
+	} else {
+		if (dev_conf->priority != 0) {
+			RTE_DMA_LOG(ERR, "Device %d should not configure priority", dev_id);
+			return -EINVAL;
+		}
+	}
+
+	if ((dev_conf->flags & ~valid_flags) != 0) {
+		RTE_DMA_LOG(ERR, "Device %d configure invalid flags", dev_id);
+		return -EINVAL;
+	}
 	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_SILENT)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support silent", dev_id);
 		return -EINVAL;
 	}
-
-	if ((dev_info.dev_capa & RTE_DMA_CAPA_PRI_POLICY_SP) &&
-	    (dev_conf->priority >= dev_info.nb_priorities)) {
-		RTE_DMA_LOG(ERR, "Device %d configure invalid priority", dev_id);
-		return -EINVAL;
-	}
-
 	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support enqueue/dequeue", dev_id);
@@ -632,13 +643,85 @@ rte_dma_close(int16_t dev_id)
 	return ret;
 }
 
+/* Perform verification on rte_dma_vchan_conf only. */
+static int
+dma_check_vchan_conf(int16_t dev_id, const struct rte_dma_vchan_conf *conf)
+{
+	bool src_is_dev, dst_is_dev;
+
+	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
+	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
+	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
+	    conf->direction != RTE_DMA_DIR_DEV_TO_DEV) {
+		RTE_DMA_LOG(ERR, "Device %d direction invalid!", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->src_port.port_type != RTE_DMA_PORT_NONE &&
+	    conf->src_port.port_type != RTE_DMA_PORT_PCIE) {
+		RTE_DMA_LOG(ERR, "Device %d source port type unsupported", dev_id);
+		return -EINVAL;
+	}
+	if (conf->src_port.reserved[0] != 0 || conf->src_port.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d src_port has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	src_is_dev = conf->direction == RTE_DMA_DIR_DEV_TO_MEM ||
+		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
+	if ((conf->src_port.port_type == RTE_DMA_PORT_NONE && src_is_dev) ||
+	    (conf->src_port.port_type != RTE_DMA_PORT_NONE && !src_is_dev)) {
+		RTE_DMA_LOG(ERR, "Device %d source port type invalid", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->dst_port.port_type != RTE_DMA_PORT_NONE &&
+	    conf->dst_port.port_type != RTE_DMA_PORT_PCIE) {
+		RTE_DMA_LOG(ERR, "Device %d destination port type unsupported", dev_id);
+		return -EINVAL;
+	}
+	if (conf->dst_port.reserved[0] != 0 || conf->dst_port.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d dst_port has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	dst_is_dev = conf->direction == RTE_DMA_DIR_MEM_TO_DEV ||
+		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
+	if ((conf->dst_port.port_type == RTE_DMA_PORT_NONE && dst_is_dev) ||
+	    (conf->dst_port.port_type != RTE_DMA_PORT_NONE && !dst_is_dev)) {
+		RTE_DMA_LOG(ERR,
+			"Device %d destination port type invalid", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->auto_free.reserved[0] != 0 || conf->auto_free.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d auto_free has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+
+	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
+	    conf->domain.type != RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    conf->domain.type != RTE_DMA_INTER_OS_DOMAIN) {
+		RTE_DMA_LOG(ERR, "Device %d domain type invalid!", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0) {
+		RTE_DMA_LOG(ERR, "Device %d domain has non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
+	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
+		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_dma_vchan_setup)
 int
 rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		    const struct rte_dma_vchan_conf *conf)
 {
 	struct rte_dma_info dev_info;
-	bool src_is_dev, dst_is_dev;
 	struct rte_dma_dev *dev;
 	int ret;
 
@@ -653,6 +736,10 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		return -EBUSY;
 	}
 
+	ret = dma_check_vchan_conf(dev_id, conf);
+	if (ret != 0)
+		return ret;
+
 	ret = rte_dma_info_get(dev_id, &dev_info);
 	if (ret != 0) {
 		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
@@ -666,34 +753,7 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
 		return -EINVAL;
 	}
-	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
-	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
-		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
-		return -EINVAL;
-	}
-	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
-	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
-		return -EINVAL;
-	}
-	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
-	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
-		return -EINVAL;
-	}
-	if ((conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN ||
-	    conf->domain.type == RTE_DMA_INTER_OS_DOMAIN) &&
-	    (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0)) {
-		RTE_DMA_LOG(ERR, "Device %d does not support non-zero reserved fields", dev_id);
-		return -EINVAL;
-	}
-	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
-	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
-	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
-	    conf->direction != RTE_DMA_DIR_DEV_TO_DEV) {
-		RTE_DMA_LOG(ERR, "Device %d direction invalid!", dev_id);
-		return -EINVAL;
-	}
+
 	if (conf->direction == RTE_DMA_DIR_MEM_TO_MEM &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_MEM_TO_MEM)) {
 		RTE_DMA_LOG(ERR,
@@ -724,19 +784,21 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 			"Device %d number of descriptors invalid", dev_id);
 		return -EINVAL;
 	}
-	src_is_dev = conf->direction == RTE_DMA_DIR_DEV_TO_MEM ||
-		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
-	if ((conf->src_port.port_type == RTE_DMA_PORT_NONE && src_is_dev) ||
-	    (conf->src_port.port_type != RTE_DMA_PORT_NONE && !src_is_dev)) {
-		RTE_DMA_LOG(ERR, "Device %d source port type invalid", dev_id);
+
+	if (conf->auto_free.m2d.pool != NULL &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_M2D_AUTO_FREE)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support m2d auto free", dev_id);
 		return -EINVAL;
 	}
-	dst_is_dev = conf->direction == RTE_DMA_DIR_MEM_TO_DEV ||
-		     conf->direction == RTE_DMA_DIR_DEV_TO_DEV;
-	if ((conf->dst_port.port_type == RTE_DMA_PORT_NONE && dst_is_dev) ||
-	    (conf->dst_port.port_type != RTE_DMA_PORT_NONE && !dst_is_dev)) {
-		RTE_DMA_LOG(ERR,
-			"Device %d destination port type invalid", dev_id);
+
+	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
 		return -EINVAL;
 	}
 
-- 
2.55.0

