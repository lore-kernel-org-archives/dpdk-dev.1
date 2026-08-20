Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D6C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06C65406BA;
	Thu, 20 Aug 2026 07:23:34 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id F18D9402BA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:32 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2018017a91.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203412;
 x=1787808212; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3S/ert9Zu5h/9H9vgbIId5n4Ogwf0Sx2leUgmzPTRA=;
 b=mvPSz9jZUisV4PUy64NSezwwMlkMqN0e/JTjrxiW6QdVo+m2Hc7rkNPm64VnHtQZvG
 965/BkA5BqucjcyuIqMmZ2DeSoz0f8KX0rXpN5f/8oAqP/vD1FsknLVrcWp0F2m2J87b
 YTXxLi42ou92HMpLffo26LjE0byRlAnMzPco8zA0FV3+J6ZBJSVe5I5VkJ7dYXp2Rh52
 KayJBwFdP+1hd3+p2EHTBa4JvfLu95WH+HUSxkL0UktRZam/OZ76ZwOAr+Fd9UyzUihC
 N54ip6/pj3Ej/FeU2mDWBOlD/IOWxKX5SkECuWzcVJkVpmtUuDKRvta7KVAHXYrGT50L
 5Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203412; x=1787808212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f3S/ert9Zu5h/9H9vgbIId5n4Ogwf0Sx2leUgmzPTRA=;
 b=Fs2ZbeJpgM+7Bi1SExmE6rVotFFXxX6wQl6a0R25mrTfVl5zdIVCygpMTINppMtGrU
 URhCwVAQpS+Jv/EtaVp30wsHsqz13YnuaPYsufUO2HrTsr/xRW1h3bJQ9gotoub7D3QE
 1twyHzJ9TOx+Vc1S8Z/9CGh6ATZUYACRtYMB3HTwR2snhDosVSGdwtWlBqEbEtrtBUkb
 +4/GuvCOAaXPwriMbZtsLBY3G6f+P8itB2XD2YpRTlc1rXKURZvmJoZlemLBkAHiWhL7
 9lr2foc/DzOyietjh9gX/9laKQlpLpXamJPqNpkd0ag3m4bs1joBfCMpf9mlqdBPq0z/
 YHcQ==
X-Gm-Message-State: AFuF++nVUqJHDZAPU17lfRGrlj0m1kJ4UNHjDKiYOqBLEjdtljIwfoqp
 ZXos4s5TewWcKsE1H2lZV2nibhZJPIH/bHKwiTruhqIb+07p+NY/ij8XgkrHewIpDAJvlL3YsaB
 fewbD
X-Gm-Gg: AR+sD10/dzuCv6H+g+4jSyf2yaq8mLODv76mmKmBqCizm20b8xisgdGXR8+fKvFc2bG
 n8OsIb2GOrtND0NkIjJMNn3PKRVQYCMtYUOhwZv09WA6le9i9vk4uu9SzCrTaIY+NTMmdIDO5sQ
 BGg+x8vbjg2Ah3Sax7J+CiZ0lXC8G/h4dWdBMDq/xvrwCfu0HBwl9Na5djdBJjKD9ORn5hmDec8
 QbXtFn7FoWcoRj/cPvUEJ/ikjIbxxxi/33QYPMRUK8eA0J6OClmFuxuV0drElUeWjOZrMaQXP+/
 6q/n++d5tJT2Vmw94gSaJlbeiSyjfMGSToBXnrK2i321nww+eH8QzuXwNFHXT2qP7IOw0Bii12m
 zTC8Mfbd+Lnmi4setodMAN7ZuVUec63OymjKCBPSzKebmxxiD/cBWW7Ip9eJukVXv4icR93a8cv
 mtQerqfX9XiwgNxVbD1T5Tfp+jNnJOHhnzJVRpOAUeWQMUS93l15pkRpen0zyFaifYRFLxY7m/n
 EW9SKPEpOgvPkxlH5I15S/X6Yw=
X-Received: by 2002:a17:90b:2d85:b0:385:393e:7124 with SMTP id
 98e67ed59e1d1-3958127ae44mr19059961a91.14.1787203412078; 
 Wed, 19 Aug 2026 22:23:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 07/61] drivers/bus: remove unnecessary include of rte_memcpy.h
Date: Wed, 19 Aug 2026 22:11:57 -0700
Message-ID: <20260820052251.1453273-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

