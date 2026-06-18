Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CABCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 16:26:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC87A4027F;
	Thu, 18 Jun 2026 18:26:08 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 32E1B40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 18:26:08 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 9B8E4EC0116;
 Thu, 18 Jun 2026 12:26:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 18 Jun 2026 12:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781799967;
 x=1781886367; bh=s6C8oFBCAS1Rzz5fN+LNN98ylpYfGTQb0+yzKefmhMs=; b=
 hNL2c+9GwLgcmMoNVQks/U4hT22VaPTLzM1uGjFp+JAZUF5Z6/d60eHu/nlLJpl1
 GonTDqHHHEnu9oB5wfHO8nL8G7nMZHWvlCB8sV0IbbNQEVhDxS2GWqyzczj7mYhB
 AShN+T/nmUl3Q1p3efMM/CLbcrDpW2xCUszUhRuxnHK6HKLv4wxx2w0vQX+9fMWW
 g0AxgQwwTrrv5q0ZgZQUNquGK0aYtgBS+YObPQjXJenc4+H9tpdiyU7d87YZCWUW
 sjPqsJJzBkUgBYg+ARZwAHZVvM4xgMoZ934pMwPVLg2adODubEaQ17jNFIKRh9xX
 dxiYdVFYH98cMD/vcVwdvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781799967; x=
 1781886367; bh=s6C8oFBCAS1Rzz5fN+LNN98ylpYfGTQb0+yzKefmhMs=; b=H
 +eFWC+CVMPELqITzy3sgJcGumrY2ycZXc0Quq4nTKwDCHdUrrk24e5VpRRYl+i2q
 zV5c67kiwHdtKeMbEHaby/0qwHOfQnaapGOtl05xPae+yx/+FtMqNbc4E51R/U0p
 esvf6WWiK+6JwEa0D2iNg/jDM35fFtSeNfeyniBHZBZfa3BNr9X5Cy24kDb7iiop
 Ni1XNB5ie+WOs5riA8trGYRpZSStDXmuNbPe8KtY8S0UARENLpGYTs7caz3lzR+/
 U2sUMKH6jDd4wYYbjK8Uz4pIKrGof68eZQFbAgU+iMEcBzp4Z1K8AtdmqV1QMYZE
 y06cZgi643ax9IwfXkFJA==
X-ME-Sender: <xms:Hhw0ah_kuH9rtYoYtj7rDHMQHbMJr1ba7tEEY1u1XevIzH5iLiQ_7w>
 <xme:Hhw0aupUPbFir6blQRwV13VTkBwPjmUT1rWqGLYqrIiJPzOrLfF7-1GpAhtgK4NAR
 k0ck4L-YOsDvs5vclB3qibPb2XeF2GC5uyUBiX9RMZk8pVnfab4X54>
X-ME-Received: <xmr:Hhw0aqmrWBsuLpZzAz3qu0JGqs5FXGfmDP9DBhK_Sm6sqjKx-ecbGpnJopDmQiFlgVDzAKla6NA3IwM-pbM6QQy5gg>
X-ME-Proxy-Cause: dmFkZTFP8tCIFjlmBKlQ8H/7ei/NFmFq26hZfsA/Oj59WEs5EaMdev+EykJmhCqt93lF5+
 XUbwmCPhVTJumAi7SLcWT5RXKMafT2SVhx2lfEgGsfSeyXQMR+7TNIybreOuAVcbjKdd6A
 RXl2A/2JhEAxCh5Un48cTfu3Ir8/s/9sXWioxJnmrWsLP+Qiw3jKumGV6Pefx8UNTjU+yj
 brqTD355WSy+m5Uvzpjx5bZfmOzjWM58a//Aa9yELXY0Q/g/TSk8Ox6vreyWiTEYwShMlN
 l5LmN33ltudOB2bIheeDi4Itxyi+8MVauvRFirWJfoYqXv8nnkHitz/jp6Y/CAHxq1e/br
 mnsD3OercMn3sRjVS2lOY/QubR3xQ1cCOnssgUC7snmROgkoDcQDkAFsU8N5M6yJnbBRJX
 l6PRmjdQeAbaGMCDNHI8YoP/w71olQJXwsnTERl5sitiGDh94zYOvRDXSHIJbkfQ/q9P3i
 bE5uvYDVizXfVKlOWqJ9hfnBz6qn9b4PUyjPGo7+My3wv2aADvEF6CIViFpukiGTbPbRqN
 7+yce9RHZY2H/tnMvlhp3wSjrDjOYPloIj/46Cpyc6CRNDC8CKaJJt0q+N8cu8cjqglukx
 C8oipVR/VW2EPTFOHduN3bZyUaoVF5bUShNsioGgfXnTidI4e+ldzv0H/vqg
X-ME-Proxy: <xmx:Hhw0alguOBQ_cO7SPuIPyWCZtoqVvwnQ-Y_NC_d5UPvJodEQof1edw>
 <xmx:Hhw0aicmcmeQWQ9h6bAttTt8r2S8c_qxBNt617KSQpPBvcK5A6c_XA>
 <xmx:Hhw0ali4wntYrdawOW39j7ptkQdOtO3K52wWwGfe271PcVMRIEt5sw>
 <xmx:Hhw0aqxcHUv9G8O4MtHar951djAIwl4M2cRufEndeta5aIPEDzxXlQ>
 <xmx:Hxw0apUBQHw69xc-6XR0-BiIC4IWCKQ-s9kh30J388p9o6QmDnmr8G3Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 12:26:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com,
 Stephen Hemminger <stephen@networkplumber.org>, andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 1/7] ethdev: add header split mbuf callback API
Date: Thu, 18 Jun 2026 18:26:03 +0200
Message-ID: <S2CuFF0sSGW_kdQEDd06JQ@monjalon.net>
In-Reply-To: <20260618144442.312844-2-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
 <20260618144442.312844-2-dawid.wesierski@intel.com>
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

Hello,

Please use --cc-cmd devtools/get-maintainer.sh so maintainers are Cc'ed.

18/06/2026 16:44, Dawid Wesierski:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> Add rte_eth_hdrs_set_mbuf_callback() that allows applications to
> register a callback providing custom payload mbufs for header split RX
> mode. When registered, a PMD that supports header split is expected to
> call this callback at mbuf allocation points to obtain user-provided
> payload buffers instead of allocating from the mempool.

What is not working with the current API?
You can already use an external buffer.

> This enables zero-copy RX for header split: the NIC DMAs the payload
> directly into application-managed buffers (e.g., mapped frame buffers
> with known IOVA), bypassing an extra memcpy from the mempool mbuf.

Do you know the flag RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF?

> A new struct rte_eth_hdrs_mbuf describes the payload buffer (virtual
> address and IOVA), and the new dev_ops hook hdrs_mbuf_set_cb lets each
> PMD wire the callback to its receive queue state.
> 
> The API is marked experimental and exported with version 26.07.

I think this API is not necessary.


