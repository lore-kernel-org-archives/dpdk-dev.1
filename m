Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E322FA1FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 16:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F54402B5;
	Wed, 22 Apr 2026 18:32:20 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id E6163402A3
 for <dev@dpdk.org>; Wed, 22 Apr 2026 18:32:19 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso4727469eec.0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776875539;
 x=1777480339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZpXxGlGQIWuEHjy9dxysRiYGE2kAQUv8peukSWF0QM=;
 b=pvlpJlN2ShF+SFqhiRwgiX8bGkPUdW5ehz2yYxWuhjqQSn2cZ81xTzubpjOPrBssfq
 ADKBkiJItQ2t5zG87xAw0kR+edjfIZ7b4snBOc7lIDmucjQBmtiqr0K/TXpdnVt7HDET
 NKD/RRgtosuPsUapPjf9u+xb3pWjHN6X/ouxMq9fr7t3klE/Ml8pT6Ksv9vDjcnQScvX
 xsDoB7j3X2BvHRGleNqjCEC3v4gwacHmf8jyhTNSTGxzYB6FtF7h6te9giQJTA5zB6UW
 Cyz/C3mxhS7UAjz0kLLFBr5ipXwLcKeAadcFoH5YHyAdL7HClyk5EDvqYBOsaV0Y+bRd
 PGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875539; x=1777480339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IZpXxGlGQIWuEHjy9dxysRiYGE2kAQUv8peukSWF0QM=;
 b=sI3LoGLcdr3iF1FFtiAU8cAOyagdQ/jfgxBIu9A1dkIk9Z46ZiPvW+FfVGa6z63yjt
 5B/njyliNiwj6+RtmBl9+Wmo9k7EIoTf7niHDDW1dloCIpM0+7aSun/nO7AaVB55lIle
 FGAMwNSSkBfotWeCkPXajeZAsPmsy+fTYV0G5iDgcIhb1Bf5undSzBqzJDAz5JPfnga/
 bi0t0i/qwNnt0Jq/3pz3cXBxjzibfKIltRSOwkl5nib/Pr9wjvMJu7Tyr/xQaYd/EVj2
 Uxg0wtzu2axGJuC45bKki7EaaIsssWQH/KWGLFeuxZ39i3CwAu5lpqZ/s/ynPSJcWoES
 uzCA==
X-Gm-Message-State: AOJu0YwoUEI1w+TkXEbHKv5XkcUlqMjRbnHMEZj0hGXhel+BcsuwAYlz
 RCtF2/vspQPxxiCWd1v3CP0jg3uq9R+3Otd/yYjVaSDrNENnlsUZHnLHGjK2Z4GJPnU=
X-Gm-Gg: AeBDietDM0VthN23Dakr57UHWUjSnt7N2Y6C6Yi4rc1bAaXw28H/tEjCdnquip882au
 vBv3Ly51RtiOr0qmbUbZux9a6LGl0qTa32RYJvPwFMtfA+9T8bqrjbkOtVQ6hBjH8/flwSUtGY7
 NioS3H+zRB7vMnIjWNd0L2mRqW/TQnGTx/TJuLfrAlZZo2j8mC/Dya/PfGnxLG1vV/0EV9K73fa
 xN7I/YQNvQv5N70aXxoT0Tv+4mzOdFACbe2WpjiT3FQiZR4t0QD303dSobVA0kFD0nJvrcXuSRJ
 7vaghB71ND0QGx1hKZjTAmOgGSYO/3FpBzHwZj/inv30MV9IgFJt0HdDBJ5rEMBH0HHil5XMgRJ
 +5jBKScWx4mvqez9sBwASyVEDEVjca8dN4WBXHNVJKWodWUYL4KcBH8so40ozAzm7BArfOTb3B4
 rpIgueX6eaYFlUx5KP/JZo7r74w6Y26ayk3YuHW6R8kI30/Q==
X-Received: by 2002:a05:7300:dc92:b0:2c6:7896:e2b2 with SMTP id
 5a478bee46e88-2e42dc07c36mr9039478eec.13.1776875538588; 
 Wed, 22 Apr 2026 09:32:18 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a64e5sm23744567eec.7.2026.04.22.09.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:32:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:32:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk] net/tap: use offsets provided by rte_net_get_ptype
Message-ID: <20260422093215.001c1c00@phoenix.local>
In-Reply-To: <20260422133615.680318-2-rjarry@redhat.com>
References: <20260422133615.680318-2-rjarry@redhat.com>
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

On Wed, 22 Apr 2026 15:36:16 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

AI review feedback spotted some things I didn't

On Wed, 22 Apr 2026 15:36:16 +0200
Robin Jarry <rjarry@redhat.com> wrote:

> Instead of guessing what are the proper header lengths, pass
> a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
> proper header lengths/offsets in tap_verify_csum.

The two bounds checks this patch drops are not redundant with the new
l4_off check and need to stay in some form:

-	if (l2_len + rte_be_to_cpu_16(iph->total_length) >
-			rte_pktmbuf_data_len(mbuf))
-		return;
...
-	if (l2_len + l3_len + rte_be_to_cpu_16(iph->payload_len) >
-			rte_pktmbuf_data_len(mbuf))
-		return;

rte_ipv4_udptcp_cksum_verify() -> __rte_ipv4_udptcp_cksum() does:

	l3_len = rte_be_to_cpu_16(ipv4_hdr->total_length);
	...
	l4_len = l3_len - ip_hdr_len;
	cksum = rte_raw_cksum(l4_hdr, l4_len);

and the IPv6 variant reads payload_len the same way. Both are untrusted
values from the wire. Without the checks above, a packet whose
total_length / payload_len exceeds what was actually received causes
rte_raw_cksum() to read past the valid data - uninitialized tail room at
best, outside buf_len at worst. The IP/L4 CKSUM flags set on the mbuf
will then be computed over stale memory.

These checks were added deliberately in:

  1168a4fd193 ("net/tap: add buffer overflow checks before checksum")

Please restore equivalent validation after rte_net_get_ptype(), e.g.
check iph->total_length (IPv4) and hdr_lens->l3_len + iph->payload_len
(IPv6) against rte_pktmbuf_data_len(mbuf) - hdr_lens->l2_len before
calling the checksum verifier.

One other thing: rte_net_get_ptype() returns RTE_PTYPE_L3_IPV6_EXT when
IPv6 extensions are present. The new "else if (l3 != RTE_PTYPE_L3_IPV6)"
clause falls through to return without setting any CKSUM flag for that
case. That matches pre-patch behavior, but the comment the patch removed
was the only thing documenting it. Either accept IPv6_EXT here (l3_len
now spans the extensions, so the existing helpers work as long as the
next header is TCP/UDP) or keep the comment.

Nit: the memset(&hdr_lens, 0, ...) runs on every Rx packet even when
RX_OFFLOAD_CHECKSUM is disabled. Moving it plus the &hdr_lens argument
inside the offload branch (passing NULL otherwise) avoids that.

I prefer initialization instead of memset, less error prone and easier.
