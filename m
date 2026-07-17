Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFFDC44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C92F402C1;
	Sat, 18 Jul 2026 01:26:20 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 15B55402AB
 for <dev@dpdk.org>; Sat, 18 Jul 2026 01:26:19 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 803921D000D3;
 Fri, 17 Jul 2026 19:26:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 17 Jul 2026 19:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784330777;
 x=1784417177; bh=DbCqvkeyi4v6VL6r+qJKafvsSkXdBmVLRG5EZ7AhFqw=; b=
 ix7WPMl4OkLDUflBGL9VCBM0mZTwfO72UCzhvoSjY7oj0xV2V0BhotoGIsBa9bbS
 BLKOK6MYo/3mUMhKXMRqE3Oj4l35NYUVxhbYOtjkzOjiWsU91ZmY6G4uS3KfTcK2
 E61KCrnfFSi6BIbjgUHpdn8Nfm/ozglB+17R2UWrtf5WTnA+g7rOBwujq62ebYPr
 wumBQq0+U1AI1hrbLGCXfwaE29/kzveayIWbQ0bMHry9RFhle1UgxDCYHfBr2XIc
 AUA9HCytkkBHBaCuFD9uN0SsbNf2shOgeiLTkW4BlRyCczo4UEdYKgN26cCEQWJE
 oALeJ/dal4ni1kpA/W/YTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784330777; x=
 1784417177; bh=DbCqvkeyi4v6VL6r+qJKafvsSkXdBmVLRG5EZ7AhFqw=; b=O
 nSXDtJUCuOpJoOlL6WMYjolHp2YdvBdMuU5phl/EnKEbE9aLMzLBBUArISo1Lb3m
 3QA8cY+keqy1t5qUBLOOUpYPXii0gFchuwMTR1dwrZ7yaOMj8s8v4DbOHzNWA1Yh
 Jq8JecO7XR4otpaDwY3grFpGlzFMyubvJxMXD61tJb1n8vJs3fx9ipGcjDqTK8Ao
 wvAgkZj+q83fV9DV8AoiHLTgcsZqQJLXiGlH+zynuZuz6XRFSb+TNxGcDQ+yiEqU
 aQdU98qg2U+plXYcGq0GMHiQ+Xpn43bStKeKBfo13k+dprJw1hsnMwhDJGJdg5wE
 deNhes2KwpV0CLCignSYQ==
X-ME-Sender: <xms:Gbpaajra3-uof8ckGlq4QtNndxnU9NdyhSj_8Cbz48rl_qaXzjTpNg>
 <xme:Gbpaap_zgsdMrVAw-Nv81of7KCJXYrDa76NSIKbqbli6SiWvzrW7aYKxtc6xNG1rI
 qckOidiNFepi0s29Ey234wlCnfXowY6tGydThcKjnC4jjEZuXyvKw>
X-ME-Received: <xmr:Gbpaai-eNSFpzgWzGaq5h4P2ENGAzTSUQvoohDM5X1LNkK150yJT8_esCIK1jno48UeJROaMENuX68h1WA>
X-ME-Proxy-Cause: dmFkZTFaKvrqiyCofyFHPbxmOSKtKzX2MR8/9D0BOWEsG7GlcaK8eZW7ZCvnyd4eK9UVHT
 AFJrCCRu154wwzSLN15mD0VoIj4Hs7v7hWU0YGTZXoubfRazyNJpZcGgHBCsLkMp1tv22E
 2eleZhUox9e3kPtpcMiuCWObQDu7Ijtw/nkKOMYsJR2GeUGtjp9pZXZZ/tcOF5nvr55RWe
 5BG5AEtTF11UKDFI+Bjna9aXX2WbfRuJJa2mLOjhwiOn+1ZoUjfOc6w7s0RYw6RbUTPMrX
 gP99bSNJsq4EtqVji/y7OmlniG2hAOXlBHM886Kp9nqCT7w5YHKF3iJ2oc3YT9+bkyxkr4
 XXMhqvjNtVI0iaSPUR+rjh0AvVTr2apCSggII365zhxhm3eli+p4dcOaw7OCvRD5Kp49vf
 VmdCY5eUVgBvmQtmiypI8NclIazPmz/lUcU9Z5i7WoQHCBgzTo+yPgQTh5wdOpkuYj0BkZ
 zjtHXZwJAwGFU3riBbtD8brAno9Ggd//moD7b/as0wLwIR+VLP9Mp3l10WNuVM2zFTGlZc
 AI8GST+RqwiF3n0GHGg2UVxnZ3bbwUwQsGTJbaFgajVYf5TOsaI5gcCPpCNUKNO31G1aEA
 xpdLViU8qcPHFP9g9VZFmGtasGQfF1L3QCwmSmw2eq7MUVQHO75FAMPpwGDw
