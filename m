Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B3C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8270140654;
	Sun, 22 Feb 2026 18:32:38 +0100 (CET)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50]) by mails.dpdk.org (Postfix) with ESMTP id 4ACEF4060C
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:32 +0100 (CET)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-413d8b8e98aso1411653fac.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781551;
 x=1772386351; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfuQ8LUVy62PmHWRQN3Owegch2Q0hFDFbwn/epGFtJ0=;
 b=aOElwqEZhEhi6PmBY1UVLtQ0WEdkJhQHw7Xeup5wvH310NPCm6JX+K5FGNhwEhVnte
 GUVbsfRc83gXKS2k0uII2C38w9WGo52VjOeIwk/3vwDAWI3/kFen2QxJbHfaI8pEub46
 qEZj6evO9Rs8dhrk32FmTGHpuL+YMJoZu0OzkFVHHVvxtWmP2L3AlAZ2hU8sWELbT31c
 1x59Boy/AJPYaDt7U+iCgMaXB2hQQsBzMC177eYVsbWOyE0JHPoQqdbgGuJC8TB1XLUD
 7+irQfSY07nZlWHEAWUMp92xiB1sfiPIOp4pN2HaVGN/oybihmuLp+dXWU1DXSWOapAC
 9Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781551; x=1772386351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RfuQ8LUVy62PmHWRQN3Owegch2Q0hFDFbwn/epGFtJ0=;
 b=iuWR6vR48etoayq8ZrrhBZKDulMNdoOP+Fh+NVn3z3YbcgBZq+XJV1bETMC7Y60dkM
 46a1eY0g9QDAAj5YbkgJ3WMbSQDAbcUrIbUNP1ZlCOEIh1Uj+AQZTj0TSV60gWmqnika
 3qf3qMXhZKyNwRKttpv5r52Kke5Ai6LbvuZMq+L801U8vQLMj8D+ZaMTlDBByT1y7QRK
 HQXNwl+LlipuV8uQX39ZtAbXVJJ3umQBzx+WzWyvnJg3lcqSo01OdD7c6lbn4wNE+Qsq
 GKqUC46lyNxIzUAtPBTGAt53+SRZzVytGiULWuPThQPebMHThjrm6/gAfPx4QP3EDK8t
 c4lA==
X-Gm-Message-State: AOJu0YzQQ4gvC8ji7PNS9dl/RWBhQZRmhdrh92nSDeTtV9K49x5SzUQc
 Ly4XUJk5DrmTTghITt8L0tJ3w0VQLATPFrHrSjhXcZljY3pZBK7yxy/ocwnFZFy1yazC7CnfWff
 ymJtr
X-Gm-Gg: AZuq6aLGMYRveznxvou4MSWtXMDXpSnckEzBhJiz1/yHs58aznmbxwuy0IS+oxlc1t3
 rN7HYwXhGKbbsEUWMC1k8EVdW7lXRQkDeAdDmBPprUjBVHEraGCgN8E7/LU+moDaTjkBDO+2tR2
 Xi7357c/3hP/N3vaGYgInwxN8MZuDGupyN76S8mLEg5iyMHUse6zVjVRQwnS658dDx9JqG6PehT
 2PEEeCd/ib37/knr4AtZNbeHBYEN+bGZ63Z28iT9qIlrwQbP/mMHu3XvduC0+6dnIrdVmtRPkdc
 HrJz+f9u0XBvVelzlZ9xtIwn/irv3XejGs5ZPKS7uVKajdKLPl5MKCaDLVOUWZL8gIL7WFhn+iQ
 CuxgwOWRjJwfC/wHIE56Ad2rTsjrs0YQVFws1v7OG4rtHiQPLpoDDlOc07j82L6qup4jx6y3ifh
 nItsoebHNQZPOsdZ0WORph1iVIdRrdWWDQs9oRmln5WEV4HG1lo6LHO+t7SVLoxw==
X-Received: by 2002:a05:6870:1402:b0:3ea:ff22:3dde with SMTP id
 586e51a60fabf-4157ae922e3mr3320071fac.24.1771781551547; 
 Sun, 22 Feb 2026 09:32:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 03/19] net/tap: use correct length for interface names
Date: Sun, 22 Feb 2026 09:30:38 -0800
Message-ID: <20260222173225.522754-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

The interface names in the driver internals are Linux
kernel network interface names which have a maximum size of 16;
not DPDK device names which can take up to 64 characters.

