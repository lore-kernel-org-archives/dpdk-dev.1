Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8CFE63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A95EA402AC;
	Sun, 25 Jan 2026 20:23:19 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 9F1BF4026F
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:14 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43591b55727so3709412f8f.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769368994;
 x=1769973794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=APdy1X9OVlw8EHWJIEM5khnpM8tOm2tJwnWZ4jOOjG59U9iVDvzeoKskN5EXEgKBtA
 /olKYXKFlnigtG0nMdQlODlOvIZe8FP39eN9e34arkoAhT19TV8qQSIY729OiN9zhsSw
 442KsMLUTEYN0LIOwIO61gCotcvEC+mUMK4IQwVSRoZVc9uSDVVoWSznka0x4/uPGQR2
 IN3KpV8SlEdqLKcQVVzcwltCAKZJGU6baL1X2J5mP1IGfs9rAHezn4dROE1rTnf0KP4V
 19PhUOZxruzK/H1phQTMA3YvHfOQxGzYPnJkphbrhlqLWG33LobItqoaC3nTem2AjJS1
 6unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368994; x=1769973794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=SnFPADq/XaVjsduXttbpWCsIsnQaI5DLQJXBH69J4BRWAbu6h/vcuSJk8WdWBds7IX
 8NyEfrg4dUQIAGAaLjAQKk0+r79Cwo0mx08tJ5SsEvIV859R1VfeQ5iTHHrFbvMp9fXG
 WZk8hHKqh6zEgVuFEJTN4/rpW0zAfznwP85Jh7HYiWyONE1PrM7/2cV2cYKe2ckouIOM
 8jhl5McwCqUpDu7v0RF8QbuW20Wgi0Kd4Vz6ohrMnAQ9VJAIIpGbactQWe3Ngnmessdr
 UiBMKPlxeAYLLGSLaCJINPibJisxzXAZGzoiXYtp2p8X2lsNce9fqhKsl06/lHJdeV6H
 x9qg==
X-Gm-Message-State: AOJu0YzjjD34rRH5jMGRhN1OPbotUC8H1lfSBVrj/SUsixfTTiA3R0d+
 mFqK9DaLfccmQSg2C9u0tHzOTSYCIjE7Rpe8jHFFJPoQul+sqhJFdl3+RDEea/Ru3wYhoM72qOJ
 2s8w8
X-Gm-Gg: AZuq6aJeo/cgQcxd6i0isj1QfIWJIE8goRSiEOt9jlFa1YhbO1MyiavnhXd3Pg6yx7s
 t1xfFluL4WLizRvaPp2cq8G7zZ9yG4AufBm1iBsgJ461dgSdjr38kYsIr4jjkY2C3PjVY3qz7Vp
 gLB3+YArueFRTVMjfuwoyIMCOsnIJqCAILuaWNPF+VmFJnJzORgpJ+RQJhKnwkHzgzld81OLPY9
 uymoX2DX5NdzfKY74FSsLSecism2vpcDDqj+bgE5ifSSs5fLzdWCb1bqhbjbktWv0eVjEL2QBXx
 MZ0AtkwvMqKSXpLeJetp45BBm83ne+WJE7F4yVY1XFpcZ56A4lFzu7vO2IQ5Ilepoh1uy5d/3n6
 rjBox5s58alAj7W0qjAyEBC0l7C5rySRnJzyXkiWErWZDZj7At15a0ausoRwalsRNu4qGpdxTCr
 OKCQnyKVA3CGAUcO1EXHzIHumjxvCmh9XdwDguZMLmLm4E0k69vVvevebdeAEQ
X-Received: by 2002:a05:6000:2312:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-435ca39ad53mr3899965f8f.45.1769368993643; 
 Sun, 25 Jan 2026 11:23:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 01/13] maintainers: update for pcap driver
Date: Sun, 25 Jan 2026 11:19:59 -0800
Message-ID: <20260125192248.497563-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e90cb8c28..62da2be759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap_ring.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

