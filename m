Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5370C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBF6E40E2B;
	Mon, 21 Sep 2026 21:46:01 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id 8C28840B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:46:00 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-5c8386a01b0so406806e0c.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790019960; x=1790624760;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P6rla8ragAI3eqPMGHjqwaigyG5ECOzvwuFCXZR7BPM=;
 b=EZ/jfEeTvauZunX/siyQw3NgAMmzBHG4oVXvhEkt1KVepzCUUSF3liz/zU52tr7EJc
 IimUdtFsbRvG3c5DTbgMKrX2U6Eg661filTVOnimxpbPBI3E0ou4QO5BenxLw2YEzsNs
 mKpsqWbi0Yvh1AZ2ZsH0YZHQbwupcAmJ0cScmL/BI3lNFqdnXihutYT+5jTxYyfoyBMw
 epm88EROoLJLVMqsv2G8ke540uCyxSNrgH/3fVAV7jtf7EYi4wp6SBCp2e9Tb9M1SN3s
 csnpLQZfSELxxeBh3U/ds1G16q7IgdXkelnPeYuSI30N3MmIdcSUuo5T252Kvgg7MNpA
 dnAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwI7A3m6kW/TE1KawRCil7FUnsIK97yfThd3KFc955VyyZOPYqFmIu7MRsyRaNWPZCOiCY=@dpdk.org
X-Gm-Message-State: AFuF++mAkcM/uOGAU9m/66Ya0Zim5v0zdg+rxEYvP4knOqXaxrhtIbpk
 4wP00bNFLni4u3JgFKcXkATlg2PsL4R9zGjVunL2gjmRSqo5nCOY1OVWKHLYZmMhBK3+/3LMKhD
 sqyBq+Ow1EtpYw7PtIfjtb/B33kkrRLwCIuuoGqhdaq5LI7lgQtMoBD+xTBMuJMaTjJn00+tXL3
 /43yyc6Dr6W6l2TefFz7N4fCB4/9T3CdZgjBzqk8yA4HQZUmpm3gtsUMWNRUwQoKWHzweRCeqNb
 CAsxw==
X-Gm-Gg: AYBFou2lZJLKmdIRFxX2Ul/ZKUGPY3N6yIpzMAUcs3WkoOv1qRYM+L8OpkaTE6qb+1g
 GfauOA9bJyJAncpWogaQYCoA1BSoU1+PkEn48dydgA7zBjhVbL9VlLeZ0qDknLzpR8U6Pb+L2un
 Sr4TnMrsf4fGD6DsSrl69laPUbiUDzigd8TPsmRF5yif7Hv9QlDZNoqKfXVLe75PD/w/hSF31zz
 2Dzp/rhG+H0FVRVdiP4+4qwCMhbWHLUaSZOnd1KunelI3i6I328xyKgrMjsKJwg+It5+04hfsX9
 WZlxGubUDhBvw2D5ZuF5PIK7fnlBtQk/rmqg7estSkq6PJ3s/fIILQHnok+CrZ1lRU3g7JQuE1+
 9clKkOHn1kATfsae0OVMA94cG37w3DSr/VGCmHY7IfKSTLulbC9OxfW4Ry618MkR6jr/CGhxQRQ
 Egp3Ht+Q7mfRrUau2oWRtvetFQMtvczFejQ0lFa7j3zCE=
X-Received: by 2002:a05:6102:370e:b0:7aa:7769:34e with SMTP id
 ada2fe7eead31-7aada714eebmr52036137.4.1790019959339; 
 Mon, 21 Sep 2026 12:45:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-91260bdf3fesm558846d6.28.2026.09.21.12.45.58
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:45:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a9caf60126so3839149a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790019957; x=1790624757; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P6rla8ragAI3eqPMGHjqwaigyG5ECOzvwuFCXZR7BPM=;
 b=EXYoy3V/8pvfARK/uKVnCpwWG4TWKnldpCPYnzeQk7/Fxm6/kkEF5ZMhhcwV4o06Jl
 rgXMZ4HOQjviPAAcYpkzf2Xi5TGkQBTq2arnws+Ci8B8eSxP4iCX+Hd56hq1RAtgh6F0
 06tE9OSpUd6D9FfaRJ6FfpEVxgp34e7vOzjw0=
X-Forwarded-Encrypted: i=1;
 AKwUvBzv6xGBOmLdowiIso05yViaS3iVLvhEvCLAH49No77xwhR/2KTAPzF/E8qO1xI6j8XXhR4=@dpdk.org
