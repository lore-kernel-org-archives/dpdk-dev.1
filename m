Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37128F9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B26DC40652;
	Tue, 14 Apr 2026 16:42:54 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id F368140647
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:52 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c42a23c8eso3746082c88.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177772;
 x=1776782572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RElhfK797bKlsPZtiA6sS1lAqn1B6jWXLfpJ0qmOLc=;
 b=KkfFNp5nwcaQZ/rp+Uk8dlPOy+9E0UNxvCS79Kl1G6dock7q3DxqCIHujHNVfdEfE9
 Wx7oMGEgSBN3xllJmPIomvlh5Y5pQ9OrTBQ/aPBB87M1rXgWdtwQHBrpMv4gBVyWRQhN
 fgUeFTMeVt+l661/0m9RHBrZgS0VRZtDS+QeBkBumeSrAlobjBRDiNKlzONCEVeyUClC
 40wZecfF9G3C/FchDpyA44WI3HvsEFqeAFvGfOpRIzFAKmaREGTn4iWzcXlIp+Z4t8NU
 SmbdG4pimZX9u/aqerh11qByUSTlZJhe2smKk4cG3nGm0zkSxQ94jOtnN64EKKnjYXkl
 eMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177772; x=1776782572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+RElhfK797bKlsPZtiA6sS1lAqn1B6jWXLfpJ0qmOLc=;
 b=GAwybodtLwpuZarE1OGhnKSAUqM7TRdOP5vH1FkrrR7ZhQLzfM8oHuQIkN4LugoCQD
 2bTxDDFbqfx0e3+a7G+c5VUaqsMXJ7wKp3bMEazr3okBRQzYdV4RFcySflJQ4S4IKQ1M
 7H3NIQxVcQh6bwVavvJ+GStP8HHvP+fqm+Gt2xNqlyIhJkPA1jsxi9dERdDdM9Z5eQgU
 +m2IxkGE759ATbDVftXokgpDa6Q0eBZoCzAnhz3ofzNsD1bdPEhONBEVp8P1g2vEjYqW
 KQZM/qjik+iNt8VbQGZJcC6V+tdUVuMwXoThr5UEQK+wiTOqYVoK/Gr/G/Se9VTsIjoA
 5dkQ==
X-Gm-Message-State: AOJu0YwiMSnMCEKzqg1hy5BHNX6lowyHP5mgx2zcnXPi4A8uSIBK5KDh
 ukHG9J+b0XK+W6dzqilMvDLBB8/2+kZ5enRR3J11G+TnigeVbgB0t7v8pqxqhRVZOQ+XvkibwSy
 x/UL/
X-Gm-Gg: AeBDievnfxvYHxOypCchBipGtBMr+Aq6BKH0/VYUSYiI4CTM2OglyZe2sRnHDM2xGNS
 FhvtM+HJHqwV+s9dhicW+UTomurknWE1Xrg/QfjezPtkH7d6Hjh79i30JmdSFdEmhG8EFr3wRhP
 zsGih83/0ANpT1vX7wl6geWc8Pa2Wd6Mq17b1Dd/H3gcixHiZD8m+74ypM6KclLVEJlwQ69gSYt
 JkaUOxraToQPbged6sW/tyRT5c00eUntFnaVi8rQyApV/ddbXz80UDFdk1k8WRpMXysWQcefiwt
 2f6KZu3lE+ET3fOzSslRd6QDFsqcddU5ZIc1Zt80xd9c8SYB2ZUBMCnQ0jCoxgR6RKFzoUfNhda
 e3q8WtvXsfCmOIrG3wbCYW1nplxS9xM7jSzu8ayGYDGQmhyiooRv+uYU/UtQ4Qay2lXWqx8MuvF
 rxBK7oimoHSVuZItfVRI2T7S8xbeqExMEVFduix15kKhw=
X-Received: by 2002:a05:7300:e82c:b0:2cb:990a:b5e with SMTP id
 5a478bee46e88-2d5881acd8dmr9333658eec.15.1776177771761; 
 Tue, 14 Apr 2026 07:42:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gaetan Rivet <grive@u256.net>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 2/6] net/failsafe: fix hotplug_mutex for multi-process
Date: Tue, 14 Apr 2026 07:39:54 -0700
Message-ID: <20260414144246.110681-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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
2.53.0

