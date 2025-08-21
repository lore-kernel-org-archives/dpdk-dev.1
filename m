Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864CCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 09:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1258E40292;
	Thu, 21 Aug 2025 11:07:23 +0200 (CEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41]) by mails.dpdk.org (Postfix) with ESMTP id 0D8E64026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 05:15:04 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-55ce5097493so457626e87.0
 for <dev@dpdk.org>; Wed, 20 Aug 2025 20:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755746103; x=1756350903; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gzbhKPwMqKecKCP2/gmUYwgPSw1+MuNchXB4MezEPmo=;
 b=REDDUJiWaCo0sC8EsDatAJFOV1hXDI31iHLO67FDwOoKj8y+FItb9cBcsfkomrhEiS
 60k8OsYDDheXsBJSiCUjVNBLyz8UCl5m9RDJbhnFLJ1fKxWWaq0o31gBTA7VtpcFUGdr
 6OQNYRiZUnImKkhZ8u9X8qadtLZNnY13jDPQfhz1iOG91LhldE9Y9HYor4Cwp19jF+h2
 +2nK7j/jefdd4FnsUEBH21KNE4AN1lfwFmnY8LOt0BqsgEMg96b7rjPNJ1c1eds8/C2p
 sfeKrrevf3bdhQoU7mvNEDoSNHJ4SIBDrLsTGjdQk2CYiuj2aSOLllDMIOzlr2O4I9x6
 U6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755746103; x=1756350903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzbhKPwMqKecKCP2/gmUYwgPSw1+MuNchXB4MezEPmo=;
 b=lPwk5CGKSvlnKauakMZeB0R8DloZXpnmD8cvjEKHgEywu7A+Q1ZWhSc5IPRo6nqGyx
 xqjnk6vmxjc5tM3oiD/7L/f/FT1Ua2BW6wUx9J6Ti0SI0YDiPLoHuvjQrCyTyz0WM9/s
 m159c4GFm1AbFiaTR+05a6n3rzGv4cYaraO27ngRtxLFckx/yjSv79y7kBJTTXo6UWO7
 LF/0eDwVxfeOqx9xVje59bF0AuuEJZj4C+gBVOM1IvQG4vP3lNqsOJKBbF5T9lnoh6Rr
 dwbuOsgt9EuRafL729Y3vJmBWfNmsGuPb/paopzsDfpuQsNn4Xzk2G+w1xQXPMt0bCYj
 jJtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwSmoB61uYZmDd7gArIh0yOep1TVv1Utffsgf9Vka5BZAGx039EXKL7eFOa3h+j2zFSiA=@dpdk.org
X-Gm-Message-State: AOJu0Yyz4ig+dNeSh0d3qipbsyM4IVdx23RDDoCK2ujpiK6kpi7YdZZp
 2kCScSfpxvoY7g3ZbKDPKYfMnxX0iusETtNbtIBhsueP9uJ9Z3qHJq1PIPdFEhBULpizVODKSFp
 oXSt3CxtK0g0wLQ/IVpt4rgmzHLcG8JM=
X-Gm-Gg: ASbGncvnkAjn2TVjRNmtLO8o1/4+5KB7SKrxKyMjALZKZHW/2gx7Cd4t9IPOzwm4dfc
 WzLqjEGo+y7oLkV03QnL5qTttwDR3Y7wXcjG8y6Xw4tbJvjxeRtdLZtRVlFwj5HHwCCwWH9Me2A
 my/I2cKGmmuKwi/jip9gqdKIMWuy1e8tdU8KHWrP2BVeR1oWTmAuS9KrEu7zn06LLnlDwmtbRGR
 tILnysIw86Fog==
X-Google-Smtp-Source: AGHT+IHnaNwGpKL5WEQU5yUafMonzlyyOferuqOmG2pZV8WoCObqwDg+Nr1rcl304saf03BoMHjwMCoKiX6l2TXZsDE=
X-Received: by 2002:a2e:a553:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-33549e41fe7mr2689741fa.6.1755746102404; Wed, 20 Aug 2025
 20:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
 <20250820120242.63zqjpokdzmumrka@ds-vm-debian.local>
