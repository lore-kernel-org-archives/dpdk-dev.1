Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69500CD6E74
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 17:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50C9A402D3;
	Thu,  4 Jun 2026 19:37:04 +0200 (CEST)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id 23A0140151
 for <dev@dpdk.org>; Thu,  4 Jun 2026 19:37:01 +0200 (CEST)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-8ce65629acaso10950516d6.3
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780594620; x=1781199420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnEdVi4kWL69DGBjeb43VoH3UfD3/9cLy/AsVll+u0g=;
 b=qsEoMT5sW+kGWs8yM3sfnwd3hxeGneLsVM1eWO7EUQRREQMKCCAwoYmt9yYSzV9hh8
 69NNBGN2XmAsfTbY7p/gUMee/V9XfyNx9U2NOKkwjpVQc/CO0Y2hok1HWm7rp7LeGBAA
 gTy3PYrQak6DCKJ/dICfzP520p9g9TWTTU3ipy/Ng28NzLc9KoyVo8QCnc9GvMTUF2gC
 p9h7wv9qq+mb+9+LRnl30iIXYVjDdASnbWMATGpdizXsNGTfnWCOxlhlkPD4McZga5YO
 LlefW3M1iNxcJucuDzZr+skSGBU5r8X0LKxJiXUhNiwwwbv6OFnOvX9+xmrBlvVvhpKc
 Orvw==
X-Gm-Message-State: AOJu0Ywo2c7vVYqPVbBJ+uDP1VKdFfSaQxGqAEm2gJHKc6n0apea+Bhy
 wD56XQLh9CwzufXjLCkGZ/3Pu1I/9uNPeH+c8ptgV2hBp0mqDLXPAkm67bX/Wu3FwDZELQv7dCY
 z3C/sM4n9k9SKE6bE7DH1moNeDNeVosMQ5jGaUHGPvmN9u4RCJt7ewbegK0MELdmoigk2iyInYt
 13gGNGqaN/xwDvzupimoWI21Y33tJXFKrRAeiP5fm80kBSuhSaLYq/k/+LvInm3CGgh6czsLWse
 +AMkw==
X-Gm-Gg: Acq92OH2d4pQfkC7z0cHAbVrHE4nlHoz3lWIcfn/h9BlmY0joRdYunzCLYe1RE4uwXq
 vYrC/d2pPUznbguoUpBfcDTUP1EJJECOMSUEutJnDKGfPocO+GyNGvxWNrwa7p8Ww8HQmKko/0P
 4s8DGH1miVhf3nCgOA3aXH3ZBvWySaa6kfqofYAEbrUW97yi2C1R0iMmDgYJ4riDkdpAYHjC19H
 TTWEv7gdH2BXgl3bPvvrCmAmKLF+RXk6v1z8pqdc7u9ZHu29jlX0GpRsnSfgq5SukYi2Zoq/Cc9
 eJ4MngH5/97ojRkTP8EtxUEMqJMYgSebTW33NC+3PGCXqh+KaZeO6pnJWoNqmf8RfEgqGgcebA2
 CbxC9kzdyeds96F0xjtRjXVg9oN68l/a/dkv8hi/QYFhTohYCL5MAHBW1Mrg/gkHza8fqK7c+Gw
 nVzX26uRvRkd6LCPU1OhRm/KQ=
X-Received: by 2002:ad4:5ba7:0:b0:8ce:b75f:417c with SMTP id
 6a1803df08f44-8cee62836fdmr1190786d6.47.1780594620428; 
 Thu, 04 Jun 2026 10:37:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8ceccd94f48sm3479686d6.10.2026.06.04.10.37.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 10:37:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so10513335e9.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780594619; x=1781199419; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NnEdVi4kWL69DGBjeb43VoH3UfD3/9cLy/AsVll+u0g=;
 b=CUniVeVvMlq1xMXK+m/6hZihTKurTIEixsZDLPwRT/Ts2eFqgf7T+eFYaag1MZOF8c
 b/yMacPc+JG388YoaUYme9ogMJwPH29K1Topj2MN/0NeA/cqQvQ3G0EXeZhZPZfdhJBR
 InzdHpq++6IonZP0DHVlhGAgtutA0bVtFCIs4=
X-Received: by 2002:a05:600c:34ca:b0:490:4ee0:82ff with SMTP id
 5b1f17b1804b1-490b5fe6112mr141330095e9.27.1780594619000; 
 Thu, 04 Jun 2026 10:36:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:490:4ee0:82ff with SMTP id
 5b1f17b1804b1-490b5fe6112mr141329635e9.27.1780594618533; Thu, 04 Jun 2026
 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603175137.1990204-2-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260603175137.1990204-2-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 4 Jun 2026 13:36:43 -0400
X-Gm-Features: AVVi8Cd-2PdFmy4m8MpEUiTxYbeY1fODseNp0BIdQgdDI4baLcnQJy2E97jvfS0
Message-ID: <CA+BST0kQ9fh2WZawUF4XdCvdwuN5C0faR-OsO_3SCpug=2FNVw@mail.gmail.com>
Subject: Re: [PATCH 1/4] net/bnxt: modify check for short Tx BDs
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000c55656065370fd4b"
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

--000000000000c55656065370fd4b
Content-Type: multipart/alternative; boundary="000000000000ba23f1065370fdb6"

