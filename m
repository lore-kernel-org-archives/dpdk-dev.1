Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF9CD98D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 05:43:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43F9A433A6;
	Fri, 12 Jun 2026 07:43:13 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 5EAF54027F
 for <dev@dpdk.org>; Fri, 12 Jun 2026 07:43:11 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8ccef9eabccso17509526d6.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 22:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781242990; cv=none;
 d=google.com; s=arc-20240605;
 b=Zghn9qQma5qtUh51P3aphjCo5XXA9jC6acyelKjxI/LzO4pUeaadpp9Pc+hH47bye5
 ZZ7sp2O8kUQQ/Ukd26LU+NfQnIarwCCZY/rJalyfLHxZkAE/aDbE6s94YTcRmlgcR/WG
 kdnfQMa+LR3+fDF0PplQ8ygTXsaXEzpj03Q5AFEiEG24tqCeTmXHcfkF6oR9zAzzTfPG
 NsK11Tp9DTX+uiQJhjakB8zaCWHObV7mTDnCTl27vU3RtffzUwM7lB4FnrU3vD+qs+Ff
 u+Ji/w5gfqpbm3Hd4b26i4BXQADrK90fK7wSMsNioem1C6gmeutNCCEf1JaAQANqnHbK
 OotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=gWbkIj4L4YkQa0vbwb3Jb9WOLqfqH+a8pGTntg/12Kw=;
 fh=5ZQ2igwNLOZN1rO+Nz/VeZR4mtRe8m0+gqjP3de9UfA=;
 b=OwPf9ha5IFb9vI1Mv9HaDR7ROBhvVlyIQGa8nTsYxMqIgjE8wkxscY9PJQ6RpprZ+g
 ZrTUtoM0Yjei1JsGhfP/6LVjrlnS4uqww6OPHqNFnCg4hrcrKeq5XP4cQ4nJwADeMYa4
 JlQBZ2Tg/agTWAkmepw4lLKEd5sX+yLqCRjolYXvuz9bXOAB7zxJlhlvUnVHqQHhhBmg
 JmHmqHla9xJPr2eKKqZL7uCmF9PE2i4oR9QM0Ml64h0eaNNiszKk3UBtEJ/w3yoZWMd/
 yM1bB+lapcDW9oMOgWliIixI/CHk/CK1O4BNsYAfu1QCqPNgMOysXVcxNR6KhYtWADhm
 vYWA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781242990; x=1781847790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWbkIj4L4YkQa0vbwb3Jb9WOLqfqH+a8pGTntg/12Kw=;
 b=gsfYMQDboLZrwyEQuWLIKs3/bsXyYNfx7JDI0CPYqAAcZBWuJs3ylWFFyPjLyF/oj4
 vacrc63OBDSCHsDhCW1FSmWyZwvA5qy1mG5DOaiSR/cUl8QH2vkslWrl5zsO06MdNTsq
 REn6ZPAPdwW/B5p5WiMuMXTCV3g1AjeWDF0SDY9nw/srMAL7m5LZQ2IeIXiqitrRFgoe
 LhAKUwtg898zdRnx6CczCofAwQHSxV1ZUG5QsA9FxQPJEISTtesFPGS/2l/peaShxjgO
 zd4mN3752oMjdtXpvSP7t3n+CC5ZYllcOerJb/DdU0TvW2AWC8PsId1LPBuIwZ+ivveD
 F5XA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lismrpW/7Sn/dcQ4p0So/YplL6UVpoWmgljL1Bv+ed262neIslNivUcmVB2V3JSoYDCw=@dpdk.org
X-Gm-Message-State: AOJu0YyCZl/bfS/gtx1Gskc14YNgQ3FQPsK4+3QPoQFjrUww5Q6DTrfs
 klXiMcINgwXI9nSwUeiSg1CO58vqtCP+TorYpUoB7Ipr90mYWD4a4KJV2HQJmAYTFKkit+eA5Iv
 eVQNwHYkH66ihU8t9+3Ui8Epl31MTgWU=
X-Gm-Gg: Acq92OFmSjd8QmThzv+mxAHGU7RNAoAEI+QijFSYvVSX2Y3zlwmPbGYyClJLh6ZIWSB
 c1LVkXjLv75hksjBIjy/g1zHew8LLBZOa15Nq7EnSsjMwAh473qRtbgHvm9gc9HyDB0E/dBsOKu
 ha0L+ReydgbqW89TwIWJtVFz7rWjWHqIOJYNhQMXQY+FqZ3qkkcO0GvHxUgz1bgpnt5j7Y232/y
 y/q66JyzWpOdvt2lLjslL2vU8/cmYb5AjbTN0QKCXhMmJS4eRUUgvquv6/D5rz7a60rvGXXkah0
 RiXgzl7CDOWyFbE/nO2o5Arsj0Sj6z7cuRne4zJMoDlymWcn16sk
