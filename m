Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101D3C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 20:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B51D3402D1;
	Thu,  2 Jul 2026 22:55:28 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 35F4440041
 for <dev@dpdk.org>; Thu,  2 Jul 2026 22:55:27 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 95BCDEC010C;
 Thu,  2 Jul 2026 16:55:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 16:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783025726;
 x=1783112126; bh=0yFTdqU5fRclMs/Rq6+GkmqigsusgqQT/Q+U2k+oFew=; b=
 JNQ8W7IqjZmI/gkAVbOIkCzAEp6AtTVu/x2Oj7nt9Io3FJp0AhlIAHccx7JZpAoV
 OKBFilcSTutnKyC8t54I0WyAvKw0bYs85/GZ2Yzn1e+9ttZPM2wuHSabaQrSFEQ4
 GVADfOyOO/NdnPTn6PXzV0NYm02Z4InY8X7m+pbWeRPxkXqYtuX2MIRUtyeNypqc
 lUObqTrFjzlQMxcCAIopNc8pBTxU9k6ft55ENqFe/KGJ+xt9Sw/fDWYZqbHDvw5L
 wh31Bico5RdRElm/DsJRaYjdYDel31YeYIiXvCcfsZ966pCQPYO6lBY6PhwcfihB
 ERIZtsEH51UQmhKtTr6Afg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783025726; x=
 1783112126; bh=0yFTdqU5fRclMs/Rq6+GkmqigsusgqQT/Q+U2k+oFew=; b=o
 3CVddfqIF38kyqfQDeemvMClKat2OYwnHXQ1ReMmpyoPdb9XjmAh1ps9uNUvBcjf
 mL4R811ceuq7jwbVo7EAaRmpAUYn4DH1WerosXppZMkmzjQ5L63gZZScDjyqVkGW
 Fl37hdtNATVAnoyWzvjUBPb1VcYrrQSuuJIJAOvsMNMCr1QGJjMri/8bbNUWlmoz
 lQusPSLsQbRKxOmFqtPJ2uS69es/sOGVY3dco1Yc0dRp6ZgIsbHVzGNTJDrSqICF
 Y7K8QGvEXL0W0CSUYt+IXtO8jlK7AW/8pfSSUuhnKODamjSVxdLxYRTfbuPc3etP
 rvWTf1sPYz0hsucYwndbA==
X-ME-Sender: <xms:PdBGaor35Te3zsHobTK4GUAZVPpr5qq30Ce8nXe30u1nifZOiff_Mw>
 <xme:PdBGaq9OMworbZONu89k5w66P4fwHFBN1y-GIjpfZ6FQ6jGRX1fqrkvuD2GUwpJpA
 1gKzjkImNEamkgPSWGf1E0r4v-ZsfgHgEmQ61-yVilzch-8rS6_FA>
X-ME-Received: <xmr:PdBGav_D3Mp3baSEYQUlWJUBKOM44Dl-vBoSF173zA05EwYWUreP92i-xfeBCB841MsZQ6l9seP9-M0_GPeO-FIbzg>
X-ME-Proxy-Cause: dmFkZTFNecJprlx1dKWhxdkuE6hIcwS3OoUT/3fg3JoOXS3KDCaXoqLawJG7FzUX26J23+
 cud71EdLhC6uGDjsyofduoDaHqFWvjJ7ZW2riUUzluqwqAD0mqEH2xXafcLwlQ+YGze2zt
 AGszT6i/cU79zmYwKiA94XsWafAD6Tu7HGRJB6+KFROlO7EqlJbkRPzHWkdJC8RwjLSzeT
 6cHAeZUKLTFrknEGy0W/8RHVngbNV7nsyXgtMIdAMBOGtwcuONFBZFhme1PvmSDVRRQy2T
 +Lk6yfUw6+oSpTVP8iW6g5pjzd2/U5DbUifiX6Ai2nDDrhA+h8L/NYXeaZ3Fi41hDR94at
 0vKMmFP7exZnKykddFyPHsy22XoVzwhbbwWX5d1hL3LFi8lHhO84xiz00X3tid6y1RDXap
 CIOa2qvvTnAdVIVAZGAxsCBtb/12jeQBgHDwOcQuC7gwTwAw5OIyIs6fN7Ab+YfuNOx/j7
 aF2CkTh8JGdefXJ7Sp/WwIae4fF08Ttr1YQVKfSx0MieTt3WKd5XuZIkZgdKyqZvzly6CH
 gD7BEju9FigndZ6mzqMlfFMRfbeyY5K9c5FBznavdLvWGp3EZ9I+eaRqs8/1vG4C6J12Nb
 w4pLLdq8nfsgYnqss34lrQ9HEVENlB53sH9PjTieWKbXZ0b3BU7XlA3yIlJQ
X-ME-Proxy: <xmx:PdBGahstvmEu9Q0F3poN9qGTPT1vNIoLSWv7HziN_sKl4aKaGiStaA>
 <xmx:PdBGaqpsrK1MgOstoJkMk94pidNVHC9VzCURfbiULd8Tya6D8cuY3Q>
 <xmx:PdBGamlJnZyDydmJZxwRRY_wiD_Roai1cTcbfFGj5a_mZgFXqHkeCQ>
 <xmx:PdBGamwVf6MV5l84PJZIqKq7nbpmHxx36l_FWfXpIY5k4caPtBOlOA>
 <xmx:PtBGahpfw2JO6d2tnRgVw_1GNeZ1-IEz074pnxq-kVzu-CT46LTqC992>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 16:55:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/8] ip_frag: fix reassembly defects and add test
Date: Thu, 02 Jul 2026 22:55:23 +0200
Message-ID: <HoCNbjCqTvOfwEV3R0L75g@monjalon.net>
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

01/07/2026 18:20, Stephen Hemminger:
> The IP reassembly library tracks only a running byte total and reserved
> slots for the first and last fragments, with no coverage map. As a result
> it mishandles duplicate, overlapping, oversized, and misheadered
> fragments, and the IPv4 key is missing a field RFC 791 requires. There
> was also no functional test to catch any of it.
> 
> These came out of reviewing a duplicate-fragment report on the list.
> 
> Patches 1 and 2 are interdependent: the overlap discard relies on the
> duplicate handling so an exact duplicate is dropped on its own rather
> than discarding the whole datagram. The rest are independent.
> 
> Patch 6 adds a functional test modeled on the Linux selftest ip_defrag.c.
> It passes on this series; with any single fix reverted the matching case
> fails.
> 
> v3 - drop stable from one patch and reword release note
> 
> Stephen Hemminger (8):
>   ip_frag: tolerate duplicate fragments
>   ip_frag: discard datagrams with overlapping fragments
>   ip_frag: include protocol in IPv4 reassembly key
>   ip_frag: drop IPv6 fragments with per-fragment headers
>   ip_frag: reject oversized reassembled datagrams
>   app/test: add test for IP reassembly
>   ip_frag: remove use of rte_memcpy
>   doc: add release note about ip_frag changes

doc squashed in relevant commits atomically,
applied, thanks.


