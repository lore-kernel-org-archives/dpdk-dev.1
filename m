Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A17C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 22:09:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D3724065D;
	Fri, 18 Jul 2025 00:09:40 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id B46AB40651
 for <dev@dpdk.org>; Fri, 18 Jul 2025 00:09:38 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F183F7A00F7;
 Thu, 17 Jul 2025 18:09:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 18:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752790177;
 x=1752876577; bh=lD5K2cGtT02/KZ93F/XyKQee38szYzU9+eFnQ1QcNqA=; b=
 JaeOMTEvW+NHo/pAsBHVqotzjzVg+T55A8QACvLn2bEpU7zohUWafG/MfT8Gklzx
 hNklrDEiSBwI1StFf6+6e89PeBXYjEsYI1EQWWSQ5PSvz3cW+KiX7YxeC/CEzMwl
 j8/n9E//nwNgNa2EU5y+7Ujaj5SJxhaV/OyaxVU8Sicz7ZHMdtzQIe83PX6NtjEf
 CogVHbpH4+pTGGsagUMVUQgLd90uNxbS3/rv3M+somncStq7PG5ZBlO4FLC5HBjH
 +aqLaPb5F5375MmtOWG2O45tptjoX5JnfObPEQidiy25pVUVokO0T1ZMRyb13nKo
 PWlo9mBC8Ok58dhy4OhFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752790177; x=
 1752876577; bh=lD5K2cGtT02/KZ93F/XyKQee38szYzU9+eFnQ1QcNqA=; b=j
 Ee8PcaYNnakq9V2PYKsbZgUXPw2QrF9HDhndLt2yxXnojuWUeGr/7Qe6ZMEi8lO1
 cCwJ+kaoPzkZWjZlmPSwm1TsaClFHu4v0EhzrCRYD7UKc6Q4Y//VC+Roit/VxwY5
 9y1T3xZhB48FIUyIqKZgRqFhbtqWDW1LZTbW5Gj6ieKB6oZC/RISH42MZUFLb7R5
 lxqrNqKyUo5kGXvPOuZAIgcMlxyTFn/aqb1UH2e4KaALt1UT43v/YAkQbW7n4/Pc
 Id1BDwRYUoE6/DUl4Z4ZmSWelWv+frnAD5uUcFWKCkgKHTwry270YvMna90+I6sS
 9juzALCw+qiwyH6RHT5RA==
X-ME-Sender: <xms:oXR5aLvIIRLMaybFJSyI1is-FmDkVGg0QqzBIQ5A652Ck8OBOHMZsQ>
 <xme:oXR5aD3wJlfGC1HVNUUNDY2ZQBgTtwFNXd7TOqTlGBUEkn1eK-SW0gBLuBWpwOuY5
 WHkwoG00FlxOnAHXA>
X-ME-Received: <xmr:oXR5aEUcdXTroUdRrLsD0mrc8kgYNPhm9lg6FvXpZaOZoWWjQFk2hjgzoYNN8B5ylw0L0tomFkM1oWVh7Pm7pWFZoGw5Gps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeeufeelhefhkeelvdelledvueekgfeltdeihfefleetgfffffffteel
 lefgffetteenucffohhmrghinhepnhhvihguihgrrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthho
 pegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiug
 hirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:oXR5aGLjIp7urKgTUGm1cZm0OSA2F_gonm1FI6AOCmqC4f3Xd0-Y9A>
 <xmx:oXR5aO1KLNb2lsaPdonbH9C9ORBgq0i5V8RoEbtPJ6e44ul8jKvtkw>
 <xmx:oXR5aE6pXdzHpk3HSTveOlh5neE7OOdeguowH7YQT8TKL2XAlf_6XQ>
 <xmx:oXR5aP-JMgTm_itb1B13uFSzwegMQsdfxfHWM0AnvReilq4dDKxyrg>
 <xmx:oXR5aL32H10BEYUq9UJeU2rAr09br7yAc6uZjC24DVBoI2hzYNJS1hhY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 18:09:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
Subject: [PATCH 1/4] doc: simplify mlx5 devices lists
Date: Fri, 18 Jul 2025 00:05:41 +0200
Message-ID: <20250717220912.376503-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

No need to list all devices of a family.
Instead, a list of families is given with technical details.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/nics/mlx4.rst     |  5 +-
 doc/guides/nics/mlx5.rst     | 91 +++++++++++++-----------------------
 doc/guides/platform/mlx5.rst |  9 ++--
 doc/guides/vdpadevs/mlx5.rst | 16 +++----
 4 files changed, 46 insertions(+), 75 deletions(-)

diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index e92fcc155c..24aba8661b 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -267,9 +267,8 @@ Installing NVIDIA MLNX_OFED
 
         connectx_port_config
 