X-Received: by 2002:a05:620a:2589:b0:915:9931:3a39 with SMTP id
 af79cd13be357-91619f3982emr230337285a.34.1781242990528; Thu, 11 Jun 2026
 22:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-10-maxime@leroys.fr>
 <20260611103058.160842f4@phoenix.local>
In-Reply-To: <20260611103058.160842f4@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 12 Jun 2026 07:42:59 +0200
X-Gm-Features: AVVi8CfBJIcIgBnAFlxzEMnk6g_RSthUoubowPi-Hxxgks_3-veo5uNYnZ5UDrM
Message-ID: <CAHHRULX70qaJdu-4UJ7WHtjdMN-qNu35GhOCBY9G5kODrEgxqw@mail.gmail.com>
Subject: Re: [PATCH 9/9] net/dpaa2: drop the fake software VLAN strip offload
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b58c24065407f3ed"
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

--000000000000b58c24065407f3ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 11 juin 2026, 19:31, Stephen Hemminger <stephen@networkplumber.org>
a =C3=A9crit :

> On Thu, 11 Jun 2026 17:49:24 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > It saves a forwarding application nothing: the datapath reads the L2
> > header anyway to classify or strip. The offload does not remove that
> > read, it relocates it into the driver Rx burst, where it is far more
> > expensive.
> >
> > The cost is a matter of timing. rte_vlan_strip() reaches the L2 header
> > through rte_pktmbuf_mtod(), which dereferences mbuf->buf_addr. On a
> > freshly recycled buffer that mbuf cacheline is cold. eth_fd_to_mbuf()
> > has just written other fields of it (data_off, ol_flags), but buf_addr
> > is a persistent field it does not rewrite. A write does not stall: it
> > posts to the store buffer while the line fills in the background, and
> > the rewritten fields are forwarded straight from there. buf_addr has
> > nothing to forward, so it must be read from the line, whose fill is
> > still in flight, and the read stalls. The ethertype read that follows,
> > on the cold payload line, stalls again. Read later by the application,
> > when the fill has completed, the same read hits. The offload just
> > performs it at the worst possible moment.
> >
> > Measured on a single-core port-to-port forwarding test over two 10G
> > ports (one core at 2 GHz, 64-byte untagged frames):
> >
> >   - throughput 4.22 -> 5.00 Mpps (+18 percent)
> >   - IPC 0.93 -> 1.25: the cost was memory stall, not compute
> >   - L3/DRAM-bound L2 refills 319M -> 200M over 10s (-37 percent)
> >
> > perf confirms it: with the offload, the buf_addr load (the cold mbuf
> > field) and the payload load account for about 84 percent of the Rx
> > burst's L2 refills; removing it, those vanish and only the inherent DQR=
R
> > dequeue misses remain.
> >
> > Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from
> > every Rx path. This is a behavioural change: the tag is left in the
> > frame, so an application must strip it itself, on the L2 header it
> > already reads.
> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
>
> In general I agree, but you overstate the impact. Any real application
> is going to look at the mbuf anyway. Relying on testpmd numbers is BS.
>
> The NBL driver does the same thing.
> So does PCAP but it has no choice, and is slow anyway.
> Virtio/vhost does as well.


This was not measured with testpmd, but with Grout in I/O forwarding mode.

The comparison is exactly between Grout's software fallback and the
advertised offload path. Without VLAN_STRIP, Grout's rx_process() reads the
Ethernet header and strips the VLAN tag itself if needed. With VLAN_STRIP
enabled, Grout uses rx_offload_process(), which only consumes
RTE_MBUF_F_RX_VLAN_STRIPPED/vlan_tci and does not inspect the Ethernet
header
for VLAN stripping.

For dpaa2, however, VLAN_STRIP is not done by the device. The PMD
implements the advertised offload by calling rte_vlan_strip() in the Rx
burst path. So enabling the "offload" just moves the same software work
from Grout into the driver.

The cost is timing. rte_vlan_strip() calls rte_pktmbuf_mtod(), which needs
mbuf->buf_addr. That value is persistent mbuf metadata; it is not produced
by the FD-to-mbuf conversion. eth_fd_to_mbuf() has just written other mbuf
fields such as data_off and ol_flags; those writes can be posted or
forwarded, but
they do not provide buf_addr. If the mbuf cacheline is cold, the buf_addr
load
has to wait for that line to be fetched before the driver can reach the
Ethernet header.

Grout does the same L2 read later in rx_process(), where it is already
processing L2. So the fake PMD offload performs the same software fallback,
but injects an extra mbuf-metadata dependency at a worse point in the Rx
burst path.

--000000000000b58c24065407f3ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Le jeu. 11 juin 2026, 19:31, Stephen=
 Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_bla=
