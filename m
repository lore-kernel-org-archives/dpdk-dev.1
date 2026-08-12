Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A072C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6209E40264;
	Wed, 12 Aug 2026 17:26:05 +0200 (CEST)
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by mails.dpdk.org (Postfix) with ESMTP id D946B4025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 17:26:03 +0200 (CEST)
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2cac634f921so4026315ad.0
 for <dev@dpdk.org>; Wed, 12 Aug 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786548363; x=1787153163; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QLh+Y+ydHmn27SRYEX8vavGoc8h+6ouDD6E2oQXQs6U=;
 b=U0u/UiV4UbULjUUFVpbhk0b4kGxjVX/o6gjZ5wdQ9fdLPgXPTe/H9kSSLATQHe2msa
 EYoc/x/Rd70FLjfCaGeQORkO8RgkmOWPC2w004YESLI8V+wi5fFvJRKeqV0hPvCAnrd/
 omUbgSzaOQLA7kyIqHjpJQlVtC7wZ2fU3fHv410LPExKMO8WQKBmUPk6jfeJFjb2L42a
 YsJvGKm6eotB4kX9tGLAYycawDVtmI8lJ/oRlRYOKVL4Kkkoe9zJTscE4iotBNx6FKDm
 zLcvpJ5w4N6fQILmFWDfbEAyi5/HfvLlJ8kzWfDlkbvW5xPvFM1wKoKTQn+C+4dRh/nT
 TLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786548363; x=1787153163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QLh+Y+ydHmn27SRYEX8vavGoc8h+6ouDD6E2oQXQs6U=;
 b=oNyM+FZsMAe9gNdupZcdJmoyfiY8cWJW/AX8WdoL4KpQCJrN+wksw5x4PAOcx+MJCP
 3ZoGyXf9weJ3e6azgi9Lp73BtnLCIvtz2PnLH0Q7c+y6SwTlEpQwjJ6DIxRAZ8MVOrRv
 KwscZdxRW+zqnqEw+AvUSr/nOtYaavF7ZMDfHE68/3m9zxgZe14Pt/mbmvx1VWdRe6TZ
 SHdTHgoipAf6V+D0ywaw5VMa8Vc/Yzk961Q5dt2P3qeRQ6xHs26x8+EGmU68wzMvzy38
 SmuXtL2m+lpDjw7HFwqebjfvjjcJ9KotoC0VHdXru2XTqrXNMQIYpYHGoc82hkhNvnlU
 xC/Q==
X-Gm-Message-State: AOJu0YxitzqI8+UDSc4bRIfPvDZkLt+VFkyWoD+krDhS5xe/yWKfdRXT
 zI9cf6L8ccnpMoO3iorAmN/ke1gSWlJAKiL4jipJQBn7vJuuhVoossrrOQfxp0bLBW/OoWCK
X-Gm-Gg: AR+sD13DbeXwILpQqJy6UsvQ7qwBM8twgLkMHYUmrF2ZXN2rYMjaSkEz5NAi7zRzsRW
 05/tu8gy/YkHwfwB59wS7ogT1nazXmrTYj5q1gKNxMAoht6vt41hjP5oQOoUAp/MKJ1G9z1UQo/
 Xsf4zmZYpUcGGPuwFdEXPVC8e0fqzmnqnF79yoWQRA27qyxEsopEmjeSggdtH5o6hXEmLKvqH5f
 qwzZEuSuoJvWxoFBK0E3AFH3mh5kgkbQWa+Mc45cbB1Q09FOgTZqe4XlR0HNWXyONuXmuKU4ipy
 ENXItLdguB+UrvICdUkSifhWkPXE6lHOmZg1xPmivUU0EXz5xpZSoYxQDHU+9Nx4YNr3DOUDOuW
 A9J7jW+oaAzGKpGkWBrvGMeuU1Hrk0EqpiNhjP68Hb3Hhmjs1Z8ctodwAbIiZl4OmJSOx+1aLcO
 ZTVnoU3iGxpXk9oG47VzlKIIteFRNkeD2ftS/8m6WRpz7ljTOViRmWshb99psE99KbWiuivt3Gs
 H+/Y11Z008dqyUPK2PyEr1zJQM=
X-Received: by 2002:a17:902:f68c:b0:2ca:e62c:9e96 with SMTP id
 d9443c01a7336-2d3452ae9b3mr69199115ad.5.1786548362675; 
 Wed, 12 Aug 2026 08:26:02 -0700 (PDT)
Received: from LAPTOP-H6E44CS6.localdomain ([223.104.44.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d35222e1cbsm8475055ad.72.2026.08.12.08.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:26:02 -0700 (PDT)
From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 Yang Xiaoliang <xiaoliangyang69@gmail.com>
Subject: [PATCH] examples/skeleton: fix typo in initialization comment
Date: Wed, 12 Aug 2026 23:25:55 +0800
Message-ID: <20260812152555.32070-1-xiaoliangyang69@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fix "Initializion" typo, should be "Initialization".

The sample app guide includes the comment via literalinclude with :start-after: anchored on the same string, so update both files together to keep the snippet extraction working.

Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
---
 doc/guides/sample_app_ug/skeleton.rst | 2 +-
 examples/skeleton/basicfwd.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_app_ug/skeleton.rst
index c4a29033fe..8a436b1182 100644
--- a/doc/guides/sample_app_ug/skeleton.rst
+++ b/doc/guides/sample_app_ug/skeleton.rst
@@ -55,7 +55,7 @@ function. The value returned is the number of parsed arguments:
 
 .. literalinclude:: ../../../examples/skeleton/basicfwd.c
     :language: c
-    :start-after: Initializion the Environment Abstraction Layer (EAL). 8<
+    :start-after: Initialization the Environment Abstraction Layer (EAL). 8<
     :end-before: >8 End of initialization the Environment Abstraction Layer (EAL).
     :dedent: 1
 
diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
index e8c18d5b87..3fdb83519f 100644
--- a/examples/skeleton/basicfwd.c
+++ b/examples/skeleton/basicfwd.c
@@ -176,7 +176,7 @@ main(int argc, char *argv[])
 	unsigned nb_ports;
 	uint16_t portid;
 
-	/* Initializion the Environment Abstraction Layer (EAL). 8< */
+	/* Initialization the Environment Abstraction Layer (EAL). 8< */
 	int ret = rte_eal_init(argc, argv);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
-- 
2.43.0

