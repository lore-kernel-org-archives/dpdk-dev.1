Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B9ACD8C90
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:18:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C517427A2;
	Wed, 10 Jun 2026 20:18:51 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 4F718402A7
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:18:49 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-36bba9a1089so4280571a91.3
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781115528; x=1781720328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8yr2fyIykhXl8qQdfY6p+whZJsMOX3xZBr3Z6gD8Yc=;
 b=bm+nbvzgvd9xhsMTXcKVkPsrlk90UAGs2nUaL6oR3JAbQrcL9MbyHJVQb0UhlnDAHW
 6sS2X9d8nVeOzOZhUsZjTtvUKjNLpOX7UWmA92VPlrUEV67bAK0pp2KVWOfaxjez5jh7
 EWuAZZQnDAvKz+GOcpkvB+bfTvtubMAAEgdVibQo15PT833+NlipX59PhkwthWHekAjB
 pZc7R4fIXXeB1lmzmxVhuOYjHR3D09ThDTMXs59mesQSXBTZQEG+QsDk/v4BMDE232Hu
 YR5Ip4Ne1swb5PqVlHNDGpzx2ATuRAzxpp2E0tas9HT+9JSxK6OaBu3uMRuFNNispOyV
 SyxQ==
X-Gm-Message-State: AOJu0YwyYtjsfYvgtQ8Jc5i+PgdR3zaEMH1Osc/B8laP7kyLdDqfqP5U
 F2ylFdvqmUAVDuDhYYUo0laISskpaZCXd8McdtLzKDJEKIM8pxt7x10lfRxK+pVsXWsqziQ0+xf
 xHvYMur2XlBYEyYNFj6XE3KzE8pTRdPd/f3ulaNh5sDxOYgF/6ih7e45BbNEKz0REqj0IxQAvD0
 eHarAx/7nvsFgM7nWbhv6TrY1QlfHy1vwkftHPiMas6TxHzziuN6Acs9tJvoh5+cyXcjc0L8XoD
 Y0w8w==
X-Gm-Gg: Acq92OGTgLiSlkhYOqbLjQK0mQGL6xBjXHrrDG5Wf+3fuY6ofHA9KjXVyX3SsQAzzJJ
 kKd+GOT73Kv2XqWZclzlCkA+dVq3LTEfivA0NyQ0rWU6uqw5zWziLcTTyDVSPja21hH022bjn+a
 sI0fWh3UKhnrrs1cUOXuUfKUrYcd7Z/4cnIcY4Aq5CBoQXyWcGTg8C0UCgBo+ZwEF6rHRJv+IRJ
 KR4HMHskl1YolTNlGFauX0LIWA4iEVE+OEpif0XRqvo92WrdSoZSHqo93/zp2FTM6rNzZafxm6I
 Mx/Zz1rTRZ/VFR1vm34QADs8LQFY+tb1XgTimciPjZLL0a8LpXyV7UQZpcrxItt0n9S3CLWOCM7
 Moj/LiVxBf3uWhKIbHQoqc10SoZoAQ/0DmuTGYTAaHtzxGPsMzCejq7jRRmw8wiF+PrkvZILw68
 aRldX+fPqcC1J8lZsfYGsKGMWibc33XVUZuj+bggIwfhk2g5WP+C3tNFgASggh2KUwkdVwbXAmu
 Eu9yw==
X-Received: by 2002:a05:6a21:104:b0:3b4:7eb0:479f with SMTP id
 adf61e73a8af0-3b4ccd3a851mr29174356637.5.1781115528250; 
 Wed, 10 Jun 2026 11:18:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c85df03619dsm1402376a12.4.2026.06.10.11.18.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:18:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so57274655e9.1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781115526; x=1781720326; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w8yr2fyIykhXl8qQdfY6p+whZJsMOX3xZBr3Z6gD8Yc=;
 b=Zj/tIK+PfMImxf3yvFmgsiID/UUcC+WcA1tlWQNwyY+mao3dSipDqJV+NgMsczEF/3
 AJGrtPA4Afr4r7TAeidYZy5lNwIpcJBfgcXK1si+CXEwEI3PcoixUSbRahs/3nJdqTpD
 xdI4EiiP7pXAsyHW6FEp4MdGFba6vuvXywVmY=
