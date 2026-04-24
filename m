Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B35FED3F0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 16:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1CD0402B0;
	Fri, 24 Apr 2026 18:19:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B0A040274
 for <dev@dpdk.org>; Fri, 24 Apr 2026 18:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777047540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x5agusTy6k83H1uYzuhJV1mE9WppNK+7xb50IuK46Qs=;
 b=EcwuVwol9dKMpMJZ3FgxLeA2+vYUq9eBnm8gloA0+u/NGl7X7xSlixID6NpzUdCD2kWHJV
 s3SK+sEvnIzdcVZv77HIQAAgzS7UVsGE/91v91H8B+KVEOoLlt2osHJUTQJjs7XcaoUQYC
 vdxoSvga8wA5mTwkomR2/0o8WRJfI0c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-LP4mOsbVP-esw_VntKKBgg-1; Fri, 24 Apr 2026 12:18:58 -0400
X-MC-Unique: LP4mOsbVP-esw_VntKKBgg-1
X-Mimecast-MFC-AGG-ID: LP4mOsbVP-esw_VntKKBgg_1777047537
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35d9f68d00fso8238347a91.2
 for <dev@dpdk.org>; Fri, 24 Apr 2026 09:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777047537; x=1777652337;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5agusTy6k83H1uYzuhJV1mE9WppNK+7xb50IuK46Qs=;
 b=R9fvdXAWYTQoODREz24Pv9+7ltSN3dTViwnlgPpDDnNPxWydX/yFM/K0YTYjsT9Du3
 9O5dpA0A8XY2tXShSIvjnof+08MQPHoHJisGgOL6mh6yqN1w9NlvviRedWrZ2SoKsYbg
 EXIU+KSn+8Bq4T8Pp1uaH7+vG40odYcJ2RJ0WpKXmNVQI6wMiK1XjOnQyt12NE641l+4
 AAWcwxc/KmoLx3mTysIoNdcvQCgxEtJu7RzkEvd0yDZ6WN/56Dthoox60nMhgcIheCH8
 +Wg9+jxcTdsvU2pkHCT1e7GMErcUt8WTlYgMIZQezQIG9LhwlbKOrDMOs/pu9rekJnEs
 Cobw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R3SghJradsV3k2aeza77BKoc9LQ+mzpbX4doOYZxaVvaa0zotuZbHFfepNALZCxnBAkQ=@dpdk.org
X-Gm-Message-State: AOJu0YzgHDs4bFZ5Cp7qlhXrO/alh8YWRSP0mtWDg1LWELS1FGjniw2j
 QCoJJcgM42Q7wGZBb9tIDzJX6lzr0EmJXEKWsF2sHXY3DVnngaGqNTzsctZTB/AL/ZkKpSfg6g1
 P6ihh8tkcvKMa2y6O5aSck5ksuPY2acFRpHxoWpGHlZxa
X-Gm-Gg: AeBDieszs+cKt9bvD37JIhBc7WBGdclaR5VAKmO4ZeUKlMcVh/aJcq42KqyiqARUKnY
 qXmUvZWDYI+wyzZVdkyRDxPS9FbQq7gVEwrDe7SFtp3NjC4mx0+9qcSXzxm/AMXVVFlKNVZSNnE
 1MzBjLwUgQocPhSsO/rqkjRqVWFCKJtwWE4QHAIsWuRc6IzaxIAIpoy4DFBDgLjjhb/yam2zZ6S
 YA9vsN0J83m6PVmJzZ2zorGdVV8+CMNujlXS3tfFwzd6yr6JUXir1IsCX8Bj02U9qy3euvBgxME
 mkhkWEUEb9FVvW0syInuP62ai/K+eY7OF4c47Ly6JGsNo2ljTHsS9U9ZHJKNblmhG1AGcLHh/MH
 5J0+oUgWaFS6L1/M0AXv0eqMhhkWzJ7o4rg==
X-Received: by 2002:a17:90b:1809:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-361403d53bdmr33265829a91.8.1777047536732; 
 Fri, 24 Apr 2026 09:18:56 -0700 (PDT)
X-Received: by 2002:a17:90b:1809:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-361403d53bdmr33265783a91.8.1777047536066; 
 Fri, 24 Apr 2026 09:18:56 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.130.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fb95b1csm11298634a91.5.2026.04.24.09.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:18:55 -0700 (PDT)
Message-ID: <11bc4175-0d89-4ef3-b2e9-550ca9aaf791@redhat.com>
Date: Fri, 24 Apr 2026 17:18:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
To: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org,
 Gregory Etelson <getelson@nvidia.com>
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>,
 Shani Peretz <shperetz@nvidia.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260423112458.865674-1-rjarry@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260423112458.865674-1-rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JSvu2ea5-tKl346X3pFXqHlLZgp82CfMoR97o5WF7n0_1777047537
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 4/23/26 12:24 PM, Robin Jarry wrote:
> Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
> rte_net_get_ptype() uses |= to set the L2 ptype inside the VLAN
> parsing loop. Since pkt_type is already initialized with
> RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
> (0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
> VLAN frames to be misidentified as QinQ.
> 
> This was detected while testing DPDK 25.11.1 in grout. The net/tap
> driver calls rte_net_get_ptype() in tap_verify_csum() to determine the
> L2 header length. With the wrong ptype, l2_len is set to 22 (ether
> + QinQ = 14 + 8) instead of 18 (ether + VLAN = 14 + 4), shifting the IP
> header pointer by 4 bytes. The checksum is then computed on garbage
> data, causing valid packets to be dropped.
> 
> Set pkt_type to RTE_PTYPE_L2_ETHER_VLAN or RTE_PTYPE_L2_ETHER_QINQ only
> for the first level of "VLAN" tag seen. This avoids the bitwise-or
> conflict between the L2 ptype constants entirely.
> 
> Add a new net_ptype_autotest unit test that verifies the ptype and
> header lengths (l2_len, l3_len, l4_len) returned by rte_net_get_ptype()
> for plain Ethernet, single VLAN, stacked VLAN (two 802.1Q tags), and
> QinQ (802.1ad + 802.1Q) frames, with both IPv4/IPv6 and UDP/TCP
> combinations.
> 
> Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
> 
Thanks Robin, LGTM.

Acked-by: Kevin Traynor <ktraynor@redhat.com>


