Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F7C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 16:13:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DD7040698;
	Thu,  2 Jul 2026 18:12:52 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 034084067C
 for <dev@dpdk.org>; Thu,  2 Jul 2026 18:12:51 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2c9b19bbaefso19242375ad.0
 for <dev@dpdk.org>; Thu, 02 Jul 2026 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783008770;
 x=1783613570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iD7Mo6QeChWvMD2hMBZM4SsJMERBhfxM+Gl81B6bwGQ=;
 b=bzkMHYBtAce3DxJUo9KLbRP96uzdYtkeGA7jidtdzXfhJLcUHYe7ZDzlhUhoKQWRpE
 /p7GzBso/PUp7vS8+TjjufI/Nee8chj7KYyri0hll123LGnFtEQZ14TVCuXrc0TKS1PF
 BPe/myfBlBWVmy4zQ9vf2tv9JNtMtsZfGaVhVZbeVZYviAweF3NDlhzEqZEWb7VM/N49
 AE3SRDjGlolzmJd2MCsh38411PLQMyVV1U+1bza0ICLxkNShWFLjT7pdw/SxM07HsVKi
 YmxhncE+QN1UwqerNdsyVd9AyVZbrowDbWL9bTxOWnnAxhvMmZD36tmuo5aQWCwKSR5Q
 iKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008770; x=1783613570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iD7Mo6QeChWvMD2hMBZM4SsJMERBhfxM+Gl81B6bwGQ=;
 b=EGy8IaMg9agFvsVodpbfofpP4GtT/sSM+si/b9hz/qLvUGpopQcZFHEpZENEmjbOuu
 NMy1pTPIO9JVC98dhNqgbjc/kk4uGbbsyVWQF8/avxTlFiUMCfzQTPAI2HEuTMzaZhDI
 HEVHGXtYgzNhkXTBbTdNN1NZZleOa3/h6yK6GOhGGCAZ8AMP2mPmKlStBAygZUWap8Vj
 EWs09Js0GZLB3QgAE8Av8OTGnu2tiKopwKRbHfR5jsE1sDT/YoserrpNn/UHJYTocyrQ
 W8z2+EKs9M+PT/e2dvDAw+FZCjPwnKWFrYLZioSB73lbW05EVr6dpNd7hR8O8hsqhOEl
 jBAg==
X-Gm-Message-State: AOJu0Yz8hRxBkwOs5SOMZDH6uuQEeST1THnhfFr5KyCNT/x7z+FHmTep
 B1SEpd/B90zJFWDAR/k32QggtX5iHl0CpQyZN0Jq5A3ED/OrWVluQn/ilieFgUtYZ9fyopZX+fO
 NSIbd
X-Gm-Gg: AfdE7ckaMM+Duhvjc4ABUH9XmBlZQYlvP7uWerD4HxPeVMyjtQFyALRVpsV2KJSh0vv
 02dr9LdOM+HabA30DT5j5VTyPVgf0kI5hg/vQOaprW9ANJzFq6bg/o5oWL5rB3bbHiqtRXgcMzx
 lH+YUL58DE7upBidP+9NrfOBNssVdtZxG3Z3KzSvQW9g4rbwfmSv+xR7v89WG8ay1LIHNozfQfl
 wXdEfonyZXme9VQpmAalwKRTNd4I7bltfrX8jhBTUoNkm1fauNF8sgcBM33wESH5g2iheYZyWnr
 hEx9MLk9lOE9S0B0M0dQFEckQUxcrBZ1/OTgk7W8ykh6hp4q0UeIAJ7UNqkwm0jBq8wTsWbhlg0
 iGoQr9NEBAcyK6qxyRhEmeK3e4SACV+8Lzkg95rcULTmI6AtulFfjdeA17+IBI2Ruc/PvCqKZ5O
 oyg48jwgCpnHr7zUYLZgJ3geXZCt1b6kZNRwqyzirVp3JFjj0nKIc=
X-Received: by 2002:a17:903:9cc:b0:2c9:97a7:71b0 with SMTP id
 d9443c01a7336-2ca7e936c01mr69477925ad.43.1783008770073; 
 Thu, 02 Jul 2026 09:12:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm9849304c88.4.2026.07.02.09.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:12:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 2/4] app/testpmd: consolidate port socket ID computation
