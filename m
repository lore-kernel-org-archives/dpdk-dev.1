Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A97CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 20:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F3E84064A;
	Fri, 26 Sep 2025 22:50:54 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6693040277
 for <dev@dpdk.org>; Fri, 26 Sep 2025 22:50:52 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-267f0fe72a1so21556485ad.2
 for <dev@dpdk.org>; Fri, 26 Sep 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758919851; x=1759524651; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hLGEV7ocSjaPgX79k+x8+M014J4zPs9gjqn4tkYlIUA=;
 b=IjO3md+xz/95ghcNITvvljGlJdK/BZ9mE/7AqjdBOQTXDZndPtHOCTV+Rsv+ISJgJq
 Fwtx15mqD8CmdIJu0JwWGdEbaCT4h4dE7ANUnOHHcrwB6H5mnNQZDtzDkEqVfzXRCkNK
 yOS5/caBBIAsxdADKYw5nZsCwjXNdZWbU7yy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758919851; x=1759524651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLGEV7ocSjaPgX79k+x8+M014J4zPs9gjqn4tkYlIUA=;
 b=TN3RWl5Yz64j9UPhRsVQmb3wzA/qyNaqDCDe5PWLNM+iN8jZmCkLc+T14X2rt0wbkg
 lUArU6svC1Vl5DjuaGh9KBuBEZVCdIP8klFNcXAt5b4qOryNk3XrRnaEE9w1EqrM7oCt
 TL1HjYJ/xkeq/IGV7rhOyuJWLorVvndDPjelw2HYg/imIKOpfR9lFUCDruOsUyAih13f
 neayEO4jTuCYNHoCaMNcIa95/5WIMvgfoVDGC9Oago1RAglWdZgh3Q9Wb+7n/WTZBziR
 s+Z+wABMAJtg4wIYTooZwlzh8Pmd/tM857X41qeykP7exK+VKouT5i467xLHsXhEG8Yt
 H9/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqZMi4jUZ5E8OXByzNYHnFWR0PIrn7+xwVE1qPg7vg1Nk4GOW9Rpwg4t2dduY87DI/pM=@dpdk.org
X-Gm-Message-State: AOJu0YwWXtSV1MR+1p6seXars4C93iX/SOyV12QTS6TlLz9p/JotsjCr
 cQc6KVQgwoIAe9ATGz/UdGpph/eingnipKtKY6kxHM7un7hLkG9zsIhK/AcjuQ4SHUVEHrGnhbn
 Rv0pNt9IOX24VQ/9I4UEPq1r83ms+UhZYlHpNEN8D1g==
X-Gm-Gg: ASbGncsaBxAc+486AmEXhytbw4oxR3NdVcsq0kU9hA0w+Lh+8/J7CSEP+l2BPoiu7LG
 3HldlPIyzchIQzyYB+GB+Jw9rK6hQUDcpYTaJatG3fAmi89R0gqo6sKQSKxA0zQTmrzOihsZR2r
 Loloct0uVdZkYDc9THcxvkfRrxP1xQXE3/qFr7eCHCtAdgW+yZl6XBvAjT47iWpcsQ8RYJ3f8s0
 mtdl2QMGMsps1cw8t0tq8WQq6VZGL4TCw2Fnh+2
X-Google-Smtp-Source: AGHT+IHlt2qy3/XyHp8CxMV/tZ7gR0Yj5zsp7Scfc88pIbSqZtgwwEcq7RfrNqGi+SLp+saAEsF606HuFyPWe54fLfg=
X-Received: by 2002:a17:902:ceca:b0:269:b6bd:bc0b with SMTP id
 d9443c01a7336-27ed49b188cmr92178075ad.10.1758919851382; Fri, 26 Sep 2025
 13:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
 <CAJvnSUByJac475uKawdR7wGLFi1fptp8ducXHqJ=x4EmjpvGWQ@mail.gmail.com>
 <SJ2PR02MB979508BAD29B4BCE728EC4AF891EA@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB979508BAD29B4BCE728EC4AF891EA@SJ2PR02MB9795.namprd02.prod.outlook.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 26 Sep 2025 16:50:27 -0400
X-Gm-Features: AS18NWC5Sl7PrmucFtkql2xb6gdHHX25fXzh5H5qyflJ5P7nnsACS3u0APLsa24
Message-ID: <CAJvnSUBoj-U+GqQBsGKowM4ioZhfSFNobf+GQTs=idUx7s2hhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] compressdev: support for dictionaries and PDCP
 checksum
To: Sameer Vaze <svaze@qti.qualcomm.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000ee2d30063fba70b9"
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

--000000000000ee2d30063fba70b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sameer,

Thanks for your patience and I apologize for not reaching out yesterday.

Normally, if you want a retest you send an email on your patch requesting
one per the instructions here and it automatically gets picked up by the
Community Lab CI testing system:
https://core.dpdk.org/testing/#requesting-a-patch-retest

