Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C03C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 16:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E177402C3;
	Sun, 16 Feb 2025 17:08:45 +0100 (CET)
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com
 [209.85.167.98]) by mails.dpdk.org (Postfix) with ESMTP id 2497340156
 for <dev@dpdk.org>; Sun, 16 Feb 2025 17:08:44 +0100 (CET)
Received: by mail-lf1-f98.google.com with SMTP id
 2adb3069b0e04-543d8badc30so4287887e87.0
 for <dev@dpdk.org>; Sun, 16 Feb 2025 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1739722123; x=1740326923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYzJYNQK3b6tfDGtiFqicrPaOcJDRL9jW1xIpmB9LeA=;
 b=S2PKPVoDa7KpZBA2Xf3TxYwaTdD/LodUBVIu/pgXjtiZOkL6Gvw1qVDIOp4GBJ87SD
 qqelE2hfgYYv+T6uemM3zATR7upA2XmwIAFdigSE+UrdaoIz/VGLBVWMy733RAp8wlZk
 DCi/vvshf1Klfp526Eq/AOjF2BB9QvIgeQ0dZkWqCl2KYSzZsqXNE30wDX4anTbWK2v6
 Kbb59FGpxPu/exe8QG5Kp4Ahcm2qbVdCCniVI9FKVl7LZQygaJhlyoSWDmxavzVnMlaZ
 VUaB/rHVx72jJhbDiFRdj2ipL7t7sd+mPoegG4FEZN1hNpQ0fghUESuUC6eJWy7pRw1I
 l5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739722123; x=1740326923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYzJYNQK3b6tfDGtiFqicrPaOcJDRL9jW1xIpmB9LeA=;
 b=mgar9c4623HPgOcaBfpHFpFZBd8DqFP5OKkoJo8Q829ClIJNCtaYkIRi96E34k6BlY
 bdpDsTC3astIPhgobdUA0lEtWQ3gnH4GuuqnC68ZDT5BQ0owmczcBWV6iA71sSsuUq7g
 7bfkGtEN1Ai53usr8/6gj85l7YEHD7jBldn5u4H66m4NricZUOz4odpTJTWPp22sLR+b
 /wCJALZeDH8GzVuTlJWpoE2OD1OCRuAdH9nO82pnefnfoRyi/3UuqrG3Mwu4PpXs9+HB
 DtmXQF+GiI/yb8/nWdbCZbRZgwIpXxz1jfOCgCyjqWTUd48u1rgW+SLJ86InIJVtw3s3
 5RwQ==
X-Gm-Message-State: AOJu0Yz5YJeVE7C/oQlLq4Qcvsp+4d1jFSKDJe1XPppMfAFI6G6KZjaK
 f9DQu5PjX1oCdeYGbIFojebe+HNv+2jdiGVycf6ly08V7z8dSObdn0iG1BPr6kvu4cJawAIJIAk
 mODYKxacof7bN+X7X5GBQldg0gkYNlaWfT2fPMqFh
X-Gm-Gg: ASbGncv4jwzDUH2n9Z2vOOdeGYeBw9+sIjKdxWaRLSCTWlezyllfDwxw0UfKjNavztY
 1mr2f8m9EbfGk0e/d8k+aIz/u9JPLoWKTxFr6H+/st9+C4hyQAltI5C294p9J/txgyy0aEQImMd
 epER3lm6qhlAE/o6mlMdQ18hDgWAnPzMGyjakrQ4XzTgZrkNo3gDfjkq4C/HszpHA6ltRhpMJri
 mRe6cJYMzs7xdtvsA+68nKBNMEp0T2zXIzhmZ2N83SPwxqhMlBdYM9prqghHh+RBk1zyOYZYzcx
 z09bdTlnNno6joYrFFmrzyftWdFNjPn5hF795tbME5l8OAVp4Q==
X-Google-Smtp-Source: AGHT+IFKdtWp0LSI2JckzQ44AdKOaE/gcPa9FVwkp7oypw3b8X7Tj56GTNE84FLVGeWkjcgRTMrlmIuZT8D8
X-Received: by 2002:a05:6512:4025:b0:545:60b:f38d with SMTP id
 2adb3069b0e04-5452fe2e4c4mr1786404e87.8.1739722123342; 
 Sun, 16 Feb 2025 08:08:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-5451f144e08sm388449e87.106.2025.02.16.08.08.43; 
 Sun, 16 Feb 2025 08:08:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id DF86211326;
 Sun, 16 Feb 2025 17:08:42 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: [PATCH 0/1] pcapng: fix null dereference in rte_pcapng_close
Date: Sun, 16 Feb 2025 17:08:32 +0100
Message-Id: <20250216160833.3216001-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
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

This patch fixes a null dereference warning; it was found by static analysis, courtesy of Stephen Hemminger.

Thank you,

Ariel Otilibili (1):
  pcapng: fix null dereference in rte_pcapng_close

 .mailmap                | 2 +-
 lib/pcapng/rte_pcapng.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.30.2

