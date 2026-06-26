Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD80C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 13:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056DC402B5;
	Sun, 28 Jun 2026 15:28:10 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 36498402C6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 09:37:23 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so1153568a12.2
 for <dev@dpdk.org>; Fri, 26 Jun 2026 00:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782459443; cv=none;
 d=google.com; s=arc-20260327;
 b=srZ+VZc91dVZjAiRiF9BS8F9ySN7ZIsTl4R54nZiHzjwSY8frL9ohoGxBTmVxO3CwQ
 5K2tvuVMQZtWeplRTN9MMupuzQXLDUbJCrvM+ZPZgUtwAigewDakVez41SvlRCCHVZSF
 rKGeq3oAdu2Cfa0ruFyndCsVJi3QtGadmEsSxS1EJt+cnq99PCH14fcInVivxuZZQvx7
 3sqVDq+GV6V5NoPDXzTZn0E14feumCNqJGRvbVXDo+Y6bsLoj71i5Z1e/PtYcxkbcZIl
 fIiyo7AClguRm4fY3OW1cJDpwzwL2ayut9EINa9E2AVoEjkqA8/MhO7XT37ECaEpSpkb
 bR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JMjrHct2wZOvX04pbARytiyVNS3cM8ojfv2aXRR609Y=;
 fh=h3kCsnL+Shbbnd6k9Fi4Kat+wO4+H/n2KrI++OlpKJc=;
 b=lqavRwGrKG/hbxIivUefwIX3Fxy9sicu0I3Erqc6S874kpfPDDOHGOHuZUB6q51Bcs
 1IFOK6HGiVmIPPakVFLnu6MHUK78kUeGrzKKKyHB+ZrSarJqJN3ZS03/KT6S3rDwT7vT
 WNiaZPlFa6FDTMmp4AOZu6wl10xtpkcmUcwMN12A5aG9gERJ6CmXEhqfCoZUgS+v2/dD
 35i1sz5q6716niTRdKeaBes67uuKZBOosomLvdW2Cq4mKqZA1GceU8rj9gydQUXlMLAu
 vs521yRa7E9rSAX0jYEWwh1vMWyKdNqg5vt04Ss7lrFjSysbb28pGNXUL64PCNV0rJ92
 K2Ag==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782459443; x=1783064243; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JMjrHct2wZOvX04pbARytiyVNS3cM8ojfv2aXRR609Y=;
 b=VWNOBVm9YOpjmKf1VMZ166gv+XvviJPYG0zD3HoFk6qZBma4LmPbShIjQ9d6eAY/Nz
 kscTlkPTfBJow9mk2ob05SQneGyEEtDlOL9Ham87hZ1mbH26YwsWD5equSAMRL6eSPkE
 Xmxix/XP1gZ4nmC2FwrMUY5YO6sfhpmpjolQaKbyWhUmCXbh1d1OrjO2p0nMkRwOmrKM
 nl1seQTooMQOdill5BVGkbOayLEqEzvOH+sLe+EnqzzNo73tPPeGk7alOoyoDGKgmiUA
 L7whta6t+fNrYe8Rj85vtAfws4YqvdqOLCZdglAqf7SEEommyFE/AomD1BNoMwTYHJuG
 78Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782459443; x=1783064243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMjrHct2wZOvX04pbARytiyVNS3cM8ojfv2aXRR609Y=;
 b=h3SXs18CwaVtaX6vkm+/C+e1IrhsVKK+/9tMjXEvXRke4yXfjBbE2M2KvtY2Z3QGjS
 5yZHPALaI2O0jSR1lX4KOLkWS1DOygEY0atkGyQzaA+SrlHi+ezUBY7+6fgir7Ltnq1U
 qTIi67nlk1/jrOTZow/PRwg60CKANw9HeEm3sI7/qVcDbF9hbXY9Qti7vR1ahqlpAh2d
 /jRv09z/YkDRswNW334JsFvBz+MOaybFXt9s/8sbxeOzPCo2SEioSBrBR6VavyCAm2S4
 S+RGxUBVavn47HA+8VL9kv3H4urGkcZJTFqgZKL9v/lIxUeHNaupopjPNQ96tChQnbzG
 rkFA==
X-Gm-Message-State: AOJu0YzhD2CrSSbyCRX2oEx3yJrmXoMyMQsN3h37usmDdjNpXEb9HifK
 pj08HcHXI8BHbCyIauf8LZ6MocmeX2V3igVg5nPFbzYLuluP1Busk+xyEqyHTbo5SQcAyUfYLdJ
 KkQr9WqVxzSuoneOBfGfTyPr6tcYWOeY=
X-Gm-Gg: AfdE7cnbdNLY5oLmtQ1JMvTGuxJTZOi3K6r4xaV6zuFRIps3T6HVgDiOi1U6F/6ofbH
 74lTE4LP+uNAfJQ0Hl89HL3kxe4SdRmrwpq8cxFOHFTRCXC/q8XYkYr3oqG1rybHECGmTRMGWtR
 sNdwzhxwel8zbI2hJ9yRL+4QUVt2qk/YXcpewv2NxdJeeo4Y1hC3sqBvixYpfcnhHSzWfHP9e+p
 Q9epWHZobMuC7aohZBBK1U653I9NRCdJvhl1D89ChtW0QUAgSh+LWYyLbClMK4KbTmzwv5ywF0J
 HoiPlio=
