Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B100606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=k60htxut;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UKLGl1LN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C2D940E15;
	Thu, 12 Nov 2026 16:40:51 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 04FF940682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:40:50 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 0DDBCEC05C7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 10:40:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 10:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794498048;
 x=1794584448; bh=u8IhnzBmulz6eSts+shItPv/2n1oAaSLGSPTFIULbTk=; b=
 k60htxut48xm4BCubiNmpXPkkHoba5zUOLSOxQWmjd39Nlw6R+BCGI4aKrMML0I3
 xq7Yc3XYvVul0YbERCd1eNevXT7gWh2N42kjls1ioqXjPmlt/hHBNqOjaRRf+KvA
 O9jwrChJJVRskr0C8hmG7r++UF0zatbNuHwWabLU14UQWCGAkITrqepUuZ92VyVt
 qjYy2CjJtHfqE+rwPf05rL14lev0YFWihhETOZRLJUWY4ShiIVq2QHLejH61O/3D
 jmIsF0/tYnifPztwW+uThBzhUVh1ktzHglcrcR+bqOfDET7enx2ymmJ+GuuIwZK+
 dw/8Uz1t3QoN3MWWPw1edg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794498048; x=
 1794584448; bh=u8IhnzBmulz6eSts+shItPv/2n1oAaSLGSPTFIULbTk=; b=U
 KLGl1LNjLWTCdE1vBiI+GGlLDdp5zPB33DBJIJc4PLMHRHKzUfjLTatwmGGaaaM9
 S4f8Br6Pn+mUFhOuKNVcS5UMkBEsGCpbkVaA1uWvf1KgeNfmle7DHxy1eLpiaYBl
 wFia6Z3QouTVBYh1hLbWgw86OyiNWTklm2c1DWDfzzdpc9l2aE92jglzEvYeZN4C
 r+o7jkkwZSO7DazmhS/gP4I9Q2S78jv2ajieObTM4MTIxzYtpRRlHnhAbyVOC/Fb
 P9ehjHBUtkDCSQY5eARN1UjRN9JWoodCadDtiO4xu76lNpcMKs2SmSArUEhd/c9/
 X6f/0O7uc2Ivj/dwt97iA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794498048; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:HjLVfOZz4Rwzhx2VZheZotFucRpBWKSU1o184YHolj6IaO7
 hhoAIwq6ZnDRehsV5AAJCG8W9lb1SuPeBgaog3rT5Pr02oOdPATCW/SCBSR/8WT/
 i5HdJogHo5yv/qPmrdh71iXLGa6jkiYJk4ESGfEmMh2kl9CyalkldPG78QzwJfrY
 sq5X6YmTQMdw2OBRfp/n61O/5P39SnIVSTufaO5ZQRethr/azeVPDlGYSj90IjhS
 aM3d1MFMKgXsS08GSdDtM2HEuxgGx115PB8/7gY2QvLOHNSg34i/GLCWvwpIeF7W
 SRUR4GEVvEHlmjDL6TgeZ4wESUM2HESNvA/a/Aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:v7mO9BGW6AZeRENHFWsYd/XjHL3/D8c6/QxfGFrMFMA=:aUXtX9w+TnIBYiHOPNkO7q8phTW42hQ6hEAYe6wZdEQ=;
X-ME-Sender: <xms:AN71ar1Za1CCRVol6QIvCO_zPBhrgoIB5x9mTgxVXA2Xqt2BaNJnkA>
 <xme:AN71alAiwd8kZsQxtfcMZqPxnrRgvxxT-ZptRptMX_6zKv-rSiYyVv-6GSzsWj-az
 7LSG-iyK-fT7x8e6n83VGVsybcPJuWoAkCemBII_13a1LJ0J5Gu>
