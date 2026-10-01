Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520EFCA5FB3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FDF54027A;
	Thu,  1 Oct 2026 10:30:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3601B40144
 for <dev@dpdk.org>; Thu,  1 Oct 2026 10:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790843445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY3dHkdRy7bUxKyy/9WNdCS5KDo5N5Qp1tO54nPILnA=;
 b=ORyebC03DCQVauIMSh2lRd/68csBbd8upqsV8yQ8CpJaX/J6oUkuHu/PIc0OnnS+QiiYn3
 BLhrhBvKWKKL70E0VBXadEyGtgaa9OQVe1jWnmuBKe2Q9L2dP+b9Vf8ldiaQRLMZQv8AMr
 /AxroKc7hq3dzf/KwZdzOg8Kx4Ba6aI=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-EbC3TbpKNdaHrwL1wA3nNQ-1; Thu, 01 Oct 2026 04:30:42 -0400
X-MC-Unique: EbC3TbpKNdaHrwL1wA3nNQ-1
X-Mimecast-MFC-AGG-ID: EbC3TbpKNdaHrwL1wA3nNQ_1790843441
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14373747468so5802351c88.1
 for <dev@dpdk.org>; Thu, 01 Oct 2026 01:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790843441; x=1791448241;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cY3dHkdRy7bUxKyy/9WNdCS5KDo5N5Qp1tO54nPILnA=;
 b=voACNgXxq4zc2foi2rsBn75dTPqUaMT0dqYAHuMcL+WQWh2wC8OW6eV69HuWCwRLiz
 e0mr3nzHaYhuSVKEX++DePkBivS/YPJ63nT+arXcJDnmuQg5AsiHpzSZZw7/bC8DlZMx
 DwGL3Tq8EulrP5/tDH9oXfrL2+GI470anI7DqbT2vP+b5hkJLqi9U4h4M2RbeJc9f+v4
 ucNL42kwygaT+i00byu3lg7VzAFVct1jPlIbNl2ihm8lJIvnJgY9G9bEScPVizYVtLdi
 VfKz0cewv42xHUaOjlV+h78XlRAHeKlbN5n1mQdogPH7hQ0nS/twY26byTBjRYYwi68e
 M74A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrKBEqWQm11atg0YAP7vMKjn9d0EO0kqQLQdIt8DEHweAYYunNaNCGR2zS54lZOnel/Q8=@dpdk.org
X-Gm-Message-State: AFuF++nyWzpttavVOOYSoZXYZjbuGEQDA41SxpKdaHJPcg4deFzvftNL
 5eFSlLN+wozG9qpkKbd67d+TsrAGvPDPEj+VVtG39rLFykFgm9vjXB0VhMTHySRcqVKsdCCxcHA
 n/t5nE9UU6r64LVFAYNOgxQ3TKQLLStrqOSsdCU1LgR6yN+Bdho8SME/C6lBE5Gy9xNSeKFqSEY
 vOk8TBFWM0SPkRl5FY4oI=
X-Gm-Gg: AYBFou31/oJNfIPq9IgTVatSLt3vRVbwwXz5Md0OB+BoLYmBenJj0QDvVTLGPqtbQUU
 GNvJbpCCZ6YR2PNji6MFO2faaOlp6u1FPoOwAOyvhSBjD5MPt1YQDK/wBkzolRm08irq74hXUWy
 j5w1KkAfx6MVoBF5sjoY7uxAe3PU6McSRdi/aRAqDMa2D4ABH1f9taJXBaG/r+SdGZl0uGZLBVL
 Cje1V0YJKiiRa/Yxn2+oS9rgtJH5sfpTtsPDzrHto1l5TC5cX1PJ2GG7emWGyC8mWMDoICm+XBw
 KEDFCzgW6qdt6dnPWwHtvrSvMoXkZPQAKUq31uNgjok=
X-Received: by 2002:a05:7022:158b:b0:148:4d6c:201e with SMTP id
 a92af1059eb24-14d33f3abd8mr4330921c88.23.1790843440553; 
 Thu, 01 Oct 2026 01:30:40 -0700 (PDT)
