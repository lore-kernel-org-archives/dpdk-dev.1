Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5609C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE53142FE9;
	Thu, 17 Sep 2026 19:21:32 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id F042F42FBB
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:29 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469f20513so1005732b3a.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665689;
 x=1790270489; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s5TcboQ2FgfBrNYpbAcAjRyddY1ZRzuqP9lv6CEYaJk=;
 b=lYD+aLRxn1avWG4xJeMnEKTRsZU6z4KPgdp0TPj+CEp4nWydzkL0TptsnQHyoi9inJ
 LmYjcuDOyD+skiFPCEeKGiRS47Aaj8z64oBaOpC2oFfZe4zsDGeb8I4CNU7cIA/acBhQ
 QxqQiaW6NHZUNWGvpOwfPUEvdzrACIzjL9i6I0i01+lHjBJCv9YXNfVjZTb2XLzC7ygo
 OJb4XEsNB3FVsmwYGSUeFNxBT9tIgcZnarfmVUiBWN0YtMV95NDw7iqqa+3vVbX3RI7t
 xE2nXAwNmFaQHQi1XPyVwSZkY6BF/H31mPixYDyZVM5kXAsxzcoYX9BbinYj/vzAAOIC
 hbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665689; x=1790270489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s5TcboQ2FgfBrNYpbAcAjRyddY1ZRzuqP9lv6CEYaJk=;
 b=l0ArlYuVby+BG9/5j/OYJk8XVaZeo3eGtnJTEVk69lO8+kboj18rKCINIiBYBs/pqZ
 MtnjkUpastbRh/UPfNra25AWft3HG+yxdGnVebwALoTW7IeMnVJww8bvUpnm6jOEt0a5
 Ew+q0uWxeC8zC4Zf3qM31u9nqgNaC75bTiKDP644mvnlEeOqtH8ZF/Ome05t9BJkVNyR
 WjWYX/UFg2Qj/8Ic0kf81J4L0rtpL33kYvSvSa90TKlhAxjjLm1gmdSUX4ARX5JfT2F7
 9ts9N3YCNCXbPp/NTa8AThvXg5DLAJyzAhbBcZRJ75YkrWDDRlnLejWisXdW2UHKRgp9
 p0eQ==
X-Gm-Message-State: AFuF++lquVVWvmq33nnKPda94IBKLLQu4EcqmPU2EHZegT+xbxbz7/7d
 deyKu5HOR0+cNfRAadBe5ocf/bS12OOQEgTsqvRElq5c/JxMAnq5vtj1k083vbj1xWG1eaI5sD6
 ZwCd2jH8=
X-Gm-Gg: AYBFou0LECeTKcKaoTYPjgfKFNMe4tyk/Sx0m7Y4Cd/SYfoLoKpBmsyVUh1sVtBuYkT
 SR+feILwqT0dyyIP44CVyymCNvI1xP3GG9/s3i+Goa583/Yf82V1LUA6xtq/O7A+aiu6TWT0xsY
 39r7KbLqo6xruHLFQJ9EZo/OLuQYnjYYevfMq5lhEuBYUv917zmrD4YkCv4jnuNdqubjKE8hcFI
 RlodqYEencvW+gTnC/lnMr1mDkrXXNoaoWUIerdsLJ2LCvn+xrn0hZ0hbpSLied97dEJQVzQDYk
 EPgXW5y3bazcmXSt3RhxeJYJKxAx83oZ54c65O4R4EIMHGAar163H8de9Sqnx7Yb3NtNlBheT0I
 dK9vMSNWf5EGSnT91HJpHfondYokGQ5gjMAsFBwKZ6FKKF3GVsnbVCVrIXdEabwnQ6dKGFkK0oG
 1YZO/CrrB3xsKjK1Jrd+tFtmp1ZJ3pZYgDjcrpKaYXQ9T9LvKPkQAHGim3UxxNV06mErS2FUcvU
 0HDf2FETiZvIAYVobyobpAr7vgsBmYfdOAuXw==
X-Received: by 2002:a05:6a00:4b08:b0:871:2152:980a with SMTP id
 d2e1a72fcca58-8723a8a91b4mr15275696b3a.25.1789665688422; 
 Thu, 17 Sep 2026 10:21:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Gaetan Rivet <grive@u256.net>, Praveen Shetty <praveen.shetty@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Martin Spinler <spinler@cesnet.cz>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Elena Agostini <eagostini@nvidia.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 5/6] eal: deprecate RTE_TAILQ and RTE_STAILQ macro wrappers
Date: Thu, 17 Sep 2026 10:19:43 -0700
Message-ID: <20260917172116.660120-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
References: <20260917172116.660120-1-stephen@networkplumber.org>
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

The RTE_TAILQ_HEAD, RTE_TAILQ_ENTRY, RTE_TAILQ_FOREACH, RTE_TAILQ_FIRST,
RTE_TAILQ_NEXT, RTE_TAILQ_FOREACH_SAFE, RTE_STAILQ_HEAD and
RTE_STAILQ_ENTRY were added to help the port to Windows.

Now that rte_queue.h provides the same macros on all platforms, they are
no longer necessary.  Keep them in rte_tailq.h as deprecated aliases and
add a deprecation notice for removal in 27.11.

The wrappers are defined in terms of the plain macros only, never the
extended ones, so that they keep working in a translation unit where a
system <sys/queue.h> was included first and rte_queue.h was therefore
suppressed.  That is why RTE_TAILQ_FOREACH_SAFE is open coded rather
than mapped to TAILQ_FOREACH_SAFE, which glibc does not have.

Document why rte_queue.h wins the include guard inside DPDK, and note it
in rte_os.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst         |  8 +++++
 doc/guides/rel_notes/release_26_11.rst       |  8 +++++
 drivers/bus/vdev/vdev.c                      |  2 +-
 drivers/common/cnxk/roc_platform.h           |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c           |  4 +--
 drivers/net/bonding/rte_eth_bond_flow.c      |  2 +-
 drivers/net/cnxk/cnxk_eswitch_flow.c         |  2 +-
 drivers/net/cnxk/cnxk_ethdev.c               |  6 ++--
 drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c |  8 ++---
 drivers/net/failsafe/failsafe_flow.c         |  2 +-
 drivers/net/intel/cpfl/cpfl_flow.c           |  8 ++---
 drivers/net/intel/i40e/i40e_ethdev.c         | 10 +++---
 drivers/net/intel/i40e/i40e_flow.c           |  6 ++--
 drivers/net/intel/i40e/i40e_hash.c           |  2 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c        |  6 ++--
 drivers/net/intel/iavf/iavf_generic_flow.c   | 16 ++++-----
 drivers/net/intel/ice/ice_ethdev.c           |  4 +--
 drivers/net/intel/ice/ice_generic_flow.c     |  8 ++---
 drivers/net/intel/ipn3ke/ipn3ke_flow.c       |  2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c         |  2 +-
 drivers/net/mlx5/mlx5_flow_dv.c              |  2 +-
 drivers/net/mlx5/mlx5_flow_meter.c           |  2 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c     |  4 +--
 drivers/net/nfb/nfb_ethdev.c                 |  2 +-
 drivers/net/sfc/sfc_flow.c                   |  4 +--
 drivers/net/softnic/rte_eth_softnic_swq.c    |  2 +-
 drivers/net/sxe2/sxe2_dump.c                 |  6 ++--
 drivers/net/sxe2/sxe2_filter.c               | 22 ++++++------
 drivers/net/sxe2/sxe2_vsi.c                  |  2 +-
 drivers/net/zxdh/zxdh_flow.c                 |  2 +-
 drivers/net/zxdh/zxdh_mtr.c                  |  6 ++--
 examples/vm_power_manager/channel_manager.c  |  8 ++---
 lib/bbdev/rte_bbdev.h                        |  2 +-
 lib/cryptodev/cryptodev_pmd.h                |  2 +-
 lib/cryptodev/rte_cryptodev.h                |  2 +-
 lib/eal/common/eal_common_devargs.c          |  4 +--
 lib/eal/common/eal_common_options.c          |  2 +-
 lib/eal/common/eal_common_proc.c             |  2 +-
 lib/eal/freebsd/include/rte_os.h             | 12 ++-----
 lib/eal/include/bus_driver.h                 |  8 ++---
 lib/eal/include/dev_driver.h                 |  4 +--
 lib/eal/include/rte_class.h                  |  4 +--
 lib/eal/include/rte_devargs.h                |  2 +-
 lib/eal/include/rte_queue.h                  |  5 +++
 lib/eal/include/rte_tailq.h                  | 35 ++++++++++++++++----
 lib/eal/linux/include/rte_os.h               | 12 ++-----
 lib/eal/windows/include/rte_os.h             | 31 +++--------------
 lib/efd/rte_efd.c                            |  2 +-
 lib/ethdev/rte_ethdev_core.h                 |  2 +-
 lib/eventdev/rte_event_vector_adapter.c      |  2 +-
 lib/gpudev/gpudev.c                          |  4 +--
 lib/gpudev/gpudev_driver.h                   |  2 +-
 lib/ip_frag/ip_reassembly.h                  |  4 +--
 lib/ip_frag/rte_ip_frag_common.c             |  2 +-
 lib/mempool/rte_mempool.c                    |  4 +--
 lib/mempool/rte_mempool.h                    |  8 ++---
 lib/pmu/pmu.c                                |  2 +-
 lib/power/power_cpufreq.h                    |  2 +-
 lib/power/power_uncore_ops.h                 |  2 +-
 lib/power/rte_power_cpufreq.c                |  8 ++---
 lib/power/rte_power_uncore.c                 |  6 ++--
 lib/table/rte_swx_table.h                    |  4 +--
 lib/table/rte_swx_table_selector.h           |  4 +--
 lib/vhost/iotlb.c                            | 14 ++++----
 lib/vhost/vdpa.c                             |  2 +-
 lib/vhost/vdpa_driver.h                      |  2 +-
 66 files changed, 191 insertions(+), 182 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..8a9c4f2992 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -177,3 +177,11 @@ Deprecation Notices
   after a VF reset, but this is of questionable value
   since most applications expect their settings to be preserved
   transparently across a reset.
