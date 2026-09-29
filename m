Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B612BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 242E242EA7;
	Tue, 29 Sep 2026 18:38:42 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 4B96642E5B
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:22 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-882c2bcef77so1771652b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699901;
 x=1791304701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74LFEaJWlcn4DQMWy05I+ZzfEepgvRkcxN04NLTnYIY=;
 b=Da280f8gQBvd+ibd/FmC+UePxbsLGH3YdfHptHRfgLibmWc3WyBLDS+QDbzhwYRLb8
 D9bT7tSThdccv25IUbVjr1i638vHS+LArFoTWkf7j3if/XyoDO8FvipYDmLkQ0hKkfMA
 5DlY+jekHA8g5mkXtogESnkuk9vKeyncJbMj9kq/P4pP2r2yZHa9UqtxAF5geo4QgDNC
 FcCkvAa+Qm2/NA2N9IySIW5mHYFHmhKBIedaprWeHJLK4BFKk179C4zRnUQ8mpeHOe60
 w7W6nFouYV2UtI/nXWHv21sNfWSNNlnl2DF7ndBcwYqNnBA75ux+BlYO5nxpXI5tYRxc
 gcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699901; x=1791304701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=74LFEaJWlcn4DQMWy05I+ZzfEepgvRkcxN04NLTnYIY=;
 b=ECMuQMdWL7Go7a8ak20eWLPH4wWZM1eus/Zvvr4xa9w4X156ZeTHYgLmUrOTCFr9UQ
 Hk4qYFPRQj6I9TNNZPnIfl93Mx1UdWr54hj6TXxMQZkQDjz9VndxqL4ScMKx0ODR/Eic
 HHclqqb9bbmlKQK4zs9QT7r/c43U+k5UiykHLpe7q/ctJoZP9uRCgLOqGkB895wEEiIh
 b94g8DRBJISnMATA/T6tDdBRoPTs7T2IoDFMQRph4VD3uSxnJHg8Q1+eANe1KAu3wzE7
 hu2le1/qjrjSI5jUAsMjIGipbv5epbGrWocry+OoOuRgcAzITofGrFyCDxAfEngAYJmF
 4Fyg==
X-Gm-Message-State: AFuF++kpjmrcuQ9Wh7NHFFilVMAv7/jyd/FLMn/ZlzdUj+I95ThPiE4P
 jUtQRZu4OHQDqcxcDgpk3ANZNdsXDIu2Y+5xLC74KysyemLM+NjsftfaEGE78p4b9hcNjWcsx3n
 ky46ZyDA=
X-Gm-Gg: AYBFou3Wb/tHY36MMURMh64KHFZYaYiOuEoeFDabrW3hdGYERaqUGD9sikzhZqKd3HO
 nT/+7vaqFEnyQfIo6FPd+eZzp7Wo8gCrfa67kf1oL7JRrju69BUT881k0qyfmVb98P5iagIGVdw
 jddAp4/eLs5QxHop05W+SyU56awACEFg5wMF4VjOL0a4fEZ2q5CgW+7mtqHyNcLDyYAZ+teOEWk
 Mh61wIkQMbYtEruZFlV6Rqnt+ah0LUBlkfvns2H7+bFs6+YdtvUQP2pzEAJfywdJobwfvmAfsva
 LHo88VKIwVsmxLiNoDSJ3i3sbGfoufdkrnjg+7fdnX5Xh3wn0aiJB+sVCQkPyetTY7nFZVZd6Dy
 YiDED6BI9Vupnt8dtR/JNfNj8vueEen1Oc6tbxy3JDajI2G9AnzSMwzNb0YSiHXtnmXOh56x0tF
 xXwKvI0UsqS2IXgVmxpi2sj59oDf7DWTKZkNSJhYYtBPagLTj7rpqlOltvVc4xS+iBlZGFu1T0a
 O+gRk7roSKieAAuc0fivv02ZNFzD/jPEFCJrQ==
X-Received: by 2002:a05:6a00:4c09:b0:882:7bed:3b3b with SMTP id
 d2e1a72fcca58-8827bfcb1a6mr6334514b3a.36.1790699901480; 
 Tue, 29 Sep 2026 09:38:21 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 15/61] net/ring: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:18 -0700
Message-ID: <20260929163800.1108305-16-stephen@networkplumber.org>
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

The node number is stored in an unsigned int but converted with
strtol(), so a negative value such as "node:-1:CREATE" was accepted and
wrapped around.

The value is also passed to strdup() without being checked for NULL, so
a key given with no value crashes. Check it first, and report an
allocation failure as such instead of reusing the empty parameter
message.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 4cbdbe3085..a8d118bbe2 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
+#include <limits.h>
 #include <stdlib.h>
 
 #include <eal_export.h>
@@ -579,21 +580,25 @@ static int parse_kvlist(const char *key __rte_unused,
 			const char *value, void *data)
 {
 	struct node_action_list *info = data;
+	uint64_t node_val;
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
@@ -625,14 +630,12 @@ static int parse_kvlist(const char *key __rte_unused,
 	else
 		goto out;
 
-	errno = 0;
-	info->list[info->count].node = strtol(node, &end, 10);
-
-	if ((errno != 0) || (*end != '\0')) {
+	if (rte_kvargs_to_uint(node, 0, UINT_MAX, &node_val) < 0) {
 		PMD_LOG(WARNING,
 			"node value %s is unparseable as a number", node);
 		goto out;
 	}
+	info->list[info->count].node = node_val;
 
 	strlcpy(info->list[info->count].name, name,
 		sizeof(info->list[info->count].name));
-- 
2.53.0

