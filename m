Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C98C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C25140689;
	Tue, 30 Jun 2026 15:24:30 +0200 (CEST)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by mails.dpdk.org (Postfix) with UTF8SMTP id A739640278
 for <dev@dpdk.org>; Mon, 29 Jun 2026 06:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1782706687; bh=y7WVaGwg71+jw9w6M4fkEXJvA16/cFygu9EeszQa0Hk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bTLyhpUSFfVCfFgfV1mWPIG9PeGUfTGwlKHoXRwBnQacD5r2uwFGo0Wlfo9ueSGJi
 rJ0V3UjPR9SEeDdyB2t07Eu1Uq+8vwn3F+BXXYd0IJiDd3vZgsShQJunPiDSLiQSqL
 X+Uyh9/6Kc4s4tNTVtN7vFzFKUqpJ+CdPod+ffbY=
Received: from fedora.tail0f0cf3.ts.net ([139.159.170.83])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 46F384AE; Mon, 29 Jun 2026 12:17:47 +0800
X-QQ-mid: xmsmtpt1782706682tezqghp5f
Message-ID: <tencent_FA6D169C1F95D7BDFE0311F6F7C95EDC2A0A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4Agr+cOQaAQOnNnNNQwDai+RVA/mneGQrHImzUUQMuzgIG/rj/juS
 MX/8MTEcijNK+GMBjJNSpJ70P5r4SP31wBcnJxRrTjHCf2rbsORBYXU22CmrV7JXqwFq2naK2hCM
 5TqqwILG3r4yTVzvZSm9tAg4B2BlPgAtxp06CMxdoOk6NlOxM6jp7YK7F/Mi2GKLS2ilsTwYjMqe
 pldMRYi8754DwQTFXuBawjCbLoRxQrRuitOjhRVfC+JADqlkwxKGYNebNgDFYYPnQa3ssy598mQM
 eGrbQez6rwDZ43B62+yfD832EkRi8wOAu/32fKMC5G8fjLNgo/c7nd8eOCAH3+V11Q0Ab3wSZjkb
 z23JS+k5+DZwtHr2HCd/yMETD0IbTNA7pf1nwnaWRsIJuNgp0CrPTQ5W8FOpWcLT0mDfBD1raP3P
 kCVxgpeO5uUpz7+aKFXNGfj6SfflZR8au3UluUFFDwri1HckFQtAHiW3HDdyyr1WY7g/gOIer8U+
 e0Q/pD36gd3F9sAhBprPUWbks/Cz+2AXm9d2N3LD5DSnIas2wgF0xy1JLN9lQlGm+zoC7N/C45JG
 MG1VYqlQnEKgaJeDt7gGzGGjQbTxSYUfqcEo1sFrnYHvonOj8aUUzM99ZjKAHqm0xkDYTrWqwr0m
 WY0KwNW3oeYY7ulr3p8mYtOWntmNoLpR/OGB1gFNORyP7IEXaD4/OrXWGZJyDEG2hQux24Tp0LxF
 8IQc9Xb0AxtQvXKZEyTadWMaK7Q/bTmn+oSxK9RXJykTRZkiKjQN2fy5mDElLlPbodtIwkwTSYFP
 1EXAcbAraxrwOA1ZllhXUBRXHfNNnbgk16+LwQBnY5JPfVflyK2Wjjv15u0tuAEDYBU2hrXEit/v
 SEHYRncshxUkjfYfB01B1VXPzdRf+Hl3LvTPSh4FtVKhigyLb0xrsDP0R7H5FSuUmCsfBJHD3Ho1
 26veaHminD8JLNedk2Hdx47BzEAoX1ZP7eUJJjNYNG0IS5L3TDuixO2qMd2YapX9DuoMkkV78jsU
 xDBgXopv0Qpr+KW9k0ywkIdMYzwMRUlez6LjmL/v7nQStpEv2X
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: datshan@qq.com
To: thomas@monjalon.net
Cc: dev@dpdk.org
Subject: [PATCH 2/2] test/dmadev: add config and vchan validation tests
Date: Mon, 29 Jun 2026 12:17:35 +0800
X-OQ-MSGID: <20260629041735.301180-3-datshan@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629041735.301180-1-datshan@qq.com>
References: <20260629041735.301180-1-datshan@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:24:27 +0200
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

