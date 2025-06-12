Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D119C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C2F542789;
	Thu, 12 Jun 2025 16:07:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6E68941104
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:07:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6033D20544;
 Thu, 12 Jun 2025 16:07:00 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 12 Jun 2025 16:06:59 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] eal: handle sysconf(_SC_PAGESIZE) negative return value
Date: Thu, 12 Jun 2025 14:06:57 +0000
Message-ID: <20250612140657.313785-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131348.248800-1-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jun 2025 14:06:59.0401 (UTC)
 FILETIME=[435EF390:01DBDBA3]
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

eal: handle sysconf(_SC_PAGESIZE) negative return value

Coverity reports some defects, where the root cause seems to be negative
return value from sysconf(_SC_PAGESIZE) not being handled.

rte_mem_page_size() was updated to handle negative return value from
sysconf(_SC_PAGESIZE).

All other functions calling sysconf(_SC_PAGESIZE) directly were updated to
call rte_mem_page_size() instead.

At this time, no other calls to sysconf(_SC_PAGESIZE) have been found in
the DPDK libraries.

PS: "_SC_PAGESIZE" has the alias "_SC_PAGE_SIZE". Both are covered here.

Moved the PMU library to the correct location in the meson.build file; it
depends on the EAL, not vice versa.

And an unrelated drive-by minor fix in eal_mem_set_dump():
When madvise() failed, an incorrect reason was logged.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Clarify in title and description that only sysconf(_SC_PAGESIZE) is
  covered, and in description that only DPDK libs have been patched.
* Include new PMU library in patch after rebasing.
v1:
* Improve comment about errno for indeterminate sysconf() values.
  (Stephen)
---
 lib/eal/freebsd/eal.c          |  3 ++-
 lib/eal/freebsd/eal_memory.c   |  7 +++----
 lib/eal/linux/eal.c            |  3 ++-
 lib/eal/unix/eal_unix_memory.c | 16 ++++++++++++++--
 lib/meson.build                |  2 +-
 lib/pmu/pmu.c                  |  8 ++++----
 lib/vhost/vduse.c              |  3 ++-
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 82382d6e8f..c1ab8d86d2 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -26,6 +26,7 @@
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
+#include <rte_eal_paging.h>
 #include <rte_errno.h>
 #include <rte_per_lcore.h>
 #include <rte_lcore.h>
@@ -98,7 +99,7 @@ rte_eal_config_create(void)
 	struct rte_config *config = rte_eal_get_configuration();
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	size_t page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
 	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 3b72e13506..6d3d46a390 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 
 #include <rte_eal.h>
+#include <rte_eal_paging.h>
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_string_fns.h>
@@ -22,8 +23,6 @@
 #include "eal_memcfg.h"
 #include "eal_options.h"
 
-#define EAL_PAGE_SIZE (sysconf(_SC_PAGESIZE))
-
 uint64_t eal_get_baseaddr(void)
 {
 	/*
@@ -191,7 +190,7 @@ rte_eal_hugepage_init(void)
 			addr = mmap(addr, page_sz, PROT_READ|PROT_WRITE,
 					MAP_SHARED | MAP_FIXED,
 					hpi->lock_descriptor,
-					j * EAL_PAGE_SIZE);
+					j * rte_mem_page_size());
 			if (addr == MAP_FAILED) {
 				EAL_LOG(ERR, "Failed to mmap buffer %u from %s",
 						j, hpi->hugedir);
@@ -243,7 +242,7 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 
 	addr = mmap(ms->addr, ms->len, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_FIXED, wa->fd_hugepage,
-			wa->seg_idx * EAL_PAGE_SIZE);
+			wa->seg_idx * rte_mem_page_size());
 	if (addr == MAP_FAILED || addr != ms->addr)
 		return -1;
 	wa->seg_idx++;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 54bee4a2cf..52efb8626b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -31,6 +31,7 @@
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_eal_memconfig.h>
+#include <rte_eal_paging.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
 #include <rte_service_component.h>
@@ -179,7 +180,7 @@ static int
 rte_eal_config_create(void)
 {
 	struct rte_config *config = rte_eal_get_configuration();
-	size_t page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(*config->mem_config);
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
 	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index 61e914b8db..562b2b6d92 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -89,7 +89,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
 	int ret = madvise(virt, size, flags);
 	if (ret) {
 		EAL_LOG(DEBUG, "madvise(%p, %#zx, %d) failed: %s",
-				virt, size, flags, strerror(rte_errno));
+				virt, size, flags, strerror(errno));
 		rte_errno = errno;
 	}
 	return ret;
@@ -147,8 +147,20 @@ rte_mem_page_size(void)
 {
 	static size_t page_size;
 
-	if (!page_size)
+	if (page_size == 0) {
+		/*
+		 * When the sysconf value cannot be determined, sysconf()
+		 * returns -1 without setting errno.
+		 * To distinguish an indeterminate value from an error,
+		 * clear errno before calling sysconf(), and check whether
+		 * errno has been set if sysconf() returns -1.
+		 */
+		errno = 0;
 		page_size = sysconf(_SC_PAGESIZE);
+		if ((ssize_t)page_size < 0)
+			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
+					errno == 0 ? "Indeterminate" : strerror(errno));
+	}
 
 	return page_size;
 }
