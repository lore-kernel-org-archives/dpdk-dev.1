Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9912DE7DF08
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92CEC4027D;
	Mon,  2 Feb 2026 18:00:51 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 231374026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:00:50 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso22225935e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770051649;
 x=1770656449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oj/PdaxQdJIM4XfpgozjGWn1p50X72qbUN2EcZjx8o=;
 b=ogREFTf2Aum2LgCRXmV9lAKIG/2oPQqG+g7Mkbd6jRnZCFey+Ev/YohqhCTiSOXl4+
 ZUNdLxLtS1Arh4jrLZdZ7+B8/w8PU7/J5jF+JbvqRGH9UWWnAIS2aMIQU2JXEZ+WJmhy
 zjLn4xE7zRtcsA7yCCHNd+Zp3q9oxvDg6ZYNqe7SKsiKyZBmUEavVl4HDmqFaewd0Kgo
 zSwwKorcZiCPHKEtrmI7/oz56dIMtIl1AJi7rEUaU5A6GH+5gHTFhjRe7Dhfhrulstvc
 snrgu4gZNtHymPam+uz5mIuF9dyex18yy5v955ywusZ7QuvusZIn22+ahFy8ibkQXiGr
 r1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770051649; x=1770656449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3oj/PdaxQdJIM4XfpgozjGWn1p50X72qbUN2EcZjx8o=;
 b=nN8xqFo3eoUserPnAKfYf3DHvaYfH3YQVXzjzWicYbP1uCifFW3gTsdGki27h6p4hQ
 G1GnJ6Vd0620qplLR15hy5eWqenN/7rQwbgM60sMM6GsMlNzLjxaDn+wDr015K7oxf2n
 LgNW+gx8UElr/DKnuLJOFzn9kfnBQZmEIxnfN+bkjtfC2zddMKrYQ9QoU0kTY9OUHh9N
 Pz+BsZSnxw3XgOTLP0Jb4YZVfDUCzqa/UKd2IvNh+q2rvOyVNuVyxnI/BNFiwnx+FS41
 WtPK/81SLIdrgHhy91t1PP5zDGQQHgFb9pPImSkVrEG5C9mpqE63UfCyxEd3h01ZKSto
 jRYQ==
X-Gm-Message-State: AOJu0YwJCHdqK0ICgdyEcc2aK8Clt40FtNdlz9eFpgr4bIi5+rEkaE1w
 GXDAAIMc3ZEKTdXqVy2cWi4J8IvalxWCPaI0s51eZe/b4Ch/LdIM6Kx1/GwC1Yh3HDQ=
X-Gm-Gg: AZuq6aI1zdpTxpT4WY1itgCBQN56K8D/IIxMY467iL8NY2p1GG4mzvMmJJkkh9KhTmh
 0uqLxHYJ3VGwnim5NVP7ivWsFkkckDomnGnYcYjE189b8LD049+KrzCrKxCMfi0PyOhjDLeVdYG
 beL2Pe8zlNbIpel7zQa1VTDA7yoDQuvKDWZJrkyM3llnVn3BdvARmfNjUN/R0WR1r9aB3DPordB
 BQkwKme7c69OKk5AmNGYj3xauLuhebdj4x4zQp2ecPwRRasBtVrD6aAIFhg7q1zK2nlfFCGQ26o
 g71QLnTlO8CbBxpHUxsgTp7p7HxSloDDt9iMxgxO5dI7Ptq0HdPoCbV25bzEGeByMPLUrfTYlNE
 O3O3+K0a2OnEhjWpbjvjWutEFtuf6SCv7WnXp4WqlRjLFeorGlAduXZeq+6Yqy+0AEMi7qhx/+f
 8FxCQGuG6fNEM4bgaWcawj3j27CHajYlac8cDi8Avw9OSU2bHtcGV1
X-Received: by 2002:a05:600c:1549:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-482db4e3054mr158597125e9.25.1770051649412; 
 Mon, 02 Feb 2026 09:00:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051247ebsm1933405e9.4.2026.02.02.09.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:00:49 -0800 (PST)
Date: Mon, 2 Feb 2026 09:00:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 4/4] net/af_packet: add software checksum offload
 support
Message-ID: <20260202090044.0b45b438@phoenix.local>
In-Reply-To: <20260202081456.4322-5-scott.k.mitch1@gmail.com>
References: <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260202081456.4322-5-scott.k.mitch1@gmail.com>
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

On Mon,  2 Feb 2026 00:14:56 -0800
scott.k.mitch1@gmail.com wrote:

> +	if (copy) {
> +		/*
> +		 * Copy headers to new segment to handle indirect mbufs.
> +		 * This ensures we can safely modify checksums without
> +		 * corrupting shared/read-only data.
> +		 */
> +		struct rte_mbuf *seg = rte_pktmbuf_copy(mbuf, mbuf->pool, 0, hdrlens);
> +		if (!seg)
> +			return NULL;
> +
> +		rte_pktmbuf_adj(mbuf, hdrlens);
> +		rte_pktmbuf_chain(seg, mbuf);
> +		mbuf = seg;
> +	} else if (unlikely(!RTE_MBUF_DIRECT(mbuf) || rte_mbuf_refcnt_read(mbuf) > 1))
> +		return NULL;

Maybe just rte_pkmbuf_read() helper that already handles the case of getting
the header if needed.
