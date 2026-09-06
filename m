Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C0C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54DD640609;
	Mon,  7 Sep 2026 01:27:45 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 6D2D640609
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:44 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2890513a91.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737263;
 x=1789342063; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IT3m3TSx55Z8x5D3kHCQmo2wojuSFRLxwlizA0uOdV0=;
 b=HtInpqcSgV0kNgE+IXYi1z9K8+u1yB8u1y73Y8Ul0U9/43Wf/zd69jQ6SbCCM1U88f
 0/RjhJw7R764Q2LKfjvsw0/IcqSkDdmrXzDaYA2pPNoEJ9T3NUjp3I5/aCqrcokx0ypD
 DSIFIgnhE1a1qVBUParyHz16nbDev4823IBHzfxK6OEbH7LinQ4vAOeSIIer9Ew1Wq8q
 KJnxQ8El0+1CQhZNgDkuEjifq1Q1oKal6sLH44g3ylYS3xhzJXbbWE5heY3ST+Zdumpz
 CCKQANAUJJMhnrr5KuxK5fn+dPXpH2vHGhmwBb0nwTV8Z6Mp4o+kzekZVroKKYeaURpX
 8ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737263; x=1789342063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IT3m3TSx55Z8x5D3kHCQmo2wojuSFRLxwlizA0uOdV0=;
 b=FDELpCya4q4yySGFms70RmHNgVUIzSUVKtPVWollMSOqqDjUrBGwDupV1R/4yfwrWH
 gSbpDxJfSWES5cWWyfesX41DAzFQvhB+E1CTZ5YOeO3F4sohBcqekr6s5thG7s4Yj1EL
 KpDxUlZP7YA/NDwNpYkFBZ1kWHCHp1IDW7OqvPkPYJJ11RSED8YTbBvc16G0j7BED35q
 7RoM9ZPgTIF56dnluFzgn/IBpIOH2hsZn8VkZ9i3KiAMEBvf3UZ36iR/JS4uEOsUdFNq
 6Muw2sp6AekWi1Qtj+e88PNSBC9QfTQDuqOsJ1qzK7ytJ0nPbflRDtZZ1eJBUWB7YdCz
 SE1g==
X-Gm-Message-State: AFuF++looTa8L1hcIXa9w313CXa/chrlgcVlQVJoZoP/mrFuIO07RWCk
 jvixrgKGrIhUwGSznn18z2bomvOIigDRuJBV4dH00x+6lbgfUi3SUDMBpK1FX6yY4fg+irvs4VB
 oOioS
X-Gm-Gg: AYBFou3z1zDyILjoeZ91nHQeJUhks79ip/+slQ82M5W2UFB4sajeR1YgC7qEO0OtRpO
 us9qTGT5ofqlSWGaHwpEAoWgP25n+PVl+TVjis8mFYbRtlU9kjHQ9WKSZQ6gjC5vL415bpA23Qc
 lBhZ6PZ2cJ9lA3m6OTgBlLwOyGAlM9WaOcC60/T4UNq2hZJQKZJVgEtaxnJ0dSnMHfvAZ9XMf3V
 RXJIP+594saHf8ekMjUY6TldwUGwr4w/iIhzkpJtl3ka7X7NfJ3d3O66PSVcp+JcvtmUZhpIKAE
 yYDJBtWoM/naLMSzDtKy4Wr/D9s60cFs1lqvKIjwGyb2tPGb3QUAJJBX0MAA6O5c4/I2uviFe43
 mkN4h5PI0aVEnzDSJD4gYZhj82B6quhA4ab0dw4h+bhiuDWJRH0F2p2ESw9AbMv6d5BbL9Kh2Is
 fgJfsZXxaj/5NOgqjF7UXs4QLovGQcVkTDkSZFGpnewiqBkPN875ENh10DwzQqSP42fx/mxCWYK
 vgaWvat6j8zGHwx6vg8uTxSyrw=
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39b26226de8mr31012862a91.19.1788737263525; 
 Sun, 06 Sep 2026 16:27:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 05/13] examples/vdpa: make signal handler safe
Date: Sun,  6 Sep 2026 16:24:40 -0700
Message-ID: <20260906232716.496546-6-stephen@networkplumber.org>
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

The handler called printf(), the vhost library teardown path and
exit(), none of which are async-signal-safe.

Set a flag and do the teardown in main() once the input loop returns.
This also closes the vDPA devices on exit from interactive mode, which
was missing before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vdpa/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index ac6da79b05..1b989fc6e5 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -288,14 +288,13 @@ vdpa_sample_quit(void)
 	}
 }
 
+/* Set by SIGINT and SIGTERM handler, consumed by main(). */
+static volatile sig_atomic_t quit;
+
 static void
-signal_handler(int signum)
+signal_handler(__rte_unused int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\nSignal %d received, preparing to exit...\n", signum);
-		vdpa_sample_quit();
-		exit(0);
-	}
+	quit = 1;
 }
 
 /* interactive cmd functions */
@@ -513,7 +512,7 @@ main(int argc, char *argv[])
 		}
 
 		printf("enter \'q\' to quit\n");
-		while (scanf("%c", &ch)) {
+		while (!quit && scanf("%c", &ch)) {
 			if (ch == 'q')
 				break;
 			while (ch != '\n') {
@@ -522,9 +521,10 @@ main(int argc, char *argv[])
 			}
 			printf("enter \'q\' to quit\n");
 		}
-		vdpa_sample_quit();
 	}
 
+	vdpa_sample_quit();
+
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
-- 
2.53.0

