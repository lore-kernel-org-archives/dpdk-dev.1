Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07196CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B465E40B9C;
	Wed,  6 May 2026 19:22:59 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 02C1040671
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hy95PvJzHnGgl
 for <dev@dpdk.org>; Thu,  7 May 2026 01:21:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id D104540569
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:51 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:51 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 08/10] test/bpf: test loading ELF file from memory
Date: Wed, 6 May 2026 18:22:05 +0100
Message-ID: <20260506172209.6805-9-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Run each subtest in test_bpf_elf twice: the old way loading ELF images
via temporary file, and using the new rte_bpf_load_ex API to load them
directly from memory.

In tests loading port/queue filters use new rte_bpf_eth_(rx|tx)_install
API to install an already loaded (via one of the ways) BPF program.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 193 ++++++++++++++++++++++++++------------------
 1 file changed, 113 insertions(+), 80 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index c8a4ee755097..69e84f0cab56 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3977,12 +3977,61 @@ create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
 
 #include "test_bpf_load.h"
 
+/* Function loading BPF program from ELF image in memory. */
+typedef struct rte_bpf *
+(*load_elf_image_t)(const void *data, size_t size, const char *section,
+	const struct rte_bpf_xsym *xsym, uint32_t nb_xsym, const struct rte_bpf_arg *prog_arg);
+
+/* Load BPF program by writing ELF image to temporary file and opening this file. */
+static struct rte_bpf *
+load_elf_image_temp_file(const void *data, size_t size, const char *section,
+	const struct rte_bpf_xsym *xsym, uint32_t nb_xsym, const struct rte_bpf_arg *prog_arg)
+{
+	/* Create temp file from embedded BPF object */
+	char *tmpfile = create_temp_bpf_file(data, size, "test");
+	if (tmpfile == NULL) {
+		rte_errno = EIO;
+		return NULL;
+	}
+
+	/* Try to load BPF program from temp file */
+	const struct rte_bpf_prm prm = {
+		.xsym = xsym,
+		.nb_xsym = nb_xsym,
+		.prog_arg = *prog_arg,
+	};
+
+	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, section);
+	unlink(tmpfile);
+	free(tmpfile);
+
+	return bpf;
+}
+
+/* Load BPF program by calling rte_bpf_load_ex and specifying image as the origin. */
+static struct rte_bpf *
+load_elf_image_direct(const void *data, size_t size, const char *section,
+	const struct rte_bpf_xsym *xsym, uint32_t nb_xsym, const struct rte_bpf_arg *prog_arg)
+{
+	return rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_ELF_MEMORY,
+		.elf_memory.data = data,
+		.elf_memory.size = size,
+		.elf_memory.section = section,
+		.xsym = xsym,
+		.nb_xsym = nb_xsym,
+		.prog_arg[0] = *prog_arg,
+		.nb_prog_arg = 1,
+	});
+}
+
 /*
  * Test loading BPF program from an object file.
  * This test uses same arguments as previous test_call1 example.
  */
 static int
-test_bpf_elf_load(void)
+test_bpf_elf_load(load_elf_image_t load_elf_image)
 {
 	static const char test_section[] = "call1";
 	uint8_t tbuf[sizeof(struct dummy_vect8)];
@@ -4010,28 +4059,15 @@ test_bpf_elf_load(void)
 			},
 		},
 	};
-	int ret;
-
-	/* Create temp file from embedded BPF object */
-	char *tmpfile = create_temp_bpf_file(app_test_bpf_load_o,
-					     app_test_bpf_load_o_len,
-					     "load");
-	if (tmpfile == NULL)
-		return -1;
-
-	/* Try to load BPF program from temp file */
-	const struct rte_bpf_prm prm = {
-		.xsym = xsym,
-		.nb_xsym = RTE_DIM(xsym),
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(tbuf),
-		},
+	static const struct rte_bpf_arg prog_arg = {
+		.type = RTE_BPF_ARG_PTR,
+		.size = sizeof(tbuf),
 	};
+	struct rte_bpf *bpf;
+	int ret;
 
-	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, test_section);
-	unlink(tmpfile);
-	free(tmpfile);
+	bpf = load_elf_image(app_test_bpf_load_o, app_test_bpf_load_o_len, test_section,
+		xsym, RTE_DIM(xsym), &prog_arg);
 
 	/* If libelf support is not available */
 	if (bpf == NULL && rte_errno == ENOTSUP)
