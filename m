Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C5CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 Aug 2025 21:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F8894013F;
	Sun, 17 Aug 2025 23:21:24 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id F14674003C
 for <dev@dpdk.org>; Sun, 17 Aug 2025 23:21:22 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-619998ac786so2532443a12.1
 for <dev@dpdk.org>; Sun, 17 Aug 2025 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755465682; x=1756070482; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FF9qryTtNDPC7hFYQAAidukNmcsw5NUaPUlx3Dxcz+k=;
 b=RXGEhHINR8eBC1AmQZ0UzNeBuy8v25GQNYc2KNr7/AA088szGtck2K/aWtJmnjoaxq
 A3tQgm44fqm4m/RQcKt70kvXSo3qlpdTw1c+/wR4NLe5uUf3OSAP8H04bYquxTCxsAdi
 jIwVpfgS1stO7H0mJdmKrNs25mBee6k2yw+28fh68fJV1VfGMn/HQA8x9Fvdu7Klk9PT
 ULv8lxVvwzYNlN/gSqbVk2yz9IZOb9mBhOXh9NL7IF1++qiufJ/sXjRYSe8L2hXWv9SA
 GKcFw6YGqc/TalOXj0O7sM95hSF0aI8r8PatDxAcDe8pLA9Cg+SzncEQv/8KobjPno5X
 7Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755465682; x=1756070482;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FF9qryTtNDPC7hFYQAAidukNmcsw5NUaPUlx3Dxcz+k=;
 b=MfQ0FmRPoaVKJSREHhJovip4/WsD57W9Y0p91SpV3HywaNw/53PjWOGDqegzOJss0L
 ZB8QvocQ+elQdIJCdOB/n3O+W+CcSoOpTDCeNBmNXH07PPJLSiYu9t8+B/oaEFO8WoJP
 QcZQQCbZtVOezZpxTGim+/gg35YmSyvXmSPwJ2RLfCAxGHNRrPSDZ4A8KQQLVQ1X9VrA
 aUjgPGsuvN3xSKfZsT8GrzkBHhQNcXNemr6RIFLWVBkNusB9HeRNkhj6hNqO/eGn1aHz
 Uzu97ggE2/L5/DvF6qPXfvARwfpLfJWCReKGYDySuYixN5N5ZJa0r9I8mxvN/vlHtYeR
 tM9w==
X-Gm-Message-State: AOJu0YxMtjRdlRVRkED8v377UX8tTjYUQrtfzlYoFjn2WqMhx1WK6mj8
 SCmAc5FfPW1RWGGO2KBINzmElqRkRRFPqd3nmmeypdQ30SE9sYaJCZS4Z9tN7u2JfauZ9Z1IDC4
 WuxubtAIgNc8kdrogUOIboATBpu1faNEg/qGc
X-Gm-Gg: ASbGncuppLq8rId95+mBJoVbU9DVYLhbM84Z+27ScVCP/MFSxHSM8Gb02HCCA/g5zru
 L8VwkL/TTq9rYCdRanzmXxlr3oaRqC5bxYS0twVm32+YZfRvNYeTlQutQPXOmTLHTPnxC+dQsex
 DX7/H9/caVIO3LlIWsKqkFeN0uIDL2RlCDA/y6Qh4Tbon00BH8PeLRh1U6N1d6w6u5LohblluBG
 V5lF5MXg+AFa1DT0ug8D4BwFnDREtpnBuFZUtgAUGpvJDcC7LQ=
X-Google-Smtp-Source: AGHT+IHziKpspmgPJ8DFV5bXwgwdjAGqE9BlrUn3XXLfInRSoaGbvHnDP15fa86NNug1CApqHd4dkjrhnxYMaVs280A=
X-Received: by 2002:a05:6402:13d3:b0:618:3521:6838 with SMTP id
 4fb4d7f45d1cf-618b053231emr8270834a12.13.1755465682447; Sun, 17 Aug 2025
 14:21:22 -0700 (PDT)
MIME-Version: 1.0
From: Jetse Verschuren <jetseverschuren@gmail.com>
Date: Sun, 17 Aug 2025 23:21:10 +0200
X-Gm-Features: Ac12FXyTaH29JUZCboLqgJM0ZJG5wYWKmiWBM6mDSoakiQVJk7105Fgak-m9-LM
Message-ID: <CAJusU_XQj0csZYLyEZWcDFX96M7uGngpVvsjwHowpo3csLi3RQ@mail.gmail.com>
Subject: GDRCopy build failing
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006af25c063c963469"
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

--0000000000006af25c063c963469
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm really new to DPDK, so please excuse me if I'm sending this to the
wrong list and/or got some details wrong.

