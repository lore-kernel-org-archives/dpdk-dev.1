Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC13FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9BBB40698;
	Tue,  7 Apr 2026 17:17:58 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6EFB540684
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:57 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so3410063a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575076;
 x=1776179876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktnfYUNfDFx5CRXat1RCiZpuA23cXhgIVZ2xGt489qw=;
 b=Y9f4IlfOZZQCUV9sDwlNjhdOU/FS+jTOTa5IxfTYG+Bl3tdKvQfT8+bG499wTRs448
 n8OCvVodgiz2fyh6JzPGaoI+0e4irX4vfRhGhCLtgkwfYX0it1rwD/AsrDR4GmJQAWMO
 meDkU0slr3usGZqbuFG5I7xnH2s6hKCVCOhqwsjtIPXbAgH6BPmsNR7OgdQJjRL/6Gid
 y6OdFgnxdpXVNy4rPnTkSen+m23Cczi6fUqPzHQzW9BMyS19HhLGj+jpZxcDQXMFbcoY
 RBemIhx1f6WGjOw3R4wbMj1jupgm9SLpID+w+tKFl3HOhZVSZzb20rDlaRIrWGVswKbZ
 RPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575076; x=1776179876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ktnfYUNfDFx5CRXat1RCiZpuA23cXhgIVZ2xGt489qw=;
 b=gGYp85E6qsMf0WTn+OjBwjHCAB1yS/ftKojms3eh8p3gv+94UgdgKN6COFEnNtF/Sb
 oVmcPLyasYeax6vXq0NhTccrZf5jDrRdHrHKEe/eM3ydEtzLaIPBP6He+Kr4WYXLfoJ5
 tCVbuB2nckwKY5/Rsyx0cPPkJoLOErWhHhDH6DxW6yEGP7x2yRP7MXeSbHSHqQ6UJ/5X
 L/Us9Oiny99iK9hThlhI5/5yz2PZDuYjRBz1WaR4hOASlP+9dhMfc1btdrQxK13s5Jea
 rCPPI0EFCc1BRBFOOR9Go8tNwio9marOMzUSgDxeUH5Dpw1j9cIOi1cTNHRTHQvNYyda
 JfjA==
X-Gm-Message-State: AOJu0YzdpEmWW0l9i18X27/YR9ZWfXUTEVpFfTVBvXzHVLsekwZtVw5E
 3vmBRN904u88MoqeV9/EGlMwip4M49Cj7/DkquJGmtGtaLlyN1eoaX+9Ek5nwpeB0HUeYyvRqqX
 MJdr1
X-Gm-Gg: AeBDiesQ0ADNVMwGy/x97yylDb7ews9qps4rne03CodXgQHapx/dxEuoXGfUVmRGaf0
 IjIhtZxKEB8Bpy6aB79SEjDs3lHH2w/2NHbKp1IiD0iMmv6vTmosX2vGBPIE7o6o9vRnVBgx3lf
 OPwz8aOYGsIRdMpktl47o+NoEE2NitexJEeRfcF5mnnB678f4vj1BtuZaNUMLUH3sdkXQZGtyid
 5cpiBCiJEROdn6jlaAM7bDeuPo2GhrTBKYZNw/97Yifx+KX+Ry+C4W//Z4pLzyTNz4imQgiNdF6
 15M6NYlD2B8fNRvGN6tWBoWCl4a+WJGEej4y5b1ifs32KnVWTRijozWYzyoMIXSIy24hG6OcIGK
 XjaWCaHtz+rk0RyvLWKRwluA+KlEPrJK1J3Brze7wqSym7se2QobJRZA4AUD926kpm3Yno54+DA
 earabdOPCc3JOS6hWPvQiEQrCt/hNW1AfuIYX1RqWbbwU=
X-Received: by 2002:a05:6a20:7fa4:b0:398:6645:6ee7 with SMTP id
 adf61e73a8af0-39f2f1141b7mr20251600637.52.1775575076514; 
 Tue, 07 Apr 2026 08:17:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 05/23] examples/bond: resolve shadow variable warnings
