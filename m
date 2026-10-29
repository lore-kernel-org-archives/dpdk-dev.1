Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB356606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=N6WNcuFP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tgwGEm64
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205F7402D4;
	Thu, 29 Oct 2026 17:11:05 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id BACC540284
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:11:03 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id CFE29EC0223
 for <dev@dpdk.org>; Thu, 29 Oct 2026 12:11:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 12:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793290262;
 x=1793376662; bh=hqtTDsPFD20nE3MPGGdHYPu6Roz6jN3SmfjHaFWaow0=; b=
 N6WNcuFPK4PfRBBku/Kjdz68WUhIuLmSaHfWNaMwyWvHZRpniQ69FVMmYqeLuk62
 krj0iXhwvnIbt2ozADCgwiagdAo9vqQhor7P8DchgIaga/VYXzZjvbfkADmJQG4T
 tvERhMijZc978QXJLC53DlhuvP07h/QLNc/3EH3MTc65GD0i1WqQhZI0VaijLhkH
 WuS27tnRaqsRN0e4T5GFxaL4mNGktk5hCcPEg53Wajexb7I/CUdIms+gcfV1L+jj
 ZS+K5r3anVy18I8woUEReVwfoiP3nrBpJ9/yFIbPUXKj7yJPBMCZ/gsyVPEfunq9
 vWKANGPel94OEWqatDdm6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793290262; x=
 1793376662; bh=hqtTDsPFD20nE3MPGGdHYPu6Roz6jN3SmfjHaFWaow0=; b=t
 gwGEm64rh0k9PBEh9qKcqTvDM9Nhnsy6Kgr/wDi5vaPDbGFMnR56P47TyPDAVYAK
 +ktUEAv5vDNEK+IUOIviEflo/9ELGD787uOApOUzT50WZkLBSSuUOOpeG86/yiv2
 wSvXkaqPaN2iTzEJIa+xo70FhW2FZJByP80akGppiir2qQRy9pshlCvarNxGLPZq
 YHlbSN6RPFv4m/9hfeKAWo4VzwE0+ps4M6gA1fBjEi/z5mEw60iKRRrDD03quioq
 TKAMIRAXO8ki71ctsUFq79ozA5SyGoVB52FuYngbFV4dfs3r0ZR8g19ikvMw8RSn
 GbSo0GgFsTO6+pCPfDI6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793290262; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:GJOMQlaHoK9aWNOtcskBsly5EjtLIUoej8hbcNaFU3HY9NP
 XuT+USgesyTUhOAmCHEVhQ2wlhuNfGZeDyysEPenLsYhG0n7T4lp3yNbnkSGuTJH
 XgCEdfQIcKt92pSod+dwfFXdaVYBMNdtjEGpFP5lZcm0JHpHit/48VBq3sWjEZaC
 NU/MpnYS+e6AA5UD+ksfSwJkqqpNdQuVml1oKT2I+Dsh2qAJXN6nv1GLDS1Qm/HG
 qjM74dI2Z874dGAe1jP+K/ArbueYvJMUUAo4cCR3Li4amjs6GBQRvvMYW9r6fvpV
 9mBBVwo2g3ZjG7FC7x4CaHgp7+AreE2daK2UW0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:CiVIBjIJOPsUM0m9TA+7dgmBwnV9KWClIVE9bNgcFdQ=:+ecCtN4BtdL4cK0Iqj03F9hyDPo+CkSQsOMP4vn9fZo=;
X-ME-Sender: <xms:FnDjavZlp83owt6SAOxqI-BsDOmFWS8sRHM0YfQt57QRYiPs4Sz3mQ>
 <xme:FnDjaujuOlMOYMVqC1HAA3jQO7Yr8tiZu1TxLTYKSNFVaACp6JozlxDsIumKaRSLO
 1fCQpBhq6eLBoqkWOio4vbb3pZVf1EebE-nqmQvcmi8Vc5jkpqyh-D2>
X-ME-Received: <xmr:FnDjap4ybz7kZKV6GwEgZ6HwcWfK8gcCxvYE_95HW_IhKC4sFmF7x0NM_84fDP_JF8ulrdkbmunubs36_nWphCA>
X-ME-Proxy-Cause: dmFkZTGyRed1wTYC6C8V0KDjvd6STxtPUYk1JHytVdK4WwRYUWiXu6QFT1mwQBXAHO6utv
 XCnwcwBMLo+le0k1E99Z/OSQicu8EtsyBcjEOHCpLytomtFmAx7/DkJPNK4Y1MYdyDsdsY
 1IihxhmLWCoEfB8t93vPUZEo+6oHCWep+FHabJxjkrtRJKfdAO3eMTnIFKUmd7Y5gCs1d/
 bdVxOr3dXQoeG5TdFJy6a9w4OK5VtpOxBSadnl3wAGKyvfV7LT6R0gNwhJt87/G6uVREHd
 R9Y8zNObEPrJzeXz8IatNrgkF0vrWxIrIvaXfk0jTDsTpwQ4/BnlhE4/ueGesabptJLlt5
 1UMtOYG2UsQJB4Liw5/ryt09oojbLd/YF+iT1JmCEY2PWMUbfulciPgwEnwL6x4niUkG87
 0CQLQpOwU0jLetYvAcx5EHhUnZo+G+tuiKDlvfvHRL785wNNtEQFW6cw6Vo/Jak7tvXV70
 ueqFhOZ8Nww0PH7QejHDQQbH4h2+LLJGjV5RDwkihsKCkRepThLjzZHRpOguhqAia9Snpg
 ZCjuJtV5j6aC3ArctqpCL0vkFgIOudoRQiVBtuQnif9yGPF2KSn0zs4HzkglE7K3f+i2aT
 L15GKkVA3MpCBS3GmvRhbYClRjV6KtjAMYvHr9/8mw0GSOrjFL5x3QOC+Qfw
X-ME-Proxy: <xmx:FnDjat5BqY2agO-rP1zMfEV55oZhFhYuo5HQnrTvFyUCAkR3orC9GQ>
 <xmx:FnDjaleN0Axwg37pLOPLQRzis0P94vVGeuwC9srxHS4vgD_jJLli_A>
 <xmx:FnDjahBmHGuiBliZQS2VUdJxXCrcqEmo0T6o7O8wLW9pJdts-STMAg>
 <xmx:FnDjao8Ky8K0brrgJydOuDP1KRNq4LMLIk6gSMuobZgu-JgTsYgxQA>
 <xmx:FnDjak8m8ioGi46dJ4zrkWs6PwPxLQ42dNrRZFPxzyhKZf-C0GAIWJhM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 12:11:01 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: Re: [RFC 0/2] move module EEPROM decoding to a transceiver library
Date: Thu, 29 Oct 2026 17:11:00 +0100
Message-ID: <1jOljJRtTQqpabyIXToQtw@monjalon.net>
In-Reply-To: <20261026200950.1094549-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261026200950.1094549-1-roma55592@yandex.ru>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

26/10/2026 21:09, Roman Khromenok:
> Hello,
> 
> Gentle ping on this RFC for 27.03.
> 
> I would like to agree on the direction before working on the next
> step, CMIS decoding, which I plan to add to this library. The open
> points are in the cover letter:
> 
> 1. The library name: "transceiver" or "xcvr".

"transceiver" reads better, but "xcvr" is shorter.
I cannot decide.

> 2. Whether rte_eth_module_eeprom_parse() stays as a wrapper
>    or is deprecated in favor of rte_transceiver_decode().

rte_eth_module_eeprom_parse() is experimental so it can be removed.


