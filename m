Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A0CAC59B
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:22:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8FD402E5;
	Tue, 16 Sep 2025 15:22:42 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 81D41402C2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:22:41 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-267a5aeb9f1so12456175ad.1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758028961; x=1758633761; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHtmP1/e4IBNDZ60YMMvz0TQZhhTw3toGIIIVU9gJWU=;
 b=OyUUhe641I9eW3r/ibercgZT3lyprR6sSe3lCxctsXsPvS9RNfYZiauIZKBtJiovrV
 LOA/nlA+e3vSgA7TazJOdU34/nwhPpc/PG9IKwqmFt6giiQpBiimUfxtPdsVp73p3TAV
 tdUHw5ycK2MfdfBwkeqo4W0XJdGq7SVIesY20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758028961; x=1758633761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHtmP1/e4IBNDZ60YMMvz0TQZhhTw3toGIIIVU9gJWU=;
 b=dsJbvgx/Crnqel9AsOuIfphnW/AofEyGPwhBVp9yQW6waZdpH7Fcd+2mOXGEkJVXD7
 COPWWTJzFvEktTPRPL3mDQOSfgNWqmslp/6EGBWxZsDzC+9Ck0ckyJN3sEU2urnPIXuI
 suWa72KAK983jeaMTMD2T1OLtfiRW/rWfRm+s5L6imip7/nx8Tc8j2JeuoxoOmPW7DWI
 fqmIUKr1k+wdKiftXShoK8979sJ6X3PZP3p4CWrhI/n1/W/ezRFtmJoToT4nYyj6dact
 ogvs3msEpzJfOBLrOIuixqZNAoJSB0PvsHuhtqChz0y4sVI7WtfQstQxDBBu48ZCmJaZ
 wh2Q==
X-Gm-Message-State: AOJu0Yw0M08RhWYaK4B740aoxim9DpW/ga6sEXIxGK/xLMGP5ugVbPdP
 Y80NmuX452lpNrOxzwwGimuWC9MyMY47IN1nHpskCE0e32Yf/eFHunBP4a0DJhzYfuR041uAwQP
 SVhegz4Zl5AvA4VIvOkfPWjPwZQD9rnId4v13RCYgcQ==
X-Gm-Gg: ASbGncuCjQx0QxvJKhKyL7n0NCKkeZEpIuUmhPQuPggxsajiTrqkWDnyoBzD87iaab6
 VzMr7+9X35T9NhYObs5XkCohlwhgURCIAsYeo6rRIIOToTXmYrcrEVt2MAXvLgzLNiZwRn4NRWb
 VLpHi1RwOox0piGhkep/0yTwPI6/lIVfkcbGMAAxBSgQe5aiCg+3Mq/SdDvVb3iznG0a3YZVwTy
 im3Y3ZZ6AaPnHTa6v4a49XOOBgAFmfyG/Cgb5ZdF+35W9FDSGY=
X-Google-Smtp-Source: AGHT+IHDZP+kLCeg1LkvIJnO28Yn9q/9KNEtb6Dv3XO1Fov75klxc4LX0Pam17DLRZbVJzt9kt1Pi2+rAeGzmC9TqrY=
X-Received: by 2002:a17:903:3888:b0:24c:bdf5:d74b with SMTP id
 d9443c01a7336-25d24da2d43mr209141595ad.19.1758028960638; Tue, 16 Sep 2025
 06:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250908163456.420268-1-shperetz@nvidia.com>
In-Reply-To: <20250908163456.420268-1-shperetz@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:15:38 -0400
X-Gm-Features: AS18NWDK9_DQIwtHlxmUKws_xchyspHiEoAoIhDcZHOsknzbtqiouA5ppW3CWXM
Message-ID: <CAJvnSUBtD-XRzn5x4q4WEhNZeXAcXPPbZQqh-4cdexVcpLhPBA@mail.gmail.com>
Subject: Re: [PATCH] eal: fix DMA mask validation inconsistency in IOVA VA
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Content-Type: multipart/alternative; boundary="000000000000b43e32063eeb03d7"
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

--000000000000b43e32063eeb03d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI The DTS failure for this series on patchwork for the MTU testsuite is
coming from a different patch than this one. Once I have that resolved, I
will put in a retest for this series which will clear up that MTU testsuite
failure.

On Mon, Sep 8, 2025 at 12:35=E2=80=AFPM Shani Peretz <shperetz@nvidia.com> =
wrote:

