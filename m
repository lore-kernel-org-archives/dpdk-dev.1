Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DFC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E84E940A72;
	Mon, 14 Sep 2026 07:50:14 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 52E9340DD8
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:13 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2dd020a2e44so26128545ad.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365012;
 x=1789969812; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iN5imejp4uYJSj4eYCMiZRVFJ30B+dEUYGn5u+6VTOA=;
 b=DzfSZ0t6QnGDY5WAIV5W/BXTAprRjonfJu4MTOG5Enj6M3U8BlgrD5IpDvfYNxjH5/
 D2JjDina3wRZLw6n4/GBXjGs86as/C1Ku953wAyIs2W9zPjNl7M3FMvVFy2zSWz8bo8U
 Hm/b8SS37JbkZH2/2CdTKxRIS9hV6auX8woVmIwqu0ANoIs2QyBuPZs/Pb4PfNACwsL2
 tinh2N1WZdpEafIJf8Sp14wjODWeKL0cgprDJsgVjjBBJef9ii2JkkmIxzDUjlM+LBHX
 Z6lg03R4xCEh+LeNA6UYqh0yBoa6sX5gFD+JrEhJZoaUJ2Omx6o+QsmI+U3+jzLrozCG
 MwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365012; x=1789969812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iN5imejp4uYJSj4eYCMiZRVFJ30B+dEUYGn5u+6VTOA=;
 b=Cly6AnV2V4QTcSDSzS/bDgjodNcMvkiOFvhuFC3rmqYRtmDuuikxl81+UeURk2od+G
 T/YKGWwevCwA3j2LmsxKNFp3e0PRxmqZdOOJlUhIoGRPsLuG35e1eiU0pe24vKvQraa9
 u53cQQyIn0qTghQqCeWURNwwrgtE3DXS81HPzJfaflmBwbEO+OylIPPhIGNrc15rMarg
 m6ItMlT4dCdDYaaHhjXChBXaCwMtVyv6NSjxcM8iao2hGyIx8erpmgPhftnSG1DDkDJi
 k/01DtYm2tDe12EQsZB3E8Owjh8cfWDcSaif/s7bZAk5SvWUKDJJRvIaa109yvOHDIWt
 nAKA==
X-Gm-Message-State: AFuF++mbF7XfTNyOzDFjlrCLfXFR4MVxVPv8r9WevV0KlhsmT+9QhsQ0
 Cm8+GOyVAVKDLXSmpEU8NYLpZ+qvPhlPtEmiyLOiOg6iNagLTP/ItwX/uvQNGS3eX2FdpsjWkoC
 meM/8
X-Gm-Gg: AYBFou1wrm995u/h8Q4VslCqzVzO4E6HSnjwY2F/0Yt+YTDXhAeO3CMfs0YmZ6QtPLc
 geAOkI3LmCutB/RCCBZktSy/YVVhzJ7/BwQDR98FsAMnQOz3yL7CFzuQyZg6KnxXlCYS+kAlwBL
 16k+TmexQ5MqTrZkEVbFuhQwdRo/Z3hl4OWuwtRLmdp9C/bdW3NVioKoatkmLau9WiJGj3yTZdF
 pRhu5Fj1mYSEQjkUvJBA/9K4pwAwgL64AjBI3uocyfFSWLE0MUhNARpvvgyZZDHXArlzhw/ekBO
 WDHI7x66Xlsv8LnSwZM6LZtU2F94HBH8UWPZlG9/1DXjxzHdufWb+egGoeLRW3afKyvQaLxcq5G
 7/lQaazxBQD4WzxiU7iv475n1XOFHtiVpwTIvu+0V0zhLUUANuogSVngHHxtyYuZMfHiCNvzOek
 yNZnrevNfIHEeozTpOHm8Z+vdJPEmdhf9f5q+LAeGnQ7sLLjf84NwjAIGWBIf4nrEpsAUw6wsI+
 dBLjeX2nlwPjmKCxlcos5L0JxId3UtJaWt2jQ==
X-Received: by 2002:a17:90b:5827:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-39dec0bbe04mr2638684a91.18.1789365012446; 
 Sun, 13 Sep 2026 22:50:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 16/62] net/ring: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:47 -0700
Message-ID: <20260914054912.755403-17-stephen@networkplumber.org>
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
index b639544eab..3a1040305d 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
+#include <limits.h>
 #include <stdlib.h>
 
 #include <eal_export.h>
@@ -583,21 +584,25 @@ static int parse_kvlist(const char *key __rte_unused,
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
@@ -629,14 +634,12 @@ static int parse_kvlist(const char *key __rte_unused,
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

