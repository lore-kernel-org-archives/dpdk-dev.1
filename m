Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C2C369A2
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 15:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D65B4066F;
	Thu, 10 Apr 2025 17:21:31 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5A858402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 17:21:29 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1866581b3a.0
 for <dev@dpdk.org>; Thu, 10 Apr 2025 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744298489;
 x=1744903289; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8NtuJzdkIwO8yy8fWZw/CGso00uZnqEk89WvBBCSoY=;
 b=CYD83C50MWYYp4gkIWqqcxhiglpFFl3xrdqdQqGd/XLwWujjFzwZkG8yDWAJhCI0Ld
 OWCMmGeWRDWmyTaJYuIB3OdqW/pmUu6pEzzpcPd0mV1XROLL9pktnnUIZbCyW05timv2
 rlWaJRjKWSni0M0Hwo/swGMUFt4NQGB00dvCfVZ7gB2PTc5diNcW+pgzDkOGuTQh2HMN
 OhDtzBPclYdsfdz7XD5qcnB6wjiUUcCiwHGMHKMpEYHh5IhuvybZA5yBKak1DI8hlrm6
 3V3R/swcJSxJX6krww28bRE93b1vAIjGEq8qio9bjuoe3SaRV65KXkBUHqWdwifeDkTL
 yqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298489; x=1744903289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8NtuJzdkIwO8yy8fWZw/CGso00uZnqEk89WvBBCSoY=;
 b=GkARCIZS+LX2NxYk7Mj8o+MSFIrgxEqS8Hz3CE0OgRV3KB5AF23YcetolnbUNZBUK4
 cIrhS7SkyZWrG/0s9/SQPxA0gn9BnxU+xi+KhDVmUQ7w/wZL6PJRVlE0CQy4I3q2AGmp
 3xfpqPi7o7ryKhwyJBfew0VS8Y7sPFmaHWhK673D2PAUjeYkWEo4VYwIx6q7V4t++ze5
 aZcuZPpN056Z3ARbCRlVykp+pX3DqvcDorw+eo1rLM799/xi4NvthaI+97GseM+FXBZ5
 fgwT7L/ndJpmnAL/Nul/mdb6ZoCLfO01yMFUoq3XoAx+Qu5w88zdmsJ8QR5yvz1CEQcq
 sDTQ==
X-Gm-Message-State: AOJu0YwGBEUM1uAq2FZX6imtOmGc9S1mffUvegcm5sKTtG5ZbxTJjcLD
 ROh7bCBy3wKUC8nPi7aZzME2e56sFSe8BMw5KNXN6+6o4MK7W00o8IPAsYfVrGZWks3WYgP6lp3
 /
X-Gm-Gg: ASbGnctkFKSqXkC3tajszTyth6BnAg8PvWx2RKoOREv6bThmyE2f5SwmJUqgxPQcWnh
 YvfJI7rXhin4HwwgvESMG9M4hMQr2MtN5AqBxjbK/pRTW06A5C9IFQJoaF+ShsU8eq6YkkTZJ/o
 WPdwFIkJyhYARGEeY5kT0TlgbCqvrAq9lMx1zXdE9aFYvx1b7nchOncYVLYe4aVEWpcEYk3JG2Z
 XWtRkJH0F9QyEVJlE8bGfgjvYBei063bQ9uWEZ4OW9fbwPgV7UWJDX6q9+a4mE43sZ+PuxI2koz
 qzYzsg0waJp16QqDoVEILcFJWcfST2YHGBIwg4NGuIM3DK/LCpq+157YnOZjh9R3ZVvJvJ2PEjd
 V6ePgrEjXaPKKqgSJ
X-Google-Smtp-Source: AGHT+IEeLzKADhGxP5P5mDMVDGdQV8iH6QkVbquEqK6eNupeAPATT98E7fAxrDT2dta426y87Tss4g==
X-Received: by 2002:a05:6a00:39a2:b0:736:491b:5370 with SMTP id
 d2e1a72fcca58-73bbf97f68fmr4675631b3a.10.1744298488604; 
 Thu, 10 Apr 2025 08:21:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1e517a7sm3497106b3a.146.2025.04.10.08.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:21:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] doc: update kernel version requirement
Date: Thu, 10 Apr 2025 08:20:50 -0700
Message-ID: <20250410152117.5822-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409035408.199320-1-stephen@networkplumber.org>
References: <20250409035408.199320-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The 4.19 kernel version was end of life in December 2024.
Update to 5.4 and also add better description of what "not supported"
means in this case.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
v2 - better wording

 doc/guides/linux_gsg/sys_reqs.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 5a7d9e4a43..ba48b8afc0 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -105,11 +105,20 @@ System Software
 
 **Required:**
 
-*   Kernel version >= 4.19
-
-    The kernel version required is based on the oldest long term stable kernel available
-    at kernel.org when the DPDK version is in development.
-    Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7.
+*   Kernel version >= 5.4
+
+    The Linux userspace API is compatible across releases but there are some
+    restrictions. The oldest kernel tested by the DPDK testing infrastructure
+    is the oldest maintained Long Term Stable (LTS) at time of release.
+    The DPDK is likely to still work with older releases but it is not guaranteed.
+    Compatibility for recent distribution kernels will be kept, notably RHEL, and Ubuntu.
+    It may work on older distributions, that are no longer under standard period
+    but this is no longer but this is no longer tested or guaranteed to work.
+    The following are outside the current support window: RHEL 7, SLES 15.5, Ubuntu 20.04
+    and earlier.
+
+    Some drivers and hardware support may require more recent kernels, check the
+    documentation (e.g. :doc:`../nics/index`)
 
     The kernel version in use can be checked using the command::
 
-- 
2.47.2