X-Received: by 2002:a05:6402:40cb:b0:695:4649:ca62 with SMTP id
 4fb4d7f45d1cf-69810b6f9dcmr1363041a12.21.1782459442484; Fri, 26 Jun 2026
 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260624085741.2195573-1-samaryadav5@gmail.com>
 <20260624081610.780c4b0f@phoenix.local>
In-Reply-To: <20260624081610.780c4b0f@phoenix.local>
From: Samar Yadav <samaryadav5@gmail.com>
Date: Fri, 26 Jun 2026 13:07:10 +0530
X-Gm-Features: AVVi8Ce56SLId8IVoC38-JXf6Gz-WRzMVovJnvooynVQ5FkA8HYbQEgKN5qAWeQ
Message-ID: <CAJR3iYC1mgxOZuCm0=z2-mtkhLhsXPNA50nyQ2M3p36ds4HpBQ@mail.gmail.com>
Subject: Re: [PATCH] net/virtio-user: fix eventfd sharing in secondary process
To: stephen@networkplumber.org
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, 
 tiwei.bie@intel.com, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e55ac30655232d3c"
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:28:09 +0200
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

--000000000000e55ac30655232d3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed on the related pthread_mutex_init bug.
In this patch dev->mutex is only ever locked by the primary process:
the MP handler runs in the primary's EAL dispatch thread, and the
teardown path in virtio_user_dev_uninit() is primary-only. The
secondary communicates via rte_mp_request_sync() over the EAL socket
and never calls pthread_mutex_lock() on dev->mutex directly.

That said, POSIX requires PTHREAD_PROCESS_SHARED for a mutex stored in
shared memory regardless of which processes actually lock it, and other
DPDK multiprocess-aware code already uses rte_thread_mutex_init_shared()
 for shared-memory mutexes. The pthread_mutex_init(&dev->mutex, NULL) call
predates this
patch but since this patch explicitly documents the lock's role I will fix
the
initialisation in v2:
- pthread_mutex_init(&dev->mutex, NULL);
+ rte_thread_mutex_init_shared(&dev->mutex);


On Wed, Jun 24, 2026 at 8:46=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed, 24 Jun 2026 08:57:41 +0000
> Samar Yadav <samaryadav5@gmail.com> wrote:
>
> > @@ -865,9 +913,15 @@ virtio_user_dev_uninit(struct virtio_user_dev *dev=
)
> >
> >       rte_mem_event_callback_unregister(VIRTIO_USER_MEM_EVENT_CLB_NAME,
> dev);
> >
> > +     /*
> > +      * Serialize closing/freeing the kick/call fd arrays against the =
MP
> > +      * handler, which reads them under the same lock to share them wi=
th
> > +      * secondary processes.
> > +      */
> > +     pthread_mutex_lock(&dev->mutex);
> >       virtio_user_dev_uninit_notify(dev);
> > -
> >       virtio_user_free_vrings(dev);
> > +     pthread_mutex_unlock(&dev->mutex);
> >
> >       free(dev->ifname);
>
> Related bug. virtio_user is not initializing mutex as safe between
> processes. See rte_thread_mutex_init_shared() vs pthread_mutex_init()
>

--000000000000e55ac30655232d3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Agreed on the related pthread_mutex_init bug. <br>In this =
patch dev-&gt;mutex is only ever locked by the primary process:<br>the MP h=
andler runs in the primary&#39;s EAL dispatch thread, and the<br>teardown p=
ath in virtio_user_dev_uninit() is primary-only. The<br>secondary communica=
tes via rte_mp_request_sync() over the EAL socket<br>and never calls pthrea=
d_mutex_lock() on dev-&gt;mutex directly.<br><br>That said, POSIX requires =
PTHREAD_PROCESS_SHARED for a mutex stored in<br>shared memory regardless of=
 which processes actually lock it, and other<br>DPDK multiprocess-aware cod=
e already uses rte_thread_mutex_init_shared()<br>=C2=A0for shared-memory mu=
texes. The pthread_mutex_init(&amp;dev-&gt;mutex, NULL) call predates this=
=C2=A0<div>patch but since this patch explicitly documents the lock&#39;s r=
ole I will fix the<br>initialisation in v2:<br>-	pthread_mutex_init(&amp;de=
v-&gt;mutex, NULL);<br>+	rte_thread_mutex_init_shared(&amp;dev-&gt;mutex);<=
br><br></div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 24, 2026 at 8:46=E2=80=AFPM =
Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen=
@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Wed, 24 Jun 2026 08:57:41 +0000<br>
Samar Yadav &lt;<a href=3D"mailto:samaryadav5@gmail.com" target=3D"_blank">=
samaryadav5@gmail.com</a>&gt; wrote:<br>
<br>
&gt; @@ -865,9 +913,15 @@ virtio_user_dev_uninit(struct virtio_user_dev *de=
v)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mem_event_callback_unregister(VIRTIO_USE=
R_MEM_EVENT_CLB_NAME, dev);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Serialize closing/freeing the kick/call fd arr=
ays against the MP<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * handler, which reads them under the same lock =
to share them with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * secondary processes.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;dev-&gt;mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_user_dev_uninit_notify(dev);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_user_free_vrings(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(&amp;dev-&gt;mutex);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(dev-&gt;ifname);<br>
<br>
Related bug. virtio_user is not initializing mutex as safe between<br>
processes. See rte_thread_mutex_init_shared() vs pthread_mutex_init()<br>
</blockquote></div>

--000000000000e55ac30655232d3c--
