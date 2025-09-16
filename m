Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0DDCAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2825F402C4;
	Tue, 16 Sep 2025 15:21:26 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 25AAC402C2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:21:24 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b4d4881897cso3564178a12.0
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758028883; x=1758633683; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IMo7BJzkb5OfDMiQKDcbaskFWhnSTOtE3/Kuqcr8XC8=;
 b=hYIHxlMkETuZOycjHuquXFTA5iR9qBF7uTZu6Vhql46EvyNLDIe+xtxHD9VAbHv9qI
 ZOSTBiD/3xGPMYahYzmL5MIl6YeoL8jrE20XHz0m3+YyQ1BJxbDbXejU29CB8U3234jx
 YWKM0IqUq8Rr8hUNXlnjVaeimmpl2XlhXnnGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758028883; x=1758633683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IMo7BJzkb5OfDMiQKDcbaskFWhnSTOtE3/Kuqcr8XC8=;
 b=vwht5y7xbI0q3qUeYHajPVrzvftJkmVjYgDAk4O2NHG8EvU79oJww0bOhTDxoOopqd
 ZUtgjexL7Ia9DmdC/oWnWByr5SxWFaRVEwPSjti4+YOho9dRKEaHhJ/sI/5/CE6KFtKv
 WwwyJdJB8GeirZ1gPS4Sbfsrnp6fnpBGkq1365TGYM0ofr4m+J0gP3J/yS54gP8KvxUy
 PGXbOIlhJwQC156hUwu1UAPBtZ0zQW6LUaZ3SYRYQH1R8+35YGvu/zXLYYNrHXlAWaYP
 VoulrPqGviPIQdNAwK7M63cVNJKatoN9AOtbDynwJAvqGmiB0dhu76jIkIq15IJCmdTw
 rVQg==
X-Gm-Message-State: AOJu0Yw9cEilQU3zUhY+glPCs1XWrLTaVUvb2iYuk+sa+QdczjN6BJg2
 JQlGprhml6j8XJgP8DKYJnBlmw8FfcnilTx5n2DHI/ChzJ9HYWG5zZpaSpET8U2uytBKqzURmJ0
 IMF3SqZgqNGPByOT2vc8iCL980LudNUUR1m+BJoLc8S4ixFvgCppG
X-Gm-Gg: ASbGncsDN6VAVy6EKndRlSYYikp15dB5/v/qppND5+al7ze0DADVxgRBJ9aO+0JDSej
 Js/4enr1D8o1l0s1aoM18cowO/lzGcW8DKvWZzDl+2K3bA3i6ZwvG916mrMOIFzjoSV+s2kdzgR
 YbxvEer99joe06VHWX3I2FnE7whOomN/cjj7eC4brhJWsXZ4ZQnUrhi7cosU6THwAtQxcZkbTTa
 RZwJ9NiNNpMC3kG23KT2/js+UblrHb1tz7eopyD
X-Google-Smtp-Source: AGHT+IHT/VP3iO5cwz2oDrKvujKU586jsLqTsV3EQvAvRSjz0CidQ9DfjshDaEb4FLZW5vXwherD7Vlnpg5/2fVkR20=
X-Received: by 2002:a17:902:fc4c:b0:263:d6b5:fbe1 with SMTP id
 d9443c01a7336-263d6b60724mr113474025ad.55.1758028883167; Tue, 16 Sep 2025
 06:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
 <20250908212034.699713-4-thomas@monjalon.net>
In-Reply-To: <20250908212034.699713-4-thomas@monjalon.net>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 16 Sep 2025 09:14:20 -0400
X-Gm-Features: AS18NWCc0REGXXlk5D75RqcKJx6E0ZV5OBAhUvjMvk_V9gUlidpyC2xpO_qHsbI
Message-ID: <CAJvnSUB0XahBTnvtwQXqxhe8vg2MTTGBZZ=whZhahXPLNJBVJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] bbdev: fix build with MinGW 13
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001621bd063eeaff5d"
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

--0000000000001621bd063eeaff5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI The DTS failure for this series on patchwork for the MTU testsuite is
coming from a different patch than this one. Once I have that resolved, I
will put in a retest for this series which will clear up that MTU testsuite
failure.

On Mon, Sep 8, 2025 at 5:21=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:

