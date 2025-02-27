Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D25C197BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 23:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C69094029B;
	Fri, 28 Feb 2025 00:35:27 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 7D2814027F
 for <dev@dpdk.org>; Fri, 28 Feb 2025 00:35:26 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-abb7f539c35so278561966b.1
 for <dev@dpdk.org>; Thu, 27 Feb 2025 15:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1740699325; x=1741304125; darn=dpdk.org;
 h=to:subject:message-id:date:thread-index:mime-version:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6/FV5hjf6ViDY1IqRAALxC92WlCsZDINWdxphiK+xbI=;
 b=Kdite6gmMHdquSUSYyyN1mJe+1YaMB2Z2lhtxJc8j75fIcF1vOIi0VvYl6k17QWtSW
 deqWeKQWIVtYtUxB9wpnim+U+ttRfL6GjakoAcP9Gn97g1t+whWQifz2l004j55x7ClD
 /UsP7KpNKWIpstMy6WuZdkcmJbEZid0yek6sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740699325; x=1741304125;
 h=to:subject:message-id:date:thread-index:mime-version:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6/FV5hjf6ViDY1IqRAALxC92WlCsZDINWdxphiK+xbI=;
 b=NE3X+k27hprRtlb8VB2W34A3gYU2RnMWkEV4CT1unlVzn1nsaRqnhZYcQMCNQrL8+E
 jWi7y2AgynOC8Y88CAqhllqNtppNuLt2aaSE5hHOk0JPI/wJoVz47bI+dYohDnu0LH/H
 tTf88D8N09/xKObBHFjzCzR/jdghJzYblJUdWRd2N8Ol/evLzemrwF2X5Xz0IBSRcIfD
 o4TztArXjeVE0zFwUHJWAu2Las/5RuczsM9Ftd8wHQ9wGCJ859iB8NgyeNuVbng5+p89
 MLTnDULAUscVaxJ2nEtI5+vUxP81dOJgXi+4Yw+2y+o5U2tbgYUNgGnXd5wOpnbDDMDr
 e7Bw==
X-Gm-Message-State: AOJu0YyfuhjXounGI2hKzEGg85Fcx2uVKLpkLbUeBA46cVs1UBVimawn
 +YF7p8o2k+3gW6FyjLTVL99y714dWOEnvz7VBISmmjiTD4MJhoRt1bYmL3YyoMgE9orQmJVKOWH
 SvcLnHokomLYa3yDUZ9Z6Cv196Z1NcJAqq57zuiWn2wT55LAlgtwe1VSXVFpBeFJ5WArhXPnFtl
 8ij58ybUApbWar3Lk=
X-Gm-Gg: ASbGncsASeLkLFpDAoWsLhH27qUN1HdctwuaeajNnHm3hi45Dk3fVUkSybRaKlRuSyz
 MQ6W4L99nyORETTrE1vHEuskR8ZbVmQ+XiPhSHXsAcwP0qIKbLVLtq0xP6RDh8gdu3ummke9wve
 pScn9QZXI=
X-Google-Smtp-Source: AGHT+IE5svoXLxjuRrD+6Xo58lrT18zHy3tD5CseqT2mQepCjPbpaS/t28wdsz/q46q0vzHa1CmkhVtKSpWMP61vZ5o=
X-Received: by 2002:a17:907:96ac:b0:abb:db78:a24e with SMTP id
 a640c23a62f3a-abf25fdc715mr116840666b.23.1740699325208; Thu, 27 Feb 2025
 15:35:25 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AduJbgXzAHbI9mKUTKiMjEMs7P3TUg==
Date: Thu, 27 Feb 2025 18:35:23 -0500
X-Gm-Features: AQ5f1Jqu3w0Y-IAZlHI6lpSZi2TOc7QCLgXTw_s5n2CL5IJgcFt69OJOxQRy5Uc
Message-ID: <0e434799cd43394c0604f08462001c02@mail.gmail.com>
Subject: MPLS Push action
To: dev@dpdk.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f6a6d1062f2824b9"
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

--000000000000f6a6d1062f2824b9
Content-Type: multipart/alternative; boundary="000000000000f0c536062f28245f"

--000000000000f0c536062f28245f
Content-Type: text/plain; charset="UTF-8"

Hi,



When MPLS push action is used, using testpmd action  of_push_mpls, it
accepts the ethertype only. How do I specify the MPLS label and other
fields for the MPLS header to be added ? In the doc
<https://opennetworking.org/wp-content/uploads/2014/10/openflow-switch-v1.5.1.pdf>,
in section 7.2.3.7 there is mention of OFXPMT_OFB_MPLS_LABEL and other MPLS
fields, but I could not find that in dpdk implementation.



