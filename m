Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCAFCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95C1C42E9D;
	Thu,  1 Oct 2026 00:44:03 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 8371F42E7F
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:00 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so2521227a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808240;
 x=1791413040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FFWaxUUfTczKQ+rav4H8G3MqbY/GD73mmnSjp9ERsnM=;
 b=W+Whyizpaw6ogn/7YIl9+X5LRdTnjfis+mTu+8WALnHY4h3RGiZ2miNahqji4GlKqo
 7uH21t+gIw9dp5VP7Sd5dAwF3Ws2YIMNhw1WW9m778fkAPXOrt1CyBMiZd/CKPQneIc2
 SUrICJt7CozFFHdSfpb/x0v7WUePR8jZFur4ySw/8GzJn+nK0YjQg4UKY3mIQHYi/ZLL
 1z8aXoNBEiaJHilU/A6Z7ojRovrjEKbIoZAFAIUnRmJBLHmMq09kRiKIjAOckptX4Xo6
 haqmJ0BB5ysj8d1y5tabklFvDXT4NkHCCbt1nj9v6SVWwl4b99kUDJNh+1fIMLMFOFt+
 viag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808240; x=1791413040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FFWaxUUfTczKQ+rav4H8G3MqbY/GD73mmnSjp9ERsnM=;
 b=g/ruopKsaFublRD9zLBysUdRRrW91d7i4xCYY8j627p456welBQH7suZ9xkgEZwuXD
 l/ANrw5inv7QlvkDAu2csradA9/kbYDfUDG/fyPiLj06Mcmt0tCPysiw59yjChvoJllO
 TLRTZYevV87R8e9x7nnLL0fKn9L4c2VWZT0ArTHmO2WvSqNUcj4gkZPRJHTr9VUvuz6p
 Q1bt2JPeMZqsX1XkNhfzpC6iZ8/3nMekFeTcOOQHEL8+XO/8FcRFEYd7uKm9UCP8AuLO
 8qvbonaqPh5bhV/1QBTJ2UEGYA5o3CCuMij7GL2bkYBTgDnSod5wRemzH5u1a0a+5Twz
 qBFw==
X-Gm-Message-State: AFq9FYL53hBd6pIMRursZywRZluhPBx/Y1ts8amLcNyQoCA6OZS7WIBM
 jR7xE2FgYs1Y6FslEQV1Tm3wTdAmvykdbQq1ioI4r/oDhLA6DD+cpxxybdzDfoG4pms/ljPeNs0
 H722DyGY=
X-Gm-Gg: AYBFou1lwt5Eon0qIaEWcWVTrpYeEu4Q0QqKvFqSeRM+0hbWm80UW8KokyZTPtDrmAb
 e3z5SV+0eCn4k0geCcavpbmuejoyvzi7EYODdGW67NKUaBfeCKc1tMiwpeccO7SGgjJ/7IjyO0i
 vv6e9E2TgAVDZLZ4l54YRfYpUPkroXmzygda1QnPkmmT8fOiW79yzydWHj/RkMNyB0YZ6MOo+Mf
 NgSdHSHlk9+ayW/jY5qXvBuDW4wU+grhilYbokrjA+Mt247YXERS7Tufu6GkAQ4tgLgBQiYEELT
 F0/Slk7SHAga+UrYY5VPPsoDtEXsgTYXK1IKVNz5vJm6QrlFgcO+HRobInmP+GwFId8+lAPTvvn
 S5ZatPJ19Q8yQF8P6wof9CeX2gKNRMpheaOiaXzn/T/RwLF8LMGld+94PiYuAOS/gzi6Sf8C9HN
 X84XxJTyxkn/9kLAzLsqV7s11VzvzW7bZbG71SrmlOXFJmEWkrgFw6SgIxqwPUCI6msVdQ+TYvY
 ic4zeN0MRsqZPhTd+D+Su08GtvYy7ahKYCSGb5rr6GIMabI
X-Received: by 2002:a17:90b:3c8e:b0:39e:3554:4d0e with SMTP id
 98e67ed59e1d1-3a4d0f07ee7mr993726a91.1.1790808239245; 
 Wed, 30 Sep 2026 15:43:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 16/65] net/ring: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:34 -0700
Message-ID: <20260930224340.58580-17-stephen@networkplumber.org>
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

The node number was converted with strtol() and checked only for
trailing garbage, so any value in range was taken. A socket id above
RTE_MAX_NUMA_NODES was accepted and failed later in the allocation.

Convert with rte_kvargs_to_int() over the same range as
rte_kvargs_handle_socket_id(), so -1 keeps meaning SOCKET_ID_ANY and
anything above the last socket is rejected where it is parsed. The
handler cannot be used directly since the value is one field of
"name:node:action" rather than the whole devarg.

Report a strdup() failure as -ENOMEM instead of reusing the empty
parameter message.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 533a4c1b6b..a2ac704a8d 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -579,21 +579,25 @@ static int parse_kvlist(const char *key __rte_unused,
 			const char *value, void *data)
 {
 	struct node_action_list *info = data;
+	int64_t socket_val;
 	int ret;
-	char *name;
+	char *name = NULL;
 	char *action;
 	char *node;
-	char *end;
-
-	name = strdup(value);
 
 	ret = -EINVAL;
 
-	if (!name) {
+	if (value == NULL) {
 		PMD_LOG(WARNING, "command line parameter is empty for ring pmd!");
 		goto out;
 	}
 
+	name = strdup(value);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	node = strchr(name, ':');
 	if (!node) {
 		PMD_LOG(WARNING, "could not parse node value from %s",
@@ -625,14 +629,13 @@ static int parse_kvlist(const char *key __rte_unused,
 	else
 		goto out;
 
-	errno = 0;
-	info->list[info->count].socket_id = strtol(node, &end, 10);
-
-	if ((errno != 0) || (*end != '\0')) {
+	/* -1 is SOCKET_ID_ANY, the range rte_kvargs_handle_socket_id() takes. */
+	if (rte_kvargs_to_int(node, -1, RTE_MAX_NUMA_NODES - 1, &socket_val) < 0) {
 		PMD_LOG(WARNING,
-			"node value %s is unparseable as a number", node);
+			"node value %s is not a valid socket id", node);
 		goto out;
 	}
+	info->list[info->count].socket_id = socket_val;
 
 	strlcpy(info->list[info->count].name, name,
 		sizeof(info->list[info->count].name));
-- 
2.53.0

