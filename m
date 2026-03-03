Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB6EB362F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 18:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AD6740268;
	Tue,  3 Mar 2026 19:04:50 +0100 (CET)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 60F9140268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 19:04:49 +0100 (CET)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-899fb030812so32828896d6.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561089; x=1773165889;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W70b5aSz0/nBNwLYfmcEEsZbBzaqz+6T6MZ0qlmQ3ac=;
 b=EdaK0bmdHHXvdi+vFizMV3OfbvmhsAIopxgDInh8zaizjtfY3Y0IbLG05LVHlYUB9y
 818ax4uC6Dh61KUL7Yrb0ubClZtf7DPIW3kXwiHC9o0vvLbhmN/SuOZDJCpD+M0h5nRg
 IgiIz79MSyfDCa4OdyLqnJVWkl1cYm/h3ebo9HqHaQ5fqQ/cIqAniLfQ0JFy1G/6XH+o
 3KP0zlNqIPeXnFKkO+h1vQStw82d/e5KmNKm2da/C8AgQAJD/lXTaKVOiI2YtYUY42mV
 Fq4cYDDNvvKRpftk5ZIN24vByFdtnlEYdPTibisXICzurjufvYKBfMSu3Loqk6MYMUFo
 k26A==
X-Forwarded-Encrypted: i=2;
 AJvYcCUXNXohXYtIHutsvBHQMsOok8uQEnTImsl0ukX2iSDUe6TvsldC5wHmECdgxccG9Jelb1Y=@dpdk.org
X-Gm-Message-State: AOJu0YwWb+GAaSn82G+BUqNagTE0NosERDWJEIEq4j/c6/HpUKz3LG6A
 +3rQgKlT3iGD3wK3B9hXBQxQRnmAEyZVt1AEw0wMym8VYcOz0BLJ1HQg4IuN/BVeaWWUOsEHCpA
 E4MQPBfqP9TqVpsStTTXEwjs+9tjgta7oPke2qpGTlwJ/r6ofQYFMWas837RZDVYu3AvvToy7mS
 mYL4VH26DF2tNd7nWHCGECTqEPd/+fojEkrgCm8qL7I4hoXkpoOrRHNCmOk5UM0hcgp146IRvFt
 nishA==
X-Gm-Gg: ATEYQzyjsCZtoOo5bYSiDocSjKVDeflkvMsI30ngHarMx3dBQIXyuxI77uimEMOqWlb
 tE4EArA6oHzA6mbwfWYV+rxnJUNrBSmm0vijuTc4QieysDVACZis449H6gZyAqp4PilChtINB+x
 0fP+jB5nFGgH26m+Mw4UpRgNAiPr3w/AeES8HuCZJJTkIUcnT0d8SnLtdVcfSleeq40R3lB2HuV
 TGv+eOJkKOht8pQeWObhH0985wU8XHsCZK/5etBhFLvrhkfxggRjAkgGoChc9WphL3/Lwx3ivcn
 bJhO2P1XpQfRYNY8qWdBRrPU1ID37yufBLX7efZcz6cmDv+5wWKuDjwGhQY8BdKA/zOfz8Hf0Me
 omU5cFM5GpMKtXpVJtQSwA4DRr8xn2PtZr221wJ8Tur680COj0xs45XLEpEC3qmgmlzuKCQ0LKK
 UvXijvXLvzckG/nYHMcSIHkvxs72oWbcstru6FH2YFYK1tjDTbXAZpChyn3lL3mwqshIc=
