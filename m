Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FFDCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5168A40658;
	Wed, 24 Sep 2025 22:24:31 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 07E314064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:24:30 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b54dd647edcso204452a12.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758745469; x=1759350269; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/fUuvapqmdoFxf7INyJpfLGxamdHdsD12Q2Ck5WglUs=;
 b=MJGUgN/PqI4KpYqKz5sphdKMcxH1HROzim/AeawQlUSISN2TvL+6LXLL7QpBYMHcBD
 6lMq5Z5Mjom5HyJ3lPnPLZM1FeQyqQd590dLgE2bu4EBzFXf5k/qxIypE6XxtwEln1ef
 qmFV9lB/4c5lli64Ex3cX6JVoEL5QP8yPe0I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745469; x=1759350269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fUuvapqmdoFxf7INyJpfLGxamdHdsD12Q2Ck5WglUs=;
 b=Ftf6na90IVc3ZXI4AdkeAM2MXrN7FFeU07nOhAKb43GKaangPmbtgR44jY87t6aTnZ
 tNQRpeBeeRVk6X80uhMr6Qs87xl+sYTYpZj6jlTRkFpN6vFRszKxcshlBUCogSIk8+th
 SDMOAOChRUyAWFCKK4eAcxzkmQxViCMo2u6QqqjFvUsJl6Kh0Nc2ZMuqBq24iiWX4j8t
 UlMZV1/Xa7ezFWpBgDnhwrzrqoD80WREsrWeS5SMfy+zAl7PzqrysJwq1pIEZu2dYkbz
 B/AdCsliVsCqo17jRlPcBEyO15DlXrT2uWO6jvZz/f7XhI9bUufr/WkBhDmAJglo7y7+
 3V0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuCI24j6DLXUwfEXkbDqKeC9Y19aCjzTQ4S16mzwI6yrKJh9iMPaORJ15WJPqOXnvrVSc=@dpdk.org
X-Gm-Message-State: AOJu0YwXuQXBqB6Fcdb9bDf+PvBvx3WiLm7ITlBOMExC/sAyKGNlxIYG
 xfAZvVMGsTFmMeQKJSF8YVyxONYY73dGtkriCkkPUEK8hYSrsO5yzPpV4nyXOZYVLgswf5XTsgI
 T/hlM7bR33gwIN6mJefOvwWR1hmjTkDPGFNerKqJvIA==
X-Gm-Gg: ASbGncsKdTP0OgW3BgtF6Ya6PgmdpNSCfo1ejW84j0T61zG832xICRznrqbxJseUd7c
 mWMCfAyQqnl4dwmmNYjc5ChRBHD0gRRCSqc7pspWKT2BJG1dqWHmDSkT6YC/QClrMJ5gyWrmCTb
 yIBZBo/X1MzuGZpq/iIcqqcGeuOnXBLqDmZKbvb/0ER7BByphj+uGhOkQiK9COzqo08W4Zf5yK4
 h4zt2VduGiSt3wvBNgvx5kWPZ55HEywMmvhDTkR
X-Google-Smtp-Source: AGHT+IEPCBxspMhKLnrLZaYs6dj6QcBp2g2BS1zRi7HKhtElR+clXjEE90dvoohBPPXtc7wl26wEJN3ZrxysSDlrqcQ=
X-Received: by 2002:a17:90b:1d87:b0:329:f535:6e48 with SMTP id
 98e67ed59e1d1-3342a30be1amr874125a91.36.1758745469106; Wed, 24 Sep 2025
 13:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
In-Reply-To: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 24 Sep 2025 16:24:07 -0400
X-Gm-Features: AS18NWDV8PHtTvfuXQcjDwMp9sYdsD89aee81psFLQIx1metCfNNdzfWZ7PaOUo
Message-ID: <CAJvnSUByJac475uKawdR7wGLFi1fptp8ducXHqJ=x4EmjpvGWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] compressdev: support for dictionaries and PDCP
 checksum
To: Sameer Vaze <svaze@qti.qualcomm.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000efd7d8063f91d613"
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

--000000000000efd7d8063f91d613
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The CI testing failure for this series is due to an issue with the traffic
generator that is unrelated to the patch. I will resolve it tomorrow and do
a test rerun.

On Wed, Sep 24, 2025 at 12:19=E2=80=AFPM Sameer Vaze <svaze@qti.qualcomm.co=
m> wrote:

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

--000000000000efd7d8063f91d613
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The CI testing failure for this series is due to an issue =
with the=C2=A0traffic generator that is unrelated to the patch. I will reso=
lve it tomorrow and do a test rerun.</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24, 2=
025 at 12:19=E2=80=AFPM Sameer Vaze &lt;<a href=3D"mailto:svaze@qti.qualcom=
m.com">svaze@qti.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Adds definitions for PDCP checksums and apis t=
o pass in<br>
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
xxHash/blob/dev/doc/xxhash_spec.md" rel=3D"noreferrer" target=3D"_blank">ht=
tps://github.com/Cyan4973/xxHash/blob/dev/doc/xxhash_spec.md</a><br>
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
</blockquote></div>

--000000000000efd7d8063f91d613--
