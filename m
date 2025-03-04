Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67753C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 17:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABEE2402EB;
	Tue,  4 Mar 2025 18:48:33 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 1573B402E2
 for <dev@dpdk.org>; Tue,  4 Mar 2025 18:48:32 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5e0b70fb1daso10258919a12.1
 for <dev@dpdk.org>; Tue, 04 Mar 2025 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741110512; x=1741715312; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7RYLkVuSiNZp0o5AOgierDh884RKPp4U0BkQFhC2uQ4=;
 b=NikwLo4EbwS2YRKxOMBaUNtd90NuZjf3KTL9w+1SyYzbFm4M9vrQaQVhZxBgRw4Vhe
 aoZNfQjuf6V7+NrGUpfjbQO1Mt1nV+8pwUiYo/DwCHb7TLCCsI8uAyh5vGcrxrYkXPc6
 WYZndc8UKR+JW37J4oqKA0DH7V4b4y50Ewj3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741110512; x=1741715312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RYLkVuSiNZp0o5AOgierDh884RKPp4U0BkQFhC2uQ4=;
 b=AcmTMjjRpuRH0fmJrprzYRLnlMfYMQjxvRDqCeDh57qBcR3ze6W3ijqn3jWmlBx1Ph
 qI8HRX/lKcCzkDog8twCS2+3f1yuaGdRxMhWsQn7Es8B1sIFRK3W6YdFidRQFE7Rzf8S
 yHhPWx/vHwlllrwFhQsRKl/Aejqn0C3xFEbCvf/8Xa58yB7HK9QFLVAxpvnU5fIiKDQ1
 DzO1/lgkiEsI6BiD2DPKCrxEf5lbPT+k0ouLYEq0j7ni84SdHrSDVnfKWI2CUqPLIiVB
 ZPHXk5X9+ncvof0cndNW1fBnG8oKfQ0htb4Wd2obvqcAxfg0r70ZTV5Url/DYwI/+0Dx
 XqNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gPx0rPqeGUaoJ4yYhBkELkce+2Wr1f1J5TDtc4BAyEQ65DR66wucHM0giBi2NiCAMao=@dpdk.org
X-Gm-Message-State: AOJu0Yx7Pk0IFSkg0o++6D0OEZwgaWgVOpZCqIyRm/miKX9seVloizA5
 FAK9vd5RhAvFvnR0QLdWjM6vAnxpQEDcdTM/0RIt6IMlAUTCJR9aS/RczV9mBDenIi+Aaz8yvmF
 +IIDyex/q5D/WIk5ALic5MTHDxCQ55bI3VXWC1XUJLI0jfQgrm9y9KT+JqilQeMDpgz6cNE3Ohm
 HNZgfr
X-Gm-Gg: ASbGncspK5hUZMK9WO4Rl77LOfdOxG32k5+JMbR+v8kNjS1Zg9A2CdMqCi4KYUPjHb2
 /gXxBBfsyRNt4xbVNULf9m3LyNyTTh2YQB7GXvAQFI/bMv1q7po9mogFE1pPq54FcT19dZMpt8H
 +kxDCoawlcpeCa372UKCUzLnU3k88=
X-Google-Smtp-Source: AGHT+IHbrTXj/yi3DGhWJdEi7lG7rnexnQNc4kTr7sIAzQCQD/DimR9MqKnRlAhNsw1J93Pdz6fVcwugfX0SYaI0Rto=
X-Received: by 2002:a17:906:478b:b0:ac1:df32:ac27 with SMTP id
 a640c23a62f3a-ac20dafc617mr14729166b.53.1741110511756; Tue, 04 Mar 2025
 09:48:31 -0800 (PST)
MIME-Version: 1.0
References: <b62e330e086126415f7b4987a9747ce2@mail.gmail.com>
 <CACZ4nhuSCiD6gNzF2GFXVoAD__f0oOgu8fXCwRYy6UGMDy3atQ@mail.gmail.com>
 <15378777.dW097sEU6C@thomas>
In-Reply-To: <15378777.dW097sEU6C@thomas>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 4 Mar 2025 12:48:14 -0500
X-Gm-Features: AQ5f1JqZYj55L7doH2OWFTCrrIFMZ-7n60u1It0wDcue9pMowVtOFuh6_1tE-uU
Message-ID: <CA+BST0ksp01yEEparBXw=WfqYxRZR7Yekq_dWoJbA+xZF-Dk4A@mail.gmail.com>
Subject: Re: MPLS Push action
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Ferruh.yigit@xilinx.com, 
 qi.z.zhang@intel.com, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000097d61f062f87e150"
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

