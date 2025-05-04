Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BC5C369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 21:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DFEF402CA;
	Sun,  4 May 2025 23:22:38 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 5E23D40156
 for <dev@dpdk.org>; Sun,  4 May 2025 23:22:36 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso3853466a91.1
 for <dev@dpdk.org>; Sun, 04 May 2025 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746393755; x=1746998555; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BX2iYHISeJqvwLFj9oDbOchKU33y4XvJpqfUwlGQ8Jc=;
 b=WuZUTqoLbUhb5v8PFfcUC89XW+bImKUVDuKccBAxp0CJYWG2SX0ywcGeIfijcUFLLt
 sqTRrbBXuhWaC21qU+1y3YoMcnoz4xt/TtOnKZR93vmLWQccPABwAaXnuh2+zBuZWITJ
 JO0MDxQ4Wmtlw4d4AjSWWVlI6unUB0uvSIelA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393755; x=1746998555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BX2iYHISeJqvwLFj9oDbOchKU33y4XvJpqfUwlGQ8Jc=;
 b=K/Q004cd46ouzIoTbP8G5cxlIFIJlJx3jokwZEkaHg/K/tBoOGOAURj+FTT3osl4NO
 k0H1QfjSlew7KdP1yGlxi29vFIWM5aHZ+ws3BHYqqbiyXizqjaZSshpaTbNlkRCM2tKB
 duHyEX+H8YfTjQDZeEjBMjhaUba21Z6MQvYB6KP36Skju+c0tWZxdudM78e+3MiJGzd7
 maA9hIQm9bFa7NCg3Z1ErOl83EE6dmGMgQhhMZy21qjWZJ9TxgCc5a8rRWbSkeYjOy3r
 B2OnKeicb/6tGYD1iQtbbk0uTStO7YtjV284VlDVSrLhBNgQO+wysrIJNId74jsqau9n
 sk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCRoZlmi8p+m+EIYu9jZ6Ahg0KtKJFWoskZoxERbfDsVQmvf9scea86mFtOLTScqW/rtU=@dpdk.org
X-Gm-Message-State: AOJu0YxZEksKCD1TlxoNbLVg7dhg4HdKUme1UJeYWXSt2vhRwJSSyg8G
 mr3G54XRwitZQkzBKoUux6+5IMiRQNVyYdBxG8LhvwhcB2aKp4R2DO3TtKt8CCStDSOiFU6jOv0
 dtNr6WCpqGhekm4LBbsfeG1gRtkeyEGk08YvFcw==
X-Gm-Gg: ASbGnctTIb1P+uoA50Y7ikWEYhtIKQcInRQ26Poi9UkYR2OWtCA1Wl3ND65RidVBZLV
 oChUUGMkFWIb0HmRmF1pDoVvkMl3kXXbA6LDlEqhjvUZNX/Ifh8XgeVWtzRz+q0MIk3bmfrDC2+
 xgEo4nT3SJK4tWf90Tns61AybOrze2FZgwEg4CObpw48vHsVmJU7/Ojho=
X-Google-Smtp-Source: AGHT+IFDg/tDIUqynFwxPFytBdh8jIV9hsXO6BalHALJY3rNpFe5KOBUe4VtrrR4f+dAfyK79DMrFCKVxDrWbRTsNJE=
X-Received: by 2002:a17:90b:2e41:b0:30a:4c44:cc05 with SMTP id
 98e67ed59e1d1-30a6198d00amr8465046a91.10.1746393755609; Sun, 04 May 2025
 14:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
In-Reply-To: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 4 May 2025 17:18:02 -0400
X-Gm-Features: ATxdqUHSnD7mkFZzhsAlK1wfIfOLS75Q1jqBnKZzM4EHd-I49J4t2pHg9gs6VEg
Message-ID: <CAJvnSUAweypuEGUhho4q6F6NGxotja37tpDY9yynw=EuXDpzZg@mail.gmail.com>
Subject: Re: [PATCH] net/ice: update log message
To: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org,
 timothy.miskell@intel.com, Pillai@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007101e1063455fb43"
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

--0000000000007101e1063455fb43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the Community Lab DTS failure just reported on this
patchseries. I need to reconfigure the testbed and rerun the test.

On Fri, May 2, 2025 at 11:26=E2=80=AFAM Pillai, Dhanya R <dhanya.r.pillai@i=
ntel.com>
wrote:

