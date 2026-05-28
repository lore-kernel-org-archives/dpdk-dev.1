Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3AFCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 19:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94E94021F;
	Thu, 28 May 2026 21:05:00 +0200 (CEST)
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com
 [74.125.82.195]) by mails.dpdk.org (Postfix) with ESMTP id 792F14003C
 for <dev@dpdk.org>; Thu, 28 May 2026 21:04:59 +0200 (CEST)
Received: by mail-dy1-f195.google.com with SMTP id
 5a478bee46e88-303dbfbec77so15742858eec.0
 for <dev@dpdk.org>; Thu, 28 May 2026 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779995098; x=1780599898; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hoLjUfiLkySWrsEfTSS92Q4gRZZcfod2bYoxIZ31P2E=;
 b=qhi2zK433zadTyiwFNoaEiEYvuiC2ELSmhGoKdjnE2V9HDSpABaertTDvFB67CekRN
 qhj89b8R4cU3hSRmjR/loJjSqxXhgLIiQFjaBLgVLJLaKec2qRQ3OxPrs6KJRDgXsUCu
 CVzDBMzD2oDbPBYuIPgEbZ4+SnAzZjWJEbbDBEeDFZ1ETRvoh8lWG9Aw/Puu/6y16IXy
 Oy3PAr/ve26cvqoQwLlgkHjya4NzhdnZZnbCeujyjzvcZCSlWzSU4ZL2wN2YU3jjM5Lo
 lws4cMbbqqt3M6pSaL+h/9eaOD1nc6KcPlVs/2V7YMI7RiYpACZt5dc+E9zrbVEl2zow
 PNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995098; x=1780599898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoLjUfiLkySWrsEfTSS92Q4gRZZcfod2bYoxIZ31P2E=;
 b=mTSSYHyklmMFPcdyNCzd0/aCJMZb1hWU0Bk4UQzB38JiNDxAb5VHWBg5bPuOW4Ls65
 UNL4hR6wsXM3UuOOElF27ZerQ5RR7GKyJk1gj1fqqHE0aEoGwU5olScx7F4UYbnHSdf1
 R/53lHBx9d9EWnKvaTsIJJwH2awL/Ndq6rD24gRk+v6zq2q6roWDDESe3J7cXPvWvgBN
 DsjjbY2PQPNw27LMCLCDRqZcg0jXeJCvnbx+Ub6/W3Osha7/jeWbBluqBzL+/J2n4jVS
 iYtLAXAYOqkvdMWXIn7+PM7THfdUPGGs+eM2unSFeU9U1wRB/mAyepa/kO/Cu46U2R0r
 nh1Q==
X-Gm-Message-State: AOJu0YyODyG4fGhzVL844Vn68vfJ0iJKg7iHAo4Ev1iEG6Jiuj+/bDS0
 W2sSAa6Q0vSrT0luVJAeyiovzc8wr+/uj7U8Jt9SkwLBLo94i2ed8DjlK16qMK1M
X-Gm-Gg: Acq92OFTtT3kVvJ5rBdXiYNAIOIU7YZnM0DuYxIOJVFHs1KDS3Yb75zjY+rE3GaXwS7
 4PhWiG3ImxyoOn0IP2jESBr5s0fciyb72Wc41pJyJftb78rTzJW5YFgJTzlUxnEjk7bu0dgeXFS
 Cclb7FlfXRi2OCRgD/TwFKvWRUYfWgyh5/EbVeakAiDa1C3JdCqL5j5rmlE2cEM83KmFdq3ExDg
 lQ5XegsctJRILHeGoOYk5lNOaT83uouiUN+YiOnW2xgJ7oZGt+8CtnbzHqjxLE5GmKfT0An8DoS
 Eu4La2QK3BosGTrZZKCm5C0hfZrP4zolnqKy0y1f2kJxnTXJgXbyuXQUXDUoiptg4oZib8cFznU
 Coaxzp9qKQmbGg9FceVDQDI9kYM02GaQhhxWyMQkt+wE4piMDc9NpALer75SKYHhOMRPepivTkB
 2oVlXOql0OTpUangIC6+H3Ecw+eoZEC70hR8O/Z+MQX/cmyOMqBslsJfNapNXZMIO+4VM7lESpK
 b51yCJJEc/CoypM8srkIrYxxQ==
