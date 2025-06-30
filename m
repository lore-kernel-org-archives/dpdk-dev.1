Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6805C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 08:58:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB3C240264;
	Mon, 30 Jun 2025 10:58:54 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 760F44025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 10:58:53 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-60b86fc4b47so14147a12.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751273933; x=1751878733; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b6ykod0kAtSblm3KwgWfIHEn6E16L/IN2TqfN+gk2Jg=;
 b=BG8qV/rLE218yUEJRtlxeKzgGrXBVPKtFOD4AXMvz/Ab7E1JyyzqflWHom/86Q5lJ8
 484A5549aSQsJsZU543S/fPpEDrbgerBDc5FJPJDyUSTAhGxBLm6KLwEM4HXnS4BIbDV
 iiksYRcRlMlRNw5gX5eDd0h2jTpLscHm9TUKV4XydMkAjH2ci04uuhfJmqpK6l5TfCpG
 6x6tgYRDkVyypEKoqBSyYsU/vnN+08DhuPnUVl8n8dfIz6Qjw6X37d2KXhamK4XpRf30
 hepSI30wVopgIUtKSlUKGO+KoXZxBaDMaQzdXpksp8zh1jO3wdv3oNSX4uaNnmAyiDGF
 bpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751273933; x=1751878733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b6ykod0kAtSblm3KwgWfIHEn6E16L/IN2TqfN+gk2Jg=;
 b=gbZr3FIEmCLrF1d37ja8C/CjbNU9DdngovLTJPw3tvjzS7eI8UzccGYb50MqTfxfQW
 xKIvhtFF2HW9xtMc0DAy9CXgQi6Qi3QvpTrQ0/mXTMgunoUVDvqoj1ooK7vPT4CJVAOq
 Fdt8NbQXGzd4mSqQq6M9oUww0brOEKE4+0+74Ksl3NJQzui8zzkEBiH/AcJOC4ft8Qvh
 8SpBGuXiDLg41IpD1MIbfpedq3bNzN2w4qFhtXdoem6zr6V+2mdCf31wYHenKPXYcjml
 HL4g0mcBYfDvzH0AF7Nmj8gk+1FNznuXXg4E8SQ8xoolkem24bwTJf+im47SaQ4R30lN
 6+jA==
X-Gm-Message-State: AOJu0YzMTOXRGQQM9sAgHl/0I/qnolWDT0DJqnMmrvDYY/yzhRagIU96
 A1OS1rKdPUkvYIj/7W8NfBi0Hz38GBf9ZyOOlyrgdMMsHYP8RcufEUCsSoy+VUervLteLEQYb7A
 YtP7Fd8cXJSnWAFNeEyWcSoKxGBRgfI12Ic4RNjxUd1xHUBeDpwNbtxuJIng=
X-Gm-Gg: ASbGncu9j0ABm38RbX3lZo1/KAnHYqkv+9Pi9/p9LrOgf2w4VdDjJBftOSy82i7S6Ig
 7lQrwCKNlabJ5ZPr3l+PCRi6THpZpd3DpGw1HwDqH/jKtmbSlr2s7YW7W7Oi4yfoRYCZeQwNt1m
 8HcIHctfxuMw+hIHMMCPeF/UTa56RZ0zdXZuYPR9zPgfqEjDfa6WzgPZVpZz3L2h87sx6XBZDvY
 2aIip2Ei/hU
X-Google-Smtp-Source: AGHT+IE97OUJkZRcPm7OYb+861XQet6aUosE0KmfuBQAhcm+nHlMObuGxp5tsth5C8VMJkWky+MfYm73TUONgLxWvD4=
X-Received: by 2002:a05:6402:516f:b0:607:30a0:12f4 with SMTP id
 4fb4d7f45d1cf-60ca584182bmr109172a12.5.1751273932623; Mon, 30 Jun 2025
 01:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250618174103.1345466-1-shivajikant@google.com>
 <20250630085052.585867-1-shivajikant@google.com>
In-Reply-To: <20250630085052.585867-1-shivajikant@google.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Mon, 30 Jun 2025 14:28:38 +0530
X-Gm-Features: Ac12FXw9DfcwClo5NfNHr-cL9iOebljMjUY9YCILTPLcGE2WfORmIO1DO7Zn6VM
Message-ID: <CAMEhMpncf_LQsRJpuZ9Custsh66YO6ngF0Pyt+V9KFPOu-3sAA@mail.gmail.com>
Subject: Re: [PATCH v2] net/af_xdp: add rx/tx queue support for af_xdp
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a92dc10638c63c09"
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

