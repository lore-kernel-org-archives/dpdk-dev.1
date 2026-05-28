Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC9CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AD6840649;
	Thu, 28 May 2026 23:38:24 +0200 (CEST)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50]) by mails.dpdk.org (Postfix) with ESMTP id 9C7B040661
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:22 +0200 (CEST)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66051672451so20908d50.3
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004302;
 x=1780609102; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxNSS8oZg1ar3oRXwPbTzI1y7hF0lDCVmPJnrViRYuE=;
 b=YKsXLL89na1Bvt4zalnQHBR3yLYelBm7TXWFXirdT8D6NnaHyb9bsU8H6RSeFA1bWB
 3jscZuLSMnvTVF4ZDxSegwS9G60dsIIA8gb6JpK2sW0y4gDJCg8eLZKfox9AxG+UmxMs
 ttYr6oquhOiliIiqi9LSzhx2bV9H46XJCmaIqvVP3v9VuLR4C9YAyuoHFtRp7451d+Lt
 j4/REX1892A/GTwoKM1PNJ6fxUfjc89hgFN0Sp6YjKEqGFE8N0stnznDAZplMTT9V3bM
 qCsb2PG8v4KenofrnM2jv+hSymWSky/0RM5rPFIRJfBphesArrbA4fQ/DS3Kv6YFo1NW
 HI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004302; x=1780609102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BxNSS8oZg1ar3oRXwPbTzI1y7hF0lDCVmPJnrViRYuE=;
 b=F0e8hb38nJ0PdJuNoM4EnkVPd+pyikdiDOhr1/4XGs3xJQk7JdpX9CB2gJiGGxETpS
 XeJJOybbY2K2WL1UB1MYVTWfyhBYCra9bhhbHCKcD/UU9t7UbJvKGM6UuJ1DPKFCGY4z
 Jsrby4iAbOizNMQ8ib8hm2K4Tle51oasIsEEZKdXCPQyiBFO9RZRIWy4kaRBRK4nVx+e
 /D7ydxKzuf5xE2mfR3RI1r0tMsF3/rJnLymm7UtQlPJBHPCv+OTFzqjY+WzbbR8t1Kot
 LXQPeqRTG92nkv04gOdsfPiCV8CcU/K19yOcyIasGz6DVSEjLV0NQGsNhW4ei3ftF6sV
 E7Sg==
X-Gm-Message-State: AOJu0YzHeOh4mezrjjpzktugMlRVXTR3IOOwPI7ctQ/ud2bp/JXbSasC
 GfzQD5UmdhXtXnmt5Gvt5G4JtUz+Y48SsYSmbmAdfYwOmVpQx2CrHEGq6gv8k5hoDNCJvbVxEAR
 p3pvs
X-Gm-Gg: Acq92OGKpyj2Gb8b7a+9kuqk6nLUyJnD4eFY9fXagAPKvwzGEWvj26Hgvm6CH6SvE8V
 2xQG3K2mpeVllVkrIfqXWsDbPv2wuZgvpuewjiw31PqoLUphG0zvDTvzUYN6CHHkTmh7Hx6voiM
 qRIm38TwSmbrL7sKHhkAHw52EPmmZYPrTSAuX1mpdJH2nY9+fTb+rfZXBVMfa7HtPoh/fp1Tp32
 hH4+MKRX6q+qkjWQGeUlEAOegJgYgtkGtZpYeMs2VZtBF22E+UiEX3Xpi+6SXiLTC8lSGpzrJhv
 HyNfiUnonQaD4LNAH62qsQXNGzbOLSrLI9/hQpDeQ98o7zwrlydceHomFx/bdEr7881FC5zv44T
 ImkOrIlp4eHblz4l1hWhXjwVVemz6lj1WeydNnxfoPvcpbPe6g0jCUQ9E4gYbh2i2tOgV1Hc1xm
 0KnWQbsz3ubs4t9XAspjqGsNztv3NHCWXDhveUjarAeX7EsDUtV5TWDA809bU3v/cuIRR4eK+Z
X-Received: by 2002:a05:690e:418d:b0:651:b2e4:63c1 with SMTP id
 956f58d0204a3-6604e59e882mr586747d50.22.1780004301824; 
 Thu, 28 May 2026 14:38:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 2/8] net/i40e: remove testpmd flow filter commands
