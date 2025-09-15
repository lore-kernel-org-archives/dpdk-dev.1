Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BECCAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 16:40:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 919CF4065B;
	Mon, 15 Sep 2025 18:40:00 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 80B414025D
 for <dev@dpdk.org>; Mon, 15 Sep 2025 18:39:59 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4b7a8c428c3so9763091cf.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757954399;
 x=1758559199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4p7NGu3uR6NEg/cIdAC2CnyrZel4yj/LmDe0V++8Nhk=;
 b=Z79i3MpY9cH/D/s562CIX6kh6tBKzxjTZQ6cynVxletoowWeky/BaGEaAyWB0I9mhy
 IaqOqCh3vxWob/av1YlkdkilMbMEFi06aNaxmObi+cZsv0I12QjjGyh1lube0ZDeI6+D
 TrQ7RmepBG2+8Hrjr++Iq0P7EPPYPNddLfPAJrg+tRFYocVfx1XjLN+azQ199Rm7MGcm
 3/Es1s80exYfBoyzVAsj4tjU+lEfQnUoDOrd2S4kNpklrntiVD1BX9OhymMKu/e0u3iC
 OP8lpZ9X38NRfClJp97WPWolTX40qlOg2RDDlLYZoe5JOaozB5GgpaUu5I23hL1OSMzO
 bSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757954399; x=1758559199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4p7NGu3uR6NEg/cIdAC2CnyrZel4yj/LmDe0V++8Nhk=;
 b=mfik4fpNSNvtPwk2+OzJBPfOyow4wU3IDw79ZqrjZvH4TyZYDM7PX609qW/hyDr2cY
 dCaHO6wM2sKhxaeTuw2H1pMNNxb0HbM4aDQtu3BynKLlLYUuDzFW6EcHgn0jcqFGTngn
 gf427EHmdiah67SbArN/BR0A704Mdzx0mrWc0S4P1/VCD3VH81YRI99CmgkTD0ZJm93v
 mvdiO0pUBE0rjvipe2Wl7pNSWS0d+iAUg0TlY8yyPX9ZQWvsg+BiqHKTGuEL64AciHFI
 +J4YKdotAlr6vdTUEF/94TSXvEHqySS+3o03g6zb7YQHyDmo2poNeSchXGoSAdW6q3Ly
 6HvQ==
X-Gm-Message-State: AOJu0YzcCihCzQCsIt/8nBnQUgDQPauHbEPG2AHFlgK5xoMl3j6NorZP
 gfplRcB4Gq9/qxkMIpY3vN9//6djWvSy3X+FuZ2pl/qNDUB+/RjgiNSQL0Nx4rMIVhk=
X-Gm-Gg: ASbGnctSzMI72CocDDGsClGDOekI2ZW1F0LFk/jrf0fDxTKetiIyPhS0bbVKOYApJqw
 EgEbcPs99jDrE4K0NwsJMOA2z+HsFVDgtmlOkjrO6X9IQon8PmKNcbHOdcf2Hm0hfu8Y4YZmaLu
 nWVh8eidpSaTF+Q+DTDtBgwNFt4GmIU6v4uXdKsHQrX/nLudDgUobjRlCXup9pnA2O6izkSqBPD
 yPdPId6XwIWBmiSM97VYklzoOgHuDsQFs5eszJU8pJm1FDPOS9mbhTIE7p7BuRXJ8UvVc3Osi5R
 mTH4qF9WAA2RVzVZ8dJ1odkg4UwT7vQh30w0tC22u3gqQW2EMDLqP8omFuyorpigiRwzi5YHa8u
 bSWtyst4qjYKCk3lgs/EQjq+xBRe6e70iDUNADvDa58AiOkNv0s9CXM0/ubEZT/YAvFMuCWjLfv
 AxRl50FE379g==
X-Google-Smtp-Source: AGHT+IGzVzU78c22ZVAuidA0VZXcZa4/9YWhop3a923iCj9CzKPVuA7EfK3Q6+rjgONj6fY9FE8KSA==
X-Received: by 2002:a05:620a:c4f:b0:811:6aff:d410 with SMTP id
 af79cd13be357-82402726e0cmr1464646585a.43.1757954398579; 
 Mon, 15 Sep 2025 09:39:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c8bb8d9esm827420585a.3.2025.09.15.09.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:39:58 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:39:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix L4 protocol retrieval from L3 header
Message-ID: <20250915093954.6f02c3f2@hermes.local>
In-Reply-To: <20250830012913.1117632-1-huangdengdui@huawei.com>
References: <20250830012913.1117632-1-huangdengdui@huawei.com>
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

On Sat, 30 Aug 2025 09:29:13 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> Currently, when retrieving the L4 protocol from the L3 header,
> the case of IPv6 with extension headers is not handled correctly.
> This patch fixes it.
> 
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  app/test-pmd/csumonly.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index d355dbd8c0..a6e872e5a4 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -525,20 +525,8 @@ get_tunnel_ol_flags_by_ptype(uint32_t ptype)
>  	}
>  }
>  
> -static void
> -parse_inner_l4_proto(void *outer_l3_hdr,
> -			struct testpmd_offload_info *info)
> -{
> -	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
> -	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
> -	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
> -		info->l4_proto = ipv4_hdr->next_proto_id;
> -	else
> -		info->l4_proto = ipv6_hdr->proto;
> -}
> -
>  static uint8_t
> -parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
> +parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype, bool parse_inner)
>  {
>  	int frag = 0, ret;
>  
> @@ -557,16 +545,19 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
>  		if (unlikely(ip6h == NULL))
>  			return 0;
>  
> -		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
> -				RTE_PTYPE_INNER_L3_IPV6_EXT) {
> -			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
> -			if (ret < 0)
> -				return 0;
> -			return ret;
> -		}
> +		if (!parse_inner && (ptype & RTE_PTYPE_L3_MASK) != RTE_PTYPE_L3_IPV6_EXT)
> +			return ip6h->proto;
> +
> +		if (parse_inner && (ptype & RTE_PTYPE_INNER_L3_MASK) != RTE_PTYPE_INNER_L3_IPV6_EXT)
> +			return ip6h->proto;
>  
> -		return ip6h->proto;
> +		off += sizeof(struct rte_ipv6_hdr);
> +		ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
> +		if (ret < 0)
> +			return 0;
> +		return ret;
>  	}
> +
>  	return 0;
>  }
>  
> @@ -705,7 +696,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
>  		info.l4_len = hdr_lens.l4_len;
>  		info.ethertype = get_ethertype_by_ptype(eth_hdr,
>  					ptype & RTE_PTYPE_L3_MASK);
> -		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
> +		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype, false);


Setting parse_inner to false would cause l4_proto to be set to the extension
header type (rather than the real L4 protocol). Was this change intentional?
Looks like it would cause checksum to be computed incorrectly for simple
case of IPV6 with extension header and TCP.

