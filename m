Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B540CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55820402DD;
	Wed, 20 Aug 2025 11:47:17 +0200 (CEST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mails.dpdk.org (Postfix) with ESMTP id 92D524026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 10:40:29 +0200 (CEST)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-333f8f0965dso52442701fa.1
 for <dev@dpdk.org>; Wed, 20 Aug 2025 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755679229; x=1756284029; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aCOCkATXcCJLMTtk+lffLGYk1pp2ffpWKNFU5rfHG20=;
 b=PYO7Czm1jm9vIHZTGHNkwmPFlNwF+5VV4gcMmSP8R7iM/MMlGxM2BQu7bZJOL0lxZP
 047Ps9G1XotaGcMvbx1BwwCNTuQVsziVFf9C9UD8UCixxAjDR4ag/jJItnbIiaK6FQ4P
 uiHqXKOmMnVIdcihbytLpbnjBZF3GS9l/wp8NjqxBUttTvjATRT6vz6MbgVwE4JZ1ikX
 opX+FPUOWlv66YoTHfGg11DG6c+8rVHjanxME4TPrlG9qiCAnWIPFzae3TUnt0jyJfl1
 rMZ9R2ParzxoYP2RX2ke0ZuOXjX19dh/cGmuBSe3Hrqd4YN+ioPlHAJ1y49DL9UQFm5T
 /UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755679229; x=1756284029;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCOCkATXcCJLMTtk+lffLGYk1pp2ffpWKNFU5rfHG20=;
 b=CYmOxVum2vzCZasphMexNCPEyyQxWd8gNw0kpC+6JwAUFAGNicXufe4H3sa/yAV7SM
 qJ2xOSlRW4jcOg/AtRN80WgUxo5045eNj67oHZEzhAKc+CudGPKswfZLbxJuxputb/45
 /W5j1wpGMDQSTStyYZM53PdwH5YrzQvHsR7/Jkkr687akVh+hK8aLZwn/V3e4+igqhnw
 9r+L0y3icLQ+svpvkQRcQX/+3XDGurLAABttLqST4z1g6F8ZFIYTbxOJqA80Kebe94X9
 n1407evFFlh22XHyNk/WRQ9HDxoZpXCgyPaCE2/fdNfRd/4wk22ck0cQ30EX9cx/lCQ3
 o7Bw==
X-Gm-Message-State: AOJu0YwhfmTHBubNY0BH7KgHbjnWpQsTULyiC8srSQ0HHEvd7P2r2nXM
 vvjmgHFOeAXpcq/B/oIA2ZVZUbXvy0hiW5btC2AD/J9eG0zgr/n2rq5NuZkCPJRBO9tFArh47fq
 LGVakIbxQTm+JLvMr8jTUFYxS75wr8nh+AtDh
X-Gm-Gg: ASbGncuagldSnqvANyMu14D+A+tXjN+TK8OAPH79uJl6C52izTGwxZ3GOiW7niOnuev
 hxlDoFLa685VxI/bNnMG5DZsC0hgtV9fzoYXOzvy5YMpEnFUalgbcbpK1E8E+25WtZTL/mu9l7I
 QUTuQOH3BZufkovnuViJSpvG5WXUMAQVBf1Z6hp/twpfWcEXUw+zmOQoCooN3X9njI0wXCNPjXv
 jI/Xp+zCQ==
X-Google-Smtp-Source: AGHT+IFedZ1J2390Brt+HW350iCOyDdbcmf4WEU1BY2mOtGFt66YQeZ/00Jj0+Dp4QecZze8XJuCviTI7Pwx8/HD0gQ=
X-Received: by 2002:a05:651c:1118:10b0:32f:3671:4d6d with SMTP id
 38308e7fff4ca-3353bcced65mr4655411fa.1.1755679228301; Wed, 20 Aug 2025
 01:40:28 -0700 (PDT)
MIME-Version: 1.0
From: Joni <canary.overflow@gmail.com>
Date: Wed, 20 Aug 2025 16:40:16 +0800
X-Gm-Features: Ac12FXxEwZ9YKAHH7DbvEMQwwI3DmCFVYErlQ180igPpW9GrTWSv6kSbWS6sUJY
Message-ID: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
Subject: Segmentation fault when running MPRQ on testpmd
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000be1609063cc7ece4"
X-Mailman-Approved-At: Wed, 20 Aug 2025 11:47:15 +0200
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

--000000000000be1609063cc7ece4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hope this is the correct place to report these issues since it seems to
be related to DPDK codes. I've reported this to Nvidia a few days ago but
have yet to receive any response from them.

My server is currently using ConnectX5 MT27800 (mlx5_core 5.7-1.0.2) on
firmware 16.35.4506 (MT_0000000011). My DPDK library version is 22.11.

I ran the following testpmd command which resulted in segmentation fault (I
am currently running on filtered traffic with packets >1000 bytes to
increase the odds of hitting the segmentation fault):

dpdk-testpmd -l 1-5 -n 4 -a
0000:1f:00.0,rxq_comp_en=3D1,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=
=3D1,mprq_log_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_len=
=3D64,rx_vec_en=3D1
-- -i --rxd=3D8192 --max-pkt-len=3D1700 --rxq=3D1 --total-num-mbufs=3D16384
--mbuf-size=3D3000 --enable_drop_en =E2=80=93enable_scatter

This segmentation fault goes away when I disable vectorization
(rx_vec_en=3D0). (Note that the segmentation fault does not occur in
forward-mode=3Drxonly). The segmentation fault also seems to happen with
higher chances when there is a rxnombuf.

Upon some investigation, I noticed that in DPDK=E2=80=99s source codes
drivers/net/mlx5/mlx5_rxtx_vec.c
(function rxq_copy_mprq_mbuf_v()), there is a possibility where the
consumed stride exceeds the stride number (64 in this case) which should
not be happening. I'm suspecting there's some CQE misalignment here upon
encountering rxnombuf.

rxq_copy_mprq_mbuf_v(...) {
    ...
    if(rxq->consumed_strd =3D=3D strd_n) {
        // replenish WQE
    }
    ...
    strd_cnt =3D (elts[i]->pkt_len / strd_sz) +
               ((elts[i]->pkt_len % strd_sz) ? 1 : 0);

    rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]->pkt_len, buf,
rxq->consumed_strd, strd_cnt);
    rxq->consumed_strd +=3D strd_cnt;       // encountering cases where
