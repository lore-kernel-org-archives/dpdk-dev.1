Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E09FEC0FC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 21:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9797F4042C;
	Tue, 24 Mar 2026 22:02:57 +0100 (CET)
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com
 [209.85.210.99]) by mails.dpdk.org (Postfix) with ESMTP id 6A946402CC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 22:02:55 +0100 (CET)
Received: by mail-ot1-f99.google.com with SMTP id
 46e09a7af769-7d7653db148so3405070a34.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 14:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774386175; x=1774990975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENVoa8xjHFFtT4x/QLqrXbjt5yEJb6QUseX9rFreRaA=;
 b=WEtdTv0IFajgfj4GMXhm1UI5DeGs0rAPJnyBBCoYqoqWdkmW8mWqPt/Xqw1ULEFABG
 KlBxnB5RQ43F2vlreLc442256ubT53bCPdHug8Yj8U3WAJQ+Q6vglC8kXo5pQxBwyWwB
 DKeO17XkwH2MJDFlluX/A8ZgjQ4UvxhOIK8cYT+mxCJLgX7Y7rbEjAo4TI6ptaBbE7S8
 18CIuimuS2uy4mtqs27CmkmUW201pdwqalLvZQVR0zRH3nNAqx49leQVrR9QRzAHa3y1
 Fvx3IRjwK+Zkej9Nn1VOl/Bupb36RE5gTJc9eoFMHCNhEV8fgVkHNV5z13dq2Lwizxkf
 aQsg==
X-Gm-Message-State: AOJu0YyzRVAKjxMS8QsxnzVGBuovEhfrD9+YVEpj9zgbYsu8pTH32MAr
 EXpqMBJ/0jTo3AEPeYi/Xa/TcSKacvULJEDtBB54I+fPVPy9ntykgQNBvkQ2dn8HSE18pi3cF8W
 jNSnM4///+1c8unO1ejTYWQF/oZPsE0hPAaS+izlGP4XoKjwCE9IgTd3EH/MXv3T19BDRi1K11y
 MiY77B5jQTDPSQx7mVjWoRB7dl8d/i79U1wqxhWGwudS0zs+9FJ6+PD6E8r8NOiI2g9XYUUW77B
 49lIQ==
X-Gm-Gg: ATEYQzxUqH6NqcCHp1ThjNZlCtbgL+P+B0KZoD4Lj9UMwxuX8XnNEy2SmUEap2unpzl
 713Cw5rdEdIF+41n+pCbQr7Q5Ql9pceyw4zeqVOgZgyZPJdxIH0wNgcJZUjLL28bQyNAO21OE27
 v4E8NJZbULB7g4/RfOjbDgu4kNamN5TtH4zxCqjd6/fVjkpnXjw712yOvTsuugG+mNEpq1fGl4L
 QZmhwnIqXeaZyfocQQQ9xtntP/e0FL8wwQOa/54/qzBUTPxJDtk8VZ2VrAlbiJ/UwNOV3oMIqWy
 MEtm5VVtmQWo9OdDZatqN6yx0D2HCzTZflxVbsmPCbvwKaA0Ly3VBRYWB1BsOdVbPcRVXK+y90F
 vMMtLqpx6EVsTw0sxsxVlnFSVmOsvqyhY8M87JUNubeXPchZAJUFWLEtMVokyjnq9k3rGlKmDei
 oz7RV7cksP7AcKPkiasux/s4mbKoFBI4TMk+rlVwgwABMpIemlPjLJ8p7x8azceqVe6xk=
