Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB6C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61B4240609;
	Sat, 17 Jan 2026 03:38:24 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id ADD1E402DA
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:23 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so471344866b.2
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617503;
 x=1769222303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lvxPKZfj5XvSHnTwUsP4KjcyAJOsvv2JWgWbDBemeA=;
 b=CJr4ZklNyBfPZWc5bRfng+t0wq2ylGKiw7VIPRjuO770mLXXfnMNdj0V1CnmigUsg4
 11OEroLnlaR+RCUqnfIa6jl+SJZY+4RAFNlpwrtU8n2nfBn9A1/u0QJzPUpYHLDgCTVq
 HKN8AyE0OcFiyqmTqHCpwjFV8aOlDIbf8s7S0Y7zZWpNZ1gYPqKO9kXwTY37ljobUgR8
 Xw+Tw0WGSdw4yby9OzjtxsprhSiZT360kbg0uQeZxkf86jK8Rpwdl2Ew/rT4M32YIpkT
 UpzPzBStm33lLp3IeeT67SslH+NHbUtg8RUwFaaVvTWXW/YLju3BViH5XpoXCXQ+cUT9
 XBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617503; x=1769222303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6lvxPKZfj5XvSHnTwUsP4KjcyAJOsvv2JWgWbDBemeA=;
 b=F2y+RZagAYCjvfcyS+o3RjtAfOwn+2Z9ks4qJYFAD6r89aVgRKF2cr+U+hkSfXe7Pi
 2GFeETHPaWzlAmYqFLFJLU2R/lOiiDM3DlmqZ27Kaidjt+Vim7gWeDdOzbEhF8U8NDw2
 bewzOO5grGi/mBWGV7d+eGMPYNpy6g5YC/RaINtQs8Pi8kNt+0YKrGAXQbWqXINILd0D
 9sN1TaiYxfy1pOirq73CJaVZpEDj0ZVbvlzzM42ZHIMq/hz8Kac+KkfAQ1P571MO5iiH
 I7CM9wV6ZpaRHlVfvxNls/3jSGftCe93/8N55/BMnJohmXnQaj0sKzhVEC9uu8U0/U7O
 Jk6Q==
X-Gm-Message-State: AOJu0YxOTa4Hv0PwKoLJcVTbl3Ai4Nol7vwYyGpjPyogB1LKd00k2lf6
 JUXZh8vlQY5WK0hU4oBxY8HSZlEXm4ex5ZZDHjl3vjTfFwhBB51At/E3UBGfGeXAX+a2avu+/8a
 O/vbi
X-Gm-Gg: AY/fxX4cS8sUXvkWsfTMUp5+hxiyLJtz8ZeWvSRsPrqicuFvqwc7+yk6sSQWHTApeLw
 5rTQwnZqjuecAgO9FwDl2vlI3O2f4sSw1D8mHtjYLZ/b+9MxCA+XPAkY/Dir62G/EQzAEH25qxd
 zCTGjCA8JCSRFpEfvwQo1XJQMj5vw2sZMqt8TOA/NCH6JsFok92J1Sh+68VjPoCFawv+mXUcR4H
 X+xWCBJCfCPjH02x/5gzSifLCTfx783fGHCRTJDqFTFI2zJHS4KOuMKfOl6K/+XHBUGkwYdstuk
 GzO2xR3VX4tgJ+FYDg46SQG4dtRb4sgte6jhDDTBU2GPBeMNL2tk1uRV4JwVOE90Dfgv3MMmrDV
 I4SoIMfZxYo9ThDYla9r3iSIZye25mSydNDl7eUZTXZ8NwRPB0EZpU0xYvH4Mnuq/FzKcfCjt9D
 KOXEew88AZcOljR2GReVQ1BtYSDQDyvANXesQXRPeJP6YGxBG3tg==
X-Received: by 2002:a17:907:7246:b0:b7a:6c39:8e73 with SMTP id
 a640c23a62f3a-b8792dcdeb0mr425944666b.23.1768617502250; 
 Fri, 16 Jan 2026 18:38:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 0/6] tests: enable format-overflow and fix warnings
Date: Fri, 16 Jan 2026 18:36:55 -0800
Message-ID: <20260117023817.196694-1-stephen@networkplumber.org>
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

v11 - rebase to main

v10 - fix on FreeBSD
    - rebase for 26.03

Stephen Hemminger (6):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test

 app/test/process.h        |  44 +++++--
 app/test/test_cfgfile.c   |   8 +-
 app/test/test_cryptodev.c |  22 +++-
 app/test/test_eal_flags.c | 264 +++++++++++++-------------------------
 app/test/test_memzone.c   |   2 +-
 app/test/test_table_acl.c |  30 ++---
 6 files changed, 157 insertions(+), 213 deletions(-)

-- 
2.51.0

