Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D35DC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BBEC40685;
	Tue,  4 Aug 2026 17:46:31 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id EFDBC40685
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:28 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbb662575d3so2692754a12.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858388;
 x=1786463188; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9kkitIcACETudCuT+/j9pUjDFYrlmx4NX5ndvaDZ7s=;
 b=PPtfrl9XAoNFUnxmmGt/+kvLuTEGQa1Xd093RO9IjoPXj5iMvh0+phn9Z3W0rGrPXt
 z8DFy+OWA0fo7b6mkvtgukXfVPbNvFrN1FcSsy/cZABNghZbky0Hs+RTnQSO+B32iVEy
 rZz0l543CYfkSwinN3dfeOq822cSfYr8YWoIEUSx1N2lD2xChmsCnG7xpw/ZgEsNJLtY
 bPkttRYf1XUkWLqPsawulCS7cYIfdR8OqT0910+rguGEVsQemKOhaba18iot5Q3YjKlB
 xrCZ275TDwgHj5ACffJ+IxFZgHd9kHVmOllXA0qfdu/UxEEU8wQm+8MbXdfzMH63MWyK
 xxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858388; x=1786463188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o9kkitIcACETudCuT+/j9pUjDFYrlmx4NX5ndvaDZ7s=;
 b=ZG5ENCt63f8JfBrbW8EZw6aVgbhKsqJDkLXCl/QELGhY+KMeqRPmMKy1bJc/nmAO8+
 W9MYYGiULmi9yMfQy4ey8skMEBqDKFcq2FG4cTuke6w1rpPhhvlmffjGw3nmNO6BeNJ3
 Ho1Lr9sluql06TE8Bm6vwz7rhvB6YkRz/LGOR5kN/GfbLI5k8c4ryFYhJh3fq4Cf9d1V
 95/JqMUJR4gx4Xu2IDn+8LrW7F8KCfoXNBiX/FHjwQfNp3OjN4VzRWOkrroINCosToZF
 MuAC9q8mR1CxWDvmrISVMdpur1TuhJeMnHV9z/OX8EZDDrpW1VeS7OahSkWVM4rRViIu
 Lmyg==
X-Gm-Message-State: AOJu0YxaQvbk4z9my6jMs17Y7k1LUOHnk3kOmnFfznKGTBZSSNYlDkhP
 13guPU4/cRB/gfDQfnAArng77p05EGIQhvW78eYtSaJKOEWdrZhahnUxzpayZrVjHpx+P2JH5Aw
 5vrwS
X-Gm-Gg: AR+sD12GOaCB2srYbJRLoIcvczo6Myc/El0fSWHVUom3F2rrm8/peUR8bVGpnAchFwd
 xvv1NGGFuCBNHv2I8VGPGpfF4g8NhiOYbHy8A0VXNIGS74NWtro/cX0ATEUg4EXf65/+xsgFUqi
 gwCRDAHpCFquNQGLg9oLVQmsGWlBuE/3vgRc5ToSQovsXFiIhWcQJE/2FciAUaAJ9KZ0HrBPaf2
 YxPFD3uoq23SoNfB0JE0rZtRep7Mnf2l5mpfaGK5J0dKyPC841GJepwrvBqHCwBihiXhZkUB4WE
 0sOWnDRqHDyE2XqxSuUgj+Ftx0XVvzvr0QDQD7mUH5z0iA8yTxBgwgMyv2Ep7hxURS8lMCPrTLJ
 uQ6ROQe4KNMkPd0nz5GMJNLXdbtXLxcUf26sI5shS/wEeRAF3iMF2UtbD7ElPRxcMD4JsjPUFHZ
 MDirrgNd36iFfc2IGuXvFIHJ1rtfuVJuT1NapmmHkAplhogcC5GObKDjFlYSMFAt/4L8P5QIq/A
 zShfJzq/7yQc8rFYO/kceGfqow=
X-Received: by 2002:a17:902:d590:b0:2ca:3b31:ef4f with SMTP id
 d9443c01a7336-2d052415ceamr142281345ad.40.1785858383309; 
 Tue, 04 Aug 2026 08:46:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 23/23] doc: add release note about rte_ethdev changes
Date: Tue,  4 Aug 2026 08:45:11 -0700
Message-ID: <20260804154549.148691-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

The changes to rte_ethdev are visible to applications,
which may need to include some network headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a5e049ac04 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,15 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Removed the experimental flow director API:
+
+  * ixgbe: ``rte_pmd_ixgbe_get_fdir_info``, ``rte_pmd_ixgbe_get_fdir_stats``
+  * i40e: ``rte_pmd_i40e_get_fdir_info``, ``rte_pmd_i40e_get_fdir_stats``
+
+* Removed some testpmd commands:
+
+  The ``fdir`` option in ``show port`` and ``clear port`` were removed.
+
 
 API Changes
 -----------
@@ -93,6 +102,16 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Changed ethdev include files.**
+
+  * Dropped inclusion of ``rte_flow.h`` in ``rte_ethdev.h``.
+    Applications using flow API should include it directly.
+  * Network headers ``rte_ip.h``, ``rte_udp.h``, ``rte_tcp.h`` and ``rte_sctp.h``
+    are no longer indirectly included by ``rte_ethdev.h``.
+    Applications should include network headers as needed.
+  * Legacy flow director definitions are no longer included by ``rte_ethdev.h``.
+    ``rte_eth_ctrl.h`` is removed. Internal driver definitions were moved to ``ethdev_fdir.h``.
+
 
 ABI Changes
 -----------
-- 
2.53.0

