Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF2ACAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 22:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0251A40289;
	Fri, 19 Sep 2025 00:19:03 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 19EAB4027C
 for <dev@dpdk.org>; Fri, 19 Sep 2025 00:19:02 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-77615d6af4fso2162239b3a.3
 for <dev@dpdk.org>; Thu, 18 Sep 2025 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758233941; x=1758838741; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tAT+cc8xpm6I040kvVI0YoOmOotD7DnGtL55PzDwMTU=;
 b=aKsAs+CymmknlB1BtGRre2humENisuRdkol7SpQMo7FUIIoo6vHo+tCRB4vTpZlBQF
 SdPTMnt9xPHvho9G8qUvb9re0mIxfWjrsLDttJ73LOmvi8TIrOrUIuXH8pob05WImnb4
 kHrX0dPHdiNFWYCS5yXtSCCCea0DxYckj5wus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758233941; x=1758838741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAT+cc8xpm6I040kvVI0YoOmOotD7DnGtL55PzDwMTU=;
 b=AXm5jh7l6trh/VXDTQI6WMG4MHMD4t3bcRIVA7iJpWf3cdw/RGBU//Ub11tGt+OumQ
 5y8AnMsEHK/+veOhuGoUzbE5ysFNe9XKTGBR33EAo2P+PVvzi7sAvBGfhSddoHtG89TA
 +2yfxyA7CfY56lxlQvnK9d5Mw+qY4WMHjzlfeU8xc45rnNXv9WYv0GsRffVhRc47ett0
 DquIbpO/H/58pKy/FMOP/UgnQaJEJuenQeNHpjha5hNawVg098wZSRuLtRYzfMKJcbjP
 mfN7WuLeSbGuXYsBHkan8iZJTKsnjv+zUUREPiDKqg+hAvMpWvkYuBNu2xEsnlEFHRxX
 BhJA==
X-Gm-Message-State: AOJu0YyAmliBiynvbm9soLSnXcCPsEvQZKwLlAuWz4OXZQ8+NuQCVEwC
 vIzvj++4C0EzRu7JgRtJDVqTpLZ3NVlr0CYYG07/bzSt+44k2QwPAdsF39gQ8odgJ1FQcLd9Ptr
 YpIOpiMBTF0zsMi12C/0hvOrrKhOJe4WZgNzG4r/I9WaEnDNokMbV
X-Gm-Gg: ASbGncu6CBrUUU0vzZbfdJg1v3r6d3IjXf1gOJ59f92qDbTwaes8rgh/+492E/uiH1/
 F2iXfgmPxHDcWgZl+uyakNxm0xJoHQwz2Dkh2E65sZp/Kw2P1BT+umm+dQcDnLX94hRrTLBapaX
 WjiL+xHeFCn1VqNNZ3YMNhmZ+Puomzihi9YXpoRoS+Q1fUP7CD6tYv7kBkLmOjhTT2YtCjSkRrZ
 ot9s2tv7nihKu11/OqEmgQhhZFsZBfLWO+qHtt+C/fBjAUnuE4ekZkPuY8=
X-Google-Smtp-Source: AGHT+IGr7rknEWYAYAqOBKxMZ/oVikJqffl3DP+SONRJN4c3j3kHY+8uvVSOdQheaH3xE5lKZKVObcu8tB83sMBm5Ho=
X-Received: by 2002:a05:6a21:9999:b0:251:7f83:11d0 with SMTP id
 adf61e73a8af0-29257e10eb7mr1660096637.5.1758233941205; Thu, 18 Sep 2025
 15:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250910152103.976383-1-paul.szczepanek@arm.com>
 <20250910152103.976383-2-paul.szczepanek@arm.com>
 <CAJvnSUD+qtkT88C_7q6BS8migv7r3cmdRtCMSq7KOk-ms1D1mw@mail.gmail.com>
In-Reply-To: <CAJvnSUD+qtkT88C_7q6BS8migv7r3cmdRtCMSq7KOk-ms1D1mw@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 18 Sep 2025 18:18:43 -0400
X-Gm-Features: AS18NWDdpeOIGH2nteDnM9Ka64Z0asOZ3_WH8pebVvDZXFjbUMe3So3vzvc4zpQ
Message-ID: <CAJvnSUDZAAy+Wh5-3oY8St4WoXHLQMNviMD0xCm6ZY8sYrBJCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: move testpmd into API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="0000000000007f7859063f1abdc9"
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

--0000000000007f7859063f1abdc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Per the discussion at the CI meeting this morning I ran all the existing
tests on a cx5 card and saw no difference in results with this series
applied vs running on for-main.

So, I will merge this series tomorrow morning. Thanks Paul.

On Thu, Sep 18, 2025 at 1:30=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
>

--0000000000007f7859063f1abdc9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Per the discussion at the CI meeting this morning I ran al=
l the existing tests on a cx5 card and saw no difference=C2=A0in results wi=
th this series applied vs running on for-main.=C2=A0<div><br></div><div>So,=
 I will merge this series tomorrow morning. Thanks Paul.</div></div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Sep 18, 2025 at 1:30=E2=80=AFAM Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Reviewed-by=
: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">p=
robb@iol.unh.edu</a>&gt;</div>
</blockquote></div>

--0000000000007f7859063f1abdc9--