--000000000000a92dc10638c63c09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thank you for your review and comments.

Regarding the first sentence of the commit message, you are absolutely
right. I've rephrased it for clarity in v2.

> Is there anything about queues in the driver documentation?

For your question about queues in the driver documentation, the GVE driver
documentation (specifically the
Documentation/networking/device_drivers/google/gve.rst  in the Linux kernel
source) describes the GVE's queue model as having separate RX and TX
queues. While it doesn't explicitly state "combined queues are not
supported," the design clearly indicates a preference for distinct RX and
TX queues, which this patch aims to accommodate for AF_XDP.

I have also corrected the spelling error from "dirvers" to "drivers" in the
code comment.

I've pushed a new version (v2) with these changes. Please let me know if
there are any further issues.

Thanks,
Shivaji

On Mon, Jun 30, 2025 at 2:20=E2=80=AFPM Shivaji Kant <shivajikant@google.co=
m> wrote:

> Drivers like GVE work with rx/tx queue configuration
> rather than combined queue. Enable AF_XDP vdev to use
> rx/tx queue configuration instead of combined queue
> configuration if available.
>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
>
> ---
> Changes in v2:
> - Rephrased the first sentence of the commit message for clarity.
> - Corrected spelling error "dirvers" to "drivers" in code comment.
> ---
>  .mailmap                            |  1 +
>  drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..c67caa7c9d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1423,6 +1423,7 @@ Shijith Thotton <sthotton@marvell.com> <
> shijith.thotton@caviumnetworks.com>
>  Shiqi Liu <835703180@qq.com>
>  Shiri Kuzin <shirik@nvidia.com> <shirik@mellanox.com>
>  Shivah Shankar S <sshankarnara@marvell.com>
> +Shivaji Kant <shivajikant@google.com>
>  Shivanshu Shukla <shivanshu.shukla@intel.com>
>  Shiweixian <shiweixian@huawei.com>
>  Shiyang He <shiyangx.he@intel.com>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c
> b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 05115150a7..5f65850a27 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -168,7 +168,7 @@ struct pmd_internals {
>         int start_queue_idx;
>         int queue_cnt;
>         int max_queue_cnt;
> -       int combined_queue_cnt;
> +       int configured_queue_cnt;
>         bool shared_umem;
>         char prog_path[PATH_MAX];
>         bool custom_prog_configured;
> @@ -2043,11 +2043,11 @@ parse_prog_arg(const char *key __rte_unused,
>
>  static int
>  xdp_get_channels_info(const char *if_name, int *max_queues,
> -                               int *combined_queues)
> +                               int *configured_queues)
>  {
>         struct ethtool_channels channels;
>         struct ifreq ifr;
> -       int fd, ret;
> +       int fd, ret, rxtx_q_count;
>
>         fd =3D socket(AF_INET, SOCK_DGRAM, 0);
>         if (fd < 0)
> @@ -2066,15 +2066,23 @@ xdp_get_channels_info(const char *if_name, int
> *max_queues,
>                 }
>         }
>
> -       if (channels.max_combined =3D=3D 0 || errno =3D=3D EOPNOTSUPP) {
> +       /* For drivers with rx/tx queue configured */
> +       rxtx_q_count =3D RTE_MIN(channels.rx_count, channels.tx_count);
> +
> +       if ((channels.max_combined =3D=3D 0 && rxtx_q_count =3D=3D 0) || =
errno =3D=3D
> EOPNOTSUPP) {
>                 /* If the device says it has no channels, then all traffi=
c
>                  * is sent to a single stream, so max queues =3D 1.
>                  */
>                 *max_queues =3D 1;
> -               *combined_queues =3D 1;
> -       } else {
> +               *configured_queues =3D 1;
> +       } else if (channels.max_combined > 0) {
>                 *max_queues =3D channels.max_combined;
> -               *combined_queues =3D channels.combined_count;
> +               *configured_queues =3D channels.combined_count;
> +               AF_XDP_LOG_LINE(INFO, "Using Combined queues
> configuration");
> +       } else {
> +               *max_queues =3D RTE_MIN(channels.max_rx, channels.max_tx)=
;
> +               *configured_queues =3D rxtx_q_count;
> +               AF_XDP_LOG_LINE(INFO, "Using Rx/Tx queues configuration")=
;
>         }
>
>   out:
> @@ -2215,15 +2223,15 @@ init_internals(struct rte_vdev_device *dev, const
> char *if_name,
>         strlcpy(internals->dp_path, dp_path, PATH_MAX);
>
>         if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
> -                                 &internals->combined_queue_cnt)) {
> +                                 &internals->configured_queue_cnt)) {
>                 AF_XDP_LOG_LINE(ERR, "Failed to get channel info of
> interface: %s",
>                                 if_name);
>                 goto err_free_internals;
>         }
>
> -       if (queue_cnt > internals->combined_queue_cnt) {
> -               AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger
> than combined queue count %d.",
> -                               queue_cnt, internals->combined_queue_cnt)=
;
> +       if (queue_cnt > internals->configured_queue_cnt) {
> +               AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger
> than configured queue count %d.",
> +                               queue_cnt,
> internals->configured_queue_cnt);
>                 goto err_free_internals;
>         }
>
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
>