Date: Thu,  2 Jul 2026 09:10:12 -0700
Message-ID: <20260702161244.363233-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702161244.363233-1-stephen@networkplumber.org>
References: <20260702130729.26577-1-mkashani@nvidia.com>
 <20260702161244.363233-1-stephen@networkplumber.org>
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

The socket id of a port was computed in three places with
diverging copies of the same policy:

- init_config() and init_fwd_streams() duplicated the full policy
  (--port-numa-config, device socket id, first available socket,
  --socket-num);
- setup_attached_port() used only the device socket id and ignored
  --port-numa-config, --no-numa and --socket-num, so a hot-attached
  port could be keyed to a socket where no mbuf pool exists.

Move the policy into a single helper, port_socket_id(), and use it
in all three places.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 69 +++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b5dca03047..04f0e15bee 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1740,6 +1740,31 @@ uma_socket_id(void)
 	       (unsigned int)SOCKET_ID_ANY : socket_num;
 }
 
+/*
+ * Socket id to use for a port: the socket its mbuf pools are created
+ * on and where its queue resources are placed.
+ */
+static unsigned int
+port_socket_id(portid_t pid)
+{
+	unsigned int socket_id;
+
+	if (!numa_support)
+		return uma_socket_id();
+
+	socket_id = port_numa[pid];
+	if (socket_id == NUMA_NO_CONFIG) {
+		socket_id = rte_eth_dev_socket_id(pid);
+		/*
+		 * If socket_id is invalid,
+		 * set to the first available socket.
+		 */
+		if (check_socket_id(socket_id) < 0)
+			socket_id = socket_ids[0];
+	}
+	return socket_id;
+}
+
 static void
 init_config(void)
 {
@@ -1774,25 +1799,8 @@ init_config(void)
 	}
 
 	RTE_ETH_FOREACH_DEV(pid) {
-		uint32_t socket_id;
-
-		if (numa_support) {
-			socket_id = port_numa[pid];
-			if (port_numa[pid] == NUMA_NO_CONFIG) {
-				socket_id = rte_eth_dev_socket_id(pid);
-
-				/*
-				 * if socket_id is invalid,
-				 * set to the first available socket.
-				 */
-				if (check_socket_id(socket_id) < 0)
-					socket_id = socket_ids[0];
-			}
-		} else {
-			socket_id = uma_socket_id();
-		}
 		/* Apply default TxRx configuration for all ports */
-		init_config_port_offloads(pid, socket_id);
+		init_config_port_offloads(pid, port_socket_id(pid));
 	}
 	/*
 	 * Create pools of mbuf.
@@ -1916,23 +1924,7 @@ init_fwd_streams(void)
 				nb_txq, port->dev_info.max_tx_queues);
 			return -1;
 		}
-		if (numa_support) {
-			if (port_numa[pid] != NUMA_NO_CONFIG)
-				port->socket_id = port_numa[pid];
-			else {
-				port->socket_id = rte_eth_dev_socket_id(pid);
-
-				/*
-				 * if socket_id is invalid,
-				 * set to the first available socket.
-				 */
-				if (check_socket_id(port->socket_id) < 0)
-					port->socket_id = socket_ids[0];
-			}
-		}
-		else {
-			port->socket_id = uma_socket_id();
-		}
+		port->socket_id = port_socket_id(pid);
 	}
 
 	q = RTE_MAX(nb_rxq, nb_txq);
@@ -3604,14 +3596,9 @@ attach_port(char *identifier)
 static void
 setup_attached_port(portid_t pi)
 {
-	unsigned int socket_id;
 	int ret;
 
-	socket_id = (unsigned)rte_eth_dev_socket_id(pi);
-	/* if socket_id is invalid, set to the first available socket. */
-	if (check_socket_id(socket_id) < 0)
-		socket_id = socket_ids[0];
-	reconfig(pi, socket_id);
+	reconfig(pi, port_socket_id(pi));
 	ret = rte_eth_promiscuous_enable(pi);
 	if (ret != 0)
 		fprintf(stderr,
-- 
2.53.0

