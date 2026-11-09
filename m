Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619D606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=i7CWujCs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBE1D40B9A;
	Mon,  9 Nov 2026 19:36:14 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTPS id B5C104028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 19:36:11 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so430257a12.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794249370;
 x=1794854170; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7wauiLHfBBu2raM4g0cZlIrMdkGM7cAOFI6tLJI2Nw=;
 b=i7CWujCsqyEYnfRSNk+JJb8AH48TlywzQ66xKAZnBRcbfMqX/+zE3FuCqNUmoqHcpi
 NEKCOmsOBeiljOBx58UtRDd9jv5uRpKjeIGeH0Yvo9Wpz72Iphr0qhbAcCBOaUc5GJMY
 H6oPI5BUEYP1GqqMnQP4mU/VcGpv71aIp1YDE++/9t7Ahj9KQY4gfFYDqKUA6h95NPXv
 s+E/cpC4ukdaK+wvUKSANpWa1ytt9qpyOoPa3bPF/mVWZqEvjk+lN47M2+nXjAQpt9k2
 NJOYm9q8FApORTqQzPhHyMlM8OjGusRP7g/t22bIVF4mVn3N24DmAh+uZgJr5MsbnogC
 LFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794249370; x=1794854170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7wauiLHfBBu2raM4g0cZlIrMdkGM7cAOFI6tLJI2Nw=;
 b=c78OJBAF1TFa3lNe+JO1iXd884+vPixcFcgN4HA6W0BU/Oy87qGsQCsQpVmF+Ac6Ma
 SpYK/TWSVM3dyk9Mh8+qI/fbPW1apXPZ+UORdi1W+9dCr4EjIIj6IAwNRSgVBGcwSsGh
 pVQGRWeGifsZ4Ra3z6ePtDQMErdAvtUHpbbKfjPiK/O83Jtm+9Q2BvFnuuyRGPghQfFY
 0IC1GuFE4tEmcbY2fV5E/tYJ/pIUc1X2FBHF/O+dWawNwuCtDa4ldC3F8PCU7qL6gE5S
 //fD5OeoTV4cQeYamHdgcvKyeq+ref3eqhbrZsvJfDZdDYScr9wXSJuYEVODjHeINuux
 KA+Q==
X-Gm-Message-State: APuU4Z+xKOJCHu/89bhrsSX6TY8C7yPcriKR2nfXxMQIgWJPhFX62ULd
 91MHtqhlqSa33ymW5tqUYbTMqctDAFzaCJsSGR2yZHn2GCl96vwiUygY0fwqhrR/y6o=
X-Gm-Gg: AYBFou2m5ky5tB4s/Q2rmdRKw4K81Xpm4IM+cmroNne3SrwrgHFYhF9MWDfDSRH8Sr2
 KLQ1eGjaOsGOOvftKXYSlFA0nboeGsWCzN7NGetr3/v4xHC+z5+//cp/CZAVu08uzHHiQ9oR/c8
 TNgJYo1umAe9rzhTVDVRio8346j9oBYyLIsE08ThcdQhcAug3hyBy15Ze/TEZGmvj8LeTkF9a6N
 S8ZHfUf6iTd4W5jc+w6Hlwwwv9AklF6yOYGAnnVhx4HB0FaspB9MM1hnENhKrH2xcQZsYXBGmU4
 fAjXahtANhhSKk+8GxPSbYUiwMUnJEmEerXQKQ7tetwI5oR2V02RCIQhR15x2UrFEhZQ0IsEc2f
 /b3KPO6AS/gO3/v9TsA62CxDn/wYsneH3VvE0JlZzOGSia3F9h8Gn5fz3/S1ceg2DpzGwFZ2FqQ
 h86ugmCq0cyeF4Bs5bAL1Mo03Svk2uEulqdoVX9HUuvBT3OhZXZFFqYXvRCFG7NcqB16qch2nNP
 hwePkWbwC6MJCGtnu44qLWb1/g2Lfjz4/rO6bKxmWnJaG3zes61aPVvfY5sEhSyh76mSj3DMUsk
 RYZHYsqk4NCIB3EQQvpV8BJKwCiatiEPS5vqmuu8elE5RarGBSiGlthjEtTofwpZ3fomftSr