Date: Thu, 28 May 2026 14:37:14 -0700
Message-ID: <20260528213816.562910-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528213816.562910-1-stephen@networkplumber.org>
References: <20260528213816.562910-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove the testpmd commands that drive the i40e PMD-private legacy
flow filter API, which is being deprecated in DPDK 26.07 and removed
in 26.11.

  flow_director_filter
        Drove rte_pmd_i40e_flow_add_del_packet_template().

  port config <port_id> pctype <pctype_id>
        hash_inset|fdir_inset|fdir_flx_inset get|set|clear field
  port config <port_id> pctype <pctype_id>
        hash_inset|fdir_inset|fdir_flx_inset clear all
        Drove the rte_pmd_i40e_inset_get/set and inset_field_*
        helpers.

  show port <port_id> pctype mapping
  port config <port_id> pctype mapping reset
  port config <port_id> pctype mapping update ...
        Drove rte_pmd_i40e_flow_type_mapping_get/reset/update().

The visually-similar "ptype mapping" commands (ptype mapping
get/replace/reset/update) are preserved — they drive the unrelated
rte_pmd_i40e_ptype_mapping_* DDP packet-type mapping API, which is
not in scope for this series. The naming collision between "pctype
mapping" (legacy flow-type mapping, removed here) and "ptype mapping"
(DDP packet-type mapping, kept) was a long-standing source of
confusion.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/i40e.rst              |  70 +--
 drivers/net/intel/i40e/i40e_testpmd.c | 642 --------------------------
 2 files changed, 4 insertions(+), 708 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index e67498aef4..0aae5b4d82 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -399,52 +399,6 @@ Add a rule to direct ``ipv4-udp`` packet whose ``dst_ip=2.2.2.5, src_ip=2.2.2.3,
             dst is 2.2.2.5 / udp src is 32 dst is 32 / end \
             actions mark id 1 / queue index 1 / end
 
-Check the flow director status:
-
-.. code-block:: console
-
-   testpmd> show port fdir 0
-
-   ######################## FDIR infos for port 0      ####################
-     MODE:   PERFECT
-     SUPPORTED FLOW TYPE:  ipv4-frag ipv4-tcp ipv4-udp ipv4-sctp ipv4-other
-                           ipv6-frag ipv6-tcp ipv6-udp ipv6-sctp ipv6-other
-			   l2_payload
-     FLEX PAYLOAD INFO:
-     max_len:	    16	        payload_limit: 480
-     payload_unit:  2	        payload_seg:   3
-     bitmask_unit:  2	        bitmask_num:   2
-     MASK:
-       vlan_tci: 0x0000,
-       src_ipv4: 0x00000000,
-       dst_ipv4: 0x00000000,
-       src_port: 0x0000,
-       dst_port: 0x0000
-       src_ipv6: 0x00000000,0x00000000,0x00000000,0x00000000,
-       dst_ipv6: 0x00000000,0x00000000,0x00000000,0x00000000
-     FLEX PAYLOAD SRC OFFSET:
-       L2_PAYLOAD:    0      1	    2	   3	  4	 5	6  ...
-       L3_PAYLOAD:    0      1	    2	   3	  4	 5	6  ...
-       L4_PAYLOAD:    0      1	    2	   3	  4	 5	6  ...
-     FLEX MASK CFG:
-       ipv4-udp:    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv4-tcp:    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv4-sctp:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv4-other:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv4-frag:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv6-udp:    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv6-tcp:    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv6-sctp:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv6-other:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       ipv6-frag:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-       l2_payload:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-     guarant_count: 1	        best_count:    0
-     guarant_space: 512         best_space:    7168
-     collision:     0	        free:	       0
-     maxhash:	    0	        maxlen:        0
-     add:	    0	        remove:        0
-     f_add:	    0	        f_remove:      0
-
 
 Floating VEB
 ~~~~~~~~~~~~~
@@ -613,19 +567,10 @@ Limitations or Known issues
 MPLS packet classification
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-For firmware versions prior to 5.0, MPLS packets are not recognized by the NIC.
-The L2 Payload flow type in flow director can be used to classify MPLS packet
-by using a command in testpmd like:
-
-   testpmd> flow_director_filter 0 mode IP add flow l2_payload ether \
-            0x8847 flexbytes () fwd pf queue <N> fd_id <M>
-
-With the NIC firmware version 5.0 or greater, some limited MPLS support
-is added: Native MPLS (MPLS in Ethernet) skip is implemented, while no
-new packet type, no classification or offload are possible. With this change,
-L2 Payload flow type in flow director cannot be used to classify MPLS packet
-as with previous firmware versions. Meanwhile, the Ethertype filter can be
-used to classify MPLS packet by using a command in testpmd like:
+With NIC firmware version 5.0 or greater, native MPLS (MPLS in
+Ethernet) skip is implemented, although no new packet type, no
+classification, and no offload are possible.
+The Ethertype filter can be used to classify MPLS packets via testpmd::
 
    testpmd> flow create 0 ingress pattern eth type is 0x8847 / end \
             actions queue index <M> / end
