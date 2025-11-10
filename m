Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B637FCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 22:01:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 081654026D;
	Mon, 10 Nov 2025 23:01:35 +0100 (CET)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 4EC6E4026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 23:01:33 +0100 (CET)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-297d4a56f97so26169885ad.1
 for <dev@dpdk.org>; Mon, 10 Nov 2025 14:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762812092; x=1763416892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vYZNta4hGHPB0ZOJ61NM2WmOoDRTus1f6yqQUYbWYg=;
 b=bDmquA3WW2m1lfbLur5nEKtbrfZ33/l/2v+xTyTbb73hs7GVTwwxDvras+tsK4AyyW
 4t2IA6lyQttMnZO8SGvkLfeL7L8AcO5HS7MWd7CiEhr9iiK4ZaJu4FvKzNm/F7RG4OIy
 dhguf6XqFouWpsThUQVDVHRMEwwDjg3WJTEtq2tUOub/a2vRFEJZaVj4bRU4JjvgdIGR
 FIDDcwPhSe2JoXN0yQz9EQYDmE7PyCVkWO3duiIkGv4Af3p+AG8dRFM0wOZXZMrIZda8
 a77+zEaDvRcmo4nkYMFzU2MwplyGyL+JjDtggzUV55L370+VQJ2zOVdMCcrWZnqr1o4x
 oujA==
X-Gm-Message-State: AOJu0Yxp16p3V+UkhhqbElRXGb2hN4xlhxtBVJEwn3Jw5r2C3VvX16pY
 VFbFrI8Ec7M9390reZu8RYkGqWZoSY+DVGBeOt9Dgn2fhTL+pFSh52raYq1LMB0U0F0J2aURoWC
 5wf639e/yLMfRM5Xj0c8QsLbELg9QrJLRu4+UzBA8Gvjg8JNEwHaOn5xuL9oohwIi7n42j45klL
 dj3j5r0H0QiAO1tCueEn/9rlLP3oROuqeZSliuhWZCdlJtY7zmTMmnCiLxa7427X9W4ATwDg==
X-Gm-Gg: ASbGncuQhJ+2EExXoKNDc8AVKej37SQaljPg3yE91KoRz5OOuOLrXudJamsFzQLIMij
 ZaxlHRZBqI1+cLDBiqtgCI/L8FnlnYfeclGXTLcFezU66iL1t9GtPEwvig3okemxjg68bkuE23N
 56SBRxIRwqiEDRP7vRRmseMVSumVRE91k+pQrcu/boRELUqGDqmc+qz9YNqMdVvb+NPaXNYmmok
 8VwPZWUZZDJULfeTU3k8ciN2ltPXSzXrrH96pZ8LE3WKfWBRHmGOxc3tI0KI5l9Qc2zADOJ656H
 qIlYVeQ2KAp26o/o6e2qUD0fNy7GuMfPdz1zPub6cWKXjsN5zPJ+cElLeR5cnviXeMtdlpBYFdP
 rnB32FLDx223YkUIp5ZK0CHvTUtdAKRXXRtWbLQEuPAc1whqd1hrkPVJv6uQvnvj+6VVnEnPtT7
 2CZQqU9VnBijxdmhIbOZv+MFZb5l1NHZKDxA==
X-Google-Smtp-Source: AGHT+IHdyGuM4XrBpWSdx/cjPlfKL7RpJwqekm2N6is+Hh0bqMDOuvT1QdYZ8TLBZSr8qcATGh80okbWyfuq
X-Received: by 2002:a17:903:32ce:b0:295:4936:d1e9 with SMTP id
 d9443c01a7336-297e56c8f86mr134085335ad.36.1762812092087; 
 Mon, 10 Nov 2025 14:01:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2965104831asm14850215ad.27.2025.11.10.14.01.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Nov 2025 14:01:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b6d7405e6a8so17979766b.1
 for <dev@dpdk.org>; Mon, 10 Nov 2025 14:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1762812090; x=1763416890; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7vYZNta4hGHPB0ZOJ61NM2WmOoDRTus1f6yqQUYbWYg=;
 b=DKNm7sIQWMP3c2hSit1HFjPVNLWC1lGHhDa90buNSw3XhKZ/+V9Au7rg1nEe8PMyts
 Tk+EuA10zAHFASLF0eD7AOQWgRwTOn6NHQoQvvOy+nLY4HcM2OkBRsvDaF8wwNisCuOw
 JR/qAywcX9JURRa+GJAkAC1rP3DDLqSqzr0zw=
