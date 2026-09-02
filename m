Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3175C624D4
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 15:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5550440EE3;
	Wed,  2 Sep 2026 17:57:46 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 61D1B40EE3
 for <dev@dpdk.org>; Wed,  2 Sep 2026 17:57:45 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d5335cf904so12119125ad.2
 for <dev@dpdk.org>; Wed, 02 Sep 2026 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788364664;
 x=1788969464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+dTA+/XMPXwDuuT2Otsma9WNbuH9FXWcv0VXngBaGnA=;
 b=W109OJrijmXt432PBmTxwZCkBNXw2pJ7YwbMA5E4RT/lhHidM2lFyObIipDhaEAyqP
 W5WJKbYyQZkV+qHxZBnCzzfDZnVuUaaI7ZTEcVmDXLK4geveZIVd9FxqTs7tXOnYFeP5
 hNM0lIAVk3l/JZsEsWs41WwXn0epNJiMBPEm7OY603O5g4ajm0HfHqcsmh41e0DezXn/
 0AKjSF6x23QELiMYNXchb2PHKMJ1BYvpFuB86zbR276h9oWbKhDBFZF+dW40Lq6K1mft
 9NsMg0TMu4YKACA86MDWI/ySS+TZ56tRBjPwTZV/aCvMOj5ImIkE3Id0W0YYbBVXt747
 DefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364664; x=1788969464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+dTA+/XMPXwDuuT2Otsma9WNbuH9FXWcv0VXngBaGnA=;
 b=rDAjHwQpbeyOhzgm0UxSxxt5V9z+a5ZFqCRxog0LIFRRlnVJCEjPoPO9+a3sbS8xU/
 PSoYwelgijCdzOL6VXzeMzKVEsr9lZ2DkhY3FjnqhEFguhxRzVK47mn6QZV/7ykSR6Uw
 ZamZ2HTh5U5m8cjJitq/k/oAnUdaGAvJYzzyU8ybfUacJ7IUIs258BZfozRBRV8znRaK
 w2/BopICJ0gPYNL/H9kJvEf5v5CFqurpWtCcl0EwDuiUklTeRemf+G6aSH9TkHh6PpKf
 ydk2SwJms0u48sMiJamDBU9PhTubvOgUI7kquNux3o3mcRlfI2FmKfvlnd7G2+zut0+/
 OuGw==
X-Gm-Message-State: AFuF++l9RadiXf8G3Y4+hW/fsh3hpfs3FwFJXZMqYsXxYmq3o3wJMSeE
 fgnKxxh0lWk9XSTGAqfwe0nqoOoM0BZIHlW1FI28I4VaHGWthjMCGu5Hvg+gQyOFGjBVDa/7r7a
 FfQmh
X-Gm-Gg: AYBFou0jkAndxZ6U7DU3aEL1kIDdj3ClqYSMuvK79bXuyNUCg9oWGqaN45fwfx/4bp+
 Mcy7cDd1VlxDmrPxjU7qTt/XiazGp178cbUapF5PmC3g13dJaYJaMWrvzQA4XqzdSpFpjPnm9Cf
 0t/CucNIn8SokXk5lje8EO2weKtLCd6qRT5SbQSO2w3dzvdrggfLRYKHwIo3iFxeHmUoH80+dtN
 FgHx1pgXhgiQ3tYbeO8WuhBI5f8eDYwqABYPLS0iv1Q3RJ2IIwyzdYOZJb9ac1mWtrzsFgbH+xS
 TtnV5AdCwP/JcU9++x5to4dHIHg/pIbT2xIL3RC5JAXxpcXVvFnTZHFZ0WEpTrjggheuLxtdLwr
 CrfKEsmRXgswiN2eqYOtvVQXbvKEbFu28ZSMcHI1jugj5i8I+o2U6QWH8RJbh7IkITma2pOFU1Z
 Hu7f6724/aZK+6ncST7F/PwgGbWrANpK8BQi8YCvWUehhKq/AsY9aMOzfe6S5GlGI6pSFt29yfh
 wKM6sD8OSSr2KObXebS6An48Tc=
X-Received: by 2002:a17:903:22c6:b0:2d9:520c:38e7 with SMTP id
 d9443c01a7336-2daec5d336emr77851925ad.1.1788364664519; 
 Wed, 02 Sep 2026 08:57:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4bc2f2sm15778695ad.71.2026.09.02.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:57:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 4/6] eventdev/timer: promote remaining ticks get to stable
Date: Wed,  2 Sep 2026 08:53:57 -0700
Message-ID: <20260902155722.577747-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902155722.577747-1-stephen@networkplumber.org>
References: <20260902155722.577747-1-stephen@networkplumber.org>
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

The rte_event_timer_remaining_ticks_get() function was added in v23.03
and has not changed since.  With this rte_event_timer_adapter.c has no
experimental symbol left.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/eventdev/rte_event_timer_adapter.c | 2 +-
 lib/eventdev/rte_event_timer_adapter.h | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 18f0641ef2..01aef74d0a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -107,6 +107,7 @@ API Changes
   * crypto adapter: ``rte_event_crypto_adapter_runtime_params_init``,
     ``rte_event_crypto_adapter_runtime_params_set`` and
     ``rte_event_crypto_adapter_runtime_params_get``
+  * timer adapter: ``rte_event_timer_remaining_ticks_get``
 
 
 ABI Changes
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index e3640a3bf8..a76d10f505 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -490,7 +490,7 @@ rte_event_timer_adapter_stats_reset(struct rte_event_timer_adapter *adapter)
 	return adapter->ops->stats_reset(adapter);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_event_timer_remaining_ticks_get, 23.03)
+RTE_EXPORT_SYMBOL(rte_event_timer_remaining_ticks_get)
 int
 rte_event_timer_remaining_ticks_get(
 			const struct rte_event_timer_adapter *adapter,
diff --git a/lib/eventdev/rte_event_timer_adapter.h b/lib/eventdev/rte_event_timer_adapter.h
index 67e65ab849..215584b10b 100644
--- a/lib/eventdev/rte_event_timer_adapter.h
+++ b/lib/eventdev/rte_event_timer_adapter.h
@@ -705,7 +705,6 @@ rte_event_timer_cancel_burst(const struct rte_event_timer_adapter *adapter,
  *   the armed state or ticks_remaining is NULL
  *   - -ENOTSUP The timer adapter implementation does not support this API.
  */
-__rte_experimental
 int
 rte_event_timer_remaining_ticks_get(
 			const struct rte_event_timer_adapter *adapter,
-- 
2.53.0

