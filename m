Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D64C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 19:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A4894021E;
	Thu, 29 May 2025 21:31:31 +0200 (CEST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3D1F340150
 for <dev@dpdk.org>; Thu, 29 May 2025 21:31:29 +0200 (CEST)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-525da75d902so379316e0c.3
 for <dev@dpdk.org>; Thu, 29 May 2025 12:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748547088;
 x=1749151888; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJxjno0QjAS5cRgSJG5tq8vnwREBeZB1EnRWnE3Y8u8=;
 b=1eTueDAqIIj3rCUkje38zgwATqooQuFaXeat++I+ayRPBFhFx1LM5EhdwP0joCacwa
 l7pifIMIrVwelPDN+rt+tHp9ZB8oBzlu+eD02LZKXbYdyyppBkXd+K5UKswiwnpEBCx9
 Svbjn0+c9eAiyg78BiD1LnRyXZeV0kYWOXWul6LU9NgnQzbgiWvneUBuT4qsmOhlu4YR
 +I+f2XoS1pu+MTZ0UQVC4hY+RxoK/njxcgKYkIJxhEFLAVGcJYI7PHwzd5rlHtO/KUma
 eKDoizBnF+cqA3KfNinZa/RUSijA+trjxQcchLCw5DLZaVGArSirwrDXf3le4NhriKGZ
 uZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748547088; x=1749151888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJxjno0QjAS5cRgSJG5tq8vnwREBeZB1EnRWnE3Y8u8=;
 b=quCuPsJECX+WbX7ORLYNJkKBYF6GxYRtvV6e9z6dXrvFskRImSBvZsD8gs1Xgxr4fu
 r19bNDbt3sNsrWxPCpLDS43aLYRn53V8JHjHzyS/fzt+p6TIalAzfdFNDk06mEPakuO+
 MTLbMIxY+NisbVm44IBUibV5Y6zCpb0YoNlMBbXz9kjSrmblWg1vXlo5W+GYP+olVc7n
 cqnR7T7jm5TIKSYTDta+iFXKlMrl4mMAw+COBsJD8O36HkxCIYspZrMvTppUsTOFF4la
 +5q1wujG1Oj+rqHwsUIfeQSeX3VoUaF6JIaFwL6vnqh9YtM50/AXXKN+DlvYL2PFixlc
 HLWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsyWEX6Ksk0PsW3dqsId/yWG/6YPXzuN7rnRDqpyKMqSRz3BpvXNWnuMJyqpNqtlkbPpg=@dpdk.org
X-Gm-Message-State: AOJu0YyN8f8zsaILpJsQhNjMhbbMbVdxwz6cc/Nz4jbAk9TUFm9uGMVS
 QdnxMbIE0wwoThdtXNqq7XimZdPgJl8aZo/dhTgnECVXae2FnINpQV77F7kYq1IYuc0gWA9/TYu
 WovSa1stqOdVQ+qF+MNHLWEtHsB1j1c0k+0LT9X20tA==
X-Gm-Gg: ASbGnctlCalVnlco0awhqbsQnYgHinJvOY53mx52QvQ4s+Oy3Bw7jkUDod2H4xftjW+
 BHUfALow+K6LC2LZWTkuP4KNAO7kWuyGS04ovKOYNejBetYZU5p8VWdadWVnESyimmodMCHmDvu
 ccgqJN+GXKvYdm+dXFdHBZyHujJRtlln0gmrsAZ27dqYiiKBBJzDpl23V5Sb4AlUFonS0=
X-Google-Smtp-Source: AGHT+IE8VEmungjFB1ipSFRoXP3ORdqQIqJen4GvZ2W3l6gvOD/MW+33m9xrdZBbhnji7ybz0wkMUZ5emqfgj9JN9jU=
X-Received: by 2002:a05:6122:790:b0:52a:7787:53d7 with SMTP id
 71dfb90a1353d-5308109f849mr956271e0c.6.1748547088320; Thu, 29 May 2025
 12:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
In-Reply-To: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 29 May 2025 12:31:17 -0700
X-Gm-Features: AX0GCFvglBc0WbJ8pAC6FPALxEphROVIgdnNKUqG4M7zNpmj0x83oYWnJ-kkNQ0
Message-ID: <CAOaVG17RtUQKFVoLX_WCU-MA0AzEZZ0QsJmPkO5Rpa8-9ohfKQ@mail.gmail.com>
Subject: Re: [PATCH] pcapng: allow any protocol link type for the interface
 block
To: Schneide <schneide@qti.qualcomm.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, 
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>,
 dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000012a83a06364b5848"
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

--00000000000012a83a06364b5848
Content-Type: text/plain; charset="UTF-8"

What other packet types would a DPDK app use. The possible type fields are
quite limited see the spec.

Plus it would be an ABI breakage would require versioning.

On Thu, May 29, 2025, 10:16 Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
>
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
>
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
>
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---
>
> diff --git a/.mailmap b/.mailmap
> index d9423aa..7ef0964 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -388,6 +388,7 @@
>  Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
>  Duncan Bellamy <dunk@denkimushi.com>
>  Dustin Lundquist <dustin@null-ptr.net>
> +Dylan Schneider <schneide@qti.qualcomm.com>
>  Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
>  Ed Czeck <ed.czeck@atomicrules.com>
>  Eduard Serra <eserra@vmware.com>
> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
> index 3d3c0db..e0e2b26 100644
> --- a/app/dumpcap/main.c
> +++ b/app/dumpcap/main.c
> @@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
>                 free(os);
>
>                 TAILQ_FOREACH(intf, &interfaces, next) {
> -                       if (rte_pcapng_add_interface(ret.pcapng,
> intf->port, intf->ifname,
> -                                                    intf->ifdescr,
> intf->opts.filter) < 0)
> +                       if (rte_pcapng_add_interface(ret.pcapng,
> intf->port, DLT_EN10MB,
> +                               intf->ifname, intf->ifdescr,
> intf->opts.filter) < 0)
>                                 rte_exit(EXIT_FAILURE,
> "rte_pcapng_add_interface %u failed\n",
>                                         intf->port);
>                 }
> diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
> index 8f2cff3..bcf9972 100644
> --- a/app/test/test_pcapng.c
> +++ b/app/test/test_pcapng.c
> @@ -345,7 +345,7 @@ test_add_interface(void)
>         }
>
>         /* Add interface to the file */
> -       ret = rte_pcapng_add_interface(pcapng, port_id,
> +       ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                        NULL, NULL, NULL);
>         if (ret < 0) {
>                 fprintf(stderr, "can not add port %u\n", port_id);
> @@ -353,7 +353,7 @@ test_add_interface(void)
>         }
>
>         /* Add interface with ifname and ifdescr */
> -       ret = rte_pcapng_add_interface(pcapng, port_id,
> +       ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                        "myeth", "Some long description",
> NULL);
>         if (ret < 0) {
>                 fprintf(stderr, "can not add port %u with ifname\n",
> port_id);
> @@ -361,7 +361,7 @@ test_add_interface(void)
>         }
>
>         /* Add interface with filter */
> -       ret = rte_pcapng_add_interface(pcapng, port_id,
> +       ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                        NULL, NULL, "tcp port 8080");
>         if (ret < 0) {
>                 fprintf(stderr, "can not add port %u with filter\n",
> port_id);
> @@ -406,7 +406,7 @@ test_write_packets(void)
>         }
>
>         /* Add interface to the file */
> -       ret = rte_pcapng_add_interface(pcapng, port_id,
> +       ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                        NULL, NULL, NULL);
>         if (ret < 0) {
>                 fprintf(stderr, "can not add port %u\n", port_id);
> diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
> index 89525f1..46fab8c 100644
> --- a/lib/graph/graph_pcap.c
> +++ b/lib/graph/graph_pcap.c
> @@ -117,7 +117,7 @@ graph_pcap_file_open(const char *filename)
>
>         /* Add the configured interfaces as possible capture ports */
>         RTE_ETH_FOREACH_DEV(portid) {
> -               ret = rte_pcapng_add_interface(pcapng_fd, portid,
> +               ret = rte_pcapng_add_interface(pcapng_fd, portid,
> DLT_EN10MB
>                                                NULL, NULL, NULL);
>                 if (ret < 0) {
>                         graph_err("Graph rte_pcapng_add_interface port %u
> failed: %d",
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index 16485b2..bed1e14 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -205,7 +205,7 @@ pcapng_section_block(rte_pcapng_t *self,
>  /* Write an interface block for a DPDK port */
>  RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
>  int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> +rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t
> link_type,
>                          const char *ifname, const char *ifdescr,
>                          const char *filter)
>  {
> @@ -277,7 +277,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t
> port,
>         hdr = (struct pcapng_interface_block *)buf;
>         *hdr = (struct pcapng_interface_block) {
>                 .block_type = PCAPNG_INTERFACE_BLOCK,
> -               .link_type = 1,         /* DLT_EN10MB - Ethernet */
> +               .link_type = link_type,
>                 .block_length = len,
>         };
>
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57..0a35ec9 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
>   *  The handle to the packet capture file
>   * @param port
>   *  The Ethernet port to report stats on.
> + * @param link_type
> + *  The protocol link type of the packets
>   * @param ifname (optional)
>   *  Interface name to record in the file.
>   *  If not specified, name will be constructed from port
> @@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
>   * must be added.
>   */
>  int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> +rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t
> link_type,
>                          const char *ifname, const char *ifdescr,
>                          const char *filter);
>
>

--00000000000012a83a06364b5848
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">What other packet types would a DPDK app use. The possibl=
e type fields are quite limited see the spec.<div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Plus it would be an ABI breakage would require versioning.<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, May 29, 2025, 10:16 Schneide &lt;<a href=
=3D"mailto:schneide@qti.qualcomm.com">schneide@qti.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Dylan =
Schneider &lt;<a href=3D"mailto:schneide@qti.qualcomm.com" target=3D"_blank=
" rel=3D"noreferrer">schneide@qti.qualcomm.com</a>&gt;<br>
<br>
Allow the user to specify protocol link type when creating pcapng files.<br=
>
This change is needed to specify the protocol type in the pcapng file,<br>
DLT_EN10MB specifies ethernet packets only. This will allow dissectors<br>
for other protocols to be used on files generated by pcapng.<br>
<br>
Includes a breaking change to rte_pcapng_add_interface to add link_type<br>
parameter. Existing calls to the function have been updated to pass<br>
DLT_EN10MB for the link type argument.<br>
<br>
Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface information&quot;)=
<br>
Signed-off-by: Dylan Schneider &lt;<a href=3D"mailto:schneide@qti.qualcomm.=
com" target=3D"_blank" rel=3D"noreferrer">schneide@qti.qualcomm.com</a>&gt;=
<br>
Cc: <a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank" rel=3D"=
noreferrer">stephen@networkplumber.org</a><br>
---<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index d9423aa..7ef0964 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -388,6 +388,7 @@<br>
=C2=A0Dumitru Ceara &lt;<a href=3D"mailto:dceara@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">dceara@redhat.com</a>&gt; &lt;<a href=3D"mailto:dumi=
tru.ceara@gmail.com" target=3D"_blank" rel=3D"noreferrer">dumitru.ceara@gma=
il.com</a>&gt;<br>
=C2=A0Duncan Bellamy &lt;<a href=3D"mailto:dunk@denkimushi.com" target=3D"_=
blank" rel=3D"noreferrer">dunk@denkimushi.com</a>&gt;<br>
=C2=A0Dustin Lundquist &lt;<a href=3D"mailto:dustin@null-ptr.net" target=3D=
"_blank" rel=3D"noreferrer">dustin@null-ptr.net</a>&gt;<br>
+Dylan Schneider &lt;<a href=3D"mailto:schneide@qti.qualcomm.com" target=3D=
"_blank" rel=3D"noreferrer">schneide@qti.qualcomm.com</a>&gt;<br>
=C2=A0Dzmitry Sautsa &lt;<a href=3D"mailto:dzmitryx.sautsa@intel.com" targe=
t=3D"_blank" rel=3D"noreferrer">dzmitryx.sautsa@intel.com</a>&gt;<br>
=C2=A0Ed Czeck &lt;<a href=3D"mailto:ed.czeck@atomicrules.com" target=3D"_b=
lank" rel=3D"noreferrer">ed.czeck@atomicrules.com</a>&gt;<br>
=C2=A0Eduard Serra &lt;<a href=3D"mailto:eserra@vmware.com" target=3D"_blan=
k" rel=3D"noreferrer">eserra@vmware.com</a>&gt;<br>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c<br>
index 3d3c0db..e0e2b26 100644<br>
--- a/app/dumpcap/main.c<br>
+++ b/app/dumpcap/main.c<br>
@@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(os);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TAILQ_FOREACH(intf,=
 &amp;interfaces, next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rte_pcapng_add_interface(ret.pcapng, intf-&gt;port, intf-&gt;=
ifname,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intf-&gt;ifdescr, intf-&gt;opts.filter) =
&lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rte_pcapng_add_interface(ret.pcapng, intf-&gt;port, DLT_EN10M=
B,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intf-&gt;ifname, intf-&gt;ifdescr, in=
tf-&gt;opts.filter) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_exit(EXIT_FAILURE, &quot;rte_pca=
png_add_interface %u failed\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intf-&gt=
;port);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c<br>
index 8f2cff3..bcf9972 100644<br>
--- a/app/test/test_pcapng.c<br>
+++ b/app/test/test_pcapng.c<br>
@@ -345,7 +345,7 @@ test_add_interface(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add interface to the file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d, DLT_EN10MB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NUL=
L, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;can not add port %u\n&quot;, port_id);<br>
@@ -353,7 +353,7 @@ test_add_interface(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add interface with ifname and ifdescr */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d, DLT_EN10MB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mye=
th&quot;, &quot;Some long description&quot;, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;can not add port %u with ifname\n&quot;, port_id);<br>
@@ -361,7 +361,7 @@ test_add_interface(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add interface with filter */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d, DLT_EN10MB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NUL=
L, &quot;tcp port 8080&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;can not add port %u with filter\n&quot;, port_id);<br>
@@ -406,7 +406,7 @@ test_write_packets(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add interface to the file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_add_interface(pcapng, port_i=
d, DLT_EN10MB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NUL=
L, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;can not add port %u\n&quot;, port_id);<br>
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c<br>
index 89525f1..46fab8c 100644<br>
--- a/lib/graph/graph_pcap.c<br>
+++ b/lib/graph/graph_pcap.c<br>
@@ -117,7 +117,7 @@ graph_pcap_file_open(const char *filename)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add the configured interfaces as possible ca=
pture ports */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_FOREACH_DEV(portid) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_=
add_interface(pcapng_fd, portid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rte_pcapng_=
add_interface(pcapng_fd, portid, DLT_EN10MB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 graph_err(&quot;Graph rte_pcapng_add_interface port %u failed: %=
d&quot;,<br>
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c<br>
index 16485b2..bed1e14 100644<br>
--- a/lib/pcapng/rte_pcapng.c<br>
+++ b/lib/pcapng/rte_pcapng.c<br>
@@ -205,7 +205,7 @@ pcapng_section_block(rte_pcapng_t *self,<br>
=C2=A0/* Write an interface block for a DPDK port */<br>
=C2=A0RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)<br>
=C2=A0int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *ifname, const char *ifdescr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *filter)<br>
=C2=A0{<br>
@@ -277,7 +277,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t p=
ort,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr =3D (struct pcapng_interface_block *)buf;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *hdr =3D (struct pcapng_interface_block) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .block_type =3D PCA=
PNG_INTERFACE_BLOCK,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.link_type =3D 1,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DLT_EN10MB - Ethernet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.link_type =3D link=
_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .block_length =3D l=
en,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h<br>
index 48f2b57..0a35ec9 100644<br>
--- a/lib/pcapng/rte_pcapng.h<br>
+++ b/lib/pcapng/rte_pcapng.h<br>
@@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
=C2=A0 *=C2=A0 The handle to the packet capture file<br>
=C2=A0 * @param port<br>
=C2=A0 *=C2=A0 The Ethernet port to report stats on.<br>
+ * @param link_type<br>
+ *=C2=A0 The protocol link type of the packets<br>
=C2=A0 * @param ifname (optional)<br>
=C2=A0 *=C2=A0 Interface name to record in the file.<br>
=C2=A0 *=C2=A0 If not specified, name will be constructed from port<br>
@@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
=C2=A0 * must be added.<br>
=C2=A0 */<br>
=C2=A0int<br>
-rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
+rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_=
type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *ifname, const char *ifdescr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const char *filter);<br>
<br>
</blockquote></div>

--00000000000012a83a06364b5848--
