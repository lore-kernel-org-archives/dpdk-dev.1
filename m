Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA4FC87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4F6406A2;
	Fri,  8 Aug 2025 18:58:59 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8262840685
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:57 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b78d13bf10so2364087f8f.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672337;
 x=1755277137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjbT46ktC2sBhSt6rXB5h+uP7Z5W1b7KjqGBtHox2T8=;
 b=o1Xp/CM/M2fRj2m3+mufig6p5SehxYcLPb5TP9ezwvqaDJf9rLKHLA6wujAks5IYmx
 +hSJEDbDRSopEnsxuCHxh/IZrrKCi/5ls7GMM3uXM3FWbqZGkoEha/PMwl3BVypfYhW0
 tXnBgg/AxZ5xzisDipyiWqREjBN5o7N6SgkB/4DhksHk4lqWLbWUdHoGfjngkV9uH77E
 S9UcXBc87gT2k1H/Vq9DUf6hKdNqyrAOXUzF/Hc2h7KYM2PHFpCiy73lKl7bD3eAWkSH
 xSrGRf3bNeeCw6FFXbgRexLNIyQ7KrDyuJxWo3hhbEkb+6wKnxUKoFud9B4Y4WyKFNPs
 UTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672337; x=1755277137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjbT46ktC2sBhSt6rXB5h+uP7Z5W1b7KjqGBtHox2T8=;
 b=gJu0FkfIChwT/yq2UJ8vIY+ndzKFwCGdsAlze8+EwOnGIKVjzlDfJVfVdJwfLo0Kyu
 ec0tfLDKFGLioULJq0fy+dn6ka88BEeWiiLT1OLArPEJ2rQgk4nbWuJow5krCfgJotZm
 /q/5E2u7LE/uOpLOIBtrGwTXgEwve3AGMcjLvhV7ZLtnTJgvoRKt4Kvhx/2MZOgQIPDn
 cXgjeEgIT7u9pP5MARXs79gb03PTQZI0OcDn1tEdWes+G7R6pdNXU3iY7jyL4Z1g+wzI
 s6hSfy3fKs3G7Vj1LFp7nQyBRlXO1xk4fNdJYzMKpo2gYEmqqEzjiqhaZSH7O7KE3QNT
 jMGQ==
X-Gm-Message-State: AOJu0YyPKyzi014qbZ7cFq4hZ44SpQ9ilGlamrDox2DDmce8VXex/7Rl
 hCGeecmeCxiqn4zl2dtpdhl9rIWAsWpgbmWEI2BgJI6wYLGOUd29GXXmmwL7mkVHQBBkqmmP9iE
 jKMcG
X-Gm-Gg: ASbGncuJcscQJCkSsQ/bRtcHt1EgTPg2kBZ1c+wD+ailmr8adxSutRDX2AHgQUAwfT4
 3CZ7HcKaw5ZQ0k/D0+FK1YAJpZgychtruvUj/BKR9XiXhBP1eIL2dPld7OeMi9qo9sdjUatWCwC
 L5HeT1q3eDtjKkk3dhZUpLB2XcGHdvFW1mj118pSUARO09zKg5HISAAS9Qh3vxKbqgvqM7Pg5IW
 v7YEcQr1M+mU2jZXEft46u/wBCGjA+l3Uigs0DHzsPmXBGMOTwyp4IaJbJ/MurGqytTbZJMCYSH
 5fpO0hp62fyaM5quQnUUk/FWvW6gtGcaPrQmhsCUEUR5z0bkOfHQn+iAfe+ektHymU3e4gs+0T2
 Us6Kwpdb2qQsh5jRnEz5uecOGmZMTO0q+crrY17F20xbuc8gyFzX+/ZjHbQtbGe+KRRwx/r/k
X-Google-Smtp-Source: AGHT+IGBh8spjEligQZqVPFszBrLeqff/izfLm+Oql6r3OUlSBl4py+UQm0q7fnPqo6SBN5V2FGOqw==
X-Received: by 2002:a05:6000:230f:b0:3b7:899c:e867 with SMTP id
 ffacd0b85a97d-3b900b805dcmr3466924f8f.59.1754672337062; 
 Fri, 08 Aug 2025 09:58:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v11 04/14] bpf: add ability to load bpf into a buffer
