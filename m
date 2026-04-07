Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F0FF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10F8040687;
	Tue,  7 Apr 2026 17:18:37 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 27A3140665
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:36 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so2355111a91.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575115;
 x=1776179915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HybjI3zVDQ9IPyJ10rdRl3tRuSk8dof3BPcL/9foi2U=;
 b=aX2Y0sLkUw5ZxSuYVF90qhWTOltV4JKscxF2wPMpj+aXR91Uh9f7uoibSc6979WDTR
 KbIzmKKlkZg3JgGGaEQNzmQYTPk3XE7ZjGMzpjGt0+Tqj/1IbU4oDB++BIgQMSupajSB
 DfDLquxfZBJyS0T04G/ZHFw6aXFSIdjKU8UDH7qd51WfzKAwMTUgJVwHE/0T+Y1LszGP
 PdX6Fw6Z5TsMd126F5NhMUsTYjuIzzlAWkxozLTxlUkz7sDxK03llyfnLaiQnlxunKLC
 O/BiOnrpWSArRHu43ySxWyoYowDZ6rR2lBl1uRbbWNH1u6GxTBOT/uSduL7D1dVymvus
 eePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575115; x=1776179915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HybjI3zVDQ9IPyJ10rdRl3tRuSk8dof3BPcL/9foi2U=;
 b=CEtMZFCbVOri9MdkmPams+bmWkNUd9dG1GJG/PLWzun7YDu0eOyJ3v5A6LG59tQHe+
 uYpG1f/7agqxJF1NM/7Y0E1vN89T7jKfUHmhiRM2sRnySOcbaMULgpAnDoAPyzfZ0iue
 yPziaME0bdiFHeV8KjNVMRbbJFp/N+/9fPCn6d7nm+lKBGHNU1mDSYVdNpDudWvrvyOt
 BkPluZsgYoX3u0B1wKaboBPitTi0UQFJujDrLRlIMRbAzhaCPDgr19K0r/4TS98jPKBV
 U3Z2QK/ThSMvRCwP8GBZCswLhdqADUz2y3Z3DCJfIBVvsy/jVo4FuwhZjB3IW5XErcu1
 gFEA==
X-Gm-Message-State: AOJu0YxOGDhkQ7mPio/ben5rlNtozHusXYM8aQQO3+AnNRNAXFu8lNNT
 cx+k8Dwv45CAgbaM40NVvjpVCa6pYwRTJJzSWO+IVbJcwQE1RMXXKRfwlkt5Erpytk3aGRJGZXb
 TejFH
X-Gm-Gg: AeBDievdFY8ESfKsCu9DOFIndmTq4IaLazSsQoiYJZYTTgHgpO1IB9yGmmcgmc+D11u
 368MyLhmrXzXdeuWVJsRmu0slQMY2BDc5Ko+PdZm1B7S/HYTYraaee+2iCq5HMf4vKds3GbGBt2
 GZqfmJPQS93EA5a8y0rKOdiqazxS7Hxn++/mrtqxPQdDGMk4nDPyQKSsWSWzEuT9vsFxNySBUWf
 MYi2HoMC8hTWTMsGmSJ+JIR+yE6FPj019cOikH0Kt3vmr4PzGVBhzLddNeyMXF9qFXODK6AU3KH
 s87Zn4UtANGA5d2AvQ/L8KNdaiFv/6NXUgX1RG6Naypt2e7frk7P1k3mQJcNo5x64Vk30MAlRCG
 KBEAdyFY0loweI/1cWIPMwMVWekwdBCFLNIWnz/VoRbiwUkvDLWfqhcaf94o1h413wz4mCIWMiH
 cyKRTn9bYNFw/YYTZtEOS03BUM5XToL1btizQM1H3m3G4=
X-Received: by 2002:a17:90b:48cb:b0:35d:9d7b:85ef with SMTP id
 98e67ed59e1d1-35dd677829fmr18706622a91.6.1775575114920; 
 Tue, 07 Apr 2026 08:18:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 16/23] examples/qos_sched: eliminate shadowed variables
Date: Tue,  7 Apr 2026 08:16:12 -0700
Message-ID: <20260407151732.272195-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

