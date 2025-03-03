Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB7C282D1
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 16:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E20F94027F;
	Mon,  3 Mar 2025 17:02:14 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 56B7A400D7
 for <dev@dpdk.org>; Mon,  3 Mar 2025 17:02:13 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-ac0b6e8d96cso156725466b.0
 for <dev@dpdk.org>; Mon, 03 Mar 2025 08:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741017733; x=1741622533; darn=dpdk.org;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YYaMZA6/p5LuLFMyeTJ594tiStzVQE5/WYrOu3lRy/s=;
 b=QD9Zs5g6HkXXrDyRI3ipUk5vksqoJGmxOOGvTH3gZelW+s4izk7MJ8HsBV/Fu76asY
 vkEBjsh0tROaQLxaj9F5aMIzYKtkd0KjgecxNPm+ydFuQgiTeez9acerfzs7Iv6FcaSU
 hiudtkgNnT1mXqxd4OEmxGYj2tyP8vmd38n+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741017733; x=1741622533;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYaMZA6/p5LuLFMyeTJ594tiStzVQE5/WYrOu3lRy/s=;
 b=MMwEVLnhehIhSfb+WyKRM1uRuxAWBQqQbgKz3T946JFPLn3UZpzoqVSOqUc2ZbE1mI
 1rXo/EaNJc/RztaI+7iz9sRVs6iH/RK3hiIZf1X7BQpkMm54+bz+Sq/552q6hvkITvsH
 WJw/a5/uRT82lV2Ru/blTwb3YD7KXkkuK4Epgiv3aooIUdPmF922PkI13epJU7AotSrd
 kXbV2Vc9vvrKqw2uDYVwM8AslWs3+2amMEaql6gBEwKb1HSxS5ogf8+S3GBC979NUAEN
 5Ctki/X2VkPxRD4xF8xyiKpvVg7obp0mgr/yXnfVZQzMTN0MBvWIji8UqItBYm3nrmeX
 ILbg==
X-Gm-Message-State: AOJu0YwmCMwYQzpYdIvtaPbYPgocIqNC3uWkTmt96twnulwDXEGSiOix
 6dQVH/OE1kJXEphffRNEPnZH6UgEAihQpIzyxOsM/a7hwJ8/jwsyEa7uxRFlntCflErTGg0xrLI
 /pcxl0R+EGJoI6+K1GxHazKwbPulMrFVpWpfQqbfwBwENNRhFS3iYV38FaBiU44aqvdKjXvlre0
 FqOFti
X-Gm-Gg: ASbGncvgCPI1vLe6SGNSNrsCgZz4hJpJqSkNdF1NIQcs5CrG9oAUz0ug3dULXvPtd6z
 q4S7iS+YGCigPtOfOXfJFE4+mzRXAweX41kH7dvp5aCUA+PbJh0cQqjIRbDGo6mAK/ARF+gHFIg
 4ZGzWGZj4Oe6sG73nTJ5i3//GF2U4=
X-Google-Smtp-Source: AGHT+IG+LGtQWH4Ik6hpool/KjdvKawwyRNUPG1gr8cQxfC8uDlUT6OSisDX57u4nv/UmFJG4T+ozL2zHvWvpGMY8E4=
X-Received: by 2002:a17:907:d1a:b0:ac0:6e7d:cd10 with SMTP id
 a640c23a62f3a-ac06e7dddf1mr345332166b.2.1741017732661; Mon, 03 Mar 2025
 08:02:12 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: 0e434799cd43394c0604f08462001c02@mail.gmail.com
In-Reply-To: 0e434799cd43394c0604f08462001c02@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AduJbgXzAHbI9mKUTKiMjEMs7P3TUgC5gXGw
Date: Mon, 3 Mar 2025 11:02:09 -0500
X-Gm-Features: AQ5f1Jr3ttnygxv_Y6FGpSQsX-yCQrEXm-v2CiNgKqlNFNmTEsA4qBmmHauQusM
Message-ID: <b62e330e086126415f7b4987a9747ce2@mail.gmail.com>
Subject: RE: MPLS Push action
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, Ferruh.yigit@xilinx.com, 
 qi.z.zhang@intel.com
