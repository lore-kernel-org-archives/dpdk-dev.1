Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6860A260C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=L3SAuoy6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FE140263;
	Fri, 20 Nov 2026 20:13:32 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mails.dpdk.org (Postfix) with ESMTPS id E07A9400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 20:13:30 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso755795a91.2
 for <dev@dpdk.org>; Fri, 20 Nov 2026 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795202009;
 x=1795806809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5eT7B66XwQh3/Q6XVYqoEkI0djMboo4yiq8EwFIjCfg=;
 b=L3SAuoy683LdOJxUcetn4KzIEQpRwkpkRuxZbHr7m/zso307hXkfk1PAqIqY4O/J61
 Pt++W0WNbUSIjKeWpfYZ1oVQpdApHPcpM64FshjKosLobqH4NHOXCqkpvNuYlltF3HxN
 S1pdK2o0NQ6eTy60o9KHQYzsfpM+gsDahjXXeMW61KV44P3PSw0tJmauZ2DTE2UGgNtC
 pjJTpvBck7SHxnXUwX5zUNTGmbCoA6Q12/Wl9MifRQmO5UAvy3nzX68RrFXHga813Wh6
 soBsbgbG3SoSIE9tfsabDMY+kOG4B5vihJQZKTtfxE+dwkZ0k+kauhNjZwFw/Ir3qHy1
 095w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202009; x=1795806809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5eT7B66XwQh3/Q6XVYqoEkI0djMboo4yiq8EwFIjCfg=;
 b=zY1fuQGTPf4eVYZpWsR8dwH4rOliOK5xQOrUCqOAjb70BLHsowcjvxCK07aR+nhPuq
 9qdgSSwK88h7I/+r/6xXyT2XUkbzr3qV++57ADywhJCPQ1eMuwK93fVQyNS3dROY88KA
 nnJjdATfkNgkY418DZAFd/EMQi6uyQPAg2thMr7ivkqEQXm3/PYXc9XROR7a6qX2M+6c
 1QLp3vn8I7bEaPpzXM09LbSEPRQeBINJKhyHSlkH1ZwrTepV3DhRTA8gS5kO7bjJXtyK
 ONqe7mW/PPo2r7eyVUIgEFUc5ANSGJCqIuo2d0dq1YrDqKVtxwsTX1HpK4QTBeJo0uT1
 lo8A==
X-Gm-Message-State: APuU4Z+nYs6eBNvWyqPx/Bjjo6b/e4PsqTIGKXKg8S3uXCaDxdjozK/L
 i/15sPoeoBW5SE4jR9e8xCuq362CFuEHwf7FL242cigpKCjhxThAQsKpBC9lrMrhaCMIpoHF+XI
 9UkNAbeM=
X-Gm-Gg: AZFdTZeBc6/Ox1Dizw62l3UHLi/XmolHzAMin1JVL1yzILtBs8DwyuQGGspP5GAfFvX
 hKSDlH1kSRN+qc/oRs0ccgYn8PLj5qMrqCGqfTIt0muAiRhyOwYWIlIEt9KuVFSLVyl7bwu7lc+
 MWkzjzvgZ+73j5+U+5Q2OPj0UU7e/Zzym7FxG65QLQ6X2WUKic1e3adZLvK3pa8NlhFIt+7dv8k
 XhZqEQopn3vZgpAoZS/HE7Xl7DdoosXJIFPuHqc2Q5xlP2rjf17bRE8UUqgK1UvG1e/MdNeWd+L
 9F3FxtB1ZJlotd8NL04vc6jVVPgawDopj1nnb5bdIlUSCJVAw+NOeakAB9nKM3QreY3a6dsrE8x
 hekeg1odbZCC6KAhaEKcIheabT5ceHjds4mqb1J+CTI2UOfYD5UjduD+uf5GXJxL4445/KstDin
 mViYzIydKUh3HaK28ecD2Xk48D6EVHW6N9Rxpsxz2W9wl5tY2h6ebSmqumXX4N8c88tes5s4nHk
 BftoxguXW/Kx3+Q7PkavUuryeAaGkxQYVdLA4kS7G3E0TtYTgbwLyk101KKvsyrTvBcZeDlGjjN
 U42ihO674g/WysdRYLYV7LcEG/e2Ajsc4SBXOiVYwYIJQN72BJ+J/GMKf8cz+i38qlqP
X-Received: by 2002:a17:90b:5543:b0:3ae:8106:6074 with SMTP id
 98e67ed59e1d1-3b41c8dc6ccmr3538628a91.16.1795202009059; 
 Fri, 20 Nov 2026 11:13:29 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b6fe711sm188324a91.1.2026.11.20.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:13:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] examples/multi_process: check return value from get name
Date: Fri, 20 Nov 2026 11:13:26 -0800
Message-ID: <20261120191326.4052618-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Coverity ID: 511674

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/multi_process/hotplug_mp/commands.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/examples/multi_process/hotplug_mp/commands.c b/examples/multi_process/hotplug_mp/commands.c
index e84e130b3c..b4cd073a4b 100644
--- a/examples/multi_process/hotplug_mp/commands.c
+++ b/examples/multi_process/hotplug_mp/commands.c
@@ -35,13 +35,14 @@ cmd_list_parsed(__rte_unused void *parsed_result,
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
+			cmdline_printf(cl, "%u\error - %s\n", port_id, strerror(-ret));
 	}
 }
 
-- 
2.53.0

