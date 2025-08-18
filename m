Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C71D240A72;
	Tue, 19 Aug 2025 01:33:23 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 53F59409FA
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:22 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so34272505e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560002;
 x=1756164802; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dqqwTQvGcXemJfEiMo2sKbIou1Fq1sWJqIyYOCJhwQ=;
 b=Yj+0VnYNPUrTO9N0fuwLRvrsBuCEfAXPcWNc6kV94EsjhUds2dHUpwl1Wy+nkQj6N1
 PXm6Eol2TEP1CDiQUBtuTvSniOn8b7qu01S1YiqN+zPsxce3ofqdPM9+M6G9bLNqUMyI
 gnvM9WFYyEqbDVDo6YkNTdy49h2jV/03VEYPqOdZnsLdvGfETQAgeBbVuwqejWC3SMie
 gf1VaQwvH2o/BbXeNEe3V/RH2SmXXap0LmoueTz/GFfY9+SWpdWANoOyuWvX1dYFrZAE
 r3DnYb9TiaVeJb32KcfdmYbJY39+mPsdYXd+h0Z+hP6l6LCJ528QfV/01IP9swRLQH6C
 twoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560002; x=1756164802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dqqwTQvGcXemJfEiMo2sKbIou1Fq1sWJqIyYOCJhwQ=;
 b=rNqnev0f+tmnm8de/OxwqMk+SwbTU0LuAKzNldbnRn6I0TcVJWl0uni6TDcVSPYJAl
 XgkiRScvMFIeP54ANEPkRIrNzEQoVESbsFdjdaLY26bdplC52LTnRu48YPzMt42Mr0nt
 8A40tR8d95Jl+f4Vk48QOyKLACE2NDRJVHxh5I30Fs6jKKjh7CqeLSTSBA5RYmyM2rig
 irdOJ3AsqA037a1X5W24DCL8DDI7rA7aobihyTPlvkGHHZzwuM1iD5gthGhggAtkwLdD
 v6ocdkY9GcJXEaFrw15ElA5zZhei32GK8GSTrDsVRUmizcjcVEacSYBGN95uylhVFbDR
 I0Ag==
X-Gm-Message-State: AOJu0YytI78pTicyVtBicooIaVAJ3ifQOYQm4e92YWL7pl4aLV5O90R/
 LwxrR9ueu9nZg8Xxb+QW1i0AenWodPEfy7PKXTQzeiqCyRhqHma2/IhY0/3wxig/d4SNHVyXu48
 MOhcw
X-Gm-Gg: ASbGncsKBc1RPVE335zc534ZkI9uafiqY/36lplIS6fW3UvKNPKMqz+jIlnQDgwpQhO
 fxVFygdFGUJyhpg+EwYxUYSZYDt+gv4BRqBQ1EPhefpe6wERKlKYDf3SS+zoFjqQWFtKVvKCIBv
 qFRA/ws9Pgxlv5sT+rICaNMnnXmXAMXcHHn0merryKTisDK4FLOk8K+99dvegwYC3dp89a8xa05
 Yz3wC/66E8r5U5cs3I0tA9SfGxD/tj0XRLVcnKLOsz54VLG91pHIMJZdvsVn7rgs6qTLWrJxzXm
 V0vg2sCVoVqiP9TrZwr90qFlb7rV0F7Ebb0kr5G0Pd9+FgYfFbtCZSsr1A5w/cEf3p+LabYY3IS
 iTGd7c9xNAZuYSHq9Jh7c+RoZ79/38oi+tDiiJ4lu76UWgB7zEA09qbVYoGxbCxOQDo6UbMXi
X-Google-Smtp-Source: AGHT+IFmEb9II9ZBnDcapAo0HmqfwkpiTVTCNE3/UEFnXmwNDACQOQJqlfw+QTS6YqQUaoRIWHi8yg==
X-Received: by 2002:a05:600c:1f83:b0:455:fc16:9eb3 with SMTP id
 5b1f17b1804b1-45b43e10c10mr2082805e9.33.1755560001993; 
 Mon, 18 Aug 2025 16:33:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC 18/47] mempool: do not need sys/queue.h
Date: Mon, 18 Aug 2025 16:27:29 -0700
Message-ID: <20250818233102.180207-19-stephen@networkplumber.org>
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

The necessary tailq macros are in rte_tailq.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mempool/rte_mempool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..bf8e870151 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
-- 
2.47.2