X-Received: by 2002:a05:7301:6093:b0:2da:2ec2:64fe with SMTP id
 5a478bee46e88-304e8c49485mr143670eec.24.1779995098264; 
 Thu, 28 May 2026 12:04:58 -0700 (PDT)
Received: from dpdkvm1.. (c-24-5-101-44.hsd1.ca.comcast.net. [24.5.101.44])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c51f7sm80702eec.18.2026.05.28.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 12:04:58 -0700 (PDT)
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: dev@dpdk.org
Cc: Sudheendra Sampath <giveback4fun@gmail.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
Date: Thu, 28 May 2026 19:04:48 +0000
Message-ID: <20260528190449.66254-1-giveback4fun@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch for bug 1832 will do the following:
1.  If /run/dpdk is not present, it will create it first with and
    then create powermanager directory underneath it.
2.  If /run/dpdk is present, it will verify it is actually a directory
    before creating subdirectory, powermanager.

All directory permissions are 0700.

Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
---
 examples/vm_power_manager/channel_manager.c | 27 ++++++++++++++++++++-
 examples/vm_power_manager/channel_manager.h |  2 +-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index b69449c61d..60d767ea98 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -420,8 +420,33 @@ add_all_channels(const char *vm_name)
 	if (d == NULL) {
 		RTE_LOG(ERR, CHANNEL_MANAGER, "Error opening directory '%s': %s\n",
 				CHANNEL_MGR_SOCKET_PATH, strerror(errno));
-		return -1;
+
+		const char *run_dpdk = "/run/dpdk";
+		struct stat path_stat;
+		int ret;
+
+		if (stat(run_dpdk, &path_stat) != 0) {
+			ret = mkdir(run_dpdk, 0700);
+			if (ret < 0 && errno != EEXIST) {
+				RTE_LOG(ERR, CHANNEL_MANAGER, "Error creating '%s': %s",
+						run_dpdk, strerror(errno));
+				return -1;
+			}
+		}
+
+		/* Make sure /run/dpdk is a directory */
+		if (!S_ISDIR(path_stat.st_mode)) {
+			return -1;
+		}
+
+		ret = mkdir(CHANNEL_MGR_SOCKET_PATH, 0700);
+		if (ret < 0 && errno != EEXIST) {
+			RTE_LOG(ERR, CHANNEL_MANAGER, "Error creating '%s': %s",
+				CHANNEL_MGR_SOCKET_PATH, strerror(errno));
+			return -1;
+		}
 	}
+
 	while ((dir = readdir(d)) != NULL) {
 		if (!strncmp(dir->d_name, ".", 1) ||
 				!strncmp(dir->d_name, "..", 2))
diff --git a/examples/vm_power_manager/channel_manager.h b/examples/vm_power_manager/channel_manager.h
index 6f70539815..5fc93ae0be 100644
--- a/examples/vm_power_manager/channel_manager.h
+++ b/examples/vm_power_manager/channel_manager.h
@@ -22,7 +22,7 @@ extern "C" {
 #define CHANNEL_MGR_DEFAULT_HV_PATH "qemu:///system"
 
 /* File socket directory */
-#define CHANNEL_MGR_SOCKET_PATH     "/tmp/powermonitor/"
+#define CHANNEL_MGR_SOCKET_PATH     "/run/dpdk/powermonitor/"
 
 /* FIFO file name template */
 #define CHANNEL_MGR_FIFO_PATTERN_NAME   "fifo"
-- 
2.43.0