--00000000000097d61f062f87e150
Content-Type: multipart/alternative; boundary="0000000000009193d7062f87e16c"

--0000000000009193d7062f87e16c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Mar 3, 2025 at 2:25=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:

> Hi,
>
> This is the related code:
>
> /**
>  * RTE_FLOW_ACTION_TYPE_OF_PUSH_MPLS
>  *
>  * Implements OFPAT_PUSH_MPLS ("push a new MPLS tag") as defined by the
>  * OpenFlow Switch Specification.
>  */
> struct rte_flow_action_of_push_mpls {
>     rte_be16_t ethertype; /**< EtherType. */
> };
>

 That is correct, it is related to the MPLS push action.

>
>

> > On Mon, Mar 3, 2025 at 8:02=E2=80=AFAM Kishore Padmanabha
> > <kishore.padmanabha@broadcom.com> wrote:
> > >
> > > Hi,
> > >
> > > Anyone has any inputs on this. Or should I add new CLI commands in
> testpmd to support action for push MPLS tag.
>
> This action was designed as an OpenFlow implementation.
> Is what you require an OpenFlow spec?
> If yes, we may consider an update,
> if no, we should create a new action.
>
>  The openflow spec
https://opennetworking.org/wp-content/uploads/2014/10/openflow-switch-v1.5.=
1.pdf
has mention of the MPLS push action but it does not mention how to specify
how to configure the mpls label, TC and BOS.

> > >
> > > Thanks,
> > >
> > > Kishore
> > >
> > > From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> > > Sent: Thursday, February 27, 2025 6:35 PM
> > > To: 'dev@dpdk.org' <dev@dpdk.org>
> > > Subject: MPLS Push action
> > >
> > > Hi,
> > >
> > > When MPLS push action is used, using testpmd action  of_push_mpls, it
> accepts the ethertype only. How do I specify the MPLS label and other
> fields for the MPLS header to be added ? In the doc, in section 7.2.3.7
> there is mention of OFXPMT_OFB_MPLS_LABEL and other MPLS fields, but I
> could not find that in dpdk implementation.
>
> What is this documentation?
> Please provide a link.
>
> The above label is only mentioned for match and it is documented in
https://opennetworking.org/wp-content/uploads/2014/10/openflow-switch-v1.5.=
1.pdf
section 7.2.3.7

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000009193d7062f87e16c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Thomas,</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 3, 2025 a=
t 2:25=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net=
">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Hi,<br>
<br>
This is the related code:<br>
<br>
/**<br>
=C2=A0* RTE_FLOW_ACTION_TYPE_OF_PUSH_MPLS<br>
=C2=A0*<br>
=C2=A0* Implements OFPAT_PUSH_MPLS (&quot;push a new MPLS tag&quot;) as def=
ined by the<br>
=C2=A0* OpenFlow Switch Specification.<br>
=C2=A0*/<br>
struct rte_flow_action_of_push_mpls {<br>
=C2=A0 =C2=A0 rte_be16_t ethertype; /**&lt; EtherType. */<br>
};<br></blockquote><div>=C2=A0</div><div>=C2=A0That is correct, it is relat=
ed to the MPLS push action.</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; On Mon, Mar 3, 2025 at 8:02=E2=80=AFAM Kishore Padmanabha<br>
&gt; &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com" target=3D"_blan=
k">kishore.padmanabha@broadcom.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; Anyone has any inputs on this. Or should I add new CLI commands i=
n testpmd to support action for push MPLS tag.<br>
<br>
This action was designed as an OpenFlow implementation.<br>
Is what you require an OpenFlow spec?<br>
If yes, we may consider an update,<br>
if no, we should create a new action.<br>
<br></blockquote><div>=C2=A0The openflow spec=C2=A0<a href=3D"https://openn=
etworking.org/wp-content/uploads/2014/10/openflow-switch-v1.5.1.pdf">https:=
//opennetworking.org/wp-content/uploads/2014/10/openflow-switch-v1.5.1.pdf<=
/a></div><div>has mention=C2=A0of the MPLS push action but it does not ment=
ion how to specify how to configure the mpls label, TC and BOS.</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Kishore<br>
&gt; &gt;<br>
&gt; &gt; From: Kishore Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha=
@broadcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</a>&gt;<br=
>
&gt; &gt; Sent: Thursday, February 27, 2025 6:35 PM<br>
&gt; &gt; To: &#39;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dp=
dk.org</a>&#39; &lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@d=
pdk.org</a>&gt;<br>
&gt; &gt; Subject: MPLS Push action<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; When MPLS push action is used, using testpmd action=C2=A0 of_push=
_mpls, it accepts the ethertype only. How do I specify the MPLS label and o=
ther fields for the MPLS header to be added ? In the doc, in section 7.2.3.=
7 there is mention of OFXPMT_OFB_MPLS_LABEL and other MPLS fields, but I co=
uld not find that in dpdk implementation.<br>
<br>
What is this documentation?<br>
Please provide a link.<br>
<br></blockquote><div>The above label is only mentioned for match and it is=
 documented in=C2=A0<a href=3D"https://opennetworking.org/wp-content/upload=
