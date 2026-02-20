Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C2BC5ACAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 16:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 731CC4027B;
	Fri, 20 Feb 2026 17:01:52 +0100 (CET)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id D14754026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 17:01:51 +0100 (CET)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2a91215c158so15296765ad.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 08:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771603311; x=1772208111;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EelobDUPmPbh50n7/Q+WLgPuAVpeIDWQcPX5eKVyYak=;
 b=XnOI9ZGjDAf1DNfJlfuurxVZ1k0p2E3Bjpc9JYW87fP/a9r3nPU6fbC9aCsZpSFCzZ
 dZGZwrjVr/rrspBNZE0s1yW6L6NYwgftuwuhBx4E0D4zZ2tjc223TZWZ8qpkgbFclcNz
 HkNMsfbWpqwLPOFSBVe2B0FXBhB7TNXq2Hd2JSWMT5UvHS9XOeIyiLhW1/FdPnd5WXMQ
 0g4+EmaUDEk4g0OrMEIaFsI/Zva0lrC4JXPHKI6fu1xpy9kr55kjJSb9rG55StA3MKLO
 6n6YJSmmt1wrTvyzIixHiz2P+V7G7XQhODo7ejrnzmnEuKhCIjNUayQIKkXEvq1umdmu
 +qpw==
X-Forwarded-Encrypted: i=2;
 AJvYcCWMkg1niyGYR9Lcb9krk41JCX/I08w0eubKA5itmCoYiS7DKnMu9+MH0EBfiGg+ogYOr1I=@dpdk.org
X-Gm-Message-State: AOJu0Yw3yLBHZHDdikTxARXxcOLL4/oq8X+1epCklR/75sayjkSRKcDT
 eBdvIh4XpEgeUfoitWl2JJoAuyE6m0iXjAiZJy2B0Gy4wJYCBbj2/EPZnum5crHRC9rSSQI+EW/
 gHsFA/BiEPa3Pzd4K9ZXwE5c1HAPhMGFLk6bz2Nzj2g87s7NBrvEY7h4wXH5aKzR2sI6fGNZZ8R
 mbjU8qpqvswU7ybl4biEI6uyPdhzSGd40HXSscNFp6kPDGnW+lnxfbohGWDA3R/RAX0qf96FDAc
 XSH1w==
X-Gm-Gg: AZuq6aKTele2477XUBPnsJc9t01mxy4NHlViSsWwDzRP3kCmmUameMs8PBCemAeB45u
 u31ntXez1uwwS8WH5MsP01ZXboILYs6Zr9kgSYw7u1WlUkQG1Lv385QZlbq9szyzynph1jeLezv
 NCvMkKaZ3nlTxz4/pDzOoTOi1cjtjTPmojjvxpUBpLSP8gavgD5p0A19EbSXUNK7L5FxDSOS3RK
 XZ6HvaJi91jpE9rVyqKP1+cJ6PRi7f4dxJ05h6RBWBEbn0KQJoZivORtkv8ImB93InsDh4yNPow
 XpIw9DiMyprVtzjf9RH1MQwepH8mgOr4GCnZwWJyojUlvcOl5QEIUGyDRDuul2WaN0SZMfjydEn
 1UyeD/5V8gWND5WBuj+nKX3TyshZUl+6oIrtTqRIXMNJSIhYF4LIv2aKGU6XOt2OPKbHEToWLQP
 6Nqsah62iqpZuJpTIQumXYGmDl+dKyr1NK1IcrIdeCkNLZ6m7gP+acncr+Rd589nmrSQI=
X-Received: by 2002:a17:903:2a83:b0:2a9:5c0b:e5dc with SMTP id
 d9443c01a7336-2ad745698cfmr190815ad.54.1771603308663; 
 Fri, 20 Feb 2026 08:01:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ad1a6e6a59sm25947385ad.11.2026.02.20.08.01.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Feb 2026 08:01:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6581a45f30eso2208841a12.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 08:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603305; cv=none;
 d=google.com; s=arc-20240605;
 b=YCtKFsnMPBG/vQGBZZptmjUr1G4bKk1xX+nDXsD8UBCBq8H2KtItd6uuQbtD4KtMLd
 L1JpoRa7dezpcNeLsRravCLt4I7KiYcQwocRtYRYJ3V6v7MTQHmZLNi0/a2+q6PAFWAY
 iKne66PLhssJc4O2g5eUnTQGAZl4Zcn9dy+N/knyJt17PId3ozCaBQYX895zXFuOhCUi
 XbTLlV3f+fk9XeOjAwaJORslEm0/2ICLeXD2OIBDLD2+614I/RbtMG207LJQwRnknrEd
 5/1U+NgG5Hc4m/bbPh/9sMSW90J0B75g8tN41HuqWpPisIidvHDhWvMLW3oxUkq132A6
 E3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:dkim-signature;
 bh=EelobDUPmPbh50n7/Q+WLgPuAVpeIDWQcPX5eKVyYak=;
 fh=KN9AS/oGZiRNtAiEwSuD8TiUXtsUfUl48tGxQaIJIoE=;
 b=SmoUD0iWRy0SbVFBENNDvAK2KrIBRN+gH5DyENfda0ByA8fdbiMwKnt18Wlk7Ls/Da
 xklYapt1HzkUFoYAk8NmHWh5IfKlnaao+JG+6WlZ27dCmPZf4mz3I1QiuS1wz0LloKAc
 Q6J48aMSi4z1elfEBNsLLVTe6qw2VISgj2ZBBi+E6L1F1qk3I4EgZ7Hf0rMJvgi+obVr
 KXn/lmqkuKy08/t53uF6wxPtfuBmk+ntpbH/cV+hZWNXHIQt4Fc+oJjowcsJarNKGIUl
 kRPWLF4qtZNf+V7OUxhfYBFOGy3UzbkZQsHUCFVh3btr5Q6eP7ZG2b/1IauLEDNTAyKj
 qLLA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1771603305; x=1772208105; darn=dpdk.org;
 h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
 :references:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EelobDUPmPbh50n7/Q+WLgPuAVpeIDWQcPX5eKVyYak=;
 b=OZte1nviPGxvOHiMwv+w6EBghoYw7Hp3jJsnWW+YifV1V2fyEeS4PNW9LIejdsoT3S
 79T1wmu5M3p5anWDoWm4557fK0F+Bss9iVegqtSR+Ui+7731o2t1kpeNcvZLp+FUUbtb
 nGCuWCXg3AaOS96zRN3Aqd2wtGRUQlNK79MWk=