X-Received: by 2002:a17:906:a896:b0:b72:6330:e651 with SMTP id
 a640c23a62f3a-b731d31c22amr68957366b.21.1762812090018; 
 Mon, 10 Nov 2025 14:01:30 -0800 (PST)
X-Received: by 2002:a17:906:a896:b0:b72:6330:e651 with SMTP id
 a640c23a62f3a-b731d31c22amr68954166b.21.1762812089517; Mon, 10 Nov 2025
 14:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
 <20251029160712.58519-20-manish.kurup@broadcom.com>
 <20251110135206.03f1a0be@phoenix>
In-Reply-To: <20251110135206.03f1a0be@phoenix>
From: Manish Kurup <manish.kurup@broadcom.com>
Date: Mon, 10 Nov 2025 17:01:17 -0500
X-Gm-Features: AWmQ_bngF13aCuDQScNFbySXnOa14wwEfo1kbqAIn_73FKrw46STdvCxAzugBkY
Message-ID: <CAEKskBV8Ebeesg8qLZ7JcENWYRgfFeOAOhHRBC-WaaLRhn43Mg@mail.gmail.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com, 
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>, 
 Michael Baucom <michael.baucom@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000730714064344aca6"
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

--000000000000730714064344aca6
Content-Type: multipart/alternative; boundary="00000000000066ee5f064344ac50"

--00000000000066ee5f064344ac50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 16:52 Stephen Hemminger <stephen@networkplumber.org=
>
wrote:

> On Wed, 29 Oct 2025 12:06:34 -0400
> Manish Kurup <manish.kurup@broadcom.com> wrote:
>
> > From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> >
> > Add support for hot upgrade for a generic application.  An
> > application can start a backup application and add the same flows
> > that has been offloaded in primary application and secondary
> > application can take over primary application.
> >
> > Update the hwrm version to the correct version number, the
> > corresponding code version for hot upgrade api got changed.
> >
> > Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> > Reviewed-by: Michael Baucom <michael.baucom@broadcom.com>
> > Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
> > ---
>
> After merge to main the build fails because of this patch
>
> $ meson setup build
> ...
> Has header "bpf/bpf.h" : YES
> Checking for function "xsk_socket__create_shared" with dependencies
> libxdp, libbpf: YES
> Checking for function "bpf_object__next_program" with dependency libbpf:
> YES
> Checking for function "bpf_xdp_attach" with dependency libbpf: YES
> Checking for function "xsk_socket__update_xskmap" with dependencies
> libxdp, libbpf: YES
> Message: drivers/net/af_xdp: Defining dependency "net_af_xdp"
> Message: drivers/net/ark: Defining dependency "net_ark"
> Message: drivers/net/atlantic: Defining dependency "net_atlantic"
> Message: drivers/net/avp: Defining dependency "net_avp"
> Message: drivers/net/axgbe: Defining dependency "net_axgbe"
> Run-time dependency zlib found: YES 1.3.1
> Message: drivers/net/bnx2x: Defining dependency "net_bnx2x"
> Compiler for C supports arguments -DSUPPORT_CFA_HW_P70=3D1: YES
> drivers/net/bnxt/tf_ulp/meson.build:41:3: ERROR: Option bnxt_tf_template
> does not exist.
> A full log can be found at
> /home/shemminger/DPDK/main/build/meson-logs/meson-log.txt

Hi Stephen,

I noticed that one of the patches that update the meson build options was
rejected. This is probably why the build fails. I=E2=80=99ll take a look to=
 confirm.

Thanks

>
>

