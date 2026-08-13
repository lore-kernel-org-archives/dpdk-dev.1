Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB4C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4921842DA6;
	Thu, 13 Aug 2026 20:04:20 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id E7D5642DC1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:18 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so164395a91.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644258;
 x=1787249058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtBFUn4LVAbHzA850SWpOnoyY143F4d2DK6KtGi9H3g=;
 b=SRnCdDJYV8fRL9NZpf01lluMBPH+lnbKea/RGc5KVzLGq8+UXG/NkendoAQH8RKyiN
 cfteUc7/LZ1a21mHjDviyPAlkeCEG2s8t70KKeVg3LjcTexK1feJ6GNarV1VnGsZMOy7
 AbfqC/VKrBdLAEERxGNHVgl24DO9+jQ2CPdCx5VZ+XPyvYTGg1Q9Vp51N2SmOok3+T1E
 vRS9tobk5dAi2gco7+D6UKkT6WP1epV8vxP1aaaVf6glgLeNgLEW8qYxqLcvQ9Wgd/fe
 XefuekjdgqPPih96YSCMlagDsYvgFUdfGoJBtBHJQksbXl7J+D/yY09Tc7YHPqfMhqMc
 t2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644258; x=1787249058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtBFUn4LVAbHzA850SWpOnoyY143F4d2DK6KtGi9H3g=;
 b=Fnu/s51sKn3cUkDc2bgJRBMRKugqql/nPI7IxjW8JJoqKL3lpkDPwtPdrKLYBX4if0
 wJk7cztdmhVJhiikM/pppgVnlKk4KJKBH7JiHREzWNsDIUSNJSTVM+HAaAV2SdgZ1w0R
 hLh9ADd3OjE9Rq9ovAaMYrhoPuzbgMDX7GbLkUTwLlqcH4YGw02BkqFqxq13iJxvzbSL
 TjbRmeFRIAm9dmz4gd9feH8eg5r4Kr1CPFjPvkjIytl0ioIab691kEXS5g6tutm5vWZp
 vfBSC7V0ax15rkpaDNxftItk8yyQWQrIiTuX+7ln9igJ6ZMXcCVWod2ybBB8YvpeGjhH
 gDwA==
X-Gm-Message-State: AOJu0YyDhrpyOddTvkzybAVCnodIx5+m4N3sTbgfIMZ9HAVjO/L7C4nl
 GDO3QN/KN5jExgwUlUOq2VMFpetMvV3zNTuncxsltLx5f2ViDQCWq6JYka23K3RjolYkuipXpMi
 SxCvp
X-Gm-Gg: AR+sD11+aIoi41JfbhtEWPIs3Mi7lJ71eR8iSL2dB48+9+TMtOOZoHg/vO2uCPi12sk
 yy8imugE6mmGKjShqA0qPUsEHj8OZ17pYF28ySog0M9VulNzbwslC3KAHKPrOlySSw13CnodTiw
 3B3ONzaEmmSmjq6jBS2/J1XRiCVTMj/UxmLM3GlQuzCZMBP5ihyI9dk5PgnnO/XRmM+RaADXfqA
 E+jlMuckPSV/eTbG8dEmFNWHjIV6lCxTo3PVF+Y8WOgN1myKQGT1CoOnEM3OGXutGjej2A9uTt5
 ZG+QxafydzsU4eKR/RSQikHFzk1/NeqS4nN++WH4rtDpmWC2z8aN4eD503klvMJU+u/G4yuLBU/
 XDrX0GbTitUKQ01OaA4Dk/xIAzPeMG9U+/htWBdsTcVvrlRx8aeEsmhkLgG3YBKiaSpRRFwSN/S
 q4RhIkwNcIRMdcKTl/0P74PYmoCXVGo0pSkOW9Q26r6d4krODbj3MJIGFysaf3nR+QbNThw/6Ud
 VvgIcrz1XmCq322Eba61jxt/c0=
X-Received: by 2002:a17:90b:388d:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-3931e3278f4mr8348299a91.19.1786644257805; 
 Thu, 13 Aug 2026 11:04:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 02/16] app/testpmd: remove leftover set qmap
Date: Thu, 13 Aug 2026 10:55:01 -0700
Message-ID: <20260813180402.622784-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

The function set_qmap was removed in 25.11 release but
the prototype was still there.

Also, remove leftover help text.

Fixes: 2863cbd9ee6d ("ethdev: deprecate queue stats mapping functions")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c                      |  6 ------
 app/test-pmd/testpmd.h                      |  2 --
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 11 -----------
 3 files changed, 19 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..d299edb88e 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -581,12 +581,6 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"set port (port_id) rxq (queue_id) avail_thresh (0..99)>\n "
 			"    set available descriptors threshold for Rx queue\n\n"
 
-			"set stat_qmap (tx|rx) (port_id) (queue_id) (qmapping)\n"
-			"    Set statistics mapping (qmapping 0..15) for RX/TX"
-			" queue on port.\n"
-			"    e.g., 'set stat_qmap rx 0 2 5' sets rx queue 2"
-			" on port 0 to mapping 5.\n\n"
-
 			"set xstats-hide-zero on|off\n"
 			"    Set the option to hide the zero values"
 			" for xstats display.\n"
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 083171853c..b5643e74f5 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1158,8 +1158,6 @@ void tx_qinq_set(portid_t port_id, uint16_t vlan_tci, uint16_t vlan_tci_outer);
 void tx_vlan_reset(portid_t port_id);
 void tx_vlan_pvid_set(portid_t port_id, uint16_t vlan_id, int on);
 
-void set_qmap(portid_t port_id, uint8_t is_rx, uint16_t queue_id, uint8_t map_value);
-
 void set_xstats_hide_zero(uint8_t on_off);
 void set_xstats_show_state(uint8_t on_off);
 void set_xstats_hide_disabled(uint8_t on_off);
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e65376df54..30cac0ad8c 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1554,17 +1554,6 @@ Set available descriptors threshold for a specific Rx queue of port::
 
 Use 0 value to disable the threshold and corresponding event.
 
-set stat_qmap
-~~~~~~~~~~~~~
-
-Set statistics mapping (qmapping 0..15) for RX/TX queue on port::
-
-   testpmd> set stat_qmap (tx|rx) (port_id) (queue_id) (qmapping)
-
-For example, to set rx queue 2 on port 0 to mapping 5::
-
-   testpmd>set stat_qmap rx 0 2 5
-
 set xstats-hide-zero
 ~~~~~~~~~~~~~~~~~~~~
 
-- 
2.53.0