@@ -878,13 +823,6 @@ Reset ptype mapping table::
 
    testpmd> ptype mapping reset (port_id)
 
-show port pctype mapping
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-List all items from the pctype mapping table::
-
-   testpmd> show port (port_id) pctype mapping
-
 High Performance of Small Packets on 40GbE NIC
 ----------------------------------------------
 
diff --git a/drivers/net/intel/i40e/i40e_testpmd.c b/drivers/net/intel/i40e/i40e_testpmd.c
index 21f596297b..3943287ca9 100644
--- a/drivers/net/intel/i40e/i40e_testpmd.c
+++ b/drivers/net/intel/i40e/i40e_testpmd.c
@@ -464,149 +464,6 @@ static cmdline_parse_inst_t cmd_show_queue_region_info_all = {
 	},
 };
 
-/* *** deal with flow director filter *** */
-struct cmd_flow_director_result {
-	cmdline_fixed_string_t flow_director_filter;
-	portid_t port_id;
-	cmdline_fixed_string_t mode;
-	cmdline_fixed_string_t mode_value;
-	cmdline_fixed_string_t ops;
-	cmdline_fixed_string_t flow;
-	cmdline_fixed_string_t flow_type;
-	cmdline_fixed_string_t drop;
-	cmdline_fixed_string_t queue;
-	uint16_t queue_id;
-	cmdline_fixed_string_t fd_id;
-	uint32_t fd_id_value;
-	cmdline_fixed_string_t packet;
-	char filepath[];
-};
-
-static void
-cmd_flow_director_filter_parsed(void *parsed_result,
-	__rte_unused struct cmdline *cl, __rte_unused void *data)
-{
-	struct cmd_flow_director_result *res = parsed_result;
-	int ret = 0;
-	struct rte_pmd_i40e_flow_type_mapping
-			mapping[RTE_PMD_I40E_FLOW_TYPE_MAX];
-	struct rte_pmd_i40e_pkt_template_conf conf;
-	uint16_t flow_type = str_to_flowtype(res->flow_type);
-	uint16_t i, port = res->port_id;
-	uint8_t add;
-
-	memset(&conf, 0, sizeof(conf));
-
-	if (flow_type == RTE_ETH_FLOW_UNKNOWN) {
-		fprintf(stderr, "Invalid flow type specified.\n");
-		return;
-	}
-	ret = rte_pmd_i40e_flow_type_mapping_get(res->port_id,
-						 mapping);
-	if (ret)
-		return;
-	if (mapping[flow_type].pctype == 0ULL) {
-		fprintf(stderr, "Invalid flow type specified.\n");
-		return;
-	}
-	for (i = 0; i < RTE_PMD_I40E_PCTYPE_MAX; i++) {
-		if (mapping[flow_type].pctype & (1ULL << i)) {
-			conf.input.pctype = i;
-			break;
-		}
-	}
-
-	conf.input.packet = open_file(res->filepath,
-				&conf.input.length);
-	if (!conf.input.packet)
-		return;
-	if (!strcmp(res->drop, "drop"))
-		conf.action.behavior =
-			RTE_PMD_I40E_PKT_TEMPLATE_REJECT;
-	else
-		conf.action.behavior =
-			RTE_PMD_I40E_PKT_TEMPLATE_ACCEPT;
-	conf.action.report_status =
-			RTE_PMD_I40E_PKT_TEMPLATE_REPORT_ID;
-	conf.action.rx_queue = res->queue_id;
-	conf.soft_id = res->fd_id_value;
-	add = strcmp(res->ops, "del") ? 1 : 0;
-	ret = rte_pmd_i40e_flow_add_del_packet_template(port,
-							&conf,
-							add);
-	if (ret < 0)
-		fprintf(stderr, "flow director config error: (%s)\n",
-			strerror(-ret));
-	close_file(conf.input.packet);
-}
-
-static cmdline_parse_token_string_t cmd_flow_director_filter =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		flow_director_filter, "flow_director_filter");
-static cmdline_parse_token_num_t cmd_flow_director_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_flow_director_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_flow_director_ops =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		ops, "add#del#update");
-static cmdline_parse_token_string_t cmd_flow_director_flow =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		flow, "flow");
-static cmdline_parse_token_string_t cmd_flow_director_flow_type =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		flow_type, NULL);
-static cmdline_parse_token_string_t cmd_flow_director_drop =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		drop, "drop#fwd");
-static cmdline_parse_token_string_t cmd_flow_director_queue =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		queue, "queue");
-static cmdline_parse_token_num_t cmd_flow_director_queue_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_flow_director_result,
-		queue_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_flow_director_fd_id =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		fd_id, "fd_id");
-static cmdline_parse_token_num_t cmd_flow_director_fd_id_value =
-	TOKEN_NUM_INITIALIZER(struct cmd_flow_director_result,
-		fd_id_value, RTE_UINT32);
-static cmdline_parse_token_string_t cmd_flow_director_mode =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		mode, "mode");
-static cmdline_parse_token_string_t cmd_flow_director_mode_raw =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		mode_value, "raw");
-static cmdline_parse_token_string_t cmd_flow_director_packet =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		packet, "packet");
-static cmdline_parse_token_string_t cmd_flow_director_filepath =
-	TOKEN_STRING_INITIALIZER(struct cmd_flow_director_result,
-		filepath, NULL);
-
-static cmdline_parse_inst_t cmd_add_del_raw_flow_director = {
-	.f = cmd_flow_director_filter_parsed,
-	.data = NULL,
-	.help_str = "flow_director_filter ... : Add or delete a raw flow "
-		"director entry on NIC",
-	.tokens = {
-		(void *)&cmd_flow_director_filter,
-		(void *)&cmd_flow_director_port_id,
-		(void *)&cmd_flow_director_mode,
-		(void *)&cmd_flow_director_mode_raw,
-		(void *)&cmd_flow_director_ops,
-		(void *)&cmd_flow_director_flow,
-		(void *)&cmd_flow_director_flow_type,
-		(void *)&cmd_flow_director_drop,
-		(void *)&cmd_flow_director_queue,
-		(void *)&cmd_flow_director_queue_id,
-		(void *)&cmd_flow_director_fd_id,
-		(void *)&cmd_flow_director_fd_id_value,
-		(void *)&cmd_flow_director_packet,
-		(void *)&cmd_flow_director_filepath,
-		NULL,
-	},
-};
-
 /* VF unicast promiscuous mode configuration */
 
 /* Common result structure for VF unicast promiscuous mode */
