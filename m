Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0410F995A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B284014F;
	Wed,  8 Apr 2026 18:19:53 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 73EA34013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:19:52 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2ce22328930so6432954eec.0
 for <dev@dpdk.org>; Wed, 08 Apr 2026 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775665191;
 x=1776269991; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JfPkiHy0FYnVGaTL1HGA2ZBKnJ8pDBHosWqSag0RhZ4=;
 b=qxkvdLGNei+eUTvzwmRMDTyj3SwK+1wn9H8OuqfvSfotZ5H++ItHeW/vn73TGpFxur
 HXkPR18jbYeNjhk1pQOyXvvn37PrqFmMGyx1noLep7sfEw/Sj1lSHn1WRb95lyxr6/5K
 tMEIMYD5CK4BikfWwOlAM+emjNwYsSxyXsthVKJj1py0ehSVm20JwYcVNUiYBzO5Rhpx
 /zv2JU7sVrkP/ovXNgtJx/X1r7XwIhMBXDhLDc6clYEz8tXIaXoppCQLsfgPFrNmcRHV
 zphaCyjoEL5gFmSva7v3T2DEZWyHBe1DUKBcVtdi4XA2ukL7IurvulVgwANkXCEGfIfg
 6awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665191; x=1776269991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfPkiHy0FYnVGaTL1HGA2ZBKnJ8pDBHosWqSag0RhZ4=;
 b=dQND1R5T/nWtGSh/WtHuVVcDC2tIdAaWeRKpdamOscw2LuNP4h/hAdBRTbVTE2iAhG
 zf6Y/la0Wpd0YNF7VXJ40X2L2o0iem5dO1UYM+MsXb/18PnC/F7xZJVGzet0BhSJWpKt
 HiJqbRnVkqUj0mfGt3Ea9UeA194k6jN8GKnlxvqKCvLbF7rXsMlmFg/7Q6jE2G1yJ9ss
 E9fAdOrS3YdYqhNv/D4KdXBQ2sfA6P5dOJgGI2mPEYPfzeo14iRO3VPFjbUStuBqN/yr
 i81vhEmLRF/cQveD912uWu2jccGO7KlJyzwIjMJ3DMdzAY5ma6c3pA/h40DI0hv04YUE
 SClA==
X-Gm-Message-State: AOJu0YwJZJ1WTHmJFVJssCCq/f8VJDXs3cXS9RXonfMo9WtDgl7T7hxi
 NytjPx0uXg96rIhrRmyvNgZLFTVe+AulfrCNJh+y2j0iDvhNO6vFxHNwuOReNSkZ2u7kV2NA8ZG
 hvYyK
X-Gm-Gg: AeBDievJBU6mT6I7kA+uDiVlZW8yiVOQ034AxWoyZgCpOwKlcfJ+kY3ncVAAiYeB3jI
 z8kb0E2GiOga6uw+1+d93LTpUFAe8Z53Xy9MCIek/zavb5k+DCPfvRXn6L8lWdRkuX/WyrQcmPS
 vyG+INDATmEsvqqeFSps9Qn6D2sIjbyZm04ybCh9vG4FWKGk/4evUfNEOWfhBVMzWqX4icyBdNS
 sr+HYxH4Omt8YN8P5tfqP8ktBCan8psmzaKXMr0XL2e2QhajE5oMYGKtuDGXXAQqX5fgEDJMmAg
 0Spd9V27J8VyIfmpRdQt6G6CoP7HV6FPyWhSvIP526LXPmfmLATw37OGKWe9aBJ8tepm58VcVn0
 A83eLpewHDplzL3niQcyzWROXlOoZ2aSaW+yUpRMn7ldcb5wu7njP5EhM1k8OdHlQFp3YhHwopr
 UK/LpVpnMMK+QJ75/UNxGwp3anCzAR/UcZ
X-Received: by 2002:a05:7300:371f:b0:2c5:50fe:c771 with SMTP id
 5a478bee46e88-2cbfc45be20mr12735347eec.29.1775665191244; 
 Wed, 08 Apr 2026 09:19:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ed3sm21080062eec.6.2026.04.08.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:19:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] ip_frag: TAILQ and hash fixes
Date: Wed,  8 Apr 2026 09:16:15 -0700
Message-ID: <20260408161947.285185-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The ip_frag library had a couple of issues found during review.
The use of TAILQ made assumptions about TAILQ_REMOVE,
and the hash function usage could be abused by attacker.

Stephen Hemminger (2):
  ip_frag: fix unsafe TAILQ usage
  ip_frag: randomize hash seed

 lib/ip_frag/ip_frag_common.h     |  1 +
 lib/ip_frag/ip_frag_internal.c   | 18 ++++++++----------
 lib/ip_frag/ip_reassembly.h      |  1 +
 lib/ip_frag/rte_ip_frag_common.c | 21 +++++++++++----------
 4 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.53.0

