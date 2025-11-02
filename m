Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA4CCFA00
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 22:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 890F240270;
	Sun,  2 Nov 2025 23:15:29 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id D421C4021E
 for <dev@dpdk.org>; Sun,  2 Nov 2025 23:15:27 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 4B2E8EC02C5;
 Sun,  2 Nov 2025 17:15:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 17:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1762121727; x=1762208127; bh=k81/G21S2jQhi9FbqB1Ro
 XqLdy1oyeYlAMtyuMWbnEU=; b=G4Ub30LGzyWY8PaMiaMHxRb/PXl/uplgzBkeT
 X2iy7P5x/TdVQY1eKvi/krRfA+1gxzkH/TOL8nx/U+7I6bJDyLHWWqLQy99f2hfQ
 DwmAtVuggTPm4xcrDPG4HYSUa162YZS1Ml8BR+7NBIVNleBOysZbjfhTlIeE50NK
 0hU+Ays/hqbc7SNb/hZa1477Jp+WkQBtKH7u/2Oj0BGDw4wydbe3yvXp/4LFJeYL
 nEE1I2XVovN61I0Z+v9KUm0u1XtK4AxnkN/B2ImohbIBSuQ5BALLcN3YrUggajqG
 dmlagTfDMr5YZiN6hoD2ixrf0f7sRJU7HvInX7CNOq45fKj4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762121727; x=1762208127; bh=k81/G21S2jQhi9FbqB1RoXqLdy1oyeYlAMt
 yuMWbnEU=; b=0qAx4j5V1to1OChF6m1o41+HPstkcNwCag4mVfhlEaSRYC8lL+k
 NK730EPcymZEhbA2skoQp4ScZ4ktmQhpQa7AKiyqX/qyDlWN6RihYqi/edv543sS
 pnWKS8s3TvrT/gcExpbPiFs8abV78OZ557IdVo1ufyJVMfgpjp1/xvaM7X/u7nVV
 ArQpaR6+l7aPfiMhFJJ99rozfhVHdkaotKyoy+dDAXipzCitn8imbIzgSy1nX0iv
 dUdwM3B/TILtfHiyvQOIzSlfyUDsvsImmml3vf/M77lHq0TyjY3H8vINwX87GPY0
 8i6N2mpY5EzDccxgrZosEiAK6RnbNJmg+ww==
X-ME-Sender: <xms:_tcHaZiTnMMDABjR9ddMRNMOVKoKgi_DIFP5CBcTwxG_RCIs28VjXA>
 <xme:_tcHaauzD-QneVsJL-X7caYkJgY3Rs5pY4tTeosOlCf7EBRRhwl0d94x1EUGezGZs
 f-K_IE5dsTFw8kTB1hjbb6ipAQSTaKkUhIRUPMAkzLepQO1VfWcw9g>
X-ME-Received: <xmr:_tcHac8ErZuY9q604CNMSe__Q5mAYT6HTwpn1COReHy5QvjvyYpsJw31NesCN6Da_Yvf6M5nxamI7syE4eqG1PZURfPQCDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeigeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghmrghnrdguvggv
 phdrshhinhhghhesihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinh
 drrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepnhhitgholhgrshdr
 tghhrghuthhruhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrdhsihhnghhhsehngi
 hprdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhm
 pdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepphgrsg
 hlohdruggvrdhlrghrrgdrghhurghrtghhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:_tcHaYb5lkn92aJIxO0aD1LchwclNiunOsxdOF1MfnkKuOPHfR3WIg>
 <xmx:_tcHaarvdfwCaRnYVq1KTB1riximsGVbdtNcgDfc4Od8CxYvFbK4cQ>
 <xmx:_tcHad0OwgBPDKtmlNRFtC9wVBZqb16ZavbC1-ks5JMKBtT9Mis92Q>
 <xmx:_tcHaSlqISWWLd5ZiU53lo1mJYrOZDA7F3SFvjgfcAuPxSPvFD8qeg>
 <xmx:_9cHaZFX-E-TvcDpW61MmXS5G934VX8SY-Pp3C-i3DgTq_Z--LKi2eHr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 17:15:24 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Wenbo Cao <caowenbo@mucse.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH] fix after-code Doxygen comments
Date: Sun,  2 Nov 2025 23:14:00 +0100
Message-ID: <20251102221400.4018641-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

