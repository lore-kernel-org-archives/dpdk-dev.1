Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E23ECD6E45
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 17:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 483BE4021F;
	Thu, 28 May 2026 19:01:06 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 0BD214003C
 for <dev@dpdk.org>; Thu, 28 May 2026 19:01:04 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3042a388168so4491818eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779987664;
 x=1780592464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p0qN3HmLQpwvAAv2aFUlaxdQtixAuPkTl+hD9j/wkFs=;
 b=xiF/Epptb0xyVMgkkpcUi0jlyOTVzvaLFfr4iprFXdGRShDPy2R0PmT3NXmAI2vl07
 i7e3UW83kiqqLXQlJIyEfNCxmcwcwQVvCNN66NEPvSXUJCIFzsPr2DnpFk2rUr5rNk6l
 kVMzO8M2H85BLWeArArY72/wprt4fAogAPjCphtT0H44/bHgeoSm1N6OnUyH0R3GyNwJ
 2UiSgxdsLA1v1cYdHF6NwhNP+fY1OF/DdrRnUPEz8rk8wjlw//dfypa06wzA1xHl3efE
 oH6PGrbqmJollo0wvKuyP1GqAdMlkHiLxgWazsn0rKYW3H3DqjsJJr7G3fBvXJUz1rMf
 aq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779987664; x=1780592464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0qN3HmLQpwvAAv2aFUlaxdQtixAuPkTl+hD9j/wkFs=;
 b=No80nux0ikZwsHB+4vzpfrTGFZuh74tTJzC+wnE2QeIbsAuYftQqACLDLw2l5Yb6a6
 RHd2pXnAHRw15dfKwyEU1wvli3NQbUWelxX1Q+30Fc07mRcCiOkFShuQVt892HwGNio8
 K64R0Fy48LIU5TsRHYh0HzhzWPkO/78CmgUJADviHbl8a2xQgw/9HsmVGRvxb5ZQ7y2h
 YoqfNCQoA9EPPRZyVjhCQIp0jnCmhV2M5Kj6qvV9qiPc5DnPJVuzkYosjAaGCJXgCi5T
 dzIDoGb3fJcRUmlhelIWajeI7yQdd20nzGqyW7lXCob29pCWibRhKPk1vEw7IozV2VAs
 xDVw==
X-Gm-Message-State: AOJu0YxYSAY92OxECBG3z62OJYf9B29XpUpHhHx6+qj4UJ+Kw5Kv8IH/
 xuQVQbqkqol0M9zz5wubNFghpzH+53SNveLpow6/CA1melD46mwnwIhXe23v4nUFM2H8XVs2c19
 Ux5sw
X-Gm-Gg: Acq92OGWpm4hqlHYfAGDiB54nK+hKrjxdvW2RI0Fp8uNgPnUGdYsfctQ+tK8zYlDxdN
 5BUIAt8T1TGbYfDsofgmRVyuqw7Es4cM4X9UAHwj4kEHQyp8exSbn5jHlVzFLpkTHm9C2Q+4qFh
 /x6W1fEFLh2YC0uIto4Fhxd39b/sLon/0ORJ1dgZSg5U6ITfbqepCMAb50fAxbknlx/KAD2X522
 j1NPobZqtQAXCba1dfODGBI95/9c8Mpjga88N4TW+jrqrcdaDrpyzEs77yMBnkxpvBxucUeqNO+
 aE0vgFCiVKtk/W3JjJEYqQfJ4tyk37TxZg90JNhCZzTXCSP3kdai5cavPGfq6yyWbliFgeXy4Zn
 dYgjAAnsvpdR+YCkFEXmTO5NL/XO5z+PmwegB/njMLhLvWqU3wYsxdAlisCvb4LWudLBxA1tNk/
 JBUBGwroCyatItM6rIE1yRccH41z0IB/UPdfBJSqFscvtGfvPAic3ruE6EmfX+8aAgyDKQWJan
X-Received: by 2002:a05:693c:4004:b0:2da:13c6:f27b with SMTP id
 5a478bee46e88-304dd2befabmr671449eec.5.1779987663394; 
 Thu, 28 May 2026 10:01:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230dddsm20460574eec.17.2026.05.28.10.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:01:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] doc: announce removal of flow director
Date: Thu, 28 May 2026 10:00:58 -0700
Message-ID: <20260528170059.155964-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

There are still leftover bits in ethdev related to flow director (fdir).
Will be removing these in 26.11 so give final notice.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..f9f1d97f78 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,11 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* ethdev: The legacy filtering data structures in ``rte_eth_ctrl.h``,
+  including the flow director (FDIR) types (``rte_eth_fdir_*``, ``rte_fdir_*``)
+  and the ntuple/ethertype/SYN/tunnel/input-set filter types, are superseded
+  by the ``rte_flow`` API and will be removed in DPDK 26.11. The associated
+  driver-facing definitions in ``ethdev_driver.h`` (``RTE_ETH_FILTER_FDIR``,
+  ``struct rte_eth_fdir_conf``, ``enum rte_eth_fdir_pballoc_type``,
+  ``enum rte_fdir_status_mode``) will be removed at the same time.
-- 
2.53.0