In-Reply-To: <20250820120242.63zqjpokdzmumrka@ds-vm-debian.local>
From: Joni <canary.overflow@gmail.com>
Date: Thu, 21 Aug 2025 11:14:51 +0800
X-Gm-Features: Ac12FXwcwC4QShb8Znnr8SMcf0h6twXCDLB2KSo3wMHmxLnwWOBIw2Fu6METiVY
Message-ID: <CACGKW7R_-r=C1oB=-q+zwBhChc-6hueHs-1uabHKe8pjoy8wQQ@mail.gmail.com>
Subject: Re: Segmentation fault when running MPRQ on testpmd
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000bfece0063cd77eb4"
X-Mailman-Approved-At: Thu, 21 Aug 2025 11:07:21 +0200
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

--000000000000bfece0063cd77eb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dariusz,

Sure!

#0  0x0000000001c34912 in __rte_pktmbuf_free_extbuf ()
#1  0x0000000001c36a10 in rte_pktmbuf_detach ()
#2  0x0000000001c4a9ec in rxq_copy_mprq_mbuf_v ()
#3  0x0000000001c4d63b in rxq_burst_mprq_v ()
#4  0x0000000001c4d7a7 in mlx5_rx_burst_mprq_vec ()
#5  0x000000000050be66 in rte_eth_rx_burst ()
#6  0x000000000050c53d in pkt_burst_io_forward ()
#7  0x00000000005427b4 in run_pkt_fwd_on_lcore ()
#8  0x000000000054289b in start_pkt_forward_on_core ()
#9  0x0000000000a473c9 in eal_thread_loop ()
#10 0x00007ffff60061ca in start_thread () from /lib64/libpthread.so.0
#11 0x00007ffff5c72e73 in clone () from /lib64/libc.so.6

I've raised the bugs as instructed (ID 1776, 1777, 1778 and 1779) and
included the stack trace there too.


With regards,
Joni


On Wed, Aug 20, 2025 at 8:04=E2=80=AFPM Dariusz Sosnowski <dsosnowski@nvidi=
a.com>
wrote:

