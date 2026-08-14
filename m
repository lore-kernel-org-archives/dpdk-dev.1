Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D5C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFED44028F;
	Fri, 14 Aug 2026 22:20:01 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7901A4028D
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:00 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc11a30a259so497501a12.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738799;
 x=1787343599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtBFUn4LVAbHzA850SWpOnoyY143F4d2DK6KtGi9H3g=;
 b=X0ApG/RuCX4lHt3UNqXbZWCrLO85nMXIKDxkNMlmVoxzDUQh5cnIzbjAMfP1NirZhB
 63kw6COUY+AXPAMLpTywhKeBmzYnUoFxRBVWuAlq/7mEw3JEwgEffmTlzgzBuyoIk3qn
 YGYOmpU7CgMUf74jp8lU653BnuHv1YX9fOdhGjnylUhljakic7CrVNOOYukO93NftXuQ
 iBS7+bhqxHUJVIHpy/x6MIj8QnAY6fNzj1rUvAhzAOMWLhXPwgXLdlNdPei7/0uc2eGE
 4VXuRx7J8pMZ9D24R5g3Iob3tk5XkQmi/7y9+BWTXw/wjxucxfG9Gf1p3L24jBtfeSC1
 OEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738799; x=1787343599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtBFUn4LVAbHzA850SWpOnoyY143F4d2DK6KtGi9H3g=;
 b=kifsoVgxo30dGP81FLZJjDWB2pr95ZhnluBIg41o7nVcDTYN8cW0CX8Tu6Zp+BCcFu
 //kYdXUnClq0INx5FuC8D4/m9RVWyfHX5YFpMILPvGoaALTZNjvRrc/myiLAslqlresZ
 PG6g7sHtjrYyr9N9PX0vstVYP4WK2nDyVCos7pkVPV8N/+W7yzef3oxfIbDdiPvsIyZg
 GInXWeAv516Y9EZ6ARjTXv8OhjYXcAlklpoiAo+XPk4ohOQZaxcTBuBvraB6XMZqIjJd
 AmEprMJ2SHLScu8COTAI7mKaXS0w77Pqif9tcvT8wRQJ5L1Q4fhyvKSYlmYbmm3jaxbw
 QbSQ==
X-Gm-Message-State: AOJu0YzcQnh9rIOX5du6RT3xPtH/xgUGV8SM4VU3wXc4GUEvruE4pVdJ
 9R16g8yE8llPv30ZUUoBwvwVGxyedj0R8izVk3QARVjCETnX+QiYA5pH2Q3wXnkntHSaen0D8F6
 X9BWF
X-Gm-Gg: AR+sD13QMRIAecjB7RUvtYUZbx0Jy++KxavHtob6gnp+3ucp8dRiPVqPEyH2u5fRtUu
 smrq+tjMCAVkHimSWYRicrWbSEZer94TqsfzQa/l6TvFS40XYqJkqVVWD6BIFVNCB58neHv7bTN
 I8ZXgLgzpi1jK4/KHLE3KbnSX9MQi4pJex4ZH7/CHHVCqf06xlECZCPOD7tsSXnsao0t/lkaoXp
 HTduXJ/n9LnEi/ufI4m8z7HhHa/w8YWbIK/6Ae/bmMn/Ia5u359bD6X3P9kPcxmMW+Ay+fifpgV
 nt03QW95Ah/2n2yaBO40mRCTG2t3hH0fFnpsoSMUEPhySeF1jUUf1lOy6X2TmV/NwThx6JzfFyA
 hyThZNeF4Fy4RAAlBmrH7Wo5unrQjpzqeBYOsRjBj6C05vPf+Shrs6OMqFb2tFfTJFrd58Kr+ZE
 bOBrEVY8qfmZ67+4W8kJXf/i8yoc+mvbPr6Vf6/+wmmv5ipfibJSxa36R3CkLI8kmLnFHTMJmri
 tGT26tM2c8vj5aCtkGFUKoplag=
X-Received: by 2002:a05:6a21:a4a:b0:3c3:9070:96b3 with SMTP id
 adf61e73a8af0-3cc71af165bmr10339182637.3.1786738799482; 
 Fri, 14 Aug 2026 13:19:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:19:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 02/16] app/testpmd: remove leftover set qmap
Date: Fri, 14 Aug 2026 12:45:58 -0700
Message-ID: <20260814194757.329424-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