X-Received: by 2002:a05:6402:21d7:b0:6a9:b51c:9d49 with SMTP id
 4fb4d7f45d1cf-6aa545f2675mr8341174a12.10.1790019957635; 
 Mon, 21 Sep 2026 12:45:57 -0700 (PDT)
X-Received: by 2002:a05:6402:21d7:b0:6a9:b51c:9d49 with SMTP id
 4fb4d7f45d1cf-6aa545f2675mr8341153a12.10.1790019956813; Mon, 21 Sep 2026
 12:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260915094820.431638-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915094820.431638-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:45:38 -0400
X-Gm-Features: AcwNN1UqdlyRU-xPKoHz0gxWgvXD4uf2kt-zo-YIom1IgeE-QGQ-aHaK8rjhKo4
Message-ID: <CA+BST0n7m=_TAPAuw67Tg9Bf1b09WrwRO20FD2QJPj-36BgBhg@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: use enum value for interface type check
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000bc620e065c037f2a"
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

--000000000000bc620e065c037f2a
Content-Type: multipart/alternative; boundary="000000000000aad584065c037f57"

--000000000000aad584065c037f57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:48=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> Use BNXT_ULP_INTF_TYPE_INVALID when checking the interface type
> returned by ulp_port_db_port_type_get().
>
> Comparing the enum value explicitly makes the code clearer and
> avoids relying on the numeric value of the invalid interface type.
>
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.or=
g)
> with SVACE.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
> b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
> index 26823858b5..442a795430 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
> @@ -3108,7 +3108,7 @@ ulp_rte_port_act_handler(const struct
> rte_flow_action *act_item,
>
>         /* Get the intf type */
>         intf_type =3D ulp_port_db_port_type_get(param->ulp_ctx, ifindex);
> -       if (!intf_type) {
> +       if (intf_type =3D=3D BNXT_ULP_INTF_TYPE_INVALID) {
>                 BNXT_DRV_DBG(ERR, "Invalid port type\n");
>                 return BNXT_TF_RC_ERROR;
>         }
> --

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.30.2
>
>

--000000000000aad584065c037f57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 5:48=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov@inf=
otecs.ru</a>&gt;<br>
<br>
Use BNXT_ULP_INTF_TYPE_INVALID when checking the interface type<br>
returned by ulp_port_db_port_type_get().<br>
<br>
Comparing the enum value explicitly makes the code clearer and<br>
avoids relying on the numeric value of the invalid interface type.<br>
<br>
Found by InfoTeCS on behalf of Linux Verification Center (<a href=3D"http:/=
/linuxtesting.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a=
>) with SVACE.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf=
_ulp/ulp_rte_parser.c<br>
index 26823858b5..442a795430 100644<br>
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c<br>
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c<br>
@@ -3108,7 +3108,7 @@ ulp_rte_port_act_handler(const struct rte_flow_action=
 *act_item,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get the intf type */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 intf_type =3D ulp_port_db_port_type_get(param-&=
gt;ulp_ctx, ifindex);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!intf_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (intf_type =3D=3D BNXT_ULP_INTF_TYPE_INVALID=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BNXT_DRV_DBG(ERR, &=
quot;Invalid port type\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return BNXT_TF_RC_E=
RROR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
--</blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;backg=
round-color:transparent">Acked-by:=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"> <br>
2.30.2<br>
<br>
</blockquote></div></div>

--000000000000aad584065c037f57--

--000000000000bc620e065c037f2a
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
oIHHMC8GCSqGSIb3DQEJBDEiBCBCmm6cgq3/D62C9YWp6wTetAaXbqyNRtORbWZc/hAJOzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTQ1NTdaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBXywoiw7PP
sQud8RHiPfn+pgIvAf+OcdserIs8LLhCzssK4SiK6U4G7ER8r64pxCeOBKLkjs0SRsxQvCc+b4CZ
WmNb6wJ7pOSIsON4DBztc31exO4NihdbWUucL685/zlCpAx46d5cGx9VqlsqW+xOZE8xcL6aI4k7
zdn4UynZ5iy9L/E72A8aFsD0GbCApSlPJmXWm6MigqkfERbRtnJGWuVr+w6sTsVYWkjluKGVoEbg
DlAPasizbqVo7z3/5s/MKH5mG+nA+7yJWF7v15vwAqFLJxQlt14YorAUW4S6hvl226zlkEA1pgsF
vm2D+zpRAIbJd2lp2D42IY5m1Wfr
--000000000000bc620e065c037f2a--
