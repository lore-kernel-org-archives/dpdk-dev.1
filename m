Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB82CFC518
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E32402AC;
	Sun, 23 Nov 2025 18:45:08 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id A6F7F400D7
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:06 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2955623e6faso41806935ad.1
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919905;
 x=1764524705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeOpxo/j9KCZP/VLQOcpRBObd/kLR6ddT/TQglrzxuE=;
 b=n2NaoqJCYaBXJcjk/jfyoaCkSDBh3HV2KZxQt6ZUdSWZiTCQtc3ZzmsgGMkYOY3CJy
 prTBYgAgESyQA7LwrD9rt8Tr5WnsZgd2iax3SsBu3AoshavpBC2c5U0mbO6bS6W6hznM
 J3diQdxfZ0hAJ3MIlprlCCgrqztdGYErobcxtTwi3wtO5ACGeDFcuhQLNHb8iAzvbpO3
 +IvwtW9LxWzqVCDaRQ+UpvwMo0R03UYf9GAFKZbk5Sjft/hOn2smG+CtM6UQ6dlhXjc1
 kg2qmxukkkr8HSon5XwxEJYuR/8mmZesC0kag86zF+W7BcryoK4KszNTlHei9JxHOPjm
 2G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919905; x=1764524705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CeOpxo/j9KCZP/VLQOcpRBObd/kLR6ddT/TQglrzxuE=;
 b=DKL4P/SdbEqm4LZnUWc2d2g7gtdEKFBCCDHxcR0udU2Jye6VttAcpKFQ/nBGyMLTzg
 GJdrClO8xXYa8xZrWxc8scu/6dQgapymqkuVEOc8JODEfkBXwzngRwmxZ/pj+d7dtIhP
 jyuvzQH7OLTjvaXK60qKIC7LUbd05Fx2q76ILRZwxAP3N78dLdjXQzyriShppWdBs9Ro
 cqDNNoobUQCsNL0ZzVwRj6ljYM/44Gms6gA3ezy1PcZss8COF3HZIZYV9eCGQEH7PA7M
 nuUYFVoVo/pVOnJKHLc4qwRjeFhiyf/AiICoIXypmGej8qULjSnRkTD3vzEoBnVg3vll
 Pt9Q==
X-Gm-Message-State: AOJu0YwAZUg/uzDK7Ea0G561I5MjnfQwkdBS7ukwtN79RA+KOeWyrRbO
 FdzlSYlNcHbD2EaLgKRoSvbn4XvZjOYtDUq/R166577o95PWMs/IenwU2ZyZIgRfsL06ADdSX/A
 VU8Ua
X-Gm-Gg: ASbGncs3wRBj9iDBhJafv1tDTFpZJWsGHUOrGUOiWTm6AqMkn2+CV/YUzNVuffpb9yR
 HXUlJL0+MXSV5VQhnsIuwCtJ2cShbInbTPh5GOphPjiYH/dVjrQvKfaWHmOC46QUS9rZy10gGGw
 q4tbFbak0oNHQblccHBUOL+28fQMsX2aUgZAuxHfI7sBneOElpOE1s5HGUrgM5k4wkVxr1XuKXp
 pZJWC+TyelRkfb+F0YEgWFiqESjAOMxZrBmEXRtckGWAv/AsO0rgzXUh6lvEtWXUxz/zBYJKDfo
 JZ7WsMHUXfAO+YwxckPPsPk5hoeTeDb3167o0E+odMdVKnqUQlK980bLRDmi1IIfKdeeoGsPzk1
 3o3MSTYjUBvLxBkfqFdbsitKl4191XoHyh442QYkyGs0ZmyERt/6CS9r/WlBglbUQOwCvvtbYuR
 xQj/RlVU9sxkC+1bnRWZJnpbU0IRgdZ6B3FCnpxKaNrnfTKIsadw==
X-Google-Smtp-Source: AGHT+IHakdY/8tvJzskP6C3CnNfZoT8shi/pnyU0dhBhPYPwLQsiIG50hlGf4mAXWmRju2wNSZsOZg==
X-Received: by 2002:a17:903:983:b0:246:4077:4563 with SMTP id
 d9443c01a7336-29b6bf384femr107180875ad.34.1763919905558; 
 Sun, 23 Nov 2025 09:45:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/9] tests: fix format truncation warnings
Date: Sun, 23 Nov 2025 09:43:23 -0800
Message-ID: <20251123174503.20880-1-stephen@networkplumber.org>
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

This series fixes compiler warnings about format truncation
in the unit tests.

v6 - alternate strategy for handling huge page mount point
   - fix warnings which only show up in RHEL8

Stephen Hemminger (9):
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: use unit test runner for eal flags
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in mp_secondary and pdump
  test: re-enable format-truncation warnings

 app/test/meson.build         |   1 -
 app/test/test_cfgfile.c      |   8 +-
 app/test/test_cryptodev.c    |  22 ++-
 app/test/test_eal_flags.c    | 283 ++++++++++++++---------------------
 app/test/test_memzone.c      |   2 +-
 app/test/test_mp_secondary.c |   4 +-
 app/test/test_pdump.c        |   4 +-
 app/test/test_table_acl.c    |   4 +-
 8 files changed, 140 insertions(+), 188 deletions(-)

-- 
2.51.0