> Added log message for ddp package load failure.
>
> mailmap: update contributor entry
>
> Signed-off-by: Pillai, Dhanya R <dhanya.r.pillai@intel.com>
> ---
>  .mailmap                           | 1 +
>  drivers/net/intel/ice/ice_ethdev.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index d8439b79ce..0f66ad834f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -353,6 +353,7 @@ Devendra Singh Rawat <dsinghrawat@marvell.com>
>  Dex Chen <dex.chen@ruckuswireless.com>
>  Dexia Li <dexia.li@jaguarmicro.com>
>  Dexuan Cui <decui@microsoft.com>
> +Dhanya Pillai <dhanya.r.pillai@intel.com>
>  Dharmik Thakkar <dharmikjayesh.thakkar@arm.com> <dharmik.thakkar@arm.com=
>
>  Dheemanth Mallikarjun <dheemanthm@vmware.com>
>  Dhruv Tripathi <dhruv.tripathi@arm.com>
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 21d3795954..bd55e0e7e1 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -2026,7 +2026,7 @@ int ice_load_pkg(struct ice_adapter *adapter, bool
> use_dsn, uint64_t dsn)
>
>         err =3D ice_copy_and_init_pkg(hw, buf, bufsz,
> adapter->devargs.ddp_load_sched);
>         if (!ice_is_init_pkg_successful(err)) {
> -               PMD_INIT_LOG(ERR, "ice_copy_and_init_hw failed: %d", err)=
;
> +               PMD_INIT_LOG(ERR, "Failed to load ddp package: %d", err);
>                 free(buf);
>                 return -1;
>         }
> --
> 2.43.0
>
>

--0000000000007101e1063455fb43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please disregard the Community Lab DTS failure just=C2=A0r=
eported on this patchseries. I need to reconfigure the testbed and rerun th=
e test.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, May 2, 2025 at 11:26=E2=80=AFAM Pilla=
i, Dhanya R &lt;<a href=3D"mailto:dhanya.r.pillai@intel.com">dhanya.r.pilla=
i@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Added log message for ddp package load failure.<br>
<br>
mailmap: update contributor entry<br>
<br>
Signed-off-by: Pillai, Dhanya R &lt;<a href=3D"mailto:dhanya.r.pillai@intel=
.com" target=3D"_blank">dhanya.r.pillai@intel.com</a>&gt;<br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0drivers/net/intel/ice/ice_ethdev.c | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index d8439b79ce..0f66ad834f 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -353,6 +353,7 @@ Devendra Singh Rawat &lt;<a href=3D"mailto:dsinghrawat@=
marvell.com" target=3D"_blank">dsinghrawat@marvell.com</a>&gt;<br>
=C2=A0Dex Chen &lt;<a href=3D"mailto:dex.chen@ruckuswireless.com" target=3D=
"_blank">dex.chen@ruckuswireless.com</a>&gt;<br>
=C2=A0Dexia Li &lt;<a href=3D"mailto:dexia.li@jaguarmicro.com" target=3D"_b=
lank">dexia.li@jaguarmicro.com</a>&gt;<br>
=C2=A0Dexuan Cui &lt;<a href=3D"mailto:decui@microsoft.com" target=3D"_blan=
k">decui@microsoft.com</a>&gt;<br>
+Dhanya Pillai &lt;<a href=3D"mailto:dhanya.r.pillai@intel.com" target=3D"_=
blank">dhanya.r.pillai@intel.com</a>&gt;<br>
=C2=A0Dharmik Thakkar &lt;<a href=3D"mailto:dharmikjayesh.thakkar@arm.com" =
target=3D"_blank">dharmikjayesh.thakkar@arm.com</a>&gt; &lt;<a href=3D"mail=
to:dharmik.thakkar@arm.com" target=3D"_blank">dharmik.thakkar@arm.com</a>&g=
t;<br>
=C2=A0Dheemanth Mallikarjun &lt;<a href=3D"mailto:dheemanthm@vmware.com" ta=
rget=3D"_blank">dheemanthm@vmware.com</a>&gt;<br>
=C2=A0Dhruv Tripathi &lt;<a href=3D"mailto:dhruv.tripathi@arm.com" target=
=3D"_blank">dhruv.tripathi@arm.com</a>&gt;<br>
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice=
_ethdev.c<br>
index 21d3795954..bd55e0e7e1 100644<br>
--- a/drivers/net/intel/ice/ice_ethdev.c<br>
+++ b/drivers/net/intel/ice/ice_ethdev.c<br>
@@ -2026,7 +2026,7 @@ int ice_load_pkg(struct ice_adapter *adapter, bool us=
e_dsn, uint64_t dsn)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ice_copy_and_init_pkg(hw, buf, bufsz, a=
dapter-&gt;devargs.ddp_load_sched);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ice_is_init_pkg_successful(err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_INIT_LOG(ERR, &=
quot;ice_copy_and_init_hw failed: %d&quot;, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_INIT_LOG(ERR, &=
quot;Failed to load ddp package: %d&quot;, err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(buf);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000007101e1063455fb43--