The comment syntax /*< is a mistake.
The intent was to put a Doxygen comment after some code with /**<
but an asterisk was missing.

In cases of .c files with all other comments not using Doxygen syntax,
it is converted into normal comment syntax.

In cases the comment is completely useless, it is just removed.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/cmdline_flow.c                          |  4 ++--
 doc/guides/prog_guide/packet_classif_access_ctrl.rst | 12 ++++++------
 drivers/baseband/acc/rte_vrb_pmd.c                   |  4 ++--
 drivers/baseband/la12xx/bbdev_la12xx.c               |  4 ++--
 drivers/baseband/null/bbdev_null.c                   |  4 ++--
 drivers/baseband/turbo_sw/bbdev_turbo_software.c     |  6 +++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h          |  9 +++------
 drivers/crypto/qat/qat_asym.h                        |  4 ++--
 drivers/event/sw/sw_evdev.h                          |  2 +-
 drivers/net/bnxt/hcapi/cfa/hcapi_cfa_defs.h          |  6 +++---
 drivers/net/rnp/rnp_rxtx.h                           |  2 +-
 examples/fips_validation/fips_validation.h           |  2 +-
 lib/bpf/rte_bpf_ethdev.h                             |  2 +-
 lib/mldev/rte_mldev.c                                |  3 +--
 14 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 12a0f35c21..54b247899d 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -13675,8 +13675,8 @@ update_fields(uint8_t *buf, struct rte_flow_item *item, uint16_t next_proto)
 		if (next_proto && ipv6->proto == 0)
 			ipv6->proto = (uint8_t)next_proto;
 		ipv6_vtc_flow = rte_be_to_cpu_32(ipv6->vtc_flow);
-		ipv6_vtc_flow &= 0x0FFFFFFF; /*< reset version bits. */
-		ipv6_vtc_flow |= 0x60000000; /*< set ipv6 version. */
+		ipv6_vtc_flow &= 0x0FFFFFFF; /* reset version bits. */
+		ipv6_vtc_flow |= 0x60000000; /* set ipv6 version. */
 		ipv6->vtc_flow = rte_cpu_to_be_32(ipv6_vtc_flow);
 		break;
 	case RTE_FLOW_ITEM_TYPE_VXLAN:
diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index e2cd60fb47..172f443f6e 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -41,11 +41,11 @@ To define each field inside an AC rule, the following structure is used:
 .. code-block:: c
 
     struct rte_acl_field_def {
-        uint8_t type;         /*< type - ACL_FIELD_TYPE. */
-        uint8_t size;         /*< size of field 1,2,4, or 8. */
-        uint8_t field_index;  /*< index of field inside the rule. */
-        uint8_t input_index;  /*< 0-N input index. */
-        uint32_t offset;      /*< offset to start of field. */
+        uint8_t type;         /**< type - ACL_FIELD_TYPE. */
+        uint8_t size;         /**< size of field 1,2,4, or 8. */
+        uint8_t field_index;  /**< index of field inside the rule. */
+        uint8_t input_index;  /**< 0-N input index. */
+        uint32_t offset;      /**< offset to start of field. */
     };
 
 *   type
@@ -229,7 +229,7 @@ The structure for the classification is:
         uint8_t ip_proto;
         uint32_t ip_src;
         uint32_t ip_dst;
-        uint8_t tos;      /*< This is partially using a 32-bit input element */
+        uint8_t tos;    /**< This is partially using a 32-bit input element */
     };
 
 The following array of field definitions can be used:
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 2c10ef2c94..c5161e6502 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -222,7 +222,7 @@ vrb_device_fft_win(struct rte_bbdev *dev)
 			vrb_vf2pf(d, ACC_VF2PF_FFT_WIN_REQUEST | win);
 			reg = acc_reg_read(d, d->reg_addr->pf2vf_doorbell);
 			while ((time_out < ACC_STATUS_TO) && (reg == RTE_BBDEV_DEV_NOSTATUS)) {
-				usleep(ACC_STATUS_WAIT); /*< Wait or VF->PF->VF Comms. */
+				usleep(ACC_STATUS_WAIT); /* Wait or VF->PF->VF Comms. */
 				reg = acc_reg_read(d, d->reg_addr->pf2vf_doorbell);
 				time_out++;
 			}
