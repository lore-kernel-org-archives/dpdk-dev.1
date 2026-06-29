Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E6C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:19:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2B3B40654;
	Mon, 29 Jun 2026 08:19:29 +0200 (CEST)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by mails.dpdk.org (Postfix) with UTF8SMTP id C05CF402C6
 for <dev@dpdk.org>; Mon, 29 Jun 2026 08:19:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782713963; bh=y7WVaGwg71+jw9w6M4fkEXJvA16/cFygu9EeszQa0Hk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KhnPGR5ooTndyV68TIu91Fkf+1gbmRMhQsmSvcthuGlD8cqSRU5dSZsc/fQnkvTOX
 CRg+2vfSrfsHslL93MRSTQdBIFqzLbCWN3IQenReHwQ3H4gbx6FvDSdXsPDHMWsyQO
 MOUTQ818CSc69xIDf+hZP4/3RZA51G4877H1X99Q=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 4D416624; Mon, 29 Jun 2026 14:19:20 +0800
X-QQ-mid: xmsmtpt1782713961txafjkb01
Message-ID: <tencent_331EFDF3B22AB74F9B4BE703E59DAFC44008@qq.com>
X-QQ-XMAILINFO: OenRjd0v1BXMPZNLuQUnWcKQfBfXjvl+ACehl4zUYM3nwISbU2f6JUpxWaNwW0
 U5gFaT09ONlUiIHjRVKLRAAL8vT+r1PBb0Seeu++6mKNt6Tm+usioiSVSyfjY57rdDlX3gyTlVW6
 4mq6QUcRv0zPrafpm3cDBi+K/Wf3JagtHxCynNXvrQCMTl4iF07CdyAWLEVsJez/iw/AYmWLpoyv
 Z5ze+Iw+cSI2SK5FRLwylsJl6RvWGEU2qmkalI8Jl87eVinggovjEO+4hslLwE0CwI2WPitcFbZU
 8pWUoPm4XCFlhjqmc0catcdXqV+sU7ML4xxFYUVzJF/q590HuDVD2QF3IkRFdlEcXbD6g9pOmTxD
 mcPgNKX0yloDqKzSbpDGGGVk1pINLIPpdskyXmFKnGq30eb+ypkwYdHIhYedivnAX8ZLst3uykrs
 HZoEKYFWFGCiqFd09jLas7BmT3DvP0e5QKM2QohpozcDWXeWnlTVosSzcVFD3asn8KZDrCIw/V+w
 4FRfuFqwd0qXpdj86Pk03jQI3N2kyZVE0afBJexMf6domkHQIShZTgoZiyZO7LRwPhzO4KGop9Bc
 +fW/+BS1eMYK/Mq44EXzaiU3RHYPAkGW9fDzX2rYjTT/LSpqiHOtfYIuKSWyfh/bYOl4FYatGBlQ
 MXykbP/LNJU+B1CGSI2OD8XTDOwt1JBtkMg3xsg9kVQn9N9ntThKCo3Hbe1OMUqyhuCjb/YoJKKw
 uKdK6vgQtvtZgr6CwQ+1PiyvuzgbbnVA8MIbwjHt+1hjIFaL1eO5lVVnYLEltC5Y55mbDD8Joq7k
 cf+4OdGVsPjpNhkf/wB0fHEspsy8UGExN4Mp/dxtmfAVnNP/V9Mw5vIWsVejiFTThbTJBl9r18wj
 dL9vO/flbI6gaUoAVpHvw6a44RceJBip9XP0ElWoL/zAq8WelEtWqhegS9mN2GdxV9uzfx2sL7A6
 3+iJWVlaeAnnFIzPzOVdwYJn0uV7FDcLDd2lUrTx5bShWQZ8Swf8/wI9fPdJVSd4vc1sDvShfT2W
 mtwLRvJbRKhhpgSblI2faG29stLGm/+aT7RYKJxiAwLG80gQ2TYix6hbbEDnmrp57LmpwY8BFPTs
 spabeb
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: datshan@qq.com
To: thomas@monjalon.net
Cc: dev@dpdk.org
Subject: [PATCH 2/2] test/dmadev: add config and vchan validation tests
Date: Mon, 29 Jun 2026 14:19:17 +0800
X-OQ-MSGID: <20260629061917.321374-3-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629061917.321374-1-datshan@qq.com>
References: <20260629061917.321374-1-datshan@qq.com>
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

Add negative-case tests for new checks in rte_dma_configure()
(undefined flags, capa-unaware flags/priority) and in
rte_dma_vchan_setup() (enum values, reserved fields, domain
mismatch, capability enforcement).

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
 1 file changed, 174 insertions(+), 12 deletions(-)

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
-- 
2.54.0