X-Forwarded-Encrypted: i=1;
 AJvYcCU0mW3Zayhz7yJG5g+kmdJ37+3DhDdzWYT7Wbjkb6Cbgr4AD7cnni8UQWzwxGtAOs2WUzA=@dpdk.org
X-Received: by 2002:a05:6402:3481:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-65ea4b58833mr104577a12.0.1771603303772; 
 Fri, 20 Feb 2026 08:01:43 -0800 (PST)
X-Received: by 2002:a05:6402:3481:b0:64d:e1c:4c0a with SMTP id
 4fb4d7f45d1cf-65ea4b58833mr104525a12.0.1771603302924; Fri, 20 Feb 2026
 08:01:42 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <20260220154044.1704312-1-luca.boccassi@gmail.com>
In-Reply-To: <20260220154044.1704312-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKK6nMv5uHOAUTa2IFGRCcHDhxgxLQvLqqg
Date: Fri, 20 Feb 2026 11:01:39 -0500
X-Gm-Features: AaiRm50ygoyowTiq4OSplEfFUJtNMClCj-Ky45f5zAPyvBo9I3nmEerIuQB1gKc
Message-ID: <028e16567c50b33338eec58540e9c7b3@mail.gmail.com>
Subject: RE: please help backporting some patches to stable release 24.11.5
To: luca.boccassi@gmail.com, dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b9d8b1064b438948"
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

--000000000000b9d8b1064b438948
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

The patch e0f92e31f7 is not required to be backported to 24.11. There has
changes in that part of code that will not allow simple merge of this fix.
This fix is not critical to be ported to older version as it is fixing
stats counters in a specific scenario.

Thanks,
Kishore


-----Original Message-----
From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
Sent: Friday, February 20, 2026 10:41 AM
To: dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>
Subject: please help backporting some patches to stable release 24.11.5

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool
./devtools/git-log-fixes.sh I didn't apply following commits from DPDK
main to 24.11 stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 02/27/26.

You can find the a temporary work-in-progress branch of the coming 24.11.5
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts
or misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit in
it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:

https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd381
1ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in
the subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
f82b3ed6ab  Anatoly Burakov  net/ixgbe: fix pointer handling in IPsec
ab797d5bcf  Bruce Richardson dma/idxd: mark portal pointer as volatile
77bb34e047  Ivan Malov       net/sfc: avoid speed reset when setting FEC
in started state
e0f92e31f7  Kishore Padmanabha net/bnxt: fix statistics for high number of
queues
bd2f563dbd  Rahul Bhansali   common/cnxk: fix duplicated branches
2e79349dcd  Song Yoong Siang net/e1000: fix igc launch time calculation

--000000000000b9d8b1064b438948
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVcQYJKoZIhvcNAQcCoIIVYjCCFV4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLeMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCZVQtrc6UhrNPZ71jI4RgUcEoOL21t0S+E5KRayTLfBDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjAxNjAxNDVaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGjMMMS9jy
8f+JanOg3Yylt5IgsZ02HWFOWKNGQJ/GGQ0zIMtlKhlxF3J+rFWQfyj30ocKGKtk1WAXCiE7yzq0
sqPWX8cghSF0h6NkxWjCXmAHN89eIMMOohUNrFBik5UpHg4j/YMQCZj8W5K24tAx9apXEpz8VkiP
VEXIQECd2iMr0srsZ8UlEINEYggdK8MShbJZDwP2A+Pq4C1ZHT084gC+egBVEYcRlP/iqmppTLpF
0v69a8AnArroof8ldt/Z6h/Sdj7b0wyE/Mkk2q0ci3uj24hcvs44yhq5OrTOpmoA2VsWxXt50GBH
wcsIjHHQb5Ps+SEC6+3yXRtjFwid
--000000000000b9d8b1064b438948--
