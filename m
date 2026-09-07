Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B4DC79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9AB040DCF;
	Mon,  7 Sep 2026 19:05:48 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3A4A340DC9
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:47 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso2020109a12.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800746;
 x=1789405546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PBiHRkhLa9RBIxayFmhNwOFfxqghOKQyQedSADjhl3c=;
 b=HMOYB1kJhtzzzW1OEJw4ZVUBe2rBKqvhSu+C7CemhGH/7Dy9US+d+0eo8964gLm0dg
 Lg1CPPSGwXCxcKxmY2mco9iPAdREAMRcRmR16K8cTuBRvXNujYtczwUOyjtHKWwEUrM9
 T+siJnWMbmRdvnhNoT0uzV9xZk86s9UE4WwFMVvccvV/6s6gsyIRL488H1f6ef3sbqlj
 QzbBnK/psDCMt0C/7vudp2rAasexlc8unT398tWaKQjx5mgrdrR94PpruKZLKkbeNtf9
 8gpXNvoFJKFdKqi4C6Jek5odevJHClZULmRjh2/xvw67G706au2hVoxC5+ZsTktIKna9
 +Vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800746; x=1789405546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PBiHRkhLa9RBIxayFmhNwOFfxqghOKQyQedSADjhl3c=;
 b=nPN0iI1TcKUJxn9yAimG+bFMIBScnRL7mtFv6RK7keYCWoihKgMrUawoaeTG0lt5jr
 R6elBlxb6S018vaGEHXDhJ0jo9JAXxyg8SiSOgDC1Kn/3hZfmtlKRgg/fY8V6paXXh0q
 6zrstv/9qwWrPP3oxVbg6tKDJFCA3XDsoVBxSXchlXBUp14rV9eXmkacG22R6kpB8Hg6
 yvU4xYdS1c9cjveyuLmSJ4tqmIFvCoQwszaYmAkDdjFUa8hE9ITXFDlr2FaJK0fOVaBO
 Rp+khu2HmJBVfFmwd/sWv2uGr4WbEBYxzZodvJXJyoj/NtXR+W9/cAZpQjQDCU2lxdwv
 LgtA==
X-Gm-Message-State: AFuF++lyWhHeBbygDRX0jxxct8XUm1hbtTkwGEzFGTNxhadFidoQV+9H
 TTVQ9fxLQ1dYv0OzdJQutf926HEZImtrxXm8G4+yMY45finZ79SFDhyKKTJsfeLNH8jK8OjzOOv
 /JBwl
X-Gm-Gg: AYBFou3R2rfSY5+llcr0jBBRczIX9UR7EooLmOz4icQdd2WThYyNedYfWhaO4JEYnCh
 IV1ABYSJuZ+u/XqMA8xfTd1Hmt2FBsRbjPcr5cE9/FtoIPv/ziKdr+li0lteqO7Y0/VU0fq092h
 XnbiQMQGj6GleGgUFSFLIU+4/cJwhPpWfR4H6Hgd0lCYhy40iZN7JJhXzNJP+fVpYQyLtR8nBOq
 xIdPSJvaszdIhupK3peSVDWpXpE5BaEEg90P8FPv1LFgZkVYy7LlD0hOPlVSERNRnhEkJuFHqK4
 SPDZbeivoqFlP4HMCLUCkaVWt/jB8p8EgQpgXAPIDIHqG7gyxMvzAh/2n0+pOFm8XyH69L1RIyg
 imKlbXpbRtoFPs+cTtTcE4inzgPn4E4UjdeMKbnJdfIeCt7xGOvKhLINEjptLENe0tpGO4utA/p
 H8LYYM8qx/xYkg0UPdGPbYdQOwO98KRuliCI2c5i5J4S5j5glodw+5lcdD9c2jORE+ic5GC4cPo
 64yf0yoAzeK1tw2sIOo8meujjc=
X-Received: by 2002:a17:90b:4fca:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39b260dd278mr35960374a91.3.1788800746268; 
 Mon, 07 Sep 2026 10:05:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Remy Horton <remy.horton@intel.com>
Subject: [PATCH v2 11/13] examples/ethtool: fix exit flag and unchecked cmdline
Date: Mon,  7 Sep 2026 10:03:29 -0700
Message-ID: <20260907170454.351647-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

The exit_now flag is polled by worker_main() on one lcore and set by
main() on another, but is a plain int so the load can be hoisted out
of the loop. Make it volatile.

Also check the cmdline_stdin_new() result before using it.

Found by gcc -fanalyzer.

Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ethtool/ethtool-app/ethapp.c | 5 +++++
 examples/ethtool/ethtool-app/main.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/examples/ethtool/ethtool-app/ethapp.c b/examples/ethtool/ethtool-app/ethapp.c
index 489cd4f515..68c8a29b96 100644
--- a/examples/ethtool/ethtool-app/ethapp.c
+++ b/examples/ethtool/ethtool-app/ethapp.c
@@ -4,6 +4,8 @@
 
 #include <stdlib.h>
 
+#include <rte_debug.h>
+
 #include <cmdline_parse.h>
 #include <cmdline_parse_num.h>
 #include <cmdline_parse_string.h>
@@ -914,6 +916,9 @@ void ethapp_main(void)
 	struct cmdline *ctx_cmdline;
 
 	ctx_cmdline = cmdline_stdin_new(list_prompt_commands, "EthApp> ");
+	if (ctx_cmdline == NULL)
+		rte_panic("Cannot create cmdline instance\n");
+
 	cmdline_interact(ctx_cmdline);
 	cmdline_stdin_exit(ctx_cmdline);
 }
diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index 6545eb322d..ddd256cd7b 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -44,7 +44,7 @@ struct app_port {
 struct app_config {
 	struct app_port ports[MAX_PORTS];
 	int cnt_ports;
-	int exit_now;
+	volatile int exit_now;
 };
 
 
-- 
2.53.0