s/2014/10/openflow-switch-v1.5.1.pdf">https://opennetworking.org/wp-content=
/uploads/2014/10/openflow-switch-v1.5.1.pdf</a> section 7.2.3.7</div><div><=
br></div></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--0000000000009193d7062f87e16c--

--00000000000097d61f062f87e150
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBV4wggRGoAMCAQICDGgm/w/0NSlGWEAE2zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE5MTJaFw0yNTA5MTAwODE5MTJaMIGa
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGzAZBgNVBAMTEktpc2hvcmUgUGFkbWFuYWJoYTEuMCwGCSqG
SIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAO2KIuHym2NK8LJKtVibxyL/jOwnjzOIbXwiGiJPTo8T3NfkkTIJ4jDc
o06M9E2KoIo4ve+92WrMmLwu6T+HphBMDOfwXxaFLJqYOTdp/DuZNUCmlXtWkO6YZ60qdFOP+pZI
0kEta7Kj9i8JM6kC6NChp3t27AlN/Cmo7PEvyRBXKKzBuKV8xxlaTxbs5z63gvCk4AACEUoMhT3G
OFoe9ghMyQPTG+PhUrwVfqQhB5Cq/UEBY+ML9HK5T2vnfQ6/7Ujo6SRjlDcMKCMt1fsldmDnws3R
dW+s1pbDZSF3o7LAMPaZD1K6+7+kfhg5PhpHobmqdkKh77/wagvxKPOjt2ECAwEAAaOCAeAwggHc
MA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
dDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFs
c2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+
oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
sUAuVxt1XArsF6SqOey0deblHSAwDQYJKoZIhvcNAQELBQADggEBABnnHNuTT9JPO0hVqI1+MhBA
mqeMl+tCr/6T161Uv4ra668I1pNZsS/xjmtHYG6uH7m0k09RdNZFerHwtvsaDs1ueuDic62X1xzE
d5pE71+eY7IXZyt7JOzujKMjBT1ll9ksv900PSfepOhlts+qt39mfsK3GFpWucs5yPQW4QdANh1g
QQvpKuVIATCT7bbi97PnmyBbqR4lilWpd720IqWfp2so0ihV+YqcZebbT5leoAa/bHgoDUx+ejzc
Uk12jX97cL/DKIHD0pff67TlZq5ZjltzVjTA0XaUzEak9bSqclhSSbSbYHhRDR4syFcEWXQRxou7
RctJp8+CIW2Aci4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgxoJv8P9DUpRlhABNswDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPVtXCbw
1dUA0mnMjNJdodxXnFJ6oZFeVG8YVpXo6GeDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDMwNDE3NDgzMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZI
AWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJ64qOxUh8vRfWPj/63+2Em6MP32dGJwMCtA2PIawVVH
iBEdUrbWq1nV6EHfEaYyEgBTJfHYfnBvaVGc827znW7juxFo9llQzqQ64U5VzdgV7FbWtIBK65rn
0U2lljzYUkHcUPjGXGBCdbbALOBsc7WvUpCOiLzMPnmB7OsRzxRsWpdIj4yDrIE/Gm/qqNjfm98k
gzIImMzIYzcnza+AAchtXx/zwW+appEN9onJIpouVHIC6c0kQI6+YrErrGtPkMIPTUWU5f8TJghj
qKciyGCJteRl50a419fV+/Y3E/fv/hRNGsmNzAe2kyY+wwsXapXCibco+2xze6iIDsdX1Lk=
--00000000000097d61f062f87e150--
