Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B58606A320
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fXABRHL0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F3140283;
	Tue, 20 Oct 2026 00:06:00 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 746AF4021E
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:05:59 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-8565d77c277so19028457b3.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792447558; x=1793052358;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BF4yD++zZVbJJe1yNHI+botHIJClLDnQWEOwQrwgk+s=;
 b=BSKPm6bViPIYlNkLx7aoX6sgZANyY8FP0zns6W+aGzHbBYorsnKZpeyRLZjJAFeMUd
 4tJCWsiLWV+w8EQXCsLZ2ImZRyFRk0dDr6N6y25gwoO1jmHlrY1cf4MCf0QqNzIk70kk
 UX7cz13EtdxPZH25vlw1NzUi79ppqHNRYJF1EramzvhS4fU0mw92htxFVWRcZU6jtEx4
 FySlCb+amiY1AQ3DtzxKmbFDVD9T/NxmrP4P8r+fb7Rk9meZGfYolBHvCCbsrYpJ8Gp/
 aCQf+nAXVBzSIft014SILqi7D4nHhr1osFHb8+5TKuEp0dQlruI+37dBn+ytTQlVJxi+
 JKHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNK/u0n43dlwGiGJOkb+vK7sizqBT2qGwkhB9KhZVGOTfc2WMqpThFyttsQHzf4Pm6aBw=@dpdk.org
X-Gm-Message-State: AFq9FYLlytTnHkVvGhjj2+u4fN2heTB1rgaS4+3S777urzr2oBB0zR5g
 HPNvRvx39izVUJDT3hPKKm7DoCUznfylHeoo3bgfJnlWZ8v0F0lwQCI4h2WJFe/Lxwom9bXBQYR
 7BGbjbMbYitnnGw9e3jhn2KLOEwyyGDfvcm9R4nFYCAndc1EOD7qWXZDqnHEb1McYqWS8ZMXHD+
 /i0nuBY7rF4lI4FjmmYtYZv25cX+h3qMZWL9lJsFOxARsyYQdYbXFrOATt7ceb07v/pCPJBoUOm
 DEe1g==
X-Gm-Gg: AYBFou3Ig7qgfbIp5TedtCTrawjcInEG1gsKOo9hTlTUiFHXJHlMkW3QE3bHb7B0DT1
 p48g5m33Ct3L7eEGngVs+Hgu+cqA+j3LgeJzW1nWf27pR+O62UV2yfglpI8Hqpvmgw4USpLBkEG
 JtaSyfLcKo3ZGK9VAFL8cgZQMuH/dldBezSaKYGlW9G/xH7FXkCIFuliKfPbpqkI/dFd2HWFCMr
 2uLyaM3vrblsf/ZIoQVE6ebh/9psDJuJvw/NCvGChIuQWr0tb70ahhfLZNqY7ZaQSf9/BnhZ/B+
 JHEuH11SeLMKD3kgTjs/7pUOclcFKJ5TV1pX3BwoFuSXL2p6efC+LkmpUwnpyBnJXuAshPyRUCA
 4NGF5ceQ2q674j+TpnX2ry/AZQjZrhpLj6miLTY3jTQr1/7o49qGin7l9Fa4m4ywM1UuiFzK6Hg
 k9dC3TwRXEDQqyKLlw37omB8XunXAku87yagat7nyTbRYQDg==
X-Received: by 2002:a05:690c:44a:b0:8ae:88fb:3e12 with SMTP id
 00721157ae682-8b0f22024ddmr29083387b3.61.1792447558282; 
 Mon, 19 Oct 2026 15:05:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-8b11b851a04sm98107b3.45.2026.10.19.15.05.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:05:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6b3e381c7e5so504659a12.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792447556; x=1793052356; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BF4yD++zZVbJJe1yNHI+botHIJClLDnQWEOwQrwgk+s=;
 b=fXABRHL0O5pdstBddQ1xbdaNlFhjyTSK0LDFP0gEljMabGNHO6EVO6jeojNlAlYTwt
 /MadNBW4znSyyxGupDKAvgnaWF7zY2fJojxM+rnCOIIr53zihJ6M8Zt07rIUOquWfi/3
 rGGa7Uc0HHHf5MfeIu0qJxsJWh/qbGG7KIzPQ=
