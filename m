Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8392C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0400E40E0F;
	Fri, 14 Aug 2026 14:55:06 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4286240A7F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:54:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 882B3E0F0C;
 Fri, 14 Aug 2026 16:54:58 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 882B3E0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712099;
 bh=vPlvcwGgHIFAmTwCexb1LR6e49byDrLanbdeXOtJzoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zLHQI4NiTBwnvWggLtf4elxM0BtPhOiLvtHs+9dAVXEUWuTkWiwQjm5zxTRqX6mHS
 k0lkUFwHxVVpTXSvxDgKWyip4siMSV2Z2SooJrcNonOlxScFVvAiFxnEr41l2V2Fo3
 pckHVPtSiyA0CMKervrWSZAGw9MpOIix71wH7W6L0BXa5uXra6DgkGLEfbNKve70XY
 OOIQa479Dpgss7/qq7yptK0C2xHQow7Fz343R6nZpcqVNlOzlYtp33bDe0M84Z3mHT
 7zE95nlKvB7kqPf6LIfQR2vK25ajoXCl0wZORJq9/TMUctIqz3FiEdxjS3Ry0EGmu/
 qRvbrjzGKHGpA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 14/14] common/sfc_efx/base: cleanup wider type comparisons
 in loops
Date: Fri, 14 Aug 2026 16:54:38 +0400
Message-ID: <20260814125438.13283-15-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125438.13283-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125438.13283-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

CodeQL reports errors for comparisons between narrow and wider
types in loop conditions [cpp/infiniteloop]. Use the wider types
to fix that.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_filter.c | 2 +-
 drivers/common/sfc_efx/base/ef10_mcdi.c   | 2 +-
 drivers/common/sfc_efx/base/ef10_nvram.c  | 4 ++--
 drivers/common/sfc_efx/base/efx_bootcfg.c | 2 +-
 drivers/common/sfc_efx/base/mcdi_mon.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/ef10_filter.c b/drivers/common/sfc_efx/base/ef10_filter.c
index 2fdccfdc2b..f36d159372 100644
--- a/drivers/common/sfc_efx/base/ef10_filter.c
+++ b/drivers/common/sfc_efx/base/ef10_filter.c
@@ -1300,7 +1300,7 @@ ef10_filter_supported_filters(
 	size_t mcdi_list_length;
 	size_t mcdi_encap_list_length;
 	size_t list_length;
-	uint32_t i;
+	size_t i;
 	uint32_t next_buf_idx;
 	size_t next_buf_length;
 	efx_rc_t rc;
diff --git a/drivers/common/sfc_efx/base/ef10_mcdi.c b/drivers/common/sfc_efx/base/ef10_mcdi.c
index f852d1cde3..6f3492efe4 100644
--- a/drivers/common/sfc_efx/base/ef10_mcdi.c
+++ b/drivers/common/sfc_efx/base/ef10_mcdi.c
@@ -140,7 +140,7 @@ ef10_mcdi_send_request(
 	const efx_mcdi_transport_t *emtp = enp->en_mcdi.em_emtp;
 	efsys_mem_t *esmp = emtp->emt_dma_mem;
 	efx_dword_t dword;
-	unsigned int pos;
+	size_t pos;
 
 	EFSYS_ASSERT(EFX_FAMILY_IS_EF100(enp) || EFX_FAMILY_IS_EF10(enp));
 
diff --git a/drivers/common/sfc_efx/base/ef10_nvram.c b/drivers/common/sfc_efx/base/ef10_nvram.c
index ce8357fa94..fd9564760a 100644
--- a/drivers/common/sfc_efx/base/ef10_nvram.c
+++ b/drivers/common/sfc_efx/base/ef10_nvram.c
@@ -2386,7 +2386,7 @@ ef10_nvram_type_to_partn(
 	efx_mcdi_iface_t *emip = &(enp->en_mcdi.em_emip);
 	ef10_parttbl_entry_t *parttbl = NULL;
 	size_t parttbl_rows = 0;
-	unsigned int i;
+	size_t i;
 
 	EFSYS_ASSERT3U(type, !=, EFX_NVRAM_INVALID);
 	EFSYS_ASSERT3U(type, <, EFX_NVRAM_NTYPES);
@@ -2418,7 +2418,7 @@ ef10_nvram_partn_to_type(
 	efx_mcdi_iface_t *emip = &(enp->en_mcdi.em_emip);
 	ef10_parttbl_entry_t *parttbl = NULL;
 	size_t parttbl_rows = 0;
-	unsigned int i;
+	size_t i;
 
 	EFSYS_ASSERT(typep != NULL);
 
diff --git a/drivers/common/sfc_efx/base/efx_bootcfg.c b/drivers/common/sfc_efx/base/efx_bootcfg.c
index c5b8182a3d..83379ea34c 100644
--- a/drivers/common/sfc_efx/base/efx_bootcfg.c
+++ b/drivers/common/sfc_efx/base/efx_bootcfg.c
@@ -140,8 +140,8 @@ efx_dhcp_csum(
 	__in_bcount(size)	uint8_t const *data,
 	__in			size_t size)
 {
-	unsigned int pos;
 	uint8_t checksum = 0;
+	size_t pos;
 
 	for (pos = 0; pos < size; pos++)
 		checksum += data[pos];
diff --git a/drivers/common/sfc_efx/base/mcdi_mon.c b/drivers/common/sfc_efx/base/mcdi_mon.c
index 2089840d2c..c5510e53a8 100644
--- a/drivers/common/sfc_efx/base/mcdi_mon.c
+++ b/drivers/common/sfc_efx/base/mcdi_mon.c
@@ -30,7 +30,7 @@ mcdi_mon_decode_stats(
 {
 	efx_mcdi_iface_t *emip = &(enp->en_mcdi.em_emip);
 	efx_mon_stat_portmask_t port_mask;
-	uint16_t sensor;
+	size_t sensor;
 	size_t sensor_max;
 	uint32_t stat_mask[(EFX_MON_NSTATS + 31) / 32];
 	uint32_t idx = 0;
-- 
2.47.3

