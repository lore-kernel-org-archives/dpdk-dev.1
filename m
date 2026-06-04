Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE2CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BFEE4042C;
	Thu,  4 Jun 2026 11:58:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03A44402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780567131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v8qRcYGTXDkehCjPSm+PTNQb0SPgxtq2jCZUnBHeNX4=;
 b=hspunTvoZtq28b7CEpEC+uFiJ/30pmPuZ60d/1TyPW9IKiElMz98s5PsPj024h6uSIKltd
 7KwPzhpCxLAFyRCO1MHi5KO5AR1tgtY6xGMvq6ye0D5ZdQ5HFmbWDIb7ZLTCzqJIs7PdbM
 K2SkBNxeJOgBNGHDdKKXPPNshuereTU=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4UdvJ_t2MAaTGcQ0PYYjFw-1; Thu, 04 Jun 2026 05:58:50 -0400
X-MC-Unique: 4UdvJ_t2MAaTGcQ0PYYjFw-1
X-Mimecast-MFC-AGG-ID: 4UdvJ_t2MAaTGcQ0PYYjFw_1780567129
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso508604c88.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 02:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567129; x=1781171929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8qRcYGTXDkehCjPSm+PTNQb0SPgxtq2jCZUnBHeNX4=;
 b=PQi8FXKvhm6DE3G+udn+B4RoX+HimxjeZcjwu+gkb7BhzrNOtkG36aCGOufMUNClZO
 iYSQnn/wYHv65JZNEZ4aazMFy5vHDFR56SNSZbu+HZZp4RLgyydBDcH1/9Ros1D5Rlvr
 x7bqDXvOs/8sXahtwF3D6zaoQCB3UlaJGtAjul7JDD+LRHM7Hk0rR3o5vubbJzRB0Nsi
 FKjzEyhP7xNwvSwSpSD48LcmsCtoowlPh1eu0gaBWiIETiliOCa7RkB+dWG9YcG5b+JO
 RqzLxpZb1VdPImFcRmRqQMH5XhPciTsCaO7fymVcUjbWxu3wCqSdmgJAgyoIW9MCA+uy
 iOXw==
X-Gm-Message-State: AOJu0YwalPIzgkVetFBN4e+75yOxZYW1fKIbwYZp7DBW3VqaI2g2YOdV
 ftSqjewhV5gBHr4j7gcKFfyIYsPAG2WOT2gmTnhBPaHBgIxzJR3Fw8qVal62gmwB4sqXCb8JhIW
 QM9l4c+wyx50zLaSqdmvov0LUMq9fMf3ytaWQAkxOOPgKPZfsOuMUr7bkoyNGda2FKc2zru3sp5
 g+vwwj7cq6/R1HKFvT3xg=
X-Gm-Gg: Acq92OHxeQsyhTwtRBFq/+kD0+Qdg5pqlR1foWvr84qI2tdjhHYQdOem3n0KsUIz6PA
 OkIle53pgglh5EoWZppK5z6imXksqo8UaIzQhlU9dQ2uAoTdXC2wwzb33rbZHtfVRlUb61z//8+
 7crQSJCZRqCP4cyuTPI5bM/urxReL0YjJl1xYSm/AjOpBE3aIkRUY2g9LcPOKAVBg3tVDZvB+DT
 CaZwZ1RKo/wUgMSCHzp6dYtagK/gyuarZX32ssmRUcEmrhCZDfY0VLTPTpSxNbBtWLb9AFwFGFQ
X-Received: by 2002:a05:7022:f306:b0:12d:d972:b969 with SMTP id
 a92af1059eb24-137f6bdc386mr1463900c88.24.1780567128806; 
 Thu, 04 Jun 2026 02:58:48 -0700 (PDT)
X-Received: by 2002:a05:7022:f306:b0:12d:d972:b969 with SMTP id
 a92af1059eb24-137f6bdc386mr1463892c88.24.1780567128256; Thu, 04 Jun 2026
 02:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260520022012.243619-1-pravin.bathija@dell.com>
 <20260520022012.243619-2-pravin.bathija@dell.com>
In-Reply-To: <20260520022012.243619-2-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 11:58:37 +0200
X-Gm-Features: AVHnY4J9fqO-FskUQy43uPpr_U9WywHlft0bA6uFD4lT_XmYuv5CFKtUQ7A6b4A
Message-ID: <CAO55cszimxnB578R218a1k0WG8QTOBXt8Sty4EEcw5Ca6jcqPQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] vhost: add user to mailmap and define to vhost hdr
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5NZfkWr-PArtZaYxWwmmgvUpiMysnsmQ7KtCiXF-XB4_1780567129
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002dd49906536a97dd"
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

