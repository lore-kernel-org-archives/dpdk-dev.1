Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D88CD4F21
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 09:20:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA55402C5;
	Sat, 16 May 2026 11:20:21 +0200 (CEST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42]) by mails.dpdk.org (Postfix) with ESMTP id 867514025E
 for <dev@dpdk.org>; Wed, 13 May 2026 22:37:31 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so6974528e87.1
 for <dev@dpdk.org>; Wed, 13 May 2026 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778704651; x=1779309451; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60g6AOlu4mHvoGBozPY74K/Hul/HKbLAGmlik8ZonIU=;
 b=B+a6IGkg/QgqZY2pr3t+G7dbMJGu2E5EuaKWrKGH3B/yRzLHdcKnGhohMH7gfoA7ls
 q7sz0iytAi4QSwbDftW5rVf1uXtaeK2AI+hGw+5MCGLsajmfd9Q6AojRf73RM6buI7AX
 I7DNGSTZDlVIXWuPy02iSkoYDX8Ym6PxrGRG05K3F4B9VFM6w+vMKt8s4XwJquMQ6YIb
 Flxtv3JI1xmgrpi+AAiwLVlgrvYRnWrV5XGm5FR+ch9kEdNkqTBKL9ezOPQUFQIaPVI3
 k1FL5Om0okDxV8W2kgPlMJilVm2gQAyKyhZBIDW4hNEuycukdn5c7iyTWquxcMnlMHCr
 XTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704651; x=1779309451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=60g6AOlu4mHvoGBozPY74K/Hul/HKbLAGmlik8ZonIU=;
 b=fu7IMBtywuU19SZAp33uzZM9pfzworeYcmvQuhFEUBJ9eeIGOhgcidqlI4g5f7/qlG
 N9URwJKP7ss/3OHRq219SGDj9I1AVe5oscuwQikbSDrIOA0zNHLzgjicjzeOvWC4IqZ6
 bRwF9MDi9AW898Gp8HAPhoUTT3J7PUvjyx6i/+Va93R8REzwFMcgYry30qQBKcBNmQi0
 0iZ3QGmoU0igv/oSN/OVHiLSjVD8ohAR5XvAbk4BShtpQbc98hOZ1F0w+LCmvQd4j0E4
 uuM1YRY4pqjXzgZ4fGo37ju3N7q0Vsi7soloIafx0jR2BsTaVy941w7slrST5DlgDCfF
 ebRA==
X-Gm-Message-State: AOJu0Yy3IubwE1EdchLByptjBzYhZVh11wLJbbty8MUmREsDPP0QNFLu
 YXLk/Pk+23p3LPjaNRjpUqS53IWP9HdIU7027HaQBdhwvAhLo2VRysd01ZNoYroA
X-Gm-Gg: Acq92OH6FaGuP0fZEckJvzXDyMwWEeyWgrTpQur07w15LfTBQNhx9iTgwLkC7uDen85
 /ZKOyRZNfVqfu1bSVqZnqUjNOlMYC13LGin1jijnYu5brR78RvGB5rBXNfcEXKTM1+1EOCUph8f
 rk9jNJbLayc/N6e7F1a142FnaKcmRJEE6ycHTB0jDCzwIkWe1toHjpnSxXomhPZPbSpf7gNpnhM
 lttQFkx0LP3PfOSy9z4ZkqIKeL6n5yXWwgLhkr4fRMmF+rELiT1sn8L2yRrcXdFJ3SAraDw2Zkr
 +Aplb9o3UkOEfO798XmdCE70jJgpKVmcblP1W3uFNKrm08rMblmRNdEbxFZJIdUODU1xTf0LOMQ
 FxoPZSzGySaLtF0hXQuZEa1V4G3pNX5FpoUH4zfya/5CrJpx4rwlrvqj8WqQWhKw4vu3YrpX0xH
 MbO7QDXUQqJ35+eLbe+RPJSZ4MZAIGz+tLbH3ImjvQuU3h1hi5MTagbOF7pWVRhsVV
X-Received: by 2002:a05:6512:3a8f:b0:5a8:7ca9:9f81 with SMTP id
 2adb3069b0e04-5a8ef8f8dc2mr1704333e87.0.1778704650579; 
 Wed, 13 May 2026 13:37:30 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164ccd16sm31765e87.66.2026.05.13.13.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:37:29 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@oss.nxp.com, g.singh@nxp.com,
 stable@dpdk.org
Subject: [PATCH 1/2] bus/fslmc: fix ignored return value in fslmc_bus_unplug
Date: Wed, 13 May 2026 23:37:24 +0300
Message-ID: <20260513203725.1905-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260513203725.1905-1-shofiqtest@gmail.com>
References: <20260513203725.1905-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 May 2026 11:20:19 +0200
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

fslmc_bus_unplug() called drv->remove() and discarded the return value,
unconditionally clearing driver references and reporting success even
when the remove callback signalled failure.  As a result, callers had
no way to detect or react to removal errors.

Capture the return value and propagate it to the caller.  Only clear
the driver references and log successful unplug when the callback
returns zero.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Bugzilla ID: 1914
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index cf881b3eec..9cfd8b10ba 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -620,7 +620,9 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = dev->driver;
 
 	if (drv && drv->remove) {
-		drv->remove(dev);
+		int ret = drv->remove(dev);
+		if (ret)
+			return ret;
 		dev->driver = NULL;
 		dev->device.driver = NULL;
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
-- 
2.54.0.windows.1

