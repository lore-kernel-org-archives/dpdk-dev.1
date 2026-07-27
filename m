Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7395BC53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D72E40671;
	Mon, 27 Jul 2026 15:54:33 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3B61E400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:54:32 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-51c16ac21acso17295361cf.0
 for <dev@dpdk.org>; Mon, 27 Jul 2026 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160471; x=1785765271; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/gfXQJbnPYZBrL6a0Wv+ljjrKDEBFG9hKuHAjDtyoNY=;
 b=IRC3z3YQl15jXlP+aLO9S1m2Lj/labM1s9fjiUP+KMBPk34yXJrotijkBr3Hbuh0DR
 wf7qVtC6herWkcw9+1SKbHG7swWLdUYHBu4PxFLxNEjecQBXv4qlzi4Jv5iRQbotEObb
 g37F+bCjmAqexCIH1A+4lJ57AbbOF+Mj/y9QRJ1slhj7yBTPa7Ql3HO2Ktjsnfv38N97
 aHUTFmOD0mXIidfIxGTbQFO/attSWUcbVJ/OIk5fWOHuulpyBgQyR0pTP63IYh1FAMiN
 Cl+REjoexZx8yIHkcUdarLm7wkD5n5ho0RNkWtUf+yXZYVM51mn4qdt4WHGIhNLGh8e8
 tukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160471; x=1785765271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/gfXQJbnPYZBrL6a0Wv+ljjrKDEBFG9hKuHAjDtyoNY=;
 b=JTC6q7Dff5b24tUp7N3tnSQyqJGW/pIJi9D0ze8Gly991umo2N8cSc5zMcSDT69OLD
 EH+wuO0yEiBF+yw180/2ckWHObE9CR4AhASPEqs3jsQmFmUe1xRfLdTPkvvJO9uybF+R
 0DSY+QiIMpRviqIBymRToMofXNuUmJWWzi41tHaJkOapfQipS4Xp/x1kRXUoXu//6Y4Z
 umNROkriQRn0eEuPJWSQVX6Pr9Nat+AueFmMO1M8D6wg5QNDgXBJKFNKEAXSi/SLgJVP
 8qOirbQiJqO3MzJKVHw0ZUkWu1qozmSvRVha+JuDp3Lph7eYF/6j0B8KovgwnJQCQnGE
 /fmg==
X-Gm-Message-State: AOJu0Yya39AJCdteDmsPlYxVzSNXlAxi+4u2F4Uy+tpfaNu1a6YeVlON
 rq/N6tP0dp47sJJb8ZbtCk2pw7JWToWJ+uQXfoWipwpLkLNsftZs3pYU
X-Gm-Gg: AR+sD139YPqt1hmQsCiZvnyMW+9QORIP1hN3DtI717Xf3ZU585fkTscuZeZ4nJvMex6
 jG6qRNQprC6rgDLhUjINHu7U0beU8dbkEM1JhNtS0vzFC5k9+P29VwR+JSX5KRO4S0yV06yqbvu
 naOd8HueOfI7oiw1g7I/2GCINPZskVOiTm0MOG0Mgxxwjc13Ic85SvGEnsKp78Xmldbg/ZSyrk8
 nKuEm41v6LOvZvZoHAFqk94ywHQaAeaTu/hR45Yd6ozsBY/bfqKhm6WHRcdCUDdkXDDLrVEeK2R
 b0P351RGqR5ir7ooXSyIaLne+60f+Jdu+wGqtY2fuJQH27HTdrmujmrGUQ4AHW2tgJXscZYKDdz
 w2wYWeCAHZUiDbk8/55PNsN5kb4XuOUhYXKqvz5tBoPuBF3Fi9STikPzGkkOlrcpSxOIB3CB8+Y
 DI8cRn18WLGrKk2sxFYXRTnsd3lJM3TWI=
X-Received: by 2002:ac8:6f0d:0:b0:51c:7b12:1204 with SMTP id
 d75a77b69052e-529a8897336mr88836311cf.82.1785160471409; 
 Mon, 27 Jul 2026 06:54:31 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529a29884e7sm53802631cf.17.2026.07.27.06.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:54:31 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	ferruh.yigit@amd.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 4/4] net/tap: use bool for boolean flags
Date: Mon, 27 Jul 2026 15:54:10 +0200
Message-ID: <20260727135411.2590931-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727135411.2590931-1-maxime@leroys.fr>
References: <20260727135411.2590931-1-maxime@leroys.fr>
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

persist, flow_init and flow_isolate only ever hold true or false but were
declared as int. Use bool, consistent with the interrupt-mode flags added
in this series and with common DPDK practice, and convert the parameters
and local variable that feed persist along with them.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.c | 14 +++++++-------
 drivers/net/tap/rte_eth_tap.h |  6 +++---
 drivers/net/tap/tap_flow.c    |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index f846ce1fda..b1c5237fb1 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -158,7 +158,7 @@ static int tap_intr_handle_set(struct rte_eth_dev *dev, int set);
  *   -1 on failure, fd on success
  */
 static int
-tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
+tun_alloc(struct pmd_internals *pmd, bool is_keepalive, bool persistent)
 {
 	struct ifreq ifr;
 #ifdef IFF_MULTI_QUEUE
@@ -1540,7 +1540,7 @@ tap_setup_queue(struct rte_eth_dev *dev,
 			pmd->name, fd, dir, qid);
 		gso_ctx = NULL;
 	} else {
-		fd = tun_alloc(pmd, 0, 0);
+		fd = tun_alloc(pmd, false, false);
 		if (fd < 0) {
 			TAP_LOG(ERR, "%s: tun_alloc() failed.", pmd->name);
 			return -1;
@@ -2147,7 +2147,7 @@ static const struct eth_dev_ops ops = {
 static int
 eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 		   const char *remote_iface, struct rte_ether_addr *mac_addr,
-		   enum rte_tuntap_type type, int persist)
+		   enum rte_tuntap_type type, bool persist)
 {
 	int numa_node = rte_socket_id();
 	struct rte_eth_dev *dev;
@@ -2234,7 +2234,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	 * This keep-alive file descriptor will guarantee that the TUN device
 	 * exists even when all of its queues are closed
 	 */
-	pmd->ka_fd = tun_alloc(pmd, 1, persist);
+	pmd->ka_fd = tun_alloc(pmd, true, persist);
 	if (pmd->ka_fd == -1) {
 		TAP_LOG(ERR, "Unable to create %s interface", tuntap_name);
 		goto error_exit;
@@ -2507,7 +2507,7 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
 	TAP_LOG(DEBUG, "Initializing pmd_tun for %s", name);
 
 	ret = eth_dev_tap_create(dev, tun_name, remote_iface, 0,
-				 ETH_TUNTAP_TYPE_TUN, 0);
+				 ETH_TUNTAP_TYPE_TUN, false);
 
 leave:
 	if (ret == -1) {
@@ -2630,7 +2630,7 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 	struct rte_ether_addr user_mac = { .addr_bytes = {0} };
 	struct rte_eth_dev *eth_dev;
 	int tap_devices_count_increased = 0;
-	int persist = 0;
+	bool persist = false;
 
 	name = rte_vdev_device_name(dev);
 	params = rte_vdev_device_args(dev);
@@ -2718,7 +2718,7 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 			}
 
 			if (rte_kvargs_count(kvlist, ETH_TAP_PERSIST_ARG) == 1)
-				persist = 1;
+				persist = true;
 		}
 	}
 
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 24fd055df9..ad497d5ce2 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -73,7 +73,7 @@ struct pmd_internals {
 	char remote_iface[IFNAMSIZ];	  /* Remote netdevice name */
 	char name[IFNAMSIZ];		  /* Internal Tap device name */
 	int type;                         /* Type field - TUN|TAP */
-	int persist;			  /* 1 if keep link up, else 0 */
+	bool persist;			  /* keep link up */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
 	struct rte_ether_addr *mc_addrs;  /* multicast address list */
 	uint32_t nb_mc_addrs;             /* multicast address count */
@@ -83,8 +83,8 @@ struct pmd_internals {
 	int nlsk_fd;                      /* Netlink socket fd */
 
 #ifdef HAVE_TCA_FLOWER
-	int flow_init;                    /* 1 if qdiscs were created */
-	int flow_isolate;                 /* 1 if flow isolation is enabled */
+	bool flow_init;                   /* qdiscs were created */
+	bool flow_isolate;                /* flow isolation is enabled */
 
 	struct tap_rss *rss;		  /* BPF program */
 
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index a9d8e09562..2187b9a019 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1244,7 +1244,7 @@ tap_flow_create(struct rte_eth_dev *dev,
 	struct tap_nlmsg *msg = NULL;
 	int err;
 
-	if (pmd->flow_init == 0 && tap_flow_init(pmd) < 0) {
+	if (!pmd->flow_init && tap_flow_init(pmd) < 0) {
 		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL,
 				   "can't create rule, qdisc not initialized");
@@ -1521,7 +1521,7 @@ tap_flow_isolate(struct rte_eth_dev *dev,
 	}
 	return 0;
 error:
-	pmd->flow_isolate = 0;
+	pmd->flow_isolate = false;
 	return rte_flow_error_set(
 		error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 		"TC rule creation failed");
@@ -1914,7 +1914,7 @@ tap_flow_init(struct pmd_internals *pmd)
 		return -1;
 	}
 
-	pmd->flow_init = 1;
+	pmd->flow_init = true;
 
 	return 0;
 }
-- 
2.43.0