rxq->consumed_strd > strd_n
    ...
}

In addition, there were also cases in mprq_buf_to_pkt() where the allocated
seg address is exactly the same as the pkt (elts[i]) address passed in
which should not happen.

mprq_buf_to_pkt(...) {
    ...
    if(hdrm_overlap > 0) {
        MLX5_ASSERT(rxq->strd_scatter_en);

        struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq->mp);
        if (unlikely(seg =3D=3D NULL)) return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);

        // added debug statement
        DRV_LOG(DEBUG, "pkt %p seg %p", (void *)pkt, (void *)seg);

rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR_ADD(addr, len -
hdrm_overlap), hdrm_overlap); ... } }

I have tried upgrading my DPDK version to 24.11 but the segmentation fault
still persists.

In addition, there were also a few other issues that I've noticed:

   - max-pkt-len does not seem to work for values < 1500 even though "show
   port info X" showed that the MTU was set to the value I've passed in
   - In mprq_buf_to_pkt():
       - uint32_t seg_len =3D RTE_MIN(len, (uint32_t)(pkt->buf_len -
   RTE_PKTMBUF_HEADROOM)) --> seems unnecessary as to hit this code, len ha=
s
   to be greater than (uint32_t)(pkt->buf_len - RTE_PKTMBUF_HEADROOM) due t=
o
   the if condition
       - If the allocation struct rte_mbuf *next =3D
   rte_pktmbuf_alloc(rxq->mp) fails and packet has more than 2 segs, the se=
