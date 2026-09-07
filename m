Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB66C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0625640A84;
	Mon,  7 Sep 2026 19:05:34 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 252D440A7F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:32 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so31949645ad.3
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800731;
 x=1789405531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=arnytW6yiQ2ZU9knx3vddGkF7i9lS5L2uK/ktkYju+8=;
 b=sPgffxkg8GnimXmMvJ7id0uIbHyzdlbldTgTOzgZ08u0/+XK/DWI3iPNxqi5Rl3jxA
 K5cgCYXzEY/TebHfbJkP7KWwmo1yMifyEITchlnnO7erWwE9fHm68MG+LIcwhZeoH/4t
 UJKMdJCuL7CBJXdA38+7ZDGEZ4Zo12S54mIXpE8nltzfjE+YgbelhRtw9I+oKZ933dJn
 w1jlunp+5aE0aacZ9tMXvM4N3Fd4eXBkuVmqPqvhppcicChZzxZ6/FboQvkYMvKRSspe
 SkJZhduhC0CU8YXvNFiSTgJzaGbyi7mcj+LTS7Ty2fElDVU2jsM+VJI25z6tj0/HtiKh
 eluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800731; x=1789405531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=arnytW6yiQ2ZU9knx3vddGkF7i9lS5L2uK/ktkYju+8=;
 b=Wdv3lUTcJLHmorfVj1isGvI7wRVLCYorHXu/z/2fwD36kBJ3cl+myHDBzeLYvz0Yx/
 NHOOVmKKi9URWbtkZ5koEOosxuY6vIe+64A7JP9emHfJju9r9ze4yyoNh6v1dEANca2a
 0MRWptI21E2IRg6WStw0HcP64zhKSiT/9dlMMJtKTDIDz1JRFHIm1uHI9NXg8atcFinN
 IcfBzBJyZwuKA/PIby3m0AM1yK+ZDVUIEFuo3gw4nf6F3BXlmZOTbETSnsSDhsCUEqpp
 nJfZb563139IhV5z2GMpAyLWKKpWo/natvEoE9X0d7CYPepEj+SiPAsRXR/GM9/9jeDd
 9xVw==
X-Gm-Message-State: AFuF++mRxzohvWDvKjMul3aO48bwYTFP62IRpvuoBYIoMSUJwsEx/8wp
 CpnnpG6a3VDhRemHc+WMlbCZq0ePa/7zsS8vkhuHS7mfAH16VhRbP36NL3/sew9NCCIXSzBMJw1
 ehghF
X-Gm-Gg: AYBFou1pXtnF/CVzd7T7TuhMR8MLUGi7h1CUhmDf0auktUzQDuno3vNkGcAZ7d7KHNe
 V8zzz36wM0PDfizXCimcb2LeXhUJd7ogsGGt56+Q6Nt95jxrHsyY4jGZkMEKBp3T/a9likIX6U3
 kf1AD4e2slQ6yZjtgtEstkrb62BJuC+b5zeG1rAAxkBH1kW+Ips3vkPLvXfoUE388z+tqyd/+mE
 qdlnqF1scqLT5xCcUWSPJYXwfLKu7qMz5eJzVoiBqkycS962cHqeOrJ9m5rIHLDObOMPrc/4Cm1
 q5JN0zV/mHOWsC7FvY45GRCp1Y+jdXusVQIaUN2JcW7wGUCY3j5zigm+ZJEsOOFxvRY7r2KeQwx
 71fpXOGQjbmfUVxdU3EGZzNC8kKIsj7pdah18f73ryMSE29OS0IGNl/fgmishJSChLGKXoS093Z
 97q4a1ce8I9mQApYWFYIM77YjtWp1QShEc+DhH+YizbfGn8e6AGD46PNtvRiw8zgh/ggeiswiDg
 aoCL4Xd9tqD4WCLIbmjOOzqWTg=
X-Received: by 2002:a17:90b:2644:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-39b26204e50mr33925843a91.14.1788800731230; 
 Mon, 07 Sep 2026 10:05:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 07/13] examples/vhost_blk: do not tear down from signal
 handler
Date: Mon,  7 Sep 2026 10:03:25 -0700
Message-ID: <20260907170454.351647-8-stephen@networkplumber.org>
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

The SIGINT handler destroyed the controller and called exit() from
signal context.

Set a flag, break the sleep loop, and destroy the controller in main().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vhost_blk/vhost_blk.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/examples/vhost_blk/vhost_blk.c b/examples/vhost_blk/vhost_blk.c
index 9c9e326949..0665d9fb51 100644
--- a/examples/vhost_blk/vhost_blk.c
+++ b/examples/vhost_blk/vhost_blk.c
@@ -850,24 +850,18 @@ vhost_blk_ctrlr_destroy(struct vhost_blk_ctrlr *ctrlr)
 	rte_vhost_driver_unregister(dev_pathname);
 }
 
+/* Set by the SIGINT handler to break the main loop. */
+static volatile sig_atomic_t quit;
+
 static void
 signal_handler(__rte_unused int signum)
 {
-	struct vhost_blk_ctrlr *ctrlr;
-
-	ctrlr = vhost_blk_ctrlr_find(dev_pathname);
-	if (ctrlr == NULL)
-		return;
-
-	if (ctrlr->started)
-		destroy_device(ctrlr->vid);
-
-	vhost_blk_ctrlr_destroy(ctrlr);
-	exit(0);
+	quit = 1;
 }
 
 int main(int argc, char *argv[])
 {
+	struct vhost_blk_ctrlr *ctrlr;
 	int ret;
 
 	/* init EAL */
@@ -895,9 +889,17 @@ int main(int argc, char *argv[])
 	}
 
 	/* loop for exit the application */
-	while (1)
+	while (!quit)
 		sleep(1);
 
+	ctrlr = vhost_blk_ctrlr_find(dev_pathname);
+	if (ctrlr != NULL) {
+		if (ctrlr->started)
+			destroy_device(ctrlr->vid);
+
+		vhost_blk_ctrlr_destroy(ctrlr);
+	}
+
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
-- 
2.53.0

