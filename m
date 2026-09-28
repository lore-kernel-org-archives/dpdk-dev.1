Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F0CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC2240DDD;
	Mon, 28 Sep 2026 16:18:08 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id B6CC740DDA;
 Mon, 28 Sep 2026 16:18:07 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 3A2FFEC00DD;
 Mon, 28 Sep 2026 10:18:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 10:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790605087;
 x=1790691487; bh=pAgXNl4UUzDgBC+NQ3p8V5lZT8ik2RSXmR35HONlxu8=; b=
 BXqH4DbQW0B/8Vy4nG9wSukjjDI1jVQT7x8So6UWsSzCmwMx+asqKKR3iGrCjf81
 OLMFuiP/iTJSN2chmbyS0kR4AWSqrbnF2PrYgkCe0e0CqwyMxwgWl3sOSkiv5AQe
 eVkxqbDZ4hGJOnkaoT8wsC4FTFu8SzrrSbG5egj1Q69mR/IZMDpQwuzB4Z3oXimB
 fXE3zFYRIHq3TZN0O5itphR9QHvVnnQrDhz8o7bxNFP6iw1eCJp88Giko4kT+A4M
 Rdeuc9ogxloRDfMovykzk28CJQTjYXSCWParn4nQ8aG5CC7YooDbDMvSQlwVPeG+
 EqsyXc+ml2DmQWN4UM8UqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790605087; x=
 1790691487; bh=pAgXNl4UUzDgBC+NQ3p8V5lZT8ik2RSXmR35HONlxu8=; b=A
 SP1QDYQSwAkEDHDpCBMrhWvABymrv/kXowIQU5srYCtoHsjKgJbkQeLZTguSx0K2
 XUYLJMJHmUkGVoJKtRQeDzjVB7Pq2m3uXHyPIk/tAL7LjjdqAVuNA6N/8BCH1eYL
 vefAH5rKlcEWTaG2txQ4n7mBOKOkGuW6U6vEO5KBv2hAaLVwd+j0A6zj0QQSYQo7
 OEwUlYwU1j9yLE1ibcbJj3BD+sJ+6MMO5tvpNrtSqecDsP1NJsvyd6bxOBdzBgHn
 zB8hkxJc8usKE4v3V8jOHJmDgOvBMWwbJJcPNIbjU8kMTL7VrOdbf+sr45tULyhX
 LAiiYsdyPRUn+fGwrdcuQ==
X-ME-Sender: <xms:HXe6ao5sTLteiP3Y6PfESUL5ORBSCxCjv34Kb98OAURC1RyC0BiRvA>
 <xme:HXe6al7KsYBdhomxxDsZoEPnc9OFngFGjVFuvQaXVD7gQElaiGYq-VowcPpMZF1Qi
 RNcfpg974XrALXN--CkDxNiN9ghlxaRfdvW3IuRVDbOu5wFny6c0w>
X-ME-Received: <xmr:HXe6apru7hzxZ-5BdKkiE9FTZjJsN24TaPN88Rk2UNqHkYJA3D_E0AQmFzSVp1rEqcUr_z4UD4b30AA5vc5O6Yvxdw>
X-ME-Proxy-Cause: dmFkZTETOtl+3bj+ExRQlcyoa3Tr/CZpm6g7pIAvtY2hLF+qNAPnggIQZTmjpU4E4wcRLL
 zyW6DAxrZvBiuuK7s6cs9GgBdvGhujV2g4kWMJJw7GJnAwelzqm2jf1NOpPvaQGD/cRY4d
 i/+8N9NPHAl/WQU1O2WkCipwJPu4S7gbaqiAAbulHil3/GxFCc5Yj3KJncGG/7qwjC82xs
 oQOK1LaYQnUIVP3EyUWL2OuZSxpD2Zr1kvDR3V3+7drvSrQ1xIoUR7rNuoxjOyBR8RupLn
 ePrhq0+gZNU1ImCXDBO6UyjReg7I6mRfk+2QTpr++S93ywdQJnFvCL39VGTQeonrdh6niV
 LbeH7L9F4cPBFEWwrVyjzkELS9kFDumqC4TlC16pXAYxFrvYYLSiElG6gUkdmn60C3v7ns
 tfbVb4tzFwUVWftvlN2r2GVJSWtsgZ7o4hSDvP3N2qh3thEuGoAbktEjzGXxJZIHYKMYZN
 rvDXLnYxJ0fXe0LibLlf8TAGpCSlpBazifXI1cctifyTvcb/bmtJWZO+XfOQM/parnhO0v
 86Tlu/qO/hc7utlwBaSRsolV26HO1miroBSIbqpjNHYGweadLLVLB8/FwWU+LXCMihjHc0
 TKQU+IC+XWjS2Wsnqss3/Lc9QidI9OrpByqVZfVtLNgcrNwj8UZKofkRfiNg
