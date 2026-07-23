Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D1C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 18:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94DA140A6F;
	Thu, 23 Jul 2026 20:11:58 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id AD08A4064C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 20:11:57 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1008199b3a.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784830317;
 x=1785435117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VCe+hOFAUg4D5W7bt7eGpZ6RMQu1u921WR7GEWbOf0o=;
 b=tClgay7ObZymidsQ46PTH1KYPbFVh/wJ4LoLmlZrrzeRHnOvgrToAgAb1oI186IN30
 i3aE8lwxJYWGwNp9HYwzUOCJmYh/nltHnLkYs8oSCwzH/h2Jc61sjcEOm+edgiEThNXO
 ADZzBO4xBVcgzF4LgimF9GaH/GOBWv1+i+Wpf3zy9vc/JORsdQghDeng4Vs0nBswaBC0
 AmmJXzfU/0C9rlXRMRw71Xlzpb6BHKqcxPZ4O5Cprw8q0LHwjQxJIeDOl4VNatRVpLRJ
 KZOAXKmesOIQRpSdbNlW61Kf3me5/SVN6sN5RuAzWXfESI+YbiApyPIZbQOJvGi+sl6W
 KJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830317; x=1785435117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VCe+hOFAUg4D5W7bt7eGpZ6RMQu1u921WR7GEWbOf0o=;
 b=mI3v3euC+AnzBchpHHunPFgv12BYr8tYi4ojZLZGfdGCT6divgVmHl6A558zJI4F9t
 +EnlxwhZPkZHt34oEUuYjeB94+Bl77Txh0ymFuXYGMakEsqfEVkoIcYvxMTmY14BQ6ap
 9+DCTMW35kzDTmhFZObOlDnVGxwJmWPlnHOnBml/D/Lu3H04ewk3E1m8jeFEGVJbIxdA
 PIqYBDIMIJjtXCFxNpaLNW/09XJFN6g3FECso1KGya5fv0U38r/BiDtzyw+5mKMsbbmn
 mPk+JsH8HyJ3mBRMhWk9X/tCxTy9L0Dj1yIq9a4UCToBRt6H1Qfvg8z/5syPXMn5gE4u
 dArw==
X-Gm-Message-State: AOJu0Yybfj1sLmErzFzvD5/AKhniHEYXhdyusBvaT1gNyuKTxk4f386p
 1MxKtInwPVpB+FluvM8QqcQ9EW2Pi1WHyB/+90nl13m9ij7y8ASVwyQDen6+JZppU5zfloe3MDO
 ejhHM
X-Gm-Gg: AR+sD125rnSi3uhpLI9ZNZvLSi/nRxqZ/hKgoDmp49mPSIZsF6z3+hGQGhY5NThApg8
 OeClWpuvkNpoFTvffa+CvSPyxz5RyrmSqBJw9BbWiQU6NX0Vza+Esm8Y/6D1MWdgjZWbGmf+pJH
 sr6f7ifi091njGWRcy69r8NHuUBuTuhbXieCbL6gXtTxozp/NJ2I7dErktPGyHuiruLdPQEoI9F
 UkV/hUfUjTH+ir+kcQqpBQZbfHbZY3mOpjvZuXHKDgbCyOSMC4VaW5zw8XgyH1LF5z/FV4G4xXz
 6bgCk/gBDERzrQRFtf3V9lon9q1XufIswu1UpPqI67S23BI9aF9aCzFUmPYw1hmornmMAiTMn6q
 NzOwOgOnVUvcwqQHlVpSGtOdzkXn+bG5LkcHNpw/IqccRkZ4ouNLvXB34grdSPJm+NVUAMafy0Z
 SSOTWLh9OZtiHkZrdcOAUCT8OUedtmXcg4vXeX9p3z
X-Received: by 2002:a05:6a21:3383:b0:3bf:983d:e9b4 with SMTP id
 adf61e73a8af0-3c44b05d00dmr5021823637.33.1784830316787; 
 Thu, 23 Jul 2026 11:11:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm23791932eec.9.2026.07.23.11.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:11:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/2] net/cnxk: move socket from /tmp to runtime dir
Date: Thu, 23 Jul 2026 11:10:27 -0700
Message-ID: <20260723181153.195915-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723181153.195915-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
 <20260723181153.195915-1-stephen@networkplumber.org>
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

The eswitch control message socket was created at a fixed path in
/tmp, which is world-writable and shared across DPDK instances.

Build the path under the EAL runtime directory (e.g. /run/dpdk/<prefix>)
instead, so it follows the configured prefix and is isolated per
instance.

Add cnxk_eswitch_ctrl_msg_sock_addr() to fill the sockaddr_un from the
runtime dir and use it on both the server (bind) and client (connect)
paths.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_eswitch.c | 29 +++++++++++++++++++++++++----
 drivers/net/cnxk/cnxk_eswitch.h |  3 ++-
 drivers/net/cnxk/cnxk_rep_msg.c | 26 ++++++++++++--------------
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index 7e717a2fbf..0a6482462c 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -9,6 +9,24 @@
 
 #define CNXK_NIX_DEF_SQ_COUNT 512
 
