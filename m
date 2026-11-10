Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FB60A261E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=y7jtMWI6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lWpo7TEk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73CC540283;
	Tue, 10 Nov 2026 11:39:20 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTPS id A0D424027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 11:39:19 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 708931400190
 for <dev@dpdk.org>; Tue, 10 Nov 2026 05:39:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 05:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794307158;
 x=1794393558; bh=JHsiMaRxX1o7zM5opNGmtfvSEYFmxktcrN3xnPBGQow=; b=
 y7jtMWI6gL0iux8DqDB51MzSOsUWpibZYQ2G+WGQeTyFi3Bzrqe35akvoyxgU82r
 XdqwYGn8ulIj0ZeqTZSYbCYFUjc9wnArDpWTp7Tim7+ihiuHiYD1QNzm/BblJMQ/
 VdXOvXbE8tlUQJdKjWEtWEz1wVXckUoz3X/8oH//FgqqQLMHGNNL8BYx1RQpIgkR
 D9+gWq8QmjiSuOwuCm+BhazbqgHXg1vQ6fGDhq1PJJ6MHzuXfyXiV9IERxGz8krb
 VV6khlRrhibGlVEkDdd8O3iIRis6K/cuSwfoR+82jh7qkFcHVTkuqjTrYJUzEq79
 uuX1B7r7OYeQyb/x6bZD2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794307158; x=
 1794393558; bh=JHsiMaRxX1o7zM5opNGmtfvSEYFmxktcrN3xnPBGQow=; b=l
 Wpo7TEku83beI7tlQi5Fpy4CzL0sWuk4tA3eKuBK2k8NrlY1/V0zj4hGYQVFijdU
 P+BlqiS168i3BuvaAFnhDb4MEPM/Ij47/RC/Amo9y7fNmzTW0mzjDF6rb2K1Lyh2
 Nzf8iLCwS6ztoyrSx23yyhLsEdHdOilUBR+/gCIKFj2lWuTcY4bqqM9B9Aaxn3Ab
 EZ1p8GiR/VZkJTwKK5l8Ta23hzT+g52vgXAjR/wKCGwNv1pTBUcffWzoUVYZe4yv
 sioCupQntVKvEpRKWLQIJkn0MAAUR5tS2EdUV9OXYLzLMPFL2bNrneywe6Bn/e8y
 ZBELWyAS3tPIwiCp2AdAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794307158; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:IwLYAhdjh+1drWqJlBrYd/I96Yvu02kEp72cOM8k0iKSS3H
 UOAuqx9rAmJe4Kkbg0YVjM30s1DU8fd78sXC9zbv0gYVTyCc3Yq7n94fXu5hn9Uv
 9T8Z1b5fUh5ebcioibsvRX5TDTAYueVGCFwDg3dXIhhBWTrPhksLoqhiO0EifVRM
 wK4nU3tI8gV+GbkyWq0Wf2RLhG2HMrZ2AZjEC9oafl0f3cjaQMtFkWiEEErCoEri
 dWljOj59LKjYDZ/5sOeXfQhxNMHX7j4aqa8P2M4pwkw+Lq1AZPOAEIY2ka0++gGU
 GssMgMXOXQR+KpLBcw8aewJH+4maUQ4j6LOlqIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:nIUJyjdLp/zWXbLbeir+Ib7yNm/IV1HRd/XgmAT89GQ=:2ju8Zgt+GwF05vbiEiGlAswpHjS4Vh4M0jZQ528glc4=;
X-ME-Sender: <xms:VvTyann_gV9HPTjbt5Lh0XYPBham67JQbsDBe9acuoUARb0DTh1r-A>
 <xme:VvTyaozEpT3MHEzYeV4FTBrfBCTz6u2LYNSm2PsyZjWds9CQ96Ev7LjNRJM4Kax1B
 begHBGnttfjekenJu3wep4e7jxQ2FWM_m9XaFVKsEyRUfpnyb-Ukg>
