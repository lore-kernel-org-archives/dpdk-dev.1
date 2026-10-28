Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A9606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CXjUzMtK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D2B40151;
	Wed, 28 Oct 2026 16:40:23 +0100 (CET)
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com
 [209.85.222.227])
 by mails.dpdk.org (Postfix) with ESMTPS id D6C88400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 16:40:21 +0100 (CET)
Received: by mail-qk1-f227.google.com with SMTP id
 af79cd13be357-93f36c18b75so59999185a.1
 for <dev@dpdk.org>; Wed, 28 Oct 2026 08:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202020; x=1793806820;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKdjgLi25LM+iWAjjWyCjQdefLr2ELAMT3trLnXb/rw=;
 b=UjEs5xn9Zr+DmnCUehbW5KZGqBNIILDONFesnW87Z5Y9FjiGmRF2SkZVbvNTM7Bktc
 d2HFFsCKwQNi80sZ/bFWuI3raAfk/U6P8fM8FYei7v9MgoN+WYj3N3Xu0fjQK99dy2WQ
 XffpBzjNWtcDqjZjTxoW9BOlVYFqBuqhx4NxmHkLL7sBOR3E9sRO5eHejL/DcbA/5dag
 Q8UCFOc1mcxRovD08GXUSV54yK3YAYxkvUYbb/F+DLERwBnDvW4yMmnQZ+9jsOmDxior
 nPbBRYpV1a37nyE46r/cmkgSGm7UUeZ80Zt8licEVuTdVFiIHHAM9qL8cNK1aznjlmhV
 kQBQ==
X-Gm-Message-State: AFq9FYL3VAMneb+ig0N7aKBHWL7dFL5GEl9POFz5nIl1u7EOdx25ciyD
 ybZRTASS9Cidjui3R2iI1R/GUjg2UIalpvQManCBq91TMRCUSgLXgLj64Iicbk/4/eYmA8LlMNO
 68yKJEiYT0v/8hrnr1omHPfPvMpeJ/pkpiy2ArcSGXehvD/J6Yt3EiGEfPrQXwlHdV7iHjbG07o
 iYmFghnQOAYsXU5YC0v7eigSB47fL0WQP5kgNfOOrOr5KbUATDflhDugkz4ccySwbErsfG548Au
 ddJgA==
X-Gm-Gg: AYBFou3TpzcO0JOeSOBaXW7QNptZdjZFeQymmds7Jxh/QK/mhuMqdEGdQg9QY94m+T8
 SjxIzhj+8A/JwHsed5pZ8COLSxxQrHwbED4sL3o2P/IOctZOhCwYlcvgNJrqRn9UsndgzFxTiE4
 g1G7frqeN3XZFJDIzyiBT1fpcB+FRm/mNQzIQGte3o8LXbl+fCxWPo7WKUY4oqbBYIfYY7JSEZ1
 pRCkJBo14ROB5FTmN3MRx/oz8gSoKQ/ICzztkDPfM26yb0GjPaY3MWbhA+db/0NjAvDQQ/vSK/A
 TlTmhaRtc2DwV9/pc1/0IQuevAtqo+KEk4se1SWRltLICt3RJKTBFMBfFi47EpSX6f5UZ/Kcsbn
 3XI0EJgXZxwPauMBQiG2Y/6wmu4g0HwH5ilb4/DhDCtqoVceW1jGCa/1F8oB8s1gHPafHbFduJh
 dtWXdOidz8/5bXIu1JXCKYTDZ0I6aP2ld5t62gFpVKiCsm1Q==
X-Received: by 2002:a05:620a:6016:b0:93f:34c9:9252 with SMTP id
 af79cd13be357-94408ceb6aamr380220185a.55.1793202020264; 
 Wed, 28 Oct 2026 08:40:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-940f0674580sm190221185a.7.2026.10.28.08.40.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:40:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6afbe6b47b7so1372886a12.0
 for <dev@dpdk.org>; Wed, 28 Oct 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793202019; x=1793806819; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AKdjgLi25LM+iWAjjWyCjQdefLr2ELAMT3trLnXb/rw=;
 b=CXjUzMtKYRKdLfNvVxqfnS0TLoBf+afZzvzlBeU+M2IbSwoH0Id4UEjXb2xEjPvQFn
 3Y2iP8BNfQuwOso6/9Fe4aRtv2SnVr/hQETD5RS7DzjtaOKUEi2sOqkJXQ/oofa2AZqm
 kL74MM5j7Wy7viTrVSSm7B1ABT0cUP9o+GAuM=
