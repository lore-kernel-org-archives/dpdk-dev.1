Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D316C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 09:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2733B42E80;
	Tue, 10 Jun 2025 11:14:19 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 06C4340292
 for <dev@dpdk.org>; Tue, 10 Jun 2025 11:14:15 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2A23200509;
 Tue, 10 Jun 2025 11:14:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 479C12000E8;
 Tue, 10 Jun 2025 11:14:14 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2002C1800244;
 Tue, 10 Jun 2025 17:14:13 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v3 02/10] bus/dpaa: add FMan node
Date: Tue, 10 Jun 2025 14:44:03 +0530
Message-Id: <20250610091411.2500413-3-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
References: <20250602131526.3233959-1-vanshika.shukla@nxp.com>
 <20250610091411.2500413-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Add FMan node(s) and associate FMan to it's interface(port).
This method describes FMan attributes and avoid accessing FMan from
port directly.
Logically, something like IEEE 1588 is FMan global resource,
which is in range of 0xF_E000–0xF_EFFF.
Port specific resource is in range of 0x8_0000–0xB_FFFF.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c         | 278 ++++++++++++----------
 drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
 drivers/bus/dpaa/dpaa_bus.c               |  17 +-
 drivers/bus/dpaa/include/fman.h           |  40 ++--
 drivers/bus/dpaa/include/netcfg.h         |  14 --
 drivers/net/dpaa/dpaa_ethdev.c            |  18 +-
 drivers/net/dpaa/dpaa_ptp.c               |  12 +-
 7 files changed, 206 insertions(+), 181 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index d49339d81e..1b3b8836a5 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -16,24 +16,15 @@
 #include <rte_dpaa_logs.h>
 #include <rte_string_fns.h>
 
-#define QMI_PORT_REGS_OFFSET		0x400
-
-/* CCSR map address to access ccsr based register */
-void *fman_ccsr_map;
-/* fman version info */
-u16 fman_ip_rev;
-static int get_once;
-u32 fman_dealloc_bufs_mask_hi;
-u32 fman_dealloc_bufs_mask_lo;
-
 int fman_ccsr_map_fd = -1;
 static COMPAT_LIST_HEAD(__ifs);
-void *rtc_map;
+static COMPAT_LIST_HEAD(__fmans);
 
 /* This is the (const) global variable that callers have read-only access to.
  * Internally, we have read-write access directly to __ifs.
  */
 const struct list_head *fman_if_list = &__ifs;
+const struct list_head *fman_list = &__fmans;
 
 static void
 if_destructor(struct __fman_if *__if)
@@ -55,40 +46,99 @@ if_destructor(struct __fman_if *__if)
 }
 
 static int
