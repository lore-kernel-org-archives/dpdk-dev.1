Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD2606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Tmn0n4S8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DFD8402DC;
	Sun, 22 Nov 2026 18:36:02 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTPS id E0183402E8
 for <dev@dpdk.org>; Sun, 22 Nov 2026 18:36:00 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cdb2dfcca94so997623a12.1
 for <dev@dpdk.org>; Sun, 22 Nov 2026 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795368959;
 x=1795973759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKzHw789HuqpOcT9ZsENKOv6V0gWfiOnIweamVcuAXw=;
 b=Tmn0n4S8/h5qbh6c7qMBSZA2HMEDR5kF/XNy9M2wxQvbk1avE8Y/W8JgJoHKWRfS89
 KGeZ2rQpE0uC6r51plXPhD34aZMEItDxc1gT12l2Lk48yChJMB+fcipOoM2gH5Z42D3n
 +kjzz6PFDLsmYH/lb1K313Fr+g4pvbczA6s/1lcJqqdL7rF4HXbt2FocETMejZjnYP6+
 /qKwStzHiRl9P12X5ZbLTjNWXsEm03Y1myx7yjyuaPe+PGpQiGTzvc82ggibEHIQR6dL
 JkV4fyUiQIxnfS4K8Fxy6NI4ygbuls8kDB+l21hE5wzRvZEEQxLP+PwPMuziV3MTu14s
 DBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795368959; x=1795973759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wKzHw789HuqpOcT9ZsENKOv6V0gWfiOnIweamVcuAXw=;
 b=j0+AuwZ9qG09TuZusNiBPTeS5XEDfd8tGz00zVjADwBSvzAhKjQUQB7EwDkQT+egQa
 ybL5V+/AM9XpSJEGN/ZCKSokdHj7+TAbu8BvHCoBup3ihQEmTiDa5JdullABGpPszsiy
 o4QeknwkS6Z92UMMesNhvjF8BopO7aQ2UcLN4vrOzqWK6JUue6fQy5W19Kkd/XoFa5oI
 KlbXBrtduHW5BSlQcjUCjE+HwuP9eqQPhlgpJhW4ZkuNddowXwzL3XK+TNiBUQmx+XWa
 DIYaqo2mrenW/2PwRTEGc0w20a6ikMbp8DJMdWB9q+1miJlTThGJi5rl1sW2yMnBwaqO
 Cxhw==
X-Gm-Message-State: APuU4Z/bMTdL0KZKBPHOdPK9hXdiEOJC7hVIvkQh4RltwLOrtsCMV4ah
 dhgcD4uQ4JhIyqHo1lgDdgy+aq9nAT2TelrsSwnBjjePAHfNcTWYzYoN2JdIEmBdyavWZkp1Nq6
 xNCNI
X-Gm-Gg: AZFdTZcLyGTLM5Xw4LNW/j9p7tcPuP4HFFy3if6s0oPUgXy+AgzQKVEUEkp+DmqG8QR
 Untu+3OqQfdyfsDE/bW1mboIViG8QjgZrHWeYT2YnVYSiM1UfnXdSYJQ4go3aOwzBSvX9vEWIY4
 ZbFGF8otkxBpHbDJb4lvSPgRgcfeKHHjoQAp7oRgsUnh+JuHq8JWxArBE9d8hTRtZ6DiWFs0Gj8
 GABjuiCe4H/j2kqDEvSr+CTwwkqjDehTfCjXVONZrQWCOY77wU8L7+//Xlvg5s/HIEFTn1hM3dl
 tJFs5p8Zwi/H5PfnR6tWWlLeFD+a1YVSDriF8udWx6XTtJ6cVaplekR0xUZsGAX6JomswzOsRrA
 +YL3LTwHt0VWlNxUuJpvsnkOeCHzGvoNphyXv0nJvsGmuuXDnv6eHiAQ6y/AVdSkaQ0Gh6NEEgK
 CWSH+QhzevA/laM724GfZCvsbr/CyiKiCVQD+zNysttKqPbsgXSMPNg9+v+6N+0vJ+Ao1YvkJwb
 +r5LqjGzu8JqAVJciZict2HFxP4i95auq6KfWK6FhJ7qouFkxdlNS7fEbqDpdiMv1eDTqpcMmdx
 v4SaMYIfGv+R0ECETaaIriB4PN9d/JgYJsBLcFzB+mwYxUGD+b4enQtLKsYFZkYbUKxP
X-Received: by 2002:a17:90b:3890:b0:3b3:8094:3221 with SMTP id
 98e67ed59e1d1-3b41c981a3cmr8404430a91.59.1795368959000; 
 Sun, 22 Nov 2026 09:35:59 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d639fdsm16891532a91.10.2026.11.22.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 09:35:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2] examples/multi_process: check return value from get name
Date: Sun, 22 Nov 2026 09:35:20 -0800
Message-ID: <20261122173556.105738-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120191326.4052618-1-stephen@networkplumber.org>
References: <20261120191326.4052618-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Better to use the return value of rte_eth_dev_get_name_by_port()
rather than depending on side effect of name being set or not.

Coverity issue: 511674
Fixes: 05f1d6842fc3 ("examples/multi_process: add hotplug sample")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - fix printf format typo, and commit message

 examples/multi_process/hotplug_mp/commands.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/examples/multi_process/hotplug_mp/commands.c b/examples/multi_process/hotplug_mp/commands.c
index e84e130b3c..7179a5bf8e 100644
--- a/examples/multi_process/hotplug_mp/commands.c
+++ b/examples/multi_process/hotplug_mp/commands.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2018-2023 Intel Corporation.
  */
 
+#include <string.h>
+
 #include <rte_bus.h>
 #include <rte_ethdev.h>
 #include "commands.h"
@@ -35,13 +37,15 @@ cmd_list_parsed(__rte_unused void *parsed_result,
 	cmdline_printf(cl, "list all etherdev\n");
 
 	RTE_ETH_FOREACH_DEV(port_id) {
-		char dev_name[RTE_DEV_NAME_MAX_LEN] = "";
+		char dev_name[RTE_DEV_NAME_MAX_LEN];
+		int ret;
 
-		rte_eth_dev_get_name_by_port(port_id, dev_name, sizeof(dev_name));
-		if (strlen(dev_name) > 0)
-			cmdline_printf(cl, "%d\t%s\n", port_id, dev_name);
+		ret = rte_eth_dev_get_name_by_port(port_id, dev_name, sizeof(dev_name));
+		if (ret == 0)
+			cmdline_printf(cl, "%u\t%s\n", port_id, dev_name);
 		else
-			printf("empty dev_name is not expected!\n");
+			cmdline_printf(cl, "No name for port %u: %s\n",
+				       port_id, strerror(-ret));
 	}
 }
 
-- 
2.53.0

