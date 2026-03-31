Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CAFF60F4
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 17:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3D64406FF;
	Tue, 31 Mar 2026 19:32:01 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 32ABE40615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 19:32:00 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 829AB1D0020A;
 Tue, 31 Mar 2026 13:31:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774978319;
 x=1775064719; bh=KLWkio1OKeRdxxiGE0w/X7UV+sSR3S8/rQ3YvD8iZL8=; b=
 FYpCs1sUWG75NfTjIFcGukY8LyvdFq2WcT+5KGDz5e7H7q6dXShKavOeD5tv5KzR
 GnBVBsZKKW6wELqQqNBTZ/uPPpW7j5eUkpBR3sIPAj7VhSM+h3sxxEgg97EpDtTi
 JDYATfFd7G/A+R+k3xkeGwggPm/wXKycA67URKTLyZ/SONgpmiXf9vgiyA5GXE1D
 /Yno/nEEM19D6bPErstjQ2S1/xFp4JmNAL7kHzAob2uVm7YXuXweoJPsErzRWCcR
 vXEOWPaNulWvvB5mcfC+ThrtP2LDletat/8lJS65EAIoqX94GKosUAQ9aIcI2RDq
 zEPp/Qb0ctFDeYKqYMIhvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774978319; x=
 1775064719; bh=KLWkio1OKeRdxxiGE0w/X7UV+sSR3S8/rQ3YvD8iZL8=; b=b
 Cv5UgMx93I9IxzThCRJc7FpU8jwqQRnBvSzRI0bFh9HoGYkw8NREj+BAWMuZDuuo
 InjVI+eNjSmwIHiQMKGzP7Bj22lFNKksg9anF9d0ZTh+u67Hf0C+PT7pwNaJq0Ts
 7bu1O5OQey+QzRPgM4ubkqownP2YM1UgotkewHd2iaCJALVXk3KlVr4TtmMtKZlC
 aDKQuKGi/t8nQ8XC9xnn+Rk7bJWSaGxCDDIvGYfLSgqjJpFwMiVfpNEwDSUyBYTO
 UuuidlnsmyA1bdZcfrdxrVc8NRvvNjLkibj5jREz3H35wrE8uSV1owt3qEBamZ/x
 5Tqzmw7LGD8G3NhaAJi6Q==
X-ME-Sender: <xms:DgXMaarCk8-G0gc7CinDMr1Jnbk__Gws60KvVHONjTF9pcyFzhIMVA>
 <xme:DgXMaU-LMcXGE1O_X3kPs0aXAUl698MUCtUVu9XOFqNkpdQP6NaOPhl35-ELlntPc
 nXJPoB3nItSDxauFcwqkPlGKlcQPoFi19yKoaEKh2234DRGT9IHzQ>
X-ME-Received: <xmr:DgXMaR9UFHdY8NJDIgyIoI8NvWy4vvoYhcvNKvzt9J-7N9qQLHyJUocwclclpKSi_S3OOvIISNC9gCe-JyvLxcAJ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumh
 gsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:DwXMabtKYz4XEVqSYcgThA7TuNI3wcyCHhcpqg7Uf66qHGOJF2Q1Og>
 <xmx:DwXMacrJFwgQWrIixlSllCaWmxbhLNEz8UAfvQGVk-UKKEa3ZZbJmw>
 <xmx:DwXMaQmwfivNZKTJcH3ExS4oVqFlRsFARaLIE36dS3UIIWCldrrwww>
 <xmx:DwXMaYyHK1cCCoxRGi3ZA2OcGtbKp--grqBrKpn8Jsmi7G54Omap7g>
 <xmx:DwXMaTqrhgNKEhht-UWSGSt2EAbHEWYW0wL8pmLjziJ8a9wpB-AySsMN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 13:31:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/11] doc: Linux Getting Started Guide grammar and clarity
 improvements
Date: Tue, 31 Mar 2026 19:31:56 +0200
Message-ID: <2374384.iZASKD2KPV@thomas>
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

16/01/2026 22:06, Stephen Hemminger:
> This series improves the Linux Getting Started Guide documentation by
> using AI to correct grammar errors, typos, and improving clarity throughout.
> Split into multiple patches for easier review.

Squashed and applied, thanks.



