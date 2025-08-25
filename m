Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F92ECA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 730A940BA4;
	Mon, 25 Aug 2025 05:42:55 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 19D1640A7A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:47 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3c6743a10e3so1323119f8f.0
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093367;
 x=1756698167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4D7n/Gg0JZdP4MmQV5WFOVmHoW5WpAXdAfUzSKBrrfw=;
 b=SjXPsuRGtcPLqYP4354NP0UTKDxOEZefi6+KKkPPpEzXGu8FWh7DapcW67kmnsqlYt
 bu4GU+QYnXlWRSBMvO9rBBFWrlrqyFN1NLAJxxmnw3CVYRl6bHBTHKDwZhymilRcs7SF
 nZNoCE1vFtVZerti3L9BQvoxxdQ1S3HTgE3jmI4H+XH/ktVi5FD5hiiaWxP7OVHLqX+y
 jtln0kUo7TJYeiA9D0AsSOsPHR8tBnOsW/YMsLl07Arx7BcD5vbLAjX57e02gntVOFq3
 XO8uL5dNAs5PD+S3PGmi648Xnm3bQ3FkOVnfJe+W97xoeDka0iNBkp0+RCAKnxwginaB
 0rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093367; x=1756698167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4D7n/Gg0JZdP4MmQV5WFOVmHoW5WpAXdAfUzSKBrrfw=;
 b=fCB3guu1jtl99xEY6RJl5gw3S9H5vtcLFs7Z0/LBtY8n6ntAp5xd8d9hEQq30h5GVL
 HrEE5HWSsYjk3yoPyLwYTXtBW8DsLgnUNzeKxld3CeZftVLvwexzMKgRD+PvpqzY57Iu
 A7PxqwpEETudm9b7uxZ09wAGaDbgXKgP9QaHN57y3WWx7MmxK23TYGr8AWD6yVOxfYct
 fjQC44ly3TpSqnD3vp4QczQBAyh12vOUXXbqPcEodhWoAkRlzhc/BXLEVX+oi/5wmT0j
 cWkWpoL1n5O78nuV0pN8LK8Dyjr/UxVXiL+vVDLu4ajmNHMz8SwOcqHkVy9+qcT1XRc3
 ia2w==
X-Gm-Message-State: AOJu0YxnqoE7/jFY6RxrVP8Xnk8L4t5yqLwS1MBiFHFmlefWG2yThdrv
 rpkrIY1ttqn2f6PGYcAY8IlAabHDPZwH3FcPWrx9puvV9NS2D/eUhrA1WGK69dIyilCrOHrxqXL
 3bT7R
X-Gm-Gg: ASbGnct5RKQXaKFf4fCP1vL2ITAbLx0lxV1DjdtA4Cx5fBjWi6CNfVQeJwv8H56MNGH
 tsRQ+Nm/lKL2RhXQ7YWLAZHppktKuJiewS5smGqsoH82h1XXYHeu5f7sj6H2okmGKDIkWxExXqi
 7aoyiq5x08jCtReJh70857/Gct8gK3FEe1A+3Hc+hq/+UTBgEFhq5ZL++2YPHKTE5aSLJRrc4Q/
 OA7iqWxG7UUQLSbOL9f/0Lv72ykROLa/ta5MLcgI/YbehKpN6hfdeURrBUXOj0v78Eg2f62UPOg
 9S5GcD+MOEhZ3KkEW96p8covPwsZ+qRExznN4yoeRme0VLm4ebDVWtfhEOQ8fgN7lfNVk57GO1o
 gmG8uXZcrvB3N1BjE2zWx/maMdEACyCM13dLpqrIr3WxKA9u3XoiKKRODycvvzl6XLSfjcFMh1X
 OikSkdfCU=
X-Google-Smtp-Source: AGHT+IHVD6mEiTIGyI3oDXKJQAB3MWN3hDnqtRxvCHvxybMYaUK9D7N9oal6OOmHTcyB+P25hOqQcw==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3c5dc7313famr7984543f8f.33.1756093366728; 
 Sun, 24 Aug 2025 20:42:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v2 28/43] net/ntnic: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:41 -0700
Message-ID: <20250825034126.12046-29-stephen@networkplumber.org>
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
 drivers/net/ntnic/ntnic_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..18cd0212d6 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -5,7 +5,6 @@
 
 #include <stdint.h>
 #include <stdarg.h>
-
 #include <signal.h>
 
 #include <rte_eal.h>
@@ -16,8 +15,6 @@
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
 
-#include <sys/queue.h>
-
 #include "rte_spinlock.h"
 #include "ntlog.h"
 #include "ntdrv_4ga.h"
-- 
2.47.2

