Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE8DC98304
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 22:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32F7E4027C;
	Thu, 24 Sep 2026 00:43:57 +0200 (CEST)
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com
 [74.125.82.228]) by mails.dpdk.org (Postfix) with ESMTP id 616F640276
 for <dev@dpdk.org>; Thu, 24 Sep 2026 00:43:56 +0200 (CEST)
Received: by mail-dy1-f228.google.com with SMTP id
 5a478bee46e88-3336cc33cf4so1204128eec.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203435; x=1790808235;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6lHqaF3/ZJ+5Wd8WekDMhT6lYSaMTHZ7G6CHeTNscD8=;
 b=lHvba/wMOFW0uvnj7KR+B2kt1TbBBnlL9QlF834iPCmPabzlNuExDKvmFNqGfedmp2
 x+pjLHhU5c4eSLwMFn9fQ8EUNTLOVDWwj09Y8YEEN8ICh3C+xQQDmFBTFbct+fQE7ZdQ
 nhPMBn9PRWWN3ziIOWFVHibKImWIW8ulZesOD+8HDMEfrl8uxCh1NUrgf7C83B+q0Xe7
 7eT++xaDzdye4YFnx2rKqBFIbgKMYCZeFtpZPTHVq7oGoF7wxoklEY8mSMhsxb/OJGzD
 ztT1SNUESnI3fh68LFQwqJS5fOLxuAVCZTyHHSQ6RP23c5Oo6dLhfbbTH9ZuMt8jnUqP
 TuUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp0twBtCJ/OZENzw1AGiJDwR3Yxv50XJEnew+FkdWoSP4vxREyIqELd48BUOFL4QGyJY0=@dpdk.org
X-Gm-Message-State: AFuF++ncSftqfuJwG16hTbgn4hJHSLbpgncAUypTjA05228IKWIg8w08
 aMYjDUpA+6NXRZ0ZKnBNsLqOwlXQr2FIMTnMoGDNQmVTebVHyr5z0J4GDaa1MCb6QQITL2+6//+
 XRfWegK2yxxGSFbg9IfJtfwd1A2IMQJxu6ps1ym7ohYqANEPU3OdSc7dDFrPX+SZCz31PcU6Lw6
 eVgjGVX61eZKQpRh4pQyMGnTkxJHn3fukSLvYTIWpjutphA4+qb0X91R/OpLHXQQDY3QjZK1UET
 AzVqp+Mpvfy
X-Gm-Gg: AYBFou0DyFlatgBrUyCHZhjOqat198t92f+VbK4T2AfLyKCOZeGwK5IPXTexZtkOTCA
 MUlV6ORWHim3tiExBwoE+V/hoJBdxrFxqD2a+TiYaVpDR6MyrDy1rZ88WLw6gN9YIUhVqSI/qTr
 /LBqCmkTeG+GhgVNrCBKKPfqpR9g23qzrKzdTkRIXGEIIk6fiRevHdlYlDNmRJarQ1uVfSKg1Tr
 aKTvzEk9S058mPYLnKYU2W/PtjGqqFiiQUKnf4/bg++IWgyt8yB2FRzlukDk2v/3Ea5yYUb+wzn
 9S+uPgSCnRjLsaqU/HsKH2TcPVoKjnGNqO2sffPxHY02K+ItHHH08zrMNkTXKe300NHQg5LF4E0
 H1nClF8jOV4E3BIgU6+st6XgB3pyRgk6wMBwpGObu0ShiMXPFTo3XiSioIdTLw2pn7aUn00usqM
 z3FBBBQsC2BloztUIeMA3O7UEPsnYc4ZBBfA3uiHaJcdNjbRSUHg==
