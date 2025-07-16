Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D786C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63E4E402F1;
	Wed, 16 Jul 2025 12:15:28 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 3819D40615
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:15:26 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 63A537A00B3;
 Wed, 16 Jul 2025 06:15:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 16 Jul 2025 06:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1752660925; x=1752747325; bh=ZCOFYlDDPxeWQmmvZEy1J
 YHw520l3tJNGFEG/CEJ9aA=; b=Zapia6xDuyo/R8+1PQeqmfjjwJgoS27O8EglV
 W2uZxilNVEMcGpU3sl+Ev5MLEzYdgrAoZcxIrNJVpBZdF2q03TvOzgrUShc90sgN
 kRhdo2BBODNKOaW98TaQH60j/EnUdkctUrp0G+rRXzlN+mWEwizGiMy7pXLNlsJF
 bR09zJSpUh+gIXpwuT17RS2E6tffxXQiAUpfO2faYdJ7QDmYbxwx41CnNieenaU1
 99ybo0LYaQbuL1r/tGAjwdYCC8UWNdYXULtKgQf+2P5vVtJsN+DcRLm3d4FHE4Qj
 jKdYMO96lY+er85lNDnG3dYBj9toVP8VPep3nj5v0rJGOkQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752660925; x=1752747325; bh=ZCOFYlDDPxeWQmmvZEy1JYHw520l3tJNGFE
 G/CEJ9aA=; b=FjnwQ43FZqMUwMdMRXZdK79ySQ+r46Sl6GlSNL2l2YtjxHAcTCK
 fzHQX4jeY1u9AW/X9vxzUhVl2LnJirMKag+va3pqjBVUveONoT+4wUtQjIBkSP+T
 tCFXDMimiuDebP9xVQNwGOsw35IXLbH2NIf7098gUb6nR+ZU9NIkxgPp+el501/a
 yHBaJBDkzCRRnzIJl/XC1cWC+kxmUYF2i5j4G/IvHLkbD/UuKnnS5mtzonXiD9mB
 trfQHofy1v8MDfl2+HdLeOHoaYooT37Ojz04s2jPsH90eljzHhiEDU/zX+bZxSrR
 0Qrh12oYUpxv/E/GXSsGzNBV3Mk8CAmPknw==
X-ME-Sender: <xms:vHt3aG3xZWNAm0z4hDS6brtg39vrIyehgsdCnlR44aynN4NVXCJnvQ>
 <xme:vHt3aAcw1A1kkZqXCmvDTlwkZt2tlGzBV5C6p_0Pvd2lPht-UjSJkamVSYSpCbWkV
 v-MV1X0u6TxEf00cQ>
X-ME-Received: <xmr:vHt3aEfBwN0zoZAZMP0Fy1ie_cttH_kQHAV-8ICOyzyMpnMpMJ9ozu4F3bQHScPAMLpbxY1f3mvWQ10uBJkU8twbtyZ-guc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepveevfeevieeihfetudekgeekleeigeffueekveduteeuffeiudevteeiudek
 feelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoh
 epmhgrthgrnhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghv
 ohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiug
 hirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphht
 thhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhngh
 hmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:vXt3aDzxb0MUeRsco1e8oxDsoIltBvbZp27K9NOGAovaktaxOq6REw>
 <xmx:vXt3aL8MZUOkl7ns29eupoqJrr1Q6aT4vrwEWVxaqvS_m7BGBg-9TA>
 <xmx:vXt3aLjbQiVn7R60fyvSen13acZZ6yPs4r8waJa8B0U4q0UUUDIWSQ>
 <xmx:vXt3aCE9zF6hjDnrW-4q5UV7MwIVejKCyCAIINVMDV0-ipWEdV6now>
 <xmx:vXt3aIfjamWkfktkSeEJcDfEXBwFk7bT1zjJfPxXXyO6xnA7i1hOv9gO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 06:15:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: [PATCH] doc: remove Mellanox acquisition explanation
Date: Wed, 16 Jul 2025 12:15:16 +0200
Message-ID: <20250716101516.224980-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

