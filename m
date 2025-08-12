Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E9CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 14:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F21840270;
	Tue, 12 Aug 2025 16:43:08 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id EA0C4400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 16:43:07 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 3C2E81D000A0;
 Tue, 12 Aug 2025 10:43:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 12 Aug 2025 10:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1755009787; x=1755096187; bh=VrsaL7wvMIIVo9Fq8b2Me
 97K1045Y5CntVs3ZHoXO5c=; b=Feczg15NvZZ7bDrGI6ZjUUi8gV30Q/h2yuh5z
 Y7bBXxKpD996doFnydGnPS7XR7SA6Wb0PWYgUtqyD/7U5CTCFa8thVc/yuE7kRi+
 qXqVh8RKD6gITuxhgDTLlnrgq8DyKmuB5O39J8seYaUIdx3xpox/8CZkLXFohYZf
 //yop5a+YGnwQRPtLYcRrt0ZpjNpErxhyViW+SUHFJEh8fcXBYhFrjunOKclTc7Q
 8632JynzSlSPVJtgs1f0gEL8l9pNTB0Nkg+L8BZbsDZdMn6C8EcA3tY72/4ORQQb
 TvFMO8swXNubAJT9qTGil8DiD07HmrjcuF+K2nJ8z2WCkG2lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1755009787; x=1755096187; bh=VrsaL7wvMIIVo9Fq8b2Me97K1045Y5CntVs
 3ZHoXO5c=; b=ifmYb4fNedTkWM38jYMeX8M5JM1QxcLI2hchH0ACFcppZYpcTBm
 tuGgAf2qwvcoLErcXv826aVRAMwNqH8Mwp8zNfvvjdoa1xM0zLbSFccHbSABoFiS
 a8nqqYxU3mWjT2uBgKiStUJj+KgjpuISFJlnkNM0Y0ZS9asohgnm95Xml87P/3Px
 2QAA28azQwRhCcbMEQOuYRcPrEqWfpL5SPh09oY8MrdMzyVe7WkX6rYTh6Np4HTY
 NTYFza4uYjqnKjUixEd9iohKPwdcCG29Aa+g65433WU3bqHySQWrYgPjB5TQ0hHr
 GxJG1an05hMxmgDTwONirzfyWmev3mXzp4Q==
X-ME-Sender: <xms:-lKbaGwjoGotyYfSYfyr7scUTQrL3BgeSniWLs0ZZ4kV6a4Q1J5OKQ>
 <xme:-lKbaHowfR1ayTxspB-RSIjxJX_mp436MeCNKHSt7_XFIPFX0uKEWWhoH-aoWck0Y
 uBPNGCbvkb4FOzQ1g>
X-ME-Received: <xmr:-lKbaIgmgJ9p8bPLBe46T2fLQmAj_xQnHhJ7jyT23gGq9ND8o2vO2YfeTOXmlxCRyYtIx5tOzTaudO8HnIoect5uU5tTCDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehiedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 rghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtth
 hopehmrgigihhmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pegthhgvnhgsohigsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:-lKbaMgqoSTssyLrSJK6Th89mkEW5JzgBiKYXgeKC8uHnY0OfGQkhg>
 <xmx:-lKbaGgREMu9ghLfjaIaqBslP2YjleunhjRxNz-kxxY0v2c0c25lHg>
 <xmx:-lKbaEKWcFbkLxl6j3IATqN75s-9K56xXph4dPN0ehntv77I-hD-8Q>
 <xmx:-lKbaNGfw7mdWEy6CmIumAJ0Pl9y0b-p0jaZ5raooARQzl7uk7HzpA>
 <xmx:-1KbaA07frZkcNTQO5CYK_UmSMt08ljolXPKShxsyO_xJq_PPcDNU8MW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 10:43:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 1/1] ethdev: add link speed 800G
Date: Tue, 12 Aug 2025 16:42:48 +0200
Message-ID: <20250812144249.316120-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

There are some devices supporting 800G speed,
and it is well standardized in IEEE.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/cmdline.c                      | 21 ++++++++++++++-------
 app/test-pmd/config.c                       |  2 ++
 app/test-pmd/parameters.c                   |  3 +++
 app/test/test_ethdev_link.c                 |  3 ++-
 doc/guides/rel_notes/release_25_11.rst      |  5 +++++
 doc/guides/testpmd_app_ug/run_app.rst       |  1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  2 +-
 drivers/net/virtio/virtio_ethdev.c          |  2 ++
 lib/ethdev/rte_ethdev.c                     |  6 ++++++
 lib/ethdev/rte_ethdev.h                     |  2 ++
 10 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 801dee4456..3731fba370 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -710,7 +710,8 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Detach physical or virtual dev by port_id\n\n"
 
 			"port config (port_id|all)"