--000000000000ba23f1065370fdb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:49=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Ajit Khaparde <ajit.khaparde@broadcom.com>
>
> There is no need to use the long BDs for transmits
> where only checksum offload is needed.
> Modify the check for long BD and use long BDs only in cases
> where TSO and other offloads are requested.
>
> Fixes: 527b10089cc5 ("net/bnxt: optimize Tx completion handling")
> Cc: stable@dpdk.org
>
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_txr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
> index 27758898b0..7ef5b15ae8 100644
> --- a/drivers/net/bnxt/bnxt_txr.c
> +++ b/drivers/net/bnxt/bnxt_txr.c
> @@ -111,8 +111,7 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue
> *txq, unsigned int socket_id)
>  static bool
>  bnxt_xmit_need_long_bd(struct rte_mbuf *tx_pkt, struct bnxt_tx_queue *tx=
q)
>  {
> -       if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_TCP_CKSUM |
> -                               RTE_MBUF_F_TX_UDP_CKSUM |
> RTE_MBUF_F_TX_IP_CKSUM |
> +       if (tx_pkt->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
>                                 RTE_MBUF_F_TX_VLAN |
> RTE_MBUF_F_TX_OUTER_IP_CKSUM |
>                                 RTE_MBUF_F_TX_TUNNEL_GRE |
> RTE_MBUF_F_TX_TUNNEL_VXLAN |
>                                 RTE_MBUF_F_TX_TUNNEL_GENEVE |
> RTE_MBUF_F_TX_IEEE1588_TMST |
> --
> 2.47.3
>
>

--000000000000ba23f1065370fdb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 3, =
2026 at 1:49=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.com" target=3D"_=
blank">ajit.khaparde@broadcom.com</a>&gt;<br>
<br>
There is no need to use the long BDs for transmits<br>
where only checksum offload is needed.<br>
Modify the check for long BD and use long BDs only in cases<br>
where TSO and other offloads are requested.<br>
<br>
Fixes: 527b10089cc5 (&quot;net/bnxt: optimize Tx completion handling&quot;)=
<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.c=
om" target=3D"_blank">ajit.khaparde@broadcom.com</a>&gt;<br>
Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab=
.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.=
com</a>&gt;<br></blockquote><div><span style=3D"font-family:Calibri,sans-se=
rif;font-size:11pt">Acked-by:</span><span style=3D"font-family:Calibri,sans=
-serif;font-size:11pt">=C2=A0 </span><span style=3D"font-family:Calibri,san=
s-serif;font-size:11pt">Kishore
Padmanabha &lt;</span><a href=3D"mailto:kishore.padmanabha@broadcom.com" st=
yle=3D"font-family:Calibri,sans-serif;font-size:11pt;color:rgb(5,99,193)">k=
ishore.padmanabha@broadcom.com</a><span style=3D"font-family:Calibri,sans-s=
erif;font-size:11pt">&gt;</span>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c<br>
index 27758898b0..7ef5b15ae8 100644<br>
--- a/drivers/net/bnxt/bnxt_txr.c<br>
+++ b/drivers/net/bnxt/bnxt_txr.c<br>
@@ -111,8 +111,7 @@ int bnxt_init_tx_ring_struct(struct bnxt_tx_queue *txq,=
 unsigned int socket_id)<br>
=C2=A0static bool<br>
=C2=A0bnxt_xmit_need_long_bd(struct rte_mbuf *tx_pkt, struct bnxt_tx_queue =
*txq)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tx_pkt-&gt;ol_flags &amp; (RTE_MBUF_F_TX_TC=
P_SEG | RTE_MBUF_F_TX_TCP_CKSUM |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_MBUF_F_TX_UDP_CKSUM | RTE_MBUF_F_=
TX_IP_CKSUM |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tx_pkt-&gt;ol_flags &amp; (RTE_MBUF_F_TX_TC=
P_SEG |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_O=
UTER_IP_CKSUM |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GRE | RTE_MBUF_=
F_TX_TUNNEL_VXLAN |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_MBUF_F_TX_TUNNEL_GENEVE | RTE_MB=
UF_F_TX_IEEE1588_TMST |<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--000000000000ba23f1065370fdb6--

--000000000000c55656065370fd4b
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
oIHHMC8GCSqGSIb3DQEJBDEiBCBQiRwUnHeiLuTBLr85n1htfKOstr/tBKTqvQvorZy4GzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MDQxNzM2NTlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCPdOmRI8vZ
nJPG25JW7j/tiJEJ0C7OtlAh2A1Ajg+43LFUliLRpf8rv1hpYcjBaUlaWRa0QXiBKmU5gGnaZvaU
vSTzfyUXIK1mNA4U5PegDRyonn6Ql49I9fZiXb/RiB5G7/gY8FNJGNOFZYqmJYoI3KSXyEKaJ/bT
n9+MIl8TqADvfKlsPatfxKygBsIW4tBVfU+Kcs7ofNQJBToVCX4t0IPeNGl24zDQ3E8/xbdjfgDy
Y9wWpzGAi+wnjIdEp9Ph8Gr6Asnr46zCa2LWC6cgTZgxDKX4iuMhLbKdVardZ+Ljp5t+69CdRV4T
KsthVhrlfNPCit4eUb1T1roAcTuX
--000000000000c55656065370fd4b--
