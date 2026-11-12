Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD8606A897
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=0LMCfl5G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oM/14O5B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 521D040E15;
	Thu, 12 Nov 2026 12:20:59 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTPS id 6F4BD402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:20:57 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6125414000DD
 for <dev@dpdk.org>; Thu, 12 Nov 2026 06:20:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 06:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794482456;
 x=1794568856; bh=TmO1ZLaWY+kPoJU+cOtcgzVkSbD3c3W0FT+eYV6kZG4=; b=
 0LMCfl5GGK1yKJcUzy92ufpqYRUZfulZHf0R/oZ0wmOJxlF7A9F1sGAA8tG9JaE9
 AM2IYMR5KxZe54qPIOxFYHAlPZC8bB9+OfrRz6DTcy3jEWTxn/P5T761jB9CsKFW
 eyF5gvfOBFKjLBnv3JKxsRNTg2uBlVb8plGuHn0k5OpJlYcq/oiFJsRX5YDsJmEn
 rB2CqPRe4E3bFJZqBl2kTykz2Ar+GW2CGvTLYMjN9IJCUZs88mca6vVb01yW3XFz
 wYZluIyDqfm6T8xCTRwZSthZMl8B8O7Oq6NU7EzpJfWsxwqDQe+G12PjmLY7mt4F
 jwRgwDEH66oCUfthCBR0vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794482456; x=
 1794568856; bh=TmO1ZLaWY+kPoJU+cOtcgzVkSbD3c3W0FT+eYV6kZG4=; b=o
 M/14O5BVRAcYTxXYaMAhptz6Gv2ggAmWZYVZzAqGbie7LCzFFvPLzNhpFAS1jGeg
 lFHUtjbsopcVX0OX2Z3yAVYwDL+fiDPfA7ufUSwm4g2SxISQ9n7kwioIpKPkJFrw
 KlPZZK5Utt/4XHWlYeT2cfYpJ8yyStoCZKOLBh75go8yy3Tosc0EQksGps9vl0fu
 kQbJDVK0hFXmAxfSYt/i6fTnTbIUJvWTcv84Qdq9bzvOl+x6MeWovSZ3fB0Hwls9
 AHI97UqSOAdOeJfW930Wnf35xISyMA7kingGO4d/47ZuIUrVu1e9C+vDp3rxQFFI
 bcY9J+rcaTSxMd3p7NVLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794482456; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:UlHpKlN0oK06PkEK6djCau5vqTAC/WC6KIzjydvANakZDH1
 ijUm05laKUAe2AGwZw0vJBZFcT1fo3Rsp5nB3Y3ufwb5HrLV+ivWRJVbcJy8gpcO
 Bk+ANF2StDnzq1REGddLxIRh/54kj3CTg+8a4MnNkBDyPAaaQHXZDMbRKAwBxmXl
 q0/nsgE70WPqY+gAmKIefGJlyhfGhFkFs6rCtSm0co836Eia+jRY+QmnzHGigU6d
 N8O8dp0WsobWmouMRYJZIcoQhSKV+xMHQa13diLov6Iff4QO92nFJZFJahB//V5P
 Or67jsytaW61hY9i4E/Jjo9tyNKD0PQvcbWgTIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:N+7Fx1HMcagWiK9B9x9T7mpvJd1BwJo4cIU/qjJc5T4=:fbvKR6oCPsVs5zo4YpJukZA5328tBtOZ4+mm/X6Tlqg=;
X-ME-Sender: <xms:GKH1alAVI5yVL7LsrID7ikVQRtYx-SKP66xCoqJDFTTCFSXDC9Y77Q>
 <xme:GKH1ajp0ZxBGo-8pybVAaMh4ad2wNDrOdQsipBKzqTvDk80XmpbqHGqpl3SQkGIc0
 UyZusITtcrAuGnE9I2IyxHpi-2Bjc9K6godk4KNGlLZfNYFufAV2D8>
