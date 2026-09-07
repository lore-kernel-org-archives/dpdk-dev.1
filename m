Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B82C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB3CB40DCE;
	Mon,  7 Sep 2026 19:05:51 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7A9AD40DCE
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:50 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc1c73645a1so2752226a12.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800749;
 x=1789405549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Htnv3pUdHPWw5jirO9IQo93v0HddL0mBr9w9oocdgNA=;
 b=F9qtQw0JkTW81zDHDuNLM1FMfKxzIKAqxgNyhs4/UXhlkfaUSaq7gyZNsEi4MWxMvL
 og0+d/3ud1UT+fg7frAtxpq8oQZjbcmrZKgJb39RHK0msaROW1+/M+HWl46OagtgFVxW
 YLj261QgZIHnnR0UERjkFjtu8Yi65Evatv6ymq4ns7TTBLUJWJJWUarKY/kOIMHyz9aL
 rkv6v1hGOWkTH0ZA01PxFvOepP8+RlTvVjgEyWbjhvf7Ls/yDaB2jga1IqgHzsdVDjT0
 R9m/bVl7syUocrCXp4yMlfKOQHuJqm1LHT8B54nDrn7jSZsVSo3MZcTudXmW77oitUTP
 BHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800749; x=1789405549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Htnv3pUdHPWw5jirO9IQo93v0HddL0mBr9w9oocdgNA=;
 b=GQD2MMd7shTD+I8OENNEFy/ARgrGxuSzZu0GhCYyYexm0N75FY63HSQSl6gzTJ2LV7
 hJ61evurYRdXJQDbMUmylD8vFA9RFZTopVUfdoZtFicxnxzxCx9CmPPDmqiV8nAIa7Qr
 Nfdb2kXP06tHvMNRIP6CYoGHAZOiHSWrCHzibn/kZmawxb5vOEcsn+Ewxqt8Ko42yu8q
 T3F4Xhkh4jN1SVaktgN/qR2/nSUknAyEcaBW5MwFqXJ/Vjk0lXiYDoz46wa0D0/D5L6X
 JedMM59THAoMhhHb99HM15A0m+xaQPY9ERtkmWSFfUR5V4c+bWdM8nEv7iHDdwmYkmqH
 k7Gg==
X-Gm-Message-State: AFuF++lSDHUZrka6Rez6/fN2gDeGPARGPNoljwfh7WZ7fx76pRJrJ/uo
 0cCmDFecuVdgF/z548Xdjpwn7okFiAn1ZOOITEo3vVPnAdwiegOgLWLEwL4XBrPT+3lYUci5dF5
 WPxsH
X-Gm-Gg: AYBFou0z+CXweUUD2b+o2ljZ2pVaTxmtY/083/aXPv9ya+4utNVUdGQPU95ZwRgVFN1
 lWVPHzBftJPF6ZCGIIHMg9YlGzhWXanmNZU2jeb4sYNj6OmscCxWkCcVkRMs39IhZ0DWMVt1OLw
 YM9p8RlkAiMnDsLGXujRD/u47iPYIH1wVFnig3nFw93l8H6kAuhFQtjy8wf4RiZiVzHeuT0JaTJ
 mTXQ+FS7rDAyfgycFeixNcJBHqirEbPeCxzZ8dPPa01sOJbvsV0BJ8JQpf8UR8R6G5Nz9WQJvAM
 bZaRQaFiE4VXXZDUozm6Ly8KJdGKrwqMQS65pCYkW4MJXej0AeXQPqOCFYzSgVcYLv0/SOTyzlX
 0L0R9ZWNLUqro0P4+UOsLbwCFfRAZUiu0Bo82/eXfWwo/4pYsq0Bm2gZP3oSGfW9YYcsRv02gk2
 Weo3iUQmV6Uu8uZ3ScDO15NOa5SODWCSp9iRRH+2FEE0jnvSjYMIKUAV0y0AZ5XkTKe1+bbx7oe
 H7oQ+ExggWXTrG4l5Sqas0Mx9gLRnPSJIHTZsE=
X-Received: by 2002:a17:90b:578c:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-39b261e7649mr38436074a91.12.1788800749357; 
 Mon, 07 Sep 2026 10:05:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 12/13] examples/vmdq_dcb: allow exit on signal
Date: Mon,  7 Sep 2026 10:03:30 -0700
Message-ID: <20260907170454.351647-13-stephen@networkplumber.org>
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

The forwarding loop never terminated, so the application could only be
killed. There was also no wait for the worker lcores.

Add a SIGINT and SIGTERM handler that sets a flag, return from
lcore_main() when it is set, and join the workers before cleanup.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vmdq_dcb/main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index d6f7b632b9..563b4f9ce1 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -513,6 +513,15 @@ update_mac_address(struct rte_mbuf *m, unsigned dst_port)
 	rte_ether_addr_copy(&vmdq_ports_eth_addr[dst_port], &eth->src_addr);
 }
 
+/* Set by the SIGINT and SIGTERM handler to stop the forwarding loops. */
+static volatile sig_atomic_t quit;
+
+static void
+signal_handler(__rte_unused int signum)
+{
+	quit = 1;
+}
+
 /* When we receive a HUP signal, print out our stats */
 static void
 sighup_handler(int signum)
@@ -567,7 +576,7 @@ lcore_main(void *arg)
 		return 0;
 	}
 
-	for (;;) {
+	while (!quit) {
 		struct rte_mbuf *buf[MAX_PKT_BURST];
 		const uint16_t buf_size = RTE_DIM(buf);
 		for (p = 0; p < num_ports; p++) {
@@ -598,6 +607,8 @@ lcore_main(void *arg)
 			}
 		}
 	}
+
+	return 0;
 }
 
 /*
@@ -640,6 +651,8 @@ main(int argc, char *argv[])
 	uint16_t portid;
 
 	signal(SIGHUP, sighup_handler);
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
 
 	/* init EAL */
 	ret = rte_eal_init(argc, argv);
@@ -697,6 +710,11 @@ main(int argc, char *argv[])
 	/* call on main too */
 	(void) lcore_main((void*)i);
 
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			return -1;
+	}
+
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
-- 
2.53.0

