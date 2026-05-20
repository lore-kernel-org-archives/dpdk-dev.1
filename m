Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE17CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E77406B7;
	Wed, 20 May 2026 14:50:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id AE54640144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:49:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gLBF62jJ3zJ46b5
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9189640569
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:54 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:49:54 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v4 06/11] bpf: support loading ELF files from memory
Date: Wed, 20 May 2026 13:49:15 +0100
Message-ID: <20260520124922.42445-7-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520124922.42445-1-marat.khalili@huawei.com>
References: <20260518084912.57006-1-marat.khalili@huawei.com>
 <20260520124922.42445-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

Introduce new ELF origin RTE_BPF_ORIGIN_ELF_MEMORY allowing one to
specify data area containing ELF image.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_impl.h     |  5 +++++
 lib/bpf/bpf_load.c     |  4 ++++
 lib/bpf/bpf_load_elf.c | 40 +++++++++++++++++++++++++++++++++++++++-
 lib/bpf/rte_bpf.h      |  6 ++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index 92d03583d977..14ad772d4beb 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -27,6 +27,7 @@ struct __rte_bpf_load {
 	/* Loading ELF and applying relocations. */
 	int elf_fd;  /* ELF fd, must be negative (not zero) by default. */
 	void *elf;  /* Using void to avoid dependency on libelf. */
+	const char *elf_section;
 
 	/* Value we are going to return, if any. */
 	struct rte_bpf *bpf;
@@ -53,6 +54,10 @@ __rte_bpf_load_elf_cleanup(struct __rte_bpf_load *load);
 int
 __rte_bpf_load_elf_file(struct __rte_bpf_load *load);
 
+/* Open the ELF memory image. */
+int
+__rte_bpf_load_elf_memory(struct __rte_bpf_load *load);
+
 /* Get code from ELF and apply relocations to it. */
 int
 __rte_bpf_load_elf_code(struct __rte_bpf_load *load);
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index e3265e97ff7f..e406211e0e47 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -247,6 +247,10 @@ load_try(struct __rte_bpf_load *load, const struct rte_bpf_prm_ex *app_prm)
 		rc = rc < 0 ? rc : __rte_bpf_load_elf_file(load);
 		rc = rc < 0 ? rc : __rte_bpf_load_elf_code(load);
 		break;
+	case RTE_BPF_ORIGIN_ELF_MEMORY:
+		rc = rc < 0 ? rc : __rte_bpf_load_elf_memory(load);
+		rc = rc < 0 ? rc : __rte_bpf_load_elf_code(load);
+		break;
 	default:
 		rc = rc < 0 ? rc : -EINVAL;
 	}
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 4ae7492351ae..80443cb63a61 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -310,6 +310,36 @@ __rte_bpf_load_elf_file(struct __rte_bpf_load *load)
 		return -EINVAL;
 	}
 
+	load->elf_section = prm->elf_file.section;
+
+	return 0;
+}
+
+int
+__rte_bpf_load_elf_memory(struct __rte_bpf_load *load)
+{
+	const struct rte_bpf_prm_ex *const prm = &load->prm;
+
+	RTE_ASSERT(prm->origin == RTE_BPF_ORIGIN_ELF_MEMORY);
+
+	if (prm->elf_memory.data == NULL || prm->elf_memory.section == NULL)
+		return -EINVAL;
+
+	if (elf_version(EV_CURRENT) == EV_NONE)
+		return -ENOTSUP;
+
+	load->elf = elf_memory(
+		/* Cast away const, we are not going to modify the ELF image. */
+		(char *)(uintptr_t)prm->elf_memory.data, prm->elf_memory.size);
+	if (load->elf == NULL) {
+		const int rc = elf_errno();
+		RTE_BPF_LOG_FUNC_LINE(ERR, "error %d opening ELF image: %s",
+			rc, elf_errmsg(rc));
+		return -EINVAL;
+	}
+
+	load->elf_section = prm->elf_memory.section;
+
 	return 0;
 }
 
@@ -321,7 +351,7 @@ __rte_bpf_load_elf_code(struct __rte_bpf_load *load)
 	size_t sidx;
 	int rc;
 
-	rc = find_elf_code(load->elf, prm->elf_file.section, &sd, &sidx);
+	rc = find_elf_code(load->elf, load->elf_section, &sd, &sidx);
 	if (rc < 0)
 		return rc;
 
@@ -353,6 +383,14 @@ __rte_bpf_load_elf_file(struct __rte_bpf_load *load)
 	return -ENOTSUP;
 }
 
+int
+__rte_bpf_load_elf_memory(struct __rte_bpf_load *load)
+{
+	RTE_SET_USED(load);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libelf installed");
+	return -ENOTSUP;
+}
+
 int
 __rte_bpf_load_elf_code(struct __rte_bpf_load *load)
 {
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index da2bdea7e0a8..413ccf049755 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -97,6 +97,7 @@ enum rte_bpf_origin {
 	RTE_BPF_ORIGIN_RAW,		/**< code loaded from raw array */
 	RTE_BPF_ORIGIN_CBPF,		/**< code converted from cbpf */
 	RTE_BPF_ORIGIN_ELF_FILE,	/**< code loaded from elf_file */
+	RTE_BPF_ORIGIN_ELF_MEMORY,	/**< code loaded from elf_memory */
 };
 
 struct bpf_insn;
@@ -127,6 +128,11 @@ struct rte_bpf_prm_ex {
 			const char *path;  /**< path to the ELF file */
 			const char *section;  /**< ELF section with the code */
 		} elf_file;
+		struct {
+			const void *data;  /**< pointer to the ELF image */
+			size_t size;  /**< size of the ELF image */
+			const char *section;  /**< ELF section with the code */
+		} elf_memory;
 	};
 
 	const struct rte_bpf_xsym *xsym;
-- 
2.43.0

