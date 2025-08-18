Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B4CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9A3040676;
	Tue, 19 Aug 2025 01:32:55 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 4D85B40395
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:54 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9edf0e4efso3290729f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559974;
 x=1756164774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAidEhzDFjhNI7Mw7ehm6RWhkknqhTpLbn3qmzEKRUE=;
 b=nyBHENa8BWsoci/KgI9PhwIbMF9Tas8TLnykwfjJnEOnk9XKcXNTnaJmVc9TMVw7n0
 549btXscN/fcePC+T3ypPJZZs5Siv58qXng4MOLtdh2rt6bfKgx3f3jN2YWc7HyoX8l4
 7ENL+t0ey8WoNkRGmmm30WLCvYzxz076DtKRvKmC7V7fMrj4qjZc7hShNla0wRRs+Ibg
 El56tGcgruyb27kohDMdfDZGRVipKdI+6fyG4JTmy39WSusojoqp29+JpRp33T5FwRok
 9NCbWQ6yMDN/+Y3CsgUAFNzFgGxvueH7pgCFTOpDw2Dp+uTOUdIENT/JQU6W+k0TL/0n
 xskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559974; x=1756164774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAidEhzDFjhNI7Mw7ehm6RWhkknqhTpLbn3qmzEKRUE=;
 b=Bst9rurFLR92ZP9ToftCRz2bPus8HF0w2IA16MoL4RDFOwZLr3vmjy2++Dm/N/1UIm
 xTjxWCrc1ymJ9BiD6DYODq1rCtqDnAgj0OmSJKLJQ4/WabXUfrlEKrUhpNLA+pF4a6Nt
 /h7pCXIKztd45D+BYRhgxPcqR63NT33wLgfOIlxRrVn35qiieuZNWgd5qu4+JDq6cDZQ
 mEd1UMsscztUcjIJGem1MC+datQ8U+C445wQAZ4jWP+X3vgDb/2WheYsYOFT9OOsDWo5
 vYt4WwBBLoPK94w32CoZBP5fniMM5WGsuf5bbbWRWIQTPxtOMzwFyjY09v138bbkCfK7
 uHmg==
X-Gm-Message-State: AOJu0Yx4SHeOXFOtydCVD3SyiRO6GphzGTwmc4hSe3lG3cP8A06C/nIF
 rXl37mxLyW/88kA+v/23ZKnhUKZYO/nYncWdi0hdqMV87RrhWbeS3/zRXMTv3z8jLn/YL4hdr1s
 HdsCT
X-Gm-Gg: ASbGncsicg0I7aYd37YRf6cc+wUkiF4BfAd07uFLFWCaBZH9lAZb7QUj6zfMxgU6L1n
 Pki3bL1Uot8E8vTUyBsleAnkY7duvQoGGyRSIgVi9L6y8xmaf07xQoo6oyn30i8YkOiyY2neJMW
 20giiRjPk1ymuoJyKE2GJaMiZgF87iZJGEIzb2g/m9WulLhcEMeJqalJP3uYQcJbXtetVXer7UJ
 toJ5mxp6f6dTXsJ+9U0Iob50yFLjRf3XE+/dNIz1PIM4aDqICPtj1eHckfWDBqI8BX9mQuqC5Yw
 7cs/ecp8VR6zhNOWi2gW5rgX5OGlp+2duV61ajcU5GkzW0XDbl+Zf1yDnyu7TWS4Okl/kfOwelE
 MvSD2QExhTw6AsUw/Uz+Bmorp69rLFA4QYTiiCKyz4y7ewSToHqwpGa4MXJVY3UAVsb/gs8vM
X-Google-Smtp-Source: AGHT+IH6iOqwOlQ1T//mwVgl1f69H/ZGMNkKGIhzi7BhjrHxJCAZKDPkBSvmd1tE/CGWVZ06My4sjw==
X-Received: by 2002:a5d:5d0d:0:b0:3b8:893f:a17d with SMTP id
 ffacd0b85a97d-3c0ed1f3496mr296051f8f.49.1755559973841; 
 Mon, 18 Aug 2025 16:32:53 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 08/47] doc: suggest bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:19 -0700
Message-ID: <20250818233102.180207-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Don't suggest use of sys/queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/coding_style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 243a3c2959..1f3d5d9acb 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -324,12 +324,12 @@ Structure Declarations
 Queues
 ~~~~~~
 
-Use queue(3) macros rather than rolling your own lists, whenever possible.
+Use queue(3) macros defined in <bsd_queue.h> rather than rolling your own lists.
 Thus, the previous example would be better written:
 
 .. code-block:: c
 
- #include <sys/queue.h>
+ #include <bsd_queue.h>
 
  struct foo {
          LIST_ENTRY(foo) link;      /* Use queue macros for foo lists. */
-- 
2.47.2

