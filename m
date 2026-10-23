Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF5606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E34415D7;
	Fri, 23 Oct 2026 15:44:56 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6A8F640A89
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:43 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AA56200020;
 Fri, 23 Oct 2026 15:44:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E27E5200045;
 Fri, 23 Oct 2026 15:44:42 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E066018000B1;
 Fri, 23 Oct 2026 21:44:41 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 47/65] bus/fslmc: defer DPIO interrupt setup and bind
 portal to worker core
Date: Fri, 23 Oct 2026 19:13:27 +0530
Message-ID: <20261023134346.37727-48-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Rework the DPIO software-portal interrupt handling so that a portal is
only wired to a VFIO eventfd IRQ when it is actually used, and bind the
portal's IRQ, CPU governor and stashing to the worker core on first
touch or worker core change rather than at create time.

VFIO interrupt lookup:

  - rte_dpaa2_vfio_setup_intr() now takes a flag and returns the matched
    interrupt index (or a negative errno) instead of hard-coding index 0
    and the eventfd type. It skips vectors that do not advertise the
    requested flag instead of failing on the first one.
  - dpaa2_dpio_intr_init() calls it with VFIO_IRQ_INFO_EVENTFD, stores
    the resolved intr_index in the dpio_dev, and enables/disables the
    interrupt using that index. The intr handle allocation and one-shot
    setup are removed from dpaa2_create_dpio_device(); the dpio_dev now
    caches vfio_fd and num_irqs for the lazy setup.

Per-core binding helpers:

  - dpaa2_dpio_intr_affinity_set() locates the dpio.<id> IRQ in
    /proc/interrupts (exact-token match so dpio.17 does not match
    dpio.170) and writes the CPU to smp_affinity_list, returning an
    error code instead of the old void best-effort helper.
  - dpaa2_dpio_affine_intr_to_core() now takes the dpio_dev and uses the
    new setter.
  - dpaa2_dpio_cpufreq_governor() saves the per-CPU scaling_governor,
    forces "performance", and can restore all saved governors.
  - dpaa2_configure_stashing() is exported as
    dpaa2_dpio_configure_stashing() and its errors are propagated.

Event PMD binding:

  - On the first dequeue on a new core or core change, the event port
    pins the portal IRQ to that core, sets the performance governor and
    configures stashing. Governors are restored in dpaa2_eventdev_close().
  - Mark the port_atomic branch as unlikely on the enqueue/dequeue hot
    path.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/fslmc_vfio.c           |  34 ++-
 drivers/bus/fslmc/fslmc_vfio.h           |   4 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 297 ++++++++++++++++-------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h  |   3 +
 drivers/event/dpaa2/dpaa2_eventdev.c     |  29 ++-
 drivers/net/dpaa2/dpaa2_ethdev.c         |   2 +-
 7 files changed, 266 insertions(+), 114 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 4897d7a78b..887a68ab32 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1509,41 +1509,35 @@ int rte_dpaa2_intr_disable(struct rte_intr_handle *intr_handle, int index)
 	return ret;
 }
 
-/* set up interrupt support (but not enable interrupts) */
+/* Set up interrupt with flag, return interrupt index in success, minus in failure. */
 int
 rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
