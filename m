Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F6606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a+vET2hw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 953D4402D5;
	Sun, 22 Nov 2026 19:06:37 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C3F4402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 19:06:36 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3b08cf16decso1392091a91.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795370794;
 x=1795975594; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D6jQgCH6AjaJ/Q5mnCHUTg8FN0IVdIr8W9oA6PcWUOs=;
 b=a+vET2hw+dOzMZ6ThPVYZ6utpjnMbteSd91/UvMpjo//1aBGs4kjefeG4GCSuowTzk
 SNL9ELIcx5oWt/pgKu0AA22doeh98cQL+7tYCapctio9OWePttErquzwbyOyawv6AiIC
 Nkpw1vLKWl2fnwnrFvVZNpCDu5Ol9pSBC67xmlBup4b39KysARFusRoxr4iFKRABBxYw
 wocmI20p0TuxZasypjUxM1v4fYHMiWxY2WGFMPqFXBK5TSmvhbnZrdzfTpBdoPI4HFHM
 R9IlyQdpRHv7Z090Ao1/k4tDhJ4DxYzLV8ragiFIl7YMNsSHsa14gDkuz1sRlAfVQ+Qj
 eOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795370794; x=1795975594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D6jQgCH6AjaJ/Q5mnCHUTg8FN0IVdIr8W9oA6PcWUOs=;
 b=phkrhirPxjEyAAE/xVt3RyBPjK/XhDb1EMEWCD8nuAMvdKm9xMFYLTc9UUhTkD26oN
 evAZqkMxc7NhfImI9N4ytQ1Keey3rZ1Uuw1/RfosZGh/R7VtXncUhguN66j40s9JjVHE
 XGuwArfA4e7kcrRTCMwEssRyA4fe1ucwqww01F8vh1+4RrhoWmJ2+POYqYDXV2JP7vJu
 li/H13kz/nFCrFBnVF+L9RELhddLJnwJE/tfSRoDCFLdNx9GelZSfG8OdbPr6ylX4fE1
 H2z/YR371yat+cwabxNbN5PirhWek6JkfTE3HHL2+jat3L7pqjFSl/FGqcc0FTK9yiZX
 kWFg==
X-Gm-Message-State: APuU4Z/IxdsqsSmofB4IVL7UH+Dg42tLo5SoYP0xnQs1aAUg/IXLbnfd
 Oxfpt1Pdw7ILfW+r7lyuXBVCfbQmeoHkCJxO4Ua9RxvcVcfyV0YnQxL6Klx1FSRkVuiKMhIqxRD
 mcbFsu0c=
X-Gm-Gg: AZFdTZcCMyZgExvt/en/S8KMeYX5vCictaHmciY56JKXKJ2da/Hua13nwfFQDZ2oZpm
 jFLAqbm+ZzUg+mfnsUVPAAGxvHCVItVWKvSmvZf22GZ280rmwQ9KLgfphlFH5tpE/gj0vRA5TQs
 t4dF/RXRasMoqYaB8HBCc0EnGCLuZJc+RZtr3IK6M2cJCzXGw4oOa7gxrwcJAt+jwz96rJo2M1T
 B1k8BwyljgQ6qFYlD6fyy7FtWXX38z0bacUOrZEcZTHT/8KyVp/LLxze5aubutgY3k5T5+1JcvR
 cWRNIVyjh2xowNOn6L7bkMil4Zn4+tTnaqIz21z2SxNtGvQ7v4zBje99HUYuk+Hv5WTeb4fyyX/
 nLNNVPiLAdFvA1vBKmnIQdHfJ7mozXY/jzm5joqcxosj8GvV5H/Gii35NGLqscu5UhsHf+qQkfq
 /OwTVuMIbeKOzvEYWoaEJBmo2b6wnfVJcqlnMiKRVfvHnbnOjnNIyBQeJWv+JXtS1zXh0nIIUbv
 55D462iANs3uEIwJ0WsSlGGh+TihDeLmx0l2kP2EX/XGI+TNE7ghWjgqCYk/7EOpujoPHb3e8I1
 jNXT3zIQW4qaAwzFR59zmPwU/WZLbc/fiMgSU2eBLw2DUunHI97hebMSGxYFYEYNCEmCKwji
X-Received: by 2002:a17:90b:4b85:b0:3b0:96b4:ceb7 with SMTP id
 98e67ed59e1d1-3b41c7c2384mr8942510a91.8.1795370794340; 
 Sun, 22 Nov 2026 10:06:34 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ecbd0bsm16792227a91.15.2026.11.22.10.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 10:06:34 -0800 (PST)
Date: Sun, 22 Nov 2026 10:06:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: Re: [PATCH v2] net/pcap: fix handling of transmit errors
Message-ID: <20261122100632.2c599577@phoenix.local>
In-Reply-To: <20261117183240.852179-1-stephen@networkplumber.org>
References: <20261116232834.1190655-1-stephen@networkplumber.org>
 <20261117183240.852179-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 10:32:12 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The pcap PMD assumed every pcap_sendpacket() failure was back
> pressure and stopped the burst. A hard error such as EMSGSIZE or
> ENETDOWN caused the same mbuf to be returned to the caller on every
> burst, stalling the queue.
> 
> Only treat EAGAIN (socket send buffer full) as back pressure.
> Drop and count the packet on any other error, including ENOBUFS
> which means the packet was already dropped by the qdisc.
> 
> Use PMD_TX_LOG for the error message, as other errors in the Tx burst path do.
> 
> Bugzilla ID: 2132
> Fixes: cf91cce204ea ("net/pcap: fix error accounting and backpressure on Tx")
> Cc: stable@dpdk.org
> 
> Reported-by: Anthropic OSS scanner (ANT-2026-DLCI8IK6)
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Fixed up complaints about comments from AI and applied to next-net
