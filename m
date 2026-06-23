Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF01CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:18:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E24DB402A2;
	Tue, 23 Jun 2026 12:18:42 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 670AF40269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:18:42 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id C02ECEC0209;
 Tue, 23 Jun 2026 06:18:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 23 Jun 2026 06:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782209921;
 x=1782296321; bh=hMZWXaz6W640sXKwfsRr/ZQRxRNDzlw6hlltGjuanJ0=; b=
 r5FNIGW7Z8A7BhY+FXQNfn6lULSAbgtkYA9TRK8pmmpJjopXF0DT2LHFUWHEkZSs
 ls7k/ieIMi5bYBeIPScWfMSRDdbefT4Jjwva0exp+Z1dZbX+B16/G8/4m18gpeN9
 GGubx1sUvL6aTE7YMJzxEdeUNuipcKgzxm3oXFRAs23Muceh6mKaly7m9AYdiIKj
 CvaL4BJecLu5odUZmuE8OnPJ3b3ULiGDAqppZ0vQ0ueTMMXT5ukVDiiYAUB5VK6L
 Uh+QmZ2MnzcJ4asGmJ3Cx4HZ/ZOy0g4T4aR8XIuq+eL+0r6hOecedERB1B0ukAVg
 3/9G3UKbKuuLk0X5QRrHlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782209921; x=
 1782296321; bh=hMZWXaz6W640sXKwfsRr/ZQRxRNDzlw6hlltGjuanJ0=; b=h
 ByPKr01vyH8H9hyL9UcQelovrGPwvXR65nsBg/fmjNfwoZ3BOHsj3KyHd5+h+ZH1
 SpDxJc2PsKr/+yIa2YjDhR9T8f08zAztUW8RpPbJISOl4MNm5rZLXX/fFY64PTYk
 ARP5WPBsGCBkbhcIY5u8zCZQMdaKIaidveghEQV55HCItnNH+IJOClfEJSRbK8ZZ
 Cim1w2NeV0VTuoIJ0AWPKb1kOgtKWowfopnyA8oTtMrlbiGonFoklgabn7UvTr8V
 v7QIIf7/VT4wnGKx4Dhbqi6ZYzy6o8tL4f1sc5wmzR6N3dygM3MDZLaNhp9Uvv1v
 O8jNllfNc0mxw2RTVN7qw==
X-ME-Sender: <xms:gV06atevBDl0ydViyhcg_xFCRU8dUnFfIx1rLUBatY9clwFtzuxR_Q>
 <xme:gV06avjzxaaKcBWw54KmjgrqoR7Z84JujVzolqX9GOglTr9HFINihDx-Ilo5ROgHQ
 flRNwaOnt2IhYilUYMSlNAdFvvpG_7XwJAaEvoC9x2E1Jtpcl8d2A>
X-ME-Received: <xmr:gV06alpjrq9icqcurYhHcKGeAcTbl-tecB-TrB0wfy88mPaTsJ-w1v2F_KfaGPpc3uOOqB5oS4fKgQAbKvuimuJidw>
X-ME-Proxy-Cause: dmFkZTGKAJK9lu141NUmLj49iZ/qPkr/rni8qNRDi2DwZcDSNcQTRY8G0hPuQvUDwNEfNM
 BsQ2RB3ypLKpJ9aUbRJDHeUqcGmfgyLMDKAm8bNsLctvrY1k46nSefE4Xf8xrU5PjaiJb/
 zOjkpt4wDDy9b2tW3592Iz/ZoDQ0ms6CQBiEYvCVVuoRDHMd/zF3kl7fshO0Hoa/a+WsLH
 nIwZCJWTWEig0Wvhdztopu/AeloC+GZTS/kEXE4svaNz92vz48+OFx3y8txWIwz26hpW+6
 AWwzUweqC85u6QYIHv/KhLgMh2nclpXoQWK2x7p3aHxClQRaletXhRM/JYL9OvgGTsceJs
 ul7GwmwkzeHlUysWevevcBbrQnoNW1v5/UXoiXMuKM65bPO60K51WOelcZgI8jUdVw7ybn
 Cfgksb/Asdl6T7f350nchByZnqu/cIev13D5x2sOb66pwq+rRCzR25RepzQM0wRmtUSTC3
 Lk3gAglibWnHLQYEH9x2adEZf+0rzXtHcmBD2lH06MDpgBE4rkeNpHC5z9XwOcxgw91Q5e
 voVGUhXL5i/EoNVB2icWkkLDFJxuz68Bersbyy/b4xjivWAO5Yh7+pvmFDUXtuSLlN2w3C
 cVFvZknKjMvgvZLblI0SMeBmPY2fev2yxG7BNkQL2cTnOisy4Mk7H+tYYq4g
X-ME-Proxy: <xmx:gV06avEgTc-Jvs3CNA1nt9M5kmDF4okKX-68JEetvEqKgeAu5-yDBQ>
 <xmx:gV06avmUGSDB68vHtHTg2S6lz92tWyELQnUugbW2JsAEwTg_iy2lUQ>
 <xmx:gV06aqmnEtONnrBMP_m32U2efRZZiQzd0GAkeBicX3yOLG8go8PejA>
 <xmx:gV06aou0wCn2kaaNEcuVhcuH1QQbKuZ6ugX_-Vv0yH6IwRz0L1x_HQ>
 <xmx:gV06ansow54ZK3pIJbcbUJKxxQuM38M3bEvNeU0XVmhRSazIEszzMQdz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 06:18:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v3 05/25] bpf/validate: introduce debugging interface
Date: Tue, 23 Jun 2026 12:18:38 +0200
Message-ID: <3BbIFKkFSyOqZrm3k570og@monjalon.net>
In-Reply-To: <20260612104743.6465-6-marat.khalili@huawei.com>
References: <20260519093131.52022-1-marat.khalili@huawei.com>
 <20260612104743.6465-1-marat.khalili@huawei.com>
 <20260612104743.6465-6-marat.khalili@huawei.com>
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

12/06/2026 12:47, Marat Khalili:
> +#ifndef LIST_FOREACH_SAFE
> +/* We need this macro which neither Linux nor EAL for Linux include yet. */
> +#define        LIST_FOREACH_SAFE(var, head, field, tvar)                       \
> +       for ((var) = LIST_FIRST((head));                                \
> +           (var) && ((tvar) = LIST_NEXT((var), field), 1);             \
> +           (var) = (tvar))
> +#else
> +#ifdef RTE_EXEC_ENV_LINUX
> +#error "Don't need LIST_FOREACH_SAFE in this version of DPDK anymore, remove it."
> +#endif
> +#endif

It fails on Alpine Linux.
Why adding this #error?


