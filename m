Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEACA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DECAC40670;
	Tue, 19 Aug 2025 01:34:01 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 5271B40DD8
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:58 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b9a342e8ffso3313791f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560038;
 x=1756164838; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eERboQcbxfstTPm1iaAKJhdA3K1gWVbSCwGA4iu2/Dw=;
 b=hWQobneAJ72LsT1pt8NW0p07A0bE8qFXH/kRC3F3exvnpvCXvu471SHVwl4cLxI/1O
 Ti1bHudQqGCtxcfXBU+hID26yLNghNCS/0A0IIThex08M0sptnfkrOASDojleA7S+k2x
 fwHGw0PUtL9CEBEXUjZj+tAbsoJ8J8vBAazviXxNhg5J8a15qNAAzooVkrEdXgQ32Mnm
 iu7ihHw6Itg8sUNAzf3pzvi1Gf0F2RCNouGeT0M3ru8oRnIWAGccMKY6a3WQgs2MilpS
 Ykdb4x5DfHKv1k8BIRjdddwRMH4gO2uI+k8JL8VmNpX/YgwI3jZny7kumMvcPfLXnUMh
 9OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560038; x=1756164838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eERboQcbxfstTPm1iaAKJhdA3K1gWVbSCwGA4iu2/Dw=;
 b=ErDW9X/zcQDzYG3mGkHveZoAIKi3uaRo3870so9ugW7TZdXNSGk2TpQs7dN3iR24HW
 oDr+492C3kwmpGh30XZL2FzbhoITIrfpOlWyxpZOr8mxwYJSbCM8bDzENKtdvUmePGbX
 hGIf+B07PPtijusT4ZbEcluHf1d8ok4CBnuxfctMMMnaJacd18OTOMDHMdd5mwOXxqop
 gUwpKNg5+mKchenJGfntnUztZ0kuxebgCqAkV2E2Y8aIw3QCDpkKbXvXCuzREDqSS/mC
 RCetMBv09H6rVT7sZmlWWCuDUWIoNF/x3fwoWyJ6TVNjf7ZklB+0TrFa0+QhoNkvFJuL
 51qQ==
X-Gm-Message-State: AOJu0YwCI7uXmFEkx7U76IjYl/4m/xJByCMS8zRPjyJZKnvrjqTUyigY
 6Hp8OPc6AVxJERLq+QezCreP5sv3R7clUFLc/6Mn3RZxB/Fx5hJK45S/ZqUFmfgPEj+Zfh8MPTR
 pzXe4
X-Gm-Gg: ASbGncurBV44UK4/yeRSx63dFU++J6IU0pdqUrgtq2AukTEsCa3Xolp2P80S+30RyE0
 q4WlRUhgV1dg6Ml1LA5/5zEZltDWILPw6sK2n6ujlGjS2NGpAOvOvczkyQdckjic00MwS3/hlSP
 wvbSwQ7DfUor5ZiiQLIqDk0fhuAFf7v0JinP4MNKj1IuV34xY1mvFtqDyIrpjnliJXxcBYpmB/q
 CmGp07z7kPda53HKXwDn6UFzlzFvebJchl0eK31wuFBj6zJAAnE/M60ZHZ8K1iDiU0kCXKWEPrf
 bAewAsCDhfYsvvby37uMLvjZPsxNpzzwd6rcxUX3xw8MbzoFZHeT30+rNlypJJnMOdiLCQTXhs5
 XZd05TI4FCFedZ86PW4HNkKNGnmLlJ3l4NGc8O0g24r7AVYf7oeoCXx8Eqa6CqyES+lUU6l8g
X-Google-Smtp-Source: AGHT+IFBe/m7x8HncLxMn/+Iz+10QlBraBW1DYaRpPI2X6z1gC1+kVj+EhFPf5Lzze/QPCoQuL4/jA==
X-Received: by 2002:a05:6000:2485:b0:3b9:717:4bc2 with SMTP id
 ffacd0b85a97d-3c12a804044mr177136f8f.6.1755560037897; 
 Mon, 18 Aug 2025 16:33:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [RFC 32/47] net/failsafe: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:43 -0700
Message-ID: <20250818233102.180207-33-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_flow.c    | 1 -
 drivers/net/failsafe/failsafe_private.h | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_flow.c b/drivers/net/failsafe/failsafe_flow.c
index 707e6c63b5..9f620443a4 100644
--- a/drivers/net/failsafe/failsafe_flow.c
+++ b/drivers/net/failsafe/failsafe_flow.c
@@ -5,7 +5,6 @@
 
 #include <stddef.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index babea6016e..1702d5fb3b 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -7,7 +7,7 @@
 #define _ETH_FAILSAFE_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 #include <pthread.h>
 
 #include <rte_atomic.h>
-- 
2.47.2

