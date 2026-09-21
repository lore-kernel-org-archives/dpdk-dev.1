Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F94DC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AAE941156;
	Mon, 21 Sep 2026 18:17:57 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 4772B40298
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:17:55 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-868a9c48f9eso3799256b3a.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790007474;
 x=1790612274; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8umt9DAGad0pR2qkyPSRXAsqKg3VAdpaE/ulMlXt/xs=;
 b=qYJp23d8LW9WkJHCM3NWtoff6u5Il+zN1g/IxI0aCcWIWOS+8wWlgewZO1d26+KXCY
 EeUfsr0ECgc7qxAvD6wOZKcNQjKHba4eydopJ9Qmm5RuhUCdgM13+50fejtCgdjSR8Ti
 g3HsHRFDJN0k+iklQuPADS5JCiJfpEqJ9BZ433raj5RF9IS0TOSQr3iiQBPLnSg25H+I
 wvCuO1Y2oWPV2Z+nYWsa30eza8a6kDze2JjLLA4oSH3O0NCztmjRXQTOwxrfYDf9tkNR
 w7DIcoxrY2r1Jb7rwdQZeZvHDtYKrUHY7UR5IudrbDvejRvu3Ot0/gZIluzeqSvg4qDy
 ES+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790007474; x=1790612274;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8umt9DAGad0pR2qkyPSRXAsqKg3VAdpaE/ulMlXt/xs=;
 b=S1PED5x0Ei6nL6UEZ3tkIFkYQ0u4J2hQrpu+x5SeB+Jr3qnanvo/CM5fA7mBfx+HnM
 Yvtms+Y50CyP+BVPih5s9moYXeVEpGEE7EtIac8o5GrFxr+snh9JwhRJIlIGp23LINuh
 JJrAgWPvHIj5PM793140o+vQMOfm+36HixQKYB1cH2l/XNofBMrNdPSImcJ0DOq5Vs7X
 NK+nQSl6utgFgVLTcA5Oz6n7l/1ZkRM5W6eNM6BQQngxT5cYkdXzKAwRL54K6jXyWzkF
 1hqdofGLzcJl39+cLGT208x1Pb/pHBc5K8t6+fHUjob2UJVuru3WJJY2jmUpvegtddGl
 QCpA==
X-Gm-Message-State: AFuF++kqMT2ZeresSdF/yrBHNhgD4PCGCjzu5Xgg2AlMGkCAOAhw+IaO
 ribZBXLkvNd/TNb38ihQdXYYMx+iHhnU4QQbsz67viXBEqRXVjdsNqKQ2aPtt6Y9uzE=
X-Gm-Gg: AYBFou2fqSbsljK65PK7KnKt6Gf6CyeUEYKvpi6J24VDCU5P1nfXaOaVzsn6Da6EqnD
 id9JLWP6VAZUeXWrup8HArbfoY5Y7dvfEptETuQdB9U/sdMASK1cU3O0+RbA/65AnYv61UYVWKO
 xZTIKIxtuYV9MwM/2kOcxvhu3PjbTBgT/7GgKfTB7NjFTv5UE+KP4lAJPVKPNwpJG3wwASBgwOi
 3vpLkxCkYd3Ql0O82v4wvIa8RNCG9o0F2Qai/Ql/O0QWPPwZwoliWKEP/nohrV/wmfg9b4+3I2t
 J7Grhs8BrWPv2q38ch6gCXVwM22CQL2DtMctQ5G0NymwpDtc61uFnl4cmV69O2BTdU/ffvhVRRg
 xjKvitXvbNaMXuPD34PY5eUaDGWN1CEFNGEerTVT3RFQHZE+w8F90hNjj0ZIreFnTH9FKlFqnGG
 v+3PTP5LCJZBUHEd3Z0LndWxjPL3c2T1bAX9QHhJdwfaHC2AIyOOH7482fR1rwDfsCbmfj0qJ9a
 6ku9XMmcQ7T9fgs6f2Uu5Hs8omv+YPOjoR2LJ6w
X-Received: by 2002:a05:6a21:596:b0:3b3:216b:2743 with SMTP id
 adf61e73a8af0-3dd8c3f19acmr21237951637.4.1790007474247; 
 Mon, 21 Sep 2026 09:17:54 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc72aead0casm3748121a12.20.2026.09.21.09.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:17:53 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:17:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260921091751.5de88951@phoenix.local>
In-Reply-To: <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
 <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
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

On Mon, 21 Sep 2026 10:51:39 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> >   examples/rpcapd/main.c                 | 1430 ++++++++++++++++++++++++  
> 
> main.c is a bit large and handles many different functions. It would be 
> more readable if different aspects were handled by different files, or 
> at least clearly marked sections of the file, with overall structure 
> explained somewhere at the top.

It is mostly comments.
Fits within the general sizes of examples.

source   blank   comments   comment-lines 
    2569      499       13      17  examples/fips_validation/main.c
    2302      411      272     151  examples/l3fwd-power/main.c
    2208      452      226     173  examples/l2fwd-crypto/main.c
    1542      343      200     102  examples/vhost/main.c
    1489      226      104      77  examples/l3fwd/main.c
    1254      216      101      99  examples/l2fwd-macsec/main.c
    1116      224       99      85  examples/l3fwd-graph/main.c
    1045      190      195      72  examples/rpcapd/main.c
     944      181       69      60  examples/bbdev_app/main.c
                            

> >   examples/rpcapd/meson.build            |   19 +
> >   examples/rpcapd/rpcap-protocol.h       |  127 +++  
> Could we just use one from libpcap?

The long answer:

- the file is internal to libpcap and not shipped.
- Would have to add SPDX
- It isn't just wire format but includes function prototypes
  for code in libpcap's implementation
- It is ugly style overall: lots of typedefs, windows-ism's, #pragma

What AI did was extract the parts that were used.

