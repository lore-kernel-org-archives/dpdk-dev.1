Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE95FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0404740A67;
	Tue,  7 Apr 2026 05:52:33 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 33F844066B
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:28 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1279eced0b9so5269016c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533947;
 x=1776138747; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtyW6bb7BrOxb5YSe7/rWGzJ04QGtJElFlyoH3EuEFY=;
 b=vJymImyu+GHAl4/caMP94MYUC8WR3cyxzuTCb28BO7aqUKTqFHma+/74zBP0Hj2ubY
 sOCCvu5jsBi8F4KVeJZmVQyaGphG8F5wewu3A/SUAChpOy3IjZuNVS24zJWxwkwwSU94
 vRJfNMAmsvSk9xAMM1TewN83OwHU6bg4nfOtOoOu0RU1vXTxjLw2jEBPEeq54uXTS0AO
 YVwsM7fj9uq/XlD7VgESrGKpebP0mwOBSH9dT4YHgUAkSxEDlEWIstV3ByGn8bTH6xFm
 4vxesRt3w08EJX2I0wCQCeEij2kmrJO1d1Pp2Kz19VAtdLRu2R81Omqik1d5aHgRo1oC
 SQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533947; x=1776138747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DtyW6bb7BrOxb5YSe7/rWGzJ04QGtJElFlyoH3EuEFY=;
 b=iUCahy059In4liu9sKa68Wjv558Q6xIOl6eo6BypEdXusHXzIyOJW1TTsLy9VSwziO
 i11Ji/pyuaewazMRpTJwqYcjabnbRWPRnXqCUEsMkpI8twiYDoUe9F9LhN1xyeqNbCod
 XAL2iCM5mMuYK7jQuqepDosU1gf20qZm8uMPCWIRlOn5PJRF8CT2E/7otEWYt4E7XpYF
 ZLyv25vw74npM3nyzu6820GGwJPNiC1ZXL9hYrWm2hd/syzagttYR8t2I4hK3rJKO9ph
 k0xZa1KyyEFAcxph20+Wkch1XAq9DgLAUPYHBZWcMio65hNoSKDXZrGoQSURVkhgasb/
 x7Ew==
X-Gm-Message-State: AOJu0YwesWdclaCY/DCyh4ZycS4W3pK4ZPtWMCHUi/VIlWrwuIzmWYtW
 KmgOnxuUSTEw8JnkGTQne7Ecxjlt54fiZnihw1YejjjczvI5Pf2zfP+edNtr3VKOIFAUX+u+c+G
 pLHIV
X-Gm-Gg: AeBDievsy3LB6CqSmK4QWaEnK8v4PUt00bQOJCRv/b9EqPh7/mIz1eAEfCuRxN/EzS7
 kxiVOTD8qTvEQmtu/nsJz6a7DrKbi6zYfQRr8s1aTDzVlGUcWaFyfDz8NvvFtHFRZQnu5Zw/pDr
 6t6OnG5mmNudVZ16rqVwsUvf6lriqo5B06K+3wonK6H59bQ5a1zVN2YnMLsquzbu5pfoBYr8vbw
 ZdPn0IUJlFdDMnlWvQ3PcoR63Ph9Ca3ZEueLWdE29Np3PTYFyX7DeEtPyrafO9B541ZTcklMgeB
 gUZNX5jY0hyLV4bxQoU0rtil48xMg3Zp9t1uMPsT/ICGiPVhoZEgYbPmFglLJP5CYyZ0Ua45Pfd
 3qxTgad4U1YutcA/7uMoEGXVYmEQ8h8WR2yV7PSOb9tr1kdInf9WIg4ExiZMH8lgOj4wO/a569x
 YGL97/4VqJGIYCFJb/JBpqfiPG6ZaiZjKm
X-Received: by 2002:a05:7022:90e:b0:128:d752:e074 with SMTP id
 a92af1059eb24-12bfb6e7b54mr7072575c88.1.1775533947231; 
 Mon, 06 Apr 2026 20:52:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 16/23] examples/qos_sched: eliminate shadowed variables
Date: Mon,  6 Apr 2026 20:49:42 -0700
Message-ID: <20260407035209.650419-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

