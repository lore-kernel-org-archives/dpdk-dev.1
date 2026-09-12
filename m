Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C0C88E59
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 379A5406B4;
	Sat, 12 Sep 2026 19:04:23 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 880E3409FA
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:21 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-868cfc5c244so511967b3a.3
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232661;
 x=1789837461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=tWIwqsDAJZUM/C8j+s51yyvDzGsHJHK70A12xLytZzgas1UgLVROek6Uf94OZcPNPf
 Zqpl2ix+KBC8RJHeJdOTyOdQSE/0qIcg/12+veAkN0L51/Zwjrc6gYdUQ9eWhgb5yRX3
 6h/lqmEi/nuC0iy3NiO4buJ5zwTV8gP3t9aX7tpMkcAZu3TjlqbsqFFZALZehkH8a9ZR
 TsULYAmy5orJplypbeyqlaA0TT5bXaBPqXLJQ0LSSQuoJlPUOgmiOUinilEsfIiRPeZL
 A1Wn8igYUJyoltWXrhwcJjB4g6yIsIh+2rUw+umSVkQWcYh2+y16O+aS3rBza/3YHyaa
 g2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232661; x=1789837461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=EDIQFTWFYfhIDyziYp9bUkHz9FtzhQ+RkL/w8XXmgQ8Eoc9WIUWrSlMtknW0QVk5hp
 lmdUF9/zN7anTwgMjYF8AOUsMYHhflzTa1zxJFHCYiSfO9vyZ+e9ed2k/laTmN7mUnhL
 CnT+kNHBjO4cvTff7qppXf2EJLkT16XUH0Sm4w0Abtr7uOviOVjgNe4vZsgJK4flNZzv
 udV8SzRP73Y1wtKYpY6bubx8BvDKObEZlIjONMarh+5zClx6ugvgcKiLw34OZOXljNKl
 +I9sL5epvbUlkNCNXgjGc/PvupJCzA5CTCfOXudCqGfr3O0dZmlVpUj+7I00++wlNxC8
 PMfA==
X-Gm-Message-State: AFuF++mSieP5oGBLiVgldEUGx3bFHAucyj2jx8No/0De/sJh5FP81Bwa
 uMymBHEjuexY5r8Sg0hQkHeaaSDRepa88AFTL/7l71SEM2g6jLp/5A2Ob9ugwX7Rp7bUXVst3Bf
 ovT7FVrY=
X-Gm-Gg: AYBFou2ic1qxMjRrXXnZBO/l2Nc8jH/0LC17fyypE1iIFc8g8tnUTXAxc0G8uoImEb4
 gTn4aQny+hqIGqZZxWq6uhlNuYV1W3dsRESorlh1f7Uuz7ZUcTkeEdXa3Um2tkAAONOz3ksrRp6
 TH3tnN3LpOeiBOi7osZrHRbP3XlkFb1tTCbbwX9x7epciXBjaFl/tdxRglWfq2hyI/bXZ2JklJo
 uIZC31JTX4VNqSKqNjt6b8OR40OTXTEdEZx7uKf1Jc6ZyfZdhrDscg0RfzPLdI1coQv4tYgnhPy
 5istZbqT2cSU3AEi7QcYBfEn9pBti4mVSVZS3hxfXUJeaaWBmUIBnvhZUw/FGWhvzniR2Swyxa8
 +jKQCT6UI7RjDJIc99vHjK5kkfmYDEGIJp6hC0+KF2pChvn64mR9ZV4QLhfN3lCI0k+eMYAwgFw
 Kiyw08iQzRw5qnhJeaixxd8IJV892rZZQmJivi31n6hZT5wTZhPgxw1BimzycY4Fu+Qzx64jUuz
 4Tb2DqLmHGcOTJjeO0cOMYPxLZazeL3tRqsQw==
X-Received: by 2002:a05:6a20:939e:b0:3d3:adbf:7784 with SMTP id
 adf61e73a8af0-3daed4ec53emr18167200637.25.1789232660667; 
 Sat, 12 Sep 2026 10:04:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 7/9] common/mlx5: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:19 -0700
Message-ID: <20260912170338.486978-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

mlx5_sys_roce_disable() read the roce_enable attribute and then
reopened the same file to write it. Use the EAL read and write
routines instead.

The dev_port lookup is left alone: it selects the scanf format at
runtime and distinguishes ENOENT from other errors to fall back to
dev_id on older kernels.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 39 ++++++++--------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 3e9cd86062..cf496b0b58 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -16,6 +16,7 @@
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 #include <bus_pci_driver.h>
 #include <bus_auxiliary_driver.h>
 
@@ -658,45 +659,33 @@ mlx5_nl_roce_disable(const char *addr)
 	return ret;
 }
 
+#define MLX5_ROCE_ENABLE_PATH "/sys/bus/pci/devices/%s/roce_enable"
+
 /* Try to disable ROCE by sysfs. */
 static int
 mlx5_sys_roce_disable(const char *addr)
 {
-	FILE *file_o;
-	int enable;
+	unsigned long enable;
 	int ret;
 
-	MKSTR(file_p, "/sys/bus/pci/devices/%s/roce_enable", addr);
-	file_o = fopen(file_p, "rb");
-	if (!file_o) {
+	if (rte_sysfs_parse_uint(&enable, MLX5_ROCE_ENABLE_PATH, addr) != 0) {
 		rte_errno = ENOTSUP;
 		return -ENOTSUP;
 	}
-	ret = fscanf(file_o, "%d", &enable);
-	if (ret != 1) {
-		rte_errno = EINVAL;
-		ret = EINVAL;
-		goto close;
-	} else if (!enable) {
-		ret = 0;
+	if (enable == 0) {
 		DRV_LOG(INFO, "ROCE has already disabled(sysfs).");
-		goto close;
+		return 0;
 	}
-	fclose(file_o);
-	file_o = fopen(file_p, "wb");
-	if (!file_o) {
+
+	ret = rte_sysfs_write_string("0\n", MLX5_ROCE_ENABLE_PATH, addr);
+	if (ret != 0) {
 		rte_errno = ENOTSUP;
+		DRV_LOG(DEBUG, "Failed to disable ROCE by sysfs.");
 		return -ENOTSUP;
 	}
-	fprintf(file_o, "0\n");
-	ret = 0;
-close:
-	if (ret)
-		DRV_LOG(DEBUG, "Failed to disable ROCE by sysfs: %d.", ret);
-	else
-		DRV_LOG(INFO, "ROCE is disabled by sysfs successfully.");
-	fclose(file_o);
-	return ret;
+
+	DRV_LOG(INFO, "ROCE is disabled by sysfs successfully.");
+	return 0;
 }
 
 static int
-- 
2.53.0