@@ -4174,22 +4210,28 @@ setup_mbufs(struct rte_mbuf *burst[], unsigned int n)
 	return tcp_count;
 }
 
-static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
-		       const char *section, uint32_t flags)
+static int bpf_tx_test(uint16_t port, struct rte_mempool *pool, load_elf_image_t load_elf_image,
+	const char *section, uint32_t flags)
 {
-	const struct rte_bpf_prm prm = {
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct dummy_net),
-		},
+	static const struct rte_bpf_arg prog_arg = {
+		.type = RTE_BPF_ARG_PTR,
+		.size = sizeof(struct dummy_net),
 	};
+	struct rte_bpf *bpf;
 	int ret;
 
-	/* Try to load BPF TX program from temp file */
-	ret = rte_bpf_eth_tx_elf_load(port, 0, &prm, tmpfile, section, flags);
+	/* Try to load BPF program from image */
+	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, section,
+		NULL, 0, &prog_arg);
+	TEST_ASSERT_NOT_NULL(bpf, "failed to load BPF filter from image, error=%d:(%s)\n",
+		       rte_errno, rte_strerror(rte_errno));
+
+	/* Try to install loaded BPF program */
+	ret = rte_bpf_eth_tx_install(port, 0, bpf, flags);
 	if (ret != 0) {
-		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
-		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
+		printf("%s@%d: failed to install BPF filter, error=%d:(%s)\n",
+		       __func__, __LINE__, rte_errno, rte_strerror(rte_errno));
+		rte_bpf_destroy(bpf);
 		return ret;
 	}
 
@@ -4217,10 +4259,9 @@ static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 
 /* Test loading a transmit filter which only allows IPv4 packets */
 static int
-test_bpf_elf_tx_load(void)
+test_bpf_elf_tx_load(load_elf_image_t load_elf_image)
 {
 	static const char null_dev[] = "net_null_bpf0";
-	char *tmpfile = NULL;
 	struct rte_mempool *mb_pool = NULL;
 	uint16_t port = UINT16_MAX;
 	int ret;
@@ -4237,27 +4278,17 @@ test_bpf_elf_tx_load(void)
 	if (ret != 0)
 		goto fail;
 
-	/* Create temp file from embedded BPF object */
-	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "tx");
-	if (tmpfile == NULL)
-		goto fail;
-
 	/* Do test with VM */
-	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", 0);
+	ret = bpf_tx_test(port, mb_pool, load_elf_image, "filter", 0);
 	if (ret != 0)
 		goto fail;
 
 	/* Repeat with JIT */
-	ret = bpf_tx_test(port, tmpfile, mb_pool, "filter", RTE_BPF_ETH_F_JIT);
+	ret = bpf_tx_test(port, mb_pool, load_elf_image, "filter", RTE_BPF_ETH_F_JIT);
 	if (ret == 0)
 		printf("%s: TX ELF load test passed\n", __func__);
 
 fail:
-	if (tmpfile) {
-		unlink(tmpfile);
-		free(tmpfile);
-	}
-
 	if (port != UINT16_MAX)
 		rte_vdev_uninit(null_dev);
 
@@ -4272,23 +4303,28 @@ test_bpf_elf_tx_load(void)
 }
 
 /* Test loading a receive filter */
-static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *pool,
-		       const char *section, uint32_t flags, uint16_t expected)
+static int bpf_rx_test(uint16_t port, struct rte_mempool *pool, load_elf_image_t load_elf_image,
+	const char *section, uint32_t flags, uint16_t expected)
 {
-	struct rte_mbuf *pkts[BPF_TEST_BURST];
-	const struct rte_bpf_prm prm = {
-		.prog_arg = {
-			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct dummy_net),
-		},
+	static const struct rte_bpf_arg prog_arg = {
+		.type = RTE_BPF_ARG_PTR,
+		.size = sizeof(struct dummy_net),
 	};
+	struct rte_mbuf *pkts[BPF_TEST_BURST];
+	struct rte_bpf *bpf;
 	int ret;
 
-	/* Load BPF program to drop all packets */
-	ret = rte_bpf_eth_rx_elf_load(port, 0, &prm, tmpfile, section, flags);
+	/* Try to load BPF program from image */
+	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, section,
+		NULL, 0, &prog_arg);
+	TEST_ASSERT_NOT_NULL(bpf, "failed to load BPF filter from image, error=%d:(%s)\n",
+		       rte_errno, rte_strerror(rte_errno));
+
+	/* Try to install loaded BPF program */
+	ret = rte_bpf_eth_rx_install(port, 0, bpf, flags);
 	if (ret != 0) {
-		printf("%s@%d: failed to load BPF filter from file=%s error=%d:(%s)\n",
-		       __func__, __LINE__, tmpfile, rte_errno, rte_strerror(rte_errno));
+		printf("%s@%d: failed to install BPF filter, error=%d:(%s)\n",
+		       __func__, __LINE__, rte_errno, rte_strerror(rte_errno));
 		return ret;
 	}
 
