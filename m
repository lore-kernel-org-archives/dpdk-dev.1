Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B4C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1294028B;
	Fri, 17 Jul 2026 10:14:00 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 632E94028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:13:58 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id B14D9EC0105;
 Fri, 17 Jul 2026 04:13:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 17 Jul 2026 04:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784276037;
 x=1784362437; bh=lEiqzDG/RWcuI4m5SVJBaBNoCgETY97c0qdpAic0ef8=; b=
 HM4y7U5rogqFrFBmXEja5NUPlT4aAF4yu+lkc8pg5r0UWqXwCGunDYEcMktJ3RsO
 gjXPQY5dqKg5G5VY1iKizdc1MO4DxGNjKvufjYaqU4yBNGIP0D7Uq+ZBMkG+PRCv
 gJzN3jCEIOvSHcFwy8CmO17486uXTEReXXKfwImLZJR+SPeShnk6jCDbF29mbkPp
 hG+9sO53gjMO7mhLbop4enB5tHNq6YqIBNosUVoX5X1mLqLOOx+c2nFTSGFMELqA
 UfbhBKU0SIpiHdDE10BcYOF8wgeA6ZnpVKQbg94mtTWcIzMrqjgmNLfrv1iPaHNJ
 RCsO8ic3BmUn2dqhYTSjkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784276037; x=
 1784362437; bh=lEiqzDG/RWcuI4m5SVJBaBNoCgETY97c0qdpAic0ef8=; b=g
 llU0l12EU7AouPWf4iIpoTve/PJ7uye1HspWLjna6Iu1OFuQy9bTGSmqsz+9qPRU
 0C9dhBdsmGlJCvxhg4sUvC4ujplR3Hh5JrzfxdfiWQ/uw7zRQRchtKFa+S6SeAXn
 1kbUHOz2awJ33nJc/gXVKecygCkoWFDOeshzsEw/1vA2QmTjxksZ7+p41b74M5vk
 yEtLqiXoSsQzAwtgA5yqAM4FU7jlI5Y4riYKQzijCHKJyUHnZuPaOrYKBfUr3s2i
 ypBqQ+4J2cCUobBM2g/PE+/xGbqGFurE8oNoUfeRs2Wj7jvUF7U5faRiJQemd8o2
 54GpxakuiQTistPa6QgYA==
X-ME-Sender: <xms:ReRZau6VQ1CQyE0qJu6sj2gbvcEQw9CWglbD7IGc9V5HDGYrMJTgYA>
 <xme:ReRZasOVeh7y8zxEGYbw-6ac9YUKPA9FyelO_x_t2s-5eLmNjLO_MBVtkxCZ6Q5zp
 eyvN3C06pCxUV7KkLGH3Z5Ulocr_P-OnFlKJQ0waLJN2YXbMPNe>
X-ME-Received: <xmr:ReRZasmoFyK5vu7BIIm8061ZJ7WGDQL3d7N3IIrviDwLiroJsRzLz54_b2bscHZeEEK5ys3afO8ElIciHg>
X-ME-Proxy-Cause: dmFkZTGDSerV1/v/r2Gr07Lo0B5BKadElJmXWFybdNYHG0mSHV2Odv0fmH8xSDTf09XClq
 aAce6bio1M+xUoHPGnRLVDG7OoOE8NLXjiGqD2kDtqZ81P4f8MdPQ0nhs4LM4ohlJOJJZ0
 YYS5NcJinIC5quwH721hvPcHQWbV9YCxJgYy62JStYUekUznI7lxcpKyt899geVNA3XtcE
 uN1NejAJBLqHR1FEqgyRUrgXsxZfjj9jqJy9PFGF7tz3RA1/cVRJGS5z9zY9+KGCXolrs3
 iDRb6uwxihEXjklkgWi0XT7o2zFaCmsP/z876rjTb3sdkCs/3jE41OnLFfg4O+pXNJ3pNM
 aObZyqf/2y5L4jw0IgrbvBd+330JsCOmnkQUDSqwHUY/DoYaZINh70ybxM5jQKd3LKaOm/
 JVue37CvrrcQecRkI/Hvd//w3KWNSVoxUKdPw21MyT5iK0v16l8g/rmSUDe+Jm0F/DB77L
 kZsB0KFmSCRfWn2cFhmFfLNTRJRGAjPXuRrHi5ieaJrXDCSqtZYgHeJ4qh/XRXv9VrVwtB
 s710JV1PyZI+RiqwO/XRt+1oqDVAHyW7+cehGc62lZj5vEA41F5e9iIRfIrxPyFqMZLmXc
 QwemvFMAHGPwLFPseURLXdUp5IJGLRRf+wShLxEj5QhmMuh2CiT7/G09iBBA
X-ME-Proxy: <xmx:ReRZajRr1V5-tqkOfyLQ-z-CGpbjgOTwXrL9fxkbJQ_DAfzuNiwFXA>
 <xmx:ReRZaoBlnT8iqYDWW4BoMp2hke4NjFfTt2gQfDjhyc3llu13ctGYVA>
 <xmx:ReRZaiS7__mLmLjgIlSt_x9BvGiB4F38MlMmocM6qsDnVaXoMXr-tA>
 <xmx:ReRZauqBlluErNTIB-okc4L9Sm6CWHM7SixtMal1XfG8kS-IGlrX4w>
 <xmx:ReRZaggmuZ6OzHdl2BnfqJ5HH1LFv-QXwiWt0Hxa7F_Gvf7rZUbNN0Nb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:13:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v3 2/8] doc: document rte_os.h
Date: Fri, 17 Jul 2026 10:13:54 +0200
Message-ID: <4fzQ93JqRAO9h6zzYW03fg@monjalon.net>
In-Reply-To: <20260707085048.15295-3-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260707085048.15295-3-marat.khalili@huawei.com>
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

07/07/2026 10:50, Marat Khalili:
> File rte_os.h did not previously have a generic version to generate
> documentation from, but its OS-specific version was installed. Since it
> is now verified that documentation is generated for all public headers,
> add a generic stub containing description of this file.

I don't understand the benefit of adding an empty file.
rte_os.h files are defining standard functions which do not need documentation.


