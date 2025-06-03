Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7DC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 05:54:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5FB44028E;
	Tue,  3 Jun 2025 07:54:34 +0200 (CEST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by mails.dpdk.org (Postfix) with ESMTP id 069604025A
 for <dev@dpdk.org>; Tue,  3 Jun 2025 07:54:33 +0200 (CEST)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-525da75d902so1592107e0c.3
 for <dev@dpdk.org>; Mon, 02 Jun 2025 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748930072; x=1749534872; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gs2Dr3dbjbHkuvionsENd0EtGe6zlhFZkZaixYrhKAo=;
 b=T0v/cEepzXGzX5ERPxoMq+LjNvlKK38xpJVQsYyQ1qklQOzOmXD6LWyUPpayXH6c27
 PiXIHrtgxkShO3GvqBW3ulPHrqwSA0uW0oeSf+qS4DLwC9e37VShf02cPQhO9xTI0eHM
 xG8LCG7C0CTV76qo+S/5TJTfcA895Vp7fl0XCiAYtCq3wvmj5SUhU5mln15IOqudoa7y
 FQQitjam85MabMYW5q+nlGw02D8ZN0OVV9wj9w89hN6qzPkPaEEWYsrp7ZzmCgvmBVgd
 pFOA3D5ZZW3tUzZf325UY9ZG5gsXcgjfZa+75LQYC5smDUjgPCZ2u7rnlhaNuxsfuDJD
 x08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748930072; x=1749534872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gs2Dr3dbjbHkuvionsENd0EtGe6zlhFZkZaixYrhKAo=;
 b=L8tI96JKOaLEAyJ/8RapIEQuSRXO3uIJkuj95z0Dz2yix5pBszgCGZUwO7JNAiYTXb
 LX7/8/2iedCsHCAHwA8zjfBXN95Q+nhBE5SDmiTNE7QF3AeEwd5KazOYJaSTX1NOd/0i
 0hRGTzEr8jKNzuMkRaisMFgPjseJiUGplLlUIgD3WI05ILNTug0Qb38wJPecBSxHjre2
 Xlce8S8WoYx30H0022SaentIH5x2q2rajOnU56C8sTP0mRff36YYBL2xY3tob3Nya5Xi
 JC8gnPXMF5HYOIYBaPwVrwNeCI72kP45bImzpO/pYOfMARyAlDnInH9PGcEiqsdIWoBr
 cayA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5nP+VNhjmzpiJcF9bCNtlWqXiH/W5/CaqwbpfRzhHqEID2hG46389LTcbP5cxKxOJLQY=@dpdk.org
X-Gm-Message-State: AOJu0Yy3ebDqx27zwPdGAZeFF36rBzIEaSvqVunOgt6aN63Z7bbbUMDh
 zvGve5D1g3OATxpYMOZ222PebaXcRp6bM8+/3jBubzqrJchleQP8GBeK4yiQkVfOYkPdurP5JxZ
 KKKNQPkJRbX0hWMR+Wcs5/knZ/ecQucg=
X-Gm-Gg: ASbGncsqTNJm6kcl2vnpluAtnYtjDd1NXINtHpG1U2+JH5cNEsRGH5vBqNsHShpMBUv
 OssbwtM8svtJJrKvU3TH/qAdk65q1r/7kftADvvql9+8Q8wLKwvbwFLB3jUFXfoYvP8hWB0z4jo
 UR66bgcxXQNw+8RslOdw1FJMHdcXDO1WXolKxGJZ71cg==
X-Google-Smtp-Source: AGHT+IFkD35xlog+9Ui929Uz9VBLhZi2ONR7y7rWmDNdsQC5jTNFGtAvXd7XvQOZ1Ah4PLyvIT4AslDOSlC0r7dNJHI=
X-Received: by 2002:a05:6122:1e11:b0:530:65b3:4920 with SMTP id
 71dfb90a1353d-53080fa9934mr13814341e0c.5.1748930072079; Mon, 02 Jun 2025
 22:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCA9@smartserver.smartshare.dk>
 <CAG6-93zSt1SGRa0XnJnodCtiOKWUMTYBY26A3qy9cE1hd_K3oQ@mail.gmail.com>
In-Reply-To: <CAG6-93zSt1SGRa0XnJnodCtiOKWUMTYBY26A3qy9cE1hd_K3oQ@mail.gmail.com>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Tue, 3 Jun 2025 11:24:20 +0530
X-Gm-Features: AX0GCFtMzL8zy26ouN1XwBhUIQoePwdwUWXt6QXSOh7bfEmUk1d7a39ZQYXAx5E
Message-ID: <CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2yuQteyqTZBUm=Kyk4Bg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] add lookup fib nodes in graph library
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Ankur Dwivedi <adwivedi@marvell.com>, vladimir.medvedkin@intel.com, 
 Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>, skori@marvell.com,
 rkudurumalla@marvell.com, 
 Nitin Saxena <nsaxena@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Morten,

Let me take a stab regarding the VRF question.
Please find answers inline

Thanks,
Nitin

On Mon, Jun 2, 2025 at 2:12=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesys=
tems.com> wrote:
>
> +TO: Robin Jarry, might have relevant feedback for such a node
>
> > From: Ankur Dwivedi [mailto:adwivedi@marvell.com]
> > Sent: Monday, 2 June 2025 08.36
> >
> > This patch series adds two inbuilt nodes ip4_lookup_fib and
> > ip6_lookup_fib in graph library. These nodes uses the existing
> > Forwarding Information Base (FIB) library to create FIB, to do
> > route addition and route lookup.
> >
> > Two new commands (for ipv4 and ipv6) for providing the lookup mode
> > is added in the dpdk-graph application. fib or lpm can be given as
> > lookup mode. If these new lookup mode commands are not given, the
> > dpdk-graph uses lpm (Longest Prefix Match) or lpm6 by default.
> > If fib is given as lookup mode then the ip4_lookup_fib or
> > ip6_lookup_fib
> > nodes are used by the application.
>
> @Ankur, @Vladimir, @Jerin,
>
> A couple of high level questions...
>
> 1. Thread safety:
> I'm not familiar with the thread safety models of the FIB and Graph libra=
ries.
> Is the FIB library thread safe, so one thread can invoke the FIB modify o=
peration while other threads invoke the FIB lookup operation?
> If it isn't, how does the Graph library make its use of the FIB library t=
hread safe?
>

Just a nit-pick here, there are two libraries used by rte_graph application=
s
- Graph library (lib/graph/*)
- Node library (lib/node/*)

Questions here are pertaining to "Node library" and not to "Graph library"

> 2. VRF support:
> This looks like a global route table for the entire graph.
Correct.

> Shouldn't there be a route table per FIB node?
Yes when VRF support is added in library, one FIB would support on route ta=
ble

> Or how are VRFs supported by the Graph library?
> Or is there no requirement to support VRFs in the Graph library?
>
Currently the node library(instead of Graph library) does not support
VRF. There is an intention to add it in lib/node/ip[4|6]-lookup nodes
IMO, @Vladimir can correct me, even FIB support for multiple VRF is
unoptimized because rte_fib_lookup_bulk() function takes single fib
pointer instead of multiple fib pointers
For adding VRF support in ip[4|6]-lookup nodes ideally we would like to hav=
e

rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips, uint64_t
next_hops, int n); (OR different new API)

taking an array of fib pointers (or fib index) corresponding to each
nth packet. It should also avoid fib->lookup() callback for every
packet.
We can also add this API as part of "Node library" but we need "static
inline" version of fib->lookup() in rte_fib header file

> -Morten
>
