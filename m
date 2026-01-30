Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2211E6BF32
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B761402EE;
	Fri, 30 Jan 2026 18:35:04 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 8138A402D8
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:00 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so22265895e9.3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794500;
 x=1770399300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=qGwqPQVPKQjiaI7s/a3bAAiw9cyyRwmG9q25yk7zSO8qv/nWZxhJ8DLSGWx6BowY22
 GAXH4/+YkLrJgt8uvr//KeSD9TgUKk4hsWZmYi0tllOOjjlUx0tP2Qmt1zSSm68ns5+/
 pxr0F6A2zj0wE/PEy23B0Qjj38X8lt/uL20sIr1FiO7pV7l+RMFE9fsY4ZJlZhop4JqR
 DVQ9IylCPDbMC5RPv6hx+erwEjKOuLfUJqb1EBsNkVQ2UPZeC9F9ySiuyp0y8GDG73pl
 ruLYysA8UBoTpk9m7lj4v1eGlYOdB1lkzbqyY30AKnJa21oS/ODpP8G+bGZsf3UcF447
 J6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794500; x=1770399300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=XP3njH359lfvXjAhuTk3eSLxm+oeUJjne4pQyO8apZHI42RGDs+0aM69VgYgxWwxZR
 5tTaPHQaEdwB9Zmh1JIeYe/09UNwrKOvZq9hJHukVBdiUml52Fg/P+XXBneyvIIbagxb
 GR3FlgaR5vtIbNgQyYUQ3W8iUMkgU87Z6wdVkSNKRQgyoBF07jviGSHXgLMoZeYAEaPs
 noTaZlja5W3V0jGkApcI+hOIn5NEW2KuSfzVX+vaDSqjXo9YbZnAlIqTaqJaTuayzRKK
 5BLCqNY6QgYcyzQElFH4N8eTN6MzTCr+oX8Pjqz+RhmzesG6kXQhIkxZwyW1WFMDBNVC
 OoyA==
X-Gm-Message-State: AOJu0Yzj69atvaO2yvBiVpRIwM5lVrBVpqDx6u3s2t4y7amkquubxu8Q
 1tSJtMoSBqF2yl0qqMgOC8/f9J66JAwC266PMQe1kcQqRt/V87XN/jqORhT4gOhHDzExJLBEBKn
 qUwX2
X-Gm-Gg: AZuq6aLpjDH/ucnbzWFDGYdQXi53sWimtJ/uYB6PBjeh6SIikZdunEez+n9RdIuH/bB
 hwdiHFwnG2ZOcgI77j96JpgnLKb9EGkdyEcIrMDvmtnMyDlq0O3w/0JYNMOeXck2k6o28NdFOA3
 tvniP/R0IHJqeWPvNAMdclZy+11oR3o8YvvXeqXKJdDYQXPSqnVKz9fJE/s1/4Pb62t1xmdk/fU
 O2oAJFGNjGmAyxpH08q4lrCRCz4T+H2gz/uY4bX4GdK6rTR0BcI8rZtK+srcQcqvn+KAMBV7PTi
 lVFHh/2PT29jv6oYJc1VJKoLK7w+aQR/Dl1C2gQmd41B/8UlaKxnjB/s7ikRyekH75MFLBpuIwa
 RCbGeVT4A0soFVPuOti4VfGXUFrO8LQXYl259zNikLgGUPII4wkE97l3bERp/XR8fYm1RG/BglX
 fgXgzbEH5fUuSsuDVEADBNrelOrecxlPpJwrNo/WW+Cd/5vm+mMw==
X-Received: by 2002:a05:600c:6814:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-482db4ac0b0mr47601785e9.16.1769794500088; 
 Fri, 30 Jan 2026 09:35:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:34:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 02/19] doc: update features for PCAP PMD
Date: Fri, 30 Jan 2026 09:33:15 -0800
Message-ID: <20260130173447.14546-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..b0dac3cca7 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

