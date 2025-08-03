Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F1EC87FCA
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 16:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 080B84026C;
	Sun,  3 Aug 2025 18:43:04 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 7F126400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 18:43:01 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3b8db5e9b35so943216f8f.1
 for <dev@dpdk.org>; Sun, 03 Aug 2025 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754239381;
 x=1754844181; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lytqk2jv4rm7lvmiiV8bhK03c2YWzN1Pq5xpNaD1EXE=;
 b=sUAG1rpmUC6lxsNYf/m4nq1XYqXRRHBjg9EA3XLVhVUwHj7XPjOt1Tdg9zEoo7sWzV
 2C//EA54MGRIH3KzTrexhfprb0GV1twWBn0NtliJKeiF1LDtuoO3SrgV9KuBNDN0Ou1u
 hOFVIw3lkxQ8518TG1pKYipaecTqaLGQpNmL2fRzZ+7bXU3xHAxgCpUv+cYWXVzEt8XS
 O+XcKhOKKO4CDZxJ14Ez4hn1qLgsodY9ocBHnk2UhKbuLxHwlOl7iZRHYILIfNovMgbg
 77iPfUGbMqelt+g7vhxRaP04By6KihO5b4WAOx9r3D0LU4HfscNPQ+IOj/6Omp1aTaxQ
 GffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754239381; x=1754844181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lytqk2jv4rm7lvmiiV8bhK03c2YWzN1Pq5xpNaD1EXE=;
 b=KP3YTASuQekGTSgxc5u+bgI776sVBY8JGYW+sLU7BwiA1+zYK67UAaCX8FMnWj0EeZ
 KumGoWLHqBsz9rK00H1kRGe6jT19TtYHxWvZQIaLr162AFjCETRT0Qa6rFSOD8mB3pfN
 aLPk1Bxp3JCGFO3c09DgpFS8UG6vuz9ARgdfjZjSK5LycXI0RM0UNot0pqwtSAagQaWn
 f0/GBGfJwOsl2x9fWyRL4PoEgyUEB1DtLwei65QqZYgOzQ2p+qSp2gNfgmYQL5cD8+wR
 GLN9wzGJMQ56kGLTo34LJxkH7nqAfSHx7r87zrkhD3ngjUW05JYse9FKshmU038N5oS4
 oZnA==
X-Gm-Message-State: AOJu0YzkBhCcOeSl7I+GQ7fECJL8r6vFqRTiv0A9OYGn7hb+hjNvFMDw
 RicaUDyvHJ2AwFjEnfiY9s1MiMOjLeDpOVMCKxjRlGshnWrnoitG40zfseWSwZ3UfmUHaOBNQH3
 H/2Tk
X-Gm-Gg: ASbGncss44dYIg9rvl17GQYOVdzsGEjXM93nbGjlk11a8LohBKJ1UsgpHsDcjsTmXu8
 Zy4Uuhcu248yZ7SotoV9eyws8VhYurMVEihznk6qwJiZ08B2zVtR2YV27W3QrX+j5hgvmHlbthx
 pn8+pOFuBLdyQC8DJ3RNS/JCNmdAp4TIBwxkN9ym4b3edECSRfl9Ry0zNG6q5zGkJ9LnIYmsOmH
 5UEN8MBwLV4xAVAQ2wrh0dkJ1YWXeGrXDXxs+MQz0SWLT0/OOrlC2SIYFm0xJdhGzgfZIEmieZT
 OsIJyNjbH5vMT/GFntsCtc/HOKyc7MfCuCyj61q/B2vu34kc61WfuzJvdRapwJ4jibIRp0hyhyS
 G3RWEItksq4SX+e0KQrzt1Qqj2zjCtw3VWL4OpzPV9jK17VM7YtBqKFRbq6Fra6021H90mhocv4
 k=
X-Google-Smtp-Source: AGHT+IE9Nhi+IzdSou+Ub8bio7W430Y5KfOxp5FxAiOlOCa9QCPmcqTgdSlI+vP1hxV2G3ubo53B9w==
X-Received: by 2002:a05:6000:1445:b0:3b7:9477:f4ad with SMTP id
 ffacd0b85a97d-3b8d94b9f95mr4672861f8f.36.1754239381000; 
 Sun, 03 Aug 2025 09:43:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee4f089sm146242375e9.20.2025.08.03.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 09:43:00 -0700 (PDT)
Date: Sun, 3 Aug 2025 09:42:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang
 <jianwang@trustnetic.com>
Subject: Re: [PATCH v3 04/15] net/txgbe: add basic link configuration for
 Amber-Lite NICs
Message-ID: <20250803094255.18afa192@hermes.local>
In-Reply-To: <20250626080221.22488-5-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-5-zaiyuwang@trustnetic.com>
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

On Thu, 26 Jun 2025 16:02:09 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> Due to Amber-Lite's significant differences from our 10G NICs, we split
> link configuration components (setup_link, check_link, etc.) into new
> files.
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

This does not apply cleanly to current main (or next-net) branch.
Looks like there is some fuzz (file offset) changes.

Rather than me trying to fix, and potentially breaking the driver;
please resubmit.