--00000000000066ee5f064344ac50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On Mon, Nov 10, 2025 at 16:52 Stephen Hemminger &lt;<a hr=
ef=3D"mailto:stephen@networkplumber.org">stephen@networkplumber.org</a>&gt;=
 wrote:<br></div><div><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(2=
04,204,204)">On Wed, 29 Oct 2025 12:06:34 -0400<br>
Manish Kurup &lt;<a href=3D"mailto:manish.kurup@broadcom.com" target=3D"_bl=
ank">manish.kurup@broadcom.com</a>&gt; wrote:<br>
<br>
&gt; From: Kishore Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broa=
dcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</a>&gt;<br>
&gt; <br>
&gt; Add support for hot upgrade for a generic application.=C2=A0 An<br>
&gt; application can start a backup application and add the same flows<br>
&gt; that has been offloaded in primary application and secondary<br>
&gt; application can take over primary application.<br>
&gt; <br>
&gt; Update the hwrm version to the correct version number, the<br>
&gt; corresponding code version for hot upgrade api got changed.<br>
&gt; <br>
&gt; Signed-off-by: Kishore Padmanabha &lt;<a href=3D"mailto:kishore.padman=
abha@broadcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</a>&gt=
;<br>
&gt; Reviewed-by: Michael Baucom &lt;<a href=3D"mailto:michael.baucom@broad=
com.com" target=3D"_blank">michael.baucom@broadcom.com</a>&gt;<br>
&gt; Reviewed-by: Shuanglin Wang &lt;<a href=3D"mailto:shuanglin.wang@broad=
com.com" target=3D"_blank">shuanglin.wang@broadcom.com</a>&gt;<br>
&gt; ---<br>
<br>
After merge to main the build fails because of this patch<br>
<br>
$ meson setup build<br>
...<br>
Has header &quot;bpf/bpf.h&quot; : YES<br>
Checking for function &quot;xsk_socket__create_shared&quot; with dependenci=
es libxdp, libbpf: YES<br>
Checking for function &quot;bpf_object__next_program&quot; with dependency =
libbpf: YES<br>
Checking for function &quot;bpf_xdp_attach&quot; with dependency libbpf: YE=
S<br>
Checking for function &quot;xsk_socket__update_xskmap&quot; with dependenci=
es libxdp, libbpf: YES<br>
Message: drivers/net/af_xdp: Defining dependency &quot;net_af_xdp&quot;<br>
Message: drivers/net/ark: Defining dependency &quot;net_ark&quot;<br>
Message: drivers/net/atlantic: Defining dependency &quot;net_atlantic&quot;=
<br>
Message: drivers/net/avp: Defining dependency &quot;net_avp&quot;<br>
Message: drivers/net/axgbe: Defining dependency &quot;net_axgbe&quot;<br>
Run-time dependency zlib found: YES 1.3.1<br>
Message: drivers/net/bnx2x: Defining dependency &quot;net_bnx2x&quot;<br>
Compiler for C supports arguments -DSUPPORT_CFA_HW_P70=3D1: YES<br>
drivers/net/bnxt/tf_ulp/meson.build:41:3: ERROR: Option bnxt_tf_template do=
es not exist.<br>
A full log can be found at /home/shemminger/DPDK/main/build/meson-logs/meso=
n-log.txt</blockquote><div dir=3D"auto"><span style=3D"background-color:rgb=
a(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Hi Stephen,</span><br>=
</div><div dir=3D"auto"><div><div dir=3D"auto" style=3D"font-size:16px;font=
-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-tr=
ansform:none;white-space:normal;word-spacing:0px;text-decoration:none;backg=
round-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br></d=
iv><div dir=3D"auto" style=3D"font-size:16px;font-style:normal;font-weight:=
400;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);=
border-color:rgb(0,0,0);color:rgb(0,0,0)">I noticed that one of the patches=
 that update the meson build options was rejected. This is probably why the=
 build fails. I=E2=80=99ll take a look to confirm.</div><div dir=3D"auto" s=
tyle=3D"font-size:16px;font-style:normal;font-weight:400;letter-spacing:nor=
mal;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0=
);color:rgb(0,0,0)"><br></div><div dir=3D"auto" style=3D"font-size:16px;fon=
t-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;text-decoration:none;back=
ground-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Thanks=
<br></div></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1=
ex;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
</blockquote></div></div>

