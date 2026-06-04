Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBC8CD6E74
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C56740657;
	Thu,  4 Jun 2026 19:42:09 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 4E4F64028C
 for <dev@dpdk.org>; Thu,  4 Jun 2026 19:42:08 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2c0c2d8b95bso7041305ad.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780594927; x=1781199727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PFKVm9oLdHldyCuNA0eBs/E2dtv6pzkRV38nhyfNtg=;
 b=O4VudtugKi/FpZhYZ1jpWA6lZZBx4n9JkdeITSiJj3j6bCLvNHGMyl4iZ/P+4Mi7L1
 FwY1lN/LpDjwjzOHifWS+YgOyZqnWn88tqvgXHc6Y1Ai6Bfe2Tbq0CONxG0JO2jvF3UL
 rU1JsxcjKZweYLlhISA64dwFQvK42rZsNQc+h28aPU/vLJvficU7l6EueQ6bZADI/9CR
 EHJ7jeeggqyMe2Y4PcNpXuM8ijFrfDkYulUjv2uX63K69QbTPZVmOQ4LK09xqGdePKaY
 Qqu1mgt19d4qgqIchYv7iPHoVWwDk1YSsB4xiAJlEgLAAMcR092eIo6lItfktSFvpBAB
 UvJg==
X-Gm-Message-State: AOJu0Yz751i4BR4+KsyIOKLxhCFWjNRPJDfruJWa0sXLMnu0BJEU8tZv
 NIWcofudJegugvpf+V9dGb1BjCMJWY8g9oN0d5jtwqQJWjks+uJKpFS2TiNnNT46rGul9+dcqVQ
 +/0Y/ui6eamuzbfTJKDMtH/duGTqWjWOA9bPF3F5uEUtzzAX5vtk5VqSc2hAUs7gWFM2NYQpkrR
 dXGxMKWZ2g3Xlf5z0GOfbO5a3hDZQKux9clikq0D6mGRziRjpoilotyDqw+TuJXSlJ4IUJSd8Dk
 oGWvQ==
X-Gm-Gg: Acq92OHLBSa3BBVhX71jCf4JI2DHVH6nVQ1z9OBj++qcIdVD2oRS8LGm52ld4H31Vs7
 VfM42XB+6osHcFnKeWwzYMqEJsLDJcfg9UwlsvZheiwsy5gaAkZgx1BSoWSvipuO4k/mIi4DIqr
 1jWDTvhxAm7JfGpOqdtCz+Mm2ocGbukEU0hfnTc293aF0EG0NHK/kvhyi1lwar1W1oUjkJAJW9P
 NIQAuI97jbWgUk61bpJspywyIdwVuSg8Z6Oa1BoTCjyiLNnFuYEOeUTKuKBFKQWO5UquMPY55km
 G39sq08mW26G+pd+prfXytE5JVBx2m0TCwVr3HyjWyThGHRybP9xoJlyMwX2qsK28MFUjLtlgVD
 Yx63JvEVtG1hUfjdegcEAStCvEvQ9r5o9xgI+NQSOrGvtoOpJfAo2WcycKB6ERDyvRU2ral8BTU
 YWqQb6RITn5bFtfXKAVHGM+IFsXkvcovJdaFsOCX4M5YYvm/rD/PqPuCvQrVDpBMTt4kQLUK/RK
 UZRgQ==
X-Received: by 2002:a17:903:2ace:b0:2c0:bd28:bed5 with SMTP id
 d9443c01a7336-2c163a2c80dmr100653585ad.10.1780594927202; 
 Thu, 04 Jun 2026 10:42:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c165f9fe79sm5958295ad.26.2026.06.04.10.42.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 10:42:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b4d3d3e6so7998685e9.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780594925; x=1781199725; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7PFKVm9oLdHldyCuNA0eBs/E2dtv6pzkRV38nhyfNtg=;
 b=PNGdeHja++ofdm0A2lixnm28rBvgxtZQR5gSlCQfPCLylVNjUzGBL3erJRFTPlpifZ
 RlEXoIn8yjj+qnqWHYcj+K32ldhSQwaVMOjrxiW8eYUlNPjE1G7JAUyOfIyTDRwwr3sC
 4oHWajYCJxEdGT3TQjCAcZMm51iAWiKPy9u2A=
X-Received: by 2002:a05:600c:5252:b0:490:bde2:666a with SMTP id
 5b1f17b1804b1-490bde26799mr71407355e9.16.1780594925068; 
 Thu, 04 Jun 2026 10:42:05 -0700 (PDT)
X-Received: by 2002:a05:600c:5252:b0:490:bde2:666a with SMTP id
 5b1f17b1804b1-490bde26799mr71406935e9.16.1780594924668; Thu, 04 Jun 2026
 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603175137.1990204-4-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260603175137.1990204-4-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 4 Jun 2026 13:41:49 -0400
X-Gm-Features: AVVi8CfDaUVFZyts3uKQpCp8qywN-e1nV3oX8SUDG2w14-Sh-zuCcL8yUMObiCU
Message-ID: <CA+BST0=_cye2uXAVJN-aUtfieErVtNvhHuFKwPqkmgcv2BXbOg@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/bnxt: remove implicit integer sign-extension
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org, Zoe Cheimets <zoe.cheimets@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000005123a0653711007"
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

--00000000000005123a0653711007
Content-Type: multipart/alternative; boundary="000000000000f9701e0653710fc1"