> Hi,
>
> On Wed, Aug 20, 2025 at 04:40:16PM +0800, Joni wrote:
> > Hi,
> >
> > I hope this is the correct place to report these issues since it seems =
to
> > be related to DPDK codes. I've reported this to Nvidia a few days ago b=
ut
> > have yet to receive any response from them.
> >
> > My server is currently using ConnectX5 MT27800 (mlx5_core 5.7-1.0.2) on
> > firmware 16.35.4506 (MT_0000000011). My DPDK library version is 22.11.
> >
> > I ran the following testpmd command which resulted in segmentation faul=
t
> (I
> > am currently running on filtered traffic with packets >1000 bytes to
> > increase the odds of hitting the segmentation fault):
> >
> > dpdk-testpmd -l 1-5 -n 4 -a
> >
> 0000:1f:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=
=3D1,mprq_log_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_len=
=3D64,rx_vec_en=3D1
> > -- -i --rxd=3D8192 --max-pkt-len=3D1700 --rxq=3D1 --total-num-mbufs=3D1=
6384
> > --mbuf-size=3D3000 --enable_drop_en =E2=80=93enable_scatter
> >
> > This segmentation fault goes away when I disable vectorization
> > (rx_vec_en=3D0). (Note that the segmentation fault does not occur in
> > forward-mode=3Drxonly). The segmentation fault also seems to happen wit=
h
> > higher chances when there is a rxnombuf.
>
> Thank you for reporting and for the analysis.
>
> Could you please open a bug on https://bugs.dpdk.org/ with all the
> details?
>
> Do you happen to have a stack trace from the segmentation fault?
>
> Slava: Could you please take a look at the issue described by Joni in thi=
s
> mail?
>
> >
> > Upon some investigation, I noticed that in DPDK=E2=80=99s source codes
> > drivers/net/mlx5/mlx5_rxtx_vec.c
> > (function rxq_copy_mprq_mbuf_v()), there is a possibility where the
> > consumed stride exceeds the stride number (64 in this case) which shoul=
d
> > not be happening. I'm suspecting there's some CQE misalignment here upo=
n
> > encountering rxnombuf.
> >
> > rxq_copy_mprq_mbuf_v(...) {
> >     ...
> >     if(rxq->consumed_strd =3D=3D strd_n) {
> >         // replenish WQE
> >     }
> >     ...
> >     strd_cnt =3D (elts[i]->pkt_len / strd_sz) +
> >                ((elts[i]->pkt_len % strd_sz) ? 1 : 0);
> >
> >     rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]->pkt_len, buf,
> > rxq->consumed_strd, strd_cnt);
> >     rxq->consumed_strd +=3D strd_cnt;       // encountering cases where
> > rxq->consumed_strd > strd_n
> >     ...
> > }
> >
> > In addition, there were also cases in mprq_buf_to_pkt() where the
> allocated
> > seg address is exactly the same as the pkt (elts[i]) address passed in
> > which should not happen.
> >
> > mprq_buf_to_pkt(...) {
> >     ...
> >     if(hdrm_overlap > 0) {
> >         MLX5_ASSERT(rxq->strd_scatter_en);
> >
> >         struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq->mp);
> >         if (unlikely(seg =3D=3D NULL)) return MLX5_RXQ_CODE_NOMBUF;
> >         SET_DATA_OFF(seg, 0);
> >
> >         // added debug statement
> >         DRV_LOG(DEBUG, "pkt %p seg %p", (void *)pkt, (void *)seg);
> >
> > rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -
> > hdrm_overlap), hdrm_overlap); ... } }
> >
> > I have tried upgrading my DPDK version to 24.11 but the segmentation
> fault
> > still persists.
> >
> > In addition, there were also a few other issues that I've noticed:
> >
> >    - max-pkt-len does not seem to work for values < 1500 even though
> "show
> >    port info X" showed that the MTU was set to the value I've passed in
> >    - In mprq_buf_to_pkt():
> >        - uint32_t seg_len =3D RTE_MIN(len, (uint32_t)(pkt->buf_len -
> >    RTE_PKTMBUF_HEADROOM)) --> seems unnecessary as to hit this code, le=
n
> has
> >    to be greater than (uint32_t)(pkt->buf_len - RTE_PKTMBUF_HEADROOM)
> due to
> >    the if condition
> >        - If the allocation struct rte_mbuf *next =3D
> >    rte_pktmbuf_alloc(rxq->mp) fails and packet has more than 2 segs, th=
e
> segs
> >    that were allocated previously do not get freed
> >
> >     mprq_buf_to_pkt(...) {
> >         ...                } else if (rxq->strd_scatter_en) {
> >
> > struct rte_mbuf *prev =3D pkt;
> >
> > uint32_t seg_len =3D RTE_MIN(len, (uint32_t)
> >
> > (pkt->buf_len - RTE_PKTMBUF_HEADROOM));
> >
> > uint32_t rem_len =3D len - seg_len;
> >
> >
> >       rte_memcpy(rte_pktmbuf_mtod(pkt, void *), addr, seg_len);
> >       DATA_LEN(pkt) =3D seg_len;
> >       while (rem_len) {
> >          struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq->mp);
> >
> >
> >             if (unlikely(next =3D=3D NULL))
> >                 return MLX5_RXQ_CODE_NOMBUF;
> >             ...
> >     - In the external buffer attach case where hdrm_overlap > 0, the co=
de
> > did not decrement the buffer refcnt if allocation struct rte_mbuf *next=
 =3D
> > rte_pktmbuf_alloc(rxq->mp) fails
> >
> > mprq_buf_to_pkt(...) {
> >     ...            if (hdrm_overlap > 0) {
> >
> >         __atomic_add_fetch(&buf->refcnt, 1, __ATOMIC_RELAXED);
> >         ...
> >         MLX5_ASSERT(rxq->strd_scatter_en);
> >         struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq->mp);
> >         if (unlikely(seg =3D=3D NULL))
> >             return MLX5_RXQ_CODE_NOMBUF;
> >         SET_DATA_OFF(seg, 0);
> >         ...
> >
> >
> > Hope to hear from you soon!
> >
> > With regards,
> > Joni
>
> Best regards,
> Dariusz Sosnowski
>

--000000000000bfece0063cd77eb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dariusz,=C2=A0<div><br></div><div>Sure!=C2=A0</div><div=
><br></div><div><font face=3D"monospace">#0 =C2=A00x0000000001c34912 in __r=
te_pktmbuf_free_extbuf ()<br>#1 =C2=A00x0000000001c36a10 in rte_pktmbuf_det=
ach ()<br>#2 =C2=A00x0000000001c4a9ec in rxq_copy_mprq_mbuf_v ()<br>#3 =C2=
=A00x0000000001c4d63b in rxq_burst_mprq_v ()<br>#4 =C2=A00x0000000001c4d7a7=
 in mlx5_rx_burst_mprq_vec ()<br>#5 =C2=A00x000000000050be66 in rte_eth_rx_=
burst ()<br>#6 =C2=A00x000000000050c53d in pkt_burst_io_forward ()<br>#7 =
=C2=A00x00000000005427b4 in run_pkt_fwd_on_lcore ()<br>#8 =C2=A00x000000000=
054289b in start_pkt_forward_on_core ()<br>#9 =C2=A00x0000000000a473c9 in e=
al_thread_loop ()<br>#10 0x00007ffff60061ca in start_thread () from /lib64/=
libpthread.so.0<br>#11 0x00007ffff5c72e73 in clone () from /lib64/libc.so.6=
</font><br><div><br></div><div>I&#39;ve raised the bugs as instructed (ID 1=
776, 1777, 1778 and 1779) and included the stack trace there too.</div><div=
><br></div><div><br>With regards,</div><div>Joni<br><br></div></div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Aug 20, 2025 at 8:04=E2=80=AFPM Dariusz Sosnowski &=
lt;<a href=3D"mailto:dsosnowski@nvidia.com">dsosnowski@nvidia.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Aug 20, 2025 at 04:40:16PM +0800, Joni wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I hope this is the correct place to report these issues since it seems=
 to<br>
&gt; be related to DPDK codes. I&#39;ve reported this to Nvidia a few days =
ago but<br>
&gt; have yet to receive any response from them.<br>
&gt; <br>
&gt; My server is currently using ConnectX5 MT27800 (mlx5_core 5.7-1.0.2) o=
n<br>
&gt; firmware 16.35.4506 (MT_0000000011). My DPDK library version is 22.11.=
<br>
&gt; <br>
&gt; I ran the following testpmd command which resulted in segmentation fau=
lt (I<br>
&gt; am currently running on filtered traffic with packets &gt;1000 bytes t=
o<br>
&gt; increase the odds of hitting the segmentation fault):<br>
&gt; <br>
&gt; dpdk-testpmd -l 1-5 -n 4 -a<br>
&gt; 0000:1f:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq=
_en=3D1,mprq_log_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_le=
n=3D64,rx_vec_en=3D1<br>
&gt; -- -i --rxd=3D8192 --max-pkt-len=3D1700 --rxq=3D1 --total-num-mbufs=3D=
16384<br>
&gt; --mbuf-size=3D3000 --enable_drop_en =E2=80=93enable_scatter<br>
&gt; <br>
&gt; This segmentation fault goes away when I disable vectorization<br>
&gt; (rx_vec_en=3D0). (Note that the segmentation fault does not occur in<b=
r>
&gt; forward-mode=3Drxonly). The segmentation fault also seems to happen wi=
th<br>
&gt; higher chances when there is a rxnombuf.<br>
<br>
Thank you for reporting and for the analysis.<br>
<br>
Could you please open a bug on <a href=3D"https://bugs.dpdk.org/" rel=3D"no=
referrer" target=3D"_blank">https://bugs.dpdk.org/</a> with all the<br>
details?<br>
<br>
Do you happen to have a stack trace from the segmentation fault?<br>
<br>
Slava: Could you please take a look at the issue described by Joni in this =
mail?<br>
<br>
&gt; <br>
&gt; Upon some investigation, I noticed that in DPDK=E2=80=99s source codes=
<br>
&gt; drivers/net/mlx5/mlx5_rxtx_vec.c<br>
&gt; (function rxq_copy_mprq_mbuf_v()), there is a possibility where the<br=
>
&gt; consumed stride exceeds the stride number (64 in this case) which shou=
ld<br>
&gt; not be happening. I&#39;m suspecting there&#39;s some CQE misalignment=
 here upon<br>
&gt; encountering rxnombuf.<br>
&gt; <br>
&gt; rxq_copy_mprq_mbuf_v(...) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0if(rxq-&gt;consumed_strd =3D=3D strd_n) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// replenish WQE<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0strd_cnt =3D (elts[i]-&gt;pkt_len / strd_sz) +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((elts[i]-&gt;p=
kt_len % strd_sz) ? 1 : 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]-=
&gt;pkt_len, buf,<br>
&gt; rxq-&gt;consumed_strd, strd_cnt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0rxq-&gt;consumed_strd +=3D strd_cnt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0// encountering cases where<br>
&gt; rxq-&gt;consumed_strd &gt; strd_n<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; }<br>
&gt; <br>
&gt; In addition, there were also cases in mprq_buf_to_pkt() where the allo=
cated<br>
&gt; seg address is exactly the same as the pkt (elts[i]) address passed in=
<br>
&gt; which should not happen.<br>
&gt; <br>
&gt; mprq_buf_to_pkt(...) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0if(hdrm_overlap &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLX5_ASSERT(rxq-&gt;strd_scatter_en);=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *seg =3D rte_pktmbuf_=
alloc(rxq-&gt;mp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(seg =3D=3D NULL)) return=
 MLX5_RXQ_CODE_NOMBUF;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_DATA_OFF(seg, 0);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// added debug statement<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_LOG(DEBUG, &quot;pkt %p seg %p&qu=
ot;, (void *)pkt, (void *)seg);<br>
&gt; <br>
&gt; rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -<br>
&gt; hdrm_overlap), hdrm_overlap); ... } }<br>
&gt; <br>
&gt; I have tried upgrading my DPDK version to 24.11 but the segmentation f=
ault<br>
&gt; still persists.<br>
&gt; <br>
&gt; In addition, there were also a few other issues that I&#39;ve noticed:=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - max-pkt-len does not seem to work for values &lt; 1500 =
even though &quot;show<br>
&gt;=C2=A0 =C2=A0 port info X&quot; showed that the MTU was set to the valu=
e I&#39;ve passed in<br>
&gt;=C2=A0 =C2=A0 - In mprq_buf_to_pkt():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - uint32_t seg_len =3D RTE_MIN(len, (uint32=
_t)(pkt-&gt;buf_len -<br>
&gt;=C2=A0 =C2=A0 RTE_PKTMBUF_HEADROOM)) --&gt; seems unnecessary as to hit=
 this code, len has<br>
