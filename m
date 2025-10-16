Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9277FCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 19:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57F641611;
	Thu, 16 Oct 2025 21:34:50 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id DC2F64026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 21:34:48 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-26c209802c0so12311695ad.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760643288; x=1761248088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L23KxszxmnHguSqie5HPxGHmR8eDQT8aM/yq5HTxanU=;
 b=QHjsFeUy6eX4x65sBtML/YonVhEVhkuXXhv93mgJf3ljHiHLI5LHYMz3Xm/KdxGcH0
 /Qd18ZpEr5WFZKZB7wQKGqxBC2qnkL6J9XeTyZXBGMv4zAqwpXPCbXS5sh6HKR1sm1Fc
 z8rYlaOLtn8BYaH5IlSHsADgTKdMLj9UPvB5kyTFRSy1JdbEWA0CYCz4uaBdHB4uXyND
 CzPWKjjcTIrWgyVvJ1Oy/dx38IRwxkAN9MLbAJi6szJcOzjFQB2XsGG+kJs32KiNcDY3
 JFWAK3F5gSTvxni4UWTtoOKvmf7Qp4zQIk3+9gvRkmtsA7/IZ6IX7J/V4sG9NwM6/Qio
 2Ptw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/wSyPuMpMTk93yv4avhFBrEOuop22p3Y7Q3dSga+kM7eg//mftyvEivib/JMO/2wNxJE=@dpdk.org
X-Gm-Message-State: AOJu0YxXHv44hltelBi4uHFGyRkLyYdYNSNEmpB9mjZ+t9bsVIi/WD+w
 JRuCvyOP8XDomJWmMXeaxr5VROjkJBq7SLnWVsp65E9pkNS66RZEQcCUD3X4y2qbsp+7RKcmzAM
 2oiEowQmOsd56XoKuvuNG62xxLms33BfOKE0/e8GjIaWSTGhKBpkdDnO5z2jcr8laiG81aMRqTS
 PYgIoqGrsi2kRkOh+xWu+a9y7sK2GV4+vWsgav47PjxgUjJq0XzM5GkUO4K4ZNCPrkXUjhhg==
X-Gm-Gg: ASbGncuT+h3PXCNVtN8ubKgTuj70DxzwmGYTBSHQCkyzhVeBG49LhP0uyg6fLqjAD+y
 SBjMXURGYUn9pTIIsNZnTTd9GbgpcYp7ghp2JgfuopEYBIJIzHt0TQ8F0N9CyWe/AXfcOThkSyI
 B/A7pAr05fOceV341x7FoucKaTD3RmAylcsNpZdGXCV80uCC4fYX3NFJ9R0lM1A+BfDWaPDX2V2
 zBMvtg4zLhjlxHq4ghBpLvueYBFSePD+cZGdCV+FF7mur5UvE51qXImEoNj67n3JfPrQkA4Ibdq
 rTgfCj6pSwRxnV6Eh7GuneDruXnA/EXRm3o/oxMxZdNy5CGGTkGva6IuZtsiEQEOjTIS/rXzkt0
 f1BnYNbtzAx3u7e13Vn9lK91sc+II1iyYDLZuG0ilB8TQ8dkpvWr29+HLk8iYH91R1yvh0W9Nxx
 fCzZtaVUfuEZt5sltN5T2cgc+pEzmsVWN/6DQG
X-Google-Smtp-Source: AGHT+IGmv/JvmbhnvMjDJ/pDhFXJgTcvXSStAgekVNcvSJsAlX79NL0tuDCDtPulactZ7nhWLcdCfnfKlGQJ
X-Received: by 2002:a17:902:cf42:b0:28e:aacb:e702 with SMTP id
 d9443c01a7336-290c9c8978dmr13521975ad.2.1760643287766; 
 Thu, 16 Oct 2025 12:34:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29098e8abdesm4011905ad.5.2025.10.16.12.34.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Oct 2025 12:34:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b548c516b79so176688566b.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760643286; x=1761248086; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L23KxszxmnHguSqie5HPxGHmR8eDQT8aM/yq5HTxanU=;
 b=hKNF+4caAogECU6IqmpYRlsNOyP5cQwNIR8N4jyqjuKYRMpTCMY+O7L56wFpXgfmxJ
 0hMT1JVmGW9p3tpNhND1FAEd2ksG4Lo+ZxzhTbtoJQKpS9ESQu4LiGD65LdDEXUS1sJ2
 fTAJePJILZ00oMcjqiijZjhxRtOmuL7GZS6EU=
