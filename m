Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A05C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 10:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7102540289;
	Tue, 14 Jul 2026 12:21:40 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 949194026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 12:21:39 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 7FE9B1D00176;
 Tue, 14 Jul 2026 06:21:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 06:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784024498;
 x=1784110898; bh=B0dWs1Be2HmwRiiF1ULcqpsVpR8nc80uuC67WaRn1MU=; b=
 kOE+ekuzWMllYd1XfDc/INSd1XOfOSiuE0L9rn3p9+Zhtp5d6isimwgmc4GXxTOL
 wstgJ0wVT8hyq/Ep/c59h81jnBMfI7NRGNgnBJSxjHvwx+7d2td6ZAUEWWSA6ELI
 CiV7nJQCFDiAMn6OGs86J6lipYBGP0Oo+n23ZOULKfvMGDm6Bt8GFavaTklSDQVi
 IoWbDeghGqWEckY84bJTElFGlvdeZV/nzWjSvnTR+kx54iXWFfzYgsG8RM+JjMg9
 Arh2rAHkKwmkAlVrwWvE0//u1iGU+qjZJn19p1syVLlDuqSM23+vM2STNI3waOJT
 BN8QAw8rLwIxXx1xwvTK5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784024498; x=
 1784110898; bh=B0dWs1Be2HmwRiiF1ULcqpsVpR8nc80uuC67WaRn1MU=; b=F
 IT+EPjky5qw7cZSr5oxxASMBujWAIYNwtb2F5THXEXVMiS2ishrDuEfQIUu7TnH8
 OhgoRRKUOTKThw+ZpoSzPlrSRlAPXbN7gD3c4M8BUB0H0PS0lsCNEyOVLLSVrG3s
 HD5Nt9/XZwY8jFXw19WWDzxXWZnuLlYilUJN5nBcv3M/V5kNQ4Qk2sWmKS0X2oRl
 Db9dokPxns2yviWfecSmmVTtgxH9GESvFnuOenL7dCYyBBbaF1BJo9hrd2nj7CIB
 hykA6wzkLSClUM0dpiGBUJ6nypKDPnIb82A2ss3r61NIpUEm6AQgkDLgy58ZMTSW
 TtC5/iscM/vekQ0Jt8BTA==
X-ME-Sender: <xms:sQ1WalpSRnl5xepyk9muJ--eThiCrR0EiIPJv0QnUwQ9_eafYVOGwg>
 <xme:sQ1War_XfWWmFNaG-If567VYz-IwovLYTlnndSg08NCMxLogmslKZwTrrbgaJ9qMh
 OQjyzM0sXcoIP-fo5pane1aMe0CphvjjFN7yIY2ZNk2h02uN36P6ew>
X-ME-Received: <xmr:sQ1WahUpE6hnFvLmRsQnRO12PPdKHy2nRPbS1kNc8wvLqbX8gaqi6OW5S5oIIT2erbD3hWX6JtEAFCevaA>
X-ME-Proxy-Cause: dmFkZTGjGge60XM0NJYrFbrABUERrlnypDE5ANmXECbtweOv83CGdE103llPRg2FfESfAT
 8nY6CV0fJ8+hmHfBkqVMvWuynvM3wscARjCcS0O5VnuPzz2NuvpjFsNzn6bQslaNmMfB/m
 KZqazPbRrwM+HHe2jJM6ynNqyAxZVS/qhhmOdSx5U0eSppgPxjEF4/Co4twlCcBopsdjTJ
 V1966q+eIG15pfEf2nOfwl9PhBXzAHrvtZeTsaa2T7PfSK44AgZXoX8xNGjvwwrHWdbs4K
 eoqiRVYeR1/9vR0QfDM2ol0yY5rs6dwpmoE4tzV625ZzSi53hm7lYOq28yxDt2WriDiSbx
 gp9SxuYyTof0kzcfDlpQhvVkZmUZ93FfD4ccTre3ICVc+u8Ogtv4s0vlNkY8zrdel79Bwh
 ch+SnlG37UunAh/jxfN7fKrqxghDUgIhtR1GITnvslIZfOSdTBAdTp00MN0OqlS5Kf3G+C
 Z8rSEcUdD6CF3xeAElgS5Dx/L13QNMA6aqxMbxM8xjYDZLXc7Fkicjr3DAKt/Q2aS/6g98
 MYdMfyY6aouwmO0H8wZXIxUVf6UWD9PmSZxIDqFpqi+kb5jXqUw9G9pTjpHTLDjEhoBxbo
 hUzg+QTb+9GRS0pndNUUUOqbMGgXDBUxbTdzHx+oOJj9TfejMesu4GS7sCLA
X-ME-Proxy: <xmx:sQ1WapBTP45YX49F2fBpB0pK3KzzrsrXH_MbpjI5NnogO7U6X7phig>
 <xmx:sQ1Waqz8R5PPCRHW5JBHeumFszElez6Ac2q0e8zq2dlG7QM0fGNDCA>
 <xmx:sQ1WauCgA2LomxCkx-l70sE49AwT1iu9PpBxG3aZZZCbJ64exclKzg>
 <xmx:sQ1WavY69vbsVpq9lKraeA4eQU2FZhJ8Y8ofTPFuuYB5lJxItzsfcg>
 <xmx:sg1WanB82EGRT0adIT-4jmC-4uJ_O2XbEzbdeHWx3C-eR-fX0uaGENtK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 06:21:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v5 00/18] net/dpaa: bug fixes for bus,
 net and fmlib drivers
Date: Tue, 14 Jul 2026 12:21:34 +0200
Message-ID: <BuZHjYthSkqL9MviBfI9Xg@monjalon.net>
In-Reply-To: <20260713101747.2947405-1-hemant.agrawal@nxp.com>
References: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
 <20260713101747.2947405-1-hemant.agrawal@nxp.com>
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

13/07/2026 12:17, Hemant Agrawal:
> Gagandeep Singh (3):
>   bus/dpaa: fix device probe issue
>   net/dpaa: fix invalid check on interrupt unregister
>   net/dpaa: fix device remove
> 
> Hemant Agrawal (11):
>   bus/dpaa: fix error handling of qman_create_fq
>   bus/dpaa: fix fqid endianness
>   bus/dpaa: fix error handling in qman_query
>   net/dpaa: fix modify cgr to use index
>   bus/dpaa: fix fd leak for ccsr mmap
>   net/dpaa: fix xstat name for tx undersized counter
>   net/dpaa: fix xstat string typos in BMI stats table
>   net/dpaa: remove duplicate ptype entries
>   net/dpaa: fix wrong buffer in xstats get by id
>   net/dpaa: fix null l3_len check in checksum offload
>   net/dpaa: fix mbuf leak in SG fd creation
> 
> Jun Yang (1):
>   bus/dpaa: fix BMI RX stats register offset
> 
> Prashant Gupta (1):
>   net/dpaa/fmlib: add null check in scheme delete
> 
> Vanshika Shukla (2):
>   net/dpaa: fix port_handle leak in fm_prev_cleanup
>   dma/dpaa: fix out-of-bounds access in SG descriptor enqueue

We don't care the cause of a bug in the subject of the fix.
The most important is to reflect clearly the consequence,
the scope of the impact in words easy to quickly read.
Also, acronyms should be uppercased.

Applied with better titles.

Note there are still issues detected by AI but it is late
and merging in this release was explicitly requested.


