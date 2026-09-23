Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D4C98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 22:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B62EC4027C;
	Thu, 24 Sep 2026 00:47:18 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id B84AD40276
 for <dev@dpdk.org>; Thu, 24 Sep 2026 00:47:17 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2d715f4a587so6824965ad.2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203636; x=1790808436;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jxAmPeDiYCNLZ1cfCqTnoPRpPulU+X5iE1uMUgxRvh0=;
 b=Th9USmgjvpwRfHGkh69rMJjia3mbgFwSSneMJHEIqSoeVGBb3BAFAI2Nhm3wWoEHXB
 KED9LV4ApDu9TKfLjl4lXoyWvReArRvizmo7pjOlpvEIXQ/pM6TH5pe0tzM96lHJcIWb
 VGBi9uLPQmKN6Gb5Fhj1Mn19/LaRIWYeUsx6fE0EoMFomQO/1j3vL2nC/zX+K67wnM3z
 Tn64jpnBClXLGsHT1eayuqsXQ5HLoJKzjMBKRIzvq+P2p7NVLKALGOVrzyd1yl1k3nqj
 +V9gqSxyqIVMk4YlPcbHgrllYz9jhTf4QhidcfEF7w7KyDYr5MB3cqz05QSC6iPjx4yV
 P2lg==
X-Gm-Message-State: AFuF++lYLQ1SISHpTEPLHdyOLRCXRreO3s4Li5pl1TwYFoUsaxXdTMuG
 TFb/PHaXFszbkLofg+MUNWFehKB+RaSpEcyywpwX2pR4JvXGiIbhghAzAlPRPPb5rRjC500hqqz
 HL+QtTgKf0QnoFkr0Tg4gNLBROqFXJyizLXne90+OQEeaq97xL++w2zDnwX5WqOP0OSAIIGJXZB
 Cqcc5o4A8e9I24WVih2eBIxZB98Hhkop6gDi3Q/tr5IIo5s/bi0nM8jfB0WvAUPBjwEse/VqHmx
 Y3r1RgJjM3C
X-Gm-Gg: AYBFou05ieMlkopfeG8VFdGLlLGOIr51mPYKJ3kEiKfuV9vtjYsg/gFRhkTCt2gbD5s
 257MCFn1k18tOOd0+ZDjDTGedpSSqw4r8q4gjh21qkZJUoj2gB4fleNBXW9QVq+9awc77tg/MaI
 2LgIAEqo3lg2sHkrVmQqNrEO/VNWFme6Bjqt+0oAt4bmh5e4rKumA+zGEJ/2hulftc1AKvT9xfP
 ACo9+SgwT/uJ3eJuQkiUH9BZqXrVpraUMTwx0LvA3YRSI4qc0tkr2HAIKgbF7Xa3udD0CNegscU
 3c6FBdAuHtkIfzamxs/woB9Vv40Nd4jCuf16KDcam6bmNIpVkCSGegxo6p/V2QBfyWmuZvxMpeg
 gkYzewcB4pBEPflJaa6XA0eBqUZpt8HJvMsuIvjws7ZDrFDqZOky+U8J3JN80bfu4ZTqKqjLQxD
 VwCkXUjXTqauX4iTdgwwrWACHqgzHIb683bcwtUwPURHKV/dU2qQ==
X-Received: by 2002:a17:90b:3c0e:b0:39e:4c81:6c95 with SMTP id
 98e67ed59e1d1-3a098dbb040mr482967a91.27.1790203636515; 
 Wed, 23 Sep 2026 15:47:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a0973973d9sm378540a91.7.2026.09.23.15.47.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Sep 2026 15:47:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso1389327a12.2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790203635; x=1790808435; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jxAmPeDiYCNLZ1cfCqTnoPRpPulU+X5iE1uMUgxRvh0=;
 b=LpzZm7EKne5sQoyZ6B2gZLeP3exs5NbYJcGCcBBoqYhXeDVuFFx8ev8hYvrocmcBmE
 nJM5IHRWqKNakVOzO0JugOa8/bNgGthB++Rp8hIC6Yy/mSpJyEd18mGunbhPJTxWJpN1
 X3Sp1to6PUM4ZxMLNKGtrnYuI0hBadBOK9Pds=
X-Received: by 2002:a05:6a20:3d1e:b0:3da:f21a:23ca with SMTP id
 adf61e73a8af0-3de0e73318emr548769637.22.1790203634911; 
 Wed, 23 Sep 2026 15:47:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1e:b0:3da:f21a:23ca with SMTP id
 adf61e73a8af0-3de0e73318emr548758637.22.1790203634545; Wed, 23 Sep 2026
 15:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260918032825.763449-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921025903.1034720-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921085250.46018e60@phoenix.local>
