Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61370FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF1BB4069D;
	Tue,  7 Apr 2026 05:52:35 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 2531540696
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:31 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12c19d23b19so27558c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533950;
 x=1776138750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGQurNypu0ewoYhEVJtowEC2NV6CjFTgJQwuKFLqOXU=;
 b=rYEsZRyrUT1iY9gXolgLZFE2MJDwsUz/V2QLfwCIaCm3u0KexVsFsBn4DQHXfsCkCf
 /MHzjs+sV4SfAVNrx/widZA2UI0yejhdsOlCijmfAStSehq+jnUfqYwnG5D3p7PBpKYo
 7CiVh5UU1szk0bKDCdL9MUAhb+LYsBTCdVJ4OXqFmJZcjUvjxdlI+ncdTNjJP23tANON
 o39PNo/QQkdJnXHEdCESp+HMrdAinF+1VD+eZyEdUBn6+k/gMTACQTm9FR2Q6KOgeHq5
 dAAJhPZJ3zPjvCPEIz3ax69nWW2JUB/rZbQha7NYIlMPUoChmVIG1LkUzqSPoQDzJXkP
 8s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533950; x=1776138750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SGQurNypu0ewoYhEVJtowEC2NV6CjFTgJQwuKFLqOXU=;
 b=ZAFX35/0mESzH7cCkarqJ1pWt5q1gaIQ/F1+OKP/N67wt1pcg0D1bsAHMjTx/pUsMf
 31mPuEuZG44TsP4dnSo3XqK3SQ+yjm7LBLZDQPCwp5bpo1sELOO1uS5aR2TLZ1Hm+BDn
 v5XaJbGOSF/FL24N9SyeEEthW459xLu0gSd2TLoXpPlCFXxKmzsiXl8As3jBI7ZnNmD9
 qz2hm51dRcS9eimS6nJ+g0pDU7Z4DNBFZVAKNrGevJs2+1tbGlnc+VQbUGxyvUmT/eej
 PxZorMqG11fIR8kv0xg4aZyXqAg+RNjW189CiUYNywoJRd0BJsuPkKmxHmKIKfxBgUMm
 DX3Q==
X-Gm-Message-State: AOJu0Yyq4hjdkqzbJh1itnSYv49RxHx4QXRqGH2TxGuWGv45ONZP4A9H
 svd7qU79UC8eADI+rNXGb1ZByRBEeFwAuYDXgSJa2vfFnh7A3gI1wZuQphwV/rJEmgYCfLOu95q
 /qLgE
X-Gm-Gg: AeBDies3aDjfjU8/tvnoXUr4hyQl9A41jORan/DQYS9ALcTPBpJfxmgcQkmcqcw7Xey
 VeXzzt0lEg4MCYwtbcIr7etO47tA6Bi4kHnnlc5MNUeO/CCHpZzyM77jljy2YpO4BFEpd0WeeQt
 6CYslkxqQjRwJfMVEfmJoinVq1Z7coQ6vUT0Vp89Zj0VoVZwgqPY1sE5DvqbqUsmMcP8q2WnhbC
 ZOdlnAmaSUUAf3NomCRpjBDd/pxaWFCbqpoad1EkNmGE0G/UhaaZH835Fjpo6Dytsh0Yd7DqDoR
 bR/xp/tkxpbx32ULmc1nGX36ZQp7Jwo1lXIEstpWtox8p9mybIebU8+jpgwUlhJdU8J523rHuUJ
 00HjqQW+4hPjrtlJ8vqKaKiDSfDxhjAlR/IS32FMxxfyvNbFRCIeulGsbCm4mYM29Oc9UAZViCy
 PLqzSGQ0ci0vSdZQwRMN4daQNgREjmjsrmFaKrdujZ/OM=
X-Received: by 2002:a05:7022:ea2f:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-12bfb6ee08dmr8250327c88.1.1775533950103; 
 Mon, 06 Apr 2026 20:52:30 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 19/23] examples/l2fwd-event: remove no shadow flag
Date: Mon,  6 Apr 2026 20:49:45 -0700
Message-ID: <20260407035209.650419-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

There are no shadow variable warnings in this example.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-event/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/l2fwd-event/meson.build b/examples/l2fwd-event/meson.build
index ff171189ba..5bc8188086 100644
--- a/examples/l2fwd-event/meson.build
+++ b/examples/l2fwd-event/meson.build
@@ -17,4 +17,3 @@ sources = files(
         'l2fwd_event_internal_port.c',
         'l2fwd_poll.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

