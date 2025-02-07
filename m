Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0214AC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6E4F42D9F;
	Fri,  7 Feb 2025 13:33:48 +0100 (CET)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6D3B542798
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:33:47 +0100 (CET)
Received: by mail-il1-f182.google.com with SMTP id
 e9e14a558f8ab-3cfcf8b7455so14791665ab.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738931627; x=1739536427; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H0+o4QwVK1wwRzypiPrlS0Rt1tiJ9fYV0Q84ESgIwWI=;
 b=V73KJOjBjXLBFHG/e6YbTcsXVEBX0awsZymHj4M4/+MUleZ2VrvaWvzeOcX/+KyUi3
 adM9D0IiAJK0SOwP2ZatJDk69Y6KNC3jEvfP3T82ONM9BiTeKL4rHQyrJ5E0tQeOws1R
 wb2vavDikW/YTJb6BJqTrP4pUSk4Sv4vOqRps/bKkqNZp2q7bVkavLbSlNmyE01TExeU
 fOykXgNLRnDTFAfK9OM8bnpU00mcrXjZo0C4NzkeqiPCYbcKV7bSDgSIQ4rY7YVLCufO
 4DEXOVjtkp+SIqqUlOjtR5xr7zMfMQe7VMG7f882QsYr/updS7Fsvqq0s8MwklLJphqg
 7dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738931627; x=1739536427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H0+o4QwVK1wwRzypiPrlS0Rt1tiJ9fYV0Q84ESgIwWI=;
 b=iT1Q4C4Hz2zL2cmrmwwk5SEzGSBqO/MD7jkHQF46p1sqXzbzFuciZeoQPZjA+81BSg
 qNm2rBmCNGoj3CvVnY9ELcRazACMR1mvQgUZgzYmQcaOBb1HNNiPSnMW/XxQ/tvUcKAB
 kFMVr6WipOGBXuZy+11O+wQrUXE2S5ixj18pIK4eL+A6iqP9hQHNWUNJ+liiuEoqcQil
 ITk9Figggw03mh7VhozXU+hvrtGIqv+trKYnf4m/Ca0f8B7Y1tSvF+6mK4LI0QizeLkk
 SnBDMDNk1HAzOu1V/eM+2UxQXYnHXGnpM5EKnOxsx6Jh5TsEmRnrA5tyCsOUsTlMnEoy
 Pa+w==
X-Gm-Message-State: AOJu0YzAHrVIq/MJofRF3G0Tshv0kLSSVHEUNK4q04qdsRFkHqefVgze
 inCPcUcSoq772fAzp4oMK160N3r/B6MZs6CCxaoiwk32Ko911kDTZ9H53WEEBzkfpp8tM/TyxYK
 iF2wD7Hn8i0D8ChgqtVwB+KwqMe8v6kNofJ5rnA==
X-Gm-Gg: ASbGncvL5yQzvddj6A33Jg6bsTF7je2PshNXzZBBwshI/qs5EYqwbWogXx2M7BAoZcr
 5pILnkoaR/R+qA6J6gXWghI3VxR6n7KQw4ykOhqTC9lo7lpr+FVvJxLs490ImCwPsTUXvMvhtgu
 LVVh0vdhqqPfF0UDuprz6IA91htwgF
X-Google-Smtp-Source: AGHT+IHWGRy9pGtHwYWSa238PGs05C6Ynnu5n2BqOU6UL5dJK1VRQRGduNHk6B1Bn7y+jfF/+ildzuLJSFf/qpUaPUE=
X-Received: by 2002:a92:c266:0:b0:3d0:e6c:e9c5 with SMTP id
 e9e14a558f8ab-3d13e009029mr24897445ab.21.1738931626670; Fri, 07 Feb 2025
 04:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-3-ariel.otilibili@6wind.com>
 <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
In-Reply-To: <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
From: Ariel Otilibili <ariel.otilibili@6wind.com>
Date: Fri, 7 Feb 2025 13:33:35 +0100
X-Gm-Features: AWEUYZkbjVSk73pZ9gtOm2Dc3g11jCDXMNTdmdmY-NcpEF7zGLyd6SzRk0zU98Q
Message-ID: <CAF1zDgYZJLX7FBCpwMWrfiLm6si-8jpfppQaW1Cd36QoNOCOfw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Ciara Loftus <ciara.loftus@intel.com>
Content-Type: multipart/alternative; boundary="000000000000e59af3062d8c91f7"
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

--000000000000e59af3062d8c91f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:13=E2=80=AFPM Maryam Tahhan <mtahhan@redhat.com> =
wrote:

>
> On 07/02/2025 10:45, Ariel Otilibili wrote:
>
> Both legs of the loop share the same logic: the common parts are about
> reserving and filling both address and length into the description.
>
> This is moved into reserve_and_fill().
>
> Bugzilla ID: 1440
> Suggested-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com> <ariel.otilibi=
li@6wind.com>
>
> Acked-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
>
>
Thanks for your insight, Maryam; I've learnt a lot along the way.

--000000000000e59af3062d8c91f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, =
2025 at 12:13=E2=80=AFPM Maryam Tahhan &lt;<a href=3D"mailto:mtahhan@redhat=
.com">mtahhan@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 07/02/2025 10:45, Ariel Otilibili
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>Both legs of the loop share the same logic: the common parts are=
 about
reserving and filling both address and length into the description.

This is moved into reserve_and_fill().

Bugzilla ID: 1440
Suggested-by: Maryam Tahhan <a href=3D"mailto:mtahhan@redhat.com" target=3D=
"_blank">&lt;mtahhan@redhat.com&gt;</a>
Signed-off-by: Ariel Otilibili <a href=3D"mailto:ariel.otilibili@6wind.com"=
 target=3D"_blank">&lt;ariel.otilibili@6wind.com&gt;</a>
</pre>
    </blockquote>
    <pre>Acked-by: Maryam Tahhan <a href=3D"mailto:mtahhan@redhat.com" targ=
et=3D"_blank">&lt;mtahhan@redhat.com&gt;</a></pre></div></blockquote><div><=
br></div><div>Thanks for your insight, Maryam; I&#39;ve learnt a lot along =
the way. <br></div></div></div>

--000000000000e59af3062d8c91f7--