-			  int vfio_dev_fd,
-			  int num_irqs)
+	int vfio_dev_fd, int num_irqs, uint32_t flag)
 {
-	int i, ret;
+	int i, ret, fd;
 
-	/* start from MSI-X interrupt type */
+	/* Find interrupt with given flag. */
 	for (i = 0; i < num_irqs; i++) {
 		struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
-		int fd = -1;
 
 		irq_info.index = i;
 
 		ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
 		if (ret < 0) {
-			DPAA2_BUS_ERR("Cannot get IRQ(%d) info, error %i (%s)",
-				      i, errno, strerror(errno));
-			return ret;
+			DPAA2_BUS_ERR("Failed(%d) to get IRQ(%d) info (%s)",
+				-errno, i, strerror(errno));
+			continue;
 		}
 
-		/* if this vector cannot be used with eventfd,
-		 * fail if we explicitly
-		 * specified interrupt type, otherwise continue
-		 */
-		if ((irq_info.flags & VFIO_IRQ_INFO_EVENTFD) == 0)
+		if (!(irq_info.flags & flag))
 			continue;
 
 		/* set up an eventfd for interrupts */
 		fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
 		if (fd < 0) {
-			DPAA2_BUS_ERR("Cannot set up eventfd, error %i (%s)",
-				errno, strerror(errno));
-			return fd;
+			DPAA2_BUS_ERR("Cannot set up eventfd, error %d (%s)",
+				-errno, strerror(errno));
+			return -errno;
 		}
 
 		if (rte_intr_fd_set(intr_handle, fd))
@@ -1555,7 +1549,7 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
 		if (rte_intr_dev_fd_set(intr_handle, vfio_dev_fd))
 			return -rte_errno;
 
-		return 0;
+		return i;
 	}
 
 	/* if we're here, we haven't found a suitable interrupt vector */
@@ -1628,8 +1622,8 @@ fslmc_vfio_process_iodevices(struct rte_dpaa2_device *dev)
 	switch (dev->dev_type) {
 	case DPAA2_ETH:
 		ret = rte_dpaa2_vfio_setup_intr(dev->intr_handle, dev_fd,
-				device_info.num_irqs);
-		if (ret)
+				device_info.num_irqs, VFIO_IRQ_INFO_EVENTFD);
+		if (ret < 0)
 			return ret;
 		break;
 	case DPAA2_CON:
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index 34f2d7759c..9934bc0e86 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -45,8 +45,8 @@ int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
 __rte_internal
 int rte_dpaa2_intr_disable(struct rte_intr_handle *intr_handle, int index);
 
-int rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle, int vfio_dev_fd,
-	int num_irqs);
+int rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
+	int vfio_dev_fd, int num_irqs, uint32_t flag);
 
 int fslmc_vfio_core_cluster_sdest(uint32_t cpu_id);
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e95345627d..17af74aad8 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -66,6 +66,13 @@ static uint32_t io_space_count;
 /* Variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa2_portal_key;
 
+struct dpaa2_dpio_gov_save {
+	char prev[32];
+	uint8_t valid;
+};
+
+static struct dpaa2_dpio_gov_save s_dpaa2_dpio_gov_save[RTE_MAX_LCORE];
+
 static struct dpaa2_dpio_dev *get_dpio_dev_from_id(int32_t dpio_id)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
@@ -105,59 +112,92 @@ dpaa2_get_core_id(void)
 	return cpu_id;
 }
 
-static void
-dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_affinity_set)
+int dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 {
-#define STRING_LEN	28
-#define AFFINITY_LEN	128
-	uint32_t cpu_mask = 1;
-	size_t len = 0;
-	char *temp = NULL, *token = NULL;
-	char string[STRING_LEN];
-	char smp_affinity[AFFINITY_LEN];
-	FILE *file;
-
-	snprintf(string, STRING_LEN, "dpio.%d", dpio_id);
-	file = fopen("/proc/interrupts", "r");
-	if (!file) {
-		DPAA2_BUS_WARN("Failed to open /proc/interrupts file");
-		return;
+	char line[512], match[32], path[64];
+	FILE *fp;
+	long irq = -1;
+	int32_t dpio_id = dpio_dev->hw_id, ret = 0;
+
+#define IRQ_ALL_F "/proc/interrupts"
+#define IRQ_SMP_AFFINITY_F "/proc/irq/%ld/smp_affinity_list"
+
+	if (cpu_id < 0 || cpu_id >= RTE_MAX_LCORE)
+		return -EINVAL;
+
+	/* Token we look for on each /proc/interrupts line, e.g. "dpio.17". */
+	snprintf(match, sizeof(match), "dpio.%d", dpio_id);
+
+	fp = fopen(IRQ_ALL_F, "r");
+	if (!fp) {
+		DPAA2_BUS_ERR("Failed to open %s: %s", IRQ_ALL_F, strerror(errno));
+		return -errno;
 	}