In this case I will just trigger the retest directly since I'm the
Community Lab manager. The failure in question should be gone in approx 30
minutes.

Have a good weekend.

On Fri, Sep 26, 2025 at 12:15=E2=80=AFPM Sameer Vaze <svaze@qti.qualcomm.co=
m> wrote:

> Hey Patrick,
>
> Were you able to fix the issue with the traffic generator? Is there
> documentation on what steps need to be done to request a rerun?
>
> Thanks
> Sameer Vaze
> ------------------------------
> *From:* Patrick Robb <probb@iol.unh.edu>
> *Sent:* Wednesday, September 24, 2025 2:24 PM
> *To:* Sameer Vaze <svaze@qti.qualcomm.com>
> *Cc:* Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <
> ashishg@marvell.com>; dev@dpdk.org <dev@dpdk.org>
> *Subject:* Re: [PATCH 1/3] compressdev: support for dictionaries and PDCP
> checksum
>
>
> *WARNING:* This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
> The CI testing failure for this series is due to an issue with the traffi=
c
> generator that is unrelated to the patch. I will resolve it tomorrow and =
do
> a test rerun.
>
> On Wed, Sep 24, 2025 at 12:19=E2=80=AFPM Sameer Vaze <svaze@qti.qualcomm.=
com>
> wrote:
>
> Adds definitions for PDCP checksums and apis to pass in
> dictionaries
>
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
> ---
>  lib/compressdev/rte_comp.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
> index 96d9b276dd..169d3d960e 100644
> --- a/lib/compressdev/rte_comp.h
> +++ b/lib/compressdev/rte_comp.h
> @@ -101,6 +101,10 @@ enum rte_comp_op_status {
>          * is not an error case. Output data up to op.produced can be use=
d
> and
>          * next op in the stream should continue on from op.consumed+1.
>          */
> +       RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED,
> +       /**< Checksum validation failed. Either calculated does checksum
> not match
> +        * the one provided or there was an error calculating the checksu=
m
> +        */
>  };
>
>  /** Compression Algorithms */
> @@ -166,6 +170,10 @@ enum rte_comp_checksum_type {
>         /**< Generates a xxHash-32 checksum, as used by LZ4.
>          * https://github.com/Cyan4973/xxHash/blob/dev/doc/xxhash_spec.md
>          */
> +       RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,
> +       /**< Generates checksum as defined under Uplink Data Compression
> +        * checksum as defined in the 3GPP PDCP specification
> +        */
>  };
>
>  /** Compression Huffman Type - used by DEFLATE algorithm */
> @@ -201,6 +209,11 @@ enum rte_comp_flush_flag {
>          */
>  };
>
> +#define        DEFLATE_MAX_WINDOW_SIZE (1ULL << 15)
> +
> +#define        DEFLATE_MIN_WINDOW_SIZE         (1ULL << 8)
> +
> +
>  /** Compression transform types */
>  enum rte_comp_xform_type {
>         RTE_COMP_COMPRESS,
> @@ -305,6 +318,15 @@ struct rte_comp_compress_xform {
>         /**< Hash algorithm to be used with compress operation. Hash is
> always
>          * done on plaintext.
>          */
> +       uint8_t *dictionary;
> +       /**<
> +        * Pointer to memory containing dictionary to be used for inflate
> +        * and deflate operations
> +        */
> +       uint16_t dictionary_len;
> +       /**<
> +        * Length of dictionary to be used
> +        */
>  };
>
>  /**
> @@ -328,6 +350,15 @@ struct rte_comp_decompress_xform {
>         /**< Hash algorithm to be used with decompress operation. Hash is
> always
>          * done on plaintext.
>          */
> +       uint8_t *dictionary;
> +       /**<
> +        * Pointer to memory containing dictionary to be used for inflate
> +        * and deflate operations
> +        */
> +       uint16_t dictionary_len;
> +       /**<
> +        * Length of dictionary to be used
> +        */
>  };
>
>  /**
> --
> 2.31.1
>
>

--000000000000ee2d30063fba70b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sameer,=C2=A0<div><br></div><div>Thanks for your patien=
ce and I apologize for not reaching out yesterday.=C2=A0</div><div><br></di=
v><div>Normally, if you want a retest you send an email on your patch reque=
sting one per the instructions here and it automatically gets picked up by =
the Community Lab CI testing system:=C2=A0<a href=3D"https://core.dpdk.org/=
testing/#requesting-a-patch-retest">https://core.dpdk.org/testing/#requesti=
ng-a-patch-retest</a></div><div><br></div><div>In this case I will just tri=
gger the retest directly since I&#39;m the Community Lab manager. The failu=
re in question should be gone in approx 30 minutes.=C2=A0</div><div><br></d=
iv><div>Have a good weekend.</div></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 26, 202=
5 at 12:15=E2=80=AFPM Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.=
com">svaze@qti.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div class=3D"msg-3743604220984076725">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Hey Patrick,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Were you able to fix the issue with the traffic generator? Is there documen=
tation on what steps need to be done to request a rerun?</div>
<div id=3D"m_-3743604220984076725Signature">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:11pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:11pt=
;color:rgb(0,0,0)">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"m_-3743604220984076725appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-3743604220984076725divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b>=
 Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">pr=
obb@iol.unh.edu</a>&gt;<br>
<b>Sent:</b> Wednesday, September 24, 2025 2:24 PM<br>
<b>To:</b> Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" target=
=3D"_blank">svaze@qti.qualcomm.com</a>&gt;<br>
<b>Cc:</b> Fan Zhang &lt;<a href=3D"mailto:fanzhang.oss@gmail.com" target=
=3D"_blank">fanzhang.oss@gmail.com</a>&gt;; Ashish Gupta &lt;<a href=3D"mai=
lto:ashishg@marvell.com" target=3D"_blank">ashishg@marvell.com</a>&gt;; <a =
href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a> &lt;<a href=
=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/3] compressdev: support for dictionaries and P=
DCP checksum</font>
<div>=C2=A0</div>
</div>
<div>
<p style=3D"text-align:center"><span style=3D"background-color:rgb(255,255,=
0);font-size:14px;font-family:sans-serif;color:rgb(0,0,0)"><strong>WARNING:=
</strong> This email originated from outside of Qualcomm. Please be wary of=
 any links or attachments, and do not enable
 macros.</span></p>
<div>
<div dir=3D"ltr">The CI testing failure for this series is due to an issue =
with the=C2=A0traffic generator that is unrelated to the patch. I will reso=
lve it tomorrow and do a test rerun.</div>
<br>
<div>
<div dir=3D"ltr">On Wed, Sep 24, 2025 at 12:19=E2=80=AFPM Sameer Vaze &lt;<=
a href=3D"mailto:svaze@qti.qualcomm.com" target=3D"_blank">svaze@qti.qualco=
mm.com</a>&gt; wrote:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Adds definitions for PDCP checksums and apis to pass in<br>
dictionaries<br>
<br>
Signed-off-by: Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcomm.com" ta=
rget=3D"_blank">svaze@qti.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0lib/compressdev/rte_comp.h | 31 +++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 31 insertions(+)<br>
<br>
diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h<br>
index 96d9b276dd..169d3d960e 100644<br>
--- a/lib/compressdev/rte_comp.h<br>
+++ b/lib/compressdev/rte_comp.h<br>
@@ -101,6 +101,10 @@ enum rte_comp_op_status {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is not an error case. Output data up to=
 op.produced can be used and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* next op in the stream should continue o=
n from op.consumed+1.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt; Checksum validation failed. Either calc=
ulated does checksum not match<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * the one provided or there was an error calcu=
lating the checksum<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0};<br>
<br>
=C2=A0/** Compression Algorithms */<br>
@@ -166,6 +170,10 @@ enum rte_comp_checksum_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Generates a xxHash-32 checksum, as used=
 by LZ4.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* <a href=3D"https://github.com/Cyan4973/=