+
+* eal: The ``RTE_TAILQ_HEAD``, ``RTE_TAILQ_ENTRY``, ``RTE_TAILQ_FOREACH``,
+  ``RTE_TAILQ_FIRST``, ``RTE_TAILQ_NEXT``, ``RTE_TAILQ_FOREACH_SAFE``,
+  ``RTE_STAILQ_HEAD`` and ``RTE_STAILQ_ENTRY`` macros in ``rte_tailq.h``
+  are deprecated and will be removed in DPDK 27.11.
+  They existed only because Windows had no ``<sys/queue.h>``.
+  Use the equivalent ``TAILQ_`` and ``STAILQ_`` macros from
+  ``<rte_queue.h>``, which are now available on all platforms.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0701fbee8d..892d55a7eb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -130,6 +130,14 @@ API Changes
   * ``rte_tel_data_add_dict_uint_hex``
   * ``rte_telemetry_register_cmd_arg``
 
+* eal: Deprecated the ``RTE_TAILQ_HEAD``, ``RTE_TAILQ_ENTRY``,
+  ``RTE_TAILQ_FOREACH``, ``RTE_TAILQ_FIRST``, ``RTE_TAILQ_NEXT``,
+  ``RTE_TAILQ_FOREACH_SAFE``, ``RTE_STAILQ_HEAD`` and ``RTE_STAILQ_ENTRY``
+  macros.
+  They existed only because Windows had no ``<sys/queue.h>``.
+  Use the standard ``TAILQ_`` and ``STAILQ_`` macros from ``rte_queue.h``.
+  The macros are kept as aliases and will be removed in DPDK 27.11.
+
 
 ABI Changes
 -----------
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 04702a7270..4f30a295d5 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -103,7 +103,7 @@ rte_vdev_remove_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 	struct vdev_custom_scan *custom_scan, *tmp_scan;
 
 	rte_spinlock_lock(&vdev_custom_scan_lock);
