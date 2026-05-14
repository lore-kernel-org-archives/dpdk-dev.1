Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B02CD4F25
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 09:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3AA740669;
	Thu, 14 May 2026 11:38:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 85C9D4025E
 for <dev@dpdk.org>; Thu, 14 May 2026 11:38:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gGQGx2CWHzJ4680
 for <dev@dpdk.org>; Thu, 14 May 2026 17:37:45 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 62CAD40584
 for <dev@dpdk.org>; Thu, 14 May 2026 17:38:15 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 May 2026 11:38:15 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 07/10] test/bpf: test loading cBPF directly
Date: Thu, 14 May 2026 10:37:09 +0100
Message-ID: <20260514093713.90118-8-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514093713.90118-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
 <20260514093713.90118-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100002.china.huawei.com (7.182.19.63) To
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

Run cBPF tests twice: via rte_bpf_convert, and using
RTE_BPF_FLAG_ORIGIN_CBPF origin of new rte_bpf_load_ex API.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 132 +++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 52 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index dd24722450..c8a4ee7550 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4429,13 +4429,59 @@ test_bpf_dump(struct bpf_program *cbf, const struct rte_bpf_prm *prm)
 	}
 }
 
+/* Function loading BPF program from cBPF instructions array. */
+typedef struct rte_bpf *
+(*load_cbpf_program_t)(struct bpf_program *cbpf_program, const char *str);
+
+/* Load BPF program by converting cBPF array to rte_bpf_prm and then opening it. */
+static struct rte_bpf *
+load_cbpf_program_convert(struct bpf_program *cbpf_program, const char *str)
+{
+	struct rte_bpf_prm *prm = NULL;
+	struct rte_bpf *bpf;
+
+	prm = rte_bpf_convert(cbpf_program);
+	if (prm == NULL) {
+		printf("%s@%d: bpf_convert(\"%s\") failed\n",
+			__func__, __LINE__, str);
+		return NULL;
+	}
+
+	printf("bpf convert(\"%s\") produced:\n", str);
+	rte_bpf_dump(stdout, prm->ins, prm->nb_ins);
+
+	printf("%s \"%s\"\n", __func__, str);
+	test_bpf_dump(cbpf_program, prm);
+
+	bpf = rte_bpf_load(prm);
+	rte_free(prm);
+
+	return bpf;
+}
+
+/* Load BPF program by calling rte_bpf_load_ex and specifying cBPF array as the origin. */
+static struct rte_bpf *
+load_cbpf_program_direct(struct bpf_program *cbpf_program, const char *str __rte_unused)
+{
+	return rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_CBPF,
+		.cbpf.ins = cbpf_program->bf_insns,
+		.cbpf.nb_ins = cbpf_program->bf_len,
+		.prog_arg[0] = {
+			.type = RTE_BPF_ARG_PTR_MBUF,
+			.size = sizeof(struct rte_mbuf),
+		},
+		.nb_prog_arg = 1,
+	});
+}
+
 static int
