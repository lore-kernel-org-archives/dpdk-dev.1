Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F38CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57EEE40A84;
	Thu, 15 Oct 2026 16:58:35 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 4596E4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:58:33 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B687E7A0147
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:58:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 10:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792076312;
 x=1792162712; bh=aAbe9pAvkEFWQRZJWz2XeC+g0JRBMMwV5XEyowW/Adw=; b=
 UFNALR6PvyVzZpmxXtHQB4SfFXAFOQnA5mFkx3KmmoV87aJbzMhr0xixozGdhUqo
 TZ7P7Vfk1YxaMTR9W3cDnNspfjyUgqOWPSil3OQf7BaOgcJ5ptTxeF+dcZRcL54y
 7C/qEgSwBArPnLGf1ToX2FzjGJ+YMSqAXpHN3HngNtC7vxPYCz5fqWe634B5K6kC
 iNW0JFsVGcCBpOXMSkQyt6BHd9BCbX8nrJAU9+bWfVQciGSqdF/1FaguY1sbokKk
 MIciwlYt44Uon4mds8JeW2rImNHjULKNnI4UdFj+F2ZUMTR69G+jjM4qJExlvAy4
 xhutvChRpJFHPL4tvxgG0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792076312; x=
 1792162712; bh=aAbe9pAvkEFWQRZJWz2XeC+g0JRBMMwV5XEyowW/Adw=; b=I
 oSXwzQh6R5cfIkNV3bhm55+HuLDbl/hOZTSdFsgFOZ/g+LJvBk9y35wDE/wcBAME
 hLrBPgCTzdG2+ouZ48VZ5tlF3Xwr05U36rP4PtXdOHh455OlFoiMC142dJ/R4TUt
 nOND7F1j9OUz28ner0Q4kYWwVrtXBnUL/XOyUKLHYezHJBjfRriFVUPrn/gEn8Oc
 uMpgFCLVYN/jn7Y43PI4Axp103CL1wOXDn+16JnJIYjBwzgTt9U9lRpadkR7roAv
 xbFf/boH8O7lTctwn2xvorm1ljO68pfsTQN0frURk5oemFNOgaIHncBniWRb9AKE
 ilaPOW9gTKrpIdh0KjNKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792076312; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:kZ9GScHfySmQAETzpbKFavLEW8qSpJB8wzRhkvNVLf37zR3
 cR5dV07s8uaW7l9QunVUO7DgV4Q6NS8sECkv4UI+MiKidzY/tmxgBBLyXTO9GuFT
 TT7/4D5B76djR5AaBETVeC3AvE7dX72fc3un2uzogadksyyuhdN53Eu8sWOpR6+E
 8v+6m0RWHKhT37QBBJQQXeqQwNGeYoMsDAc3CboyByPqH0AWUQBZ/xEHIzuNgczm
 5gO77LwlMxTl6fabTUuGhlYZr44ZxNS7n784ATwYKYN5zL7tgiyNvyn/lGgYzJfK
 SblGK6LEfB4eY47lzHLOxgMsnopQTuwU40a+Yrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:jUBk30EWMtnqVCrJT0f+IhDozLjd/DKLRedfvMFGc3k=:V0IEtPIsw6M5xPSsWGVb5J2T4nzkRKIfO0K8wqQCrk4=;
X-ME-Sender: <xms:GOrQavTSiRWCAQqdvj8QMhet4up9SUY6J2iDPOj3IbyyZV9VV0_29g>
 <xme:GOrQalH1va2xugNVx-qngPwxpfn-ah9F8FB2mPk1GPh0oXI22gKmLIgZJ_fIpZYNT
 C4TRZdd34kYNHrq19wSNSJo6fH-l5h8IHxrGGJTcB80TGlG1utxcFMY>
X-ME-Received: <xmr:GOrQaj_siOQQEKDTkJMB5oY-c-YYTR2pzvnBtIH6ksiTDKC7RiqCOnKz1wxMJ09QJ7R7xTESox1ulty3CmZT6qg>
X-ME-Proxy-Cause: dmFkZTGxoctqNzP0UKSSLBmxOjZxhh1p580P8r8MlDZiQwtOcaHafn4NGmc7njBQJBvsw+
 Is/KsIa8GXWCRbnMUMTmkZJFm00xIp+7ESaEGfqWm686tlXUJm3T8y2DY8YUEPZL5h4Q24
 I5tNfejcSfBjlk+AeLiPQVhZvkexn53hXA48vDg2JpPSADF71qd9JQMGlZNkeyD+3upY7u
 zL5wpoeuF2U/L+yY+zDYY6eZtCCZCK+YnPXKdifi2FPDAFOoy5JV823Yw2QpnZ6pwPjGFK
 qmG0/5tfJCW8lGmEG+PNfa55pEVy7wEvio2h13eDu/1Fu+yE9h7c1YJhpEB+ZguDdL8kdn
 H/GDYKWHU75PNYE7HagsG68dgo2Z2obabzD6L6iXHhqgaGRpBGu8AAkBv3To55rhxnyk+z
 VvOm73oaUh5CQ2UisDZWNV0bNpqBD4aIskggN6FaK1T9ar6I/DkJez3CtC7sEKdnB6+0fy
 uLsohcZfYz70B2NDLaYFywPN3bZ7WSWApfgxmjVx4B3Y3/5Mnb6fH33P2nuqco+b/GU8OS
 kJHT3iZi8xFuaYoTYSA9D815XP0CYBD2WbYF7ac+IqD4ltFkTiZo/1UHoChKNGULeQlCbO
 hsyM0gkitNjXhRDSs5iQXjnH2sHw4I+bHMbvMwEbt9DTtBXa4ImlySKW2vsA
X-ME-Proxy: <xmx:GOrQanIoc3CrUdoDqT-2UwWIOLvQyLCQENxpAp6vZjpjjafI_3CUfw>
 <xmx:GOrQauas9LB-skcYBdz-uMIqH4kOHX4_EdR2MhjXLBe1Xql0frD4Kw>
 <xmx:GOrQapLFVux9As9AhNfzha1Mpr8ITtNlGwvDPEZFh8uNvev2sBxzxA>
 <xmx:GOrQasDGbL8t-Pt12Q0J7G4g9m5ks9y4MwohJsXIYwB45gFFU5TRaA>
 <xmx:GOrQaiFdZW2LbgxLYISGlECue4ufrYrosZUa4cg8aqxa0-Qewj1L5fMf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 10:58:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, hkalra@marvell.com
Subject: Re: [PATCH v2 0/5] Interrupts API update
Date: Thu, 15 Oct 2026 16:58:30 +0200
Message-ID: <JXnW8Ee-RSq-CrdpDaqh7Q@monjalon.net>
In-Reply-To: <20261014164313.1755520-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
 <20261014164313.1755520-1-david.marchand@redhat.com>
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

14/10/2026 18:43, David Marchand:
> This series is a simple cleanup to have a simpler helper that close all
> FD reference in an interrupt handle.
> It helped catch one small FD leak in FreeBSD EAL.
> 
> This should make life (a bit) easier on driver side and help limit FD
> leaks.

Applied, thanks.
We can expect some leaks will now appear in logs.
It opens the door to new fixes.


