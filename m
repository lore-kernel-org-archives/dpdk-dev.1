Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5CFB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8EFD40684;
	Tue,  7 Apr 2026 05:52:28 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 66F3E4065F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:24 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1273349c56bso5687586c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533943;
 x=1776138743; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUIhEb1zkygid77eWtI2oO7nyMyT8Xiz8e8bE6VnSyU=;
 b=AgCYKcWOmU9gfqroLg6oBBXORTuvwgORHfeImvG0/buLEP5NSQMX10yR2srmnbPWyE
 DiXO3q6sx05SMOspEzl3yRZzAeBWq5hG0al00mOA4SPnYEIdgGBzBg1QG8iIULdJGHaM
 3nyYqssJD8d+Eo33sYvqqmICpbE9A6u9qAklEYrgGAuoqe+P7gnubicV+e316xNzqMhy
 ERp9pggenSYYHJdK1N/wIxZefkddoJCs6OxMqaDTFM7lO5s4J4p7ZCzJeMFLmaZ0Z5GS
 +kbeuuGAcn0FwhRAOsSycWEqI5if4vnwqwf7l1/q3Qdedziya3wd0Z8cDKCdDTm27Z4N
 Hw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533943; x=1776138743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UUIhEb1zkygid77eWtI2oO7nyMyT8Xiz8e8bE6VnSyU=;
 b=LzNw19pHw1AFyL8bHoFWaXyHAaPNPVwtmjCAJ+a8gvHNP2GGRv3crV57U3yCq3d48o
 gwrIXL+TChhKQsF5I0XgufTAV8PZzqPY9cxU9kdeQw8wR+e+mdEqvxpuIJYIzlNJnqR/
 2UDtbKG0vpNLfys43i0vUxK3FbHEQjL5VrW3bvBYoyZIISE25Nts36UUkZH6iAxVq3Eo
 MVZ95kZIisBY9dQKtEwFExb0MsslMQ8UY5Yg6tHIVDnCO2SCEEdG6JgZ3bvNChcNikjB
 VUsG0l0BxuHcUalRlwXWAGiJ+FHQnnf+hKmsqATICmPvqfqpZWrUc0UccolbS8CYCV8n
 qSrQ==
X-Gm-Message-State: AOJu0Ywe/Q5RSBVPdH34uRyOvfLIbRl5blV3wjfhPrZjAy90nod79YQ4
 XIqChbJbgL218cnv70lPeKMfBCUA3f6cRJbyjWX+7CQa8+KVWMLDDiqlcw+n4Dk1Wnh/gERwnPE
 K0uL/
X-Gm-Gg: AeBDiesg7ZyicqUNKyCIauM/fytcv1jUUJE1cn6dAdGMF5+I8qAiS+gbGf6+1QaZSYi
 97RZiq3g1LzsHWL74AK3qwFHGMF5eH89l1ls9BjRxiG+QBxUpxZpm3QHaMDZBx8j9U6+FhM0E2v
 vdiGpunhjS6l+4+/SgISrTfmX6r+n9ffj+mzQsC5CDN8dcqWI5uHGMjZbOYGz04pI7mNVcmM/rs
 +htSSnjwI3pnPKasQgEfk0WH0XD50/6g4/+pWtOnT17cpIN15FbqxXcqIsbcMq9xLOLAFt0MIpA
 NXK16kZZJ7Oa+jKVMDH+aF1ifD6C915Ul6OMU2TnbkZdxJFP919fttxH0gPeneOrqvFqraHbtTj
 /0txBNERE9+teEjA3Bl9Gg12VysuEFvg1MJ3+4zvOTaxIPlj8KTWr8U+/vP7UeCUxW5UJGy9CZj
 ElwHgv0virRofoyjM09MaUeOpc3DrF2H09dMcgrY1ueSs=
X-Received: by 2002:a05:7022:4585:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12bfb7653e6mr7274999c88.30.1775533943370; 
 Mon, 06 Apr 2026 20:52:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 12/23] examples/vm_power_manage: enable shadow warnings
Date: Mon,  6 Apr 2026 20:49:38 -0700
Message-ID: <20260407035209.650419-13-stephen@networkplumber.org>
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

No problems in this code, re-enable the warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vm_power_manager/guest_cli/meson.build | 1 -
 examples/vm_power_manager/meson.build           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/examples/vm_power_manager/guest_cli/meson.build b/examples/vm_power_manager/guest_cli/meson.build
index 45f2edab22..6a6809240e 100644
--- a/examples/vm_power_manager/guest_cli/meson.build
+++ b/examples/vm_power_manager/guest_cli/meson.build
@@ -13,7 +13,6 @@ sources = files(
         'parse.c',
         'vm_power_cli_guest.c',
 )
-cflags += no_shadow_cflag
 
 allow_experimental_apis = true
 
diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
index 6bc84d752d..53949ce6d8 100644
--- a/examples/vm_power_manager/meson.build
+++ b/examples/vm_power_manager/meson.build
@@ -29,7 +29,6 @@ sources = files(
         'power_manager.c',
         'vm_power_cli.c',
 )
-cflags += no_shadow_cflag
 
 # If we're on X86, pull in the x86 code for the branch monitor algo.
 if dpdk_conf.has('RTE_ARCH_X86_64')
-- 
2.53.0

