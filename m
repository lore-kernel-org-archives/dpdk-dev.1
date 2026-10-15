Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCFCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7426640698;
	Thu, 15 Oct 2026 17:55:41 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id B8401402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:55:39 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4A6317A00B8
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:55:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 11:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792079738;
 x=1792166138; bh=yaZtmTmV7nzh3+OQJSgsFdhyXEGuoalUAe17LqDvTIo=; b=
 MA0PAXtVahyMn0Y09zbCDUZtFvFEFC/rTZkV0IknvLXC2EWiGrInhuJDPg67Ojbc
 dmpqE+AuJhzFPs9OuDEXpmakjnybNto7t27MUzxm4tm1PW+YJd+g1vYY4ImLma5c
 NcvQtrexUskVB1ZM+EB4UrFwIz5rwPoCaRqDlPveJV0+t2fCLO+Fe/kfhdgnwIPC
 6JIwhVqwy0yEfJ8GjFSeLTVWsDzllaN0hJASRynnX9CzVyXawFjRACqB5WUkF7xe
 CoorkOXky3D18pouxZnj6ur3DqUk0+4tYBbLEcqE93zecs0b6oAwrFlW36zJW/Hj
 FAvvqttEcE9UQoM1iBdcrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792079738; x=
 1792166138; bh=yaZtmTmV7nzh3+OQJSgsFdhyXEGuoalUAe17LqDvTIo=; b=A
 hzIBwg4YBoLzoEGgM3/xlqWF9yVyOtqlQn8BeHGZKF/4Wxu7JwZ5LGzljUv3JRL5
 UKEvaCOyHdwCuVjNd+KZEBXmCV1jY2kub0F/jQAXucJT71x8EvtlPgXouxfpQPV6
 aDusVf+EhW2wgNK7Bh5kF71Ecg8KUD+c4dtrKAtdnfsTav1gdQ5737oEhr057bFP
 z8YAiYxVhu+Y+P3K0bQyg9hwwkk30Om/hbKhQo88LniUThWFrQ2RK2JpPtehx8UH
 6rcF5tbZHM9paUrQIigW8F056WLlYvxDaq6glomq4+SqOLOy9VkP1fzxdnbJs/4M
 m6Zafc5EK1eWDsyi1ZOxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792079738; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:hrP0jsLsQjxYbVoBSzdMyIFwC7uM9R2ci/+txnRwrGlcPGK
 eq9WX2yADdoicRQTRoALR2a+BDFaC4GVzjqOMykhYDuYyvsNgPgOxAOWUt2C3IAf
 3aonc3rm0z+KN/LMHyvngCx3yVrhdiDSySEoDJnH1yB9cQmXJtcJ+R3sVLmfMS1F
 zOy4O3aXHH4EcBzbDIiU5lchXCfygWEj0f+pLwXUtKTFNSsRgFbi31Bj88uu3jG3
 iGDTxvR0WTRkbIpA40WN+XciwBIWRXlz54mtIo2rIix/HUbweb2WIrKsywueqr60
 YAScurW4GmljFFICFlCxobB/9lFYpLETpgMHn7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:utolwviLR9vKxaSMkUBk7e0OUU14hbwTs9dtlooJqK4=:yaZtmTmV7nzh3+OQJSgsFdhyXEGuoalUAe17LqDvTIo=;
X-ME-Sender: <xms:evfQas_wt3cJ28WUQm9Gsap-xv1Egu_uP8HL715LOZsHT4QVFysI1w>
 <xme:evfQauzhzA4wpbtIvw3bgP8ILTxUzF9p8xwtzc6fHL_eoPoinZjG4rD7pzFSR1Jw8
 rIfKmFB_F3RtUBs-eTRyAIzWAYQyUpBEzloD9x-gT4MztHb-uidgQ>
X-ME-Received: <xmr:evfQah6VoMFXeNnZ3vxXFRZcTGY1Hkk6gBwZatM3djRrsT3JCmUg1tDKurd5wnv7mYyekQNEoaNODyVT96exgDg>
X-ME-Proxy-Cause: dmFkZTEkXCbH56fXxktvgxAvr0bmfNuAs98hBqgqOxVVF7FR/RKQ4MSVqwZsG4WqSb0fwz
 UHjXQJneIOS2F9wRydWk0O5AAGiFdoSwQUCzaCZXOcrEw4g/Gg37FUDn3W/444e72ejSrX
 Ibk5yEd8vDR2ddKoYRUV+F3qDVFYpw51fybP+dDBkuinFkjtNIo7rhJz1yZ27Kydg/ovUa
 YI66niam636ZInPr54l37707hBj30GnZL+L4S6whvY4mgyP4lrcLMa97ISQAzyMCaAo8kU
 Z6sHaeBJy7FOMwrPdVmXwacsvuINJjMEcmmbt00xVY/xJVsYf1HJf/nS8GDGPFC6x+7Jdu
 ZcsOOswYfTq99Ju/nG2d0lKOYLzDyCkJHMtSHpbFszw3Jc4uFp02IPSHnhZPj+UErmcmWP
 /PfR7iE4yFvUFz4x+ecKQVgqmGF1ncWj7mWBzjMTC17Hd/ydHK6nh2oi71h67cc0EOIJxO
 eOHNyNmM6VCqmKg6mnf2K5N33FRz56wmBLcmKNaymlhVJJ1cEeJLRXmBK6m2dFsIO36wCR
 /ZhfhqNSlVHs/Gi40VFP4ePupc+cmQD3bbAQLjUhyAXw3aD72IAVvVDmYszU7EF7khivke
 x5sVzqWNocEtoi5COVwFky/KvgdJT+jcr45ITSsRqU5LIOsjwLtAhZIBa7pg
X-ME-Proxy: <xmx:evfQat9sacH52tmZv-RMmvAEDB2yvTsRyUBHNc-4tyX48bQUH9M8YA>
 <xmx:evfQaupy1GRffkEFjae9ygiPmGrkNjZ9PQE2ExN4bfwQbSmYsQcMdQ>
 <xmx:evfQampHVB7FVdxbQx56708wHsKxCnP-GAyxiiuEAr-7a66hvxzzSA>
 <xmx:evfQap0yAoxulzr-oNcBQ1CFePlLhl8XSD-7SV_oo1-jTEPSRySOaQ>
 <xmx:evfQarZJ97sJs8ea9mWPfqk0t6B1-JglWJca18zb4Y6vknrNVe_XBxPi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 11:55:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: mb@smartsharesystems.com
Cc: dev@dpdk.org, jerinj@marvell.com, kirankumark@marvell.com,
 ndabilpuram@marvell.com, rjarry@redhat.com, saeed.bishara.os@gmail.com,
 yanzhirun_163@163.com
Subject: Re: [PATCH v17] graph: add optional profiling stats
Date: Thu, 15 Oct 2026 17:55:35 +0200
Message-ID: <MQ5lvJGYSaavyZFtug-8hg@monjalon.net>
In-Reply-To: <20260824111606.779723-1-kirankumark@marvell.com>
References: <20260823150127.490511-1-mb@smartsharesystems.com>
 <20260824111606.779723-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

> > Added graph node profiling stats, build time configurable by enabling
> > RTE_GRAPH_PROFILE in rte_config.h.
> >
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Acked-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.

I would prefer it is easier to enable,
but I understand the performance is important?
The idea would be to avoid using rte_config.h.