&gt;=C2=A0 =C2=A0 to be greater than (uint32_t)(pkt-&gt;buf_len - RTE_PKTMB=
UF_HEADROOM) due to<br>
&gt;=C2=A0 =C2=A0 the if condition<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - If the allocation struct rte_mbuf *next =
=3D<br>
&gt;=C2=A0 =C2=A0 rte_pktmbuf_alloc(rxq-&gt;mp) fails and packet has more t=
han 2 segs, the segs<br>
&gt;=C2=A0 =C2=A0 that were allocated previously do not get freed<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0mprq_buf_to_pkt(...) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 } else if (rxq-&gt;strd_scatter_en) {<br>
&gt; <br>
&gt; struct rte_mbuf *prev =3D pkt;<br>
&gt; <br>
&gt; uint32_t seg_len =3D RTE_MIN(len, (uint32_t)<br>
&gt; <br>
&gt; (pkt-&gt;buf_len - RTE_PKTMBUF_HEADROOM));<br>
&gt; <br>
&gt; uint32_t rem_len =3D len - seg_len;<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_memcpy(rte_pktmbuf_mtod(pkt, void *), ad=
dr, seg_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DATA_LEN(pkt) =3D seg_len;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while (rem_len) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf *next =3D rte_pktmbu=
f_alloc(rxq-&gt;mp);<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(next =3D=
=3D NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ML=
X5_RXQ_CODE_NOMBUF;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0- In the external buffer attach case where hdrm_ove=
rlap &gt; 0, the code<br>
&gt; did not decrement the buffer refcnt if allocation struct rte_mbuf *nex=
t =3D<br>
&gt; rte_pktmbuf_alloc(rxq-&gt;mp) fails<br>
&gt; <br>
&gt; mprq_buf_to_pkt(...) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hd=
rm_overlap &gt; 0) {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__atomic_add_fetch(&amp;buf-&gt;refcn=
t, 1, __ATOMIC_RELAXED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLX5_ASSERT(rxq-&gt;strd_scatter_en);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *seg =3D rte_pktmbuf_=
alloc(rxq-&gt;mp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(seg =3D=3D NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MLX5_RXQ_CODE_NO=
MBUF;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_DATA_OFF(seg, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; <br>
&gt; <br>
&gt; Hope to hear from you soon!<br>
&gt; <br>
&gt; With regards,<br>
&gt; Joni<br>
<br>
Best regards,<br>
Dariusz Sosnowski<br>
</blockquote></div>

--000000000000bfece0063cd77eb4--
