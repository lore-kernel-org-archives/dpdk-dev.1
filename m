Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BCCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971D74068A;
	Thu, 28 Aug 2025 01:15:53 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 7D7124067A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:52 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1b065d59so1975175e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336552;
 x=1756941352; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DC4efpDSXuwFPeqZNNjFC6rUkG9JTSDopXpKu3QXi8=;
 b=yAcRZjm9LcLJYOj6Azr+zTO2cEz6NVcM/HalArIc26W+w1X3lTl8TJ7ko2hV5Rrgli
 YF7KRtnDREFtzUiWpgHxvAAdWQfn5z67Wwl7sq8bghqNXqWn53xbZWYxyILWqiJXaE/p
 WHXvV8sFRcsWei4IohEMw4AZv8vzOf9JjkNciD89e0twjvVweeEH0tD7AibzipnZbqQu
 lqhcpKeGyH1C7EZN9T6IUQh0/Kb1lCVCyJru75a7MKUuJHm0FFD60Q2/01F9Sbxwru0j
 r6omkPvmZJJ6Ur402pIXeyQjvN0iZyPO2lVlIv2fdLiAXHd/fXHS4851wyVIpJFw70LF
 3FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336552; x=1756941352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DC4efpDSXuwFPeqZNNjFC6rUkG9JTSDopXpKu3QXi8=;
 b=FdzGYgP2Z7o2EDm/ZL2ojwDIypGNEW5d1NnL1PTylUnxY8nmp7aFnIP4d4mQcrJjtd
 oniLPpQEZTlCrUVMntpZJPwQSw2lioaOJ5yV5L6tbI+29ia5Q/55UaBBM9nTfLglww5d
 6cc1yCThpUWYe8Y/P5ISYOmhW8YKRwPbdZAMaHPr4gse4r5QetR6ePvvaut/DTYnl9C5
 PQjbHu0HvSEeb97AIJ7OV422GRa65Nh5AKrfRKSXpvo5ydoy0LkdPuJGjSKcHuMtlRrW
 Q0eFGg9Z0TQQoTzah4L67/39Ixe5D/XM2nt6ejwvfdk8jWZxIlEup7wSGMZPvVzGd0bz
 l6VQ==
X-Gm-Message-State: AOJu0YwndA642thgNOvW9q+wgJi6HsXKTs/+tjM5fq/ykvnzF3N0oyFC
 aEPxauygKYsJ7oophNzAjV47rjA7ikxi6X9oFmPPH297sFBMgIrGtleli4U5l3gCenYuWkUrDJF
 YILdI
X-Gm-Gg: ASbGncuZM+BIJbYRwEyMHTDXvALsVg6zfUkxx0tZfd0fmozBd84saBGlvSMMJMD93JE
 5EDkZOOkGetegQBzcCRjf9dPTJxzkEy30k/kzy6q2DZDSCUeH1f8V5rPwrG2Ec9Bd13HvRbRa6M
 i23BVkIXCGXVUzor4q2mkhGIiOKe/ceptPFVEoAsFTTbJUj2dEVwPMTegRnz7y1Tqox1pa9vJqA
 YqsUvZP1rWQMbcM29zZ0uhWUnAzhhYkD8ovVcpfQkaqbW97CAE1xdyguS+rKPNth9ekixSULjqu
 YoGbQnTfDFols+HdWUf1fZgsTQJVGTBEEl1qoNjkRim31XPN2b702Q7jRLjQ3gl8GR2y2gFNA/z
 MatN+4CeJRGk0QgoEp/EFPnUIe7MQ8o3lQYcDyfr6KhQpGKiaNZBWQiGA9HgDPveQc5py+7/sVA
 fDjPJjUM8=
X-Google-Smtp-Source: AGHT+IGvhY0OMu9a0ctY6Iyi5QOHs/fqC1xTO9VlD5/xbY4/TYsGyVdYw02zhT/8t+2oFbQFBqhb7g==
X-Received: by 2002:a05:600c:3ba3:b0:456:24aa:958e with SMTP id
 5b1f17b1804b1-45b5755a6famr136261915e9.0.1756336552024; 
 Wed, 27 Aug 2025 16:15:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 7/8] telemetry: avoid potential name conflict for handler
Date: Wed, 27 Aug 2025 16:14:10 -0700
Message-ID: <20250827231528.236172-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

The typedef for handler creates shadow declaration warnings
in other drivers with variables of that name. Add telemetry_
prefix like other variables in the library.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/rte_telemetry.h | 2 +-
 lib/telemetry/telemetry.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
index c4554e4028..4202847cd7 100644
--- a/lib/telemetry/rte_telemetry.h
+++ b/lib/telemetry/rte_telemetry.h
@@ -369,7 +369,7 @@ typedef int (*telemetry_arg_cb)(const char *cmd, const char *params, void *arg,
  * @return
  * Void.
  */
-typedef void * (*handler)(void *sock_id);
+typedef void * (*telemetry_handler)(void *sock_id);
 
 /**
  * Used when registering a command and callback function with telemetry.
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index 1cbbffbf3f..7b8fee0e0e 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -47,7 +47,7 @@ struct cmd_callback {
 struct socket {
 	int sock;
 	char path[sizeof(((struct sockaddr_un *)0)->sun_path)];
-	handler fn;
+	telemetry_handler fn;
 	RTE_ATOMIC(uint16_t) *num_clients;
 };
 static struct socket v2_socket; /* socket for v2 telemetry */
-- 
2.47.2