-			" speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|auto)"
+			" speed (10|100|1000|2500|5000|10000|25000|40000|50000|"
+			"100000|200000|400000|800000|auto)"
 			" duplex (half|full|auto)\n"
 			"    Set speed and duplex for all ports or port_id\n\n"
 
@@ -1430,6 +1431,8 @@ parse_and_check_speed_duplex(char *speedstr, char *duplexstr, uint32_t *speed)
 			*speed = RTE_ETH_LINK_SPEED_200G;
 		} else if (!strcmp(speedstr, "400000")) {
 			*speed = RTE_ETH_LINK_SPEED_400G;
+		} else if (!strcmp(speedstr, "800000")) {
+			*speed = RTE_ETH_LINK_SPEED_800G;
 		} else if (!strcmp(speedstr, "auto")) {
 			*speed = RTE_ETH_LINK_SPEED_AUTONEG;
 		} else {
@@ -1480,7 +1483,8 @@ static cmdline_parse_token_string_t cmd_config_speed_all_item1 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, item1, "speed");
 static cmdline_parse_token_string_t cmd_config_speed_all_value1 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, value1,
-				"10#100#1000#2500#5000#10000#25000#40000#50000#100000#200000#400000#auto");
+		"10#100#1000#2500#5000#10000#25000#40000#50000#"
+		"100000#200000#400000#800000#auto");
 static cmdline_parse_token_string_t cmd_config_speed_all_item2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_all, item2, "duplex");
 static cmdline_parse_token_string_t cmd_config_speed_all_value2 =
@@ -1491,8 +1495,9 @@ static cmdline_parse_inst_t cmd_config_speed_all = {
 	.f = cmd_config_speed_all_parsed,
 	.data = NULL,
 	.help_str = "port config all speed "
-		"10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|auto duplex "
-							"half|full|auto",
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000|auto "
+		"duplex half|full|auto",
 	.tokens = {
 		(void *)&cmd_config_speed_all_port,
 		(void *)&cmd_config_speed_all_keyword,
@@ -1555,7 +1560,8 @@ static cmdline_parse_token_string_t cmd_config_speed_specific_item1 =
 								"speed");
 static cmdline_parse_token_string_t cmd_config_speed_specific_value1 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, value1,
-				"10#100#1000#2500#5000#10000#25000#40000#50000#100000#200000#400000#auto");
+		"10#100#1000#2500#5000#10000#25000#40000#50000#"
+		"100000#200000#400000#800000#auto");
 static cmdline_parse_token_string_t cmd_config_speed_specific_item2 =
 	TOKEN_STRING_INITIALIZER(struct cmd_config_speed_specific, item2,
 								"duplex");
@@ -1567,8 +1573,9 @@ static cmdline_parse_inst_t cmd_config_speed_specific = {
 	.f = cmd_config_speed_specific_parsed,
 	.data = NULL,
 	.help_str = "port config <port_id> speed "
-		"10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|auto duplex "
-							"half|full|auto",
+		"10|100|1000|2500|5000|10000|25000|40000|50000|"
+		"100000|200000|400000|800000|auto "
+		"duplex half|full|auto",
 	.tokens = {
 		(void *)&cmd_config_speed_specific_port,
 		(void *)&cmd_config_speed_specific_keyword,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 08048da6f8..85f148a174 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -634,6 +634,8 @@ device_infos_display_speeds(uint32_t speed_capa)
 		printf(" 200 Gbps  ");
 	if (speed_capa & RTE_ETH_LINK_SPEED_400G)
 		printf(" 400 Gbps  ");
+	if (speed_capa & RTE_ETH_LINK_SPEED_800G)
+		printf(" 800 Gbps  ");
 }
 
 void
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 80c6ecae54..f7601df0bf 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -924,6 +924,9 @@ parse_link_speed(int n)
 	case 400000:
 		speed |= RTE_ETH_LINK_SPEED_400G;
 		break;
+	case 800000:
+		speed |= RTE_ETH_LINK_SPEED_800G;
+		break;
 	case 100:
 	case 10:
 	default:
diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index f063a5fe26..47c526eb0c 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -54,7 +54,7 @@ test_link_status_up_default(void)
 		"string with HDX");
 
 	/* test max str len */