In-Reply-To: <20260921085250.46018e60@phoenix.local>
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Date: Wed, 23 Sep 2026 16:46:35 -0600
X-Gm-Features: AclHuK8En1H1ggnCXNQU-6ZtvMRT_Afq15ZVMqW2w5bLDTdx7ZEktPen4cqcAlA
Message-ID: <CAPTrkjG05N9z06ix1d-yKJnJAGbAiEGfXq=4yji0V-2pAD2nrA@mail.gmail.com>
Subject: Re: [PATCH v2] net/bnxt: add support for queue size of 16384
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, 
 Keegan Freyhof <keegan.freyhof@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000c17a28065c2e4375"
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

--000000000000c17a28065c2e4375
Content-Type: multipart/alternative; boundary="000000000000b69811065c2e43f2"

--000000000000b69811065c2e43f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Agreed. Since it gates nothing, I will delete it rather than document a
no-op constant.

On Mon, Sep 21, 2026 at 9:54=E2=80=AFAM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Sun, 20 Sep 2026 20:59:03 -0600
> Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:
>
> > From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> >
> > The driver only supported queue sizes up to 4096 for Tx and 8192 for
> > Rx. Raise both to 16384. The completion ring for a Rx ring is sized
> > at 2x the Rx ring size, further multiplied by 4 when the aggregation
> > ring is in use (8x total), so at 16384 it can reach 131072, above
> > uint16_t range - widen the ring index/counter variables touched by
> > that path to uint32_t.
> >
> > Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> > Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
> > ---
> [PATCH v2] net/bnxt: add support for queue size of 16384
>
> Warning: the change of BNXT_MAX_MTU and BNXT_NUM_VLANS to UL is
> unrelated to queue size and is not described. It changes the type of
> BNXT_MAX_PKT_LEN to unsigned long. Drop it, or split it out with a
> reason.
>
> Warning: MAX_CP_DESC_CNT is bumped to 32K and gains a comment saying
> it is unused and the real worst case is 131072. If it is unused,
> delete it.
>


--=20
Regards,
Shuab

--000000000000b69811065c2e43f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<br><br>Agreed. Since it gates nothing, I will =
delete it rather than document a no-op constant.<br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Sep 21, 2026 at 9:54=E2=80=AFAM Stephen Hemminger &lt;<a href=3D"mai=
lto:stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, 20 Sep 20=
26 20:59:03 -0600<br>
Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broad=
com.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt; wro=
te:<br>
<br>
&gt; From: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.sid=
dique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com<=
/a>&gt;<br>
&gt; <br>
&gt; The driver only supported queue sizes up to 4096 for Tx and 8192 for<b=
r>
&gt; Rx. Raise both to 16384. The completion ring for a Rx ring is sized<br=
>
&gt; at 2x the Rx ring size, further multiplied by 4 when the aggregation<b=
r>
&gt; ring is in use (8x total), so at 16384 it can reach 131072, above<br>
&gt; uint16_t range - widen the ring index/counter variables touched by<br>
&gt; that path to uint32_t.<br>
&gt; <br>
&gt; Signed-off-by: Keegan Freyhof &lt;<a href=3D"mailto:keegan.freyhof@bro=
adcom.com" target=3D"_blank">keegan.freyhof@broadcom.com</a>&gt;<br>
&gt; Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-=
shuab.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broa=
dcom.com</a>&gt;<br>
&gt; ---<br>
[PATCH v2] net/bnxt: add support for queue size of 16384<br>
<br>
Warning: the change of BNXT_MAX_MTU and BNXT_NUM_VLANS to UL is<br>
unrelated to queue size and is not described. It changes the type of<br>
BNXT_MAX_PKT_LEN to unsigned long. Drop it, or split it out with a<br>
reason.<br>
<br>
Warning: MAX_CP_DESC_CNT is bumped to 32K and gains a comment saying<br>
it is unused and the real worst case is 131072. If it is unused,<br>
delete it.<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Regards,<div>Shuab</div></div></div>

--000000000000b69811065c2e43f2--