gs
   that were allocated previously do not get freed

    mprq_buf_to_pkt(...) {
        ...                } else if (rxq->strd_scatter_en) {

struct rte_mbuf *prev =3D pkt;

uint32_t seg_len =3D RTE_MIN(len, (uint32_t)

(pkt->buf_len - RTE_PKTMBUF_HEADROOM));

uint32_t rem_len =3D len - seg_len;


      rte_memcpy(rte_pktmbuf_mtod(pkt, void *), addr, seg_len);
      DATA_LEN(pkt) =3D seg_len;
      while (rem_len) {
         struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq->mp);


            if (unlikely(next =3D=3D NULL))
                return MLX5_RXQ_CODE_NOMBUF;
            ...
    - In the external buffer attach case where hdrm_overlap > 0, the code
did not decrement the buffer refcnt if allocation struct rte_mbuf *next =3D
rte_pktmbuf_alloc(rxq->mp) fails

mprq_buf_to_pkt(...) {
    ...            if (hdrm_overlap > 0) {

        __atomic_add_fetch(&buf->refcnt, 1, __ATOMIC_RELAXED);
        ...
        MLX5_ASSERT(rxq->strd_scatter_en);
        struct rte_mbuf *seg =3D rte_pktmbuf_alloc(rxq->mp);
        if (unlikely(seg =3D=3D NULL))
            return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);
        ...


Hope to hear from you soon!

With regards,
Joni

--000000000000be1609063cc7ece4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>Hi, <br><br>I hope this is the correct=
 place to report these issues since it seems to be related to DPDK codes. I=
&#39;ve reported this to Nvidia a few days ago but have yet to receive any =
response from them.<br><br>My server is currently using ConnectX5 MT27800 (=
mlx5_core 5.7-1.0.2) on firmware 16.35.4506 (MT_0000000011). My DPDK librar=
y version is 22.11.</p><p>I ran the following testpmd command which resulte=
d in segmentation fault (I am currently running on filtered traffic with pa=
ckets &gt;1000 bytes to increase the odds of hitting the segmentation fault=
):</p><pre><code>dpdk-testpmd -l 1-5 -n 4 -a 0000:1f:00.0,rxq_comp_en=3D1,r=
xq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=3D1,mprq_log_stride_num=3D6,mpr=
q_log_stride_size=3D9,mprq_max_memcpy_len=3D64,rx_vec_en=3D1 -- -i --rxd=3D=
8192 --max-pkt-len=3D1700 --rxq=3D1 --total-num-mbufs=3D16384 --mbuf-size=
=3D3000 --enable_drop_en =E2=80=93enable_scatter</code></pre><p>This segmen=
tation fault goes away when I disable vectorization (rx_vec_en=3D0). (Note =
that the segmentation fault does not occur in forward-mode=3Drxonly). The s=
egmentation fault also seems to happen with higher chances when there is a =
rxnombuf.<br><br>Upon some investigation, I noticed that in DPDK=E2=80=99s =
source codes <code>drivers/net/mlx5/mlx5_rxtx_vec.c (function rxq_copy_mprq=
_mbuf_v())</code>, there is a possibility where the consumed stride exceeds=
 the stride number (64 in this case) which should not be happening. I&#39;m=
 suspecting there&#39;s some CQE misalignment here upon encountering rxnomb=
uf.</p><pre><code>rxq_copy_mprq_mbuf_v(...) {
    ...
    if(rxq-&gt;consumed_strd =3D=3D strd_n) {  =20
        // replenish WQE
    }
    ...
    strd_cnt =3D (elts[i]-&gt;pkt_len / strd_sz) +=20
               ((elts[i]-&gt;pkt_len % strd_sz) ? 1 : 0);

    rxq_code =3D mprq_buf_to_pkt(rxq, elts[i], elts[i]-&gt;pkt_len, buf, rx=
q-&gt;consumed_strd, strd_cnt);
    rxq-&gt;consumed_strd +=3D strd_cnt;       // encountering cases where =
rxq-&gt;consumed_strd &gt; strd_n
    ...
}</code></pre><p>In addition, there were also cases in mprq_buf_to_pkt() wh=
ere the allocated seg address is exactly the same as the pkt (elts[i]) addr=
ess passed in which should not happen.<br></p><pre><code>mprq_buf_to_pkt(..=
.) {
    ...
    if(hdrm_overlap &gt; 0) {  =20
        MLX5_ASSERT(rxq-&gt;strd_scatter_en);<pre><code>        struct rte_=
mbuf *seg =3D rte_pktmbuf_alloc(rxq-&gt;mp);
        if (unlikely(seg =3D=3D NULL)) return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);
       =20
        // added debug statement
        DRV_LOG(DEBUG, &quot;pkt %p seg %p&quot;, (void *)pkt, (void *)seg)=
;<br></code></pre>        rte_memcpy(rte_pktmbuf_mtod(seg, void *), RTE_PTR=
_ADD(addr, len - hdrm_overlap), hdrm_overlap);
        ...
    }
}</code></pre><p>I have tried upgrading my DPDK version to 24.11 but the se=
gmentation fault still persists.=C2=A0<br><br>In addition, there were also =
a few other issues that I&#39;ve noticed:<br></p><ul><li>max-pkt-len does n=
ot seem to work for values &lt; 1500 even though &quot;show port info X&quo=
t; showed that the MTU was set to the value I&#39;ve passed in<br></li><li>=
In mprq_buf_to_pkt():<br>=C2=A0 =C2=A0 - uint32_t seg_len =3D RTE_MIN(len, =
(uint32_t)(pkt-&gt;buf_len - RTE_PKTMBUF_HEADROOM)) --&gt; seems unnecessar=
y as to hit this code, len has to be greater than=C2=A0(uint32_t)(pkt-&gt;b=
uf_len - RTE_PKTMBUF_HEADROOM) due to the if condition<br>=C2=A0 =C2=A0 - I=
f the allocation struct rte_mbuf *next =3D rte_pktmbuf_alloc(rxq-&gt;mp) fa=
ils and packet has more than 2 segs, the segs that were allocated previousl=
y do not get freed=C2=A0<br></li></ul><p></p><pre><code>    mprq_buf_to_pkt=
(...) {
        ...       =20
</code>        } else if (rxq-&gt;strd_scatter_en) {</pre></div><blockquote=
 style=3D"margin:0 0 0 40px;border:none;padding:0px"><blockquote style=3D"m=
argin:0 0 0 40px;border:none;padding:0px"><div><font face=3D"monospace">			=
struct rte_mbuf *prev =3D pkt;</font></div></blockquote><blockquote style=
=3D"margin:0 0 0 40px;border:none;padding:0px"><div><font face=3D"monospace=
">			uint32_t seg_len =3D RTE_MIN(len, (uint32_t)</font></div></blockquote>=
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><font =
face=3D"monospace">				(pkt-&gt;buf_len - RTE_PKTMBUF_HEADROOM));</font></d=
iv></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;padding:=
0px"><div><font face=3D"monospace">			uint32_t rem_len =3D len - seg_len;</=
font></div></blockquote><div><font face=3D"monospace"><br></font></div><div=
><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 rte_memcpy(rte_pktmbuf_mtod(=
pkt, void *),=C2=A0</font><span style=3D"font-family:monospace">addr, seg_l=
en);</span></div><div><font face=3D"monospace">=C2=A0 =C2=A0 =C2=A0 DATA_LE=
N(pkt) =3D seg_len;</font></div><div><font face=3D"monospace">=C2=A0 =C2=A0=
 =C2=A0 while (rem_len) {</font></div><div><font face=3D"monospace">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *next =3D</font><span style=3D"f=
ont-family:monospace">=C2=A0rte_pktmbuf_alloc(rxq-&gt;mp);</span></div></bl=
ockquote><div dir=3D"ltr"><font face=3D"monospace"><br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 if (unlikely(next =3D=3D NULL))<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return MLX5_RXQ_CODE_NOMBUF;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br></font>=C2=A0 =C2=A0 - In the=
 external buffer attach case where hdrm_overlap &gt; 0, the code did not de=
crement the buffer refcnt if allocation struct rte_mbuf *next =3D rte_pktmb=
uf_alloc(rxq-&gt;mp) fails<br></div><blockquote style=3D"margin:0 0 0 40px;=
border:none;padding:0px"><div dir=3D"ltr"><div><pre><code>mprq_buf_to_pkt(.=
..) {
    ...       =20
</code>    if (hdrm_overlap &gt; 0) {</pre><pre>        __atomic_add_fetch(=
&amp;buf-&gt;refcnt, 1, __ATOMIC_RELAXED);
        ...
        MLX5_ASSERT(rxq-&gt;strd_scatter_en);
        struct rte_mbuf *seg =3D=C2=A0rte_pktmbuf_alloc(rxq-&gt;mp);
        if (unlikely(seg =3D=3D NULL))
            return MLX5_RXQ_CODE_NOMBUF;
        SET_DATA_OFF(seg, 0);
        ...</pre></div></div></blockquote><div dir=3D"ltr"><pre></pre><br>H=
ope to hear from you soon!<br><br>With regards,<br>Joni</div>
</div>

--000000000000be1609063cc7ece4--
