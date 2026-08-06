Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CFCC56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5480C4027E;
	Thu,  6 Aug 2026 19:21:48 +0200 (CEST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 341A040262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:21:47 +0200 (CEST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso3213201a12.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036907; cv=none;
 d=google.com; s=arc-20260327;
 b=j+LmHQvKHPqggfR6jUY3DMBgU/y0lB156S/+TEWhGR/jafqprZMpWzL9kbbukVc3A8
 45PEDBO/Jt6fza51SXCEMdPtWnFB/8xg90/yTR4xQ8ZcFO6aSNEwSSEL543cSdL0226N
 /UyfuG09KRVsjIpRiA1si9JwoX17ozqWHZkW05DBcd2lzYnfmhxAcsMyCcndYKlnJ+7q
 oB6xw3Wn/tXYuH4ACt8X+qTLm1f+fCVpJ/2szVMpKYe67nRaWg/wZV5vnK5bYXpyVdMV
 slBYn3ZBLHeqwird0fXdo10r+psuZGYF5r9TBOM6dWS4OUgkXKZpbW15o6AL2C66odXe
 OtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1WpmGlIg1NCkcV4Btg1wbutjfC9Tvtne0TFv0vBWoS8=;
 fh=HsqiOxi/KN2B1l1xQhG9LOw/E+V6ldW+IdSl/xXrkdg=;
 b=XC9XheUPpHsdtlLS1YACcQY9s/xnf9JNiASUuw1B6QrkiJhR5/A6On7FSDNyupD4LG
 o8qyTsyqmcku++gy6XlVidot+ESZiEclLQ2UEMyK/PdNj0RiMV32Hd/yz35Qw4vPxUgE
 jt4OoaI/pDqcdJInjB0BbX1HkJH5LxzYwLdfUZ+eJkrfrAq/WYeo8QyDeLxZvwUJR4r3
 JLve95CFIIGGgJ2Kyw4epRNDPU0qc9/lxRk+mvPY30UnYetmWQot+1GwHXDTr9iV9q+T
 OseJXX3onqomtbvyvGKHW1lp8ySeabypSiDpTnpkrqBGkI+hKIENWIKFOVO+utL4V61M
 hZyw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036907; x=1786641707; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1WpmGlIg1NCkcV4Btg1wbutjfC9Tvtne0TFv0vBWoS8=;
 b=N0Tv+BzsBgP+Y0avkhST9MKYyjxFY/80v6GT+is0ZaYK2C4gzigDrhhhBV1XCIMQql
 FckjFU94WTNEtFJDRFeefA7Jj9U4nLN8pKQVKM6OSIQwq0KcKBpIuaZfDtXAyJpcGW4J
 nqp5CVc0uUn/nePM/OTOIqCHviHhBIb4Uxj2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036907; x=1786641707;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1WpmGlIg1NCkcV4Btg1wbutjfC9Tvtne0TFv0vBWoS8=;
 b=f1Q4jaexqs7enK63A/u/EZ0DevWsOoPXsK8id5gQx9mM2nQPGyZM5x9mq/seocZWb+
 CXC9DN2xNT1FEwI7e0wDfPQRq1kds3TE1n6Bgq/o7kqiBAIGjobeN16VYfyGpeKKGfVN
 J9pJvhbf2LB6qz2hyuA/C8YJ3B3akLSsCGmnT406L9PgodjEGmlgT3sndVv0gWLmndY6
 y5ucIFLteSFD4A7ld5JTmn/GnzX8WGjJuAEhr9Y0EgmBydW36cvzULMM1ATCBypCqQyu
 XCfmSdrtqC8WEfRDCawm7TRljcchTaJ4H2uvFRM8usC+op6Eo6BpnrA0svCWQnxRmkUt
 0pIQ==
X-Gm-Message-State: AOJu0YzQqXBpj8LzB/3WtUSK4Bu7Zvr6Q0ZP1f63VsGxCuqQZua/MqS3
 Lz8XPrBBwO2O17c1yVvFLSpUkvdjvaNnoRek2EVrsvkFt8E9BxxkjSfOefKzdyZGINwgrtDH+Mj
 vjn5fCJtUacgGVySfpIBCkzjZi0yyFxg+gb0xx2SiNqnDz2LRd/k7Qkc=
X-Gm-Gg: AR+sD12RbUkeJxQUxL1QSdZIlnA3O5OeMYqPkZbQxwQdlohOIWIprwAEpMvpKLkfYpg
 wqPd0qraBFHr8gnXQjNS1R+bP8fnf3Lj2gA3h12XUV16QfsTcoFH9S99FSyuj0Y7WdxHC+aw/Tg
 3xAqmQyZGBfRlWcvSB+B1BZgl5KIM0E73wpGFj8hKqCbiucoPg31ImHZz1LHVoRdSpk9ADHkMpj
 dl53SZ61F2wcPfRfF318Q8OkaD/zDEFW/+WWSJHwVhhlpOVdLUbpd71Lrxhqn59USH7yw8b0Uem
 0TtcicpEvOQhLB3JPF5ZW7lx0m933xYnPTdO92GxkIkZxjLPkTfxOiy0gnQl
X-Received: by 2002:a05:6402:916:b0:6a1:2efd:8687 with SMTP id
 4fb4d7f45d1cf-6a14f132690mr9554150a12.14.1786036906914; Thu, 06 Aug 2026
 10:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
 <20260806171636.656181-8-abailey@iol.unh.edu>
In-Reply-To: <20260806171636.656181-8-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 6 Aug 2026 13:21:35 -0400
X-Gm-Features: AUfX_mxiurHxCZ-vLjNW5BDm9EGphHGNyMl1u2zn7HOs8bPUKOxEaGyjLUJpftA
Message-ID: <CABJ3N2VUaY3c2cOqdEzNeJ2ckmVbX1YMN0gHFFBQ5rwfPY=Z8w@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] lib: remove ICMP and IPv6 deprecated functions and
 macros
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu, 
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006482130658641fa3"
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

--0000000000006482130658641fa3
Content-Type: text/plain; charset="UTF-8"

Hi all,

I sent the wrong patchfiles out, please ignore.

Thanks,
Andrew Bailey

--0000000000006482130658641fa3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi all,<br><br>I sent the wrong patchfile=
s=C2=A0out, please ignore.<br><br>Thanks,<br>Andrew Bailey</div></div>

--0000000000006482130658641fa3--