X-Forwarded-Encrypted: i=1;
 AKwUvBzb3ZrYywlWkg6WDfOSAZKDIGbMbJEKC/GA105BHV9rczBvjqSa9zoBkFfIbSeURgMojhc=@dpdk.org
X-Received: by 2002:a05:6402:13d6:b0:6b1:b0f3:35d4 with SMTP id
 4fb4d7f45d1cf-6b3a81a4f2cmr5345144a12.11.1792447556607; 
 Mon, 19 Oct 2026 15:05:56 -0700 (PDT)
X-Received: by 2002:a05:6402:13d6:b0:6b1:b0f3:35d4 with SMTP id
 4fb4d7f45d1cf-6b3a81a4f2cmr5345130a12.11.1792447556144; Mon, 19 Oct 2026
 15:05:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
In-Reply-To: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 19 Oct 2026 18:05:39 -0400
X-Gm-Features: AclHuK-PzoXv9CwLLwtgR_Ruh3L9xHJJCRZ_xm9zTzVo54MkYXqlFPG05miV0Oo
Message-ID: <CA+BST0n2PkJap9Dh0owwUnCeKE_dLzoZvWH4dberN6mg=zus0w@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: fix aliasing in firmware command writes
To: alex@goodkind.io
Cc: ajit.khaparde@broadcom.com, dev@dpdk.org, stable@dpdk.org, 
 thomas@monjalon.net, tarick@bedeir.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e9b846065e38b7a1"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e9b846065e38b7a1
Content-Type: multipart/alternative; boundary="000000000000dd01ad065e38b7ba"

--000000000000dd01ad065e38b7ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:49=E2=80=AFPM Alexander Goodkind <alex@goodkind.i=
o> wrote:

