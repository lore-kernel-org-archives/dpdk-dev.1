Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E9DCA9EBB
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F35F40274;
	Fri,  9 Oct 2026 22:34:43 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 2DF964026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 22:34:42 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 7D9801D0007F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 16:34:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 16:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791578081;
 x=1791664481; bh=3vFLl0msjYnhNKgEVIpxTbPv8RZV5C/kQxE4mX3IOJw=; b=
 I7Xz5B5YuA62m6eyaNPwRunTLv+vjgzt7WCU6kKzD/2p59Ai0eEWu+PxeklS+EK/
 M6Onw0r0YlJrZTufLO3ucZ7TDZSyYG9mrUDacnzihMrOpL49e+OKW9vPxVZ+Uo/Q
 wLlS2FC6DgVNeK74BBLwPOaxilJtI/arxyI2rNUmSTkbCMCUgLgA7cyrpkwWECb2
 YTy5/jh68UW0nBIMGwPautNKVyIDBxAAi3Wjm50fjxHYvfEpzEDo7BC6zrHAh798
 qRdyxCqWyYN/FYQMLKTiAF4MFCXrohpK2bojW/is5KOQ1fzygPmHeO8r6M2lgRxE
 +/MjyfDlM9/79Izut+qyOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791578081; x=
 1791664481; bh=3vFLl0msjYnhNKgEVIpxTbPv8RZV5C/kQxE4mX3IOJw=; b=C
 bbqmlZ38gvw0pELp+0NbGzv5qR7CakS5a365cAyyyeph2Hng2UJD+XmZPq1awNA2
 krp4tesTg77qLu1A/G5IR7YuVR3V3gVXAw6YCNY6gmkYkyvg18LfWa44wualtqcj
 xHuLW/opsFLeyRQaYu6oy6ySeQdl1WW6feNeb3BC1ROCsOP+lt6iIvoQJaOo5lG3
 r/1UqB4GmqEuLeFWZvuUFXuUzT8VEqGehvL+VioBoG2Z4uSv4+WoG0dw9n/vTIX9
 7VjalPJ1FWphKUOSmi5aTyvDKBRyAHMcD9H0sYP82jUyhQCvwCLSASbVX2Do6eMT
 G8DKkujofBuy+ZXablEcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791578081; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:SzAE9GFBNZ+R6laZTuPSjKeIcln/DTWgDMh1P7oKG3M0AJQ
 3EP9hR4jLVNEsIUoAg5uh3ilGtfaL3SRUpKljloS3f7DTmTe/gP/8MnDTaHWeejB
 tZrVf5ulXt0DwV+Z7g5toVEgTp0FlcuwsqHwX2vI6jx2kLFp/grEuXTwKCKJTDeL
 q8ILQ/XpC+1oFgqaNHe2ELoKd9sxFb0GCMTMccN71n61mG0EzEproRKda9qMtyWP
 DaeEBvYXjlwzxd+rspOFprmk/uuMkVy6iFMfRA93tEAFdFEk2ren8Ft5FR3Mhadz
 m2xUdCN8esulQayJYC8rZkKK/36zKyNsvOIZF3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:OKDt+gIr7rHHb3YNAya1mNfO9AfPrV6+0DhiXxw4BaE=:3sfHOs3qpPIWYwnIW81cAO9MyvSwLWMVkOKgbf5gEiI=;
X-ME-Sender: <xms:30_JahmbFPnpnRtyiBDGs238WS6Kp9s6K6N5wv8Hfyx6a0tTGFU1tQ>
 <xme:30_Jas8AvESmRBfzoqvbaDF_E1075GlGeXB1uaL6Pv0aQsC4repiPqPw6QAXVTBqR
 JFVE5elykTnFD4-EN5FwfhOkgemU_13fuwtB9ZmhnMU_5db6g65LO4>