@@ -4311,11 +4347,10 @@ static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 
 /* Test loading a receive filters, first with drop all and then with allow all packets */
 static int
-test_bpf_elf_rx_load(void)
+test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
 {
 	static const char null_dev[] = "net_null_bpf0";
 	struct rte_mempool *pool = NULL;
-	char *tmpfile = NULL;
 	uint16_t port = UINT16_MAX;
 	int ret;
 
@@ -4331,28 +4366,23 @@ test_bpf_elf_rx_load(void)
 	if (ret != 0)
 		goto fail;
 
-	/* Create temp file from embedded BPF object */
-	tmpfile = create_temp_bpf_file(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "rx");
-	if (tmpfile == NULL)
-		goto fail;
-
 	/* Do test with VM */
-	ret = bpf_rx_test(port, tmpfile, pool, "drop", 0, 0);
+	ret = bpf_rx_test(port, pool, load_elf_image, "drop", 0, 0);
 	if (ret != 0)
 		goto fail;
 
 	/* Repeat with JIT */
-	ret = bpf_rx_test(port, tmpfile, pool, "drop", RTE_BPF_ETH_F_JIT, 0);
+	ret = bpf_rx_test(port, pool, load_elf_image, "drop", RTE_BPF_ETH_F_JIT, 0);
 	if (ret != 0)
 		goto fail;
 
 	/* Repeat with allow all */
-	ret = bpf_rx_test(port, tmpfile, pool, "allow", 0, BPF_TEST_BURST);
+	ret = bpf_rx_test(port, pool, load_elf_image, "allow", 0, BPF_TEST_BURST);
 	if (ret != 0)
 		goto fail;
 
 	/* Repeat with JIT */
-	ret = bpf_rx_test(port, tmpfile, pool, "allow", RTE_BPF_ETH_F_JIT, BPF_TEST_BURST);
+	ret = bpf_rx_test(port, pool, load_elf_image, "allow", RTE_BPF_ETH_F_JIT, BPF_TEST_BURST);
 	if (ret != 0)
 		goto fail;
 
@@ -4364,11 +4394,6 @@ test_bpf_elf_rx_load(void)
 			  "Mempool available %u != %u leaks?", avail, BPF_TEST_POOLSIZE);
 
 fail:
-	if (tmpfile) {
-		unlink(tmpfile);
-		free(tmpfile);
-	}
-
 	if (port != UINT16_MAX)
 		rte_vdev_uninit(null_dev);
 
@@ -4381,13 +4406,21 @@ test_bpf_elf_rx_load(void)
 static int
 test_bpf_elf(void)
 {
-	int ret;
+	static const load_elf_image_t elf_image_loaders[] = {
+		load_elf_image_temp_file,
+		load_elf_image_direct,
+	};
 
-	ret = test_bpf_elf_load();
-	if (ret == TEST_SUCCESS)
-		ret = test_bpf_elf_tx_load();
-	if (ret == TEST_SUCCESS)
-		ret = test_bpf_elf_rx_load();
+	int ret = TEST_SUCCESS;
+
+	for (int li = 0; li != RTE_DIM(elf_image_loaders); ++li) {
+		if (ret == TEST_SUCCESS)
+			ret = test_bpf_elf_load(elf_image_loaders[li]);
+		if (ret == TEST_SUCCESS)
+			ret = test_bpf_elf_tx_load(elf_image_loaders[li]);
+		if (ret == TEST_SUCCESS)
+			ret = test_bpf_elf_rx_load(elf_image_loaders[li]);
+	}
 
 	return ret;
 }
-- 
2.43.0