X-ME-Proxy: <xmx:Gbpaaosz2r3TfEBV7pcmkXVr3ToW416OxE6asjdw9Cg87fcniJ3lyg>
 <xmx:GbpaalrKoyJMrtRS9xV5NfyjpR6D6GGKELq6CCWYqtXuKMPQ8I4qoA>
 <xmx:GbpaallNXKaomkPf-CGuAsSAeeOmCyhyzesCDqGaIKDCtPdvZIUc3Q>
 <xmx:GbpaapxinShWf1QGlmMdIEncFkK03e0PxPROzZ4cgqBdqM1FUYDkbg>
 <xmx:GbpaakqTGX5NtuYqf4875IDT2waimsvrePujx7Esz-L0w3t_GIRIChxZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 19:26:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/54] doc: programmers guide corrections
Date: Sat, 18 Jul 2026 01:26:13 +0200
Message-ID: <KyjwWJg3QACMtpEHv56IoQ@monjalon.net>
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

> Stephen Hemminger (54):
>   doc: correct grammar and typos in argparse library guide
>   doc: correct grammar in service cores guide
>   doc: correct grammar and errors in trace library guide
>   doc: correct typos in log library guide
>   doc: correct errors in command-line library guide
>   doc: correct errors in trace library guide
>   doc: correct errors in stack library guide
>   doc: correct errors in RCU library guide
>   doc: correct grammar and formatting in ASan guide
>   doc: correct grammar and typos in bbdev guide
>   doc: correct grammar and formatting in bpf lib guide
>   doc: correct grammar and typos in meson build guide
>   doc: correct grammar and typos in cryptodev guide
>   doc: correct grammar and formatting in compressdev guide
>   doc: correct grammar in dmadev guide
>   doc: correct grammar in efd guide
>   doc: correct grammar in EAL guide
>   doc: correct double space in FIB guide
>   doc: correct grammar in GRO guide
>   doc: correct grammar in GSO guide
>   doc: correct typos and grammar in graph guide
>   doc: correct grammar in hash guide
>   doc: correct grammar and typos in IP fragment guide
>   doc: correct double spaces in IPsec guide
>   doc: correct grammar in lcore variables guide
>   doc: correct typo in link bonding guide
>   doc: correct grammar in LTO guide
>   doc: correct grammar in LPM guide
>   doc: correct grammar and typo in LPM6 guide
>   doc: correct grammar in introduction
>   doc: correct grammar in mbuf library guide
>   doc: correct grammar in membership library guide
>   doc: correct errors in mempool library guide
>   doc: correct style in meson unit tests guide
>   doc: correct errors in metrics library guide
>   doc: correct grammar in mldev library guide
>   doc: correct grammar in multi-process guide
>   doc: correct grammar in overview
>   doc: correct grammar in ACL library guide
>   doc: correct typos in packet distributor guide
>   doc: correct grammar in packet framework guide
>   doc: correct grammar in PDCP library guide
>   doc: correct grammar in pdump library guide
>   doc: correct typos in power management guide
>   doc: correct grammar in profiling guide
>   doc: correct errors in regexdev guide
>   doc: correct grammar in reorder library guide
>   doc: correct whitespace in RIB library guide
>   doc: correct incomplete sentence in ring library guide
>   doc: correct grammar in security library guide
>   doc: correct hyphenation in thread safety guide
>   doc: correct errors in toeplitz hash library guide
>   doc: correct errors in vhost library guide
>   doc: correct whitespace in efficient code guide

Applied, thanks.