X-Received: by 2002:a17:90b:562d:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3b166b218camr486521a91.9.1794249369887; 
 Mon, 09 Nov 2026 10:36:09 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b16797069bsm468053a91.14.2026.11.09.10.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:36:09 -0800 (PST)
Date: Mon, 9 Nov 2026 10:36:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <haijie1@huawei.com>,
 <rasland@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: fix VXLAN-GPE and GENEVE custom port parsing
Message-ID: <20261109103607.54d26e40@phoenix.local>
In-Reply-To: <20261105073110.3643780-1-mkashani@nvidia.com>
References: <20261105073110.3643780-1-mkashani@nvidia.com>
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

On Thu, 5 Nov 2026 09:31:10 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> The csum forwarding engine parses packets with rte_net_get_ptype(),
> which recognizes VXLAN-GPE and GENEVE tunnels only on their default UDP
> ports. Since the switch to that API, --vxlan-gpe-port and
> --geneve-parsed-port no longer take effect: a packet whose outer UDP
> destination port matches a configured non-default port is not detected
> as a tunnel, so tunnel Tx flags, outer checksum handling and tunnel TSO
> are skipped.
> 
> When parse-tunnel is enabled and the outer UDP port matches one of those
> options, temporarily present the corresponding default port to
> rte_net_get_ptype() and restore the original port afterwards. This reuses
> the existing parser without a new library API. Plain VXLAN is unchanged:
> the csum engine has always recognized it only on RTE_VXLAN_DEFAULT_PORT,
> and rx_vxlan_port configures the device filter rather than this parser.
> 
> Only process inner checksums when the parser identified an inner IP
> header and all declared inner headers fit in the packet. This preserves
> tunnel forwarding for valid non-IP payloads and avoids accessing
> truncated inner headers on both default and configured tunnel ports.
> 
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

AI review (run manually with claude) sees a problem here.

Subject: Re: [PATCH] app/testpmd: fix VXLAN-GPE and GENEVE custom port parsing

Applied to main (v26.11-rc2), testpmd builds with -Dwerror=true.
Fixes: tag checked, 76730c7b9b5a is in v25.03, so Cc stable is right.

Warning

can_process_inner_headers() checks the wrong length:

	return rte_pktmbuf_pkt_len(m) >= headers_len;

Everything after this check reaches the inner headers through a pointer
into the first segment. l3_hdr is built from eth_hdr (mtod), and
process_inner_cksums() then reads and writes ipv4_hdr->hdr_checksum and
udp_hdr->dgram_cksum through it. For a multi-segment mbuf (scatter Rx)
whose first segment ends inside the inner headers, pkt_len passes and
the access still runs past the segment's data. The commit message says
this avoids accessing truncated inner headers. That is only true if
the check matches how the headers are accessed:

	return rte_pktmbuf_data_len(m) >= headers_len;

Info

parse_tunnel_udp_custom_port() runs for every non-tunnel UDP packet
when parse-tunnel is on, even when both ports are at their defaults.
It only returns after it reads the UDP header. Bail out first:

	if (vxlan_gpe_udp_port == RTE_VXLAN_GPE_DEFAULT_PORT &&
	    geneve_udp_port == RTE_GENEVE_DEFAULT_PORT)
		return ptype;

Before 76730c7b9b5a, --geneve-parsed-port replaced 6081 (old
parse_geneve() compared against geneve_udp_port only), and run_app.rst
still says it "sets" the port. With this patch, 6081 is still parsed
as GENEVE in addition to the configured port. The same applies to
--vxlan-gpe-port and 4790. If additive is intended, update the
run_app.rst text to say so.

Review-Result: WARNING
