Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA1C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3CB7410ED;
	Sun, 16 Feb 2025 18:01:44 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 929D940ED4
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:37 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2211acda7f6so11895185ad.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725297;
 x=1740330097; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=vjN59/LMg3FmIIf4f69xuJzqg44QeU8ePYBH2nZiMdK//KTVbiClF7IfAgO15f7xah
 XC5lUVxeqiFww3+RyquWJtimubvNT/Dz7LYxOHniYTY2dp79MfuHmH3dfGOklAVTNjHJ
 31qDepkXCE4gxwmcEtaFuC8AqEghIj5oLuJNBVdOWdOqjiKNS8hV8AZD1ORWekFPgK/p
 Cf2CTG0Lo0KbYcNFp9v0cFql+scARahdY+ri9FLQiv8r9HvowFjTrjbl/FBCjp4altQq
 CQng/e3NloktvCVTCR9Lu1OhU4gk3S+K5Z3SesnYHlCLLuFUMXTAJ0xsLHQhHWmp7QAj
 9VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725297; x=1740330097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=CkEjsg/UCVwHP5d+cU0q8a0NQDD+5yzcKVPwVwt7+tVa6JcLu4ICGL0B6HT6Hl6F8N
 yUHkVsJGVy5bCKfZAiYGZ+jPz+xmUNhslWDykwDQhXatlixZ6ikf8NemwE4M+xIp+Vlc
 nazBSS3V7+f1fH1f4RUDspLZnBOxEBwop3CKRUU/atmhrCm8O9AA0yHfLbdRELhqHeHt
 W4xBcViqw/zKv3gx6PSveZtk6O/M1YLOmn8588AQOVIHDau+b0C6b448SWxvvnFYwtDp
 f6NDPXSh/s1T7JdyyBiUUHsTPZfs5wfKJmkIgFd+jBuDg41L2kL5cDSQF3FgLSF8z6UU
 qPQQ==
X-Gm-Message-State: AOJu0YzRqRozy9V9EBo4fBkdApRma7mfZMeLv1smjOQ96TGgkzlbrQxS
 CYfOwraL1SIC9PU5itjTueGSgiwBIz4r2DSR/zTsMwZJiAe+TRVX8mOH3vMERM9Is57jHUI3e+3
 P
X-Gm-Gg: ASbGnct3x1Ft6TGY0p2gXT5IF/HuKs1OAF/ywY964U5I5fU64rhcDAP0i8W+v96eSsj
 alNVvOrLCmf6ZMBLV4sO/DBPTEKEbTZwnZG0cLmlfHZNXp1Bk19kKbFg+KbU+H9eSjJE4MH4AUE
 P7vODEy/hS5kp51KVqtLoBIxVcOeeKOsMj1qCBWCdi5r/XbjkXQNnP0TeFsJYasvt2L0uQSyeFN
 UW71qOM3m5A2mDkV0NxOI5+pG+64+2ZV/Awmc/STxzqX5Vcp0T9TF51UMMAjySzcQolI3T/OnFP
 v6ock+EX8Ftb3aZFizpZh3qTmdqm4Cc1KMXqWs+B/8i2hJm8gVYCfPhf+/17p6J1bkkJ
X-Google-Smtp-Source: AGHT+IHi/FOhm+bAoEH2HaytNHXrOoo6TevM3FODnQ/gliYf+tqlHnBuG7gXZTpGS6ZHnTjzNzCdzA==
X-Received: by 2002:a17:902:f547:b0:21f:53ce:b2e2 with SMTP id
 d9443c01a7336-2210409af9fmr89704245ad.45.1739725295221; 
 Sun, 16 Feb 2025 09:01:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 17/17] devtools/cocci: add script to find problematic memset
Date: Sun, 16 Feb 2025 08:53:16 -0800
Message-ID: <20250216170110.7230-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Script that converts memset before free into rte_memset_sensitive
and memset before rte_free into rte_free_sensitive

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/memset_free.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 devtools/cocci/memset_free.cocci

diff --git a/devtools/cocci/memset_free.cocci b/devtools/cocci/memset_free.cocci
new file mode 100644
index 0000000000..96334dc8c0
--- /dev/null
+++ b/devtools/cocci/memset_free.cocci
@@ -0,0 +1,9 @@
+// Replace calls to memset before free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- rte_free(E);
++ rte_free_sensitive(E);
+)
-- 
2.47.2

