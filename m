Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F92CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0755A40B98;
	Mon, 25 Aug 2025 05:42:51 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id AB8A7406A2
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:40 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3c7aa4ce85dso643578f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093360;
 x=1756698160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9Bfl/nR+3g3V5zNi1mRS29nt+CTLwIXJ00tHOmOcwQ=;
 b=RqYbvxNdWIdlYMZQ5tPFRc8WGYQwZHOYRw9aBWe8Bzjj1NviwqE6pXhOK82i2ecY+m
 Vx5HyrTW6PhLYIMi8y96kd51F5LtvZNAVJHlZVCGdrnK7wqz0t63hY7+qcUxr+2ufDmd
 YEnZGJYVb0aoJAv+74HBW8DExVgrk4Bt1f/dfFN0JqNDb2cYltxPzQxs+H0K6ggVowRG
 nV/46Es8EPeoPpV8xjPj0blA3UpCZ/XyGomBatvQnepc1DvIf0+rHydarQfRj/S6fTX9
 VcJ1gvHnf57yjIBBwUmdVVhkOXt2+NO97cyGiMBXmH4XQeT5vzwfKyqZgUZGw+yuybgQ
 gzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093360; x=1756698160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9Bfl/nR+3g3V5zNi1mRS29nt+CTLwIXJ00tHOmOcwQ=;
 b=pXkUflyiVVeCFv6eveRIuG7FAZWes20scHyZ53bJ/3dzojhKflyVQRqhokUlmXH1CY
 adQz9vOfcsZRiq7RSzhiwq4/GWgsAiIh3HGrXCkNjE32vGd9W6bdAb7I9wdNj1e4/PH8
 0FjVUA2dtnN81JCu7iiKr1AOi5fTyn+WOq+LF6EHjZn7tsJKFSKrIyJN2ChtYTloRwjN
 FrcPzCE7OTZBGzeotyhSHc3P+phpJTk+nquJbUaeHmGZK3nHiPJUotDwoUudfRR/gngo
 LuXnrvYbEWA5WhfYWNQ8zh1j4QJXmz/I2VaXkLueL5ziP+asOyX4oEYtkTvDr1K2lpyS
 CUHw==
X-Gm-Message-State: AOJu0YwSZDXOMnnF6MAaVmumr0A2PRx01v7hYNq2DP6t+bcggiKlWLN9
 9rpmLY1aQufmmB6HsHa42hNDypwBVmO7zNs2uBtZ6dtz7xXzRg0LEvXxjNXT/wXVIwssLagLTDL
 OXZBI
X-Gm-Gg: ASbGncuMuCEXzhFf53QsTxYa1uh+nsCvIKr46/ROM2+I1+DfwD8eIuBPTg5YZ3587ih
 ghroJmcG3vJ4Ne0KW9HJ1xLu+FfRAY50mANzw9cP/yrjOgXQxr1sHbS+3cPf3aeQVR4lr/QHV9s
 OKSHlOkSImK/ZJJw3yk96mpY69ak9Zo+jO1rm5H71+Pjbz4zEHaphZHfAGrMsAxbof2totc/LjY
 XD8j6A+drmn+4QinaBp0SKYHhN9Kn2A15E8VBxhOebhgrBB2hDTkVdK63/6MQys5/QWDrRyZZt+
 XwtNHMIV1DXoYXaugzQUNdonHaBkHrZhOM3BnSZBDzNlDW4+3OZmgS6Qbkl9o/7Ool3pF5qsDVW
 NoytaCcuFjafZoHYuV7/wjiIolohsrPrH+38MmaeegoWLpJwD+wA7Wy3JxB4LLCzaeACTwM60
X-Google-Smtp-Source: AGHT+IEHst2cy2tglOpBI6Lci5JO3D6q6NrDLMpUYoOXZoh5DESEn+abszmO5rC20OV8EhQLxMPmbg==
X-Received: by 2002:a05:6000:2481:b0:3c9:b8b7:ea5a with SMTP id
 ffacd0b85a97d-3c9b8b7eba3mr595996f8f.45.1756093360284; 
 Sun, 24 Aug 2025 20:42:40 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v2 25/43] net/failsafe: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:38 -0700
Message-ID: <20250825034126.12046-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

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
index babea6016e..94533a9a81 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -7,7 +7,7 @@
 #define _ETH_FAILSAFE_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <pthread.h>
 
 #include <rte_atomic.h>
-- 
2.47.2