diff --git a/lib/meson.build b/lib/meson.build
index 1934cb4a29..7c1c21e6bc 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -13,7 +13,6 @@ libraries = [
         'kvargs', # eal depends on kvargs
         'argparse',
         'telemetry', # basic info querying
-        'pmu',
         'eal', # everything depends on eal
         'ptr_compress',
         'ring',
@@ -49,6 +48,7 @@ libraries = [
         'lpm',
         'member',
         'pcapng',
+        'pmu',
         'power',
         'rawdev',
         'regexdev',
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 46b0b450ac..267d48c3d6 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -14,6 +14,7 @@
 
 #include <eal_export.h>
 #include <rte_bitops.h>
+#include <rte_eal_paging.h>
 #include <rte_tailq.h>
 #include <rte_log.h>
 
@@ -215,13 +216,12 @@ open_events(struct rte_pmu_event_group *group)
 static int
 mmap_events(struct rte_pmu_event_group *group)
 {
-	long page_size = sysconf(_SC_PAGE_SIZE);
 	unsigned int i;
 	void *addr;
 	int ret;
 
 	for (i = 0; i < rte_pmu.num_group_events; i++) {
-		addr = mmap(0, page_size, PROT_READ, MAP_SHARED, group->fds[i], 0);
+		addr = mmap(0, rte_mem_page_size(), PROT_READ, MAP_SHARED, group->fds[i], 0);
 		if (addr == MAP_FAILED) {
 			ret = -errno;
 			goto out;
@@ -233,7 +233,7 @@ mmap_events(struct rte_pmu_event_group *group)
 	return 0;
 out:
 	for (; i; i--) {
-		munmap(group->mmap_pages[i - 1], page_size);
+		munmap(group->mmap_pages[i - 1], rte_mem_page_size());
 		group->mmap_pages[i - 1] = NULL;
 	}
 
@@ -250,7 +250,7 @@ cleanup_events(struct rte_pmu_event_group *group)
 
 	for (i = 0; i < rte_pmu.num_group_events; i++) {
 		if (group->mmap_pages[i]) {
-			munmap(group->mmap_pages[i], sysconf(_SC_PAGE_SIZE));
+			munmap(group->mmap_pages[i], rte_mem_page_size());
 			group->mmap_pages[i] = NULL;
 		}
 
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index a2a7d73388..9de7f04a4f 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -16,6 +16,7 @@
 #include <sys/stat.h>
 
 #include <rte_common.h>
+#include <rte_eal_paging.h>
 #include <rte_thread.h>
 
 #include "fd_man.h"
@@ -690,7 +691,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 		dev_config->vendor_id = 0;
 		dev_config->features = features;
 		dev_config->vq_num = total_queues;
-		dev_config->vq_align = sysconf(_SC_PAGE_SIZE);
+		dev_config->vq_align = rte_mem_page_size();
 		dev_config->config_size = sizeof(struct virtio_net_config);
 		memcpy(dev_config->config, &vnet_config, sizeof(vnet_config));
 
-- 
2.43.0

