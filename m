Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 22:35:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E0F40285;
	Thu,  2 Jul 2026 00:34:59 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id E5FAA40279
 for <dev@dpdk.org>; Thu,  2 Jul 2026 00:34:58 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-664cdeab266so1585773d50.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782945298;
 x=1783550098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n+qHyeDvWVCGi91NM2cR8jDzzA+uO/C8So4h9Y0gxas=;
 b=yrC7kM9bGjX1aiJGc+7PJZ8I+F3gr0pkJr9DUqnxkfomsHCgTth+uFRT9y+HXuN4dY
 +w3h73Ejn/xeFXIk/mORyRJ2hDkEm9pjNM4q1CGQThvmQqLgYo1qWN57Ye8D+yqzAO3o
 ZeLTjjGDP4CkxxLvfyU+jW7cBdk5Mp8lQhnsCPcR94t1LdGnXAgzyaJFbo7ljj8mI2vm
 mmLcBhgkejDH6EYyBHhG4gYw8EFoGNX+sqGx16OlRPNdwEa6PVCip7J4j4yX/f4BYdXF
 NYqhZbeY6SlLBXUyBYUqpMMH9vcGeQUkL92K+CSoQCg3mQQWMY3qva8MO5bjSqhd+Ovj
 9v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782945298; x=1783550098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+qHyeDvWVCGi91NM2cR8jDzzA+uO/C8So4h9Y0gxas=;
 b=HC7OuhFwBlhflmHPA5IsG77WXry5k81tb1hzD9xtG6f/CGZY4pe9FimmruAYHNNmJE
 N64hgwE9OPe4nCOY1AecE/VLjBjRpCktAc4BQnr389tzdpqgW9IGuv1rEnWZS+goVWDu
 pVCVIPEintIHCbEN+ek4l/cBS61v9g/ENSfeg/GNlwa0c6Zqh0ExYzGOcl47lE+SWhpc
 28XE3zpWu4aiETHFnYRidaExJ3uAkQbajuTau4HTf1TCPhkLnZZJN+BbVQrJ07bVbXst
 bq1yd1gTcUdDtOMyLgWnH8I9T44qj2XNZ/5C8q7KiUN5eRI4UkFY/rHw3n21Ev2R1U/G
 3+Ag==
X-Gm-Message-State: AOJu0Yyc47v9pWGX/T8CsWubRKY4J1Jxi2xY0tTYsfm9NasBKb1aJsK2
 NHeh7qnqtIU95aMnQG2UkuKZaeMMrLSUAH56aWCLsCfhWUoJ2lJN1yoW0bjMiS8vZ8F+/m5RAXf
 rrwVt
X-Gm-Gg: AfdE7clC+XBKBqo/Nvf4e4spz9c05Uk+Q9bhI1+bjD4AR5ucZM4kFY8nCsyVTUnT101
 CSTCndu38zNJ1+yL3r1oLT20r6RKqjQMPrezOeW7MjtJ8HJdO7XjVOP0hfFzkyT4g9ekMHAlgGJ
 BDxIU89or37gszzkOXWal6TL+fXD4BQiM9zIVmhoYcsfb5rYM0OODPHVw7pG+Fak4trpcq7Codh
 dli4014iYmcwYLR7kbw003CDkd+Ntqn4sBq1zV4f6mzu9zTDdM+oFCcyIKb1VFe5qRJ439GQO+k
 ztvw3lG7dtokPyvqPtLoN7+i5z7dbAhgol4RPatex9ZldqNrdTrFZfM90nXGfh21jS97mx1pLOB
 UFShKMd3OPllAoqSgkv+5d1s2Cxz88LOCydN5tI5wCdoZPL2SkOJ76M2Oh6BKOeaiM1v6JK89Vh
 K9WRAeOfeboKpCxZ+iyjAigYBLHjFgO4oA2pIyhBx3lgIZJoFmETk=
X-Received: by 2002:a05:690c:311:b0:80d:66b2:852 with SMTP id
 00721157ae682-812eae804eamr38300257b3.44.1782945298000; 
 Wed, 01 Jul 2026 15:34:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81448219f1csm5678887b3.20.2026.07.01.15.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:34:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH 1/2] bpf: default log level should be NOTICE
Date: Wed,  1 Jul 2026 15:34:51 -0700
Message-ID: <20260701223453.104660-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

BPF is used by other services now and the default log
level should match other libraries.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf.c b/lib/bpf/bpf.c
index 740c080591..695454a2d4 100644
--- a/lib/bpf/bpf.c
+++ b/lib/bpf/bpf.c
@@ -78,4 +78,4 @@ __rte_bpf_jit(struct rte_bpf *bpf)
 	return rc;
 }
 
-RTE_LOG_REGISTER_DEFAULT(rte_bpf_logtype, INFO);
+RTE_LOG_REGISTER_DEFAULT(rte_bpf_logtype, NOTICE);
-- 
2.53.0

