Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78125CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBB0440651;
	Fri, 29 Aug 2025 16:50:11 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 303514042C
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:50:11 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-244582738b5so19657065ad.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756479010; x=1757083810; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0WiZKuFv2yHMjM9vanz5jGs3Rv2MYxGf/96u97IfqL8=;
 b=fyzmAwII1gVBlCXW9OHyiD1kHjj2ILNr8s4c6N5thHpiQ0YQnV4yqgrbh4ZxIqIPAy
 h/vVSPSvnH8sDVINtd7iNIbzOGw6JIEqsofn7lfRjK++xIkqWfdmwRseiIPSsZfKAEky
 eTAkHMsMCfdpdoN1JO2fyWPwIU0jyZtsw4ku9ElZN3FF21GH5SYH7ZuQaMyPn7QhPAmD
 N7L7nbbB9eBoqRAeZiF0cI6bKD0hstjBDF867ZWC7mnjhTYFuq8DNMJAj1nv02dAvkZ7
 96JoiqG0vlzqiMLxgG0fdYbenwL1oezJdhN/Qa06r+JhFBN+fvFB1jnaIhTxV7Yo8p9Q
 xhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756479010; x=1757083810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WiZKuFv2yHMjM9vanz5jGs3Rv2MYxGf/96u97IfqL8=;
 b=HjR6+3kMpRtxkiPobj66Mv/SftYdvFlijxIl80xcPERjoGDr4kLXUtrQ7IDqKbLX+0
 LHCnK8CC7uwsROlISxzl788VeOmYYdSGvnkePoGDBDgu0lisVLpnYcoB7nHJA5okms9a
 KsoKjGQ2PWbT6ww04Qb38/obsBmoCtJFaIQLvD3M6TS76UoZWlderCMoDlAktzSNvPwe
 rg+WPpbTw/IMokGrDdEOfr7uEiPQnYG4J3GjBvP8POFKduiGopnTTCIKfL/haRw7iJpd
 9LBFaoyX0JldjSVmGVADc06DElKEmwKWOCsy6ZCpp0J/GPvUafANdsnHC+Zi4KM3q82s
 N2Ow==
X-Gm-Message-State: AOJu0YxnnPozhdURWkY84brHOxanB5m8UGh0B+fqRuZDUUr82c7rLefk
 gXT8EJ33lPy6rr5AYntn1jO78T4FeXlkb0Qfyjr/MLomzzIHn352B6JZ4XuBSoxn
X-Gm-Gg: ASbGnctF/z16mNXKLHAodEO14eepjeUcfYuFqv/PYqUMuOm5VFeuqr14mq+lfxRNGaC
 zCw7WxKrBCfhXlPgi2sfuD65I9WuudeV8ZzU2QkBnqTauR/yLWraYczQgNTCkj2epK84KwJKTo4
 t84EoyRxCXAZNUj1VTEuMFvWglXrVRz9BMeIs/t/+dCOLhCjIQN9KpQWWfFXLhHptUNXNkUdTaY
 xYBlzMq5dCs66vPbzq/YFSOt+1WlnqS8HpNA76kUGLeesE/vX+stmybm7vA1sozjzExa7tXNrsY
 5MW1wqkZo9592sYLCy6h4EINv03zwOPDChoq9J3cj5cz6nauVEsyStMf8rbcuj3owd/zwOXDYQG
 wbPj76nWANfSYB8Pa09SIckSuTb1eIXTZXGqndXt8eJeIYx7o5osqqxVH75QNmVRm
X-Google-Smtp-Source: AGHT+IGQVxeW+r0PkD4jxsbLXsbnNSo5A+GwFyOOlML28/6o7QBf9O8PJErlXKWk9GrsuV0MuUrJJg==
X-Received: by 2002:a17:903:1a8e:b0:246:620:a0b9 with SMTP id
 d9443c01a7336-2462efcaaa3mr335697175ad.61.1756479009945; 
 Fri, 29 Aug 2025 07:50:09 -0700 (PDT)
Received: from localhost.localdomain ([125.120.234.137])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065ad5b7sm27510985ad.128.2025.08.29.07.50.08
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:50:09 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: dev@dpdk.org
Subject: [PATCH v3 2/2] net/mlx5: improve debug dump file path handling
Date: Fri, 29 Aug 2025 22:49:53 +0800
Message-ID: <20250829144954.2576-2-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250829144954.2576-1-mosesyyoung@gmail.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
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

The current implementation always tries to open debug dump files
under /var/log, which may not be writable in containerized or
restricted environments (e.g. when the filesystem is mounted as
read-only).

This patch introduces an OS-specific helper function
mlx5_os_debug_dump_file_open() to unify the logic:

* On Linux:
  1. Try /var/log if it is writable (kept for backward
     compatibility).
  2. Fallback to the DPDK runtime directory.
  3. Finally, use the current working directory.

* On Windows:
  1. Use the DPDK runtime directory.
  2. Fallback to the current working directory.