Cc: dev@dpdk.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000880f67062f7247fa"
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

--000000000000880f67062f7247fa
Content-Type: multipart/alternative; boundary="00000000000080f950062f7247b5"

--00000000000080f950062f7247b5
Content-Type: text/plain; charset="UTF-8"

Hi,



Anyone has any inputs on this. Or should I add new CLI commands in testpmd
to support action for push MPLS tag.



Thanks,

Kishore





*From:* Kishore Padmanabha <kishore.padmanabha@broadcom.com>
*Sent:* Thursday, February 27, 2025 6:35 PM
*To:* 'dev@dpdk.org' <dev@dpdk.org>
*Subject:* MPLS Push action



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

--00000000000080f950062f7247b5
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" s=
tyle=3D"word-wrap:break-word"><div class=3D"WordSection1"><p class=3D"MsoNo=
rmal">Hi,</p><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Anyone=
 has any inputs on this. Or should I add new CLI commands in testpmd to sup=
port action for push MPLS tag.</p><p class=3D"MsoNormal">=C2=A0</p><p class=
=3D"MsoNormal">Thanks,</p><p class=3D"MsoNormal">Kishore</p><p class=3D"Mso=
Normal">=C2=A0</p><p class=3D"MsoNormal">=C2=A0</p><div><div style=3D"borde=
r:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in 0in 0in"><p class=
=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sans-serif=
">From:</span></b><span style=3D"font-family:&quot;Calibri&quot;,sans-serif=
"> Kishore Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com=
">kishore.padmanabha@broadcom.com</a>&gt; <br><b>Sent:</b> Thursday, Februa=
ry 27, 2025 6:35 PM<br><b>To:</b> &#39;<a href=3D"mailto:dev@dpdk.org">dev@=
dpdk.org</a>&#39; &lt;<a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>&gt;<=
br><b>Subject:</b> MPLS Push action</span></p></div></div><p class=3D"MsoNo=
rmal">=C2=A0</p><p class=3D"MsoNormal">Hi,</p><p class=3D"MsoNormal">=C2=A0=
</p><p class=3D"MsoNormal">When MPLS push action is used, using testpmd act=
ion =C2=A0of_push_mpls, it accepts the ethertype only. How do I specify the=
 MPLS label and other fields for the MPLS header to be added ? In the <a hr=
ef=3D"https://opennetworking.org/wp-content/uploads/2014/10/openflow-switch=
-v1.5.1.pdf">doc</a>, in section 7.2.3.7 there is mention of OFXPMT_OFB_MPL=
S_LABEL and other MPLS fields, but I could not find that in dpdk implementa=
tion. </p><p class=3D"MsoNormal">=C2=A0</p><p class=3D"MsoNormal">Thanks,</=
p><p class=3D"MsoNormal">Kishore</p><p class=3D"MsoNormal">=C2=A0</p></div>=
</body></html>

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
--00000000000080f950062f7247b5--

--000000000000880f67062f7247fa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfwYJKoZIhvcNAQcCoIIQcDCCEGwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3WMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
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
MDIwAgxoJv8P9DUpRlhABNswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAwmsSM3
xUa2xj2KKIVJ1Cjq6vbg5PsnVMI0+/nqKAsQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDMwMzE2MDIxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDHrgabC75SNicUzB/qYI7N3YAl
eBzVpVpnAwIfNEEensBE46Ea1vc+csLvU5W0B3NG0RXC+hYffwQuXMYVPx15lXg6Aw7U+qhxF08z
ksdFobcekVYUlf2PYac+pQBNHJlUkV82atKhajpDE/bNAjGgTRnnn7w+GFNp4SzFCc7Vs2hdKS1r
bqsdK2Do5pSBLiVaU1g59/1INIgmA1ARC14Zev1I9NmaSb8t+//xFK5hOMi9ZK7Ri7azbl6mHBkd
+n1lO/Xs9y0OsANAKWGKrULcMGTfoMYKxWLwAV7B+WfI1RkVh/kCafj5xxBtkj38X9TY+1wnZz7g
I0oISI5iMVTA
--000000000000880f67062f7247fa--