-fman_get_ip_rev(const struct device_node *fman_node)
+_fman_init(const struct device_node *fman_node, int fd)
 {
-	const uint32_t *fman_addr;
-	uint64_t phys_addr;
-	uint64_t regs_size;
+	const struct device_node *ptp_node;
+	const uint32_t *fman_addr, *ptp_addr, *cell_idx;
+	uint64_t phys_addr, regs_size, lenp;
+	void *vir_addr;
 	uint32_t ip_rev_1;
-	int _errno;
+	int _errno = 0;
+	struct __fman *fman;
+
+	fman = rte_zmalloc(NULL, sizeof(struct __fman), 0);
+	if (!fman) {
+		FMAN_ERR(-ENOMEM, "malloc fman");
+		return -ENOMEM;
+	}
+
+	cell_idx = of_get_property(fman_node, "cell-index", &lenp);
+	if (!cell_idx) {
+		FMAN_ERR(-ENXIO, "%s: no cell-index", fman_node->full_name);
+		return -ENXIO;
+	}
+	assert(lenp == sizeof(*cell_idx));
+	fman->idx = of_read_number(cell_idx, lenp / sizeof(phandle));
 
 	fman_addr = of_get_address(fman_node, 0, &regs_size, NULL);
 	if (!fman_addr) {
-		pr_err("of_get_address cannot return fman address\n");
+		FMAN_ERR(-EINVAL, "Get fman's CCSR failed");
 		return -EINVAL;
 	}
 	phys_addr = of_translate_address(fman_node, fman_addr);
 	if (!phys_addr) {
-		pr_err("of_translate_address failed\n");
+		FMAN_ERR(-EINVAL, "Translate fman's CCSR failed");
 		return -EINVAL;
 	}
-	fman_ccsr_map = mmap(NULL, regs_size, PROT_READ | PROT_WRITE,
-			     MAP_SHARED, fman_ccsr_map_fd, phys_addr);
-	if (fman_ccsr_map == MAP_FAILED) {
-		pr_err("Can not map FMan ccsr base");
+	vir_addr = mmap(NULL, regs_size, PROT_READ | PROT_WRITE,
+		MAP_SHARED, fd, phys_addr);
+	if (vir_addr == MAP_FAILED) {
+		FMAN_ERR(-EINVAL, "Map fman's CCSR failed");
 		return -EINVAL;
 	}
+	fman->ccsr_phy = phys_addr;
+	fman->ccsr_size = regs_size;
+	fman->ccsr_vir = vir_addr;
+
+	fman->time_phy = 0;
+	for_each_compatible_node(ptp_node, NULL, "fsl,fman-ptp-timer") {
+		ptp_addr = of_get_address(ptp_node, 0, &regs_size, NULL);
+		if (!ptp_addr)
+			continue;
+		phys_addr = of_translate_address(ptp_node, ptp_addr);
+		if (phys_addr != (fman->ccsr_phy + fman->ccsr_size))
+			continue;
+		vir_addr = mmap(NULL, regs_size, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fd, phys_addr);
+		if (vir_addr == MAP_FAILED) {
+			FMAN_ERR(-EINVAL, "Map fman's IEEE 1588 failed");
+			return -EINVAL;
+		}
+		fman->time_phy = phys_addr;
+		fman->time_size = regs_size;
+		fman->time_vir = vir_addr;
+		break;
+	}
 
-	ip_rev_1 = in_be32(fman_ccsr_map + FMAN_IP_REV_1);
-	fman_ip_rev = (ip_rev_1 & FMAN_IP_REV_1_MAJOR_MASK) >>
-			FMAN_IP_REV_1_MAJOR_SHIFT;
+	if (!fman->time_phy) {
+		FMAN_ERR(-EINVAL, "Map fman's IEEE 1588 failed");
+		return -EINVAL;
+	}
 
-	_errno = munmap(fman_ccsr_map, regs_size);
-	if (_errno)
-		pr_err("munmap() of FMan ccsr failed");
+	ip_rev_1 = in_be32((uint8_t *)fman->ccsr_vir + FMAN_IP_REV_1);
+	fman->ip_rev = ip_rev_1 >> FMAN_IP_REV_1_MAJOR_SHIFT;
+	fman->ip_rev &=	FMAN_IP_REV_1_MAJOR_MASK;
+	DPAA_BUS_LOG(NOTICE, "FMan version is 0x%02x", fman->ip_rev);
 
-	return 0;
+	if (fman->ip_rev >= FMAN_V3) {
+		/*
+		 * Set A2V, OVOM, EBD bits in contextA to allow external
+		 * buffer deallocation by fman.
+		 */
+		fman->dealloc_bufs_mask_hi =
+			DPAA_FQD_CTX_A_A2_FIELD_VALID |
+			DPAA_FQD_CTX_A_OVERRIDE_OMB;
+		fman->dealloc_bufs_mask_lo = DPAA_FQD_CTX_A2_EBD_BIT;
+	} else {
+		fman->dealloc_bufs_mask_hi = 0;
+		fman->dealloc_bufs_mask_lo = 0;
+	}
+
+	fman->fman_node = fman_node;
+
+	list_add_tail(&fman->node, &__fmans);
+
+	return _errno;
 }
 
 static int
@@ -227,7 +277,7 @@ static void fman_if_vsp_init(struct __fman_if *__if)
 }
 
 static int
