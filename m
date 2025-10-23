Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C2CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1315640647;
	Thu, 23 Oct 2025 17:47:58 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 25013402C3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:54 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2897522a1dfso9890505ad.1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234473;
 x=1761839273; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMzcG/dx47rB7zMu6YKpMEyYpYdcwWlyM2vmgXpTbtM=;
 b=TgfA/XFgLggtrTpKP/W9BWg7XMT00FaNczEgRu3skMcnamX5FpFAMO9rY0b81uRXrl
 PRi8lBmu4yQkZTeCh3dwmvRbMDBnuWjGVYWYQhnGNujTtVB81ov/SIr8EcL0tXQRr8tz
 PhYBpoC90K+oKGX07b6N+olS9GOe2XFMFqjIGJSxYIHy+HXjnU+9xhljSRWEBpRfSpSk
 EVBp2rEEyIjm+ASnVRAo9OYk8en5k2irzNOd73ThAzQN2u7T8XBX0947U/NqyKM53Z+u
 uXwePJeWEvcqhYiw73ihA5B0ZqgeDQJljlbKHDjzb1Z2LYpwvc2fsUNHHQJkPvpAJlcq
 bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234473; x=1761839273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMzcG/dx47rB7zMu6YKpMEyYpYdcwWlyM2vmgXpTbtM=;
 b=pvzSR4eEJEEXLDvAeP1k8nlHnsytqNRGa9NueC+49uwqswIPizoj7TzrL6JDSwlAn+
 SbMJnbqTWxty1BZJ69JaYaR62FjX+naVsoLdqJ8d8TqdislQRrwTAvC5jUcpmBPR7nTK
 7X/ZACiGqWneESjx+H8XyVsqvhhKeiBhOHGLxmBWNW/DN1TaUBd0M1VoOaqGLAZVhCCG
 83Bfna2ErhSmsx1tcNjnv7zGJVcuyvPY1XntiJbaNgNgGTY4E1UUcIqlyu5DhViPlciO
 o8AN/bv1PT9W723aL1f9cH5o3Qt/1xfKHQ3sVonzxI8egGUy1N0BWIe7Md76406oGf3m
 UHdg==
X-Gm-Message-State: AOJu0YySkpzP98yJBLTcWlOjosHmlHz096c59KIK3F3hTToB2X0ba6v1
 B2awv9bT7T25ajX5Dcvz6T+313uLsnwRw9eXKPgUIRZypWmzyOaW6QwpPl0vIarv0EBjtU15otl
 hm6e/6VQ=
X-Gm-Gg: ASbGncuweY/0MOJuUJiIkkk+2+FxWAfUiA9pWZXHqxjVYcYG/q6k7jn4RdDzC9Os+Fn
 95uVQn706wuzCrUewX07ilPMoB/K56Ki12jD9TVoX43LJEeZfwz9SHsNWIRt084XKbqXs/UEveQ
 Ic1ZOHRA8aEw9DSUuVziIGaCozQz5ZDPVBgcQBYuW/qpfBvMWdQPW+6Zv0B+9HKuvvGQlzwWreX
 /UtSBCnxARwWb+bZURt1gwYNUyG+i6jN2J/5o++IIoN+r/wNaodgS5SlDgrHHyPJt+XuGDfB30z
 xE24LnhoHjjJehprVo6rs7cQ1SL9CA+eW3KIrkdxsQ0aYpqmztF0FGMEntyCCGPDUmobn8gA5dC
 dqxECW2CSAL14vgWbg7sBBJCFB2G7XNXd7hKRr2/B50FQrF5FzJuyxkkmjy1cBuHGRgR+3CkNoP
 zYtpPNHiqbqgO9pcy2zKa/+LtAtYZA0DJ5vwAnzIDCFRCGiec6
X-Google-Smtp-Source: AGHT+IF0IEAMSQbLis1aJykMsh7ZprTPgKPjAl6L0wzN2urwZNOGVlsdTsZYZze+ZtPlxN6OPNpkUg==
X-Received: by 2002:a17:902:f68b:b0:28e:a70f:e879 with SMTP id
 d9443c01a7336-2946de3ece8mr40470655ad.1.1761234473282; 
 Thu, 23 Oct 2025 08:47:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 4/8] dumpcap: handle pdump requests from primary
Date: Thu, 23 Oct 2025 08:46:25 -0700
Message-ID: <20251023154748.38535-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The dumpcap secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3621c0ebe3..46a6cb251e 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -528,6 +528,8 @@ cleanup_pdump_resources(void)
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
+
+	rte_pdump_uninit();
 }
 
 /* Alarm signal handler, used to check that primary process */
@@ -659,6 +661,14 @@ static void dpdk_init(void)
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
 		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
 
+	/*
+	 * Register pdump callback handler.
+	 * Primary will notify all secondary processes of change.
+	 * No impact for this application, but need to reply.
+	 */
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL pdump init failed\n");
+
 	/*
 	 * If no lcore argument was specified, then run this program as a normal process
 	 * which can be scheduled on any non-isolated CPU.
-- 
2.51.0

