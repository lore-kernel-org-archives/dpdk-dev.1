Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B75E7DF13
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E3414027D;
	Mon,  2 Feb 2026 18:54:07 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 2E01B4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:54:05 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801ea9bafdso20323505e9.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054845;
 x=1770659645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=bnY3z1o9VGsa9DZ3oVC3N/ODBrgubiPGpMI7Gpj3nbc=;
 b=Qtw8kRRVHKmJt/vGBoF/gibhvSJGCJV/15DVQA4dhfEGZWKyGPaGnGfpnZ70Qqeylu
 tN5G0hAmoqrNZRX7J0R+tbX8ESqxzZjSL0ybqOlliOpD0v3b91tZaS672DDC9b4n/bf1
 OkbFvml7TpmdsEDzbRGVtka6e1rHBFyCEk8GkjnCz2QOSCKZjS+ruG04xbQlj+7voby0
 Pw6TX0aoCyhZIKApZ9DMtoabb8J4bfB6SgVKOll1tjxKptx2mMUy/kV6jmGCvDnihHnU
 nQCnGk6dD9FSLJderFykuw26U7rsVvi+7cQj+8ZLvjmr/YTD4y2qJ1Agybaeble6J4Od
 g3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054845; x=1770659645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bnY3z1o9VGsa9DZ3oVC3N/ODBrgubiPGpMI7Gpj3nbc=;
 b=YnoGXOdle443Hh1ECi7LQsAoFHLom67FyyCwLK6CK7gYRijISyUfsrj+bHcXHcXZTH
 k/mB/TTf+vxDx9Q9S4weQMfbJ/d1sLaX6/ppn7Ml1HyfhSkL51VEQO4fy8dTM8oPfxRo
 6VXpGi19nlTF1EdZSd3ve78thU8zFsRQV8FII28v72SEXe2lkiTt/d3gce1bdF88B1Ub
 K84QqZowqvG7KAWv1vi1ndm2rouoVqHkt5QVPeAh4gW5iyQ1Ms4WrkQ/Gn5UadUO+SmS
 GmA2waRQno5XBy/kg69mZud/1jvpST7dMUBtAYrDGUPdNILIrjJadwAllqS3NvmPH1MY
 n1PA==
X-Gm-Message-State: AOJu0YytDkxhEHLfhoFS6fkbzNgSO9K7Yvp+PuU8XKVxIeHMNjZ3K2jY
 /Zhq23R5lAtbqL3unrpgKKh6lyIcyis+A5x9R01JNDCBucxPTX+jCEaHnWhXF59Jj1yVAjO8JO6
 g3IJU
X-Gm-Gg: AZuq6aJ7nyPpmgJ5ndonNQr2rMCeK/pqIWh7IWxN8qm0CJTdh+ZyNRFd3mA0bNoBShd
 HTA9dItzA6pOZNcJG0mOMToaCA2QCvGO43LIBTh2qUILFcR1pXLZFiBl3Qih811lIdvPIDJ+bES
 ngNbhactk66wi4Ga3M2Us8oZgkXC3ZoobCq4YYAQsFn2ZcnT9hIVyT9UEWbuIRpx7A3C7kyAVAx
 HgnOx7o7mcplVxQHs/IM9QfBAa8LeVRz6dtw75qD/MvLnjA2NveCu3L3wXaBBZrwXFKKbmThzGS
 bLhXRXYTY+lPRuk7M8/lX4C1JNAjvz1X+mLVh9fyK1btRIMGDG634lAON/VfTCrrGUEL8L9m3eX
 J7EthRMXYpmLV/QfNcHgpqie4SZgz1ybEs9A5wMCeC/QdyBW8FrZsldETygBFbUvKE+TYEgUUVK
 6lGqDOuehGHq2Rmbiho7m9UePNb8MAeI3lpJEq2hZtaGSfCfbKF6WbBsvepemv0V8=
X-Received: by 2002:a05:600c:b99:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-482db49a483mr163331315e9.28.1770054844726; 
 Mon, 02 Feb 2026 09:54:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm47044323f8f.10.2026.02.02.09.54.03
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:54:04 -0800 (PST)
Date: Mon, 2 Feb 2026 09:54:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] doc/nfb: cleanup and update guide
Message-ID: <20260202095400.1240ed85@phoenix.local>
In-Reply-To: <20260202174235.20628-1-stephen@networkplumber.org>
References: <20260202153449.3295979-9-spinler@cesnet.cz>
 <20260202174235.20628-1-stephen@networkplumber.org>
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

On Mon,  2 Feb 2026 09:42:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ## Patch 5/8: net/nfb: init only MACs associated with device
> 
> ### Errors
> None.
> 
> ### Warnings
> 
> 1. **Using `calloc()` instead of `rte_calloc()`** (nfb_ethdev.c:74-78)
>    ```c
>    intl->rxmac = calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
>    ...
>    intl->txmac = calloc(ifc->eth_cnt, sizeof(*intl->txmac));
>    ```
>    For consistency within the driver and proper NUMA-aware allocation, consider using `rte_calloc()` or `rte_zmalloc()`. However, since these are control structures (not DMA-accessible), standard `calloc()` is acceptable.
> 
> 2. **Using `free()` instead of `rte_free()`** (nfb_ethdev.c:114-115)
>    ```c
>    free(intl->txmac);
>    free(intl->rxmac);
>    ```
>    Should match the allocation function. If using `calloc()`, then `free()` is correct.


Another false-positive. If you can use regular calloc then it is fine.
