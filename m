Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B6EC79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AE7C40A75;
	Mon,  7 Sep 2026 01:28:05 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 3252340A75
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:28:04 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3964dfb5b9aso3692262a91.1
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737283;
 x=1789342083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CGiQD9KGWqJZuLBK0ilYxEKzK+L3fjshUm2ysloCUIY=;
 b=WVOoAOEdPl1owjEGhjFpkMaUAZuHyspgLCwLbZu2VPD5FqXz2KKa7CxC76d8Ib63MJ
 g9XNHcKWnI8YfmDvOchgcvSpx+ZJmdRLtYTuSuXEbC+t3eJBEhlA3/tWzBiVZDc/dOcV
 FkRAXpNICzbpOkycAhnIpvRc/QvBgJyAPXHtTTLGPvgqQIP/DJoOU9vRfDYKQcmSLkzw
 5ScT6qy0QAhXsSo90QIBaDMCMuS7sd6Jj9S1mw65bQ1KDmVpDG2U0zigQ/st49Bq48UD
 HwIEZbTs0fKMBXKuGgHiEUs2KJLAQ5MLK5YpMXcOJ8KjAqxdsdq4sfByCO8anvMFeFbT
 DH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737283; x=1789342083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CGiQD9KGWqJZuLBK0ilYxEKzK+L3fjshUm2ysloCUIY=;
 b=GmDCrQTLYAaHmWxmFJXmE5LKY/unLcVhbs8fFBTcYtSGv94FxiXVp+R6TnOwQepHHB
 yYB0SjtJ5hI7REt5DL/7/hhmCikUZCBKEzpEwbqXp0I+yBIaJnrdBPhKuf2V01xgjAMg
 7femm7ZCKMNOAztG9CnUnYoWsDtS3MRYtp1jo/HacH7nsAJPAN/VxDvN2aJUtc5qEvGg
 AIi9pnVb5Spo6qwqQz9leCiFT0cjJZyZ3sIJvG9hJptvKwJqnil4NFivqDkolDUM9r7p
 URPdLU0b447qRYQkt5wlr4iVMvAmbc5yGY+K6bRMyYtiJRucTj7MZsFJoLPr10tI03Yw
 yaHg==
X-Gm-Message-State: AFuF++n6cWkAK69gVWFX0Jbod3aaxN8j6jt3NMBI+MjPhj+JgiPbW+o+
 rhRt0wKquqgP1HJ2TavgpWN/EU3yLYHM5QN/huOu8hO0z8tTCh3IaDaoExpPFL9lIioMTCtIFus
 yVBrb
X-Gm-Gg: AYBFou3yksvMG1ySiDwOlw0Th4hSNUxSePhv7xvln55gM2schGAvscnMpiP9vO9xcGz
 K9ZkV/kMlj/Ztg3bC5RARNS2nUi/ahFa7npi0JKTvq9xO0pERpDPlf0qP4xwu4D0h5r5gFyBL47
 PDAuiJStOa4FqWBSKCfMzyElgNIu2omANhyxvsFubzKS8RJ4QJjgXwU67hmqxixIO3y47A0sbOi
 rsmwM1o4u01QNZni8vi/6+kmovXzMM4kghSqv/etS5nX2u6PUwn+3GoKEqsrJTV7aGgO6HB15Av
 SdWkNv4jFfgnWZtnjr1nFR6QHppIFZmvFy5vVmdo5OvE5k/jgGffDzu8lZwpk78/gS785LuSwTw
 YwShlYcNw2+SlENTw5nKNyHNsFcd7i6odrOVNTKNpcHjMHY7HPMXdo4Q4N7l3LFqTzymcZfGzAc
 l7tfH+0kMouwyHFnMtmavZ+7/+YubxX5joYIOgVYEPDQ8mYNq6NiMJaTDeTm7dayzeebFFlArCu
 vfHufTLtD0EFG+eYkM6wRC7euo=
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39b26203f11mr31316862a91.16.1788737283356; 
 Sun, 06 Sep 2026 16:28:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:28:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Remy Horton <remy.horton@intel.com>
Subject: [PATCH 11/13] examples/ethtool: fix exit flag and unchecked cmdline
Date: Sun,  6 Sep 2026 16:24:46 -0700
Message-ID: <20260906232716.496546-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