X-Received: by 2002:a05:6214:5013:b0:89a:116b:e67c with SMTP id
 6a1803df08f44-89a116bf2a6mr28012906d6.45.1772561088327; 
 Tue, 03 Mar 2026 10:04:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-5074e4d1418sm20339211cf.0.2026.03.03.10.04.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:04:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-660a2f72c01so1040627a12.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561087; cv=none;
 d=google.com; s=arc-20240605;
 b=f2Wl0u5+MhxajrRXZsVVjZDwqUonYXVgGsKRTAMOICkNGg1IBCInJvlxjMqxXYTQ2t
 wqfjjRUx1i2P2i4intgHj3JdK313hoFM3k4C9Qnc/l7ed7CicQvxGiHHVqLs95fREZ7w
 zoJ3hZR6R4Cvn7bvtHKnhtO1kw+82A8UhxWMrIbBcJX53+hBppGgXXeDUmse/e54TR47
 gHx3VV+GF1NyQVJ/di39ULUlt8QM3zmv2DA/trSXHIEMFRvk/g/ZJcX4VTGiUZPqxsKL
 1CMuKiuxmouy01SP8AE/fRJCr4y5gSV6nSY+BMKqWRVL+TCKfj1zhDBdvRarv1ZrTqty
 uLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature;
 bh=W70b5aSz0/nBNwLYfmcEEsZbBzaqz+6T6MZ0qlmQ3ac=;
 fh=iT8uAPCOV0jhViw9/XjEENs4o6sfsAmZpf++6pX78sI=;
 b=BYHV79hjOymZ8x/H3B/DQ2o6eaO5YuZZmjaRDLR05+O997aGHny501S09lxlNlHvSR
 yjarntPUagTdscVIGnIRw3TCvOlwmonTvphAkbaibqza1+gk5lcuao0ztcihFEtBQbYA
 BR+ONpTHLANjEjR43UDWEmkg5zvn/7y6hFhNL9zJf0KBLaFgutw0HPkSZKgB472Pr8TA
 dl06jnc8JaIUrk9kaLZFOYwxbd8TJnvu39WO9NiAn9pJHBxaFLsbNDlwbB6JIMm85/LP
 Ozty3Oa9xbMKk67eTpL+2n+pNtcR9UB3YtwN0lKe/Nn6ww8qlWjoIBD8xKsFM+UGw6GE
 HfHA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772561087; x=1773165887; darn=dpdk.org;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W70b5aSz0/nBNwLYfmcEEsZbBzaqz+6T6MZ0qlmQ3ac=;
 b=cVDMeaLzcYEOegMBs+pu6r0i0CDMonAbr20xA2qVuMEMo/AniZloz7YMEcl4BNK+v3
 +L5GkXxn55O8ZBDF1Ho6RC2Po1znpKNJuYotyBiTjjGPRiE0V9lCnGB0jrBt0LX8QQQq
 uCYZM3PHcOX3sR2WAZyn7sNkt0/raKCpJn7Q8=
X-Forwarded-Encrypted: i=1;
 AJvYcCXnC/OHlu83TVs7L2ITRVgEXazOOiqTeYDQ/v0t+94iL/X6xmKaMznxrMJIUlEAEX3UZEE=@dpdk.org
X-Received: by 2002:a05:6402:270e:b0:65a:507b:c7bd with SMTP id
 4fb4d7f45d1cf-65fddceeb96mr10449181a12.26.1772561086660; 
 Tue, 03 Mar 2026 10:04:46 -0800 (PST)
X-Received: by 2002:a05:6402:270e:b0:65a:507b:c7bd with SMTP id
 4fb4d7f45d1cf-65fddceeb96mr10449158a12.26.1772561086181; Tue, 03 Mar 2026
 10:04:46 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260227202042.71404-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260227202042.71404-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHgLdtHSxwFvtxZe6yO6IdLohDdzbWWFK7g
Date: Tue, 3 Mar 2026 13:04:42 -0500
X-Gm-Features: AaiRm52b9Dp1C1XH-DkfuSMis89zt7w4nUmrA91oNSbREQfAQbd_F3GhFcz3SkA
Message-ID: <6ec6e43a646c4ae0c22ac3330d4c346b@mail.gmail.com>
Subject: RE: [PATCH] net/bnxt: fix reported VLAN stripped flag for Thor 2
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 dev@dpdk.org
Cc: Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ef88d3064c22894a"
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