Date: Fri,  8 Aug 2025 09:55:42 -0700
Message-ID: <20250808165843.39075-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

When using BPF in cases like port mirroring, need to be
able to put BPF code into a buffer shared between primary
and secondary process. Separate the allocation of the
buffer from the export step.

Minor code refactoring to breakup the steps for how load
happens.

Add test for the new function.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c |  28 +++++++++++
 lib/bpf/bpf_load.c  | 111 ++++++++++++++++++++++++++++++++++++++------
 lib/bpf/rte_bpf.h   |  38 +++++++++++++++
 3 files changed, 163 insertions(+), 14 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 90e10d7d2c..3aefc684eb 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3235,6 +3235,7 @@ run_test(const struct bpf_test *tst)
 	if (ret != 0) {
 		printf("%s@%d: check_result(%s) failed, error: %d(%s);\n",
 			__func__, __LINE__, tst->name, ret, strerror(ret));
+		return -1;
 	}
 
 	/* repeat the same test with jit, when possible */
@@ -3250,10 +3251,37 @@ run_test(const struct bpf_test *tst)
 				"error: %d(%s);\n",
 				__func__, __LINE__, tst->name,
 				rv, strerror(rv));
+			return -1;
 		}
 	}
 
 	rte_bpf_destroy(bpf);
+
+	/* repeat the same test with bpf in hugepages */
+	size_t len = rte_bpf_buf_size(&tst->prm);
+	void *buf = malloc(len);
+	if (buf == NULL) {
+		printf("%s@%d: allocation of %zu failed\n",
+		       __func__, __LINE__, len);
+		return -1;
+	}
+
+	bpf = rte_bpf_buf_load(&tst->prm, buf, len);
+	if (bpf == NULL) {
+		printf("%s@%d: failed to load bpf into buf, error=%d(%s);\n",
+			__func__, __LINE__, rte_errno, strerror(rte_errno));
+		return -1;
+	}
+
+	tst->prepare(tbuf);
+	rc = rte_bpf_exec(bpf, tbuf);
+	ret = tst->check_result(rc, tbuf);
+	if (ret != 0) {
+		printf("%s@%d: check_result(%s) failed, error: %d(%s);\n",
+			__func__, __LINE__, tst->name, ret, strerror(ret));
+	}
+	free(bpf);
+
 	return ret;
 
 }
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 556e613762..7b526346ea 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -14,25 +14,16 @@
 #include "bpf_impl.h"
 
 static struct rte_bpf *
-bpf_load(const struct rte_bpf_prm *prm)
+bpf_copy(const struct rte_bpf_prm *prm, uint8_t *buf)
 {
-	uint8_t *buf;
 	struct rte_bpf *bpf;
-	size_t sz, bsz, insz, xsz;
-
-	xsz =  prm->nb_xsym * sizeof(prm->xsym[0]);
-	insz = prm->nb_ins * sizeof(prm->ins[0]);
-	bsz = sizeof(bpf[0]);
-	sz = insz + xsz + bsz;
-
-	buf = mmap(NULL, sz, PROT_READ | PROT_WRITE,
-		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if (buf == MAP_FAILED)
-		return NULL;
+	size_t xsz =  prm->nb_xsym * sizeof(prm->xsym[0]);
+	size_t insz = prm->nb_ins * sizeof(prm->ins[0]);
+	size_t bsz = sizeof(bpf[0]);
+	size_t sz = insz + xsz + bsz;
 
 	bpf = (void *)buf;
 	bpf->sz = sz;
-
 	memcpy(&bpf->prm, prm, sizeof(bpf->prm));
 
 	if (xsz > 0)
@@ -45,6 +36,30 @@ bpf_load(const struct rte_bpf_prm *prm)
 	return bpf;
 }
 
+static size_t
+bpf_buf_size(const struct rte_bpf_prm *prm)
+{
+	size_t xsz =  prm->nb_xsym * sizeof(prm->xsym[0]);
+	size_t insz = prm->nb_ins * sizeof(prm->ins[0]);
+	size_t bsz = sizeof(struct rte_bpf);
+
+	return insz + xsz + bsz;
+}
+
+static struct rte_bpf *
+bpf_load(const struct rte_bpf_prm *prm)
+{
+	void *buf;
+	size_t len = bpf_buf_size(prm);
+
+	buf = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED)
+		return NULL;
+
+	return bpf_copy(prm, buf);
+}
+
 /*
  * Check that user provided external symbol.
  */
