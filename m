Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D3DCA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB10C42DC3;
	Thu,  1 Oct 2026 00:43:52 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id BC96440FB5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:48 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so2119512a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808228;
 x=1791413028; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oNNaUuKkK9YlLeYmxGWAVVevPGKfYXZIwfW7hi9cs/8=;
 b=M8m8yXdvJUr/lghBuQjb/AhPVRErzi6/eZ7bzuExVbiKX5qvdFQs55bVrR91AzaRNw
 XmQoK6Tl9OrBytAaqiE2uywYsUHU2OwyySOztDvQJmnJnRCjim6JliYc1KdRGdWQW0bZ
 0zQH2FbiUnQIROYdO5ace4Lxl6emjGepLqbnCxslkrGrqdvzYjWttkM9ey3aBAyIdjEM
 cZuSYrQqBifYUmdxoIbso1VJ37EK6/7z8gGnPWv7F5LuSj9VoNzyKVLcl1/HkMQzj/4T
 WbHuzZxjLSGwp87hKJNEUDmY3f5BH0eYFTnKYQUlwXstC0MSWIeyP/jdeERJfh3zO0/k
 ODRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808228; x=1791413028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oNNaUuKkK9YlLeYmxGWAVVevPGKfYXZIwfW7hi9cs/8=;
 b=y8xnGJvsPUTuTyg1j6mDRgqMTepUK7u+lW7BFx6xiL7s4LDw5uuhgL2e8kvOVwESmM
 0GuzRJC2i4hJu7qovHlQCin7g+g/vk03BI/z68SDPekhO7Vk4gA5LUDkhSV9w8IyehOI
 6qUpYGkWOrkImQ9+Hz3/rUtnX16CzqgBOSC70FLrvz2I99P+hEhGG6+MG5FInOR/s+XX
 stV4irOYEKnszCWQU2Kl88EZv4ood2dlPdwN7TlWR54oBDHhTjEuYVZXcpXsH307K6wn
 kAa76NYpv7X2Q+LzSVwC97FtHNhiwqB78YdPjaBNXi3/V7IH6tF4uXL7kjOdrsfkNiU4
 X9vw==
X-Gm-Message-State: AFq9FYJfGbyncw5UNV066xjeom3vLR5ARe0I6EGy/7iLPPCfcdojHEZY
 mKchKIMe2p+BUWpinYlJdB2kET97NuMKY7kHGjtdEnAFlpEfQKbX9GkBz8eX9TqOANLKf8Yeamb
 m3syh/e8=
X-Gm-Gg: AYBFou12irAqtcpvPSxwqDeX9aHbRPbicR8a7opeTQW19Hj2hg76RbcyESte4XgGREG
 nCm92sz3jxhlNWKGttl6piPgJ/Iy7dFIKHJ6SodgkYGZHxjnqgvLhEjKWERSzJe9Cwvz8MZX3aA
 erHnLFHhjRhA8FWWcEA2Bwgxgrr0PGl2NSvwJ3dC0+8cTyOZ1538lAA12geubucM8/EQDiwBtog
 JMuv2SnxEqyMGJP9KDS0p7SIM46BDJMNiZhnzHeCaK5MbYPFDrpKIIvw4iwxkrPqHbDneTe4ctT
 f1E6IPswwwKQTTjNinCTZvUl8gbtBFy9vKlIsnN+Vsg12cWDS0SXK4Ol8NQnNr7FzOcwCuGGW36
 nRZMTz3v7UZ0c0PjGI6gkhfuIzcI81ZWyW3UypM8gS6YTk8a3jE6C89lZPfQgyIdJ0zo/xqIEb6
 2bhK0/oKyp78SdJVTrbfHHM1bfnM5a9D7BLgeRVSdD50DbD+BjKk1n88/vgLX8zrIKpqtkSLG83
 UukMLWgZRn0WSYjPF9tjm35OdG7VwyMlzOG5Q==
X-Received: by 2002:a17:90b:3c4c:b0:3a4:b509:88bd with SMTP id
 98e67ed59e1d1-3a4f2afacd2mr511698a91.2.1790808227640; 
 Wed, 30 Sep 2026 15:43:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v3 06/65] net/null: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:24 -0700
Message-ID: <20260930224340.58580-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

