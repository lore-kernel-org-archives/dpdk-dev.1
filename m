Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D0C282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 17:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF16740281;
	Mon,  3 Mar 2025 18:04:22 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id F18D840280
 for <dev@dpdk.org>; Mon,  3 Mar 2025 18:04:20 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c08f9d0ef3so256281885a.2
 for <dev@dpdk.org>; Mon, 03 Mar 2025 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741021460; x=1741626260; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dAaBSZXLuuI9xOw+Vy3m15AEi1mNl/DMP7iBP/q6Cis=;
 b=LoM0vI38OVuhTUPvL8OiBpDqMCJcMHUCHuKAGfjIUc/NlWmy1rYhnditaCLrj+eC/A
 QdcOBDClCEomeJ0pke5PhGnPgCrH1qT06fTdx1CGRLMLnJ1wZF338KDtmcPew66n9ZtU
 X1f8OIDNqYWPurRQTYcGtf2ML4amqewjIlsFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021460; x=1741626260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dAaBSZXLuuI9xOw+Vy3m15AEi1mNl/DMP7iBP/q6Cis=;
 b=CuGsen/TxDOyuT7B7D5scQw9CLRvhXCHxugRx+939EfUxtNRf4LPzYMmumCDrhful1
 Ix9RY1+ONps0rhSGFlO/Em7zxTBYtZiMCpglwifiDY4Kcn69iK8k8lCYxEvYWvt1KjL3
 gB/KjXd6X+zdgH7xLhOCRjFkBs5zQ9UQhcjw+OAzif+hA8rFoYuO1QQsqF6GL85v1NBg
 Q+h45N6CU3bqDZzioE0XzVb1OmW/RVoCw8DtOMBSHI941Wq7uohaoWXe973hjuK3hmxU
 8GIE0HtHamUn7OOVIUx4CmhlHPAfXyY+qU7Iv9a+pCfFeesX0BzEhDgm42AsoKq2BOur
 WSDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNQvZ1lFrqdek7ex08j9Heqhr8gKg+FfjEMbLgS+5PEBoqGMcPUYsyXhyffNeRuTN73o=@dpdk.org
X-Gm-Message-State: AOJu0YxTFKjWFvQFdGUv/odYWeD8DvimJAIXp4eVzKBinrMBSSSNChkV
 w+8ukP2EEboh8jqmMpLJ2BlD/EhoIDODcLNOJslcp7LCWyH1Lqu0kxzK5zuYNCFYewZFcAO9eUC
 ZwWYYZV4OBhiTBe5UrZJ+E++Dkh41sy49pBIc
X-Gm-Gg: ASbGncs67xeDWK3FhwkFIGfvYV7c1JYcYo/YNnC6OiNeHK660mRqJ7rXEcNy1U/vmN4
 12sUIiRZcASmXgct61B4vM2LkYF0LzAxO3eQEUuPTN7Xc5UppSyVRjiB/urvT8YaGqoRCQtpvI7
 SOgbT+offdxuvI1eu0awwzGnOApLw=
X-Google-Smtp-Source: AGHT+IG/D/qCBOh8jKaLxoLJpSeKss+dv5mOfafEzFutuVPOt4aSEjuO78RFGFECjYsqeutIBxncFkEXABV3orwOC9U=
X-Received: by 2002:a05:620a:1726:b0:7c0:a667:6c16 with SMTP id
 af79cd13be357-7c39c4a1bf6mr2526410185a.8.1741021460299; Mon, 03 Mar 2025
 09:04:20 -0800 (PST)
