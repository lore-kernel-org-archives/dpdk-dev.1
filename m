Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054BD2629F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 23:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECAB24114B;
	Wed, 21 Jan 2026 00:24:32 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id D5FAC41144
 for <dev@dpdk.org>; Wed, 21 Jan 2026 00:24:31 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so54724425e9.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768951471; x=1769556271; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=c5IIKIpygdn8sZq5kUDr0XfGRp0gxcg16m5aKEe+dUXC1HS+gu9Q3sNsk5vIU0iU/o
 3SOyw2kLS5vjoAZzoZAi9j/vGk0/S3A2CW98UQ+qqszRmpST0bwHRveLusyjt5uY/eaY
 ESxabzje1w/FenYe3deyc9XLsZZmxknGbeu2e6bICIcs2221mgM1Ny/9S5ZXs1I6Qxh8
 kdzTBJCX1khHs2mcgwt3FYWgG6KUygBUYuw93odSEW4ixh/HvALG4Uui4K470Z5Q/WxI
 K+H6TpzZZwbyvw0qayO6H3X5inwC8H9X8dkbpnWjHtnGmejiOgrU280lyklJ0/ivGpUi
 qomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768951471; x=1769556271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=vH6srjsILwF2Qkx30Lk1mJ4cPTOTq78YXv6Rff9lhOofCoGds32bvzAOS9Sn8KvUGo
 uXO2Z/7SYuyuIBi91TyVSQNoMIbErm4fD/f9XV93XibSURN1n1XkJijGQ4D5OErVVeco
 YyA06BmZBxIj59qYDKMG17RGHt8VWYX2fJolpoBfgGr5oSl+Q2rY9r8eig/CUp+3qXzY
 YQRy07FNlYadAL69jcjC8vhInSAst4KVNEWx3oOtQMMlvnJ6YBAijIyaF+Qveh+MEk9a
 0O6aYK6vrlobPIdxpZtK+oK9I77dniEiSkm39Z55FQ9ZhzyhNLa9ySEN+HaSCQ6Qzig/
 PGBw==
X-Gm-Message-State: AOJu0YyDV6cW0GP0XGZ92/n4xiDujm9VLrTisshNj/9CrtL/Wl+lVjWI
 nTciWP7nrQCSmB9hoMwthjmdJnt7Uz78YZgK2n4mdOS+oSZdZQ7PsBVyCwrO48Nq1k+lc21g2w+
 e/yBq
X-Gm-Gg: AY/fxX4JG3uqL+x1EkSfW93uyF08KEegOqBl46kzeAjhWcNLXTqFEYkhPsZaTcG4AvJ
 dNIOD7dQUOHawiunI+yXqDYhhEC4C1m6ZT/lDC22HJR4/qp28McmljqWLkJgR383tNSKMdbyANj
 uKxvcfnG68+E80KYZmuEKkbwWEc3uWKhhqM6NWa5EJW4UKrXXCnHj/6RjvPVAqo9Ytrcb3AceK8
 nyfHtdV89ewenCIZEnzFNFjFmQARwNK8Hk8F3dhv3zGzoPNqBA24JIHp1u3N5MUaiTllN1xMX2n
 KWyHVJW24Omth5LwMDlW/yigMd2AtCK21q3uXXceCIVgGPbPLaFnfAUGjHTAqpE62/+BDADkZJP
 Ma/m/qw2H0/Y4AIHVtMwwp3zCUJRMOoZjMB3TlWByzjxqPyyFzXKMSdRh/irYnqkGq/TBs1NlsK
 Gy7S/4l1MOtWd9WzukymR8Xa7lx7S5C7BSXFrmKSzLlnH1Pagll2Vi5OAa
X-Received: by 2002:a05:600c:1991:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-4801e34b5a7mr183623645e9.37.1768951471237; 
 Tue, 20 Jan 2026 15:24:31 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804249c5e9sm5865505e9.1.2026.01.20.15.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 15:24:30 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v4 1/7] cmdline: include stddef.h for offsetof
Date: Wed, 21 Jan 2026 00:24:18 +0100
Message-ID: <20260120232424.195059-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260120232424.195059-1-sismis@dyna-nic.com>
References: <20260120232424.195059-1-sismis@dyna-nic.com>
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

Include <stddef.h> at the top of cmdline_parse.h before the
fallback offsetof macro definition. This prevents macro
redefinition warnings when building with MSVC which uses /WX
(warnings as errors).

The standard header provides offsetof on all platforms, and
including it first ensures the fallback is only used when truly
needed.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 lib/cmdline/cmdline_parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
index d9a7d86256..c4131e4af5 100644
--- a/lib/cmdline/cmdline_parse.h
+++ b/lib/cmdline/cmdline_parse.h
@@ -7,6 +7,8 @@
 #ifndef _CMDLINE_PARSE_H_
 #define _CMDLINE_PARSE_H_
 
+#include <stddef.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.43.7