-#. Continue with :ref:`section 2 of the Quick Start Guide <QSG_2>`.
+#. Continue with :ref:`section 2 of the Quick Start Guide <mlx4_QSG_2>`.
 
-.. _qsg:
 
 Quick Start Guide
 -----------------
@@ -286,7 +285,7 @@ Quick Start Guide
         to Ethernet using connectx_port_config tool provided by it.
         :ref:`OFED_as_a_fallback`:
 
-.. _QSG_2:
+.. _mlx4_QSG_2:
 
 #. In case of bare metal or hypervisor, configure optimized steering mode
    by adding the following line to ``/etc/modprobe.d/mlx4_core.conf``::
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 5c825dd6b0..1b136f083a 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -7,70 +7,45 @@
 NVIDIA MLX5 Ethernet Driver
 ===========================
 
+The mlx5 Ethernet poll mode driver (``librte_net_mlx5``)
+provides support for NVIDIA NIC and DPU device families.
+The embedded switch, Physical Functions (PF),
+SR-IOV Virtual Functions (VF), Linux auxiliary Sub-Functions (SF),
+and their port representors are supported
+with many :ref:`features <mlx5_net_features>`.
 
-The mlx5 Ethernet poll mode driver library (**librte_net_mlx5**) provides support
-for **NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx** , **NVIDIA ConnectX-5**,
-**NVIDIA ConnectX-6**, **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**,
-**NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**, **NVIDIA BlueField**,
-**NVIDIA BlueField-2** and **NVIDIA BlueField-3** families of
-10/25/40/50/100/200/400 Gb/s adapters as well as their virtual
-functions (VF) in SR-IOV context.
+For additional support, you may contact NVIDIA_.
 
-Supported NICs
---------------
+.. _NVIDIA: mailto:enterprisesupport@nvidia.com?subject=DPDK%20mlx5%20support&body=Company:%20%0D%0A%0D%0AEnvironment:%20%0D%0A%0D%0ADPDK%20version:%20%0D%0A%0D%0AQuestion:
 
-The following NVIDIA device families are supported by the same mlx5 driver:
 
-  - ConnectX-4
-  - ConnectX-4 Lx
-  - ConnectX-5
-  - ConnectX-5 Ex
-  - ConnectX-6
-  - ConnectX-6 Dx
-  - ConnectX-6 Lx
-  - ConnectX-7
-  - ConnectX-8
-  - BlueField
-  - BlueField-2
-  - BlueField-3
+Supported Devices
+-----------------
 
-Below are detailed device names:
+The following families of NVIDIA ConnectX NICs and BlueField DPUs are supported
+with the same driver:
 
