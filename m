Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25FC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 480B3406BB;
	Thu, 27 Mar 2025 17:09:26 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 1C37640654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:09:25 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6e8f94c2698so6276756d6.0
 for <dev@dpdk.org>; Thu, 27 Mar 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1743091764; x=1743696564; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JRiDuRgcClsJ9AY6lOMLh91Z0ibQL4H86u0ymUTCDZU=;
 b=X2mDJsevK6fe45LfJr40kuXmCrworYIUGHJogOIlwVXpF85dcMp+QoYLt+VEMn+qLq
 aCEx2zVDunjV7/GeDGxVGm0x/FwQRFSkdch+LBJDWB8l67i8J8gZcB6R1bX2UtuEQEQu
 es3SREJe+Kqb9tD2QMV+jiTeRMK7Xooo4VoCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743091764; x=1743696564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRiDuRgcClsJ9AY6lOMLh91Z0ibQL4H86u0ymUTCDZU=;
 b=i+kG/Bg8ayN+zsQjOQ1PbX7xn7YVmDKaZLgpK36ljm6IpbJJiXoWA2cmGtqw9bg5eu
 sWcJvBJDmVuzE2P/CnMz7VY+FaRM8K3VsdfhCsJ9VdDjmmip/YgQSA4dDXQoyAOwTJOK
 DqwXQqZgM9JDYjjsuoFVDIBhRtSJ6Yl04ese9C9DL+YCenA6xoV1ELVPHuz5OIvP5l9w
 uJcJX3na5IlRbZTd2cDhmydFun11ZQBqkEuTYw1wg+eukh0d9B+X5yctUFySObWM0xFx
 qMlx3vPBFGCuOXxeN2MgV12E/QvBzHHRnE7wgUKYxjqWegI89NDR6gOgq5/E20O4HHFK
 qayw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2UhQ58kEE55TTgovAEZhBpsOlZwBJTq3oGayG5HCkSxqgkSdkc4LzFrnRmLLBtffEpn4=@dpdk.org
X-Gm-Message-State: AOJu0Yxxz4QZn6KexSCRyecFaP/HdTjyI/aFHuEGBbGpZ0nXxXDDNz6X
 dbE2ZwsetuEr+q+88amopotEcEtKeHV4tQdLsWEvpGnn1QVj6RVVojm7N0qtyPbWvmX3K5/wwtm
 k6a5XiB8mb9yg3mxuaQOefrDk/FSkhgdYgtTt
X-Gm-Gg: ASbGncvkxpS+enE7Q/7Uc21cb04LLB9j8ODrh4yCdlEe1j63x17bHpTMz/1NOwfN7C7
 WCZLdbWNO8HaXV0KcntYqE+bEZYB76wR5jfixQNyxgwSeFp9uOUFji9u+fibIcLV4iGcAd72PB3
 hxmaMnMDQWtgbXu/5fyP0o4+P1J/A=
X-Google-Smtp-Source: AGHT+IHCqiUT4rcTf7y5+THiYXs4rVoRIivRjz5pCT1WdcmXYWDiUur79GSxfYUfTrEJhyqXly3dzfOC1a58ZiICPeQ=
X-Received: by 2002:ad4:5bae:0:b0:6e8:9e9c:d212 with SMTP id
 6a1803df08f44-6ed236eae21mr58572706d6.0.1743091764136; Thu, 27 Mar 2025
 09:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFFPToi31bmGM76Uuiy0VAOsH=5YM6z0x1UH9EyyPGM-CF4tw@mail.gmail.com>
 <20250110100425.598c939c@hermes.local>
 <CAOFFPTrA3fu7kxBcdwMPJvLjeNeSurms+dsXXK5Cg4gogfwa8w@mail.gmail.com>
In-Reply-To: <CAOFFPTrA3fu7kxBcdwMPJvLjeNeSurms+dsXXK5Cg4gogfwa8w@mail.gmail.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Thu, 27 Mar 2025 09:09:08 -0700
X-Gm-Features: AQ5f1Jptf1tRf_uekYLPkLSuEX40_I0Jm7bsvrpfuln-9TkEQBsBKpm-jj-IQi4
Message-ID: <CACZ4nhv1VL=GMX+ofj1mMEs2t1F7KkwgnCQsWNJXWQ5ErT8NZw@mail.gmail.com>
Subject: Re: Driver: bnxt_en
To: Eldho Paul Mathew <eldho789@gmail.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000729ede0631552dd9"
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