X-ME-Received: <xmr:30_JavlbbdvkPzjhxAw2LmilgueEKLkvL8FYnbCS-g7_IkW6DcxWseR_tHMRozbh9oyBqHPg1UZROabEOqa1mLI>
X-ME-Proxy-Cause: dmFkZTESeEJsvQNXVrX5fwZ3O5129uQ33NvAcFNIVqYwkuHcdkwnLxRg3OPsemcpgYUjmy
 tuudF5Qu8HCcJL3E+rU230BmRcSeZbM+ebVTrbEnqYkwb7rTsFAsDJ9Avxz0Ok75fpFMDm
 8VlwM9rnUO1R5WV0rAPbHwb8RGW6ItmLrI9sdaPu2e/gJvG2YIT876TsWyKtpxl2eI3A71
 0OJhVieFaVaSfofbpNUsahAcWSiegp387hHwK7yYqesLVgtitZzzgd2HSMzECnZAZWHQle
 hX+daN65o28e87aI8a7159pziJ6m1jCOnfzilCTiGLrEFVssrEVWxC7t1NMjx5j2onE1j2
 J7lqbejzAn5Sab9R5d5gWSR7x7Gxlya/s9qyWiNhD+F/ZziUwUW3/YLXNDRHvI67dxJbSB
 j7XZl1D7NJFGmbW3zAtKJdRQctohpO/vgaKhNCct/6PEvtqHE9CkQFJobq9mi8OXf1vfW9
 PeiRdQn1JMv02kiEz8/1tta6v7Ly7MHgAzRDa2mqZXtqiBegpSKYUuh1re2KNoUVC7Uim+
 jHoAgTBbYe8tO9FNf7CEyCwGu2rp//9NJ+xfhmxjfS8Dbia6FjJ/a/bFWO/zbX1nW/vaGp
 noPaw5DmGjnQyQKg8A0/UVGnuEnC//hVyk47oZE7X43ja4xJMVvqkrJivcZw
X-ME-Proxy: <xmx:30_Jap2f7Mh1Hl-urihv7wamO4ibFj4DE1RH8q5KHxwVxHgxs6WG2g>
 <xmx:30_JaqoRzdySxgIB7RVJug-eSiewalXvX_AI_5nmNxUeNH3mkNmZPQ>
 <xmx:30_JamdPB8-fBRH25Q5p6DWWL0txgPqIc5VDurE_IJiZbK4YqHKQ2g>
 <xmx:30_JapqOqOml2QpZx0smaijEraoebEbhORoquoIFEmCceSkguC0YuQ>
 <xmx:4U_JamIw7SM8n1eArqyHRDkXkcMUE25z_vWVy_ThXluy4V7Tk2vcgUDL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:34:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, stephen@networkplumber.org, andrew.rybchenko@oktetlabs.ru
Subject: Re: [PATCH v2 0/4] ethdev: report module signal status flags
Date: Fri, 09 Oct 2026 22:34:37 +0200
Message-ID: <QfuRvLIpRPi5pHmcYtqGrA@monjalon.net>
In-Reply-To: <20261009192113.534604-1-roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
 <20261009112259.2bd9debc@phoenix.local>
 <20261009192113.534604-1-roma55592@yandex.ru>
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

09/10/2026 21:21, Roman Khromenok:
> On Fri, 9 Oct 2026, Stephen Hemminger wrote:
> > Applied to next-net.
> >
> > I wonder if the eeprom really belongs in its on library, really it is not
> > part of standard ethdev.
> 
> Thanks, Stephen.
> 
> Agreed, the decoder does not need a device: it only parses a buffer
> and works without EAL. Only rte_eth_dev_get_module_eeprom() and the
> telemetry command are really ethdev.
> 
> If Thomas and Andrew are fine with it, I can send an RFC for 27.03
> moving the SFF decoders into a small library with its own API, with
> the ethdev telemetry command on top of it. rte_eth_module_eeprom_parse()
> is experimental, so it can stay as a thin wrapper or be removed.
> A separate library would also be the place for CMIS (QSFP-DD, OSFP)
> decoding later, which does not fit the SFF naming, so a neutral name
> like lib/xcvr may be better than lib/sff.
> 
> I am willing to maintain this library.

This is specific to networking devices, right?
So it has to be linked with ethdev probably.
But if it is not specific to any driver,
we may consider moving it to separate library.
I'm not sure which place is best.


