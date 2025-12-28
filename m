Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F6E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:19:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0B3540678;
	Sun, 28 Dec 2025 21:19:44 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 8513B40666
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:40 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-477770019e4so72219285e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953180;
 x=1767557980; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=V2s57i0pOVqYdH10nBVIXq7wNCBpCthGrcfD/rThCTCIUwggfDTG1Rr3y4zbFl4/G3
 r/w7y0DG3OzwhWKl9Aq3VlEQwqnZEZowDdLvYQKZ1iuAuTtNp0sPP5mgAJmUr55eeErL
 q5+jc7q4PVt9NMbfAT9Uo9ot4hEEFIyoiSWLetHXhvCzvhvWaaXzV+kpu22MnKKh5zi8
 kFdytBAiMy5t5IodozAxog/Bo8OmR0VHwebzoHhhSErmSOQ10S/mAyBW4ewLpvSBGT6D
 e7u0gzQEOlS10xwTwlCtLqIEozoJRHbJ7i1qgdx12Yc4bPErxKNs8gnQEwNgINz7Pafq
 ATNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953180; x=1767557980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=T1/ZN8r46SRv0+dH+9dlG+cKHd99+dIB/nnPCq+fWdsWogmFjlF9Qce4IZbpdbb8v0
 GCQTQmRwKZT91a5+JW9jbTu7HGBZ4A5e/YDK6QDfzDBbt7830k9QEEjziLft7RV+DLyd
 BJZmwAQk2Mtb3pzsvD+dOkuvaNDQ9FpgGU49+XTaXAWYiUWd/Pw4BvehAguLsc1Lij9N
 U1N7wtuVyc/Q+s/K6sBDNuPamKZhk0JE2ZfjmscBd3n9tRKCriM3JgdBzY9CpfHLjqvA
 dwzunmTixmn7qHncRbPOxZJsHCcvF7L7PBVF3eQEANHsaduxs/7qEpZIJBvtPnAwabLU
 tAYg==
X-Gm-Message-State: AOJu0Yz5ryAtrbgIIUTAZlGe8/oPWwNSBVpbKia/clwEdTP8NLzpEeI5
 jtmBwpIFd9eCsHB0wb6FFPMaEDKiMABxHxmZvbMsBmPxeG6YR7+KAIQ2IpyGDsYz4qyg64k4At6
 NZhGB8Lw=
X-Gm-Gg: AY/fxX4ay22QmLHv3Kv27uQekf+dInXtMVjuIyGm0OAgzjFva+8R01qstRSBCSPxNQA
 SwgCpZ98EvQPmzXmqXRjOfrCwLNxipuK4n1EIzS9iGAuQmUdYYe+DBymcmvz5TcRRzqGcq1FOrZ
 JlOC7CnGiwotYce9lKNSTftGDssAviyiOxmhWxkNE1ia1PykHZXDz0X93Xa748Qd88QdqpceRuk
 1nUEAjbo5d4UiKXaAurngHx1M5BygxoxcfDw8bn2dFmlHAnM9E/o2KctQ7MkJOBTgR+kk6ad43Z
 Y2t56RnnzhWyQ+Ikhj0WeYvZZJm1qNK93nIwvAmUWMEKY0asDeKUaWQ4Ygkt9l89xFTvXd0FgB/
 lSY5zwUM46Q3/DqZRr2OeMh5s+DdvKCE/YdAqs9CCjnnD97gTHifvVxqapXpN1nS6HwZzZsw07m
 PtlBj0vpaLu9tOOMEOnK5rHmzL4yMsJpbUufRpEatHkiyC8QLNDfCct1oMgs7M
X-Google-Smtp-Source: AGHT+IHWwXm8j4JNZ3Gp4mJVnNJjaK/ejB9ws1qUINZqCANggnLYR1vRhgoDnLq1HeOC7kF0eGqoew==
X-Received: by 2002:a05:600c:1550:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47d1958b250mr327620015e9.25.1766953180132; 
 Sun, 28 Dec 2025 12:19:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 05/18] telemetry: check for path overflow
Date: Sun, 28 Dec 2025 10:56:08 -0800
Message-ID: <20251228201236.547268-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

