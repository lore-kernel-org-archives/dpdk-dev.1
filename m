Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212EC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 16:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 292CA402DE;
	Thu, 13 Aug 2026 18:11:11 +0200 (CEST)
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
 by mails.dpdk.org (Postfix) with ESMTP id 00930402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 18:11:08 +0200 (CEST)
Received: by mail-pz2-f0.google.com with SMTP id
 41be03b00d2f7-c96739a46acso1139346a12.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786637468; x=1787242268; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x6cMKCVw5OH9E8vDlNpCrR42MekREtwa5MUrqdr2FJg=;
 b=tBqQH27CkGJZtQb1C6Dg/UAOn35YSP0epN2EULcvZatphiPyZwoymOky5Pi/Lsd0Ii
 Oza2f0A0yA7IRJYzqiq1tUBhzJj1n7cF+9WuqdqPKfsbaOwfL6ZaXKaY2IVNHfosBd2q
 HjbZIZIa2EPvfqjd9eevHw9xij/gDgsq191UaUteMtypR5eMKaG5kDTOWeOlVdHGKZtw
 nJGo/Gp2WOw9NqMC+dBkYfrAjSaGWqrsGi7OjzjnYlLq2jf8p/ZwuJJM7VfZdgD2csDd
 WBxqTjRuDD3i8pIxioCjjmaA6iVILWlcIICoFBwdpmmwkWZj1aI5hDtwIoCFLvlyEmAU
 ih7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637468; x=1787242268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6cMKCVw5OH9E8vDlNpCrR42MekREtwa5MUrqdr2FJg=;
 b=YSRh2ElrK23/8JxODClfl57D06vzMW8fCQFL/rw1QsdZqwxbObFYqe46Lv9u0UcHVn
 pX5pbloYoNo6tEAy9jEZRurfblaWwFWe1fbff3uBOMMKaQ8IwJAIl7yDCnkwXX1ExgpC
 nE/DIJ9lo/z0lZVV6X7uxiwOF/VXqZu5U93y6bBzf6o4xIoj81G/1gDQEWR0gY42tWA5
 TmhXLPTurLD/HTdDs3RDHA8eZsjlcYbead1sEQ695izLMJV5QByfC61dTy1ulZnJzxop
 rnK3+mfKjQGXnZK/tzwCz3F4RZwOyE6Qip8htW5tGUv8tH96hJE1/HPmiicksSxt0X7E
 6edg==
X-Gm-Message-State: AOJu0YyUwkxVNyrsVywlyRvkkSE8ZwWPwelhjgedrz/RvY9Inhru1ans
 JIu1rT3PmU1ddLjsyIfldT33AqcdClCtETLlPxr7b6GywzNr2L8OfM8Gsd9GZBz8xBsz6gE55sQ
 =
X-Gm-Gg: AR+sD10CoiFujtq0TuZhlD/nPJ2gtKeIwu7D/t6CsltwusgexKVU2mubZ/YYCqLxyHi
 LiL7p9dw7RBaMWlenOnSmvOlueADvklCd+J/DzYXVLT+b+sHlMiNbAVwBFNPAwxobweHu+vTPdR
 TcnNEDLgvdIGzng3pp8KmFvFx7p/Kf+0T7gAK3JSA/sA3/uizY3fGLmjHVv53E2OjFRimsHRXcp
 Y8PRF5fonLzPf8hiUqQSiTjnDqP8WTexaZlBX+TgYJYUfhGEU3OlE+96v78hDTG2EmBzfl1L1Oj
 BZJuGLRzENzuQcWYDFPQ9pNbdmlpdMQvbxPkM45aolJf3QpbzU51/ukrIiJg+sVJoxtegxz4C2r
 fso6K9dH4mf5ZuYv1OckjTPUrNYY1u6jjn3UM/JpabFLUHa4aWfPPuSbRyok5K1fzkfQE4OSw9w
 bSIO4YVo8+RjAUXbuOIY6LJx9Hi6geDeM+ujyLNdS7brAtxCfErEA8pCRx9chg4mLF1Qxm6D23j
 0auQO7peajN
X-Received: by 2002:a05:6a00:1d13:b0:84e:43f:7188 with SMTP id
 d2e1a72fcca58-84fc6d9c4dcmr8087201b3a.12.1786637467946; 
 Thu, 13 Aug 2026 09:11:07 -0700 (PDT)
Received: from LAPTOP-H6E44CS6.localdomain ([20.78.144.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc45692eesm1184766b3a.11.2026.08.13.09.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:11:07 -0700 (PDT)
From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 Yang Xiaoliang <xiaoliangyang69@gmail.com>
Subject: [PATCH v2 0/1] examples/skeleton: fix typo in initialization comment
Date: Fri, 14 Aug 2026 00:11:01 +0800
Message-ID: <20260813161102.41575-1-xiaoliangyang69@gmail.com>
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

v2:
* Wrap the commit message body to fit checkpatch's 75-char
  line limit (fixes the COMMIT_LOG_LONG_LINE warning from v1)

Yang Xiaoliang (1):
  examples/skeleton: fix typo in initialization comment

 doc/guides/sample_app_ug/skeleton.rst | 2 +-
 examples/skeleton/basicfwd.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