--0000000000002dd49906536a97dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:20=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> - add user to mailmap file.
> - define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>   that depicts if the feature/capability to add/remove memory regions
>   is supported. This is a part of the overall support for add/remove
>   memory region feature in this patchset.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> Acked-by: Fengchengwen <fengchengwen@huawei.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

It was a:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Not a ack.


> ---
>  .mailmap              | 1 +
>  lib/vhost/rte_vhost.h | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 0e0d83e1c6..cc44e27036 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1295,6 +1295,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
>  Prathisna Padmasanan <prathisna.padmasanan@intel.com>
>  Praveen Kaligineedi <pkaligineedi@google.com>
>  Praveen Shetty <praveen.shetty@intel.com>
> +Pravin M Bathija <pravin.bathija@dell.com>
>  Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
>  Prince Takkar <ptakkar@marvell.com>
>  Priyalee Kushwaha <priyalee.kushwaha@intel.com>
> diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
> index 2f7c4c0080..a7f9700538 100644
> --- a/lib/vhost/rte_vhost.h
> +++ b/lib/vhost/rte_vhost.h
> @@ -109,6 +109,10 @@ extern "C" {
>  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
>  #endif
>
> +#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> +#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
> +#endif
> +
>  #ifndef VHOST_USER_PROTOCOL_F_STATUS
>  #define VHOST_USER_PROTOCOL_F_STATUS 16
>  #endif
> --
> 2.43.0
>
>

--0000000000002dd49906536a97dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20,=
 2026 at 4:20=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">pra=
vin.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bat=
hija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
<br>
- add user to mailmap file.<br>
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS<br>
=C2=A0 that depicts if the feature/capability to add/remove memory regions<=
br>
=C2=A0 is supported. This is a part of the overall support for add/remove<b=
r>
=C2=A0 memory region feature in this patchset.<br>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
Acked-by: Fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targe=
t=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber=
.com" target=3D"_blank">stephen@networkplumber.com</a>&gt;<br>
Acked-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com"=
 target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br></blockquote><div>=
<br></div><div>It was a:</div><div>Reviewed-by: Maxime Coquelin &lt;<a href=
=3D"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>&gt;</=
div><div><br></div><div>Not a ack.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0lib/vhost/rte_vhost.h | 4 ++++<br>
=C2=A02 files changed, 5 insertions(+)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 0e0d83e1c6..cc44e27036 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1295,6 +1295,7 @@ Prateek Agarwal &lt;<a href=3D"mailto:prateekag@cse.i=
itb.ac.in" target=3D"_blank">prateekag@cse.iitb.ac.in</a>&gt;<br>
=C2=A0Prathisna Padmasanan &lt;<a href=3D"mailto:prathisna.padmasanan@intel=
.com" target=3D"_blank">prathisna.padmasanan@intel.com</a>&gt;<br>
=C2=A0Praveen Kaligineedi &lt;<a href=3D"mailto:pkaligineedi@google.com" ta=
rget=3D"_blank">pkaligineedi@google.com</a>&gt;<br>
=C2=A0Praveen Shetty &lt;<a href=3D"mailto:praveen.shetty@intel.com" target=
=3D"_blank">praveen.shetty@intel.com</a>&gt;<br>
+Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.com" target=3D"=
_blank">pravin.bathija@dell.com</a>&gt;<br>
=C2=A0Pravin Pathak &lt;<a href=3D"mailto:pravin.pathak.dev@gmail.com" targ=
et=3D"_blank">pravin.pathak.dev@gmail.com</a>&gt; &lt;<a href=3D"mailto:pra=
vin.pathak@intel.com" target=3D"_blank">pravin.pathak@intel.com</a>&gt;<br>
=C2=A0Prince Takkar &lt;<a href=3D"mailto:ptakkar@marvell.com" target=3D"_b=
lank">ptakkar@marvell.com</a>&gt;<br>
=C2=A0Priyalee Kushwaha &lt;<a href=3D"mailto:priyalee.kushwaha@intel.com" =
target=3D"_blank">priyalee.kushwaha@intel.com</a>&gt;<br>
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h<br>
index 2f7c4c0080..a7f9700538 100644<br>
--- a/lib/vhost/rte_vhost.h<br>
+++ b/lib/vhost/rte_vhost.h<br>
@@ -109,6 +109,10 @@ extern &quot;C&quot; {<br>
=C2=A0#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12<br>
=C2=A0#endif<br>
<br>
+#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS<br>
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15<br>
+#endif<br>
+<br>
=C2=A0#ifndef VHOST_USER_PROTOCOL_F_STATUS<br>
=C2=A0#define VHOST_USER_PROTOCOL_F_STATUS 16<br>
=C2=A0#endif<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000002dd49906536a97dd--