+/* Build the control message unix socket address under the EAL runtime
+ * directory (e.g. /run/dpdk/<prefix>) rather than a fixed path in /tmp.
+ */
+int
+cnxk_eswitch_ctrl_msg_sock_addr(struct sockaddr_un *un)
+{
+	int ret;
+
+	memset(un, 0, sizeof(*un));
+	un->sun_family = AF_UNIX;
+	ret = snprintf(un->sun_path, sizeof(un->sun_path), "%s/%s",
+		       rte_eal_get_runtime_dir(), CNXK_ESWITCH_CTRL_MSG_SOCK_NAME);
+	if (ret < 0 || (size_t)ret >= sizeof(un->sun_path))
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int
 cnxk_eswitch_representor_id(struct cnxk_eswitch_dev *eswitch_dev, uint16_t hw_func,
 			    uint16_t *rep_id)
@@ -122,14 +140,17 @@ cnxk_eswitch_dev_remove(struct rte_pci_device *pci_dev)
 					plt_err("Failed to open socket. err %d", -errno);
 					return -errno;
 				}
-				sun.sun_family = AF_UNIX;
+				rc = cnxk_eswitch_ctrl_msg_sock_addr(&sun);
+				if (rc) {
+					plt_err("Control message socket path too long");
+					close(sock_fd);
+					return rc;
+				}
 				sunlen = sizeof(struct sockaddr_un);
-				strncpy(sun.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH,
-					sizeof(sun.sun_path) - 1);
 
 				if (connect(sock_fd, (struct sockaddr *)&sun, sunlen) < 0) {
 					plt_err("Failed to connect socket: %s, err %d",
-						CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, errno);
+						sun.sun_path, errno);
 					close(sock_fd);
 					return -errno;
 				}
diff --git a/drivers/net/cnxk/cnxk_eswitch.h b/drivers/net/cnxk/cnxk_eswitch.h
index 0275e760fb..b35a615edd 100644
--- a/drivers/net/cnxk/cnxk_eswitch.h
+++ b/drivers/net/cnxk/cnxk_eswitch.h
@@ -12,7 +12,7 @@
 
 #include "cn10k_tx.h"
 
-#define CNXK_ESWITCH_CTRL_MSG_SOCK_PATH "/tmp/cxk_rep_ctrl_msg_sock"
+#define CNXK_ESWITCH_CTRL_MSG_SOCK_NAME "cnxk_ctrl_msg_sock"
 #define CNXK_ESWITCH_VLAN_TPID		ROC_ESWITCH_VLAN_TPID
 #define CNXK_REP_ESWITCH_DEV_MZ		"cnxk_eswitch_dev"
 #define CNXK_ESWITCH_MAX_TXQ		256
@@ -179,6 +179,7 @@ cnxk_eswitch_pmd_priv(void)
 }
 
 /* HW Resources */
+int cnxk_eswitch_ctrl_msg_sock_addr(struct sockaddr_un *un);
 int cnxk_eswitch_nix_rsrc_start(struct cnxk_eswitch_dev *eswitch_dev);
 int cnxk_eswitch_representor_id(struct cnxk_eswitch_dev *eswitch_dev, uint16_t hw_func,
 				uint16_t *rep_id);
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index a222e2b5cd..9662213139 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -14,8 +14,11 @@
 static void
 close_socket(int fd)
 {
+	struct sockaddr_un un;
+
 	close(fd);
-	unlink(CNXK_ESWITCH_CTRL_MSG_SOCK_PATH);
+	if (cnxk_eswitch_ctrl_msg_sock_addr(&un) == 0)
+		unlink(un.sun_path);
 }
 
 static int
@@ -113,6 +116,7 @@ open_socket_ctrl_channel(void)
 {
 	struct sockaddr_un un;
 	int sock_fd;
+	int ret;
 
 	sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (sock_fd < 0) {
@@ -120,26 +124,20 @@ open_socket_ctrl_channel(void)
 		return -1;
 	}
 
-	/* Set unix socket path and bind */
-	memset(&un, 0, sizeof(un));
-	un.sun_family = AF_UNIX;
-
-	if (strlen(CNXK_ESWITCH_CTRL_MSG_SOCK_PATH) > sizeof(un.sun_path) - 1) {
-		plt_err("Server socket path too long: %s", CNXK_ESWITCH_CTRL_MSG_SOCK_PATH);
+	/* Set unix socket path under the runtime dir and bind */
+	ret = cnxk_eswitch_ctrl_msg_sock_addr(&un);
+	if (ret) {
+		plt_err("Server socket path too long");
 		close(sock_fd);
-		return -E2BIG;
+		return ret;
 	}
 
-	if (remove(CNXK_ESWITCH_CTRL_MSG_SOCK_PATH) == -1 && errno != ENOENT) {
-		plt_err("remove-%s", CNXK_ESWITCH_CTRL_MSG_SOCK_PATH);
+	if (remove(un.sun_path) == -1 && errno != ENOENT) {
+		plt_err("remove-%s", un.sun_path);
 		close(sock_fd);
 		return -errno;
 	}
 
-	memset(&un, 0, sizeof(struct sockaddr_un));
-	un.sun_family = AF_UNIX;
-	strncpy(un.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, sizeof(un.sun_path) - 1);
-
 	if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
 		plt_err("Failed to bind %s: %s", un.sun_path, strerror(errno));
 		close(sock_fd);
-- 
2.53.0