--000000000000c17a28065c2e4375
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGuzCCBKOg
AwIBAgIMe3qtI1AIrKid6Xt7MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEwMzg1M1oXDTI3MDYyMTEwMzg1M1owgfgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMIU2lkZGlxdWUxFzAVBgNVBCoTDk1vaGFtbWFkIFNodWFiMRYwFAYDVQQK
Ew1CUk9BRENPTSBJTkMuMS0wKwYDVQQDDCRtb2hhbW1hZC1zaHVhYi5zaWRkaXF1ZUBicm9hZGNv
bS5jb20xMzAxBgkqhkiG9w0BCQEWJG1vaGFtbWFkLXNodWFiLnNpZGRpcXVlQGJyb2FkY29tLmNv
bTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKAmLH8/UOfCDAU7JT4+OcBqdOcNF0Ug
7xCc1Ntnd68sHOfD2JehN5u4/anYsJKtscbyMp3He38rtQKPy3hSQhPtmRbfBky5W1ys13aDtvfm
r5O4ALB8U5We6UUO2+ZzAsXTqL7sRBbhNatmv8Hfj7PcESRxqu7VVsmTl80rErk5PI6LAdE/+G9J
oFiucQWSniUW5EetnWSiHQ7s6joTA86jJxIJK07x7qC9GegHSx1IZ4FabgfuSbiaUw97L++emzwR
LdU4q7vihBD1z1WSXEgMTYmSAPJILKTrvv850PXoh/5LT6B7ulIQZ9AmdqzPAQuC9jGUtDjLUqli
vofjwbMCAwEAAaOCAegwggHkMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEF
BQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
cnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFs
c2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEE
AaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWdu
LmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24u
Y29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLwYDVR0RBCgwJoEkbW9oYW1tYWQtc2h1YWIuc2lk
ZGlxdWVAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5c
eroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSG5HUWE+7W4aykMqvAMPJyt2xRjjANBgkqhkiG9w0B
AQsFAAOCAgEALm8ZZnO7SkU0kPN+kCI//bT1xRZcv7yJIQTFHCAP+GHGe3qpWC3k9C5o+7hgOWT9
8vH3V1CpZ8f48wINyklyrNqlDXdtPK4d42HP3DdLQzQqV7d4Jg9YViI6lax05Ay2W8Cjp1QasS7s
qKyaFVL9JdiF7quEO+1ZMtbffbiormfoiIDUVMaZ1fqWpUcqpIs7awVPDFIsR/MAUSs1G/1Zbl9w
aBWMSYazZSrhtfAww5ZlCG+WoVhCgV2YVAfbw8Nu6kLeckdJf6FqauwouXqIK42hh1dCqTgRGpQq
1Z7DMDZ91bYBs05JgzHR1T0F57VaO4b9T4kGTsTByzyNTWOyxpugAFfNF0Tk9D3HXsV/LKjKjD4N
6nzoYi2EeN+nIqPHFQNVgRNel70mWnIYfzyxvpgOiAku+Mf265LP+pWeuYpdRgbPWeW92QptHVLJ
xHUOhRjKgziDHnOwMLditWGgi4ZrsQfAESX7UBekNapX7udGNRE+l5xSvMYDMezeaT77wxQIYf5H
kJEu6e8wkjO/YXT72+3ZYPY5zpDa/3tOieHfS3O4SHnwF/DIkFkCpZY6aLo/8RKZ5oBrVsDvId32
aMer3EvJtSphZOrdROgWDn8WjzxCsIpMFMZox9Q8O6F4litYD1lzorw6hhL/2kQpHRibT2M7xzs3
X09O7RJTuMkxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgx7eq0jUAis
qJ3pe3swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIK81o+w4TWRD3lGvF4amELY4
4Dc8UdfhBbjwn3xzKC1NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTI2MDkyMzIyNDcxNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEW
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqG
SIb3DQEBAQUABIIBABHwibiUIiHgCzJjDN0M0KFNqROBIec3ht+WNviNdWHmBvyKWVRfR/1N4lcj
nWwo5oPJNl326R6gc8hlkXAttdTfyNsGOmgFDASkKGAHeyp5MM9PYEQTH5bVBgKe9BwKyhIgFBrj
hx44sMVHDr6g+kN3/TFsGuan2TJHWV6JOF/QawfVhOega3SWfuXrjrZ2CRZj2k7vkBktbUyYJ2Ew
haQpdfMgPBB9PLA94L3tCvfHi32uSQCzO443DmZeHFc17q+Pw2UB9h8Qjr9e1asRzMAvPpyXBvdn
tyZEAXTy6VNoRyn0pk3D3qooFJ9VsIkYPCtljWNpNCDa38ubTg3U338=
--000000000000c17a28065c2e4375--
