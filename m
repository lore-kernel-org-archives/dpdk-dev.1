Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3175CCA464
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 21:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF181400EF;
	Thu, 15 Oct 2026 23:48:15 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id B78B1400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:48:14 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 1A2CC1D00188
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:48:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 17:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792100893;
 x=1792187293; bh=/V5ndrXLuPVUPapEegoSo6xYTTw3FMuBdAbBei40s0w=; b=
 lzNiHdTU6ZRpxH0km1cvfi8xUW7orgHg+gE6DKcO8Gw8zDq+RKnQ8SF9T3NKhAUv
 zg9HI1J3/wQy7ZFyFZR0D1fQOazRQhMOGuMhRt3luefgWnExGGiAu/ESJb3ylN/p
 2x8YdD60TVI0Q3wHPW4KJMppNjx/c6gDVN+AGVO3tduNCilKcEjuFMSR3cuUVA54
 QvYrGUGNgCUYjxfJrYsj7DdLeNX/6sUpoI1mGtq5dbb8lCHC6J2KyTGkBMCYuJZX
 9FpPAZ0JdZ/Y6C5rzlJp1upTld2Ci31IaAK/qJAV53nKp/P1oMIqHNoHZmNefGsQ
 aZcQTHcNgWJMCfqh3yfm9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792100893; x=
 1792187293; bh=/V5ndrXLuPVUPapEegoSo6xYTTw3FMuBdAbBei40s0w=; b=h
 FKCN0DL4Ip20a0ttXJDIZJzqR3LL3NPjFydcP2S3cc7SgRmkeceB0n2/tpXKqy0K
 ydMCEU5ZHFbULxDWSK6B5NijZA2OX3jyihEZz02x363/G7bE8aUn1LhtXltq3cM/
 j9bl/0Sd5OIMM4h7mUX90A8kFi96taV8pntKkKc62nHSaMj17t/u0ZfnqN98HWFg
 Ru9ciDigtHDNrVJkLtspu44H2r2HWJBotA8PdI1oQ2esmZoZn61WOrvMt4OsIAuV
 GwfsyKcUaSKGiBLDK4mX9ZSAONJgqOzwJrnr1QO7JGlFIqxr6OrarPqWqFjtIkFM
 Yy+qjDEOR879UW5Q8JI7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792100893; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:cEwKAmue1pS1yhisMbqxAalw6xmGmKDwIghQMZnQbFnaVW2
 EJmlPH0Win2K7LmLv1EezLWp3g4B0rDOhcedVnrn2KLcBtVqHclv57H2ZvrGDqP+
 ut6wF5obFOdKtxjksBSipMeu8R0ktOAzA6cfTgTcvb6YSHWg8RqOyuCWBegc+vWq
 kfVkI4vcoq1eOWVzBYE01twU/54Nde0JmeuFU0AXNmDJ/+U4zuO/DgxrPbiqhjYg
 /WFAOTmAB0bsmkO700hP9iRKjJ8v1MMYWK5nPI1Zvwru5EipiekJbl7hFmdOrppP
 tmUOryOMynFPiyBcbRr8drOEXcHia+t6G6MjO6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:my3IzwKN6QJvkoaG1sNvjNZOMVGDTu6egeW44A/S4V0=:s1+pnBLw2XzIcqOYPU0M9UwqTfSd+/sLc/DYYoafAls=;
X-ME-Sender: <xms:HUrRah-OkpMtIRxe7vFgr4dLrBuQVuTNpRPtVW_vILV4adLR4ZSMgw>
 <xme:HUrRahKrQLbJkz-Ld1moDhlxfHY6NVmNvYDtSuvPi3tq4G1gq2bmfCjTHNK3_-jtP
 B0ym4m6D9Bx3klcK2uLtmr7jVkbscC2IyykYZKVO1oDH2ulhUPvW7o>
X-ME-Received: <xmr:HUrRaigWvouui2bWqUdgUwXJKCK2i9yF_CUWm2LSI9AG6Y21ZQ9ScHy_EDjka6SG3jfW4jiDYgCUXLoUHlGA9q8>
X-ME-Proxy-Cause: dmFkZTFfprnSyi3fH5VVf3U25OC3KGOSaFB+Ri6Tn9anMzeFVVPEAD7D2ybhq1TfZWddHk
 iwy4IacnppWtigzSpmr9GOdqmYpe+oP68nkEcrctVYAgWBif9Rg+GaDo806FKtcOdOiXSX
 oU39GfMcnbBNBXXVEhJJZ/2IEnWetA9QbqE0pzFcl/CT8odms4G9RMtoQTzXe7VBhMatq3
 jdx3coda5zsVg4PYfKy4d8fsd3DqGK1wp2ZFfOxxPCHSeIcq1B12XRffq+k1Pz1H5g/sh2
 zyksKvmLZNspK6D9+Eo+DZccG5v8mN6YF3eKpCVaNp+v1bb9NOJDcW43jSnFEg5jlwAoSl
 NIfEZwaL80d3WDqY48r5loJKbzQc95Bevj8/a12+gFuiHRCif2WDn9fj8hhNajHy+NZSPA
 zAyZyWgrPa2tAqtZrMTsEuLAAl1ISp7QfMHjIPPhdE+3Rz8/SrJC8NhMalTnq1sG/JikKQ
 e9kSLgWifAye0ND6DLOuAiNmsF1qbppkP/W4E49kFx0S2zP+8U+t+rKFuuq+VUIbFd2Tcf
 SsNbmSnaRAnXYUcDypwKovLNoU//XcRmecdKne66lOql6fYUz5HKbOrhIDOPdZOnKh9lol
 wE0nRaC46qqVsXi7pLFpsZJUKp33euLuSA+kRnk/COEvOnJQkHc/nYox6hwQ
X-ME-Proxy: <xmx:HUrRap5F5H95jTNRmbEEoiHLw0nc8XXZhGA4N13rEvz7E90z-sS7Uw>
 <xmx:HUrRaiYreF8UC6thbuLs2aPJyIO_6OcTfViWBQAf9kY7UyW0ZX19QA>
 <xmx:HUrRam6tl93ObsA9d5YYlYRJP2Xtly9RNV_24MnDfNOCPh23iMOqRg>
 <xmx:HUrRatBo4xnyMWcGw2oVDdnxzUphzFivWdA-MNKkrHoIZmht0WLF0Q>
 <xmx:HUrRapHvrr8tgVfOllJBEOokuIzBDlyhgPUIJA9yQmG5m-pdq638e32U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 17:48:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org,
 stable@dpdk.org, Sebti Mouelhi <sebti.mouelhi@huawei.com>
Subject: Re: [PATCH] bpf/validate: fix 32-bit BPF_AND/OR/XOR shift UBs
Date: Thu, 15 Oct 2026 23:48:10 +0200
Message-ID: <JB6AoSDES7OTqsCmhpZbHg@monjalon.net>
In-Reply-To: <20260825095530.41354-1-marat.khalili@huawei.com>
References: <20260825095530.41354-1-marat.khalili@huawei.com>
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

25/08/2026 11:55, Marat Khalili:
[...]
> To fix the issue change to subtracting clz64 result from 64 instead of
> instruction width, add tests. Remove no-longer-used opsz argument
> (truncation of inputs to 32 bits is handled by the caller `eval_alu`).
> 
> Fixes: 8021917293d0 ("bpf: add extra validation for input BPF program")
> Cc: stable@dpdk.org
> 
> Reported-by: Sebti Mouelhi <sebti.mouelhi@huawei.com>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


