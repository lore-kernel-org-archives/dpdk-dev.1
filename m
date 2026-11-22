Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A98606A683
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Z/dJMRs6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F39CF402E8;
	Sun, 22 Nov 2026 18:44:56 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 3EABF402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 18:44:56 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso1169802b3a.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795369494;
 x=1795974294; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1HCHp/RR52aViz6UHlOc2IQmJSKSssvOXa9WDBshOnM=;
 b=Z/dJMRs6+gBZ1QWswEIcD3dUM63vWbwjVXmjZecrcZ+ptwG6dGE6OB8OvGt9dDY91f
 sibYB1SoEEvPc3pG2PzyIs6sg4nMCUZ+4vDGXV4kPEyURgfZwiRYRXzRZmOxjLeDbwUy
 8m7oyHd2B+8yAWyW//l6egN3c3bjyu/+TzeQfRmMwqpgQuPCLLwV1AU2hPKv5Sq5P9h7
 HecBvmUvzA1Aprkb97852iF6M5ggm7NLb3CJ4rY+KDcwRMyCSb4kMZpPWRnhDK+ukR2B
 XIlLD5KgnWBYG4BQ61aRmhEqYrOjEq/r26C9aYi/70kqAxwiT74O+vEMMN0JtanwUBA4
 Ac3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795369494; x=1795974294;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1HCHp/RR52aViz6UHlOc2IQmJSKSssvOXa9WDBshOnM=;
 b=tDE/n5EOT4Mprfs60510cxVgIloZ0kyTU0wU+dfPdGUA61y9Wr/v7eSfkDGYVOEp19
 qNUhFkrWzby5c7pzoY9nMYUIWHj0dwDEaqWEXlpAGbGXxol/kpqadT3tD9KB1l8yXuZ7
 iVuv84h/y5brYljJPkYFY/b3Q+d/yrm4s7phrp7Uv5plRFX2w9OEjxafeUBGRD+qzzt5
 ghWo91JFGWzmXFDOD3UtPBySN49VWKb6vIp1dFfex+Oxak1F9DCJ0PTMwKxg2ppmyY3B
 dbq/fUkNIUdHlZC5rOmhlHhA/mD1yVQ9hBEudfPTCB2rrTI9f8yDG1FY3pPwmiZWQu9U
 gvUQ==
X-Gm-Message-State: APuU4Z+EG0280ykSTMWGo7q0t0L3DQmhK0lcJnx01vsuzsyKxeY4vn6W
 x1rl8cOFTxuLqPJ+id/oTBR0GXsaNvaSLYs94hPZgNsaHmR4xLZNe91SNGcSSgve5+s=
X-Gm-Gg: AZFdTZf1t4u0/3Eavq+YSNn+oEHYn8oSFCbN+v0T/SQlazJ3CQq6rWPOjNPG8WbQfF+
 nkrqZWmUb475AkQNh5x1W2j7Saxbcgzd6bz2LVhgpW+0IEMypBv6rn9Jo3iAAuYm5QaES8rY8yq
 /fnwQBFYNtiOJSkvS+hH5f/q3NbJzPT9UWpGNkmNgOz8fToi7hTIVI/mJwslW4cK3m9SRQtsvGp
 dO9kb6/nsPOTMkcPqZmU77Osg8PF8q6ztq9pluj1DgRovD13IczGLdYWkQie3ZPPZRw9ORQTjy4
 4QM0EBKPvZxTu5d3tfDr7/OOL7OEf6Kc7tR/YUZtelUNgY7GPVtXGF3t9qSWNhVRHXj0GmfLrxf
 +U/UCH3gWd7EEaB4XS9p5BpadH71e4XhCRFvKjqG5RfE6hr6xNzT6qo+PCbY5rcVXZCBHyLQhBF
 4FomFWf31aUy6SlMzribTrPP06miI/ZRD5aqx5NNxIp0u1OPaEspmpxc470POn7Gn8rVYdipz/r
 Z8/Uw74wFXWHxgfKeQMQtShXU+pTGAoKQjZGVl6Q5O2gSo0XTghyG7iIWLYMC2baRms0sydnOLw
 R9wsP+JWvcXO50+03loIE93PM2DBjJRt6WdUNcQv8O7e54lq4Nil2UlWkk21pbET2Mr2syI=
X-Received: by 2002:a05:6a00:409a:b0:855:eb7b:5804 with SMTP id
 d2e1a72fcca58-8c8794b8c36mr7069685b3a.4.1795369494500; 
 Sun, 22 Nov 2026 09:44:54 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87343f83dsm4195541b3a.39.2026.11.22.09.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 09:44:54 -0800 (PST)
Date: Sun, 22 Nov 2026 09:44:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH] app/test-pmd: use burst IO for IEEE1588 forwarding
Message-ID: <20261122094451.5907535e@phoenix.local>
In-Reply-To: <20261118151155.2740034-1-bruce.richardson@intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
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

On Wed, 18 Nov 2026 15:11:55 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The IEEE1588 forwarder in test-pmd read a single packet at a time rather
> than using the burst size configuration parameter. This meant that it
> cannot be used with vector driver paths which require a minimum burst
> size for calling the Rx function.
> 
> Make the forwarding function respect the configured burst size and only
> process packets one at a time, not Rx them one-at-a-time.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

More detailed AI review had pre-existing observation.

Subject: Re: [PATCH] app/test-pmd: use burst IO for IEEE1588 forwarding

Applies cleanly to main. Rx path change is correct; Tx drop path still
frees the mbuf via common_fwd_stream_transmit().

Info

ieee1588_packet_fwd() returns true only if at least one packet was
forwarded. Other engines (macfwd, iofwd) return true whenever
nb_rx > 0, so busy-cycle accounting counts a burst of rejected
packets as idle here. This matches the old single-packet behaviour,
but with bursts it is simpler to follow the other engines:

	nb_rx = common_fwd_stream_receive(fs, pkts_burst,
					  nb_pkt_per_burst);
	for (i = 0; i < nb_rx; i++)
		ieee1588_process_packet(fs, pkts_burst[i]);

	return nb_rx > 0;

ieee1588_process_packet() could then return void.