--000000000000a92dc10638c63c09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Stephen,<br><br>Thank you for your rev=
iew and comments.<br><br>Regarding the first sentence of the commit message=
, you are absolutely right. I&#39;ve rephrased it for clarity in v2.<br><br=
><font color=3D"#741b47">&gt; Is there anything about queues in the driver =
documentation?</font></div><div dir=3D"ltr"><br>For your question about que=
ues in the driver documentation, the GVE driver documentation (specifically=
 the Documentation/networking/device_drivers/google/gve.rst=C2=A0 in the Li=
nux kernel source) describes the GVE&#39;s queue model as having separate R=
X and TX queues. While it doesn&#39;t explicitly state &quot;combined queue=
s are not supported,&quot; the design clearly indicates a preference for di=
stinct RX and TX queues, which this patch aims to accommodate for AF_XDP.<b=
r><br>I have also corrected the spelling error from &quot;dirvers&quot; to =
&quot;drivers&quot; in the code comment.<br><br>I&#39;ve pushed a new versi=
on (v2) with these changes. Please let me know if there are any further iss=
ues.<br><br>Thanks,<br>Shivaji</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 30, 2025 at=
 2:20=E2=80=AFPM Shivaji Kant &lt;<a href=3D"mailto:shivajikant@google.com"=
