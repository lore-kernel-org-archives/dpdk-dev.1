Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6BD73EBC
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 059CA40671;
	Fri, 30 Jan 2026 06:22:05 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id AEABE40667
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:22:02 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48068127f00so14154515e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750522;
 x=1770355322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iez7tlY8xl08bxg4f4bggzdIzvYjAanstB6O4TlkECI=;
 b=FbO5sj24GmbdpYNdwcq2b58cu+Zaifnw122aZrf0WopQPXygZE/sOsL+C2gghFfH/+
 hTQ3mPB5LfZtgGrNB2JQo3+JO+YsAAJwWAFDdWM2qLYPIi/Mo/ja7XWuh5kA2D0XGqvv
 I3yQkN/rgH7yDC84caJRFqxGb5CjD+hjMYKnXl9abzuMjokDgRrdmE66z2Hrt4dZcvl7
 YsPPfV508AawvgpMxq4PgfXjlg9BHt8hZSxRW788QestxP70kL8CFzTmnPYHGxgKVW++
 N8HVeb/WYUEpQv/uLDm+73wxQL0hAatDRu9oPRJyLK8aiiBA7BQPIHN8gHFI0EW8SSXi
 DlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750522; x=1770355322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iez7tlY8xl08bxg4f4bggzdIzvYjAanstB6O4TlkECI=;
 b=w+a74ErAfj/FFa9g0hHN6IXdKqHri1QZGsAQ/z4zH/g2jDpY8axHiTHIBofBH6rAvO
 59mAQRnJqUJNnlxwImSIYeowu+eiHC0ulIwSJE7FtmPvaqHs3A3BzW2DnC1zNMzH4gnq
 o6y1gmitCXBmadZ8sE5XpLLip1uBCZDOuAiVs9Hfrh/aUj5g4xaIZS1H0kDWp64uLy0x
 eSoBMdOnRP1JQkqJfR0qF8BANL9NlBC1I4OG/1EfbZydl72I6GjYfNxyF2b9TeQVinaM
 fNqr+r2sQl+6gl8fBgLQoDA08stquv9/i5REnD+vYsH+FrWJoplVzQ4vq+FNF3iE9EKs
 iB1g==
X-Gm-Message-State: AOJu0YwHMsf8NAP3smbwOAoWIE9+U1i1sXd/dN8gST8SHZlVpte5IdtM
 FMYAsojnGicinvv4SBiDAZ0fg0p3/sDYzSqbwLelmFBJqb5v3A6wSyub022KRdZnKrPpYJmW3Kk
 al2ef
X-Gm-Gg: AZuq6aI8WkNxPvNCRcahBU3zM/H8SCIsUaWEC78Gukl9D83QlPSTiPVtTsJZyXQfcI3
 25jD88B6QFnbqt5AjUHFfR7VarpsOPinlPVtSvX7fuB7d3whgUkBqelF18pQgzCbzeeSea88feu
 rWIKFyluorocN7Y5ep3tDzU9ENiUazNMUZ8rmk/IbA1IPjojjZZy4fsacWTVgucZNXh4T7tw7y9
 T0J1aFuZNydRJf+x6pyH1q5sf7g8i1OiAjtDQdTYSFrZorKZ9dLPX10Id0WeQkgOY+J68P0npJJ
 JIG+toHJabxkd0HG20CBNKSs7yH8DvqMj2t1e8hgpMbsxC1O9IpIE1fcFh4oDnChU6oRS2gTe7Q
 o0C9u/C3JBWkUd5PK/IhHs3t1vBUOqIx9qo+AO5pjonOyEpvlHVsBrGPxPuIPh6YDJGi1xHMXQN
 wRQMucRRybUphRkK2QodIYVIKXMlM0SV1WBzBwNXG1CWMPp4pzhQ==
X-Received: by 2002:a05:600c:628d:b0:480:6b76:dfb4 with SMTP id
 5b1f17b1804b1-482db45698amr15324395e9.8.1769750522286; 
 Thu, 29 Jan 2026 21:22:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:22:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ziyang Xuan <xuanziyang2@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [RFC 6/6] net/hinic: fix mutexes for multi-process
Date: Thu, 29 Jan 2026 21:17:37 -0800
Message-ID: <20260130052142.251649-7-stephen@networkplumber.org>
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

The hinic driver supports secondary processes, as shown by the
explicit check in hinic_dev_init(). Multiple mutexes are located
in structures allocated in shared memory (dev_private and
rte_zmalloc'd structures) that are accessible by both primary
and secondary processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

Fix the hinic_mutex_init() wrapper function to set the
PTHREAD_PROCESS_SHARED attribute on all mutexes.

Bugzilla ID: 662
Fixes: ae865766b334 ("net/hinic: replace spinlock with mutex")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index d3994c50e9..18148a119e 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -197,10 +197,21 @@ static inline u16 ilog2(u32 n)
 	return res;
 }
 
+/*
+ * Initialize mutex for process-shared access.
+ * Structures may be in shared memory accessible by multiple processes,
+ * so mutexes must use PTHREAD_PROCESS_SHARED.
+ */
 static inline int hinic_mutex_init(pthread_mutex_t *pthreadmutex,
 					const pthread_mutexattr_t *mattr)
 {
-	return pthread_mutex_init(pthreadmutex, mattr);
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(pthreadmutex, mattr ? mattr : &attr);
+	pthread_mutexattr_destroy(&attr);
+	return 0;
 }
 
 static inline int hinic_mutex_destroy(pthread_mutex_t *pthreadmutex)
-- 
2.51.0

