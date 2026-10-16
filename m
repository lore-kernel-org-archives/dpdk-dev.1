Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7BCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 00:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17D0E400EF;
	Fri, 16 Oct 2026 02:50:22 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id B2EAA40041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 02:50:20 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id F3CFCEC0242
 for <dev@dpdk.org>; Thu, 15 Oct 2026 20:50:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 20:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792111819;
 x=1792198219; bh=j2p3k6UIDWqOtECMgTwXh/NKIiOYuoR8Y4VtCgfbkKI=; b=
 dDkeFwABm77FLOQbOtuwp9SYC9rCI3YjW0lRl/xutkAO21Gmr90nefJadR6c4R82
 vUanGukhjDyaCkogeJh3NSfCICU38zISVimNrYZf26uvSHjr4AM9tQDwxb6wIQrM
 TFikIoXGkbLpUKcMkjzitLAUUUf8cIs3r6CeWIO9mx/pEN46BrQhByqm9HmLo5AP
 PwgIg3+YV0LVP3yTi/Qkw/Si1B2jIu3LinSaK/j9JTzhMG+gN3gLl//MTJ9o4ZXJ
 /osVNg6bionhRK8f7IECUjUi8LmW5wqnXovPPq25YkN0SLH5wGW7OvyZnBzpW+sV
 xlqYOpb5mC5Gffsnk6AtWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792111819; x=
 1792198219; bh=j2p3k6UIDWqOtECMgTwXh/NKIiOYuoR8Y4VtCgfbkKI=; b=Q
 p2ZofviZzx1fG5aAXqpvF0uvGR4JyJnfZTiwjRvGkLioadMe6e30CSZhYGeINjAP
 pggrvWF5F1VBrNNED3wPZfSTRHsl1lJ1ZIqyuAuUXTt+a1789pdAOHn+sfZN64zf
 K581GYUNOry0JCT6NPArsl2ScPXa93JA4OaUSOgKrYG67qdx2UIb1SLilqtjj8N1
 4ETHji8U8rJloTpGUYFr+csVq1Ae5wXQkQV1k5czT10BVYcdQL6O38MfcyC2EuBb
 E6mbo7ltmsVFwd1FrZ1kN95XtMjUiD0xbE/IfE+RdzZXHrMnPNVL5x7SHbE78UkP
 QCD2RrM+S49tbcSxOxNuA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792111819; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:gE0+M3tZtzX/zUSidaR+9h7/A225DB0vwS1Z41Cp8mVPbnz
 z8klv89zbu2rGUF34/oyV2gbc5Tk0RSoHOzJb6SwxGNW18o2y5LH5Q8supDvzzux
 EHsMHLUDOrlUTs2Hb+Bu3hhCyN6h+INJuV9YZDv4xa+po42++p6ZMKYOkTwlMLon
 Zo3yJEa8/hGBzvJ2XHxJP00klNiyPzJvwfC0I30c42PO987N0OyOX4nTdShZbsjy
 atYRa1ly97KwUeN5u35bzMZG5mANQ674q59ekpELNqePxDexGHjkIBwTKeAFLQTR
 u3+4Ln7sCZjAh8RXwazWaPlcH3/5pzI57IMJlvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:GNWgxY59wg4um7GvKDn1m7X/0yXuMmnjElgSl3Jo8QM=:mBLve0IHXnb85Es3U7/qNkP6PzlL+e8FnD0BteeKsaw=;
X-ME-Sender: <xms:y3TRajUJiimLIW8QkE8aXH8n7lwVUntEP4nJJZ2kt_N8vWuzfx0e8w>
 <xme:y3TRanDXfXUSjQfFj03M7zHEAg7gQ-c_jbjI3ULfbYqp2wlu5BE3kFCUb1myRh0T9
 M212xgJhz_u0I1lyP_44ILWd9WVdhxghSmltU9PBt4nvnTKKN-PcRk>
X-ME-Received: <xmr:y3TRai5uTllMeF8Da9Sa5ppQCChFsF5mUiZz1zC9798Rb7qQdQW_P75EhEoq6nocnBj7ItlZf4EaFYzGPsiKW6Q>
X-ME-Proxy-Cause: dmFkZTFfWx6mCL/ioaOddGbv3AQr4tFlyzfXPQmABTpX7fvqJzM0qn2Itj+572m5ZYbl8V
 GHXDjk+AeSwzl5o8vihoN6/WsVBte2TE42G7MdzjjG767t+SK6CEB9kCaw5kHBsmRwzllJ
 Zwtp2fwBe4X64uAgq4FtBwrULEmT5QCSEpPedJmE548TrQDpCK3NoFseQn8rdyqx7Qsy3B
 TrKJiPt21JYC04Ckk0V44h+HAhSvIPvLnud2YPLimMxqFdKt7QgmjBVGyI3spdKWRcUmRE
 NZL4F9ZIrmKUQXlW3R9/X8QJgalmyV8IjKwKsJmtef/EP62jH7oeDbA6AvJoVMzIHxuXat
 aPdqrFdOCzC/RZ+FYd/RuQ4CPXt0PT6prL2tB8iDXVvJZ0+72qARt6hBgk1zsvJyZ/K11E
 6EYWZUq3IcHESGoRTCpQjkvHUGQXOo7K7g63LTojG3jZDpOQmTZWvPa0unncFXCQ/Ue9y2
 jjY/SMc8rnUv/XgkYMaBGFjDqNgigVYrvPz2bu+f0yZ9+hEXr3qXvIxTPzYea21GtSAvvg
 F9xExl5psgt6KoOeRONsKZLLstEJEBHoVVYJ2d2tXQESzqDf7MgD8yyQ+L2VXEotCSMWUx
 43Fl4J/fEDDWTlTuvbRQ5tq5cNi5mDUphT+9f5HlKKuPGrKT4toqHW+qki0A
X-ME-Proxy: <xmx:y3TRaiwk9w7veBYRHDOGqiQj2xyLtunSAR0P0S_yA041fBl4Fv0JlQ>
 <xmx:y3TRapyBXI3JWGRmA_ZlUcne1Eu4t0dHQ0L3C2v9NXE3Qm7RuKZIUg>
 <xmx:y3TRaqyBRpbY9vqMGWYhFCw7umN6Pk0hqN8sfM3hRLe8ZtpYxp_qHQ>
 <xmx:y3TRajZ7Kzy38ofBVJyDVJyqzeIlxVoG46JGUl_H3G7blp6rchhVhA>
 <xmx:y3TRamwSYyn746kRAtAIzyxjGlLIjISvzeZhIHQqbI96VWujUPluEzC->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 20:50:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <qm2k21@gmail.com>, Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v4 0/7] validate-bpf: add standalone validation debug tool
Date: Fri, 16 Oct 2026 02:50:14 +0200
Message-ID: <zhxZqPS2RSGnsbCUD_zxpg@monjalon.net>
In-Reply-To: <4f90b8f5788e40fe94ddda11e94a474f@huawei.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
 <4f90b8f5788e40fe94ddda11e94a474f@huawei.com>
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

> > Marat Khalili (7):
> >   bpf/validate: fix finished status on restart
> >   bpf/validate: refactor internal step function
> >   bpf/validate: formalize call back requirements
> >   bpf/validate: add jump notification events
> >   bpf/validate: add get current event API
> >   app/test: add test for bpf validate debug events
> >   app/validate-bpf: add BPF validation application
> 
> Series-Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



