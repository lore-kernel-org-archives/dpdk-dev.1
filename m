Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BFC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C35402D4;
	Tue, 10 Jun 2025 16:14:01 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id DAF744026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:13:59 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d38d562a55so299871885a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564839;
 x=1750169639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfvfRMH22JwkmzBhsfaTr68CAlHRJgIAnQXHe2sFdhI=;
 b=jd4YWrKFkRjIqCjReb2zT6Av3go3jcQKtKLbjo7zIaM+pgRJe3q6O9MsXVm+C7h4ZJ
 dxiCbdW+Xta8EMzfiD7+QvXj9QLAJpMs8sfF88FbCnLQvszoxMDptQecp4ttiNvnZI/4
 uy4R2kdCmrs59hwMewyYdGjUCG7n86PA00oilsT3WYPxWyLmHSqCHgBO1wD1+8F8lDHR
 B8bWdvVpUrgvxlquI8hPiEC2CWjczeW6THIm/aiKDLxOxsl0nOWS3010GX3cERaGPk11
 g0/cL98tSDyGgsL+ptxUviDeGhGmJ4QffHvGxhB2v/NctXtl8ePjwgiJRs1bJUjeZjHO
 JJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564839; x=1750169639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfvfRMH22JwkmzBhsfaTr68CAlHRJgIAnQXHe2sFdhI=;
 b=suvMMjTSGP68G5VjRW2gX9LykeVzgXWfKra9l0ToosT6NKRX/q0CqEV7tQq7hQwGdA
 xc+mh1wKDvVYrrMGlJ8dWQV9PTogBfmem3Q8eb4pvV574/+6D99G8h4ifepL/prZQ6qO
 OL7r26d1UUPijjTTifoe3WVN0F06/GnplmpqhxjyCM8VmR3VaDUc3w8X1khyUDU0kA5M
 WIvSRFCTzLZtSVTNX/CuxOvcmzANbA3Y/Ntx1KpiByVyqlfYYr+LlLBWhAxjNAa+90iS
 04A2FaalChOk3pqsNpW8szOQD4rmsYuSqG7Cb5TKfIS6n8agkZ4JlsZ8XBSRdNgMQB9u
 i8Bg==
X-Gm-Message-State: AOJu0Yx6E3qqDGmK7gcqOD4UtcmWMBynw1/tF9HXE5UhFzYdqSYU8222
 uSUYZJOhAh7My1/LusShfHQPD/lTgJT4vkMu3DTQvPHk4zUdHwu/Rp5DQbvBfAxtueQjK7MmRA5
 ErETK
X-Gm-Gg: ASbGncuI3Y95pk6LJNKt5ogzqQlFAGGC3gRDA+F1Fl3BPOvVCOrQ+uPOSFnZg2J4d9Z
 aGioi1fhVDrbKgBbtD7Cx1VsXbGkrMr/Tj66XmsqzYj33BX0hsa5KuFrfOHpwNmtEL5UzUd8XKI
 N8DX0/PrM1C5VfUsrP0de1LhGr54OZtZ/AdTXhA6j1x03JCdC6tnXBhIvK/OM152OPTZINpjJgZ
 5z+JFp5QhfXCYjNOAVVCk9AR3c7ioCOfRkPNUgAEpVc8DxoROyKOAYv/zhZCjFzJRTDxQQeCV+G
 KNjD7TTipNKiWHRzWJcOB1yrnjR8CQTH08qhhJkr7qk5i0xEir/IfGKNTJonWu9DOn+Ttiljaqu
 wEBve/iG+YoBWXhZMIP9FpDueMUPZH/z4qFSq
X-Google-Smtp-Source: AGHT+IFWX8BuzghEqdHaLhw0eyymFJiihM0xy9F3TqjTdiCc4xXwHQWtwaPBMFM+yjKZuXbbelnV9A==
X-Received: by 2002:a05:620a:2606:b0:7d2:3db:a4c0 with SMTP id
 af79cd13be357-7d2298c5bc8mr2721769085a.41.1749564839013; 
 Tue, 10 Jun 2025 07:13:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:13:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/7] latencystats: cleanup and floating point fixes
Date: Tue, 10 Jun 2025 07:12:39 -0700
Message-ID: <20250610141355.91759-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240408195036.182545-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
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

Latencystats uses unnecessary floating point and is inaccurate if the number
of cycles per ns is not an integral value. Cleanup the code and add
more tests as well.

v8 - rebase to 25.07-rc1

Stephen Hemminger (7):
  latencystats: handle fractional cycles per ns
  latencystats: do not use floating point
  latencystats: fix log messages
  latencystats: update include files
  latencystats: enforce that unused callback function is NULL
  latencystats: add metric for number of samples
  test: update to latencystats tests

 app/test/test_latencystats.c        |  84 +++++++----
 lib/latencystats/rte_latencystats.c | 212 ++++++++++++++++------------
 2 files changed, 177 insertions(+), 119 deletions(-)

-- 
2.47.2