xxHash/blob/dev/doc/xxhash_spec.md" rel=3D"noreferrer" target=3D"_blank">
https://github.com/Cyan4973/xxHash/blob/dev/doc/xxhash_spec.md</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt; Generates checksum as defined under Upl=
ink Data Compression<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * checksum as defined in the 3GPP PDCP specifi=
cation<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0};<br>
<br>
=C2=A0/** Compression Huffman Type - used by DEFLATE algorithm */<br>
@@ -201,6 +209,11 @@ enum rte_comp_flush_flag {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0};<br>
<br>
+#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFLATE_MAX_WINDOW_SIZE (1ULL &lt;&lt; =
15)<br>
+<br>
+#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFLATE_MIN_WINDOW_SIZE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(1ULL &lt;&lt; 8)<br>
+<br>
+<br>
=C2=A0/** Compression transform types */<br>
=C2=A0enum rte_comp_xform_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_COMP_COMPRESS,<br>
@@ -305,6 +318,15 @@ struct rte_comp_compress_xform {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Hash algorithm to be used with compress=
 operation. Hash is always<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* done on plaintext.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *dictionary;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Pointer to memory containing dictionary to b=
e used for inflate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and deflate operations<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t dictionary_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Length of dictionary to be used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
@@ -328,6 +350,15 @@ struct rte_comp_decompress_xform {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt; Hash algorithm to be used with decompre=
ss operation. Hash is always<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* done on plaintext.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *dictionary;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Pointer to memory containing dictionary to b=
e used for inflate<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and deflate operations<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t dictionary_len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Length of dictionary to be used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
-- <br>
2.31.1<br>
<br>
</blockquote>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--000000000000ee2d30063fba70b9--
