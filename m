Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183EAC369C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E156410D5;
	Wed, 16 Apr 2025 18:38:48 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0503D40F35
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:38:45 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22c33ac23edso12137825ad.0
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821525;
 x=1745426325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cNjBeidnNhyNYn1ML6S6pVYrue8vDheyYSd7rbxbDI=;
 b=c4ixjOeBDVcRDnM1YvjfvLhs6AThZgYYDLxEKQMuht5CsZZRfzSeLu5pPuY6r6jVZY
 nXZxfRaB1n7GcCkxCBo3I2Z6tnyBhs6ijhy+TU0q9Xk+84RJ8kRYp/te9QsqVsAidGfa
 IvqQiZk9oRIXTHj4WypwinSC8mpiQiha8LfO9kfBA1ncdhc19FlnpjMYysS8DLAabP0P
 kxfFA2DSXuAMSKB/nLQxop6coizDGTy49K07hVGHYCC/5biAPDJuGDj2nHFLYlAu2yb0
 LBxmaOxTvYjKluyTgTzUFJ/9mckvigRJxpeifAvybWa9z+JStQGgZkT1lAyYEWorSRID
 u3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821525; x=1745426325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cNjBeidnNhyNYn1ML6S6pVYrue8vDheyYSd7rbxbDI=;
 b=OwNDcNQ6yyTmpEWKxoeRwLNdy44yP0unGgKTGfC9fwJZHeKpOdEaKQNg9xEp1fmQkn
 WqH8qnXclnxR0uSQYBkD/fPrOISyGyc2g8veGgayVFleg6QPs/sEu96b2HjoH1c8IpuE
 VJ1t8U7krMxjIrs5Xu0S6Skrsb20vbLk8LNurTPboL9s28roftMIzOQstvRz1TEbDHYt
 hwKD5gVv6/mZVQazmyWzcB+mi5kN1QudAefwEwy3SK6Bl3vToTVgspJkEVDGdT97bhm9
 iqDGuuQxaa5Ti6HtXxqZqQGgu/My+5bWGDk1JDkNDJuiJlSmyc0YWiunVDPSiRI1t87m
 8HNA==
X-Gm-Message-State: AOJu0YzWbx0oMJspoyZTiTJalArZtEXxmUxv3smURyq8qsAOD0O6ulSD
 SsuErv3dWujUR392OXyZz0kgTviu9bEDx40o3F7BXMJE7M3yiegxO3Gy1QwdXT+jHGWmT8zVTPf
 9Smo=
X-Gm-Gg: ASbGnct292xyvCH84Nv0QqRtcsczofUKzpL475eTV/sUY/m81CF0XaJyTNREbfellEG
 exyLl1MTmiry9z78SQevXifgcvtor3SBYRHL6PD2BRew7OOF2qR8DBKLOgQ4O0tFzoJ1siPgiSV
 fcEvjD9PUY5pkowNhAi02lTeRc6WincjxsNAARIeOaAYDmQ4iLRZF7hoX4gmO7/kDsgjMOdr+2Q
 xaC6JZFZqmO9fHiwWian5EWU+/POclkjkQNCZNwJmsT4i3/ca7fG2rQIEF6Sxe0C5fnjwB7iKX2
 RNZjpIVH43PcUU78Nb8FL6M9y7WFcE5JFiPeWAaw8be+07aF542qLEVnWLAkeZyeG/u36Msqce2
 NitvgEe3S1ZyPGgvW
X-Google-Smtp-Source: AGHT+IFjGhAXJXHfTGCwbPoksGAyJSBhMvrYLM+mzX77S82ntZgoQgt3Yryr/bVg5w2l9cXmGXXh1Q==
X-Received: by 2002:a17:902:ebc3:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22c3596d747mr43312305ad.36.1744821525082; 
 Wed, 16 Apr 2025 09:38:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d414sm16413885ad.56.2025.04.16.09.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:38:44 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:34:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 2/4] net/macb: add new poll mode driver
Message-ID: <20250416093402.0dd1609e@hermes.local>
In-Reply-To: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:58:56 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> +
> +struct __rte_cache_aligned macb_rx_queue_stats {
> +	union {
> +		unsigned long first;
> +		unsigned long rx_packets;
> +	};
> +	unsigned long rx_bytes;
> +	unsigned long rx_dropped;
> +};
> +
> +struct __rte_cache_aligned macb_tx_queue_stats {
> +	unsigned long tx_packets;
> +	unsigned long tx_bytes;
> +	unsigned long tx_dropped;
> +	unsigned long tx_start_packets;
> +	unsigned long tx_start_bytes;
> +};
> +

Doesn't really matter, but most drivers use uint64_t for stats.