-	RTE_TAILQ_FOREACH_SAFE(custom_scan, &vdev_custom_scans, next,
+	TAILQ_FOREACH_SAFE(custom_scan, &vdev_custom_scans, next,
 				tmp_scan) {
 		if (custom_scan->callback != callback ||
 				(custom_scan->user_arg != (void *)-1 &&
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index 24f0c41cbf..5c9776ab61 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -66,7 +66,7 @@
 #define PLT_ALIGN_FLOOR		 RTE_ALIGN_FLOOR
 #define PLT_INIT		 RTE_INIT
 #define PLT_MAX_ETHPORTS	 RTE_MAX_ETHPORTS
-#define PLT_TAILQ_FOREACH_SAFE	 RTE_TAILQ_FOREACH_SAFE
+#define PLT_TAILQ_FOREACH_SAFE	 TAILQ_FOREACH_SAFE
 
 #ifndef PLT_ETHER_ADDR_LEN
 #define PLT_ETHER_ADDR_LEN RTE_ETHER_ADDR_LEN
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index a75da8aa19..1721f97a38 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -649,7 +649,7 @@ bnxt_ulp_cntxt_list_del(struct bnxt_ulp_context *ulp_ctx)
 	struct ulp_context_list_entry	*entry, *temp;
 
 	rte_spinlock_lock(&bnxt_ulp_ctxt_lock);
-	RTE_TAILQ_FOREACH_SAFE(entry, &ulp_cntx_list, next, temp) {
+	TAILQ_FOREACH_SAFE(entry, &ulp_cntx_list, next, temp) {
 		if (entry->ulp_ctx == ulp_ctx) {
 			TAILQ_REMOVE(&ulp_cntx_list, entry, next);
 			rte_free(entry);
@@ -666,7 +666,7 @@ bnxt_ulp_cntxt_list_count(void)
 	int count_1 = 0;
 
 	rte_spinlock_lock(&bnxt_ulp_ctxt_lock);
-	RTE_TAILQ_FOREACH_SAFE(entry, &ulp_cntx_list, next, temp) {
+	TAILQ_FOREACH_SAFE(entry, &ulp_cntx_list, next, temp) {
 		count_1++;
 	}
 	rte_spinlock_unlock(&bnxt_ulp_ctxt_lock);
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index b2a7d397c3..9e267078b0 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -157,7 +157,7 @@ bond_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *err)
 	/* Destroy all bond flows from its members instead of flushing them to
 	 * keep the LACP flow or any other external flows.
 	 */
-	RTE_TAILQ_FOREACH_SAFE(flow, &internals->flow_list, next, tmp) {
+	TAILQ_FOREACH_SAFE(flow, &internals->flow_list, next, tmp) {
 		lret = bond_flow_destroy(dev, flow, err);
 		if (unlikely(lret != 0))
 			ret = lret;
diff --git a/drivers/net/cnxk/cnxk_eswitch_flow.c b/drivers/net/cnxk/cnxk_eswitch_flow.c
index 06077bfe92..767b666e86 100644
--- a/drivers/net/cnxk/cnxk_eswitch_flow.c
+++ b/drivers/net/cnxk/cnxk_eswitch_flow.c
@@ -21,7 +21,7 @@ cnxk_eswitch_flow_rules_remove_list(struct cnxk_eswitch_dev *eswitch_dev, struct
 	struct roc_npc_flow *flow, *tvar;
 	int rc = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(flow, list, next, tvar) {
+	TAILQ_FOREACH_SAFE(flow, list, next, tvar) {
 		plt_esw_dbg("Removing flow %d", flow->mcam_id);
 		rc = roc_eswitch_npc_mcam_delete_rule(&eswitch_dev->npc, flow,
 						      hw_func);
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index c41959173b..5317d48fd2 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -464,7 +464,7 @@ nix_meter_fini(struct cnxk_eth_dev *dev)
 	uint32_t i;
 	int rc = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(mtr, fms, next, next_mtr) {
+	TAILQ_FOREACH_SAFE(mtr, fms, next, next_mtr) {
 		for (i = 0; i < mtr->rq_num; i++) {
 			rq = &dev->rqs[mtr->rq_id[i]];
 			rc |= roc_nix_bpf_ena_dis(nix, mtr->bpf_id, rq, false);
@@ -512,7 +512,7 @@ nix_security_release(struct cnxk_eth_dev *dev)
 	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY || dev->ip_reass_en) {
 		/* Destroy inbound sessions */
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar)
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar)
 			cnxk_eth_sec_ops.session_destroy(eth_dev,
 							 eth_sec->sess);
 
@@ -534,7 +534,7 @@ nix_security_release(struct cnxk_eth_dev *dev)
 	    dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 		/* Destroy outbound sessions */
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar)
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar)
 			cnxk_eth_sec_ops.session_destroy(eth_dev,
 							 eth_sec->sess);
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c b/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
index 0c1533e3d7..1104e0ec81 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c
@@ -275,7 +275,7 @@ ethdev_sec_tel_handle_sa_info(const char *cmd __rte_unused, const char *params,
 	i = 0;
 	if (dev->tx_offloads & RTE_ETH_TX_OFFLOAD_SECURITY) {
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar) {
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar) {
 			if (eth_sec->sa_idx == sa_idx) {
 				rte_tel_data_add_dict_int(d, "outb_sa", 1);
 				if (roc_model_is_cn10k())
@@ -292,7 +292,7 @@ ethdev_sec_tel_handle_sa_info(const char *cmd __rte_unused, const char *params,
 	i = 0;
 	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar) {
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar) {
 			if (eth_sec->sa_idx == sa_idx) {
 				rte_tel_data_add_dict_int(d, "inb_sa", 1);
 				if (roc_model_is_cn10k())
@@ -353,7 +353,7 @@ ethdev_sec_tel_handle_info(const char *cmd __rte_unused, const char *params,
 
 	if (dev->tx_offloads & RTE_ETH_TX_OFFLOAD_SECURITY) {
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar) {
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->outb.list, entry, tvar) {
 			if (eth_sec->sa_idx < min_outb_sa)
 				min_outb_sa = eth_sec->sa_idx;
 			if (eth_sec->sa_idx > max_outb_sa)
@@ -370,7 +370,7 @@ ethdev_sec_tel_handle_info(const char *cmd __rte_unused, const char *params,
 
 	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 		tvar = NULL;
-		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar) {
+		TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar) {
 			if (eth_sec->sa_idx < min_inb_sa)
 				min_inb_sa = eth_sec->sa_idx;
 			if (eth_sec->sa_idx > max_inb_sa)
diff --git a/drivers/net/failsafe/failsafe_flow.c b/drivers/net/failsafe/failsafe_flow.c
index 5baa11460f..7b54644e38 100644
--- a/drivers/net/failsafe/failsafe_flow.c
+++ b/drivers/net/failsafe/failsafe_flow.c
@@ -186,7 +186,7 @@ fs_flow_flush(struct rte_eth_dev *dev,
 			return ret;
 		}
 	}
-	RTE_TAILQ_FOREACH_SAFE(flow, &PRIV(dev)->flow_list, next, tmp) {
+	TAILQ_FOREACH_SAFE(flow, &PRIV(dev)->flow_list, next, tmp) {
 		TAILQ_REMOVE(&PRIV(dev)->flow_list, flow, next);
 		fs_flow_release(&flow);
 	}
diff --git a/drivers/net/intel/cpfl/cpfl_flow.c b/drivers/net/intel/cpfl/cpfl_flow.c
index 3ba6c0f0e7..fd847d76b6 100644
--- a/drivers/net/intel/cpfl/cpfl_flow.c
+++ b/drivers/net/intel/cpfl/cpfl_flow.c
@@ -27,7 +27,7 @@ cpfl_flow_engine_match(struct rte_eth_dev *dev,
 	struct cpfl_flow_engine *engine = NULL;
 	void *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (!engine->parse_pattern_action)
 			continue;
 
@@ -46,7 +46,7 @@ cpfl_flow_engine_init(struct cpfl_adapter_ext *adapter)
 	void *temp;
 	int ret;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (!engine->init) {
 			PMD_INIT_LOG(ERR, "Invalid engine type (%d)",
 				     engine->type);
@@ -70,7 +70,7 @@ cpfl_flow_engine_uninit(struct cpfl_adapter_ext *adapter)
 	struct cpfl_flow_engine *engine = NULL;
 	void *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (engine->uninit)
 			engine->uninit(adapter);
 	}
@@ -244,7 +244,7 @@ cpfl_flow_flush(struct rte_eth_dev *dev,
 	void *temp;
 	int ret = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(p_flow, &itf->flow_list, next, temp) {
+	TAILQ_FOREACH_SAFE(p_flow, &itf->flow_list, next, temp) {
 		ret = cpfl_flow_destroy(dev, p_flow, error);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to flush flows");
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..32a0f51973 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4195,7 +4195,7 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 		 * recommended to be used in firmware v8.6.
 		 */
 		/* Remove all existing mac */
-		RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
+		TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
 			mac_filter[i] = f->mac_info;
 			ret = i40e_vsi_delete_mac(vsi, &f->mac_info.mac_addr);
 			if (ret)
@@ -5570,7 +5570,7 @@ i40e_vsi_release(struct i40e_vsi *vsi)
 
 	/* VSI has child to attach, release child first */
 	if (vsi->veb) {
-		RTE_TAILQ_FOREACH_SAFE(vsi_list, &vsi->veb->head, list, temp) {
+		TAILQ_FOREACH_SAFE(vsi_list, &vsi->veb->head, list, temp) {
 			if (i40e_vsi_release(vsi_list->vsi) != I40E_SUCCESS)
 				return -1;
 		}
@@ -5578,7 +5578,7 @@ i40e_vsi_release(struct i40e_vsi *vsi)
 	}
 
 	if (vsi->floating_veb) {
-		RTE_TAILQ_FOREACH_SAFE(vsi_list, &vsi->floating_veb->head,
+		TAILQ_FOREACH_SAFE(vsi_list, &vsi->floating_veb->head,
 			list, temp) {
 			if (i40e_vsi_release(vsi_list->vsi) != I40E_SUCCESS)
 				return -1;
@@ -5587,7 +5587,7 @@ i40e_vsi_release(struct i40e_vsi *vsi)
 
 	/* Remove all macvlan filters of the VSI */
 	i40e_vsi_remove_all_macvlan_filter(vsi);
-	RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp)
+	TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp)
 		rte_free(f);
 
 	if (vsi->type != I40E_VSI_MAIN &&
@@ -6230,7 +6230,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 	i = 0;
 
 	/* Remove all existing mac */
-	RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
+	TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
 		mac_filter[i] = f->mac_info;
 		ret = i40e_vsi_delete_mac(vsi, &f->mac_info.mac_addr);
 		if (ret) {
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 6cb5219a80..5eb31876aa 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -4216,7 +4216,7 @@ i40e_flow_flush_fdir_filter(struct i40e_pf *pf)
 		}
 
 		/* Delete FDIR flows in flow list. */
-		RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
+		TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
 			if (flow->filter_type == RTE_ETH_FILTER_FDIR) {
 				TAILQ_REMOVE(&pf->flow_list, flow, node);
 			}
@@ -4271,7 +4271,7 @@ i40e_flow_flush_ethertype_filter(struct i40e_pf *pf)
 	}
 
 	/* Delete ethertype flows in flow list. */
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
+	TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
 		if (flow->filter_type == RTE_ETH_FILTER_ETHERTYPE) {
 			TAILQ_REMOVE(&pf->flow_list, flow, node);
 			rte_free(flow);
@@ -4299,7 +4299,7 @@ i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
 	}
 
 	/* Delete tunnel flows in flow list. */
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
+	TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, temp) {
 		if (flow->filter_type == RTE_ETH_FILTER_TUNNEL) {
 			TAILQ_REMOVE(&pf->flow_list, flow, node);
 			rte_free(flow);
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index f24b7540f0..db8c4a9b17 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -1503,7 +1503,7 @@ i40e_hash_filter_flush(struct i40e_pf *pf)
 {
 	struct rte_flow *flow, *next;
 
-	RTE_TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, next) {
+	TAILQ_FOREACH_SAFE(flow, &pf->flow_list, node, next) {
 		if (flow->filter_type != RTE_ETH_FILTER_HASH)
 			continue;
 
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index 2e7943ef8b..dd1358ce7a 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -221,7 +221,7 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
 	void *temp;
 
 	/* remove all the MACs */
-	RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
+	TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
 		vlan_num = vsi->vlan_num;
 		filter_type = f->mac_info.filter_type;
 		if (filter_type == I40E_MACVLAN_PERFECT_MATCH ||
@@ -279,7 +279,7 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
 	void *temp;
 
 	/* restore all the MACs */
-	RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
+	TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp) {
 		if (f->mac_info.filter_type == I40E_MACVLAN_PERFECT_MATCH ||
 		    f->mac_info.filter_type == I40E_MACVLAN_HASH_MATCH) {
 			/**
@@ -572,7 +572,7 @@ rte_pmd_i40e_set_vf_mac_addr(uint16_t port, uint16_t vf_id,
 	rte_ether_addr_copy(mac_addr, &vf->mac_addr);
 
 	/* Remove all existing mac */
-	RTE_TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp)
+	TAILQ_FOREACH_SAFE(f, &vsi->mac_list, next, temp)
 		if (i40e_vsi_delete_mac(vsi, &f->mac_info.mac_addr)
 				!= I40E_SUCCESS)
 			PMD_DRV_LOG(WARNING, "Delete MAC failed");
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 38c1261bd9..e45abb2928 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1817,7 +1817,7 @@ iavf_flow_init(struct iavf_adapter *ad)
 	TAILQ_INIT(&vf->ipsec_crypto_parser_list);
 	rte_spinlock_init(&vf->flow_ops_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (engine->init == NULL) {
 			PMD_INIT_LOG(ERR, "Invalid engine type (%d)",
 				     engine->type);
@@ -1843,7 +1843,7 @@ iavf_flow_uninit(struct iavf_adapter *ad)
 	struct iavf_flow_parser_node *p_parser;
 	void *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (engine->uninit)
 			engine->uninit(ad);
 	}
@@ -1895,7 +1895,7 @@ iavf_register_parser(struct iavf_flow_parser *parser,
 		TAILQ_INSERT_TAIL(list, parser_node, node);
 	} else if (parser->engine->type == IAVF_FLOW_ENGINE_FDIR) {
 		list = &vf->dist_parser_list;
-		RTE_TAILQ_FOREACH_SAFE(existing_node, list, node, temp) {
+		TAILQ_FOREACH_SAFE(existing_node, list, node, temp) {
 			if (existing_node->parser->engine->type ==
 			    IAVF_FLOW_ENGINE_FSUB) {
 				TAILQ_INSERT_AFTER(list, existing_node,
@@ -1939,7 +1939,7 @@ iavf_unregister_parser(struct iavf_flow_parser *parser,
 	if (list == NULL)
 		return;
 
-	RTE_TAILQ_FOREACH_SAFE(p_parser, list, node, temp) {
+	TAILQ_FOREACH_SAFE(p_parser, list, node, temp) {
 		if (p_parser->parser->engine->type == parser->engine->type) {
 			TAILQ_REMOVE(list, p_parser, node);
 			rte_free(p_parser);
@@ -2085,7 +2085,7 @@ iavf_parse_engine_create(struct iavf_adapter *ad,
 	void *temp;
 	void *meta = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
+	TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
@@ -2115,7 +2115,7 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 	void *temp;
 	void *meta = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
+	TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
@@ -2261,7 +2261,7 @@ iavf_flow_is_valid(struct rte_flow *flow)
 		return true;
 
 	if (flow->engine) {
-		RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+		TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 			if (engine == flow->engine)
 				return true;
 		}
@@ -2322,7 +2322,7 @@ iavf_flow_flush(struct rte_eth_dev *dev,
 	void *temp;
 	int ret = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(p_flow, &vf->flow_list, node, temp) {
+	TAILQ_FOREACH_SAFE(p_flow, &vf->flow_list, node, temp) {
 		ret = iavf_flow_destroy(dev, p_flow, error);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to flush flows");
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..6f4b26dc9f 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1373,7 +1373,7 @@ ice_remove_all_mac_vlan_filters(struct ice_vsi *vsi)
 	if (!vsi || !vsi->mac_num)
 		return -EINVAL;
 
-	RTE_TAILQ_FOREACH_SAFE(m_f, &vsi->mac_list, next, temp) {
+	TAILQ_FOREACH_SAFE(m_f, &vsi->mac_list, next, temp) {
 		ret = ice_remove_mac_filter(vsi, &m_f->mac_info.mac_addr);
 		if (ret != ICE_SUCCESS) {
 			ret = -EINVAL;
@@ -1384,7 +1384,7 @@ ice_remove_all_mac_vlan_filters(struct ice_vsi *vsi)
 	if (vsi->vlan_num == 0)
 		return 0;
 
-	RTE_TAILQ_FOREACH_SAFE(v_f, &vsi->vlan_list, next, temp) {
+	TAILQ_FOREACH_SAFE(v_f, &vsi->vlan_list, next, temp) {
 		ret = ice_remove_vlan_filter(vsi, &v_f->vlan_info.vlan);
 		if (ret != ICE_SUCCESS) {
 			ret = -EINVAL;
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 23076b23d9..929dc94764 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -1998,7 +1998,7 @@ ice_flow_init(struct ice_adapter *ad)
 			ice_parser_dvm_set(ad->psr, false);
 	}
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (engine->init == NULL) {
 			PMD_INIT_LOG(ERR, "Invalid engine type (%d)",
 					engine->type);
@@ -2028,7 +2028,7 @@ ice_flow_uninit(struct ice_adapter *ad)
 	struct rte_flow *p_flow;
 	void *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 		if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask, engine->type)) {
 			PMD_DRV_LOG(DEBUG, "Engine %d disabled skip it", engine->type);
 			continue;
@@ -2556,7 +2556,7 @@ ice_flow_flush(struct rte_eth_dev *dev,
 	void *temp;
 	int ret = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(p_flow, &pf->flow_list, node, temp) {
+	TAILQ_FOREACH_SAFE(p_flow, &pf->flow_list, node, temp) {
 		ret = ice_flow_destroy(dev, p_flow, error);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to flush flows");
@@ -2697,7 +2697,7 @@ ice_flow_redirect(struct ice_adapter *ad,
 
 	rte_spinlock_lock(&pf->flow_ops_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(p_flow, &pf->flow_list, node, temp) {
+	TAILQ_FOREACH_SAFE(p_flow, &pf->flow_list, node, temp) {
 		if (!p_flow->engine->redirect)
 			continue;
 		ret = p_flow->engine->redirect(ad, p_flow, rd);
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_flow.c b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
index 3ee089a416..a74e729a66 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_flow.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
@@ -1230,7 +1230,7 @@ ipn3ke_flow_flush(struct rte_eth_dev *dev,
 	struct ipn3ke_hw *hw = IPN3KE_DEV_PRIVATE_TO_HW(dev);
 	struct rte_flow *flow, *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(flow, &hw->flow_list, next, temp) {
+	TAILQ_FOREACH_SAFE(flow, &hw->flow_list, next, temp) {
 		TAILQ_REMOVE(&hw->flow_list, flow, next);
 		rte_free(flow);
 	}
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index b3c4b10e75..4899be44af 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2783,7 +2783,7 @@ ixgbe_filterlist_flush(struct rte_eth_dev *dev)
 	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_ele_base *ele, *tmp;
 
-	RTE_TAILQ_FOREACH_SAFE(ele, &adapter->flow_list, entries, tmp) {
+	TAILQ_FOREACH_SAFE(ele, &adapter->flow_list, entries, tmp) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
 			(struct ixgbe_flow_mem *)ele;
 		struct rte_flow *flow = ixgbe_flow_mem_ptr->flow;
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 0866b425b4..0b26fab216 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -17516,7 +17516,7 @@ __flow_dv_destroy_sub_policy_rules(struct rte_eth_dev *dev,
 		    policy->act_cnt[i].fate_action == MLX5_FLOW_FATE_MTR)
 			next_fm = mlx5_flow_meter_find(priv,
 					policy->act_cnt[i].next_mtr_id, NULL);
-		RTE_TAILQ_FOREACH_SAFE(color_rule, &sub_policy->color_rules[i],
+		TAILQ_FOREACH_SAFE(color_rule, &sub_policy->color_rules[i],
 				   next_port, tmp) {
 			claim_zero(mlx5_flow_os_destroy_flow(color_rule->rule));
 			tbl = container_of(color_rule->matcher->tbl,
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index e7afcf5399..56babbff7f 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -2747,7 +2747,7 @@ mlx5_flow_meter_flush(struct rte_eth_dev *dev, struct rte_mtr_error *error)
 			priv->mtr_idx_tbl = NULL;
 		}
 	} else {
-		RTE_TAILQ_FOREACH_SAFE(legacy_fm, fms, next, tmp) {
+		TAILQ_FOREACH_SAFE(legacy_fm, fms, next, tmp) {
 			fm = &legacy_fm->fm;
 			if (mlx5_flow_meter_params_flush(dev, fm, 0))
 				return -rte_mtr_error_set(error, EINVAL,
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 96f0d2e264..b95fad6c47 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -281,7 +281,7 @@ static int nbl_userdev_free_record(u64 vaddr, u64 iova __rte_unused, u64 len __r
 {
 	struct nbl_userdev_map_record *record, *tmp_record;
 
-	RTE_TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
+	TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
 		if (record->vaddr != vaddr)
 			continue;
 		nbl_vfio_dma_mem_map(nbl_default_container, vaddr, record->len, 0);
@@ -296,7 +296,7 @@ static void nbl_userdev_dma_free(void)
 {
 	struct nbl_userdev_map_record *record, *tmp_record;
 
-	RTE_TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
+	TAILQ_FOREACH_SAFE(record, &nbl_map_list, next, tmp_record) {
 		TAILQ_REMOVE(&nbl_map_list, record, next);
 		free(record);
 	}
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 9ad93c6766..672a443dd9 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -1127,7 +1127,7 @@ nfb_eth_common_remove(struct rte_device *dev)
 {
 	struct pmd_internals *entry, *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(entry, &nfb_eth_dev_list, eth_dev_list, temp) {
+	TAILQ_FOREACH_SAFE(entry, &nfb_eth_dev_list, eth_dev_list, temp) {
 		if (dev == entry->eth_dev->device)
 			rte_eth_dev_destroy(entry->eth_dev, nfb_eth_dev_uninit);
 	}
diff --git a/drivers/net/sfc/sfc_flow.c b/drivers/net/sfc/sfc_flow.c
index 1006243539..8a599e0726 100644
--- a/drivers/net/sfc/sfc_flow.c
+++ b/drivers/net/sfc/sfc_flow.c
@@ -2666,7 +2666,7 @@ sfc_flow_flush(struct rte_eth_dev *dev,
 
 	sfc_adapter_lock(sa);
 
-	RTE_TAILQ_FOREACH_SAFE(flow, &sa->flow_list, entries, tmp) {
+	TAILQ_FOREACH_SAFE(flow, &sa->flow_list, entries, tmp) {
 		if (flow->internal)
 			continue;
 
@@ -2962,7 +2962,7 @@ sfc_flow_fini(struct sfc_adapter *sa)
 
 	SFC_ASSERT(sfc_adapter_is_locked(sa));
 
-	RTE_TAILQ_FOREACH_SAFE(flow, &sa->flow_list, entries, tmp) {
+	TAILQ_FOREACH_SAFE(flow, &sa->flow_list, entries, tmp) {
 		if (flow->internal)
 			continue;
 
diff --git a/drivers/net/softnic/rte_eth_softnic_swq.c b/drivers/net/softnic/rte_eth_softnic_swq.c
index afe6f05e29..2083d0a976 100644
--- a/drivers/net/softnic/rte_eth_softnic_swq.c
+++ b/drivers/net/softnic/rte_eth_softnic_swq.c
@@ -39,7 +39,7 @@ softnic_softnic_swq_free_keep_rxq_txq(struct pmd_internals *p)
 {
 	struct softnic_swq *swq, *tswq;
 
-	RTE_TAILQ_FOREACH_SAFE(swq, &p->swq_list, node, tswq) {
+	TAILQ_FOREACH_SAFE(swq, &p->swq_list, node, tswq) {
 		if ((strncmp(swq->name, "RXQ", strlen("RXQ")) == 0) ||
 			(strncmp(swq->name, "TXQ", strlen("TXQ")) == 0))
 			continue;
diff --git a/drivers/net/sxe2/sxe2_dump.c b/drivers/net/sxe2/sxe2_dump.c
index d43473e083..3d003bb34e 100644
--- a/drivers/net/sxe2/sxe2_dump.c
+++ b/drivers/net/sxe2/sxe2_dump.c
@@ -132,7 +132,7 @@ static void sxe2_dump_filter_info(FILE *file, struct rte_eth_dev *dev)
 	if (adapter->filter_ctxt.uc_num > 0) {
 		fprintf(file,
 			"\t  -- Unicast entry:\n");
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
 				       next_mac_entry) {
 			fprintf(file,
 				"\t  -- addr: %02x:%02x:%02x:%02x:%02x:%02x hw status:%u "
@@ -151,7 +151,7 @@ static void sxe2_dump_filter_info(FILE *file, struct rte_eth_dev *dev)
 	if (adapter->filter_ctxt.mc_num > 0) {
 		fprintf(file,
 			"\t  -- Multicast entry:\n");
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list,
 				       next, next_mac_entry) {
 			fprintf(file,
 				"\t  -- addr: %02x:%02x:%02x:%02x:%02x:%02x "
@@ -170,7 +170,7 @@ static void sxe2_dump_filter_info(FILE *file, struct rte_eth_dev *dev)
 	if (adapter->filter_ctxt.vlan_num > 0) {
 		fprintf(file,
 			"\t  -- Vlan entry:\n");
-		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list,
+		TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list,
 			next, next_vlan_entry) {
 			fprintf(file,
 				"\t  -- vlan tpid:0x%04x vid:0x%04x prio:%d "
diff --git a/drivers/net/sxe2/sxe2_filter.c b/drivers/net/sxe2/sxe2_filter.c
index 175b886aa3..c581339f78 100644
--- a/drivers/net/sxe2/sxe2_filter.c
+++ b/drivers/net/sxe2/sxe2_filter.c
@@ -19,7 +19,7 @@ static struct sxe2_mac_filter *sxe2_uc_filter_find(struct sxe2_adapter *adapter,
 	struct sxe2_mac_filter *next_entry  = NULL;
 
 	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
-	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
+	TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
 		if (rte_is_same_ether_addr(macaddr, &entry->mac_addr)) {
 			filter = entry;
 			break;
@@ -125,7 +125,7 @@ void sxe2_uc_filter_clear(struct sxe2_adapter *adapter, bool default_config)
 	struct sxe2_mac_filter *entry;
 	struct sxe2_mac_filter *next_entry;
 
-	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
+	TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.uc_list, next, next_entry) {
 		if (entry->default_config && !default_config)
 			continue;
 
@@ -142,7 +142,7 @@ static struct sxe2_mac_filter *sxe2_mc_filter_find(struct sxe2_adapter *adapter,
 	struct sxe2_mac_filter *next_entry  = NULL;
 
 	rte_spinlock_lock(&adapter->filter_ctxt.filter_lock);
-	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
+	TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
 		if (rte_is_same_ether_addr(macaddr, &entry->mac_addr)) {
 			filter = entry;
 			break;
@@ -249,7 +249,7 @@ void sxe2_mc_filter_clear(struct sxe2_adapter *adapter, bool default_config)
 	struct sxe2_mac_filter *entry;
 	struct sxe2_mac_filter *next_entry;
 
-	RTE_TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
+	TAILQ_FOREACH_SAFE(entry, &adapter->filter_ctxt.mc_list, next, next_entry) {
 		if (entry->default_config && !default_config)
 			continue;
 		if (sxe2_mc_filter_del(adapter, &entry->mac_addr))
@@ -388,7 +388,7 @@ void sxe2_vlan_filters_clear(struct sxe2_adapter *adapter, bool default_config)
 	if (adapter->filter_ctxt.vlan_num == 0)
 		return;
 
-	RTE_TAILQ_FOREACH_SAFE(v_f, &adapter->filter_ctxt.vlan_list, next, temp)
+	TAILQ_FOREACH_SAFE(v_f, &adapter->filter_ctxt.vlan_list, next, temp)
 	{
 		if (v_f->default_config && !default_config)
 			continue;
@@ -521,7 +521,7 @@ static int32_t sxe2_all_filter_hw_clear(struct sxe2_adapter *adapter)
 	struct sxe2_vlan_filter *next_vlan_entry;
 
 	if (adapter->filter_ctxt.uc_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
 			    next_mac_entry) {
 			if (mac_entry->hw_config) {
 				ret = sxe2_drv_uc_config(adapter, &mac_entry->mac_addr, false);
@@ -536,7 +536,7 @@ static int32_t sxe2_all_filter_hw_clear(struct sxe2_adapter *adapter)
 	}
 
 	if (adapter->filter_ctxt.mc_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
 			    next_mac_entry) {
 			if (mac_entry->hw_config) {
 				ret = sxe2_drv_mc_config(adapter, &mac_entry->mac_addr, false);
@@ -551,7 +551,7 @@ static int32_t sxe2_all_filter_hw_clear(struct sxe2_adapter *adapter)
 	}
 
 	if (adapter->filter_ctxt.vlan_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
+		TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
 			    next_vlan_entry) {
 			if (vlan_entry->hw_config) {
 				ret = sxe2_drv_vlan_filter_id_config(adapter,
@@ -606,7 +606,7 @@ static int32_t sxe2_all_filter_hw_set(struct sxe2_adapter *adapter)
 	struct sxe2_vlan_filter *next_vlan_entry;
 
 	if (adapter->filter_ctxt.uc_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.uc_list, next,
 				       next_mac_entry) {
 			if (!mac_entry->hw_config) {
 				ret = sxe2_drv_uc_config(adapter, &mac_entry->mac_addr,
@@ -624,7 +624,7 @@ static int32_t sxe2_all_filter_hw_set(struct sxe2_adapter *adapter)
 	}
 
 	if (adapter->filter_ctxt.mc_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
+		TAILQ_FOREACH_SAFE(mac_entry, &adapter->filter_ctxt.mc_list, next,
 				       next_mac_entry) {
 			if (!mac_entry->hw_config) {
 				ret = sxe2_drv_mc_config(adapter, &mac_entry->mac_addr, true);
@@ -641,7 +641,7 @@ static int32_t sxe2_all_filter_hw_set(struct sxe2_adapter *adapter)
 	}
 
 	if (adapter->filter_ctxt.vlan_num > 0) {
-		RTE_TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
+		TAILQ_FOREACH_SAFE(vlan_entry, &adapter->filter_ctxt.vlan_list, next,
 				       next_vlan_entry) {
 			if (!vlan_entry->hw_config) {
 				ret = sxe2_drv_vlan_filter_id_config(adapter,
diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index d29480b931..7d2252725b 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -287,7 +287,7 @@ void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 		PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 		goto l_end;
 	}
-	RTE_TAILQ_FOREACH_SAFE(var, &adapter->vsi_ctxt.other_vsi_list, next, tvar) {
+	TAILQ_FOREACH_SAFE(var, &adapter->vsi_ctxt.other_vsi_list, next, tvar) {
 		ret = sxe2_vsi_destroy(adapter, var);
 		if (ret) {
 			PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index c138712635..5da939ec03 100644
--- a/drivers/net/zxdh/zxdh_flow.c
+++ b/drivers/net/zxdh/zxdh_flow.c
@@ -288,7 +288,7 @@ static struct dh_flow_engine *zxdh_get_flow_engine(struct rte_eth_dev *dev __rte
 	struct dh_flow_engine *engine = NULL;
 	void *temp;
 
-	RTE_TAILQ_FOREACH_SAFE(engine, &flow_engine_list, node, temp) {
+	TAILQ_FOREACH_SAFE(engine, &flow_engine_list, node, temp) {
 		if (engine->type  == FLOW_TYPE_FD_TCAM)
 			break;
 	}
diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
index b23f6535a8..e49e88b64b 100644
--- a/drivers/net/zxdh/zxdh_mtr.c
+++ b/drivers/net/zxdh/zxdh_mtr.c
@@ -1209,13 +1209,13 @@ zxdh_mtr_release(struct rte_eth_dev *dev)
 	struct rte_mtr_error error = {0};
 	struct zxdh_mtr_object *mtr_obj;
 
-	RTE_TAILQ_FOREACH(mtr_obj, &zxdh_shared_data->mtr_list, next) {
+	TAILQ_FOREACH(mtr_obj, &zxdh_shared_data->mtr_list, next) {
 		if (mtr_obj->port_id == priv->port_id)
 			zxdh_mtr_obj_free(dev, mtr_obj);
 	}
 
 
-	RTE_TAILQ_FOREACH(profile, &zxdh_shared_data->meter_profile_list, next) {
+	TAILQ_FOREACH(profile, &zxdh_shared_data->meter_profile_list, next) {
 		if (profile->dpdk_port_id == priv->port_id)
 			zxdh_mtr_profile_res_free(dev,
 				zxdh_shared_data->mtr_profile_mp,
@@ -1226,7 +1226,7 @@ zxdh_mtr_release(struct rte_eth_dev *dev)
 
 	struct zxdh_meter_policy *policy;
 
-	RTE_TAILQ_FOREACH(policy, &zxdh_shared_data->mtr_policy_list, next) {
+	TAILQ_FOREACH(policy, &zxdh_shared_data->mtr_policy_list, next) {
 		if (policy->dpdk_port_id == priv->port_id)
 			zxdh_mtr_policy_res_free(zxdh_shared_data->mtr_policy_mp, policy);
 	}
diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index e162fe5da6..5c41219827 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -59,16 +59,16 @@ struct virtual_machine_info {
 	virDomainInfo info;
 	rte_spinlock_t config_spinlock;
 	int allow_query;
-	RTE_TAILQ_ENTRY(virtual_machine_info) vms_info;
+	TAILQ_ENTRY(virtual_machine_info) vms_info;
 };
 
-RTE_TAILQ_HEAD(, virtual_machine_info) vm_list_head;
+TAILQ_HEAD(, virtual_machine_info) vm_list_head;
 
 static struct virtual_machine_info *
 find_domain_by_name(const char *name)
 {
 	struct virtual_machine_info *info;
-	RTE_TAILQ_FOREACH(info, &vm_list_head, vms_info) {
+	TAILQ_FOREACH(info, &vm_list_head, vms_info) {
 		if (!strncmp(info->name, name, CHANNEL_MGR_MAX_NAME_LEN-1))
 			return info;
 	}
@@ -1015,7 +1015,7 @@ channel_manager_exit(void)
 	char mask[RTE_MAX_LCORE];
 	struct virtual_machine_info *vm_info, *tmp;
 
-	RTE_TAILQ_FOREACH_SAFE(vm_info, &vm_list_head, vms_info, tmp) {
+	TAILQ_FOREACH_SAFE(vm_info, &vm_list_head, vms_info, tmp) {
 
 		rte_spinlock_lock(&(vm_info->config_spinlock));
 
diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
index 36dabf8fa6..e8de3fe265 100644
--- a/lib/bbdev/rte_bbdev.h
+++ b/lib/bbdev/rte_bbdev.h
@@ -501,7 +501,7 @@ struct rte_bbdev_callback;
 struct rte_intr_handle;
 
 /** Structure to keep track of registered callbacks */
-RTE_TAILQ_HEAD(rte_bbdev_cb_list, rte_bbdev_callback);
+TAILQ_HEAD(rte_bbdev_cb_list, rte_bbdev_callback);
 
 /**
  * @internal The data structure associated with a device. Drivers can access
diff --git a/lib/cryptodev/cryptodev_pmd.h b/lib/cryptodev/cryptodev_pmd.h
index 929c6defe9..c60b60c767 100644
--- a/lib/cryptodev/cryptodev_pmd.h
+++ b/lib/cryptodev/cryptodev_pmd.h
@@ -131,7 +131,7 @@ struct rte_cryptodev_global {
 
 /* Cryptodev driver, containing the driver ID */
 struct cryptodev_driver {
-	RTE_TAILQ_ENTRY(cryptodev_driver) next; /**< Next in list. */
+	TAILQ_ENTRY(cryptodev_driver) next; /**< Next in list. */
 	const struct rte_driver *driver;
 	uint8_t id;
 };
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index 37a6a5e49b..1fc2282894 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -1049,7 +1049,7 @@ rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id);
 struct rte_cryptodev_callback;
 
 /** Structure to keep track of registered callbacks */
-RTE_TAILQ_HEAD(rte_cryptodev_cb_list, rte_cryptodev_callback);
+TAILQ_HEAD(rte_cryptodev_cb_list, rte_cryptodev_callback);
 
 /**
  * Structure used to hold information about the callbacks to be called for a
diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index c523429d67..c5936ae6bd 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -303,7 +303,7 @@ rte_devargs_insert(struct rte_devargs **da)
 	if (*da == NULL || (*da)->bus == NULL)
 		return -1;
 
-	RTE_TAILQ_FOREACH_SAFE(listed_da, &devargs_list, next, tmp) {
+	TAILQ_FOREACH_SAFE(listed_da, &devargs_list, next, tmp) {
 		if (listed_da == *da)
 			/* devargs already in the list */
 			return 0;
@@ -372,7 +372,7 @@ rte_devargs_remove(struct rte_devargs *devargs)
 	if (devargs == NULL || devargs->bus == NULL)
 		return -1;
 
-	RTE_TAILQ_FOREACH_SAFE(d, &devargs_list, next, tmp) {
+	TAILQ_FOREACH_SAFE(d, &devargs_list, next, tmp) {
 		if (strcmp(d->bus->name, devargs->bus->name) == 0 &&
 		    strcmp(d->name, devargs->name) == 0) {
 			TAILQ_REMOVE(&devargs_list, d, next);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 9c5d6df36f..26f3e4e931 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -482,7 +482,7 @@ eal_option_device_parse(void)
 	void *tmp;
 	int ret = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(devopt, &devopt_list, next, tmp) {
+	TAILQ_FOREACH_SAFE(devopt, &devopt_list, next, tmp) {
 		if (ret == 0) {
 			ret = rte_devargs_add(devopt->type, devopt->arg);
 			if (ret)
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 5133eaaa47..aded70b9cb 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1266,7 +1266,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	if (ret != 0 && reply->nb_sent > 0) {
 		struct pending_request *r, *tmp;
 
-		RTE_TAILQ_FOREACH_SAFE(r, &pending_requests.requests, next, tmp) {
+		TAILQ_FOREACH_SAFE(r, &pending_requests.requests, next, tmp) {
 			if (r->type == REQUEST_TYPE_ASYNC && r->async.param == param) {
 				TAILQ_REMOVE(&pending_requests.requests, r, next);
 				free(r->reply);
diff --git a/lib/eal/freebsd/include/rte_os.h b/lib/eal/freebsd/include/rte_os.h
index ddc3b4fd2e..05ff038e1d 100644
--- a/lib/eal/freebsd/include/rte_os.h
+++ b/lib/eal/freebsd/include/rte_os.h
@@ -12,17 +12,11 @@
 
 #include <pthread_np.h>
 #include <stdlib.h>            /* Declares alloca() */
+/* Not used here, but included so that rte_queue.h wins the multiple
+ * inclusion guard race against a system <sys/queue.h>. See rte_queue.h.
+ */
 #include <rte_queue.h>
 
-/* These macros are compatible with system's sys/queue.h. */
-#define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
-#define RTE_TAILQ_ENTRY(type) TAILQ_ENTRY(type)
-#define RTE_TAILQ_FOREACH(var, head, field) TAILQ_FOREACH(var, head, field)
-#define RTE_TAILQ_FIRST(head) TAILQ_FIRST(head)
-#define RTE_TAILQ_NEXT(elem, field) TAILQ_NEXT(elem, field)
-#define RTE_STAILQ_HEAD(name, type) STAILQ_HEAD(name, type)
-#define RTE_STAILQ_ENTRY(type) STAILQ_ENTRY(type)
-
 typedef cpuset_t rte_cpuset_t;
 #define RTE_HAS_CPUSET
 
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index fa4d711a90..34f4cfdc4d 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -20,7 +20,7 @@ struct rte_device;
 struct rte_driver;
 
 /** Double linked list of buses */
-RTE_TAILQ_HEAD(rte_bus_list, rte_bus);
+TAILQ_HEAD(rte_bus_list, rte_bus);
 
 /**
  * Bus specific scan for devices attached on the bus.
@@ -351,7 +351,7 @@ typedef void *(*rte_bus_dev_iterate_t)(const struct rte_bus *bus,
  * A structure describing a generic bus.
  */
 struct rte_bus {
-	RTE_TAILQ_ENTRY(rte_bus) next; /**< Next bus object in linked list */
+	TAILQ_ENTRY(rte_bus) next; /**< Next bus object in linked list */
 	const char *name;            /**< Name of the bus */
 	bool allow_multi_probe;      /**< Allow probing devices multiple times */
 	rte_bus_scan_t scan;         /**< Scan for devices attached to bus */
@@ -374,8 +374,8 @@ struct rte_bus {
 					/**< handle sigbus error on the bus */
 	rte_bus_free_device_t free_device; /**< Free bus-specific device */
 	rte_bus_cleanup_t cleanup;   /**< Cleanup devices on bus */
-	RTE_TAILQ_HEAD(, rte_device) device_list; /**< List of devices on the bus */
-	RTE_TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
+	TAILQ_HEAD(, rte_device) device_list; /**< List of devices on the bus */
+	TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
 };
 
 /**
diff --git a/lib/eal/include/dev_driver.h b/lib/eal/include/dev_driver.h
index 2052e3ecb2..2732401dfd 100644
--- a/lib/eal/include/dev_driver.h
+++ b/lib/eal/include/dev_driver.h
@@ -12,7 +12,7 @@
  * A structure describing a device driver.
  */
 struct rte_driver {
-	RTE_TAILQ_ENTRY(rte_driver) next; /**< Next in list. */
+	TAILQ_ENTRY(rte_driver) next; /**< Next in list. */
 	const char *name;                   /**< Driver name. */
 	const char *alias;              /**< Driver alias. */
 	const struct rte_bus *bus;      /**< Bus reference. */
@@ -22,7 +22,7 @@ struct rte_driver {
  * A structure describing a generic device.
  */
 struct rte_device {
-	RTE_TAILQ_ENTRY(rte_device) next; /**< Next device */
+	TAILQ_ENTRY(rte_device) next; /**< Next device */
 	const char *name;             /**< Device name */
 	const char *bus_info;         /**< Device bus specific information */
 	const struct rte_driver *driver; /**< Driver assigned after probing */
diff --git a/lib/eal/include/rte_class.h b/lib/eal/include/rte_class.h
index 7631e36e82..216474ff43 100644
--- a/lib/eal/include/rte_class.h
+++ b/lib/eal/include/rte_class.h
@@ -25,13 +25,13 @@ extern "C" {
 #endif
 
 /** Double linked list of classes */
-RTE_TAILQ_HEAD(rte_class_list, rte_class);
+TAILQ_HEAD(rte_class_list, rte_class);
 
 /**
  * A structure describing a generic device class.
  */
 struct rte_class {
-	RTE_TAILQ_ENTRY(rte_class) next; /**< Next device class in linked list */
+	TAILQ_ENTRY(rte_class) next; /**< Next device class in linked list */
 	const char *name; /**< Name of the class */
 	rte_dev_iterate_t dev_iterate; /**< Device iterator. */
 };
diff --git a/lib/eal/include/rte_devargs.h b/lib/eal/include/rte_devargs.h
index ed5a4675d9..0c64a98214 100644
--- a/lib/eal/include/rte_devargs.h
+++ b/lib/eal/include/rte_devargs.h
@@ -71,7 +71,7 @@ enum rte_devtype {
  */
 struct rte_devargs {
 	/** Next in list. */
-	RTE_TAILQ_ENTRY(rte_devargs) next;
+	TAILQ_ENTRY(rte_devargs) next;
 	/** Type of device. */
 	enum rte_devtype type;
 	/** Device policy. */
diff --git a/lib/eal/include/rte_queue.h b/lib/eal/include/rte_queue.h
index a847670470..635e7797cf 100644
--- a/lib/eal/include/rte_queue.h
+++ b/lib/eal/include/rte_queue.h
@@ -26,6 +26,11 @@
  * _FOREACH_SAFE, _FOREACH_FROM or _SWAP. Conversely, when this header wins,
  * the glibc-only CIRCLEQ_ and SIMPLEQ_ families are not defined.
  *
+ * Within DPDK this is not a problem: rte_os.h includes this header and is
+ * reached from rte_common.h, so any DPDK header included first wins the
+ * race. Note that the include in rte_os.h is load bearing for that reason,
+ * even though nothing in rte_os.h itself uses the list macros.
+ *
  * The FreeBSD QUEUE_MACRO_DEBUG and INVARIANTS facilities are omitted: they
  * are there to debug the macros themselves, which is not something DPDK does.
  */
diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index e7caed6812..decd833b0d 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -12,6 +12,7 @@
 
 #include <stdio.h>
 #include <rte_debug.h>
+#include <rte_queue.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -19,11 +20,11 @@ extern "C" {
 
 /** dummy structure type used by the rte_tailq APIs */
 struct rte_tailq_entry {
-	RTE_TAILQ_ENTRY(rte_tailq_entry) next; /**< Pointer entries for a tailq list */
+	TAILQ_ENTRY(rte_tailq_entry) next; /**< Pointer entries for a tailq list */
 	void *data; /**< Pointer to the data referenced by this tailq entry */
 };
 /** dummy */
-RTE_TAILQ_HEAD(rte_tailq_entry_head, rte_tailq_entry);
+TAILQ_HEAD(rte_tailq_entry_head, rte_tailq_entry);
 
 #define RTE_TAILQ_NAMESIZE 32
 
@@ -46,7 +47,7 @@ struct rte_tailq_elem {
 	 * rte_eal_tailqs_init()
 	 */
 	struct rte_tailq_head *head;
-	RTE_TAILQ_ENTRY(rte_tailq_elem) next;
+	TAILQ_ENTRY(rte_tailq_elem) next;
 	const char name[RTE_TAILQ_NAMESIZE];
 };
 
@@ -124,10 +125,32 @@ RTE_INIT(tailqinitfn_ ##t) \
 		rte_panic("Cannot initialize tailq: %s\n", t.name); \
 }
 
-/* This macro permits both remove and free var within the loop safely.*/
+/*
+ * Compatibility wrappers, deprecated.
+ *
+ * These existed only because Windows had no <sys/queue.h>. Use the plain
+ * macros from <rte_queue.h> instead; these are kept for out of tree code
+ * and will be removed in a future release.
+ *
+ * They are defined in terms of the plain TAILQ_ and STAILQ_ macros only,
+ * never the extended ones, so that they keep working in a translation unit
+ * that included a system <sys/queue.h> before any DPDK header, in which
+ * case rte_queue.h is suppressed and only the subset the system provides
+ * is defined. That is why RTE_TAILQ_FOREACH_SAFE is open coded rather than
+ * mapped to TAILQ_FOREACH_SAFE, which glibc does not have.
+ */
+#define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
+#define RTE_TAILQ_ENTRY(type) TAILQ_ENTRY(type)
+#define RTE_TAILQ_FOREACH(var, head, field) TAILQ_FOREACH(var, head, field)
+#define RTE_TAILQ_FIRST(head) TAILQ_FIRST(head)
+#define RTE_TAILQ_NEXT(elem, field) TAILQ_NEXT(elem, field)
+#define RTE_STAILQ_HEAD(name, type) STAILQ_HEAD(name, type)
+#define RTE_STAILQ_ENTRY(type) STAILQ_ENTRY(type)
+
+/* This macro permits both remove and free var within the loop safely. */
 #define RTE_TAILQ_FOREACH_SAFE(var, head, field, tvar) \
-	for ((var) = RTE_TAILQ_FIRST((head)); \
-	    (var) && ((tvar) = RTE_TAILQ_NEXT((var), field), 1); \
+	for ((var) = TAILQ_FIRST((head)); \
+	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
 	    (var) = (tvar))
 
 #ifdef __cplusplus
diff --git a/lib/eal/linux/include/rte_os.h b/lib/eal/linux/include/rte_os.h
index 3c87f52b33..e8b35d265e 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -12,17 +12,11 @@
 
 #include <alloca.h>
 #include <sched.h>
+/* Not used here, but included so that rte_queue.h wins the multiple
+ * inclusion guard race against a system <sys/queue.h>. See rte_queue.h.
+ */
 #include <rte_queue.h>
 
-/* These macros are compatible with system's sys/queue.h. */
-#define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
-#define RTE_TAILQ_ENTRY(type) TAILQ_ENTRY(type)
-#define RTE_TAILQ_FOREACH(var, head, field) TAILQ_FOREACH(var, head, field)
-#define RTE_TAILQ_FIRST(head) TAILQ_FIRST(head)
-#define RTE_TAILQ_NEXT(elem, field) TAILQ_NEXT(elem, field)
-#define RTE_STAILQ_HEAD(name, type) STAILQ_HEAD(name, type)
-#define RTE_STAILQ_ENTRY(type) STAILQ_ENTRY(type)
-
 #ifdef CPU_SETSIZE /* may require _GNU_SOURCE */
 typedef cpu_set_t rte_cpuset_t;
 #define RTE_HAS_CPUSET
diff --git a/lib/eal/windows/include/rte_os.h b/lib/eal/windows/include/rte_os.h
index 2a43cb1f9b..3f2a57c325 100644
--- a/lib/eal/windows/include/rte_os.h
+++ b/lib/eal/windows/include/rte_os.h
@@ -16,33 +16,10 @@
 #include <malloc.h>
 
 #include <sched.h>
-
-/* These macros are compatible with bundled sys/queue.h. */
-#define RTE_TAILQ_HEAD(name, type) \
-struct name { \
-	struct type *tqh_first; \
-	struct type **tqh_last; \
-}
-#define RTE_TAILQ_ENTRY(type) \
-struct { \
-	struct type *tqe_next; \
-	struct type **tqe_prev; \
-}
-#define RTE_TAILQ_FOREACH(var, head, field) \
-	for ((var) = RTE_TAILQ_FIRST((head)); \
-	    (var); \
-	    (var) = RTE_TAILQ_NEXT((var), field))
-#define RTE_TAILQ_FIRST(head) ((head)->tqh_first)
-#define RTE_TAILQ_NEXT(elm, field) ((elm)->field.tqe_next)
-#define RTE_STAILQ_HEAD(name, type) \
-struct name { \
-	struct type *stqh_first; \
-	struct type **stqh_last; \
-}
-#define RTE_STAILQ_ENTRY(type) \
-struct { \
-	struct type *stqe_next; \
-}
+/* Not used here, but included so that rte_queue.h wins the multiple
+ * inclusion guard race against a system <sys/queue.h>. See rte_queue.h.
+ */
+#include <rte_queue.h>
 
 /* cpu_set macros implementation */
 #define RTE_CPU_AND(dst, src1, src2) CPU_AND(dst, src1, src2)
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 34b9585cb8..e184fc10f6 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -777,7 +777,7 @@ rte_efd_free(struct rte_efd_table *table)
 	efd_list = RTE_TAILQ_CAST(rte_efd_tailq.head, rte_efd_list);
 	rte_mcfg_tailq_write_lock();
 
-	RTE_TAILQ_FOREACH_SAFE(te, efd_list, next, temp) {
+	TAILQ_FOREACH_SAFE(te, efd_list, next, temp) {
 		if (te->data == (void *) table) {
 			TAILQ_REMOVE(efd_list, te, next);
 			rte_free(te);
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
index 4ffae4921a..e8497301f2 100644
--- a/lib/ethdev/rte_ethdev_core.h
+++ b/lib/ethdev/rte_ethdev_core.h
@@ -18,7 +18,7 @@
 
 struct rte_eth_dev_callback;
 /** @internal Structure to keep track of registered callbacks */
-RTE_TAILQ_HEAD(rte_eth_dev_cb_list, rte_eth_dev_callback);
+TAILQ_HEAD(rte_eth_dev_cb_list, rte_eth_dev_callback);
 
 struct rte_eth_dev;
 
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index 9a839517c8..3e1ef8bf44 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -506,7 +506,7 @@ struct sw_vector_adapter_data {
 	struct rte_event_vector_adapter *adapter;
 	struct rte_event_vector_adapter_stats stats;
 	struct sw_vector_adapter_service_data *service_data;
-	RTE_TAILQ_ENTRY(sw_vector_adapter_data) next;
+	TAILQ_ENTRY(sw_vector_adapter_data) next;
 };
 
 struct sw_vector_adapter_service_data {
diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index b44f92a04c..d67878a999 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -476,7 +476,7 @@ rte_gpu_callback_unregister(int16_t dev_id, enum rte_gpu_event event,
 	rte_rwlock_write_lock(&gpu_callback_lock);
 	do {
 		callbacks = &gpus[next_dev].callbacks;
-		RTE_TAILQ_FOREACH_SAFE(callback, callbacks, next, nextcb) {
+		TAILQ_FOREACH_SAFE(callback, callbacks, next, nextcb) {
 			if (callback->event != event ||
 					callback->function != function ||
 					(callback->user_data != user_data &&
@@ -499,7 +499,7 @@ gpu_free_callbacks(struct rte_gpu *dev)
 
 	callbacks = &dev->callbacks;
 	rte_rwlock_write_lock(&gpu_callback_lock);
-	RTE_TAILQ_FOREACH_SAFE(callback, callbacks, next, nextcb) {
+	TAILQ_FOREACH_SAFE(callback, callbacks, next, nextcb) {
 		TAILQ_REMOVE(callbacks, callback, next);
 		free(callback);
 	}
diff --git a/lib/gpudev/gpudev_driver.h b/lib/gpudev/gpudev_driver.h
index b7621f6e5a..956deb8935 100644
--- a/lib/gpudev/gpudev_driver.h
+++ b/lib/gpudev/gpudev_driver.h
@@ -80,7 +80,7 @@ struct __rte_cache_aligned rte_gpu {
 	/* Driver functions. */
 	struct rte_gpu_ops ops;
 	/* Event callback list. */
-	RTE_TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
+	TAILQ_HEAD(rte_gpu_callback_list, rte_gpu_callback) callbacks;
 	/* Current state (used or not) in the running process. */
 	enum rte_gpu_state process_state; /* Updated by this library. */
 	/* Driver-specific private data for the running process. */
diff --git a/lib/ip_frag/ip_reassembly.h b/lib/ip_frag/ip_reassembly.h
index 9e1666ef67..001a0d6e5b 100644
--- a/lib/ip_frag/ip_reassembly.h
+++ b/lib/ip_frag/ip_reassembly.h
@@ -48,7 +48,7 @@ struct ip_frag_key {
  * First two entries in the frags[] array are for the last and first fragments.
  */
 struct __rte_cache_aligned ip_frag_pkt {
-	RTE_TAILQ_ENTRY(ip_frag_pkt) lru;      /* LRU list */
+	TAILQ_ENTRY(ip_frag_pkt) lru;      /* LRU list */
 	struct ip_frag_key key;                /* fragmentation key */
 	uint64_t start;                        /* creation timestamp */
 	uint32_t total_size;                   /* expected reassembled size */
@@ -58,7 +58,7 @@ struct __rte_cache_aligned ip_frag_pkt {
 };
 
  /* fragments tailq */
-RTE_TAILQ_HEAD(ip_pkt_list, ip_frag_pkt);
+TAILQ_HEAD(ip_pkt_list, ip_frag_pkt);
 
 /* fragmentation table statistics */
 struct __rte_cache_aligned ip_frag_tbl_stat {
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index 00bf9476de..31556f82e7 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -140,7 +140,7 @@ rte_ip_frag_table_del_expired_entries(struct rte_ip_frag_tbl *tbl,
 
 	max_cycles = tbl->max_cycles;
 
-	RTE_TAILQ_FOREACH_SAFE(fp, &tbl->lru, lru, tmp) {
+	TAILQ_FOREACH_SAFE(fp, &tbl->lru, lru, tmp) {
 		if (max_cycles + fp->start >= tms)
 			return;
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 57fd282970..287cd4e331 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1437,7 +1437,7 @@ void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 
 	rte_mcfg_mempool_read_lock();
 
-	RTE_TAILQ_FOREACH_SAFE(te, mempool_list, next, tmp_te) {
+	TAILQ_FOREACH_SAFE(te, mempool_list, next, tmp_te) {
 		(*func)((struct rte_mempool *) te->data, arg);
 	}
 
@@ -1505,7 +1505,7 @@ mempool_event_callback_invoke(enum rte_mempool_event event,
 	void *tmp_te;
 
 	rte_mcfg_tailq_read_lock();
-	RTE_TAILQ_FOREACH_SAFE(cb, &callback_tailq, callbacks, tmp_te) {
+	TAILQ_FOREACH_SAFE(cb, &callback_tailq, callbacks, tmp_te) {
 		rte_mcfg_tailq_read_unlock();
 		cb->func(event, mp, cb->user_data);
 		rte_mcfg_tailq_read_lock();
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..cbe74b65c3 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -153,7 +153,7 @@ struct rte_mempool_objsz {
  * double-frees.
  */
 struct rte_mempool_objhdr {
-	RTE_STAILQ_ENTRY(rte_mempool_objhdr) next; /**< Next in list. */
+	STAILQ_ENTRY(rte_mempool_objhdr) next; /**< Next in list. */
 	struct rte_mempool *mp;          /**< The mempool owning the object. */
 	rte_iova_t iova;                 /**< IO address of the object. */
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
@@ -164,7 +164,7 @@ struct rte_mempool_objhdr {
 /**
  * A list of object headers type
  */
-RTE_STAILQ_HEAD(rte_mempool_objhdr_list, rte_mempool_objhdr);
+STAILQ_HEAD(rte_mempool_objhdr_list, rte_mempool_objhdr);
 
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 
@@ -191,7 +191,7 @@ extern int rte_mempool_logtype;
 /**
  * A list of memory where objects are stored
  */
-RTE_STAILQ_HEAD(rte_mempool_memhdr_list, rte_mempool_memhdr);
+STAILQ_HEAD(rte_mempool_memhdr_list, rte_mempool_memhdr);
 
 /**
  * Callback used to free a memory chunk
@@ -206,7 +206,7 @@ typedef void (rte_mempool_memchunk_free_cb_t)(struct rte_mempool_memhdr *memhdr,
  * and physically contiguous.
  */
 struct rte_mempool_memhdr {
-	RTE_STAILQ_ENTRY(rte_mempool_memhdr) next; /**< Next in list. */
+	STAILQ_ENTRY(rte_mempool_memhdr) next; /**< Next in list. */
 	struct rte_mempool *mp;  /**< The mempool owning the chunk */
 	void *addr;              /**< Virtual address of the chunk */
 	rte_iova_t iova;         /**< IO address of the chunk */
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index d372ecf4f1..ea69beab13 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -460,7 +460,7 @@ rte_pmu_fini(void)
 	if (!rte_pmu.initialized)
 		return;
 
-	RTE_TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {
+	TAILQ_FOREACH_SAFE(event, &rte_pmu.event_list, next, tmp_event) {
 		TAILQ_REMOVE(&rte_pmu.event_list, event, next);
 		free_event(event);
 	}
diff --git a/lib/power/power_cpufreq.h b/lib/power/power_cpufreq.h
index 41bfaed7bb..9847cb52db 100644
--- a/lib/power/power_cpufreq.h
+++ b/lib/power/power_cpufreq.h
@@ -147,7 +147,7 @@ typedef int (*rte_power_get_capabilities_t)(unsigned int lcore_id,
 
 /** Structure defining core power operations structure */
 struct rte_power_cpufreq_ops {
-	RTE_TAILQ_ENTRY(rte_power_cpufreq_ops) next;	/**< Next in list. */
+	TAILQ_ENTRY(rte_power_cpufreq_ops) next;	/**< Next in list. */
 	char name[RTE_POWER_DRIVER_NAMESZ];             /**< power mgmt driver. */
 	rte_power_cpufreq_init_t init;                  /**< Initialize power management. */
 	rte_power_cpufreq_exit_t exit;                  /**< Exit power management. */
diff --git a/lib/power/power_uncore_ops.h b/lib/power/power_uncore_ops.h
index 025a55cb97..62bc65dcc7 100644
--- a/lib/power/power_uncore_ops.h
+++ b/lib/power/power_uncore_ops.h
@@ -185,7 +185,7 @@ typedef void (*rte_power_uncore_driver_cb_t)(void);
 
 /** Structure defining uncore power operations structure */
 struct rte_power_uncore_ops {
-	RTE_TAILQ_ENTRY(rte_power_uncore_ops) next;     /**< Next in list. */
+	TAILQ_ENTRY(rte_power_uncore_ops) next;     /**< Next in list. */
 	char name[RTE_POWER_UNCORE_DRIVER_NAMESZ];      /**< power mgmt driver. */
 	rte_power_uncore_driver_cb_t cb;                /**< Driver specific callbacks. */
 	rte_power_uncore_init_t init;                   /**< Initialize power management. */
diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index 8394cbc77f..dafacbae19 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -13,7 +13,7 @@ static enum power_management_env global_default_env = PM_ENV_NOT_SET;
 static struct rte_power_cpufreq_ops *global_cpufreq_ops;
 
 static rte_spinlock_t global_env_cfg_lock = RTE_SPINLOCK_INITIALIZER;
-static RTE_TAILQ_HEAD(, rte_power_cpufreq_ops) cpufreq_ops_list =
+static TAILQ_HEAD(, rte_power_cpufreq_ops) cpufreq_ops_list =
 			TAILQ_HEAD_INITIALIZER(cpufreq_ops_list);
 
 const char *power_env_str[] = {
@@ -55,7 +55,7 @@ rte_power_check_env_supported(enum power_management_env env)
 	if (env >= RTE_DIM(power_env_str))
 		return 0;
 
-	RTE_TAILQ_FOREACH(ops, &cpufreq_ops_list, next)
+	TAILQ_FOREACH(ops, &cpufreq_ops_list, next)
 		if (strncmp(ops->name, power_env_str[env],
 				RTE_POWER_DRIVER_NAMESZ) == 0)
 			return ops->check_env_support();
@@ -77,7 +77,7 @@ rte_power_set_env(enum power_management_env env)
 		goto out;
 	}
 
-	RTE_TAILQ_FOREACH(ops, &cpufreq_ops_list, next)
+	TAILQ_FOREACH(ops, &cpufreq_ops_list, next)
 		if (strncmp(ops->name, power_env_str[env],
 				RTE_POWER_DRIVER_NAMESZ) == 0) {
 			global_cpufreq_ops = ops;
@@ -123,7 +123,7 @@ rte_power_init(unsigned int lcore_id)
 	POWER_LOG(INFO, "Env isn't set yet!");
 
 	/* Auto detect Environment */
-	RTE_TAILQ_FOREACH(ops, &cpufreq_ops_list, next) {
+	TAILQ_FOREACH(ops, &cpufreq_ops_list, next) {
 		POWER_LOG(INFO,
 			"Attempting to initialise %s cpufreq power management...",
 			ops->name);
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index b50e09a2ad..15f3e1f3ab 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -14,7 +14,7 @@ static enum rte_uncore_power_mgmt_env global_uncore_env = RTE_UNCORE_PM_ENV_NOT_
 static struct rte_power_uncore_ops *global_uncore_ops;
 
 static rte_spinlock_t global_env_cfg_lock = RTE_SPINLOCK_INITIALIZER;
-static RTE_TAILQ_HEAD(, rte_power_uncore_ops) uncore_ops_list =
+static TAILQ_HEAD(, rte_power_uncore_ops) uncore_ops_list =
 			TAILQ_HEAD_INITIALIZER(uncore_ops_list);
 
 const char *uncore_env_str[] = {
@@ -68,7 +68,7 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 		env = RTE_UNCORE_PM_ENV_INTEL_UNCORE;
 
 	if (env < RTE_DIM(uncore_env_str)) {
-		RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
+		TAILQ_FOREACH(ops, &uncore_ops_list, next)
 			if (strncmp(ops->name, uncore_env_str[env],
 				RTE_POWER_UNCORE_DRIVER_NAMESZ) == 0) {
 				global_uncore_env = env;
@@ -115,7 +115,7 @@ rte_power_uncore_init(unsigned int pkg, unsigned int die)
 		return global_uncore_ops->init(pkg, die);
 
 	/* Auto Detect Environment */
-	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
+	TAILQ_FOREACH(ops, &uncore_ops_list, next)
 		if (ops) {
 			POWER_LOG(INFO,
 				"Attempting to initialise %s power management...",
diff --git a/lib/table/rte_swx_table.h b/lib/table/rte_swx_table.h
index cf7dcea8a1..b6ab2c59d7 100644
--- a/lib/table/rte_swx_table.h
+++ b/lib/table/rte_swx_table.h
@@ -73,7 +73,7 @@ struct rte_swx_table_entry {
 	/** Used to facilitate the membership of this table entry to a
 	 * linked list.
 	 */
-	RTE_TAILQ_ENTRY(rte_swx_table_entry) node;
+	TAILQ_ENTRY(rte_swx_table_entry) node;
 
 	/** Key value for the current entry. Array of *key_size* bytes or NULL
 	 * if the *key_size* for the current table is 0.
@@ -116,7 +116,7 @@ struct rte_swx_table_entry {
 };
 
 /** List of table entries. */
-RTE_TAILQ_HEAD(rte_swx_table_entry_list, rte_swx_table_entry);
+TAILQ_HEAD(rte_swx_table_entry_list, rte_swx_table_entry);
 
 /**
  * Table memory footprint get
diff --git a/lib/table/rte_swx_table_selector.h b/lib/table/rte_swx_table_selector.h
index ef29bdb6b0..52d4dbe568 100644
--- a/lib/table/rte_swx_table_selector.h
+++ b/lib/table/rte_swx_table_selector.h
@@ -55,7 +55,7 @@ struct rte_swx_table_selector_params {
 /** Group member parameters. */
 struct rte_swx_table_selector_member {
 	/** Linked list connectivity. */
-	RTE_TAILQ_ENTRY(rte_swx_table_selector_member) node;
+	TAILQ_ENTRY(rte_swx_table_selector_member) node;
 
 	/** Member ID. */
 	uint32_t member_id;
@@ -65,7 +65,7 @@ struct rte_swx_table_selector_member {
 };
 
 /** List of group members. */
-RTE_TAILQ_HEAD(rte_swx_table_selector_member_list, rte_swx_table_selector_member);
+TAILQ_HEAD(rte_swx_table_selector_member_list, rte_swx_table_selector_member);
 
 /** Group parameters. */
 struct rte_swx_table_selector_group {
diff --git a/lib/vhost/iotlb.c b/lib/vhost/iotlb.c
index f2c275a7d7..2198eeb080 100644
--- a/lib/vhost/iotlb.c
+++ b/lib/vhost/iotlb.c
@@ -115,7 +115,7 @@ vhost_user_iotlb_pending_remove_all(struct virtio_net *dev)
 
 	rte_rwlock_write_lock(&dev->iotlb_pending_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next, temp_node) {
+	TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next, temp_node) {
 		TAILQ_REMOVE(&dev->iotlb_pending_list, node, next);
 		vhost_user_iotlb_pool_put(dev, node);
 	}
@@ -181,7 +181,7 @@ vhost_user_iotlb_pending_remove(struct virtio_net *dev, uint64_t iova, uint64_t
 
 	rte_rwlock_write_lock(&dev->iotlb_pending_lock);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next,
+	TAILQ_FOREACH_SAFE(node, &dev->iotlb_pending_list, next,
 				temp_node) {
 		if (node->iova < iova)
 			continue;
@@ -203,7 +203,7 @@ vhost_user_iotlb_cache_remove_all(struct virtio_net *dev)
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
 		vhost_user_iotlb_clear_dump(dev, node, NULL, NULL);
 
 		TAILQ_REMOVE(&dev->iotlb_list, node, next);
@@ -226,9 +226,9 @@ vhost_user_iotlb_cache_random_evict(struct virtio_net *dev)
 
 	entry_idx = rte_rand() % dev->iotlb_cache_nr;
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
 		if (!entry_idx) {
-			struct vhost_iotlb_entry *next_node = RTE_TAILQ_NEXT(node, next);
+			struct vhost_iotlb_entry *next_node = TAILQ_NEXT(node, next);
 
 			vhost_user_iotlb_clear_dump(dev, node, prev_node, next_node);
 
@@ -314,13 +314,13 @@ vhost_user_iotlb_cache_remove(struct virtio_net *dev, uint64_t iova, uint64_t si
 
 	vhost_user_iotlb_wr_lock_all(dev);
 
-	RTE_TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
+	TAILQ_FOREACH_SAFE(node, &dev->iotlb_list, next, temp_node) {
 		/* Sorted list */
 		if (unlikely(iova + size < node->iova))
 			break;
 
 		if (iova < node->iova + node->size) {
-			struct vhost_iotlb_entry *next_node = RTE_TAILQ_NEXT(node, next);
+			struct vhost_iotlb_entry *next_node = TAILQ_NEXT(node, next);
 
 			vhost_user_iotlb_clear_dump(dev, node, prev_node, next_node);
 
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index 4f2b7e0013..75c34f4d66 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -137,7 +137,7 @@ rte_vdpa_unregister_device(struct rte_vdpa_device *dev)
 	int ret = -1;
 
 	rte_spinlock_lock(&vdpa_device_list_lock);
-	RTE_TAILQ_FOREACH_SAFE(cur_dev, vdpa_device_list, next, tmp_dev) {
+	TAILQ_FOREACH_SAFE(cur_dev, vdpa_device_list, next, tmp_dev) {
 		if (dev != cur_dev)
 			continue;
 
diff --git a/lib/vhost/vdpa_driver.h b/lib/vhost/vdpa_driver.h
index 42392a0d14..db640013ef 100644
--- a/lib/vhost/vdpa_driver.h
+++ b/lib/vhost/vdpa_driver.h
@@ -87,7 +87,7 @@ struct rte_vdpa_dev_ops {
  * vdpa device structure includes device address and device operations.
  */
 struct rte_vdpa_device {
-	RTE_TAILQ_ENTRY(rte_vdpa_device) next;
+	TAILQ_ENTRY(rte_vdpa_device) next;
 	/** Generic device information */
 	struct rte_device *device;
 	/** vdpa device operations */
-- 
2.53.0

