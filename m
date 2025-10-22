Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7ACCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FE87402D1;
	Wed, 22 Oct 2025 18:33:20 +0200 (CEST)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 0B708402CA
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:33:19 +0200 (CEST)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-430d0cad0deso21136735ab.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150798; x=1761755598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZDEXYgUi4qP3Z9f/Im3MKUsaSksPzGyOcO+OcxKKXwk=;
 b=NnHcOf3IEyXqPshbAGXKr+o2fsjwdp79rFW6V+IswtXFDZ44U4dWDdziq/lSfcmkq3
 rHuRxWi7bmneg7xHT0SAUIH11biyh3lSizVnVsI8Q4qBLDvdgLjFIxkQHoBIFHjAZjzq
 HildfSJANtq0JEja4N+L9lUkOoX13wfKFBOprs3u+ICrBIGX0AOEAqj9Xzpju6rKfeyM
 mS05psWa7b1b6JNzQ6spoSSpjUTpDfpLJh+aR5pMKv4zkOc0lI7u+7PFz3wVzUekjzPT
 GE6e3xC2vjMwGTVkna0BCpyDYFtamwJDT2yK9qzWd5Hz4gTkeekWjmFxF8mM1Mp7fimp
 juug==
X-Gm-Message-State: AOJu0Yzyzu850QCt92WAhEbFUW96nYByj7ri0yHHS2GbVJ9KowOPJ9zu
 V98aUpcroE4d1TihVeNqtE3a3LFZYnO+Vl9o77mP7ThEwgy8/fQkzPiWQLThATj+Oh+Xbj3LH3u
 3izqiDSYTZuo0pzIXdefLzcMylb/jMUHaUR8/11svu8+rd4scfiZn9Of2SljNjS2D3DBPlibBNQ
 jeE/A03XIrq6hRB6fBrZHU2ZzMzQMpOqujtqQ3ToVGMXAw7F5xBsWc7zuVENZQIw3msQDm
X-Gm-Gg: ASbGnct2RkxbIIB+Hr0VbMomkBURcyp/ErG/hhLalRzO472M5+59YpvmRKuvbN1zOnn
 YDeV0Zn+ao3h+6H+kmYlJ8PZmCOAL3/CBLcsiv+CNa/BiLuGm3Ze1pnRnVBFsfqA2k0O9xcfrmw
 bbAcKEtdNYlnPuG8A09XByTS8VHP0CJRDFgWOZsMocpsFxwR6ridrcuvnEzW9O8klaFvdsmsPQX
 3hrQEnz8YPywWMYvPkzf0XBKuOIZH1s1sV60L/IGdMNID3qwHXE2+x2+9XErmOSXjoRLNp7cKHU
 vyCz1/j/rTGBl4phi8qosWypZ34XDvWEAFKYUbjjJlgJ6KH2DZHuq+/1dVXmbw2le2ZDUZHGgzs
 DID+sH0kxYCG4QvUymeiZtI9U7X7PJXNM1OJnjeCtHh7HJ/It4eYhAzhovljHX1ufCuuFsmqgUM
 2ZO+U51uRAc/KZiVrvyYJ6gu7Ww6Ps+Evr
X-Google-Smtp-Source: AGHT+IE09xdKAJ45v2Rnw90LzTxjGbxI8ryndhkxEG/ZXgG/5NBMkUA9QyMfOpU0X1tt2nd11vBBOSXp9U4I
X-Received: by 2002:a05:6e02:1522:b0:42f:e334:5ec3 with SMTP id
 e9e14a558f8ab-430c527fc65mr272050715ab.26.1761150798140; 
 Wed, 22 Oct 2025 09:33:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5a8a95fee33sm1548005173.6.2025.10.22.09.33.17
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:33:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-375da0ef7f8so61437301fa.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761150796; x=1761755596; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDEXYgUi4qP3Z9f/Im3MKUsaSksPzGyOcO+OcxKKXwk=;
 b=HhFIfaMxCr+DmHaVciNZ0BE1xPODwu24JxDfil/oknHc40LOUWeOcZlD6hvShfuo1W
 VQYvWHvXKc+4pmbMGxnUDTxWUPpfjaWs7Ll8YLRzJArvYG8+PgcAatjmGaAChi+d2Gas
 Ub6b+26GC9mGUtLSe/Nf/hjIzHQraopUrN7tg=
X-Received: by 2002:a05:651c:25cb:20b0:378:d312:52c0 with SMTP id
 38308e7fff4ca-378d312536cmr1912581fa.5.1761150796245; 
 Wed, 22 Oct 2025 09:33:16 -0700 (PDT)
X-Received: by 2002:a05:651c:25cb:20b0:378:d312:52c0 with SMTP id
 38308e7fff4ca-378d312536cmr1912521fa.5.1761150795830; Wed, 22 Oct 2025
 09:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Wed, 22 Oct 2025 09:32:58 -0700
