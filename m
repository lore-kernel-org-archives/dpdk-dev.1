Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E15C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9321F40B90;
	Mon, 14 Sep 2026 07:49:41 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id C663440B8D
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:40 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1165846a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364980;
 x=1789969780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wu0ntsqZihHJ4PPmK9hFYIwAA6IxkEIGvvI3l0p7Gak=;
 b=PupDK/+AGvGvDRrFWyuEmOq17k6CqmnqRu1a8BDKhxRPGL9K9tA7NEHSjmluivo/Uv
 r+wj9QMADrb6FpAQA/u2FV5dQ0t0xbu0+UDD2P8kwAZnaAVopHt+97MDNOxdGlYJxWP+
 HDiQkZrykeGpvuUXlkKc3N2hFJE3/XF20b2GkWQrmmpb5mcnBtmreUnnHerIa/ne/nZb
 rf7fTOcChcLDeAVB8qxqvCVtWfW7TVMKnNsRPWO43WcdWwMFlQRgVt4hFEmLqecAJhCT
 WvJTP6OWOATqWgMqdCCNga86Gati16xVKxA9RPAzXbEkSMBc9CL+q/OjsfyvWTRuLolX
 MyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364980; x=1789969780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wu0ntsqZihHJ4PPmK9hFYIwAA6IxkEIGvvI3l0p7Gak=;
 b=ifLmUzTO4/SGYBOS7sUg0QWLZyLcr4RWEsuR7JPT7Rb7VGXrrZVGBlzfhadAHCwTgn
 DAL1JWsY/2eTTqerh2Sl8uksI0DVZja1/PwFQIdZfvlcSLdJ9phSNC+GPCQc5TBCg6HJ
 UjYtAmMNuxurstbdtVOBRjVKkQWFnIwqzxLU4evwwNB/9Vq+zBEAhD4DOk4H6rgVbG3G
 nmpDp6DRXZ8ly1COV7WK4V9hCgaMaPZnoosN8cpvTV6d9JieI97vVoinQqvKhdZ1yhg5
 P//0DnrvB4vtOhx1IGemjlN2jX9a2Vpfbwy4H/7W8jZrVtg22g48nXIY1wdDZA/tKvQx
 rDVw==
X-Gm-Message-State: AFuF++mzQ0OPvRVXNT6uX3KjBUgSS0AlTaFnJv7UH3sD46hjN3M6qNS2
 PiXhPIE1wwDNtOS7W5AzfyueBrduvQeG2x2jYYQbIxFgrQpgWSbPNZej3Uj1t8cdj5/XP9I0BQo
 8xXiqBLA=
X-Gm-Gg: AYBFou3mQgmygd5JJAgARu5NIzZsK0hnOayg/oLYNewNJ5Ow5aqbI1ItdBhwu2V079H
 KcU6/ip874Psqtw30KdyttJE8skJ9zBFRb74vquwQErT2v2gm8OrzBzdaob8wDm6XdyT2D+Z6tN
 ptXUIiDaqYZZteEshFABFDw/kB3nEPc9tuD47krcw6M2P59h8btBgm+t+vzLk1OxgAObNkMCwg2
 4zuDo6PQf+4dupZuZU1rGNdVKkxMtIpJ0yVWiibvlP6G8PXb1yNsNkpkuJuIc7mjnGVxxlZtc53
 Z6iIkG3fipsNP+bpIhWHa/CJzXbbs6/gLwFe8hCarKTGXgkbcyzNScEb40FfaWBl9lFaw6/+PUX
 UUKg40kKXb9ukc1YKpA/1hBwBfMDC+cy1lNyrcFzYXo6kpc8oY/s94v7S5bnS8RV602iGTavo6O
 zVzxFH1oYsqq7JIZy//eCOgyWZlGkfJAg3yjx++2SahEircSLCfBC9RlDFDsO6PItpNW+GkX8Ny
 4DP4pvoEFhZEzZYdET/T9jM1IVU9wkzCuJXDw==
X-Received: by 2002:a17:90b:390f:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-39debf78031mr2270188a91.6.1789364979859; 
 Sun, 13 Sep 2026 22:49:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH 06/62] net/null: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:37 -0700
Message-ID: <20260914054912.755403-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index 7fba3a661b..60f6f7d799 100644
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