-test_bpf_match(pcap_t *pcap, const char *str,
-	       struct rte_mbuf *mb)
+test_bpf_match(pcap_t *pcap, const char *str, struct rte_mbuf *mb,
+	load_cbpf_program_t load_cbpf_program)
 {
 	struct bpf_program fcode;
-	struct rte_bpf_prm *prm = NULL;
-	struct rte_bpf *bpf = NULL;
+	struct rte_bpf *bpf;
 	int ret = -1;
 	uint64_t rc;
 
@@ -4445,17 +4491,10 @@ test_bpf_match(pcap_t *pcap, const char *str,
 		return -1;
 	}
 
-	prm = rte_bpf_convert(&fcode);
-	if (prm == NULL) {
-		printf("%s@%d: bpf_convert('%s') failed,, error=%d(%s);\n",
-		       __func__, __LINE__, str, rte_errno, strerror(rte_errno));
-		goto error;
-	}
-
-	bpf = rte_bpf_load(prm);
+	bpf = load_cbpf_program(&fcode, str);
 	if (bpf == NULL) {
-		printf("%s@%d: failed to load bpf code, error=%d(%s);\n",
-			__func__, __LINE__, rte_errno, strerror(rte_errno));
+		printf("%s@%d: failed to load cbpf program for \"%s\", error=%d(%s);\n",
+			__func__, __LINE__, str, rte_errno, strerror(rte_errno));
 		goto error;
 	}
 
@@ -4465,7 +4504,6 @@ test_bpf_match(pcap_t *pcap, const char *str,
 error:
 	if (bpf)
 		rte_bpf_destroy(bpf);
-	rte_free(prm);
 	pcap_freecode(&fcode);
 	return ret;
 }
@@ -4474,6 +4512,11 @@ test_bpf_match(pcap_t *pcap, const char *str,
 static int
 test_bpf_filter_sanity(pcap_t *pcap)
 {
+	static const load_cbpf_program_t cbpf_program_loaders[] = {
+		load_cbpf_program_convert,
+		load_cbpf_program_direct,
+	};
+
 	const uint32_t plen = 100;
 	struct rte_mbuf mb, *m;
 	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
@@ -4500,15 +4543,17 @@ test_bpf_filter_sanity(pcap_t *pcap)
 		.dst_addr = rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
 	};
 
-	if (test_bpf_match(pcap, "ip", m) != 0) {
-		printf("%s@%d: filter \"ip\" doesn't match test data\n",
-		       __func__, __LINE__);
-		return -1;
-	}
-	if (test_bpf_match(pcap, "not ip", m) == 0) {
-		printf("%s@%d: filter \"not ip\" does match test data\n",
-		       __func__, __LINE__);
-		return -1;
+	for (int li = 0; li != RTE_DIM(cbpf_program_loaders); ++li) {
+		if (test_bpf_match(pcap, "ip", m, cbpf_program_loaders[li]) != 0) {
+			printf("%s@%d: filter \"ip\" doesn't match test data\n",
+			       __func__, __LINE__);
+			return -1;
+		}
+		if (test_bpf_match(pcap, "not ip", m, cbpf_program_loaders[li]) == 0) {
+			printf("%s@%d: filter \"not ip\" does match test data\n",
+			       __func__, __LINE__);
+			return -1;
+		}
 	}
 
 	return 0;
@@ -4556,44 +4601,25 @@ static const char * const sample_filters[] = {
 };
 
 static int
-test_bpf_filter(pcap_t *pcap, const char *s)
+test_bpf_filter(pcap_t *pcap, const char *s, load_cbpf_program_t load_cbpf_program)
 {
 	struct bpf_program fcode;
-	struct rte_bpf_prm *prm = NULL;
-	struct rte_bpf *bpf = NULL;
+	struct rte_bpf *bpf;
 
 	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
-		printf("%s@%d: pcap_compile('%s') failed: %s;\n",
+		printf("%s@%d: pcap_compile(\"%s\") failed: %s;\n",
 		       __func__, __LINE__, s, pcap_geterr(pcap));
 		return -1;
 	}
 
-	prm = rte_bpf_convert(&fcode);
-	if (prm == NULL) {
-		printf("%s@%d: bpf_convert('%s') failed,, error=%d(%s);\n",
-		       __func__, __LINE__, s, rte_errno, strerror(rte_errno));
-		goto error;
-	}
-
-	printf("bpf convert for \"%s\" produced:\n", s);
-	rte_bpf_dump(stdout, prm->ins, prm->nb_ins);
-
-	bpf = rte_bpf_load(prm);
+	bpf = load_cbpf_program(&fcode, s);
 	if (bpf == NULL) {
-		printf("%s@%d: failed to load bpf code, error=%d(%s);\n",
-			__func__, __LINE__, rte_errno, strerror(rte_errno));
-		goto error;
+		printf("%s@%d: failed to load cbpf program for \"%s\" , error=%d(%s);\n",
+			__func__, __LINE__, s, rte_errno, strerror(rte_errno));
 	}
 
-error:
-	if (bpf)
-		rte_bpf_destroy(bpf);
-	else {
-		printf("%s \"%s\"\n", __func__, s);
-		test_bpf_dump(&fcode, prm);
-	}
+	rte_bpf_destroy(bpf);
 
-	rte_free(prm);
 	pcap_freecode(&fcode);
 	return (bpf == NULL) ? -1 : 0;
 }
@@ -4612,8 +4638,10 @@ test_bpf_convert(void)
 	}
 
 	rc = test_bpf_filter_sanity(pcap);
-	for (i = 0; i < RTE_DIM(sample_filters); i++)
-		rc |= test_bpf_filter(pcap, sample_filters[i]);
+	for (i = 0; i < RTE_DIM(sample_filters); i++) {
+		rc |= test_bpf_filter(pcap, sample_filters[i], load_cbpf_program_convert);
+		rc |= test_bpf_filter(pcap, sample_filters[i], load_cbpf_program_direct);
+	}
 
 	pcap_close(pcap);
 	return rc;
-- 
2.43.0

