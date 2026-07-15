Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5817C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 15:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C14D4028C;
	Wed, 15 Jul 2026 17:13:25 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id B7DB44026A
 for <dev@dpdk.org>; Wed, 15 Jul 2026 17:13:24 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2caf228a910so42416765ad.2
 for <dev@dpdk.org>; Wed, 15 Jul 2026 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128404; x=1784733204;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QW8Gc3TdqxIZxHy7o+ra8labkNdXRRsbbxPUz9oDFhM=;
 b=lQ+8pw+NBYl3h7V5e8FPojfvvgUrmureh+Ga/FQhoUBb6VOnFUJEQl2wo+srjI0nmV
 Tp7zZBn37ZBgGUENiR/AwBk27hyvTaKx4ROIKz5ouDmLTHsquemfAyAX7PPrfCMOPrtA
 HvH99sqWI0iZgpP1oi0YXMtE2s41Yj2ZAixwZqNZkAAadvWwmD+05pBcS5mYQNOrH/6Y
 TpRJQMPb9n0pYG8o7oisi+hlaykKOoUnhzOzAZeXVXwLS2QR9hgP8fHchZW5KLcH0sF6
 xmQ3VFTzjtsG9sqDd5E3iJdPcWCkVVC8f55wzAwFiiNweFVXfRoBl/ME059m+cPu2Jk5
 hE9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpcbfn6LhGMJCvQZBextW8OWVu+jmiZP+Z1+IXS0Bdgui6RPUeqILfzYoEZvDm9wUpLNs8=@dpdk.org
X-Gm-Message-State: AOJu0YzsuxXhhOkWkLPCDPC/McHupUXN97xEQz6el+bWVZQcaa4K/GM7
 U5uI8QjRbUouvyNXKemy0OV4JTwcyGZCg+vkX/lNVc3ZIPdJ2g/PmoGysStSHgzqQBQ2K4gu2x6
 XLvw/wMZdk3SkhrwiwcT0zPRX2WPED+cb4m+KnZoJ7xPuWMcmXRVh0qaUeZxpK5b1DJPq1vC/2x
 /UMb1F5l1D2sbBt1UA9+Qyj1vMwEZKYpuDcACUjmmN2BADOnVhaT2rT62AFQU7VjHiyIvpB1EKJ
 5humw==
X-Gm-Gg: AfdE7cmD8qFvFWwykm/wans8iu9Xj3tAJl8TsQjiSNhW90uPZnWnL4Rg/YR46jBlXO9
 0Gh2SpLozR7/aXMBq4r4++9r6i8L2QnLbSyq32yYLjS5thIGaZtUplkFi+NeWqOXnyvBNd5c/WO
 4nW+pQETy5fLDHfQ9/LrELIkkNho/KfHt9MDstZ+2nRTCl4UA7M/Wuau3bJL+ffoD8Pb7hukZjO
 7yeT1Gtu+mvn01zaOPMAC8WvCtjqIfaO8HDZ7UJIlmoMr7ijF45qc50R1ppyDRQn1jWjAqvVJ0h
 ++pARbAdHOqa550LpBwFuFW8kbTT5VTjSN+GptVi9GXtGUCDOcB3NftR0N7n9iohxbDGpy1mRAl
 5LLbMGXC40uCxx/fcuL/mHR2bWU+iVZC+fzWccEQ+vkw6gE8X8oqey4mcVzaU4UHud1Hoyf5Uld
 z2dLv4oBuE1LI68oPOlS/fvbC/V/f+P8R4jNmSbnQEtKqBaqnCcsX9iA==
X-Received: by 2002:a17:902:ec8e:b0:2ca:ce91:f027 with SMTP id
 d9443c01a7336-2cf03d37947mr27169825ad.36.1784128402597; 
 Wed, 15 Jul 2026 08:13:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2cf102e6d04sm608085ad.26.2026.07.15.08.13.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 08:13:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493f75ebec5so37504415e9.1
 for <dev@dpdk.org>; Wed, 15 Jul 2026 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784128400; x=1784733200; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QW8Gc3TdqxIZxHy7o+ra8labkNdXRRsbbxPUz9oDFhM=;
 b=GacQ8l6IXdvSHP3RIRKJPJjGRsH7LlnKUFo8YkkbN6H/r2WcR5iAoLF9X/BCo+/BTn
 OVTrR95GrR76iSRZML7SnrUyeLITbZRc4JOo/T7gbxBWoRlWOJ5F/u7vie/p3aQd0875
 CBfYF805p6jehOMFSz266zK84cZCXzvtwsIq8=
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7ezPG1Osd201VFSW5Qldq1r1inptUheyoPTfN593BFpwnfNbEWURVaDHabazvnESa+hU=@dpdk.org
X-Received: by 2002:a05:600c:c3ce:10b0:495:3fa4:e8a6 with SMTP id
 5b1f17b1804b1-495403fcad6mr7710745e9.8.1784128400282; 
 Wed, 15 Jul 2026 08:13:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c3ce:10b0:495:3fa4:e8a6 with SMTP id
 5b1f17b1804b1-495403fcad6mr7710255e9.8.1784128399785; Wed, 15 Jul 2026
 08:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 15 Jul 2026 11:12:59 -0400
