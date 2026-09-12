Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D9CC79FB6
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C356742E02;
	Sat, 12 Sep 2026 08:34:02 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3A27A42E12
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:34:01 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so272980a91.3
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194840;
 x=1789799640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=Qyw3wzVgKgQ2WKAl0+7Lr2dFRCZHPObPVmMccamv50P1ADEgAvP/4hanjhcFTdOQEu
 RNgHo3egPfKZpVODxd8Jepwp1PZbydTxu8dMGXgWEpfS8PlF2BrVJck1IYnPdNJq1IIS
 4OQ1uqzwcYJomTUO/2Wr0KNw1OcQYEa5jctyM6wuTsuxBEPTqiyro+aMjnBPoiBe4uhF
 ywiG221Tyl//JrbYVIoCK56ZfgZH5VPrvLB6OhlO9Py6gqpQKGiVOJQzOksM6iH+iCaD
 j9SteZQlaibPwCswzSpRv9GXrrwQCO1tmum1CJg0WU6SisE4pJuVoNwY3BvROt5X/PbJ
 M7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194840; x=1789799640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C7JK7M9VK27xxXe6PsJLwe4/YWV0H/4G1Eis3zsGIks=;
 b=J6KF4QFho71yo2+lYCjg7Xum1dOrQUyj3feoCdJyaTsW9TwS1JEVC17MGigfVdB9i0
 qoYfOLlzCTidUHZUKY9sz4iHXtMkzanlaN9Y5o6JrKV08GEtHfIVw5bgQKHnm5vEtjgZ
 Qe4q2zR44O7E5an6m12YooA3ah96V9Ku1Stx87LM8BbNSl09cJARA1ey3i+WKyQAEF3L
 h7gkFc6xhgdAVk5fZwrZevUNoQP+bokKiFjtBoEct+4w1ACFjhzdOZdzpXmPBUZmEP3/
 fCQFsUdYva3pK0lRWmr/wxjsHJtD/Hjx45j3wiPdzYREdtcQqUnf8Lo+yNASrd0q5owA
 QGpA==
X-Gm-Message-State: AFuF++m1OPVOvRdpeGzsASWDL1cJRpeN5koylSxb66TXzOSls7gWja3I
 ePKtCXBu0v6oAd7kATzZuhJe6Y/4j81q2uOkQ+S67AN6oUxRBIvzr4mkpyOACusEBp37Mgo/cPa
 0wBjq
X-Gm-Gg: AYBFou1qQVXvpuCfFQZx9yyt0br0YEQnJIEGI/yFfAW2mBaXXoegcU/FwwTblaMQYA8
 r6lhuAKktZPZJ/mUcKr8KqFXryvRXOstEZ5mo6KS4pyyeleBHPjmVwaCKCj7L+AUlM1KsE7bQvh
 5DL1wYYZnEZUkRdp7R9cCwbSm5aHU8SsKE7b2O7t1bDY/VKBlZEfFiBEVUWTC8OCRehwp5llDi1
 fJUlPfpmUfNmBzHGPLUUBv0O92pid3Pt+BFoxDUGQlFUgfTPvFG8RjFmb/DTTPKKhwBFFzQYtM6
 IZLduxIo/0iWhg4BkrSAiwwdiIC7Ywn2UJMh52PeOYu9n9++mNG5lLAkxN27KK812yPvaCEV5bL
 Dt/OzluXPEhT79SR3eZ0Q3xANQjicKx3eQOPThUg6CPid0Gbm86x9sx4lchmcTfP49wkTb/UXiL
 bjJxPfGN+IlfgChVBuXe5+grDSpkFUlNbAKzQ/ztVNOzSwDVIYaD829Z4X6vM0vOBDzXynj8Fo2
 vr9hMSdQtQBZNer+FYJZj7XdPmGtSFWT4xsQA==
X-Received: by 2002:a17:90b:3b4f:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39dbbea461fmr2812450a91.4.1789194840326; 
 Fri, 11 Sep 2026 23:34:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 7/9] common/mlx5: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:26 -0700
Message-ID: <20260912063319.4117869-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
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

