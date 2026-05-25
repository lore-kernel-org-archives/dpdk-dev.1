Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E2CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 17:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92F4F402D0;
	Mon, 25 May 2026 19:13:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1B53E4064F
 for <dev@dpdk.org>; Mon, 25 May 2026 19:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779729231; x=1811265231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J1TgXxCGdyKyKGbr4jy9YA8ZQLQnE7r/P+iuWm5KupU=;
 b=cjvRp9lyGTbiTO8USriSsFmt2MMVuwSG74jw45RhL1egFAdTNaGgLUPn
 0XoYerXXq0stV+fdUx9IBZJZyQUpKLTQZ1382Kn2pXUdsAD2Z8UXeVbAi
 fd0BRvvg38fjMxta0TrLekmCNjm+twLU8JPIV3IgACdsYu5wMYq4RDZxO
 SHOv7vB8DYxOXJjTftgEU3GBXtjTs/nmXNf2PmcWDpcxMfKt2j9vVlVfD
 4Iel33wT+PdK1rKwX60rA+xFzgPBe3oPjTYCi7iHngJUXlnryfx6heQoc
 DR+s0o/Mz7fmXpPn3Jgp8xkqfv3LSicXiWeObjdclPx0ftqr4hU4bl3n5 A==;
X-CSE-ConnectionGUID: cbXLm4+iRLiy+jkjZJpSSQ==
X-CSE-MsgGUID: EtVy8ZQYQemktZBAAQGp1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80607458"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="80607458"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 10:13:50 -0700
X-CSE-ConnectionGUID: ypMPOWZEQsqFyTHLbhanqw==
X-CSE-MsgGUID: HcT1wB5RQsS1EwFCi/OqPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="241506567"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 25 May 2026 10:13:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Lewis Donzis <lew@perftech.com>
Subject: [PATCH 2/2] eal/freebsd: implement virtual to IOVA translation fn
Date: Mon, 25 May 2026 18:13:40 +0100
Message-ID: <20260525171340.1701509-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525171340.1701509-1-bruce.richardson@intel.com>
References: <20260525171340.1701509-1-bruce.richardson@intel.com>
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

The function rte_mem_virt2iova() function was always returning BAD_IOVA
on FreeBSD as it was not implemented. Unfortunately, this function was
used by some drivers - expecting it to work as they used addresses from
rte_malloc calls. Implement this call on FreeBSD to fix things and
enable more drivers on BSD.  To verify the function works as expected
add a basic unit test to the memory_autotest for it.

At the same time, we can trivially use this to implement the
rte_mem_virt2phy function for the case of using contigmem where IOVAs
are physical addresses.

Reported-by: Lewis Donzis <lew@perftech.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

NOTE: This is one of those patches that could be either a bugfix or a
feature. For now, I'm treating it as adding new feature support, though
in doing so it enables previously broken drivers.
---
 app/test/test_memory.c       | 67 ++++++++++++++++++++++++++++++++++++
 lib/eal/freebsd/eal_memory.c | 22 +++++++++---
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/app/test/test_memory.c b/app/test/test_memory.c
index 628714c0b8..260d5ed8f8 100644
--- a/app/test/test_memory.c
+++ b/app/test/test_memory.c
@@ -8,6 +8,7 @@
 #include <rte_eal.h>
 #include <rte_errno.h>
 #include <rte_memory.h>
+#include <rte_malloc.h>
 #include <rte_common.h>
 #include <rte_memzone.h>
 
@@ -75,6 +76,68 @@ check_seg_fds(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 	return 0;
 }
 
+static int
+check_malloc_virt2iova(void)
+{
+	const size_t alloc_sz = 128;
+	const size_t off = 32;
+	struct rte_memseg *ms;
+	char *p;
+	rte_iova_t iova, iova_off;
+
+	p = rte_malloc("memory_autotest", alloc_sz, RTE_CACHE_LINE_SIZE);
+	if (p == NULL) {
+		printf("rte_malloc failed\n");
+		return -1;
+	}
+
+	iova = rte_mem_virt2iova(p);
+	if (iova == RTE_BAD_IOVA) {
+		printf("rte_mem_virt2iova failed for rte_malloc pointer\n");
+		rte_free(p);
+		return -1;
+	}
+
+	ms = rte_mem_virt2memseg(p, NULL);
+	if (ms == NULL) {
+		printf("failed to resolve memseg for rte_malloc pointer\n");
+		rte_free(p);
+		return -1;
+	}
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
+		if (ms->iova == RTE_BAD_IOVA || iova < ms->iova ||
+					iova >= ms->iova + ms->len) {
+			printf("translated iova is outside memseg range\n");
+			rte_free(p);
+			return -1;
+		}
+
+		phys_addr_t physaddr = rte_mem_virt2phy(p);
+		if (physaddr == RTE_BAD_PHYS_ADDR || physaddr != iova) {
+			printf("rte_mem_virt2phy failed for rte_malloc pointer\n");
+			rte_free(p);
+			return -1;
+		}
+	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
+		if (iova != (uintptr_t)p) {
+			printf("rte_mem_virt2iova did not return VA in VA mode\n");
+			rte_free(p);
+			return -1;
+		}
+	}
+
+	iova_off = rte_mem_virt2iova(p + off);
+	if (iova_off == RTE_BAD_IOVA || iova_off != iova + off) {
+		printf("translated iova for interior pointer is invalid\n");
+		rte_free(p);
+		return -1;
+	}
+
+	rte_free(p);
+	return 0;
+}
+
 static int
 test_memory(void)
 {
@@ -107,6 +170,10 @@ test_memory(void)
 		return -1;
 	}
 
+	ret = check_malloc_virt2iova();
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index e56d149a22..6952b38630 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -40,16 +40,28 @@ RTE_EXPORT_SYMBOL(rte_mem_virt2phy)
 phys_addr_t
 rte_mem_virt2phy(const void *virtaddr)
 {
-	/* XXX not implemented. This function is only used by
-	 * rte_mempool_virt2iova() when hugepages are disabled. */
-	(void)virtaddr;
-	return RTE_BAD_IOVA;
+	/* not implemented for FreeBSD when not using contigmem memory */
+	if (virtaddr == NULL || rte_eal_iova_mode() != RTE_IOVA_PA)
+		return RTE_BAD_IOVA;
+	/* when IOVA == PA, return the IOVA */
+	return rte_mem_virt2iova(virtaddr);
 }
+
 RTE_EXPORT_SYMBOL(rte_mem_virt2iova)
 rte_iova_t
 rte_mem_virt2iova(const void *virtaddr)
 {
-	return rte_mem_virt2phy(virtaddr);
+	if (virtaddr == NULL)
+		return RTE_BAD_IOVA;
+
+	if (rte_eal_iova_mode() == RTE_IOVA_VA)
+		return (uintptr_t)virtaddr;
+
+	const struct rte_memseg *ms = rte_mem_virt2memseg(virtaddr, NULL);
+	if (ms != NULL && ms->iova != RTE_BAD_IOVA)
+		return ms->iova + RTE_PTR_DIFF(virtaddr, ms->addr);
+
+	return RTE_BAD_IOVA;
 }
 
 int
-- 
2.53.0

