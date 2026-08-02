Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F48C55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D87F40DDE;
	Sun,  2 Aug 2026 20:19:10 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 37536402D8
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:19:02 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2015834a12.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694741;
 x=1786299541; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uiujdLukiIwZwpMjz6TZ/4zxzNqefR9RbQJvbFOWlCM=;
 b=HI/4YlKCnYwgb3ytsvrmH6iqyYhpVDCr6ryeZC3HO3O49gG4+tCFtEwHWSrPXeu4XL
 x1dFatMBb8go6p/NgnY5LLhfVsS+BTLQcLWJnm4Xr6zgYgwYm+rk4ETqlClQW1LXUomC
 yNPBkdDs3qe4MsqMO9pTHgfXfzxyIx6ZoS/RAlXA+gf6Mtv2nHqx6YsdIpGXqjDmvySM
 VEJQz+4rjSKXmc9oIE8984qq+9dHMiVFBWNYP2ZtDaI2M+0r5LHVDoPSNRV6jiUdmYi9
 qfcCc/iSBuKrUrkJaoInNSgz8B3FCoMnsUbUhZVRhwyEtiRFEFSQU05kkzl6/2iK6oYc
 LQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694741; x=1786299541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uiujdLukiIwZwpMjz6TZ/4zxzNqefR9RbQJvbFOWlCM=;
 b=dDp72RAMATzpxPJoBVgJkJYmTXvk0JzuzLjaoAS/kTmJH+fEjzNIuw7CK0BTr/fk8n
 YvQ+XsQSOJl6adK+HYssMDwNiT7DPfQkujE4sp85rYfGafO4PSDcMjLidPJTjkejN1ZH
 YK6ABtolNGOsuq+3gr/KdYkWfuCq7nXFYHK5ZWOQUHoFC4jvV0X4elh8cjgIYk0KlPtR
 eFUh4wfCR3w4gHnGDZeCIYzxSIFHrV6TRG0KZ/lL1xVDc8l4OIRdYfs4SUhW9YK731PH
 mk//ydQ5PLf5kg3HxyloFI50eoG6yAG3Hv3HbTIdyzVCQTmQqWKO8+MoIyAM7JpwndEW
 +aNw==
X-Gm-Message-State: AOJu0Yz9RgTsXtCfJNma25/eZW3/Y/Kg5PE2D3P5ZUAoaSPV2mnlbcoh
 G4qu0vJjAKpemMt2zFbnfZeaoSI4xbxSNScD5OFmTHXDz91RG7edN2JF/an+IryEeF9FfHPt9Ca
 L7lNd
X-Gm-Gg: AR+sD12FFlC61q9J8FU/HBE7SNhmjDpY1JKkjGao1YLUi0Ks1+1yCwSMdiVaF6LFmst
 zad7PxVLm1yim8pTqzpXDFoLOS9eNgdJucOdTTXS9/otlQeWWFN73vTBrPW1x6jrl9paBwQ7fp4
 PkWyJ79GFQBHv2bzgI5zr4aFzW2D1McEpyk+QJ6T3LpdBfBxE2WRlb5jkPVr2xWpRwKWaKqNSV7
 32LbkZ7khhEAEpOetRDJNejKbcboV7TQc0m/W0x42JHcFfFHDK8dB1FgO7/mL5wSX3G0RIiKYEJ
 20+5kY6eNhZK/2BEa0XsUwSyBCRglyckuv/qkRPAhOicuCAzCZWoPdbpFpvHmx2rlbVJWXuGs+a
 zHNvfNSwihLaswJAH212YsJiddaofYyttssOXO3PVVN7k0/OEtQ53Xt9tdmpwIaLXQyAooh6q/U
 mSBftXiC1YI+KF664RM2EGdSNR+IChIJq0CmtOuiWeBDNlpsjODWd5rqBrX85ZGEY/XXv7bo4+f
 xG1qGSrPZdpkr3ZPfytEW7lKLA=
X-Received: by 2002:a05:6a21:6117:b0:3c4:1c9f:d90 with SMTP id
 adf61e73a8af0-3c92a8133e6mr7096245637.39.1785694741387; 
 Sun, 02 Aug 2026 11:19:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:19:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 21/21] doc: add release not about rte_ethdev changes
Date: Sun,  2 Aug 2026 11:15:26 -0700
Message-ID: <20260802181835.476887-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

The changes to rte_ethdev are visible to applications.
This may require straight forward include file changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..ae130852b6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,12 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* Experimental flow director related API's have been removed:
+
+  * Testpmd: ``show port fdir``
+  * ixgbe: ``rte_pmd_ixgbe_get_fdir_info``, ``rte_pmd_ixgbe_get_fdir_stats``
+  * i40e: ``rte_pmd_i40e_get_fdir_info``, ``rte_pmd_i40e_get_fdir_stats``
+
 
 API Changes
 -----------
@@ -93,6 +99,13 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Changed ethdev include files.**
+
+  * Dropped inclusion of ``rte_flow.h`` in ``rte_ethdev.h``.
+  * Network headers ``rte_ip.h``, ``rte_udp.h``, ``rte_tcp.h`` and ``rte_sctp.h``
+    are no longer indirectly included by ``rte_ethdev.h``.
+  * Legacy flow director definitions are no longer included by ``rte_ethdev.h``.
+
 
 ABI Changes
 -----------
-- 
2.53.0

