Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DF9EB5961
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 05:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB2FD402B5;
	Wed, 11 Feb 2026 06:27:33 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 191874026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 06:27:32 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-896f82e5961so26565416d6.0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 21:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770787651; cv=none;
 d=google.com; s=arc-20240605;
 b=X3PyD5qJMIa7UwPLDKdNRRUA61PbgLK5OGvPWSy5TcjQKpOAFR95T5crht5YcfYJBP
 s3iBbjS4QPnwa6gGk9y81y3AFz58JNLYAVOjPokosuFQ9cEz0Y3nVY6G8ANUiAvmil0l
 m0P2ttd4fLO86NQabny0Wze6hcS0IXeyTarVSYqS7fvCyTIkJ6iWCgD6XwFjsvsGTOpk
 EPDdTyUA2raZ/jBhwboE5yH+Vh8V2aoujUrBOFbHVrxXvnRIzMlceLEfOWND26HjYwYZ
 HISkcDes/mM+hGOOVRXUuPL5pbKnMXu96uNYBERq+pQbyQGKHXdRkP3jdaThIlkP4PnU
 Rr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4J/wHDuTdlErx/0omWEa2fdruwwbFc3GG30mJRLDaN0=;
 fh=39ai7dxpruQhwoieGFVm/82iE2ZdXXDn9YcTXHnNveU=;
 b=SU1KLlHv497yF891dcowxGt5sUbXJTMBcqX46MOMojjRwrkBF8S9/y11tAT/NXmDA/
 O66L6EOKPXguDOoWIpNp5kAZ0HCJBAEHb6kdwFyyCS+LyU8uvnY29aEKSbIrjr4zbsbC
 uUKHVV8Q47B3PR/xL4cX40uT7/8y+Plmuj4WLbi3WfI4K4dHFd37rtwJZgnVsuRYXm08
 TeVxDj0pVhq+GqxoVWdRYMt7TmjcbkGzL+JD9AUHscK/LyDwX4AThI9Z4l8CQTZ6ZtVd
 IleREIkKLD1nZ3kQvaRnuWs4FIw+v/KFZgWOgW2PYMd8GlinXoItv5Tb4lWI0tBf7Jt9
 VIvQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770787651; x=1771392451; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4J/wHDuTdlErx/0omWEa2fdruwwbFc3GG30mJRLDaN0=;
 b=MwUkazJsMyVxoAJxVdbpXwBbXrMs5icSUpOAveP4o1BKmxmzjfqbPZ46urCHWb70TI
 8t+wcaEQDIUgINTuxYiRI7fgF6wni+TgGDOzpb7kgC3sZQBZ0ovk510vva9D2Dqsj6xK
 SvgCFQEQSctqtIxMQ1FVC7P5E+wzog5G9jSidzy+TwLYqia5FE+4ZNGbJyk3dwXOwHZP
 cmWZv2sK9VFeSoSbdV7Pwqm731wO84o9luFjd6skiywqnOj/A074/l9LFJD1fYsS5/fo
 eXvRIE8bEztym0aYVPVthgnMVAl2ADOuf3i7iAIgmWszRBhM63EUBImWhD4sorIVuS2n
 ZZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770787651; x=1771392451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4J/wHDuTdlErx/0omWEa2fdruwwbFc3GG30mJRLDaN0=;
 b=WJyKhfZwAiTSvg9HWiDdyHfsEWtfuaHbvzEwL4vatcEcTCE4V8K2w0k670FCmWwjju
 t+66rhmzkk2875o2wwr54IT/SVwIKYUGYUcG54k2pTMTba4UhxgFz92Zj37qKf4ccpCn
 KrNPY/1SLYpzvO+Fk7KLW0uGz9V5E7oKrzeEAcpj1U4p5i24Ngoa7Y3t+yeHxtElrHlw
 igaxOg/01jIZuoTHsN1VdGGpTPqisCssNdjZfxBIxf2eTi3GmQPlEWn6PIx+hIFoGsdc
 U9ZQXXuTRI9zBUN1mgHITStqOL9K/mG0LZyDj/GtKgDJ67RenGmDtVn5oRFEuZnVKTdK
 9NQg==
X-Gm-Message-State: AOJu0YwXxpkbl2CV2mwfYNye6CBTY2g7qbDslOud4D85quSB3H+H/piL
 HQ6I4ucEFUCsTHK6oY9apt+681Wc4E7Sm40A91Gb3GAgOd7pA24F2vgoA0rW1385Cst4Izhi7CA
 f0/wGaqK888m2W/eq683A/Nq9RfYhe0E=
X-Gm-Gg: AZuq6aKIRPUryQlRU+Vpzi07u15ffiOmqS0km7jpXZkUASCaim9rg/gsrm4ksDz0NEJ
 7jwptVOX/tJIrrP6hmrLQtWJaJ4eK3Sw/t1aTnb/uCpmCN3gk/YAen8e/f7hqnDMYt63Z6rFWPM
 wi/ODmxi7CVhIUMOiS2vKng/FLBg5NwLXBmmLliLQykn+Fhv5yA4fn7vVvImv36ah7lFHtTrO0F
 fCL6cL8oMz20z4iH40bV1jg+F+cBSO1B1m23zIXmm4LDuGeYW9nPDNroW1S2ABGyr9wehP431Ae
 z1A=
X-Received: by 2002:a05:622a:f:b0:502:9a94:2f9c with SMTP id
 d75a77b69052e-50681222149mr20418881cf.44.1770787651240; Tue, 10 Feb 2026
 21:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20260116220617.116295-1-stephen@networkplumber.org>
In-Reply-To: <20260116220617.116295-1-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 11 Feb 2026 10:57:21 +0530
X-Gm-Features: AZwV_QjU5E7T39wASmXf9nBoezwAHnNPDGdwTYJnhRe5DfLWvUDO1RbWMlZ5Amk
Message-ID: <CALBAE1NDTRrqM=2ZETk+KtaC21Ob4KdjCj3scmgMPiBeTez1YQ@mail.gmail.com>
Subject: Re: [PATCH] doc/eventdev: correct grammar and style issues
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, 
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>, 
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, 
 Jerin Jacob <jerinj@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jan 17, 2026 at 4:53=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Use AI review to find and address various documentation issues
> in the eventdev programmer's guide:
>
> Grammar
> - Fix subject-verb agreement in multiple places
> - Fix article usage ("a" vs "an" before consonant/vowel sounds)
> - Fix relative pronoun usage ("which" vs "that")
> - Replace nonstandard verb "invocated" with "invoked"
>
> Spelling
> - Fix "setup up" to "set up"
> - Fix "as show below" to "as shown below" (multiple files)
> - Fix "rte mbuf" to "rte_mbuf"
> - Fix "rte_mbufs" to "rte_mbuf"
> - Fix missing backtick in RST markup
>
> Style
> - Capitalize "api" to "API"
> - Replace informal "For e.g," with "For example,"
> - Remove extra whitespace
> - Fix "benefit of" to "benefit from"
> - Clarify awkward phrasing
>
> Code example
> - Fix invalid switch syntax "case default:" to "default:"
>
> Path corrections
> - Update outdated library path from libs/librte_eventdev to lib/eventdev
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied to dpdk-next-eventdev/for-main. Thanks
