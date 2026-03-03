Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB84EDA6BE
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 18:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AAE040E13;
	Tue,  3 Mar 2026 19:02:16 +0100 (CET)
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
 by mails.dpdk.org (Postfix) with ESMTP id 9BA23402AA
 for <dev@dpdk.org>; Tue,  3 Mar 2026 19:02:14 +0100 (CET)
Received: by mail-dl1-f98.google.com with SMTP id
 a92af1059eb24-1270ac5d3efso5820382c88.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772560933; x=1773165733;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TzgYfmtkxm8S0u1fx27b8sXaQy36DH2x9TCYGW2YVUs=;
 b=hdPzM1odqP8P0BVfvJZz/gYcz1LYitzik9M/cZxVPrBVYE4OGwMsmJ8PVKoKv6vwgy
 nLSuj/mmEHhIQ5S/sOeA5U9fIx0WmD894BUH4Eqf/1KzyyIRWpZ1j/yWwgyx/kR36fsf
 /RYwxknQwgdZId4CMoEQ9HRhQE4U3dSscLXBbcQu4N/2W2T5eOoERFMoxmv4kWiPn1yR
 GEGPpAtMNyWQ8V8x8x1Ns+ZwUzWxv8fmAMAqo+38rIRGDFWUrm4s0EYgbqbvJYYjdQJC
 czjmnnUatUoNbeGz+nYVxEgwgb0IKsWQpZj9xnGJHEtgN5F4kO6QHRpSsony3J6CmepK
 cFuw==
X-Forwarded-Encrypted: i=2;
 AJvYcCUpEhAqdRhaj6mB0+vl4DIUqLxMbguOUOiFI+Uw1zqk/fr3z2A2TB4r4WOc/66LsA2xfEY=@dpdk.org
X-Gm-Message-State: AOJu0YyBo3qiSeYhLjVoVKhKazUWwseOL4wNV0OZ/ozpIxYaA1D34f6p
 UwrXMK86QChLZtJXFxa6UQS1VLCiRS7+aeKSi5Yq6ldr9GbdAdA5PlSmb45Z1CrVwsUqLHFXipA
 jU5WxuG2QWY8+zyNPmd8gIlPzgTmsijNXnCpUiOShlHCFHzCQ04ncwf8g4Gdb9Lbc/gsqhBZqZL
 5vXBMRpYlIYS9rolARmmPhmFk4A+3JL5UdFbS6dVJj7q6UDSE2BZv9NsBSTRzldM3sZOlasSAxh
 v2zjw==
X-Gm-Gg: ATEYQzxbfcGUE3WzoMEMAdOrTQj8tzchEVe42T4DBksP6r4uTG4dPEVg2gvd1y4WORa
 wDAIxia0SQHlivavrrMREggwEyM8u7v/r/sbyHBasY2Z7c5IRZnTdeZVFgWOxEMD31udZ/tKn2X
 Lvu3uYwav5qfWuy1vIMiUKiJRgEfMZ2i4ktRl9zuKljFccKQ1BGGk8vY1NZxFHnsr7fsHiScyip
 0WMUFWQTtGJzTt3k1lSoiz/Hp9XXjTRNZC6pNmLQ1CXYE43gtD1VZtiPHAozH/6/nJlCy6NxR71
 066CDlRf06BlJgCAZonXWOHCNVrjR0hDI4v+0QpowsMP7Sme0XsbW3heVALQ1bBYXJxIFsVFi59
 DFfniLqosJCSNQ9a7ATCf8JLCIcP2yKiT3Q8Ym7IiKFVnlHbSb+fWhIJIkOx4bF7rC48nwPI9NR
 Hfh9OAmwiALzwqMUtaYFCduj1cHDk2V7L4x7EeBdD8Funt2Q8YncE48/u0+N8vbA==
X-Received: by 2002:a05:7022:51e:b0:127:5cda:aaf2 with SMTP id
 a92af1059eb24-1278fb77ea5mr8007327c88.10.1772560933182; 
 Tue, 03 Mar 2026 10:02:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2be2c2cba38sm63835eec.2.2026.03.03.10.02.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:02:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-65f767a8d6cso6392832a12.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772560931; cv=none;
 d=google.com; s=arc-20240605;
 b=Gp09J+ZN+yM4ictxrxKIx/DBTViOFrWzdHu2zHvRMEYNP7SJ1FwfQZMyE6JCJxV9kS
 FHkbkJlTKx/jmQvDldVgwyey+SNCriT7WKaOjhW/pD151RdJUj5LgDLpofphkF0nIfdM
 Uq6DfBvAonY+1Cl/WDexc0a3akn8v87ZuXh24+18QrIgrmrn4g6ldsOmEL/2g+JloYff
 BajaATBfZ8fgKr7qDskBzzKgyfggcXWhlFs8Sk88Y76x2D4LE9U3O6PrGvHivzJec+Vh
 6p8gvuvmGGcwP8SCOVsDngE1CvcNweBDv21qLCHs+5cNpHgaUnVs/YMXpoaHwZ0EXHWp
 gGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature;
 bh=TzgYfmtkxm8S0u1fx27b8sXaQy36DH2x9TCYGW2YVUs=;
 fh=fepYQINKgfIfKsbjsAdsqsLHASxEPIbll6/ZbJvU0mY=;
 b=VWI0jTP9NEswCi8v11Put+RMA1UdFM6DCdH88d+eKhXVNisFKQxoWc1c2Oa2P6YErC
 cfbxdeN49Bu/nAS4pVB2SWvjEbt4YwaNB0ITR9HmWtjyvRWqPPlbktXlPSw5Spj9ILny
 0pcwGf3TyXjPg71wWCEk4Zi1snJKFclQEOs8utjz/ysg8jgMSnXhFeU/O8akj3bc6NkU
 s1Li0CY+jkkTwLRkjnf6qhHs8i6PRDtUAjbdKkoDNekh5gIdJ1snN02ErQh3Q06WjI0q
 Q+2oS/SvHWA+Qf3+7XLEH+GyGHD+WGy2vb5iM0dphkcXSR4y0BLX73N+HwriynbdIngO
 hF5A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772560931; x=1773165731; darn=dpdk.org;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TzgYfmtkxm8S0u1fx27b8sXaQy36DH2x9TCYGW2YVUs=;
 b=DcPxUC2AyPD3bFVh9ZS9/9lIPa06Yz8A6+ebWTMYdocrxVClFCCHRDOYeNB8HWR99R
 HB4dPnSofQ1htYnXybj9SqoNb82CP1z9CQTvP+8R1sYztQHP4c/7RjjLY13PTLdM5qUP
 wicM3G7jPKmsa/VA/Hc8RpvNLseFy32YdIIAU=