X-Received: by 2002:a05:693c:621a:b0:33c:e61:e201 with SMTP id
 5a478bee46e88-34002edee42mr483867eec.22.1790203434744; 
 Wed, 23 Sep 2026 15:43:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-33e96357306sm35434eec.10.2026.09.23.15.43.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Sep 2026 15:43:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so1002290a12.3
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790203433; x=1790808233; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6lHqaF3/ZJ+5Wd8WekDMhT6lYSaMTHZ7G6CHeTNscD8=;
 b=aDlPnWijdiLhg9NfdGlbB1QQHx19IT0nvKXPe6qsNRKFggOyZQtpO6AbpMfnzqt1P7
 hoplWHtYK0lX2e6DkQW2mBUxDJhMzgKBf0d6VwxSw2OCNswQ2ovrdBefwxJewRPepeqj
 4pYmG6J46wun5x+4L/n1oDIpb3iIW6jDKSW5Y=
X-Forwarded-Encrypted: i=1;
 AKwUvBzY1rzqKknwIg563ou0kFxjIgL8HX/EyfEa6agfuFBA4cRYKg8tpd+vEQ6r3RCNEShVSKs=@dpdk.org
X-Received: by 2002:a05:6a21:3301:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3de0e9211e2mr566513637.78.1790203432711; 
 Wed, 23 Sep 2026 15:43:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:3301:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3de0e9211e2mr566493637.78.1790203432220; Wed, 23 Sep 2026
 15:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921091932.39fa0013@phoenix.local>
 <CAJFAV8y=YSgqdt+gtXn37VYZagnMzMCaRg+VQZbmjfQ974vW7w@mail.gmail.com>
In-Reply-To: <CAJFAV8y=YSgqdt+gtXn37VYZagnMzMCaRg+VQZbmjfQ974vW7w@mail.gmail.com>
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Date: Wed, 23 Sep 2026 16:43:13 -0600
X-Gm-Features: AclHuK9ud8cv4kWNxfevjXwk_gobu8bVWaKtxFDE6maIxV5kixqTcli3eiUFVvE
Message-ID: <CAPTrkjHZgh_ASCsyjh9B=LbUQaGvXGWCJSVHWJmYr+PZavHucQ@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove VMDq support
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 kishore.padmanabha@broadcom.com, Keegan Freyhof <keegan.freyhof@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b3d09d065c2e377d"
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

--000000000000b3d09d065c2e377d
Content-Type: multipart/alternative; boundary="000000000000a75c45065c2e37ea"

--000000000000a75c45065c2e37ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will restore the explicit rejection in v2.

On Tue, Sep 22, 2026 at 1:50=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> On Mon, 21 Sept 2026 at 18:21, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Sun, 20 Sep 2026 21:08:11 -0600
> > Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:
> >
> > > From: Keegan Freyhof <keegan.freyhof@broadcom.com>
> > >
> > > Remove support for the VMDq feature from the driver: the multi-pool
> > > Rx-queue configuration path in bnxt_mq_rx_configure(), the VMDQ VLAN
> > > pool wiring in the L2 filter alloc path, and the max_vmdq_pools/
> > > vmdq_queue_num reporting in dev_info (now always reported as 0).
> > >
> > > Preserved two pieces of logic that live in the same
> > > function/switch statement but are not VMDq-pool-specific: the
> > > RTE_ETH_MQ_RX_RSS pools=3Drx_cosq_cnt case and the
> > > per-non-default-VNIC skip_filter_allocation guard in
> > > bnxt_mq_rx_configure(), both used by the plain multi-COS RSS path.
> > > Also kept the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST ->
> > > l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(): despite the
> > > name, those bits are the standard DPDK VF-rxmode API used regardless
> > > of hardware VMDq pool support, not a VMDq-pool-specific control.
> > >
> > > Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> > > Signed-off-by: Mohammad Shuab Siddique <
> mohammad-shuab.siddique@broadcom.com>
> > > ---
> >
> > [PATCH] net/bnxt: remove VMDq support
> >
> > Warning: mq_mode validation is lost. Before, VMDq, DCB and DCB_RSS
> > modes hit the default case and returned -EINVAL. Now any mode other
> > than NONE or RSS silently configures a single pool and succeeds.
> > Reject every other mq_mode explicitly in bnxt_mq_rx_configure() or
> > dev_configure.
>
> mq_mode should be validated in ethdev now, in next-net.
> 93b017ff2ffa ("ethdev: check VMDq availability")
>
> Is there something missing?
>
> --
> David Marchand
>
>

