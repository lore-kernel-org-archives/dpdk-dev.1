Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFFC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA65140E3B;
	Tue,  4 Feb 2025 17:23:00 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0CC7D402E6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C8337210C338; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C8337210C338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686167;
 bh=R3V4XamouzonlE20qOkBxm8ebIicgN8hHsgTyx8pLrg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XkO0m/0qOZXFeWHMODqRnYu8C8OqIePgCrrPSyDt/nijrSj9PGQmOZWrf4dKsRtYz
 c4fsk4ruVxI68qkTau0xhqwi+Td02RPHScvMPd27LDqrPTd+bgJUNZBKGxVSaNxeF6
 GNfYR0Hi3ZDkYfIN2lWH/41ckIeK+dx4tWjXGV5o=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v20 12/27] app/testpmd: remove use of VLAs for Windows built
Date: Tue,  4 Feb 2025 08:21:49 -0800
Message-Id: <1738686124-16173-13-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c      |  2 +-
 app/test-pmd/cmdline_flow.c | 15 ++++++++++-----
 app/test-pmd/config.c       | 16 +++++++++-------
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7e0666e9f6..2897e44c34 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13274,7 +13274,7 @@ cmd_set_port_ptypes_parsed(
 		return;
 	}
 
-	uint32_t ptypes[ret];
+	uint32_t *ptypes = alloca(sizeof(uint32_t) * ret);
 
 	ret = rte_eth_dev_set_ptypes(port_id, ptype_mask, ptypes, ret);
 	if (ret < 0) {
diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 9e4fc2d95d..e1720e54d7 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -11707,8 +11707,7 @@ parse_hex(struct context *ctx, const struct token *token,
 	char tmp[16]; /* Ought to be enough. */
 	int ret;
 	unsigned int hexlen = len;
-	unsigned int length = 256;
-	uint8_t hex_tmp[length];
+	uint8_t hex_tmp[256];
 
 	/* Arguments are expected. */
 	if (!arg_data)
@@ -11735,7 +11734,7 @@ parse_hex(struct context *ctx, const struct token *token,
 		str += 2;
 		hexlen -= 2;
 	}
-	if (hexlen > length)
+	if (hexlen > RTE_DIM(hex_tmp))
 		goto error;
 	ret = parse_hex_string(str, hex_tmp, &hexlen);
 	if (ret < 0)
@@ -11868,10 +11867,13 @@ parse_ipv4_addr(struct context *ctx, const struct token *token,
 		void *buf, unsigned int size)
 {
 	const struct arg *arg = pop_args(ctx);
-	char str2[len + 1];
+	char str2[INET_ADDRSTRLEN];
 	struct in_addr tmp;
 	int ret;
 
+	/* Length is longer than the max length an IPv4 address can have. */
+	if (len >= INET_ADDRSTRLEN)
+		return -1;
 	/* Argument is expected. */
 	if (!arg)
 		return -1;
@@ -11914,11 +11916,14 @@ parse_ipv6_addr(struct context *ctx, const struct token *token,
 		void *buf, unsigned int size)
 {
 	const struct arg *arg = pop_args(ctx);
-	char str2[len + 1];
+	char str2[INET6_ADDRSTRLEN];
 	struct rte_ipv6_addr tmp;
 	int ret;
 
 	(void)token;
+	/* Length is longer than the max length an IPv6 address can have. */
+	if (len >= INET6_ADDRSTRLEN)
+		return -1;
 	/* Argument is expected. */
 	if (!arg)
 		return -1;
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 4e7fb69183..b19df95321 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1802,7 +1802,8 @@ port_flow_configure(portid_t port_id,
 {
 	struct rte_port *port;
 	struct rte_flow_error error;
-	const struct rte_flow_queue_attr *attr_list[nb_queue];
+	const struct rte_flow_queue_attr **attr_list =
+	    alloca(sizeof(struct rte_flow_queue_attr *) * nb_queue);
 	int std_queue;
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN) ||
@@ -2616,10 +2617,10 @@ port_flow_template_table_create(portid_t port_id, uint32_t id,
 	int ret;
 	uint32_t i;
 	struct rte_flow_error error;
-	struct rte_flow_pattern_template
-			*flow_pattern_templates[nb_pattern_templates];
-	struct rte_flow_actions_template
-			*flow_actions_templates[nb_actions_templates];
+	struct rte_flow_pattern_template **flow_pattern_templates =
+	    alloca(sizeof(struct rte_flow_pattern_template *) * nb_pattern_templates);
+	struct rte_flow_actions_template **flow_actions_templates =
+	    alloca(sizeof(struct rte_flow_actions_template *) * nb_actions_templates);
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN) ||
 	    port_id == (portid_t)RTE_PORT_ALL)
@@ -5551,7 +5552,7 @@ parse_port_list(const char *list, unsigned int *values, unsigned int maxsize)
 	char *end = NULL;
 	int min, max;
 	int value, i;
-	unsigned int marked[maxsize];
+	unsigned int *marked = alloca(sizeof(unsigned int) * maxsize);
 
 	if (list == NULL || values == NULL)
 		return 0;
@@ -7292,7 +7293,8 @@ show_macs(portid_t port_id)
 	if (eth_dev_info_get_print_err(port_id, &dev_info))
 		return;
 
-	struct rte_ether_addr addr[dev_info.max_mac_addrs];
+	struct rte_ether_addr *addr =
+	    alloca(sizeof(struct rte_ether_addr) * dev_info.max_mac_addrs);
 	rc = rte_eth_macaddrs_get(port_id, addr, dev_info.max_mac_addrs);
 	if (rc < 0)
 		return;
-- 
2.47.2.vfs.0.1

