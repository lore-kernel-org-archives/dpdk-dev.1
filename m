Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B020BCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 22:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22274026C;
	Wed, 20 Aug 2025 00:35:14 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 0C20F40151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 00:35:14 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1149so4264444f8f.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755642913;
 x=1756247713; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krTWkx/TkTLiPztuUfFSJrlL+PpfiBNALLNuznHUZDc=;
 b=tYjgcz92b0IJoFyWClujv/0/3tYgwxNYV7s0GEZmnUNFzYwj5lK+Cp5WVWsI/J/IBt
 tL48OoYay26KX/QkslZOl28pZw5QlWWbi+nRTCfaJXPDXDEkaBRITFctdLjbHPmD81oz
 HGur86LSh16pZk3njPRCYhV7KqBuFkAbY+OI/V8JWvh2DOMJ2Hhl8sbgWvbsPQRKqssj
 OEzMN3G6nV7mgqOQsIhLZDQ2tXekOJJwhmbHCyKzJm4riDKoUwqKXVR1Zll9eWQlWoau
 ic37N/tueYyrpSC9DP5AZPuvQWtdf0vC1FkAc2PzgiahsggqGqvA/VT3pKlyXyes8my4
 tmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755642913; x=1756247713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krTWkx/TkTLiPztuUfFSJrlL+PpfiBNALLNuznHUZDc=;
 b=CGkpZIxNOjUXg9+QoTwMEiXh4yflqATmSiXLilkPgKwdp/C8jsZlHY33sGuVnvbz12
 efvwj5rHJp8PAM218tq85rR6R1RSQYGBDPRsJUk21ahv/6owW6VU4ZjRttOr335wtRXD
 Jn5w1kkxtpLDtlwiIXV9e8alyplo/HO4w9KWUAATPkqJLKKpKzbwhYodyFwjm1dWo61j
 juhKdtUCobDowCJsTF3ue90apqDojJkhpEVCVaRFkDriS5Xhbd+us18fqA7f/oty1J/v
 fzWWEHlgojUksZ2pKfCDvXUbpJdLk4rwWlm77wSD4dOh/s5PyqpgFsEp9sM81nWLcwMb
 r2DQ==
X-Gm-Message-State: AOJu0YymLfyZwr02uTUaHAbp/1H8qJ4DECaDrck4S3gdHJ6QZX0+gxPz
 Ez3L8EeBQBWEfkNiHXWAC76LzvPJMvjZkEQSDGBOKoWsSZanpf+PJJ/496A30VaVJMhq8i5+rdy
 6WW0y
X-Gm-Gg: ASbGnctlhKJeIKtIKM6iP+pYjm4cRVweE8lE8lqummg1Rp3iHnSXtwcmYFgAROh41jD
 agdkDl9lUtTdGvRcYIIXJblTF2XMPK7nUk7C5Nlh0lsAHTZXh3ZRd9AYRjLQ4xue+ghnkCYPXrf
 Qb/mCfZgkOLcI3b56tZGcXJrzAbyndD8hJnevieZomjmbN3GapcDHYjcAtg4Xvsj2qE6y0/TLkG
 roi1buUNEsMrr93At+GgiXI8rCXhvMrlbBgTsFKYIDqjH5yyJkrgJVdm6QN8HOoy8NTFEq1yNSY
 was9X+fDObit+pnkcyV6MJteHczapgJJWzbxY+lYrFP2MpDdmnVksjHsUxRxXpOgKv2yv/HLW95
 Aso/Da+6qygBNqhPs3b3RpX3PJkgsOPEpTGADIgwkZHAZ2LCa45ldKgws2I9tu6JddTka6s7y/Y
 c=
X-Google-Smtp-Source: AGHT+IFQoXlfIX65SeZbMvUmNsXWdrPhpi+4USkcMkAgbql5w/R9/eZjvqVdJbc5kd8P2UTL8VQkTA==
X-Received: by 2002:a05:6000:402b:b0:3b9:13e4:966d with SMTP id
 ffacd0b85a97d-3c32eccde5dmr383952f8f.59.1755642913516; 
 Tue, 19 Aug 2025 15:35:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0771c1715sm5616344f8f.36.2025.08.19.15.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 15:35:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:35:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v5 12/17] net/nbl: add nbl device rxtx queue setup and
 release ops
Message-ID: <20250819153506.01d1bcee@hermes.local>
In-Reply-To: <20250819102237.3067518-13-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-13-dimon.zhao@nebula-matrix.com>
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

On Tue, 19 Aug 2025 03:22:32 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> -static int nbl_res_txrx_start_tx_ring(void *priv,
> -				      struct nbl_start_tx_ring_param *param,
> -				      u64 *dma_addr)
> +static inline u16 nbl_prep_tx_ehdr_leonis(void *priv, struct rte_mbuf *mbuf)
>  {

Get the prototype right in earlier patch.

And don't use void * to hide the private data. Instead always use a structure pointer.
That way you avoid potential type confusion bugs.