This preserves the previous directory preference while ensuring
debug dumps can still be written in restricted environments such
as containers. The structure of the open logic is kept unchanged
so that test cases and expected logs remain valid.

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 drivers/net/mlx5/linux/mlx5_os.c   | 44 ++++++++++++++++++++++++++++++
 drivers/net/mlx5/mlx5.h            |  1 +
 drivers/net/mlx5/mlx5_rxtx.c       | 16 ++---------
 drivers/net/mlx5/windows/mlx5_os.c | 30 ++++++++++++++++++++
 4 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 696a3e12c7..fdb2102cd5 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -3020,6 +3020,50 @@ mlx5_os_net_cleanup(void)
 	mlx5_pmd_socket_uninit();
 }
 
+/* Default system log directory on Linux. */
+#define MLX5_SYSTEM_LOG_DIR "/var/log"
+
+/*
+ * Open a debug dump file on Linux.
+ *
+ * The function attempts to create/open the file in the following order:
+ * 1. /var/log (if writable),
+ * 2. EAL runtime directory,
+ * 3. current working directory ("./").
+ */
+FILE *
+mlx5_os_debug_dump_file_open(const char *fname)
+{
+	FILE *fd = NULL;
+
+	if (access(MLX5_SYSTEM_LOG_DIR, W_OK) == 0) {
+		MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
+		fd = fopen(path, "a+");
+		if (fd) {
+			DRV_LOG(INFO, "New debug dump in file %s", path);
+			return fd;
+		}
+		DRV_LOG(WARNING, "cannot open %s for debug dump", path);
+	}
+
+	MKSTR(path2, "%s/%s", rte_eal_get_runtime_dir(), fname);
+	fd = fopen(path2, "a+");
+	if (fd) {
+		DRV_LOG(INFO, "New debug dump in file %s", path2);
+		return fd;
+	}
+	DRV_LOG(WARNING, "cannot open %s for debug dump", path2);
+
+	MKSTR(path3, "./%s", fname);
+	fd = fopen(path3, "a+");
+	if (fd)
+		DRV_LOG(INFO, "New debug dump in file %s", path3);
+	else
+		DRV_LOG(ERR, "cannot open %s for debug dump", path3);
+
+	return fd;
+}
+
 /**
  * Install shared asynchronous device events handler.
  * This function is implemented to support event sharing
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index c08894cd03..fc7ac08039 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2597,6 +2597,7 @@ int mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_free_shared_dr(struct mlx5_priv *priv);
 int mlx5_os_net_probe(struct mlx5_common_device *cdev,
 		      struct mlx5_kvargs_ctrl *mkvlist);
+FILE *mlx5_os_debug_dump_file_open(const char *name);
 void mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_dev_shared_handler_uninstall(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index);
diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
index 82c5481ad7..b35365ffd3 100644
--- a/drivers/net/mlx5/mlx5_rxtx.c
+++ b/drivers/net/mlx5/mlx5_rxtx.c
@@ -391,7 +391,6 @@ mlx5_set_swp_types_table(void)
 	}
 }
 
-#define MLX5_SYSTEM_LOG_DIR "/var/log"
 /**
  * Dump debug information to log file.
  *
@@ -411,20 +410,11 @@ mlx5_dump_debug_information(const char *fname, const char *hex_title,
 {
 	FILE *fd;
 
-	MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
-	fd = fopen(path, "a+");
+	fd = mlx5_os_debug_dump_file_open(fname);
 	if (!fd) {
-		DRV_LOG(WARNING, "cannot open %s for debug dump", path);
-		MKSTR(path2, "./%s", fname);
-		fd = fopen(path2, "a+");
-		if (!fd) {
-			DRV_LOG(ERR, "cannot open %s for debug dump", path2);
-			return;
-		}
-		DRV_LOG(INFO, "New debug dump in file %s", path2);
-	} else {
-		DRV_LOG(INFO, "New debug dump in file %s", path);
+		return;
 	}
+
 	if (hex_title)
 		rte_hexdump(fd, hex_title, buf, hex_len);
 	else
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index d583730066..734b71e3f7 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -629,6 +629,36 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	return NULL;
 }
 
+/*
+ * Open a debug dump file on Windows.
+ *
+ * The function attempts to create/open the file in the following order:
+ * 1. EAL runtime directory,
+ * 2. current working directory ("./").
+ */
+FILE *
+mlx5_os_debug_dump_file_open(const char *fname)
+{
+	FILE *fd = NULL;
+
+	MKSTR(path, "%s/%s", rte_eal_get_runtime_dir(), fname);
+	fd = fopen(path, "a+");
+	if (fd) {
+		DRV_LOG(INFO, "New debug dump in file %s", path);
+		return fd;
+	}
+	DRV_LOG(WARNING, "cannot open %s for debug dump", path);
+
+	MKSTR(path2, "./%s", fname);
+	fd = fopen(path2, "a+");
+	if (fd)
+		DRV_LOG(INFO, "New debug dump in file %s", path2);
+	else
+		DRV_LOG(ERR, "cannot open %s for debug dump", path2);
+
+	return fd;
+}
+
 /**
  * This function should share events between multiple ports of single IB
  * device.  Currently it has no support under Windows.
-- 
2.49.0.windows.1

