Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA6FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 541B740648;
	Wed, 29 Apr 2026 20:21:02 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 0C194402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:21:00 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2d8fa0fadfeso90250eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777486860;
 x=1778091660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8AUcMLwl7JNpjeEGfKgmXol7SZCIr2k4fnNVLMhXmo=;
 b=LjqTvkSzIPDruHhXGQrYgxXq8DBIC1anNtpuIoOtuih1zoDWLdjg6hKpS6e817R56H
 JSVlz/0NJf1XYu1qZhsnvfyuufWwbCFCF/lmubMFju1InDtkcHkoLu0Dg0S3Wqvquw+n
 to4qWyEdVygbH/tVFRPI3/EBEwhHrq5rXxBdmoU4DHy6OPjDrbSOt5Ag13FdpdUWNhTG
 h3PzaHa2IyDhhCqW9Upj4Il9PwDU3IOaNvz7L1zJYFod4vGwnCGw+8OYP0hA6O5pPCFB
 HZduRdkT0JSUUE5Yd5R8nZu3F5hO7x2or1SspCco1C8jo/lN7rUgTwNB84BdD+5rdmkG
 oj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777486860; x=1778091660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8AUcMLwl7JNpjeEGfKgmXol7SZCIr2k4fnNVLMhXmo=;
 b=dm+FsPpPKIDX6XMLFZCQOxzUDAsLPlxl5aWpfKe2wdeWCIJLAJ4Z9mktBbJ+3uTyUf
 bnRFCyBFIdva2NNrT1sCix63yljv+FLWPERJsMqQZpS6uqKqN36JHTQxS9gACnRpRP3z
 NdrlT387i10ewUscEq8QUpi1IA58rSvqAbU7JWGzOkyTwnsV3L2lcbEck8hwmFImrK8j
 RP1c0qAw7H53QzI6b065E3CuV+D4QsxdAE1H7RqSS2pUNAdj2+bdtdjO47e636egmngz
 jN/CgNCGjK8xpFYLf5Pftf5sByhyP/aXAKJDCTM0wu49O01kaIXr6UYf0xovtOs5R0PR
 RXgg==
X-Gm-Message-State: AOJu0YxlLlPa28/HKjuHQ8kuhmCAPcu57nyWNTT9ALsOvoxRMvJWyEzh
 yi4YMSkIssogCeEVgKipeis1wYQFTFYd17KMUFcs7uSHJ+5h1Zwfod18/HQL3nDiZ8Hkwq9F0wb
 UzbWC
X-Gm-Gg: AeBDievkJet2dYcIJkB/lvAILl+FMN3MKe+qbls1Yu6HY9h0Cf94bVPhbgikCpCd2UO
 GeKwTQv9JwCfNAzbaMGYQH83jVBMjg5pZm5A65lyeu++r1EwheS7do8M/tROsxtFVDszgYvMxTD
 M4E4+Gr122TmRyccGeR7exqpG6x0NOtcVT/wmroRzSCBbnmv/4RwOP4UFRY1HHwqYBqAPokUYpb
 9wY4aJnqh+JShNd7RbnJGCA3c0cyjHa4rO4ToOBV/IPouqjX3UEXA8epAsQwtO/NMLpHOu5H3Zt
 yC+hxgfepeu2Tc/xBPxi4l9ZusMg0PwSrZ1zR/qDRk6dCj0ck+VftrDpKy8QTr1aw/IwSeZNaW3
 sJkNw4rjyXI5a8Dp1IRCl586kCYRK781a0Wq5X+TZM1lFxd6xeKv+G6yhl7WzG+/9cmhlNcIVZo
 I6ipAHyT/c/MkRcg5S7VdEJ2RKgoWOPAo6ze5rxEWv16s=
X-Received: by 2002:a05:7300:861e:b0:2be:88f2:3c98 with SMTP id
 5a478bee46e88-2ed1b3c6b63mr1815058eec.1.1777486859536; 
 Wed, 29 Apr 2026 11:20:59 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e7absm3230152eec.10.2026.04.29.11.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:20:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/3] af_packet: cleanup and add test
Date: Wed, 29 Apr 2026 11:18:58 -0700
Message-ID: <20260429182055.398105-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413230018.515837-1-stephen@networkplumber.org>
References: <20260413230018.515837-1-stephen@networkplumber.org>
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

A couple of small patches for the af_packet PMD.
Fix indentation and add a basic test.

Stephen Hemminger (2):
  net/af_packet: fix indentation
  test: add test for af_packet

v6 - add myself as maintainer

v5 - end test after 10 packets or timeout

v4 - fix test to use stdatomic correctly

Stephen Hemminger (3):
  maintainers: nominate myself for af_packet
  net/af_packet: fix indentation
  test: add test for af_packet

 MAINTAINERS                               |    3 +-
 app/test/meson.build                      |    1 +
 app/test/test_pmd_af_packet.c             | 1123 +++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |   64 +-
 4 files changed, 1158 insertions(+), 33 deletions(-)
 create mode 100644 app/test/test_pmd_af_packet.c

-- 
2.53.0

