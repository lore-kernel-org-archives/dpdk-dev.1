Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D43C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC23E402CC;
	Tue, 22 Jul 2025 05:46:28 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id AB724402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:46:27 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7e34399cdb2so541180585a.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753155987;
 x=1753760787; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cXGJ1CVy12YCOn5qavGlJ12jHDKV5S+a5PqejsHGeM=;
 b=0PEXFcPpJ6JKhQ1MYTRdeLzwWNIBBFgHiP7HG85MJGkyRPlZQQnqJRUVzGQWTtvKkF
 zVOZluSLQ6A9Qks79dfp5KMlOs0DbL2P0llGjLQNa2DJqkbH8omkNiRZwGHD/2sFHSbM
 A44JZKsG5ArEEhChzwLFnav0ojX2t3069DL7H7f6bieiJ2Myjw+G1WksKHpcLGAj1jTm
 4hRlDHmL6nj/JD6yum+xw2K3HXkrSuda54orJUkPEg6q3+SHze3vz1v+7FGANdOF+J3a
 c19IVXwNwqjf9zCNOYq9l8X3vuCExw0R2dAPlzELtpe9KAHJK6iLB+Jj2NwbYi60yulO
 t4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753155987; x=1753760787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cXGJ1CVy12YCOn5qavGlJ12jHDKV5S+a5PqejsHGeM=;
 b=mAN9yszWNAnCuf+f0UoqABc+ZISpIqsxlw+jHA2qnQ0JrDzsieupADalk6M1rRYAxY
 8La8eUXLSlAtvtLmcB+8/6JEnRY6iRVd78vUKPuiWXjnSmENtr4e/ikPHHY5AL6XmjQ2
 Om+QTXim0Kf0H9cGkuwXL8/vFN3Ef1SP02tDntAeOTSqzd3bDadtW0495798YjWAYbdm
 D/sdWctegmRsQtD8NflCIZI9fGIk5dfxrM7soNqIbxe7qaBYhL4A1MoVsXeU0eTsrBUn
 n/hIum+DZ0vKoz+JTzeCeK2IHTXeRqQmqBYvd3HTdd5RRVqU4lK7Fws6F4+Ht0/7cISK
 5bGg==
X-Gm-Message-State: AOJu0Yygl0NHVXOUVJdnjFw2DtMIO9qb9CCx11WEs+iPGH/DltjNjoCb
 NM15mThoMDjgoXGnRwT048LK2jnkrHJ2nY/uchy+qnwggrJMV2MVr760XJOmjQGGlAjncriL7W/
 mk8fV
X-Gm-Gg: ASbGncvu1YqInYwj0S4xmF+/hhh6hUXgeYxg4rn1ibC4t/kqs1uGBP3bsC8/PxkIfpy
 UbaZeHnkIllr2SCD93s8lGVNA/8vEJfWBykhSWUuzpy61maS9Y6dWJ6duT/ZeIX5qYH1tFuzQNx
 /pSBDQe2qj0b6WkN/tzrVMVHd9PCoDGXoh9zSnOk57mkmrtZqpWxX4bUHX6wTdngmvX7PnvHXvO
 3iRYBcxBOUhBRGfLi0p8AYpJFJTfNvYGhks7XOBVwTCeUqQOUB60nQuiJI7dprsrO3kT1t/oZc9
 GCVa5JhVigqgmkCDezLocCxnklnZgibK0vn2kQeyH6kbhUO78kDI+BBUUB45Kmt7Mk5Mo5vxcBT
 iG9iEVdIZe0jw3A9TTf89uruVxC5/F5qeWtghXjWFRcziqwZXSLDjmh4GdrImKurBE4uPr5gD7v
 o=
X-Google-Smtp-Source: AGHT+IG9HQSAA9LQEfnh92RSqORuOtcHAMx4wpKmaWAKCoFHEUGAfBxHXVMFUmmYEa+WiGdx8SeDGg==
X-Received: by 2002:a05:620a:1b8a:b0:7dc:7b5c:f02e with SMTP id
 af79cd13be357-7e342b6f800mr3007545885a.46.1753155986730; 
 Mon, 21 Jul 2025 20:46:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm486870085a.14.2025.07.21.20.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:46:26 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:46:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/7] net/gve: Tx datapath fixes for GVE DQO
Message-ID: <20250721204623.2b972435@hermes.local>
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
References: <20250707231812.1937260-1-joshwash@google.com>
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

On Mon,  7 Jul 2025 16:18:04 -0700
Joshua Washington <joshwash@google.com> wrote:

> There are a number of consistency errors with the DQO Tx datapath, which
> this series aims to address. These changes should make the driver much
> more resilient against edge case and malformed packets overall.
> 
> Joshua Washington (7):
>   net/gve: send whole packet when mbuf is large
>   net/gve: clean when there are insufficient Tx descs
>   net/gve: don't write zero-length descriptors
>   net/gve: validate Tx packet before sending
>   net/gve: add DQO Tx descriptor limit
>   net/gve: fix DQO TSO descriptor limit
>   net/gve: clear DQO Tx descriptors before writing
> 
>  .mailmap                     |   1 +
>  drivers/net/gve/gve_ethdev.c |   1 +
>  drivers/net/gve/gve_ethdev.h |   1 +
>  drivers/net/gve/gve_tx_dqo.c | 164 ++++++++++++++++++++++++++++++-----
>  4 files changed, 143 insertions(+), 24 deletions(-)
> 

Queued to next-net for 25.11
