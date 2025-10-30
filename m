Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC1CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 15:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 979464026F;
	Thu, 30 Oct 2025 16:43:20 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 3EAC940150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 16:43:19 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 5EE4D1D00100;
 Thu, 30 Oct 2025 11:43:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 30 Oct 2025 11:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1761838998; x=1761925398; bh=evdu9eQJ+HtOtAyoYfL87
 2kmMlIwnd9YgGMBkqd1nck=; b=HV6EI/kI/FvjoaOLi2WYIosNiDKGWzMSyWt2H
 JNe+MwxsYY+LmXZNJJbAv1ecOCnqQyEVWxCAlS0ilnhwDnYWvS52Gg8XcaaMS+R4
 YnniQI39bU8ZfGKONBv6/4yeXVWaAosXnbVnt1UVUI77g73LUVtFf8LAX1abDTyp
 Vn0Qe61R7b3k87oZi9uddft4znTlRk/NaReopKZdwTYMeeOpJZrhyLhfvYxVYjhT
 xC/1y0gSViiXDrPxoa3z9VyqTyzxBQSurN04kpAM3UN4PEUJZkknzGJNQmDLeIx4
 qqSMTMtRDWg06fJjmHQlWfNNeP5AHlD1gpx99ZrzuZhqCmT/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761838998; x=1761925398; bh=evdu9eQJ+HtOtAyoYfL872kmMlIwnd9YgGM
 Bkqd1nck=; b=2HwTEd5O8iZHaMr8SXEhtjPiwZoYtEGLIQbqmlEazaoEkFC8sc+
 zKasrpy67z4ZN2sBY1JdUxUA+qyrwVb0CSZMVz7WuZ1wakf2rQxsCZy+SWrKsrS0
 Errp+ZVefjgljGDr0QPknENqWhoAM6OUMmIMnT88NA7iYiv2pOAphW23rDS+4o0m
 ol17U7C/tcypDKr6hc5WOxkRYBm9qxMhdZZvrYlxjBtaAuk4G4QZWxC1DssCzGoe
 SVSA1QfEMpiC2S71cn5SPAiAVMY0Cg4AwWVPnZrPu+lXQsQu3QjdHqS9vgEfMYHL
 g+pzoXRmn77EyCMRz6CgI/nS+n/xQhto2OQ==
X-ME-Sender: <xms:lYcDaeBNeTEkqUmSeq2eWd6D8oelQRZeeefXApN6rzBDY1KE1RPpCA>
 <xme:lYcDac1TtbRaEN65e61mUhUWhwryH4LmcgFL-QEdTJu4dzDt6SY3xQeIdrQMZVm2Q
 7bg1eCNFYuFgZw0GBln0MtTck9DuNUJCZcYFrvX1oTOXfrakUFeguI>
X-ME-Received: <xmr:lYcDaQuPD70o0U7RgEnLMfr0A0rL2djFC2w-QzSCDtGq_TDo22t_ZZDhbQi_172JRnw7iU1JL7MVkamZcuqPAh3eQJC2sQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejtddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeehueekvdejudefveekjeelgeejffeuiefgleffleefudfgkefhheetuddt
 leegfeenucffohhmrghinhepnhhvihguihgrrdgtohhmnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgt
 ohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:lYcDaU7BGZQ2HLDW4iRA4Hgq8hIT6clRYob7s4qHJYfQYE5c3mvs9Q>
 <xmx:lYcDaZJqCT8akkFER8z-BODi_uZPKuhIv6W7HS1JCAR_fBAFVus4ow>
 <xmx:lYcDac4PJBB-kLE44wmhZqBC13tgaSph5DtS_CawNgiuxpbY099KRA>
 <xmx:lYcDaUxK1-VJUXji6JNKU1fSEssexWb58HE_ispUNgcDtW9S1wtu0A>
 <xmx:locDaWjncyMEOsmz-ohvaCuipCNsi0uJdeAfAQq8V7xFhOgkNTpfdc5l>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 11:43:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
	Ori Kam <orika@nvidia.com>
Subject: [PATCH] doc: add NVIDIA SuperNIC devices
Date: Thu, 30 Oct 2025 16:42:49 +0100
Message-ID: <20251030154250.3918985-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

SuperNIC devices are designed for AI workloads:
https://www.nvidia.com/en-us/networking/products/ethernet/supernic/

