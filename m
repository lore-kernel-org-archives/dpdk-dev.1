Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DAECD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD60402DD;
	Mon,  8 Jun 2026 18:28:44 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 754B54029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:28:42 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304ec41197bso4204067eec.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780936121;
 x=1781540921; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Yj8XS/pK8LJaYw7g7ypmumxs7EgzKd5uJfKIukP2Js=;
 b=0MWdB/R/W+A02iZEXfh6fU3nNjAN9/ClcNhsxcydvHOA6P+vpURiJTcOMAAwWfcnOG
 vvQUjIdn+gqogkMq5EMki8001+3CzAAsZqXNr2slcnn3O3B5h3tlHdDxJSEXMn8WedcB
 /GknZ+DtGqgizKz2bWXKsDrQoP8cwLy9PZZIhoLUUBhHk+KvaPCeMoiVC9blOqKA2LAb
 gXscJ0ZQgjf2GDvLy3PmVUX3OMNJUNUAs6mXzfRZBhuhxToHClb6iUrmsREQmSm+K72C
 Q7SiEZ8L2uqajFubkmeiJ6TnVd31Hdvs8hzPLEiT9Yfn0v6atnatSkrHnCWe0ZRhVV86
 enXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936121; x=1781540921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Yj8XS/pK8LJaYw7g7ypmumxs7EgzKd5uJfKIukP2Js=;
 b=s3RuBMVnDaQ+8rGLs8XToY573Ww+gKdmdj5XkgjhmWXRFntFt/5X2HEL6P6WTSdbMk
 M+0UrVQ8dHqjf+y8cUznkhkAIxTvBbjra6YXLOTqVvXRtuJIG/sepidkb9sUE3jw27m0
 fCJ27BmSiuvk+Is+SovS9jSXu90JP58XD0QABO3aiGDjXuMTeLVuVNNEb5eUCtN3OuBL
 qErdE9BbzzVBLA9M09F+lKPGH1j4gQUz1oIKdnoX4Heu4JQndGCCVhI01gVf3pDQfd+b
 AqjqqPVjIi4IUHwDkCOymmUyHoLANstq7aoPVpxbWODmCYVNpzddZae5HT34Id9wgOqQ
 P3UQ==
X-Gm-Message-State: AOJu0YyO6eP3dc+jkc5U++31mTD1S5z+Y02soNbu9bQXah9eL3yMwGkY
 3B77jso0JSNg81gVYYXTdSAOhAquFQKLfZlkRA6HtP4HaLkdTVJhg5A1oHcfmUrj5sk=
X-Gm-Gg: Acq92OFLxPVFS058uwMk83FPzDN00BDsyqwfMKFJZKqg0IOqzWC4/S/+srt4MVfWfau
 akl/WqKrRlBb0S7PLeLZWPyePJitGuyzRu67Jjh1tdIBfqfSPkQRoVgQRAzgyb7QbZoCVG0wxOe
 Zeu4BUDivCjHg0BLYK6C8agGvFzxN7C37VPi02WEjJ9CpxcA8frByei4caAbHad9E42Uwpeykre
 uwfvV3DjLHTxc6JRv6lmz0lg+4bBXRh/X8DmobI1UKiZSPB6qy4O5djG97qN0UmBCsjUGJ9Hizt
 UuYYw1x1jsgOQBQ1biTD46jYbtp/aVglvSmQFvukTq7pfLnJYDmMBbiLNMXNVvBX7cZ4JRg6XlK
 vVJPh2lAa3V0cEBVrZC53KNnHjySbCTMTLu7/+GKT5wExD/vrNMoNlqtvFSaSnFPANb+mYp2S4c
 Kg4UU9ZayqoqfmkG6DKe6DEH4rB6t9FkBOixFiZWdhfOUOvft0G7vf6GhxOlCN6+e6VbpFmiYzv
 Yo=
X-Received: by 2002:a05:7301:2923:b0:2d8:7302:d3d with SMTP id
 5a478bee46e88-3077b38bab4mr8373553eec.8.1780936121135; 
 Mon, 08 Jun 2026 09:28:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm20940816eec.3.2026.06.08.09.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 09:28:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:28:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eimear Morrissey <eimear.morrissey@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
Message-ID: <20260608092837.5f5498d2@phoenix.local>
In-Reply-To: <03abaccc37f14f4c8955580784f30cbe@huawei.com>
References: <20251009152740.10437-1-eimear.morrissey@huawei.com>
 <20251015102947.4614244f@hermes.local>
 <03abaccc37f14f4c8955580784f30cbe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 31 Oct 2025 12:32:18 +0000
Eimear Morrissey <eimear.morrissey@huawei.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Wednesday 15 October 2025 18:30
> > To: Eimear Morrissey <eimear.morrissey@huawei.com>
> > Cc: dev@dpdk.org
> > Subject: Re: [PATCH] lib/net: Add ICMP support to rte_net_get_ptype()
> > 
> > On Thu, 9 Oct 2025 16:27:40 +0100
> > Eimear Morrissey <eimear.morrissey@huawei.com> wrote:
> >   
> > > Set RTE_PTYPE_L4_ICMP for ICMP packets.
> > >
> > > Signed-off-by: Eimear Morrissey <eimear.morrissey@huawei.com>  
> > 
> > Would be good to do ICMP6 as well.  
> 
> 
> Should an ICMPv6 packet be RTE_PTYPE_L4_ICMP/RTE_PTYPE_INNER_L4_ICMP as well? 
> 
> The comments in rte_mbuf_ptype.h are inconsistent, the top level comment with examples suggests that 'version'=6, 'next header'=0x3A
>  should be RTE_PYTPE_INNER_L4_ICMP but the comment on RTE_PTYPE_INNER_L4_ICMP itself says  'version'=6, 'next header'=1 ?
> 
> -Eimear

	static const uint32_t ptype_l4_proto[256] = {
		[IPPROTO_ICMP] = RTE_PTYPE_L4_ICMP,
		[IPPROTO_ICMPV6] = RTE_PTYPE_L4_ICMP,
		[IPPROTO_UDP] = RTE_PTYPE_L4_UDP,
		...
