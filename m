Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2616606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=bfGUSmgp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QfL//d8j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF26F40679;
	Wed, 21 Oct 2026 12:42:44 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 4DDF340041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:42:43 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 95A0FEC0257
 for <dev@dpdk.org>; Wed, 21 Oct 2026 06:42:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 06:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792579362;
 x=1792665762; bh=XJnmaDDsds8GD5AAJD/zNiT6B0tZAyLEnnyIycomwp0=; b=
 bfGUSmgpXm3Ut1Y4LOFHJnCW1L1aGnFwJN/6eNcfT/YN6NaqkORmLyIuo7A7tjhb
 QLxS3pBaiMBvT4/MH8FnKrP7ryhwA11dcSMepKlRkufQJqmlZ90KlaNKWIEdNbFJ
 5v0OKxNJYnVTygD4HyX0Js9AMePRIe0S7E0qo4PJx3tYgr4BGIpLoDqog4smwzXg
 PXqgeKF5ZVepFzvpagOTOmFa0UBnbus7DvILC2te2Q15IwGo1jgKJF9UAAE9W5X0
 r5YMTSp8Uyy8M2pIv2cH5oeik+2MWeFkAbXVA73RTXa3uKdbalgyIyO1kUK8M+6M
 WYsWbjRvCWZPSuJacbX5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792579362; x=
 1792665762; bh=XJnmaDDsds8GD5AAJD/zNiT6B0tZAyLEnnyIycomwp0=; b=Q
 fL//d8j6HTy7XFVfaNZjVSF4HqIg7+G1Ic9L1vZrkHe+2A0sUI5mtnqLkxRTAinZ
 IALs+o7/EDfHK5N2lZLuBlJPqibuGDKmhmchPeWSrX718LBFSvxEt0LixsBbzuj3
 RloJ2lgsB1SN/YLf2HLbD8weKEEKoVryVS+6vLL1hhhhC/tHbzd+DDD99qQcL774
 z5Tv++4TD4npaBh2h3PNUAUucPSr2C8UtrP0dkMqpZbGzP/wXcZJZOMtwEDzLum3
 HiXC04o8X/FHxOTC8qzjQ768oxumfc36anaK/m6gka9eaOAmKKJHoRSYmSt64x/u
 PJbZQ7hvcT1kVultBzQwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792579362; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:CiMHSKn7thkZ22ml4LzSZKK3umpUeZgziylYJS2Oz4nHfUg
 u2GjSUc/MQxR8FOsVOqvvFORzwRycDw9Y+AfaKTUgnfbzl9SWNPDy8yoRiJwO6lX
 HR8KZp2udMIFzmEU55MLTFJ70iqu/PjPh2TvMYZphq1CUzCKyX14STvQdm++rRzj
 nOa41nUdp/q6VG8Bn3652k5abkwD6gcg9G6Cn4tKdOY9XqIwvt05hJ3OWT0yPzSn
 TyfBvNhXX1D9Q5qiKQIUb2N4Na//8zwonHKw4vqGmeWixNFKfrRPNbMJSKHJqjaP
 pF47BA9sF2BZ6QXgMU/lihYUaOARMre++eGLH0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:9ume8++mAPhyyUVB9M+QZDFrC7YIcvX+VxNOF9cedH0=:gpj+t+GTWlbmMO3SvMUgGybs4GXcFz3eV4/Cvfc1lsQ=;
X-ME-Sender: <xms:IpfYasalJzZn76AVRxdygVKYimrdsROVs8k5LImbVCGnXeBqBkK-0w>
 <xme:IpfYartk8dFv2ciYxLjgN0gmr0rUoN0FYgldLxuCknlOnWwFQGeEgseESFFP9WV4O
 iuUjnd9Cj7TvRrHOfQloPdvcwNbxmKcbatocj6XVktPVEM1CQ>
X-ME-Received: <xmr:IpfYamGYQCbGzb7fdPjNdcPECHMFruYpULFN7xu_MEanp1sMt2q_AFSf2Mqif1aAOgXoiuwznWoV2epLTs92nNo>
X-ME-Proxy-Cause: dmFkZTEsPaAhKXjEDtgioZLr+RnCquWYJHQEVug7xbGTU9yS7AiQr5kLAPoMfreC76qmZo
 ItYJQjaiSBMLBZPxXFmhT4mayJD2PeKLieFPnfBVovhQgsjZpTHfM12VzuKehFK7MUOJ6/
 88D8esc9SmX9xay7tsspMIq5EB7O7Xb02+4vox+znq2NNax+HvHooDUR0B2vS0UoO5+xwf
 MEZKO4lh5T4+VZ4yrmgzUmuEe5ZZ77ukPH/AQb14ffZvcK8XMu0xAfAqXlsRRTAqssN4ZO
 n3s4iHTrq22sqIOqYNXBgmPdATqCooNe4Si5XFjIcGZauS6lGeW5ZQ1VcMeaHU96V/VEci
 1bBYQW30ZmsDJMJnle0NSO3B6BwVJP+UYlUcwGMd5P+5P1pn5s0eTH6e7tGmsC3nqym44q
 Qr/iPI0kLoD6Q/rY3KIZ8PDRCDPpuMOAQDCNSThOyuZhlCkqR3jNsHe6+ZHO0vMpgUVmbz
 Rq+Yf1pN9deOb6ddMLM4CExXmY6lO6fhum95dN/EgsVE8f7TGAnni11CQ13rxZPpuCUjpE
 6tJHz/XUlFTW+uNW9mDtEb/ny9E4F/E0HKPRjaxfgGodVe52ON0DqeQBh5wNDphQaW5A+6
 hR4jodf7PjZ65lYHUODJkPKtIvWLtIqYGnqd7hdEDB8md6guIrHgq8YF8WAA
X-ME-Proxy: <xmx:IpfYauz-pZvWK4Ldxf0L_AmN2k3Df_ILPgyV8EYYUudoBvPBRQBCzw>
 <xmx:IpfYatiaw0bIZ6Pmax7cMK6umlXrs9Kzhwx5fhDaRlceZg4DYgk8gg>
 <xmx:IpfYapyBUdZ-tNgRZABz_D4CXLkCGkIXBhpkwzNsXCi9b2gqzCsFGA>
 <xmx:IpfYagLTV6mM1jtfCP2zmwjXGbm3Todll7Oy3sHyOb7Dc0R7XjHMiQ>
 <xmx:IpfYajD9v4HYbj4R3ewtAJQCqbbLdrOXIMJ7ATQtIGewBVodDa5GMzE->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:42:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2 01/12] devtools: fix matching in doc check
Date: Wed, 21 Oct 2026 12:42:39 +0200
Message-ID: <9FBb5UFHTlS3RLOr23pZpA@monjalon.net>
In-Reply-To: <20261021103027.2050351-2-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-2-david.marchand@redhat.com>
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

21/10/2026 12:30, David Marchand:
> The current user (rte_flow) of has_code_change pass what looks like
> a regular expression, while -S matches exact strings.
> 
> Use -G.
> 
> Fixes: 947dff12bcf5 ("devtools: check flow API doc tables")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Good catch, thank you.

Acked-by: Thomas Monjalon <thomas@monjalon.net>


