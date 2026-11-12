Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01454606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=zt5MFZuD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V1uI9jJi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8124427C8;
	Thu, 12 Nov 2026 20:48:33 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 29F07427AE
 for <dev@dpdk.org>; Thu, 12 Nov 2026 20:48:32 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 125F97A0487
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:48:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 14:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794512910;
 x=1794599310; bh=AYvBmogYzAN47cUfebcrVKFKaKfqIx1dOLG9fXMEA3w=; b=
 zt5MFZuD1JrILy4+k7GUSMdV607ew3RjghLejtSs12MpgWBxj8adm4xg8kciw+Ml
 p+MVv2aw2JIHPK+0UKYGTKslS64E/ZgSlzwfhLWrwu6GbofRRGLCgzsuAv29jFFI
 QhOnuHqeE3coQOPrF1z3T5pxxfL7DXLSf2nE4+UqhxUvrqZqWRmTIpB6+7FA82l2
 L3Gnbnlp6nFt3cXCwdrcprlokiFtuHiVPGf6fdrPxRCij/wmcMwiCNY0QTe7hJ6H
 ElS5zODnKE4onDvlpWuihxN+5+tXjw1sDzTfv40W3fp51VmVgf4c68PJkBxBwhfg
 axukHHInuBVDXDTo34BHkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794512910; x=
 1794599310; bh=AYvBmogYzAN47cUfebcrVKFKaKfqIx1dOLG9fXMEA3w=; b=V
 1uI9jJivOZ8E2iuP2L8bhrQ4w/Xkzy/jeOZQAZs8NS3jf+z2BYqz1OlHXpGeBzSZ
 1PtxntmPTKHnNUsRURIz18c3l+tKqzUGe+J55ZEvn0k7UlC7OKlKtffYgdTFkBbT
 xqdgJ590BeXe6I80UXp3K+7qxhQs69BwtlrIkD80gEva3shpZsJ8cKmRrQpTPs3C
 qGoNGFSzaDaCrg9Gsc8IJNHsbnwlnyfUAvRgRkwBcIT0GCowcuNYmA2LYavMIQFQ
 St2DqZEKYnxjdykddEh9GAIk/Kr9RvT//81EOwebEkB0jcCG0A8qdDMXv5944Vuh
 2QXIx2XWWVZ4K9ovB/E2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794512910; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:auAcEDKVAGoMBx7Y+9uQLUyiSsMEFs09jEIAjjomYluaTyl
 yYgCoQTpozB8KUaW9AZaRFoC2jjmmC7yf/Tm3lLeqYGq3A0spPHJpmbBTDeoaO/r
 qotash3CZ0uW/XB7ZpxenhU/Jy0vurhp6BnrWEnNKnJeR22yYMYbWLk/y7TaOP5W
 RwSCJsoyRXbYgIiHf9LLQAY6/lTkBMbA9Yuw2MsdgUlF/RaTEefrnmuSCWE00Dqk
 wm+nW71u5Qa3lMIIgTLt5J2iCmpBbcGaZZ3IZvnK2GNo9XAYkwHf+E2NKYf4ewRd
 5gFei43o21cn2qjC6RVtXqDonvI0Vly565VWQXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:FCf5IPStRwNr6RQ4BkAc600rlVBSfXntMrOkWf/R1xM=:qrUqNaypTNfdWVEJp2rOgUlQ1mfYEM6EWVt52GXwQ34=;
X-ME-Sender: <xms:Dhj2am6eROB7SylwWJKbZYpvE52hgzrvoTXtxqZnOm-2EFH1_0DNgg>
 <xme:Dhj2ao2i8piLGHm5knNjDX7FIOFiQ6iKQUroDo476LHsyNKGXTsErertmIsvP2l3G
 Q6AxXI9_LgT1jm51dveAkj1xIsgi7YeA85uukNnGAWseVKzv17oJg>