X-ME-Received: <xmr:GKH1aoiiw80KU0y1wNf_ldYVtcC1M8lGeWkBCJVgzm6RvFeIoWWa5Av6NmPsfYlydt0gkV9zRnelXec5EPn-sTk>
X-ME-Proxy-Cause: dmFkZTGd0MKKGxmBqpiR+YRymZ/+AhKoMXIB6IJ3i5HTvs3o7q0bf6L3zdOuvkT5xyrt3A
 qYpQh8uSLd30mRmM8UXW/+wVWbo1SmMrDfCLg8t71sLoHF5Q60N4FydKa1DJSnaH6Uevp2
 OWgVi7LdQ5jNB9G6sG6t1z8Und686EV6eQJ7NMfafigtO2ZyUO2jGmBLcBYHHNf4p1Nc6N
 EVK+Jc3hdpNp6HYxrla4fMZ7jhCJj8HsGTXQU88K/qWulmjLJ12EimMxhTufOoKGJpjBs1
 2JRW64mCVfSarPLlap8KNuALBPtKaeVZpOMHzEtH7Sl20UeZl5EyUvkJft/DGjbhetrXpP
 +QcNko1hnswz1751mhmlsip+nwT63iIbWGGipWBQ5RBRa5wBn0nYnXhi1vDDVdIgMS72ms
 LV5Zpz0BILHLsxh8LKfWuzaW2l//caAWPbfzHjBBXHbMOduPnlWTziVuag/kqF4/q1r4Vc
 JE37WrzpYDx4P+65wStX2KI3+BQaRJyP3lLEfcWABf5tlS1p6Hxv+LhXfTgL60AzsjtJaq
 WNs2N3JnbvV6MbCfkP2NDhZnL3gIYgipO/srRFRAtLmSQPXFhLIASnlQHBSzhoj76O47sU
 JibvCiNYajIqIjG/z1JaPbHWaC+ve2h1CLRMIUEIh9+SOhehNeiqiEMQaiZw
X-ME-Proxy: <xmx:GKH1aoAk4Yh6I-99Cvm8efbjdTlhxpVeOkU8Sl67boo_PM6xxHSPRA>
 <xmx:GKH1alGYkaKmk8LSBpQdrDq1u_pwG_3IlC7r5ohDxJ3QjYimlRPi4g>
 <xmx:GKH1aoKuooi3n-BpFocMC9Mvfl1h_ovKEjOVBF9CkGEWB0XLrxaK-g>
 <xmx:GKH1ahlPJp9hqGZjIi79JttoQLq8y4_-w8cnnr33XXvvG9YT38EUfg>
 <xmx:GKH1akBgYa59TRz1KboVQuSypURcrhl9hR1cIYZKSCldhXCAVpeQWBdh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 06:20:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org
Subject: Re: [PATCH] gso: fix segmentation of unsupported tunnel packets
Date: Thu, 12 Nov 2026 12:20:53 +0100
Message-ID: <mo_JScwtQ8mnxNg-1Y6qHA@monjalon.net>
In-Reply-To: <20261109092742.77701-1-a.mokrushin@ideco.ru>
References: <20261109092742.77701-1-a.mokrushin@ideco.ru>
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

09/11/2026 10:27, Andrey Mokrushin:
> IS_IPV4_TCP() and IS_IPV4_UDP() do not check the tunnel type bits.
> A tunnel packet that does not match any of the tunnel cases (IPIP,
> GENEVE, IPv6 outer header, VXLAN or GRE without its type in gso_types)
> is segmented as a plain TCP/IPv4 or UDP/IPv4 packet. For a tunnel
> packet, l2_len, l3_len and l4_len describe the inner headers, so the
> segments get wrong header boundaries, and the IPv4 and TCP header
> updates overwrite the outer Ethernet and IPv4 headers. When the bytes
> read as fragment offset are not zero, the packet is returned
> unsegmented instead.
> 
> Return -ENOTSUP for such packets, as documented for protocols that
> can not be segmented.
> 
> Fixes: 119583797b6a ("gso: support TCP/IPv4 GSO")
> Fixes: b166d4f30b66 ("gso: support UDP/IPv4 fragmentation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>

Applied, thanks.



