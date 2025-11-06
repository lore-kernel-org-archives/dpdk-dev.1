Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C906CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B097540687;
	Thu,  6 Nov 2025 12:08:27 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id DB94C4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:08:25 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3ADB714001B8;
 Thu,  6 Nov 2025 06:08:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 06 Nov 2025 06:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1762427305; x=1762513705; bh=8FWr1SP986XzDy9Ya3kwy
 5MJW0giMGXuIed47Q536Wo=; b=unmTFSLkh+8pqaUWjbTnLUlaL4UTUksJ3Umhc
 xhfvXTcThCPma4mlP9Hruknk6nsIWrkXsrUkOZACollr3QrE7fTFpO/Mfxv+21Iv
 fPft323IbBiKJzuSbI3qnAxZb2pdaP3ONzyAVswGYL8s/0Rg3JFsXd3KeZbLpUex
 xeNPhF/3oHzMwtntKaQqNJKOVPBiD7EUr9Jv+cECehbb9jcnsFfZIM365n1nc4Iq
 v2zqIhLn5HCtM9OfFgCLh/Tjzmtpq9KPL7oNZn2iipaySw+a3FUTEtfEV0Ow+OBs
 kPpjXVrpc7Xgq3purnrHdmhoUDEq80zt2koE0Jqa/HqRJCzZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762427305; x=1762513705; bh=8FWr1SP986XzDy9Ya3kwy5MJW0giMGXuIed
 47Q536Wo=; b=jKFs9wsn6+G5VAr6CcG20q/34Z7jhrwxsWTHeeSO8vD/08UYOyo
 uvr+j30gszOWjPCdzonrooWTF8SMgKpDUBv6rxjerbs/4vDKG3eTBhoEn2nkFoU5
 6OMrLSaVzW7nsUIiqr6ObG3JdQdz4PhpoTsJ/xv9lIyN5lFA4N1VU8491FZswEtj
 vNKGjul+oYZXSGsRmVtd2gOJ2xZyz5PiNRARvtYFzD3a7trFpAjf4Il9WWjiUW+r
 EOziB9ALVq3hDSo00qzkmVOe8FY87iDhb67kILwPXGbYn/HXdcedtRco4s8uspAh
 EIxOtZPdRd5UL8grslkaVSM/QCcGnRqQoCw==
X-ME-Sender: <xms:qIEMaR6UXXHT-dzfZ5cZVk6HADRiBRwPHx0B2tGKw8ScBzTWSaDPjQ>
 <xme:qIEMaTPwKoXTwjPrZwuPahezGCcQEWG8vfAZlwWXcPHprKNKLgxyJ_xagHc8wYPz9
 G6jE-i8yTnic9g-fUeuftKp7hAwhUCO__pfqM_yHwwmF5Q1caBc8w>
X-ME-Received: <xmr:qIEMaXnKrsvUPUWnWNvsORBdOy1vcmX3zgEZ0TcEBrLKGieTKsoyXSYpinyJaXSxU-d3LWitTvSq3OFMWRkzUwQHx9lMWWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiiedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgr
 vhhosehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:qIEMaSTjsgryM9fkroK9_OYmhGw2MvTCNAnzx09aG2kjxMcvSz9unQ>
 <xmx:qIEMabAW6xd4XR9aXuPpWXFBEGk41rOxKE0lmd3oQERB2pggIWcQug>
 <xmx:qIEMaZRMhdg2iU_iBPhREOpUK4hU3d5Rp6CI_a7imZ_BupP7KuilWA>
 <xmx:qIEMaZoOYE6Sre8Q1BO4SGnbBzbnVW4It8cH33P6vqVR1fvg27gmVg>
 <xmx:qYEMaW6kJC0psxIPsV10q1L0nnoCtZpgRh63HOxwRo7r-dp7kJpW-OKG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 06:08:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH] doc: update mlx5 vDPA guide
Date: Thu,  6 Nov 2025 12:08:06 +0100
Message-ID: <20251106110807.1223973-1-thomas@monjalon.net>
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

Adjust supported devices and reformat headings layout.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/vdpadevs/mlx5.rst | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/doc/guides/vdpadevs/mlx5.rst b/doc/guides/vdpadevs/mlx5.rst
index 6cea1f43e9..2ee8112131 100644
--- a/doc/guides/vdpadevs/mlx5.rst
+++ b/doc/guides/vdpadevs/mlx5.rst
@@ -6,21 +6,13 @@
 NVIDIA MLX5 vDPA Driver
 =======================
 
-The mlx5 vDPA (vhost data path acceleration) driver library
-(**librte_vdpa_mlx5**) provides support for **NVIDIA ConnectX-6**,
-**NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**, **NVIDIA ConnectX7**,
-**NVIDIA BlueField**, **NVIDIA BlueField-2** and **NVIDIA BlueField-3** families
-of 10/25/40/50/100/200 Gb/s adapters as well as their virtual functions (VF) in
-SR-IOV context.
-
-.. note::
-
-   This driver is enabled automatically when using "meson" build system which
-   will detect dependencies.
+The mlx5 vDPA (vhost data path acceleration) driver (``librte_vdpa_mlx5``)
+provides support for NVIDIA NIC and DPU device families.
 
 See :doc:`../../platform/mlx5` guide for design details,
 and which PMDs can be combined with vDPA PMD.
 
+
 Supported NICs
 --------------
 
@@ -28,21 +20,23 @@ Supported NICs
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Lx
 * NVIDIA\ |reg| ConnectX\ |reg|-6 Dx
 * NVIDIA\ |reg| ConnectX\ |reg|-7
-* NVIDIA\ |reg| BlueField
-* NVIDIA\ |reg| BlueField |reg|-2
-* NVIDIA\ |reg| BlueField\ |reg|-3
+* NVIDIA\ |reg| BlueField\ |reg|-2 DPU
+* NVIDIA\ |reg| BlueField\ |reg|-3 DPU/SuperNIC
+
 
 Prerequisites
 -------------
 
 - NVIDIA MLNX_OFED version: **5.0**
-  See :ref:`mlx5 common prerequisites <mlx5_linux_prerequisites>` for more details.
+
+See :ref:`mlx5 common prerequisites <mlx5_linux_prerequisites>` for more details.
+
 
 Run-time configuration
-~~~~~~~~~~~~~~~~~~~~~~
+----------------------
 
 Driver options
-^^^^^^^^^^^^^^
+~~~~~~~~~~~~~~
 
 Please refer to :ref:`mlx5 common options <mlx5_common_driver_options>`
 for an additional list of options shared with other mlx5 drivers.
@@ -136,16 +130,18 @@ for an additional list of options shared with other mlx5 drivers.
 
   - 0, default value, no pre-create virtq resource.
 
+
 Error handling
-^^^^^^^^^^^^^^
+--------------
 
 Upon potential hardware errors, mlx5 PMD try to recover, give up if failed 3
 times in 3 seconds, virtq will be put in disable state. User should check log
 to get error information, or query vdpa statistics counter to know error type
 and count report.
 
+
 Statistics
-^^^^^^^^^^
+----------
 
 The device statistics counter persists in reconfiguration until the device gets
 removed. User can reset counters by calling function rte_vdpa_reset_stats().
-- 
2.51.0

