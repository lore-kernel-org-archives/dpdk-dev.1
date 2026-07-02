Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BDC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7AB402C5;
	Thu,  2 Jul 2026 10:57:46 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id DB8F340265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 10:57:44 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso3353759a12.0
 for <dev@dpdk.org>; Thu, 02 Jul 2026 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782982664; x=1783587464; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKy3JKwadC3J1LwaEaH9KPcZsVF8AXCIVMuNV5q5KhE=;
 b=d3On2tncasfoPa5+jNV436zPkN7Eau1GZdqyNJFPrDXYCXi72AXZRseTr61bIA4aJN
 XBHtwxMUJb8v6PespYgNYk7ioHJZBppw0JTF1PuCSDYIcq9qVZbYVf2Q+jP1ldLWOVKB
 8SprTT+1v7FHDbXqam+myiY0sSerGK6zsx8lY++TcgAB17bfZ1R7BFrrQjpilLYaMiXC
 RvPYx5X74hZB2FFbXrDI9y0MRnS1dVXh3riEVoDfW1RFEOhLnLocRFI8NIxZK53Irs+K
 5vATXOMfvrEE3RBDm80TcStVmM7rjov/7RwiX6j1UFfmH81aOlMPZ6UlHDMOHm7U5ZmG
 zxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982664; x=1783587464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKy3JKwadC3J1LwaEaH9KPcZsVF8AXCIVMuNV5q5KhE=;
 b=CUhYX87tm4zH8BNACdAqZfiNgSHEYlho2Z/BCAaGi1mCZwkopZmYe+eKrV6qrxIuO4
 NYKmadoDjMelzRzFyWCDMDOW48HdZ91N2kx6V3GaZpeM0dOci+nu20Ki+g+lnvDl6YLp
 qvYbJiiokNcot7TL+ICYc9tAYD5dWlZ6R1oGnHBqGpXwOt0j8seOnllGqkSl/QBQhB35
 qUnJ3xyEY6CWEPMfYnXqrXtY38sW4mnsiRZ+MTtRSjTcyRM5KceS3/ODx5C6AxVuznhI
 rWoU3Utf6U7CeHHipFQWBKQ34v2IbHQ7pcm+8bmFxVkAs3ZOrzRhViNbF4PlL4jI/2Fc
 fePQ==
X-Gm-Message-State: AOJu0YzYJBDmsNDjjDnH8ORDr6EY7JIEcL+FXKGv5pRv5Caq4TMO8xuz
 WO7h1PeI5Zye567DY0b6rLNekXtb9kHbuEcF7OdRvTGcx1796ojGo2H+
X-Gm-Gg: AfdE7clZxEd7UkL76AfwaMEK6q8wgp1Lg4h04cSQlqqfmNe3qPEn7+JjgZ+qJRWHBGj
 YRxPYvasyP0KtRODhT1ttaim0aOjSP5Sh9NyflM+ykXxRe06IW05fkAw6ikjxmJhC+YsXB1/6JF
 zCjh187grlcxzUvmka0q6UXjnyClbyYBmeHBptYqOqZXjb0U4lG8Xv5cD+vvuO2pHCAVo2TZr02
 3631nW19GmMnfXVpiYH7gDvXSmNe4elUkqTi7HXeaGDUkkDd7FaZQUTJbqOm7QuaZ5Qj8TASiTI
 peq+S6uBm+dK1u3NPl+8KEyPUkjtruFchCfJ+8Z0T0bNuuNesBgjFmZ9jxoZoAGANEJRhkd0oQW
 9ouikbOurxQlUFXZEXvW8BJZClNqbo/1cA5t/N74Dr5HbWGHLHGBgvCmumXNGSUVb5D4MlEp9MX
 0mUaLiheJDfSfj0IG1Etan0wScQUt96ZOvWFAkgR7xvZdlSV5WzjEKJSUX5tJDRplEpTbrejK+
X-Received: by 2002:a05:6402:50ce:b0:696:565:a9e7 with SMTP id
 4fb4d7f45d1cf-698a2c6d238mr1814459a12.9.1782982664043; 
 Thu, 02 Jul 2026 01:57:44 -0700 (PDT)
Received: from halsandi-l-pw05wngr.cisco.com
 ([2001:420:44f5:1250:f092:b1ed:acff:4627])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-698ace163adsm641829a12.4.2026.07.02.01.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:57:43 -0700 (PDT)
From: Hadi Sandid <hadisandid@gmail.com>
To: wisamm@nvidia.com
Cc: dev@dpdk.org,
	Hadi Sandid <hadisandid@gmail.com>
Subject: [PATCH v2] app/flow-perf: add represented-port/port-representor
 actions