X-Forwarded-Encrypted: i=1;
 AJvYcCWMtLjkgb/7inUQUctbbW6JbURLp1F3CZoKWFJ8i7HzrC3Prisd1fLr0TFkv1x0O4e8clw=@dpdk.org
X-Received: by 2002:a17:906:7945:b0:b50:891f:6699 with SMTP id
 a640c23a62f3a-b6473241dc4mr114699066b.15.1760643285790; 
 Thu, 16 Oct 2025 12:34:45 -0700 (PDT)
X-Received: by 2002:a17:906:7945:b0:b50:891f:6699 with SMTP id
 a640c23a62f3a-b6473241dc4mr114697066b.15.1760643285301; Thu, 16 Oct 2025
 12:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <CAEKskBV=t-3tR+qBGBDPNiEj1=6UKSPGP=-LA5Ztmxr5viwizw@mail.gmail.com>
 <CACZ4nhvcn-z_9W=cuV5nKEcFsP87cBQ+hx6_WsNcqZGpw3gm-w@mail.gmail.com>
 <10599004.ag9G3TJQzC@thomas>
In-Reply-To: <10599004.ag9G3TJQzC@thomas>
From: Manish Kurup <manish.kurup@broadcom.com>
Date: Thu, 16 Oct 2025 15:34:33 -0400
X-Gm-Features: AS18NWB3mKeIJNRBWsJVbory5DdZqCfst4rQnn_WGUSIdqEWW-JPCOm22Rex03s
Message-ID: <CAEKskBXRXKOs6fMqC4+pevZVAs_PM30O9UosXNXFL4w72EKupQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/54] bnxt patchset
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000a5e64a06414bb53d"
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

--000000000000a5e64a06414bb53d
Content-Type: multipart/alternative; boundary="00000000000099519806414bb5a3"

--00000000000099519806414bb5a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 15:29 Thomas Monjalon <thomas@monjalon.net> wrote:

> 16/10/2025 17:39, Ajit Khaparde:
> > On Wed, Oct 15, 2025 at 12:46=E2=80=AFPM Manish Kurup <manish.kurup@bro=
adcom.com>
> wrote:
> > > Ok I=E2=80=99ll do that the next time Stephen. Could you please allow=
 this one
> through?
> > Thomas,
> > Patch 01/54 is stuck probably because of its size.
> > Can you help and open the gate for the patch.
> > https://patchwork.dpdk.org/project/dpdk/list/?series=3D36360
>
> Indeed, it's a big one and was blocked (currently it's limited at 700 kB)=
.
> I've unblocked it.
> I can raise it but processing big emails may be a problem for many tools.
>
>
Thanks Thomas. I=E2=80=99ll split it into smaller patches the next time I u=
pload an
update.

Sorry for the trouble!

>
> > > Also, how would you recommend I split it? Can I do it by file?
> > >
> > > What=E2=80=99s the patch limit?
> > >
> > > Thanks,
> > >
> > > ;) Manish (x1380)
> > >
> > >
> > > On Wed, Oct 15, 2025 at 15:09 Stephen Hemminger <
> stephen@networkplumber.org> wrote:
> > >>
> > >> On Wed, 15 Oct 2025 14:20:00 -0400
> > >> Manish Kurup <manish.kurup@broadcom.com> wrote:
> > >>
> > >> > Hi Stephen,
> > >> >
> > >> > To reiterate, this happened for V2 as well. I remember seeing a
> warning
> > >> > about the size of the patch, and that being the reason it was
> dropped.
> > >> >
> > >> > Could you please explain why this happens? How can I ensure that
> this
> > >> > doesnt happen again?
> > >> >
> > >> > Thanks a lot!
> [...]
> > >> > > Stephen,
> > >> > > I don't see patch [01/54] on patchwork yet.
> > >> > > From what I am told, that patch adds the ulp_template_db_defs.h
> [...]
> > >>
> > >> I think mailing list and patchwork have size limits.
> > >> You might need to split big ones.
>
>
>
>