--000000000000f9701e0653710fc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:50=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Zoe Cheimets <zoe.cheimets@broadcom.com>
>
> In bnxt_ring.c, the result on line 389 was auto-sign extended by
> the compiler because the arithmetic result is an int, but the
> dpi_offset is uint64_t. Fix by casting the result to uint64_t
> before the multiplication forces extension. To ensure that a
> negative integer is not being cast to uint64_t, add a check in
> the if-statement.
>
> Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")
> Cc: stable@dpdk.org
> Signed-off-by: Zoe Cheimets <zoe.cheimets@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_ring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
> index ccca779b97..579b73d2ce 100644
> --- a/drivers/net/bnxt/bnxt_ring.c
> +++ b/drivers/net/bnxt/bnxt_ring.c
> @@ -385,9 +385,10 @@ void bnxt_set_db(struct bnxt *bp,
>                 db->doorbell =3D (char *)bp->doorbell_base + db_offset;
>
>                 if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB &&
> -                               dpi !=3D BNXT_PRIVILEGED_DPI) {
> -                       dpi_offset =3D (dpi - bp->nq_dpi_start) *
> -                                       bp->db_page_size;
> +                   dpi !=3D BNXT_PRIVILEGED_DPI &&
> +                   dpi >=3D bp->nq_dpi_start) {
> +                       dpi_offset =3D (uint64_t)(dpi - bp->nq_dpi_start)=
 *
> +                                                       bp->db_page_size;
>                         db->doorbell =3D (char *)db->doorbell + dpi_offse=
t;
>                 }
>                 db->db_key64 |=3D (uint64_t)fid << DBR_XID_SFT;
> --
> 2.47.3
>
>

--000000000000f9701e0653710fc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, =
2026 at 1:50=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Zoe Cheimets &lt;<a href=3D"mailto:zoe.cheimets@broadcom.com" target=3D"_bl=
ank">zoe.cheimets@broadcom.com</a>&gt;<br>
<br>
In bnxt_ring.c, the result on line 389 was auto-sign extended by<br>
the compiler because the arithmetic result is an int, but the<br>
dpi_offset is uint64_t. Fix by casting the result to uint64_t<br>
before the multiplication forces extension. To ensure that a<br>
negative integer is not being cast to uint64_t, add a check in<br>
the if-statement.<br>
<br>
Fixes: 7a1f9c782b50 (&quot;net/bnxt: add multi-doorbell support&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
Signed-off-by: Zoe Cheimets &lt;<a href=3D"mailto:zoe.cheimets@broadcom.com=
" target=3D"_blank">zoe.cheimets@broadcom.com</a>&gt;<br>
Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab=
.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.=
com</a>&gt;<br></blockquote><div><span style=3D"font-family:Calibri,sans-se=
rif;font-size:11pt">Acked-by:</span><span style=3D"font-family:Calibri,sans=
-serif;font-size:11pt">=C2=A0 </span><span style=3D"font-family:Calibri,san=
s-serif;font-size:11pt">Kishore
Padmanabha &lt;</span><a href=3D"mailto:kishore.padmanabha@broadcom.com" st=
yle=3D"font-family:Calibri,sans-serif;font-size:11pt;color:rgb(5,99,193)">k=
ishore.padmanabha@broadcom.com</a><span style=3D"font-family:Calibri,sans-s=
erif;font-size:11pt">&gt;</span>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_ring.c | 7 ++++---<br>
=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c<br=
>
index ccca779b97..579b73d2ce 100644<br>
--- a/drivers/net/bnxt/bnxt_ring.c<br>
+++ b/drivers/net/bnxt/bnxt_ring.c<br>
@@ -385,9 +385,10 @@ void bnxt_set_db(struct bnxt *bp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 db-&gt;doorbell =3D=
 (char *)bp-&gt;doorbell_base + db_offset;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;fw_cap &=
amp; BNXT_FW_CAP_MULTI_DB &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpi !=3D BNXT_PRIVILEGED_DPI) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dpi_offset =3D (dpi - bp-&gt;nq_dpi_start) *<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;db=
_page_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpi !=
=3D BNXT_PRIVILEGED_DPI &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpi &=
gt;=3D bp-&gt;nq_dpi_start) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dpi_offset =3D (uint64_t)(dpi - bp-&gt;nq_dpi_start) *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;db_page_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 db-&gt;doorbell =3D (char *)db-&gt;doorbell + dpi_offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 db-&gt;db_key64 |=
=3D (uint64_t)fid &lt;&lt; DBR_XID_SFT;<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--000000000000f9701e0653710fc1--

--00000000000005123a0653711007
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVcQYJKoZIhvcNAQcCoIIVYjCCFV4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLeMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDw+3XbAA/XKSqsck9ayOQGCUt3lI1fJquiqZ5BPYADTTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MDQxNzQyMDVaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCeeTLFeooH
i3Rqd6fstN2rRouyVgnWWUdbikLrEUK+9tkaL/wsL13L3LM6ld4nOUubdrS+ReP3L+VgyannwxOh
ynflK4UwPWLICTz99qXoZ3q1nDqOY5Zr6lws1uqOZR0P4tlb+uiEh0IlzliIZWT/Lk9CfKIv4noN
2L+1l2W7iK2HFLWl7Dr8FxOigUSJe8BTno5E0J71eSACeecwpkzo6PjpVNstn5zDMtoVwg6/5mLn
Hh5X94Ym2rshRkkSV+jWBYPOfxmtsI2q6btJi3ZgSAHWj42SPPaOeYUSVB5V1RDuiv4Xe+TDSc27
heTdGieQ2xo/MCNNa/AlxkMAK39W
--00000000000005123a0653711007--