-	while (getline(&temp, &len, file) != -1) {
-		if ((strstr(temp, string)) != NULL) {
-			token = strtok(temp, ":");
-			break;
-		}
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *p, next;
+
+		/*
+		 * Match the exact device token. Use the trailing '(' or ')'
+		 * naming so that "dpio.17" does not accidentally match
+		 * "dpio.170". We look for "dpio.<id>)" or "dpio.<id>(".
+		 */
+		p = strstr(line, match);
+		if (!p)
+			continue;
+
+		/* Ensure the char right after the id is not another digit,
+		 * so "dpio.17" won't match "dpio.170".
+		 */
+		next = p[strlen(match)];
+		if (next >= '0' && next <= '9')
+			continue;
+
+		/* IRQ number is the leading integer before the first ':'. */
+		irq = strtol(line, NULL, 10);
+		break;
 	}
+	fclose(fp);
 
-	if (!token) {
-		DPAA2_BUS_WARN("Failed to get interrupt id for dpio.%d",
-			       dpio_id);
-		free(temp);
-		fclose(file);
-		return;
+	if (irq < 0) {
+		DPAA2_BUS_ERR("IRQ for dpio.%d not found in %s", dpio_id, IRQ_ALL_F);
+		return -ENOENT;
+	}
+
+	/*
+	 * Write the CPU as a decimal list to smp_affinity_list; this is the
+	 * simplest and least error-prone form (no hex bitmask math needed).
+	 * Equivalent to writing (1 << cpu_id) in hex to smp_affinity.
+	 */
+	snprintf(path, sizeof(path), IRQ_SMP_AFFINITY_F, irq);
+
+	fp = fopen(path, "w");
+	if (!fp) {
+		DPAA2_BUS_ERR("Failed to open %s: %s", path, strerror(errno));
+		return -errno;
 	}
 
-	cpu_mask = cpu_mask << cpu_id;
-	snprintf(smp_affinity, AFFINITY_LEN, "/proc/irq/%s/smp_affinity", token);
-	free(temp);
-	fclose(file);
+	if (fprintf(fp, "%d\n", cpu_id) < 0) {
+		DPAA2_BUS_ERR("Failed to write %s: %s", path, strerror(errno));
+		ret = -EIO;
+		goto close_f;
+	}
 
-	file = fopen(smp_affinity, "w");
-	if (file == NULL) {
-		DPAA2_BUS_WARN("Failed to open %s", smp_affinity);
-		return;
+	if (fflush(fp) != 0 || ferror(fp)) {
+		DPAA2_BUS_ERR("Error writing affinity to %s", path);
+		ret = -EIO;
 	}
-	fprintf(file, "%X\n", cpu_mask);
-	fflush(file);
 
-	if (ferror(file)) {
-		fclose(file);
-		DPAA2_BUS_WARN("Failed to write to %s", smp_affinity);
-		return;
+close_f:
+	fclose(fp);
+
+	if (!ret) {
+		DPAA2_BUS_INFO("dpio.%d -> IRQ %ld affinity set to CPU %d",
+			dpio_id, irq, cpu_id);
 	}
 
-	fclose(file);
+	return ret;
 }
 
 /* Pin the dpio's MSI IRQ to the calling lcore's core (best-effort), so a
@@ -165,12 +205,104 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
  */
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_affine_intr_to_core)
 void
-dpaa2_dpio_affine_intr_to_core(int32_t dpio_id)
+dpaa2_dpio_affine_intr_to_core(struct dpaa2_dpio_dev *dpio_dev)
+{
+	int cpu_id = dpaa2_get_core_id(), ret;
+
+	if (cpu_id >= 0) {
+		ret = dpaa2_dpio_intr_affinity_set(dpio_dev, cpu_id);
+		if (ret)
+			DPAA2_BUS_ERR("Failed(%d) to affinity interrupt on core.%d", ret, cpu_id);
+	}
+}
+
+static int _dpaa2_dpio_cpufreq_governor(uint32_t cpu_id, bool restore)
+{
+	struct dpaa2_dpio_gov_save *gov;
+	char path[64], prev[32];
+	FILE *fp;
+	int ret = 0;
+	const char *str;
+
+#define CPU_FREQ_SCALING_GOVERNOR_F \
+	"/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor"
+
+	if (cpu_id >= RTE_MAX_LCORE)
+		return -EINVAL;
+
+	gov = &s_dpaa2_dpio_gov_save[cpu_id];
+	if (!gov->valid && restore)
+		return 0;
+
+	snprintf(path, sizeof(path), CPU_FREQ_SCALING_GOVERNOR_F, cpu_id);
+	if (restore) {
+		str = gov->prev;
+		goto set_governor;
+	}
+
+	if (!gov->valid) {
+		fp = fopen(path, "r");
+		if (!fp) {
+			DPAA2_BUS_ERR("Failed to open %s in r mode: %s", path, strerror(errno));
+			return -errno;
+		}
+		if (fgets(prev, sizeof(prev), fp)) {
+			prev[strcspn(prev, "\n")] = '\0';
+			snprintf(gov->prev, sizeof(gov->prev), "%s", prev);
+		}
+		fclose(fp);
+	}
+	str = "performance";
+
+set_governor:
+	fp = fopen(path, "w");
+	if (!fp) {
+		DPAA2_BUS_ERR("Failed to open %s in w mode: %s", path, strerror(errno));
+		return -errno;
+	}
+
+	if (fprintf(fp, "%s\n", str) < 0) {
+		DPAA2_BUS_ERR("Failed to write %s to %s: %s", str, path, strerror(errno));
+		ret = -EIO;
+		goto close_f;
+	}
+
+	if (fflush(fp)) {
+		DPAA2_BUS_ERR("Failed to flush %s: %s", path, strerror(errno));
+		ret = -EIO;
+	}
+
+close_f:
+	fclose(fp);
+
+	if (!ret) {
+		DPAA2_BUS_INFO("Set cpu%d's freq as performance mode.", cpu_id);
+		gov->valid = restore ? 0 : 1;
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_cpufreq_governor)
+int dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore)
 {
-	int cpu_id = dpaa2_get_core_id();
+	bool governor_all = cpu_id < 0 ? true : false;
+	int ret = 0;
 
-	if (cpu_id >= 0)
-		dpaa2_affine_dpio_intr_to_respective_core(dpio_id, cpu_id);
+	if (cpu_id >= RTE_MAX_LCORE)
+		return -EINVAL;
+
+	if (governor_all) {
+		for (cpu_id = 0; cpu_id < RTE_MAX_LCORE; cpu_id++) {
+			ret = _dpaa2_dpio_cpufreq_governor(cpu_id, restore);
+			if (ret)
+				break;
+		}
+	} else {
+		ret = _dpaa2_dpio_cpufreq_governor(cpu_id, restore);
+	}
+
+	return ret;
 }
 
 /* threshold: DQRR fill raising DQRI (< ring depth); timeout: holdoff in ITP units.
@@ -183,13 +315,20 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
 int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 	int timeout, bool build_epoll)
 {
-	int eventfd, dpio_epoll_fd, ret;
+	int eventfd, dpio_epoll_fd, ret, index;
 	struct rte_epoll_event *epoll_ev;
 
 	if (dpio_dev->intr_enabled)
 		return 0;
 
-	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, 0);
+	index = rte_dpaa2_vfio_setup_intr(dpio_dev->intr_handle, dpio_dev->vfio_fd,
+		dpio_dev->num_irqs, VFIO_IRQ_INFO_EVENTFD);
+	if (index < 0) {
+		DPAA2_BUS_ERR("Fail(%d) to setup interrupt for %d", index, dpio_dev->hw_id);
+		return index;
+	}
+
+	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, index);
 	if (ret) {
 		DPAA2_BUS_ERR("Failed(%d) to enable dpio interrupt", ret);
 		return ret;
@@ -234,14 +373,15 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 		}
 	}
 
-	dpio_dev->intr_enabled = 1;
+	dpio_dev->intr_enabled = true;
+	dpio_dev->intr_index = index;
 
 	return 0;
 
 epoll_close_err:
 	close(dpio_epoll_fd);
 int_disable_err:
-	rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
+	rte_dpaa2_intr_disable(dpio_dev->intr_handle, index);
 	return ret;
 }
 
@@ -265,15 +405,16 @@ void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 		close(epfd);
 	}
 
-	ret = rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
+	ret = rte_dpaa2_intr_disable(dpio_dev->intr_handle, dpio_dev->intr_index);
 	if (ret)
 		DPAA2_BUS_ERR("DPIO interrupt disable failed(%d)", ret);
 
-	dpio_dev->intr_enabled = 0;
+	dpio_dev->intr_enabled = false;
 }
 
-static int
-dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_configure_stashing)
+int
+dpaa2_dpio_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 {
 	int sdest, ret;
 
@@ -281,19 +422,18 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	 * Valid values of SDEST are 4,5,6,7. Where,
 	 */
 	sdest = fslmc_vfio_core_cluster_sdest(cpu_id);
-	DPAA2_BUS_DEBUG("Portal= %d  CPU= %u SDEST= %d",
-			dpio_dev->index, cpu_id, sdest);
+	DPAA2_BUS_DEBUG("Portal= %d  CPU= %u SDEST= %d", dpio_dev->index, cpu_id, sdest);
 	if (sdest < 0)
 		return sdest;
 
 	ret = dpio_set_stashing_destination(dpio_dev->dpio, CMD_PRI_LOW,
-					    dpio_dev->token, sdest);
+		dpio_dev->token, sdest);
 	if (ret) {
-		DPAA2_BUS_ERR("%d ERROR in SDEST",  ret);
-		return ret;
+		DPAA2_BUS_ERR("Failed(%d) to set stashing(%02x) of dpio.%d/cpu.%d",
+		 ret, sdest, dpio_dev->hw_id, cpu_id);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
@@ -335,9 +475,9 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 		if (dpaa2_svr_family != SVR_LX2160A)
 			qbman_swp_update(dpio_dev->sw_portal, 1);
 	} else {
-		ret = dpaa2_configure_stashing(dpio_dev, cpu_id);
+		ret = dpaa2_dpio_configure_stashing(dpio_dev, cpu_id);
 		if (ret) {
-			DPAA2_BUS_ERR("dpaa2_configure_stashing failed");
+			DPAA2_BUS_ERR("Failed(%d) to configure stashing", ret);
 			rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
 				rte_memory_order_release);
 			return NULL;
@@ -453,7 +593,7 @@ rte_dpaa2_alloc_dpio_device(int isr, uint32_t threshold, int32_t cpu_affine)
 		return NULL;
 	}
 	if (cpu_affine >= 0)
