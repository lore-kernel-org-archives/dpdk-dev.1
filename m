Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B5BCD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE54402AD;
	Mon,  8 Jun 2026 14:05:47 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id EAEB940265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 14:05:45 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 60C08EC0073;
 Mon,  8 Jun 2026 08:05:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 08:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1780920345; x=1781006745; bh=mCd+lqgnnRN5zpG0yJOjd
 e7ePvVo9aA23ljLXYZwEh8=; b=SvIfdOSfSQQP9HwthmDcglFou3HpVhs+5fHhA
 jmeCFGGf3nqDTvB3Ubed4z296s3DeFjCl5qlxhx+4qGq3PFKP+Y/XTs0+mkIQCg/
 wGFp+BYrak4wsVq6W5eDyPMcc+wu4I9GyW9723PYOXiCVvpDvzL/DWio1pLXcxaF
 xJB5saNxxXBCYswvzZmBBeFa5UXXIUpBM/HwViM2R2ICXTAiaH+B1hOtqi66xpld
 krMZOUfsHaC0xmDkSMDvWcFIWu50ncf/iaKLu3WzgteiP0FJV1ZTs3YnT6iDYGHp
 i0GrXrE6lm9ry6+pBCfL6oejrwO7ZPZs1w3C3ZepIP5U6gboQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1780920345; x=1781006745; bh=mCd+lqgnnRN5zpG0yJOjde7ePvVo9aA23lj
 LXYZwEh8=; b=ZFJvtbDJSy5S6YZySSFwqb9bbsR5ElB+rLTiaA30qwEo9ck1Oy7
 yY4gfWytq7F7HyqyZF7wrbtDv81Ho1txbGYe2KL290E3g6VyhCXpQD8gIGVMWqwg
 CLEKJfSZUFhadmavm4gF7wDZiwgCyrvYhPOl0VQXbA6z6TnDVUxTdFFxqc1mCDfx
 MmZB3Eg8jS9k75po/hoE4ay+rYelXIjVBv/mMOIp8wNNEOQO5+IEXr4nHV0QhPRx
 Tk+kkRygaaOBQiYw07WueSqQLQZ3kSiV+mAWkBGNemP17NXsuFov7S4v9ncQZuKO
 oIv1TJ9MSGLIT3/K9jVI4/mnxbeuL+Fqreg==
X-ME-Sender: <xms:GLAmajBqLnJqWkH8Gj8SXw45okFM7iqJ3MtSh6hDfmgVsotxA6adKw>
 <xme:GLAmakd1mmQ-yJEN5LJ9pw27Gb4CdV56KDaMr5PNa-N7_IohXFRs4A0sPlSG83yij
 AfCH8LZGKLTcrUaAdErJ9NwHotcyyrctm7G4mgZpB68gHdTY3UMlgU>
X-ME-Received: <xmr:GLAmatkvnlj_nnnGmHZbk1gS4MaysRDwjH4zZ_O4u8CvOGS0lYcgbYwLQJLLLrNPsyi0ihFnP2r_ymchgieCu9eg40ySaJU>
X-ME-Proxy-Cause: dmFkZTEkpA/m3J4T7oVlQTjSEe8wpCnHsexuB/5k9rSv0QKKOzFR+U51PXxMwSL+B1HDjf
 I6tKp3wAP0fYf0jKVir2M3TVzTJPNV11Ve/UDdgAexKZIzcoNr9b9xCTHzDYU+Hoqmo/ft
 W5TOi3cKdgP3XYO7ojyw3mfq/W77fFIoP+ivmtaR9txnQY/v+nsIiXuz3byBgUeRXi1Li6
 G+auIzFz9kdSFmkt5SNlk6sfkvGERyplvukCTvd9KdWgJgCrz4ohE0KuSdKgScFCKaE83n
 EdP2j+Nr5cMaXbbYdJdV9FazNJPXttPb3lNAuDA+Z1YJ7nXhlXacH3ciV/fup0IX8wJsNS
 aPqUIEjH9aqTZV3BcFH/HPOr+jfOZKJ1sOsT+pIdoBc0TdEif+Km1AIseE6ydwWBKy5fQh
 tzE3JQPT6shM1t2exfpI5wPzUZXiP86PCLr0I1CnNOhpDaKl36lObVAtvmupNG1CCfYMtk
 UBR/xrkssxxtXF/8uMs4s2DyklgqRBT8ul9JVHcMXw3piKOUsRfStZITO111BBNt7iHqdG
 vu0HxM1aKGyG+Jog9hQ8dWJOwdRA0oFfBN+Unqx93VddhQ6cxOKfDmyus9fiV1iJs1xwGq
 DPNMmHzKHrzbcKtVlg/942BYbGIn8vp6kW7e0nA2+1IooKDGwnU7sUvfJiPg
X-ME-Proxy: <xmx:GLAmarFZMSNP_zb8d_OARUftMXRQqVzp9rfwYWTL50RwdknaJwESNg>
 <xmx:GLAmal4SCGtmuRxtHLBxkFbpZQXMcqwc-LWPuukvpSPpIsPE03NYJQ>
 <xmx:GLAmajm0R9QaMLTdI2wlN3jxa7T7vqvkvaXTcgc7OyvYjTTX1pPalg>
 <xmx:GLAmaqrGs6jQgP4d-t6ut8wk3d05jPQWG36sn9jaFPqw03kS7qBwHQ>
 <xmx:GbAmardvKHISnZDXLmD9CTd-xbm4rDUb9LshdWOBSEcJscN-UeUrm9EU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:05:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc: move firmware instructions in mlx5 guide
Date: Mon,  8 Jun 2026 14:05:31 +0200
Message-ID: <20260608120531.1037367-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

Having firmware update instructions before firmware config
looks simpler to find than in compilation prerequisites.

A link is also added after listing minimum firmware versions.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/platform/mlx5.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index 285d58be4f..0a8917530d 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -143,7 +143,7 @@ The following dependencies are not part of DPDK and must be installed separately
   - BlueField-2: **24.28.1002** and above.
   - BlueField-3: **32.36.3126** and above.
 
-  New features may be added in more recent firmwares.
+  New features may be added in more recent :ref:`firmwares <mlx5_firmware_config>`.
 
 Libraries and kernel modules can be provided either by the Linux distribution,
 or by installing NVIDIA MLNX_OFED/EN which provides compatibility with older kernels.
@@ -171,11 +171,6 @@ It is possible to build rdma-core as static libraries starting with version 21::
     ninja
     ninja install
 
-The firmware can be updated with `mlxup
-<https://docs.nvidia.com/networking/display/mlxupfwutility>`_.
-The latest firmwares can be downloaded at
-https://network.nvidia.com/support/firmware/firmware-downloads/
-
 
 NVIDIA MLNX_OFED/EN
 ^^^^^^^^^^^^^^^^^^^
@@ -490,6 +485,11 @@ Additional information can be found in the WinOF2 user manual.
 Firmware Configuration
 ~~~~~~~~~~~~~~~~~~~~~~
 
+The firmware can be updated with `mlxup
+<https://docs.nvidia.com/networking/display/mlxupfwutility>`_
+after `downloading a new version
+<https://network.nvidia.com/support/firmware/firmware-downloads/>`_.
+
 Firmware features can be configured as key/value pairs.
 
 The command to set a value is::
-- 
2.54.0