Fixes: 02f96a0a82d1 ("net/tap: add TUN/TAP device PMD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 28 ++++++++++++++--------------
 drivers/net/tap/rte_eth_tap.h |  4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 8b233a3143..08d51c3a45 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -203,7 +203,7 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * and need to find the resulting device.
 	 */
 	TAP_LOG(DEBUG, "Device name is '%s'", ifr.ifr_name);
-	strlcpy(pmd->name, ifr.ifr_name, RTE_ETH_NAME_MAX_LEN);
+	strlcpy(pmd->name, ifr.ifr_name, IFNAMSIZ);
 
 	if (is_keepalive) {
 		/*
@@ -1994,7 +1994,7 @@ static const struct eth_dev_ops ops = {
 
 static int
 eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
-		   char *remote_iface, struct rte_ether_addr *mac_addr,
+		   const char *remote_iface, struct rte_ether_addr *mac_addr,
 		   enum rte_tuntap_type type, int persist)
 {
 	int numa_node = rte_socket_id();
@@ -2137,7 +2137,7 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 				pmd->name, remote_iface);
 			goto error_remote;
 		}
-		strlcpy(pmd->remote_iface, remote_iface, RTE_ETH_NAME_MAX_LEN);
+		strlcpy(pmd->remote_iface, remote_iface, IFNAMSIZ);
 
 		/* Save state of remote device */
 		if (tap_nl_get_flags(pmd->nlsk_fd, pmd->remote_if_index,
@@ -2250,10 +2250,10 @@ set_interface_name(const char *key __rte_unused,
 				value);
 			return -1;
 		}
-		strlcpy(name, value, RTE_ETH_NAME_MAX_LEN);
+		strlcpy(name, value, IFNAMSIZ);
 	} else {
 		/* use tap%d which causes kernel to choose next available */
-		strlcpy(name, DEFAULT_TAP_NAME "%d", RTE_ETH_NAME_MAX_LEN);
+		strlcpy(name, DEFAULT_TAP_NAME "%d", IFNAMSIZ);
 	}
 	return 0;
 }
@@ -2271,7 +2271,7 @@ set_remote_iface(const char *key __rte_unused,
 				value);
 			return -1;
 		}
-		strlcpy(name, value, RTE_ETH_NAME_MAX_LEN);
+		strlcpy(name, value, IFNAMSIZ);
 	}
 
 	return 0;
@@ -2322,13 +2322,13 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
 	const char *name, *params;
 	int ret;
 	struct rte_kvargs *kvlist = NULL;
-	char tun_name[RTE_ETH_NAME_MAX_LEN];
-	char remote_iface[RTE_ETH_NAME_MAX_LEN];
+	char tun_name[IFNAMSIZ];
+	char remote_iface[IFNAMSIZ];
 	struct rte_eth_dev *eth_dev;
 
 	name = rte_vdev_device_name(dev);
 	params = rte_vdev_device_args(dev);
-	memset(remote_iface, 0, RTE_ETH_NAME_MAX_LEN);
+	memset(remote_iface, 0, IFNAMSIZ);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
 	    strlen(params) == 0) {
@@ -2344,7 +2344,7 @@ rte_pmd_tun_probe(struct rte_vdev_device *dev)
 	}
 
 	/* use tun%d which causes kernel to choose next available */
-	strlcpy(tun_name, DEFAULT_TUN_NAME "%d", RTE_ETH_NAME_MAX_LEN);
+	strlcpy(tun_name, DEFAULT_TUN_NAME "%d", IFNAMSIZ);
 
 	if (params && (params[0] != '\0')) {
 		TAP_LOG(DEBUG, "parameters (%s)", params);
@@ -2485,8 +2485,8 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 	int ret;
 	struct rte_kvargs *kvlist = NULL;
 	int speed;
-	char tap_name[RTE_ETH_NAME_MAX_LEN];
-	char remote_iface[RTE_ETH_NAME_MAX_LEN];
+	char tap_name[IFNAMSIZ];
+	char remote_iface[IFNAMSIZ];
 	struct rte_ether_addr user_mac = { .addr_bytes = {0} };
 	struct rte_eth_dev *eth_dev;
 	int tap_devices_count_increased = 0;
@@ -2537,8 +2537,8 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 	speed = RTE_ETH_SPEED_NUM_10G;
 
 	/* use tap%d which causes kernel to choose next available */
-	strlcpy(tap_name, DEFAULT_TAP_NAME "%d", RTE_ETH_NAME_MAX_LEN);
-	memset(remote_iface, 0, RTE_ETH_NAME_MAX_LEN);
+	strlcpy(tap_name, DEFAULT_TAP_NAME "%d", IFNAMSIZ);
+	memset(remote_iface, 0, IFNAMSIZ);
 
 	if (params && (params[0] != '\0')) {
 		TAP_LOG(DEBUG, "parameters (%s)", params);
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 218ee1b811..7be8f4d01b 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -68,8 +68,8 @@ struct tx_queue {
 
 struct pmd_internals {
 	struct rte_eth_dev *dev;          /* Ethernet device. */
-	char remote_iface[RTE_ETH_NAME_MAX_LEN]; /* Remote netdevice name */
-	char name[RTE_ETH_NAME_MAX_LEN];  /* Internal Tap device name */
+	char remote_iface[IFNAMSIZ];	  /* Remote netdevice name */
+	char name[IFNAMSIZ];		  /* Internal Tap device name */
 	int type;                         /* Type field - TUN|TAP */
 	int persist;			  /* 1 if keep link up, else 0 */
 	struct rte_ether_addr eth_addr;   /* Mac address of the device port */
-- 
2.51.0

