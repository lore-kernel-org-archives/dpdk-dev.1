Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1201DCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F61E427E4;
	Fri, 17 Oct 2025 17:02:48 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 29A03400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:46 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-267facf9b58so14326895ad.2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713365;
 x=1761318165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qzdi8kIp6sEnmiFIQVaItw81m6S/RSM9hI24cSlzR8k=;
 b=Gj4btn3canjCDxTavf2Tafif1Cy/tW86DbwS+kZmGtKEik09R0caHTvZoBh8k9Qqwj
 +8t0+p1G3MSCe3i3DkZEC8vjDWNhXsgY9oMa0iug4UU0bPop6IQd7DF4DqBk38DeOASd
 M2SPKXiprDTUy6c6QbtKD8fI0w8K62lv7B9FA8QfLjQY9j6AwdMgd+Z/zhCeRakSdQU5
 Xx4rswZF+CY+oIw+2uIQgnNwWEuK8yEfSg0RP/v6ISqU5/xEeR+OzmIv0wauCspxvD8n
 rIkmrenamKntjZCnr1B7tGSkRwuoAKcYRjU555N90sNyXqoPeHH9/39VcDEfC0aq3fOW
 1igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713365; x=1761318165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qzdi8kIp6sEnmiFIQVaItw81m6S/RSM9hI24cSlzR8k=;
 b=N3vYBiOXCymXmsCQmBGNogp9Ye7rDru68scaaTLiqqbK1IdfKjWWjWsOZip6s+Qz4x
 fzuBg4vA1ngy4a+rqlvn8H2TzHNyYVY2hkvO0JPiKib/mpvGOq7u701P/w+4mKIK7oyX
 JpTr15ZfYPHvRMerZCQH4c1l1CmA+GCpHitp/sYxqxFPkVHv1hWiIHb1XU3SsH5UVug5
 a0gRkx99Fx984HqJzdUjTQ+mnNG0xrvkyiYOtetqVxJUtNJh8eyiF+x+QiDyQ/AItDDj
 eKLfNopK5O3jycqbCCbCWQ2Jw1i1vWRgnCZ2YhL/O5FDbehIHMuogHQUsuBn4HZyz6Aw
 d2Xg==
X-Gm-Message-State: AOJu0YwMZQb74cdLV1fPfQK76dR8yt4TjkImsk5rsJgamjG1UlvMsJHG
 wb6ZKsnzSkP1uuojY7Nlt0YXTBO8VsqbVyXvdm63TT0wFBbN5xE4YsRrYoKDD30XZcMoPxARpeY
 om6wEHTk=
X-Gm-Gg: ASbGncvM7hRFxsQZTsorg/crxoGjLhqJXUoZsAqRdaPXpRSwY43v7XFKNty70Qrxcy3
 r3KzFqwSCyI+xd9ZMpKP49iKZcA5zUn9FN7DZhkULeDMnz76ge4VoNjqxnp2jem097pfgEUJJyh
 ggY5vuzNGzqIDz2iWxbk4zPafeNMWz7XrSZ/7mOMnoBNZJAc9sW1O9j+BN4e1uanLrFE8H9gkl+
 +aifSh67ZqlzNYXJUdPmAt7UD5cNs7h62cUxqAyazxN+bFJ7ImHlSRxLibo6isTDMqITh2vgXKj
 KGvERv8LgsLQQQebCO4Z9lhgDOQjRbXAt41hufYFZB55TNvEHduwzJee+2NcQk90gzGQ3zYjfXd
 difNt/rjwD99/rE93zXxMgVQTIhVRD/l46o2xTsSvE4GZQatiPICMSh0BRtiB/aSoZuBw9kpR7F
 DpgPnh4aeg44unVeKFssBOnpRP901Q+wO0NOXhzvCBslxUhLZPzA==
X-Google-Smtp-Source: AGHT+IG4anA5rNlH2kVsKLZ5Mx+AFRzcU+8UfcHtUORFjnc/QAH0IPm5S6m58Wch8AisWlxMoChzDg==
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id
 d9443c01a7336-290c9c897damr59351195ad.9.1760713364648; 
 Fri, 17 Oct 2025 08:02:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/8] avoid unnecessary use of comma operator
Date: Fri, 17 Oct 2025 08:02:01 -0700
Message-ID: <20251017150241.28511-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Clang has ability to detect suspicious use of comma operator
where a semicolon would have the same effect.
Easy enough to fix in DPDK code.

v5 - rebase to current main

Stephen Hemminger (8):
  eal: replace unnecessary comma operator
  ipsec: replace unnecessary comma operator
  test: replace unnecessary comma operators
  app/testpmd: replace comma operator with bracket
  examples: remove unnecessary use of comma operator
  net/bnx2x: remove unnecessary comma operator
  net/bnxt: remove unnecessary use of comma operator
  config: enable comma warnings

 app/test-pmd/cmdline_flow.c                |  6 ++++--
 app/test-pmd/config.c                      | 10 ++++++----
 app/test/test_compressdev.c                |  4 ++--
 app/test/test_link_bonding_rssconf.c       |  2 +-
 app/test/test_thash.c                      |  7 +++----
 config/meson.build                         |  1 +
 drivers/meson.build                        |  2 +-
 drivers/net/bnx2x/bnx2x.c                  |  4 ++--
 drivers/net/bnxt/tf_core/tf_msg.c          |  4 ++--
 examples/l2fwd-event/l2fwd_event_generic.c |  2 +-
 examples/l3fwd/l3fwd_event_generic.c       |  2 +-
 lib/eal/common/rte_malloc.c                |  4 ++--
 lib/eal/linux/eal_alarm.c                  |  6 ++++--
 lib/ipsec/misc.h                           |  8 +++-----
 14 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.47.3

