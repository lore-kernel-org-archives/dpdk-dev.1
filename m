Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07CC44501
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 539D540289;
	Tue, 14 Jul 2026 18:48:51 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 64DD44026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 18:48:48 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2caed617615so50210555ad.3
 for <dev@dpdk.org>; Tue, 14 Jul 2026 09:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784047727; x=1784652527;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eUV5eSBKYl67+Y+X4EBRLgPddwTsn12Xen5qcacvWcY=;
 b=ltkPbXoy6nQ93vBtkkjr+4J2KSHZLU+WcAxC/k6IjX0EE7Abhh69KAp0OOwCMGjf1Z
 iW/vjLNUXPooOBzUhlZKt8b3TSKCaK0nBnVbOq2+ZhUxPPCTI0cHkC6lfaZ96wMi2Bxh
 gNjnrGC138u9ZZDZQaIoHhUCt0+OoC73k8D8ei3fGLkkhqqaDOOPZHXappZqPImkpBrZ
 aKYd8PCtGiw1Y8fU9Lftb1RFE6q2aBL4YvACRkhXZRlA7/jnOnD3B8kUjyCg3pbIFonb
 zir/WdvuvQeyi9GDM/2vS3ntcX+BvRhtoYC39KmXregz8J9vlHX5hXbU63yJXhHog1sK
 exxg==
X-Gm-Message-State: AOJu0Yz5XT92eSeUrXe5jz0WTtR2PemfIoHJzbRZ70HL2NayvVNC1OAq
 MobT9eWOaQQF2vu1mJz4eQPdt29BkT2dMc/1lgOvx9+/3ulWnHYUUHB2RhFzXEs31Uf/PrAZpu3
 Hk1Murb2l/xhSfKj07s849+HiOnH36IChGES+LM8F0WLihsZnj5TCuzJFZfyQjaOAQwdSL27lvX
 k8XxyY0/A1YoXAsLvATupfDALpoaz+X8K0xkcgXQKMpKD1p4S68RIqBnt7qM/+68orTRkNwk8gu
 cFE5g==
X-Gm-Gg: AfdE7ck18bpLp559SFt3tj5pPEZAm7o+mABgsGKqV06jcSSgvh2lZ/DrB64vbJCoZEn
 6zlUODuQQ4UCJixLPJrPuM7r/n++6MlWmQXgT3lrwKEiLhXdOF1pFTZ2dbJBvdG3yBgSE/9YFUp
 3DcfrvgUprmVzLabEfW7F+rvDElX2Up4FLnyTPr06FNTckeMPfcjQovz3H7k04FX1sbPgMBAvfC
 r2JtQkvOLxOuMXgpB1cJzuVPbxoigUVg3rZE1qN5ZnFaBR3+aSMfo1YLGedTvMcmEKIC7qB9DRt
 knOBsZY89sr7p31sj6hyhQomrYGTG8kbCumY8+J+ZA1Yk/Td4ElBWX7iiZ5IJ3HrSvzOLD8rkrw
 12l2m1nEDKyvQ3/x/v6EJSlIV1BxmwK5lem5dV8AVg6BSOPncmj7CLrGahyvCWFN/hPnMiFXG6i
 6/BZVGElrOuaMoMYOJiIoizW6gu6BMzfLNsOCKT2E5dBmno2T+X/JuyA==
X-Received: by 2002:a05:6a21:9d4c:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3c110778416mr15318831637.24.1784047726939; 
 Tue, 14 Jul 2026 09:48:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-ca5b22d0c9csm1755429a12.6.2026.07.14.09.48.46
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2026 09:48:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493d742c668so37364225e9.2
 for <dev@dpdk.org>; Tue, 14 Jul 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784047725; x=1784652525; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eUV5eSBKYl67+Y+X4EBRLgPddwTsn12Xen5qcacvWcY=;
 b=RqbsAYJ6vjuO4qKfs4+HalipaG8OG9rsJcqTmb6td3/PB2Oyq7+tMpIZRph1IPkya3
 gnziWYJVIWUmiIUBIg3p2sB3uf24/1FJT5ooycqpRiGr79k7Cd9N5oOtHJetxpIJ/AGu
 6Fpk6QCSKrEV5gez094kJ9p8+0ojWn0Qr0o0Q=
X-Received: by 2002:a05:600c:6303:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-495158c6a1bmr50626045e9.8.1784047724703; 
 Tue, 14 Jul 2026 09:48:44 -0700 (PDT)
X-Received: by 2002:a05:600c:6303:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-495158c6a1bmr50625735e9.8.1784047724156; Tue, 14 Jul 2026
 09:48:44 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad0Tr9aWQsKEwKP8T8yAs2PIc5sPaQ==
