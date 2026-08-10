Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E10C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B7B640E17;
	Mon, 10 Aug 2026 17:24:28 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4E34940272
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:24:27 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c998fd549a8so1507139a12.2
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786375466;
 x=1786980266; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=99R4WhvZxuUrgiq1tItOh0g5Mp6f8e5JL7kCXxNY/m4=;
 b=bwNnUshYIpLODcPA/KVzUp903NQ4B6HA4LsGTG7J7K6x4Wz2aPPki3Leb+K3KZuftW
 dnqN1TSxSccUxf+/QVsrnifyKYR4n0k219dv1el2cZL5/We0On1jouQeq89TlnISLb3t
 lal+mG4KBA4//WRBVeVxNAaTE1lDJYHBpSknHdSl2qkKfb0iK64C5tl9ZdMEhKJJ6j/K
 8rx05+wZCKn1vyrVaC52cRyvQgIerXP4pb9o/nAmd39F+b4O9RGQRKeGSOKDBqdjs1Ca
 YjXfoFXxTEyQO/+Jpfa3D3Tlhs3BVQG787Qxfq59mtR9Ckj5o2x25Iq+dQNm2/WXjAYQ
 n/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786375466; x=1786980266;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99R4WhvZxuUrgiq1tItOh0g5Mp6f8e5JL7kCXxNY/m4=;
 b=ZXYOdnu8DZ8XgNizzYrdnMwdCtKIEgu/lDWb8DV0fhYc1k67sBUhSyFYSlNa/DnZ20
 XNhq/CdMbXwRREqyMp3DkTWVmmNImtdnNL35vQUL9aHgf29NQwkAU9qAi83e152eycyu
 G7iJjI9xSZjB5aXWRXnwlKK7wp9PLdhJC0R30LRTeA4rFE7clNol76oDTIMTK2bsd/K1
 mtwKwt1NI/mtyvXJqL44a9tpcgnKxkvqUxN1QMmDhGN/OX16noOPupkbG91A3qnjDwmf
 f13+b91+nv0uNRpw+7oqO8iOK/SIN50cVW0LbZvfyZMMCzOPXNrgvgky2VYgnJP72dpS
 feAw==
X-Gm-Message-State: AOJu0YxuqUWd9mq+X1ObbxJb3+2xFJ2sPgDi3kYbSWdDIf2EqRQcSG4/
 I7/1tSJ/9uksyNsOcWIobNqJuhGWs1yRCHb8lriklwM6Vsu8d4+MsUXC74WhXKL6VRM=
X-Gm-Gg: AR+sD13s7sxP3nNHPv7p7cGYwSZXv7wWW0bQgzBjImamZXjoJ3F+MeNBl7D/kLD5gC7
 gSyrzYo1M0aGBEmfSqdJEG5CO+9cIKvkjXxTLTvg/JucCb2RVDWVVA94wv17RXe7RxmzbJK389t
 4Rdo16kQ16ZYhRrJ0kI6aZ0YdLjx6V+/Z48klIoJzlOdqxh3cMpzk5giRXL8sTOtPR72rhOteHV
 OHOYqkbbKQcoOdknaoJgS/K4+cVIwTT1PcwJZi67OWtgHxlty8ivoVr+8Zzw0fxeZgS4rFu7bOA
 cDlptp83uY91n2T4A21y22W1z78jifC/ViGe7sFo+5fR0vuLuQJ94vybfF4Gat2DH4uib7f6i1G
 sa6ToaFHFnQnA95syUFrDLBVAPPxzHFdFv7XWaZRw8zRlQOoO6dVi9clzNAEjToEp4BfxAMQt1s
 MaShc3BjNU9smibrs0BTgl6b7SJ54eTYwBSnNAEq1T9+gqq9n0PEby6b7xrmpx4Soq67GoeRU/Q
 id9HrxKavlehKycDHIzKTHrcazoB2o=
X-Received: by 2002:a05:6a20:568e:b0:3bf:49c8:f7b with SMTP id
 adf61e73a8af0-3cc1a1a810fmr3580422637.13.1786375466196; 
 Mon, 10 Aug 2026 08:24:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101a5ee91sm35417454c88.11.2026.08.10.08.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:24:25 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:24:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, Gregory Etelson
 <getelson@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path
Message-ID: <20260810082412.76a25695@phoenix.local>
In-Reply-To: <20260809094837.123931-1-mkashani@nvidia.com>
References: <20260730135620.213682-1-mkashani@nvidia.com>
 <20260809094837.123931-1-mkashani@nvidia.com>
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

On Sun, 9 Aug 2026 12:48:37 +0300
Maayan Kashani <mkashani@nvidia.com> wrote:

> Avoid post-decrementing the segment index when it is zero in the
> error cleanup path of mlx5_rxq_mempool_register().
> 
> Coverity issue: 503770
> Fixes: 8d1cb02da5b7 ("net/mlx5: support selective Rx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

Claude Opus AI review sees dead bodies here...

Review of [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path

Warning: undocumented second change, and it is dead code

  The commit message describes only the loop restructuring, but the patch
  also adds a "seg->mp == NULL" guard around the free:

  +		if (seg->mp == NULL) {
  +			mlx5_free(seg->null_mbuf);
  +			seg->null_mbuf = NULL;
  +		}

  This guard can never be false for a segment that has a null_mbuf.
  seg->null_mbuf is only ever assigned in the mp == NULL branch of the
  registration loop (mlx5_trigger.c:179), and rxq_ctrl is allocated with
  MLX5_MEM_ZERO (mlx5_rxq.c:1881), so a segment with mp != NULL always has
  null_mbuf == NULL. mlx5_free() already returns early on NULL
  (drivers/common/mlx5/mlx5_malloc.c:275), so the guard changes nothing.

  It also makes this cleanup inconsistent with rxq_free_elts_sprq(),
  which frees null_mbuf for every segment unconditionally:

	for (i = 0; i < rxq->rxseg_n; i++) {
		mlx5_free(rxq->rxseg[i].null_mbuf);
		rxq->rxseg[i].null_mbuf = NULL;
	}

  Suggest dropping the guard so the patch does only what its subject says.
  If it is deliberate, say why in the commit message and apply the same
  rule in mlx5_rxq.c so the two paths agree.

Info: the underflow has no observable effect

  In the original "while (s-- > 0)", s is uint16_t and the comparison uses
  the value before the decrement. With s == 0 the body never executes; s
  wraps to 0xFFFF but is dead from that point on, so there is no
  out-of-bounds index and no misbehaviour. Coverity 503770 is reporting the
  wrap of a dead local. The rewrite is behaviour-preserving and fine, but
  it would help stable maintainers to state in the commit message that this
  is a static-analysis fix with no runtime impact.

Info: no v2 changelog after the "---" separator, so what changed since
  20260730135620.213682-1-mkashani@nvidia.com is not visible to reviewers.
