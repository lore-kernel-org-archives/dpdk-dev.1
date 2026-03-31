Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC1F10F9308
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:49:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B28240275;
	Wed,  1 Apr 2026 00:49:12 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id C40E74026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:49:10 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so39995445ad.3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774997350;
 x=1775602150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzoFudENB77etqPA7vm9U2aGwvFopm+YAFCdOT04800=;
 b=yfSQkOvNPQ5+DlMvWZ5LxRb4wZ0zLNcoSDf48TCFl/4dWrhox1mrdz6hj9c6cPMmvX
 566G17+PkFeBdx8FgsleiKs9HuxbGYM0wamxIQc3hghwsumOyrtYQD27R/d/7yGzbZe0
 pUNhcnVGARHLvAoooNKGw97M+gmwQ15UPmbXTI8eR9txJdBrHoRzY5vdAy9le+RLgv+r
 Of0hd84TUGCRII3SyFhA2BeqlS1TBCPUSw6okUdTezNgVGQtf85O8rMFhtFKr7xFiLll
 0E+z6KurJPiZptqfdVmhlwpu+/MIrrpomVCvhWsW936TyjHl112KBYA43mYJ0tHXpCsf
 t50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774997350; x=1775602150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SzoFudENB77etqPA7vm9U2aGwvFopm+YAFCdOT04800=;
 b=hiPiXbV2T4Nl0uz4+yLjaXA4BtvmHqwoHzSKnP/b6Dg+v2/afdkXhhMbsO2bwQUEHS
 4+yzphLVJEIR258/9G+7CopNEt0CNxVQpExycNStGjkV7lFvc6Z3uvmgxZETFwL9euHd
 eWX0noTmLAS9Lo10PYFLP4DIJEDrRAwiEW49yAeQH71vvRK/HEI5SRYzNcIqzwGU6E0x
 JZO/TpIP6HNCo2bYTohh3Xocwv0r93fvMLVqK3SbCQUQbRqowDO+EHqJyndCZAFogXxS
 ZiCmO2vxGOJ/X19hFozPl8V9wb2D4HZz4VW7VD25HZofz7wYTCjQLtQtJXC8eNDCc841
 H17w==
X-Gm-Message-State: AOJu0YxZGTfBxamVf1+KbT3/lE0HIau8BXx4fh8a4ar0cioBMfIrpJ77
 tRUzwnJ8OsKACtcMFPr5fSpdh7RGzkpL450ZmuDUMIhft0wacwXw4DnaC7EXng+mAxI=
X-Gm-Gg: ATEYQzxLzeMOAHJ23wHLEyKATszAP5VE+qzVpDCh+WRxqBhsBds0CEpMcjapV23ghxn
 q86rVKQFpQQ7FIpDqwWLj6YaMAZrlcB3J/2IS+/dFbl501Qn1S0LD66hb9oFimHJ2an4PXzKQzY
 xSJozEOQdnwGQaNK17EsU9I/HmbXQ78HFjGAYeFXnylQtque44KzkKJ1LqdcOqk/NIiNBBNuRFV
 Enr30gNqiKgrBTvNEuNYhajC4lSx3XQgJGFntQUMVj4zyM8OK1cLXG0JOR4xALGR2QmYLTwfn/V
 D6MNd0J8BfkEx12j2N2fOV3BZZx72t/MIrKy8rVB7a+WgZtMaw80geYkKwppby/NGv4b2FQdOty
 BLAFFwfTDq8KQ0ZcY3dAmAKTwkPnJGDf9SnMunvG5WR9yaP6dELONNZuZa3lJMwK7ymFiV/Euou
 SxI6AgRKDONFjRsgl2mslpGhie+WesabXSOqI=
X-Received: by 2002:a17:903:4b04:b0:2b0:b1e7:8841 with SMTP id
 d9443c01a7336-2b269c44915mr8307135ad.32.1774997349809; 
 Tue, 31 Mar 2026 15:49:09 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242642856sm147305345ad.8.2026.03.31.15.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:49:09 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:49:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 5/9] doc: reword trace library section in prog guide
Message-ID: <20260331154903.57a8c667@phoenix.local>
In-Reply-To: <20240621023254.4258-5-nandinipersad361@gmail.com>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20240621023254.4258-1-nandinipersad361@gmail.com>
 <20240621023254.4258-5-nandinipersad361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 20 Jun 2024 19:32:50 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> Minor syntax edits were made to sect the trace library section of prog guide.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

Integrated this into https://patchwork.dpdk.org/project/dpdk/patch/20260118191323.241013-7-stephen@networkplumber.org/