X-Received: by 2002:a05:7022:158b:b0:148:4d6c:201e with SMTP id
 a92af1059eb24-14d33f3abd8mr4330883c88.23.1790843439954; Thu, 01 Oct 2026
 01:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-2-maxime.coquelin@redhat.com>
 <20260930082638.0932a5e9@phoenix.local>
 <CAO55cszUi99k3vjKTQh31QArHxpq_65HK1sKS2AdTW4TzLSSwg@mail.gmail.com>
 <CAJFAV8xRTkAbOo-c5hp75ChtVJoLct4fh5jR4-rYZEU8u576WQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xRTkAbOo-c5hp75ChtVJoLct4fh5jR4-rYZEU8u576WQ@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 1 Oct 2026 10:30:28 +0200
X-Gm-Features: AclHuK8kEK9LhX8IQPv8AlMnV5sO1IIQ2rqIkfqOKfq20ljzcbowdKzgMnrF9o8
Message-ID: <CAO55cswLKcxMdTYMXZaBPFy1gW0BAjQSOBGasEqjimoytGkhoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: add compatibility for old compilers with new
 UAPI headers
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 eperezma@redhat.com, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u_zQf-tRTYR6GKcJDf7q7Gpfh64OScScLFpWKus4JgE_1790843441
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000001654c0065cc33bfc"
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

--0000000000001654c0065cc33bfc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:19=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> On Wed, 30 Sept 2026 at 17:37, Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
> > On Wed, Sep 30, 2026 at 5:26=E2=80=AFPM Stephen Hemminger <
> stephen@networkplumber.org> wrote:
> >>
> >> On Wed, 30 Sep 2026 11:57:59 +0200
> >> Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
> >>
> >> > This patch adds a compatibility define for __counted_by attribute,
> >> > which is not present in older compilers but required for recent UAPI
> >> > headers like vfio.h.
> >> >
> >> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >> > ---
> >> >  config/rte_config.h | 9 +++++++++
> >> >  1 file changed, 9 insertions(+)
> >> >
> >> > diff --git a/config/rte_config.h b/config/rte_config.h
> >> > index 0447cdf2ad..307e7dac62 100644
> >> > --- a/config/rte_config.h
> >> > +++ b/config/rte_config.h
> >> > @@ -25,6 +25,15 @@
> >> >  #define RTE_TOOLCHAIN_MSVC 1
> >> >  #endif
> >> >
> >> > +/*
> >> > + * Compatibility define for Linux kernel UAPI headers that may use
> __counted_by
> >> > + * attribute for bounds checking. This attribute is not understood
> by userspace
> >> > + * compilers, so define it as empty if not already provided.
> >> > + */
> >> > +#ifndef __counted_by
> >> > +#define __counted_by(m)
> >> > +#endif
> >> > +
> >> >  /* legacy defines */
> >> >  #ifdef RTE_EXEC_ENV_LINUX
> >> >  #define RTE_EXEC_ENV_LINUXAPP 1
> >>
> >> NAK this is best done by keeping up to date stddef over in virtio
> headers.
> >
> > This is for VFIO, not Virtio but that does not change the issue.
> >
> > Problem is importing stddef in UAPI as currently done, does not work,
> > because the system version is included first so the imported one is
> discarded.
> >
> > An alternative solution I tested would be to include the imported
> headers first,
> > but it means imported headers get silently intermixed, which worked in
> my test
> > but could lead to hard to debug issues.
>
> I don't like the alternative, for the reason you listed, plus the fact
> that this intermixing is invisible.
> At the moment, using an imported uapi header is opt-in, and I prefer
> it like this.
>
>
> > While not ideal, the solution proposed in this patch is harmless, we ar=
e
> talking
> > about an attribute defined as empty.
>
> Your solution of wrapping __counted_by is simple.
>
> On the other hand, fixing the existing import script would require
> relying on an external tool (unifef), which could be acceptable.
>

Your solution is certainly more future-proof.
If others agree, can you send a series that supersedes mine so that we can
get it merged early?
Eugenio will need to rebase his series on top of it.

Thanks,
Maxime