X-Received: by 2002:a05:6830:44a4:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7d9d66e9648mr524147a34.15.1774386174533; 
 Tue, 24 Mar 2026 14:02:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7d9d17860b8sm130042a34.7.2026.03.24.14.02.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2026 14:02:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6676eeba186so5647909a12.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 14:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774386173; cv=none;
 d=google.com; s=arc-20240605;
 b=XDr1FNHVNIqYa4d2o8BWw3f5F0tPsHQ9H5t00rR7lnr0YSejSBfXTPcR4RbfaS7lQa
 cSgAV9cyQXaIBX82CvMQHSTSuWLHiFkTrvAZiYSL67ewEpq9sWSD6UQOFLd0QVt5lIjZ
 3soOPXhCqVKKjtMAMw5fLLa/S9XgtaMtvMARQMmXHobyg+ENS62G9qThGtg/nRT90NGl
 0ObSfQxIoa39OX8h06gJyCCGAwkvV0NweI8nmfFTWbU0AeUjJ7znwE8TN9gxPHhIvUTb
 2S6Cgn3JfOnB5MVOPTN/l4XxshIn/9+CApFx89tF1QtBy8lFopVn56USjWuhU02RRQLM
 B7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ENVoa8xjHFFtT4x/QLqrXbjt5yEJb6QUseX9rFreRaA=;
 fh=ZM/Q+maMBufmZ4AECQZKz7wfFKp42pv804lz4VHaNO8=;
 b=Cqa6P5LpDm1yCVotNI9+HoTnx/iznR183wJi/epfGIBIPvrg7P3sPtBp125u/9s1OY
 E8P29VRJQgU+65VBul3MyQVrqLQomipl/yxiCDzpZyCTlIntWh9iXPFpdP41CvlN4X8z
 d9EKN4VGzcWP84WzMkSlL7TXrlufHdSGKugq3rRr6F8ZFpd9ErGZtjITd0HtgaOkM3CG
 8C7KqRITNs+j/EEKziFmG0u99hMgaauMFkx5odcFO5bi7N/sHEv9THaHXEUYOJsS6mW5
 6+DhQNgF7sYbqQDfUIEx2XudzotpQTpb/tRyWO+cOz58zNuPGBjhA4hXAlKUgonSZl5y
 eFHw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774386173; x=1774990973; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ENVoa8xjHFFtT4x/QLqrXbjt5yEJb6QUseX9rFreRaA=;
 b=GhxOGlLIbJK6H5wOnjVrcW5ocMAe/Lei7CUpQKkHTZbcZ+oU18zwJSoBymehW82FsJ
 7Kus0sXTDOfEwuKoW9jgbYbbcuqVb+LfCIHPQMaIKWDjpwBnztOrLzo/43QxMun2bkTk
 ucqej7wvplvNDraHEH55sAT8wpA7ffDpWarwc=
X-Received: by 2002:a17:906:6a02:b0:b98:2df5:9bd6 with SMTP id
 a640c23a62f3a-b9a3f146480mr54653766b.7.1774386172735; 
 Tue, 24 Mar 2026 14:02:52 -0700 (PDT)
X-Received: by 2002:a17:906:6a02:b0:b98:2df5:9bd6 with SMTP id
 a640c23a62f3a-b9a3f146480mr54652066b.7.1774386172176; Tue, 24 Mar 2026
 14:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260324204815.54465-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260324204815.54465-1-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 24 Mar 2026 17:02:36 -0400
X-Gm-Features: AQROBzDRHf7MLFz3Fqxi-ceJloL2rHaDem8bGqQOE-7TVOUdsQ90lql9aa_4e2k
Message-ID: <CA+BST0kjGN1rez_OWsrYdRHs0q=QiTv=s4iT7Xfq8Ag46PMDjw@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: fix l2_db_multi_page_size_kb position in
 func_qcfg output
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008c35f8064dcb7977"
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

--0000000000008c35f8064dcb7977
Content-Type: multipart/alternative; boundary="0000000000007cd57b064dcb79fd"

