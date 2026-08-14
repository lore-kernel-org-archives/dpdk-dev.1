Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9CDC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2199B40DFB;
	Fri, 14 Aug 2026 14:55:05 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 74A9940695;
 Fri, 14 Aug 2026 14:54:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A6B76E0B4D;
 Fri, 14 Aug 2026 16:54:57 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A6B76E0B4D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712098;
 bh=y+juGF+r5fjPcxigvukUTKl8kKd3pNGk5uGJos1mtOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cOyv0xprd0z/43hTni44W6MzRh3u/bKDYwawc1giwnL+Ut+7tpBDTadhHLVyZpw4/
 vSg0FsIqqsNXYfWHeX4psZNGIw7/dYfkY9HH4tfctAl9N/Hs+3q+dZL0JnFJVoCgil
 ctLB7k+LwKGN01JyNoz2DT0xfbAnjDa3vhsGN9wzckQAfxFhInIFNB8G0GSHw/l9oI
 n/6V/0D6RzUA9qJ8jOgtdiMlOAhPVn+mVnZ3ZBMoXf0Udqkei6E84Ky1Rj031RSWf3
 r+O7IV99rCWUjLTAlRo0ibGiGboR3/HQBzMhm4TunbBMmYEAm5X3MdWZGRjteujp+e
 kfPagsEUMGCJA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 13/14] common/sfc_efx/base: rework SW mask to HW enum
 converter
Date: Fri, 14 Aug 2026 16:54:37 +0400
Message-ID: <20260814125438.13283-14-ivan.malov@arknetworks.am>
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

Code analysis reports that *enum_hwp is not written on successful
return on some paths through this function. Refactor to simplify the
code, and adjust the annotations so it is clear that *enum_hwp is only
written on successful return. Adjust FEC handling in efx_np_link_ctrl
to allow for *supportedp always being updated.

Code analysis also reports that the optional filter_arg can be NULL
when invoking filter_cb, but the callback argument is not optional.
Check that filter_arg is non-NULL to ensure correct usage.

The refactoring adds an explicit default for the HW enum for the case when
no software capability bit is found in the map. For the link technology,
this default becomes AUTO, replacing the implicit NONE. This change is
intentional and yields the correct instruction to firmware.

Fixes: 8e79cd30230d ("common/sfc_efx/base: implement PHY link control for Medford4")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 68 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 6fc024e17b..06cb33e39b 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1211,60 +1211,59 @@ efx_np_cap_mask_sw_to_hw(
 	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
 	    (_filter_cb), (_filter_arg), (_mask_hwp))
 
-static					void
+__success(*supportedp != 0)	static	void
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
+	uint32_t matched_mask = 0;
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
 
-		++(hw_sw_map);
+		if (enum_hwp != NULL && (matched_mask & flag_sw) == 0)
+			*enum_hwp = hw_sw_map[i].encm_hw;
+
+		matched_mask |= flag_sw;
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
@@ -1276,12 +1275,13 @@ efx_np_cap_sw_mask_to_hw_enum(
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
 
@@ -1396,6 +1396,7 @@ efx_np_link_ctrl(
 	} else {
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_tech,
 		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    MC_CMD_ETH_TECH_AUTO,
 		    efx_np_filter_tech_by_lane_count_cb, &lane_count,
 		    &supported, &link_tech);
 
@@ -1424,10 +1425,9 @@ efx_np_link_ctrl(
 		 */
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
 		    ETH_AN_FIELDS_FEC_MASK, cap_data_raw, cap_mask_sw,
-		    NULL, NULL, &supported, &cap_enum_hw);
+		    cap_enum_hw, NULL, NULL, &supported, &cap_enum_hw);
 
-		if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0
-		    && supported == B_FALSE) {
+		if (supported == B_FALSE) {
 			rc = ENOTSUP;
 			goto fail5;
 		}
-- 
2.47.3