-fman_if_init(const struct device_node *dpa_node)
+fman_if_init(const struct device_node *dpa_node, int fd)
 {
 	const char *rprop, *mprop;
 	uint64_t phys_addr;
@@ -251,12 +301,13 @@ fman_if_init(const struct device_node *dpa_node)
 	const struct device_node *rx_node = NULL, *tx_node = NULL;
 	const struct device_node *oh_node = NULL;
 	const uint32_t *regs_addr = NULL;
-	const char *mname, *fname;
+	const char *mname;
 	const char *dname = dpa_node->full_name;
 	size_t lenp;
-	int _errno, is_shared = 0, is_offline = 0;
+	int _errno, is_shared = 0, is_offline = 0, find_fman = false;
 	const char *char_prop;
 	uint32_t na;
+	struct __fman *fman, *tmp_fman;
 
 	if (of_device_is_available(dpa_node) == false)
 		return 0;
@@ -414,8 +465,7 @@ fman_if_init(const struct device_node *dpa_node)
 		goto err;
 	}
 	__if->ccsr_map = mmap(NULL, __if->regs_size,
-			      PROT_READ | PROT_WRITE, MAP_SHARED,
-			      fman_ccsr_map_fd, phys_addr);
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
 	if (__if->ccsr_map == MAP_FAILED) {
 		FMAN_ERR(-errno, "mmap(0x%"PRIx64")", phys_addr);
 		goto err;
@@ -426,51 +476,24 @@ fman_if_init(const struct device_node *dpa_node)
 
 	/* Get the index of the Fman this i/f belongs to */
 	fman_node = of_get_parent(mac_node);
-	na = of_n_addr_cells(mac_node);
-	if (!fman_node) {
-		FMAN_ERR(-ENXIO, "of_get_parent(%s)", mname);
-		goto err;
+	list_for_each_entry_safe(fman, tmp_fman, &__fmans, node) {
+		if (fman_node == fman->fman_node) {
+			find_fman = true;
+			break;
+		}
 	}
-	fname = fman_node->full_name;
-	cell_idx = of_get_property(fman_node, "cell-index", &lenp);
-	if (!cell_idx) {
-		FMAN_ERR(-ENXIO, "%s: no cell-index)", fname);
+	if (!find_fman) {
+		FMAN_ERR(-ENXIO, "Failed to get parent of %s", mname);
 		goto err;
 	}
-	assert(lenp == sizeof(*cell_idx));
-	cell_idx_host = of_read_number(cell_idx, lenp / sizeof(phandle));
-	__if->__if.fman_idx = cell_idx_host;
-	if (!get_once) {
-		_errno = fman_get_ip_rev(fman_node);
-		if (_errno) {
-			FMAN_ERR(-ENXIO, "%s: ip_rev is not available",
-				 fname);
-			goto err;
-		}
-	}
+	__if->__if.fman = fman;
 
-	if (fman_ip_rev >= FMAN_V3) {
-		/*
-		 * Set A2V, OVOM, EBD bits in contextA to allow external
-		 * buffer deallocation by fman.
-		 */
-		fman_dealloc_bufs_mask_hi = DPAA_FQD_CTX_A_A2_FIELD_VALID |
-					    DPAA_FQD_CTX_A_OVERRIDE_OMB;
-		fman_dealloc_bufs_mask_lo = DPAA_FQD_CTX_A2_EBD_BIT;
-	} else {
-		fman_dealloc_bufs_mask_hi = 0;
-		fman_dealloc_bufs_mask_lo = 0;
-	}
 	/* Is the MAC node 1G, 2.5G, 10G or offline? */
 	__if->__if.is_memac = 0;
 
-	if (is_offline)
+	if (is_offline) {
 		__if->__if.mac_type = fman_offline_internal;
-	else if (of_device_is_compatible(mac_node, "fsl,fman-1g-mac"))
-		__if->__if.mac_type = fman_mac_1g;
-	else if (of_device_is_compatible(mac_node, "fsl,fman-10g-mac"))
-		__if->__if.mac_type = fman_mac_10g;
-	else if (of_device_is_compatible(mac_node, "fsl,fman-memac")) {
+	} else if (of_device_is_compatible(mac_node, "fsl,fman-memac")) {
 		__if->__if.is_memac = 1;
 		char_prop = of_get_property(mac_node, "phy-connection-type",
 					    NULL);
@@ -490,7 +513,7 @@ fman_if_init(const struct device_node *dpa_node)
 				__if->__if.mac_type = fman_mac_10g;
 		}
 	} else {
-		FMAN_ERR(-EINVAL, "%s: unknown MAC type", mname);
+		FMAN_ERR(-ENOTSUP, "%s: Unsupported MAC type", mname);
 		goto err;
 	}
 
@@ -574,9 +597,9 @@ fman_if_init(const struct device_node *dpa_node)
 			 mname, regs_addr);
 		goto err;
 	}
+
 	__if->bmi_map = mmap(NULL, __if->regs_size,
-				 PROT_READ | PROT_WRITE, MAP_SHARED,
-				 fman_ccsr_map_fd, phys_addr);
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
 	if (__if->bmi_map == MAP_FAILED) {
 		FMAN_ERR(-errno, "mmap(0x%"PRIx64")", phys_addr);
 		goto err;
@@ -597,28 +620,13 @@ fman_if_init(const struct device_node *dpa_node)
 		}
 
 		__if->tx_bmi_map = mmap(NULL, __if->regs_size,
-					PROT_READ | PROT_WRITE, MAP_SHARED,
-					fman_ccsr_map_fd, phys_addr);
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
 		if (__if->tx_bmi_map == MAP_FAILED) {
 			FMAN_ERR(-errno, "mmap(0x%"PRIx64")", phys_addr);
 			goto err;
 		}
 	}
 
