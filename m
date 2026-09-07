Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B074C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C332540B8F;
	Mon,  7 Sep 2026 19:05:36 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 9A9DA402DE
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:35 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2979070a91.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800735;
 x=1789405535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCWIYffv4r3tvalb1OZOTvC+ipTb1EOZxKXDQKm0KH0=;
 b=SQZY1/EblNvntdH/fCNp/q3ff0d9q0xhYcx2OYr048hme2aplrRlT0h/YbfRKYX/Jx
 Ym5ZE77NG3+SP0GIrDoI5BT52yNh4EC10Lv+Z57HoGBuYBe1vyMRYplpxTW1yWgMbGDj
 QynxtZOcuRpHcn06v05xJpX+1A8rm/QebXkuy5wHVTTlmfgHiNhjgy0s42mxhuiglR9O
 v0121owfhpg878MSKfrcoSpW70v1eVUY/oKkYFuZeSajd7FNrIXNY0i0ncbcfqrkLrt8
 +FTL/wofWQneC5xHQfD6m7IgAjO6I7dWpd/DYJD2M6YN+exBhKOyV4f01uTdMPrxAWlj
 iOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800735; x=1789405535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCWIYffv4r3tvalb1OZOTvC+ipTb1EOZxKXDQKm0KH0=;
 b=A1cRTH4PymeQLGemvqNBF5hLj1jIloJy+AomfqyctXeXNVXyHQHlJFJwripvG+YCRd
 Zu3Ax+p/4s4fEufv/weBV7SgcWzMEXcB9muzKJsKV/ASkKATuHrLYpS7KAegL7rKrLXE
 z58/sFq3uc7i2d4GWff9gxf7qTVRoCBgzB5fxIiWW9+6yhP9Q9sbAPzVT6pqcBkrzgp7
 c4WZcc1M9D5GTea3NpoY6GuxMAogXuSwvOznp4OjS2LnOKAs8RXIX18e8QKycn9iwRLf
 1nmbtnfhC/7w7O24+UatfO4IavmEs8rHgZjhRpr8uEMqK8hsB/BMrKHme7yW3zYg/TQx
 x7aA==
X-Gm-Message-State: AFuF++nrCNJmtWzD+1ymO5y3yMORTI4FeevbUJBp27tN1iCYV2S+iI3V
 G0z6hXTOlrlBirOdJQmON8vPWgr4H+kJxBp5idwQ5RxSaKRjzwngJcFcBKU6cAyWjNcyzakHVsG
 HW2ys
X-Gm-Gg: AYBFou3iGAXJ79V+zWw/20WeSB8264FlaPHPDR+YLPm5Is5Tfe5o1a8imeNeVLcUiEV
 uM05n3t1styBXFRpHJYvjIztL8mBddVUbGqc7rdVezeuSFrQG0MhVI7b43rGEMSkJ3xAC3HYcWC
 bdV7RnmbRjVs4LniTCCXtb4xq0/6xp0rnYRCyZ++WNl1y2X0u7sC28nTt2NgxexyjeSGSBQPQyZ
 WJWptQ8GgQMNZHZ9n0deZ7de3r16TZ/M+H+Vv3HpPLWVWql83QXH7x8aJTmfRlEL89fzVE/mCJc
 AFMXVweHxbmxJNjTOm583UwHF79rULtIlPzeofTKgrJkusaY7J2e48Mm1Cc8F4YsYplHnUmSE6L
 9+OS7clsm/X0htOE56YA6DSoHK3Ks2roe+ruV2FrEejyfj7Clnu71CBW9yLu9q+d2w7YztDpzVn
 dpR7vHLcBxmnUZoj2o+ZzJi3s+YA+8KamqC5mNtwDTZvyTD+ibRjn26Ug7pIh5VhaBN5o/xYDoC
 9GnxKzbMsoV43F0qPeg5w7uhMXo
X-Received: by 2002:a17:90b:2784:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39b26272bdcmr40882196a91.16.1788800734765; 
 Mon, 07 Sep 2026 10:05:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 08/13] examples/ntb: do not print and re-raise from signal
 handler
Date: Mon,  7 Sep 2026 10:03:26 -0700
Message-ID: <20260907170454.351647-9-stephen@networkplumber.org>
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

The handler called printf(), reset the disposition to SIG_DFL and
killed itself, so the process died without stopping the forwarding
lcores or closing the devices.

Set the existing per-lcore stopped flag instead, and mark it volatile
since it is now written from signal context.

SIGINT no longer terminates the application; it stops forwarding and
returns to the ntb> prompt, where quit does the teardown.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ntb/ntb_fwd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 33f3c1ef17..bbacce97db 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -41,7 +41,7 @@ struct ntb_fwd_stream {
 struct ntb_fwd_lcore_conf {
 	uint16_t stream_id;
 	uint16_t nb_stream;
-	uint8_t stopped;
+	volatile uint8_t stopped;
 };
 
 enum ntb_fwd_mode {
@@ -947,12 +947,16 @@ prompt(void)
 }
 
 static void
-signal_handler(int signum)
+signal_handler(__rte_unused int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\nSignal %d received, preparing to exit...\n", signum);
-		signal(signum, SIG_DFL);
-		kill(getpid(), signum);
+	struct ntb_fwd_lcore_conf *conf;
+	uint32_t lcore_id;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		conf = &fwd_lcore_conf[lcore_id];
+
+		if (conf->nb_stream)
+			conf->stopped = 1;
 	}
 }
 
-- 
2.53.0

