Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A34CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F70402A4;
	Wed, 14 Oct 2026 17:07:43 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id A22984026E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:07:42 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e618db81c0so9514115ad.2
 for <dev@dpdk.org>; Wed, 14 Oct 2026 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791990461;
 x=1792595261; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JF5WCkbHjFSNWd/BMSKgmDtXS2s8UOtTBAOhjEjPg8g=;
 b=JxL2ZBrNttklwuwqArkAEGWRZ21hf6KO4NMhZyg/X5KCqCC2tqrRe8s4EfO2IihjU3
 2qObsSap4j4QwgKAvNA0w3qFQzSnAWXBg2aNzdC939cxNcpQ7410/f+nmuhrDZPhSyW+
 UV4hNdzvTgSQbKyHblSN7T8l2jc/ewyLcAnLWAQxGLMHFlzos3sAQM5WIfJGVeXn3iOP
 9CtY3G6oLtJcFEQXE8ReJNdFSWJNod1d3T0kzejKUlz3zoLqO/x0Ea8AnGWNN8su9GD1
 KIBYpbsRgQlAkpJuDfGKlT+Ggk//EXGxc5G1Nd5kC1aMWmPU5mREuPkAoSKcRuZ0FKL6
 uUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791990461; x=1792595261;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JF5WCkbHjFSNWd/BMSKgmDtXS2s8UOtTBAOhjEjPg8g=;
 b=xvUXyNbqD7g2gkq1v9pkaqnFX+5uPRfdejYKxWB40Si3m/ppal8/4da867+UerNO6D
 t5Ur+sE3NHV5AdK3ExRFOsyoOd1/+bWiBB5Lb4GQ5y/4Hm2f4w9fTaw61rDoeme71LqY
 PVhOgEe+U2422rRELF2WPDrDqv1JC6sAxDsj/naX55kPwt3YbhPzdNzWnvwDb36ZQSqL
 H57b1GOLoDuOV0D0p7ZvElx401oqo4bP8JrXPPBDRV/BRnKrVA7dR3m41Q8+GdxCCaTJ
 JuWv8FACVtJKsuugpOxQSo5NJspzdOxl9BYgQNLJP9zIa8V4zTFlYla5b7+JDtHNxdxh
 FVUQ==
X-Gm-Message-State: AFq9FYLCyvirHhd3hNq33+OYaNAKFd/+HqaSBl9P054gpsfbBOboZ0YV
 M/9L4vwSIBKJE+SZt7e0mKnd+UYW6XcsoWH3/OOjLOWC5HBZOHX5YBBMfNt0bShNq38=
X-Gm-Gg: AYBFou2qk1L76F0svV/brRD6LUMWnF7+tI2HlO2vROZ7ilBTgAf2uAhLpUxjS/uKgzU
 oKosNmsflCN35UN3exlnY2dpIXiNqIROSWp45TD6bDHaaV9UEy3Y1r1tEHiQT7jwE8GHFALBaUe
 fy9Wd3JgXNM303d7zxnPWiBIebwudoIZQ6oHArIsAHtcLoxxkTbKPOm7hs2zxBIwlurzg4ZsyLk
 ZUymZye4nVQTq0Qo5da2jOzRq+A54+kqDXyFIXEpY5YLyqo2AY4+OkJHGsVsB6k2v0RleVwa6hV
 A3YsCUxLHpvCehFUPioUHtDPLhLfqsNHyCpGaZz6yw0RFn/rV29FStGFxHszoMcte6NRrKjQ7Sb
 /EXFtRj9s4IB7zOVRN0/k4R+8HwlbIgJhanGTIKaYUbXIZMUOUR+2lnKd3f4kEQkkCGnOpovoQn
 hzKXTSZKTeK7DC9Z81ujVO+mF8MFS1lb8I9z8fkkSKWPlGAnkooQJMYtTYNdOAAWNfYsWxVjDtx
 M7wi5XP6F2CAxSl7nD4fczwSGKvyBav+cLAn3st
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id
 d9443c01a7336-2e842f31562mr141591705ad.50.1791990461448; 
 Wed, 14 Oct 2026 08:07:41 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e4cf3sm69198915ad.72.2026.10.14.08.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:07:40 -0700 (PDT)
Date: Wed, 14 Oct 2026 08:07:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, Jakub Grajciar <jgrajcia@cisco.com>, <stable@dpdk.org>
Subject: Re: [PATCH 1/6] net/memif: guard against empty Tx burst
Message-ID: <20261014080739.45ef24b5@phoenix.local>
In-Reply-To: <20261014091257.1051190-2-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
 <20261014091257.1051190-2-sriram.yagnaraman@ericsson.com>
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

On Wed, 14 Oct 2026 11:12:52 +0200
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> eth_memif_tx() reads bufs[0]->pool before any check on nb_pkts, to pick
> the mempool for its fast-path single-pool test. A caller that passes
> nb_pkts == 0 therefore dereferences bufs[0], which is out of bounds for
> an empty burst. Return early when there is nothing to transmit.
> 
> Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

Calling tx_burst with 0 packets is undefined. Ok to check but drivers
are not required.