-	if (!rtc_map) {
-		__if->rtc_map = mmap(NULL, FMAN_IEEE_1588_SIZE,
-				PROT_READ | PROT_WRITE, MAP_SHARED,
-				fman_ccsr_map_fd, FMAN_IEEE_1588_OFFSET);
-		if (__if->rtc_map == MAP_FAILED) {
-			pr_err("Can not map FMan RTC regs base\n");
-			_errno = -EINVAL;
-			goto err;
-		}
-		rtc_map = __if->rtc_map;
-	} else {
-		__if->rtc_map = rtc_map;
-	}
-
 	/* Extract the Rx FQIDs. (Note, the device representation is silly,
 	 * there are "counts" that must always be 1.)
 	 */
@@ -788,7 +796,7 @@ fman_if_init(const struct device_node *dpa_node)
 	/* Parsing of the network interface is complete, add it to the list */
 	DPAA_BUS_LOG(DEBUG, "Found %s, Tx Channel = %x, FMAN = %x,"
 		    "Port ID = %x",
-		    dname, __if->__if.tx_channel_id, __if->__if.fman_idx,
+		    dname, __if->__if.tx_channel_id, __if->__if.fman->idx,
 		    __if->__if.mac_idx);
 
 	/* Don't add OH port to the port list since they will be used by ONIC
@@ -823,6 +831,8 @@ static int fman_if_init_onic(const struct device_node *dpa_node)
 	uint32_t na = OF_DEFAULT_NA;
 	uint64_t rx_phandle_host[4] = {0};
 	uint64_t cell_idx_host = 0;
+	struct __fman *fman, *tmp_fman;
+	int find_fman = false;
 
 	if (of_device_is_available(dpa_node) == false)
 		return 0;
@@ -950,15 +960,18 @@ static int fman_if_init_onic(const struct device_node *dpa_node)
 	__if->__if.mac_idx = cell_idx_host;
 
 	fman_node = of_get_parent(fman_tx_oh_node);
-	cell_idx = of_get_property(fman_node, "cell-index", &lenp);
-	if (!cell_idx) {
-		FMAN_ERR(-ENXIO, "%s: no cell-index)", tx_oh_node->full_name);
+	list_for_each_entry_safe(fman, tmp_fman, &__fmans, node) {
+		if (fman_node == fman->fman_node) {
+			find_fman = true;
+			break;
+		}
+	}
+	if (!find_fman) {
+		FMAN_ERR(-ENXIO, "Failed to get parent of %s",
+			fman_tx_oh_node->full_name);
 		goto err;
 	}
-	assert(lenp == sizeof(*cell_idx));
-
-	cell_idx_host = of_read_number(cell_idx, lenp / sizeof(phandle));
-	__if->__if.fman_idx = cell_idx_host;
+	__if->__if.fman = fman;
 
 	rx_phandle = of_get_property(tx_oh_node, "fsl,qman-frame-queues-oh",
 				     &lenp);
@@ -1075,7 +1088,7 @@ static int fman_if_init_onic(const struct device_node *dpa_node)
 	/* Parsing of the network interface is complete, add it to the list. */
 	DPAA_BUS_DEBUG("Found %s, Tx Channel = %x, FMAN = %x, Port ID = %x",
 		       dpa_node->full_name, __if->__if.tx_channel_id,
-		       __if->__if.fman_idx, __if->__if.mac_idx);
+		       __if->__if.fman->idx, __if->__if.mac_idx);
 
 	list_add_tail(&__if->__if.node, &__ifs);
 	return 0;
