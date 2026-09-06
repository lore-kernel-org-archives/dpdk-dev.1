Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24776C79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8043040613;
	Mon,  7 Sep 2026 01:27:51 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 414CB40696
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:50 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so2861385a12.2
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737269;
 x=1789342069; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lVx8b5KfzwUhTl0nKVccE8vm364pQIBoqUDZsfNsklU=;
 b=iWKOtiIoMO8uXrwwXkLBFPiNbVamhv2CRs87KKIBktl+IC2b2cejxR+6T+yWzWixoP
 /rZS3pks+VnfHzkk4zpSan2SLmpm0wlZtb2K3jTpIl50Y4kLWnVyTPv9m1TomMK5nKfp
 5v3Wj2USIo9KUirxqksGoNYg3zYoya/JQxXTA4p6HjNIpeNztT3VClPhLmEj8VXkKiup
 6hlq/mO3DMJXgAFTGxbRaRuBuZ8wa+Q2oUMHTu86X5HvlF0nQkFmgjtHqlZ5hruaJ2cT
 ZeUvul7lHRXQ6vicndTqIaeZZ2hZJEzM9p+sMyGO5Nchfjn/HoYSrW6Qtu7PTMGJh8zW
 Jrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737269; x=1789342069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lVx8b5KfzwUhTl0nKVccE8vm364pQIBoqUDZsfNsklU=;
 b=JtP3nFKv3gE1HDzgaKJH5LJXRqTi87nEKPhzMflpV2aF4kOMH0PtmCOkEZlXUZ6fK+
 ILV41PlfRhSdOImaXPR7q468awsuJUPV7f5QASOir9XQtCxW6kdPhYRxu6XNnEzdlcY+
 5wAEDfT2VANaa+q5Q5yDkDNiAby/3Dj/MeDNXxp0tPlean2lcW5165ZCBzwx8qNRkcm+
 MxDuy2zJFwBJ0nVx17vOnQF7I5AZ3nrErIkFLZsu6v1lR/ku5nv+rsGdUp7XntdF7IHT
 i4Ih8aTkK9nShxLhooTU7BvqzhYQ0dZzfqxc5hzd1QdaWnX/8NOl+MQjj5w2dH5X8m/C
 QTKg==
X-Gm-Message-State: AFuF++lUnknKmMns9SQf8nikEP1XpfbWtuINuR8O7Idl0jHsDvajOPxi
 0m9jMNwOnii9GxMVGrCsmv0TuWY4gSbIf3n6KuIERPVlpNBwAR8QDWsM4JnUHRgMbHfdt5J6wgz
 QF28m
X-Gm-Gg: AYBFou2WCw3O1HL37pUUcuzg6GS/gpaDatpg8Qvxyy5RX71X4bV8keP/Viua9lnM5N9
 yGVXVSIuyszNGmI8vCwHKNmZcRR9UROAPmwB1O1qylv/O5j+81gXtLttorLMq44IAUGcUu1Muap
 arFYACIo3fV5rxZ614Ux5BZDVAt/pD4X+CSMrgYbmUAHGgrv5UsdkhpPTnUekJO1Jycyh5I7v8Y
 fU649ow8jArMT//DzQ+1E7k2jbOICwb/DrTE13XSzAyTIcj8HSM9CIT/tWtoIEFqnhGSMWq5jxu
 1SIyH9hDHQWakwEH/m8OXKI7q61xUS3tsQcXkvk4Cf5tX8sRBf1Jzl16rCDBOPJIzhAjNIEGdIc
 IFt/c1BJnThmHH2HvEHsbpBh1TgTWAQ6Z+J98miYuFPLfmUL9oTwoK8Lvoxivf036bp4KDwHVlB
 w63Br9HPwIBrhGX7ksXaxxt/wYgADhT+QEaaZAoWwKqcrETuwXB0lqDamzFimHwDGELTzoMdNBQ
 dMlLFMNppptZTJ3ci0Fsd8Ps4Vd
X-Received: by 2002:a17:90b:4a49:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39b26100cd2mr28508208a91.2.1788737266936; 
 Sun, 06 Sep 2026 16:27:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 06/13] examples/vhost: make signal handler safe
Date: Sun,  6 Sep 2026 16:24:41 -0700
Message-ID: <20260906232716.496546-7-stephen@networkplumber.org>
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

The SIGINT handler unregistered the vhost drivers and called exit(),
neither of which is async-signal-safe.

Set a flag, let switch_worker() return, and unregister the drivers in
main() after joining the lcores.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vhost/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 5978a50cfe..f768f0c5e0 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -79,6 +79,9 @@ static int dma_count;
 /* mask of enabled ports */
 static uint32_t enabled_port_mask = 0;
 
+/* Set by the SIGINT handler to stop the worker loops. */
+static volatile sig_atomic_t quit;
+
 /* Promiscuous mode */
 static uint32_t promiscuous;
 
@@ -1494,7 +1497,7 @@ switch_worker(void *arg)
 		}
 	}
 
-	while(1) {
+	while (!quit) {
 		drain_mbuf_table(tx_q);
 		drain_vhost_table();
 		/*
@@ -1872,14 +1875,10 @@ unregister_drivers(int socket_num)
 	}
 }
 
-/* When we receive a INT signal, unregister vhost driver */
 static void
 sigint_handler(__rte_unused int signum)
 {
-	/* Unregister vhost driver. */
-	unregister_drivers(nb_sockets);
-
-	exit(0);
+	quit = 1;
 }
 
 static void
@@ -2070,6 +2069,9 @@ main(int argc, char *argv[])
 	RTE_LCORE_FOREACH_WORKER(lcore_id)
 		rte_eal_wait_lcore(lcore_id);
 
+	/* Unregister vhost driver. */
+	unregister_drivers(nb_sockets);
+
 	for (i = 0; i < dma_count; i++) {
 		if (rte_vhost_async_dma_unconfigure(dmas_id[i], 0) < 0) {
 			RTE_LOG(ERR, VHOST_PORT,
-- 
2.53.0