X-Gm-Features: AUfX_mxKzd2IPwbzoOavev1ciTWSBDJYsp6MxZAxqw-V66MLSAEkmssUdcFrwGs
Message-ID: <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
Subject: Re: mempool cache change
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: fengchengwen <fengchengwen@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, 
 Wisam Jaddo <wisamm@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008d5ad70656a7c345"
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

--0000000000008d5ad70656a7c345
Content-Type: multipart/alternative; boundary="00000000000080e1300656a7c3c7"

--00000000000080e1300656a7c3c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com>
wrote:

> > From: fengchengwen [mailto:fengchengwen@huawei.com]
> > Sent: Wednesday, 15 July 2026 10.12
> >
> > On 7/15/2026 4:08 AM, Morten Br=C3=B8rup wrote:
> > > Hi Kishore,
> > >
> > > For your testing purposes, please follow the guidance provided to
> > Wisam Jaddo:
> > >
> > https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F65964@smart
> > server.smartshare.dk/
> >
> > We need to recompile in this case. We should try to avoid
> > recompilation.
> > I think it is necessary to adjust RTE_MEMPOOL_CACHE_MAX_SIZE to 768 as
> > a default configuration.
>
> Changing RTE_MEMPOOL_CACHE_MAX_SIZE breaks both the API and the ABI; so i=
t
> has to be done when building locally, where API/ABI breakage is acceptabl=
e.
>
> For DPDK 26.11, where API/ABI breakage is acceptable, we can discuss
> increasing the default from 512 to a higher value. I do have some input t=
o
> that discussion, but let's postpone it until after DPDK 26.07 has been
> released.
>
We should increase this value to avoid performance degradation, as users
may not realize they need to change it.  We do not have do it right away
for 26.07 release but we should it right after the release.

>
> >
> > Thanks
> >
> > >
> > > Thank you for testing!
> > >
> > > Venlig hilsen / Kind regards,
> > > -Morten Br=C3=B8rup
> > >
> > > From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com]
> > > Sent: Tuesday, 14 July 2026 18.49
> > > To: Thomas Monjalon; Morten Br=C3=B8rup
> > > Cc: dev@dpdk.org
> > > Subject: mempool cache change
> > >
> > > Hi Thomas,
> > >
> > > The recent change done as part of BUG ID: 1027, with commit id
> > https://git.dpdk.org/dpdk/commit/?id=3Df5e1310f16e0909e7e7f71807123644c=
63
> > b23cba
> > > Is causing performance drop for the bnxt NIC in 26.07 release.
> > >
> > > The smaller, shallower cache increases the miss rate, causing refills
> > to hit the shared ring more frequently.
> > > In the old code, the cache only touched the shared ring when it
> > climbed past 768 instead of 512. That extra 256 elements of headroom
> > allowed significantly more frees to remain local.
> > >
> > > Could we make the change in config/rte_config.h for
> > RTE_MEMPOOL_CACHE_MAX_SIZE to be 768 instead of 512. Since we use =E2=
=80=93
> > mbcache=3D512 as argument for the performance tests.
> > >
> > > Thanks,
> > > Kishore
> > >
> > >
>
>

--00000000000080e1300656a7c3c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 15,=
 2026 at 5:02=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smarts=
