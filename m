Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5039D25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A711740693;
	Mon, 12 Jan 2026 05:54:07 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id A54574013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:05 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6505d3adc3aso9419022a12.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193645;
 x=1768798445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4PuEP5S/MZnc0WdyV7NuiYG426/3sQBFxrZffnrxXs=;
 b=WvUPLVGghxph7Vz0dHG/JwcQdfCLfAaIMVGfYr3ohIT1bJpScv8LQJGCTM2AvWcw6w
 YlgAiZSewXTJMBST9KApetcTq3aiN+4xcu8W5CT3l2yl8sjZ1/3J8JWSbMczcwKHfkag
 4jvcP4sE8fRAQ/ECUidIXSyYzvdIrAIn0rVUzQ9QOapFpgOpCzqNwuXu8Bf5UaIeXdCu
 L12DoEWKbcCQ/ZI/n/6tCYnL+qjAxA7OMG8iECj1qdNLpC467e0vx/YXmuXtGf+xl7HB
 QqtBGLm572cK8R1xcbE27sJZKRhI7YXxYCjzAb1q9zUpMHs1EYSVmkR27qyksfTzxxxm
 fPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193645; x=1768798445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4PuEP5S/MZnc0WdyV7NuiYG426/3sQBFxrZffnrxXs=;
 b=eiQygyFtBd5hxVc46A8E0Bpr91Bdd4YId2pbP0TNXLh5XADMoi4y0r65pT2iJnjtE8
 PD3WsGCu9AQ7e0iSvenS2X98F1X7Tndqo2wSsfH1oXwlZLq6u0YLF1d3GGo4UBMAo/5p
 2lXYDgjykrhMWY1RdwEM64lGTS7RI6s8sBcfzAzZ1xG+BB9Y4C+1Q5vlQRJK8RL9wg2D
 86ZHVPgnxt+/m90ELMvH2TvzBKEGnJvtRtOJ6klRbrnwFeeB5Fu7vH1iiLJZeA4Bkjge
 40K2xEeoqcntLKz4RD97M+fsA/tkXNxB1ZXOiNkeq63zIFZ9OrL1iu1EvEnrR8PpxvQN
 OthQ==
X-Gm-Message-State: AOJu0Yyye4IwvuBlW9fzRTjfQs8gE5yOjEX1howSiPpCy5AiXR+Wx6xv
 gIf/pBiyg5LxcTaRh5rRCmZZvBV1jXcXQBmnWjF4BXm72AWmeEROtanhADMFfu4dOeYDNYeyK/U
 7izv7
X-Gm-Gg: AY/fxX4B/s+KQHw/K27FHR46NsAgjgic3320f1hktyZ1BvKbFVJHP9qtMwwZDaUD9j4
 WA8IjHb8rFmCmAu2mHdM3S4y9Dk04V7orO2Cd2mm61dEvfjEKPG/by2pZd6n89tBpGWp6lTjaOx
 fYAPWZ4PKlTeTXKY+7ZhIBVzo5JSWpZWzfqn4e8QAOH4Dcui1oytbYyPD/vEc4Vd57Nia4QBZ+l
 ApB9iGlxQJ5Ty9EnZUria6Mx98WD4nxZPmvqJyKXNz9VcVRIWlHQT/8GAuxBVF95vURdP/hHV3W
 4yjCBC+oGcslCRdoBC/z/6M8lq0/pzakyhUHIk2OQ5DSqJCLytsnVnXndgSfecTfmZr/kb7k3Xo
 zOOSn9Lk0GZ/8aAknBdB8TVRmNIFeixTLOzePnsSaPrX7gOlmb2co7BGPNlXiQrSwTIyBFfyYbJ
 tzdw+ke50al8h09U7dhQ8yMt8KumSCHM4pdhBB+ysjsTGOskj+pg==
X-Google-Smtp-Source: AGHT+IFayJDMQvjWZuo6WrDdqQicX+yV0YvFK7chFftlkGnRZWXx598qbG0dwWEsNP1oj3ri+hYLFw==
X-Received: by 2002:a17:907:7846:b0:b84:569b:5b6e with SMTP id
 a640c23a62f3a-b84569b61d5mr1011816466b.41.1768193645040; 
 Sun, 11 Jan 2026 20:54:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/7] pcapng: fixes and improvements
Date: Sun, 11 Jan 2026 20:50:13 -0800
Message-ID: <20260112045359.142999-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126051218.50568-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
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

This series addresses several issues in the pcapng library
and improves test coverage.  Several of these patches were
submitted previously in other series but have been more throughly
tested and passed AI review.

Bug Fixes:

Patches 1-3 fix potential issues with string handling in the pcapng
administrative APIs. The pcapng file format uses 16-bit length fields
for option data, but the library did not validate input string
lengths, and used fixed-size stack buffers that could be overrun by
large comments or metadata strings.

    Patch 1 adds length validation against the format's 16-bit limit
    Patch 2 replaces fixed stack buffers with dynamic allocation
    Patch 3 handles the case where comment options
       exceed available mbuf tailroom by chaining an additional mbuf segment

Test Improvements:

Patches 4-6 improve the pcapng unit test coverage:

    Patch 4 exercises the comment option code path with varied test strings
    Patch 5 varies packet sizes to exercise more of the copy logic
    Patch 6 ensures the test runs long enough to verify 32-bit TSC wraparound handling

Performance:

Patch 7 optimizes timestamp conversion by replacing division
operations with shift-multiply arithmetic, following the approach used
by the Linux kernel vDSO. This eliminates expensive divides from the
packet capture hot path.

Stephen Hemminger (7):
  pcapng: add length checks to string arguments
  pcapng: use malloc instead of fixed buffer size
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test
  test: increase gap in pcapng test
  pcapng: improve performance of timestamping

 app/test/test_pcapng.c  | 134 ++++++++++++++++++++++++++----------
 lib/pcapng/rte_pcapng.c | 147 +++++++++++++++++++++++++++++-----------
 lib/pcapng/rte_pcapng.h |   8 ++-
 3 files changed, 211 insertions(+), 78 deletions(-)

-- 
2.51.0

