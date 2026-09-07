Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD3C79FA0
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6083C40A6E;
	Mon,  7 Sep 2026 19:05:25 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 8F064402DE
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:24 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso2998614a91.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800724;
 x=1789405524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p27BlLWLqLZR4plgP6dKJeiaHKbp6hofN1TlmhhRWDU=;
 b=oyYppGcNer9bntHQXIyTxidpgxtUHshY9Bp34IFSymljqkIjv+aRi+/LMKNn/04ALY
 zx+GLr8SoqMpQkRarULJi0Gy5WHyOPmthKzAKx/v6T6VOmy+UZmMzway3S2IoEk/OfuO
 hWi5ORvjN6kDBUUWpgpOo4AdAtcnxKUC03cz5C4OiJAD6oQIq4wNHitIh1BS71HzxdRM
 Tiu63Nx2YYojAz6P/08LwdjGRpYjkTVa/kfOr59IsSjNxnqhw10WQcrUcZAlJ0Cqh4Fs
 pBL0Mtm2Qjod7ac/F9ZIluRgXR9pan7TKLFPWBv3uaDl+EaTZ/7lwPHdhnsVx038c7Rp
 qI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800724; x=1789405524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p27BlLWLqLZR4plgP6dKJeiaHKbp6hofN1TlmhhRWDU=;
 b=NGkY0EmWAhZGcpaPXxxvAhwOMdk2olZCB0L/TlFc6l5ZkRVcFYn3sebTRdjtwYuNTZ
 dV6dcK9XT/qKex+7r85NSE+8xdb1wH1JJ5dg/eS4N1YZUILfx750MLoYPKnwN3vpD+fK
 Asuzoi4mAju9MyjQwztXXyldrTRii+uWWt3lQvd7Wz52U21PtsllMcU0Ug2xd9kWix+u
 PRk725Lc5z4dq6EZKy99VA2d9eMSPgdBeQaEqmfX/bzHuE0UVfLjsJYvhuLZoU4cp2eo
 2IoOZwPbqQqjujYSAJ1Y45+r8Krl/9gAJu0SYWv7rI5ETcUZUUy5vqEjcxlNeOafk33N
 xlQw==
X-Gm-Message-State: AFuF++m3GX21/1wNVbI36QVFPAQ3SorUhVMTtgtKUV8zBMGTCd1gdcZ/
 3DCBzT85SUEDFpY7+fRYDfqYATEOiBbyMmFb7JCn26P7c20Q4o/DoDO5ZJLpNQfY9czZvXDNQHO
 zVF6d
X-Gm-Gg: AYBFou1gUTRzxntLYsQh/UtVh8wz3WifECiPwIPqXzBKqK2BekQuFL0tfFghcFCEvFW
 SznbXJ5RrStiSooHxYctlzFMkAn4OqtB2DckT1sVXcBk0I+6LJLDcLntHg5YgBBPS3F4OE21zUv
 +vWemwc5GslUwrEAuXqlbS0cZCAIBvJboetptVGu8mt/LlYRlrtjEx1+RpGbRUuO2VEMS2GqoJq
 G9lmHVKOLHWc76fVrUqsXVA9hMd0KC1spxp+K0ugIpTM1ykb4S6QjTLsDEg09VJgUBL6Vmyb7x8
 FNhjHu2HKkrfmqxYZyIGTwIoscYQCXqaWNNoCicneDbqwOdH1NVxhF/wQgA4EB953Ggkr3UGzTn
 9kl0/EI/HUzWKdKvabk9FVSygwI14uD1VaCP3yrlP1Xaxmrbh6TlKg/UYX+ip/j5S978JiMOC+2
 tHu5TeqL0qH3N8Rg7HDyA6k1K1QbVS8rrlWZrS04LalENBebO+UVrCABDAU3KQcmffRivhnR3bT
 eFEdqWZHsAak2BguKO1JNhG5oY=
X-Received: by 2002:a17:90b:3a81:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-39b2612eaa4mr33491450a91.10.1788800723456; 
 Mon, 07 Sep 2026 10:05:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 05/13] examples/vdpa: make signal handler safe
Date: Mon,  7 Sep 2026 10:03:23 -0700
Message-ID: <20260907170454.351647-6-stephen@networkplumber.org>
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

The handler called printf(), the vhost library teardown path and
exit(), none of which are async-signal-safe.

Set a flag and do the teardown in main() once the input loop returns.
This also closes the vDPA devices on exit from interactive mode, which
was missing before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