X-ME-Received: <xmr:AN71aq7y19lFgBQfNQsCIu1u8wJtwO7Y-8POygsjR7_AXo4eJkSCPkaI20y-h3lHQqLjWvOVNyd8wMsfBC3qIyM>
X-ME-Proxy-Cause: dmFkZTEN8rMaSnUntNx18MnqRHGFavs8aufvJ3/wvUTY4S6h10XEORQ7tHY2xkJcPl8NgC
 GVrbBXaa7/enCQzQeN8JQqHLOgAqay7f7r+aoLYHhL0n1MOlAMHgoWqkATVwKlXL7uvoT4
 e7IsnZ8JDnfeDRZXHBMCiikd2ZkwSIkdiuyLer2wuqSX42tGQlBPagzxKsV5l3qJCNniUE
 xCpMzI1FYnLuoOXSeFcfhASQJhPw47cr4qaRyS1IEs9qKA6kIb9t9ECveCEN7GTkg9MBDB
 GsYOiwjQN8jA4UN5Eq6jofLIyCP0hYxjHEnAAFN9jCkW1fbmNebTLxOns55tmZsj6VV7o9
 CjEYp+HX0fAArIBLpw1gbrI6HJsm+oW2pXBpXfNam+1YULkHxdrOHLV66mg48JWqUnjsKB
 hJTEZSdYx6VVrLJg+YRcKe6SB4joQ7rIZeiaafqe6UYtOyH94nqGJ/rjxI34RywYTNJxmG
 G5pNoYAxxaM/CPzpH4+YA2kj96k5PtQKBwVGaZzcw2isSKIcBg3NVR+4ZGJl0zLODMrPIq
 h9NijxJbATSPRwb3cc9oqi6JUU/hhgkZOytMhkw8P2Xto+NBxdYSz4JU0sRUciQEY9dn9+
 wElz54bE4VMUBZTlLbWup+f1nbe6RM80QXSoMdkV25tHdNG4xdilbUBpyOBQ
X-ME-Proxy: <xmx:AN71amKsMGBOA6eReayAD-GYE0Qa0EPT2gPEt1_bjFNnnlzegzlGVw>
 <xmx:AN71artNNYFaOyUXhU0r5fZJkDMKpMpkJhQ6-NTtavFLyDMHeRVqrQ>
 <xmx:AN71atKIm0ijxcQDDZ-kOZD1jxgUU1tEX1HXgSd5iDPUUaL9MGiBUQ>
 <xmx:AN71as_BciwfRseqqLNT5Caf3lYDyXw7bRCWU_PuhMpQ_FQAJ3cQeQ>
 <xmx:AN71avtwuf86fpzXD6T_d60l6V7rQPhUc65uQ4oth8ZFj6VJ6BnJjot_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:40:47 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ray Kinsella <mdr@ashroe.eu>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH] bpf: fix index register for classic BPF indirect loads
Date: Thu, 12 Nov 2026 16:40:45 +0100
Message-ID: <Ruj7YOxHRl6oTm5bxZ8m_g@monjalon.net>
In-Reply-To: <243ec0f2-f8fc-4074-b30c-4e9b5fcd94ff@yandex.ru>
References: <20261027170619.2193021-1-stephen@networkplumber.org>
 <243ec0f2-f8fc-4074-b30c-4e9b5fcd94ff@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > Classic BPF filters using a variable offset into the packet, such as
> > "tcp[tcpflags] & tcp-syn != 0" or "tcp[0:4] = ...", read the wrong bytes.
> >
> > The indirect loads ldb/ld [x + k] were handled in the same case as the
> > arithmetic instructions, which take the source register from
> > BPF_SRC(code), that is bit 0x08. In a load opcode that bit is part of
> > the size field, not a K/X selector, so BPF_LD|BPF_IND|BPF_B (0x50) and
> > BPF_LD|BPF_IND|BPF_W (0x40) both yield BPF_K and the index register
> > becomes R0 (A) instead of R7 (X). The halfword form works only because
> > BPF_H and BPF_X are both 0x08.
> >
> > Give the indirect loads their own case next to the absolute loads and
> > emit X as the index register. The interpreter and the JITs already
> > take the index from src_reg, so this fixes all engines.
> >
> > Bugzilla ID: 2085
> > Fixes: 2eccf6afbea9 ("bpf: add function to convert classic BPF to DPDK BPF")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

Applied, thanks.