X-Gm-Features: AS18NWDxRRM1gXfR3N_pq_i0RVnXwFEwJEu9eDhA6M9y1chbIH3lU_SOoQc6V90
Message-ID: <CAP1Q3XQp=fSDqrE-x6qTPhnm66Yoeiaq4skBbq2z_QaG4CaOmA@mail.gmail.com>
Subject: Re: [PATCH] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000a11e720641c1df88"
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

--000000000000a11e720641c1df88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:59=E2=80=AFAM Amiya Ranjan Mohakud
<amiyaranjan.mohakud@gmail.com> wrote:
>
> +    /* Disabling RSS for single queue pair */
> +    if (dev->data->nb_rx_queues =3D=3D 1) {
> +        dev->data->dev_conf.rxmode.mq_mode =3D ETH_MQ_RX_NONE;
> +        PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
> +    }
> +

Can you check if mq_mode had RSS enabled? Otherwise, this will always
LOG as WARN for application using single rx queue.

Thanks,
Ronak

--000000000000a11e720641c1df88
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
EFpmxF3Rbc3gEgIcYiyGcyQoDOx5qoyhCDJDMos7kJc5sKcmBxmD93r4vMUtJzAYKbw3V9i1+1bl
lU/0K+6NNVxX2NU3cAsWlrr1Z9FVCgVD2Gm+oTVKKP9PQiyTCKV/ia4jllLAe5D9qx48/l/Ud3or
C9S060BkjtpoTwUlvEvqW7cYpiQHZ5h6Sn8kfDhhrvjlnhlTWFOaYFeTgXONpRmP9fzrWGCp65Um
HNA22CDDA8JphKLM4yZvV/f0YIhuQFq5MlUCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYcm9uYWsuZG9zaGlAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBS/+YQAXlGnSY3OTXZjaWa0ffwL0jAN
BgkqhkiG9w0BAQsFAAOCAgEACNahijglDMUpQxxcZSN28atG9fHRNjXoYsFmQ4eeq+iHAAnrBr+S
lJ3jFCMTulB2hl2y8JilwFq1OvME984wBHpl8GazNOQUyIrqqVP+3uikZoamMq0zTrxP/JjBWjT6
P/wQ2ZjCtXqooVZGW/PfNw8Rixa92nsMpGPrqmlFp7icvIfKqwDcDeFfb/8qGlozS5c49hTFMBAo
zrwMLg73Yd+OGfH5k9vitxsyxvb1CbIgIRFsJTSG9nYH9PGyDPOKIiq/JFX9Ve7c98Mu7iOS+lYT
w7xhFUofzTiXoELyZZ+jCUCdKaAmhVux05XaxUqFAYIfSgrEuO1/wwT4NGF5LD88AUxyvlAMJtUP
q+am3jh5Kqi3ZJ0S4+z9htCfU7IHfMxPnrgfKfrRNpHjHaCy5k2tojE9yT/RxPNTpZXrT0DKa+BE
as+PYqVbMlvaYivqIJoSZUZdp73yg7rJIrIXsifxWtsqFvMoc6TZCXmBeG1VOMuP7cXd/iXMmi44
ZDaQJjvEk4ezmFzcPZIE8/wbix3HYa74UV4JQ54GJ9cs6AOkIkPqN20zfEEcBmrRlRzF0pzeufjF
noRv/QScVrdKXl2dBdaRTImZVWwTPxszU3xDr7WvHeXQhGSwICMc6V0cgVLxH+31O+aw/FeL1b9h
emZAui9pdgbotf7AX8L+Nr8xggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
AgwB0kttp9h82mCA8UMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFggCYW23mcU
lSfD5ErnAV2nevvRuVhjKZUNAm7k9djpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI1MTAyMjE2MzMxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHjlwv3FuFbwLCUFYPCIyjAXQfX6P69V9jpgr/+4dPwjFxBV
KuiEg2DK4m7y+IMWsobXzFUyxhTnoIx69/VuM7506nc5UfMFV6H5BzFoWl+wVeUOTSMLYj16VBYr
qegUIQfvaFaajUkzwJBG9Kd+zceqiuL0xNay0U7TJ4MBPs1Z4SS5UJOYFogacsydO80Vt2a38+K7
ZRSLLfrh0vpi+nsWRL5bWg5w8RWWd64ZtQQMvsI/rndwEj1Sd6BkopUdkb779SoNd+RzccTT/rGl
b2xMVoCWUwO2KbwRrB5B1Et3W3rx5EVFWg8SCd0Tam9G7b8+YXMEBQl+zQvdmNFu32o=
--000000000000a11e720641c1df88--
