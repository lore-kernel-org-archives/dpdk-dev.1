Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E65FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A91D402F1;
	Tue,  7 Apr 2026 05:52:21 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id C56CE402AC
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:17 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c0b72daf7so74704c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533937;
 x=1776138737; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgRfmiiPjEpKuJwq3dJzlztM2bsHTG7GBU6AMBdbYFA=;
 b=eRw0WEMMdcP6Pw+S89vOe3xvwBEhPK6V63hQD7Cfug6gts8X2emjxLMBR8QiQdhVAK
 WxeIBg5ZMDfUqil5gdlueE0pr4x0GAHML/IwcoeOjLVFQpjHyqvhkJeKeJTThqlitKer
 JeYqzTtmGM9avhetYbbgh/w9dV0aL7cJxyEGqnUZkrrFRGvosPNat9CTYkTQHMZthyNJ
 mC8Sr/HoYJ5XHP85cSQ4nieUHHY3bDnLT/TXT6Z5aTTiV1v7tlP5RPgaM8sOXOyGEEsE
 0vNxpshg/T2pULJcTtQDoxQ2Vvw/iAjTBwxQ4LE7H/hfm4YZ9oPLmQZxpa6m0HktJJNR
 G9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533937; x=1776138737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BgRfmiiPjEpKuJwq3dJzlztM2bsHTG7GBU6AMBdbYFA=;
 b=KSo5aBSRXnIZEDo/4mza/HcPjeCLd05EgAGNYgEeIfcxDB6uS9oJPfyMGZqg+jh4kp
 hjfzVP9liKFHwAX4hRZuq0Pcm5nNwtO/6cMgtsYyKmXgJfIQoF5svjlhHcwYJLl5oLjo
 e064BizKXkKTGWR1AEsZb3J6sbGCMva95WRUASiuEVAwHNAbczWUpvOHmyoZMs1NUTW4
 5le+L++rxcrBXf08na5sGx6Qwtf3tClsmYGHhrLuWTpqj7LVYobdwYlr1lAz0xZ9FfOR
 ZUK/3bUNNO8Lf0VvFxHyF2RxwLTEZNuDQ/uKjEUsVW+mHuX/WjE35mKQXtS3FHKir4KJ
 ocAA==
X-Gm-Message-State: AOJu0Yxd5SkOge8a7Y/e/LwytEUhofjnJZNiJKXwvqfAis0jw4hOTjQa
 aDgmVtrCtEve0QnkyhcxTQ2Me63kMmVJBU4T7br+WbEi2qEueTPI9Goy7Z+WyHLzZz/19U4kJW0
 bA2i+
X-Gm-Gg: AeBDiessbLtUyhWs/jEjTNgYfRLcv8/KxASbQjGBf6CmrPVvdohP774W/J82oh38bsi
 zysznr8MCrvOYv+ZP825JopMapehv41W+WqLg7VwBDPyxSFh4UUR6Ireydu0XG+attM6j089Ff/
 AhRRUxmjrHIGQ1RbEk7MhZKrwbskVI8KJyEByKidErKPLNjlQiX5d0RT+BbdYBHEzOKwV7hwzO8
 vvdyR28g8C6N5u7aCi3WpcwqQHba4kzraYL7ejZB7hN6eqX+z9HiT+D812qx6Npmdrd6YBVHjqF
 aKLlXkFzESNV9t6FTmeY+JMzSG5zzYI+Akk6ucXhORkVeQIaubwA8XQKMKvtmI7T35dZ8PmoD1N
 0QTJhWuOfl4zGOMTZV2fx6/XW8Nh8iuK11nNnMQU4O0xCmUopP8dRkBvWhvVN+90DGNpFFbOEto
 c8kP/32bke8kFaHYcBAGUwQVPGUUV+dMY+
X-Received: by 2002:a05:7022:2221:b0:127:33e0:ea33 with SMTP id
 a92af1059eb24-12bfb74c9bcmr8115275c88.22.1775533936791; 
 Mon, 06 Apr 2026 20:52:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 05/23] examples/bond: fix shadow variable warnings
Date: Mon,  6 Apr 2026 20:49:31 -0700
Message-ID: <20260407035209.650419-6-stephen@networkplumber.org>
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

Fix shadow variable warnings
- remove mbuf_pool parameters since member_port_init() and
  bond_port_init() always called with same pool.
- rename members array used in show command
- make the variables static

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

