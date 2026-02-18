Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C4DE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 07:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27E7A40299;
	Wed, 18 Feb 2026 08:50:51 +0100 (CET)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 5C4874014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:50:49 +0100 (CET)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b740872a01so11148969eec.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 23:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771401048; x=1772005848; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr+xFr1mwyaWNzb+uX1X3QWsr707FEKp5LdylAkkYMg=;
 b=Oe9pt//qxGTltW9KCv0jLtbk0keJI9zzKPm+iyx+Xkj7LYbIu1sakSX8j832xYQMD/
 yDutl1KtMyrLH4RHYR/D2OYf1HpK3g0fEQO0WcajQMKlFkqbEfc3d71QoflFLhH/8nkL
 Z1hZbX6y3DtGhwUYUe0FJ9/+w/ynZFSAvFnv8k3OH9MWDPN8q145vXMarclOaT97an7C
 lsVgbpNqkBKWm9h/m/eLc6ds+v6zHwLINhP7hf+Mb4xR0wIrcvkGlMoLhw4yhnZkNDlm
 tsO9HH5Nqs0krmiBrAd67b0KlCv99SHR25YAri5w3OsCXl7+hoFdGagO8BEQMjRX9Kn0
 IAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771401048; x=1772005848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tr+xFr1mwyaWNzb+uX1X3QWsr707FEKp5LdylAkkYMg=;
 b=v2XLvCtyamqQhG+Gvg1wLLSBnE0Hr03BJtChkTd/eq0v+s162sYMxiQcWG/mKs08p6
 CJiipR9EKZClj38uF0evuFAJXRvc7NVJ6byc5gcbCWSKHQqRYbtJqTgw6gbV3xF3+wdE
 xt2BgKthZIsgvZpM4XeBEJX7GueBley56kSO15uKQHMXa6aEgDU7tDzRH1KQ+9F1v6yl
 BuzambAbc+Y8GqJi6arEcnTFLl2t3fmFP+JCTUNjAUanKdLQdj2avanmnDPuM7IVdtaA
 XHMl3XUaq0ZyILh1BP75omIqbYIprM+pSXf35AbLqNcYJJmUo+DyrQrG6KPtVLuSwU0Y
 49Cg==
X-Gm-Message-State: AOJu0YxJefxI2K761Jwev0igPCQE9ntTwdqURgu9l7NLC4RRAPudGHgB
 AvvZh3vqLmzt4ihN3SEE4DOiOG89YDihoKolq4M3TVsvgI+EodJ8lI7dF1ea/g==
X-Gm-Gg: AZuq6aKW5ZaHzARPCmpEt6/QdoN/22NN1Sj8nWS0ZMSrevrVjH/6b/3ie2Pnk6tLEYm
 Vqyz4dWWxR75RYh739mc2Rez9pbzcBjW84FJTvm/hsn96AzW3e5+VZr6R8UZmYWPPwLzYxP3vsU
 toyzwDvgdggqbbqHQjDMxNHemh1ouMnvKH6J+9l7k+2rd+Dm2ByYcLaxI46zLPuOCWB0PNsdOKr
 KfZ91tyA/1HzQuc/xLyhUnMHObaZHa50ZSjjqUZ4j5GzIM08NUXcbpJ/FWZZYSyNz0+t/MN5I6r
 nmroBqpXQJVkB2NgswY6gI/M3NHQ5IPgAb24rYTWlpkDd0x0VN6T6Y3Zq5NqJOadNW3cEu7eWAg
 qQycTuxBrdDrt10cSBMZotUsvdZvBwrDp/tGDhuMEHvjJHzKI9wm51vxDLndIkExj2YGBofcnZx
 e5HbU1wv2Rx6jBnogcaf9tZtPuuJh3onV5xeP3SGiPp8W0kIUwlFrWS0gOHByWvQ==
X-Received: by 2002:a05:693c:380a:b0:2ae:5dc2:3b08 with SMTP id
 5a478bee46e88-2bd50082621mr666366eec.18.1771401047746; 
 Tue, 17 Feb 2026 23:50:47 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bacb66addcsm17413864eec.24.2026.02.17.23.50.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Feb 2026 23:50:47 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, david.marchand@redhat.com, chenbox@nvidia.com,
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v10] vhost: fix use-after-free in fdset during shutdown
Date: Wed, 18 Feb 2026 08:50:17 +0100
Message-ID: <20260218075016.65429-2-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAJFAV8zTzM5vXEckOvLsH54p50PGO9n5Uj0R5krHSmUmnzKFUg@mail.gmail.com>
References: <CAJFAV8zTzM5vXEckOvLsH54p50PGO9n5Uj0R5krHSmUmnzKFUg@mail.gmail.com>
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

From: Yehor Malikov <Yehor.Malikov@solidigm.com>

The fdset_event_dispatch thread runs in a loop checking the destroy
flag after each epoll_wait iteration. During process exit,
rte_eal_cleanup() frees hugepage memory while the fdset thread is
still running. Since the fdset structure was allocated with
rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
causes use-after-free.

Switch fdset allocation from rte_zmalloc/rte_free to libc
calloc/free. The fdset is a control-path structure that does not
need hugepage memory. Using libc allocation ensures the fdset
remains valid after rte_eal_cleanup() releases hugepages.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 lib/vhost/fd_man.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..fae6d787b6 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -8,9 +8,10 @@
 #include <sys/epoll.h>
 #include <unistd.h>
 
+#include <stdlib.h>
+
 #include <rte_common.h>
 #include <rte_log.h>
-#include <rte_malloc.h>
 #include <rte_string_fns.h>
 #include <rte_thread.h>
 
@@ -94,7 +95,7 @@ fdset_init(const char *name)
 		return fdset;
 	}
 
-	fdset = rte_zmalloc(NULL, sizeof(*fdset), 0);
+	fdset = calloc(1, sizeof(*fdset));
 	if (!fdset) {
 		VHOST_FDMAN_LOG(ERR, "failed to alloc fdset %s", name);
 		goto err_unlock;
@@ -142,7 +143,7 @@ fdset_init(const char *name)
 err_epoll:
 	close(fdset->epfd);
 err_free:
-	rte_free(fdset);
+	free(fdset);
 err_unlock:
 	pthread_mutex_unlock(&fdsets_mutex);
 
-- 
2.52.0

