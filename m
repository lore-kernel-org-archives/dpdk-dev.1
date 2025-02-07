Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A44C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB6D42D26;
	Fri,  7 Feb 2025 11:48:48 +0100 (CET)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5413E42B71
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:48:47 +0100 (CET)
Received: by mail-il1-f181.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so6187485ab.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738925326; x=1739530126; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mW+bTkxVkogKB6jBkmw916TWdFgbh8PxbS80ausoG58=;
 b=WfH0IacS5Pc9yO9hH4bj9Q4ckTOvGN7ey+VXOYA+S14IZtFakNCSNI5z4CNfb83rv4
 CJsTyVifgXkxZLK5wxxBQRdv8T1RmeTiHh/wn0sqb1rD+OxCg05k1fiXxixnBMQWg6zU
 Xbdl25va/IWuGCdQ8RYxm9bqb+R6RDYYrySDJI5rN6VDN9EZ5itibY2dK9nL214209uN
 Y7QveI3WxNSxc+0lzEiQEfCk7olqzCxgcONeeWnju28bICU4E228tZWOsCkR+Ecdwjo5
 TH1tZwlDWPxTcUcui2gdfR2wa3PEV/NMEJqW0QrbWhUVKLwAjGwLnuFT6GeTRokW6IaM
 h+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925326; x=1739530126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mW+bTkxVkogKB6jBkmw916TWdFgbh8PxbS80ausoG58=;
 b=A1EmImGmxzhPMkZvFQBczqJq73GC+Jj5rMBhx7xroIv1G2q3oeKnzcfh90BNEj8JDy
 m+s23KZMocLFX2LnvEjaxO2nzpnLpJsqTh6Ey5BraUxOhfClkJ/sjHHYJ/ZD+R1oxbQo
 F+aqxtk1CkmVCT93tUjsxQW8tMqQfRR+6R/N+EWSC/noSOlJXYw2uhdLO1naJJbaey8P
 KXTAiLDUQ1ozuG7Hv81u18oPaTJ5tj/wpthPSJb0aCUGwEXhoeSlzPvWq6e1B8LW5t5R
 HPl7osLH5l8gFVa83KBGa9Xr93xCM7L+WPmRj9BTGaUFhbCpLVKscIhD0Xi7pPEJwNSS
 8pqA==
X-Gm-Message-State: AOJu0YzEe/Q6xw1cmGMZbHw9x5TZEPN+gk+8AbUNQiydIb2mARcRgTRZ
 6w6qFKJ3nv0e6qGFtTaqi63I+e9Xr6LlP1KlvJkyf2xZzFlyH/Dj7y8XgFuiICy2S3h+WapcRaB
 jDtJyxOspg9eTIX+UiOyZT64QsewpBk8mg32S4w==
X-Gm-Gg: ASbGnctTRIJ+tvGqIpKVLYqvzayG6/2qGfk7cWRmdP/OaeVW5xcGfgw8tGqy7yByo1X
 LNJ5SWbglDiYRihuzvIe+ZN5s1FhbP66Mv0RYURKwP1N35lNR7Dd1EhYK9Ktm7LbTMa4KCiun2N
 eyR3uyQW1spWp3XJ8ZTQzFBY96rYzC
X-Google-Smtp-Source: AGHT+IGDjw35fQJ9dPWTYTdDXed7HcPEV7lQdEtqgRuPLI7v1/6wxqJq+LFeHN2PmhwmPM8sDaNDMWvcToiXQYLIc6U=
X-Received: by 2002:a05:6e02:3304:b0:3cf:c8ec:d375 with SMTP id
 e9e14a558f8ab-3d13da20395mr22516045ab.0.1738925326584; Fri, 07 Feb 2025
 02:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-3-ariel.otilibili@6wind.com>
 <CAFdtZivFid2eN0j5=YDnA9DC5GZNAEJDq-RqmYt-Ns26iuDw3Q@mail.gmail.com>
In-Reply-To: <CAFdtZivFid2eN0j5=YDnA9DC5GZNAEJDq-RqmYt-Ns26iuDw3Q@mail.gmail.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Fri, 7 Feb 2025 11:48:35 +0100
X-Gm-Features: AWEUYZlRJ8Xim6CRHsIionNz0XCw_f2-kYnIzJluBERXUAn1eViGXbFf7UUukUE
Message-ID: <CAF1zDgZPcdz34iQRA1ASPZ6qrZhg+dh=h87G8X5an29Zk0D5qQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="00000000000061ee19062d8b1a52"
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

--00000000000061ee19062d8b1a52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maryam, hi Stephen;

On Fri, Feb 7, 2025 at 10:14=E2=80=AFAM Maryam Tahhan <mtahhan@redhat.com> =
wrote:

> Sorry if my remarks were confusing, it was just missing from the previous
> patch and it needs to be:
> desc->len =3D mbuf->pkt_len;
>
> We need to keep this the same as the original code. This is a scenario
> where we need to copy the data from an mbuf that isn't in from the pool o=
f
> buffers allocated for the umem. So the desc->len needs to be set to that =
of
> the (non umem) mbuf.
>
> The other changes look good. Nearly there,
>
> Thanks again
>

Thanks for the feedback. There is it,
http://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@6wind.co=
m/

>
> <snip>
>

--00000000000061ee19062d8b1a52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Maryam, hi Stephen;<br></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Feb 7, 2025 at 10:14=E2=80=AFAM Maryam Tahhan &lt;<a href=3D=
"mailto:mtahhan@redhat.com">mtahhan@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D=
"auto"></div><div dir=3D"auto">Sorry if my remarks were confusing, it was j=
ust missing from the previous patch and it needs to be:</div><div dir=3D"au=
to">desc-&gt;len =3D mbuf-&gt;pkt_len;</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">We need to keep this the same as the original code. This is =
a scenario where we need to copy the data from an mbuf that isn&#39;t in fr=
om the pool of buffers allocated for the umem. So the desc-&gt;len needs to=
 be set to that of the (non umem) mbuf.=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">The other changes look good. Nearly there,</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Thanks again</div></div></blockquo=
te><div><br></div><div>Thanks for the feedback. There is it,=C2=A0<a href=
=3D"http://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@6win=
d.com/">http://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@=
6wind.com/</a> </div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto">&lt;snip&gt;</d=
iv></div>
</blockquote></div></div>

--00000000000061ee19062d8b1a52--