> After an upgrade to MinGW version 13, compilation breaks:
>
> In function 'rte_bbdev_queue_ops_dump':
> lib/bbdev/rte_bbdev.c:1269:63: error:
>         '%s' directive argument is null [-Werror=3Dformat-overflow=3D]
>         fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
>
> The enqueue status string may be null if the index is too high,
> because RTE_BBDEV_ENQ_STATUS_SIZE_MAX is defined to include
> padding for future enum insertion.
> This padding case must be checked
> to avoid printing a dump of a non-existing status.
>
> Fixes: 353e3639d458 ("bbdev: add queue debug dump")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> ---
> v2: make status_str variable local
> ---
>  lib/bbdev/rte_bbdev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
> index e0f8c8eb0d..e76124532d 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -1264,11 +1264,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_=
t
> queue_id, FILE *f)
>                         dev->data->name, queue_id);
>         fprintf(f, "  Last Enqueue Status %s\n",
>
> rte_bbdev_enqueue_status_str(q_data->enqueue_status));
> -       for (i =3D 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
> +       for (i =3D 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++) {
> +               const char *status_str =3D rte_bbdev_enqueue_status_str(i=
);
> +               if (status_str =3D=3D NULL)
> +                       continue;
>                 if (q_data->queue_stats.enqueue_status_count[i] > 0)
>                         fprintf(f, "  Enqueue Status Counters %s %" PRIu6=
4
> "\n",
> -                                       rte_bbdev_enqueue_status_str(i),
> +                                       status_str,
>
> q_data->queue_stats.enqueue_status_count[i]);
> +       }
>         stats =3D &dev->data->queues[queue_id].queue_stats;
>
>         fprintf(f, "  Enqueue Count %" PRIu64 " Warning %" PRIu64 " Error
> %" PRIu64 "\n",
> --
> 2.51.0
>
>

--0000000000001621bd063eeaff5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FYI The DTS failure for this series on patchwork for the M=
TU testsuite is coming from a different patch than this one. Once I have th=
at resolved, I will put in a retest for this series which will clear up tha=
t MTU testsuite failure.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 8, 2025 at 5:21=
=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net">thom=
as@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">After an upgrade to MinGW version 13, compilation breaks:<br=
>
<br>
In function &#39;rte_bbdev_queue_ops_dump&#39;:<br>
lib/bbdev/rte_bbdev.c:1269:63: error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;%s&#39; directive argument is null [-Werro=
r=3Dformat-overflow=3D]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f, &quot;=C2=A0 Enqueue Status Counters=
 %s %&quot; PRIu64 &quot;\n&quot;,<br>
<br>
The enqueue status string may be null if the index is too high,<br>
because RTE_BBDEV_ENQ_STATUS_SIZE_MAX is defined to include<br>
padding for future enum insertion.<br>
This padding case must be checked<br>
to avoid printing a dump of a non-existing status.<br>
<br>
Fixes: 353e3639d458 (&quot;bbdev: add queue debug dump&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" t=
arget=3D"_blank">thomas@monjalon.net</a>&gt;<br>
Acked-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com=
" target=3D"_blank">bruce.richardson@intel.com</a>&gt;<br>
Acked-by: Hemant Agrawal &lt;<a href=3D"mailto:hemant.agrawal@nxp.com" targ=
et=3D"_blank">hemant.agrawal@nxp.com</a>&gt;<br>
---<br>
v2: make status_str variable local<br>
---<br>
=C2=A0lib/bbdev/rte_bbdev.c | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c<br>
index e0f8c8eb0d..e76124532d 100644<br>
--- a/lib/bbdev/rte_bbdev.c<br>
+++ b/lib/bbdev/rte_bbdev.c<br>
@@ -1264,11 +1264,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t =
queue_id, FILE *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev-&gt;data-&gt;name, queue_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f, &quot;=C2=A0 Last Enqueue Status %s\=
n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 rte_bbdev_enqueue_status_str(q_data-&gt;enqueue_status));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; RTE_BBDEV_ENQ_STATUS_SIZE_=
MAX; i++)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; RTE_BBDEV_ENQ_STATUS_SIZE_=
MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *status_=
str =3D rte_bbdev_enqueue_status_str(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status_str =3D=
=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (q_data-&gt;queu=
e_stats.enqueue_status_count[i] &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(f, &quot;=C2=A0 Enqueue Status Counters %s %&quot; PRIu6=
4 &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_bbdev=
_enqueue_status_str(i),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status_st=
r,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q_data-&=
gt;queue_stats.enqueue_status_count[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 stats =3D &amp;dev-&gt;data-&gt;queues[queue_id=
].queue_stats;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f, &quot;=C2=A0 Enqueue Count %&quot; P=
RIu64 &quot; Warning %&quot; PRIu64 &quot; Error %&quot; PRIu64 &quot;\n&qu=
ot;,<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--0000000000001621bd063eeaff5d--
