Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B725CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9058040658;
	Wed,  3 Jun 2026 07:26:20 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 92F4C402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:26:18 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49068493267so70977365e9.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780464378; x=1781069178; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb169rxtsTsp/+y+V2bYFATlaBNqAjJsqr6R40pTgeg=;
 b=ajUwnEnfwGRyGwUmG5qOlfaVeOfMXdL4Ro9unIV/8EuAyVBKV382tFMi3IpaaOcp76
 RWYdwhLsnXY8byiW1IiHs2KE7cgSjmcC4szuRD2+rgwEL17LWJJLaxs9mk4SiPkeAJsF
 U9gDEonp9nmIYKqPpOHfIyn3+yKmitePRqFzL/mnvVMdH4hl1VgDrR7c9Ifx2iwPdhri
 zgS7IQjLEYuK07Q07+bLlJL0ahFmeRf2mq25sWv5d0G0az9TQfqBcV3Oy+jr+hrlqjB9
 59osP1Xp2X7hRfpgOydKjAXBoCv3hvqJgfoSlGm8xZKaquuc2kCAwWyA/Aye6hPWEwCq
 SZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780464378; x=1781069178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nb169rxtsTsp/+y+V2bYFATlaBNqAjJsqr6R40pTgeg=;
 b=mpLs2k7i26+TAMiSUfX5r8AB62G2qXkAOPF4nwAXU6pCg0lL8zhhskR+abRVJxEJKc
 Hy+yPlMGd/k5Afm7ruBT3uC3d9QaEejXSs0RqubkvmT217dN4bvxwUj/l2zoRh10puRM
 vWwFJ9lHi8gmF1tDTI1PpUBl4AfMhLJekCUbxPZPPQ1em8sL76MhJhRE0X0DCDxQCuAI
 elqUNUO/mvlfmGNnGy+WVf8k0CfCzr+AKzDbrpEZLGX35vVuKLJbkwTsqbqppbY1JROv
 EUvxOuxfqk4fE86jWuL4K8Lv2zFa/MfHTpCtituGwawivuGn8CL/OxUYSbJmulyKaR6X
 wJbg==
X-Gm-Message-State: AOJu0YxT2x2KEkBqVaa8f42Vlzuv4EipysIJWhhwAmG1gM/C9FppWLGi
 B1ox3sVLjLD6mbTglaSFFYm18B+2Z5dO7gLHr4Xc9hSgvmLR8/Nyp81O/zYP9VjE
X-Gm-Gg: Acq92OFfnPKt8JWGhZEI895sNq6fW3xWieYh0dmV0Imfh3WvaMijLIOgKWvQZVhRV+A
 6dkxKd7FHYYO5L/wytbPqgqA28Z1mO0omP4AUUUf4ZDtoOfxsjulw9IdhmBIGIS4rfqO4e94H5+
 w18hflL3OaLdo1Ao2I6YdWU6qK75/5Al7wj4Y1Y7121SBBktdhhLR33ZJkn8ONOYfmYPUwww/Cb
 1mxhM2cAJGvDeqbr4RwstX+hCSCvrbHdUJxmeeUrbk5DjJvhSMB/tLqW8YvFmBOm3J8vPKIEUk9
 zSeMHGw0UViWlFS3K/OnsTVMXYaabytRb3/mX4h/lrVbSsP0KLo/H9aT0rt3jXRkasKmBMl2iLS
 G8nTu198YeXhUCIiUE3+8734XWvWIa2Zz1Fvk8t5Km48PeUjZfgvNYWUs4vuwLXKUMRqqYNCTiK
 9Met0djNXqK30bc3NXrSGxnB9TzKsARUXfFSOyzLSxAGyx65NBwHy/mMdh
X-Received: by 2002:a05:600c:528b:b0:490:b297:89b with SMTP id
 5b1f17b1804b1-490b5ed6482mr30891825e9.21.1780464378107; 
 Tue, 02 Jun 2026 22:26:18 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e20a24sm112411245e9.5.2026.06.02.22.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:26:17 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/ark: fix unsafe env variable in extension loading
Date: Wed,  3 Jun 2026 08:26:00 +0300
Message-ID: <20260603052604.118850-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The ARK_EXT_PATH environment variable is passed to dlopen without
verifying process privileges. In a setuid/setgid scenario, this
could allow loading an arbitrary shared library with elevated
privileges.

Add a check that effective user/group IDs match real IDs before
trusting the environment variable, consistent with the same
protection already present in the mlx5 driver.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 727b3fe292 ("net/ark: integrate PMD")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/ark/ark_ethdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..e25478103b 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -211,9 +211,19 @@ static int
 check_for_ext(struct ark_adapter *ark)
 {
 	int found = 0;
+	const char *dllpath;
+
+	/*
+	 * A basic security check is necessary before trusting
+	 * ARK_EXT_PATH environment variable.
+	 */
+	if (geteuid() != getuid() || getegid() != getgid()) {
+		ARK_PMD_LOG(DEBUG, "EXT ignoring ARK_EXT_PATH under setuid/setgid\n");
+		return 0;
+	}
 
 	/* Get the env */
-	const char *dllpath = getenv("ARK_EXT_PATH");
+	dllpath = getenv("ARK_EXT_PATH");
 
 	if (dllpath == NULL) {
 		ARK_PMD_LOG(DEBUG, "EXT NO dll path specified\n");
-- 
2.50.1

