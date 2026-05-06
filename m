Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8002ECD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 11:36:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4373940685;
	Wed,  6 May 2026 13:36:17 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id A6B9E40395
 for <dev@dpdk.org>; Wed,  6 May 2026 13:36:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowABHs26oJ_tpEyFuDw--.16283S5;
 Wed, 06 May 2026 19:36:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 03/10] drivers: add sxe2 basic structures
Date: Wed,  6 May 2026 19:35:49 +0800
Message-ID: <20260506113557.1151250-4-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506113557.1151250-1-liujie5@linkdatatechnology.com>
References: <20260506095704.1056840-11-liujie5@linkdatatechnology.com>
 <20260506113557.1151250-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHs26oJ_tpEyFuDw--.16283S5
X-Coremail-Antispam: 1UD129KBjvAXoWDZF18JrWxKrWDAFykJF4rAFb_yoWxZFWkCo
 WUJFsxXw1UArn7Aw4DG3W7X34jvry09r15tFWF9rWSy3W7Jr1DGryUJa95Xw1YqFyvgFy3
 Wr9Fv3s8t3s0vFy8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
 kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
 8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUePfHUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

This patch adds the base infrastructure for the sxe2 common
library. It includes the mandatory OS abstraction layer (OSAL),
common structure definitions, error codes, and the logging
system implementation.

Specifically, this commit:
 - Implements the logging stream management using RTE_LOG_LINE.
 - Defines device-specific error codes and status registers.
 - Adds the initial meson build configuration for the common library.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/meson.build         |  19 +
 drivers/common/sxe2/sxe2_common_log.c   |  75 +++
 drivers/common/sxe2/sxe2_common_log.h   | 368 ++++++++++++
 drivers/common/sxe2/sxe2_errno.h        | 113 ++++
 drivers/common/sxe2/sxe2_host_regs.h    | 707 ++++++++++++++++++++++++
 drivers/common/sxe2/sxe2_internal_ver.h |  33 ++
 drivers/common/sxe2/sxe2_osal.h         | 584 +++++++++++++++++++
 drivers/common/sxe2/sxe2_type.h         |  65 +++
 drivers/meson.build                     |   1 +
 9 files changed, 1965 insertions(+)
 create mode 100644 drivers/common/sxe2/meson.build
 create mode 100644 drivers/common/sxe2/sxe2_common_log.c
 create mode 100644 drivers/common/sxe2/sxe2_common_log.h
 create mode 100644 drivers/common/sxe2/sxe2_errno.h
 create mode 100644 drivers/common/sxe2/sxe2_host_regs.h
 create mode 100644 drivers/common/sxe2/sxe2_internal_ver.h
 create mode 100644 drivers/common/sxe2/sxe2_osal.h
 create mode 100644 drivers/common/sxe2/sxe2_type.h

