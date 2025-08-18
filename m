Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E4CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F1C40666;
	Tue, 19 Aug 2025 01:32:53 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id E2A4E40666
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:51 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b00797dso30810125e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559971;
 x=1756164771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+43g4kMXsVPa2foCDjIY+G21rdMrQ92mkFNTspUivzA=;
 b=tKuvh3rCkGGSlpu34evezYCHNTtrh714KEyG7en/elGnnfQnRXkANpR2uUK58qQECW
 h3XmkjbCzdTAgY1uhW2g+047r/MyY4fJCFMzDnax3oAkh7MgbBDo0U6bXFmpOJRfsODp
 AQIQ7X/5dfhM2KgC+VlG+KeNUTdGl6q176NcsX9rbc1u6f30zjYl+5womeMs1ZAleqQw
 nt1QNCrY0Z/IzBxg0rJ//ftXrw9SvNuuXKosKxK9Vdmbqw732MKbg7ygQK6oHd0bWoaS
 BkV4BB4YKBa6LKJTNI/Zsc7s9L4rO4i5skebyPbRt5WMREy0X5Gd2++UdARzGTAzfTob
 aA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559971; x=1756164771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+43g4kMXsVPa2foCDjIY+G21rdMrQ92mkFNTspUivzA=;
 b=JVhU37RVRKd3hYmelTKqsUVVl0YWV8Gd0UlkmtrOZODJ2ThRg81qZ5gZLTIppuurn8
 CIrnTDT4jGLs597fLJ7Buen11gU/xySe0aGL7zhRQwY3Z9VKNjC5hVos/9n3qq6ioMKZ
 QbFF9JEsFIjDlTtMmij0ynUCtkumD5zXTeCPCtl4cFYMB4M3IRBt4dK7opyn48nDKIEi
 EO5WeudJqgHGAOF7FIQwd1ol4KI0c7EDe9BTM9jjsf/lzXkTTslDax+cqGxBF/COGWak
 3ssUSR1olSrYW53nOdbjtX8FwtIqoiEDXKYL3HXv43dDqrs+iRFPfNjsqoUQp3cyeKjZ
 mhVg==
X-Gm-Message-State: AOJu0YwTxhH17igGnvgZlI3EDcqFfIIOf4dJLbsJk40ohN1pp9z1VtIy
 M6zri0Lnguhs2xTxjtQCAcjni9ZD1zAsIRmjA1A0E1m4m/suZVhCv2uu4BR96/oZlv1eEf+A59k
 aLwrN
X-Gm-Gg: ASbGnculpG50rFnnqU7hJtq0RCYCOcoVksep2dapHm83anE7aCnzt1USgE2gLLQLHQW
 m7zNo9QTsAgtjJbKNO1UcOWBo+6IFekDEaMLu2ENHRSfjBE5JfuoHt1iZ1MrbdIOLslBPGtl+ze
 prGa1//8K6i1Zkdt+4kwhoplJ0htJ1URKe//nNlpfq5pgrsnhCBRylS7FBp9EkJRnNNgTN+QRRH
 93acXRLwjdKvlOpgbvfRQwHVhpYRCH+cXWgam81UBCf6H32han8NThYc05oog9Te+MLrex0c1WJ
 5jAoGCMHR0y6kxzJq+iW+arC5GlO3js4phw67ABXZAeDSwKbOGyMkH15L7BA6G/mHlnCdYXzb+o
 q/VxDQ/pbI9Cdu22/j/U8Trn7fccR9D9U89WN9SqRUr9fExSf5W6F3lkW7gKP7qgsiThTlF16
X-Google-Smtp-Source: AGHT+IE50iG49o5LXjEMgatitbJGgJdPjsd2wiw3A1V83enYKq99fl4JRyO54sgKSKhFkww93m9FVg==
X-Received: by 2002:a05:600c:314c:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-45b43e0b924mr2051535e9.27.1755559971537; 
 Mon, 18 Aug 2025 16:32:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC 07/47] proc-info: remove unnecessary sys/queue.h
Date: Mon, 18 Aug 2025 16:27:18 -0700
Message-ID: <20250818233102.180207-8-stephen@networkplumber.org>
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

Not used directly here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/proc-info/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index be67386658..2feecbca78 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -9,7 +9,6 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
-- 
2.47.2

