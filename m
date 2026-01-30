Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724BD73EB7
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:22:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FEDC402E8;
	Fri, 30 Jan 2026 06:21:55 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id C8598402F0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:21:52 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso17505005e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750512;
 x=1770355312; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCarlbCP6+ZUc2h7goQh+psgyAEUNY5s2Fc9ccpKcQ4=;
 b=No6I3+4byH08HPSZQBE4KFXMfj/TDprN5cDtegXIXI6rEuX6scEmP7/6Elk5C0YYtI
 rTTxi68KYcDkjMylBJOgKnye8XR17v8/hY9FijqGsoetYujLwa1OVedDa/YIRx7XbV+L
 kmtyJ7XqfdMjgAP8IAC6W5zKH6ilBYUndhjlFsSvKIkRloqvAtaQChUiBC/HqNY0TEr3
 dISnUuMBg8i7DpovB6qv/93lwqqMkJAWOnJ5/8O7TVNYnCsLBmLccZpCCh92HriUHUiY
 kAOcEKGPXFV6i0aMb6SZNVfWkbYGlKlBRWY6DvjIlvwFmkgb1twrCgdUDTfOA/wzWF/Q
 c16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750512; x=1770355312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCarlbCP6+ZUc2h7goQh+psgyAEUNY5s2Fc9ccpKcQ4=;
 b=kH6OiMR0ZUbM+e6l0uLD6C45zzordnUCjWje8y3Rzu5O3Q9Hwucbqyb6R3jQ+OulzN
 S/levn6Ku0X5EI77VvYphg6yeZBo2nF/B388sbpbxLsKJ9iMyNpCxyBNKbQHOyKOvvii
 1BkQd7BPDDvLyJHk34SjOsfCdZZFS4VMNHSO6c1ukzd/kJ6MSrduWu0ZIJMMj+KS+176
 vkNQ/jR5zUCyB12zyskULtZRXrEptooK+w40znJfHZ11j23IgumrDOi+1yAVcd65wD+G
 C6AXOKsetHWh9vVqcDagxyZEKmhqG6OrUH8KFCW3mefzYo1MiaZpJoKhO/b4XjO4+JSa
 Umkg==
X-Gm-Message-State: AOJu0YyWQvLd9ArfXfX/fhx83/arBusOFrDt+q+XfNQHfhRjbRn+t9JT
 OkDMDVPRtoexgpNH0XpSaTv3LBEzM9tbVWHjHBe6Od84olnbRHq+YHYxmDfbtkb1p8X9beb6ajQ
 6FDnv
X-Gm-Gg: AZuq6aIwAep7A4meXf1x8AkVGPG93+ldwn8G/ewI6MZWClAqpMAXK39qKyRTONYSwqP
 ZR9Z9EJmPAAF7bk9UaCyAT+O6RKwrmUQwOSHle/+B53EaVNZdhgIgNp04+37vbSzcUnpbtuskNV
 AWQxSd4pq2mU4aVy4nzigRbdOrxMpVPwEmx6ORfePmGk16gFPvPmzEhMr59g9yyBrxrwTLtkQyE
 /IzhhqcQuIMlITLoyaf1GN+C6yw3NubnK+2LuMjuBFwaD+0zGGFBWQw+DT6j+dWjJeQBoprTJKS
 KDKKKOW5ZGNzBGD2ngxXPFkM/OOL+IKLgmJAXV7cVhYNgrBmR5NA3gXi2uU8UXvP5dazx46mGPc
 wB3jB9c8YduQwampYtgN42NynSIC8Zlmw5+ePICsahJeO940u+mGQj1aRaYji4VdsUdlVZ+FetU
 SOR/wXoN6X+0Rj6S50FdaEvwXrMqKhmBFwIyKPVZ32So6s63xPTA==
X-Received: by 2002:a05:600c:64c8:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-482db48cb4amr18522435e9.22.1769750512424; 
 Thu, 29 Jan 2026 21:21:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gaetan Rivet <grive@u256.net>, Matan Azrad <matan@nvidia.com>
Subject: [RFC 2/6] net/failsafe: fix hotplug_mutex for multi-process
Date: Thu, 29 Jan 2026 21:17:33 -0800
Message-ID: <20260130052142.251649-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130052142.251649-1-stephen@networkplumber.org>
References: <20260130052142.251649-1-stephen@networkplumber.org>
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

The failsafe driver supports secondary process attachment via
rte_eth_dev_attach_secondary() in rte_pmd_failsafe_probe(). The
hotplug_mutex in fs_priv protects shared state but is initialized
without PTHREAD_PROCESS_SHARED attribute.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures accessed by multiple processes,
pthread_mutexattr_setpshared() must be called with PTHREAD_PROCESS_SHARED.

Also add missing pthread_mutexattr_destroy() call to avoid resource leak.

Bugzilla ID: 662
Fixes: 655fcd68c7d2 ("net/failsafe: fix hotplug races")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/failsafe/failsafe.c b/drivers/net/failsafe/failsafe.c
index 3e590d38f7..aa3fe53b22 100644
--- a/drivers/net/failsafe/failsafe.c
+++ b/drivers/net/failsafe/failsafe.c
@@ -144,11 +144,20 @@ fs_mutex_init(struct fs_priv *priv)
 	/* Allow mutex relocks for the thread holding the mutex. */
 	ret = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
 	if (ret) {
-		ERROR("Cannot set mutex type - %s", strerror(ret));
-		return ret;
+		ERROR("Cannot set mutex recursive - %s", strerror(ret));
+		goto out;
+	}
+	/* Allow mutex to be shared between processes. */
+	ret = pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	if (ret) {
+		ERROR("Cannot set mutex pshared - %s", strerror(ret));
+		goto out;
 	}
+	pthread_mutex_init(&priv->hotplug_mutex, &attr);
 
-	return pthread_mutex_init(&priv->hotplug_mutex, &attr);
+out:
+	pthread_mutexattr_destroy(&attr);
+	return ret;
 }
 
 static int
-- 
2.51.0