I'm trying to compile DPDK release 25.06 from source, with the goal of
exploring CUDA/DMA for packet processing. Compiling the project worked
fine, until I realized the GDRCopy feature needs some extra flags to
actually get enabled, after which my compile broke. I pasted the relevant
part of it below, that chain was repeating a few times.

../drivers/gpu/cuda/gdrcopy.c: In function =E2=80=98gdrcopy_loader=E2=80=99=
:
../lib/log/rte_log.h:364:9: error: static assertion failed: "This log
format string contains a \\n"
  364 |         static_assert(!__builtin_strchr(fmt, '\n'), \
      |         ^~~~~~~~~~~~~
../lib/log/rte_log.h:387:9: note: in expansion of macro
=E2=80=98RTE_LOG_CHECK_NO_NEWLINE=E2=80=99
  387 |         RTE_LOG_CHECK_NO_NEWLINE(RTE_FMT_HEAD(__VA_ARGS__ ,)); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
../drivers/gpu/cuda/common.h:20:9: note: in expansion of macro
=E2=80=98RTE_LOG_LINE=E2=80=99
   20 |         RTE_LOG_LINE(level, CUDA, fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~
../drivers/gpu/cuda/gdrcopy.c:31:17: note: in expansion of macro
=E2=80=98rte_cuda_log=E2=80=99
   31 |                 rte_cuda_log(ERR, "Failed to find GDRCopy library
%s (GDRCOPY_PATH_L=3D%s)\n",
      |                 ^~~~~~~~~~~~

When I looked in drivers/gpu/cuda/gdrcopy.c, there were indeed a couple of
log statements that ended with a newline character. Removing those newlines
has solved the compilation errors.

I tried to search the email archive for this issue, but have been unable to
find anything. If it indeed is a new issue, would it be helpful for me to
submit a patch?

With kind regards,
Jetse

--0000000000006af25c063c963469
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>I&#=
39;m really new to <span class=3D"gmail-il"><span class=3D"gmail-il"><span =
class=3D"gmail-il">DPDK</span></span></span>, so please excuse me if I&#39;=
m sending this to the wrong list and/or got some details wrong.</div><div><=
br></div><div>I&#39;m trying to compile <span class=3D"gmail-il"><span clas=
s=3D"gmail-il"><span class=3D"gmail-il">DPDK</span></span></span>
 release 25.06 from source, with the goal of exploring CUDA/DMA for=20
packet processing. Compiling the project worked fine, until I realized the =
GDRCopy feature needs some extra flags to actually get enabled, after which=
 my compile broke. I pasted the=20
relevant part of it below, that chain was repeating a few times.</div><div>=
<br></div><div>../drivers/gpu/cuda/gdrcopy.c: In function =E2=80=98gdrcopy_=
loader=E2=80=99:<br>../lib/log/rte_log.h:364:9: error: static assertion fai=
led: &quot;This log format string contains a \\n&quot;<br>=C2=A0 364 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 static_assert(!__builtin_strchr(fmt, &#39;\n&#39;)=
, \<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>=
../lib/log/rte_log.h:387:9: note: in expansion of macro =E2=80=98RTE_LOG_CH=
ECK_NO_NEWLINE=E2=80=99<br>=C2=A0 387 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_LOG=
_CHECK_NO_NEWLINE(RTE_FMT_HEAD(__VA_ARGS__ ,)); \<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>../drivers/gpu/cud=
a/common.h:20:9: note: in expansion of macro =E2=80=98RTE_LOG_LINE=E2=80=99=
<br>=C2=A0 =C2=A020 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_LOG_LINE(level, CUDA,=
 fmt, ##__VA_ARGS__)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
^~~~~~~~~~~~<br>../drivers/gpu/cuda/gdrcopy.c:31:17: note: in expansion of =
macro =E2=80=98rte_cuda_log=E2=80=99<br>=C2=A0 =C2=A031 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_cuda_log(ERR, &quot;Failed to fi=
nd GDRCopy library %s (GDRCOPY_PATH_L=3D%s)\n&quot;,<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~<=
br></div><div><br></div><div>When
 I looked in=C2=A0drivers/gpu/cuda/gdrcopy.c, there were indeed a couple of=
=20
log statements that ended with a newline character. Removing those=20
newlines has solved the compilation errors.</div><div><br></div><div>I=20
tried to search the email archive for this issue, but have been unable=20
to find anything. If it indeed is a new issue, would it be helpful for=20
me to submit a patch?</div><div><br></div><div>With kind regards,</div><div=
>Jetse</div></div><br></div>

--0000000000006af25c063c963469--
