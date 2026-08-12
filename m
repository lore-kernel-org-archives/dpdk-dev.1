Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B924C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25F88427E9;
	Wed, 12 Aug 2026 19:09:00 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6F918427A5;
 Wed, 12 Aug 2026 19:08:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A041BE0AD0;
 Wed, 12 Aug 2026 21:08:53 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A041BE0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554534;
 bh=tn5+AaXtA1pGc2mXhpWmv/rQyP3BwlZNwmDs6zaQm2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=75L6b3UJuCT82dOPNDOlIIciocOTWoaPeN/9Cfg/+FLPyf7JFLAlqyei3ZAz9v7Bl
 GlD3ved6DYIGv9kjcocxPRg/kI5lTejGvaReHGZGr2cuMFeXOx4BRH87R6K/N3VS2N
 2X6q1CX8rGheB8Mo1kAVAiZ7midDrel/c+OGr+LlmINR2uFKHjHU1DYzZ5PTxD6LiX
 bIrY7ysAZoXuBYZssWKQfYoAaARWyyI09YtLhHeCi5m6bo4Wnk34/v5B9WMn5Q4Yf1
 fESpbq3nXhgiEg44xxoh3rT8biXgczoN5nVseGjqc25ye4wyNt5O0pjJVjLN+Lr8ZU
 02hRoA5HzIE9g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 13/14] common/sfc_efx/base: rework SW mask to HW enum
 converter
Date: Wed, 12 Aug 2026 21:08:33 +0400
Message-ID: <20260812170834.8443-14-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812170834.8443-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260812170834.8443-1-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_np.c | 67 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index a5003536c1..293f587892 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1203,6 +1203,7 @@ efx_np_cap_mask_sw_to_hw(
 	    MC_CMD_##_hw_cap_section##_LEN, (_mask_sw),			\
 	    (_filter_cb), (_filter_arg), (_mask_hwp))
 
+__success(*supportedp != 0)
 static					void
 efx_np_cap_sw_mask_to_hw_enum(
 	__in_ecount(hw_sw_map_nentries)	const struct efx_np_cap_map *hw_sw_map,
@@ -1210,53 +1211,52 @@ efx_np_cap_sw_mask_to_hw_enum(
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
+
+		if (enum_hwp != NULL && (matched_mask & flag_sw) == 0)
+			*enum_hwp = hw_sw_map[i].encm_hw;
 
-		++(hw_sw_map);
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
@@ -1268,12 +1268,13 @@ efx_np_cap_sw_mask_to_hw_enum(
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
 
@@ -1388,6 +1389,7 @@ efx_np_link_ctrl(
 	} else {
 		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_tech,
 		    ETH_AN_FIELDS_TECH_MASK, cap_data_raw, cap_mask_sw,
+		    MC_CMD_ETH_TECH_AUTO,
 		    efx_np_filter_tech_by_lane_count_cb, &lane_count,
 		    &supported, &link_tech);
 
@@ -1416,10 +1418,9 @@ efx_np_link_ctrl(
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

