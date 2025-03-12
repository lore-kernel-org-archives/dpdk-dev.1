Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C992C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:18:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8882340E43;
	Thu, 13 Mar 2025 00:17:37 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 047D240E24
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:33 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22359001f1aso8777655ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821451;
 x=1742426251; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1GXH9VXd0owb32qRKJE3Gdw4of2uF3ErSKi+1agzEo=;
 b=Wvu8arUZA4rEsjdc1TAHnDXg3tORtCJSNTAZU0hum0a6tI0+RICFMBoe0NnozZib9Y
 jlzGQVhmM07uEloixYc6j+B73GdMs3YcaA29uZKUBbw0lUgyU+exFnXy9cOnd0IW4mHo
 xuQbVHCX7+QuUnQ45VRhB68zvhWZomBGG/dAWoWsWHXGlwAfJiPTlmx3e+FuuPZBgAk8
 Bd97HNgre2twtX18DQhZa9vPyKgHAymbEeJ1k97CSL4un0IlITvx5oZf0ltEOa3hgOTI
 Odh9FTEFt8KeQVhn4OuJLuTvDsdMajAZ6r7nqGa87jbQWJtyo65h1IGizVdeV5qej+vh
 ikJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821451; x=1742426251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1GXH9VXd0owb32qRKJE3Gdw4of2uF3ErSKi+1agzEo=;
 b=GCSlWpz7qvyj1WfMwaLaDp7mD0Cg3B0Z0wc60RB9Q4C7XJydNcHP/ytWd7QKPQ8ExK
 2KAJgapJbjc/i9DsBHGmvIcq4cBkBZOqL5b60QiiPNT+bGQSezhWGt4rnSOwaLQgHcpj
 eLHuC2yiGU97xTaEynsf/IgJrk+daLxA1Vr11300FcA8tsHIJJQu5Z9vPZk9j6zPtYeb
 vVr41VKcwwRl2L7hdM0A7X3SPpsPndJMM+SjYbQQaYaymrFnOf25+HV7YQ+/ALPfNMLT
 8OKtqSsxXFfSbKF3VQ4CaE4jhzJbbtXstf9qEV42TIgz6vZ2qcNZ7FhDnYv9Yicuv47s
 KYSg==
X-Gm-Message-State: AOJu0Yz/sY3DZMYcGUZPkJktMWl1IIEGyJJx7yWdxL0Zg6o8IjpVDhT6
 NojMeLOKQ7iRXqQuMIK/G5KmiFWer/00IgCgeC7JJgYqBeBCGB5SmY9dHTx7pmUC7986diuDhM0
 Y
X-Gm-Gg: ASbGncuKaYdp6mfuFjj8bQdjag/uIyWJ41lFuEaqQ+9XqEQ5oxZ+Ln9jpNWiaTWK3DS
 L4QTPrDHe0zJ7kkGRx2FV53Q5WEsRdeT9bIKYmV+g+/wG08D+j4/1QMRomg4vlgN56UXeBDiJXo
 dLfNE/EMaMMSHJUMZZCzamvcjbODo57cVriw+N5+obPgw/AdSF4GWd+ytnU8CNlB314ExPCXZ0X
 J897ZMSvOd+hv/jIQT89WoF1HcpLwMsta/jBt6+TM7qjZSXHJbsh9872mJ6CLoGR4b/Go7R3s0V
 u1pscu8JUYEd0wjWCXZT+a81QTBTi+L4cR54BN9Gg21xm15JaMl0lj+J+9omj4t/ykiAJMBMLgU
 8VPYzxKwDgDcuIhw2bmh11g==
X-Google-Smtp-Source: AGHT+IEv7nhw4p+GJh6fods1n1rsZasHRVKz6h5nD3FNqca/EzZmPHQgKycNhu+i7o4FxZJ3onGjmQ==
X-Received: by 2002:a17:902:ccc8:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-2242888a7cemr330194915ad.13.1741821451207; 
 Wed, 12 Mar 2025 16:17:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 6/9] vhost: replace open coded TAILQ_FOREACH_SAFE
Date: Wed, 12 Mar 2025 16:15:35 -0700
Message-ID: <20250312231715.222149-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

Proper macro is now in EAL rte_queue.h use it instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/socket.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 4c6c551c3d..dc9c9da9d1 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -10,10 +10,10 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/queue.h>
 #include <errno.h>
 #include <fcntl.h>
 
+#include <rte_queue.h>
 #include <rte_thread.h>
 #include <rte_log.h>
 
@@ -456,14 +456,7 @@ vhost_user_client_reconnect(void *arg __rte_unused)
 	while (1) {
 		pthread_mutex_lock(&reconn_list.mutex);
 
-		/*
-		 * An equal implementation of TAILQ_FOREACH_SAFE,
-		 * which does not exist on all platforms.
-		 */
-		for (reconn = TAILQ_FIRST(&reconn_list.head);
-		     reconn != NULL; reconn = next) {
-			next = TAILQ_NEXT(reconn, next);
-
+		TAILQ_FOREACH_SAFE(reconn, &reconn_list.head, next, next) {
 			ret = vhost_user_connect_nonblock(reconn->vsocket->path, reconn->fd,
 						(struct sockaddr *)&reconn->un,
 						sizeof(reconn->un));
-- 
2.47.2