Date: Tue,  7 Apr 2026 08:16:01 -0700
Message-ID: <20260407151732.272195-6-stephen@networkplumber.org>
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

Fix shadow variable warnings
- remove mbuf_pool parameters since member_port_init() and
  bond_port_init() always called with same pool.
- rename members array used in show command
- make the variables static

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/bond/main.c      | 21 ++++++++++-----------
 examples/bond/meson.build |  1 -
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/examples/bond/main.c b/examples/bond/main.c
index 4e8eeb7a5e..99359cd6fb 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -96,13 +96,12 @@
 		":%02"PRIx8":%02"PRIx8":%02"PRIx8,	\
 		RTE_ETHER_ADDR_BYTES(&addr))
 
-uint16_t members[RTE_MAX_ETHPORTS];
-uint16_t members_count;
+static uint16_t members[RTE_MAX_ETHPORTS];
+static uint16_t members_count;
+static struct rte_mempool *mbuf_pool;
 
 static uint16_t BOND_PORT = 0xffff;
 
-static struct rte_mempool *mbuf_pool;
-
 static struct rte_eth_conf port_conf = {
 	.rxmode = {
 		.mq_mode = RTE_ETH_MQ_RX_NONE,
@@ -119,7 +118,7 @@ static struct rte_eth_conf port_conf = {
 };
 
 static void
-member_port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
+member_port_init(uint16_t portid)
 {
 	int retval;
 	uint16_t nb_rxd = RTE_RX_DESC_DEFAULT;
@@ -204,7 +203,7 @@ member_port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
 }
 
 static void
-bond_port_init(struct rte_mempool *mbuf_pool)
+bond_port_init(void)
 {
 	int retval;
 	uint8_t i;
@@ -462,10 +461,10 @@ static inline void get_string(struct cmd_send_result *res, char *buf, uint8_t si
 		((unsigned)((unsigned char *)&(res->ip.addr.ipv4))[3])
 		);
 }
+
 void
 cmd_send_parsed(void *parsed_result, __rte_unused struct cmdline *cl, __rte_unused void *data)
 {
-
 	struct cmd_send_result *res = parsed_result;
 	char ip_str[INET6_ADDRSTRLEN];
 
@@ -635,7 +634,7 @@ cmd_quit_parsed(__rte_unused void *parsed_result, struct cmdline *cl, __rte_unus
 void
 cmd_show_parsed(__rte_unused void *parsed_result, struct cmdline *cl, __rte_unused void *data)
 {
-	uint16_t members[16] = {0};
+	uint16_t act_members[16] = {0};
 	uint8_t len = 16;
 	struct rte_ether_addr addr;
 	uint16_t i;
@@ -658,7 +657,7 @@ cmd_show_parsed(__rte_unused void *parsed_result, struct cmdline *cl, __rte_unus
 	cmdline_printf(cl,
 			"Active_members:%d "
 			"packets received:Tot:%d Arp:%d IPv4:%d\n",
-			rte_eth_bond_active_members_get(BOND_PORT, members, len),
+			rte_eth_bond_active_members_get(BOND_PORT, act_members, len),
 			global_flag_stru_p->port_packets[0],
 			global_flag_stru_p->port_packets[1],
 			global_flag_stru_p->port_packets[2]);
@@ -706,11 +705,11 @@ main(int argc, char *argv[])
 	/* initialize all ports */
 	members_count = nb_ports;
 	RTE_ETH_FOREACH_DEV(i) {
-		member_port_init(i, mbuf_pool);
+		member_port_init(i);
 		members[i] = i;
 	}
 
-	bond_port_init(mbuf_pool);
+	bond_port_init();
 
 	rte_spinlock_init(&global_flag_stru_p->lock);
 
diff --git a/examples/bond/meson.build b/examples/bond/meson.build
index 45389998e4..5a6db9a870 100644
--- a/examples/bond/meson.build
+++ b/examples/bond/meson.build
@@ -11,7 +11,6 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
 
 cmd_h = custom_target('commands_hdr',
         output: 'commands.h',
-- 
2.53.0

