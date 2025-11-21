Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1388DCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1BE640668;
	Fri, 21 Nov 2025 18:10:07 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id C3C4740609
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:59 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b996c8db896so2582073a12.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744999;
 x=1764349799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=EznZG6ox9GJBeLxg0DEoOfSGzjYNjqT52jYSd2HAhOghoRVBhuFZ6BWtHUNhA0OYzN
 mAWlosznoBQ9vdprJMykgXpMNLHHGg4huvtgq4sSap5H0QMVQ6dbu7xzv19oNI5uSWuC
 tVlLeP3y86NssIEY5GTD4LOhe48FaVXywlGyCyN/Mho5f1jqKgX5XodPYb+oekIKTio1
 yVvFqZja9v2MeaE1H7Xr8a3v/MUUzGh/NRDlsAAtAfcl3nM4ZzjHKwgjK7Hcas035kzm
 I7CSd11yEEUyZYWEL1lgLRRBUikBDdn8q2X1vs2j3V2enfMokH9ezAmZ1DcesUxUqh3G
 xTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744999; x=1764349799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=ANU8DGafIjZhhZhGBZMxLt2/XyFqwCNJJw6NmNLDqyp6ZfwRISd3/J/qLitSONMu3J
 a5aLXouTdTJcJIZH5fAWa+g+z13D0nqr8N2B3U965oxhGHvSX4pJ7wYBTtv6P5KjVaZM
 XdYRFpTuWiG/B8BOu4SIgMeLeWQL2xsPpWBIy8fy0CHsJrp2+OnNCVvl5B0VM01w+etk
 9fzEGPvaL6z61ofCYOn8y7KnCtdKGTyhO4Qbxuj6Z06bH5n0mGyhkZctetTXSHDtoUk/
 o47m6rZcenJuhRIAaxRF9Uhyl20JulfkorLpcCMnwYrznVugnxs7qbL8n3msITUfrhsE
 4Ylg==
X-Gm-Message-State: AOJu0Yww+A5vn0JKu0ZbxPNbxh+TCV08Rq7+RAa2hSxF/BwAFULLqPhp
 v+JfzfM1St3znikqAeSh+GSD59JacrzVL9m9Yk+D6PU3uRWFdxylQIcnIoJrfPt5lxajZC5hkJk
 7W5Lr
X-Gm-Gg: ASbGncuhZlK7GPJutFLz+ifzMYlmzXz8Va+xh5YwMNO06o5UuGp09OM7QTpliI+WK/i
 unxDZRk9cAu0sdIMyjhAOHe5apQTcCkm5QwNXxngSaHE2GmTyBDJKlBTAIUSCOwqMXkZyMNvnZo
 DmBFlObuQRFJzcaeVds7FMDKcoY7GPX7xJlsnU0nUWmqlxwai04fLHdC9LOqh7wjzJdZXuxd/Zd
 uq0K/2kQuuKjeJQtlAbOSYnhiNWwuLE5zu4njQHFDL5diBH3i2KoNtpSV/hKdZgwI4j3AWUe/gG
 jJu+qXaI8vFz7Pb+aok1cro2bx5sNrPqRMINtusac4JNZou02U/Wvbp1k+/lMd5EeGuk1tTBZej
 RsMOQEWJxHl4oFiDFwqjPW3m6VYznH5ku94HCtrVxfFOMD0z0sHAN671eKTBy+synZQ9l2c2+Yf
 hRje1bIrhB7PDTYOLMHtkfptmR28+pUxG7DX48pDtALYxTtk3MPQ==
X-Google-Smtp-Source: AGHT+IF+MPt6lysT9VbCcFQRUew+ULIyXe/QXc7pdb5tm3fYNk/KukjXcX/4qXz+TCK+b/bPLg+9AA==
X-Received: by 2002:a05:7300:3a9d:b0:2a4:3592:cf5c with SMTP id
 5a478bee46e88-2a718aee8a3mr840158eec.0.1763744998826; 
 Fri, 21 Nov 2025 09:09:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 8/8] test: re-enable format-truncation warnings
Date: Fri, 21 Nov 2025 09:08:27 -0800
Message-ID: <20251121170947.134502-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..b00260c0e9 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

