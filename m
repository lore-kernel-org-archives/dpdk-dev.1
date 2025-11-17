Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DFECEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE23E402A0;
	Mon, 17 Nov 2025 18:53:37 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8EEC040262
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:36 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b9f1d0126e6so2911699a12.1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402015;
 x=1764006815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bnl/ky9T/i/2Ab6J96Hfj4CoCFtyEvPXV6Ghyfm9TA=;
 b=IXhGNQwU0o2c65U47pK/GnEzhCunB9nyH0zevIEacI0QLqi9alb53iEUy0VA/zG/FD
 XJgzuiGpyKmyIUFjohhpeSdFuIK8HJDEeD8Dqth8v4Fq1cW89oV6JrGVLoZZ0tEMWVtm
 Zoh77ZQk4UTPwOpimblHXNl8lYmSvBlr1B/jkS5CG17ZjnAeBZUwsIqxrHA9Zw/CSORT
 kt4Z3IoUzHNTPViO5+QQOfVKSO/sgZYLIcX0JChbakjuGPhD83ZKh0dDIUV6lC0UolO8
 dJLHjuFUxSbel0AUS1t+lO1Qaku+CpW2kWTeeIHm3CmVj4c2B4wZ+WdlClq1N7Yx2mBZ
 Ky/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402015; x=1764006815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2bnl/ky9T/i/2Ab6J96Hfj4CoCFtyEvPXV6Ghyfm9TA=;
 b=LNJe1YObX62dEywrE4mUcTBXh21TMHDabrBMtK08muion2rbQNsgBfZLQcnOxmRntb
 3ZMLzIX/7yyg0wg2XAPJ1hxIEg02OaxhhlfLQ2M6Su+68kbBahS5/V4AbTE9iwQRj5F1
 IF/6OYgx6SEIsTu6A20yEJMGTND2cLhnb+HD+Fr8azzMOMUooxw3OdNVvorivg2nO286
 5iE4+Ryds6HwQeG3IP3a/gPjk2+6SlK2KuX7fpBEu9coYCyUUMU8NC48O/+ICzWwBIX5
 TmRilKCvmnl45O3OXUreqnr6uR3YLWgPAeUGDLjMj5PXvA0Rk5+Elhbjmj82WjQ6NzO5
 SUlw==
X-Gm-Message-State: AOJu0YwFTeZkVOsVLnd0V+uJ6WN63OCy5ZmFRYBlSLKU/5kyJK/uPuot
 pP8uENsWNrT410DDemuZ7sgp6vjs/MyXdpZbj7g6lG7rGbD80L1JI8YsWkHbXdnFAg1c/W9o4UN
 j8lnm
X-Gm-Gg: ASbGncvWGeLcyIQaRpeZcF4HSVtLL/v79SA5DTNDbWO3j/vBin/Uas9KqClqzYaynCJ
 wwDQK8ijW1zqHSZpZ5Lod2sp6fBQUFSl/U4kq39uVsMQM6oN0yU8aGKpA6BqhTwaNWl+F/XSDOH
 QbzDY5tc/TM8Y/byOdEpDEqc6PxZqatqzLT89ATsARHjEOt29j9XBXPbeBEN8rb53Ez+NF5+3Mo
 kul8esmjgSA5LhQIFxqzm2t6AeUTzSmYUalsH7v9ha/Oz4WjRHdg7N22Z4zJ6i/jq6yKqYodU/Z
 rL3iyWmEp65sk6jLWM/zAGLvNF8ighLhKr17XbgwygAL1r0VPyp5ENXUo5P9AR3mYEIC6LeCrEH
 5XIgdbdYVKNj8spQBVV3aQJ1Rl6xYQyRsBmHLvM4j6nM9x/GW3VpakIF8UiyMVkOXs2zKhPogqc
 1mpIxQEUwbHh+tzMBx+nhjN4EPl2jFlwbq1ONOMx0JvmFAactIwlSdC5G4RGup
X-Google-Smtp-Source: AGHT+IHWkyQ0z4PHY6RSxAxSZKEBeMy8lLZiThAJZitqP8zjSzLIhXAtmikqN8PX9l1/KQYgu0WdHw==
X-Received: by 2002:a05:7300:ec91:b0:2a4:646c:e096 with SMTP id
 5a478bee46e88-2a6c68e10fcmr81790eec.0.1763402015385; 
 Mon, 17 Nov 2025 09:53:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/6] test suite enable format overflow checks
Date: Mon, 17 Nov 2025 09:52:07 -0800
Message-ID: <20251117175332.14014-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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

Cleanup the standalone tests to allow enabling detection of
format overflow.

v3 - fix build on FreeBSD
   - add additional fixes for ACL and cfgfiles

Stephen Hemminger (6):
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: use unit test runner for eal flags
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: re-enable format-truncation warnings

 app/test/meson.build      |   1 -
 app/test/test_cfgfile.c   |   2 +-
 app/test/test_eal_flags.c | 168 ++++++++++++++++----------------------
 app/test/test_memzone.c   |   2 +-
 app/test/test_table_acl.c |   4 +-
 5 files changed, 74 insertions(+), 103 deletions(-)

-- 
2.51.0