The port_params and subport_params are global variables,
then passed to load functions. The names clash so just use
the globals.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/qos_sched/cfg_file.c  | 12 ++++++------
 examples/qos_sched/cfg_file.h  |  4 ++--
 examples/qos_sched/init.c      |  4 ++--
 examples/qos_sched/meson.build |  1 -
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/examples/qos_sched/cfg_file.c b/examples/qos_sched/cfg_file.c
index c75cf9db2e..3ca06c2ff9 100644
--- a/examples/qos_sched/cfg_file.c
+++ b/examples/qos_sched/cfg_file.c
@@ -41,20 +41,20 @@ int parse_u64(const char *entry, uint64_t *val)
 }
 
 int
-cfg_load_port(struct rte_cfgfile *cfg, struct rte_sched_port_params *port_params)
+cfg_load_port(struct rte_cfgfile *cfg)
 {
 	const char *entry;
 
-	if (!cfg || !port_params)
+	if (!cfg)
 		return -1;
 
 	entry = rte_cfgfile_get_entry(cfg, "port", "frame overhead");
 	if (entry)
-		port_params->frame_overhead = (uint32_t)atoi(entry);
+		port_params.frame_overhead = (uint32_t)atoi(entry);
 
 	entry = rte_cfgfile_get_entry(cfg, "port", "number of subports per port");
 	if (entry)
-		port_params->n_subports_per_port = (uint32_t)atoi(entry);
+		port_params.n_subports_per_port = (uint32_t)atoi(entry);
 
 	return 0;
 }
@@ -279,13 +279,13 @@ cfg_load_subport_profile(struct rte_cfgfile *cfg,
 }
 
 int
-cfg_load_subport(struct rte_cfgfile *cfg, struct rte_sched_subport_params *subport_params)
+cfg_load_subport(struct rte_cfgfile *cfg)
 {
 	bool cman_enabled = false;
 	const char *entry;
 	int i, j, k;
 
-	if (!cfg || !subport_params)
+	if (!cfg)
 		return -1;
 
 	memset(app_pipe_to_profile, -1, sizeof(app_pipe_to_profile));
diff --git a/examples/qos_sched/cfg_file.h b/examples/qos_sched/cfg_file.h
index 71d280718f..26552f1e30 100644
--- a/examples/qos_sched/cfg_file.h
+++ b/examples/qos_sched/cfg_file.h
@@ -10,11 +10,11 @@
 
 int parse_u64(const char *entry, uint64_t *val);
 
-int cfg_load_port(struct rte_cfgfile *cfg, struct rte_sched_port_params *port);
+int cfg_load_port(struct rte_cfgfile *cfg);
 
 int cfg_load_pipe(struct rte_cfgfile *cfg, struct rte_sched_pipe_params *pipe);
 
-int cfg_load_subport(struct rte_cfgfile *cfg, struct rte_sched_subport_params *subport);
+int cfg_load_subport(struct rte_cfgfile *cfg);
 
 int cfg_load_subport_profile(struct rte_cfgfile *cfg,
 			     struct rte_sched_subport_profile_params
diff --git a/examples/qos_sched/init.c b/examples/qos_sched/init.c
index ace7279c67..561f9e0619 100644
--- a/examples/qos_sched/init.c
+++ b/examples/qos_sched/init.c
@@ -296,11 +296,11 @@ app_load_cfg_profile(const char *profile)
 	if (file == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot load configuration profile %s\n", profile);
 
-	ret = cfg_load_port(file, &port_params);
+	ret = cfg_load_port(file);
 	if (ret)
 		goto _app_load_cfg_profile_error_return;
 
-	ret = cfg_load_subport(file, subport_params);
+	ret = cfg_load_subport(file);
 	if (ret)
 		goto _app_load_cfg_profile_error_return;
 
diff --git a/examples/qos_sched/meson.build b/examples/qos_sched/meson.build
index 4657c756a1..92657ce8a5 100644
--- a/examples/qos_sched/meson.build
+++ b/examples/qos_sched/meson.build
@@ -18,4 +18,3 @@ sources = files(
         'stats.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