--000000000000ef88d3064c22894a
Content-Type: text/plain; charset="UTF-8"

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

-----Original Message-----
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Sent: Friday, February 27, 2026 3:20 PM
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com; Keegan Freyhof
<keegan.freyhof@broadcom.com>; stable@dpdk.org; Mohammad Shuab Siddique
<mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: fix reported VLAN stripped flag for Thor 2

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Modified the way that the scalar path reports VLAN TCI and the
RTE_MBUF_F_RX_VLAN_STRIPPED flag.

Bugzilla ID: 1868
Fixes: 65d2b0557ba3 ("net/bnxt: support Rx completion v3")
Fixes: daa02b5cddbb ("mbuf: add namespace to offload flags")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique
<mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 3 ++-
 drivers/net/bnxt/bnxt_rxr.h | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index c94abefa01..eb01132f48 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1115,6 +1115,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	uint16_t cmp_type;
 	uint32_t vfr_flag = 0, mark_id = 0;
 	struct bnxt *bp = rxq->bp;
+	struct bnxt_vnic_info *vnic = rxq->vnic;

 	rxcmp = (struct rx_pkt_cmpl *)
 	    &cpr->cp_desc_ring[cp_cons];
@@ -1198,7 +1199,7 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	if (cmp_type == CMPL_BASE_TYPE_RX_L2_V3) {
 		bnxt_parse_csum_v3(mbuf, rxcmp1);
 		bnxt_parse_pkt_type_v3(mbuf, rxcmp, rxcmp1);
-		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1);
+		bnxt_rx_vlan_v3(mbuf, rxcmp, rxcmp1, vnic->vlan_strip);
 		if (BNXT_TRUFLOW_EN(bp))
 			mark_id = bnxt_ulp_set_mark_in_mbuf_v3(rxq->bp,
rxcmp1,
 							       mbuf,
&vfr_flag);
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index 7357ca4427..f6d1e3ddfb 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -474,11 +474,14 @@ bnxt_parse_pkt_type_v2(struct rte_mbuf *mbuf,

 static inline void bnxt_rx_vlan_v3(struct rte_mbuf *mbuf,
 	struct rx_pkt_cmpl *rxcmp,
-	struct rx_pkt_cmpl_hi *rxcmp1)
+	struct rx_pkt_cmpl_hi *rxcmp1,
+	bool stripped)
 {
 	if (RX_CMP_V3_VLAN_VALID(rxcmp)) {
 		mbuf->vlan_tci = RX_CMP_V3_METADATA0_VID(rxcmp1);
-		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN |
RTE_MBUF_F_RX_VLAN_STRIPPED;
+		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN;
+		if (stripped)
+			mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
 }

--
2.47.3

--000000000000ef88d3064c22894a
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
oIHHMC8GCSqGSIb3DQEJBDEiBCAle5uT3eYkdoqfrTItQlbcgy9FIiUAK4XGfrWlcqDaDzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDMxODA0NDdaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAGpPDSK+Oh
wAM68ZRSWj5ABzQdGriVGiMQOgtrS2UdxUqXuEPwFTN/nwC8Ozy3aWh6p9DnjpHXdMGoB5OO2fR4
8jWii0+zVTH20w/yTKjBBEnTjVgXSB2opZt/eLmn5Btk4rEUAZq3iGc7aPjzMJEKPrV84J6GSTwA
0nWvYOAyDWUFwTw+C8N65GWRKu0cKc8WB+7SMu2gzATZrqaMUpp/BelqZVqwujvPVevuIBrrsQsA
VG8qvSfbadPXh9tRdAXKfXDvU++OshFTsjy7hBGZK5T4C1z3jfbCQd0eDk3xJ+xj2M6SSzFDlHiY
GMZIhA2IbbrOJ/gRER1Hm9CZPFs3
--000000000000ef88d3064c22894a--
