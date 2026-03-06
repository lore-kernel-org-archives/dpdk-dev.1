Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32823F01804
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 08:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF95C402D3;
	Fri,  6 Mar 2026 09:09:22 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 2EBFB40278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 09:09:22 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-899fc265126so73115216d6.1
 for <dev@dpdk.org>; Fri, 06 Mar 2026 00:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772784561; cv=none;
 d=google.com; s=arc-20240605;
 b=UrPIq1P7XzNdsfiStB0N3QQzYuaS8DwvUENy2xYvzypEhoBBBLcM1Ye3FvMbVAKx2P
 WqfRW0Gu6JEnYpcsYYLndRVWfkOKcsXe2QmmSbvx/fnFisrlq8mmUcVfRTwQNdBhKbOk
 eFVL4mQ0KHcZI/1d/LFmNpAYfhm6dlsM00B65XCi5UECCUpCXGi/w799o4bM7ENj/Ra9
 4OW0r1DzgV3LGMBieQWaKQIl770JY0pH/xHjva8CoEP6V4s626dsnrIka7XAFO08UtEY
 UEwWZyF8fQofBWYmfM1fZr9iWqgYg8yzPsHHeG0KtHjT1JgJTKG7tSr3MyF06Tbmao8p
 TJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=RxnRHNHQ34+d19E5Vum8+45Nfr3J/kYTX/60VJLsYP8=;
 fh=hvnFB2jl/FDZc3t+mEZczD88lWwmlVswi5D8ytlD1nc=;
 b=VKvI81A7S85jeGEyy/UytHBilaXGC9SPGWrAndZw0xBpWCRRJ8GFLoAtc91PHPIMnn
 Ru7Cr1bqJT7zRhadk1aDL05MPEYIurTnb+PhuPj2SVOt92JAVMWs4cKNbj4joHeZaC53
 Igj0ByhZSJznFePPDasBJh/o+DO0hWkEDEay3HK6Ue9r2gEL6yj35SLOIvikOVmoYNZL
 Duskl+uYX3G0CYl1g9t4TxS6RUmDRpPiE+owBYy9BCWjdu9MZiubNUJvjM7slucZ4xuK
 mmrQG/NZWXPeUSd/XiZ/IwnEkQdnlE//FdpPkqn/RAXJEeFwkfBjoX7PvWcYkoNrSdc/
 2Fvg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772784561; x=1773389361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RxnRHNHQ34+d19E5Vum8+45Nfr3J/kYTX/60VJLsYP8=;
 b=WmZH3CKtbOrkG6A495srv0zzEbg+rMJKzt6FaXpTRDqzapwDMNOhdLUwVbMkfVtHlq
 Rf0wKOS2PEz7SDvVVDDS2zLBRHFI4O3DZL9Czg0SrzO9mZHXK2m9muobtQkl56oRbUXc
 06d9xCveFvrGJMsR3FBnKKIuqhz7cJ0DTc64RxVif2L1W7mqicd/Z6JfYr2NKoPcuOIz
 7mUGOVfR7KpG3kxgGzutDI7Dfwtro7DlkDg5Z1HjBVUSZhlFblYRxTu4OSu0dfpgtGN7
 jg03EwE+F+Y+BEe6t11XZqy+HbvzIxj1yic/dHLXyurhyBi0pgQLigp5AW11xMwFcdu0
 hMxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGiZ0JkfAuEbaf9wkU1GWm5h7WnwtXNakmWClM8PObTlYIm5XvKL1RZjvZvBaBAULOxjg=@dpdk.org
X-Gm-Message-State: AOJu0YynEof9fqXehAcN6BiP+wI7YesTcogdo/GtbwTAmQdPnxwQPFmz
 YEoZkWtRUXMW/+c0ze/cwbsRRnQYEwe3s1daS5G5KDf0Fsnt0vriEPxkk1TrtCvDrkYoKkKKgS+
 eZf/OQzANM1U4nQ1k+5IYX6IM4ZzwxrYb/f/T
X-Gm-Gg: ATEYQzwDyrk6CsV1mNwk6n29VlBu+kJJehqQVfG5PUq7UWHipUu6oDGnYFGxZsJ8G3Z
 W/ytjvQBSCAy2NK4n3j6Hj+QCn/W/+2SJIMqGsKO6onIupIizv8BKHt/pwHjvXk6LMaQ5iqg2tc
 4UfDaYfYKTAaPgMX3k6yty7wALIGLuc2gv0ysP3TMmh/05Gml4khrI4pml4xnvnPtBvM1Pg9HaZ
 FJaps2IreSZ3DrGHpHmjnjkK52QjrlAheq0PFXpZ6hmEFC9D4pzrfhj2QJVntB/m746y0Rj5h+/
 FK49
X-Received: by 2002:ad4:5bc2:0:b0:89a:110f:8947 with SMTP id
 6a1803df08f44-89a30a2bbc1mr15411276d6.5.1772784561132; Fri, 06 Mar 2026
 00:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-1-maxime@leroys.fr>
 <20260226112551.7ec09c50@phoenix.local>
 <CAJFAV8yFRfHOoBha12Vistp48reyhdgNxaxZpys66eC_MOz5Tw@mail.gmail.com>
 <20260305095707.03ced639@phoenix.local>
In-Reply-To: <20260305095707.03ced639@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 6 Mar 2026 09:09:10 +0100
X-Gm-Features: AaiRm53reWcUDKdwZWYm4u9uH8htsp_mgsv6CS7155O5yCWB-edS9h4O_ZKCLwg
Message-ID: <CAHHRULUTgUCvPFxwnRU17PKaZ-x-5OCZ8BsJZWzDWLE2=PAk2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] net/dpaa2: fixes and improvements
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Marchand <david.marchand@redhat.com>, hemant.agrawal@nxp.com,
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

Hi Stephen,

Le jeu. 5 mars 2026 =C3=A0 18:57, Stephen Hemminger
<stephen@networkplumber.org> a =C3=A9crit :
>
> On Thu, 5 Mar 2026 17:55:39 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > > Please fix the free bulk bug on Transmit and revise
> >
> > As I replied in other thread, I see no bug on usage of free bulk (not
> > the raw helper).
>
> There is no requirement that all packets in one tx burst come from the
> same mempool. And free_bulk assumes that all packets in the array
> can go back to the mempool of the first element.

rte_pktmbuf_free_bulk() handles mbufs from different mempools
correctly. It was specifically designed for this, see 0f824df6f8c5
("mbuf: add bulk free function").

It uses an internal helper __rte_pktmbuf_free_seg_via_array() that
batches consecutive mbufs from the same pool, and flushes via
rte_mempool_put_bulk() when the pool changes:

 if (*nb_pending =3D=3D pending_sz ||
     (*nb_pending > 0 && m->pool !=3D pending[0]->pool)) {
     rte_mempool_put_bulk(pending[0]->pool,
             (void **)pending, *nb_pending);
     *nb_pending =3D 0;
 }
 pending[(*nb_pending)++] =3D m;

It also walks m->next for multi-segment packets.

Perhaps you are thinking of rte_mbuf_raw_free_bulk(), which does
assume a single mempool and is only safe to use when
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE is set.

See for example i40e_tx_free_bufs() which guards
rte_mbuf_raw_free_bulk() behind a MBUF_FAST_FREE check.

Regards,

Maxime
