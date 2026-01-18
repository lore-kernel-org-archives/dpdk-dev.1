Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC5C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A81FD40EE4;
	Sun, 18 Jan 2026 20:13:54 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id F2F9D40E64
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:52 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b874c00a39fso642677366b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763632;
 x=1769368432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzeMGUWT2sH9uJj21BW2ouNXrZRjZZTpaB8D/vPE7VY=;
 b=nHItD5/UadAc5OjjjLfvTO2m1rglukfqSRfKi6wBWQqPvfUDDfLxvRmw7DPBAH3lmw
 Vf8ev1nZDPhE+tPO6Adw5c5K9O9ScSGzkTbKmL/5ihd46TdGmmkGDeNBDo1feqnu1Xvz
 9mq3+hEDKR6KjAE+nMuGWjXkr4cLRzarN5s6PtEyJ6ZA/p+WUYdCCpkLcCY8wNFL9cLh
 n9HJS+rEb+EurY5kaUZOIEjfBDqw6ojYQ5xcPh5g/p2bXIqu2IUUzg5wX8Ashj0fpAKQ
 +gWk5zICNynW7cg4vYYALBNkHlPr4PxY2gp+FiteB8ixo6Bxm3Tj0OY2qknM5xhztEdu
 hhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763632; x=1769368432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wzeMGUWT2sH9uJj21BW2ouNXrZRjZZTpaB8D/vPE7VY=;
 b=sd9OoGiWDMaw5AQS+8Ld/GcVfSHHFfMJMdpPxCsEX9vfi72rLRTzc8vMiRajOhEEtJ
 /zyHtvzWHOOW283+F1sk9MSdMXs7jKrgbik0VKuWXIviGWTRhnsVL8qvUHPZAjqmxVda
 EqrPPQwO3ZyOlGww/x6NBUAUCZkKvY/cW+yIXjWuLwOfY3yM9HAlX6Cu5/3GH0JLBISF
 74zf2GdSw0GroFlsnqf0Pu8IfvD7rLKxdKIVPVHbgn3XTwPMh46RHBEX8K7bV3PevWY/
 jkt4t1HRFb59IbcT1sl9mwWt0dNmc7w4OSTWD8mBGAb74ptDKqgBuWpu67Umi8PbqgdL
 NcGQ==
X-Gm-Message-State: AOJu0Yy83U7099W4WtfIU14t87gy3d6YGfOdN8L97hiR3b9/XXqJr+XE
 a1rHVc0h1urd6FyQG9sLJ4nM0tZdRy780EDlXtNI5IY4TiOrSVTPEAtB9Ag3Hw9D3dt1PKTCQX3
 +9XLT
X-Gm-Gg: AY/fxX4C3sQ5Ig7GConi4FK448gkBX+nCcLLRORf7ZB5cp5ArTboWfRYxiIB7dG4t2T
 nyuoN+L6pW6ZxVcZznwW6t9Q+QQ4BE+mXNQPgINuru9k0/8QgLb66gfcKHOAJhj9ebER0xarwH2
 Yekvqj5NCHf1T1HQHxg81cIMrUyG9KZnwNOtrtDF85KiIprR9oGXyLDYtXh17b9SfTtgDjAdh1v
 YMIvv+Yndbey46UwR9S9NiRczEN0lkZXm4N1c/9F/qSENw3nbhjZR8y5C6X0kfTzT6E3kM61PTL
 2ABBDOSyFPm0KbeQ202Xi81Pr/whQU7Th6lPQchr8s8AW48u5NWZ8os1E4jdjGJokY+4nT5r31x
 fK+s1b5ZcAYileCdvS5lVDR9ZMklZqSHsIT41zERo12GQH8tl2O1Li05jUaXCv0jskn8j45KVJC
 aPRyrjwbqNI5dx7eQ+2Rt7KslVXRVgiCynMpZFxceHLiWDpe5WFw==
X-Received: by 2002:a17:907:724e:b0:b87:1fe2:55f8 with SMTP id
 a640c23a62f3a-b8777c537aamr1213427866b.29.1768763632549; 
 Sun, 18 Jan 2026 11:13:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 15/54] doc: correct grammar in dmadev guide
Date: Sun, 18 Jan 2026 11:10:18 -0800
Message-ID: <20260118191323.241013-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "defining generic API which support" to "defining generic APIs
  which support"
- Change "can be got via" to "can be obtained via"
- Change "the necessary API are" to "the necessary APIs are"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/dmadev.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index df25b52461..ad0598a8c0 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -5,7 +5,7 @@ Direct Memory Access (DMA) Device Library
 =========================================
 
 The DMA library provides a DMA device framework for management and provisioning
-of hardware and software DMA poll mode drivers, defining generic API which
+of hardware and software DMA poll mode drivers, defining generic APIs which
 support a number of different DMA operations.
 
 
@@ -144,7 +144,7 @@ The following example demonstrates the usage of enqueue and dequeue operations:
 Querying Device Statistics
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The statistics from a dmadev device can be got via the statistics functions,
+The statistics from a dmadev device can be obtained via the statistics functions,
 i.e. ``rte_dma_stats_get()``. The statistics returned for each device instance are:
 
 * ``submitted``: The number of operations submitted to the device.
@@ -192,7 +192,7 @@ DMA devices used for inter-domain data transfer can be categorized as follows:
 - Class B: Only one endpoint requires a DMA device; the other does not.
 - Class C: Other device types not currently classified.
 
-Currently the necessary API for Class A DMA devices are available
+Currently the necessary APIs for Class A DMA devices are available
 for exchanging the handler details.
 Devices can create or join access groups using token-based authentication,
 ensuring that only authorized devices within the same group
-- 
2.51.0

