Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4582CCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6068740A4B;
	Wed, 29 Apr 2026 20:47:49 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 681C440662
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:47 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2d96243c91fso209649eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488466;
 x=1778093266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1ElsO3Efp0jNl8cbTqINhymF+vD7cwcSRmpXWddVkk=;
 b=dOWn9SPyLEpeJnTJdARCb9zu6o9kFFVgxZHT41es9RIQgFOwQRIRSdlckJhEaWe3MJ
 yM7qlRBtjnNje735Vr5sEIVqBc9i+iEC0ahkazfDlf5mMhXXn4UN4Il4k4/FJ+jiALnq
 jHXgaYzyCnDKahhvMnmmZgjKPNhmgxVkHbhjFMa5u0aWGfNe5DYe12Pvxv7wGQuo4za0
 zFuWo/Y3Bmm+YkR2ZLCYifgSX10ZMFQK8XDcqGv3FVio0pUmdFjfJOTpcWlMBHQzSjwt
 0744OiI5eIup0GvH3xsTJrQ3zEJ8stlByewIfw3hl7vVThDQ4POATWpB6F+DlfT1uwwz
 delA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488466; x=1778093266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1ElsO3Efp0jNl8cbTqINhymF+vD7cwcSRmpXWddVkk=;
 b=WvO76o35v/1WPFkM8x3OFqv+ay7slK2fe9URT6XDfNXgzprZ63PIC74yC7E1vQHfs7
 iKyGcWFHCJbJJyF0AGZWDCCAR2dDsi4HHAp1S86z8++FDKlAOf0jgdNenhfMkxsH+/i+
 v2wQTOTEnU/lv/t7kkzw6abLRKsN45ypd58inp8xRtJEZaZ92qG+gMk5rYmBxVGD4Faw
 nmBO0QlXWHYDcXQUDG9sTNw6wxQtpK7mn5CqlqUa4iyifQp0qbhlorfHgjgIIGA919mI
 qgjMwosLt3jGF2kvScKgjkLr1FNWuzT/+F6XuIkYLuGawXNNbD+mezfsFob6EcjGqoy0
 xnHQ==
X-Gm-Message-State: AOJu0YwqhDH8EGcTkzr5EaLq6t9WG6J5PEBfGHI/PJHPNSVNlPDduI0i
 rkwJCC2JfMU1k2x+dM6M50wEzq0FBsijO4moc3UU0ITb97iR15O4ZJ9hAt5N/xQJH6j6FWFKst2
 Svwzm
X-Gm-Gg: AeBDietfYBOlKHtXxxWieU776XSwK6l62zvnyb1tuMyOT1JpPdHGRVTsm+COJ4OjewT
 DPJYKV6ADe7N3AgxgBkOQ5TXLAVpptQKI67+hAhgJlWZhpbhrHQw/NrW6NFN5mWk7RiC4DU17vT
 6BTRIZXzzr4hhxpmnH3bXK6y6KrK2HAE8fQCGAwLKVRscOMOuq+PcIPJ5jxOCRhLsyacOy2SEq+
 gZuW1vFltGecNTIv0I/t+2VN6HdYD8m4t74hJLN9N+FnwZZvN+DAUVtPx5B8EdA04f1iyRQDr9E
 SSlpXtw6foWKiCSpQw7yBkCrJ+zvSrTa6XK/TNQXN8B5KIr1GzkW6FmV/MCW+OXTQ/hOIDAGXzm
 MJHwgduFO6pS306i9jQ6TFphuM8MV7GYOTvfGv9WFAOH9G2cb3GSgalRNeNDJOR7iA8fSxgEUdO
 oioBfgVQj9fIOqNoe/0JTeIZPrCLNyLnGU3amB0zy2R6w=
X-Received: by 2002:a05:7300:b58b:b0:2e2:a64b:63b5 with SMTP id
 5a478bee46e88-2ed0a1219f7mr4392069eec.18.1777488466494; 
 Wed, 29 Apr 2026 11:47:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gaetan Rivet <grive@u256.net>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 3/7] net/failsafe: fix hotplug_mutex for multi-process
Date: Wed, 29 Apr 2026 11:46:40 -0700
Message-ID: <20260429184739.706250-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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
hotplug_mutex protects shared state but was initialized without
PTHREAD_PROCESS_SHARED.

The mutex is also recursive, so the EAL helper does not fit; set the
attribute alongside the recursive type. Also add the missing
pthread_mutexattr_destroy() call.

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
2.53.0