-	link_status.link_speed = RTE_ETH_SPEED_NUM_400G;
+	link_status.link_speed = RTE_ETH_SPEED_NUM_800G;
 	link_status.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 	link_status.link_autoneg = RTE_ETH_LINK_AUTONEG;
 	ret = rte_eth_link_to_str(text, sizeof(text), &link_status);
@@ -131,6 +131,7 @@ test_link_speed_all_values(void)
 		{ "100 Gbps", RTE_ETH_SPEED_NUM_100G },
 		{ "200 Gbps", RTE_ETH_SPEED_NUM_200G },
 		{ "400 Gbps", RTE_ETH_SPEED_NUM_400G },
+		{ "800 Gbps", RTE_ETH_SPEED_NUM_800G },
 		{ "Unknown",  RTE_ETH_SPEED_NUM_UNKNOWN },
 		{ "Invalid",   50505 }
 	};
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index e81ba33907..122029b3c8 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added speed 800G.**
+
+  Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
+  and some devices already support this speed.
+
 * **Updated DPAA2 ethernet driver.**
 
   * Enabled software taildrop for ordered queues.
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 35a0c5528c..171f87e56d 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -409,6 +409,7 @@ The command line options are:
        100000 - 100Gbps
        200000 - 200Gbps
        400000 - 400Gbps
+       800000 - 800Gbps
        ...
 
 *   ``--disable-link-check``
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 6ad83ae50d..ea0ab9bcab 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2090,7 +2090,7 @@ port config - speed
 
 Set the speed and duplex mode for all ports or a specific port::
 
-   testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|auto) \
+   testpmd> port config (port_id|all) speed (10|100|1000|2500|5000|10000|25000|40000|50000|100000|200000|400000|800000|auto) \
             duplex (half|full|auto)
 
 port config - queues/descriptors
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 2d2635b669..eebc3ea817 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -2104,6 +2104,8 @@ virtio_dev_speed_capa_get(uint32_t speed)
 		return RTE_ETH_LINK_SPEED_200G;
 	case RTE_ETH_SPEED_NUM_400G:
 		return RTE_ETH_LINK_SPEED_400G;
+	case RTE_ETH_SPEED_NUM_800G:
+		return RTE_ETH_LINK_SPEED_800G;
 	default:
 		return 0;
 	}
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 4148c33807..f22139cb38 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1078,6 +1078,9 @@ rte_eth_speed_bitflag(uint32_t speed, int duplex)
 	case RTE_ETH_SPEED_NUM_400G:
 		ret = RTE_ETH_LINK_SPEED_400G;
 		break;
+	case RTE_ETH_SPEED_NUM_800G:
+		ret = RTE_ETH_LINK_SPEED_800G;
+		break;
 	default:
 		ret = 0;
 	}
@@ -3287,6 +3290,9 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	case RTE_ETH_SPEED_NUM_400G:
 		ret = "400 Gbps";
 		break;
+	case RTE_ETH_SPEED_NUM_800G:
+		ret = "800 Gbps";
+		break;
 	case RTE_ETH_SPEED_NUM_UNKNOWN:
 		ret = "Unknown";
 		break;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 5d7fc5ee9d..d23c143eed 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -306,6 +306,7 @@ struct rte_eth_stats {
 #define RTE_ETH_LINK_SPEED_100G    RTE_BIT32(14) /**< 100 Gbps */
 #define RTE_ETH_LINK_SPEED_200G    RTE_BIT32(15) /**< 200 Gbps */
 #define RTE_ETH_LINK_SPEED_400G    RTE_BIT32(16) /**< 400 Gbps */
+#define RTE_ETH_LINK_SPEED_800G    RTE_BIT32(17) /**< 800 Gbps */
 /**@}*/
 
 /**@{@name Link speed
@@ -326,6 +327,7 @@ struct rte_eth_stats {
 #define RTE_ETH_SPEED_NUM_100G    100000 /**< 100 Gbps */
 #define RTE_ETH_SPEED_NUM_200G    200000 /**< 200 Gbps */
 #define RTE_ETH_SPEED_NUM_400G    400000 /**< 400 Gbps */
+#define RTE_ETH_SPEED_NUM_800G    800000 /**< 800 Gbps */
 #define RTE_ETH_SPEED_NUM_UNKNOWN UINT32_MAX /**< Unknown */
 /**@}*/
 
-- 
2.47.1

