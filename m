Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96365D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 16:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D224740268;
	Mon,  1 Dec 2025 17:07:10 +0100 (CET)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51]) by mails.dpdk.org (Postfix) with ESMTP id 889374021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 17:07:09 +0100 (CET)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-93539c5e2b5so2370636241.0
 for <dev@dpdk.org>; Mon, 01 Dec 2025 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1764605229; x=1765210029; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=deZrYNwOXP8dgAxKyYMDdsU2PLY8vWGY4KAcqu0XySY=;
 b=EU4C9+5vh3AfuKBjAiyufpIk41Y8xPKIpfBPVHwJQu3cYvIvFCZX3CndgapxSrU/xm
 FDX0f6LOwr+hmxsjhPMa8cYxNCiLQnceS9tDc93Hvtsvq5Vr5D3ODbAyi9dSumMdYAgl
 Xqp+QeqJKNlGlB6XwI5bta8Zr0rtua0QE69J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605229; x=1765210029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=deZrYNwOXP8dgAxKyYMDdsU2PLY8vWGY4KAcqu0XySY=;
 b=YcAMfEc2f7OC6aaUHyNtRpGe1hVwNtQbIKIzwuGymE8QQzClmcZylAGAHM3i6xMK09
 /9oReiXFDTOkOEfsBYT3cBd2kpMO7Rx7dr+vhM+lLF8xxhiTAA8i2fpAOVzMjZOG8Swu
 ERW+TdBtgsD1tFrYOmfPfrV45EJHocHq6//8tcEz1m0B7FnmtYIw+DFhnvR+SdJrzvD+
 EaGCZ2nfTyV0ukvm10lfexbLaNuojho4d+tx6q5bBD/bB7JYKeREL1gqfC1YJkft55ct
 oYPGgrFPjDNehpvKnysorBpye5HJ7AbhF269fOSj+XDLT3G+LJU7yyxLfbniLRaB6rWZ
 Z1uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Y2hHAlU45FLOBCSgQID9w1zSg6MJ5R7Pe8D8l+4z3T2gXDR1jMio8wgAkycLjh0kLHQ=@dpdk.org
X-Gm-Message-State: AOJu0YxckeY7s7yeq4+mwxFR9e4WWyOM/fRQTEVJT+mfKOrTPtREvp9u
 Fs+86v91WAe6zEx8pwVmZPyVgUM0edCb9hLyzs0rcDJ8tlL1Bzqrhs4WPVEAV72Ek690S0pPhb8
 AxAqocSkLuIsnWYt4n8I8dLIAGZ2zAOwLbCO2j57/QgHAVckKrRwL/RuIYA==
X-Gm-Gg: ASbGncs4FVUsMDjmaNOwufNmm75UR1cP5OhyI8L2x1KAioKTdWpju5vee3YcN19vuuK
 QWNR5b0Phie+ru4JJ3Fzx5frbFNXZcvP3XJhJRolt1mIBOTR2J/GZu0bjnHurzZtgOK+gbxFpRh
 pPvzB4Ymq4M+902FgoR7fAlyYy4mxWEnzwN2QbarXwklkNCvp7piX0Ozs+86KPJ3x9S0EGPKL3t
 MjnWZG/6VbmEo+sf4x5ZFZk5J4rlpG3SyINVCTOa5JjhiIycIHxePpWmfdYhlP1kQmyhockeU1h
 MVncIiWP1IHIZCtRBvJ91PoArRat
X-Google-Smtp-Source: AGHT+IF6QPZYOUQqriYmeVpRfgfJx3z/RykiIM/8hv66XSpBAyOUvtqbDfWJnTgMJOX1WmordzalUk+agoAxAduB/ck=
X-Received: by 2002:a05:7022:789:b0:119:e569:f84f with SMTP id
 a92af1059eb24-11c94b0b4b8mr33796668c88.6.1764604862407; Mon, 01 Dec 2025
 08:01:02 -0800 (PST)
MIME-Version: 1.0
References: <db4d85aea29e4549b04750288db649c3@huawei.com>
 <F28176920A8AE2E0+20251201120508.120236-1-mannywang@tencent.com>
In-Reply-To: <F28176920A8AE2E0+20251201120508.120236-1-mannywang@tencent.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 1 Dec 2025 10:59:30 -0500
X-Gm-Features: AWmQ_bmZrIK0xxNSlxg9MXlAxA5PJVi-CkeMJ36ASFEc_y3ZDmShjkZjAOeWDvQ
Message-ID: <CAJvnSUBrCiEYqjTTC5My8pb1f3wQ_H+rV82iLxV9Yd3XY=kR2A@mail.gmail.com>
Subject: Re: [PATCH v4] acl: support custom memory allocators in rte_acl_build
To: =?UTF-8?B?bWFubnl3YW5nKOeOi+awuOWzsCk=?= <mannywang@tencent.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000fe339b0644e61512"
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

--000000000000fe339b0644e61512
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Putting in a retest due to an infra fail at UNH. No action on your end is
needed.

--000000000000fe339b0644e61512
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-intel-Performance<br><br>Putting in a retest due to an infra fail at UNH. No action on your end is needed.</div>

--000000000000fe339b0644e61512--