X-Received: by 2002:a05:600c:1c1f:b0:490:b724:dbd6 with SMTP id
 5b1f17b1804b1-490c2598382mr412377725e9.6.1781115526106; 
 Wed, 10 Jun 2026 11:18:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1f:b0:490:b724:dbd6 with SMTP id
 5b1f17b1804b1-490c2598382mr412377455e9.6.1781115525634; Wed, 10 Jun 2026
 11:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 10 Jun 2026 14:18:29 -0400
X-Gm-Features: AVVi8CdMnGLUotaxgnYXu41K26tur23-EvLXDp6k-XhvIVzsngdRlYZYxFWwgMU
Message-ID: <CA+BST0kS1yKdm32GPnzeVvDC5ubn8R1BrcBakGiE+qQEaLxczg@mail.gmail.com>
Subject: Re: [PATCH 00/10] net/bnxt: vector mode V3 implementation and AVX2
 improvements
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000416c1d0653ea46b9"
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

--000000000000416c1d0653ea46b9
Content-Type: multipart/alternative; boundary="00000000000035bfa30653ea46e6"

--00000000000035bfa30653ea46e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:17=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> This series adds vector mode support for BCM5760X (Thor2 / V3 packets)
> and fixes several AVX2 path issues:
>
>  - Implement AVX2 vector RX for V3 packet completions with VLAN TCI
> reporting
>  - Fix stale nr_bds values that could cause the producer to lag the
> consumer
>  - Fix incorrect advertisement of LRO offload capability
>  - Fix scalar RX path not checking rxcmp flags before setting the PTP mbu=
f
> flag
>  - Fix missing timestamps for non-PTP traffic when promiscuous
> timestamping is on
>  - Fix Tx ring corruption and burst truncation after an invalid Tx
> descriptor
>  - Optimise the AVX2 RX paths (dead code removal, register reduction for
> V3)
>  - Fix VLAN strip ol_flag being set per-port instead of per-packet for V3
>  - Add burst mode info entry for V3 in bnxt_rx_burst_info
>  - Fix V3 vector mode defaulting to cksum-good instead of cksum-unknown
>
> Most patches carry Fixes: tags. New functionality (V3 vector mode, AVX2
> optimisation) is targeted at 26.07.
>
> Note: this series depends on series "net/bnxt: stability fixes".
>
> Chenna Arnoori (1):
>   net/bnxt: fix RX timestamping for non-PTP packets
>
> Damodharam Ammepalli (1):
>   net/bnxt: fix advertising RX LRO offload capability
>
> Keegan Freyhof (6):
>   net/bnxt: vector mode implementation for V3 packets
>   net/bnxt: stale values in nr_bds are cleared
>   net/bnxt: optimization of the AVX2 RX paths
>   net/bnxt: fix for VLAN stripping being set incorrectly
>   net/bnxt: add vector AVX2 burst mode indicator for v3
>   net/bnxt: fix v3 vector mode not selecting cksum unknown
>
> Mohammad Shuab Siddique (1):
>   net/bnxt: scalar rx path disregarded rxcmp flags for setting ptp mbuf
>     flag
>
> Zoe Cheimets (1):
>   net/bnxt: fix packet burst truncation after invalid Tx descriptor
>
>  .gitignore                              |   1 +
>  drivers/net/bnxt/bnxt.h                 |   1 +
>  drivers/net/bnxt/bnxt_ethdev.c          |   6 +-
>  drivers/net/bnxt/bnxt_hwrm.c            |   7 +-
>  drivers/net/bnxt/bnxt_rxq.c             |   3 +-
>  drivers/net/bnxt/bnxt_rxr.c             |  25 +-
>  drivers/net/bnxt/bnxt_rxr.h             |  14 +-
>  drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 444 +++++++++++++++++++++++-
>  drivers/net/bnxt/bnxt_rxtx_vec_common.h |  37 ++
>  drivers/net/bnxt/bnxt_stats.c           |   3 +
>  drivers/net/bnxt/bnxt_txr.c             | 170 ++++++++-
>  11 files changed, 677 insertions(+), 34 deletions(-)
>
> patches merged into dpdk-next-net-brcm
Thanks

> --
> 2.47.3
>
>

--00000000000035bfa30653ea46e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, =
2026 at 11:17=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moha=
mmad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:=
 Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broa=
dcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt;<br=
>
<br>
This series adds vector mode support for BCM5760X (Thor2 / V3 packets)<br>
and fixes several AVX2 path issues:<br>
<br>
=C2=A0- Implement AVX2 vector RX for V3 packet completions with VLAN TCI re=
porting<br>
=C2=A0- Fix stale nr_bds values that could cause the producer to lag the co=
nsumer<br>
=C2=A0- Fix incorrect advertisement of LRO offload capability<br>
=C2=A0- Fix scalar RX path not checking rxcmp flags before setting the PTP =
mbuf flag<br>
=C2=A0- Fix missing timestamps for non-PTP traffic when promiscuous timesta=
mping is on<br>
=C2=A0- Fix Tx ring corruption and burst truncation after an invalid Tx des=
criptor<br>
=C2=A0- Optimise the AVX2 RX paths (dead code removal, register reduction f=
or V3)<br>
=C2=A0- Fix VLAN strip ol_flag being set per-port instead of per-packet for=
 V3<br>
=C2=A0- Add burst mode info entry for V3 in bnxt_rx_burst_info<br>
=C2=A0- Fix V3 vector mode defaulting to cksum-good instead of cksum-unknow=
n<br>
<br>
Most patches carry Fixes: tags. New functionality (V3 vector mode, AVX2<br>
optimisation) is targeted at 26.07.<br>
<br>
Note: this series depends on series &quot;net/bnxt: stability fixes&quot;.<=
br>
<br>
Chenna Arnoori (1):<br>
=C2=A0 net/bnxt: fix RX timestamping for non-PTP packets<br>
<br>
Damodharam Ammepalli (1):<br>
=C2=A0 net/bnxt: fix advertising RX LRO offload capability<br>
<br>
Keegan Freyhof (6):<br>
=C2=A0 net/bnxt: vector mode implementation for V3 packets<br>
=C2=A0 net/bnxt: stale values in nr_bds are cleared<br>
=C2=A0 net/bnxt: optimization of the AVX2 RX paths<br>
=C2=A0 net/bnxt: fix for VLAN stripping being set incorrectly<br>
=C2=A0 net/bnxt: add vector AVX2 burst mode indicator for v3<br>
=C2=A0 net/bnxt: fix v3 vector mode not selecting cksum unknown<br>
<br>
Mohammad Shuab Siddique (1):<br>
=C2=A0 net/bnxt: scalar rx path disregarded rxcmp flags for setting ptp mbu=
f<br>
=C2=A0 =C2=A0 flag<br>
<br>
Zoe Cheimets (1):<br>
=C2=A0 net/bnxt: fix packet burst truncation after invalid Tx descriptor<br=
>
<br>
=C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0drivers/net/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A06 +-<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A07 +-<br>
=C2=A0drivers/net/bnxt/bnxt_rxq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0drivers/net/bnxt/bnxt_rxr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 25 +-<br>
=C2=A0drivers/net/bnxt/bnxt_rxr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 14 +-<br>
=C2=A0drivers/net/bnxt/bnxt_rxtx_vec_avx2.c=C2=A0 =C2=A0| 444 +++++++++++++=
++++++++++-<br>
=C2=A0drivers/net/bnxt/bnxt_rxtx_vec_common.h |=C2=A0 37 ++<br>
=C2=A0drivers/net/bnxt/bnxt_stats.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A03 +<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 170 ++++++++-<br>
=C2=A011 files changed, 677 insertions(+), 34 deletions(-)<br>
<br></blockquote><div>patches merged into dpdk-next-net-brcm</div><div>Than=
ks=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--00000000000035bfa30653ea46e6--

--000000000000416c1d0653ea46b9
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCr69kIUuxnGT8jfmGz7kcPqz/ekTMtcHm1F6BXbqaJmjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MTAxODE4NDZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCsRozLT0AY
hGkVt+zP2oRUBaql5mVcL+uI+Uigg54xsiy6XIn+vHddVkzu6QqHIozZLl904bc8Ka9iAohTNmsL
uKuDWHaHYP3zk96a/yDbxK38J/+X27bpl6dCKC0gEKLJtA7sa+oFFDmdhnHH/10cK8XiCiaEXNdn
//Zdgk2qB4PBLAChVGbikve5glOjsmhS01JGqLoG477OfDidCyK+SIkYklKxAb4mhUB4mraBhb0O
V5Lq7pO8j8Y83UqpIV0p+1mi84sZxJ3TQYSsa7vE1//1UMO9rBPsiTUNYcrow4lUFAB/zU8Cmavb
peNfF+7rvrNoB1zrH28SuLHazLDY
--000000000000416c1d0653ea46b9--
