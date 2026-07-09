Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA19C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53984060B;
	Thu,  9 Jul 2026 18:09:42 +0200 (CEST)
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com
 [209.85.217.98]) by mails.dpdk.org (Postfix) with ESMTP id 41F1E402CC
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:09:41 +0200 (CEST)
Received: by mail-vs1-f98.google.com with SMTP id
 ada2fe7eead31-73770fd1cd9so2281137.3
 for <dev@dpdk.org>; Thu, 09 Jul 2026 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613380; x=1784218180;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3/nRUl2czCQQbmU8nrb7rMf8OxodgGeyxz5aYWVrl3g=;
 b=eqXUaqD/dFC70Ie8a37wj4A5qE/W8kwXrsatvgYZ4cll2SUgfS+Seqvyg4ODVOdqAC
 JBD3ypEZ7zbacVkT2rJN3ayfBJfycHCpCC0wpFmrkTq71uWzgU+6myh46pxlI8AA8WMj
 RBZh4JMz8CAcuqqNZ2eImHkKk9jEcgUBwvi1DQ9lQXTYqJuePn+63mcTEdDj0wxWPasD
 +8qAka6/3/t09aNBtCIHpXgHtqgPSJfyR5O17Swj2lhG4j9/KoyW19yzGYMLW4f4GeDg
 TEgp+MChoeoi0cu5kHfcN4uTtEgyYdpXTrn53PRWjEH+ujbbFzJYpC6YGXODANjHLRq/
 nV0w==
X-Gm-Message-State: AOJu0Yzq+pEj41UgLtQxsSnaOHwfvQsTq2zpluwitgN53VJsKT4qW2ZE
 nzlISY7JA6drbdxhCDNNi0KEsufo8+0ngBcPXHRjweRDsAHQK1t7zMS5fn4HnAKRmHYtdM/aZev
 x/BQ3KRmNbSU76mYRK5WF309u+qaLr7Y3WM17s6m2XTzh89jlOMgKAN+HbtTGpUgyxQgtf6DcUY
 /3iIdxRdYItXQWeMlMAWKdbDcD3LyfTlI4McO6nte6j19k0RK+3jrGLzuPMS+n8mKZx+P4mlo/8
 Ejfwg==
X-Gm-Gg: AfdE7cmD3HcrmA9zBn1kT04WGp8U24QdzXsbS3zIuEYqp7IsaVXNmIx+f8IU/nLpNxN
 LbEdU0C8iThPM5a0TBVQCcQECeDgE+qbu9H6i7F6AsBFa+6KKPk/QTfcS1YioEyOyXt3oXoCntA
 0WTY+HgPm3jI1x9eatcWqbE1AoBtzIYLoalkNeJcSdPRTXogaJv5R0ktgvfx4XSsbwjvhbWo3YC
 vLIG85sIYjyyQI/zpjdsBr6HegHfrmjG9wqOWxcNWmgHKw3A7RUnTRtQSdPIcT5GCO9mMy916cQ
 hw/GpmiopSnjlRyHYbrbweXvRZdmet0FGDN+qUjCzvgPZjP8YSD6ghZL5tT6W7Aclf9xGKE+jxR
 4Kzn7jRTxXmLuZT578OQtHLRfzVyzlX+lSIKgTRtxkN//6+W5iZBhAyb5uMRRA9hFKywPjlP8ET
 OT/YNSf++nex9KRHuJylLRvh1QHJpkTjlUIn9gSqMvBZV9AQ665fsYIg==