X-ME-Proxy: <xmx:HXe6auPTxbCFhpCpgoNzBz9ufZ0lQ1rr6CwLVnC6A2Iy3fE43LI1Cg>
 <xmx:HXe6ap3--rZdXyS8Lupr0bOEbuf0rr2Sr3UvHA4PJpVs1iriPI9g2Q>
 <xmx:HXe6alAs6FWoHiN7uk55q00H7ntWKNChVoufbt9p43is1Fi9JtZ69w>
 <xmx:HXe6auLt6ua-TDJd-ufuvID9iWGxXajljhFVWmQX0ip4tdV_9cbMRw>
 <xmx:H3e6aiwJlB_jlXwtDFqBIL2G9cdqvrCwIjHXlnt0xSrLGxEQF_rCh1sl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:18:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Aleksandr Khromov <haa@amicon.ru>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, konstantin.ananyev@huawei.com, olivier.matz@6wind.com,
 sdl.dpdk@linuxtesting.org, rrv@amicon.ru, stable@dpdk.org,
 Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Date: Mon, 28 Sep 2026 16:18:00 +0200
Message-ID: <HTNMG94CQuKiMcKhE4so4g@monjalon.net>
In-Reply-To: <20260921141515.759647f5@phoenix.local>
References: <20260918074729.79205-1-haa@amicon.ru>
 <20260921141515.759647f5@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Should we merge this patch and expect another one for the endian issue?


21/09/2026 23:15, Stephen Hemminger:
> On Fri, 18 Sep 2026 10:47:29 +0300
> Aleksandr Khromov <haa@amicon.ru> wrote:
> 
> > In rte_ipv6_phdr_cksum() the next header field, a uint8_t, is promoted to
> > a signed int before the left shift by 24. For protocol values >= 128
> > (for example IPPROTO_SCTP), proto << 24 does not fit in int, which is
> > undefined behaviour (signed left shift overflow) reported by UBSan:
> > 
> >   rte_ip6.h: runtime error: left shift of 132 by 24 places cannot be
> >   represented in type 'int'
> > 
> > Cast the operand to uint32_t before the shift so it is performed in
> > unsigned arithmetic. The resulting value is unchanged on two's
> > complement platforms. The same idiom is already used in RTE_IPV4().
> > 
> > Fixes: 6006818cfb26 ("net: new checksum functions")
> > Cc: stable@dpdk.org
> > Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
> > ---
> 
> Looks good, but there is also a pre-existing byte order issue here.
> 
> Review: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
> Patchwork: 169805
> 
> Applies cleanly to main. Fixes: 6006818cfb26 verified; the line was
> introduced there and carried over by 1a2b549bb4 (header split).
> Cc: stable is correct.
> 
> The fix is right. ipv6_hdr->proto is uint8_t, promoted to int, and
> proto << 24 for proto >= 128 (SCTP = 132) overflows int. Casting the
> operand to uint32_t makes the shift unsigned; generated code is the
> same.
> 
> Info
> 
>   drivers/net/hinic/hinic_pmd_tx.c:740 has an identical copy of this
>   code with the same UB:
> 
>       psd_hdr.proto = (ipv6_hdr->proto << 24);
> 
>   Worth fixing in the same patch (or a v2 as a two patch series) so
>   the pattern does not survive in the driver.
> 
>   Consider rte_cpu_to_be_32(ipv6_hdr->proto) instead of the shift.
>   psd_hdr.proto is rte_be32_t and must hold proto in the last byte in
>   memory. proto << 24 only achieves that on little-endian; on a
>   big-endian build it lands in the first byte and the pseudo-header
>   sum is wrong. rte_cpu_to_be_32() removes the shift, is correct for
>   both byte orders, and the compiler folds it to the same shift on
>   little-endian. Not a blocker since the endian issue is pre-existing.
> 
> 





