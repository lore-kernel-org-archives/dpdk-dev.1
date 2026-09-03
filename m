Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD7C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 19:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A1642D0C;
	Thu,  3 Sep 2026 21:16:14 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3620D4026C
 for <dev@dpdk.org>; Thu,  3 Sep 2026 21:16:12 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-853c07a76adso183401b3a.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788462971;
 x=1789067771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=etvqfCtVvz1vOTTu9slXQfiodrUQIp+THOBcooU9U6Q=;
 b=gqosSyzlbU3IpEllhpdPzMgyvz0ZgmB/iOSfkZJypTzFoeU94oyAsqIc+79H/7g+wN
 ZLR5XqrgYIZGGmpy0VlVOkw4dEZ8Jqj+rCvmV2EqKz6qXbBbFY9QmLLpWHXnO2ldipcG
 62/C6KB8Sq6mDvpXUov0Su+FdJEYwjD/PQzvYQ2wgTtxpNIyoDVfxJRcfK9lWvKCXBwA
 tlBN0bi5PVrAD3jmHRYMDD0cut5PZpT09g+Hyoz3u+d6pfaHkxiy4JFzVRu7taYrlx9t
 2c4wp8BozGdzBVqEoUDoEixOoniDDW4rH54x/q9TiQOvm7XrGKTkTdJcG6KLCEopfmW0
 LqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788462971; x=1789067771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etvqfCtVvz1vOTTu9slXQfiodrUQIp+THOBcooU9U6Q=;
 b=hXFhSILmw+oASobx4y+j8c6KipDoHddc6OTY40ItdXxOnllvlIJE6y1m5Ij/neDCkc
 kSK+9GX4O+eWYKjphibpqqyIZw/tD5voeZF43NeRI5mNVYES3dWiEXpnHxDIdRE159/t
 gF+Qumcfrq9u6X5JAgGBy+nrnC2Os55gFEdMNMqL174I0mFljIMsvAqFcAboYQTlviAk
 XK0RNdOCIz80h1z3kfyTxRg7FGJRyfee9kf0LRHzkeCwEc7Z85FN3ISgSpIEsxMWtUmA
 uUSKMVFLqztJyocEu0GMdVmni1v4DToNuHVwDDaSKTlbs/kgZ1DgbvdmycEQphPZUHB8
 tGXA==
X-Gm-Message-State: AFuF++kCt/KkMPkiqq6F+avhv/RNfMfRhuO2ieNNG1gs7E8smqTnxB0v
 3BTTlH49KZjHEbHiyiQyyjtwipLN+DiAravxnGt9/oGY1bJ5j3iU2FJHXqUhH292MPO34ADjcj2
 A8tdM
X-Gm-Gg: AYBFou2ohFeoxguj9DThW7iqbY14TVmRNlqjx/89DaiqR+MJcsJa4/E0A6glDnKcBEW
 lUzPwfoMR67vxz1ZgtsSxjusxfib6R70NL80eJXDicnSTbF77y3uWlQKiXMeDoDo0DiI6kXBciO
 J5hOwbCvQHoIlQyNCsemYBFBioBpW9EXoc10D2f6lFMZE1DC8rylV0svgAxxc+WtY2tAVr9CAQG
 Gp3vnlvfpi3iBEvIpzhE4ynWoIdwAz0yuoJ7vxahywMAt279tkFTrZN+x59ZBHsYILCroaADzyU
 rZeUyUgIZoiT8SIwafzW/lzKygzRyY2jWDnCJonG7DhAaagRV98m9DlGusPJzmhyOF8b430M5p8
 8k5Flzs5YRbllpWtGgBIV1HVJKl8PQ9TAHR2VCXjbXRE5/bXwgtrAlmrjXDDJVloMqEyr7N1VQU
 7T6GceXeUeL47EANPKDHRHO08R+DTMHn9uPRTtwe5a0iw7l9MogMQCEoYAUh6JYTpS9MypJUJZJ
 k/2uaYn+p+fiAgr8JsIKpIeboM=
X-Received: by 2002:a05:6a00:3020:b0:85f:d76c:e23e with SMTP id
 d2e1a72fcca58-86169676529mr1540390b3a.23.1788462970975; 
 Thu, 03 Sep 2026 12:16:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614c699735sm375033b3a.0.2026.09.03.12.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:16:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 1/2] examples/qos_sched: fix unused but set global errors
Date: Thu,  3 Sep 2026 12:16:01 -0700
Message-ID: <20260903191602.924372-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The QoS sched example tracks numa and port mask but never
uses them. Remove the dead code.

clang 23 reports:
qos_sched/args.c:26:17: error: variable 'app_numa_mask' set but not used
	 [-Werror,-Wunused-but-set-global]
qos_sched/args.c:27:17: error: variable 'app_used_port_mask' set but not used
	[-Werror,-Wunused-but-set-global]

Fixes: de3cfa2c9823 ("sched: initial import")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/qos_sched/args.c | 5 -----
 examples/qos_sched/init.c | 1 -
 2 files changed, 6 deletions(-)

diff --git a/examples/qos_sched/args.c b/examples/qos_sched/args.c
index 886542b3c1..04e2a0e03c 100644
--- a/examples/qos_sched/args.c
+++ b/examples/qos_sched/args.c
@@ -23,8 +23,6 @@
 #define SYS_CPU_DIR "/sys/devices/system/cpu/cpu%u/topology/"
 
 static uint32_t app_main_core = 1;
-static uint32_t app_numa_mask;
-static uint64_t app_used_port_mask = 0;
 static uint64_t app_used_rx_port_mask = 0;
 static uint64_t app_used_tx_port_mask = 0;
 
@@ -214,7 +212,6 @@ app_parse_flow_conf(const char *conf_str)
 		return -1;
 	}
 	app_used_rx_port_mask |= mask;
-	app_used_port_mask |= mask;
 
 	mask = 1lu << pconf->tx_port;
 	if (app_used_tx_port_mask & mask) {
@@ -223,7 +220,6 @@ app_parse_flow_conf(const char *conf_str)
 		return -1;
 	}
 	app_used_tx_port_mask |= mask;
-	app_used_port_mask |= mask;
 
 	nb_pfc++;
 
@@ -404,7 +400,6 @@ app_parse_args(int argc, char **argv)
 			RTE_LOG(ERR, APP, "pfc %u: RX and WT must be on the same socket\n", i + 1);
 			return -1;
 		}
-		app_numa_mask |= 1 << rte_lcore_to_socket_id(qos_conf[i].rx_core);
 	}
 
 	return 0;
diff --git a/examples/qos_sched/init.c b/examples/qos_sched/init.c
index 561f9e0619..9f4b2e0082 100644
--- a/examples/qos_sched/init.c
+++ b/examples/qos_sched/init.c
@@ -19,7 +19,6 @@
 #include "main.h"
 #include "cfg_file.h"
 
-uint32_t app_numa_mask = 0;
 static uint32_t app_inited_port_mask = 0;
 
 int app_pipe_to_profile[MAX_SCHED_SUBPORTS][MAX_SCHED_PIPES];
-- 
2.53.0

