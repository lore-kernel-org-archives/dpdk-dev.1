Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF66ACAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:56:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF9840DD7;
	Wed, 24 Sep 2025 18:55:42 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id B09A940DCE
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:38 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4d142e9903fso753351cf.0
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732938;
 x=1759337738; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSLSRIPkUfbzcCyM90QYhpAsCcgtIja0luSxNpfH6QY=;
 b=k3yAs0FC7tYXyddj0HDmoR177jxrfKJaG1YXLCFDCQ6eSQbhJgOe+XxU90QcmK+Thk
 qGZ4MfyJ+ZJBAhifLTm5a+ZfGnzHfx1UxnANIi/kAdyjgv07+4CmlTkdTAMBWYTil3ci
 IkhEayRr0l9Pj94So6nsXqLfZVD3OPtLiMuGTIMmSq3cvfZvT5M5J31SGcmS5GMl9qyV
 OTe7Jcc1+JF3qP0H6y+5/CYXTVVtS0wQJ9JuyIA9aEwE7qSJXZVEili+H4oRF29MzEhM
 38JauOC5P/puzOz0iEeFLTJ6jsb0CpYmZq6U9Jpv+pbWomAPfVqffhTiOiQv+FeYJiwm
 Eapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732938; x=1759337738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSLSRIPkUfbzcCyM90QYhpAsCcgtIja0luSxNpfH6QY=;
 b=ZByFypo0blRuJv5yzeu1dDxiZsyXdc3fy6PdDWkZ7K3/7OtR+2YWao0yGdvPe1JTHQ
 nJStHWgZdMqhwZfv7U5cAlkK6FcEILlIIIPYvc41Bfcdw6rsWIDXH5Fzf2R4BKSbz/Bd
 xhStcOwzdHNfFFuEfqW9Crym/QBv6b8HrnlfTldtXMXwcEm9HVhMrBu4d1xJgsGQYJjz
 zVgjCY/zWiJwPM71XU2VtU1SP6qavNJXMLPFiE3BnklgLXseQrtDRMXw7LOVjkL6rBOe
 TQ2di2fG9m4Sg+O+PieHjWRaL8gBkuryxUUkkKiKUmSIdv1zbW96BfcKOwJFk6tCUJmL
 Vs9w==
X-Gm-Message-State: AOJu0YyTbWdDOAtA0EzGkfMjgwrqtLI5VSK2FlYSBKGWAG04uRkdMiwQ
 gI7uc6Bb9iWpTKCJjj7kks12Dkmx8Q8EOSP4x3iOS0EZcU1mGHdLc3FxsdVyMcOsJA2s9PBm5U+
 ZfpA7
X-Gm-Gg: ASbGncvug8GhwUTapEoQesin34JCs93FmDzGIvagHp2AGFi2QGbgK3NJafX+qR+CKKc
 w/057wEavYxtYNJybOcky+oYKpnBGhd5xgE69/tgzx+YKd/nlHUuhayIcY3MxgyD74RH44n1nu9
 xUe9GboF9htC93vWeInH+K88ZIv7Ll9MQUwZLrPEn0gb+RcKFUdbffffZzLuki8CppbeWru4Syv
 fpAGie2wsqLoZI2ZDoO4/7OGWzYaQ91Kdd7Frw5cw7bfOhEK3Nbj8dJIfinSRXwSfjyxcztcLO3
 uI1pA3T0fuTY72VGUs3lt1MmUDj90gpgnSDV3Yyx+uktKRkMZIR/NaFYvRDfJM/WyMUm1kKkpqC
 unJ5qYCMdbe80WrSBaDyzjs2rrCtEbU20FlMELe0GvAqzKHHl5CItidIERucrgrR4V/bKnsnz
X-Google-Smtp-Source: AGHT+IHyfblCodJFVeF8gFQNlrj7Pz4siPPvkUBOdwQ1VyXDXiyk74gyfRE8rg3sS94eHnFHh+YWVw==
X-Received: by 2002:a05:622a:258c:b0:4d9:1d03:83c9 with SMTP id
 d75a77b69052e-4da485b6ac1mr7622491cf.25.1758732938025; 
 Wed, 24 Sep 2025 09:55:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 6/6] intel/iavf: remove use of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:13 -0700
Message-ID: <20250924165527.268645-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
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

The iavf driver uses a pipe to communicate with control thread.
By closing the write side of the pipe, the main thread can
tell the control thread to exit without use of pthread_cancel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index b1b7a5bf94..781bae11be 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -161,14 +161,14 @@ iavf_dev_event_handler_fini(void)
 	if (rte_atomic_fetch_sub_explicit(&handler->ndev, 1, rte_memory_order_relaxed) - 1 != 0)
 		return;
 
-	int unused = pthread_cancel((pthread_t)handler->tid.opaque_id);
-	RTE_SET_USED(unused);
-	close(handler->fd[0]);
+	/* closing the write side of the pipe will cause read() to return 0 in thread */
 	close(handler->fd[1]);
-	handler->fd[0] = -1;
 	handler->fd[1] = -1;
 
 	rte_thread_join(handler->tid, NULL);
+	close(handler->fd[0]);
+	handler->fd[0] = -1;
+
 	pthread_mutex_destroy(&handler->lock);
 
 	struct iavf_event_element *pos, *save_next;
-- 
2.47.3