X-Received: by 2002:a05:6102:418f:b0:738:1fcb:f276 with SMTP id
 ada2fe7eead31-744dffbeddbmr4906541137.1.1783613379969; 
 Thu, 09 Jul 2026 09:09:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-744d6ee19fbsm476893137.26.2026.07.09.09.09.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jul 2026 09:09:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4926596eebcso17442935e9.3
 for <dev@dpdk.org>; Thu, 09 Jul 2026 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1783613378; x=1784218178; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3/nRUl2czCQQbmU8nrb7rMf8OxodgGeyxz5aYWVrl3g=;
 b=L3KayoRlAKhdSDwuwhwc6K60AS6sxssXZ4Yp412iP8aV98RbEeFuvxOSscK4r8n+9Q
 EQh4ouTJ9r0UORbJUGeFHDXihbxjezMnQ+NKnvBaegQ+glVEVkuPagrw/gH2Bz+bDydm
 Gz4vSmxpkWC3VUIGv9meBeNe0dW8k9LpgA1AY=
X-Received: by 2002:a05:600c:4743:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-493e68c4a07mr76623215e9.20.1783613378525; 
 Thu, 09 Jul 2026 09:09:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-493e68c4a07mr76623045e9.20.1783613378099; Thu, 09 Jul 2026
 09:09:38 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <EAYPR13MB7316899D71B96849EDFB8BC0B4F2F02@EAYPR13MB731689.namprd13.prod.outlook.com>
In-Reply-To: <EAYPR13MB7316899D71B96849EDFB8BC0B4F2F02@EAYPR13MB731689.namprd13.prod.outlook.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJWsLk+Taj3zPwIrv2QKb7C2ptLl7VyGRcA
Date: Thu, 9 Jul 2026 12:09:35 -0400
X-Gm-Features: AUfX_mwXszWkr3S8uRIO0dfxkABxhkI5Zh3BQ8X5BKDLUOhV08od3VzEI2tycJQ
Message-ID: <6456b41e6775851acdf996127afffc35@mail.gmail.com>
Subject: RE: Inquiry about status of accepted patch net/bnxt/tf_core: fix null
 deref on pool use allocation
To: 20260603041557.115956-1-denserg.edu@gmail.com
Cc: dev@dpdk.org, Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>,
 stable@dpdk.org, denserg.edu@gmail.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000dcf86706562fd9d6"
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

--000000000000dcf86706562fd9d6
Content-Type: text/plain; charset="UTF-8"

Hi Simakov,

Will get back once I check with the maintainers.

Thanks,
Kishore


-----Original Message-----
From: Simakov Aleksey <bigalex934@gmail.com>
Sent: Tuesday, July 7, 2026 4:05 AM
To: kishore.padmanabha@broadcom.com
Cc: dev@dpdk.org; ajit.khaparde@broadcom.com; stable@dpdk.org;
denserg.edu@gmail.com
Subject: Inquiry about status of accepted patch net/bnxt/tf_core: fix null
deref on pool use allocation

Hello!

I hope this message finds you well.

I am writing to inquire about the status of patch
https://patches.dpdk.org/project/dpdk/patch/20260603041557.115956-1-denser
g.edu@gmail.com/
It was marked as "Accepted" in Patchwork over a month ago, but I noticed
that it has not yet been merged into any of the DPDK branches.

Could you please clarify the current status of this patch?

Thank you for your time

--000000000000dcf86706562fd9d6
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
oIHHMC8GCSqGSIb3DQEJBDEiBCChPR0vF31q2Ts/YruB4+/BN3bz0gnLHU6L0AsvmIaphjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MDkxNjA5MzhaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBusP/Lzflk
02afn7F4mwltfiDXrRFBA5evDlo3BgTE+kCeeEjb+fo89mhamZtEKY+emSsyZpfwuJPEfOHPpn9d
FGsMbGtYLMradS7ONJXrxrv8Af5S+C08IOes3wuIGc4k1RvI8NulKxigQF8Od7EoHTxS5wLM3+rN
GZJApiIidO9u1Xt+JMRBpA+OS7igh22ZvEA4kKlJtqEPTHb2AdXzL/LuNY/TuqL8cpcnHedQiWEn
l3V+3pNV60lSR7F2lqRKyIlVrujdCJPm2TjwJffe6Rkwz5tMDLehEdghHxysLmLK1xCok1P4oY1W
H9XS3GNwKaQFoY69yqHBYZXC8OC+
--000000000000dcf86706562fd9d6--
