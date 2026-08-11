Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D2C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:49:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C59427DD;
	Tue, 11 Aug 2026 19:48:48 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id AB6F8427B1;
 Tue, 11 Aug 2026 19:48:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DD589E0BE5;
 Tue, 11 Aug 2026 21:48:39 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DD589E0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470520;
 bh=wOANR+U1uwnUtTQdlzY5OyM3zDZx8rjgGDXNZ9FDgTM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BKEL7u0O12W3JeesfrE02fnFQ3lsMa8EG1BpZ3Cuss9+2QcGtaU1beFapfhnvKSFv
 CrsuyENWFYk7LPnYg+VdcUVJ+mfyiCVjrm0NETF+22LSMfk81S9GAhEj94HNRSknZ9
 JdwAsE/BxIWTuWqe3s2bC87hUZmvh29tJKbSdEE3JqMMo37F5wqHv2vx4nMR/q83Gi
 QDVSP0CZN4agIAuQS/AX75cpWR4cONEVovyrlzUkIN5q04BySRJe9WqGEmPwrLL+WQ
 z6V/dVpdRhn+K3tZclDBj1e1gaTMsqjyfVW3NI8CZmKsSWU+F+xkxbhzeqKVOYubRh
 9LFnJUJkYgPjA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 13/14] common/sfc_efx/base: rework SW mask to HW enum converter
Date: Tue, 11 Aug 2026 21:48:20 +0400
Message-ID: <20260811174821.8930-14-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

Code analysis reports that *enum_hwp is not written on successful
return on some paths through this function. Refactor to simplify the
code, and adjust the annotations so it is clear that *enum_hwp is only
written on successful return. Adjust FEC handling in efx_np_link_ctrl
to allow for *supportedp always being updated.

Code analysis also reports that the optional filter_arg can be NULL
when invoking filter_cb, but the callback argument is not optional.
Check that filter_arg is non-NULL to ensure correct usage.

Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 65 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 180f24c8e5..4ba3c7d260 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1202,59 +1202,57 @@ efx_np_cap_mask_sw_to_hw(
 	    (_filter_cb), (_filter_arg), (_mask_hwp))
 
 static					void
+__success(*supportedp != 0)
 efx_np_cap_sw_mask_to_hw_enum(
 	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
 	__in				unsigned int hw_sw_map_nentries,
 	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
 	__in				size_t hw_cap_data_nbytes,
 	__in				uint32_t mask_sw,
+	__in				uint16_t enum_hw_def,
 	__in_opt			efx_np_cap_filter_cb *filter_cb,
 	__in_opt			void *filter_arg,
 	__out				boolean_t *supportedp,
 	__out_opt			uint16_t *enum_hwp)
 {
-	unsigned int sw_nflags_req = 0;
-	uint32_t sw_check_mask = 0;
+	boolean_t supported = B_FALSE;
+	uint32_t flags_seen = 0;
 	unsigned int i;
 
 	for (i = 0; i < hw_sw_map_nentries; ++i) {
-		uint32_t flag_sw = 1U << hw_sw_map->encm_sw;
-		unsigned int byte_idx = CAP_BYTE(hw_sw_map);
-		uint8_t flag_hw = CAP_FLAG(hw_sw_map);
+		uint32_t flag_sw = 1U << hw_sw_map[i].encm_sw;
+		unsigned int byte_idx = CAP_BYTE(&hw_sw_map[i]);
+		uint8_t flag_hw = CAP_FLAG(&hw_sw_map[i]);
 
-		if (byte_idx >= hw_cap_data_nbytes) {
-			++(hw_sw_map);
+		if (byte_idx >= hw_cap_data_nbytes)
 			continue;
-		}
 
-		if ((mask_sw & flag_sw) == flag_sw) {
-			if ((sw_check_mask & flag_sw) == 0)
-				++(sw_nflags_req);
+		if ((mask_sw & flag_sw) != flag_sw)
+			continue;
 
-			sw_check_mask |= flag_sw;
+		flags_seen |= flag_sw;
 
-			if ((hw_cap_data[byte_idx] & flag_hw) == flag_hw) {
-				if (filter_cb == NULL ||
-				    filter_cb(hw_sw_map->encm_hw, filter_arg) !=
-				    B_FALSE) {
-					mask_sw &= ~(flag_sw);
+		if ((hw_cap_data[byte_idx] & flag_hw) != flag_hw)
+			continue;
 
-					if (enum_hwp != NULL)
-						*enum_hwp = hw_sw_map->encm_hw;
-				}
-			}
-		}
+		if ((filter_cb != NULL) && (filter_arg != NULL) &&
+		    (filter_cb(hw_sw_map[i].encm_hw, filter_arg) == B_FALSE))
+			continue;
+
+		if (enum_hwp != NULL)
+			*enum_hwp = hw_sw_map[i].encm_hw;
 
-		++(hw_sw_map);
+		supported = B_TRUE;
 	}
 
-	if (sw_check_mask != 0 && (mask_sw & sw_check_mask) == sw_check_mask) {
-		/* Failed to select the enum by at least one capability bit. */
-		*supportedp = B_FALSE;
-		return;
+	if (flags_seen == 0) {
+		if (enum_hwp != NULL)
+			*enum_hwp = enum_hw_def;
+
+		supported = B_TRUE;
 	}
 
-	*supportedp = B_TRUE;
+	*supportedp = supported;
 }
 
 /*
@@ -1266,12 +1264,13 @@ efx_np_cap_sw_mask_to_hw_enum(
  */
 #define	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(					\
 	    _hw_sw_cap_map, _hw_cap_section, _hw_cap_data,		\
-	    _mask_sw, _filter_cb, _filter_arg, _supportedp, _enum_hwp)	\
+	    _mask_sw, _enum_hw_def, _filter_cb, _filter_arg,		\
+	    _supportedp, _enum_hwp)					\
 	efx_np_cap_sw_mask_to_hw_enum((_hw_sw_cap_map),			\
 	    EFX_ARRAY_SIZE(_hw_sw_cap_map),				\
 	    MCDI_STRUCT_MEMBER((_hw_cap_data), const uint8_t,		\
 		    MC_CMD_##_hw_cap_section),				\
-	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
+	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw), (_enum_hw_def),	\
 	    (_filter_cb), (_filter_arg),				\
 	    (_supportedp), (_enum_hwp))
 
@@ -1386,6 +1385,7 @@ efx_np_link_ctrl(
 	} else {
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_tech,
 		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    MC_CMD_ETH_TECH_AUTO,
 		    efx_np_filter_tech_by_lane_count_cb, &lane_count,
 		    &supported, &link_tech);
 
@@ -1414,10 +1414,9 @@ efx_np_link_ctrl(
 		 */
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
 		    ETH_AN_FIELDS_FEC_MASK, cap_data_raw, cap_mask_sw,
-		    NULL, NULL, &supported, &cap_enum_hw);
+		    MC_CMD_FEC_AUTO, NULL, NULL, &supported, &cap_enum_hw);
 
-		if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0
-		    && supported == B_FALSE) {
+		if (supported == B_FALSE) {
 			rc = ENOTSUP;
 			goto fail5;
 		}
-- 
2.47.3