diff --git a/drivers/common/sxe2/meson.build b/drivers/common/sxe2/meson.build
new file mode 100644
index 0000000000..09ce556f70
--- /dev/null
+++ b/drivers/common/sxe2/meson.build
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (c) 2023 Corigine, Inc.
+
+if is_windows
+        build = false
+        reason = 'only supported on Linux'
+        subdir_done()
+endif
+
+cflags += [
+        '-DSXE2_DPDK_DRIVER',
+        '-DSXE2_DPDK_DEBUG',
+]
+
+deps += ['bus_pci', 'net', 'eal', 'ethdev']
+
+sources = files(
+        'sxe2_common_log.c',
+)
diff --git a/drivers/common/sxe2/sxe2_common_log.c b/drivers/common/sxe2/sxe2_common_log.c
new file mode 100644
index 0000000000..e2963ce762
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common_log.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <eal_export.h>
+#include <string.h>
+#include <time.h>
+#include <rte_log.h>
+
+#include "sxe2_common_log.h"
+
+#ifdef SXE2_DPDK_DEBUG
+#define SXE2_COMMON_LOG_FILE_NAME_LEN     256
+#define SXE2_COMMON_LOG_FILE_PATH         "/var/log/"
+
+FILE *g_sxe2_common_log_fp;
+s8 g_sxe2_common_log_filename[SXE2_COMMON_LOG_FILE_NAME_LEN] = {0};
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_log_stream_init)
+void
+sxe2_common_log_stream_init(void)
+{
+	FILE *fp;
+	struct tm *td;
+	time_t rawtime;
+	u8 len;
+	s8 stime[40];
+
+	if (g_sxe2_common_log_fp)
+		goto l_end;
+
+	memset(g_sxe2_common_log_filename, 0, SXE2_COMMON_LOG_FILE_NAME_LEN);
+
+	len = snprintf(g_sxe2_common_log_filename, SXE2_COMMON_LOG_FILE_NAME_LEN,
+			"%ssxe2pmd.log.", SXE2_COMMON_LOG_FILE_PATH);
+
+	time(&rawtime);
+	td = localtime(&rawtime);
+	strftime(stime, sizeof(stime), "%Y-%m-%d-%H:%M:%S", td);
+
+	snprintf(g_sxe2_common_log_filename + len, SXE2_COMMON_LOG_FILE_NAME_LEN - len,
+		"%s", stime);
+
+	fp = fopen(g_sxe2_common_log_filename, "w+");
+	if (fp == NULL) {
+		RTE_LOG_LINE_PREFIX(ERR, SXE2_COM, "Fail to open log file:%s, errno:%d %s.",
+				g_sxe2_common_log_filename RTE_LOG_COMMA errno RTE_LOG_COMMA
+				strerror(errno));
+		goto l_end;
+	}
+	g_sxe2_common_log_fp = fp;
+
+l_end:
+	return;
+}
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_log_stream_open)
+void
+sxe2_common_log_stream_open(void)
+{
+	rte_openlog_stream(g_sxe2_common_log_fp);
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_log_stream_close)
+void
+sxe2_common_log_stream_close(void)
+{
+	rte_openlog_stream(NULL);
+}
+#endif
+
+#ifdef SXE2_DPDK_DEBUG
+RTE_LOG_REGISTER_SUFFIX(sxe2_common_log, com, DEBUG);
+#else
+RTE_LOG_REGISTER_SUFFIX(sxe2_common_log, com, NOTICE);
+#endif
diff --git a/drivers/common/sxe2/sxe2_common_log.h b/drivers/common/sxe2/sxe2_common_log.h
new file mode 100644
index 0000000000..8ade49d020
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_common_log.h
@@ -0,0 +1,368 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_COMMON_LOG_H__
+#define __SXE2_COMMON_LOG_H__
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include <pthread.h>
+#else
+#include <windows.h>
+#endif
+
+#include "sxe2_type.h"
+
+extern s32 sxe2_common_log;
+extern s32 sxe2_log_init;
+extern s32 sxe2_log_driver;
+extern s32 sxe2_log_rx;
+extern s32 sxe2_log_tx;
+extern s32 sxe2_log_hw;
+
+#define RTE_LOGTYPE_SXE2_COM  sxe2_common_log
+#define RTE_LOGTYPE_SXE2_INIT sxe2_log_init
+#define RTE_LOGTYPE_SXE2_DRV  sxe2_log_driver
+#define RTE_LOGTYPE_SXE2_RX   sxe2_log_rx
+#define RTE_LOGTYPE_SXE2_TX   sxe2_log_tx
+#define RTE_LOGTYPE_SXE2_HW   sxe2_log_hw
+
+#define  STIME(log_time) \
+	do { \
+		time_t tv; \
+		struct tm *td; \
+		time(&tv); \
+		td = localtime(&tv); \
+		strftime(log_time, sizeof(log_time), "%Y-%m-%d-%H:%M:%S", td); \
+	} while (0)
+
+#define filename_printf(x) (strrchr((x), '/') ? strrchr((x), '/') + 1 : (x))
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+#define get_current_thread_id() ((uint64_t)pthread_self())
+#else
+#define get_current_thread_id() ((uint64_t)GetCurrentThreadId())
+#endif
+
+#ifdef SXE2_DPDK_DEBUG
+
+__rte_internal
+void
+sxe2_common_log_stream_open(void);
+
+__rte_internal
+void
+sxe2_common_log_stream_close(void);
+
+__rte_internal
+void
+sxe2_common_log_stream_init(void);
+
+#define SXE2_PMD_LOG(level, log_type, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "[%" PRIu64 "]:%s:%u:%s(): ", \
+		get_current_thread_id() RTE_LOG_COMMA \
+		filename_printf(__FILE__) RTE_LOG_COMMA \
+		__LINE__ RTE_LOG_COMMA \
+		__func__, __VA_ARGS__)
+
+#define SXE2_PMD_DRV_LOG(level, log_type, adapter, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "[%" PRIu64 "]:%s:%u:%s():[port:%u]:", \
+		get_current_thread_id() RTE_LOG_COMMA \
+		filename_printf(__FILE__) RTE_LOG_COMMA \
+		__LINE__ RTE_LOG_COMMA \
+		__func__,  RTE_LOG_COMMA \
+		adapter->port_id, __VA_ARGS__)
+
+
+#define PMD_LOG_DEBUG(logtype, fmt, ...) \
+	do { \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(DEBUG, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_INFO(logtype, fmt, ...) \
+	do { \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(INFO, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_NOTICE(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(NOTICE, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(NOTICE, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_WARN(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(WARNING, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(WARNING, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_ERR(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(ERR, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(ERR, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_CRIT(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(CRIT, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(CRIT, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_ALERT(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(ALERT, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(ALERT, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_LOG_EMERG(logtype, fmt, ...) \
+	do { \
+		SXE2_PMD_LOG(EMERG, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_open();\
+		SXE2_PMD_LOG(EMERG, SXE2_##logtype, fmt, ##__VA_ARGS__); \
+		sxe2_common_log_stream_close();\
+	} while (0)
+
+#define PMD_DEV_LOG_DEBUG(adapter, logtype, fmt, ...) \
+		do { \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(DEBUG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_INFO(adapter, logtype, fmt, ...) \
+		do { \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(INFO, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_NOTICE(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(NOTICE, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(NOTICE, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_WARN(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(WARNING, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(WARNING, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_ERR(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(ERR, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(ERR, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_CRIT(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(CRIT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(CRIT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_ALERT(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(ALERT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(ALERT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#define PMD_DEV_LOG_EMERG(adapter, logtype, fmt, ...) \
+		do { \
+			SXE2_PMD_DRV_LOG(EMERG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_open();\
+			SXE2_PMD_DRV_LOG(EMERG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__); \
+			sxe2_common_log_stream_close();\
+		} while (0)
+
+#else
+#define SXE2_PMD_LOG(level, log_type, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "%s(): ", \
+		__func__, __VA_ARGS__)
+
+#define SXE2_PMD_DRV_LOG(level, log_type, adapter, ...) \
+	RTE_LOG_LINE_PREFIX(level, log_type, "%s(): port:%u ", \
+		__func__ RTE_LOG_COMMA \
+		adapter->dev_port_id, __VA_ARGS__)
+
+#define PMD_LOG_DEBUG(logtype, fmt, ...) \
+	SXE2_PMD_LOG(DEBUG, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_INFO(logtype, fmt, ...) \
+	SXE2_PMD_LOG(INFO, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_NOTICE(logtype, fmt, ...) \
+	SXE2_PMD_LOG(NOTICE, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_WARN(logtype, fmt, ...) \
+	SXE2_PMD_LOG(WARNING, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_ERR(logtype, fmt, ...) \
+	SXE2_PMD_LOG(ERR, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_CRIT(logtype, fmt, ...) \
+	SXE2_PMD_LOG(CRIT, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_ALERT(logtype, fmt, ...) \
+	SXE2_PMD_LOG(ALERT, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_LOG_EMERG(logtype, fmt, ...) \
+	SXE2_PMD_LOG(EMERG, SXE2_##logtype, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_DEBUG(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(DEBUG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_INFO(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(INFO, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_NOTICE(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(NOTICE, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_WARN(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(WARNING, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_ERR(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(ERR, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_CRIT(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(CRIT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_ALERT(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(ALERT, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#define PMD_DEV_LOG_EMERG(adapter, logtype, fmt, ...) \
+	SXE2_PMD_DRV_LOG(EMERG, SXE2_##logtype, adapter, fmt, ##__VA_ARGS__)
+
+#endif
+
+#define PMD_INIT_FUNC_TRACE() PMD_LOG_DEBUG(INIT, " >>")
+
+#ifdef SXE2_DPDK_DEBUG
+
+#define LOG_DEBUG(fmt, ...) \
+		PMD_LOG_DEBUG(DRV, fmt, ##__VA_ARGS__)
+
+#define LOG_INFO(fmt, ...) \
+		PMD_LOG_INFO(DRV, fmt, ##__VA_ARGS__)
+
+#define LOG_WARN(fmt, ...) \
+		PMD_LOG_WARN(DRV, fmt, ##__VA_ARGS__)
+
+#define LOG_ERROR(fmt, ...) \
+		PMD_LOG_ERR(DRV, fmt, ##__VA_ARGS__)
+
+#define LOG_DEBUG_BDF(dev_name, fmt, ...) \
+		PMD_LOG_DEBUG(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_INFO_BDF(dev_name, fmt, ...) \
+		PMD_LOG_INFO(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_WARN_BDF(dev_name, fmt, ...) \
+		PMD_LOG_WARN(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_ERROR_BDF(dev_name, fmt, ...) \
+		PMD_LOG_ERR(HW, fmt, ##__VA_ARGS__)
+
+#else
+#define LOG_DEBUG(fmt, ...)
+#define LOG_INFO(fmt, ...)
+#define LOG_WARN(fmt, ...)
+#define LOG_ERROR(fmt, ...)
+#define LOG_DEBUG_BDF(dev_name, fmt, ...) \
+		PMD_LOG_DEBUG(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_INFO_BDF(dev_name, fmt, ...) \
+		PMD_LOG_INFO(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_WARN_BDF(dev_name, fmt, ...) \
+		PMD_LOG_WARN(HW, fmt, ##__VA_ARGS__)
+
+#define LOG_ERROR_BDF(dev_name, fmt, ...) \
+		PMD_LOG_ERR(HW, fmt, ##__VA_ARGS__)
+#endif
+
+#ifdef SXE2_DPDK_DEBUG
+#define LOG_DEV_DEBUG(fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+			LOG_DEBUG_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_DEV_INFO(fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+		LOG_INFO_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_DEV_WARN(fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+		LOG_WARN_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_DEV_ERR(fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+			LOG_ERROR_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_MSG_DEBUG(msglvl, fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+			LOG_DEBUG_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_MSG_INFO(msglvl, fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+		LOG_INFO_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_MSG_WARN(msglvl, fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+		LOG_WARN_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define LOG_MSG_ERR(msglvl, fmt, ...) \
+	do { \
+		RTE_SET_USED(adapter); \
+			LOG_ERROR_BDF(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#else
+
+#define LOG_DEV_DEBUG(fmt, ...)         RTE_SET_USED(adapter)
+#define LOG_DEV_INFO(fmt, ...)          RTE_SET_USED(adapter)
+#define LOG_DEV_WARN(fmt, ...)          RTE_SET_USED(adapter)
+#define LOG_DEV_ERR(fmt, ...)           RTE_SET_USED(adapter)
+#define LOG_MSG_DEBUG(msglvl, fmt, ...) RTE_SET_USED(adapter)
+#define LOG_MSG_INFO(msglvl, fmt, ...)  RTE_SET_USED(adapter)
+#define LOG_MSG_WARN(msglvl, fmt, ...)  RTE_SET_USED(adapter)
+#define LOG_MSG_ERR(msglvl, fmt, ...)   RTE_SET_USED(adapter)
+#endif
+
+#endif /* SXE2_COMMON_LOG_H__ */
diff --git a/drivers/common/sxe2/sxe2_errno.h b/drivers/common/sxe2/sxe2_errno.h
new file mode 100644
index 0000000000..89a715eaef
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_errno.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_ERRNO_H__
+#define __SXE2_ERRNO_H__
+#include <errno.h>
+
+enum sxe2_status {
+
+	SXE2_SUCCESS                = 0,
+
+	SXE2_ERR_PERM               = -EPERM,
+	SXE2_ERR_NOFILE             = -ENOENT,
+	SXE2_ERR_NOENT              = -ENOENT,
+	SXE2_ERR_SRCH               = -ESRCH,
+	SXE2_ERR_INTR               = -EINTR,
+	SXE2_ERR_IO                 = -EIO,
+	SXE2_ERR_NXIO               = -ENXIO,
+	SXE2_ERR_2BIG               = -E2BIG,
+	SXE2_ERR_NOEXEC             = -ENOEXEC,
+	SXE2_ERR_BADF               = -EBADF,
+	SXE2_ERR_CHILD              = -ECHILD,
+	SXE2_ERR_AGAIN              = -EAGAIN,
+	SXE2_ERR_NOMEM              = -ENOMEM,
+	SXE2_ERR_ACCES              = -EACCES,
+	SXE2_ERR_FAULT              = -EFAULT,
+	SXE2_ERR_BUSY               = -EBUSY,
+	SXE2_ERR_EXIST              = -EEXIST,
+	SXE2_ERR_XDEV               = -EXDEV,
+	SXE2_ERR_NODEV              = -ENODEV,
+	SXE2_ERR_NOTSUP             = -ENOTSUP,
+	SXE2_ERR_NOTDIR             = -ENOTDIR,
+	SXE2_ERR_ISDIR              = -EISDIR,
+	SXE2_ERR_INVAL              = -EINVAL,
+	SXE2_ERR_NFILE              = -ENFILE,
+	SXE2_ERR_MFILE              = -EMFILE,
+	SXE2_ERR_NOTTY              = -ENOTTY,
+	SXE2_ERR_FBIG               = -EFBIG,
+	SXE2_ERR_NOSPC              = -ENOSPC,
+	SXE2_ERR_SPIPE              = -ESPIPE,
+	SXE2_ERR_ROFS               = -EROFS,
+	SXE2_ERR_MLINK              = -EMLINK,
+	SXE2_ERR_PIPE               = -EPIPE,
+	SXE2_ERR_DOM                = -EDOM,
+	SXE2_ERR_RANGE              = -ERANGE,
+	SXE2_ERR_DEADLOCK           = -EDEADLK,
+	SXE2_ERR_DEADLK             = -EDEADLK,
+	SXE2_ERR_NAMETOOLONG        = -ENAMETOOLONG,
+	SXE2_ERR_NOLCK              = -ENOLCK,
+	SXE2_ERR_NOSYS              = -ENOSYS,
+	SXE2_ERR_NOTEMPTY           = -ENOTEMPTY,
+	SXE2_ERR_ILSEQ              = -EILSEQ,
+	SXE2_ERR_NODATA             = -ENODATA,
+	SXE2_ERR_CANCELED           = -ECANCELED,
+	SXE2_ERR_TIMEDOUT           = -ETIMEDOUT,
+
+	SXE2_ERROR                  = -150,
+	SXE2_ERR_NO_MEMORY          = -151,
+	SXE2_ERR_HW_VERSION         = -152,
+	SXE2_ERR_FW_VERSION         = -153,
+	SXE2_ERR_FW_MODE            = -154,
+
+	SXE2_ERR_CMD_ERROR          = -156,
+	SXE2_ERR_CMD_NO_MEMORY      = -157,
+	SXE2_ERR_CMD_NOT_READY      = -158,
+	SXE2_ERR_CMD_TIMEOUT        = -159,
+	SXE2_ERR_CMD_CANCELED       = -160,
+	SXE2_ERR_CMD_RETRY          = -161,
+	SXE2_ERR_CMD_HW_CRITICAL    = -162,
+	SXE2_ERR_CMD_NO_DATA        = -163,
+	SXE2_ERR_CMD_INVAL_SIZE     = -164,
+	SXE2_ERR_CMD_INVAL_TYPE     = -165,
+	SXE2_ERR_CMD_INVAL_LEN      = -165,
+	SXE2_ERR_CMD_INVAL_MAGIC    = -166,
+	SXE2_ERR_CMD_INVAL_HEAD     = -167,
+	SXE2_ERR_CMD_INVAL_ID       = -168,
+
+	SXE2_ERR_DESC_NO_DONE       = -171,
+
+	SXE2_ERR_INIT_ARGS_NAME_INVAL = -181,
+	SXE2_ERR_INIT_ARGS_VAL_INVAL  = -182,
+	SXE2_ERR_INIT_VSI_CRITICAL    = -183,
+
+	SXE2_ERR_CFG_FILE_PATH        = -191,
+	SXE2_ERR_CFG_FILE             = -192,
+	SXE2_ERR_CFG_INVALID_SIZE     = -193,
+	SXE2_ERR_CFG_NO_PIPELINE_CFG  = -194,
+
+	SXE2_ERR_RESET_TIMIEOUT       = -200,
+	SXE2_ERR_VF_NOT_ACTIVE        = -201,
+	SXE2_ERR_BUF_CSUM_ERR         = -202,
+	SXE2_ERR_VF_DROP              = -203,
+
+	SXE2_ERR_FLOW_PARAM           = -301,
+	SXE2_ERR_FLOW_CFG             = -302,
+	SXE2_ERR_FLOW_CFG_NOT_SUPPORT = -303,
+	SXE2_ERR_FLOW_PROF_EXISTS      = -304,
+	SXE2_ERR_FLOW_PROF_NOT_EXISTS = -305,
+	SXE2_ERR_FLOW_VSIG_FULL        = -306,
+	SXE2_ERR_FLOW_VSIG_INFO        = -307,
+	SXE2_ERR_FLOW_VSIG_NOT_FIND    = -308,
+	SXE2_ERR_FLOW_VSIG_NOT_USED    = -309,
+	SXE2_ERR_FLOW_VSI_NOT_IN_VSIG    = -310,
+	SXE2_ERR_FLOW_MAX_LIMIT        = -311,
+
+	SXE2_ERR_SCHED_NEED_RECURSION  = -400,
+
+	SXE2_ERR_BFD_SESS_FLOW_HT_COLLISION = -500,
+	SXE2_ERR_BFD_SESS_FLOW_NOSPC        = -501,
+};
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_host_regs.h b/drivers/common/sxe2/sxe2_host_regs.h
new file mode 100644
index 0000000000..984ea6214c
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_host_regs.h
@@ -0,0 +1,707 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_HOST_REGS_H__
+#define __SXE2_HOST_REGS_H__
+
+#define SXE2_BITS_MASK(m, s)		((m ## UL) << (s))
+
+#define SXE2_RXQ_CTXT(_i, _QRX)             (0x0050000 + ((_i) * 4 + (_QRX) * 0x20))
+#define SXE2_RXQ_HEAD(_QRX)                 (0x0060000 + ((_QRX) * 4))
+#define SXE2_RXQ_TAIL(_QRX)                 (0x0070000 + ((_QRX) * 4))
+#define SXE2_RXQ_CTRL(_QRX)                 (0x006d000 + ((_QRX) * 4))
+#define SXE2_RXQ_WB(_QRX)                   (0x006B000 + ((_QRX) * 4))
+
+#define SXE2_RXQ_CTRL_STATUS_ACTIVE       0x00000004
+#define SXE2_RXQ_CTRL_ENABLED             0x00000001
+#define SXE2_RXQ_CTRL_CDE_ENABLE		BIT(3)
+
+#define SXE2_PCIEPROC_BASE         0x002d6000
+
+#define SXE2_PF_INT_BASE         0x00260000
+#define SXE2_PF_INT_ALLOC        (SXE2_PF_INT_BASE + 0x0000)
+#define SXE2_PF_INT_ALLOC_FIRST  0x7FF
+#define SXE2_PF_INT_ALLOC_LAST_S 12
+#define SXE2_PF_INT_ALLOC_LAST \
+	(0x7FF << SXE2_PF_INT_ALLOC_LAST_S)
+#define SXE2_PF_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PF_INT_OICR                  (SXE2_PF_INT_BASE + 0x0040)
+#define SXE2_PF_INT_OICR_PCIE_TIMEOUT     BIT(0)
+#define SXE2_PF_INT_OICR_UR               BIT(1)
+#define SXE2_PF_INT_OICR_CA               BIT(2)
+#define SXE2_PF_INT_OICR_VFLR             BIT(3)
+#define SXE2_PF_INT_OICR_VFR_DONE         BIT(4)
+#define SXE2_PF_INT_OICR_LAN_TX_ERR       BIT(5)
+#define SXE2_PF_INT_OICR_BFDE             BIT(6)
+#define SXE2_PF_INT_OICR_LAN_RX_ERR       BIT(7)
+#define SXE2_PF_INT_OICR_ECC_ERR          BIT(8)
+#define SXE2_PF_INT_OICR_GPIO             BIT(9)
+#define SXE2_PF_INT_OICR_TSYN_TX          BIT(11)
+#define SXE2_PF_INT_OICR_TSYN_EVENT       BIT(12)
+#define SXE2_PF_INT_OICR_TSYN_TGT         BIT(13)
+#define SXE2_PF_INT_OICR_EXHAUST          BIT(14)
+#define SXE2_PF_INT_OICR_FW               BIT(15)
+#define SXE2_PF_INT_OICR_SWINT            BIT(16)
+#define SXE2_PF_INT_OICR_LINKSEC_CHG      BIT(17)
+#define SXE2_PF_INT_OICR_INT_CFG_ADDR_ERR BIT(18)
+#define SXE2_PF_INT_OICR_INT_CFG_DATA_ERR BIT(19)
+#define SXE2_PF_INT_OICR_INT_CFG_ADR_UNRANGE BIT(20)
+#define SXE2_PF_INT_OICR_INT_RAM_CONFLICT BIT(21)
+#define SXE2_PF_INT_OICR_GRST             BIT(22)
+#define SXE2_PF_INT_OICR_FWQ_INT          BIT(29)
+#define SXE2_PF_INT_OICR_FWQ_TOOL_INT     BIT(30)
+#define SXE2_PF_INT_OICR_MBXQ_INT         BIT(31)
+
+#define SXE2_PF_INT_OICR_ENABLE (SXE2_PF_INT_BASE + 0x0020)
+
+#define SXE2_PF_INT_FW_EVENT (SXE2_PF_INT_BASE + 0x0100)
+#define SXE2_PF_INT_FW_ABNORMAL BIT(0)
+#define SXE2_PF_INT_RDMA_AEQ_OVERFLOW BIT(1)
+#define SXE2_PF_INT_CGMAC_LINK_CHG BIT(18)
+#define SXE2_PF_INT_VFLR_DONE         BIT(2)
+
+#define SXE2_PF_INT_OICR_CTL           (SXE2_PF_INT_BASE + 0x0060)
+#define SXE2_PF_INT_OICR_CTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_OICR_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_OICR_CTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_OICR_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_OICR_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_FWQ_CTL           (SXE2_PF_INT_BASE + 0x00C0)
+#define SXE2_PF_INT_FWQ_CTL_MSIX_IDX  0x7FFF
+#define SXE2_PF_INT_FWQ_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_FWQ_CTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_FWQ_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_FWQ_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_MBX_CTL           (SXE2_PF_INT_BASE + 0x00A0)
+#define SXE2_PF_INT_MBX_CTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_MBX_CTL_ITR_IDX_S 11
+#define SXE2_PF_INT_MBX_CTL_ITR_IDX   (0x3 << SXE2_PF_INT_MBX_CTL_ITR_IDX_S)
+#define SXE2_PF_INT_MBX_CTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_GPIO_ENA      (SXE2_PF_INT_BASE + 0x0100)
+#define SXE2_PF_INT_GPIO_X_ENA(x) BIT(x)
+
+#define SXE2_PFG_INT_CTL               (SXE2_PF_INT_BASE + 0x0120)
+#define SXE2_PFG_INT_CTL_ITR_GRAN      0x7
+#define SXE2_PFG_INT_CTL_ITR_GRAN_0    (2)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN   BIT(4)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN_0 (4)
+#define SXE2_PFG_INT_CTL_CREDIT_GRAN_1 (8)
+
+#define SXE2_VFG_RAM_INIT_DONE \
+	(SXE2_PF_INT_BASE + 0x0128)
+#define SXE2_VFG_RAM_INIT_DONE_0 BIT(0)
+#define SXE2_VFG_RAM_INIT_DONE_1 BIT(1)
+#define SXE2_VFG_RAM_INIT_DONE_2 BIT(2)
+
+#define SXE2_LINK_REG_GET_10G_VALUE   4
+#define SXE2_LINK_REG_GET_25G_VALUE   1
+#define SXE2_LINK_REG_GET_50G_VALUE   2
+#define SXE2_LINK_REG_GET_100G_VALUE  3
+
+#define SXE2_PORT0_CNT 0
+#define SXE2_PORT1_CNT 1
+#define SXE2_PORT2_CNT 2
+#define SXE2_PORT3_CNT 3
+
+#define SXE2_LINK_STATUS_BASE		(0x002ac200)
+#define SXE2_LINK_STATUS_PORT0_POS		3
+#define SXE2_LINK_STATUS_PORT1_POS		11
+#define SXE2_LINK_STATUS_PORT2_POS		19
+#define SXE2_LINK_STATUS_PORT3_POS		27
+#define SXE2_LINK_STATUS_MASK			1
+
+#define SXE2_LINK_SPEED_BASE		(0x002ac200)
+#define SXE2_LINK_SPEED_PORT0_POS		0
+#define SXE2_LINK_SPEED_PORT1_POS		8
+#define SXE2_LINK_SPEED_PORT2_POS		16
+#define SXE2_LINK_SPEED_PORT3_POS		24
+#define SXE2_LINK_SPEED_MASK			7
+
+#define SXE2_PFVP_INT_ALLOC(vf_idx)        (SXE2_PF_INT_BASE + 0x012C + ((vf_idx) * 4))
+#define SXE2_PFVP_INT_ALLOC_FIRST_S  0
+
+#define SXE2_PFVP_INT_ALLOC_FIRST_M  (0x7FF << SXE2_PFVP_INT_ALLOC_FIRST_S)
+#define SXE2_PFVP_INT_ALLOC_LAST_S 12
+#define SXE2_PFVP_INT_ALLOC_LAST_M \
+	(0x7FF << SXE2_PFVP_INT_ALLOC_LAST_S)
+#define SXE2_PFVP_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PCI_PFVP_INT_ALLOC(vf_idx)  (SXE2_PCIEPROC_BASE + 0x5800 + ((vf_idx) * 4))
+#define SXE2_PCI_PFVP_INT_ALLOC_FIRST_S  0
+
+#define SXE2_PCI_PFVP_INT_ALLOC_FIRST_M  (0x7FF << SXE2_PCI_PFVP_INT_ALLOC_FIRST_S)
+#define SXE2_PCI_PFVP_INT_ALLOC_LAST_S 12
+
+#define SXE2_PCI_PFVP_INT_ALLOC_LAST_M \
+		(0x7FF << SXE2_PCI_PFVP_INT_ALLOC_LAST_S)
+#define SXE2_PCI_PFVP_INT_ALLOC_VALID BIT(31)
+
+#define SXE2_PCIEPROC_INT2FUNC(_INT)		   (SXE2_PCIEPROC_BASE + 0xe000 + ((_INT) * 4))
+#define SXE2_PCIEPROC_INT2FUNC_VF_NUM_S		0
+#define SXE2_PCIEPROC_INT2FUNC_VF_NUM_M		(0xFF << SXE2_PCIEPROC_INT2FUNC_VF_NUM_S)
+#define SXE2_PCIEPROC_INT2FUNC_PF_NUM_S		12
+#define SXE2_PCIEPROC_INT2FUNC_PF_NUM_M		(0x7 << SXE2_PCIEPROC_INT2FUNC_PF_NUM_S)
+#define SXE2_PCIEPROC_INT2FUNC_IS_PF_S       16
+#define SXE2_PCIEPROC_INT2FUNC_IS_PF_M       BIT(16)
+
+#define SXE2_VSI_PF(vf_idx)                (SXE2_PF_INT_BASE + 0x14000 + ((vf_idx) * 4))
+#define SXE2_VSI_PF_ID_S		   0
+#define SXE2_VSI_PF_ID_M		  (0x7 << SXE2_VSI_PF_ID_S)
+#define SXE2_VSI_PF_EN_M		  BIT(3)
+
+#define SXE2_MBX_CTL(_VSI)			(0x0026692C + ((_VSI) * 4))
+#define SXE2_MBX_CTL_MSIX_INDX_S		0
+#define SXE2_MBX_CTL_MSIX_INDX_M		(0x7FF << SXE2_MBX_CTL_MSIX_INDX_S)
+#define SXE2_MBX_CTL_CAUSE_ENA_M		BIT(30)
+
+#define SXE2_PF_INT_TQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x092C + 4 * (q_idx))
+#define SXE2_PF_INT_TQCTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_TQCTL_ITR_IDX_S 11
+#define SXE2_PF_INT_TQCTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_TQCTL_ITR_IDX_S)
+#define SXE2_PF_INT_TQCTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_RQCTL(q_idx)    (SXE2_PF_INT_BASE + 0x292C + 4 * (q_idx))
+#define SXE2_PF_INT_RQCTL_MSIX_IDX  0x7FF
+#define SXE2_PF_INT_RQCTL_ITR_IDX_S 11
+#define SXE2_PF_INT_RQCTL_ITR_IDX \
+	(0x3 << SXE2_PF_INT_RQCTL_ITR_IDX_S)
+#define SXE2_PF_INT_RQCTL_CAUSE_ENABLE BIT(30)
+
+#define SXE2_PF_INT_RATE(irq_idx)        (SXE2_PF_INT_BASE + 0x7530 + 4 * (irq_idx))
+#define SXE2_PF_INT_RATE_CREDIT_INTERVAL (0x3F)
+#define SXE2_PF_INT_RATE_CREDIT_INTERVAL_MAX \
+	(0x3F)
+#define SXE2_PF_INT_RATE_INTRL_ENABLE           (BIT(6))
+#define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT (7)
+#define SXE2_PF_INT_RATE_CREDIT_MAX_VALUE \
+	(0x3F << SXE2_PF_INT_RATE_CREDIT_MAX_VALUE_SHIFT)
+
+#define SXE2_VF_INT_ITR(itr_idx, irq_idx) \
+	(SXE2_PF_INT_BASE + 0xB530 + 0x2000 * (itr_idx) + 4 * (irq_idx))
+#define SXE2_VF_INT_ITR_INTERVAL 0xFFF
+
+#define SXE2_VF_DYN_CTL(irq_idx)   (SXE2_PF_INT_BASE + 0x9530 + 4 * (irq_idx))
+#define SXE2_VF_DYN_CTL_INTENABLE     BIT(0)
+#define SXE2_VF_DYN_CTL_CLEARPBA   BIT(1)
+#define SXE2_VF_DYN_CTL_SWINT_TRIG BIT(2)
+#define SXE2_VF_DYN_CTL_ITR_IDX_S \
+	3
+#define SXE2_VF_DYN_CTL_ITR_IDX_M      0x3
+#define SXE2_VF_DYN_CTL_INTERVAL_S     5
+#define SXE2_VF_DYN_CTL_INTERVAL_M     0xFFF
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_ENABLE BIT(24)
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_S   25
+#define SXE2_VF_DYN_CTL_SW_ITR_IDX_M   0x3
+
+#define SXE2_VF_DYN_CTL_INTENABLE_MSK \
+	BIT(31)
+
+#define SXE2_BAR4_MSIX_BASE 0
+#define SXE2_BAR4_MSIX_CTL(_idx) (SXE2_BAR4_MSIX_BASE + 0xC + ((_idx) * 0x10))
+#define SXE2_BAR4_MSIX_ENABLE 0
+#define SXE2_BAR4_MSIX_DISABLE 1
+
+#define SXE2_TXQ_LEGACY_DBLL(_DBQM)	(0x1000 + ((_DBQM) * 4))
+
+#define SXE2_TXQ_CONTEXT0(_pfIdx)	(0x10040 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT1(_pfIdx)	(0x10044 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT2(_pfIdx)	(0x10048 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT3(_pfIdx)	(0x1004C + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT4(_pfIdx)	(0x10050 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT7(_pfIdx)	(0x1005C + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CONTEXT7_HEAD_S      0
+#define SXE2_TXQ_CONTEXT7_HEAD_M      SXE2_BITS_MASK(0xFFF, SXE2_TXQ_CONTEXT7_HEAD_S)
+#define SXE2_TXQ_CONTEXT7_READ_HEAD_S 16
+#define SXE2_TXQ_CONTEXT7_READ_HEAD_M SXE2_BITS_MASK(0xFFF, SXE2_TXQ_CONTEXT7_READ_HEAD_S)
+
+#define SXE2_TXQ_CTRL(_pfIdx)          (0x10064 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_CTXT_CTRL(_pfIdx)     (0x100C8 + ((_pfIdx) * 0x100))
+#define SXE2_TXQ_DIS_CNT(_pfIdx)       (0x100D0 + ((_pfIdx) * 0x100))
+
+#define SXE2_TXQ_CTXT_CTRL_USED_MASK   0x00000800
+#define SXE2_TXQ_CTRL_SW_EN_M		BIT(0)
+#define SXE2_TXQ_CTRL_HW_EN_M		BIT(1)
+
+#define	SXE2_TXQ_CTXT2_PROT_IDX_S	0
+#define	SXE2_TXQ_CTXT2_PROT_IDX_M	SXE2_BITS_MASK(0x7, 0)
+#define	SXE2_TXQ_CTXT2_CGD_IDX_S	4
+#define	SXE2_TXQ_CTXT2_CGD_IDX_M	SXE2_BITS_MASK(0x1F, 4)
+#define	SXE2_TXQ_CTXT2_PF_IDX_S	9
+#define	SXE2_TXQ_CTXT2_PF_IDX_M	SXE2_BITS_MASK(0x7, 9)
+#define	SXE2_TXQ_CTXT2_VMVF_IDX_S	12
+#define	SXE2_TXQ_CTXT2_VMVF_IDX_M	SXE2_BITS_MASK(0x3FF, 12)
+#define	SXE2_TXQ_CTXT2_VMVF_TYPE_S	23
+#define	SXE2_TXQ_CTXT2_VMVF_TYPE_M	SXE2_BITS_MASK(0x3, 23)
+#define	SXE2_TXQ_CTXT2_TSYN_ENA_S	25
+#define	SXE2_TXQ_CTXT2_TSYN_ENA_M	BIT(25)
+#define	SXE2_TXQ_CTXT2_ALT_VLAN_S	26
+#define	SXE2_TXQ_CTXT2_ALT_VLAN_M	BIT(26)
+#define	SXE2_TXQ_CTXT2_WB_MODE_S	27
+#define	SXE2_TXQ_CTXT2_WB_MODE_M	BIT(27)
+#define	SXE2_TXQ_CTXT2_ITR_WB_S	28
+#define	SXE2_TXQ_CTXT2_ITR_WB_M	BIT(28)
+#define	SXE2_TXQ_CTXT2_LEGACY_EN_S	29
+#define	SXE2_TXQ_CTXT2_LEGACY_EN_M	BIT(29)
+#define	SXE2_TXQ_CTXT2_SSO_EN_S	30
+#define	SXE2_TXQ_CTXT2_SSO_EN_M	BIT(30)
+
+#define	SXE2_TXQ_CTXT3_SRC_VSI_S	0
+#define	SXE2_TXQ_CTXT3_SRC_VSI_M	SXE2_BITS_MASK(0x3FF, 0)
+#define	SXE2_TXQ_CTXT3_CPU_ID_S	12
+#define	SXE2_TXQ_CTXT3_CPU_ID_M	SXE2_BITS_MASK(0xFF, 12)
+#define	SXE2_TXQ_CTXT3_TPH_RDDESC_S	20
+#define	SXE2_TXQ_CTXT3_TPH_RDDESC_M	BIT(20)
+#define	SXE2_TXQ_CTXT3_TPH_RDDATA_S	21
+#define	SXE2_TXQ_CTXT3_TPH_RDDATA_M	BIT(21)
+#define	SXE2_TXQ_CTXT3_TPH_WRDESC_S	22
+#define	SXE2_TXQ_CTXT3_TPH_WRDESC_M	BIT(22)
+
+#define	SXE2_TXQ_CTXT3_QID_IN_FUNC_S	0
+#define	SXE2_TXQ_CTXT3_QID_IN_FUNC_M	SXE2_BITS_MASK(0x7FF, 0)
+#define	SXE2_TXQ_CTXT3_RDDESC_RO_S	13
+#define	SXE2_TXQ_CTXT3_RDDESC_RO_M	BIT(13)
+#define	SXE2_TXQ_CTXT3_WRDESC_RO_S	14
+#define	SXE2_TXQ_CTXT3_WRDESC_RO_M	BIT(14)
+#define	SXE2_TXQ_CTXT3_RDDATA_RO_S	15
+#define	SXE2_TXQ_CTXT3_RDDATA_RO_M	BIT(15)
+#define	SXE2_TXQ_CTXT3_QLEN_S		16
+#define	SXE2_TXQ_CTXT3_QLEN_M		SXE2_BITS_MASK(0x1FFF, 16)
+
+#define SXE2_RX_BUF_CHAINED_MAX        10
+#define SXE2_RX_DESC_BASE_ADDR_UNIT    7
+#define SXE2_RX_HBUF_LEN_UNIT          6
+#define SXE2_RX_DBUF_LEN_UNIT          7
+#define SXE2_RX_DBUF_LEN_MASK          (~0x7F)
+#define SXE2_RX_HWTAIL_VALUE_MASK      (~0x7)
+
+enum {
+	SXE2_RX_CTXT0 = 0,
+	SXE2_RX_CTXT1,
+	SXE2_RX_CTXT2,
+	SXE2_RX_CTXT3,
+	SXE2_RX_CTXT4,
+	SXE2_RX_CTXT_CNT,
+};
+
+#define SXE2_RX_CTXT_BASE_L_S                 0
+#define SXE2_RX_CTXT_BASE_L_W                 32
+
+#define SXE2_RX_CTXT_BASE_H_S                 0
+#define SXE2_RX_CTXT_BASE_H_W                 25
+#define SXE2_RX_CTXT_DEPTH_L_S                25
+#define SXE2_RX_CTXT_DEPTH_L_W		       7
+
+#define SXE2_RX_CTXT_DEPTH_H_S                0
+#define SXE2_RX_CTXT_DEPTH_H_W		       6
+
+#define SXE2_RX_CTXT_DBUFF_S                  6
+#define SXE2_RX_CTXT_DBUFF_W                  7
+
+#define SXE2_RX_CTXT_HBUFF_S                  13
+#define SXE2_RX_CTXT_HBUFF_W                  5
+
+#define SXE2_RX_CTXT_HSPLT_TYPE_S             18
+#define SXE2_RX_CTXT_HSPLT_TYPE_W             2
+
+#define SXE2_RX_CTXT_DESC_TYPE_S              20
+#define SXE2_RX_CTXT_DESC_TYPE_W              1
+
+#define SXE2_RX_CTXT_CRC_S                    21
+#define SXE2_RX_CTXT_CRC_W                    1
+
+#define SXE2_RX_CTXT_L2TAG_FLAG_S             23
+#define SXE2_RX_CTXT_L2TAG_FLAG_W             1
+
+#define SXE2_RX_CTXT_HSPLT_0_S                24
+#define SXE2_RX_CTXT_HSPLT_0_W                4
+
+#define SXE2_RX_CTXT_HSPLT_1_S                28
+#define SXE2_RX_CTXT_HSPLT_1_W                2
+
+#define SXE2_RX_CTXT_INVALN_STP_S             31
+#define SXE2_RX_CTXT_INVALN_STP_W             1
+
+#define SXE2_RX_CTXT_LRO_ENABLE_S             0
+#define SXE2_RX_CTXT_LRO_ENABLE_W             1
+
+#define SXE2_RX_CTXT_CPUID_S                  3
+#define SXE2_RX_CTXT_CPUID_W                  8
+
+#define SXE2_RX_CTXT_MAX_FRAME_SIZE_S         11
+#define SXE2_RX_CTXT_MAX_FRAME_SIZE_W         14
+
+#define SXE2_RX_CTXT_LRO_DESC_MAX_S           25
+#define SXE2_RX_CTXT_LRO_DESC_MAX_W           4
+
+#define SXE2_RX_CTXT_RELAX_DATA_S             29
+#define SXE2_RX_CTXT_RELAX_DATA_W             1
+
+#define SXE2_RX_CTXT_RELAX_WB_S               30
+#define SXE2_RX_CTXT_RELAX_WB_W               1
+
+#define SXE2_RX_CTXT_RELAX_RD_S               31
+#define SXE2_RX_CTXT_RELAX_RD_W               1
+
+#define SXE2_RX_CTXT_THPRDESC_ENABLE_S        1
+#define SXE2_RX_CTXT_THPRDESC_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPWDESC_ENABLE_S        2
+#define SXE2_RX_CTXT_THPWDESC_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPRDATA_ENABLE_S        3
+#define SXE2_RX_CTXT_THPRDATA_ENABLE_W        1
+
+#define SXE2_RX_CTXT_THPHEAD_ENABLE_S         4
+#define SXE2_RX_CTXT_THPHEAD_ENABLE_W         1
+
+#define SXE2_RX_CTXT_LOW_DESC_LINE_S          6
+#define SXE2_RX_CTXT_LOW_DESC_LINE_W          3
+
+#define SXE2_RX_CTXT_VF_ID_S                  9
+#define SXE2_RX_CTXT_VF_ID_W                  8
+
+#define SXE2_RX_CTXT_PF_ID_S                  17
+#define SXE2_RX_CTXT_PF_ID_W                  3
+
+#define SXE2_RX_CTXT_VF_ENABLE_S              20
+#define SXE2_RX_CTXT_VF_ENABLE_W              1
+
+#define SXE2_RX_CTXT_VSI_ID_S                 21
+#define SXE2_RX_CTXT_VSI_ID_W                 10
+
+#define SXE2_PF_CTRLQ_FW_BASE      0x00312000
+#define SXE2_PF_CTRLQ_FW_ATQBAL (SXE2_PF_CTRLQ_FW_BASE + 0x0000)
+#define SXE2_PF_CTRLQ_FW_ARQBAL (SXE2_PF_CTRLQ_FW_BASE + 0x0080)
+#define SXE2_PF_CTRLQ_FW_ATQBAH (SXE2_PF_CTRLQ_FW_BASE + 0x0100)
+#define SXE2_PF_CTRLQ_FW_ARQBAH (SXE2_PF_CTRLQ_FW_BASE + 0x0180)
+#define SXE2_PF_CTRLQ_FW_ATQLEN (SXE2_PF_CTRLQ_FW_BASE + 0x0200)
+#define SXE2_PF_CTRLQ_FW_ARQLEN (SXE2_PF_CTRLQ_FW_BASE + 0x0280)
+#define SXE2_PF_CTRLQ_FW_ATQH   (SXE2_PF_CTRLQ_FW_BASE + 0x0300)
+#define SXE2_PF_CTRLQ_FW_ARQH   (SXE2_PF_CTRLQ_FW_BASE + 0x0380)
+#define SXE2_PF_CTRLQ_FW_ATQT   (SXE2_PF_CTRLQ_FW_BASE + 0x0400)
+#define SXE2_PF_CTRLQ_FW_ARQT   (SXE2_PF_CTRLQ_FW_BASE + 0x0480)
+
+#define SXE2_PF_CTRLQ_MBX_BASE      0x00316000
+#define SXE2_PF_CTRLQ_MBX_ATQBAL (SXE2_PF_CTRLQ_MBX_BASE + 0xE100)
+#define SXE2_PF_CTRLQ_MBX_ATQBAH (SXE2_PF_CTRLQ_MBX_BASE + 0xE180)
+#define SXE2_PF_CTRLQ_MBX_ATQLEN (SXE2_PF_CTRLQ_MBX_BASE + 0xE200)
+#define SXE2_PF_CTRLQ_MBX_ATQH   (SXE2_PF_CTRLQ_MBX_BASE + 0xE280)
+#define SXE2_PF_CTRLQ_MBX_ATQT   (SXE2_PF_CTRLQ_MBX_BASE + 0xE300)
+#define SXE2_PF_CTRLQ_MBX_ARQBAL (SXE2_PF_CTRLQ_MBX_BASE + 0xE380)
+#define SXE2_PF_CTRLQ_MBX_ARQBAH (SXE2_PF_CTRLQ_MBX_BASE + 0xE400)
+#define SXE2_PF_CTRLQ_MBX_ARQLEN (SXE2_PF_CTRLQ_MBX_BASE + 0xE480)
+#define SXE2_PF_CTRLQ_MBX_ARQH   (SXE2_PF_CTRLQ_MBX_BASE + 0xE500)
+#define SXE2_PF_CTRLQ_MBX_ARQT   (SXE2_PF_CTRLQ_MBX_BASE + 0xE580)
+
+#define SXE2_CMD_REG_LEN_M      0x3FF
+#define SXE2_CMD_REG_LEN_VFE_M  BIT(28)
+#define SXE2_CMD_REG_LEN_OVFL_M BIT(29)
+#define SXE2_CMD_REG_LEN_CRIT_M BIT(30)
+#define SXE2_CMD_REG_LEN_ENABLE_M  BIT(31)
+
+#define SXE2_CMD_REG_HEAD_M     0x3FF
+
+#define SXE2_PF_CTRLQ_FW_HW_STS (SXE2_PF_CTRLQ_FW_BASE + 0x0500)
+#define SXE2_PF_CTRLQ_FW_ATQ_IDLE_MASK BIT(0)
+#define SXE2_PF_CTRLQ_FW_ARQ_IDLE_MASK BIT(1)
+
+#define SXE2_TOP_CFG_BASE      0x00292000
+#define SXE2_HW_VER (SXE2_TOP_CFG_BASE + 0x48c)
+#define	SXE2_HW_FPGA_VER_M	SXE2_BITS_MASK(0xFFF, 0)
+
+#define SXE2_FW_VER (SXE2_TOP_CFG_BASE + 0x214)
+#define	SXE2_FW_VER_BUILD_M	SXE2_BITS_MASK(0xFF, 0)
+#define	SXE2_FW_VER_FIX_M	SXE2_BITS_MASK(0xFF, 8)
+#define	SXE2_FW_VER_SUB_M	SXE2_BITS_MASK(0xFF, 16)
+#define	SXE2_FW_VER_MAIN_M	SXE2_BITS_MASK(0xFF, 24)
+#define	SXE2_FW_VER_FIX_SHIFT	(8)
+#define	SXE2_FW_VER_SUB_SHIFT	(16)
+#define	SXE2_FW_VER_MAIN_SHIFT	(24)
+
+#define SXE2_FW_COMP_VER_ADDR (SXE2_TOP_CFG_BASE + 0x20c)
+
+#define SXE2_STATUS SXE2_FW_VER
+
+#define SXE2_FW_STATE     (SXE2_TOP_CFG_BASE + 0x210)
+
+#define SXE2_FW_HEARTBEAT (SXE2_TOP_CFG_BASE + 0x218)
+
+#define SXE2_FW_MISC (SXE2_TOP_CFG_BASE + 0x21c)
+#define	SXE2_FW_MISC_MODE_M	SXE2_BITS_MASK(0xF, 0)
+#define	SXE2_FW_MISC_POP_M	SXE2_BITS_MASK(0x80000000, 0)
+
+#define SXE2_TX_OE_BASE		0x00030000
+#define SXE2_RX_OE_BASE		0x00050000
+
+#define SXE2_PFP_L2TAGSEN(_i)	(SXE2_TX_OE_BASE + 0x00300 + ((_i) * 4))
+#define SXE2_VSI_L2TAGSTXVALID(_i)	\
+	(SXE2_TX_OE_BASE + 0x01000 + ((_i) * 4))
+#define SXE2_VSI_TIR0(_i)		(SXE2_TX_OE_BASE + 0x01C00 + ((_i) * 4))
+#define SXE2_VSI_TIR1(_i)		(SXE2_TX_OE_BASE + 0x02800 + ((_i) * 4))
+#define SXE2_VSI_TAR(_i)		(SXE2_TX_OE_BASE + 0x04C00 + ((_i) * 4))
+#define SXE2_VSI_TSR(_i)		(SXE2_RX_OE_BASE + 0x18000 + ((_i) * 4))
+
+#define SXE2_STATS_TX_LAN_CONFIG(_i)			(SXE2_TX_OE_BASE + 0x08300 + ((_i) * 4))
+#define SXE2_STATS_TX_LAN_PKT_CNT_GET(_i)		(SXE2_TX_OE_BASE + 0x08340 + ((_i) * 4))
+#define SXE2_STATS_TX_LAN_BYTE_CNT_GET(_i)		(SXE2_TX_OE_BASE + 0x08380 + ((_i) * 4))
+
+#define SXE2_STATS_RX_CONFIG(_i)	(SXE2_RX_OE_BASE + 0x230B0 + ((_i) * 4))
+#define SXE2_STATS_RX_LAN_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x230C0 + ((_i) * 8))
+#define SXE2_STATS_RX_LAN_BYTE_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23120 + ((_i) * 8))
+#define SXE2_STATS_RX_FD_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x230E0 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_IN_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23100 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_IN_BYTE_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23140 + ((_i) * 8))
+#define SXE2_STATS_RX_MNG_OUT_PKT_CNT_GET(_i)	(SXE2_RX_OE_BASE + 0x23160 + ((_i) * 8))
+
+#define SXE2_L2TAG_ID_STAG		0
+#define SXE2_L2TAG_ID_OUT_VLAN1	1
+#define SXE2_L2TAG_ID_OUT_VLAN2	2
+#define SXE2_L2TAG_ID_VLAN		3
+
+#define SXE2_PFP_L2TAGSEN_ALL_TAG	0xFF
+#define SXE2_PFP_L2TAGSEN_DVM		BIT(10)
+
+#define SXE2_VSI_TSR_STRIP_TAG_S	0
+#define SXE2_VSI_TSR_SHOW_TAG_S	4
+
+#define SXE2_VSI_TSR_ID_STAG		BIT(0)
+#define SXE2_VSI_TSR_ID_OUT_VLAN1	BIT(1)
+#define SXE2_VSI_TSR_ID_OUT_VLAN2	BIT(2)
+#define SXE2_VSI_TSR_ID_VLAN		BIT(3)
+
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_S	0
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_ID_M	0x7
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG1_VALID	BIT(3)
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_S	4
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_ID_M	0x7
+#define SXE2_VSI_L2TAGSTXVALID_L2TAG2_VALID	BIT(7)
+#define SXE2_VSI_L2TAGSTXVALID_TIR0_ID_S	16
+#define SXE2_VSI_L2TAGSTXVALID_TIR0_VALID	BIT(19)
+#define SXE2_VSI_L2TAGSTXVALID_TIR1_ID_S	20
+#define SXE2_VSI_L2TAGSTXVALID_TIR1_VALID	BIT(23)
+
+#define SXE2_VSI_L2TAGSTXVALID_ID_STAG		0
+#define SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN1	2
+#define SXE2_VSI_L2TAGSTXVALID_ID_OUT_VLAN2	3
+#define SXE2_VSI_L2TAGSTXVALID_ID_VLAN		4
+
+#define SXE2_SWITCH_OG_BASE		0x00140000
+#define SXE2_SWITCH_SWE_BASE		0x00150000
+#define SXE2_SWITCH_RG_BASE		0x00160000
+
+#define SXE2_VSI_RX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01074 + ((_i) * 4))
+#define SXE2_VSI_TX_SWITCH_CTRL(_i)	(SXE2_SWITCH_RG_BASE + 0x01C74 + ((_i) * 4))
+
+#define SXE2_VSI_RX_SW_CTRL_VLAN_PRUNE	BIT(9)
+
+#define SXE2_VSI_TX_SW_CTRL_LOOPBACK_EN	BIT(1)
+#define SXE2_VSI_TX_SW_CTRL_LAN_EN		BIT(2)
+#define SXE2_VSI_TX_SW_CTRL_MACAS_EN		BIT(3)
+#define SXE2_VSI_TX_SW_CTRL_VLAN_PRUNE		BIT(9)
+
+#define SXE2_VSI_TAR_UNTAGGED_SHIFT		(16)
+
+#define SXE2_PCIE_SYS_READY                    0x38c
+#define SXE2_PCIE_SYS_READY_CORER_ASSERT       BIT(0)
+#define SXE2_PCIE_SYS_READY_STOP_DROP_DONE     BIT(2)
+#define SXE2_PCIE_SYS_READY_R5                 BIT(3)
+#define SXE2_PCIE_SYS_READY_STOP_DROP          BIT(16)
+
+#define SXE2_PCIE_DEV_CTRL_DEV_STATUS               0x78
+#define SXE2_PCIE_DEV_CTRL_DEV_STATUS_TRANS_PENDING BIT(21)
+
+#define SXE2_TOP_CFG_CORE            (SXE2_TOP_CFG_BASE + 0x0630)
+#define SXE2_TOP_CFG_CORE_RST_CODE   0x09FBD586
+
+#define SXE2_PFGEN_CTRL       (0x00336000)
+#define SXE2_PFGEN_CTRL_PFSWR BIT(0)
+
+#define SXE2_VFGEN_CTRL(_vf)       (0x00337000 + ((_vf) * 4))
+#define SXE2_VFGEN_CTRL_VFSWR      BIT(0)
+
+#define SXE2_VF_VRC_VFGEN_RSTAT(_vf)        (0x00338000 + (_vf)*4)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT           (0x3)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_VFR       (0)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_COMPLETE  (BIT(0))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_VF_ACTIVE (BIT(1))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_MASK (BIT(2))
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF (0x300)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_NO_VFR (0)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_VFR (1)
+#define SXE2_VF_VRC_VFGEN_VFRSTAT_FORVF_MASK (BIT(10))
+
+#define SXE2_GLGEN_VFLRSTAT(_reg) (0x0033A000 + ((_reg)*4))
+
+#define SXE2_ACCEPT_RULE_TAGGED_S      0
+#define SXE2_ACCEPT_RULE_UNTAGGED_S    16
+
+#define SXE2_VF_RXQ_BASE(_VF)			(0x000b0800 + ((_VF) * 4))
+#define SXE2_VF_RXQ_BASE_FIRST_Q_S		0
+#define SXE2_VF_RXQ_BASE_FIRST_Q_M		(0x7FF << SXE2_VF_RXQ_BASE_FIRST_Q_S)
+#define SXE2_VF_RXQ_BASE_Q_NUM_S		16
+#define SXE2_VF_RXQ_BASE_Q_NUM_M		(0x7FF << SXE2_VF_RXQ_BASE_Q_NUM_S)
+
+#define SXE2_VF_RXQ_MAPENA(_VF)		(0x000b0400 + ((_VF) * 4))
+#define SXE2_VF_RXQ_MAPENA_M		        BIT(0)
+
+#define SXE2_VF_TXQ_BASE(_VF)			(0x00040400 + ((_VF) * 4))
+#define SXE2_VF_TXQ_BASE_FIRST_Q_S		0
+#define SXE2_VF_TXQ_BASE_FIRST_Q_M		(0x3FFF << SXE2_VF_TXQ_BASE_FIRST_Q_S)
+#define SXE2_VF_TXQ_BASE_Q_NUM_S		16
+#define SXE2_VF_TXQ_BASE_Q_NUM_M		(0xFF << SXE2_VF_TXQ_BASE_Q_NUM_S)
+
+#define SXE2_VF_TXQ_MAPENA(_VF)		(0x00045000 + ((_VF) * 4))
+#define SXE2_VF_TXQ_MAPENA_M		        BIT(0)
+
+#define PRI_PTP_BASEADDR 0x2a8000
+
+#define GLTSYN (PRI_PTP_BASEADDR + 0x0)
+#define GLTSYN_ENA_M BIT(0)
+
+#define GLTSYN_CMD (PRI_PTP_BASEADDR + 0x4)
+#define GLTSYN_CMD_INIT_TIME 0x01
+#define GLTSYN_CMD_INIT_INCVAL 0x02
+#define GLTSYN_CMD_ADJ_TIME 0x04
+#define GLTSYN_CMD_ADJ_TIME_AT_TIME 0x0C
+#define GLTSYN_CMD_LATCHING_SHTIME 0x80
+
+#define GLTSYN_SYNC (PRI_PTP_BASEADDR + 0x8)
+#define GLTSYN_SYNC_PLUS_1NS 0x1
+#define GLTSYN_SYNC_MINUS_1NS 0x2
+#define GLTSYN_SYNC_EXEC 0x3
+#define GLTSYN_SYNC_GEN_PULSE 0x4
+
+#define GLTSYN_SEM (PRI_PTP_BASEADDR + 0xC)
+#define GLTSYN_SEM_BUSY_M BIT(0)
+
+#define GLTSYN_STAT (PRI_PTP_BASEADDR + 0x10)
+#define GLTSYN_STAT_EVENT0_M			BIT(0)
+#define GLTSYN_STAT_EVENT1_M			BIT(1)
+#define GLTSYN_STAT_EVENT2_M			BIT(2)
+
+#define GLTSYN_TIME_SUBNS (PRI_PTP_BASEADDR + 0x20)
+#define GLTSYN_TIME_NS (PRI_PTP_BASEADDR + 0x24)
+#define GLTSYN_TIME_S_H (PRI_PTP_BASEADDR + 0x28)
+#define GLTSYN_TIME_S_L (PRI_PTP_BASEADDR + 0x2C)
+
+#define GLTSYN_SHTIME_SUBNS (PRI_PTP_BASEADDR + 0x30)
+#define GLTSYN_SHTIME_NS (PRI_PTP_BASEADDR + 0x34)
+#define GLTSYN_SHTIME_S_H (PRI_PTP_BASEADDR + 0x38)
+#define GLTSYN_SHTIME_S_L (PRI_PTP_BASEADDR + 0x3C)
+
+#define GLTSYN_SHADJ_SUBNS (PRI_PTP_BASEADDR + 0x40)
+#define GLTSYN_SHADJ_NS (PRI_PTP_BASEADDR + 0x44)
+
+#define GLTSYN_INCVAL_NS (PRI_PTP_BASEADDR + 0x50)
+#define GLTSYN_INCVAL_SUBNS (PRI_PTP_BASEADDR + 0x54)
+
+#define GLTSYN_TGT_NS(_i) \
+	(PRI_PTP_BASEADDR + 0x60 + ((_i) * 16))
+#define GLTSYN_TGT_S_H(_i) (PRI_PTP_BASEADDR + 0x64 + ((_i) * 16))
+#define GLTSYN_TGT_S_L(_i) (PRI_PTP_BASEADDR + 0x68 + ((_i) * 16))
+
+#define GLTSYN_EVENT_NS(_i) \
+	(PRI_PTP_BASEADDR + 0xA0 + ((_i) * 16))
+
+#define GLTSYN_EVENT_S_H(_i) (PRI_PTP_BASEADDR + 0xA4 + ((_i) * 16))
+#define GLTSYN_EVENT_S_H_MASK (0xFFFF)
+
+#define GLTSYN_EVENT_S_L(_i) (PRI_PTP_BASEADDR + 0xA8 + ((_i) * 16))
+
+#define GLTSYN_AUXOUT(_i) \
+	(PRI_PTP_BASEADDR + 0xD0 + ((_i) * 4))
+#define GLTSYN_AUXOUT_OUT_ENA BIT(0)
+#define GLTSYN_AUXOUT_OUT_MOD (0x03 << 1)
+#define GLTSYN_AUXOUT_OUTLVL BIT(3)
+#define GLTSYN_AUXOUT_INT_ENA BIT(4)
+#define GLTSYN_AUXOUT_PULSEW (0x1fff << 3)
+
+#define GLTSYN_CLKO(_i) \
+	(PRI_PTP_BASEADDR + 0xE0 + ((_i) * 4))
+
+#define GLTSYN_AUXIN(_i) (PRI_PTP_BASEADDR + 0xF4 + ((_i) * 4))
+#define GLTSYN_AUXIN_RISING_EDGE BIT(0)
+#define GLTSYN_AUXIN_FALLING_EDGE BIT(1)
+#define GLTSYN_AUXIN_ENABLE BIT(4)
+
+#define CGMAC_CSR_BASE 0x2B4000
+
+#define CGMAC_PORT_OFFSET         0x00004000
+
+#define PFP_CGM_TX_TSMEM(_port, _i)        \
+	(CGMAC_CSR_BASE + 0x100 + \
+	 + CGMAC_PORT_OFFSET * _port + ((_i) * 4))
+
+#define PFP_CGM_TX_TXHI(_port, _i) (CGMAC_CSR_BASE + CGMAC_PORT_OFFSET * _port + 0x108 + ((_i) * 8))
+#define PFP_CGM_TX_TXLO(_port, _i) (CGMAC_CSR_BASE + CGMAC_PORT_OFFSET * _port + 0x10C + ((_i) * 8))
+
+#define CGMAC_CSR_MAC0_OFFSET 0x2B4000
+#define CGMAC_CSR_MAC_OFFSET(_i) (CGMAC_CSR_MAC0_OFFSET + ((_i) * 0x4000))
+
+#define PFP_CGM_MAC_TX_TSMEM(_phy, _i)        \
+	(CGMAC_CSR_MAC_OFFSET(_phy) + 0x100 + \
+	 ((_i) * 4))
+
+#define PFP_CGM_MAC_TX_TXHI(_phy, _i) (CGMAC_CSR_MAC_OFFSET(_phy) + 0x108 + ((_i) * 8))
+#define PFP_CGM_MAC_TX_TXLO(_phy, _i) (CGMAC_CSR_MAC_OFFSET(_phy) + 0x10C + ((_i) * 8))
+
+#define SXE2_VF_GLINT_CEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
+#define SXE2_VF_GLINT_CEQCTL_ITR_INDX_S	11
+#define SXE2_VF_GLINT_CEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
+#define SXE2_VF_GLINT_CEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_GLINT_CEQCTL(_INT)			(0x0026492C + ((_INT) * 4))
+
+#define SXE2_VF_PFINT_AEQCTL_MSIX_INDX_M	SXE2_BITS_MASK(0x7FF, 0)
+#define SXE2_VF_VPINT_AEQCTL_ITR_INDX_S	11
+#define SXE2_VF_VPINT_AEQCTL_ITR_INDX_M	SXE2_BITS_MASK(0x3, 11)
+#define SXE2_VF_VPINT_AEQCTL_CAUSE_ENA_M	BIT(30)
+#define SXE2_VF_VPINT_AEQCTL(_VF)			(0x0026052c + ((_VF) * 4))
+
+#define SXE2_IPSEC_TX_BASE (0x2A0000)
+#define SXE2_IPSEC_RX_BASE (0x2A2000)
+
+#define SXE2_IPSEC_RX_IPSIDX_ADDR (SXE2_IPSEC_RX_BASE + 0x0084)
+#define SXE2_IPSEC_RX_IPSIDX_RST (0x00040000)
+#define SXE2_IPSEC_RX_IPSIDX_VBI_SHIFT (18)
+#define SXE2_IPSEC_RX_IPSIDX_VBI_MASK (0x00040000)
+#define SXE2_IPSEC_RX_IPSIDX_SWRITE_SHIFT (17)
+#define SXE2_IPSEC_RX_IPSIDX_SWRITE_MASK (0x00020000)
+#define SXE2_IPSEC_RX_IPSIDX_SA_IDX_SHIFT (4)
+#define SXE2_IPSEC_RX_IPSIDX_SA_IDX_MASK (0x0000fff0)
+#define SXE2_IPSEC_RX_IPSIDX_TABLE_SHIFT (2)
+#define SXE2_IPSEC_RX_IPSIDX_TABLE_MASK (0x0000000c)
+
+#define SXE2_IPSEC_RX_IPSIPID_ADDR (SXE2_IPSEC_RX_BASE + 0x0088)
+#define SXE2_IPSEC_RX_IPSIPID_IP_ID_X_SHIFT (0)
+#define SXE2_IPSEC_RX_IPSIPID_IP_ID_X_MASK (0x000000ff)
+
+#define SXE2_IPSEC_RX_IPSSPI0_ADDR (SXE2_IPSEC_RX_BASE + 0x008c)
+#define SXE2_IPSEC_RX_IPSSPI0_SPI_X_SHIFT (0)
+#define SXE2_IPSEC_RX_IPSSPI0_SPI_X_MASK (0xffffffff)
+
+#define SXE2_IPSEC_RX_IPSSPI1_ADDR (SXE2_IPSEC_RX_BASE + 0x0090)
+#define SXE2_IPSEC_RX_IPSSPI1_SPI_Y_MASK (0xffffffff)
+
+#define SXE2_PAUSE_STATS_BASE(port)		(0x002b2000 + port * 0x4000)
+#define SXE2_TXPAUSEXONFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0894)
+#define SXE2_TXPAUSEXOFFFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0a18)
+#define SXE2_TXPFCXONFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0a20 + 8 * (pri)))
+#define SXE2_TXPFCXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0a60 + 8 * (pri)))
+#define SXE2_TXPFCXONTOXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+							(0x0aa0 + 8 * (pri)))
+#define SXE2_RXPAUSEXONFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0988)
+#define SXE2_RXPAUSEXOFFFRAMES_LO(port)	(SXE2_PAUSE_STATS_BASE(port) + 0x0b28)
+#define SXE2_RXPFCXONFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0b30 + 8 * (pri)))
+#define SXE2_RXPFCXOFFFRAMES_LO(port, pri)	(SXE2_PAUSE_STATS_BASE(port) + \
+						(0x0b70 + 8 * (pri)))
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_internal_ver.h b/drivers/common/sxe2/sxe2_internal_ver.h
new file mode 100644
index 0000000000..a41913fdd8
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_internal_ver.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_INTERNAL_VER_H__
+#define __SXE2_INTERNAL_VER_H__
+
+#define SXE2_VER_MAJOR_OFFSET (16)
+#define SXE2_MK_VER(major, minor) \
+	(major << SXE2_VER_MAJOR_OFFSET | minor)
+#define SXE2_MK_VER_MAJOR(ver) ((ver >> SXE2_VER_MAJOR_OFFSET) & 0xff)
+#define SXE2_MK_VER_MINOR(ver) ((ver) & 0xff)
+
+#define SXE2_ITR_VER_MAJOR_V100    1
+#define SXE2_ITR_VER_MAJOR_V200    2
+
+#define SXE2_ITR_VER_MAJOR      1
+#define SXE2_ITR_VER_MINOR      1
+#define SXE2_ITR_VER SXE2_MK_VER(SXE2_ITR_VER_MAJOR, SXE2_ITR_VER_MINOR)
+
+#define SXE2_CTRL_VER_IS_V100(ver)  (SXE2_MK_VER_MAJOR(ver) == SXE2_ITR_VER_MAJOR_V100)
+#define SXE2_CTRL_VER_IS_V200(ver)  (SXE2_MK_VER_MAJOR(ver) == SXE2_ITR_VER_MAJOR_V200)
+
+#define SXE2LIB_ITR_VER_MAJOR      1
+#define SXE2LIB_ITR_VER_MINOR      1
+#define SXE2LIB_ITR_VER     SXE2_MK_VER(SXE2LIB_ITR_VER_MAJOR, SXE2LIB_ITR_VER_MINOR)
+
+#define SXE2_DRV_CLI_VER_MAJOR      1
+#define SXE2_DRV_CLI_VER_MINOR      1
+#define SXE2_DRV_CLI_VER \
+	SXE2_MK_VER(SXE2_DRV_CLI_VER_MAJOR, SXE2_DRV_CLI_VER_MINOR)
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
new file mode 100644
index 0000000000..fd6823fe98
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -0,0 +1,584 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_OSAL_H__
+#define __SXE2_OSAL_H__
+#include <string.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_malloc.h>
+#include <rte_ether.h>
+#include <rte_version.h>
+
+#include "sxe2_type.h"
+
+#define BIT(nr)             (1UL << (nr))
+#ifndef __BITS_PER_LONG
+#define __BITS_PER_LONG   (__SIZEOF_LONG__ * 8)
+#endif
+#define BIT_WORD(nr)      ((nr) / __BITS_PER_LONG)
+#define BIT_MASK(nr)	  (1UL << ((nr) % __BITS_PER_LONG))
+
+#ifndef BIT_ULL
+#define BIT_ULL(a) (1ULL << (a))
+#endif
+
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+
+#define BITS_PER_BYTE 8
+
+#define IS_UNICAST_ETHER_ADDR(addr)			\
+	((bool)((((u8 *)(addr))[0] % ((u8)0x2)) == 0))
+
+#define STRUCT_SIZE(ptr, field, num) \
+	(sizeof(*(ptr)) + sizeof(*(ptr)->field) * (num))
+
+#ifndef TAILQ_FOREACH_SAFE
+#define TAILQ_FOREACH_SAFE(var, head, field, tvar) \
+	for ((var) = TAILQ_FIRST((head)); \
+		(var) && ((tvar) = TAILQ_NEXT((var), field), 1); \
+		(var) = (tvar))
+#endif
+
+#define SXE2_QUEUE_WAIT_RETRY_CNT    (50)
+
+#define __iomem
+
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+
+#define dma_addr_t rte_iova_t
+
+#define resource_size_t u64
+
+#define FIELD_SIZEOF(t, f) RTE_SIZEOF_FIELD(t, f)
+#define ARRAY_SIZE(arr) RTE_DIM(arr)
+
+#define CPU_TO_LE16(o) rte_cpu_to_le_16(o)
+#define CPU_TO_LE32(s) rte_cpu_to_le_32(s)
+#define CPU_TO_LE64(h) rte_cpu_to_le_64(h)
+#define LE16_TO_CPU(a) rte_le_to_cpu_16(a)
+#define LE32_TO_CPU(c) rte_le_to_cpu_32(c)
+#define LE64_TO_CPU(k) rte_le_to_cpu_64(k)
+
+#define CPU_TO_BE16(o) rte_cpu_to_be_16(o)
+#define CPU_TO_BE32(o) rte_cpu_to_be_32(o)
+#define CPU_TO_BE64(o) rte_cpu_to_be_64(o)
+#define BE16_TO_CPU(o) rte_be_to_cpu_16(o)
+
+#define NTOHS(a) rte_be_to_cpu_16(a)
+#define NTOHL(a) rte_be_to_cpu_32(a)
+#define HTONS(a) rte_cpu_to_be_16(a)
+#define HTONL(a) rte_cpu_to_be_32(a)
+
+#define udelay(x) rte_delay_us(x)
+
+#define mdelay(x) rte_delay_us(1000 * (x))
+
+#define msleep(x) rte_delay_us(1000 * (x))
+
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d) \
+			(((n) + (typeof(n))(d) - (typeof(n))1) / (typeof(n))(d))
+#endif
+
+#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+
+#define __bf_shf(x) ((uint32_t)rte_bsf64(x))
+
+#ifndef BITS_PER_LONG
+#define BITS_PER_LONG	32
+#endif
+
+#define FIELD_PREP(mask, val) (((typeof(mask))(val) << __bf_shf(mask)) & (mask))
+#define FIELD_GET(_mask, _reg) ((typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)))
+
+#define SXE2_NUM_ROUND_UP(n, d) (DIV_ROUND_UP(n, d) * d)
+
+static inline void sxe2_swap_u16(u16 *a, u16 *b)
+{
+	*a += *b;
+	*b = *a - *b;
+	*a -= *b;
+}
+
+#define SXE2_SWAP_U16(a, b) sxe2_swap_u16(a, b)
+
+enum sxe2_itr_idx {
+	SXE2_ITR_IDX_0 = 0,
+	SXE2_ITR_IDX_1,
+	SXE2_ITR_IDX_2,
+	SXE2_ITR_IDX_NONE,
+};
+
+#define MAX_ERRNO	4095
+#define IS_ERR_VALUE(x) unlikely((uintptr_t)(void *)(x) >= (uintptr_t)-MAX_ERRNO)
+static inline bool IS_ERR(const void *ptr)
+{
+	return IS_ERR_VALUE((uintptr_t)ptr);
+}
+
+#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+
+#define SXE2_CTXT_REG_VALUE(value, shift, width)    ((value << shift) & \
+						(((1ULL << width) - 1) << shift))
+
+#define  ETH_P_8021Q  0x8100
+#define  ETH_P_8021AD 0x88a8
+#define  ETH_P_QINQ1  0x9100
+
+#define FLEX_ARRAY_SIZE(_ptr, _mem, cnt) ((cnt) * sizeof(_ptr->_mem[0]))
+
+struct sxe2_lock {
+	rte_spinlock_t spinlock;
+};
+#define sxe2_init_lock(sp) rte_spinlock_init(&(sp)->spinlock)
+#define sxe2_acquire_lock(sp) rte_spinlock_lock(&(sp)->spinlock)
+#define sxe2_release_lock(sp) rte_spinlock_unlock(&(sp)->spinlock)
+#define sxe2_destroy_lock(sp) RTE_SET_USED(sp)
+
+#define COMPILER_BARRIER() \
+		{ asm volatile("" ::: "memory"); }
+
+struct sxe2_list_head_type {
+	struct sxe2_list_head_type *next, *prev;
+};
+
+#define LIST_HEAD_TYPE				sxe2_list_head_type
+
+#define SXE2_LIST_ENTRY(ptr, type, member) container_of(ptr, type, member)
+#define LIST_FIRST_ENTRY(ptr, type, member) \
+			SXE2_LIST_ENTRY((ptr)->next, type, member)
+#define LIST_NEXT_ENTRY(pos, member) \
+			SXE2_LIST_ENTRY((pos)->member.next, typeof(*(pos)), member)
+
+static inline void INIT_LIST_HEAD(struct LIST_HEAD_TYPE *list)
+{
+	list->next = list;
+	COMPILER_BARRIER();
+	list->prev = list;
+	COMPILER_BARRIER();
+}
+
+static inline void sxe2_list_add(struct LIST_HEAD_TYPE *curr,
+					struct LIST_HEAD_TYPE *prev,
+					struct LIST_HEAD_TYPE *next)
+{
+	next->prev = curr;
+	curr->next = next;
+	curr->prev = prev;
+	COMPILER_BARRIER();
+	prev->next = curr;
+	COMPILER_BARRIER();
+}
+
+#define LIST_ADD(entry, head)    sxe2_list_add(entry, (head), (head)->next)
+#define LIST_ADD_TAIL(entry, head)    sxe2_list_add(entry, (head)->prev, head)
+
+static inline void __list_del(struct LIST_HEAD_TYPE *prev, struct LIST_HEAD_TYPE *next)
+{
+	next->prev = prev;
+	COMPILER_BARRIER();
+	prev->next = next;
+	COMPILER_BARRIER();
+}
+
+static inline void __list_del_entry(struct LIST_HEAD_TYPE *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+#define LIST_DEL(entry) __list_del_entry(entry)
+
+static inline bool __list_is_empty(const struct LIST_HEAD_TYPE *head)
+{
+	COMPILER_BARRIER();
+	return head->next == head;
+}
+
+#define LIST_IS_EMPTY(head) __list_is_empty(head)
+
+#define LIST_FOR_EACH_ENTRY(pos, head, member)			       \
+		for (pos = LIST_FIRST_ENTRY(head, typeof(*pos), member);    \
+				&pos->member != (head);                    \
+				pos = LIST_NEXT_ENTRY(pos, member))
+
+#define LIST_FOR_EACH_ENTRY_SAFE(pos, n, head, member)		       \
+		for (pos = LIST_FIRST_ENTRY(head, typeof(*pos), member),    \
+				n = LIST_NEXT_ENTRY(pos, member);            \
+				&pos->member != (head);                     \
+				pos = n, n = LIST_NEXT_ENTRY(n, member))
+
+struct sxe2_blk_list_head_type {
+	struct sxe2_blk_list_head_type *next_blk;
+	struct sxe2_blk_list_head_type *next;
+	u16 blk_size;
+	u16 blk_id;
+};
+
+#define BLK_LIST_HEAD_TYPE	sxe2_blk_list_head_type
+
+static inline void sxe2_blk_list_add(struct BLK_LIST_HEAD_TYPE *node,
+					struct BLK_LIST_HEAD_TYPE *head)
+{
+	struct BLK_LIST_HEAD_TYPE *curr = head->next_blk;
+	struct BLK_LIST_HEAD_TYPE *prev = head;
+
+	while (curr != NULL && curr->blk_id < node->blk_id) {
+		prev = curr;
+		curr = curr->next_blk;
+	}
+
+	if (prev != head && prev->blk_id + prev->blk_size == node->blk_id) {
+		prev->blk_size += node->blk_size;
+		node->blk_size = 0;
+	} else {
+		node->next_blk = curr;
+		prev->next_blk = node;
+	}
+
+	node = (node->blk_size == 0) ? prev : node;
+
+	if (curr) {
+
+		if (node->blk_id + node->blk_size == curr->blk_id) {
+			node->blk_size += curr->blk_size;
+			curr->blk_size = 0;
+			node->next_blk = curr->next_blk;
+		} else {
+			node->next_blk = curr;
+		}
+	}
+}
+
+static inline struct BLK_LIST_HEAD_TYPE *sxe2_blk_list_get(
+			struct BLK_LIST_HEAD_TYPE *head, u16 blk_size)
+{
+	struct BLK_LIST_HEAD_TYPE *curr = head->next_blk;
+	struct BLK_LIST_HEAD_TYPE *prev = head;
+	struct BLK_LIST_HEAD_TYPE *blk_max_node = curr;
+	struct BLK_LIST_HEAD_TYPE *blk_max_node_pre = head;
+	struct BLK_LIST_HEAD_TYPE *ret = NULL;
+	s32 i = blk_size;
+
+	while (curr && curr->blk_size != blk_size) {
+		if (curr->blk_size > blk_max_node->blk_size) {
+			blk_max_node = curr;
+			blk_max_node_pre = prev;
+		}
+		prev = curr;
+		curr = curr->next_blk;
+	}
+
+	if (curr != NULL) {
+		prev->next_blk = curr->next_blk;
+		ret = curr;
+		goto l_end;
+	}
+
+	if (blk_max_node->blk_size < blk_size)
+		goto l_end;
+
+	ret = blk_max_node;
+	prev = blk_max_node_pre;
+
+	curr = blk_max_node;
+	while (i != 0) {
+		curr = curr->next;
+		i--;
+	}
+	curr->blk_size = blk_max_node->blk_size - blk_size;
+	blk_max_node->blk_size = blk_size;
+	prev->next_blk = curr;
+
+l_end:
+	return ret;
+}
+
+#define BLK_LIST_ADD(entry, head) sxe2_blk_list_add(entry, head)
+#define BLK_LIST_GET(head, blk_size) sxe2_blk_list_get(head, blk_size)
+
+#ifndef BIT_ULL
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#endif
+
+static inline bool check_is_pow2(u64 val)
+{
+	return (val && !(val & (val - 1)));
+}
+
+static inline u8 sxe2_setbit_cnt8(u8 num)
+{
+	u8 bits = 0;
+	u32 i;
+
+	for (i = 0; i < 8; i++) {
+		bits += (num & 0x1);
+		num >>= 1;
+	}
+
+	return bits;
+}
+
+static inline bool max_set_bit_check(const u8 *mask, u16 size, u16 max)
+{
+	u16 count = 0;
+	u16 i;
+	bool ret = false;
+
+	for (i = 0; i < size; i++) {
+		if (!mask[i])
+			continue;
+
+		if (count == max)
+			goto l_end;
+
+		count += sxe2_setbit_cnt8(mask[i]);
+		if (count > max)
+			goto l_end;
+	}
+
+	ret = true;
+l_end:
+	return ret;
+}
+
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(unsigned long))
+#define BITS_TO_U32(nr) DIV_ROUND_UP(nr, 32)
+
+#define GENMASK(h, l) (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (__BITS_PER_LONG - 1 - (h))))
+
+#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (__BITS_PER_LONG - 1)))
+
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+#define BITMAP_MEM_ALIGNMENT 8
+#else
+#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
+#endif
+#define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
+#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
+
+#define DECLARE_BITMAP(name, bits) \
+				unsigned long name[BITS_TO_LONGS(bits)]
+#define BITMAP_TYPE unsigned long
+#define small_const_nbits(nbits) \
+	(__rte_constant(nbits) && (nbits) <= __BITS_PER_LONG && (nbits) > 0)
+
+static inline void set_bit(u32 nr, unsigned long *addr)
+{
+	addr[nr / __BITS_PER_LONG] |= 1UL << (nr % __BITS_PER_LONG);
+}
+
+static inline void clear_bit(u32 nr, unsigned long *addr)
+{
+	addr[nr / __BITS_PER_LONG] &= ~(1UL << (nr % __BITS_PER_LONG));
+}
+
+static inline u32 test_bit(u32 nr, const volatile unsigned long *addr)
+{
+	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (__BITS_PER_LONG-1)));
+}
+
+static inline u32 bitmap_weight(const unsigned long *src, u32 nbits)
+{
+	u32 cnt = 0;
+	u16 i;
+	for (i = 0; i < nbits; i++) {
+		if (test_bit(i, src))
+			cnt++;
+	}
+	return cnt;
+}
+
+static inline bool bitmap_empty(const unsigned long *src, u32 nbits)
+{
+	u16 i;
+	for (i = 0; i < nbits; i++) {
+		if (test_bit(i, src))
+			return false;
+	}
+	return true;
+}
+
+static inline void bitmap_zero(unsigned long *dst, u32 nbits)
+{
+	u32 len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memset(dst, 0, len);
+}
+
+static bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+		 const unsigned long *bitmap2, u32 bits)
+{
+	u32 k;
+	u32 lim = bits/__BITS_PER_LONG;
+	unsigned long result = 0;
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & bitmap2[k]);
+	if (bits % __BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & bitmap2[k] &
+				BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
+
+static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, u32 nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & *src2 & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_and(dst, src1, src2, nbits);
+}
+
+static void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+		 const unsigned long *bitmap2, int bits)
+{
+	int k;
+	int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++)
+		dst[k] = bitmap1[k] | bitmap2[k];
+}
+
+static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, u32 nbits)
+{
+	if (small_const_nbits(nbits))
+		*dst = *src1 | *src2;
+	else
+		__bitmap_or(dst, src1, src2, nbits);
+}
+
+static int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, u32 bits)
+{
+	u32 k;
+	u32 lim = bits/__BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % __BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			   BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
+
+static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+			const unsigned long *src2, u32 nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
+static bool __bitmap_equal(const unsigned long *bitmap1,
+		const unsigned long *bitmap2, u32 bits)
+{
+	u32 k, lim = bits/__BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return false;
+
+	if (bits % __BITS_PER_LONG)
+		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return false;
+
+	return true;
+}
+
+static inline bool bitmap_equal(const unsigned long *src1,
+		const unsigned long *src2, u32 nbits)
+{
+	if (small_const_nbits(nbits))
+		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
+	if (__rte_constant(nbits & BITMAP_MEM_MASK) &&
+		IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		return !memcmp(src1, src2, nbits / 8);
+	return __bitmap_equal(src1, src2, nbits);
+}
+
+static inline unsigned long
+find_next_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
+{
+	u16 i;
+
+	for (i = offset; i < size; i++) {
+		if (test_bit(i, addr))
+			break;
+	}
+	return i;
+}
+
+static inline unsigned long
+find_next_zero_bit(const unsigned long *addr, unsigned long size,
+		unsigned long offset)
+{
+	u16 i;
+	for (i = offset; i < size; i++) {
+		if (!test_bit(i, addr))
+			break;
+	}
+	return i;
+}
+
+static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
+			u32 nbits)
+{
+	u32 len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	memcpy(dst, src, len);
+}
+
+static inline unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
+{
+	return find_next_zero_bit(addr, size, 0);
+}
+
+static inline unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
+{
+	return find_next_bit(addr, size, 0);
+}
+
+#define for_each_clear_bit(bit, addr, size) \
+		for ((bit) = find_first_zero_bit((addr), (size));	\
+			(bit) < (size);					\
+			(bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+#define for_each_set_bit(bit, addr, size) \
+		for ((bit) = find_first_bit((addr), (size));	\
+			(bit) < (size);					\
+			(bit) = find_next_bit((addr), (size), (bit) + 1))
+
+struct sxe2_adapter;
+
+static inline void *sxe2_malloc(__rte_unused struct sxe2_adapter *ad, size_t size)
+{
+	return rte_zmalloc(NULL, size, 0);
+}
+
+static inline void *sxe2_calloc(__rte_unused struct sxe2_adapter *ad, size_t num, size_t size)
+{
+	return rte_calloc(NULL, num, size, 0);
+}
+
+static inline void sxe2_free(__rte_unused struct sxe2_adapter *ad, void *ptr)
+{
+	rte_free(ptr);
+}
+
+static inline void *sxe2_memdup(__rte_unused struct sxe2_adapter *ad,
+			const void *src, size_t size)
+{
+	void *p;
+
+	p = sxe2_malloc(ad, size);
+	if (p)
+		rte_memcpy(p, src, size);
+	return p;
+}
+
+#endif
diff --git a/drivers/common/sxe2/sxe2_type.h b/drivers/common/sxe2/sxe2_type.h
new file mode 100644
index 0000000000..56d0a11f48
--- /dev/null
+++ b/drivers/common/sxe2/sxe2_type.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TYPES_H__
+#define __SXE2_TYPES_H__
+
+#include <sys/time.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+
+#if defined __BYTE_ORDER__
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define __BIG_ENDIAN_BITFIELD
+#elif __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define __LITTLE_ENDIAN_BITFIELD
+#endif
+#elif defined __BYTE_ORDER
+#if __BYTE_ORDER == __BIG_ENDIAN
+#define __BIG_ENDIAN_BITFIELD
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+#define __LITTLE_ENDIAN_BITFIELD
+#endif
+#elif defined __BIG_ENDIAN__
+#define __BIG_ENDIAN_BITFIELD
+#elif defined __LITTLE_ENDIAN__
+#define __LITTLE_ENDIAN_BITFIELD
+#elif defined RTE_TOOLCHAIN_MSVC
+#define __LITTLE_ENDIAN_BITFIELD
+#else
+#error  "Unknown endianness."
+#endif
+typedef uint8_t     u8;
+typedef uint16_t    u16;
+typedef uint32_t    u32;
+typedef uint64_t    u64;
+
+typedef char    s8;
+typedef int16_t    s16;
+typedef int32_t    s32;
+typedef int64_t    s64;
+
+typedef s8     S8;
+typedef s16    S16;
+typedef s32    S32;
+
+#define __le16    u16
+#define __le32    u32
+#define __le64    u64
+
+#define __be16    u16
+#define __be32    u32
+#define __be64    u64
+
+#define STATIC static
+
+#define ETH_ALEN    6
+
+#endif
diff --git a/drivers/meson.build b/drivers/meson.build
index 6ae102e943..d4ae512bae 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -12,6 +12,7 @@ subdirs = [
         'common/qat',     # depends on bus.
         'common/sfc_efx', # depends on bus.
         'common/zsda',    # depends on bus.
+        'common/sxe2',    # depends on bus.
         'mempool',        # depends on common and bus.
         'dma',            # depends on common and bus.
         'net',            # depends on common, bus, mempool
-- 
2.47.3