X-Received: by 2002:a05:6402:1344:b0:6b1:a86c:7b with SMTP id
 4fb4d7f45d1cf-6b49cc0f92cmr1451931a12.36.1793202018598; 
 Wed, 28 Oct 2026 08:40:18 -0700 (PDT)
X-Received: by 2002:a05:6402:1344:b0:6b1:a86c:7b with SMTP id
 4fb4d7f45d1cf-6b49cc0f92cmr1451905a12.36.1793202017977; Wed, 28 Oct 2026
 08:40:17 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028035353.2273737-1-stephen@networkplumber.org>
In-Reply-To: <20261028035353.2273737-1-stephen@networkplumber.org>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 28 Oct 2026 11:40:00 -0400
X-Gm-Features: AclHuK8FgKIcRPNEL27GQnrkE_Ui-w3zjtYdvgygAqcWwwD6MFGWKhqxhQOQOSI
Message-ID: <CA+BST0nRHw8pwicJSms2hbhoAT-VDVd=y_KjtncyCUJj-NbhNg@mail.gmail.com>
Subject: Re: [RFC] net/bnxt: fix buffer overflow in TF set message helpers
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Michael Wildt <michael.wildt@broadcom.com>, 
 Randy Schacher <stuart.schacher@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000005aa791065ee86177"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005aa791065ee86177
Content-Type: multipart/alternative; boundary="0000000000004b07bd065ee86139"

