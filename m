Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7551DC98315
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA7D40DDE;
	Sun, 18 Jan 2026 21:12:36 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 07CFD40E40
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:35 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so20770885e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767154;
 x=1769371954; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEwFievd6/BnszrhL/SqBdRT8/oJX7XPT7k3Uy5zFxI=;
 b=vRROS9914QdtYFmhksUpUR1yYFOmrgZVpHCWp5RJaDBshtkaZZhomn9b7gwXi7OWQe
 UxdxxrBHZUhGZk2sovaCEASPQVyJoSahpqrullAnSmQCZ/XeSqgBf96zpFmILG0uoB7Y
 pxKXSUwTAsmEmnJ3RWjpqOwO8a1EJzKL8ddH+q/JXUWy18NOUdqHZqx27LSNDh4Ox8pn
 iYg0yQHJPaPo5sztP5+4aZ7+4hifSWiKbG+pL9RCTrJTQcYPNNk/ZyVUgltns16gu94h
 x1qvpkOH3NhNdorh97FABtr85IcOJv+MUTBeksgBKXde7JkW50wdV+w6btLmVFHikLA4
 ZegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767154; x=1769371954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KEwFievd6/BnszrhL/SqBdRT8/oJX7XPT7k3Uy5zFxI=;
 b=ZpL9Krc9lzSh3bnfOK0Lmefq2btCht6+ieXEMeVSAJSXaIeRybk/rk8Lu8bvpuJOvA
 aj+zgwZESm7J7JtiyamvI+0pb4jcHbRjdN9afgFpf/dLy7m7E84HtGRkrhJH/xjHgkaR
 j6qYw+IMH0uM8y/zDGTJeS7pANI0kibmAL/K5C3X2h+nlw7W1vVCNIlaTQv+KrOJ+MUS
 DDbJWgnqGj+/aNoNFd1+0cLIuvR97+SfMcPr6TMaJYFQCbJwQMG8G1jXYlUvW6iC8qVi
 uGJYpFW+Wa4RtJDOIHC73+N6Td1nG3d+X5C8CYgw5N8ilyjEGycrVa1RwcH40uxtJE+j
 ryAw==
X-Gm-Message-State: AOJu0YzaDTwTYiaG5mYmxNRO09+HYrxK0Xed+G1QBS5FKV28Xlxo6qGh
 Fl18rri6smtbgenYLQJOisfID9O2He4FTiw8VB7rNKXgFno+sQYpWZBkBWEae+mBpHoYhkfo7YU
 3HL/X
X-Gm-Gg: AY/fxX6hPWvn4ksF0m9YdgniYzt2BwtqDA7HB6ZSbkLUnSDShqrQFTrCH40d01p2eix
 zbXIBudqHvYGjFQMUh5azbV/8iD9OuH/wG+aI4xHMXEc7wrf3t9RlAGw8ItGI+T8DHPasBr5IrA
 2xfopjc82nzZZfLLiefOYOuVAxSoTlxrVVADtgc4PHimuuPDN+H08oqlXWasnWNWAYVVck2mF4G
 CzJRF6sE0Jg6JYE/bX+q5duIcDj+xgOGrhj7j6yNvIDMKTJX1INnu3w9MvDqj9+zNY6/e/BzAvS
 4uMIzB/fgNJ0NIANI054JES3YSIaINKLk9QluNaCUTIfzjvtkCBiGJ5uTuBxMLRNoZgl4goVqGM
 PPXxovKUPnTch8z8xVp1FmGOjAXUybCqMNrC8vgWVbbBoTOWpuJk8YJJzndnrZ1AwgK4gp5XUGt
 w8WVj9Sch4LgnJQcVUd/it5YaYSt4f558EGaorTXIB6j5oCsnVzA==
X-Received: by 2002:a05:600c:60f:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-47f4289abb5mr100722945e9.1.1768767154606; 
 Sun, 18 Jan 2026 12:12:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 3/6] test: fix race condition in ELF load tests
Date: Sun, 18 Jan 2026 12:09:10 -0800
Message-ID: <20260118201223.323024-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

The BPF ELF tests sporadically fail with EINVAL when loading from
the temporary file. This is a race condition where the BPF loader
reads the file before the data is fully flushed to disk.

Add fsync() before close() in create_temp_bpf_file() to ensure the
BPF object data is visible on the filesystem before attempting to
load it.

Also fix two related issues found during review
- Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
- Initialize port variable in test_bpf_elf_rx_load to avoid undefined
  behavior in cleanup path if null_vdev_setup fails early

Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a7d56f8d86..03705075d8 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3311,6 +3311,8 @@ create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
 
 	/* Write BPF object data */
 	written = write(fd, data, size);
+	if (written == (ssize_t)size)
+		fsync(fd);
 	close(fd);
 
 	if (written != (ssize_t)size) {
@@ -3580,6 +3582,7 @@ test_bpf_elf_tx_load(void)
 	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
 					  SOCKET_ID_ANY);
+	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, mb_pool);
 	if (ret != 0)
@@ -3664,7 +3667,7 @@ test_bpf_elf_rx_load(void)
 	static const char null_dev[] = "net_null_bpf0";
 	struct rte_mempool *pool = NULL;
 	char *tmpfile = NULL;
-	uint16_t port;
+	uint16_t port = UINT16_MAX;
 	int ret;
 
 	printf("%s start\n", __func__);
-- 
2.51.0

