Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC3C88E56
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C79CB40695;
	Sat, 12 Sep 2026 19:04:09 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id EFF664067C
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:08 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d7so774797b3a.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232648;
 x=1789837448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=EzHbM7BPAuQHNwNUPuszhxDgljKDF8sgfapvY0BZqOakfT3ZpxFyKvO3QgYkTRU4LD
 OaPfo2vF/jpV8XcRg4gwT4zeFKZjq/ttS8amrwgxLl8qYafe4CwTL5n45AyWPPXjlfLW
 HBEs+MspsIfonHz1gywN/uIZc6WdZ0yLhK76BHQVJyD8abz8GUmKIveP2KCiecU9ZLdT
 nZqPVp9DX7X8htf+oxjZAvtn8LDKYSlCW/z9BAMk9SieRhVpxWXbX5EB7aebWgrBrUZR
 f3pcRsKKA6NC08js9ALm0NluiGlEJO6qUtHAAR0i5QrjMhj32fTqDaibO0yeRh93GAXX
 P0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232648; x=1789837448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=oU+smNI+u8Jc5Hu+/G13rMxhVxlGRdpQ3rSoPVkKrXcfuW3FqFT/0VEMiQQJa8FPlZ
 YKNPp3FqZDseTs/VK92AZRBxW/HinBXQZUjZ0lmuUzor7fPAmXSGOOZnrC4eHeXh5IdK
 W3TEohEP7z1FF0WvYscyzN5UuB7rUAYI1ulieUpOcw8d+CulAbNb8wTHL9VZkfI5aNn2
 Eis9WZqNn3x2RzIpnibtH8i58ltwIPIC6rSVRzZ5CmDogTE96AgAzK60sqm6Wzk0QdUL
 EEaHLR9LJDee3YAD7eCgYpzPxBsZUKKlgq5hj9m4vcoRZL+cC0Edci8ST+xgR32WRtFs
 +7OA==
X-Gm-Message-State: AFuF++mWqF32XtHfhr6Bf6kgnoynbLfZWHPbjpVyekLc1OfgtRNZGVmJ
 f/7pL30G2ISQXcjCLyV97eVvGbLDVzJ6Te8NuMzMPq3PlPeAWcAtIi3dHh5cwnE5urqZ1WyeEyT
 f+w1eNSw=
X-Gm-Gg: AYBFou1MwavEcJFCATF8BD+XSNUfNwrAoZ2ZcaBQvOZMKRpB0cw9iUMsMiEHs7s95zq
 SMSUBB8UzaBsaN8NH0zFbX6ZcxNWFdPsQAqLkQwHC/+Qk3ejCOBlEkSvG5sMNtPPYztBSs/hQk7
 KaKWfJvJQC18FpH9HZLo80z5zQkFls11tvHdLlWW9qVr35L5AnI3qtRhkxH0OPHQaN2BxpAspal
 jhfI3fVEjoaU3n2oC0zPxw0RNlOHz6V8ET6siEN5Nok63CfiddU9PHYezoczmnT3Kk3TSHJZoCo
 iwjQROOa9pxk2fFSspX7eL6LFpkM211Kpavt+QHA3C1BucGZomRQ/Rb2z3VEqmctg3R9CLXq5aH
 LtI/OTxTBJOejT6FYGWeNK+R4lo0UsIEpHJ31mpgSboX/7bFIslnhQznRAfmhMrLLEAwBIuu20C
 U0ZZz1kOR/wHAqnO3Z5RlLqgDIRWkdnuUrxpuzg5GJyq3NdkjJK2ryRzZExUDKPQs1CgdqdV6VJ
 bpEX89J0BScg567CnCtEuUIjkIjcHSn2x8hPg==
X-Received: by 2002:a05:6a00:4387:b0:857:72ba:ff0c with SMTP id
 d2e1a72fcca58-86b33ffbe80mr17544309b3a.20.1789232648136; 
 Sat, 12 Sep 2026 10:04:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 4/9] bus/vmbus: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:16 -0700
Message-ID: <20260912170338.486978-5-stephen@networkplumber.org>
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

Replace the open coded read in vmbus_uio_sysfs_read() with the EAL
routine. The range check and the -ERANGE return are unchanged.

Two things do change. On an open failure the helper now returns -EIO
rather than -errno; both callers only pass it to strerror(-err) in a
log message, so this is message text only. And subchannel_id and
monitor_id were read with fscanf("%u") and are now converted with
base 0, so a value with a leading zero would parse as octal. Neither
attribute is printed with leading zeros by the kernel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/linux/vmbus_uio.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index fbafc5027d..50e58f9b65 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -18,6 +18,7 @@
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 
 #include "private.h"
 
@@ -334,27 +335,12 @@ int vmbus_uio_map_rings(struct vmbus_channel *chan)
 static int vmbus_uio_sysfs_read(const char *dir, const char *name,
 				unsigned long *val, unsigned long max_range)
 {
-	char path[PATH_MAX];
-	FILE *f;
-	int ret;
-
-	snprintf(path, sizeof(path), "%s/%s", dir, name);
-	f = fopen(path, "r");
-	if (!f) {
-		VMBUS_LOG(ERR, "can't open %s:%s",
-			  path, strerror(errno));
-		return -errno;
+	if (rte_sysfs_parse_uint(val, "%s/%s", dir, name) < 0) {
+		VMBUS_LOG(ERR, "can't read %s/%s", dir, name);
+		return -EIO;
 	}
 
-	if (fscanf(f, "%lu", val) != 1)
-		ret = -EIO;
-	else if (*val > max_range)
-		ret = -ERANGE;
-	else
-		ret = 0;
-	fclose(f);
-
-	return ret;
+	return *val > max_range ? -ERANGE : 0;
 }
 
 static bool vmbus_uio_ring_present(const struct rte_vmbus_device *dev,
-- 
2.53.0

