Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B2C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77A1A40B90;
	Fri, 21 Aug 2026 21:28:51 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id B162440B90
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:48 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso956443b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340528;
 x=1787945328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3S/ert9Zu5h/9H9vgbIId5n4Ogwf0Sx2leUgmzPTRA=;
 b=ci15CmELTZ8xZgngR8bZXwpiYBxbVqHvw+jEkyi6k4PybbFQZVroUZcqkrVcsuTCJ0
 pLyrcIJc8U6b5q5L6diDugSNnxhGaKtNr4OWWCmfahKRe1IP7Blvxnp3R9QA22GkV38H
 15APxgBMzhlz0nl0N93ADXsA1vcvUFHjixvwFwbWoxtHFXjk8O8tgT9UKy8nMPpt2dCk
 ob53Bxx3i4jjjsEJ/FCLD7VGE5isTcfG5nbhQiiWNXD3cOx759wr5aXRbGd/NjhT75Jo
 3ItNMtxqIjwTGDHlGg6TWxZJAJnZ4qVBWjdZlOZZezK0uah3b++GV5ihGkEmN3cKgqEa
 o9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340528; x=1787945328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f3S/ert9Zu5h/9H9vgbIId5n4Ogwf0Sx2leUgmzPTRA=;
 b=JegiZ+Jl9Qapuhc7xTwAVwQ/mGkPd0q2yXyoKx6AzRd/LIUs+EX1RknG8Qa94y+0ct
 cWdFlTB1r8g7cjthZ9H/KkHcS88nNPyAHM4yhPVkXZZx0KW2cf6IoMAsWNH0ac5+vpz7
 yByoORODsf2Sm6K3zZ7QnzOmLLPuGzFIdjhMNrmtRFKjkthUfQvhGi/ucx86pRvvKsVi
 nDQTvJ8QZ0dzwYeiLwseiwlH9iqLYXPwxrJTaWqIcGZK8x/F92xtMkK+bfIb80Lm3yBo
 YkVAddyM7fyPbdJ9zOcf8gTI9Z1KyPwlWmG0WTWR6DtW1v27fiXrtlMk5Cyv8hv4KOAq
 4VfQ==
X-Gm-Message-State: AFuF++mPzr/IR6HHgEbEg/x75MavIbx9XjMnMpMgz3lbTdoaDBY0SVbV
 xQrDe39abdpN6qQiCok51S8RO4cbuao3uZkU17gHbem6w/Hcw+hqGAJ3khU9m4p+z2I7n0Mb5PL
 VOnBC
X-Gm-Gg: AR+sD11CpdPIj7SC9gL/1afciAA3dRyclb60ZxRGshRww1jPQbSiAdE6Ecp6rBOmsVz
 1kDv+n/r9BPxtzjc5KuAz0Ur9Gu7lz27n2rhf8OutcNRUck/yUX1t8eeAIxoguNPo+AiT3EmSJu
 QgAv3IQXSRu8kEDdSV3A2oHSG+gz7j1W7lgTTZUDAloaPB4lc8pGr9vziOEQeipHHeb/mY4IXiN
 ex4fQ0sj0Y7jt8Q4REmPiOJF2VCCQHlDKv10PnmnKFIqZzlZHYYWr5aN/61zY3RDMQqUYoCjNpZ
 f3wBw1DDBl6Uk74LTpmMtOyhg1MgvHoK3FovfTh5nZJCM2cRz7tMyD7LwJRijArhfuX0lCiThOO
 +oWX3NbSv/ovEhGBmAdE0k0HPJaYjKkPUgVPVrZlgNMb6V8iqn+i10YW886uYir3OORGFkhAmBj
 yH9Q28u3XG0zBDIjoSSe2owtvCUKGm+XZjHFIijK9KpRq0PAoI6TMMdeSsnxkYkGgo/0mtobIV1
 pDW9ScNnHMlUmXLufrrvbB5CSQ=
X-Received: by 2002:a05:6a00:3a1f:b0:84e:909:ac03 with SMTP id
 d2e1a72fcca58-851f9a4e57dmr13456215b3a.10.1787340527861; 
 Fri, 21 Aug 2026 12:28:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v2 14/68] drivers/bus: remove unnecessary include of
 rte_memcpy.h
Date: Fri, 21 Aug 2026 12:24:09 -0700
Message-ID: <20260821192646.146382-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The file is included but rte_memcpy() no longer used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/auxiliary/linux/auxiliary.c   | 1 -
 drivers/bus/fslmc/fslmc_bus.c             | 1 -
 drivers/bus/fslmc/fslmc_vfio.c            | 1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c  | 1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c  | 1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c | 1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c  | 1 -
 drivers/bus/pci/linux/pci.c               | 1 -
 8 files changed, 8 deletions(-)

diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 3a2dca2865..26d48efedb 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -8,7 +8,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #include <eal_filesystem.h>
 
 #include "../private.h"
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 3626b12316..638f541d32 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -14,7 +14,6 @@
 #include <bus_driver.h>
 #include <rte_malloc.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #include <ethdev_driver.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_vfio.h>
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae..d7f6f2819f 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -28,7 +28,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 925e83e97d..eacfbe1df8 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -15,7 +15,6 @@
 
 #include <eal_export.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index b546da82f6..3d582d1154 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -14,7 +14,6 @@
 
 #include <eal_export.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
index 6fd96ec0b9..fd34f31518 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
@@ -13,7 +13,6 @@
 #include <errno.h>
 
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e17050b625..be878c2fff 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -29,7 +29,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..45b42b16e4 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -10,7 +10,6 @@
 #include <rte_bus_pci.h>
 #include <rte_malloc.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #include <rte_vfio.h>
 
 #include <eal_export.h>
-- 
2.53.0