nk" rel=3D"noreferrer">stephen@networkplumber.org</a>&gt; a =C3=A9crit=C2=
=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On Thu, 11 Jun 2026 17:49:24 +=
0200<br>
Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">maxime@leroys.fr</a>&gt; wrote:<br>
<br>
&gt; It saves a forwarding application nothing: the datapath reads the L2<b=
r>
&gt; header anyway to classify or strip. The offload does not remove that<b=
r>
&gt; read, it relocates it into the driver Rx burst, where it is far more<b=
r>
&gt; expensive.<br>
&gt; <br>
&gt; The cost is a matter of timing. rte_vlan_strip() reaches the L2 header=
<br>
&gt; through rte_pktmbuf_mtod(), which dereferences mbuf-&gt;buf_addr. On a=
<br>
&gt; freshly recycled buffer that mbuf cacheline is cold. eth_fd_to_mbuf()<=
br>
&gt; has just written other fields of it (data_off, ol_flags), but buf_addr=
<br>
&gt; is a persistent field it does not rewrite. A write does not stall: it<=
br>
&gt; posts to the store buffer while the line fills in the background, and<=
br>
&gt; the rewritten fields are forwarded straight from there. buf_addr has<b=
r>
&gt; nothing to forward, so it must be read from the line, whose fill is<br=
>
&gt; still in flight, and the read stalls. The ethertype read that follows,=
<br>
&gt; on the cold payload line, stalls again. Read later by the application,=
<br>
&gt; when the fill has completed, the same read hits. The offload just<br>
&gt; performs it at the worst possible moment.<br>
&gt; <br>
&gt; Measured on a single-core port-to-port forwarding test over two 10G<br=
>
&gt; ports (one core at 2 GHz, 64-byte untagged frames):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- throughput 4.22 -&gt; 5.00 Mpps (+18 percent)<br>
&gt;=C2=A0 =C2=A0- IPC 0.93 -&gt; 1.25: the cost was memory stall, not comp=
ute<br>
&gt;=C2=A0 =C2=A0- L3/DRAM-bound L2 refills 319M -&gt; 200M over 10s (-37 p=
ercent)<br>
&gt; <br>
&gt; perf confirms it: with the offload, the buf_addr load (the cold mbuf<b=
r>
&gt; field) and the payload load account for about 84 percent of the Rx<br>
&gt; burst&#39;s L2 refills; removing it, those vanish and only the inheren=
t DQRR<br>
&gt; dequeue misses remain.<br>
&gt; <br>
&gt; Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from=
<br>
&gt; every Rx path. This is a behavioural change: the tag is left in the<br=
>
&gt; frame, so an application must strip it itself, on the L2 header it<br>
&gt; already reads.<br>
&gt; <br>
&gt; Signed-off-by: Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" re=
l=3D"noreferrer noreferrer" target=3D"_blank">maxime@leroys.fr</a>&gt;<br>
&gt; ---<br>
<br>
In general I agree, but you overstate the impact. Any real application<br>
is going to look at the mbuf anyway. Relying on testpmd numbers is BS.<br>
<br>
The NBL driver does the same thing.<br>
So does PCAP but it has no choice, and is slow anyway.<br>
Virtio/vhost does as well.</blockquote></div></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">This was not measured with testpmd, but with Gr=
out in I/O forwarding mode.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">The comparison is exactly between Grout&#39;s software fallback and the=
 advertised offload path. Without VLAN_STRIP, Grout&#39;s rx_process() read=
s the Ethernet header and strips the VLAN tag itself if needed. With VLAN_S=
TRIP enabled, Grout uses rx_offload_process(), which only consumes</div><di=
v dir=3D"auto">RTE_MBUF_F_RX_VLAN_STRIPPED/vlan_tci and does not inspect th=
e Ethernet header</div><div dir=3D"auto">for VLAN stripping.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">For dpaa2, however, VLAN_STRIP is not=
 done by the device. The PMD implements the advertised offload by calling r=
te_vlan_strip() in the Rx burst path. So enabling the &quot;offload&quot; j=
ust moves the same software work from Grout into the driver.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">The cost is timing. rte_vlan_strip() =
calls rte_pktmbuf_mtod(), which needs mbuf-&gt;buf_addr. That value is pers=
istent mbuf metadata; it is not produced by the FD-to-mbuf conversion. eth_=
fd_to_mbuf() has just written other mbuf fields such as data_off and ol_fla=
gs; those writes can be posted or forwarded, but</div><div dir=3D"auto">the=
y do not provide buf_addr. If the mbuf cacheline is cold, the buf_addr load=
</div><div dir=3D"auto">has to wait for that line to be fetched before the =
driver can reach the Ethernet header.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Grout does the same L2 read later in rx_process(), where it i=
s already processing L2. So the fake PMD offload performs the same software=
 fallback, but injects an extra mbuf-metadata dependency at a worse point i=
n the Rx burst path.</div><div dir=3D"auto"><div dir=3D"auto"><br></div></d=
iv></div>

--000000000000b58c24065407f3ed--
