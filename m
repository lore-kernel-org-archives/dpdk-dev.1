Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC29D116EA
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F8A440281;
	Fri, 28 Nov 2025 23:44:27 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 1E698400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:25 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-88057f5d041so19985036d6.1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369865;
 x=1764974665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGCpuu3fIhvjhwzP4d3pQlbALo7r9NWZeaXaPanMnZg=;
 b=Q0NP5ycoPJp8EE5QQH0DYu7yaAuHR1rg8N1pPT/2vya7iQUj51sROKBivZFgCogAqA
 iFEHUVMyyZ4K+XvRawiz7uK1OlHBI/mug06Tzi6HcC5aDGMExgdLk/iKibEhw1DGIOCk
 8X/RlWhVnTpT4h/kP5vSZ9BAN50b7TY9Q4FmFQ2/ouHkWvOLgUKLpNDlY12p+fgFwsL/
 jHPcpWp234FeGS0/Gj3fg1gzv5Ss+Ghhrb2KE0T5or62cm4sJX91FrUcnKCUhR/vUYT7
 zHZxwU6r5b4ucXW14SPZxcFqmcoWscCsZ3n2Q/GmvIbJd/jU/H68+jQmuurD3uLZzl64
 RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369865; x=1764974665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EGCpuu3fIhvjhwzP4d3pQlbALo7r9NWZeaXaPanMnZg=;
 b=gs80k7R3RZJ6iYmera6ZsT8GS4O5ia7HxvCoCy+/5EpIg5Cw6dJ0igQzpEx2/iqfhe
 koeb+Dux0NamxwEpaj6/XQxnKtkG4cmoB6huB34iAyZdVmYhm6VnENkwbF5wfB3jY43/
 i5pLYTei1iKxNaLq1uhgoGd9+oDJQ2LPkNB/Xn9XlUDuir19z1UBhO0ig6JIwHn+YAYG
 NPLDMacRJOd0atthvVJd61K0OCFNY3jxoepiLCOUyTeR/TiQUNHTqTo9UTt26ci862ok
 nKv50yrw3zbtT3bapAofviTrzeqQ6HonFJyghQy9UWukjfFe2O5if4mucenq/ZgizR3p
 VSDg==
X-Gm-Message-State: AOJu0Yy0RiUaHUPGN/7OSq6xFqB39Yhq9oaJXatq80mowjutU0ayk5Yk
 1ZVhjmbZkHYGDnM06miOO3sIYKYKqU/pXef/lL/BpbeECzw1y9prLJBB/sxp1hOSOWmCaUMHd1i
 9q6JT
X-Gm-Gg: ASbGncsfeDolAQoJTbo1gFU31D4EVisd0cjl8li7ws6HbtLo7L6BVQq4tWKNY5nDY9M
 Ot15SKrw0NOzzIjWZF2A/AwG5u3gFn0QUa0xCUyduJo0KrU4J7FDb4idYLLXyE+rfUklpzyv/m3
 NkiL37z6QQlK6qc2NhCDK/iR/LIGOwv74vbSLgQJQgbeCz5kqtL5vRQVFJoogwgCe+uDG/X4Mjv
 cUJ/ZszxQk9EvBalJVsoBC7uhS3fexbTI5QwVJMUsKDTb9x43zYuZbcFdoechQ+cVekvVH1k69q
 CAdCKtL1UvlCGNlouuQZCV9BK9Tbmm7HhAQUO4vA3fTg31Tmc2lUffZHfw9g/349nhTY97Np4+j
 zMnfEKf7uXFfyeOq1t0bcs1d0rNHebuP07pEiyzy2zsCKGlAy7YaZsbDK+PLaOkQD0tZJmAgM0r
 3DxpmNzOxVrPpqGHpd7z9xOTbj8S+l1D17wXD0HEFWd3s3rlSNVPxRPJTjpFAM
X-Google-Smtp-Source: AGHT+IFuk1bXeE+XJhGzBRuw+48RXDC9eBvn88kVyAOIDmSgG8OR4NaqanoVB1MnxSZiRH8M93Gawg==
X-Received: by 2002:ad4:5cc1:0:b0:880:1e6e:806 with SMTP id
 6a1803df08f44-8863aecabaemr220517456d6.2.1764369864999; 
 Fri, 28 Nov 2025 14:44:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/10] test: cleanup and format truncation fixes
Date: Fri, 28 Nov 2025 14:42:03 -0800
Message-ID: <20251128224420.195013-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

This series fixes compiler warnings in unit tests about
format truncation. It also refactor some the related tests
to be cleaner and use standard API's.

v8 - avoid building unused code on FreeBSD

Stephen Hemminger (10):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in several places by using common code
  test: use unit test runner for eal flags
  test: re-enable format-truncation warnings

 app/test/meson.build            |   1 -
 app/test/process.h              |  38 ++++-
 app/test/test_cfgfile.c         |   8 +-
 app/test/test_cryptodev.c       |  22 ++-
 app/test/test_eal_flags.c       | 294 +++++++++++---------------------
 app/test/test_memzone.c         |   2 +-
 app/test/test_mp_secondary.c    |  14 +-
 app/test/test_pdump.c           |  13 +-
 app/test/test_table_acl.c       |   4 +-
 app/test/test_timer_secondary.c |  12 +-
 10 files changed, 170 insertions(+), 238 deletions(-)

-- 
2.51.0

