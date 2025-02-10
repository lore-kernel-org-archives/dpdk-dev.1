Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7499C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AC1427C5;
	Mon, 10 Feb 2025 18:21:03 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id DF3E6427C4
 for <dev@dpdk.org>; Mon, 10 Feb 2025 18:21:01 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso113918945ad.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 09:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739208061;
 x=1739812861; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNe+nXDcRCkNSOIlqr/voh/oXWoMHGmJCu4QrYgj5+M=;
 b=Zo7iqQiinmBKpM9agVYQZV7sufQrxEFFOaRgXWkDpQpwJcMq2cLHIKXmng9q9WxQ/c
 ApZeFjClfVsx0yfSWQpOEfmFe5GOh6J6NGsqUohRCsnqdYL4hn135dQ9ZsmYAZirioTO
 2MsDMoyFZGcbFGox6xoC298kCmt9TYQDH7ISYM8tKFSpVVHDAnnLBNcb/15r+WrVFTz7
 YIxp6JPV6cCqhPWtn8ZwQ3VzGtTXgy3eGUiuJoUGXbkXk6NVlCiRdEe7ORnJV1hYfxXd
 UwhDd2DAJ1HSDWyf5lIinStXUZlZcJLyJOZxZFcaXtRTAc/JvkYiTzhdIu63qB2yBA2r
 GJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739208061; x=1739812861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TNe+nXDcRCkNSOIlqr/voh/oXWoMHGmJCu4QrYgj5+M=;
 b=Py6HglapsXutd7G+RBpzcksZ6aOalOYQY6t+Baw2I3SY5FCTYj6k0u8d6Atwq3Hr6e
 Ui+WpBiqHcMFEXRFQZTX/g1DBaQXt6xXWTRSQR1SnyYHfrjYCrWXCQ+4+xS8x0myt1Zi
 RI4rEYnSL9oh3B2I/nlX/uwwGH/PLlarY60IpO3oGDsP+uQKc8lNXwEgCon/hwFju7KC
 0Rd6H7E3CLOppdsbsyo2oQna4v7gA2pV89jEQ63zR7ltaLn7aGCVuMyo9A9YCf3RGkcq
 6IkXm1bocHGraniL+HZiVg58R/0xIsjzJy+mFB+PzyGN3yqmNHo3WXuyJwoJsBpTHWDi
 hLrA==
X-Gm-Message-State: AOJu0Yzdz02fC12UGXoHh1fjRlacXzncwt6NSNw3Q+g/1FcydYJ8Ixfs
 pk6sXfKZGZi3PN5zbMhzSXHcjoDqw8VHBhP4b+zfIT0hDOY1R4zNnozavgoE9UpuGbEWlv5ns9K
 s
X-Gm-Gg: ASbGncvDA9y4szef+lXZX21/TSWXtdxAeiUBxlyxJxcAvoxJPwcBM7fxzQUfyN8u50+
 u8i1pKdJBnm02OXf088M70s8P0dmnkHgFM+ld03+rh05X7oqgjhlsKsbpK2350rqldFqA3sXoad
 +cBuvJ84lLbUigjL9J0an2/3LizuGCXALfE4AHaWzeESkt17rUP2Oi7VowOq6II0GX3+yLTTpAd
 odwfjfhrXWIRhy34CMy754+488+gt2QmTpJ3BY4hluHcZQBKeIqFDZzlpHGMuIEqH3HFon3LMXE
 FznrF0UicHHLiuEbDRDV5iOFkT6W+yRdQLniFacyTxWLHgH47emneUBLWhveV/iTIz07
X-Google-Smtp-Source: AGHT+IG0MoZWYS+ITRis03k8sbLwzq/07B30BYYrCfLiSnB6iuJgVFifJ0k48+a7FPrv/9zq//umPw==
X-Received: by 2002:a17:903:240f:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-21f4e6ce1a4mr229953025ad.8.1739208061096; 
 Mon, 10 Feb 2025 09:21:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f365110f7sm81330985ad.42.2025.02.10.09.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 09:21:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [RFC] git: consolidate .gitignore files
Date: Mon, 10 Feb 2025 09:20:49 -0800
Message-ID: <20250210172050.8884-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207182634.168820-1-stephen@networkplumber.org>
References: <20250207182634.168820-1-stephen@networkplumber.org>
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

Lets have only one .gitignore at top level.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .gitignore                   | 6 ++++++
 dts/.gitignore               | 4 ----
 kernel/linux/uapi/.gitignore | 4 ----
 3 files changed, 6 insertions(+), 8 deletions(-)
 delete mode 100644 dts/.gitignore
 delete mode 100644 kernel/linux/uapi/.gitignore

diff --git a/.gitignore b/.gitignore
index 903fe9bc64..a1a6843494 100644
--- a/.gitignore
+++ b/.gitignore
@@ -43,6 +43,8 @@ TAGS
 
 # DTS results
 dts/output
+dts/nodes.yaml
+dts/test_rund.yaml
 
 # ignore default build directory, and directories from test-meson-builds.sh
 build
@@ -50,3 +52,7 @@ build-*
 # ignore other build directory patterns
 *-gcc*
 *-clang*
+
+# ignore Linux UAPI kernel headers
+kernel/linux/uapi/version
+kernel/linux/uapi/**/*.h
diff --git a/dts/.gitignore b/dts/.gitignore
deleted file mode 100644
index d53a2f3b7e..0000000000
--- a/dts/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-# default configuration files for DTS
-nodes.yaml
-test_runs.yaml
-
diff --git a/kernel/linux/uapi/.gitignore b/kernel/linux/uapi/.gitignore
deleted file mode 100644
index 558ba597d6..0000000000
--- a/kernel/linux/uapi/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-**
-!**/
-!**/*.h
-!version
-- 
2.47.2

