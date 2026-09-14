Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68BAC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D20E410D3;
	Mon, 14 Sep 2026 19:37:44 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id D8FA641109
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:41 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-86908cbc011so5256846b3a.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407461;
 x=1790012261; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=TTnwQs7gtBVr9em7k1KI5DqjNKbvyJCzx+cm9Cmqr9Lg4BEhdOc9W28SQgEKK2EECc
 viaQEvbNz2/Wfod5jRnV0l/xA9mhSlb8958mj/26SwcZuIGY1V/d6Wh7UIdWPNo+K1Cj
 3IZI3brk1xl5NNkXwIbahe1yu/deA5CEr/qqAx28PZ6o9kdVja6BxMtAnrch5oLWkG32
 8S7Z/Nnt0oHgitg1PvGIHQY0doL2jA4sxf8V7u7jUaey4/MdDtSnCE6vGDhLdfyUY9Ge
 rjFt4i5J8L4MkcQwf0mwtAtrxA+Jrca2qHpzwFt7XKXBzGpt10mRAjFVTyGTOihUO8ef
 +3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407461; x=1790012261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=e0J1Ft+OdjYVObBpu57Mez8HFdyMOvMjmP6U7zQ/b4mJL7rioj0Y4+ePz875zVBcBz
 hd/I6GcILeXtOhbJlwITisVIFPDWPPnoPWh/oPNhxhBXDxzulRNtkhQCorCnSDTC4Oav
 flGFx9ojpKz8iDy5kB2zOnqmISs8moZ1E0Z1PJNt7v3AayT5BMSBqLTS6gs5ZVqcL7QJ
 TuIoSvPwUNqTeDW4K98QycmN3mkEKQXgDVWrn1iyJ27+H78PveUg2rwEnBbl/eYdf7pE
 098j28asposgoYqfR8GYgcHshwfxjDEI0nKglnevzp1WMaX/RLf/L/ao9ivCyAVB+zBm
 q83Q==
X-Gm-Message-State: AFuF++nDbDT5UhYd0WdOI+zekZaqEMwplqQ2d7+KY2WtzX4p8cde9fi8
 oekHRR8P9GbZ92+ioAqaEFQj6Kt00GY67V19z/f+yiA67a5AWdg8ZOh3faHmHM6pIkdjXxrL/gx
 7Ns1APXAGLA==
X-Gm-Gg: AYBFou2HxejH8TMjPVQOjsSMQtrkMy3wG8WgZnbw2Da7bTGv2EG/HBHWK1aUXA4jheR
 1wcH6Tyh4uQDp5+AD7Ykm5A97kDTcPUAKH2eOYKLG9c3dDZat4I+agZk5GIEsHRKelUqt7jfewO
 XemmgRR9dLs2Eks26yEfY8Un8Sp3TxU9dIYLu8AAyzCHZlJ6XhSqZJn/0KQOgah3FeLKMQXYZPi
 F3vkS6NiAV8jkvSRgLXOqNsgTrh058F348m+ItArT7VaOCthbnw6ncvPoY2fkaI2o++HAHwrR2A
 8pYfZjRppnws6ZnPym89RTqQ+ed3Fe/sKDEdPJ7ZsPEX/sQBMkb5eeU4Vy6hZ/zTbcJsdRiWq+J
 p0g6TDWgz2mtD+3WAyXK9ORqLoPV6naBJLFdCR5dgti8d5c5jkP2aZkUf4CWWsK5hOxw8IQjgWZ
 8Dr5xSarBINMlIEOvFDw5uAcxiOLazabl+aq5zhmog4koQRVAEyzp9uB9oDzq+V/7CXjbPm61jH
 AACB9+NQ1wCYR3Iq7AA+QEBYmIzv++ZISBC8Q==
X-Received: by 2002:a05:6a00:438d:b0:85f:2f32:7a53 with SMTP id
 d2e1a72fcca58-86f85ae9d18mr7281434b3a.17.1789407461029; 
 Mon, 14 Sep 2026 10:37:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 7/9] common/mlx5: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:20 -0700
Message-ID: <20260914173700.2795983-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