--=20
Shuab

--000000000000a75c45065c2e37ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;trebuchet ms&quot;,sans-serif">I will restore the explicit r=
ejection in v2.=C2=A0=C2=A0</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2026=
 at 1:50=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand@red=
hat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Mon, 21 Sept 2026 at 18:21, Stephen He=
mminger<br>
&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen=
@networkplumber.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Sun, 20 Sep 2026 21:08:11 -0600<br>
&gt; Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@=
broadcom.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt=
; wrote:<br>
&gt;<br>
&gt; &gt; From: Keegan Freyhof &lt;<a href=3D"mailto:keegan.freyhof@broadco=
m.com" target=3D"_blank">keegan.freyhof@broadcom.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Remove support for the VMDq feature from the driver: the multi-po=
ol<br>
&gt; &gt; Rx-queue configuration path in bnxt_mq_rx_configure(), the VMDQ V=
LAN<br>
&gt; &gt; pool wiring in the L2 filter alloc path, and the max_vmdq_pools/<=
br>
&gt; &gt; vmdq_queue_num reporting in dev_info (now always reported as 0).<=
br>
&gt; &gt;<br>
&gt; &gt; Preserved two pieces of logic that live in the same<br>
&gt; &gt; function/switch statement but are not VMDq-pool-specific: the<br>
&gt; &gt; RTE_ETH_MQ_RX_RSS pools=3Drx_cosq_cnt case and the<br>
&gt; &gt; per-non-default-VNIC skip_filter_allocation guard in<br>
&gt; &gt; bnxt_mq_rx_configure(), both used by the plain multi-COS RSS path=
.<br>
&gt; &gt; Also kept the RTE_ETH_VMDQ_ACCEPT_HASH_UC/BROADCAST/MULTICAST -&g=
t;<br>
&gt; &gt; l2_rx_mask flag mapping in rte_pmd_bnxt_set_vf_rxmode(): despite =
the<br>
&gt; &gt; name, those bits are the standard DPDK VF-rxmode API used regardl=
ess<br>
&gt; &gt; of hardware VMDq pool support, not a VMDq-pool-specific control.<=
br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Keegan Freyhof &lt;<a href=3D"mailto:keegan.freyho=
f@broadcom.com" target=3D"_blank">keegan.freyhof@broadcom.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Mohammad Shuab Siddique &lt;<a href=3D"mailto:moha=
mmad-shuab.siddique@broadcom.com" target=3D"_blank">mohammad-shuab.siddique=
@broadcom.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt;<br>
&gt; [PATCH] net/bnxt: remove VMDq support<br>
&gt;<br>
&gt; Warning: mq_mode validation is lost. Before, VMDq, DCB and DCB_RSS<br>
&gt; modes hit the default case and returned -EINVAL. Now any mode other<br=
>
&gt; than NONE or RSS silently configures a single pool and succeeds.<br>
&gt; Reject every other mq_mode explicitly in bnxt_mq_rx_configure() or<br>
&gt; dev_configure.<br>
<br>
mq_mode should be validated in ethdev now, in next-net.<br>
93b017ff2ffa (&quot;ethdev: check VMDq availability&quot;)<br>
<br>
Is there something missing?<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Shuab</div></div></div></div>

--000000000000a75c45065c2e37ea--