Thanks,

Kishore

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000f0c536062f28245f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"><meta name=3D"Generator" content=3D"Microsoft Word 15 (filtere=
d medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" s=
tyle=3D"word-wrap:break-word"><div class=3D"WordSection1"><p class=3D"MsoNo=
rmal">Hi,</p><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">When M=
PLS push action is used, using testpmd action =C2=A0of_push_mpls, it accept=
s the ethertype only. How do I specify the MPLS label and other fields for =
the MPLS header to be added ? In the <a href=3D"https://opennetworking.org/=
wp-content/uploads/2014/10/openflow-switch-v1.5.1.pdf">doc</a>, in section =
7.2.3.7 there is mention of OFXPMT_OFB_MPLS_LABEL and other MPLS fields, bu=
t I could not find that in dpdk implementation. </p><p class=3D"MsoNormal">=
=C2=A0</p><p class=3D"MsoNormal">Thanks,</p><p class=3D"MsoNormal">Kishore<=
/p><p class=3D"MsoNormal">=C2=A0</p></div></body></html>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--000000000000f0c536062f28245f--

--000000000000f6a6d1062f2824b9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBV4wggRGoAMCAQICDGgm/w/0NSlGWEAE2zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE5MTJaFw0yNTA5MTAwODE5MTJaMIGa
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGzAZBgNVBAMTEktpc2hvcmUgUGFkbWFuYWJoYTEuMCwGCSqG
SIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAO2KIuHym2NK8LJKtVibxyL/jOwnjzOIbXwiGiJPTo8T3NfkkTIJ4jDc
o06M9E2KoIo4ve+92WrMmLwu6T+HphBMDOfwXxaFLJqYOTdp/DuZNUCmlXtWkO6YZ60qdFOP+pZI
0kEta7Kj9i8JM6kC6NChp3t27AlN/Cmo7PEvyRBXKKzBuKV8xxlaTxbs5z63gvCk4AACEUoMhT3G
OFoe9ghMyQPTG+PhUrwVfqQhB5Cq/UEBY+ML9HK5T2vnfQ6/7Ujo6SRjlDcMKCMt1fsldmDnws3R
dW+s1pbDZSF3o7LAMPaZD1K6+7+kfhg5PhpHobmqdkKh77/wagvxKPOjt2ECAwEAAaOCAeAwggHc
MA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
dDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFs
c2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+
oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
sUAuVxt1XArsF6SqOey0deblHSAwDQYJKoZIhvcNAQELBQADggEBABnnHNuTT9JPO0hVqI1+MhBA
mqeMl+tCr/6T161Uv4ra668I1pNZsS/xjmtHYG6uH7m0k09RdNZFerHwtvsaDs1ueuDic62X1xzE
d5pE71+eY7IXZyt7JOzujKMjBT1ll9ksv900PSfepOhlts+qt39mfsK3GFpWucs5yPQW4QdANh1g
QQvpKuVIATCT7bbi97PnmyBbqR4lilWpd720IqWfp2so0ihV+YqcZebbT5leoAa/bHgoDUx+ejzc
Uk12jX97cL/DKIHD0pff67TlZq5ZjltzVjTA0XaUzEak9bSqclhSSbSbYHhRDR4syFcEWXQRxou7
RctJp8+CIW2Aci4xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgxoJv8P9DUpRlhABNswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGK9hBMY
Pym88EhT4N4h/1mFHAKPkIBhGMgho9HGW0jSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDIyNzIzMzUyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDrqtmOXNFrjCYY0Qq4C86gKFZy
/bIf7r/BJGY+CQYcBN6mjprg5dNybkqjpHPq8RP+17LvdwBUaYoNbg49xgbK7vRxSAalwV6eA6kN
PnXQK4JODylhh3j/HExuK2FPIu2vL0P/pXkXYLxHjdGLCc79LVJIu50vUwIScmeX2YQOfQHSItp/
Y4aqzi742f+T+ug35CSx7t7Ax7rSBLW5Vy8SVAZmjRFxjlGP/KuRAc4GNC5JcAAMlu8wfoK45BUr
oVyzsSg+AN/k8HzuPKm6zOOTNhYEZ5aY/2XI6CYV+IRuE4jA3HZeG5qX9VahK0827zlefVmOzQTD
R08ZSB9M0U2k
--000000000000f6a6d1062f2824b9--
