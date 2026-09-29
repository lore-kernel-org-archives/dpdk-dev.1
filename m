Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA1CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA40F42E37;
	Tue, 29 Sep 2026 18:38:18 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id B25D442670
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:13 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc750a1482fso2458751a12.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699893;
 x=1791304693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNNaUuKkK9YlLeYmxGWAVVevPGKfYXZIwfW7hi9cs/8=;
 b=NUX7llVDPv34nVrG9RQsKOmZlKVMeXOxjPE1fqdLO6twAL9cZKHrTCIuAsqRjDL2f9
 qB5csA8/+fXfGBU6DUYz+NAPc+az3IUhXd644ktUOolA+XfYafFUDt6z7NNPag3KU3PB
 jifZ12pOMALaSP4u672Tg+4h6fL0S4q1FC3AU0g5kjEG1hCSDHN++mEyTPd2B29/aqHB
 REKyXvJXFYDZb4qoyZeLje8UAT5s9f06Sm6PPKgMtQ/EAA7llTGVLQ1U2qro1keCiDcZ
 k7FaNAB0eiTqt3wn72ag3CnYeoITLmTVTmJNGJ8nJqdbOyZfwOtJT+lC+WC1Is3bMmsC
 QNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699893; x=1791304693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNNaUuKkK9YlLeYmxGWAVVevPGKfYXZIwfW7hi9cs/8=;
 b=2M79V9OC6LEIDsrh23DrbV2A1dXGmCw+6ADKiHXoKUGkMcYFI/KL0/F48mZTHy7uTC
 BBDk23ydLQtDO14ZLOcVeuoD5KAzH38xzdbdf175C/k8/Qg5m0u9UyFtqS+ehNAdaAPI
 CIO4P76Qa2l51/3vZHoGa7jFK7dTwcSXFrUH+zt/8O/lmKnQp+/lo5qaqU32l9DAbSrR
 malm1yqbVao6fQqha5yiOnymQEm7Drya/e17Yupor3cGioMsdFKeaN5/ox3ngx4BnXkF
 n1KmdbyFDqmNa39KqNtOhWauLi335/o2OBiKjL2+tWqhssSeO5ToI4NUU+vkvmed0xcR
 2+XA==
X-Gm-Message-State: AFuF++lqlePKObTJx3uWHYc2pP9j+P1U9vZp8gdvL6sYrpU4ferJFwOh
 tu60daKo1Lv1AL5g+GiOC+eMByBM33l1C94xFgUWrna0tgjH7rmqQrl+fqCzbAMA94uC3dBa42p
 Yp6fgxzA=
X-Gm-Gg: AYBFou1VvuZWxVjaGb3XqudnWIv71JIuYUUI8uQZHTn8HjCEkcOBi+yzyGw3ekKq2L8
 4c7tcnaZOF4gK9yTya/TnO8pdjSc8uJEw4bL+GG73Xtpn/xYK94Z2DXYM1Qs7u+CabdMy/iJj20
 Y8i2CeUhR/ziGMYFMCbp7CYurreKkC0u7EcqrKAXIadu/C1jqoNxebMSbpoOQhJfvCI2ujFoE6z
 1E0Tjg04xXPfLh7/kLLPOJFZNmEbIwTdUe70opD3+eKDwqiPn4C/Ucmnput6IHyrnybLDI+XTSp
 MyhKOkfx+114N7ZDaZJdqqjGYD1MnTeZ67vuKbIIWWjjapF1LrexwlIIRiqaHf1qi6wSgnm1o1F
 5n5uZs33Y7QmH1gvWBgqGiks1NxMz7/K55IVc05XZW4bil5vjPsYS0/fVDqWnwHVBPnN9Zm1rgI
 AOVyd9xGDkciMycW6ZHsHIjVrSHB4p9KBrmNc2xTrRDCfgq2oh8qUgoF1M/FKDmj+aRl7luS1+Z
 clxwK86vzGFt09vvAWPWaBAugr5+UQxaoEfww==
X-Received: by 2002:a05:6a21:7a43:b0:3dd:a196:69da with SMTP id
 adf61e73a8af0-3de26f09ecfmr12983483637.53.1790699892795; 
 Tue, 29 Sep 2026 09:38:12 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 05/61] net/null: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:08 -0700
Message-ID: <20260929163800.1108305-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

The three device argument handlers each convert with strtoul() and
check neither errno nor the end pointer, so "size=foo" is silently
taken as zero and "size=99999999999999999999" as ULONG_MAX truncated
to unsigned int. The checks for UINT_MAX that follow only catch the
truncated overflow case on a 32 bit build.

A zero packet size was accepted, and the value is later cast to the
16 bit mbuf data length, so anything above 65535 was silently
truncated. Convert with an explicit 1..UINT16_MAX range instead.

