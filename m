Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C39CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:58:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E74B74042C;
	Mon,  1 Jun 2026 17:58:10 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 9E0A94025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:58:09 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0F2107A00A5;
 Mon,  1 Jun 2026 11:58:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 11:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780329488;
 x=1780415888; bh=CVkvL80dPtdACoVOjAUiBXqOPS5KPMvrqDNVDUg2sWM=; b=
 EC3vtWf1mZwKpxYDFpMnfUKwrFHWXhGcMFTRh29PAwo/25Gj845h0zuYG/aNAMKF
 rxh9eTFfz4GTyr7+koi4lxZejYIcQnjBRRaIK8JsSOmg9Pxs5R1AN9mshpR11mXn
 JJTwev8SlskNrViEodPph4ZhS38DKc6A5TsffKGClNFWMPk6BDDwwrksRvNCGmOA
 xNTWVMU3TXuOql08pm9ahQsjJVcIolgcEM9ODVnJxe5a1rv3XwhQcx2WboJdcmC0
 Wu2sYC2FU+0e2K8dPD99Ychrv4uUlvTgNb879Rermww1g1z0zQfbti5Ab9Ilz1ys
 zWmHoFOafrA5XTEkJtwBlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780329488; x=
 1780415888; bh=CVkvL80dPtdACoVOjAUiBXqOPS5KPMvrqDNVDUg2sWM=; b=J
 8tFafZNCgBjBZlbiLAXNSAMQVcgOmmWMNKhzsqli9UeKZ72FTr+jGowhfWBr0KFh
 jAsHdSRa9UM/97aOUAe9j1b3Kz9vSo5cXn5BmZRkgNEEaci92wWTBo+JFVrgXBa+
 MX4K4wI9yjuyykidsJw8bxzflpCNOMxHS9HmlNzB8mgmgoJG/GCPA3MRDFoSi4Rr
 omqXcxxLTut/OrNOEoUGs8UdZ5cBF53WIJ7FxYatvpyhG00WmaOvIprM/AoWp8Ut
 /WyEPzRBtJJBKEppC4aOh+ppBZNuF/OaJwu+boq/0ld3jMTz1ttr0G3Av9pZ+GZo
 pTzhGT5cIWybvDFaA/RBw==
X-ME-Sender: <xms:EKwdatNtCjDzk0dbQCdk671pG0_f1R5L5EQwQ_aIGRqdTFQs46Kx4Q>
 <xme:EKwdasRBS82FdoMa_2fEUkpuZnGOV7zn3GkJhQxBYs5tb0dJ8dLqWeJH28tBUkfct
 fvd-FuyJIg5VW_mrxbcgspUfyPIpX6HR4WXKX1AskAgcO8vunki>
X-ME-Received: <xmr:EKwdavAh0K0022UBAa4cKDoTlWcg2b7Q_Y8_QyXz_wmn7bbG2vghZB5hhbMZBlXKEXnJY34pBEZTryOPzeqPdaCwFQ>
X-ME-Proxy-Cause: dmFkZTGzaeknnQwAWrWrMOQp7sI/uziK7olLk7Yw29VHytuTjyutoU3X1NKX5ZIYwGvb0/
 ZOne6zyzVA9aND3bB7GaUmimPDOiAFvXN5bFMpTU1sLTdI0spH8QRlulg1H+baNP7WGjUk
 qr/wFQPmF4Apy+i9dFYSDc1fFbpAl3guBpmClBVeSvzUTNrlkgjKqLOl6ldFEhRHmZzUvv
 VQT8gRgZRmjC5mHrcoZ78okv2aW1h7FzGLGGjnFsbyhdq0/1+VUoTL5vwdd6FJZGEhOT8X
 EwzQf+uHUd6XWJo0CGqPbHx8IYX3h3hoLi/oAWQu2H45tEeKkB896+X+CJ0ms2nt0CGzC6
 sHQVZSi+KjxCqbw2HNe9w+zOFjJGzYMHYNrb7pXXZcRtVUyQQ0gjkA6GN2Zs4N5EvRh7rJ
 gvwzZvj4zK7brEbTWMpn2wPKJMEJChO1AKwwfCmTt2Ywi+IlSZDaLcnjg80K5r5miF0c1c
 AJTxaLBdtrsonnCFHBPeoR787CqH4ptHrKytcaVNce9Zsj5D1WGTrfCzeNVjpL5b3GKjBc
 Ny9EtLKwBQvDpPYXEZ0+DpXJ8Ke66FgsxtItJelgNY1+y1+2S/8NfQbHSw2ZDJGAQDquRU
 d76+kMEknmTuNGuwUsPIthDnJNb3H8IqiAYQ3PUDI8xL1FPcdiOqT8DX1/5Q
X-ME-Proxy: <xmx:EKwdariy70F9UUIWuObYdEuOpHBdAdn3Jx4qow4Wkxc39DX6WTM8tw>
 <xmx:EKwdaoNeifPMG6_ugY0t1tjR239fzh7fy0ABsp4Y5Ya1CIMTS4udGA>
 <xmx:EKwdas44Bf_47e4W4NvY0DHij1v_sk7L4QLC3cukBT9kajkbu7ezqA>
 <xmx:EKwdam3B8DF4nkETnIad4tp2CZXk4T-CWYdgsaORmaG1l3cwEQb2NQ>
 <xmx:EKwdaktcn2PGehVCQ_XpInDDs31-cVesU3UJ38rMgt6DaC77ApBYj1ye>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 11:58:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] stack: rightsize cache guard
Date: Mon, 01 Jun 2026 17:58:06 +0200
Message-ID: <GpUm1Dv7TBWnSxp9D8Onxg@monjalon.net>
In-Reply-To: <20260504071539.252926-1-mb@smartsharesystems.com>
References: <20260504071539.252926-1-mb@smartsharesystems.com>
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

04/05/2026 09:15, Morten Br=C3=B8rup:
> Using 2 cache lines as cache guard after the table holding the stack
> elements may be too many or too few. Instead, use the number of cache
> lines specified in the build configuration.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



