Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3EECA0EE6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 05:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C1140292;
	Thu, 21 Aug 2025 07:10:40 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id B64A44026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 07:10:39 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-70a88ddb1a2so6708686d6.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755753039;
 x=1756357839; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kuBSkJ/1iTFmJoViPU1mtO45nmFiB0b4NLqL1+0JCXY=;
 b=Q+zCEEla+yg0L3wyrScgVw2rkoMSecPizJtZikQ1lQMcROOclHWAxiZovbahI9OSVd
 7Ff5nAO+uwm6tJowfT48bIc7qET8MQf8pjKNaR9tR9uGVawLNkm1Br9im3hwIJ3TjU+b
 fAPYPFiY9zenD0EqmVTgkUJtJ4bn3yYtxAMcQiyQjIbSBjYBsg2jrgFXw2TCnwYRaNAC
 wQMInoFEptNlLJy/ocZMaDd46aSCbVCOKr6WAQxnH8uZ5JqOsG+7BIyFhM1tjrh/RPNE
 T0EfFzLkxNu2/jEYnH5iSwUe2O/UXGCghsQ1ASTfSDvSdKFg9qVUt3egqziPZ9jVHVRw
 n9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755753039; x=1756357839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kuBSkJ/1iTFmJoViPU1mtO45nmFiB0b4NLqL1+0JCXY=;
 b=AyPfL42vo0z980bN5ZWNFY0ESVTt4HxdCXb+SHvgfxTAbBh8ETVWLDdZJ4jBneDPWQ
 glIUFAXBmW6xwt22qsN6dPbPwQhmuW7XFLD3a1jtcMgOPRL1wXU5hRFHJxO8p1biMfNn
 7jycKgM+DGgTXUT5mDYRnixJCWkmhbbld8FnqPe/z7o4b4kyyENGZZUMqhZLu5kxzhw0
 A9F+YTO1GWc5Gp2JE1UTCTB3CG3HYWZ6xQn6QtGmr/DFn7MyVZn9cP2TnlzzRg6ei+Mv
 dc2IlFmynI3JdM8Y4+2ILGivIa8P3DDkYbsS1Hy0S8O7dWwN2Szj928tfjrlG32Fqtga
 ZA4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpwLWFY7UvqllCFOtvGGZXmAfPZ+rjC1NaGL3A0rG/E1iJB2p2XtU/YXWwfDODwxvXslM=@dpdk.org
X-Gm-Message-State: AOJu0YxdUAmfW4ZUbvR4GKXiNbGzCRz0c5zdwXFOo2oyn+07WS0W5m/N
 KUPQ5JI6Hg0GU3a5XZglW/oZpzYNsgEbvMmPvpee3nnGIugxuWMxw5G312HEliAJ9l0fsQjaQAX
 ni9U49EOhDCcYSitZ1aibgh9vcZ8xzMAMHp99iNdQnA==
X-Gm-Gg: ASbGncsc6sXL9MmrepTldJIbW0JiK4GcS9yGMLKf6P0zQLQ7v2B4Myq7r/VPNV8dKbL
 Amu4t2xrA6codXREg3JWm0b8j/fIFgRMxbywmDYqa/Og2I9kXlLIyW26Vb6Cdt+3EMF/lfdofh3
 DnN4LurAuTYsuqiM26nQNG2avIeOymhnhmWyPVrJusvOnzqbIi3/yNWGacTPder2dd9XOgUBurY
 5fLoDpz
X-Google-Smtp-Source: AGHT+IF3nID3BGtR4qmWsdo/oRZkdjifw8Mb9LKL/bSM4aWSnIxLEaYGsxy9QjIv+MazcGbFiUxRk9nMOwdpcgpM0X8=
X-Received: by 2002:a05:6214:250e:b0:70d:89b3:b9a7 with SMTP id
 6a1803df08f44-70d89b3be3fmr8073986d6.3.1755753039051; Wed, 20 Aug 2025
 22:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250814085831.3511020-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250815111514.3866449-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250820114845.5c18bb6b@hermes.local>
In-Reply-To: <20250820114845.5c18bb6b@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Thu, 21 Aug 2025 10:10:27 +0500
X-Gm-Features: Ac12FXxNooOfy0ydLGVXakCE4HEm3fCiGAAtkA8VgKCjjsvQyPqEO9pHf5ZUgjI
Message-ID: <CA++2-x5HeL41EpVrZ+gBf45xV4ojtqoxPc6_YKhFnir30j3C2g@mail.gmail.com>
Subject: Re: [PATCH] app/testpmd: add contrack CT state inspect commands
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>, Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, dev@dpdk.org, stable@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000034d179063cd91c35"
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

--00000000000034d179063cd91c35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,
Thanks for the update.
Should I correct the spelling in the commit message in the next version of
the patch ?


On Wed, Aug 20, 2025 at 11:48=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

>
> Queued to next-net after fixing spelling in commit message.
>


Best Regards,
Khadem

--00000000000034d179063cd91c35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div><div><div>Hi Stephen,=C2=A0<br>=
</div>Thanks for the update.=C2=A0<br></div>Should I correct the spelling i=
n the commit message=C2=A0in the next version of the patch ?<br>=C2=A0</div=
></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 20, 2025 at 11:48=E2=80=AFPM Step=
hen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@net=
workplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
Queued to next-net after fixing spelling in commit message.<br>
</blockquote></div><div><br clear=3D"all"></div><br><div>Best Regards,=C2=
=A0<br></div>Khadem</div>

--00000000000034d179063cd91c35--
