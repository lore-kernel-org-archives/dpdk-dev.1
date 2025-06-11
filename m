Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334CC678DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 14:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA44402EA;
	Wed, 11 Jun 2025 16:31:44 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 8D49A402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:31:43 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 2AE1A138049B;
 Wed, 11 Jun 2025 10:31:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 11 Jun 2025 10:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749652303;
 x=1749738703; bh=vWOwQrmkJEJNsVXrQrfSV0N5TRlxp1eFdYB53vc7+O8=; b=
 arvJhHIoiQ6lpZJlxiDLtQ96ZnxsoveuVYIwoSjI2VA/S+8ZVZtShHDn4MUI4xxC
 tzSmmKGWp+bJVINCDV38RtR8wIoLt9Em8LQgdlWtkpnXeFZRpcER/ZpxADp7Jk2u
 wfWqlhisXBKmYtYliSUgt64XogOeLPfPF8YyJzzCYOwfyeZj5SzyA9yy+oyBb61D
 6bOHcq8TgBJoDeLYONSVzJ/i+azMstJDfcqT2aKlH2seBk/F1h3+wsPHm2I0z6I0
 +g59WCcFZHqSprVgUCdfP622fbieT3hFWdA8yg3XfCuMVJSCuOwZLL7dIV+eSdWN
 hj9Zzrf2Qb2baNeSiuA7xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749652303; x=
 1749738703; bh=vWOwQrmkJEJNsVXrQrfSV0N5TRlxp1eFdYB53vc7+O8=; b=H
 vvraRNNu0L6Y0hbAyAyzg1ZIhnNc0YeeB4Btr+QKf+/7W4cQqn5H8K7+Cq5V6+Yw
 vFvVrbHlAtH445+6Ou9JaJRAcBQMH0n3tmAdTm8bFd55dF2PQ8VWrF5yGehSrO59
 Vn7VgItMPbqI6bmFZhlPHjW+Sja18QDjVQoep5BdR31r9X5nv9lyJyFfWhee+aZy
 nyL9tONAH+YeG4DYA0isxq7ZdAZgtLDdlKc73+Mhs24Stiwbp4+niij9LOduXEul
 +jo6QzL9LARTVbwfsPiogytIWwI36SuVZeI8JZ5Z13GWpDRMhXr7VdU8lPXc85tL
 hATlHYW1AKgzul1P8/kaw==
X-ME-Sender: <xms:TpNJaOHkVAooXh9AZSm6ny4l-Mu0d1-XTeJesjJQb-NrmmjKfLeLoQ>
 <xme:TpNJaPW1KRHKUOwNDlGun1OrKDpTm6qM7UwUAx4cDvNGb3vGUuen4IpF8linqMJO0
 N6GPhw3vh9KE8m3ag>
X-ME-Received: <xmr:TpNJaILvePMZH5FeyKNPHlLU7YfJvyVi0beoN56Qz_p_zaySg738LZg2vTiq7l33PnsLBtAlXzqKNCT8HjBS66_IHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdegfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:TpNJaIEyaB4HoPfVtuoX8POakEE0Zkt91beOkIMUhCJmDFfxiMGocw>
 <xmx:TpNJaEUr7TgaknQ9wK1nxxyBwabU_06C-K7iqx7WYhL65IzTnta5ig>
 <xmx:TpNJaLMGXoyZZCJfQbUzTHwCIQLar-jZnOeZfUTEpcFVxPHGKEr-LA>
 <xmx:TpNJaL09rxd3xwrdCWHGQdjTtoTnAiBP7uoeu3mtAZW__vrQdjtbSA>
 <xmx:T5NJaHbT6pZrF37-ugmNTbToxviP_sSlrtimKasRXz7MyNWpNFt32CO3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 10:31:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/15] fix insecure use of memset bugs
Date: Wed, 11 Jun 2025 16:31:40 +0200
Message-ID: <13352429.BaYr0rKQ5T@thomas>
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

> Stephen Hemminger (15):
>   eal: introduce new secure memory zero
>   app/test: remove unused variable
>   eal: add new secure free function
>   app/test: use unit test runner for malloc tests
>   app/test: add test for rte_free_sensitive
>   common/cnxk: remove unused variable
>   crypto/qat: force zero of keys
>   crypto/qat: fix size calculation for memset
>   crypto/qat: use secure free for keys
>   bus/uacce: remove memset before free
>   compress/octeontx: remove unnecessary memset
>   test: remove unneeded memset
>   net/ntnic: check result of malloc
>   net/ntnic: remove unnecessary memset
>   devtools/cocci: add script to find problematic memset

Applied with a bit of squashing and a release note, thanks.