@@ -1670,469 +1527,6 @@ static cmdline_parse_inst_t cmd_ddp_get_list = {
 	},
 };
 
-/* Configure input set */
-struct cmd_cfg_input_set_result {
-	cmdline_fixed_string_t port;
-	cmdline_fixed_string_t cfg;
-	portid_t port_id;
-	cmdline_fixed_string_t pctype;
-	uint8_t pctype_id;
-	cmdline_fixed_string_t inset_type;
-	cmdline_fixed_string_t opt;
-	cmdline_fixed_string_t field;
-	uint8_t field_idx;
-};
-
-static void
-cmd_cfg_input_set_parsed(__rte_unused void *parsed_result,
-	__rte_unused struct cmdline *cl,
-	__rte_unused void *data)
-{
-	struct cmd_cfg_input_set_result *res = parsed_result;
-	enum rte_pmd_i40e_inset_type inset_type = INSET_NONE;
-	struct rte_pmd_i40e_inset inset;
-	int ret = -ENOTSUP;
-
-	if (!all_ports_stopped()) {
-		fprintf(stderr, "Please stop all ports first\n");
-		return;
-	}
-
-	if (!strcmp(res->inset_type, "hash_inset"))
-		inset_type = INSET_HASH;
-	else if (!strcmp(res->inset_type, "fdir_inset"))
-		inset_type = INSET_FDIR;
-	else if (!strcmp(res->inset_type, "fdir_flx_inset"))
-		inset_type = INSET_FDIR_FLX;
-	ret = rte_pmd_i40e_inset_get(res->port_id, res->pctype_id, &inset, inset_type);
-	if (ret) {
-		fprintf(stderr, "Failed to get input set.\n");
-		return;
-	}
-
-	if (!strcmp(res->opt, "get")) {
-		ret = rte_pmd_i40e_inset_field_get(inset.inset, res->field_idx);
-		if (ret)
-			printf("Field index %d is enabled.\n", res->field_idx);
-		else
-			printf("Field index %d is disabled.\n", res->field_idx);
-		return;
-	}
-
-	if (!strcmp(res->opt, "set"))
-		ret = rte_pmd_i40e_inset_field_set(&inset.inset, res->field_idx);
-	else if (!strcmp(res->opt, "clear"))
-		ret = rte_pmd_i40e_inset_field_clear(&inset.inset, res->field_idx);
-	if (ret) {
-		fprintf(stderr, "Failed to configure input set field.\n");
-		return;
-	}
-
-	ret = rte_pmd_i40e_inset_set(res->port_id, res->pctype_id, &inset, inset_type);
-	if (ret) {
-		fprintf(stderr, "Failed to set input set.\n");
-		return;
-	}
-
-	if (ret == -ENOTSUP)
-		fprintf(stderr, "Function not supported\n");
-}
-
-static cmdline_parse_token_string_t cmd_cfg_input_set_port =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		port, "port");
-static cmdline_parse_token_string_t cmd_cfg_input_set_cfg =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		cfg, "config");
-static cmdline_parse_token_num_t cmd_cfg_input_set_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_cfg_input_set_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_cfg_input_set_pctype =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		pctype, "pctype");
-static cmdline_parse_token_num_t cmd_cfg_input_set_pctype_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_cfg_input_set_result,
-		pctype_id, RTE_UINT8);
-static cmdline_parse_token_string_t cmd_cfg_input_set_inset_type =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		inset_type, "hash_inset#fdir_inset#fdir_flx_inset");
-static cmdline_parse_token_string_t cmd_cfg_input_set_opt =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		opt, "get#set#clear");
-static cmdline_parse_token_string_t cmd_cfg_input_set_field =
-	TOKEN_STRING_INITIALIZER(struct cmd_cfg_input_set_result,
-		field, "field");
-static cmdline_parse_token_num_t cmd_cfg_input_set_field_idx =
-	TOKEN_NUM_INITIALIZER(struct cmd_cfg_input_set_result,
-		field_idx, RTE_UINT8);
-
-static cmdline_parse_inst_t cmd_cfg_input_set = {
-	.f = cmd_cfg_input_set_parsed,
-	.data = NULL,
-	.help_str = "port config <port_id> pctype <pctype_id> hash_inset|"
-		"fdir_inset|fdir_flx_inset get|set|clear field <field_idx>",
-	.tokens = {
-		(void *)&cmd_cfg_input_set_port,
-		(void *)&cmd_cfg_input_set_cfg,
-		(void *)&cmd_cfg_input_set_port_id,
-		(void *)&cmd_cfg_input_set_pctype,
-		(void *)&cmd_cfg_input_set_pctype_id,
-		(void *)&cmd_cfg_input_set_inset_type,
-		(void *)&cmd_cfg_input_set_opt,
-		(void *)&cmd_cfg_input_set_field,
-		(void *)&cmd_cfg_input_set_field_idx,
-		NULL,
-	},
-};
-
-/* Clear input set */
-struct cmd_clear_input_set_result {
-	cmdline_fixed_string_t port;
-	cmdline_fixed_string_t cfg;
-	portid_t port_id;
-	cmdline_fixed_string_t pctype;
-	uint8_t pctype_id;
-	cmdline_fixed_string_t inset_type;
-	cmdline_fixed_string_t clear;
-	cmdline_fixed_string_t all;
-};
-
-static void
-cmd_clear_input_set_parsed(__rte_unused void *parsed_result,
-	__rte_unused struct cmdline *cl,
-	__rte_unused void *data)
-{
-	struct cmd_clear_input_set_result *res = parsed_result;
-	enum rte_pmd_i40e_inset_type inset_type = INSET_NONE;
-	struct rte_pmd_i40e_inset inset;
-	int ret = -ENOTSUP;
-
-	if (!all_ports_stopped()) {
-		fprintf(stderr, "Please stop all ports first\n");
-		return;
-	}
-
-	if (!strcmp(res->inset_type, "hash_inset"))
-		inset_type = INSET_HASH;
-	else if (!strcmp(res->inset_type, "fdir_inset"))
-		inset_type = INSET_FDIR;
-	else if (!strcmp(res->inset_type, "fdir_flx_inset"))
-		inset_type = INSET_FDIR_FLX;
-
-	memset(&inset, 0, sizeof(inset));
-
-	ret = rte_pmd_i40e_inset_set(res->port_id, res->pctype_id, &inset, inset_type);
-	if (ret) {
-		fprintf(stderr, "Failed to clear input set.\n");
-		return;
-	}
-
-	if (ret == -ENOTSUP)
-		fprintf(stderr, "Function not supported\n");
-}
-
-static cmdline_parse_token_string_t cmd_clear_input_set_port =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		port, "port");
-static cmdline_parse_token_string_t cmd_clear_input_set_cfg =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		cfg, "config");
-static cmdline_parse_token_num_t cmd_clear_input_set_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_clear_input_set_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_clear_input_set_pctype =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		pctype, "pctype");
-static cmdline_parse_token_num_t cmd_clear_input_set_pctype_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_clear_input_set_result,
-		pctype_id, RTE_UINT8);
-static cmdline_parse_token_string_t cmd_clear_input_set_inset_type =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		inset_type, "hash_inset#fdir_inset#fdir_flx_inset");
-static cmdline_parse_token_string_t cmd_clear_input_set_clear =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		clear, "clear");
-static cmdline_parse_token_string_t cmd_clear_input_set_all =
-	TOKEN_STRING_INITIALIZER(struct cmd_clear_input_set_result,
-		all, "all");
-
-static cmdline_parse_inst_t cmd_clear_input_set = {
-	.f = cmd_clear_input_set_parsed,
-	.data = NULL,
-	.help_str = "port config <port_id> pctype <pctype_id> hash_inset|"
-		"fdir_inset|fdir_flx_inset clear all",
-	.tokens = {
-		(void *)&cmd_clear_input_set_port,
-		(void *)&cmd_clear_input_set_cfg,
-		(void *)&cmd_clear_input_set_port_id,
-		(void *)&cmd_clear_input_set_pctype,
-		(void *)&cmd_clear_input_set_pctype_id,
-		(void *)&cmd_clear_input_set_inset_type,
-		(void *)&cmd_clear_input_set_clear,
-		(void *)&cmd_clear_input_set_all,
-		NULL,
-	},
-};
-
-/* port config pctype mapping reset */
-
-/* Common result structure for port config pctype mapping reset */
-struct cmd_pctype_mapping_reset_result {
-	cmdline_fixed_string_t port;
-	cmdline_fixed_string_t config;
-	portid_t port_id;
-	cmdline_fixed_string_t pctype;
-	cmdline_fixed_string_t mapping;
-	cmdline_fixed_string_t reset;
-};
-
-/* Common CLI fields for port config pctype mapping reset*/
-static cmdline_parse_token_string_t cmd_pctype_mapping_reset_port =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		port, "port");
-static cmdline_parse_token_string_t cmd_pctype_mapping_reset_config =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		config, "config");
-static cmdline_parse_token_num_t cmd_pctype_mapping_reset_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_pctype_mapping_reset_pctype =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		pctype, "pctype");
-static cmdline_parse_token_string_t cmd_pctype_mapping_reset_mapping =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		mapping, "mapping");
-static cmdline_parse_token_string_t cmd_pctype_mapping_reset_reset =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_reset_result,
-		reset, "reset");
-
-static void
-cmd_pctype_mapping_reset_parsed(void *parsed_result,
-	__rte_unused struct cmdline *cl,
-	__rte_unused void *data)
-{
-	struct cmd_pctype_mapping_reset_result *res = parsed_result;
-	int ret = -ENOTSUP;
-
-	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
-		return;
-
-	ret = rte_pmd_i40e_flow_type_mapping_reset(res->port_id);
-	switch (ret) {
-	case 0:
-		break;
-	case -ENODEV:
-		fprintf(stderr, "invalid port_id %d\n", res->port_id);
-		break;
-	case -ENOTSUP:
-		fprintf(stderr, "function not implemented\n");
-		break;
-	default:
-		fprintf(stderr, "programming error: (%s)\n", strerror(-ret));
-	}
-}
-
-static cmdline_parse_inst_t cmd_pctype_mapping_reset = {
-	.f = cmd_pctype_mapping_reset_parsed,
-	.data = NULL,
-	.help_str = "port config <port_id> pctype mapping reset",
-	.tokens = {
-		(void *)&cmd_pctype_mapping_reset_port,
-		(void *)&cmd_pctype_mapping_reset_config,
-		(void *)&cmd_pctype_mapping_reset_port_id,
-		(void *)&cmd_pctype_mapping_reset_pctype,
-		(void *)&cmd_pctype_mapping_reset_mapping,
-		(void *)&cmd_pctype_mapping_reset_reset,
-		NULL,
-	},
-};
-
-/* show port pctype mapping */
-
-/* Common result structure for show port pctype mapping */
-struct cmd_pctype_mapping_get_result {
-	cmdline_fixed_string_t show;
-	cmdline_fixed_string_t port;
-	portid_t port_id;
-	cmdline_fixed_string_t pctype;
-	cmdline_fixed_string_t mapping;
-};
-
-/* Common CLI fields for pctype mapping get */
-static cmdline_parse_token_string_t cmd_pctype_mapping_get_show =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_get_result,
-		show, "show");
-static cmdline_parse_token_string_t cmd_pctype_mapping_get_port =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_get_result,
-		port, "port");
-static cmdline_parse_token_num_t cmd_pctype_mapping_get_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_pctype_mapping_get_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_pctype_mapping_get_pctype =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_get_result,
-		pctype, "pctype");
-static cmdline_parse_token_string_t cmd_pctype_mapping_get_mapping =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_get_result,
-		mapping, "mapping");
-
-static void
-cmd_pctype_mapping_get_parsed(void *parsed_result,
-	__rte_unused struct cmdline *cl,
-	__rte_unused void *data)
-{
-	struct cmd_pctype_mapping_get_result *res = parsed_result;
-	int ret = -ENOTSUP;
-	struct rte_pmd_i40e_flow_type_mapping
-				mapping[RTE_PMD_I40E_FLOW_TYPE_MAX];
-	int i, j, first_pctype;
-
-	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
-		return;
-
-	ret = rte_pmd_i40e_flow_type_mapping_get(res->port_id, mapping);
-	switch (ret) {
-	case 0:
-		break;
-	case -ENODEV:
-		fprintf(stderr, "invalid port_id %d\n", res->port_id);
-		return;
-	case -ENOTSUP:
-		fprintf(stderr, "function not implemented\n");
-		return;
-	default:
-		fprintf(stderr, "programming error: (%s)\n", strerror(-ret));
-		return;
-	}
-
-	for (i = 0; i < RTE_PMD_I40E_FLOW_TYPE_MAX; i++) {
-		if (mapping[i].pctype != 0ULL) {
-			first_pctype = 1;
-
-			printf("pctype: ");
-			for (j = 0; j < RTE_PMD_I40E_PCTYPE_MAX; j++) {
-				if (mapping[i].pctype & (1ULL << j)) {
-					printf(first_pctype ?  "%02d" : ",%02d", j);
-					first_pctype = 0;
-				}
-			}
-			printf("  ->  flowtype: %02d\n", mapping[i].flow_type);
-		}
-	}
-}
-
-static cmdline_parse_inst_t cmd_pctype_mapping_get = {
-	.f = cmd_pctype_mapping_get_parsed,
-	.data = NULL,
-	.help_str = "show port <port_id> pctype mapping",
-	.tokens = {
-		(void *)&cmd_pctype_mapping_get_show,
-		(void *)&cmd_pctype_mapping_get_port,
-		(void *)&cmd_pctype_mapping_get_port_id,
-		(void *)&cmd_pctype_mapping_get_pctype,
-		(void *)&cmd_pctype_mapping_get_mapping,
-		NULL,
-	},
-};
-
-/* port config pctype mapping update */
-
-/* Common result structure for port config pctype mapping update */
-struct cmd_pctype_mapping_update_result {
-	cmdline_fixed_string_t port;
-	cmdline_fixed_string_t config;
-	portid_t port_id;
-	cmdline_fixed_string_t pctype;
-	cmdline_fixed_string_t mapping;
-	cmdline_fixed_string_t update;
-	cmdline_fixed_string_t pctype_list;
-	uint16_t flow_type;
-};
-
-/* Common CLI fields for pctype mapping update*/
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_port =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		port, "port");
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_config =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		config, "config");
-static cmdline_parse_token_num_t cmd_pctype_mapping_update_port_id =
-	TOKEN_NUM_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		port_id, RTE_UINT16);
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_pctype =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		pctype, "pctype");
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_mapping =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		mapping, "mapping");
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_update =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		update, "update");
-static cmdline_parse_token_string_t cmd_pctype_mapping_update_pc_type =
-	TOKEN_STRING_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		pctype_list, NULL);
-static cmdline_parse_token_num_t cmd_pctype_mapping_update_flow_type =
-	TOKEN_NUM_INITIALIZER(struct cmd_pctype_mapping_update_result,
-		flow_type, RTE_UINT16);
-
-static void
-cmd_pctype_mapping_update_parsed(void *parsed_result,
-	__rte_unused struct cmdline *cl,
-	__rte_unused void *data)
-{
-	struct cmd_pctype_mapping_update_result *res = parsed_result;
-	int ret = -ENOTSUP;
-	struct rte_pmd_i40e_flow_type_mapping mapping;
-	unsigned int i;
-	unsigned int nb_item;
-	unsigned int pctype_list[RTE_PMD_I40E_PCTYPE_MAX];
-
-	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
-		return;
-
-	nb_item = parse_item_list(res->pctype_list, "pctypes", RTE_PMD_I40E_PCTYPE_MAX,
-		pctype_list, 1);
-	mapping.flow_type = res->flow_type;
-	for (i = 0, mapping.pctype = 0ULL; i < nb_item; i++)
-		mapping.pctype |= (1ULL << pctype_list[i]);
-	ret = rte_pmd_i40e_flow_type_mapping_update(res->port_id,
-						&mapping,
-						1,
-						0);
-	switch (ret) {
-	case 0:
-		break;
-	case -EINVAL:
-		fprintf(stderr, "invalid pctype or flow type\n");
-		break;
-	case -ENODEV:
-		fprintf(stderr, "invalid port_id %d\n", res->port_id);
-		break;
-	case -ENOTSUP:
-		fprintf(stderr, "function not implemented\n");
-		break;
-	default:
-		fprintf(stderr, "programming error: (%s)\n", strerror(-ret));
-	}
-}
-
-static cmdline_parse_inst_t cmd_pctype_mapping_update = {
-	.f = cmd_pctype_mapping_update_parsed,
-	.data = NULL,
-	.help_str = "port config <port_id> pctype mapping update"
-	" <pctype_id_0,[pctype_id_1]*> <flowtype_id>",
-	.tokens = {
-		(void *)&cmd_pctype_mapping_update_port,
-		(void *)&cmd_pctype_mapping_update_config,
-		(void *)&cmd_pctype_mapping_update_port_id,
-		(void *)&cmd_pctype_mapping_update_pctype,
-		(void *)&cmd_pctype_mapping_update_mapping,
-		(void *)&cmd_pctype_mapping_update_update,
-		(void *)&cmd_pctype_mapping_update_pc_type,
-		(void *)&cmd_pctype_mapping_update_flow_type,
-		NULL,
-	},
-};
-
 /* ptype mapping get */
 
 /* Common result structure for ptype mapping get */
