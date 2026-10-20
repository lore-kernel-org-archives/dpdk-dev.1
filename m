Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967A606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PiLipAKL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C1E6406BA;
	Tue, 20 Oct 2026 17:21:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6D5354067A;
 Tue, 20 Oct 2026 17:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509692; x=1824045692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rYL4wUnLiikxwIt6l8l150XF1xgPZ8+IXmQqKS+BUhw=;
 b=PiLipAKLYIpfo7uGhD/g8NRtBXyY/3GvzGBhoEm2nJ7Ijk2Fsj+zqC+O
 /5ySlRs44YYtlneXCr20ERSka+V5ucK7CI+WTsTss7aDGqhEnc/OEiPUi
 LzsNzjxN+sgm2sCRSKPPuFYLgAQybM2meZ2geim/XW1bKWIsg1M/3j3Qf
 29iR3UIa65c9nj0bqU4W4QTBH2F+bTbAdskN+Z6x3gh4qRf2s2DTc7Za+
 GchRNDZ5MFvgwsuXQu0puDJbIg0IKWfOZfhUBqVt7n6qa1KddobvzRmQH
 WhqT/nJXq9bk2cCx2lHNjeupodh+qP/dKqFNlhBZiIdTtYsyUdMbe9079 w==;
X-CSE-ConnectionGUID: k95U9jW3S6q5oGcS268JCw==
X-CSE-MsgGUID: vqtoYeQHSLKHQrMUN0kwxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226850"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:30 -0700
X-CSE-ConnectionGUID: Ato6OksETi6gLE/9DtL2eg==
X-CSE-MsgGUID: X0fODDsRQfWhA3ACBUxrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3240979"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:29 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com, stable@dpdk.org
Subject: [PATCH v2 3/3] net/iavf: fix crash in TM ops without QoS capability
Date: Tue, 20 Oct 2026 15:22:12 +0000
Message-ID: <b40955d28bef3581546adb8033c02dc27cb91071.1792504817.git.dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504817.git.dawid.wesierski@intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <cover.1792504817.git.dawid.wesierski@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VF allocates qos_cap and initializes the TM lists only when the PF
grants VIRTCHNL_VF_OFFLOAD_QOS. The in-tree ice PF does not grant it.
On such a VF, node add, shaper profile add, capabilities get, and node
capabilities get dereference a NULL qos_cap, or insert into a list that
has no initialization. The application gets a segmentation fault from a
call such as rte_tm_capabilities_get().

Return -ENOTSUP from these operations when qos_cap is NULL. The other
TM operations only search the lists, or check VIRTCHNL_VF_OFFLOAD_QOS
already, so they do not need the check.

Fixes: 44d0a720a538 ("net/iavf: query QoS capabilities and set queue TC mapping")
Cc: stable@dpdk.org

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
- Add Acked-by. No change.
 drivers/net/intel/iavf/iavf_tm.c | 37 ++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 57075ee5b8..07ba58f6f5 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -102,6 +102,18 @@ iavf_tm_conf_uninit(struct rte_eth_dev *dev)
 	vf->qtc_map = NULL;
 }
 
+/* qos_cap and the TM lists exist only if the PF grants VIRTCHNL_VF_OFFLOAD_QOS. */
+static int
+iavf_tm_qos_check(struct iavf_info *vf, struct rte_tm_error *error)
+{
+	if (vf->qos_cap != NULL)
+		return 0;
+
+	error->type = RTE_TM_ERROR_TYPE_CAPABILITIES;
+	error->message = "VF has no QoS capability";
+	return -ENOTSUP;
+}
+
 static inline struct iavf_tm_node *
 iavf_tm_node_search(struct rte_eth_dev *dev,
 		    uint32_t node_id, enum iavf_tm_node_type *node_type)
@@ -279,12 +291,18 @@ iavf_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	struct iavf_tm_shaper_profile *shaper_profile = NULL;
 	struct iavf_tm_node *tm_node;
 	struct iavf_tm_node *parent_node;
-	uint16_t tc_nb = vf->qos_cap->num_elem;
+	uint16_t tc_nb;
 	int ret;
 
 	if (!params || !error)
 		return -EINVAL;
 
+	ret = iavf_tm_qos_check(vf, error);
+	if (ret)
+		return ret;
+
+	tc_nb = vf->qos_cap->num_elem;
+
 	/* if already committed */
 	if (vf->tm_conf.committed) {
 		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
@@ -524,6 +542,10 @@ iavf_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!profile || !error)
 		return -EINVAL;
 
+	ret = iavf_tm_qos_check(vf, error);
+	if (ret)
+		return ret;
+
 	ret = iavf_shaper_profile_param_check(profile, error);
 	if (ret)
 		return ret;
@@ -588,11 +610,17 @@ iavf_tm_capabilities_get(struct rte_eth_dev *dev,
 			 struct rte_tm_error *error)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	uint16_t tc_nb = vf->qos_cap->num_elem;
+	uint16_t tc_nb;
+	int ret;
 
 	if (!cap || !error)
 		return -EINVAL;
 
+	ret = iavf_tm_qos_check(vf, error);
+	if (ret)
+		return ret;
+
+	tc_nb = vf->qos_cap->num_elem;
 	if (tc_nb > vf->vf_res->num_queue_pairs)
 		return -EINVAL;
 
@@ -744,10 +772,15 @@ iavf_node_capabilities_get(struct rte_eth_dev *dev,
 	enum iavf_tm_node_type node_type;
 	struct virtchnl_qos_cap_elem tc_cap;
 	struct iavf_tm_node *tm_node;
+	int ret;
 
 	if (!cap || !error)
 		return -EINVAL;
 
+	ret = iavf_tm_qos_check(vf, error);
+	if (ret)
+		return ret;
+
 	if (node_id == RTE_TM_NODE_ID_NULL) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 		error->message = "invalid node id";
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