The copy and no-rx arguments are booleans, so store them as bool and
use rte_kvargs_handle_bool. This also means they now accept the word
forms such as "copy=on", not only 0 and 1.

While here, set an error code when copy and no-rx are both given.
The error was logged but the zero return from the last successful
rte_kvargs_process() was returned, so probe reported success without
ever creating the device.

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/null.rst        |  2 +-
 drivers/net/null/rte_eth_null.c | 78 ++++++++++-----------------------
 2 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/doc/guides/nics/null.rst b/doc/guides/nics/null.rst
index c0e3199102..fd8d685d83 100644
--- a/doc/guides/nics/null.rst
+++ b/doc/guides/nics/null.rst
@@ -30,7 +30,7 @@ Runtime Configuration
 
 - ``size`` [optional, default=64 bytes]
 
- Custom packet length value to use.r
+ Custom packet length value to use, from 1 to 65535.
  If ``copy`` is enabled, this is the length of copy operation.
 
 .. code-block:: console
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index a469825cb6..6f3b27bd78 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -3,7 +3,8 @@
  *  All rights reserved.
  */
 
-#include <stdlib.h>
+#include <stdbool.h>
+#include <stdint.h>
 
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
@@ -19,8 +20,8 @@
 #define ETH_NULL_PACKET_NO_RX_ARG	"no-rx"
 
 static unsigned int default_packet_size = 64;
-static unsigned int default_packet_copy;
-static unsigned int default_no_rx;
+static bool default_packet_copy;
+static bool default_no_rx;
 
 static const char *valid_arguments[] = {
 	ETH_NULL_PACKET_SIZE_ARG,
@@ -45,15 +46,15 @@ struct null_queue {
 };
 
 struct pmd_options {
-	unsigned int packet_copy;
+	bool packet_copy;
 	unsigned int packet_size;
-	unsigned int no_rx;
+	bool no_rx;
 };
 
 struct pmd_internals {
 	unsigned int packet_size;
-	unsigned int packet_copy;
-	unsigned int no_rx;
+	bool packet_copy;
+	bool no_rx;
 	uint16_t port_id;
 
 	struct null_queue rx_null_queues[RTE_MAX_QUEUES_PER_PORT];
@@ -606,55 +607,22 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	return 0;
 }
 
-static inline int
-get_packet_size_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	const char *a = value;
-	unsigned int *packet_size = extra_args;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-
-	*packet_size = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_size == UINT_MAX)
-		return -1;
-
-	return 0;
-}
-
-static inline int
-get_packet_copy_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	const char *a = value;
-	unsigned int *packet_copy = extra_args;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-
-	*packet_copy = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_copy == UINT_MAX)
-		return -1;
-
-	return 0;
-}
-
+/* Packet size is stored in a 16 bit mbuf data length, and must not be zero. */
 static int
-get_packet_no_rx_arg(const char *key __rte_unused,
+get_packet_size_arg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	const char *a = value;
-	unsigned int no_rx;
+	uint64_t packet_size;
+	int ret;
 
-	if (value == NULL || extra_args == NULL)
+	if (extra_args == NULL)
 		return -EINVAL;
 
-	no_rx = (unsigned int)strtoul(a, NULL, 0);
-	if (no_rx != 0 && no_rx != 1)
-		return -1;
+	ret = rte_kvargs_to_uint(value, 1, UINT16_MAX, &packet_size);
+	if (ret < 0)
+		return ret;
 
-	*(unsigned int *)extra_args = no_rx;
+	*(unsigned int *)extra_args = packet_size;
 	return 0;
 }
 
@@ -714,16 +682,15 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 		if (ret < 0)
 			goto free_kvlist;
 
-
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_NULL_PACKET_COPY_ARG,
-				&get_packet_copy_arg, &args.packet_copy);
+				rte_kvargs_handle_bool, &args.packet_copy);
 		if (ret < 0)
 			goto free_kvlist;
 
-		ret = rte_kvargs_process(kvlist,
+		ret = rte_kvargs_process_opt(kvlist,
 				ETH_NULL_PACKET_NO_RX_ARG,
-				&get_packet_no_rx_arg, &args.no_rx);
+				rte_kvargs_handle_bool, &args.no_rx);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -732,11 +699,12 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 				"Both %s and %s arguments at the same time not supported",
 				ETH_NULL_PACKET_COPY_ARG,
 				ETH_NULL_PACKET_NO_RX_ARG);
+			ret = -EINVAL;
 			goto free_kvlist;
 		}
 	}
 
-	PMD_LOG(INFO, "Configure pmd_null: packet size is %d, "
+	PMD_LOG(INFO, "Configure pmd_null: packet size is %u, "
 			"packet copy is %s", args.packet_size,
 			args.packet_copy ? "enabled" : "disabled");
 
-- 
2.53.0

