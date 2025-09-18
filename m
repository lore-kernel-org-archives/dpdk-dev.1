Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A35CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46D5240670;
	Thu, 18 Sep 2025 17:51:52 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 3FCAF4060A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:51:50 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-78f15d58576so10448256d6.0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758210709;
 x=1758815509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvB8CfZXuxBaIoCRwzsWwGJ78ZFmL0BVzPhkCB8x5l4=;
 b=25nfs+szaa3B1rLGe930o/efN7yt30hG9cFhFEqAJdOSVfN3ucW2rMTVYGMnGCU25a
 U3+xeZKGpuV1qpFM+66Zn54Zq4De+zVEgtVpvuRoPGTMoxN5259qoewpMkWkErTzNi9i
 VpjipZ10fTnFG5bRGTY5561HqVemz2k9yJyWhZyv0BCtkzo2dPVx8PELEPKa2v3Sc6NV
 12DXHle+BxLWWv1wHifUVmxKACXJobH2y5UqX7Imhvt6T/pv0v22+OicFlEnnvEQCS5b
 0NCNpdjE04lTHrZ6W2S9i19d6Ed148XlMOHoq6IASCyYc3bwmOu70Cw8vMZR1Hmi2jdS
 BRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758210709; x=1758815509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvB8CfZXuxBaIoCRwzsWwGJ78ZFmL0BVzPhkCB8x5l4=;
 b=ftGlUYPZL1qXSt0BfEDz1tjh7RIm8icQT9/FGQUz0ZKcFqbN8NoFW2qhaa3aZvL3Mq
 +wsjeecDwNlFmMIBJhbmRm79RuQaU7+v2A4iB5KNXyqI6Po9UNK7OwS0Ub4VWczliHQK
 I5SzPePlk0rLQaGph+yxbs5lr/h2X5/aOZfxXJPTSYI1+B4qD8q8sZ392LJbz+VznMai
 gzNVY3vaGGy6h4xE2N5oAZWUR5X+4Vb8BNT/5mcn16JbbLGH3EjffpiVZZOBKqu51bVF
 7ww3/49801x2sAsElRQKpjjBPxm+E2y3CqqdTofB2ojrm+JFvU3oxtBve5eFclB/Nk8o
 JR2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSVZ2Xl5KMzihjgskvY4Oo4cIiMUFIcVPR01vJdOWWnTj50rweBReLTJbmnkfXUgH9nwQ=@dpdk.org
X-Gm-Message-State: AOJu0YzS2LGipOsU1eu8qwIerEo8R17VqOf8HLAvTGCrDCXgT04fsFm6
 6h/fle2nrfXWlywdHQAsXa0vN+H6Vm3a6sXps6yTtDYrDGjJfcvmOl0l+xRZU2G/4KA=
X-Gm-Gg: ASbGnctH5z9pHpMc6+KXQyfmm/zmSlh/Ho9E5zOm0b/odQAL+hp19Et66hc15YqpeJF
 FT5eDpDmLKxxaMjL+eUbxHjnnfWXL5oDnQLboN0hFU3CnLHtvLZn0eIcr4cSIIOeINj1j9GhHdk
 gOa9A1DG59op/pLG7kY16WYkCLddTYbM7xp7E+OHDtseFC1w22cQMXjbdP7WwRz85Q61xErEco5
 qmSRyY5guF7DbCmKUe5e3cTCJ/D0iIsXr6d027zEuyNZQSgZraidqaWy97vFi4WBkYdflmyN6gJ
 ALkOw9mrHQtAyVIJqRgjn06sGFTlqJaYO8yVIOcsFjm0AFy3nG547PMUSTllabaqa/FlTxCpI6Z
 Sp4fGKUc24o1m8VzOCSbvW6vnNd0OsdG4ktwqRV8qD2p+Y/7jYtSSYF/bq+Zoe2kq3hAx6VdxhZ
 n9Sr0qRFzLk092JEJ9ug==
X-Google-Smtp-Source: AGHT+IGt+uNw3JaX8DrRCNdZgmeuFLQaHMEslxpcI0KwYXEOFprlo/UcvWVHbc+3tc6oLvI6jj9slQ==
X-Received: by 2002:ad4:5fca:0:b0:773:292c:4f69 with SMTP id
 6a1803df08f44-792652fce9fmr42958796d6.10.1758210709361; 
 Thu, 18 Sep 2025 08:51:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79356677f79sm14646336d6.72.2025.09.18.08.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:51:49 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:51:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Megha Ajmera <megha.ajmera@intel.com>
Cc: jasvinder.singh@intel.com, dev@dpdk.org
Subject: Re: [PATCH] sched: fix wrr parameter data type
Message-ID: <20250918085145.584fca13@hermes.local>
In-Reply-To: <20250918024609.2027038-1-megha.ajmera@intel.com>
References: <20250918024609.2027038-1-megha.ajmera@intel.com>
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

On Thu, 18 Sep 2025 08:16:09 +0530
Megha Ajmera <megha.ajmera@intel.com> wrote:

> wrr tokens getting truncated to uint8_t in wrr_store function() due to
> type mismatch. This patch changes the data type to uint16_t.
> 
> Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")
> 
> Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> Acked-by: Jasvinder Singh <Jasvinder.singh@intel.com>

The pipe tokens are updated in grinder_wrr_store by:

	pipe->wrr_tokens[0] =
			(grinder->wrr_tokens[0] & grinder->wrr_mask[0]) >>
				RTE_SCHED_WRR_SHIFT;

The token in rte_sched_grinder is uint16_t.
The mask value in wrr_mask is either 0 or 0xffff.
The shift is 3.
Therefore the range of pipe tokens is 0xffff >> 3 = 1FFF

The sched code is severely under commented and overly complex.
The patch looks right.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>