X-ME-Received: <xmr:VvTyav-4q74EEQW-kbz4jOF_6hkWxaHe3597SXaEjWv2PjaRklh0xneRcAoM8CwZ0wnlKm497HUiLXz9pqdNONc>
X-ME-Proxy-Cause: dmFkZTGT30x0bZH+2Q2g9Ro1hOXaKz1RuOZD+3AI7OzoIpkysPXcKiioYcK6yR7S7A9i9Y
 7oKBhxAG3JI/9cBiuQNg0NzmaJQRpjbCJ1Qhwya+nE4uqo/i2vOlWLyg+ZGl/BH4ukWcsG
 +PGLN4C09HBsSB8U6B82VQNJc2hGmc9OgHgC7/MDPwhIdDgGxxv9JxJgboVcU7G9VfqR/R
 3T/w/5DRC/OrF/f9pi1k7jfzOutyznKxK+ED1RAGL6FB0NGS65HVGX04Baptt5zimMvF6f
 eC9yCIzIgfP2tvsmwyws6OJuFDqjCjL4iTcYyDEWtxKdYpv+jVe/kaOdSQEY4NeIy46gW0
 n9iP1QDAEYEjVG/zT090GXq+JbZ36Ffh9WO1zoTLNprWl/E+h4+z+R3vc7TGphs/RmcpWk
 wRsM0vVUVUl6WVQuSVV8GuONkDWtFIg6m5MzHRCb29lmqlIevdJeKoyBegw44w4qi76+7/
 +3KUmv1UfMrVdaNIfssOdhTOiYD3CUZJm56bMga6++hTKVqeXaH6wsXuc2lLra3yShegMU
 IoU6fz7KMZuA+mJuCvmT0AUpiSr6LP4Bm66N4BRCf3N/zx3FXytnCxQWEXiJ1gUcN2TG4W
 ahyGTphWZGF3A9zGi72kI/iMfpO9aQdv/I8YNz8W/z6fwZvi/XXqn7vBdDSw
X-ME-Proxy: <xmx:VvTyakI5Km1I4kP7l1y06shqpU7rL_cFPGo6pVKPAjui_Q0yLZMRcQ>
 <xmx:VvTyatccMVMnQy72_X4L01Qc26oCOWqmwSGRqAEHxqN6kWOxr6EB9A>
 <xmx:VvTyar9AfPrzN_os6BiM7D63BHpwSjgdXRk2ER2CVq8M9ncUkJ1n1g>
 <xmx:VvTyaipKVyom9iVOMLXcLlY-GcbPq4oudyxlq15HMjSFtSJwJObLgg>
 <xmx:VvTyagZ66Pv4n16Dky2ILx0hbpbqbf_lCHr37qHDlVIZY0ZEjckvLaRZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 05:39:17 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Frank Dressler <frank@dressler.pro>,
 David Marchand <david.marchand@redhat.com>,
 Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH v2] net/af_packet: fix build with old kernel headers
Date: Tue, 10 Nov 2026 11:39:15 +0100
Message-ID: <O1P4UruZSlqFOdl0F9QGXA@monjalon.net>
In-Reply-To: <20261109094700.12df2349@phoenix.local>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <20261109154730.146345-1-bingz@nvidia.com>
 <20261109094700.12df2349@phoenix.local>
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

09/11/2026 18:47, Stephen Hemminger:
> On Mon, 9 Nov 2026 17:47:30 +0200
> Bing Zhao <bingz@nvidia.com> wrote:
> 
> > The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
> > but it was only added to the uapi headers in Linux 4.20. The build
> > fails on distributions shipping older kernel headers, like RHEL 8
> > (kernel-headers 4.18.0):
> > 
> >   rte_eth_af_packet.c:1057:41: error: 'PACKET_IGNORE_OUTGOING'
> >     undeclared (first use in this function)
> > 
> > DPDK requires Linux 5.4, so the driver does not need to support older
> > kernels. Check for the symbol at configure time and skip the driver
> > when the headers lack it, instead of failing the whole build.
> > 
> > Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter single-queue Rx")
> > 
> > Signed-off-by: Bing Zhao <bingz@nvidia.com>
> > ---
> 
> No. DPDK should just fail build on older kernels.
> Since current DPDK is not tested with those releases, anyone doing that is
> working outside the tested environment and has to fix it themselves.

We used to support some old RHEL versions.
Remind that the RHEL kernel is full of backports,
it is not exactly the same as an really old kernel.
I think this solution disabling a driver is acceptable.