Date: Tue, 14 Jul 2026 12:48:42 -0400
X-Gm-Features: AUfX_mzxmuQa_8xCUrDStTi0JH_ihDkjBwmN19OoBYFLIy5BZxSpLhnKx28tAtI
Message-ID: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
Subject: mempool cache change
To: Thomas Monjalon <thomas@monjalon.net>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000eb537c065694fa7b"
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

--000000000000eb537c065694fa7b
Content-Type: multipart/alternative; boundary="000000000000dc7f24065694fa2e"

--000000000000dc7f24065694fa2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,



The recent change done as part of BUG ID: 1027, with commit id
https://git.dpdk.org/dpdk/commit/?id=3Df5e1310f16e0909e7e7f71807123644c63b2=
3cba

Is causing performance drop for the bnxt NIC in 26.07 release.



The smaller, shallower cache increases the miss rate, causing refills to
hit the shared ring more frequently.
In the old code, the cache only touched the shared ring when it climbed
past 768 instead of 512. That extra 256 elements of headroom allowed
significantly more frees to remain local.



Could we make the change in config/rte_config.h for
RTE_MEMPOOL_CACHE_MAX_SIZE to be 768 instead of 512. Since we use
=E2=80=93mbcache=3D512 as argument for the performance tests.



Thanks,

Kishore

--000000000000dc7f24065694fa2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Diso-8859-1"><meta name=3D"Generator" content=3D"Microsoft Word 15 (filte=
red medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
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
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" s=
tyle=3D"word-wrap:break-word"><div class=3D"WordSection1"><p class=3D"MsoNo=
rmal"><span style=3D"font-size:11.0pt">Hi Thomas,</span></p><p class=3D"Mso=
Normal"><span style=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:11.0pt">The recent change done as part of BU=
G ID: 1027, with commit id=C2=A0 <a href=3D"https://git.dpdk.org/dpdk/commi=
t/?id=3Df5e1310f16e0909e7e7f71807123644c63b23cba">https://git.dpdk.org/dpdk=
/commit/?id=3Df5e1310f16e0909e7e7f71807123644c63b23cba</a></span></p><p cla=
ss=3D"MsoNormal"><span style=3D"font-size:11.0pt">Is causing performance dr=
op for the bnxt NIC in 26.07 release.</span></p><p class=3D"MsoNormal"><spa=
n style=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"MsoNormal"><span =
style=3D"font-size:11.0pt">The smaller, shallower cache increases the miss =
rate, causing refills to hit the shared ring more frequently.=C2=A0<br>In t=
he old code, the cache only touched the shared ring when it climbed past 76=
8 instead of 512. That extra 256 elements of headroom allowed significantly=
 more frees to remain local.</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt">Could we make the change in config/rte_config.h for R=
TE_MEMPOOL_CACHE_MAX_SIZE to be 768 instead of 512. Since we use =E2=80=93m=
bcache=3D512 as argument for the performance tests.</span></p><p class=3D"M=
soNormal"><span style=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"Mso=
Normal"><span style=3D"font-size:11.0pt">Thanks,</span></p><p class=3D"MsoN=
ormal"><span style=3D"font-size:11.0pt">Kishore</span></p><p class=3D"MsoNo=
rmal"><span style=3D"font-size:11.0pt">=C2=A0</span></p><p class=3D"MsoNorm=
al"><span style=3D"font-size:11.0pt">=C2=A0</span></p></div></body></html>

--000000000000dc7f24065694fa2e--

--000000000000eb537c065694fa7b
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
oIHHMC8GCSqGSIb3DQEJBDEiBCD4IXaagkKGLCfbzNStFE5Z4yt3XSMgFLTYzSZj8D2YbjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MTQxNjQ4NDVaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBNmU5i9EWO
0TwuWHPQBptfiW5N2WDKXXAs7dWuZ0Di9A222/LbiZLoRNlWxnkDcpF6hNUlIKBNN7Qzt9lGuLQS
Ntc6ZReZQBz7Onjh7nmUzzkkXvkXABCRrddzp8pXYcJc6HYfuamlpc0QyF88o4dPpwMO0qwq3TT7
p6hmo8+kSaTbkSrLxyCXhrhHuFjzVOyLerIVneKtzOxrVggNtiNAPe3njuL/L+TSSQ50mXaRi9Su
eqaCjGeF4bd1cV6a7xyflbqhHvW8Jb8sATQ3yYN+hbzcK0KJsOOSfZoVNDqgCLsot8Lynm5bjhJL
fuSsqid44bI0VWQ9Jx4Rnbps5cqC
--000000000000eb537c065694fa7b--