@@ -1087,20 +1100,18 @@ static int fman_if_init_onic(const struct device_node *dpa_node)
 int
 fman_init(void)
 {
-	const struct device_node *dpa_node, *parent_node;
-	int _errno;
+	const struct device_node *dpa_node, *parent_node, *fman_node;
+	int _errno, fd, ret;
 
-	/* If multiple dependencies try to initialise the Fman driver, don't
-	 * panic.
-	 */
-	if (fman_ccsr_map_fd != -1)
+	if (fman_ccsr_map_fd >= 0)
 		return 0;
 
-	fman_ccsr_map_fd = open(FMAN_DEVICE_PATH, O_RDWR);
-	if (unlikely(fman_ccsr_map_fd < 0)) {
-		DPAA_BUS_LOG(ERR, "Unable to open (/dev/mem)");
-		return fman_ccsr_map_fd;
+	fd = open(FMAN_DEVICE_PATH, O_RDWR);
+	if (unlikely(fd < 0)) {
+		DPAA_BUS_LOG(ERR, "Unable to open (%s)", FMAN_DEVICE_PATH);
+		return fd;
 	}
+	fman_ccsr_map_fd = fd;
 
 	parent_node = of_find_compatible_node(NULL, NULL, "fsl,dpaa");
 	if (!parent_node) {
@@ -1108,11 +1119,17 @@ fman_init(void)
 		return -ENODEV;
 	}
 
+	for_each_compatible_node(fman_node, NULL, "fsl,fman") {
+		ret = _fman_init(fman_node, fd);
+		if (ret)
+			return ret;
+	}
+
 	for_each_child_node(parent_node, dpa_node) {
-		_errno = fman_if_init(dpa_node);
+		_errno = fman_if_init(dpa_node, fd);
 		if (_errno) {
 			FMAN_ERR(_errno, "if_init(%s)", dpa_node->full_name);
-			goto err;
+			return _errno;
 		}
 	}
 
@@ -1124,33 +1141,36 @@ fman_init(void)
 	}
 
 	return 0;
-err:
-	fman_finish();
-	return _errno;
 }
 
 void
 fman_finish(void)
 {
 	struct __fman_if *__if, *tmpif;
+	struct __fman *fman, *tmpfman;
+	int _errno;
+	struct memac_regs *regs;
+	uint32_t cfg;
 
 	assert(fman_ccsr_map_fd != -1);
 
 	list_for_each_entry_safe(__if, tmpif, &__ifs, __if.node) {
-		int _errno;
-
 		/* No need to disable Offline port */
 		if (__if->__if.mac_type == fman_offline_internal)
 			continue;
 
+		if (!__if->__if.is_memac) {
+			DPAA_BUS_ERR("FM%d-MAC%d's MAC is not memac!",
+				__if->__if.fman->idx, __if->__if.mac_idx);
+			continue;
+		}
+
 		/* disable Rx and Tx */
-		if ((__if->__if.mac_type == fman_mac_1g) &&
-		    (!__if->__if.is_memac))
-			out_be32(__if->ccsr_map + 0x100,
-				 in_be32(__if->ccsr_map + 0x100) & ~(u32)0x5);
-		else
-			out_be32(__if->ccsr_map + 8,
-				 in_be32(__if->ccsr_map + 8) & ~(u32)3);
+		regs = __if->ccsr_map;
+		cfg = in_be32(&regs->command_config);
+		out_be32(&regs->command_config,
+			cfg & (~(MEMAC_RX_ENABLE | MEMAC_TX_ENABLE)));
+
 		/* release the mapping */
 		_errno = munmap(__if->ccsr_map, __if->regs_size);
 		if (unlikely(_errno < 0))
@@ -1160,6 +1180,18 @@ fman_finish(void)
 		rte_free(__if);
 	}
 
+	list_for_each_entry_safe(fman, tmpfman, &__fmans, node) {
+		/* release the mapping */
+		_errno = munmap(fman->ccsr_vir, fman->ccsr_size);
+		if (unlikely(_errno < 0))
+			FMAN_ERR(_errno, "munmap() = (%s)", strerror(errno));
+		_errno = munmap(fman->time_vir, fman->time_size);
+		if (unlikely(_errno < 0))
+			FMAN_ERR(_errno, "munmap() = (%s)", strerror(errno));
+		list_del(&fman->node);
+		rte_free(fman);
+	}
+
 	close(fman_ccsr_map_fd);
 	fman_ccsr_map_fd = -1;
 }