> Use memcpy to copy each firmware command word into a local uint32_t
> before writing it to the card. Replace the uint32_t pointer reads in
> bnxt_hwrm_send_message() with byte access.
>
> Fixes: 1cd45aeb3270 ("net/bnxt: support Stratus VF device")
> Cc: stable@dpdk.org
>
> Signed-off-by: Alexander Goodkind <alex@goodkind.io>
> ---
>
> VPP could not initialize the interfaces on my PowerEdge XR11 with a
> Broadcom BCM57504 card, using SR-IOV virtual functions inside an Ubuntu
> LXC container on Proxmox. The debugger showed an empty command header
> immediately before the driver wrote it to the card.
>
> The original pointer reads violate GCC's strict-aliasing rule [1].
> The patched driver initialized the interfaces and transferred packets
> with DPDK 26.03.0 and VPP 26.06-release. Separate build and software
> tests passed against the current Broadcom source.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
>
>  .mailmap                     |  1 +
>  drivers/net/bnxt/bnxt_hwrm.c | 11 +++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 5d1df79860..3143e642b5 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -65,6 +65,7 @@ Alex Zelezniak <alexz@att.com>
>  Alexander Bechikov <asb.tyum@gmail.com>
>  Alexander Belyakov <abelyako@gmail.com>
>  Alexander Chernavin <achernavin@netgate.com>
> +Alexander Goodkind <alex@goodkind.io>
>  Alexander Guy <alexander@andern.org>
>  Alexander Kozyrev <akozyrev@nvidia.com> <akozyrev@mellanox.com>
>  Alexander Matushevsky <matua@amazon.com>
> diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
> index ab1521953a..573a33b2de 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/bnxt/bnxt_hwrm.c
> @@ -483,7 +483,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,
> void *msg,
>         unsigned int i;
>         struct input *req =3D msg;
>         struct output *resp =3D bp->hwrm_cmd_resp_addr;
> -       uint32_t *data =3D msg;
> +       const uint8_t *data =3D msg;
>         uint8_t *bar;
>         uint8_t *valid;
>         uint16_t max_req_len =3D bp->max_req_len;
> @@ -526,7 +526,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,
> void *msg,
>                 short_input.req_addr =3D
>                         rte_cpu_to_le_64(bp->hwrm_short_cmd_req_dma_addr)=
;
>
> -               data =3D (uint32_t *)&short_input;
> +               data =3D (const uint8_t *)&short_input;
>                 msg_len =3D sizeof(short_input);
>
>                 max_req_len =3D BNXT_HWRM_SHORT_REQ_LEN;
> @@ -534,9 +534,12 @@ static int bnxt_hwrm_send_message(struct bnxt
> *bp, void *msg,
>
>         /* Write request msg to hwrm channel */
>         for (i =3D 0; i < msg_len; i +=3D 4) {
> +               uint32_t request_word;
> +
>                 bar =3D (uint8_t *)bp->bar0 + bar_offset + i;
> -               rte_write32(*data, bar);
> -               data++;
> +               memcpy(&request_word, data, sizeof(request_word));
> +               rte_write32(request_word, bar);
> +               data +=3D sizeof(request_word);
>         }
>
>         /* Zero the rest of the request space */
>
> base-commit: af80aca47b05d46f4a5e1951de3ce8372bd726b6
> --

 Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.54.0 (Apple Git-157)
>

--000000000000dd01ad065e38b7ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 17,=
 2026 at 9:49=E2=80=AFPM Alexander Goodkind &lt;<a href=3D"mailto:alex@good=
kind.io">alex@goodkind.io</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Use memcpy to copy each firmware command word into=
 a local uint32_t<br>
before writing it to the card. Replace the uint32_t pointer reads in<br>
bnxt_hwrm_send_message() with byte access.<br>
<br>
Fixes: 1cd45aeb3270 (&quot;net/bnxt: support Stratus VF device&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Alexander Goodkind &lt;<a href=3D"mailto:alex@goodkind.io" t=
arget=3D"_blank">alex@goodkind.io</a>&gt;<br>
---<br>
<br>
VPP could not initialize the interfaces on my PowerEdge XR11 with a<br>
Broadcom BCM57504 card, using SR-IOV virtual functions inside an Ubuntu<br>
LXC container on Proxmox. The debugger showed an empty command header<br>
immediately before the driver wrote it to the card.<br>
<br>
The original pointer reads violate GCC&#39;s strict-aliasing rule [1].<br>
The patched driver initialized the interfaces and transferred packets<br>
with DPDK 26.03.0 and VPP 26.06-release. Separate build and software<br>
tests passed against the current Broadcom source.<br>
<br>
[1] <a href=3D"https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html" re=
l=3D"noreferrer" target=3D"_blank">https://gcc.gnu.org/onlinedocs/gcc/Optim=
ize-Options.html</a><br>
<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c | 11 +++++++----<br>
=C2=A02 files changed, 8 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 5d1df79860..3143e642b5 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -65,6 +65,7 @@ Alex Zelezniak &lt;<a href=3D"mailto:alexz@att.com" targe=
t=3D"_blank">alexz@att.com</a>&gt;<br>
=C2=A0Alexander Bechikov &lt;<a href=3D"mailto:asb.tyum@gmail.com" target=
=3D"_blank">asb.tyum@gmail.com</a>&gt;<br>
=C2=A0Alexander Belyakov &lt;<a href=3D"mailto:abelyako@gmail.com" target=
=3D"_blank">abelyako@gmail.com</a>&gt;<br>
=C2=A0Alexander Chernavin &lt;<a href=3D"mailto:achernavin@netgate.com" tar=
get=3D"_blank">achernavin@netgate.com</a>&gt;<br>
+Alexander Goodkind &lt;<a href=3D"mailto:alex@goodkind.io" target=3D"_blan=
k">alex@goodkind.io</a>&gt;<br>
=C2=A0Alexander Guy &lt;<a href=3D"mailto:alexander@andern.org" target=3D"_=
blank">alexander@andern.org</a>&gt;<br>
=C2=A0Alexander Kozyrev &lt;<a href=3D"mailto:akozyrev@nvidia.com" target=
=3D"_blank">akozyrev@nvidia.com</a>&gt; &lt;<a href=3D"mailto:akozyrev@mell=
anox.com" target=3D"_blank">akozyrev@mellanox.com</a>&gt;<br>
=C2=A0Alexander Matushevsky &lt;<a href=3D"mailto:matua@amazon.com" target=
=3D"_blank">matua@amazon.com</a>&gt;<br>
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c<br=
>
index ab1521953a..573a33b2de 100644<br>
--- a/drivers/net/bnxt/bnxt_hwrm.c<br>
+++ b/drivers/net/bnxt/bnxt_hwrm.c<br>
@@ -483,7 +483,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,<br>
void *msg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct input *req =3D msg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct output *resp =3D bp-&gt;hwrm_cmd_resp_ad=
dr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *data =3D msg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t *data =3D msg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *bar;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *valid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t max_req_len =3D bp-&gt;max_req_len;<br=
>
@@ -526,7 +526,7 @@ static int bnxt_hwrm_send_message(struct bnxt *bp,<br>
void *msg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short_input.req_add=
r =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_cpu_to_le_64(bp-&gt;hwrm_short_cmd_req_dma_addr);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D (uint32_t =
*)&amp;short_input;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D (const uin=
t8_t *)&amp;short_input;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_len =3D sizeof(=
short_input);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_req_len =3D BNX=
T_HWRM_SHORT_REQ_LEN;<br>
@@ -534,9 +534,12 @@ static int bnxt_hwrm_send_message(struct bnxt<br>
*bp, void *msg,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Write request msg to hwrm channel */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; msg_len; i +=3D 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t request_wo=
rd;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bar =3D (uint8_t *)=
bp-&gt;bar0 + bar_offset + i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_write32(*data, =
bar);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;request=
_word, data, sizeof(request_word));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_write32(request=
_word, bar);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D sizeof(re=
quest_word);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Zero the rest of the request space */<br>
<br>
base-commit: af80aca47b05d46f4a5e1951de3ce8372bd726b6<br>
--</blockquote><div>=C2=A0<span style=3D"font-family:Calibri;font-size:11pt=
;background-color:transparent">Acked-by:=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"> <br>
2.54.0 (Apple Git-157)<br>
</blockquote></div></div>

--000000000000dd01ad065e38b7ba--

--000000000000e9b846065e38b7a1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCD386kdphhNPgiFS9O8r57TWYuDnPivQRECvy/6FRI/lTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMTkyMjA1NTZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBLwGTRJLcH
QfamMovT5DfsDmfwixeREZBqu1njXFMHU77fQEiGHVAPJE6Gvbar/npSNlgtE0KkXklWDrgyjMxE
uFl7Q6alWcoOAgLUisuFcsxkFsElmEM6vzLNXhjIq2q1lB3m+WhDTCzqTcumccAmpjFXzSq8p1EG
xUkjpG7lKqzFUgzYcBuk6UWwzTmoE/03EzOZsKkL5yxvmq6o3Qy+Bx7FYGCYivvzTNlL26lWzhJJ
2FjsZmZFSbkJs6f0oDzjLAMVu75+fDkuY5SSTCklSySikoTiY1/Y+fGS5BxeiJ727nZNoqBcwm9/
wjs2KTv7bF6Ha+ot/UCI+t2yywGA
--000000000000e9b846065e38b7a1--