@@ -125,3 +140,71 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 
 	return bpf;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_buf_size, 25.11)
+ssize_t
+rte_bpf_buf_size(const struct rte_bpf_prm *prm)
+{
+	int rc = 0;
+	uint32_t i;
+
+	if (prm == NULL || prm->ins == NULL ||
+	    (prm->nb_xsym != 0 && prm->xsym == NULL)) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	for (i = 0; i != prm->nb_xsym && rc == 0; i++)
+		rc = bpf_check_xsym(prm->xsym + i);
+
+	if (rc != 0) {
+		rte_errno = -rc;
+		RTE_BPF_LOG_LINE(ERR, "%s: %d-th xsym is invalid", __func__, i);
+		return -1;
+	}
+
+	return bpf_buf_size(prm);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_buf_load, 25.11)
+struct rte_bpf *
+rte_bpf_buf_load(const struct rte_bpf_prm *prm, void *buf, size_t len)
+{
+	struct rte_bpf *bpf;
+	int32_t rc;
+	uint32_t i;
+
+	if (prm == NULL || prm->ins == NULL ||
+	    (prm->nb_xsym != 0 && prm->xsym == NULL)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	rc = 0;
+	for (i = 0; i != prm->nb_xsym && rc == 0; i++)
+		rc = bpf_check_xsym(prm->xsym + i);
+
+	if (rc != 0) {
+		rte_errno = -rc;
+		RTE_BPF_LOG_LINE(ERR, "%s: %d-th xsym is invalid", __func__, i);
+		return NULL;
+	}
+
+	size_t sz = bpf_buf_size(prm);
+	if (len < sz) {
+		rte_errno = -EINVAL;
+		RTE_BPF_LOG_LINE(ERR, "%s: len %zu < required %zu",
+				 __func__, len, sz);
+		return NULL;
+	}
+
+	bpf = bpf_copy(prm, buf);
+	rc = __rte_bpf_validate(bpf);
+	if (rc != 0) {
+		rte_errno = -rc;
+		return NULL;
+	}
+
+	/* This bpf code is in non protected memory it can not use JIT  */
+	return bpf;
+}
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 80ebb0210f..0972422a30 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -153,6 +153,44 @@ rte_bpf_load(const struct rte_bpf_prm *prm);
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 		const char *sname);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Determine size of required memory area.
+ *
+ * @param prm
+ *  Parameters used to create and initialise the BPF execution context.
+ * @return
+ *   Number of bytes required or negative on error,
+ *   with error code set in rte_errno.
+ */
+__rte_experimental
+ssize_t
+rte_bpf_buf_size(const struct rte_bpf_prm *prm);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Create a new eBPF execution context into provided memory area
+ * and load given BPF code into it.
+ *
+ * @param prm
+ *  Parameters used to create and initialise the BPF execution context.
+ * @param buf
+ *  Memory area to place BPF code into.
+ * @param len
+ *  Size of the buf area.
+ * @return
+ *   BPF handle that is used in future BPF operations,
+ *   or NULL on error, with error code set in rte_errno.
+ */
+__rte_experimental
+struct rte_bpf *
+rte_bpf_buf_load(const struct rte_bpf_prm *prm, void *buf, size_t len);
+
 /**
  * Execute given BPF bytecode.
  *
-- 
2.47.2