>shivajikant@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Drivers like GVE work with rx/tx queue configuration=
<br>
rather than combined queue. Enable AF_XDP vdev to use<br>
rx/tx queue configuration instead of combined queue<br>
configuration if available.<br>
<br>
Signed-off-by: Shivaji Kant &lt;<a href=3D"mailto:shivajikant@google.com" t=
arget=3D"_blank">shivajikant@google.com</a>&gt;<br>
Reviewed-by: Joshua Washington &lt;<a href=3D"mailto:joshwash@google.com" t=
arget=3D"_blank">joshwash@google.com</a>&gt;<br>
<br>
---<br>
Changes in v2:<br>
- Rephrased the first sentence of the commit message for clarity.<br>
- Corrected spelling error &quot;dirvers&quot; to &quot;drivers&quot; in co=
de comment.<br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++----------=
-<br>
=C2=A02 files changed, 20 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 8483d96ec5..c67caa7c9d 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1423,6 +1423,7 @@ Shijith Thotton &lt;<a href=3D"mailto:sthotton@marvel=
l.com" target=3D"_blank">sthotton@marvell.com</a>&gt; &lt;<a href=3D"mailto=
:shijith.thotton@caviumnetworks.com" target=3D"_blank">shijith.thotton@cavi=
umnetworks.com</a>&gt;<br>
=C2=A0Shiqi Liu &lt;<a href=3D"mailto:835703180@qq.com" target=3D"_blank">8=
35703180@qq.com</a>&gt;<br>
=C2=A0Shiri Kuzin &lt;<a href=3D"mailto:shirik@nvidia.com" target=3D"_blank=
">shirik@nvidia.com</a>&gt; &lt;<a href=3D"mailto:shirik@mellanox.com" targ=
et=3D"_blank">shirik@mellanox.com</a>&gt;<br>
=C2=A0Shivah Shankar S &lt;<a href=3D"mailto:sshankarnara@marvell.com" targ=
et=3D"_blank">sshankarnara@marvell.com</a>&gt;<br>
+Shivaji Kant &lt;<a href=3D"mailto:shivajikant@google.com" target=3D"_blan=
k">shivajikant@google.com</a>&gt;<br>
=C2=A0Shivanshu Shukla &lt;<a href=3D"mailto:shivanshu.shukla@intel.com" ta=
rget=3D"_blank">shivanshu.shukla@intel.com</a>&gt;<br>
=C2=A0Shiweixian &lt;<a href=3D"mailto:shiweixian@huawei.com" target=3D"_bl=
ank">shiweixian@huawei.com</a>&gt;<br>
=C2=A0Shiyang He &lt;<a href=3D"mailto:shiyangx.he@intel.com" target=3D"_bl=
ank">shiyangx.he@intel.com</a>&gt;<br>
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_e=
th_af_xdp.c<br>
index 05115150a7..5f65850a27 100644<br>
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
@@ -168,7 +168,7 @@ struct pmd_internals {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int start_queue_idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int queue_cnt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int max_queue_cnt;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int combined_queue_cnt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int configured_queue_cnt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool shared_umem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char prog_path[PATH_MAX];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool custom_prog_configured;<br>
@@ -2043,11 +2043,11 @@ parse_prog_arg(const char *key __rte_unused,<br>
<br>
=C2=A0static int<br>
=C2=A0xdp_get_channels_info(const char *if_name, int *max_queues,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *combined_queues)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *configured_queues)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ethtool_channels channels;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ifreq ifr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd, ret, rxtx_q_count;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D socket(AF_INET, SOCK_DGRAM, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0)<br>
@@ -2066,15 +2066,23 @@ xdp_get_channels_info(const char *if_name, int *max=
_queues,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (channels.max_combined =3D=3D 0 || errno =3D=
=3D EOPNOTSUPP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* For drivers with rx/tx queue configured */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rxtx_q_count =3D RTE_MIN(channels.rx_count, cha=
nnels.tx_count);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((channels.max_combined =3D=3D 0 &amp;&amp; =
rxtx_q_count =3D=3D 0) || errno =3D=3D EOPNOTSUPP) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the device sa=
ys it has no channels, then all traffic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is sent to =
a single stream, so max queues =3D 1.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *max_queues =3D 1;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*combined_queues =
=3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*configured_queues =
=3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (channels.max_combined &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *max_queues =3D cha=
nnels.max_combined;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*combined_queues =
=3D channels.combined_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*configured_queues =
=3D channels.combined_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AF_XDP_LOG_LINE(INF=
O, &quot;Using Combined queues configuration&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*max_queues =3D RTE=
_MIN(channels.max_rx, channels.max_tx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*configured_queues =
=3D rxtx_q_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AF_XDP_LOG_LINE(INF=
O, &quot;Using Rx/Tx queues configuration&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 out:<br>
@@ -2215,15 +2223,15 @@ init_internals(struct rte_vdev_device *dev, const c=
har *if_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 strlcpy(internals-&gt;dp_path, dp_path, PATH_MA=
X);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xdp_get_channels_info(if_name, &amp;interna=
ls-&gt;max_queue_cnt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;internals-&gt;combined_qu=
eue_cnt)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;internals-&gt;configured_=
queue_cnt)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AF_XDP_LOG_LINE(ERR=
, &quot;Failed to get channel info of interface: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if_name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_inter=
nals;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (queue_cnt &gt; internals-&gt;combined_queue=
_cnt) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AF_XDP_LOG_LINE(ERR=
, &quot;Specified queue count %d is larger than combined queue count %d.&qu=
ot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_cnt, internals-&gt;combined_que=
ue_cnt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (queue_cnt &gt; internals-&gt;configured_que=
ue_cnt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AF_XDP_LOG_LINE(ERR=
, &quot;Specified queue count %d is larger than configured queue count %d.&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_cnt, internals-&gt;configured_q=
ueue_cnt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_inter=
nals;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-- <br>
2.50.0.727.gbf7dc18ff4-goog<br>
<br>
</blockquote></div></div>

--000000000000a92dc10638c63c09--
