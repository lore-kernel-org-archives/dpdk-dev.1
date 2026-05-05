Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EEFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 09:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B79764060B;
	Tue,  5 May 2026 11:30:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6360B40272
 for <dev@dpdk.org>; Tue,  5 May 2026 11:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777973444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjGmoRxjQ17RNoYRi4b1gK5FRWG0WQ62ynoWSaZlQrc=;
 b=VUsCq0RvN1PnACxheTOpESTyKfoudI8+vBrEZgj/97AQvJL5xJwZ16WtHRQrjSw/0VCTze
 6ap31j5DVEMhwgQj3H6/4jNfENrMm4Sm6l0NO1G86kpgsMmHf4GX/kcSchyFx4xD5wSwSN
 FAhTA1is6jdKgwz/4wfShIpBFcDgNns=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-W2nELjbqPeCevEqD9i14MA-1; Tue, 05 May 2026 05:30:43 -0400
X-MC-Unique: W2nELjbqPeCevEqD9i14MA-1
X-Mimecast-MFC-AGG-ID: W2nELjbqPeCevEqD9i14MA_1777973442
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dc1c0b7ccso5360061c88.1
 for <dev@dpdk.org>; Tue, 05 May 2026 02:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777973442; x=1778578242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjGmoRxjQ17RNoYRi4b1gK5FRWG0WQ62ynoWSaZlQrc=;
 b=qPkhCLi7UGm354nS91KdjGyuji+Ch6OWKBbFSyRvffj/vUGFfZKXu9OMqIVflcEJmu
 7M7DKhyfIPoBAZoCfzxKQndGTmGzy/2Oxs+eNF4Hy5pBk/IrlMKEyelCMoP3L3S29UMX
 em5+GjRoSmZJar8UawmBW5hg+YpMLxLEx4DTOnITj3rWRJy8KPjuOYRK0F07D33hs8vK
 GakFh7EEODvjZ+EeeKO8FOs8DEwxuSArE+1Kr9Lt1M2UeWb3jwBqNeYA20Fi5jGJMHMs
 F28Sx+t/Ez5BiNLHVzDB/DL8cvwTJvSSHFOiyLRdDH8dfY26+339PMGfqz2Ipw/hdW1N
 GjyQ==
X-Gm-Message-State: AOJu0Yzj2DWvY+Ix5m/J1OKZGudwdDR86oafANwp9GyanZ+Cn7291qGJ
 jdtGxmJPoppbKX6rt+F0pag7dJW1NT1AKGNFKIy95KLovRP9rtah6HNs/ExtmDW+NwECiho0l2c
 /NWGZD2f42Nn/cQoWol5sR74/oHqwh+QuZGvQgAcgL5qgXc7Yyqey45AtHL9ivtU8wD6P5NNDoI
 tXty5819PVDIIjh6sSunTmBSms4NE=
X-Gm-Gg: AeBDieteHw56RxjLCC5Egk9fu9H8pTo+Ui5OraKcLbdPeez2LPN8fb47VROdLVHagGY
 PUi+SQs3gOEKkCNYzpAFENXKL845bi3b5p9QB65upNGLKSLK4OeF4A+jBKhBu7VsMs58acJ4eIr
 RAztQo30euSgpMpaTbpfpeFlMpkJSRYN3KiCNSqieIsR2xOe6SP3ys25uoyrEYzox7DvlT7nr4O
 7BTaLgyxqH14Kk9IYglfGIti9cwV5W9r7eKKmyaIuzSwkoSUWY//MCOKuT19ELyOhkAzBZyDSxe
X-Received: by 2002:a05:701b:220f:b0:130:c9dc:1b6d with SMTP id
 a92af1059eb24-130c9dc20eamr110451c88.15.1777973442035; 
 Tue, 05 May 2026 02:30:42 -0700 (PDT)
X-Received: by 2002:a05:701b:220f:b0:130:c9dc:1b6d with SMTP id
 a92af1059eb24-130c9dc20eamr110440c88.15.1777973441459; Tue, 05 May 2026
 02:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260505055251.818594-1-pravin.bathija@dell.com>
 <20260505055251.818594-2-pravin.bathija@dell.com>
In-Reply-To: <20260505055251.818594-2-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 5 May 2026 11:30:28 +0200
X-Gm-Features: AVHnY4KYziFJv6ikxPb9AXhMFESimp-CtThewkLkopCh-3mkRQ-fVV8Uj87Cy1M
Message-ID: <CAO55csxPUFQxkvx0Raa+atEHSqiAKw-QFpHyBd9TGMEkJBxGcA@mail.gmail.com>
Subject: Re: [PATCH v11 1/5] vhost: add user to mailmap and define to vhost hdr
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net, 
 fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yiVNVk7tGZsKf9qGGM27-Q6O7C9cxUGXyZCnhUcp5jU_1777973442
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000006616ba06510eb3d1"
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

--0000000000006616ba06510eb3d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 7:53=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> - add user to mailmap file.
> - define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>   that depicts if the feature/capability to add/remove memory regions
>   is supported. This is a part of the overall support for add/remove
>   memory region feature in this patchset.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
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
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

--0000000000006616ba06510eb3d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 5, =
2026 at 7:53=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">prav=
in.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bath=
ija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
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
<br></blockquote><div><br></div><div>Reviewed-by: Maxime Coquelin &lt;<a hr=
ef=3D"mailto:maxime.coquelin@redhat.com">maxime.coquelin@redhat.com</a>&gt;=
</div><div><br></div><div>Thanks,</div><div>Maxime=C2=A0</div></div></div>

--0000000000006616ba06510eb3d1--