--00000000000066ee5f064344ac50--

--000000000000730714064344aca6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMNmKeINO4t964SBkFMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDIwN1oXDTI3MDYyMTEzNDIwN1owgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEOMAwGA1UEBBMFS3VydXAxDzANBgNVBCoTBk1hbmlzaDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWFuaXNoLmt1cnVwQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWFuaXNoLmt1cnVwQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AJ51YusDd0uXGeLCmsrdGVmVtbtGHeW90Em7SGbKq3wj6J8L1t41BO3PneC7Q/Cxaz3VbSQDRS8S
Ax6wtLQLOKzBPadeA5b964iGGF3eiFykVJL6g32dfXCnhU2bC4aHqGbwcUuOGXr64brR8refD0ND
tkUDm6Ck36ZJa4c0kk/tp2BL24XeUHIQ7tGVlMcPFYCTUHOpIduE8C8yqCqj8UVbn4s1px4U/81h
nHyA+wACG3xqA+4ZIOxA36btkSRaxCDqBde1JXJAwd4KaaE57ggUAbbGyyS3U4fEg7ivnwTqe/xr
BMUe5dkJKlUevcRI+KUbCyPBFdydjWo6pqrDx98CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWFuaXNoLmt1cnVwQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUlTJzl+DMv+RTNsn0e8FosYo2
buowDQYJKoZIhvcNAQELBQADggIBAK0fhbUPytWTCdQbZ8oyh042mBx9U+pfy5c35DLRRyrMMZhJ
A92wjuSEnUhN+OHWsDpr9nhnAJMujiRCAjPOSZslPVpjUa0/SizbixjAqmnmbKH573MB30KzN/1P
YWUlo2S2FNJcgAhzGzcCm97HbgvXMp1J8Vffh7r1tgNJMCTtIGJ5iETXbLUv2bmtP4tv+7o7ChMi
qyersTJNXcGGT5h8BwJLirAE1sqI0OWoNj/gBCowPOF6LUy7H+9kpRreFuvwpPVpUTlYvC5PiJxa
xyirfam81v/M411xzXS9zAeeeb9m/Krztjlnr14CEKXzRdMMqKoklNscF6WL5umL0q2na3YPc3u0
UFQZvVFymYPeJIccvb0GtdzmWvVBWcz8YTaA1eaooFYJ4y/SV93+bToTDCFd3IhMNsH18fnFtWO0
qu2WfDfQaGXRlPKurR4YHVDxru38j8b/KPFBlNkK9NZfZNCDbxse/H4pSXxOyJprOv7a72fItdW4
XPsuwBD9KoXLrjpfElqyF+z9jEPg+5cDA7Ff2wiNxfs1K5SdL7LV5me38wZhAHLRrYK9y4XXHYmc
QBmV6o+ACc3LZVapWaPlpHtQkmTDX7LhF3aP+RpoyIz2q/rgaEX7tHHHRulX1Bj96M5CvkNp3ccl
I7P9UEWAXb5llaVGoyR1/8ypT3Y9MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMNmKeINO4t964SBkFMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCJBiJv
/4C13AaZgKUCUn0XCXK9KA95yzPjONEqvxy38jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTExMTAyMjAxMzBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQACK1rhjzGummPCXa5ZxOJyptiOow3AeeTfQS+ZTTzJ
UtAUDxn89D/TpqI0WYHRA2/b4inJmQkW1EgKCxAtptbRKSTyDCypPCF7+tSs5dWqDqEEGx3BtAXe
7N88Jtu6Vo+kcQmOgiGNkuYFIit1wxoi9laYM6PL+oy3wgR3Pji+CMuZ+00KSIAm0k9prgt1itza
T4J0JYa7K06Z1aNPKQ00N9dTsIfJO6qT375hPBOedpJLUyDB27MrcW2qtVnicHV1GgwNZJAiwxjA
zPpyuMP4LbrKhqD9TtMKdFZVSTG/9i9oFVfOX5SnAxgxfuC73/jFVbNNmq5vxQrI2VsJrY/g
--000000000000730714064344aca6--
