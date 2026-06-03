Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF82FCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EC94402BD;
	Wed,  3 Jun 2026 07:33:48 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id C43AA402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:33:46 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso13411345e9.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780464826; x=1781069626; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzTWFZpNO10iZwC7ElXqkqOoCTisrqSmWmYrptUSr3w=;
 b=WY+yXnLCY5HxXX57XIuoH9b5BDYLLPiiu5jtP+ORV5b42yRccAKnXbjgJTLxuKOSQX
 WHDj/LjFMdpQfJouisbya66EZwAFXYjNtgD27lwvgL7WHOIKdYzVtoHv77uKoXuYWnKy
 mbJQHm5JxUbrsIJUyEZ7wayEV9Dcu1n3q6I7Df6v128wzILrWtLZ76i9A5nsk8arT1YX
 tTS8GsgvQBZga9d3eimqech2WF7kGLoubtXgiqg7yIyLYGdgRwCqCEm9icaskgxJZIFd
 6KGKKMtBcmrYoTLThbSva4S50BpSwreIdsptMPsrkxAMv1lKtsiz01gJ43C1Iv1uz2LA
 l4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780464826; x=1781069626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzTWFZpNO10iZwC7ElXqkqOoCTisrqSmWmYrptUSr3w=;
 b=ZGcuKNcH1Z3AoZ1SAH3iTFGK+HEFt+OELbAsprb+fd21t4xlwzRrWCUbr58XfjuK0w
 HlNKcToPAdM8HJ32oL8Rzg+P1fcjLx+IlVe2QCvZzhZfBiHJWCmUDBA5dRyj3ehMCmxG
 +pzYhDgJeWPRycmZSoY0LFpZLCHA1lE02mXqKJ8ItwRJoToEDr0Po8PhHFIO24OJLl+7
 6TTU+3XjSpyZ/F5WcKEv5xc+zHvywkTyVFMtOPIdgs4tttMP4KTd5klfb2TSDesG8wPX
 31jEqLPZDk9kVWrxUsGCy1T4z+yXUeQX9h5ATK6ZMz67fEaVdQ+5VP0EcKeUD9GOYFlB
 ZEoA==
X-Gm-Message-State: AOJu0YyVk7fY9yrFctMsUyPE53WW3Z5+m9Li5EncyRq/08iTyxAmebUA
 mv3O1MyzDROiIuk36SWxW1Ua88VFwFacxct5D/pcqgK9Nv2qfG2lQTV9JTtT+K+S
X-Gm-Gg: Acq92OFIq9kxhW1W6e5d3JKhGIFKnMVYDs3iPhy2OOzqtF9EyVUXxLNWydz85qa7OgA
 cy7VRzOY6Wi2/FeJGD+gzjn+9LLyVT61M6uuqlv0ntL4DONLTMi1fm+KeEpIBpiRTE8i6GsiVrT
 JVh/QwKlamICW7hIsaqTP1k00kkDXYKVdP9/Mw8Y3IeIPe+/vUNFGIude1NmPlYFTK1fdaxabg/
 xJSI1vPFZb/jqSluADnfIEVNtplJhwRsAYdyJP2Y0cWHhuJDeU/Wm7nZuPs+hQWY+9h3U/NODnE
 pvD1k0Tbyx/7wH3beTpb+7rNIm5iK+GApVwSv4CR7BfE25yJfJzUqKibjLcTwUCz5y9HWkm2461
 t7F1+RqCTCVyC8YgrLD+HBMyHkS/bRAX//IMQigY9vxijISCeq7MJl9QDrYVCYtrAPvN5P4EVZK
 BvyfdA6r6vTOgWzls/S/NK6d0iA8wUVhCENVU6cHUSd5a0r8UE3JCW42I8
X-Received: by 2002:a05:600c:859b:b0:490:b55c:cec3 with SMTP id
 5b1f17b1804b1-490b5e95fccmr21721545e9.12.1780464826203; 
 Tue, 02 Jun 2026 22:33:46 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e20a76sm107303085e9.4.2026.06.02.22.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:33:46 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH v2] net/ark: fix unsafe env variable in extension loading
Date: Wed,  3 Jun 2026 08:32:45 +0300
Message-ID: <20260603053313.119342-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603052604.118850-1-denserg.edu@gmail.com>
References: <20260603052604.118850-1-denserg.edu@gmail.com>
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

Fixes: 727b3fe292bc ("net/ark: integrate PMD")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v2:
  * Fix Fixes: tag to use 12-char sha1 (checkpatch BAD_FIXES_TAG)

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