--000000000000729ede0631552dd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 6:49=E2=80=AFAM Eldho Paul Mathew <eldho789@gmail.c=
om> wrote:
>
> Hi All,
>
> What is the importance of the 'ice' driver?
>
> Right now I am using 18.05.1. Does it have 'ice' driver support?
>
> We bought a new card: BCM57508 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb/200G=
b Ethernet
>
> To support this card using the 'ice' driver, is the DPDK 18.05.1 version =
sufficient, or is there any other driver that is the placeholder for 'ice' =
in 18.05.1?
>
> If I need to go for an upgrade, which is the minimum version to support t=
his card by 'ice'?
ice driver will not work with the card you have listed. It is for an Intel =
NIC.
Support for BCM5708 was added in 2019 in the Broadcom bnxt PMD.
You can either use the 19.11 - an LTS version. But that is not
maintained anymore.
You can use the 22.11 release which is still maintained. Refer to the
DPDK roadmap
for EOL releases.
https://core.dpdk.org/roadmap/

Thanks
Ajit

>
> Kindly help!
>
>
>
> On Fri, Jan 10, 2025 at 11:34=E2=80=AFPM Stephen Hemminger <stephen@netwo=
rkplumber.org> wrote:
>>
>> On Fri, 10 Jan 2025 10:02:48 +0530
>> Eldho Paul Mathew <eldho789@gmail.com> wrote:
>>
>> > We are using DPDK 18.05.1
>> >
>> > We received a new network card.
>> >
>> > Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Eth=
ernet
>> > Controller
>> >
>> > DPDK 18.05.1 has support for this card and driver bnxt_en?
>> >
>> > If not, which stable version onwards has this driver support added?
>>
>> Release 18.05 is not a stable LTS version.
>>
>> Let me teach you how to look this question up.
>>
>> To look up device you need the actual PCI-ID, using pcilookup.com
>>         14e4:16d7
>>
>> Look at source of drivers/net/bnxt/bnxt_ethdev.c for the pci table bnxt_=
id_pci_map.
>> The entry for 16d7 is
>>         #define BROADCOM_DEV_ID_57414           0x16d7
>>
>> Using git blame find the commit that added that:
>>
>> $ git blame drivers/net/bnxt/bnxt_ethdev.c | grep BROADCOM_DEV_ID_57414
>> 3fab7694403 (Ajit Khaparde                   2017-04-26 14:20:02 -0500  =
 51)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_VF) =
},
>> 1f4a84672ec (Ajit Khaparde                   2017-01-06 13:55:17 -0600  =
 60)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414) },
>> 1f4a84672ec (Ajit Khaparde                   2017-01-06 13:55:17 -0600  =
 68)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_MF) =
},
>> 3f6d59b0c88 (Kalesh AP                       2019-12-02 09:48:07 +0530 4=
999)    case BROADCOM_DEV_ID_57414_VF:
>>
>> So we want 1f4a84672ec
>>
>> If you look at that commit with a tool like gitk it shows it happened wa=
y back in 17.02
>> And the card is listed in driver for 18.11
>>

--000000000000729ede0631552dd9
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
u50xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFoP3VT42hPQWKvL6eGq
uSmxiyEvGi6rvDmTcDIsh0V7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDMyNzE2MDkyNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAJmE9MYnCsHwPWxbDJVH+zg7rQWYPQZi4MZDwfmd+VSivpeJY33yiaUq
Zk57zjjXpYXHp83XOHknSxS9Vz/iEPrk2RiMPCbkxVOzEgrHAjgyW+9Giv8asGaPJer6GjCDB3Zk
zAtnfWlP8qh5JKdrKjlhTNBUYAHBx3b+TvSEOpo+I9BhZEAImTy5hDBKO+tp2NpHSX70z8OtzkpN
6NSzKtvyKwvLeMW1dJS62AmMLy4VeaLtfrZnz8avJPkNzTWIy1PMTD9bOXgObsivC8eEXn480WkC
narf4HkP0JXQ+UFxgOX41xOum17BrCfhubObg0U0yUKn+4dW2CRykXoER8U=
--000000000000729ede0631552dd9--