Date: Thu,  2 Jul 2026 10:56:26 +0200
Message-ID: <20260702085626.465075-1-hadisandid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701150422.57359-1-hadisandid@gmail.com>
References: <20260701150422.57359-1-hadisandid@gmail.com>
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
v2:
  - use per-lcore port-action configurations during concurrent flow creation
  - clarify port redirection actions and destination option handling

 .mailmap                         |  1 +
 app/test-flow-perf/actions_gen.c | 46 ++++++++++++++++++++++++++++----
 app/test-flow-perf/main.c        | 31 ++++++++++++++++-----
 doc/guides/tools/flow-perf.rst   | 42 ++++++++++++++++++++++++-----
 4 files changed, 102 insertions(+), 18 deletions(-)

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
index 9d102e3af4..2a1fca9d7a 100644
--- a/app/test-flow-perf/actions_gen.c
+++ b/app/test-flow-perf/actions_gen.c
@@ -178,13 +178,41 @@ add_port_id(struct rte_flow_action *actions,
 	uint8_t actions_counter,
 	struct additional_para para)
 {
-	static struct rte_flow_action_port_id port_id = {
-		.id = PORT_ID_DST,
-	};
+	static alignas(RTE_CACHE_LINE_SIZE)
+	    struct rte_flow_action_port_id port_ids[RTE_MAX_LCORE];
+	uint8_t ti = para.core_idx;
 
-	port_id.id = para.dst_port;
+	port_ids[ti].id = para.dst_port;
 	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_PORT_ID;
-	actions[actions_counter].conf = &port_id;
+	actions[actions_counter].conf = &port_ids[ti];
+}
+
+static void
+add_represented_port(struct rte_flow_action *actions,
+	uint8_t actions_counter,
+	struct additional_para para)
+{
+	static alignas(RTE_CACHE_LINE_SIZE)
+	    struct rte_flow_action_ethdev represented_ports[RTE_MAX_LCORE];
+	uint8_t ti = para.core_idx;
+
+	represented_ports[ti].port_id = para.dst_port;
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT;
+	actions[actions_counter].conf = &represented_ports[ti];
+}
+
+static void
+add_port_representor(struct rte_flow_action *actions,
+	uint8_t actions_counter,
+	struct additional_para para)
+{
+	static alignas(RTE_CACHE_LINE_SIZE)
+	    struct rte_flow_action_ethdev port_representors[RTE_MAX_LCORE];
+	uint8_t ti = para.core_idx;
+
+	port_representors[ti].port_id = para.dst_port;
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR;
+	actions[actions_counter].conf = &port_representors[ti];
 }
 
 static void
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
index 6636d1517f..646caccfda 100644
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
@@ -913,14 +929,17 @@ args_parse(int argc, char **argv)
 					rte_exit(EXIT_FAILURE, "Invalid hairpin config mask\n");
 				hairpin_conf_mask = hp_conf;
 			}
-			if (strcmp(lgopts[opt_idx].name,
-					"port-id") == 0) {
+			if (strcmp(lgopts[opt_idx].name, "port-id") == 0 ||
+			    strcmp(lgopts[opt_idx].name, "represented-port") == 0 ||
+			    strcmp(lgopts[opt_idx].name, "port-representor") == 0) {
 				uint16_t port_idx = 0;
 
-				token = strtok(optarg, ",");
-				while (token != NULL) {
-					dst_ports[port_idx++] = atoi(token);
-					token = strtok(NULL, ",");
+				if (optarg != NULL) {
+					token = strtok(optarg, ",");
+					while (token != NULL) {
+						dst_ports[port_idx++] = atoi(token);
+						token = strtok(NULL, ",");
+					}
 				}
 			}
 			if (strcmp(lgopts[opt_idx].name, "rxq") == 0) {
diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index 657f06fec7..aecbb846e3 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -240,13 +240,41 @@ Items:
 Actions:
 
 *	``--port-id``
-	Add port redirection action to all flows actions.
-	Port redirection destination is defined in user_parameters.h
-	under PORT_ID_DST, default value = 1.
-
-       It can also has optional parameter like --port-id=N[,M] to
-       specify the destination port, the number of values should be
-       the same with number of set bits in portmask.
+	Add an action that redirects matching traffic to a DPDK port ID.
+	As this action is deprecated; prefer ``--represented-port`` or
+	``--port-representor`` for embedded-switch flows when supported by
+	the PMD.
+	Port redirection destination is defined in config.h under
+	PORT_ID_DST, default value = 1.
+
+       Without an argument, ``PORT_ID_DST`` is used for each source port.
+       With ``--port-id=N[,M]``, the values override the destination for
+       enabled source ports in ``--portmask`` order; provide one value for
+       each set bit in the port mask.
+
+*	``--represented-port``
+	At the embedded-switch level, add an action that redirects matching
+	traffic to the entity represented by the specified ethdev. Use this
+	action when the destination is the represented entity.
+	Port redirection destination is defined in config.h under
+	PORT_ID_DST, default value = 1.
+
+		Without an argument, ``PORT_ID_DST`` is used for each source port.
+		With ``--represented-port=N[,M]``, the values override the destination
+		for enabled source ports in ``--portmask`` order; provide one value
+		for each set bit in the port mask.
+
+*	``--port-representor``
+	At the embedded-switch level, add an action that redirects matching
+	traffic to the specified ethdev. Use this action when the destination
+	is the ethdev rather than the entity it represents.
+	Port redirection destination is defined in config.h under
+	PORT_ID_DST, default value = 1.
+
+		Without an argument, ``PORT_ID_DST`` is used for each source port.
+		With ``--port-representor=N[,M]``, the values override the destination
+		for enabled source ports in ``--portmask`` order; provide one value
+		for each set bit in the port mask.
 
 *	``--rss``
 	Add RSS action to all flows actions,
-- 
2.43.0

