Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B4C87FDA
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 052FE402E1;
	Wed,  6 Aug 2025 23:42:25 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id F0D67402E1
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:23 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3b7961cf660so240218f8f.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516543;
 x=1755121343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjbT46ktC2sBhSt6rXB5h+uP7Z5W1b7KjqGBtHox2T8=;
 b=G2c0C2wPPvEmdAYyLeFA4xyOOHLF4bZsMy7IhL3gXGCLKHanFcO/RuLxDDf0RgJ3Xz
 YnkuyysrdvZm7fWFQaoX5nDPPcmYojtcNHWffdJ4kspg1wABMFohrymEEVBaQSBbddSJ
 HvcP0GtLxpU0QTFUUAJV3183u5sP3DcxhcNPKInVBD8s40/rlSVNUm5ahS8dclVyYLGV
 VhdxCnzU0Y36PN7i6gRqopmCxZdg2UdjXCxIdTuF01J5foD3abBhNMqWsPScp1k4OSNc
 vRSLx0TNQ/sL9+QRjEgDwNVYBXvQbHvuGQ61gZGVcNqxm7VH420+uHtb/KwQGUnMhJW4
 Mhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516543; x=1755121343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjbT46ktC2sBhSt6rXB5h+uP7Z5W1b7KjqGBtHox2T8=;
 b=ceYYGRXhUdK9Sk0IcJt0bkviywjtJz8kYY70mN1vTRTRi7WSV3FSot+LA0pE3cbMLJ
 DhsDOIXNT9clrtYVojBjHyDE4eDAhqHrtE5zlEr03Sp7FezPPazVqZ0SFsmbjFnNNrJZ
 ziHZeL6Mld2i/qb2ANhIjC5vGnNWgsaR07HCQXf59KYQ0tempzdHD1G7tMnnqlkrsY1r
 zebEravefT/ewsCOscivL1QTZKQMm/2OwOobpXpdyQTn1uunBKRB8uECPVtSwLpymeFw
 AUbGTgl3cUtJriIi3uh5HtDVf30FU1xNzcgw4xvc3IZs+5S7DZBVv5MfjwWR01p1Tlku
 R72w==
X-Gm-Message-State: AOJu0Yyu7A5ngKD64vk9UqRZQX5pYEJhLRYblhdcIYRngSOXMNFcD8IY
 ODO6lDQZpVMWMh6iUbwdhFbvatvY83O3H49ebUC9nOa6Zk/IQmyBTh1jtJqGRZVKYdz8wQA+BZU
 0sdGm
X-Gm-Gg: ASbGncsdbKF+d74HGO/2hpJ+z+idNyA4juQNcvW7K/02r9FARIFniXGHAGiouYAcSFT
 HsZKco7LRcdYxUHtHF0kJvLLtrX7Z8wdVOAHycTNTimWskZqY8Js1roLd/crmbhNXQIsHeZ8+XY
 PIjZpocbt+jaJrpz96b9wOBLmeXhoKwJipEN10xJmHBtAXUC/S10vuIHvmM+z28UxpyiDMPYyqO
 /x0eOgw+5LxavH2mX4rkQHroLHbkkbqbFioxdOP5BX7yI8s1kk9h7z3msrufF5NlUiZq8kRXoZ3
 qF+4eDpfstnKDw9JHusj1h6hZcF0PFpU+X96O9xW6/UrShXM2qIkMQIoDQAem08JWo3YRZMPM1v
 kMHHctzYG6oDmSE2Y6AvYfBcNmcMAqvp1seFjKeB6bENCdTWeNcVrrESaWQL+v2j0roO5UZu/
X-Google-Smtp-Source: AGHT+IGDfx+0Wce6w2vWK5lv9CseTO+H67Us92ERjANFaaYjiyQrMW7vrMPTUZksCTO5vVJtQBQS+Q==
X-Received: by 2002:a05:6000:2c01:b0:3b7:8338:d219 with SMTP id
 ffacd0b85a97d-3b8f48de412mr3744703f8f.3.1754516543480; 
 Wed, 06 Aug 2025 14:42:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v9 04/13] bpf: add ability to load bpf into a buffer
Date: Wed,  6 Aug 2025 14:40:33 -0700
Message-ID: <20250806214200.193029-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

