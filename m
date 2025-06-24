Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A75C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 08:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2E2840698;
	Tue, 24 Jun 2025 10:03:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EED4F40668
 for <dev@dpdk.org>; Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B78952087D;
 Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 24 Jun 2025 10:03:43 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 3/3] pmu: handle sysconf(_SC_PAGESIZE) negative return value
Date: Tue, 24 Jun 2025 08:03:33 +0000
Message-ID: <20250624080333.127618-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624080333.127618-1-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jun 2025 08:03:43.0148 (UTC)
 FILETIME=[80BFAEC0:01DBE4DE]
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

Coverity reports some defects, where the root cause seems to be negative
return value from sysconf(_SC_PAGESIZE) not being handled.

The PMU library cannot use the EAL function rte_mem_page_size(), because
of the dependency chain. (EAL depends on PMU, because Trace is part of
EAL, and Trace depends on PMU; so PMU cannot call EAL functions.)
So mem_page_size(), inspired by rte_mem_page_size(), was added to PMU, and
used instead.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/pmu/pmu.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 46b0b450ac..4c7271522a 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -212,14 +212,40 @@ open_events(struct rte_pmu_event_group *group)
 	return ret;
 }
 
+/* Inspired by rte_mem_page_size() from /lib/eal/unix/eal_unix_memory.c */
+static size_t
+mem_page_size(void)
+{
+	static size_t page_size;
+
+	if (unlikely(page_size == 0)) {
+		/*
+		 * When the sysconf value cannot be determined, sysconf()
+		 * returns -1 without setting errno.
+		 * To distinguish an indeterminate value from an error,
+		 * clear errno before calling sysconf(), and check whether
+		 * errno has been set if sysconf() returns -1.
+		 */
+		errno = 0;
+		page_size = sysconf(_SC_PAGESIZE);
+		if ((ssize_t)page_size < 0 && errno == 0)
+			errno = ENOENT;
+	}
+
+	return page_size;
+}
+
 static int
 mmap_events(struct rte_pmu_event_group *group)
 {
-	long page_size = sysconf(_SC_PAGE_SIZE);
+	size_t page_size = mem_page_size();
 	unsigned int i;
 	void *addr;
 	int ret;
 
+	if ((ssize_t)page_size < 0)
+		return -errno;
+
 	for (i = 0; i < rte_pmu.num_group_events; i++) {
 		addr = mmap(0, page_size, PROT_READ, MAP_SHARED, group->fds[i], 0);
 		if (addr == MAP_FAILED) {
@@ -243,6 +269,7 @@ mmap_events(struct rte_pmu_event_group *group)
 static void
 cleanup_events(struct rte_pmu_event_group *group)
 {
+	size_t page_size = mem_page_size();
 	unsigned int i;
 
 	if (group->fds[0] != -1)
@@ -250,7 +277,8 @@ cleanup_events(struct rte_pmu_event_group *group)
 
 	for (i = 0; i < rte_pmu.num_group_events; i++) {
 		if (group->mmap_pages[i]) {
-			munmap(group->mmap_pages[i], sysconf(_SC_PAGE_SIZE));
+			__rte_assume((ssize_t)page_size >= 0);
+			munmap(group->mmap_pages[i], page_size);
 			group->mmap_pages[i] = NULL;
 		}
 
-- 
2.43.0