@@ -2553,13 +1947,6 @@ static struct testpmd_driver_commands i40e_cmds = {
 		"show port (port_id) queue-region\n"
 		"    show all queue region related configuration info\n",
 	},
-	{
-		&cmd_add_del_raw_flow_director,
-		"flow_director_filter (port_id) mode raw (add|del|update)"
-		" flow (flow_id) (drop|fwd) queue (queue_id)"
-		" fd_id (fd_id_value) packet (packet file name)\n"
-		"    Add/Del a raw type flow director filter.\n",
-	},
 	{
 		&cmd_set_vf_promisc,
 		"set vf promisc (port_id) (vf_id) (on|off)\n"
@@ -2620,19 +2007,6 @@ static struct testpmd_driver_commands i40e_cmds = {
 		"ddp get info (profile_path)\n"
 		"    Get ddp profile information.\n",
 	},
-	{
-		&cmd_cfg_input_set,
-		"port config (port_id) pctype (pctype_id) hash_inset|"
-		"fdir_inset|fdir_flx_inset get|set|clear field\n"
-		" (field_idx)\n"
-		"    Configure RSS|FDIR|FDIR_FLX input set for some pctype\n",
-	},
-	{
-		&cmd_clear_input_set,
-		"port config (port_id) pctype (pctype_id) hash_inset|"
-		"fdir_inset|fdir_flx_inset clear all\n"
-		"    Clear RSS|FDIR|FDIR_FLX input set completely for some pctype\n",
-	},
 	{
 		&cmd_ptype_mapping_get,
 		"ptype mapping get (port_id) (valid_only)\n"
@@ -2653,22 +2027,6 @@ static struct testpmd_driver_commands i40e_cmds = {
 		"ptype mapping update (port_id) (hw_ptype) (sw_ptype)\n"
 		"    Update a ptype mapping item on a port\n",
 	},
-	{
-		&cmd_pctype_mapping_get,
-		"show port (port_id) pctype mapping\n"
-		"    Get flow ptype to pctype mapping on a port\n",
-	},
-	{
-		&cmd_pctype_mapping_reset,
-		"port config (port_id) pctype mapping reset\n"
-		"    Reset flow type to pctype mapping on a port\n",
-	},
-	{
-		&cmd_pctype_mapping_update,
-		"port config (port_id) pctype mapping update"
-		" (pctype_id_0[,pctype_id_1]*) (flow_type_id)\n"
-		"    Update a flow type to pctype mapping item on a port\n",
-	},
 	{
 		&cmd_config_src_prune_all,
 		"port config all i40e_src_prune (on|off)\n"
-- 
2.53.0

