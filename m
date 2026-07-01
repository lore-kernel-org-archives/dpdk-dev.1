Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B2BC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 15:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC5C640278;
	Wed,  1 Jul 2026 17:04:28 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id D0A5C4025F
 for <dev@dpdk.org>; Wed,  1 Jul 2026 17:04:26 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493ba729dbdso4018215e9.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782918266; x=1783523066; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CpQDLGp0/gEsFSO4+rj+F9L8RI7XeHVY29UwZaHQnC8=;
 b=SM4ixJZj1rLwEsOOzwT0L+f5HUjUnLFNsrmVNbWqkUW3TV3u0WcDJ27eRs7zdsHDaV
 4TydUfCA1OPWNZMq68dPPUTN4VswIZPVVO4lBrKcfTD+N7cvs2yvLXlPFWxSywaGAzjv
 RmjeE2cubhg3PqXaZz1XDozxKIVEhU4Zb6Ki21ZZSG7T1sGoMVktnp/IW2odTy6krBzT
 zlY2QCpClVZ3mtXSKnL0Z+5we2ecg2knYzot3c6lbK4Hq4cHx4ML/HOlRmm1eIoHcviz
 Sy1bS/2OVn1Cw2jYpvtZ72heoJecSOd1tI9Zz76zxXbPIw90Ci3YG4aYh+PENbIA/X1g
 rWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782918266; x=1783523066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpQDLGp0/gEsFSO4+rj+F9L8RI7XeHVY29UwZaHQnC8=;
 b=bkKhcwObJ0bMROF7CQSMnBM7Q6xNonIVt9TVj+0PezNnQS2PMTfeMn5QyJjn4G4qTd
 EK6/IbuGD+FLxvYIQ5lwEnJUOoYeajOoJTqBd32MScmILpSAwEkUtk6Nt1tLTIDYMIXN
 yLoQ3T5PKmPLl8Ec/7IoTmvz5tnlGZnAWUT7jmpjss44BSa29JqHz2ydxthvchVEAJGc
 3Ca5y0TpMtGPHMi5cH1V+lPyU0vqLAQ+sx8xNTX+I1hbiuqM6RW97e1FYQd+T0CvW+mg
 P2DV7xT718HW0gf6lZlDZnr1bRIJmLy0Kkjf4uJnh7RT48fBMHOw+CDySiyggeWE6lka
 wExA==
X-Gm-Message-State: AOJu0YyShB0hOGCLkxUETvbfYmymRrrBJ8UmO+p0qSeIuOwmDEZf2Yl3
 eZElUwCiGIlhKnkI6oCA63lzUePdFUfBA4w44DhcsmfThMgalEc0S2y6
X-Gm-Gg: AfdE7clm7bmx0tv4Iu+mTsB1EynJHI4bCCFqTYnXcCSx0jgoMVZnVmiR+rA2PxEwvfb
 9mXfwZYb689mUn5vAMg9DnUQp4Tmp0y6VKwNDpxCUK6LhEdrhLbrn5fM7AwlrmnTQCHtiOLe5xG
 TqfuEhoEQQ9zQ6CrWE6zOgrTq1g2xF2qcUO8P+JKmg90Nx+7KKnChMLarS3flZ8uD4lgNoRA1//
 2xaQiF815W2WWmhju3KB/ocx0Cy8pbclSMwHG4We6AIbB+JZhBG9oRlHtcs4o2MzoN3JxQJJrra
 dwNuEO0kIuIgPTrS88SQS0OOw5YHeg3eCBpn6JeiWMg14hmB09mr2+fUSQsHuljyAqJRUlOiLDc
 iFG6a5afaulnTMgW618AAcitDleHTYP0tRN7iwv3Ezx9yJDXbBiQ0GicNuaCU51vlqtQzZFEcoJ
 QZuyef6M47onYOZzio4+NaA1soejGFvsCHTgeuz4gLUb4+wMKHTmQwRzz77C4oMNPpTybKoLHAB
 TR6VMvppoaLU8jHKhLTYOZ0j2ywMubglhaSBDXEpmgDGV+M3xdgpdpOnnpHqm+inw==
X-Received: by 2002:a05:600c:83c8:b0:492:7101:3d88 with SMTP id
 5b1f17b1804b1-493c3cf47fcmr15301725e9.24.1782918265922; 
 Wed, 01 Jul 2026 08:04:25 -0700 (PDT)