MIME-Version: 1.0
References: <b62e330e086126415f7b4987a9747ce2@mail.gmail.com>
In-Reply-To: <b62e330e086126415f7b4987a9747ce2@mail.gmail.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Mon, 3 Mar 2025 09:04:03 -0800
X-Gm-Features: AQ5f1JqM2ZxhrmWO6sCj7HuBKIFTHpJDAUo7q2Ke9U3F0Y-x44erlVgmqzPyFPA
Message-ID: <CACZ4nhuSCiD6gNzF2GFXVoAD__f0oOgu8fXCwRYy6UGMDy3atQ@mail.gmail.com>
Subject: Re: MPLS Push action
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Ferruh.yigit@xilinx.com, qi.z.zhang@intel.com, dev@dpdk.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b46413062f732520"
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

--000000000000b46413062f732520
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Thomas Monjalon

On Mon, Mar 3, 2025 at 8:02=E2=80=AFAM Kishore Padmanabha
<kishore.padmanabha@broadcom.com> wrote:
>
> Hi,
>
>
>
> Anyone has any inputs on this. Or should I add new CLI commands in testpm=
d to support action for push MPLS tag.
>
>
>
> Thanks,
>
> Kishore
>
>
>
>
>
> From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Sent: Thursday, February 27, 2025 6:35 PM
> To: 'dev@dpdk.org' <dev@dpdk.org>
> Subject: MPLS Push action
>
>
>
> Hi,
>
>
>
> When MPLS push action is used, using testpmd action  of_push_mpls, it acc=
epts the ethertype only. How do I specify the MPLS label and other fields f=
or the MPLS header to be added ? In the doc, in section 7.2.3.7 there is me=
ntion of OFXPMT_OFB_MPLS_LABEL and other MPLS fields, but I could not find =
that in dpdk implementation.
>
>
>
> Thanks,
>
> Kishore
>
>

--000000000000b46413062f732520
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pZEyqKnwS1lKCzjX7mV5W955rFsFxChdAKfw0HilwtqdY24mhy62+GeaEkD0gYIj1tCmw9gnQToc
K+0s7xEunfR9pBrzmOwS3OQbcP0nJ8SmQ8R+reroH6LYuFpaqK1rgQIDAQABo4IB2zCCAdcwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAlBgNVHREEHjAcgRphaml0LmtoYXBhcmRlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUbrcTuh0mr2qP
xYdtyDgFeRIiE/gwDQYJKoZIhvcNAQELBQADggEBALrc1TljKrDhXicOaZlzIQyqOEkKAZ324i8X
OwzA0n2EcPGmMZvgARurvanSLD3mLeeuyq1feCcjfGM1CJFh4+EY7EkbFbpVPOIdstSBhbnAJnOl
aC/q0wTndKoC/xXBhXOZB8YL/Zq4ZclQLMUO6xi/fFRyHviI5/IrosdrpniXFJ9ukJoOXtvdrEF+
KlMYg/Deg9xo3wddCqQIsztHSkR4XaANdn+dbLRQpctZ13BY1lim4uz5bYn3M0IxyZWkQ1JuPHCK
aRJv0SfR88PoI4RB7NCEHqFwARTj1KvFPQi8pK/YISFydZYbZrxQdyWDidqm4wSuJfpE6i0cWvCd
u50xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGZeF+w+/tYkyXm+z2uh
Ha5j80tP+o5ufe5nz9rqD1w1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDMwMzE3MDQyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBEVn1Kc7WYzRbNHMesMjKZcBHSL6/BOZvuhMR7
A3J0Ss3x6lP5RWTubhuvMzRrqcXd6pK8BEU0+Jyhtth2NczhA8wMhGPtat40UHlL21HpwN6x1LOg
tHxuAPZAbYdGKYLSzCwWhyAuTm/IFX9mKbR0Ds1kCK6SmWyqSdCiBCH5lRiSuTFfFsuUYhETFdhJ
j+PZR6vamhzysl7H36YZTTK9h9S95uEzbT68zMHaS95hmo9ioB7SCqUcIyzD4FJ5z5Epc27ZL4g6
nujI76Zkiy6bS9r7yzLWDJtYBYikq0/dlqdEkOQGEZNlhGTC2Swz0JmgowC08d6p17ooYC0mydWl
--000000000000b46413062f732520--
