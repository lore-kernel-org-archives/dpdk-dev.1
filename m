Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3076C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 15:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE7B402DA;
	Tue, 11 Feb 2025 16:47:02 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id DCDA3402C9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 16:47:01 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fa40c0bab2so6496005a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739288821; x=1739893621; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HyupsvYxA82OBVeZL6P7KsGdH6OYgwmh08o1LDAxCcs=;
 b=aBLuLEzQf0s1WDQ2a/HbVZrkMqi4dZ1ZkrDft20OMfFX2GPLjBgVej1uMpYDv0B2AC
 fDBY7mW1otmAV2KAqiada3fyxg+uZyww+m0DopHWFSmjshCWgHJuO3dVT0Xp8Bi5Y+hb
 oyc99V88S2jId3weNHnl0oMC2sLzCTNeoGst0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739288821; x=1739893621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HyupsvYxA82OBVeZL6P7KsGdH6OYgwmh08o1LDAxCcs=;
 b=rNZA0kdYAiNyGUV0SwWAP7yNxX24i/pNwbCmRiAP72hbk3z10MmhK2vWuHc5P8h/KE
 kzY0tSUshQ9NXlbjjKyeb/D8qHt9LSoimJ4Trxw8OX0JnsnpdHBmHTsKLCWh4T8sKmUd
 lRUdm0sNppg1HtpQNOojgsHJJIClQKqJ2IBAcMd70OiseswaJGFPOBhFffy4om3AwgVW
 8n425ZpjBTCCk3MS/IWwq7BNyieyMNL0fYPOVy1qFqBHh99B0uEXLmrgGi2qhtmb7l+g
 t4jzNYMvy+KTmkAVCQdkjbFwQpFvx0xnSYpSi+lCtd+7M5e0rXulQ3dBWbtnSe1Q1QJa
 boDw==
X-Gm-Message-State: AOJu0YxPz8OsBpRSuwu2TQoBfVvo4ijboOfn2GuBYnF2m8PeEe3OcabL
 hrtotDHDEjJQ45WiNbb7LL41rwx91oLpLCVISos189oSrzq55q8pBspWttxNjykaf/973qe69Qn
 kZ1tFSlNt6T6P8DXBEBlElrypdYCuMNvNRVnJ5A==
X-Gm-Gg: ASbGnctj6Tg9iJaO7RF/J4kSHW2ll+7Csgj+RvzxtWtsFaS2j0tZOZhFNicj+xzkL0d
 +pvLGqBbkqVS2yZWiIosj1T/JT4711cOJKAWAM1YODn/UbNECKrvx8Ufa5GtV/ES0/OToYNaP3M
 /FT9uPjeJtD/YYhYhGjqphaO6FxzL58g==
X-Google-Smtp-Source: AGHT+IFNaIkFTCEU00gB8z0ufWS+YNZKzvjVaGLki7lIU7kqr/B6TJ51fzDo9UgAnDW+YhKqHxttcU0JmBHhIiXdeEs=
X-Received: by 2002:a17:90b:38cc:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fb63d30fb6mr379125a91.16.1739288820997; Tue, 11 Feb 2025
 07:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20250207182634.168820-1-stephen@networkplumber.org>
 <20250210172050.8884-1-stephen@networkplumber.org>
In-Reply-To: <20250210172050.8884-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 11 Feb 2025 10:43:47 -0500
X-Gm-Features: AWEUYZkTInw6o-KkS7GbWdNLC1tKUqrOLIqCPApVri0j6bJKwAi9j6lh3LHpSVk
Message-ID: <CAJvnSUCdVG-Az61VqnsVKRntALy-er+yE=_HDsREU7iTq=75wA@mail.gmail.com>
Subject: Re: [RFC] git: consolidate .gitignore files
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000567a47062ddfbc12"
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

--000000000000567a47062ddfbc12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:21=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

>
> diff --git a/.gitignore b/.gitignore
> index 903fe9bc64..a1a6843494 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -43,6 +43,8 @@ TAGS
>
>  # DTS results
>  dts/output
> +dts/nodes.yaml
> +dts/test_rund.yaml
>

test_rund -> test_runs

--=20
> 2.47.2
>
>
Thanks, I see no issue with consolidating.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000567a47062ddfbc12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 10, 2025 at 12:=
21=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
diff --git a/.gitignore b/.gitignore<br>
index 903fe9bc64..a1a6843494 100644<br>
--- a/.gitignore<br>
+++ b/.gitignore<br>
@@ -43,6 +43,8 @@ TAGS<br>
<br>
=C2=A0# DTS results<br>
=C2=A0dts/output<br>
+dts/nodes.yaml<br>
+dts/test_rund.yaml<br></blockquote><div><br></div><div>test_rund -&gt; tes=
t_runs</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
-- <br>
2.47.2<br>
<br></blockquote><div>=C2=A0</div><div>Thanks, I see no issue with consolid=
ating.=C2=A0</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div></div>

--000000000000567a47062ddfbc12--