--000000000000b3d09d065c2e377d
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGuzCCBKOg
AwIBAgIMe3qtI1AIrKid6Xt7MA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEwMzg1M1oXDTI3MDYyMTEwMzg1M1owgfgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMIU2lkZGlxdWUxFzAVBgNVBCoTDk1vaGFtbWFkIFNodWFiMRYwFAYDVQQK
Ew1CUk9BRENPTSBJTkMuMS0wKwYDVQQDDCRtb2hhbW1hZC1zaHVhYi5zaWRkaXF1ZUBicm9hZGNv
bS5jb20xMzAxBgkqhkiG9w0BCQEWJG1vaGFtbWFkLXNodWFiLnNpZGRpcXVlQGJyb2FkY29tLmNv
bTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKAmLH8/UOfCDAU7JT4+OcBqdOcNF0Ug
7xCc1Ntnd68sHOfD2JehN5u4/anYsJKtscbyMp3He38rtQKPy3hSQhPtmRbfBky5W1ys13aDtvfm
r5O4ALB8U5We6UUO2+ZzAsXTqL7sRBbhNatmv8Hfj7PcESRxqu7VVsmTl80rErk5PI6LAdE/+G9J
oFiucQWSniUW5EetnWSiHQ7s6joTA86jJxIJK07x7qC9GegHSx1IZ4FabgfuSbiaUw97L++emzwR
LdU4q7vihBD1z1WSXEgMTYmSAPJILKTrvv850PXoh/5LT6B7ulIQZ9AmdqzPAQuC9jGUtDjLUqli
vofjwbMCAwEAAaOCAegwggHkMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEF
BQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
cnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFs
c2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEE
AaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWdu
LmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24u
Y29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwLwYDVR0RBCgwJoEkbW9oYW1tYWQtc2h1YWIuc2lk
ZGlxdWVAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5c
eroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSG5HUWE+7W4aykMqvAMPJyt2xRjjANBgkqhkiG9w0B
AQsFAAOCAgEALm8ZZnO7SkU0kPN+kCI//bT1xRZcv7yJIQTFHCAP+GHGe3qpWC3k9C5o+7hgOWT9
8vH3V1CpZ8f48wINyklyrNqlDXdtPK4d42HP3DdLQzQqV7d4Jg9YViI6lax05Ay2W8Cjp1QasS7s
qKyaFVL9JdiF7quEO+1ZMtbffbiormfoiIDUVMaZ1fqWpUcqpIs7awVPDFIsR/MAUSs1G/1Zbl9w
aBWMSYazZSrhtfAww5ZlCG+WoVhCgV2YVAfbw8Nu6kLeckdJf6FqauwouXqIK42hh1dCqTgRGpQq
1Z7DMDZ91bYBs05JgzHR1T0F57VaO4b9T4kGTsTByzyNTWOyxpugAFfNF0Tk9D3HXsV/LKjKjD4N
6nzoYi2EeN+nIqPHFQNVgRNel70mWnIYfzyxvpgOiAku+Mf265LP+pWeuYpdRgbPWeW92QptHVLJ
xHUOhRjKgziDHnOwMLditWGgi4ZrsQfAESX7UBekNapX7udGNRE+l5xSvMYDMezeaT77wxQIYf5H
kJEu6e8wkjO/YXT72+3ZYPY5zpDa/3tOieHfS3O4SHnwF/DIkFkCpZY6aLo/8RKZ5oBrVsDvId32
aMer3EvJtSphZOrdROgWDn8WjzxCsIpMFMZox9Q8O6F4litYD1lzorw6hhL/2kQpHRibT2M7xzs3
X09O7RJTuMkxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgx7eq0jUAis
qJ3pe3swDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPZ58APQ3FldyapwIPOkpQWu
HHaCrsgEQaRAjV99zpg+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTI2MDkyMzIyNDM1M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEW
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqG
SIb3DQEBAQUABIIBAIZ4NGLb6dfc9zY/WuyGDvPQ8epZmvdVKmayt99xzVEobJO11m/cAoWFa+1T
nW/h703A/X71UMIjNRupedNxIYrmNg2NXaB5gyUQI15IyYRn3yEUbSJWk8/uDyOjvcU7jhMj0kn0
coPipm8JKl8rZrPT+cXcKBjORPJLk0TadYFYxAaOSnoEmewvkCpx9GPYBsmY+GIieyFiIhxeGOhf
V+7ZTX7mDH4t+H6GmDDLRxVN17sQlBM5Q1MT3C6sC4PC27nJ/hFBiRq/rzb0CRS8xM87eShIUCwe
Vs1rh25+esJGNcNkVHIj51VhPQYZEJBQjkIvYj/jtornh4dg//UFwuA=
--000000000000b3d09d065c2e377d--