-* NVIDIA\ |reg| ConnectX\ |reg|-4 10G MCX4111A-XCAT (1x10G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 10G MCX412A-XCAT (2x10G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 25G MCX4111A-ACAT (1x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 25G MCX412A-ACAT (2x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 40G MCX413A-BCAT (1x40G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 40G MCX4131A-BCAT (1x40G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 40G MCX415A-BCAT (1x40G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX413A-GCAT (1x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX4131A-GCAT (1x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX414A-BCAT (2x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX415A-GCAT (1x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX416A-BCAT (2x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX416A-GCAT (2x50G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 50G MCX415A-CCAT (1x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 100G MCX416A-CCAT (2x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 Lx 10G MCX4111A-XCAT (1x10G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 Lx 10G MCX4121A-XCAT (2x10G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 Lx 25G MCX4111A-ACAT (1x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 Lx 25G MCX4121A-ACAT (2x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-4 Lx 40G MCX4131A-BCAT (1x40G)
-* NVIDIA\ |reg| ConnectX\ |reg|-5 100G MCX556A-ECAT (2x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-5 Ex EN 100G MCX516A-CDAT (2x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 200G MCX654106A-HCAT (2x200G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 200G MCX623105AN-VDAT (1x200G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
-* NVIDIA\ |reg| ConnectX\ |reg|-8 400G C900-9X81Q-00CN-STQ_Ax (2x400G)
-* NVIDIA\ |reg| BlueField\ |reg|-2 25G MBF2H332A-AEEOT_A1 (2x25Gg
-* NVIDIA\ |reg| BlueField\ |reg|-3 200GbE 900-9D3B6-00CV-AA0 (2x200)
-* NVIDIA\ |reg| BlueField\ |reg|-3 200GbE 900-9D3B6-00SV-AA0 (2x200)
-* NVIDIA\ |reg| BlueField\ |reg|-3 400GbE 900-9D3B6-00CN-AB0 (2x400)
-* NVIDIA\ |reg| BlueField\ |reg|-3 100GbE 900-9D3B4-00CC-EA0 (2x100)
-* NVIDIA\ |reg| BlueField\ |reg|-3 100GbE 900-9D3B4-00SC-EA0 (2x100)
-* NVIDIA\ |reg| BlueField\ |reg|-3 400GbE 900-9D3B4-00EN-EA0 (1x100)
+================== =============== ========= =========== ============
+NIC / DPU          total bandwidth max ports PCIe        embedded CPU
+================== =============== ========= =========== ============
+**ConnectX-4 Lx**   50 Gb/s        2         Gen3        --
+**ConnectX-4**     100 Gb/s        2         Gen3        --
+**ConnectX-5**     100 Gb/s        2         Gen3        --
+**ConnectX-5 Ex**  100 Gb/s        2         Gen4        --
+**ConnectX-6 Lx**   50 Gb/s        2         Gen3 / Gen4 --
+**ConnectX-6**     200 Gb/s        2         Gen3 / Gen4 --
+**ConnectX-6 Dx**  200 Gb/s        2         Gen4        --
+**BlueField-2**    200 Gb/s        2         Gen4        A72 x8
+**ConnectX-7**     400 Gb/s        4         Gen5        --
+**ConnectX-8**     400 Gb/s        4         Gen6        --
+**BlueField-3**    400 Gb/s        2         Gen5        A78 x16
+================== =============== ========= =========== ============
+
+The details of models and specifications can be found on the website
+for `ConnectX NICs <https://www.nvidia.com/en-in/networking/ethernet-adapters/>`_
+and `BlueField DPUs <https://www.nvidia.com/en-in/networking/products/data-processing-unit/>`_.
+
+A DPU can act as a NIC in NIC mode.
 
 
 Design
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index 8742f84972..fe5cff7032 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -7,11 +7,10 @@
 NVIDIA MLX5 Common Driver
 =========================
 
-The mlx5 common driver library (**librte_common_mlx5**) provides support for
-**NVIDIA ConnectX-4**, **NVIDIA ConnectX-4 Lx**, **NVIDIA ConnectX-5**,
-**NVIDIA ConnectX-6**, **NVIDIA ConnectX-6 Dx**, **NVIDIA ConnectX-6 Lx**,
-**NVIDIA ConnectX-7**, **NVIDIA ConnectX-8**, **NVIDIA BlueField**, **NVIDIA BlueField-2** and
-**NVIDIA BlueField-3** families of 10/25/40/50/100/200 Gb/s adapters.
+The mlx5 common driver library (``librte_common_mlx5``) provides support
+for NVIDIA NIC and DPU device families.
+The SR-IOV Virtual Functions (VF), Linux auxiliary Sub-Functions (SF),
+and their port representors are supported as well.
 
 Information and documentation for these adapters can be found on the
 `NVIDIA website <https://www.nvidia.com/en-us/networking/>`_.
diff --git a/doc/guides/vdpadevs/mlx5.rst b/doc/guides/vdpadevs/mlx5.rst
index e7d37aa4ea..6cea1f43e9 100644
--- a/doc/guides/vdpadevs/mlx5.rst
+++ b/doc/guides/vdpadevs/mlx5.rst
@@ -24,15 +24,13 @@ and which PMDs can be combined with vDPA PMD.
 Supported NICs
 --------------
 
-* NVIDIA\ |reg| ConnectX\ |reg|-6 200G MCX654106A-HCAT (2x200G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 25G MCX621102AN-ADAT (2x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 100G MCX623106AN-CDAT (2x100G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx EN 200G MCX623105AN-VDAT (1x200G)
-* NVIDIA\ |reg| ConnectX\ |reg|-6 Lx EN 25G MCX631102AN-ADAT (2x25G)
-* NVIDIA\ |reg| ConnectX\ |reg|-7 200G CX713106AE-HEA_QP1_Ax (2x200G)
-* NVIDIA\ |reg| BlueField SmartNIC 25G MBF1M332A-ASCAT (2x25G)
-* NVIDIA\ |reg| BlueField |reg|-2 SmartNIC MT41686 - MBF2H332A-AEEOT_A1 (2x25G)
-* NVIDIA\ |reg| BlueField\ |reg|-3 200GbE 900-9D3B6-00CV-AAB_Ax
+* NVIDIA\ |reg| ConnectX\ |reg|-6
+* NVIDIA\ |reg| ConnectX\ |reg|-6 Lx
+* NVIDIA\ |reg| ConnectX\ |reg|-6 Dx
+* NVIDIA\ |reg| ConnectX\ |reg|-7
+* NVIDIA\ |reg| BlueField
+* NVIDIA\ |reg| BlueField |reg|-2
+* NVIDIA\ |reg| BlueField\ |reg|-3
 
 Prerequisites
 -------------
-- 
2.47.1