-		dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_affine);
+		dpaa2_dpio_intr_affinity_set(dpio_dev, cpu_affine);
 quit:
 #else
 	RTE_SET_USED(isr);
@@ -533,18 +673,13 @@ dpaa2_create_dpio_device(int vdev_fd,
 
 	dpio_dev->dpio = NULL;
 	dpio_dev->hw_id = object_id;
+	dpio_dev->vfio_fd = vdev_fd;
+	dpio_dev->intr_handle = obj->intr_handle;
+	dpio_dev->num_irqs = obj_info->num_irqs;
 	rte_atomic_store_explicit(&dpio_dev->ref_count, 0, rte_memory_order_relaxed);
 	/* Using single portal  for all devices */
 	dpio_dev->mc_portal = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 
-	/* Allocate interrupt instance */
-	dpio_dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
-	if (!dpio_dev->intr_handle) {
-		DPAA2_BUS_ERR("Failed to allocate intr handle");
-		goto err;
-	}
-
 	dpio_dev->dpio = rte_zmalloc(NULL, sizeof(struct fsl_mc_io),
 				     RTE_CACHE_LINE_SIZE);
 	if (!dpio_dev->dpio) {
@@ -553,8 +688,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	}
 
 	dpio_dev->dpio->regs = dpio_dev->mc_portal;
-	if (dpio_open(dpio_dev->dpio, CMD_PRI_LOW, dpio_dev->hw_id,
-		      &dpio_dev->token)) {
+	if (dpio_open(dpio_dev->dpio, CMD_PRI_LOW, dpio_dev->hw_id, &dpio_dev->token)) {
 		DPAA2_BUS_ERR("Failed to allocate IO space");
 		goto err;
 	}
@@ -569,8 +703,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 		goto err;
 	}
 
-	if (dpio_get_attributes(dpio_dev->dpio, CMD_PRI_LOW,
-				dpio_dev->token, &attr)) {
+	if (dpio_get_attributes(dpio_dev->dpio, CMD_PRI_LOW, dpio_dev->token, &attr)) {
 		DPAA2_BUS_ERR("DPIO Get attribute failed");
 		goto err;
 	}
@@ -587,8 +720,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 
 	dpio_dev->ce_size = reg_info.size;
 	dpio_dev->qbman_portal_ce_paddr = (size_t)mmap(NULL, reg_info.size,
-				PROT_WRITE | PROT_READ, MAP_SHARED,
-				vdev_fd, reg_info.offset);
+		PROT_WRITE | PROT_READ, MAP_SHARED, vdev_fd, reg_info.offset);
 
 	reg_info.index = DPAA2_SWP_CINH_REGION;
 	if (ioctl(vdev_fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info)) {
@@ -598,8 +730,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 
 	dpio_dev->ci_size = reg_info.size;
 	dpio_dev->qbman_portal_ci_paddr = (size_t)mmap(NULL, reg_info.size,
-				PROT_WRITE | PROT_READ, MAP_SHARED,
-				vdev_fd, reg_info.offset);
+		PROT_WRITE | PROT_READ, MAP_SHARED, vdev_fd, reg_info.offset);
 
 	/* Configure & setup SW portal */
 	p_des.block = NULL;
@@ -620,12 +751,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 	io_space_count++;
 	dpio_dev->index = io_space_count;
 
-	if (rte_dpaa2_vfio_setup_intr(dpio_dev->intr_handle, vdev_fd, 1)) {
-		DPAA2_BUS_ERR("Fail to setup interrupt for %d",
-			      dpio_dev->hw_id);
-		goto err;
-	}
-
 	dpio_dev->eqresp = rte_zmalloc(NULL, MAX_EQ_RESP_ENTRIES *
 				     (sizeof(struct qbman_result) +
 				     sizeof(struct eqresp_metadata)),
@@ -668,7 +793,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 		rte_free(dpio_dev->dpio);
 	}
 
-	rte_intr_instance_free(dpio_dev->intr_handle);
 	rte_free(dpio_dev);
 
 	/* For each element in the list, cleanup */
@@ -680,7 +804,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 				dpio_dev->token);
 			rte_free(dpio_dev->dpio);
 		}
