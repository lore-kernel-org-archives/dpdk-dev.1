Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E29C54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 10:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 386DE40616;
	Wed, 29 Jul 2026 12:49:22 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 95FBF40150
 for <dev@dpdk.org>; Mon, 27 Jul 2026 08:28:51 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso3396715ad.3
 for <dev@dpdk.org>; Sun, 26 Jul 2026 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785133730; x=1785738530; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U+hTmHCI6YLWe9bojXcIbRM9rv1EiOMh61/WbJ29d18=;
 b=KDDxM9+mymy1w3oIj+Y6bDAbUVrvvjosn/j26vU++1ibNe7Mtq5uCR9uoSNxXjk/Q3
 kew7FJasfveiw+dvk95KDGlr9Kn5YN2bfdnvtsNg7RiKPTP8UWtqyhYLIIjEq4nzGY/I
 prcvp5Pck6KtyvpmRLwjJ7hZvtenlAJVOPwkTrOaogMwqnZjBIcdbnRRzXqsqrHLIuof
 bEtoM3m36wRxy1sr8DYWzN2o4efdZRgu8ecMWAMf20bVrq5i9/Mh76uMnjuFqbU4CIpz
 bVCoUpx/jtf0V+4ynGmtRIpe4ATdtOgNso72gdtzGBdge3vwihFvJuBWPx+2giw4R4iR
 bUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785133730; x=1785738530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U+hTmHCI6YLWe9bojXcIbRM9rv1EiOMh61/WbJ29d18=;
 b=PNW6me2cx0UI+HsdPhgPqrMynGdBJPmh+fbBw4FEsU2eJZDZumUGvc+v2MB0UqlrDr
 R4rEpR85XIzDQO11ty1dEk6x2AZDKknZzRG/Kyw7H1CeYnG8oQs9GxwOKYOvB7apUV1m
 FYCClVVVJ7GnYmAwD8sA6Pg+QhsWyDrZi11FBY/1G+g1g9TUrIpqXA6HoD8NFWcUzXbb
 m8rGnUMdtpsJUVnZyqM5BDK7CzodSaiyRyXK0DX8NFdZSpQUQmnaUkZLRP7NHApkmqmf
 djrhQalh4UTMixlt0ELZ8bSzNJnIfCpBs9oEHPNgulUb7RgQTIMVpLz12ZTvbe9lziW0
 /www==
X-Gm-Message-State: AOJu0YzXnsSwFG/6kWQ5qBHuGF7ynl8+PrlCE5XAdNVs2f0Jphq+8Auw
 I/kpuXtozSbZALb9XkElGxt0wg2iZhLUuJYCP/zUs+8/snoviQ6BkGDQ
X-Gm-Gg: AR+sD10eISA4v2OWcIaS4izfuTyevjSBYpr0xNA7Jbw7fbc+u9ijExUFijh19By1onF
 m5/EaTfYMjF/F5LogyyYCfpgZ/drwzGYZvvpbW9rnRwHHSPUd1FldLTEZsRyY5oOd+/UB/jXcE0
 v0P34LACWkwH8wJJN7i6t2o432uks9bMXdRFU+QOrQ9tJK99aWn/jEWqqG2tzfxjl9GZImOVd8A
 1kgsmGCBbn6XfSem8jon57RxGXHPNzPNuZbOeBKxcX4Di7nkX975kKLN2ksg9z3aCLiIGUABCnJ
 JZiNTc1nUNzGZspWzlTj6lm5M/X4RWo94t3T+Q8atwZoQQxuM030VbtcwWzep+Dgs7CgYXf39FZ
 qkm6MuA4HJUof/NUVMXo69Ek1LBoZOMlWv4JIIezA55zi3fXij8ZX5T+oryP1Mjf7Xp75oQFJEu
 O9r6xcW+F992bwgVp4osFmSHSSaOsiMeBvzNJC7TSvR9B1jbg=
X-Received: by 2002:a17:902:f68d:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2cfde67b9ebmr72766105ad.8.1785133730514; 
 Sun, 26 Jul 2026 23:28:50 -0700 (PDT)
Received: from khadem-VirtualBox (mbl-65-129-4.dsl.net.pk. [58.65.129.4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc59e9fesm25298023eec.27.2026.07.26.23.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 23:28:50 -0700 (PDT)
From: Khadem Ullah <khadem.systems@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Khadem Ullah <khadem.systems@gmail.com>
Subject: [PATCH] mailmap: update Khadem Ullah email address
Date: Mon, 27 Jul 2026 11:28:20 +0500
Message-ID: <20260727062821.42394-1-khadem.systems@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:49:19 +0200
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

Update my email address to my personal account for
all future and past historical DPDK contributions.

Signed-off-by: Khadem Ullah <khadem.systems@gmail.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..ba44cb17ce 100644
--- a/.mailmap
+++ b/.mailmap
@@ -877,7 +877,8 @@ Kevin Liu <kevinx.liu@intel.com>
 Kevin O'Sullivan <kevin.osullivan@intel.com>
 Kevin Scott <kevin.c.scott@intel.com>
 Kevin Traynor <ktraynor@redhat.com>
-Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
+Khadem Ullah <khadem.systems@gmail.com> <14pwcse1224@uetpeshawar.edu.pk>
+Khadem Ullah <khadem.systems@gmail.com> khadem <14pwcse1224@uetpeshawar.edu.pk>
 Khoa To <khot@microsoft.com>
 Kiran KN <kirankn@juniper.net>
 Kiran Kumar K <kirankumark@marvell.com> <kkokkilagadda@caviumnetworks.com>
-- 
2.53.0