--0000000000007cd57b064dcb79fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:46=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> The field was placed at incorrect offset in hwrm_func_qcfg_output causing
> legacy_l2_db_size_kb to read svif_info instead, producing a doorbell offs=
et
> exceeding BAR2 and resulting in SIGSEGV on BCM57608.
>
> Move l2_db_multi_page_size_kb after mirror_vnic_id to match firmware
> response layout.
>
> Fixes: 04102f2ffc8c ("net/bnxt: update HWRM API to version 1.10.1.6")
> Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")
>
> Cc: stable@dpdk.org
>
> Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/hsi_struct_def_dpdk.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h
> b/drivers/net/bnxt/hsi_struct_def_dpdk.h
> index 26d5e9ca78..1a8874f5b6 100644
> --- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
> +++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
> @@ -16277,12 +16277,6 @@ struct __rte_packed_begin hwrm_func_qcfg_output =
{
>          * of the doorbell BAR between L2 and RoCE is required.
>          */
>         uint16_t        l2_doorbell_bar_size_kb;
> -       /*
> -        * The size of the doorbell BAR in KBytes reserved for multi-L2
> -        * doorbell pages. This area is a subset of
> l2_doorbell_bar_size_kb,
> -        * which is size of the total doorbell BAR space reserved for L2.
> -        */
> -       uint16_t        l2_db_multi_page_size_kb;
>         /*
>          * A bitmask indicating the active endpoints. Each bit represents=
 a
>          * specific endpoint, with bit 0 indicating EP 0 and bit 3
> indicating
> @@ -16605,6 +16599,12 @@ struct __rte_packed_begin hwrm_func_qcfg_output =
{
>          * or a raw QP.
>          */
>         uint16_t        mirror_vnic_id;
> +       /*
> +        * The size of the doorbell BAR in KBytes reserved for multi-L2
> +        * doorbell pages. This area is a subset of
> l2_doorbell_bar_size_kb,
> +        * which is size of the total doorbell BAR space reserved for L2.
> +        */
> +       uint16_t        l2_db_multi_page_size_kb;
>         uint8_t unused_7[7];
>         /*
>          * This field is used in Output records to indicate that the outp=
ut
> --
> 2.47.3
>
>

--0000000000007cd57b064dcb79fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 4:46=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moha=
mmad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:=
 Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broa=
dcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt;<br=
>
<br>
The field was placed at incorrect offset in hwrm_func_qcfg_output causing<b=
r>
legacy_l2_db_size_kb to read svif_info instead, producing a doorbell offset=
<br>
exceeding BAR2 and resulting in SIGSEGV on BCM57608.<br>
<br>
Move l2_db_multi_page_size_kb after mirror_vnic_id to match firmware<br>
response layout.<br>
<br>
Fixes: 04102f2ffc8c (&quot;net/bnxt: update HWRM API to version 1.10.1.6&qu=
ot;)<br>
Fixes: 7a1f9c782b50 (&quot;net/bnxt: add multi-doorbell support&quot;)<br>
<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab=
.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.=
com</a>&gt;<br></blockquote><div><span style=3D"font-family:Calibri;font-si=
ze:11pt">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/hsi_struct_def_dpdk.h | 12 ++++++------<br>
=C2=A01 file changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_=
struct_def_dpdk.h<br>
index 26d5e9ca78..1a8874f5b6 100644<br>
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h<br>
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h<br>
@@ -16277,12 +16277,6 @@ struct __rte_packed_begin hwrm_func_qcfg_output {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* of the doorbell BAR between L2 and RoCE=
 is required.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 l2_doorbell=
_bar_size_kb;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The size of the doorbell BAR in KBytes reser=
ved for multi-L2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * doorbell pages. This area is a subset of l2_=
doorbell_bar_size_kb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * which is size of the total doorbell BAR spac=
e reserved for L2.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 l2_db_multi=
_page_size_kb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* A bitmask indicating the active endpoin=
ts. Each bit represents a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* specific endpoint, with bit 0 indicatin=
g EP 0 and bit 3 indicating<br>
@@ -16605,6 +16599,12 @@ struct __rte_packed_begin hwrm_func_qcfg_output {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or a raw QP.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 mirror_vnic=
_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The size of the doorbell BAR in KBytes reser=
ved for multi-L2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * doorbell pages. This area is a subset of l2_=
doorbell_bar_size_kb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * which is size of the total doorbell BAR spac=
e reserved for L2.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 l2_db_multi=
_page_size_kb;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t unused_7[7];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This field is used in Output records to=
 indicate that the output<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--0000000000007cd57b064dcb79fd--

--0000000000008c35f8064dcb7977
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCjQsxLK6fe/UvTwrRMIGbvmcojR+uuj8Ynm93cfSMwUTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjQyMTAyNTNaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB2RgC7B1pv
Sy1UZ3nwWVwa5vqB53xrtGfYVXlaXPaGYOkhbK070CLuGPtLqxchDT7g1igWywKQfHNfk3nxYYk+
M7+Hof0KpwSkNwZV9nqU4K5fECvDvVZiDGvNFdi0R5cUHWWaCKZ9XzvPC+W8ee7vfYeEAINezujQ
gpyazKj9hLqGTmUrJtPei2en7/e50Zk4U4nu2ZRNqt+/Jd5yxaKAVWWOpQ6lnQ3qpXIWHI50yBYZ
oi9KpALvBSj/EKdNUh6gS8V+PmixgbkMDQ6qJeyt1y8UPETvfT3FOXrfpBXQ7vGVbcxozdBetjl0
6Z4LGliEsxDYq+DyJxUbdy3yICzL
--0000000000008c35f8064dcb7977--