X-ME-Received: <xmr:Dhj2ahAsj5OF_vKYWXG8zpWBMwzCL2bgEOfMQAKFVe9c8tsIV26beTKUwOIUUjPVcvZKOJPgWLJqPLe4zzKN2pw>
X-ME-Proxy-Cause: dmFkZTEdkI118tV3dHeyrig8O+tdi5xjT1ZDEOX+mmJoQ1DMm1w7pS6Z9X3IUwgx+t45rX
 rmvUlKX4QyBE0nad4BAyJUUh8WkkXaitIzdXDZS5EiZqP/X/RwsrZw257AuOJ6uwCFB0NU
 30q6nDl9TmP1xJaqm9dhJIn6reO5B796YOaB4AMuHUCMDVfv0fdxZwPycYJ07xNTA8zkbO
 ecEgpCXucHPaxTAdaeWUn5Jm1i2iRz1mK728k+vVMUd86KHc5uKqERTcAIgkxk1aIy39VT
 QGmtaau4HR5ilxq95+Huc2+XPPpLOmoeRGcxuRPW7SgqXEkKvXRdflM84+OxBoc1zr8Tmy
 IVNac3X7ATeeWrYVeuC/sAhRYPl4EvdPSHqVepzfcThJbfZm/8YajlgEqYaOBMW6ZxrXWL
 nstEr7mXvFM5j7PGWDxeGDg48EKV3lkk66W/pfyldmt6szILc7v1zDa9oj9an8FX/Hdt7Z
 yU3J9Ry/dQ4ztqvcyh+uAY1F9xIBAE1+9b/unV39XXK9N4Ikd/Jw5T3f9TaF4EfwriwRy5
 PoVb4UM97x6KdlDXp903DSRVxKHuom2byeLqn8EfmNMTm8cdZ/Evm0ZhwHtszLfxmQpFo9
 DwzTi1oQDgkgf27hGodcBiPNumxosW8Ipx3TRcFnjLHW6qnaqlnQdkXnCMLg
X-ME-Proxy: <xmx:Dhj2ajNkvevBcoVhxElBLBHiq_tjJsGWIH-52n1Wl8UcRQUufK5GNg>
 <xmx:Dhj2ambWcGm-13xVwbl0oKgsSG1-tgHN8FTkbk6ZbiyqdOHDeZsWow>
 <xmx:Dhj2aitdoEO5MRzTCoiS_bIrzPVfe7CxXP9d3kqptZGtX2mSXztDbQ>
 <xmx:Dhj2aoMcFnPWDeUokG25TV137O8Yp7ch7rpT8X88eWn5FrhZXMjlug>
 <xmx:Dhj2apynGeRm41cGNJ_Rh9OScZ3Qwlm6-RAz4dx7E8BjbzMgTl92WabZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:48:29 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Michal Jastrzebski <michalx.k.jastrzebski@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] examples/qos_sched: fix build with LTO
Date: Thu, 12 Nov 2026 20:48:27 +0100
Message-ID: <AKTBn3lRQQSAhRZmoR9N5Q@monjalon.net>
In-Reply-To: <avLeZMkDhOH9Hxk2@bricha3-mobl1.ger.corp.intel.com>
References: <20261110020403.419111-1-stephen@networkplumber.org>
 <avLeZMkDhOH9Hxk2@bricha3-mobl1.ger.corp.intel.com>
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

10/11/2026 10:05, Bruce Richardson:
> On Mon, Nov 09, 2026 at 06:04:03PM -0800, Stephen Hemminger wrote:
> > rte_cfgfile_section_num_entries() returns -1 on error, which is used
> > unchecked as a VLA size. With LTO gcc inlines the library call, sees
> > the -1 path and fails with -Wvla-larger-than.
> > 
> > Return error if the entry count is negative.
> > 
> > Fixes: db935d0171dd ("examples/qos_sched: use librte_cfgfile")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


