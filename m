Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D691D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EE4A40B9A;
	Tue, 27 Jan 2026 00:24:53 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 81C8C40B97
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:24:51 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so4157331f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469891;
 x=1770074691; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=RASIBGadO2wNYOMsUlDi5EmI/HLSa7eZaYZ45SAY1lSDzdrrJqZAbXeYrR57m81Q+J
 F9fs9xhkwO+DbTBI91TAVQ3KW7Epq6GIPHERC6qIvFM+1MNzJwPb3T1ZCf5jhoeSAZTb
 QpZRg0vXUiPae29fk0SGLmaYKvrsz6+cV7qeUwXyqHDeW7YCzFCc5bJBuH7IeljMLT24
 eyxBBs50X1F9WWt9TItK0+2s2N1kfl/59DZ2gj9cSjrGeZQvmEI0qgSV1JcHspCq3Pf+
 vs1QIOa5v3uj7mZqI/7aMzmXiXGFZGs3iV5QXlCpOOBfWetzlD6qWDVciO9txy65eGFu
 +MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469891; x=1770074691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=Y2ZZYJbIvTWxR5LnCOV64D73pKg7Q4ifPuqAV/P5qFTU0kHp0qz0k0HDVaMO9ftN9+
 iuK59FZkprnTWo1anhywmixCCV8llcaUF7I/qavNQDXsaAzOU6SWCrKaKOk85+vBo3Nn
 eJClVRrApI5f3nwOVEHfvBtQ9A4tGLheFNcOsGCPmMB06naTXSk00Qa8TFsGp7gKEzxF
 DBY2l/oD0gixewnQCMpMtiGqhC7Jbw+fg2ffVu1Io4ZmsWCRMensdPdgXGvgbrzVNjvS
 5J9bXE79cGy1qCl3XrUSM7TGxJ3k3W2w+imztRRwj01n+PZUFvHW2AqWfCmIie6MFLVC
 duIA==
X-Gm-Message-State: AOJu0YwEYD4oLiqd9vFZIkFKKbem/8fbb1IU39EJUO6v958C0ckVVJfF
 kZX8bHP7SA2zSlOCGUP6Sgh1ZST8LgjwNsci3HsNPweatAVYARg6TzbcApyUhGxcTfeAPwnJHac
 rfibX
X-Gm-Gg: AZuq6aJr3xAyFxTqqAP9LDZ7Oc8p0MASlGyZ7VFylGavYbfzK6Ew/U3c5ZVokKvlJ5s
 A1WRkxGEu5iZ4NVwW7yh/9WuvrfGz3U5nIukbTSoJ//TVIZzW1zSKBGEosCZP3z45+xfTTF+dFc
 e6FUyPs2BArIkDiK71CWt80wzrZTmDzX9LT7IW2c2cPM8W4iORU/JOPEG9+JPaV+lyfu6QY7rAJ
 W2SiYUk2TWGN+5mD3Rtmt9DfeUA4VOjeXZTO6DdtqGNzgEDSRJN8wPdYLyLGrRUXbB1CDU5cibY
 Rl0IKxPFfBJ0POT7XHUtAH1i1aEQW+4ceYJiAtZ0tdJfT227CmIUuixZMZaqnNbiI7bBcXTpc1S
 gsSV+5Nx3SxL3nYkrfE8mJzuRTR9vRye1ysYEupdVVTQ+wk6OZcy8sUcBxe4JKo7wFSB0A2ZQae
 G6v4zjvTc2HKGCyhuMs9JXG5wwa16SWEFl6ggAGqAUIk9SDq8QPw==
X-Received: by 2002:a5d:588d:0:b0:430:fbe1:382a with SMTP id
 ffacd0b85a97d-435ca1aaddemr11613973f8f.54.1769469891126; 
 Mon, 26 Jan 2026 15:24:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:24:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v12 08/17] eal: warn if thread name is truncated
Date: Mon, 26 Jan 2026 15:22:16 -0800
Message-ID: <20260126232428.276534-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..60f5e676a8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..f06375a624 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

