Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA385E81A36
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 15:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 356FA402D1;
	Mon, 16 Feb 2026 16:24:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1AD2040269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 16:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771255463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfA/u5Ll9RQppKVHCAXpTwhvpUd+xbkLv0Ek9UNmoW4=;
 b=EQEiyLwE+OdgdrV17TvDJRMWVgkpK9ejLTfGsOe0Jl4XbVnhyKLZVaFnErFScb2J1yt4WV
 mXER0T0OSAXfmw5N9ECU7842thHB1OgbgU7tOVDTlTxmb+CHRl0dtLJtfRiRp6vd1OfNkm
 y+Aqg3HyzEcYDGj7josJAZZ70HYctz8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-09KrepApMG6QEzLyzz3d8w-1; Mon, 16 Feb 2026 10:24:22 -0500
X-MC-Unique: 09KrepApMG6QEzLyzz3d8w-1
X-Mimecast-MFC-AGG-ID: 09KrepApMG6QEzLyzz3d8w_1771255461
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59e63820b5fso1464753e87.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 07:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255460; x=1771860260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfA/u5Ll9RQppKVHCAXpTwhvpUd+xbkLv0Ek9UNmoW4=;
 b=h7D8TZfWL0nIHvtC/4RfpzXi7iHl9oZdNRpKA2mCdm030Di2HN9FSqvbpeUbZJZ4LN
 +nLLBE9kSRXcOwcGeqXH/HB7pZaBQ0tboN7nVgkaeVy7McuAVJ/thOLzHlHfQ+s7plzu
 Z3l3fCqai9PzziImguVHdrHXtgj8gv3nLU309qtUAhM4pCiNtT4QMdQYnLAVO58Gl3fR
 zUVEr5yRrJYy/QO0rJozX89sFS0F4c32CbnuzX0Ih2sspzoyWCDl3VHBWf+GlWTPzcLY
 XQsjzXQw6cmy8QgU/8P54N/597OXRVbcRcVtIokq3dHYDMPdp49S0yPBicy3LLma6u0V
 BbXQ==
X-Gm-Message-State: AOJu0YyiU9LXZyx6o8VhNEcQ9h896ApbuWxPWuDAf8r8l3gKEfktgi6e
 UqrjAZHT4gtLot5wzfoQDaYsfGlZigkOvZp32TMFKsHeWQm2AYpdYz+gO/IUMcEbrnCP9c5Y3UA
 oQRDhSC79O2wjOtg7Gd9Ai/oYTVVh2Mwpr4hFC+oTafxT7JX7qKdGU8DqUS6/3MXjnI9p7uHOTD
 8n2P2xgmyesdsJ2qa5Okk=
X-Gm-Gg: AZuq6aJaa22AA5GCWnz+uH2AWyLlaGN5Kau5u/UOuODoXnZoQpfMDms7KpkYHC5B9Rh
 soBnjIKLYdLm5n6Mx1T76ej1YvfBs8AFqKZ829qilJX9OK+ZQJNzyDY2v2U8rIzn8nvqsXkLEiw
 KzV5vTm3oppEjRm8RhHuPprE9ZGTx32cZWwEnnTUbDV4AkZ/Bf2FvEeLy4ZnNMVN2sFwA+T6QTS
 nOnAco/6B4Gm7G70ZAeoG0J4zv/JNzb5bFMEe97uDGVz5uS1vaFgP8g8fNuiENMh43c2g==
X-Received: by 2002:ac2:4f12:0:b0:59e:64d6:8415 with SMTP id
 2adb3069b0e04-59f69c3ea1emr2200459e87.2.1771255460404; 
 Mon, 16 Feb 2026 07:24:20 -0800 (PST)
X-Received: by 2002:ac2:4f12:0:b0:59e:64d6:8415 with SMTP id
 2adb3069b0e04-59f69c3ea1emr2200450e87.2.1771255459931; Mon, 16 Feb 2026
 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20250806164152.187460-1-stephen@networkplumber.org>
In-Reply-To: <20250806164152.187460-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 16:24:07 +0100
X-Gm-Features: AaiRm53gaMEclJVrg0gNzybBHy0mOlNfBGx5CpXZ9DgSO-SmWNV5mfpF5f36I-o
Message-ID: <CAJFAV8wFg1Dh5q45v_TL2g2VoLMqsZbBy0tgYaubHhxiTSe=Ag@mail.gmail.com>
Subject: Re: [PATCH] test: allow latencystat of zero
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKHMeS4vM85l4pJ_g0pQutGDIhXEQTeyvQFs1OLvnKc_1771255461
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 6 Aug 2025 at 18:42, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> When test is running on emulated hardware, the performance counters
> (TSC) maybe emulated and return the same value. So allow a
> latency of zero, even though it should not happen IRL.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

That should avoid the false positive we see frequently in OBS.
Applied, thanks.


-- 
David Marchand

