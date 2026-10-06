Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A805CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C501940EE3;
	Tue,  6 Oct 2026 04:31:22 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 9689C40E4B
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:21 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e5d759038aso872705ad.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253881; x=1791858681; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FLf+P7YLMAyGFrxVlFGkvTSst9FKJwGCWzuyV96vFj4=;
 b=QuShQsRBs6d4Z+2wXrwubVHDG26bpkuqaxh86PCDwA0Jlpeh7iD1ecNltWadV1CFHc
 k9Y5dR8f6HVmcnbndU62y10KNa+eujkqWq4MMD2RjKzNERS0QhWdod2HKTIftGSrudnh
 4qDf//8rOYwVfyFkPtwF4SHAL04qj/k+/TLdAWCgWfHZKrVFZFxvV5SV554cqBqrUtDx
 pIfnpiD2PiiwWLyvGvkaI9pNvwEgj4FD9kRv8aI/qOUlE352lDlMEBmsYEq9e+f20oEY
 RHYXD3uYTTRRAgIiXuiksJnlUPXR2iHfUUKoyBK8KqOfuBZBUXlKUirSuzvITbP95L4i
 ODZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253881; x=1791858681;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FLf+P7YLMAyGFrxVlFGkvTSst9FKJwGCWzuyV96vFj4=;
 b=ut3TRRhzbGSb9K5f1X6cWGN4BYlB9o6ngQwhipjybNZAhjwKgc9Nt4PBnKQg6Ic1/G
 Sk3xRSeTbVRCFeHFCzx/tj3LZe3boVJ866uF0Xp2gIlYoOV+uLjhIArPY5mF8DN02oTc
 cwPYh2mEbbg7KzVb/qQJjLQEEt4z2w1nbLt2KcHlizZXk86G3uhwao3aFbd7tWNjJYxC
 TNZsavYZpesW2EttukW6/AM+Ge9KEBQVMdt1nS08Jc+Py+AqKVCrozVEhhYItZ+8a4jw
 teIjRdiLFGbDVGZtEi0HnrtbK6IMN3sG/I+Mp+zE43ynZ10IK/uD76cxX77mftWtiC3S
 ZALg==
X-Gm-Message-State: AFq9FYJhMBqCUqWNjQL5EgFnSdYca57nkKJ8heoeKc6VtcrS3XDQ+E4e
 lpICxnxnKTNrSaAZOBijtgIMS6JUFbRaPRyjI2CLF02SQ7FdBohfXvi7teBGqk8XemMNE6Uwvj+
 J1mN/nFYY+lz2JA==
X-Received: from pleu14.prod.google.com ([2002:a17:903:41ce:b0:2e4:8c17:4dad])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b88:b0:2e5:dbbb:6c7f with SMTP id
 d9443c01a7336-2e5dbbb754amr879565ad.1.1791253880392; 
 Mon, 05 Oct 2026 19:31:20 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:49 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-14-joshwash@google.com>
Subject: [PATCH v4 13/15] app/procinfo: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Reshma Pattan <reshma.pattan@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/proc-info/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 5925bbb765..9c22fb8f01 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -48,7 +48,6 @@
 
 #define ETHDEV_FWVERS_LEN 32
 #define RTE_RETA_CONF_GROUP_NUM 32
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define EEPROM_DUMP_CHUNKSIZE 1024
 
 #define STATS_BDR_FMT "========================================"
@@ -1830,7 +1829,7 @@ show_port_rss_reta_info(void)
 			return;
 		}
 
-		num = DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
+		num = RTE_DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
 		memset(reta_conf, 0, sizeof(reta_conf));
 		for (i = 0; i < num; i++)
 			reta_conf[i].mask = ~0ULL;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

