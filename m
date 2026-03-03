Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B45EC1459
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 14:38:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32CF440E4A;
	Tue,  3 Mar 2026 15:38:20 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id EACBB402B0
 for <dev@dpdk.org>; Tue,  3 Mar 2026 15:38:18 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bdfc4b191fso2126465eec.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772548698;
 x=1773153498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ue4gw0SLSRqnNzVd6eV31N+URXu40qZRKtBz//xHq20=;
 b=wY66j3Bwrrr7/ypWPi9hP1m0k16po0OconagiQldzXs+BVww/sCVGDG/uoLKtrohvf
 1PcOvXRmyNzl02zAl8yIWt+xj4jT0wivOKII4w8IeuilH/V6U20kYSUbu7AER3X8td8H
 mVY7QdLAK4/AeqXHpejkhOT7t+cDCWM5Uldnu19P3wFAb4pBXV8F0dgpx2Elw528lNVv
 0W9anzsZrYzf8tG1d2Grkd1ZzFWM3LSOQN/QuxggJrx0wOg7MHou4iSBfnrUnwgTmuYY
 dD/mUd4XDXrFwjAl4GhmnZ1SVPGW8W99R5boeDN+D0UdXdvYlz9aNpcD9PrFnJ8I1PhF
 VR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772548698; x=1773153498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ue4gw0SLSRqnNzVd6eV31N+URXu40qZRKtBz//xHq20=;
 b=fYSyR3h9NfoIFaq29pFCVI5ZJVDkXsmxu8ZB7WwvYmC/FfC6Yv0Cq0AO7bAikNJTGT
 O66QBadYhvrFxo8jdoMfi2JIBQ//63dUMijdUQPj4q0N96W8f3d/8TcelV066m84rxy6
 j9Nq0DzE2CpeirPtY/wAdjayRnoWB33z05jqjRCXfm+jXL1hyk65OPMlh+QzbsWIURKa
 mpL2PjvOEjzRGF/hipFroLsYQZN7SFUEGeU/kO54X+IdjTrJBs2CTvj37ugK8jgzakJU
 jHzWJX2dHJESErqbnhevL0wl3Qr1zHXrISWWpnGTTWs0B8X1TXGu/fPODyDq5TVt8Cw9
 ZKwA==
X-Gm-Message-State: AOJu0Yx45W87q+/Ky/+Ez2POnn1apYHk6mZSw5EFRG+TlOK+hpUDee3Q
 NHECftCY8u6TqhqZTE2KkfUaT7p3KRVysIn2zm61JfQtiCgFaaBV/cQm3eIqcTzfiBA=
X-Gm-Gg: ATEYQzyvnWD/KVjrcmS9ApUCS9KmYEx2atzDOm9hOYRz+oOXPkx1mwDVHt2+RR3XQwh
 Cxsn7QqSy2uMSbgrPKfbiuY+jZ2YwuE67fwGyKETqRadykDMrI6oYayeJeHs/EH7ENpwEaIKz9x
 RkBAmYp1OfdD9XUCli8E2ai18gv16IyGoZWi6IitAc2aXZdj1CqFWUy+UdLtFBbhJ6DXYFbkPZA
 t/hM04p8bNSWkdSHtlGQbR/XVqCCkvL2QPGOI4E4eHxQ21pRja64TOkHdQZyWTILvt1XMTjz4Lh
 VPb9fr2gbq22uhSi0kTgcaoYHHQDVDcbfSgRgB4K0RsAKUdFi/4airx365AayK/Aj4o0fVR+O8e
 eV7YPeVT/SXVtTiER2Jz/KR4Bg9ochJdQnwtrw/zXhjEOt7FCCpuZFg4L710BI1U8Qr3aidJ7+L
 gYaQLjCtYMc9KR6n/19dMb9MHiHcraSuPIzwAqsisr9Awl97xdD48wlwrVFgNQjetpfQKvh/ES+
 4Y=
X-Received: by 2002:a05:7300:1348:b0:2be:22b0:8bf3 with SMTP id
 5a478bee46e88-2be22b090e8mr816448eec.30.1772548697936; 
 Tue, 03 Mar 2026 06:38:17 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be220eb5e5sm1467853eec.17.2026.03.03.06.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 06:38:17 -0800 (PST)
Date: Tue, 3 Mar 2026 06:38:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon
 Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix queue count issue on port restart
Message-ID: <20260303063815.2bb8500c@phoenix.local>
In-Reply-To: <20260228021211.71166-2-dimon.zhao@nebula-matrix.com>
References: <20260228021211.71166-1-dimon.zhao@nebula-matrix.com>
 <20260228021211.71166-2-dimon.zhao@nebula-matrix.com>
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

On Fri, 27 Feb 2026 18:12:11 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Remove tx_ring_num and rx_ring_num from struct nbl_txrx_mgt to fix
> an issue where these counts keep increasing during port stop/start cycles.
> 
> The counts were incremented in tx_queue_setup/rx_queue_setup, but never
> decremented. This causes incorrect queue counts after multiple port
> restarts. Since the actual queue counts are already available via
> eth_dev->data->nb_tx_queues and nb_rx_queues, use those instead.
> 
> Update nbl_res_txrx_get_xstats() to use eth_dev->data->nb_rx_queues.
> 
> Fixes: 661c0ccf2512 ("net/nbl: support statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

Applied to next-net