--00000000000099519806414bb5a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:-apple-system,sans-serif">On T=
hu, Oct 16, 2025 at 15:29 Thomas Monjalon &lt;<a href=3D"mailto:thomas@monj=
alon.net">thomas@monjalon.net</a>&gt; wrote:</span><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">16/10/2025 17:39, Ajit Khaparde:<br>
&gt; On Wed, Oct 15, 2025 at 12:46=E2=80=AFPM Manish Kurup &lt;<a href=3D"m=
ailto:manish.kurup@broadcom.com" target=3D"_blank">manish.kurup@broadcom.co=
m</a>&gt; wrote:<br>
&gt; &gt; Ok I=E2=80=99ll do that the next time Stephen. Could you please a=
llow this one through?<br>
&gt; Thomas,<br>
&gt; Patch 01/54 is stuck probably because of its size.<br>
&gt; Can you help and open the gate for the patch.<br>
&gt; <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D3636=
0" rel=3D"noreferrer" target=3D"_blank">https://patchwork.dpdk.org/project/=
dpdk/list/?series=3D36360</a><br>
<br>
Indeed, it&#39;s a big one and was blocked (currently it&#39;s limited at 7=
00 kB).<br>
I&#39;ve unblocked it.<br>
I can raise it but processing big emails may be a problem for many tools.<b=
r>
<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks Thomas. I=
=E2=80=99ll split it into smaller patches the next time I upload an update.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Sorry for the trouble!<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><br>
&gt; &gt; Also, how would you recommend I split it? Can I do it by file?<br=
>
&gt; &gt;<br>
&gt; &gt; What=E2=80=99s the patch limit?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; ;) Manish (x1380)<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Oct 15, 2025 at 15:09 Stephen Hemminger &lt;<a href=3D"ma=
ilto:stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.o=
rg</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Wed, 15 Oct 2025 14:20:00 -0400<br>
&gt; &gt;&gt; Manish Kurup &lt;<a href=3D"mailto:manish.kurup@broadcom.com"=
 target=3D"_blank">manish.kurup@broadcom.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; Hi Stephen,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; To reiterate, this happened for V2 as well. I remember s=
eeing a warning<br>
&gt; &gt;&gt; &gt; about the size of the patch, and that being the reason i=
t was dropped.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Could you please explain why this happens? How can I ens=
ure that this<br>
&gt; &gt;&gt; &gt; doesnt happen again?<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Thanks a lot!<br>
[...]<br>
&gt; &gt;&gt; &gt; &gt; Stephen,<br>
&gt; &gt;&gt; &gt; &gt; I don&#39;t see patch [01/54] on patchwork yet.<br>
&gt; &gt;&gt; &gt; &gt; From what I am told, that patch adds the ulp_templa=
te_db_defs.h<br>
[...]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I think mailing list and patchwork have size limits.<br>
&gt; &gt;&gt; You might need to split big ones.<br>
<br>
<br>
<br>
</blockquote></div></div>

--00000000000099519806414bb5a3--

--000000000000a5e64a06414bb53d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
MjAyMwIMNmKeINO4t964SBkFMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAxr/k6
iuRSN7g4eXXPGfKbS78uIKYwozCjUk/yawQjVDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTYxOTM0NDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAipKCeOKORejyR5ShEG03VB/dG4TtmS8TWV3AxjMMf
aA2K1ORXhSNTUiALinF8JkrcBbgOOqme88KYGjfimaVEjT7RH6IE1oNe7A8UI6qbUuU+u+neC625
sjkipM/EfngZJ/8Aihzrfr9seq45pP0jUD7PXMN3gHR2cmf3ZneZbiiviIoyGVWLZjhv/UQEYcff
9qhdOEh7fJaHJxOI4Lzp5TQL0NxtKj0AS6/YaH3bXNrmNI/TOIjH33DVsq+KBkOznSELG6Kdv3Wy
GSEK5liE41YRWNLyA8QAFOdaZ8GQ4+p+/QhL3wAi54nVxf6lINl+pEkTnGq1fiw/RqMGayiM
--000000000000a5e64a06414bb53d--