haresystems.com">mb@smartsharesystems.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">&gt; From: fengchengwen [mailto:<a=
 href=3D"mailto:fengchengwen@huawei.com" target=3D"_blank">fengchengwen@hua=
wei.com</a>]<br>
&gt; Sent: Wednesday, 15 July 2026 10.12<br>
&gt; <br>
&gt; On 7/15/2026 4:08 AM, Morten Br=C3=B8rup wrote:<br>
&gt; &gt; Hi Kishore,<br>
&gt; &gt;<br>
&gt; &gt; For your testing purposes, please follow the guidance provided to=
<br>
&gt; Wisam Jaddo:<br>
&gt; &gt;<br>
&gt; <a href=3D"https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35=
F65964@smart" rel=3D"noreferrer" target=3D"_blank">https://inbox.dpdk.org/d=
ev/98CBD80474FA8B44BF855DF32C47DC35F65964@smart</a><br>
&gt; <a href=3D"http://server.smartshare.dk/" rel=3D"noreferrer" target=3D"=
_blank">server.smartshare.dk/</a><br>
&gt; <br>
&gt; We need to recompile in this case. We should try to avoid<br>
&gt; recompilation.<br>
&gt; I think it is necessary to adjust RTE_MEMPOOL_CACHE_MAX_SIZE to 768 as=
<br>
&gt; a default configuration.<br>
<br>
Changing RTE_MEMPOOL_CACHE_MAX_SIZE breaks both the API and the ABI; so it =
has to be done when building locally, where API/ABI breakage is acceptable.=
<br>
<br>
For DPDK 26.11, where API/ABI breakage is acceptable, we can discuss increa=
sing the default from 512 to a higher value. I do have some input to that d=
iscussion, but let&#39;s postpone it until after DPDK 26.07 has been releas=
ed.<br></blockquote><div>We should increase this value to avoid performance=
 degradation, as users may not realize they need to change it.=C2=A0 We do =
not have do it right away for 26.07 release but we should it right after th=
e release.=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Thank you for testing!<br>
&gt; &gt;<br>
&gt; &gt; Venlig hilsen / Kind regards,<br>
&gt; &gt; -Morten Br=C3=B8rup<br>
&gt; &gt;<br>
&gt; &gt; From: Kishore Padmanabha [mailto:<a href=3D"mailto:kishore.padman=
abha@broadcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</a>]<b=
r>
&gt; &gt; Sent: Tuesday, 14 July 2026 18.49<br>
&gt; &gt; To: Thomas Monjalon; Morten Br=C3=B8rup<br>
&gt; &gt; Cc: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.or=
g</a><br>
&gt; &gt; Subject: mempool cache change<br>
&gt; &gt;<br>
&gt; &gt; Hi Thomas,<br>
&gt; &gt;<br>
&gt; &gt; The recent change done as part of BUG ID: 1027, with commit id<br=
>
&gt; <a href=3D"https://git.dpdk.org/dpdk/commit/?id=3Df5e1310f16e0909e7e7f=
71807123644c63" rel=3D"noreferrer" target=3D"_blank">https://git.dpdk.org/d=
pdk/commit/?id=3Df5e1310f16e0909e7e7f71807123644c63</a><br>
&gt; b23cba<br>
&gt; &gt; Is causing performance drop for the bnxt NIC in 26.07 release.<br=
>
&gt; &gt;<br>
&gt; &gt; The smaller, shallower cache increases the miss rate, causing ref=
ills<br>
&gt; to hit the shared ring more frequently.<br>
&gt; &gt; In the old code, the cache only touched the shared ring when it<b=
r>
&gt; climbed past 768 instead of 512. That extra 256 elements of headroom<b=
r>
&gt; allowed significantly more frees to remain local.<br>
&gt; &gt;<br>
&gt; &gt; Could we make the change in config/rte_config.h for<br>
&gt; RTE_MEMPOOL_CACHE_MAX_SIZE to be 768 instead of 512. Since we use =E2=
=80=93<br>
&gt; mbcache=3D512 as argument for the performance tests.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Kishore<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div></div>

--00000000000080e1300656a7c3c7--

--0000000000008d5ad70656a7c345
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCLDo54nAEQ8X68KpChfU9Ybj+wlgsA0Myq/3wquy6bujAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MTUxNTEzMjBaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBPExYNxksB
laBPmUoMt9oZ7t2NVPOvlC+TiS6GVNgd8uy9GuEcDVUg25yxomO/8kSJY1cpjRCf9lvY7c0Q3vt8
4zOGD4oqNCG7PQPCAFDcFmtvcOyq4fYxE/k+BStccp00HdiGEw8Tw2diaq0+0QmTIcoIbDjdbDUf
cImW9tjQ29bCVW76ZH6X5S9moh4q0NOKlq60H+Kr1aLO+B8En6i/5r3edCcdP+Nt0K39RH1N5Tt8
Tlik5tT6NbvkzergwY5UsI6wufXMjEGixoWvoY0XK1Ul/PTGD8MeFO04DQbUfBIKTYZEmCj3P6EP
vfRXZgWDIT4VoKdzmhls7e2uBuM0
--0000000000008d5ad70656a7c345--
