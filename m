Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29040E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CF86402DC;
	Tue, 10 Feb 2026 01:52:43 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 8FC0A400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:52:41 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so1629534f8f.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770684761;
 x=1771289561; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gc0hlqzaCH3H7L76T4ITtUg8xT+YRpQpUUo2U80Q7EQ=;
 b=sTX6WQgmmg9TihcN3bZSvux/QSQgImEIoUPC9HTFq+gV7BpGbYDh9RVNOsYW+h3Pav
 RDW6b9ibrMbuSqdshZCGVE0I/Q2FBzttBrbCoq10lAFIXVlBN910NICZmpI99JGdlxzy
 GVh7/e4X3qk15hHcPSi3KEwbyssPAdcnkgaSYP64AagesuIf4YIe/IvvBPDIuH9RDIAD
 FmCqnOZF8quVjZMrjeT3u6Pn04guPyDL26pkInQuCkeHLkcVq4acGEajknDAANNsYJsZ
 BygsgPjzk4a7D1R0pnORQI+0/kO75rOa1VJbrHaVJP3Iix7CVhQ1kChawHI4G6GRlZ5O
 MqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770684761; x=1771289561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gc0hlqzaCH3H7L76T4ITtUg8xT+YRpQpUUo2U80Q7EQ=;
 b=If4X8+jI2T9WgTKJhWbm/lHWD5GgCqSrqQ+Mf4XX19GvL6AsvvaOYBxDybYwc8tbgN
 pAOoruveFCFVeSVhe/0WCES21MHgK2JsIxDLP8HHyZ5Kuy6nNUIDNuFYye/39airSjr7
 jbgOqJ38+9bjvjreEsjB0JSlYtRqyMw6Oz96Cuxudmb8NDv4vj+PUWg3vFAw3/DvlJGP
 n1Pur8BZjw/OrX1bXii4zFLPJxhzDthLeaZhZAR0x01ANlCIndy6FBatetsKsVe8dBCD
 8SMwgrCxgh3S1teRlOc4fGlvgYZQKXs472iv/cMmn56AyS6Z1YvOydJoodtC1oIm9UVD
 YrLA==
X-Gm-Message-State: AOJu0YwmVeSBq3Zdo1M1ld4UTSw+ZxQo3Ogarra/v48gmF6rwePTmns6
 HUzPvfy5W4BFy3YgAAGJzODhZwf0ZKeoI7go6UU4ZoHi2dEEeskGp0uI0hKQEMujMCc=
X-Gm-Gg: AZuq6aKv69JK1xSOp6P6WlttWj51y4gWnttM+Hjd97hrVcw1Vp8neVbC/VfL2prgMux
 X6n7ZfY28QEgZT7imzR87xV0dEhQWb/JzcOst45f6vvHXjno44Sf9UTWojX5R9KjAgoGkoNoEi6
 90hqwWDByt9hkNbCUguVvlbol+imRUDn2CjrvFg7bw7UgLZ+XDHydmZzfgwutlVdlH37pGGSU22
 Y9v0EkIbkMxgNQmh8q1iMvncXajrG6izbEIvVCEgSAQ9NXOeedwQ40UTiv3toKcUilyoeyErOar
 mbvkuTXe0BqWoHmp/NtPzrvMX+40sXDzl8w853C3BLNXMw6JP9NOwoo0CGnchY+v/OEmNpQxSIL
 pax+IBiRA/DRXk02sDrO3yGYP/ZZMDCYSImRnXnxuLpj6o3JyR4s48BWmAu+24l8LqX6lkIz+7h
 J5zbnAvlNfyQ90Mrs0x+C+//ieCw7lBoAUj0IqrKhyVM/GdrRJN87hZWzkV3IH7LE=
X-Received: by 2002:a05:6000:2386:b0:436:2356:47cb with SMTP id
 ffacd0b85a97d-4377a57cc0dmr609812f8f.36.1770684761115; 
 Mon, 09 Feb 2026 16:52:41 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974b230sm33807945f8f.36.2026.02.09.16.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:52:40 -0800 (PST)
Date: Mon, 9 Feb 2026 16:52:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v5 5/6] net/nfb: release allocated resources correctly
Message-ID: <20260209165235.780b17c3@phoenix.local>
In-Reply-To: <20260202193330.3324681-6-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
 <20260202193330.3324681-6-spinler@cesnet.cz>
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

On Mon,  2 Feb 2026 20:33:29 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> Internal handles are initialized in eth_dev_init, so the cleanup
> should be done in eth_dev_uninit.
> 
> Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Martin Spinler <spinler@cesnet.cz>
> ---

More AI review feedback. Will leave up to you to fix

Patch 29: net/nfb: release allocated resources correctly
Potential uninitialized access in error path

The patch adds err_ts_register: error label that calls
nfb_eth_dev_uninit(dev). This function accesses internals->rxmac,
internals->txmac, and internals->nfb. If timestamp registration fails,
these fields should all be initialized (since the error is late in the
configure flow), but this should be verified. The rxmac/txmac are
initialized in nfb_eth_dev_init() before this error can occur, so this
appears safe. However, calling uninit from configure is unusual -
typically configure errors would not tear down the entire device.
Recommendation: Verify that all error paths properly clean up only what
was allocated in that specific function, rather than calling the full
uninit.
