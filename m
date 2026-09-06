Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD5C79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 209734067C;
	Mon,  7 Sep 2026 01:28:02 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id CC32A40A75
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:28:00 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so2090846a91.3
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737280;
 x=1789342080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CuRI5Azn+pXTdYD75lR/dGbfWZLvmzbnE2xAMQxJHns=;
 b=hxqTM4iKDusp4QipR3F+XfYhzbSmZiIp0TYva4+TKIm7/JBTS+nO0CSKFbIkSIQQcL
 lyHyseThkMi4EHTCTzkswWM3Kt+sXC4nNS59pXXEgIhlkl1p1yVC1A537MrxB6Xa5CpV
 XExPTrOh4xpqLLVTnt2JEcwZ3WMLoa3VKINn/F7nzw2eDIO8wH1ZdHsTeL6L9EeNiQml
 MBbzNRaDW8oFfCTnX36MhtGPw9WFRF0e+o/LkYjO+UJqelK8Uys1J58t0oAMwo7nNVzW
 qQhFdybGiXkB+spZF6B9bfqy0TJIqYzaU4wf2xBnnbJzZdCu6TgSUDxDdLFgaV2XxrMa
 W9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737280; x=1789342080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CuRI5Azn+pXTdYD75lR/dGbfWZLvmzbnE2xAMQxJHns=;
 b=Hdou1EJA6e0mm+Tz4PoLMvrKWFhitQaILxAzK7AK7TnocYoERioagTEppPlhAoB1dC
 L0R0encvFBFQ29jz7I50J0x+jkXmLhS4W38y+Yu50IEe3NVWHP6HeI1WenYV5dLBsy+u
 ZO1AWL4TV54BpArjm/qbnnWs82VD+w4UhLC8fv2UAz8kKEk9zgVAQoxuMVHFFSsOgpkM
 5Ub/q3a8yiQzpH+DYuCKVP5W99mJnN8H3YWSMXjxn4+yf8LxppTpthEV4FxlNL+V6YMA
 ZZmP6My40ew4lrkniLdns7MrtE07Mgs/0M3MtgOtPNtTcnvZcQI1JDveS5/bvDaSEefp
 gLZg==
X-Gm-Message-State: AFuF++ly4TNbbw9NsiJF1tlTwZZiEdbu2N+vuRefvRK+a/nj7H/DVuMg
 FNY2TLL8fFbvG1vQ0FG9V9aI7bZetdaWcExD5ss+a+iufHa2kENVXP79T97iczhunnvpM6MtQYD
 2+dEL
X-Gm-Gg: AYBFou3JNVpaF6N7m3UPvr/zD0FYC61rZm9T9QhzGhiUIJDRpB8U1DXS364Cmj9l39r
 BgjOtZ1sR+7IwYVW766trMehohVefjVsQ433PXKkuFZo2qG92JVYbe5WGpz5Mp3YrkHAupjC+AK
 NletpyPUPspbi+von7LqAr+6F8t7bWhRw2N9/Wj5MxeYp9mZOZ0zII1zQEPBArjMsp9xDVhJdeZ
 BMg67ZFcNhWp/TH9pqGgHKGtgE2WiPh+IYDgKCTxOQjDdHOO36X3j3BQUpbtCCR5R/VQdZvhhbF
 Uih53NCygJikl1I9sj5IG7KqpphpyNpi6ZZ3lLsKPphk0iT0XohNw4Zy4/5wI2SyomRoqM4y3FQ
 z8ecLAus1rkW61205VbO2TXYd4n/BbZ3nkWNkbVyx20rwdCUX7IaE8fs8Sw5gPpeiVO9HmKGCkZ
 5lhNP1eWbe/6ipal4cwg9o2jO3jw7TjI9ucJLaPfWAnUSg7LCRlGlICI7HQph/LS9aRM8M3GJeS
 2uL0O1e5SShOjibYyFkA2t1MWU=
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id
 98e67ed59e1d1-39b2614df9dmr30958123a91.2.1788737279881; 
 Sun, 06 Sep 2026 16:27:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 10/13] examples/l2fwd-macsec: remove print in signal handler
Date: Sun,  6 Sep 2026 16:24:45 -0700
Message-ID: <20260906232716.496546-11-stephen@networkplumber.org>
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

Calling printf in signal handler is not async-signal-safe.
The printf was unnecessary anyway so remove it.
Found by GCC -fanalyzer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-macsec/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..33113cb0f5 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -1247,11 +1247,8 @@ check_all_ports_link_status(uint32_t port_mask)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 int
-- 
2.53.0

