Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81638103E2F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 00:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE38240264;
	Thu, 12 Mar 2026 01:21:30 +0100 (CET)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id CBFF540264
 for <dev@dpdk.org>; Thu, 12 Mar 2026 01:21:29 +0100 (CET)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so331945fac.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773274888;
 x=1773879688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vQKnvVKs8el3lcGcJG+gOztLN9U5Pw9ufu4/E82cvbU=;
 b=Xn/TcJKmdbri8JkAtWjTXy3M5g2rBPlsBGkCaM9RavOZJQy/2WsEDq3XbdfmEvR3DB
 /fkn4jk9pmxXxps3Kv0d2NzbKUdm9JRPBKbKajCHQk9sZOPogNATeenaRoTTIc7W6rHv
 WgrVY+RGG6iP5lJfxKak8WXeHE6s+JfvXwwRh/lXUkfUrPHccPxsh0Av1aHFPpEsbAT2
 FCitzx16NhR/V2jm19g7dQG+IUlblBohvx2fN5TCy+AATg1sga61lhq0wpJJfyPwDQir
 CoFL1cebpKx97/ng5vd1D4WD+9LBGoGgnqercdDvwFZhZn8rClhxFyfPEI4KuTrEcSck
 5dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274888; x=1773879688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQKnvVKs8el3lcGcJG+gOztLN9U5Pw9ufu4/E82cvbU=;
 b=QXpNViXywRMYQjVaKzsHb4zDsVdsrbj4ClFXccVfbNWgavmlIJmr6YgGjJs4Fgu/td
 MeAtW9ytOF7va0TCWS5wSy3XUZEWFzm0GNagMnZJmH0oA9e+v3Fuwh2Pf+saOhGJxiUX
 4lJrcFpqVDsgr4AhWjgcFFKgMN1a0uQp5R2/XnZ3SrmdHdxry70WwcqTCI2OMeoquust
 VTGfXAxNzv4Oxte1QWpqMdNJeRulP86blNQn9buK6pqfHFaXoFgRDmPFPAMO/vJ0cjEQ
 I7TSNzuBrZ9WPUFlj51XW2mmUsmo2wsvthG72a3/LD8C2+CnyXUCFEyrIBNAZFwwwqR3
 KuZQ==
X-Gm-Message-State: AOJu0Yz9c1naQeHMM4JidTp/JfrPg0fPus6SVykMHSB31vQyiz45IGYh
 5GxS8jdhqJ0mDiKVdEbCX2k/x2OctLMRJbwkenSjZRJ1VfYZL5B2DmtC7Os2D/dKlfreXBx8Jrr
 2VGCtGAI=
X-Gm-Gg: ATEYQzwdlqfOi8OR+KvJvgObpAZKnD+JsGtzX18R6ttQC1/NmMFnVHEq5T5E2xxvS2G
 hdexTUOlAhVewGjZJw2Y0SwVk09Vto/GB2JHmDOkJrwGLAPu/znOmkewp7wrttziA1BOVQh06F/
 vp4GNEDBcIuwKKCa/2pvbIapHHa4MKtHqREtlzovJrVh9j3w3oq/MH2TB5CScNOr7QCgUytM//F
 IX88SzJCOhg6f7ClbjAh/VZDurK8seg1Q3u3yTezTC6w6r0SsiFPYcG8okcD4537SuhmxtYV4Oq
 ickaEDX2YRSdUDHgEJDk8mm5KstLdh+VR9zuBx9MVJtNAjx7snidpesLMG6yndFXKiKalzuKsjQ
 uQQQpRyQGdsmEdeTo7Rc8d5v5mDFhEWH/y1r9CRKLNKBEkC2jXwx1N/l3KGuDMXO4osoQZW3H4H
 +bcxLZlvTW6Jaze7y4UQwpwKHDcvn6TYoVEmeNcEXke0U=
X-Received: by 2002:a05:6871:b12:b0:417:1fce:805f with SMTP id
 586e51a60fabf-4177c6a5dc8mr2741312fac.22.1773274888506; 
 Wed, 11 Mar 2026 17:21:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e26e2c6sm3779484fac.7.2026.03.11.17.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 17:21:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] net/bnxt: shadow variable warnings
Date: Wed, 11 Mar 2026 17:20:25 -0700
Message-ID: <20260312002123.867357-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This allows bnxt driver to build cleanly with -Wshadow.
Part of a larger effort to globally enable shadow warning.

Stephen Hemminger (2):
  eal: add RTE_MIN4 and RTE_MAX4 macros
  net/bnxt: fix shadow variable warnings

 drivers/net/bnxt/bnxt.h        |  6 +++---
 drivers/net/bnxt/bnxt_ethdev.c |  3 +--
 drivers/net/bnxt/bnxt_rxq.c    |  6 ++----
 drivers/net/bnxt/bnxt_txr.c    |  3 ---
 lib/eal/include/rte_common.h   | 20 ++++++++++++++++++++
 5 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.51.0

