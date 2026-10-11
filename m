Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319ACA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC2AD40279;
	Sun, 11 Oct 2026 21:50:21 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id B386D4026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 21:50:20 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so329287b3a.2
 for <dev@dpdk.org>; Sun, 11 Oct 2026 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791748220;
 x=1792353020; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0LcrGKzbY6U5mLbMucv0iff3yZOxNz2KcW7ZwoHX4No=;
 b=FU2KuTxuKsMRBcn9ghr8lKXIhJpfnLTMFrikivixQEkFAt/nLdueLnghPS6UYDKW/M
 gG0OTnQ9dKaD+mhfQvyNT2wYevMRop5spnwmoFAqjzBcK04ibq/z1ugC7usCrGetrfh/
 OeUwPTEgPWfVeuTUPdirCyRJ5lvHcTFclqaQtMHT2R2oO/Z6G/l5PmLcjcEitt78hUxl
 gmoKyPDQ5xBQNZYL3PsnCbnCJIKqglifDs6YQKgjTeneZpnaOlsm5evriaejn+4f2YeR
 WcmyXeLPykZLpgEAhimCXihTLtdTd6wx1rqB+OGSay91dprwuR3b/dERgBT8V6N6EwI/
 kblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791748220; x=1792353020;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0LcrGKzbY6U5mLbMucv0iff3yZOxNz2KcW7ZwoHX4No=;
 b=rLx+lrXlQA6innwGX43vMw9Ei1bmZAkkG5hxqEpI7W9LC4LSgIxhEF+IYean+64Urh
 2c7vSZZx80m6XDH5+RR2Y6iT4qeasWc/nAyr0E9j8ZfhMZIUsIevKAiJre+EJl1ebnWM
 vtoFgPSF4YHnZY0437i2K4ApbFa/p6ZeUTMAYkMAHiU6k/p4WOIBQc1MPRujgoAzVkxv
 pJYeFFwwOEVDq4ZaRzXlz79jLyRjBQEXVVX/ATX8Am6wDRFKObBnoUG7GKvAOQvxS10M
 o3WoBwNLDJXVUe+VjlAHaJkO6M5wJ/WoWUuxXGn2fEPrCXuH5zcd2rvYqNhJ9VghcsRK
 GuUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuld6LWbFGvwxF0Ku8aTgs5abb9t5zHEm5YbggvQU1dTAyy4+KO0bU1vvRHs5r5XbWOBM=@dpdk.org
X-Gm-Message-State: AFq9FYKw+8+4oQhJX5oC3uT3jdSecaVWH69PnxBaF4oh2s88vKfpkusr
 ZvJsrAEkZ431XULRd5d5Xd25sccXzgHCo8JEPrWTUL3WGGAZ2EUVE2XkxeuE658gzLc=
X-Gm-Gg: AYBFou3tdeCK4MZzwJK+l3mVN1tGsmhAW1G5riWnVNnZJooqLztMmGlxuGVNZZAzW5k
 g6rLw8n/NdjyLygA3xdW3yFnSz/JafctzCk/BNkeT6BA5yGJDAvYp9csGC2PBrsRwFKzIzYbvha
 pfESxrUdw2uyzz87mMyYF5nAITpNJBwKDs3OoY2rlaKDCeke+lIDdGXC78MlUxkmhBAyYZrpapf
 bU6FR4EUWhbfb7XjwpFB1zLNao8lj2noOJJK2ijPGjKE5nJlh1Z9MMHJ5k/f6BBVfX0sIbQO7eV
 2logV/6e3KmBUE+OdSVt/T6QDebXiuIjRo1xU3a4XYC4g+uBs95PaQNWAcE+kE4SS3D17PRUMaG
 x5wH8eUqb6FekyYAzjaliFH3cYeGQ1wVwWuDxWFawakN7LBV04f3dw1WUeNSX0FW7MG4tqgsaSN
 n1jNQVh2KQd8VWC9+WFZVN23DOQcznH+EtOf6yLT1jjAeYbDlZFMRvju+5VE93GpmXak2/1aS1f
 y2dXfSnLuYe2A7I79f9JRcCYkiS6mVmBIOd2QNa/fWrpK1My/0=
X-Received: by 2002:a05:6a00:418a:b0:881:931c:cf56 with SMTP id
 d2e1a72fcca58-897c79dab6bmr6283825b3a.47.1791748219657; 
 Sun, 11 Oct 2026 12:50:19 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3107398sm3273361b3a.17.2026.10.11.12.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 12:50:18 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:50:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH 5/9] bpf: remove redundant memory barrier on unload
Message-ID: <20261011125016.15772f7c@phoenix.local>
In-Reply-To: <20261011182158.124246-6-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-6-qm2k21@gmail.com>
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

On Sun, 11 Oct 2026 18:21:53 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> In bpf_eth_cbi_unload(), rte_smp_mb() was called immediately before
> bpf_eth_cbi_wait(), which itself starts with rte_smp_mb().
> 
> Remove the redundant rte_smp_mb() call from bpf_eth_cbi_unload() and
> update the unload sequence diagram accordingly.
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>  lib/bpf/bpf_pkt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 7ee16cfa69..68671848e9 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -62,8 +62,6 @@
>   *     |                      |               |              |              |                |
>   *   rte_smp_mb()             |               |              |              |                |
>   *     |                      |               |              |              |                |
> - *   rte_smp_mb()             |               |              |              |                |
> - *     |                      |               |              |              |                |
>   *     +-if use is odd        |               |              |              | if cb not NULL-+
>   *     | |                    |               |              |              |              | |
>   *     | +------------ fetch odd ------------>|              |              |<-- execute --+ |
> @@ -502,7 +500,6 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
>  {
>  	/* mark this cbi as empty */
>  	bc->cb = NULL;
> -	rte_smp_mb();
>  
>  	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
>  	bpf_eth_cbi_wait(bc);

I think this already covered by:

https://patchwork.dpdk.org/project/dpdk/patch/20261008233649.1260843-2-stephen@networkplumber.org/