The lists of well supported NVIDIA devices are updated accordingly.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/compressdevs/mlx5.rst | 13 ++++++-------
 doc/guides/cryptodevs/mlx5.rst   | 15 ++++++---------
 doc/guides/regexdevs/mlx5.rst    | 13 ++++++-------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/doc/guides/compressdevs/mlx5.rst b/doc/guides/compressdevs/mlx5.rst
index b64818444a..8eda954d4e 100644
--- a/doc/guides/compressdevs/mlx5.rst
+++ b/doc/guides/compressdevs/mlx5.rst
@@ -6,9 +6,8 @@
 NVIDIA MLX5 Compress Driver
 ===========================
 
-The mlx5 compress driver library
-(**librte_compress_mlx5**) provides support for **NVIDIA BlueField-2**,
-and **NVIDIA BlueField-3** families of 25/50/100/200/400 Gb/s adapters.
+The mlx5 compress driver (``librte_compress_mlx5``)
+provides support for NVIDIA DPU device family.
 
 Design
 ------
@@ -108,11 +107,11 @@ for an additional list of options shared with other mlx5 drivers.
   The default value is 15.
 
 
-Supported NICs
---------------
+Supported Devices
+-----------------
 
-* NVIDIA\ |reg| BlueField-2 SmartNIC
-* NVIDIA\ |reg| BlueField-3 SmartNIC
+* NVIDIA\ |reg| BlueField-2 DPU
+* NVIDIA\ |reg| BlueField-3 DPU/SuperNIC
 
 Prerequisites
 -------------
diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index 8a2ec20e74..e1eb02e548 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -6,10 +6,8 @@
 NVIDIA MLX5 Crypto Driver
 =========================
 
-The MLX5 crypto driver library
-(**librte_crypto_mlx5**) provides support for **NVIDIA ConnectX-6**,
-**NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**,
-**NVIDIA BlueField-2**, and **NVIDIA BlueField-3** family adapters.
+The mlx5 crypto driver (``librte_crypto_mlx5``)
+provides support for NVIDIA NIC and DPU device families.
 
 Overview
 --------
@@ -201,15 +199,14 @@ for an additional list of options shared with other mlx5 drivers.
   Set to ``full_capable`` by default.
 
 
-Supported NICs
---------------
+Supported Devices
+-----------------
 
 * NVIDIA\ |reg| ConnectX\ |reg|-6 200G MCX654106A-HCAT (2x200G)
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx
 * NVIDIA\ |reg| ConnectX\ |reg|-7
-* NVIDIA\ |reg| ConnectX\ |reg|-8
-* NVIDIA\ |reg| BlueField\ |reg|-2 SmartNIC
-* NVIDIA\ |reg| BlueField\ |reg|-3 SmartNIC
+* NVIDIA\ |reg| BlueField\ |reg|-2 DPU
+* NVIDIA\ |reg| BlueField\ |reg|-3 DPU/SuperNIC
 
 
 Limitations
diff --git a/doc/guides/regexdevs/mlx5.rst b/doc/guides/regexdevs/mlx5.rst
index 814228c5e3..be45b54147 100644
--- a/doc/guides/regexdevs/mlx5.rst
+++ b/doc/guides/regexdevs/mlx5.rst
@@ -6,9 +6,8 @@
 NVIDIA MLX5 RegEx Driver
 ========================
 
-The mlx5 RegEx (Regular Expression) driver library
-(**librte_regex_mlx5**) provides support for **NVIDIA BlueField-2**,
-and **NVIDIA BlueField-3** families of 25/50/100/200 Gb/s adapters.
+The mlx5 RegEx (Regular Expression) driver (``librte_regex_mlx5``)
+provides support for NVIDIA DPU device family.
 
 Design
 ------
@@ -32,11 +31,11 @@ See :ref:`mlx5 common compilation <mlx5_common_compilation>`,
 and :ref:`mlx5 common driver options <mlx5_common_driver_options>`.
 
 
-Supported NICs
---------------
+Supported Devices
+-----------------
 
-* NVIDIA\ |reg| BlueField-2 SmartNIC
-* NVIDIA\ |reg| BlueField-3 SmartNIC
+* NVIDIA\ |reg| BlueField-2 DPU
+* NVIDIA\ |reg| BlueField-3 DPU/SuperNIC
 
 Prerequisites
 -------------
-- 
2.51.0

