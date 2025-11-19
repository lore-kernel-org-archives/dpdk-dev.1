Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29239CF2573
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 03:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E341640265;
	Wed, 19 Nov 2025 04:54:08 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 915CE4021E
 for <dev@dpdk.org>; Wed, 19 Nov 2025 04:54:07 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id B13B21D0015B;
 Tue, 18 Nov 2025 22:54:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 18 Nov 2025 22:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763524446;
 x=1763610846; bh=RnfMlbGbV2tW5zFsn+/k/wJmcbQQ/ARBlonEyIEXFbw=; b=
 Ik6xQMZVEVsBx60J/Dx1L0Oq67k8nANahQsFem9ozJ5eblj/FQvHTq2W8rf5r40s
 xxeNDfC8u0nSa8f5FrWFckWQCLYkZTKyi7M13ML20ktzC2LtUqDw4djPiErf6KuT
 xlBeAAN+JtIazXmSbXawI0Ixw2jhwltEORfDEna0cTf5BETmUZ8/fO/MyPzycUS5
 RtwiDlMjAJ4Wt4h/EpYfkTpGW9zA1gz52/3g6PfjBvDivUigLv+DLiOTdg+7x7bR
 eu467zLG9EjSgSB2zl3MiH9xWRqVpZ1Ax/gGFZPJE5CGDFvnLRzHiff8MUf08EEZ
 rs31GRdERqi3lbjrOTUkiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763524446; x=
 1763610846; bh=RnfMlbGbV2tW5zFsn+/k/wJmcbQQ/ARBlonEyIEXFbw=; b=J
 9Ii5r8D5COV8VUIM4aA9zXaggH3qFVXQbfr1g8lCYjcN+ObSS5djs50vvjft1z3I
 0gamph39yRxmiGM2jmTDoO4fjwyVmfi2lC4ozT47VmcnhJ2SAa9iqkp4xtARDtzl
 fiamLcS457Hb+DM/boQc5ds97fLe3louXVg/j+EBhIv+XSr+WTQeebvo+Phb3u+6
 lhAzBHEFecwH+M/p817wm/CXV84i1HibYbG25HqmzWirfYRJdtpt2k5RLOcBDtve
 0qUCnsuh7aiK2BBfizuxOXsF6WqkFVmA+nvc6xGRC0akdtDsnEbByk0G1WxfJ40P
 /KRFKtPpAo3yUkEskTekg==
X-ME-Sender: <xms:Xj8dafsx0xG1LjoIaDjQoLM96-P3HTpqHsA7MRd9IyxsyFxwdBvpEg>
 <xme:Xj8dacy24tRuERusmKQ-dsdo2i_scNv7Vejub_GVOpSUH2rkaMHeNbKbuXKwlmcmq
 QLKdg7pbiq6t5XW9Bs_rzsvvqxount_9Sy2SD8LLPelWJumOwedgg>
X-ME-Received: <xmr:Xj8daVgm0s8KjXv227bBpb5A70mUihKqN7ybIpkO10DWLi2UnaSSGZF7lK6MIOVZANbcTEGV6PLRz2bmYvvK9lr-uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:Xj8daQADoczmfb1Vy1XOxbsvunDOzy_UQoRoKeDoJOnz1ONh-AC6hA>
 <xmx:Xj8daSs9icEMhS1BYvZ1JBjvbobz4AYV4ioqITvhQvbegI04h7B3zg>
 <xmx:Xj8daVb24YnqeC92FeErxtkdioP_VwVxxBXDlWRMyBDF0Hv3g9I08g>
 <xmx:Xj8daVWklU1gOfiUGUJJd1MgqMkf0wkk4jMFHT5kE59oeGlcw4Kk9w>
 <xmx:Xj8daVM0t7g7-J-an66dQ04H4RNkR_lUtMa4GLYZ6bszOkXOM_-j4vkp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:54:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/2] BPF tests
Date: Wed, 19 Nov 2025 04:54:04 +0100
Message-ID: <4499844.QJadu78ljV@thomas>
In-Reply-To: <20251111225719.540140-1-stephen@networkplumber.org>
References: <20251109200854.45942-1-stephen@networkplumber.org>
 <20251111225719.540140-1-stephen@networkplumber.org>
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

11/11/2025 23:55, Stephen Hemminger:
> Add missing tests for BPF file loading functions.
> This is subset of earlier patch.
> 
> v6 - rebase to main
>    - make sure that -ENOTSUP is handled
>    - remove duplicate includes
>    - combine all of the elf tests into one test instance
> 
> Stephen Hemminger (2):
>   bpf: add a test for BPF ELF load
>   bpf: add test for Rx and Tx filtering

Applied, thanks.



