Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45380C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EEAF42D89;
	Mon, 21 Sep 2026 17:59:04 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 0649E42D76
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:59:03 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso2290967a91.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006342;
 x=1790611142; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xD1FtDvYiMjKNpNfFLtHepRa8yPHH5ug9YhefkH6ek8=;
 b=KizV2s9I1cXXS1WJZv0KVJApUcFbr41kZkBYANiFxv85aTAiCfa2Dm6Hl9lB70oJqT
 m8uG4zFogrmokLOViJKM4fnx3i07cGDhxjNQxMg7hyNjLtK1GnsSOEgQ3nJwXilBRTYn
 sfBDhdINm0PugLzr08Euk6qalZBwhfMRsyDaRlaDRBBREPT/Mgc9vbGaMWP+btkbCCjQ
 7AbrPfd/f1h4t7HWIeB880+zHALF9NvAbnIPqEzqEMxI2oU6GjJ/3CchcwQUP+wt1d4H
 9iPixBDeICWAD1j1Vf96+4KC03VxQYcMHiP7hq+x9+4wA9fJrmkkwLNS/Avw1a7dMaX1
 5/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006342; x=1790611142;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xD1FtDvYiMjKNpNfFLtHepRa8yPHH5ug9YhefkH6ek8=;
 b=rMNDTr/ZaxRVvHAnwKZUv1YDUysCOWxolW5CyapZQARICGe9eKUDXievVqFtjhTW98
 Cz/GeyznFgUfqJ9mEc15GLrZupQAM9E+cyIOnvvQzyQMZHYTfep7UZ+0ZD2mtjDiFrok
 Nt9+GA9tq5zxv8w4OCaVoMIeD7QwtOepkVR1f2R/l8/jeJIXSL/4I2Fu2Xq5l64CjJyY
 AFNlKbFJqXu3bN7i044fb2vySk5Gxilt084yoXhHiedV+3HKwUg69rwbBb8NMQi9BnoH
 LqP3LSJxjo5JIJBjBDJSfVhihLlDJoYVNOfcjCmZ6164/Jsfy8jW//7T1pnwTT6AlpmV
 Dtuw==
X-Gm-Message-State: AFuF++lMAMYYXTOs1jxpo3WQnyTu+dsj932sQbOPenHgwWrcM46FF/ZX
 1pALRW7pd2W59E4AZoi14CM2AvY4+CrH1TuQBFFZJQyRS4LcnId3f0FQe3cXy98sGLU=
X-Gm-Gg: AYBFou1i7AtohElhWPd+3C86tNwiUWWWk5znce5laB6XDKyCgR+49ltBrwbfmmymkGj
 nQHuqrEti0Z+Oxpo6XdNHbGDltZsRo1MqVBiSxg3weDlrBY4X33ZnH3VtojNzsrs95OWKmJ4PQ+
 U8hR/CxH79Nm0EKpdPUzhjbMmE2OKrlRgYCJTEvReKkmspkBJVSD0ScJZ7LOD3JGZWtUkO1iJFd
 zlYNGpxWfO1MJALQjcI84pkaE6XAEmvQ52fztZLnkzUt8se4GclUlseM3Yaj/4RGMgq2hKNSRWt
 enLSXBB97Qijj5DwgRv2MUlQSt2w8pRZyp78OjE9AJydC8ZaT4KbA3JYegvDEusBIePnTqxrZRH
 78KN0g/+20oEzlyKNmM+yreC0sFg6Cb2L4hxPiV70tc4IcmhfcojAH38ayna55vUTX+Q1kWXqQa
 M6FctpfzwIRzZd4ydDpno7p8kbDX4quTUJOXyfj1DXFkHfOulVOby53UtJuJKVKZQpbr6M+2/bP
 /bjw5ZqzTX1ViDZZP857mNuTLHL87YocaiHvMyY
X-Received: by 2002:a17:90a:fc4b:b0:3a0:2900:f577 with SMTP id
 98e67ed59e1d1-3a02900f8f6mr8393051a91.51.1790006342032; 
 Mon, 21 Sep 2026 08:59:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063bf8ddfsm733919a91.14.2026.09.21.08.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:59:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:58:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260921085859.5de77f91@phoenix.local>
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

> >   examples/rpcapd/meson.build            |   19 +
> >   examples/rpcapd/rpcap-protocol.h       |  127 +++  
> Could we just use one from libpcap?

Could but since most distro's don't enable rpcapd the header
file is not exported. We could "vendor it".
