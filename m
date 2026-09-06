Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F001C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E218B40A6C;
	Mon,  7 Sep 2026 01:27:53 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4630740613
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:51 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d6f9e2f681so32186335ad.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737270;
 x=1789342070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lv88Bw1lygES56KE+uGcWQGwDVshn+WpZYOQdjY78J8=;
 b=DA7efiy24U7mzf5BuT3bETLQZ/FZvqMwQEo8B+USUtB1au+zwfm1k3Or6jKsZsCmmm
 rNXeN4138soncApv8AgLalRWQhiUmP4vAko1V5/sZC3aQkI5fPBLK88rFsOHvZg8sSHx
 sQaag85WQcs5oju19wM3FSnBOwE3BmGh2qsRPMrdTPORAzKL65TBOzVk8rMvxWkEUJI1
 k2l4tHGz/+GT47/JxeXfTkNvPuK1S2olHYznegkarHEd+G7+Yo1aOS+FRlwd9SnoY98J
 o5yTo5fewkQ+w8FCRKPweZYgMlex1FIQL5n3KQ97KE8M47FX1M52G/2dQmS6enQQnQ0q
 k5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737270; x=1789342070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lv88Bw1lygES56KE+uGcWQGwDVshn+WpZYOQdjY78J8=;
 b=rDqarj3H4fKXjmZXvxfuOHNdqa16/AFLeZ5tJ0oZWqriZ8ZOeuYNVLb/44+0hfAN6Q
 3tZL1XIjCsxrzCova9L8eMADGaIzNj454q/yZumkJ0airS/mGKjtnCXSVlS60/vsw+pV
 QSez76fb/iEdFIf8oCNVaG0d3BatjOKQmaBojgPLx9TMLOuLCNW7fvX1682+VR/asJBY
 4J4jRWZ/2pTRPR5FP81eWLgqrPoMvM73hyh/eDF+cqvlQcUH8DQqgI9elxn1haQMtCOY
 Sp73DAynqEin2izLDmdtFWTCLKJrvXZCRvDhL495ihnuHo+eBup+nUxM/jtCQtPrEd4e
 HcGA==
X-Gm-Message-State: AFuF++lKzHaSIz91ps5PBjRMkkbpv8XHbS3GTCFxDSRlnS966bnT0Tww
 qUuuflYIFZFmISHZ0BrmPIITHJeqbXatPtP5BQlCZymE/tR0AqSgg6esRVUWzbVkEtfaPOhPbsN
 AX10W
X-Gm-Gg: AYBFou0XKXSmCOl8mxwuO695cFCFO6nxBiMVAbqLCaDo7sl96i2mDqQ2WPqZRSC4FsX
 vPkii4hdBsAqR5VINaiH73OcKxqOdj6hGelKxIz94GVPUAgHssElfmXnj/kKreOAf/++ShImVAG
 U4PIaizEIEMjkIJ6tsU/myNiHXaMm2TxTCDd8ZSIXtPYEwzhmxiBNTG4Zny/wFtDhVoiNZgk3zY
 xtWPVqEL1jONFBm2UD/UJ6IfamR9KEYQfigkm8R8YfSZZJtMXt7F0FO1ynf+rUm1kO3FYIr1Nx2
 lFnIsecZnqpAsEjeEAfsLzwrIpkGjh/YBsjYU8d6Lbp8ZuMARvJbvl4IrbZIf84voBgJ6Z8amxD
 X+8lZGvlpdC9Hg+aLbns0o5PPaeRyECOcif5t1Fdy/QskcYAea80/ldbhtwLo8gNNPh61QpX+JX
 6eme4n2wxaHFiDm+RiFoWuXKrgL7QDGOV9RdChDYtvevdB4ci7gaDypTHJmQ+kY+eF7NnVFwLt6
 HBneaRo6vaI3LWNfJUGC/PXz8s=
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39b26202ebamr30684424a91.14.1788737270379; 
 Sun, 06 Sep 2026 16:27:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 07/13] examples/vhost_blk: do not tear down from signal handler
Date: Sun,  6 Sep 2026 16:24:42 -0700
Message-ID: <20260906232716.496546-8-stephen@networkplumber.org>
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

The SIGINT handler destroyed the controller and called exit() from
signal context.

Set a flag, break the sleep loop, and destroy the controller in main().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