diff --git a/drivers/bus/dpaa/base/fman/netcfg_layer.c b/drivers/bus/dpaa/base/fman/netcfg_layer.c
index ffb37825c2..4cc9cb815c 100644
--- a/drivers/bus/dpaa/base/fman/netcfg_layer.c
+++ b/drivers/bus/dpaa/base/fman/netcfg_layer.c
@@ -43,10 +43,10 @@ dump_netcfg(struct netcfg_info *cfg_ptr, FILE *f)
 		struct fman_if *__if = p_cfg->fman_if;
 
 		fprintf(f, "\n+ Fman %d, MAC %d (%s);\n",
-		       __if->fman_idx, __if->mac_idx,
-		       (__if->mac_type == fman_offline_internal) ? "OFFLINE" :
-		       (__if->mac_type == fman_mac_1g) ? "1G" :
-		       (__if->mac_type == fman_mac_2_5g) ? "2.5G" : "10G");
+			__if->fman->idx, __if->mac_idx,
+			(__if->mac_type == fman_offline_internal) ? "OFFLINE" :
+			(__if->mac_type == fman_mac_1g) ? "1G" :
+			(__if->mac_type == fman_mac_2_5g) ? "2.5G" : "10G");
 
 		fprintf(f, "\tmac_addr: " RTE_ETHER_ADDR_PRT_FMT "\n",
 		       RTE_ETHER_ADDR_BYTES(&__if->mac_addr));
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index f5ce4a2761..ed1f77bab7 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -55,7 +55,7 @@ struct rte_dpaa_bus {
 };
 
 static struct rte_dpaa_bus s_rte_dpaa_bus;
-struct netcfg_info *dpaa_netcfg;
+static struct netcfg_info *dpaa_netcfg;
 
 /* define a variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa_portal_key;
@@ -204,22 +204,23 @@ dpaa_create_device_list(void)
 		fman_intf = cfg->fman_if;
 
 		/* Device identifiers */
-		dev->id.fman_id = fman_intf->fman_idx + 1;
+		dev->id.fman_id = fman_intf->fman->idx + 1;
 		dev->id.mac_id = fman_intf->mac_idx;
 		dev->device_type = FSL_DPAA_ETH;
 		dev->id.dev_id = i;
 
 		/* Create device name */
 		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