Received: from halsandi-l-pw05wngr.home
 (2a01cb000100ec002ea2a9769e9ead15.ipv6.abo.wanadoo.fr.
 [2a01:cb00:100:ec00:2ea2:a976:9e9e:ad15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4bfdd5sm144151005e9.1.2026.07.01.08.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:04:25 -0700 (PDT)
From: Hadi Sandid <hadisandid@gmail.com>
To: wisamm@nvidia.com
Cc: dev@dpdk.org,
	Hadi Sandid <hadisandid@gmail.com>
Subject: [PATCH] app/flow-perf: add represented-port and port-representor flow
 actions
Date: Wed,  1 Jul 2026 17:04:22 +0200
Message-ID: <20260701150422.57359-1-hadisandid@gmail.com>
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

Add 'represented-port' and 'port-representor' action support,
and update documentation.

Signed-off-by: Hadi Sandid <hadisandid@gmail.com>
---
 .mailmap                         |  1 +
 app/test-flow-perf/actions_gen.c | 36 ++++++++++++++++++++++++++++++++
 app/test-flow-perf/main.c        | 21 +++++++++++++++++--
 doc/guides/tools/flow-perf.rst   | 20 ++++++++++++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index c5bc728fae..c51b14fbda 100644
--- a/.mailmap
+++ b/.mailmap
@@ -557,6 +557,7 @@ Guruprasad Rao <guruprasadx.rao@intel.com>
 Guy Kaneti <guyk@marvell.com>
 Guy Tzalik <gtzalik@amazon.com>
 H. Peter Anvin <hpa@linux.intel.com>
+Hadi Sandid <hadisandid@gmail.com>
 Haggai Eran <haggaie@nvidia.com>
 Haifei Luo <haifeil@nvidia.com>
 Haifeng Gao <gaohaifeng.gao@huawei.com>
diff --git a/app/test-flow-perf/actions_gen.c b/app/test-flow-perf/actions_gen.c
index 9d102e3af4..4a17349f92 100644
--- a/app/test-flow-perf/actions_gen.c
+++ b/app/test-flow-perf/actions_gen.c
@@ -187,6 +187,34 @@ add_port_id(struct rte_flow_action *actions,
 	actions[actions_counter].conf = &port_id;
 }
 
+static void
+add_represented_port(struct rte_flow_action *actions,
+	uint8_t actions_counter,
+	struct additional_para para)
+{
+	static struct rte_flow_action_ethdev represented_port = {
+		.port_id = PORT_ID_DST,
+	};
+
+	represented_port.port_id = para.dst_port;
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT;
+	actions[actions_counter].conf = &represented_port;
+}
+
+static void
+add_port_representor(struct rte_flow_action *actions,
+	uint8_t actions_counter,
+	struct additional_para para)
+{
+	static struct rte_flow_action_ethdev port_representor = {
+		.port_id = PORT_ID_DST,
+	};
+
+	port_representor.port_id = para.dst_port;
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR;
+	actions[actions_counter].conf = &port_representor;
+}
+
 static void
 add_drop(struct rte_flow_action *actions,
 	uint8_t actions_counter,
@@ -1102,6 +1130,14 @@ fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 			.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_PORT_ID),
 			.funct = add_port_id
 		},
+		{
+			.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT),
+			.funct = add_represented_port,
+		},
+		{
+			.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR),
+			.funct = add_port_representor,
+		},
 		{
 			.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DROP),
 			.funct = add_drop,
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 6636d1517f..8147d41d4b 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -267,6 +267,18 @@ static const struct option_dict {
 		.map = &flow_actions[0],
 		.map_idx = &actions_idx
 	},
+	{
+		.str = "represented-port",
+		.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT),
+		.map = &flow_actions[0],
+		.map_idx = &actions_idx
+	},
+	{
+		.str = "port-representor",
+		.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR),
+		.map = &flow_actions[0],
+		.map_idx = &actions_idx
+	},
 	{
 		.str = "rss",
 		.mask = FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_RSS),
@@ -542,6 +554,8 @@ usage(char *progname)
 
 	printf("To set flow actions:\n");
 	printf("  --port-id: add port-id action in flow actions\n");
+	printf("  --represented-port: add represented-port action in flow actions\n");
+	printf("  --port-representor: add port-representor action in flow actions\n");
 	printf("  --rss: add rss action in flow actions\n");
 	printf("  --queue: add queue action in flow actions\n");
 	printf("  --jump: add jump action in flow actions\n");
@@ -699,6 +713,8 @@ args_parse(int argc, char **argv)
 		{ "icmpv6",                     0, 0, 0 },
 		/* Actions */
 		{ "port-id",                    2, 0, 0 },
+		{ "represented-port",           2, 0, 0 },
+		{ "port-representor",           2, 0, 0 },
 		{ "rss",                        0, 0, 0 },
 		{ "queue",                      0, 0, 0 },
 		{ "jump",                       0, 0, 0 },
@@ -913,8 +929,9 @@ args_parse(int argc, char **argv)
 					rte_exit(EXIT_FAILURE, "Invalid hairpin config mask\n");
 				hairpin_conf_mask = hp_conf;
 			}
-			if (strcmp(lgopts[opt_idx].name,
-					"port-id") == 0) {
+			if (strcmp(lgopts[opt_idx].name, "port-id") == 0 ||
+			    strcmp(lgopts[opt_idx].name, "represented-port") == 0 ||
+			    strcmp(lgopts[opt_idx].name, "port-representor") == 0) {
 				uint16_t port_idx = 0;
 
 				token = strtok(optarg, ",");
diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index 657f06fec7..7f97a9940d 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -248,6 +248,26 @@ Actions:
        specify the destination port, the number of values should be
        the same with number of set bits in portmask.
 
+*	``--represented-port``
+	Add represented port redirection action to all flows actions.
+	Port redirection destination is defined in config.h under
+	PORT_ID_DST, default value = 1.
+
+		It can also have an optional parameter like
+		--represented-port=N[,M] to specify the destination port. The
+		number of values should be the same as the number of set bits in
+		portmask.
+
+*	``--port-representor``
+	Add port representor redirection action to all flows actions.
+	Port redirection destination is defined in config.h under
+	PORT_ID_DST, default value = 1.
+
+		It can also have an optional parameter like
+		--port-representor=N[,M] to specify the destination port. The
+		number of values should be the same as the number of set bits in
+		portmask.
+
 *	``--rss``
 	Add RSS action to all flows actions,
 	The queues in RSS action will be all queues configured
-- 
2.43.0

