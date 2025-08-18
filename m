Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD42CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE6240BA5;
	Tue, 19 Aug 2025 01:33:50 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 4CE6E40BA4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:48 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-3b9e418ba08so2631106f8f.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560028;
 x=1756164828; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x69kLJPvV9ufYFyZJk7tvJaBn+nvaJd4rQ+z39WXnhk=;
 b=gM75y6zQ6YkZ51r/jVNHKBBrsaMNjdI03OTYktAPP12RvwFuYCmwKpouTKBAber1XK
 byeyi5Bi963uRzFmuUkBdeHb862vKSgKuQUskn7BmzzyRO/9Q8i3oJn7sDEiEpJDo+NP
 ziPf16tOC4A4iYqb+YLtG3xgpbB7dJiXxAqYF9ZeJmPIdcO3ISan55GIzbrvi9KkSsns
 PzI6sFG4AGjQFuT/3fzlrld3cPhlL1tsUxfa6YWiVx00ct/kckvYzgxfShpqaPHQU8l6
 5Bo+rQXsULx7XliS8nvy7TXB5jiHor6wwBYJ51WvlpHO55L98qC3cxG3N9iPNe5M+xgS
 zm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560028; x=1756164828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x69kLJPvV9ufYFyZJk7tvJaBn+nvaJd4rQ+z39WXnhk=;
 b=KGDVdosrtsrZdZoZPNyezuC94u85JG3qk21zaoqW/bHsqCUXerNO0I+u5NfjlBXkgF
 lEGMQbV2VJp77/QVAGS6d/rZqWzw6Dyesm7mBahBC/Bcmkb7ZI7XkSA9ihp2YyZKlPuP
 JM4t8Ogv0MBWV+aXOY1RB0J/Wzb64/zzQs2ulEAb7lzKKto2a/6lEV7ojGXWbpHlolJs
 9iXvoL9m4k2Qpdn52JD04zQNjYIBbfBIRhRrhlLcaFO2Aw5IzbUbzuqxlcPwcOA5Yg0z
 k+PFuZNDXKC9PnCyG8MoPk6gertAXWdT3rBT9Tz+F2w+XrK+oeBzEibh8JseFCuRVE4Z
 gEoQ==
X-Gm-Message-State: AOJu0YzGwpkWgUh+X54u0PUrmJ6kRTVb/thqEVDnZPwrdD8wMviA/jUx
 EuItOYqU4Hrv9bcCHJMb5/VGcgzoXFSn0uVqx1R7Aims5C5IKklJTLnAF06xsXxn4xEREH0w2WD
 sGC1y
X-Gm-Gg: ASbGnctJwLT1OYnmh5nggsLVLAymInoHPNgF5XMzG7jzYyQuQJbaVC2qPbEkhvlHcWq
 5goVHiaCoXIdWh80dUq6XG1E43CmJqyEpjOE4MrFyMTnafbFwEOIanNTsHBn7NgROfoWSjih4TD
 bLKbZUIpaGcUkAgBknrSOcptQKGPIrW0uwzrAZim8I0B9Q/DbBS5k34Bavly5r/5X8ovBx5OV1h
 fVjbKABxHixEkAGxE8OIAKydoksm0JrHAccmhApfgvC9QrGPzp1ZFKp91b9KoKIpjefrSqXZvwA
 DO6qsX85cjfTrlmS3UZDRWjCb2RLIANITg3aaEWrI6AYqDDQcxNBrcA8DkAyUxeAm/sNWUOdlFz
 skJwl8ldtfsdxnyp/TkHA6QTlKAXh27FZtlu79eWd+laFKQOMvwxxHlJeUp+b7lc99KVqaqKD
X-Google-Smtp-Source: AGHT+IFm0+V7blBk8fK6O8pUClOv927UwiB7kJjYY0OSqHIhxqlCYbQiwrPaBiVW+76yOJw4R/1vpQ==
X-Received: by 2002:a5d:64e9:0:b0:3b4:9b82:d42c with SMTP id
 ffacd0b85a97d-3c0e9f010e3mr261010f8f.17.1755560027899; 
 Mon, 18 Aug 2025 16:33:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [RFC 27/47] net/axgbe: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:38 -0700
Message-ID: <20250818233102.180207-28-stephen@networkplumber.org>
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
 drivers/net/axgbe/axgbe_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 93e6c177b6..e882842e39 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -10,7 +10,6 @@
 
 #include <stdbool.h>
 #include <limits.h>
-#include <sys/queue.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.47.2

