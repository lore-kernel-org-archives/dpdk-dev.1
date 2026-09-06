Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C0C79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A40C40A6D;
	Mon,  7 Sep 2026 01:27:56 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 5FB54406B4
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:54 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2875543a91.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737273;
 x=1789342073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=efjHmfy2VHU94ILH4hHqwxWLDaUEoGNEEU0D3Zhu3AU=;
 b=sN764h5K9HrxF5q/t1BfDIPtfdwlQgfPZAb7zG//S8HLaV23ZtnTJDaHKzFRFUiUr8
 PqdIN4zW6tR3K1MI8yBe5GaL5cmMWUvXh079VkbvVqWV1i7+JuLKtUhsRkC0jqGJBMLE
 89jEYNXSxL7wroyeSoJA6ISAGpyBMwTfwyJ46rvXp8QXRTock01Y0ZjiqlHoNk2kvKO4
 Wj1GkQ/AQEz/rCXhPCyFsRzSg5bqeW/9aIjtg9g+pjsnWkqxaC2RST6G6KKQ0n2N4lT+
 DxI1wEpMbdo7AgICfWAjBhaGSb1iKSopy3Hl3wz50oRIbXIxsHyw2LnYe5UV5i1Pp6AD
 uvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737273; x=1789342073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=efjHmfy2VHU94ILH4hHqwxWLDaUEoGNEEU0D3Zhu3AU=;
 b=JiJ+3EiPfOY7YtQvltUWaDpTzb027CDxm7WxrtyxbPjABrgiZ+cKVggPlvXkl1Oq7S
 +cYmm5xQUDfIIriUsVpVyCoxc12H1Li/Ecr1zixCtUFHAKb9WuVqQVm/fwYLK57RvymE
 FC2iodBMLTZTdUUtDh9DwiJIpZsUNzxRXe/R+ZQafqIDXssJiWB/n6Muq148XOdF0Bq+
 q+5uf3VvOW4N3UCdjuSAjwz2Lo91RknucFa0UagaABSL93LwPJ+qTmHzOZ9Gg+eJgwON
 hpe5unMZ/N9rB193LyfN7m5AmcoK4pXbfgEYPmkD5nmlHuINOG+1gQSd4oWm1RBplfNR
 3caw==
X-Gm-Message-State: AFuF++mqXEY4B5RXV+ahPWovUcEEcXxrW6DYWMIoV7tfbt5npE4zuIiW
 h5xrNf+k1OPySiFPQGPzu7MAVoF0wCd4Kviz7a71LYX0gTCeudwd0IxtpR2hkw3tbJfLfd69Hfv
 HoKmv
X-Gm-Gg: AYBFou0rY+Q3OWXjHcUvieJWKvQR+fxft2UxL52quRDtQPz3cGGL++rl3TayZi5suKs
 zFPVNdv0VWwwRrGeUVbMpHG/nE1tEqavI/eezaklYu2vKQgMPCJr3jG849424d6k1oEBhtLMNXt
 ffuYGyigar9kDDRCGqewW/3N6h/cYSl8Pn5YJvSxQ+K4iG6MvS/nvBOluMGxDdbdlo9ZzUfBclK
 oJs98gb78LY8MaRmaXsvuTkqDYqmrfQ+fwEKCLyqjvAq6hE1EGkYG/o3Nn2JCaquaKvrW/0VHTK
 dWZgQbvsQLoMmYgCXwoJYXqkgNk+n8YIKNhYSl3L2dDbcioNP1lzEtS2fc1RgQQJlJW1yp1DpkI
 j8FoLyZT4BFAZSZw9hlz9FtYx4xwSSUedyb3nahfhpFkp/myo9ZMlHyRm+U2YSufpe/u7fMWzjD
 b86uCEIal+hYPx0khjob6skSrNWBN5LsaFoJQI70Z2ZozEeNa+DO9W2+f0w5xFAVLFzxzRBpe0M
 ECpPG/JVhLQtloxPsjed4hYCRE=
X-Received: by 2002:a17:90b:2b45:b0:398:ba46:1d9f with SMTP id
 98e67ed59e1d1-39b27ea735bmr15262669a91.13.1788737273469; 
 Sun, 06 Sep 2026 16:27:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH 08/13] examples/ntb: do not print and re-raise from signal
 handler
Date: Sun,  6 Sep 2026 16:24:43 -0700
Message-ID: <20260906232716.496546-9-stephen@networkplumber.org>
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

The handler called printf(), reset the disposition to SIG_DFL and
killed itself, so the process died without stopping the forwarding
lcores or closing the devices.

Set the existing per-lcore stopped flag instead, and mark it volatile
since it is now written from signal context.

SIGINT no longer terminates the application; it stops forwarding and
returns to the ntb> prompt, where quit does the teardown.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

