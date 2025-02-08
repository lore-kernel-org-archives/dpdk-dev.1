Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C74C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75FDF402D9;
	Sat,  8 Feb 2025 21:31:56 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 27D69402A0
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:31:55 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21f5268cf50so24983535ad.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046714;
 x=1739651514; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9BTfoLjWfuzS1DoP0FGgfd61sEkhLecVg9ytCmHtKY=;
 b=g5RVNAIAJKmZIZ6Rfgu1pu3BXYcAN7VHGeZncAaFe5raWyB1xCoxrLV5EVMqCZxSD0
 25uy3DoQJ21AIGjMQgq5yMs7uzqyv9Twb/cz/xLpVnXrwQ+hpSC9roJXly0aDC9MCqq2
 SSizdBKfUyrYmVQUC6tJV7ks2iZtkWjzCpKUdcCGhFButdB92gJCoTXN+LjoOawoxy/d
 N+lXNt64VYVAm4p3JE75JRMKwfD0WjciJspGq/RUEEVEmkeFkdw7M+zivB/mz2gE6yBV
 1OgCFJ6jYUyQ3rl8vRONOqyLEyFGOkz0qxDRv52Ye77DzlP9mrXuWLfom04f1ABK8bYn
 N84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046714; x=1739651514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9BTfoLjWfuzS1DoP0FGgfd61sEkhLecVg9ytCmHtKY=;
 b=vGeoJmhz92kzEJM8eQKs8iFhXw51vM71MzwqXSQSXWwoztCUQ7svwZWICoyRQN9Mcl
 Sq2vu+fvponMdaX44KY/gqkIkfq7WuVIJCGQB1KFQMa8cOFhs4exl9CG/oeoRIO7wV/D
 miVL8Kb8bCawxJSQPghEH1ff8rKcV+SL036Q1fGz76GmZZbncrAfHPxjMyebRKc6KCju
 +abzibyMVFsJxLCrWR9BFAphgN84xaxps/EXWGA+zn+zauluuZJhrGLJrkbQY42XMPQY
 WvRrMX+eG802j2jAzvCSURBbbZOuhJChejtWKLf65jUmvWnZbw49qnHSwyTR7+2H+25n
 opJQ==
X-Gm-Message-State: AOJu0YybwOYyWeWFLwBwzZMDk9MpWHeEbDtBMDX4zSb5BNzw5H/4gqap
 x5hmRlBd0/ycw1vVvb2MDFKCtfGFXzyxh4zLT0VL+/6RYpui7hVEDD4IBUuZ0JrO5ck74gWZ9ot
 3OFQ=
X-Gm-Gg: ASbGncsozH+xZWN5FByp690cC4Nauw9P5ZPaMySPo0qjJ5E26fPHTH/5R0WNEs8NF47
 Z1j5fIHqd5DlPQ36Sb9zwr/4MAr+ZeAWRA5F+4lOkoD3pdFwjYrF/g7eNuQtKxQvUr4VLs+WHU2
 6mR0e7caY+BP1xDXvuOCSP2ijrrtHXnN1fdpOA/oh6HUtXMIsu9CEPj4Zb8ybEFJpTt1yRlX7Rm
 /p5xdFoWhL2/I8+E+ok4yy9UORU4qSKR/ojEjSG0UtT9tbPUr3EpZv7qbR/9NB4rnJLLoIXr9oH
 Y4axNdgMXWdZS4dTtw0fdhZY4xkYfhUcurNzTJWhyro/Z+CmdHP3HGGAfC3TCy/eTALJ
X-Google-Smtp-Source: AGHT+IEPIMFyesVf861cRnbWJvMdklAurI9r+F7eZMqdmHekAE/wtJR+OkPNKu9IMhz48X4qAAH8Kg==
X-Received: by 2002:a05:6a00:189f:b0:729:cc5:fa42 with SMTP id
 d2e1a72fcca58-7305d516f36mr14805565b3a.20.1739046714247; 
 Sat, 08 Feb 2025 12:31:54 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/32] devtools/cocci: prefer structure assignment over memcpy
Date: Sat,  8 Feb 2025 12:21:53 -0800
Message-ID: <20250208203142.242284-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer using simple structure assignment instead of memcpy.
Using a structure assignment preserves type information and
compiler checks types already.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/struct-assign.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 devtools/cocci/struct-assign.cocci

diff --git a/devtools/cocci/struct-assign.cocci b/devtools/cocci/struct-assign.cocci
new file mode 100644
index 0000000000..052ebf3340
--- /dev/null
+++ b/devtools/cocci/struct-assign.cocci
@@ -0,0 +1,15 @@
+//
+// prefer structure assignment over memcpy
+//
+@@
+type T;
+T *SRCP;
+T *DSTP;
+@@
+(
+- rte_memcpy(DSTP, SRCP, sizeof(T))
++ *DSTP = *SRCP
+|
+- memcpy(DSTP, SRCP, sizeof(T))
++ *DSTP = *SRCP
+)
-- 
2.47.2

