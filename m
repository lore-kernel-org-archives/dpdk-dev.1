Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBE5CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 18:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB3034021F;
	Thu,  6 Nov 2025 19:11:37 +0100 (CET)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCEC4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 19:11:37 +0100 (CET)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7866c61a9bbso12232827b3.1
 for <dev@dpdk.org>; Thu, 06 Nov 2025 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762452696; x=1763057496; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LRUODpYK/64gLgd9mEEjH37ZsXDehz+2Y3pUwzcKT0=;
 b=fQjsBz5Kve0YR8xZklnSXHulMb7r4drL4r0/OPeTI0jS+Yr29M+nbsg+5MnYr6mYSW
 2ccMgTlHO/yA+ynS/057RgUEDH24hJjf4QRkCVOHNGW/MKyPJP3jGyjvyuWIKrjeP6U+
 NnQmXVHfgC6RHg+A0VBOCqpvqQCmSHXgPezrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762452696; x=1763057496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LRUODpYK/64gLgd9mEEjH37ZsXDehz+2Y3pUwzcKT0=;
 b=erDTVc9ZeQsAGS/IkCxOUfoFpUT829Zwsq6F9W2KsLGvZstoWp294JshXmvdUWrTsp
 6ZXJFl2pYJRaoL2DejL/OnFmaU1fKZTluLlHKxfn4DJLcQFulMzsDakxHJIN63kJus81
 OMFV9sTvT8lA3UEALe0bM4n6I2l3dGuVWRtg7Vv5kX66oKtcSAY7TAnJpZz4Ol16vZw5
 2A3V4jpByKWtLHaqul8/Di8L8QkDFTnxUA+nyWun2DD8R7SgHcfqNVFBCmUT10xR0EBZ
 QhIryGQ7LaBrl8BFRB3K5hl62zR8W/1V4jFbcMfBXHqdr9rd37dLEhXVXhXtACqSWv4d
 ehBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuIN/afMIGRkToSrP9W80nnAmMd3O6+etID2WbchFUI/Zqnyx1uzj4Z2QR9qgfj1xpDP8=@dpdk.org
X-Gm-Message-State: AOJu0YwOHXxR3ZvWycIOwmPdEfS2LWB9BWEKa/eGb/jTTWvYSDs9ag5+
 jleUwUTnLqvHbeqrfOagce9w1aRbENTQerIxZyTgtDsLsF9H+ICOzHqpS1pB1c/b+uUgIBVPpBu
 ZxpsJ/g2KhRJV9HP73PE/QBGoBihCbBeYoAN1uybUAg==
X-Gm-Gg: ASbGnctZZ4M0ICu/1RA5Ct/gQTkZYZwFxbWoZXZetq+LudhteZJYzikPVaiY25D2VVg
 MqFU4G000arMitrfEaLZ5QOy9E3eyKVXzKeKwczyJEzTnbDGq/YdH3D1lrLF07P78FHKPJ+oUFG
 r8PGDPLUFIaJH8Yfm1EODAXm9ILTUo4K7TKLc+DeTSbVKVLsgrkt2z09JIWq2F/a/TLBWGc2jR2
 gQ4Nmku2E/1mdLHCXw+cz3G1RxZlhbEXYc9DiV0GTK/YxuBC7lPmh667Fbdgk0GgDrD3iLnfvBp
 FBY7Hadw3z/kqBWO9i0=
X-Google-Smtp-Source: AGHT+IHNemHxcX3ovOsmDInBquMxhoqoI3K1thbNXo9/e4YFZCLKjKnNSQBB4AN5JtTVt5E6BqtlfpT89GDYRdNZr8g=
X-Received: by 2002:a05:690e:250e:10b0:63f:a103:5d57 with SMTP id
 956f58d0204a3-640c41836bamr263847d50.5.1762452696552; Thu, 06 Nov 2025
 10:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20250820193815.61078-1-dmarx@iol.unh.edu>
 <20250826200720.104443-1-dmarx@iol.unh.edu>
 <6zyctvaihjdlgn3es3z2s3d3ae6ifc33vcqcobhylvz26m7ney@4nzef5s5lxnw>
In-Reply-To: <6zyctvaihjdlgn3es3z2s3d3ae6ifc33vcqcobhylvz26m7ney@4nzef5s5lxnw>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 6 Nov 2025 13:11:24 -0500
X-Gm-Features: AWmQ_bla3EkLb1YWN6Sw-J8zfjhgijDl9ty8rJudGBl_oBByFU7Niw8UILkgHaA
Message-ID: <CABD7UXNVrNEOtfs_4chWpy3-meVkF8cCE=PD-X+ST42nzW7UAg@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add test case docstring checks to format script
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, 
 paul.szczepanek@arm.com, dev@dpdk.org
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

On Wed, Aug 27, 2025 at 11:46=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.c=
om> wrote:
>
> Hi Dean,
>
> thank you for your patch! Looks mostly good, a couple of comments
> though.
>
> On Tue, Aug 26, 2025 at 04:07:20PM +0000, Dean Marx wrote:
> > diff --git a/devtools/dts-check-docstrings.py b/devtools/dts-check-docs=
trings.py
> > new file mode 100755
> > index 0000000000..0baee6e383
> > --- /dev/null
> > +++ b/devtools/dts-check-docstrings.py
> > @@ -0,0 +1,52 @@
>
> Consider adding a shebang here, like it's already done with the other
> scripts.

Heard

>
> > +# SPDX-License-Identifier: BSD-3-Clause
> > +# Copyright(c) 2025 University of New Hampshire
> > +
> > +import sys
> > +from ast import FunctionDef, Name, walk, get_docstring, parse
> > +from pathlib import Path
> > +
> > +BASE_DIR =3D Path(__file__).resolve().parent  # dpdk/
>
> The hint is actually wrong, this is dpdk/devtools. I think you meant to
> make this:
>
>     BASE_DIR =3D Path(__file__).resolve().parent.parent
>
> > +TESTS_DIR =3D BASE_DIR.parent / "dts" / "tests"  # dts/tests/
>
> and this would just be:
>
>     TESTS_DIR =3D BASE_DIR / "dts" / "tests"

Thanks for catching this, I hadn't realized

>
> > +
> > +
> > +def has_test_decorator(node: FunctionDef) -> bool:
> > +    """Return True if function has @func_test or @perf_test decorator.=
"""
> > +    for decorator in node.decorator_list:
> > +        if isinstance(decorator, Name) and decorator.id in {"func_test=
", "perf_test"}:
>
> I wouldn't hard code the decorator names like this. Put this in a
> constant at the top instead:
>
>     DECORATOR_NAMES =3D {"func_test", "perf_test"}

I'll add this to the new version

>
> > +            return True
> > +    return False
> <snip>
> > diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.s=
h
> > index 907eed1293..da6e6f34ee 100755
> > --- a/devtools/dts-check-format.sh
> > +++ b/devtools/dts-check-format.sh
> > @@ -86,7 +86,14 @@ if $lint; then
> >               ruff check --fix
> >               errors=3D$((errors + $?))
> >
> > +             docstring_script_path=3D$(dirname "$0")
> > +             docstring_script_path=3D$(cd "$docstring_script_path" && =
pwd)
> > +             docstring_script=3D"$docstring_script_path/dts-check-docs=
trings.py"
> > +             python "$docstring_script"
> > +             errors=3D$((errors + $?))
> > +
>
> I wouldn't insert this with the ruff if scope. This can still stay under
> the lint if block, but give it its own.

Okay, I'll add a docstringcheck variable in the check-format script to
give it its own if block