-		if (fman_intf->mac_type == fman_offline_internal)
+		if (fman_intf->mac_type == fman_offline_internal) {
 			sprintf(dev->name, "fm%d-oh%d",
-				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
-		else if (fman_intf->mac_type == fman_onic)
+				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
+		} else if (fman_intf->mac_type == fman_onic) {
 			sprintf(dev->name, "fm%d-onic%d",
-				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
-		else
+				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
+		} else {
 			sprintf(dev->name, "fm%d-mac%d",
-				(fman_intf->fman_idx + 1), fman_intf->mac_idx);
+				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
+		}
 		dev->device.name = dev->name;
 		dev->device.devargs = dpaa_devargs_lookup(dev);
 
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index 134f0dc8ff..4d4a7c1756 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -2,7 +2,7 @@
  *
  * Copyright 2010-2012 Freescale Semiconductor, Inc.
  * All rights reserved.
- * Copyright 2019-2023 NXP
+ * Copyright 2019-2024 NXP
  *
  */
 
@@ -67,14 +67,6 @@
 #define FMAN_RTC_MAX_NUM_OF_ALARMS		3
 #define FMAN_RTC_MAX_NUM_OF_PERIODIC_PULSES	4
 #define FMAN_RTC_MAX_NUM_OF_EXT_TRIGGERS	3
-#define FMAN_IEEE_1588_OFFSET			0X1AFE000
-#define FMAN_IEEE_1588_SIZE			4096
-
-/* Pre definitions of FMAN interface and Bpool structures */
-struct __fman_if;
-struct fman_if_bpool;
-/* Lists of fman interfaces and bpools */
-TAILQ_HEAD(rte_fman_if_list, __fman_if);
 
 /* Represents the different flavour of network interface */
 enum fman_mac_type {
@@ -90,6 +82,8 @@ struct mac_addr {
 	uint32_t   mac_addr_u;	/**< Upper 16 bits of 48-bit MAC address */
 };
 
+#define MEMAC_RX_ENABLE ((uint32_t)0x2)
+#define MEMAC_TX_ENABLE ((uint32_t)0x1)
 struct memac_regs {
 	/* General Control and Status */
 	uint32_t res0000[2];
@@ -381,7 +375,7 @@ struct onic_port_cfg {
  */
 struct fman_if {
 	/* Which Fman this interface belongs to */
-	uint8_t fman_idx;
+	struct __fman *fman;
 	/* The type/speed of the interface */
 	enum fman_mac_type mac_type;
 	/* Boolean, set when mac type is memac */
@@ -441,6 +435,24 @@ struct fman_if_ic_params {
 	uint16_t icsz;
 };
 
+#define FMAN_ADDRESS_NUM 2
+struct __fman {
+	const struct device_node *fman_node;
+	uint64_t ccsr_phy;
+	uint64_t ccsr_size;
+	void *ccsr_vir;
+
+	uint64_t time_phy;
+	uint64_t time_size;
+	void *time_vir;
+
+	uint8_t idx;
+	uint32_t ip_rev;
+	uint32_t dealloc_bufs_mask_hi;
+	uint32_t dealloc_bufs_mask_lo;
+	struct list_head node;
+};
+
 /* The exported "struct fman_if" type contains the subset of fields we want
  * exposed. This struct is embedded in a larger "struct __fman_if" which
  * contains the extra bits we *don't* want exposed.
@@ -453,9 +465,7 @@ struct __fman_if {
 	void *ccsr_map;
 	void *bmi_map;
 	void *tx_bmi_map;
-	void *rtc_map;
 	void *qmi_map;
-	struct list_head node;
 };
 
 /* And this is the base list node that the interfaces are added to. (See
@@ -484,7 +494,7 @@ extern int fman_ccsr_map_fd;
 	} while (0)
 
 #define FMAN_IP_REV_1	0xC30C4
-#define FMAN_IP_REV_1_MAJOR_MASK 0x0000FF00
+#define FMAN_IP_REV_1_MAJOR_MASK 0xff
 #define FMAN_IP_REV_1_MAJOR_SHIFT 8
 #define FMAN_V3	0x06
 
@@ -511,10 +521,6 @@ extern int fman_ccsr_map_fd;
 #define DPAA_FQD_CTX_A2_RESERVED_BIT	(0x02 << DPAA_FQD_CTX_A_SHIFT_BITS)
 #define DPAA_FQD_CTX_A2_VSPE_BIT	(0x01 << DPAA_FQD_CTX_A_SHIFT_BITS)
 
-extern u16 fman_ip_rev;
-extern u32 fman_dealloc_bufs_mask_hi;
-extern u32 fman_dealloc_bufs_mask_lo;
-
 /**
  * Initialize the FMAN driver
  *
diff --git a/drivers/bus/dpaa/include/netcfg.h b/drivers/bus/dpaa/include/netcfg.h
index ebbbaf6d10..4a902670fc 100644
--- a/drivers/bus/dpaa/include/netcfg.h
+++ b/drivers/bus/dpaa/include/netcfg.h
@@ -29,20 +29,6 @@ struct netcfg_info {
 	/**< Variable structure array of size num_ethports */
 };
 
-struct interface_info {
-	char *name;
-	struct rte_ether_addr mac_addr;
-	struct rte_ether_addr peer_mac;
-	int mac_present;
-	int fman_enabled_mac_interface;
-};
-
-struct netcfg_interface {
-	uint8_t numof_netcfg_interface;
-	uint8_t numof_fman_enabled_macless;
-	struct interface_info interface_info[];
-};
-
 /* pcd_file: FMC netpcd XML ("policy") file, that contains PCD information.
  * cfg_file: FMC config XML file
  * Returns the configuration information in newly allocated memory.
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 00b57cb715..66d62485af 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -593,10 +593,11 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 }
 
 static int
-dpaa_fw_version_get(struct rte_eth_dev *dev __rte_unused,
+dpaa_fw_version_get(struct rte_eth_dev *dev,
 		     char *fw_version,
 		     size_t fw_size)
 {
+	struct fman_if *fif = dev->process_private;
 	int ret;
 	FILE *svr_file = NULL;
 	unsigned int svr_ver = 0;
@@ -616,7 +617,7 @@ dpaa_fw_version_get(struct rte_eth_dev *dev __rte_unused,
 	fclose(svr_file);
 
 	ret = snprintf(fw_version, fw_size, "SVR:%x-fman-v%x",
-		       svr_ver, fman_ip_rev);
+		       svr_ver, fif->fman->ip_rev);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -1954,15 +1955,18 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 	opts.fqd.context_b = 0;
 	if (dpaa_ieee_1588) {
 		opts.fqd.context_a.lo = 0;
-		opts.fqd.context_a.hi = fman_dealloc_bufs_mask_hi;
+		opts.fqd.context_a.hi =
+			fman_intf->fman->dealloc_bufs_mask_hi;
 	} else {
 		/* no tx-confirmation */
-		opts.fqd.context_a.lo = fman_dealloc_bufs_mask_lo;
-		opts.fqd.context_a.hi = DPAA_FQD_CTX_A_OVERRIDE_FQ |
-					fman_dealloc_bufs_mask_hi;
+		opts.fqd.context_a.lo =
+			fman_intf->fman->dealloc_bufs_mask_lo;
+		opts.fqd.context_a.hi =
+			DPAA_FQD_CTX_A_OVERRIDE_FQ |
+			fman_intf->fman->dealloc_bufs_mask_hi;
 	}
 
-	if (fman_ip_rev >= FMAN_V3)
+	if (fman_intf->fman->ip_rev >= FMAN_V3)
 		/* Set B0V bit in contextA to set ASPID to 0 */
 		opts.fqd.context_a.hi |= DPAA_FQD_CTX_A_B0_FIELD_VALID;
 
diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index 48e29e22eb..8482666745 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -33,15 +33,13 @@ dpaa_timesync_read_time(struct rte_eth_dev *dev,
 					struct timespec *timestamp)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
-	struct __fman_if *__fif;
 	struct fman_if *fif;
 	uint64_t time;
 
 	fif = dev->process_private;
-	__fif = container_of(fif, struct __fman_if, __if);
 
-	tmr_cnt_h = &((struct rtc_regs *)__fif->rtc_map)->tmr_cnt_h;
-	tmr_cnt_l = &((struct rtc_regs *)__fif->rtc_map)->tmr_cnt_l;
+	tmr_cnt_h = &((struct rtc_regs *)fif->fman->time_vir)->tmr_cnt_h;
+	tmr_cnt_l = &((struct rtc_regs *)fif->fman->time_vir)->tmr_cnt_l;
 
 	time = (uint64_t)in_be32(tmr_cnt_l);
 	time |= ((uint64_t)in_be32(tmr_cnt_h) << 32);
@@ -55,15 +53,13 @@ dpaa_timesync_write_time(struct rte_eth_dev *dev,
 					const struct timespec *ts)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
-	struct __fman_if *__fif;
 	struct fman_if *fif;
 	uint64_t time;
 
 	fif = dev->process_private;
-	__fif = container_of(fif, struct __fman_if, __if);
 
-	tmr_cnt_h = &((struct rtc_regs *)__fif->rtc_map)->tmr_cnt_h;
-	tmr_cnt_l = &((struct rtc_regs *)__fif->rtc_map)->tmr_cnt_l;
+	tmr_cnt_h = &((struct rtc_regs *)fif->fman->time_vir)->tmr_cnt_h;
+	tmr_cnt_l = &((struct rtc_regs *)fif->fman->time_vir)->tmr_cnt_l;
 
 	time = rte_timespec_to_ns(ts);
 
-- 
2.25.1