Time has passed since Mellanox acquisition by NVIDIA.
No need to explain this anymore.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/compressdevs/mlx5.rst  | 7 -------
 doc/guides/cryptodevs/mlx5.rst    | 7 -------
 doc/guides/nics/mlx4.rst          | 7 -------
 doc/guides/nics/mlx5.rst          | 6 ------
 doc/guides/platform/bluefield.rst | 7 -------
 doc/guides/platform/mlx5.rst      | 7 -------
 doc/guides/regexdevs/mlx5.rst     | 7 -------
 doc/guides/vdpadevs/mlx5.rst      | 7 -------
 8 files changed, 55 deletions(-)

diff --git a/doc/guides/compressdevs/mlx5.rst b/doc/guides/compressdevs/mlx5.rst
index 751fae7184..b64818444a 100644
--- a/doc/guides/compressdevs/mlx5.rst
+++ b/doc/guides/compressdevs/mlx5.rst
@@ -6,13 +6,6 @@
 NVIDIA MLX5 Compress Driver
 ===========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The mlx5 compress driver library
 (**librte_compress_mlx5**) provides support for **NVIDIA BlueField-2**,
 and **NVIDIA BlueField-3** families of 25/50/100/200/400 Gb/s adapters.
diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index f8b43823a7..8a2ec20e74 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -6,13 +6,6 @@
 NVIDIA MLX5 Crypto Driver
 =========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The MLX5 crypto driver library
 (**librte_crypto_mlx5**) provides support for **NVIDIA ConnectX-6**,
 **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**,
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index d79d5b1661..e92fcc155c 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -5,13 +5,6 @@
 NVIDIA MLX4 Ethernet Driver
 ===========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The MLX4 poll mode driver library (**librte_net_mlx4**) implements support
 for **NVIDIA ConnectX-3** and **NVIDIA ConnectX-3 Pro** 10/40 Gbps adapters
 as well as their virtual functions (VF) in SR-IOV context.
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c3a350d24e..5c825dd6b0 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -7,12 +7,6 @@
 NVIDIA MLX5 Ethernet Driver
 ===========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
 
 The mlx5 Ethernet poll mode driver library (**librte_net_mlx5**) provides support
 for **NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx** , **NVIDIA ConnectX-5**,
diff --git a/doc/guides/platform/bluefield.rst b/doc/guides/platform/bluefield.rst
index a568cdca4c..67a70b1313 100644
--- a/doc/guides/platform/bluefield.rst
+++ b/doc/guides/platform/bluefield.rst
@@ -4,13 +4,6 @@
 NVIDIA BlueField Board Support Package
 ======================================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 This document has information about steps to setup NVIDIA BlueField platform
 and common offload HW drivers of **NVIDIA BlueField** family SoC.
 
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index ab3107209a..8742f84972 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -7,13 +7,6 @@
 NVIDIA MLX5 Common Driver
 =========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The mlx5 common driver library (**librte_common_mlx5**) provides support for
 **NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx**, **NVIDIA ConnectX-5**,
 **NVIDIA ConnectX-6**, **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**,
diff --git a/doc/guides/regexdevs/mlx5.rst b/doc/guides/regexdevs/mlx5.rst
index 174b848158..814228c5e3 100644
--- a/doc/guides/regexdevs/mlx5.rst
+++ b/doc/guides/regexdevs/mlx5.rst
@@ -6,13 +6,6 @@
 NVIDIA MLX5 RegEx Driver
 ========================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The mlx5 RegEx (Regular Expression) driver library
 (**librte_regex_mlx5**) provides support for **NVIDIA BlueField-2**,
 and **NVIDIA BlueField-3** families of 25/50/100/200 Gb/s adapters.
diff --git a/doc/guides/vdpadevs/mlx5.rst b/doc/guides/vdpadevs/mlx5.rst
index f6c3068a21..e7d37aa4ea 100644
--- a/doc/guides/vdpadevs/mlx5.rst
+++ b/doc/guides/vdpadevs/mlx5.rst
@@ -6,13 +6,6 @@
 NVIDIA MLX5 vDPA Driver
 =======================
 
-.. note::
-
-   NVIDIA acquired Mellanox Technologies in 2020.
-   The DPDK documentation and code might still include instances
-   of or references to Mellanox trademarks (like BlueField and ConnectX)
-   that are now NVIDIA trademarks.
-
 The mlx5 vDPA (vhost data path acceleration) driver library
 (**librte_vdpa_mlx5**) provides support for **NVIDIA ConnectX-6**,
 **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**, **NVIDIA ConnectX7**,
-- 
2.47.1

