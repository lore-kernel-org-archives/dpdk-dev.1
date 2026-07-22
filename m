Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E3AC44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 14:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7FC240270;
	Wed, 22 Jul 2026 16:44:39 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 6F91D4014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 16:44:39 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 0DFCA1D0014F;
 Wed, 22 Jul 2026 10:44:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 22 Jul 2026 10:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784731477;
 x=1784817877; bh=sShLXu0bJdPLwTGPkmyRJ1IZC8I9KmGlGTNaEsnuvv0=; b=
 UXtox18oSOzA+4QFi0oYxng1nwkGVY52RVECRn30nqedwMTmm3hsm5RRu3N0HIQR
 tU9ao5g3LbPDT6MvxwB1HhUbwngqNXb+8p9l44WVh/GLD4J0dGqiLacZ36Mk1Zb4
 lCxGUMa61DsGuS+8WgjQaGF4pUyyA9YsgV5iWnVetVP/9n7g7AixWJeXdBDTxt9M
 xlZx9IhEwhD8OmICzS/I7swE7FSm0uenkN/+/ZPWHr7jx4Q0aVSeW+FsqAwV+XhP
 QCNctpY8GLZ+vnuXUjqhHmomRl7xXKlFA4DyJc/ENAKEhDLaBrvVn1qeeumIBgEP
 k6mpDiKQvR0qhIXLnS2C3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784731477; x=
 1784817877; bh=sShLXu0bJdPLwTGPkmyRJ1IZC8I9KmGlGTNaEsnuvv0=; b=O
 BLI3oTVBytqlMshZuG1j7MRzEc/QYtNXwjcOjWJV0Sizv+dxls/o6clMiZkPJAkL
 9IkQKXWOAvrrOmFMp8GWnTwFqYKAD/OMqrsYiMVnhFAObDonjHhFLZ9MYTPpc/Cv
 tw9fXkXW11dcGAXE40C0hBkiqafaz9y6R4JkHjMun7jE16TMcmLE0Lr0MrZcI+4H
 SHkCD78HNYrUoKRPmjgZ86fcmZZdrPZKnxTlrRN109Efzio1Fg1mIYDsXjNC1xM6
 oR1n4XbKZxvfR4snI9Hdg2z8grwvtYFijRh+B6lUpI2y5GipcFQCyAW23ULaQx0+
 Du04fR/LGTCMtg4A9HeAQ==
X-ME-Sender: <xms:VddgaonhzCXbdiGAXyvkzEw7beGmS3zgeemRWb7JS-QWlb_KbGqrIw>
 <xme:VddgakIK1KQ-t10Z88QqHvF8GgkShQj9FcPnoXsDD6hm7wxwpVJLEvpvvFLQiK1KR
 Pon0OfL1VF4DHLF8ih_Yv7yROR640Fat63U-4KcEx0Lc13W0JS9Paw>
X-ME-Received: <xmr:VddgapazVm8uszkzRPkB_3rzdSqocLnT2n8nFukXHJZmCB2YbSEaVNJ9udX7w8PABSa2cT_FdGJsl9kuzVgG6dB0SQ>
X-ME-Proxy-Cause: dmFkZTGI0g68CjyVgMnXq423AP1G6t3AhZixfuQtvcArG8b8oHfnwo583EpIjsOZAJDTTT
 SxYOnK96UwfpI8K8kv6mihzMLaNgkeYVclS0tyWjHcJVw4yL/SYTq5DP1Amc8tggzyDbpM
 LKUb4WSfXNyL38lNuQ1U12F+8aB49634kvYeZzwnMI/C1dv61GQsB4JIUVyyZTdoWhkC1A
 5IqYITSvlESwVVdYQfWTXQTU4tglDFDj35Wr+CnvF7kt2lr3AVYTIc/XBrhGYr8jYAlm+W
 wSB0voGkEbpzmODrH3JOXF3eIJADYEuBCyWzlp5Rs50Rz+9D9yVgybmf0g1fl4z9S9ILO6
 hzPqmVH6c6jUBvh2Y6rijudqyh1UwUz+3LyAxvgNqAWOvehPR3IxvSbWn09eqHMDORZgF0
 Lr6vM+lii89OV+og0iBp4cjDX5ooZl9xJ56191JkZncrHytwniJ4BLw9+bu7AnxWSTMbLc
 Exomc6A8aM3uYV7t9uHgLzKYX4/MecRLtnH7cACwKLHu232gSwYfTvfvibKlTZK5wui3Nb
 2daml99qLxomA91WkVwRUq/Qd49qQ09YSKqE95ykIKYCICvGm3Yitxt9getGQJfTGLgjci
 0kTQM8KXRnGntPZFc4pHj1VkSA27qd6+2op8mQLUJjqdsnHiDWLp12KQgh3w
X-ME-Proxy: <xmx:VddgambaHsgZ7RsOyGljPuxDlU-eQNqAGhLDcRn3BArEA9fdPZTVcQ>
 <xmx:VddgapmXq-tdO6T0KpjH-JsZDrRPqTekiKWdKz2lpR1U4LxdkARrfg>
 <xmx:VddgaixLKRnIsWJPJR2Aej3Sll3-Em8q7YnAa5V5Jn341AIGRcIeYQ>
 <xmx:VddganMHdS4wJY5h1VQd9fk22C7jOKQVmeYjGaRd1iwK_R1s9wrzZQ>
 <xmx:VddgaptzDz-zLf7Cj2mLlFI3005h2SE9yMnKSBVUSsnuCOStUwYcC-gU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 10:44:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] doc/rel_notes: updates to 26.07 doc
Date: Wed, 22 Jul 2026 16:44:35 +0200
Message-ID: <wQTh8neDR0SZEvrUPWcAfw@monjalon.net>
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

21/07/2026 17:13, Bruce Richardson:
> A collection of miscellaneous updates and fixes for the 26.07 release notes.
> 
> Bruce Richardson (6):
>   doc/rel_notes: remove bullets for single items
>   doc/rel_notes: move mempool change to first item
>   doc/rel_notes: keep library updates together
>   doc/rel_notes: fix driver ordering
>   doc/rel_notes: fix style of API changes section
>   doc/rel_notes: minor style fixes
> 
>  doc/guides/rel_notes/release_26_07.rst | 143 ++++++++++++-------------
>  1 file changed, 69 insertions(+), 74 deletions(-)

Applied without patch 3 as discussed,
and squashed with comments removal, thanks.