X-Forwarded-Encrypted: i=1;
 AJvYcCW9MtDW2fAwBon9rD3gEgr0jtyAULCTac7g6ON5IaV0tKFNKS42e3uuINAgo4cEih13lF0=@dpdk.org
X-Received: by 2002:a05:6402:1444:b0:658:d541:9675 with SMTP id
 4fb4d7f45d1cf-65fddaf6c6fmr10212426a12.18.1772560931009; 
 Tue, 03 Mar 2026 10:02:11 -0800 (PST)
X-Received: by 2002:a05:6402:1444:b0:658:d541:9675 with SMTP id
 4fb4d7f45d1cf-65fddaf6c6fmr10212415a12.18.1772560930500; Tue, 03 Mar 2026
 10:02:10 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260227195410.70511-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260227200025.70591-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260227200025.70591-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQOSgaad32RFT0Kl7jgsfz7bfZ+m6QKDMRLMsh1SsjA=
Date: Tue, 3 Mar 2026 13:02:06 -0500
X-Gm-Features: AaiRm52z46R2MTHEwp_jAPjQPyeOX9E1sWhGXa_VACw1DpKpIFIELirzCA9Kqi8
Message-ID: <c17fda9f565e7e5b9ef2a19cc6716aed@mail.gmail.com>
Subject: RE: [PATCH v3] net/bnxt: fix clang wcomma warnings in ULP
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 dev@dpdk.org
Cc: Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000a84a94064c2280b2"
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

--000000000000a84a94064c2280b2
Content-Type: text/plain; charset="UTF-8"

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

-----Original Message-----
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Sent: Friday, February 27, 2026 3:00 PM
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com; Keegan Freyhof
<keegan.freyhof@broadcom.com>; stable@dpdk.org
Subject: [PATCH v3] net/bnxt: fix clang wcomma warnings in ULP

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Fix compile warnings seen when using clang with the -Wcomma flag in the
bnxt ULP driver code by replacing commas with semicolons.

Bugzilla ID: 1807
Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique
<Mohammad-Shuab.Siddique@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 38cb5c8b31..bc347de202 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -1296,10 +1296,10 @@ ulp_tf_global_cfg_update(struct bnxt *bp,
 	struct tf *tfp;

 	/* Initialize the params */
-	parms.dir = dir,
-	parms.type = type,
-	parms.offset = offset,
-	parms.config = (uint8_t *)&global_cfg,
+	parms.dir = dir;
+	parms.type = type;
+	parms.offset = offset;
+	parms.config = (uint8_t *)&global_cfg;
 	parms.config_sz_in_bytes = sizeof(global_cfg);

 	tfp = bnxt_ulp_bp_tfp_get(bp, BNXT_ULP_SESSION_TYPE_DEFAULT);
--
2.47.3

--000000000000a84a94064c2280b2
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
oIHHMC8GCSqGSIb3DQEJBDEiBCBezvSZ3fTpSSsVTyaPMB0UOKZpiz1kZaYp4X5LzaofpjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDMxODAyMTFaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCeZvirWUMy
n/pvZ232LTPc9Hv3Ki6U3v68LcTeTBVdKtG17Q1877N9KH1vEuda/19aPxl9A1EMcLF4pgpto+gs
P/hILcEZwHJ/dcUp+92iYjbpUjPRTKpBJcueUYoevnLJDvTI4lH/YaR6i0teQ8XEHsE37DKIX554
whvCK33qjfHt8iQZkfbYI2AYTLOg7G3+zSszpM5lfynuCnsZlcbTPM0qO9W89uz4qFLiKflIq5yl
PW60EOcVN2xK8tyPY6TtYqsa5Z8mmoSxBlB7Xq7ghvHGS3N6GFWGN9B8gNySd26U8+3x69M2zaK2
029r/INjBP0vwqW57q7InAwGgNhX
--000000000000a84a94064c2280b2--