@@ -386,7 +386,7 @@ vrb_device_status(struct rte_bbdev *dev)
 	vrb_vf2pf(d, ACC_VF2PF_STATUS_REQUEST);
 	reg = acc_reg_read(d, d->reg_addr->pf2vf_doorbell);
 	while ((time_out < ACC_STATUS_TO) && (reg == RTE_BBDEV_DEV_NOSTATUS)) {
-		usleep(ACC_STATUS_WAIT); /*< Wait or VF->PF->VF Comms */
+		usleep(ACC_STATUS_WAIT); /* Wait or VF->PF->VF Comms */
 		reg = acc_reg_read(d, d->reg_addr->pf2vf_doorbell);
 		time_out++;
 	}
diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 8928cdd89e..1116dacc4b 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -27,8 +27,8 @@
 
 /*  Initialisation params structure that can be used by LA12xx BBDEV driver */
 struct bbdev_la12xx_params {
-	uint8_t queues_num; /*< LA12xx BBDEV queues number */
-	int8_t modem_id; /*< LA12xx modem instance id */
+	uint8_t queues_num;
+	int8_t modem_id;
 };
 
 #define LA12XX_MAX_NB_QUEUES_ARG	"max_nb_queues"
diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index dab416aa41..cfa1790126 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -29,8 +29,8 @@ RTE_LOG_REGISTER_DEFAULT(bbdev_null_logtype, NOTICE);
 
 /*  Initialisation params structure that can be used by null BBDEV driver */
 struct bbdev_null_params {
-	int socket_id;  /*< Null BBDEV socket */
-	uint16_t queues_num;  /*< Null BBDEV queues number */
+	int socket_id;
+	uint16_t queues_num;
 };
 
 /* Acceptable params for null BBDEV devices */
diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index e527008524..2cab495294 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -53,13 +53,13 @@ RTE_LOG_REGISTER_DEFAULT(bbdev_turbo_sw_logtype, NOTICE);
 
 /* private data structure */
 struct bbdev_private {
-	unsigned int max_nb_queues;  /**< Max number of queues */
+	unsigned int max_nb_queues;
 };
 
 /*  Initialisation params structure that can be used by Turbo SW driver */
 struct turbo_sw_params {
-	int socket_id;  /*< Turbo SW device socket */
-	uint16_t queues_num;  /*< Turbo SW device queues number */
+	int socket_id;
+	uint16_t queues_num;
 };
 
 /* Acceptable params for Turbo SW devices */
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
index 66e8e732ff..6dc90a9849 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
@@ -987,12 +987,9 @@ get_digest_byte_length(IMB_HASH_ALG algo)
 
 /** AES-NI multi-buffer private session structure */
 struct __rte_cache_aligned aesni_mb_session {
-	IMB_JOB template_job;
-	/*< Template job structure */
-	uint32_t session_id;
-	/*< IPSec MB session ID */
-	pid_t pid;
-	/*< Process ID that created session */
+	IMB_JOB template_job; /* Template job structure */
+	uint32_t session_id; /* IPSec MB session ID */
+	pid_t pid; /* Process ID that created session */
 	struct {
 		uint16_t offset;
 	} iv;
diff --git a/drivers/crypto/qat/qat_asym.h b/drivers/crypto/qat/qat_asym.h
index 00275fa3b9..0ecbc47548 100644
--- a/drivers/crypto/qat/qat_asym.h
+++ b/drivers/crypto/qat/qat_asym.h
@@ -58,8 +58,8 @@ typedef uint64_t large_int_ptr;
 
 struct __rte_aligned(8) qat_asym_op_cookie {
 	uint64_t error;
-	uint32_t alg_bytesize; /*< Bytesize of algorithm */
-	uint32_t qat_func_alignsize; /*< Aligned bytesize of qat function */
+	uint32_t alg_bytesize; /* Bytesize of algorithm */
+	uint32_t qat_func_alignsize; /* Aligned bytesize of qat function */
 	rte_iova_t input_addr;
 	rte_iova_t output_addr;
 	alignas(8) large_int_ptr input_params_ptrs[MAX_PKE_PARAMS];
diff --git a/drivers/event/sw/sw_evdev.h b/drivers/event/sw/sw_evdev.h
index f617c7d966..c159be21be 100644
--- a/drivers/event/sw/sw_evdev.h
+++ b/drivers/event/sw/sw_evdev.h
@@ -127,7 +127,7 @@ struct sw_qid {
 	struct sw_fid_t fids[SW_QID_NUM_FIDS];
 
 	/* Track packet order for reordering when needed */
-	struct reorder_buffer_entry *reorder_buffer; /*< pkts await reorder */
+	struct reorder_buffer_entry *reorder_buffer; /* pkts await reorder */
 	struct rob_ring *reorder_buffer_freelist; /* available reorder slots */
 	uint32_t reorder_buffer_index; /* oldest valid reorder buffer entry */
 	uint32_t window_size;          /* Used to wrap reorder_buffer_index */
diff --git a/drivers/net/bnxt/hcapi/cfa/hcapi_cfa_defs.h b/drivers/net/bnxt/hcapi/cfa/hcapi_cfa_defs.h
index 7d19bf3847..20690ab784 100644
--- a/drivers/net/bnxt/hcapi/cfa/hcapi_cfa_defs.h
+++ b/drivers/net/bnxt/hcapi/cfa/hcapi_cfa_defs.h
@@ -74,7 +74,7 @@ enum hcapi_cfa_dir {
 enum hcapi_cfa_hwops {
 	HCAPI_CFA_HWOPS_PUT,   /**< Write to HW operation */
 	HCAPI_CFA_HWOPS_GET,   /**< Read from HW operation */
-	HCAPI_CFA_HWOPS_ADD,   /*<
+	HCAPI_CFA_HWOPS_ADD,   /**<
 				* For operations which require more then
 				* simple writes to HW, this operation is
 				* used.  The distinction with this operation
@@ -83,12 +83,12 @@ enum hcapi_cfa_hwops {
 				* the HCAPI_CFA_HWOPS_DEL op to remove
 				* the operations issued by the ADD OP.
 				*/
-	HCAPI_CFA_HWOPS_DEL,   /*<
+	HCAPI_CFA_HWOPS_DEL,   /**<
 				*  Beside to delete from the hardware, this
 				*   operation is also undo the add operation
 				*   performed by the HCAPI_CFA_HWOPS_ADD op.
 				*/
-	HCAPI_CFA_HWOPS_EVICT, /*< This operation is used to edit entries from
+	HCAPI_CFA_HWOPS_EVICT, /**< This operation is used to edit entries from
 				*   CFA cache memories. This operation is only
 				*   applicable to tables that use CFA caches.
 				*/
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index dd72ac7d3f..1309a49a3e 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -118,7 +118,7 @@ struct rnp_tx_queue {
 	uint16_t tx_next_rs; /* index of next time to set rs bit*/
 	uint16_t tx_free_thresh; /* thresh to free tx desc resource */
 
-	uint8_t tx_deferred_start; /*< Do not start queue with dev_start(). */
+	uint8_t tx_deferred_start; /* do not start queue with dev_start() */
 	uint8_t txq_started; /* tx queue is started */
 	uint8_t tx_link; /* device link state */
 	uint8_t pthresh; /* rx desc prefetch threshold */
diff --git a/examples/fips_validation/fips_validation.h b/examples/fips_validation/fips_validation.h
index 795cf834e8..881c759033 100644
--- a/examples/fips_validation/fips_validation.h
+++ b/examples/fips_validation/fips_validation.h
@@ -14,7 +14,7 @@
 
 #define ERR_MSG_SIZE		128
 #define MAX_CASE_LINE		15
-#define MAX_LINE_CHAR		204800 /*< max number of characters per line */
+#define MAX_LINE_CHAR		204800 /* max number of characters per line */
 #define MAX_NB_TESTS		10240
 #define DEF_MBUF_SEG_SIZE	(UINT16_MAX - sizeof(struct rte_mbuf) - \
 				RTE_PKTMBUF_HEADROOM)
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index 1cca2e6c95..cab8e9e388 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -32,7 +32,7 @@ extern "C" {
 
 enum {
 	RTE_BPF_ETH_F_NONE = 0,
-	RTE_BPF_ETH_F_JIT  = 0x1, /*< use compiled into native ISA code */
+	RTE_BPF_ETH_F_JIT  = 0x1, /**< use compiled into native ISA code */
 };
 
 /**
diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index b61e4be45c..f5061f015c 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -20,8 +20,7 @@ static struct rte_ml_dev_global ml_dev_globals = {
  * appended after the mempool structure (in private data).
  */
 struct rte_ml_op_pool_private {
-	uint16_t user_size;
-	/*< Size of private user data with each operation. */
+	uint16_t user_size; /* Size of private user data with each operation. */
 };
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_ml_dev_pmd_get_dev)
-- 
2.51.0

