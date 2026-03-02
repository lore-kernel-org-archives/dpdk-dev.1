Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EACEB362C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 20:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA4A64028C;
	Mon,  2 Mar 2026 21:21:50 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id CA74C4025F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 21:21:48 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1271257ae53so5802891c88.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772482908;
 x=1773087708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Iu126MGO0o1UlyH2g/pGLeP1K7kg90l+Lew0oY/z+hw=;
 b=odenzqewSmscODZ2USIV9LJKqk+kf4Dc/H5i9ogE54gbLdt/xwOQBugjNJeh2cTV80
 bYyO0G8gkztcSESWZiepx0NJloNRWrXmSG4npa5biwlhQHzFUORfQmKDkWoKqU1gUWlq
 a5ypwoIdSVKgN4uhi7mccJ37AEU7UHY8b758sVjV40t9/hyPXq7vmcym3x0xXnVNtxz3
 IdDfJP8d6u9PXt5ksX8DuV+7rRbX4pwgmRY35UGntIhij3Yv9qEWXYJLx7v1NJgkSBb9
 fJC8h3ZEOTMbV5YxrhqqVNAMKGq9+Lv6jXzc07teY1dFyXbgNkrPvcDjtPddxtSl4mPR
 Wp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772482908; x=1773087708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iu126MGO0o1UlyH2g/pGLeP1K7kg90l+Lew0oY/z+hw=;
 b=Li8vAupi6pHKQR/ek+LxvTtu0LweLKgxAhpEkWtKqML4+rrzDhu3nBxx0slAyzkT2P
 HvFPINdQXCL314SCFpe6RlB48Og+7gO+EvFXsQoPfHJsE+FH3+g1omOEmnkiIx/yjNyC
 lajhKDX4bUslN8zi0xT9HD7Uvs/tx3S1mZxKjm+SDHkdEO7RlO9ByAIjQxW17pZnCXDf
 RzxZmWlGQ0h7OUTRkOn3Ms5R+553YNbzXGTzoUukkCxxaHfayt0EimM1MuFRW6fPRgL9
 Wd/Kyn7UJJVTMDnJeYBEa8PLnOIPWWsDAYR7Q7JpaNlLiSDZwgWg/HOniJqn+YcMXlOD
 c+Sg==
X-Gm-Message-State: AOJu0YwV7bZTD1C8C5e/lQMV4vuxQVShtVMIOOZQeOMfcyCSyPlto7ri
 pflngOJkZvuHaZeQK1uxJld52ShkwEOHwVyjkSDUmScn+bTIYkQOAo26F4WSnpnuCDZrGy8Yuq9
 VbJNkGrg=
X-Gm-Gg: ATEYQzw4JDrxr+I+JlCV0wNSb+b0dwJ4kKd2eM9szrmuRqzwYt6z85o66DNsi0A4reV
 wT92rEBkKT9XwPoT8xiUtfatH4x4AIOvtB/e6BcT/6BKoQBvlFbX+XlBeMTU4g0vZ0tBU9GI+B6
 MAcyW0Uzdd3OFvl2EpWCKPtEj33IWM7pJUmq6uaBIzw8zRgIKKsPgLmmaB23LI6FqxoJGSnIK8q
 TEgOY86OGe9mkj011vC0k0pFhrPdXLeDLSm6t95vFEIfeYXPz1LQeZzN4X4E6txSdQkVN9JP/07
 e+XFlRmpjPMMRIFWTK9fqLTIvmUUX2+kv8jN/dQ0VieRe9ku6VseLxtPU9gR9Y11abfJ9o7sFJr
 w75GcML+OCynG/OEru6kxeWZ940V6qS3I+XCAVBgfnBlSevmdkwFIrY4zwgtJfIBGBRK5igcscy
 YJTOs8kTetvZ6uz2cXIrbYSYRSvuf/pVxXwYCz7LdSRhqOIUiD5x4qSSVjmGqKjQ==
X-Received: by 2002:a05:693c:40c6:b0:2be:494:71ce with SMTP id
 5a478bee46e88-2be04949b2bmr1884713eec.18.1772482907459; 
 Mon, 02 Mar 2026 12:21:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2056acd1sm444066eec.22.2026.03.02.12.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:21:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH] doc: fix documentation for NBL PMD
Date: Mon,  2 Mar 2026 12:21:44 -0800
Message-ID: <20260302202144.253145-1-stephen@networkplumber.org>
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

The revised documentation had some issues with formatting and
setting up vfio-pci was not described. Use the existing ENA
documentation as a template to resolve these discrepancies.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/nbl.rst | 42 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
index a9f439ae96..da4604781e 100644
--- a/doc/guides/nics/nbl.rst
+++ b/doc/guides/nics/nbl.rst
@@ -78,40 +78,36 @@ it is necessary to force I/O virtual address (IOVA)
 to be mapped to physical address (PA)
 with the EAL command line option ``--iova-mode=pa``.
 
-Only PF supports Coexistence Between DPDK And Kernel Driver, VF does not.
+Only PF supports coexistence between DPDK and kernel driver; VF does not.
 
 
 Prerequisites
 -------------
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-  to setup the basic DPDK environment.
+#. Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
+   to setup the basic DPDK environment.
 
-- Learn about `Nebulamatrix Series NICs
-  <https://www.nebula-matrix.com/main>`_.
+#. NBL PMD requires the ``vfio-pci`` kernel driver.
+   The ``igb_uio`` and ``uio_pci_generic`` drivers are not supported.
 
+   Insert the ``vfio-pci`` kernel module using the command ``modprobe vfio-pci``.
+   Please make sure that IOMMU is enabled in your system,
+   or use ``vfio-pci`` in ``noiommu`` mode::
 
-Multiple Processes
-------------------
+     echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
 
-The NBL PMD does not support multiple processes.
+   Note that VF requires ``vfio-pci`` in ``noiommu`` mode
+   when no IOMMU is available on the system.
 
+#. Bind the intended NBL device to ``vfio-pci``.
 
-Limitations or Known Issues
----------------------------
-
-32-bit architectures are not supported.
-
-Windows and BSD are not supported yet.
-
-**igb_uio Driver Support**
+#. Learn about `Nebulamatrix Series NICs
+   <https://www.nebula-matrix.com/main>`_.
 
-The ``igb_uio`` driver is not supported.
 
-**uio_pci_generic Driver Support**
-
-The ``uio_pci_generic`` driver is not supported.
-
-**VFIO no-IOMMU mode**
-If there is no IOMMU available on the system, VF must use ``vfio`` driver in ``noiommu`` mode.
+Limitations or Known Issues
+---------------------------
 
+- 32-bit architectures are not supported.
+- Windows and BSD are not supported yet.
+- Multiple processes are not supported.
-- 
2.51.0