--0000000000004b07bd065ee86139
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:53=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> LTO build with -Werror reports stack overflows in tf_msg.c:
>
>   In function 'tf_global_cfg_set':
>   rte_memcpy.h:91:9: error: writing 16 bytes into a region of size 8
>   tf_msg.c:1574:45: note: at offset 48 into destination object 'req'
>   of size 56
>
>   In function 'tf_msg_set_if_tbl_entry':
>   rte_memcpy.h:105:9: error: writing 32 bytes into a region of size 0
>   tf_msg.c:1813:41: note: at offset 136 into destination object 'req'
>   of size 128
>
> tf_msg_set_global_cfg() limits config_sz_in_bytes to 16, but
> req.data and req.mask are each 8 bytes. A config larger than 8 bytes
> overruns data into mask, and the mask copy runs off the end of req.
>
> tf_msg_set_if_tbl_entry() has no check at all. data_sz_in_bytes is a
> uint16_t copied into the 88 byte req.data. The ULP mapper fills it
> from a blob of up to 128 bytes.
>
> Check both against sizeof() of the destination, as the matching get
> functions already do.
>
> Fixes: 98487d729b4a ("net/bnxt: cleanup and refactor session management")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/tf_core/tf_msg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/bnxt/tf_core/tf_msg.c
> b/drivers/net/bnxt/tf_core/tf_msg.c
> index aab8d05d81..ab03afaabd 100644
> --- a/drivers/net/bnxt/tf_core/tf_msg.c
> +++ b/drivers/net/bnxt/tf_core/tf_msg.c
> @@ -23,7 +23,6 @@
>   * means we have to manually sync hwrm with these defines if the
>   * tf.yaml changes.
>   */
> -#define TF_MSG_SET_GLOBAL_CFG_DATA_SIZE  16
>  #define TF_MSG_EM_INSERT_KEY_SIZE        64
>  #define TF_MSG_EM_INSERT_RECORD_SIZE     96
>  #define TF_MSG_TBL_TYPE_SET_DATA_SIZE    88
> @@ -1618,7 +1617,7 @@ tf_msg_set_global_cfg(struct tf *tfp,
>         req.offset =3D tfp_cpu_to_le_32(params->offset);
>
>         /* Check for data size conformity */
> -       if (params->config_sz_in_bytes > TF_MSG_SET_GLOBAL_CFG_DATA_SIZE)=
 {
> +       if (params->config_sz_in_bytes > sizeof(req.data)) {
>                 rc =3D -EINVAL;
>                 TFP_DRV_LOG(ERR,
>                             "%s: Invalid parameters for msg type, rc:%s\n=
",
> @@ -1816,6 +1815,9 @@ tf_msg_set_if_tbl_entry(struct tf *tfp,
>         struct tf_dev_info *dev;
>         struct tf_session *tfs;
>
> +       if (params->data_sz_in_bytes > sizeof(req.data))
> +               return -EINVAL;
> +
>         /* Retrieve the session information */
>         rc =3D tf_session_get_session(tfp, &tfs);
>         if (rc) {
> --
> 2.53.0
>
>

--0000000000004b07bd065ee86139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 27,=
 2026 at 11:53=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@n=
etworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">LTO build with -Werror reports=
 stack overflows in tf_msg.c:<br>
<br>
=C2=A0 In function &#39;tf_global_cfg_set&#39;:<br>
=C2=A0 rte_memcpy.h:91:9: error: writing 16 bytes into a region of size 8<b=
r>
=C2=A0 tf_msg.c:1574:45: note: at offset 48 into destination object &#39;re=
q&#39;<br>
=C2=A0 of size 56<br>
<br>
=C2=A0 In function &#39;tf_msg_set_if_tbl_entry&#39;:<br>
=C2=A0 rte_memcpy.h:105:9: error: writing 32 bytes into a region of size 0<=
br>
=C2=A0 tf_msg.c:1813:41: note: at offset 136 into destination object &#39;r=
eq&#39;<br>
=C2=A0 of size 128<br>
<br>
tf_msg_set_global_cfg() limits config_sz_in_bytes to 16, but<br>
req.data and req.mask are each 8 bytes. A config larger than 8 bytes<br>
overruns data into mask, and the mask copy runs off the end of req.<br>
<br>
tf_msg_set_if_tbl_entry() has no check at all. data_sz_in_bytes is a<br>
uint16_t copied into the 88 byte req.data. The ULP mapper fills it<br>
from a blob of up to 128 bytes.<br>
<br>
Check both against sizeof() of the destination, as the matching get<br>
functions already do.<br>
<br>
Fixes: 98487d729b4a (&quot;net/bnxt: cleanup and refactor session managemen=
t&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumb=
er.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br></blockquot=
e><div><span style=3D"font-family:Calibri;font-size:11pt;background-color:t=
ransparent">Acked-by:=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/tf_core/tf_msg.c | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/t=
f_msg.c<br>
index aab8d05d81..ab03afaabd 100644<br>
--- a/drivers/net/bnxt/tf_core/tf_msg.c<br>
+++ b/drivers/net/bnxt/tf_core/tf_msg.c<br>
@@ -23,7 +23,6 @@<br>
=C2=A0 * means we have to manually sync hwrm with these defines if the<br>
=C2=A0 * tf.yaml changes.<br>
=C2=A0 */<br>
-#define TF_MSG_SET_GLOBAL_CFG_DATA_SIZE=C2=A0 16<br>
=C2=A0#define TF_MSG_EM_INSERT_KEY_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 64<br>
=C2=A0#define TF_MSG_EM_INSERT_RECORD_SIZE=C2=A0 =C2=A0 =C2=A096<br>
=C2=A0#define TF_MSG_TBL_TYPE_SET_DATA_SIZE=C2=A0 =C2=A0 88<br>
@@ -1618,7 +1617,7 @@ tf_msg_set_global_cfg(struct tf *tfp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.offset =3D tfp_cpu_to_le_32(params-&gt;offs=
et);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check for data size conformity */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;config_sz_in_bytes &gt; TF_MSG_S=
ET_GLOBAL_CFG_DATA_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;config_sz_in_bytes &gt; sizeof(r=
eq.data)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TFP_DRV_LOG(ERR,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: Invalid parameters for msg type, rc:%s\n=
&quot;,<br>
@@ -1816,6 +1815,9 @@ tf_msg_set_if_tbl_entry(struct tf *tfp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tf_dev_info *dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tf_session *tfs;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (params-&gt;data_sz_in_bytes &gt; sizeof(req=
.data))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Retrieve the session information */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D tf_session_get_session(tfp, &amp;tfs);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc) {<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--0000000000004b07bd065ee86139--

--0000000000005aa791065ee86177
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCs7fAaK+7+cIMrgCnPBSHVsvgNMJwkhtEVcGk8vanI1TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMjgxNTQwMTlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAYLODSvqEK
3kF1d+7uuaWSJ6+snXushzyXiFiHiBBI2TA0fa2pFZH8w86RUa+TMEUjw4Lda2iqetGY7WYhiKip
f2H+k6OGiQMncGzyEDRiojDcb7OjL/g92wmrKzO11Xy3QjsozaFumcGAlkMIDqizezf+vJACOOE/
0Wz0IIj0yNxF3HTA2ZhcNy54YiuOwfmRtCqS5ZA25PEUVgWmGuIEdOEYFiVOISHEUU3xCUBHH5B9
OIfu9ihEds59KjmNEWFDJMjO8jDKi/+UitkAtKYRAX7VZ4rKwo3GO9ENPjx2g/k66KUNWuwBMP7J
br9uv2L+J7U44RZ9EoyVbqU/n92h
--0000000000005aa791065ee86177--