> I tried some:
>
> diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
> index dbf3163bc8..189164928c 100755
> --- a/devtools/linux-uapi.sh
> +++ b/devtools/linux-uapi.sh
> @@ -13,6 +13,9 @@ file=3D""
>  check_headers=3Dfalse
>  quiet=3Dfalse
>
> +# Require unifdef
> +unifdef -h 2>&1 >/dev/null || { echo "This script requires unifdef.";
> exit 1; }
> +
>  print_usage()
>  {
>         echo "Usage: $(basename $0) [-h] [-i FILE] [-u VERSION] [-c] [-q]=
"
> @@ -85,6 +88,9 @@ fixup_includes()
>         sed -i 's|#\(define\)[[:space:]]*_UAPI|#\1 |' $path
>         sed -i 's|#\(endif[[:space:]]*/[*]\)[[:space:]]*_UAPI|#\1 |' $pat=
h
>
> +       unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ -o ${path}.tmp
> $path || [ $? -lt 2 ]
> +       mv -f ${path}.tmp $path
> +
>         # Prepend include path with "uapi/" if the header is imported
>         for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
>                 if [ -f "$base_path$include" ]; then
> diff --git a/doc/guides/contributing/linux_uapi.rst
> b/doc/guides/contributing/linux_uapi.rst
> index b8febfc420..a3490bfbb6 100644
> --- a/doc/guides/contributing/linux_uapi.rst
> +++ b/doc/guides/contributing/linux_uapi.rst
> @@ -27,6 +27,8 @@ Importing or updating an uAPI header file
>  To ensure that imported uAPI headers are unmodified
>  and sourced from an official Linux kernel release,
>  a helper script is provided and must be used.
> +This script requires the ``unifdef`` tool.
> +
>  Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10`=
`:
>
>  .. code-block:: console
>
>
> Then imported linux/types.h, linux/posix_types.h and linux/stddef.h.
>
> And net/nbl needs some fixing... as it includes uapi/linux/vfio.h too
> late...
> Only occurence in the whole DPDK tree:
> $ git grep -l '# *include.*uapi' :^devtools/linux-uapi.sh
> :^doc/guides/contributing/linux_uapi.rst | while read file; do [ $(git
> grep -B100 '# *include.*uapi' $file | grep '# *include' | wc -l) =3D 1 ]
> || echo $file; done
> drivers/net/nbl/nbl_common/nbl_userdev.c
>
>
> --
> David Marchand
>
>

--0000000000001654c0065cc33bfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 1, =
2026 at 10:19=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchan=
d@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Wed, 30 Sept 2026 at 17:37, Maxim=
e Coquelin<br>
&lt;<a href=3D"mailto:maxime.coquelin@redhat.com" target=3D"_blank">maxime.=
coquelin@redhat.com</a>&gt; wrote:<br>
&gt; On Wed, Sep 30, 2026 at 5:26=E2=80=AFPM Stephen Hemminger &lt;<a href=
=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen@networkplu=
mber.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 30 Sep 2026 11:57:59 +0200<br>
&gt;&gt; Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com" =
target=3D"_blank">maxime.coquelin@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; &gt; This patch adds a compatibility define for __counted_by attri=
bute,<br>
&gt;&gt; &gt; which is not present in older compilers but required for rece=
nt UAPI<br>
&gt;&gt; &gt; headers like vfio.h.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.c=
oquelin@redhat.com" target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br=
>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 config/rte_config.h | 9 +++++++++<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/config/rte_config.h b/config/rte_config.h<br>
&gt;&gt; &gt; index 0447cdf2ad..307e7dac62 100644<br>
&gt;&gt; &gt; --- a/config/rte_config.h<br>
&gt;&gt; &gt; +++ b/config/rte_config.h<br>
&gt;&gt; &gt; @@ -25,6 +25,15 @@<br>
&gt;&gt; &gt;=C2=A0 #define RTE_TOOLCHAIN_MSVC 1<br>
&gt;&gt; &gt;=C2=A0 #endif<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +/*<br>
&gt;&gt; &gt; + * Compatibility define for Linux kernel UAPI headers that m=
ay use __counted_by<br>
&gt;&gt; &gt; + * attribute for bounds checking. This attribute is not unde=
rstood by userspace<br>
&gt;&gt; &gt; + * compilers, so define it as empty if not already provided.=
<br>
&gt;&gt; &gt; + */<br>
&gt;&gt; &gt; +#ifndef __counted_by<br>
&gt;&gt; &gt; +#define __counted_by(m)<br>
&gt;&gt; &gt; +#endif<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 /* legacy defines */<br>
&gt;&gt; &gt;=C2=A0 #ifdef RTE_EXEC_ENV_LINUX<br>
&gt;&gt; &gt;=C2=A0 #define RTE_EXEC_ENV_LINUXAPP 1<br>
&gt;&gt;<br>
&gt;&gt; NAK this is best done by keeping up to date stddef over in virtio =
headers.<br>
&gt;<br>
&gt; This is for VFIO, not Virtio but that does not change the issue.<br>
&gt;<br>
&gt; Problem is importing stddef in UAPI as currently done, does not work,<=
br>
&gt; because the system version is included first so the imported one is di=
scarded.<br>
&gt;<br>
&gt; An alternative solution I tested would be to include the imported head=
ers first,<br>
&gt; but it means imported headers get silently intermixed, which worked in=
 my test<br>
&gt; but could lead to hard to debug issues.<br>
<br>
I don&#39;t like the alternative, for the reason you listed, plus the fact<=
br>
that this intermixing is invisible.<br>
At the moment, using an imported uapi header is opt-in, and I prefer<br>
it like this.<br>
<br>
<br>
&gt; While not ideal, the solution proposed in this patch is harmless, we a=
re talking<br>
&gt; about an attribute defined as empty.<br>
<br>
Your solution of wrapping __counted_by is simple.<br>
<br>
On the other hand, fixing the existing import script would require<br>
relying on an external tool (unifef), which could be acceptable.<br></block=
quote><div><br></div><div>Your solution is certainly more future-proof.</di=
v><div>If others agree, can you send a series that supersedes mine so that =
we can get it merged early?</div><div>Eugenio will need to rebase his serie=
s on top of it.</div><div>=C2=A0</div><div>Thanks,</div><div>Maxime</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
I tried some:<br>
<br>
diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh<br>
index dbf3163bc8..189164928c 100755<br>
--- a/devtools/linux-uapi.sh<br>
+++ b/devtools/linux-uapi.sh<br>
@@ -13,6 +13,9 @@ file=3D&quot;&quot;<br>
=C2=A0check_headers=3Dfalse<br>
=C2=A0quiet=3Dfalse<br>
<br>
+# Require unifdef<br>
+unifdef -h 2&gt;&amp;1 &gt;/dev/null || { echo &quot;This script requires =
unifdef.&quot;; exit 1; }<br>
+<br>
=C2=A0print_usage()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Usage: $(basename $0) [-h] [-i FILE]=
 [-u VERSION] [-c] [-q]&quot;<br>
@@ -85,6 +88,9 @@ fixup_includes()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -i &#39;s|#\(define\)[[:space:]]*_UAPI|#\1 =
|&#39; $path<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -i &#39;s|#\(endif[[:space:]]*/[*]\)[[:spac=
e:]]*_UAPI|#\1 |&#39; $path<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ -o =
${path}.tmp<br>
$path || [ $? -lt 2 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mv -f ${path}.tmp $path<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Prepend include path with &quot;uapi/&quot; i=
f the header is imported<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for include in $(sed -ne &#39;s/^#include &lt;\=
(.*\)&gt;$/\1/p&#39; $path); do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -f &quot;$base=
_path$include&quot; ]; then<br>
diff --git a/doc/guides/contributing/linux_uapi.rst<br>
b/doc/guides/contributing/linux_uapi.rst<br>
index b8febfc420..a3490bfbb6 100644<br>
--- a/doc/guides/contributing/linux_uapi.rst<br>
+++ b/doc/guides/contributing/linux_uapi.rst<br>
@@ -27,6 +27,8 @@ Importing or updating an uAPI header file<br>
=C2=A0To ensure that imported uAPI headers are unmodified<br>
=C2=A0and sourced from an official Linux kernel release,<br>
=C2=A0a helper script is provided and must be used.<br>
+This script requires the ``unifdef`` tool.<br>
+<br>
=C2=A0Below is an example to import ``linux/vduse.h`` file from Linux ``v6.=
10``:<br>
<br>
=C2=A0.. code-block:: console<br>
<br>
<br>
Then imported linux/types.h, linux/posix_types.h and linux/stddef.h.<br>
<br>
And net/nbl needs some fixing... as it includes uapi/linux/vfio.h too late.=
..<br>
Only occurence in the whole DPDK tree:<br>
$ git grep -l &#39;# *include.*uapi&#39; :^devtools/linux-uapi.sh<br>
:^doc/guides/contributing/linux_uapi.rst | while read file; do [ $(git<br>
grep -B100 &#39;# *include.*uapi&#39; $file | grep &#39;# *include&#39; | w=
c -l) =3D 1 ]<br>
|| echo $file; done<br>
drivers/net/nbl/nbl_common/nbl_userdev.c<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div></div>

--0000000000001654c0065cc33bfc--

