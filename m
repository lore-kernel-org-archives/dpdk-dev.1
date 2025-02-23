Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D2C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 21:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7172402DB;
	Sun, 23 Feb 2025 22:53:04 +0100 (CET)
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com
 [209.85.221.98]) by mails.dpdk.org (Postfix) with ESMTP id 5A03D402D1
 for <dev@dpdk.org>; Sun, 23 Feb 2025 22:53:03 +0100 (CET)
Received: by mail-wr1-f98.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so2026714f8f.2
 for <dev@dpdk.org>; Sun, 23 Feb 2025 13:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740347583; x=1740952383; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLCSQFVQv8VjFrJmGroWCfKrupqcgkYXy2v4bBh/kUQ=;
 b=N5MA0dTQ8ymw+oYdwpsuL2hGHz3WBWqWX0MGK9fpFO+7zHcx1b9Br+zAynB89iZaI1
 0zJTcaOrj1C5sFauW5na1bQfYtkfh/fFVWifHb+5coTF4Wg2hc6Jl4SkrTURXKtTwXgq
 vQIjg13uyc5piR1kVVpWc/DqmRy2XjlZi9sG2Jel9mlJ2kCCypfJbeUEzX7u1PsawnxV
 OJRzhTTcTp155NsNsjbOYxqPl1get2IffvQXgXNyyrqMHuwMBn/Q1kbSr+RZIwu1h/4v
 0MV3AVUIaJFXBtSqx3q5lUC5SYf3t0tFkpdYyDlh+7BvESE0HmteWLSJflrEOqnpTKw+
 7MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740347583; x=1740952383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLCSQFVQv8VjFrJmGroWCfKrupqcgkYXy2v4bBh/kUQ=;
 b=AQYV3aKMfItHknAOclY81deLCsYUxS648UZ3q0qO6D1bEKReQVaHzJwpdLbr3myv0w
 xwRgX6YuQw4XowCbKJst2srCwz2Ha4CAq533PNqiBni++0iLMowk6z2Ku2l6wldCueez
 bWOJJLzmJAH6KY149kXeJcPl8/YAB+WSvH6k+AMagXvbHhc84IoPs5xrYQzhJ82YjnpL
 WZ6jloG+xqbQ66PMYlH0kbXU8n4/fr1QU/BXR5wpWS/5SkqmPC1zJNiLAnEc1rqK1x/K
 2gMLS3l9pQ8eXtRXERQCnELgq9SCzfvuYwOkSydmt9B8iBCIvznrPWlrdcOmgBHMpac5
 sIAA==
X-Gm-Message-State: AOJu0Yz6DGjmaBBLKOzDyaPaZdeFluBN3KNhhWLkzgkX7lo6dYcSzqRN
 SKCrfi54pNDzSmtlOeNvjYMH0SRBv+Sf2MajWM0lbtX36qUeC0MAyhQf/+gomyolMyBJRr4Cd/I
 F+8HPQqREm95tgc7FsYnA9wg0cV8CG7NoEXC5vO34
X-Gm-Gg: ASbGnctOF68ux2KG+wtrvODtY29ACG2/QTjUhHS/LDOxFmzNJzxueuEh1K6p93KFv2u
 bp8CWBBZwP4QOU3kNRZrTnPa+SA2pFTFn/lZn+L3bAQWy//VwADZjkvdt7eMGZ/Xq/KqKdNITEr
 WlQG379QsbiYfVJR7IGxHXblpbG6ZwDREZEnWCdAv4+F13ExkfaKZAYUbrTiZ2vI9yJHiTqS81D
 rYg6yPGtKrkWEcBhefz+8xMawpTTPT8yQR4ufTC9xGv00NpkjpiWMbZskE9u+lHGgnBPPpwA2Id
 yBAGZWI/24OaJq1rRdV+C1kFUN7dBBTMQzUGMPxDu86GA10FJRb9vIV3PRWW
X-Google-Smtp-Source: AGHT+IGK0RPkGIRDs5Xb2qhSzjWmij2wor2Bgrnop7lsY1X6X2u22bAGKsCdRGvuWWGLR+X+Dm5w/6B9gCY2
X-Received: by 2002:a05:6000:1786:b0:38f:3e8d:dd42 with SMTP id
 ffacd0b85a97d-38f6f0d6ccemr9860648f8f.53.1740347582432; 
 Sun, 23 Feb 2025 13:53:02 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-439b030bde2sm4555805e9.34.2025.02.23.13.53.02; 
 Sun, 23 Feb 2025 13:53:02 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 4E14C14F03;
 Sun, 23 Feb 2025 22:53:02 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v10 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Sun, 23 Feb 2025 22:52:57 +0100
Message-Id: <20250223215259.448723-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v10
* no change

v9 (https://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@6wind.com/)
* desc->len takes its value from mbuf (Maryam Tahhan)

v8 (https://inbox.dpdk.org/dev/20250206204645.1564535-1-ariel.otilibili@6wind.com/)
* fixed seg fault (https://inbox.dpdk.org/dev/CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com/)
* addressed feedback from Maryam Tahhan

v7 (https://inbox.dpdk.org/dev/20250201100300.2194018-1-ariel.otilibili@6wind.com/)
* no change
* resent because CI didn't take patch-2 into the series

v6 (https://inbox.dpdk.org/dev/20250131231018.2163893-1-ariel.otilibili@6wind.com/)
* added missing credits to Maryam Tahhan in v5 

v5 (https://inbox.dpdk.org/dev/20250131183439.909831-1-ariel.otilibili@6wind.com/)
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)

v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan

v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger

v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 75 ++++++++++++++++-------------
 2 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.30.2