> When --iova-mode is explicitly specified in command line, DMA mask
> constraints were not being validated, leading to potential runtime
> failures when device DMA capabilities are exceeded.
>
> The issue occurred because rte_bus_get_iommu_class() was only called
> during IOVA mode auto-detection, but this function has the important
> side effect of triggering DMA mask detection (e.g., Intel IOMMU
> address width checking via pci_device_iommu_support_va()).
>
> This created an inconsistency, when choosing explicit mode,
> the DMA checks are bypassed, but when choosing auto-detection mode,
> the constraints are checked and enforced.
>
> The fix moves rte_bus_get_iommu_class() outside the conditional logic
> to ensure it's always called during EAL initialization.
>
> Fixes: 4374ebc24bc1 ("malloc: modify error message for DMA mask check")
> Cc: stable@dpdk.org
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  lib/eal/freebsd/eal.c | 6 +++++-
>  lib/eal/linux/eal.c   | 5 ++++-
>  lib/eal/windows/eal.c | 5 ++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
> index c1ab8d86d2..0f957919d3 100644
> --- a/lib/eal/freebsd/eal.c
> +++ b/lib/eal/freebsd/eal.c
> @@ -670,12 +670,16 @@ rte_eal_init(int argc, char **argv)
>          * with a message describing the cause.
>          */
>         has_phys_addr =3D internal_conf->no_hugetlbfs =3D=3D 0;
> +
> +       /* Always call rte_bus_get_iommu_class() to trigger DMA mask
> detection and validation */
> +       enum rte_iova_mode bus_iova_mode =3D rte_bus_get_iommu_class();
> +
>         iova_mode =3D internal_conf->iova_mode;
>         if (iova_mode =3D=3D RTE_IOVA_DC) {
>                 EAL_LOG(DEBUG, "Specific IOVA mode is not requested,
> autodetecting");
>                 if (has_phys_addr) {
>                         EAL_LOG(DEBUG, "Selecting IOVA mode according to
> bus requests");
> -                       iova_mode =3D rte_bus_get_iommu_class();
> +                       iova_mode =3D bus_iova_mode;
>                         if (iova_mode =3D=3D RTE_IOVA_DC) {
>                                 if (!RTE_IOVA_IN_MBUF) {
>                                         iova_mode =3D RTE_IOVA_VA;
> diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
> index 52efb8626b..3a0c9c9db6 100644
> --- a/lib/eal/linux/eal.c
> +++ b/lib/eal/linux/eal.c
> @@ -1042,10 +1042,13 @@ rte_eal_init(int argc, char **argv)
>
>         phys_addrs =3D rte_eal_using_phys_addrs() !=3D 0;
>
> +       /* Always call rte_bus_get_iommu_class() to trigger DMA mask
> detection and validation */
> +       enum rte_iova_mode bus_iova_mode =3D rte_bus_get_iommu_class();
> +
>         /* if no EAL option "--iova-mode=3D<pa|va>", use bus IOVA scheme =
*/
>         if (internal_conf->iova_mode =3D=3D RTE_IOVA_DC) {
>                 /* autodetect the IOVA mapping mode */
> -               enum rte_iova_mode iova_mode =3D rte_bus_get_iommu_class(=
);
> +               enum rte_iova_mode iova_mode =3D bus_iova_mode;
>
>                 if (iova_mode =3D=3D RTE_IOVA_DC) {
>                         EAL_LOG(DEBUG, "Buses did not request a specific
> IOVA mode.");
> diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
> index 4f0a164d9b..2502ec3c3d 100644
> --- a/lib/eal/windows/eal.c
> +++ b/lib/eal/windows/eal.c
> @@ -348,12 +348,15 @@ rte_eal_init(int argc, char **argv)
>                 has_phys_addr =3D false;
>         }
>
> +       /* Always call rte_bus_get_iommu_class() to trigger DMA mask
> detection and validation */
> +       enum rte_iova_mode bus_iova_mode =3D rte_bus_get_iommu_class();
> +
>         iova_mode =3D internal_conf->iova_mode;
>         if (iova_mode =3D=3D RTE_IOVA_DC) {
>                 EAL_LOG(DEBUG, "Specific IOVA mode is not requested,
> autodetecting");
>                 if (has_phys_addr) {
>                         EAL_LOG(DEBUG, "Selecting IOVA mode according to
> bus requests");
> -                       iova_mode =3D rte_bus_get_iommu_class();
> +                       iova_mode =3D bus_iova_mode;
>                         if (iova_mode =3D=3D RTE_IOVA_DC) {
>                                 if (!RTE_IOVA_IN_MBUF) {
>                                         iova_mode =3D RTE_IOVA_VA;
> --
> 2.34.1
>
>

--000000000000b43e32063eeb03d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FYI The DTS failure for this series on patchwork for the M=
TU testsuite is coming from a different patch than this one. Once I have th=
at resolved, I will put in a retest for this series which will clear up tha=
t MTU testsuite failure.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 8, 2025 at 12:35=
=E2=80=AFPM Shani Peretz &lt;<a href=3D"mailto:shperetz@nvidia.com">shperet=
z@nvidia.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">When --iova-mode is explicitly specified in command line, DMA m=
ask<br>
constraints were not being validated, leading to potential runtime<br>
failures when device DMA capabilities are exceeded.<br>
<br>
The issue occurred because rte_bus_get_iommu_class() was only called<br>
during IOVA mode auto-detection, but this function has the important<br>
side effect of triggering DMA mask detection (e.g., Intel IOMMU<br>
address width checking via pci_device_iommu_support_va()).<br>
<br>
This created an inconsistency, when choosing explicit mode,<br>
the DMA checks are bypassed, but when choosing auto-detection mode,<br>
the constraints are checked and enforced.<br>
<br>
The fix moves rte_bus_get_iommu_class() outside the conditional logic<br>
to ensure it&#39;s always called during EAL initialization.<br>
<br>
Fixes: 4374ebc24bc1 (&quot;malloc: modify error message for DMA mask check&=
quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Shani Peretz &lt;<a href=3D"mailto:shperetz@nvidia.com" targ=
et=3D"_blank">shperetz@nvidia.com</a>&gt;<br>
---<br>
=C2=A0lib/eal/freebsd/eal.c | 6 +++++-<br>
=C2=A0lib/eal/linux/eal.c=C2=A0 =C2=A0| 5 ++++-<br>
=C2=A0lib/eal/windows/eal.c | 5 ++++-<br>
=C2=A03 files changed, 13 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c<br>
index c1ab8d86d2..0f957919d3 100644<br>
--- a/lib/eal/freebsd/eal.c<br>
+++ b/lib/eal/freebsd/eal.c<br>
@@ -670,12 +670,16 @@ rte_eal_init(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with a message describing the cause.<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_phys_addr =3D internal_conf-&gt;no_hugetlbf=
s =3D=3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always call rte_bus_get_iommu_class() to tri=
gger DMA mask detection and validation */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_iova_mode bus_iova_mode =3D rte_bus_ge=
t_iommu_class();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iova_mode =3D internal_conf-&gt;iova_mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iova_mode =3D=3D RTE_IOVA_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_LOG(DEBUG, &quo=
t;Specific IOVA mode is not requested, autodetecting&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_phys_addr) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 EAL_LOG(DEBUG, &quot;Selecting IOVA mode according to bus reques=
ts&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_mode =3D rte_bus_get_iommu_class();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_mode =3D bus_iova_mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (iova_mode =3D=3D RTE_IOVA_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!RTE_IOVA_IN_MBUF) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova_mod=
e =3D RTE_IOVA_VA;<br>
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c<br>
index 52efb8626b..3a0c9c9db6 100644<br>
--- a/lib/eal/linux/eal.c<br>
+++ b/lib/eal/linux/eal.c<br>
@@ -1042,10 +1042,13 @@ rte_eal_init(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_addrs =3D rte_eal_using_phys_addrs() !=3D =
0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always call rte_bus_get_iommu_class() to tri=
gger DMA mask detection and validation */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_iova_mode bus_iova_mode =3D rte_bus_ge=
t_iommu_class();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if no EAL option &quot;--iova-mode=3D&lt;pa|=
va&gt;&quot;, use bus IOVA scheme */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (internal_conf-&gt;iova_mode =3D=3D RTE_IOVA=
_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* autodetect the I=
OVA mapping mode */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_iova_mode =
iova_mode =3D rte_bus_get_iommu_class();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_iova_mode =
iova_mode =3D bus_iova_mode;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iova_mode =3D=
=3D RTE_IOVA_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 EAL_LOG(DEBUG, &quot;Buses did not request a specific IOVA mode.=
&quot;);<br>
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c<br>
index 4f0a164d9b..2502ec3c3d 100644<br>
--- a/lib/eal/windows/eal.c<br>
+++ b/lib/eal/windows/eal.c<br>
@@ -348,12 +348,15 @@ rte_eal_init(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_phys_addr =3D f=
alse;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Always call rte_bus_get_iommu_class() to tri=
gger DMA mask detection and validation */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum rte_iova_mode bus_iova_mode =3D rte_bus_ge=
t_iommu_class();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iova_mode =3D internal_conf-&gt;iova_mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iova_mode =3D=3D RTE_IOVA_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_LOG(DEBUG, &quo=
t;Specific IOVA mode is not requested, autodetecting&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_phys_addr) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 EAL_LOG(DEBUG, &quot;Selecting IOVA mode according to bus reques=
ts&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_mode =3D rte_bus_get_iommu_class();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_mode =3D bus_iova_mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (iova_mode =3D=3D RTE_IOVA_DC) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!RTE_IOVA_IN_MBUF) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iova_mod=
e =3D RTE_IOVA_VA;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000b43e32063eeb03d7--