-		rte_intr_instance_free(dpio_dev->intr_handle);
 		rte_free(dpio_dev);
 	}
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 0d0894572a..7c089408c5 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -38,6 +38,15 @@ RTE_DECLARE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 #define DPAA2_PER_LCORE_DQRR_MBUF(i) \
 	RTE_PER_LCORE(_dpaa2_io).dpio_dev->dpaa2_held_bufs.mbuf[i]
 
+__rte_internal int
+dpaa2_dpio_intr_affinity_set(struct dpaa2_dpio_dev *dpio_dev, int cpu_id);
+
+__rte_internal int
+dpaa2_dpio_cpufreq_governor(int cpu_id, bool restore);
+
+__rte_internal int
+dpaa2_dpio_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id);
+
 /* Affine a DPIO portal to current processing thread */
 __rte_internal
 int dpaa2_affine_qbman_swp(void);
@@ -56,7 +65,7 @@ void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev);
 
 /* pin a DPIO's MSI IRQ to the calling lcore's core (rx-queue interrupt mode) */
 __rte_internal
-void dpaa2_dpio_affine_intr_to_core(int32_t dpio_id);
+void dpaa2_dpio_affine_intr_to_core(struct dpaa2_dpio_dev *dpio_dev);
 
 /* allocate memory for FQ - dq storage */
 __rte_internal
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 52ec660fb9..95c7203aa2 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -133,6 +133,9 @@ struct dpaa2_dpio_dev {
 		/**< Physical address of Cache Inhibit Area */
 	uintptr_t ci_size; /**< Size of the CI region */
 	struct rte_intr_handle *intr_handle; /* Interrupt related info */
+	int32_t vfio_fd;
+	uint32_t num_irqs;
+	int32_t intr_index;
 	int32_t hw_id; /**< An unique ID of this DPIO device instance */
 	uint8_t intr_enabled; /**< DQRI portal interrupt already set up */
 	int32_t cpu_affine;
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index f4dbf47b18..ad80fd51f5 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -88,6 +88,7 @@ static __rte_always_inline struct dpaa2_dpio_dev *
 dpaa2_event_portal_io_prepare(struct dpaa2_port *dpaa2_portal)
 {
 	struct dpaa2_dpio_dev *dpio_dev;
+	int ret, cpu = rte_lcore_id();
 
 	if (unlikely(!dpaa2_portal->dpio_dev)) {
 		DPAA2_EVENTDEV_ERR("Event port%d not setup", dpaa2_portal->port_id);
@@ -106,10 +107,23 @@ dpaa2_event_portal_io_prepare(struct dpaa2_port *dpaa2_portal)
 	if (unlikely(!dpaa2_portal->port_atomic &&
 		!rte_atomic_load_explicit(&dpaa2_portal->flushing,
 		rte_memory_order_relaxed)) &&
-		dpio_dev->cpu_affine != (int32_t)rte_lcore_id()) {
+		dpio_dev->cpu_affine != cpu) {
 		DPAA2_EVENTDEV_DEBUG("Event port%d affine CPU from %d->%d",
-			dpaa2_portal->port_id, dpio_dev->cpu_affine, rte_lcore_id());
-		dpio_dev->cpu_affine = rte_lcore_id();
+			dpaa2_portal->port_id, dpio_dev->cpu_affine, cpu);
+		dpio_dev->cpu_affine = cpu;
+		ret = dpaa2_dpio_intr_affinity_set(dpio_dev, cpu);
+		if (ret) {
+			DPAA2_EVENTDEV_ERR("Failed(%d) to affinity dpio.%d's interrupt on core%d",
+				ret, dpio_dev->hw_id, cpu);
+		}
+		ret = dpaa2_dpio_cpufreq_governor(cpu, false);
+		if (ret)
+			DPAA2_EVENTDEV_WARN("Failed(%d) to set governor of core%d", ret, cpu);
+		ret = dpaa2_dpio_configure_stashing(dpio_dev, cpu);
+		if (ret) {
+			DPAA2_EVENTDEV_WARN("Failed(%d) to configure dpio.%d's stashing on core%d",
+				ret, dpio_dev->hw_id, cpu);
+		}
 	}
 
 	return dpio_dev;
@@ -588,6 +602,15 @@ dpaa2_eventdev_close(struct rte_eventdev *dev)
 			dpaa2_eventdev_port_release(dev->data->ports[i]);
 	}
 
+	/*
+	 * Restore any CPU-frequency governor that the optional first-touch
+	 * binding may have forced (see dpaa2_dpio_cpufreq_governor(cpu, false)).
+	 * Best-effort and a no-op when the governor was never touched.
+	 */
+	ret = dpaa2_dpio_cpufreq_governor(-1, true);
+	if (ret)
+		DPAA2_EVENTDEV_ERR("Failed(%d) to restore all cpus' governors", ret);
+
 	ret = dpaa2_eventdev_eth_queue_del(dev, NULL, -1);
 	if (!ret)
 		priv->status = DPAA2_EVENTDEV_CREATED;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c1a0ae7763..88a0f9bdbb 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3669,7 +3669,7 @@ dpaa2_napi_subscribe(struct rte_eth_dev *dev, uint16_t queue_id,
 	/* pin this portal's MSI to the worker's core: a CDAN wake then lands on
 	 * the same core the worker sleeps on, instead of the default spread.
 	 */
-	dpaa2_dpio_affine_intr_to_core(dpio->hw_id);
+	dpaa2_dpio_affine_intr_to_core(dpio);
 	return 0;
 }
 
-- 
2.43.0

