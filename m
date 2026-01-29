Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0657FD46BF0
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:17:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBCDE402BA;
	Thu, 29 Jan 2026 02:17:05 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 79B6440297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:17:04 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so5871655e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769649424;
 x=1770254224; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rxQmr2M60iCbFNGCN2QD588XEtxoQxqCieLHeV1K+M=;
 b=c4ktPYt6CahIH1NN2HT9XqcN/wlE9eexTZE+K+3ZBW/L4F/itnIHthh0yiOFJWCMc8
 O38A4fRJ9AYnFcRGbnL0Y8FZwUIt0I0inXfjgZCU/3mBx8pSkDl45z3lHXBcZL7Tl09o
 oSAxTdy3mATKqqlT1nDnQcAxDrKkerR7oKoGMfUJm+FM953w0yK/g/eGCzIcDUdIeGaR
 abZdDW2JluE+vYohFyyiA3ftrkFMQE3SrasXkh5F/Cd5SO0nNJhq6PgT+cjl4v07xL9j
 Np+1fI5OQwVVkDOVM2z+bM9xAEy0MGAE54O1/kJbR2NH0d0W/0MRgsgN5HbBIBoCrHRd
 dMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769649424; x=1770254224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0rxQmr2M60iCbFNGCN2QD588XEtxoQxqCieLHeV1K+M=;
 b=dm42C3fsxqtuqIz9P9oVk3DEBLGrYhWbI7inOq22J1EUNAU7y4uRgQOtxTb1R5bB3H
 VBdDXeLIYplf9s1rhSx2b1IcipeYi4xdIxfW8MLEzlHnmvOMTFllzJzVy5Qm6LKCDG2V
 9QRGX7zaignstF2SCW1b4Dr91qfgs124NIVyGd7EBvdHvoxqBpR/xIaXHXpnTPn6olH2
 sztzHqWGtfB7FY8gMRkjcYPex5RjECftZY2jJ7WWifRaiOkbKg6yZq+RIelPPdecSb09
 +L3B5M1N3MkZCdNuuGfVQch2w61ehCLDNbyHj0+YNlwiz/fP++yFGy2q33DcwNOF/XfU
 EtFA==
X-Gm-Message-State: AOJu0YyccXUBt5fYVJI/Sl2YlS9+egUnYLf9/Wf65VDdI+MDKE4t/OPQ
 LaZJpHY8yX4/6L07mKawRTk8/UisQDJHwInqdiKrE06tfkRPdzBpTvq7nJO16B8pdZL3rtG8/Kz
 I9Pa0
X-Gm-Gg: AZuq6aL0DjvT3qjkYAgev6NzADm0/MJfp4AbDNs9dD02eDzyMVBskazlHNNACwv2FBl
 9Oqr5COJEc8rtMz8qDWrWNLvp5s4BMbCoPvtGtbKsVOaGGe/z5MOxo6KCOFRzgt8k7P5TdzL8JW
 7ocmcvDORl+TxE80zcM8WV03Xpi3Zzrd0JkAy+lAOC68o2D1InqTxMiHT4YsYeCfsf52g/yGONS
 HZCpmiv3FR2e2kjP9JL7vDps9cOUUXYHiP03/Og6dad2ittdGLXAm2KN5sL/1zCmRFvPWZ7dkhR
 WkMNTGfr0R5E37DfPdi12/SVhr8u8A2l8xwSLyYhbrcfS4lE/CbcyvjmOAR8MghQGA0g39wi+QC
 mSaIH+KiGRTaHkTnKjlBQTTStTvv3/khWj/3XNiH3VDR5aM8BO5jqqRz/H5eEKHaE9hNKOJI9pz
 Oeiy9nadvgY19ZwLEH6fy5bTJyk2N8j/KOJyKAOUbFOEgQwlDUZR/DulqHDNWjP3k=
X-Received: by 2002:a05:600c:a08e:b0:480:3bba:1ca9 with SMTP id
 5b1f17b1804b1-48069c16480mr85512465e9.4.1769649423975; 
 Wed, 28 Jan 2026 17:17:03 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c3c6sm96375975e9.10.2026.01.28.17.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:17:03 -0800 (PST)
Date: Wed, 28 Jan 2026 17:16:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 2/6] ethdev: add RSS type helper APIs
Message-ID: <20260128171655.398e9871@phoenix.local>
In-Reply-To: <20260128215838.73502-3-sismis@dyna-nic.com>
References: <20260128215838.73502-1-sismis@dyna-nic.com>
 <20260128215838.73502-3-sismis@dyna-nic.com>
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

On Wed, 28 Jan 2026 22:58:34 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -55,6 +55,17 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Added experimental RSS type helper APIs in ethdev.**
> +
> +  Added new experimental APIs ``rte_eth_rss_type_info_get()``,
> +  ``rte_eth_rss_type_from_str()``, and ``rte_eth_rss_type_to_str()`` to
> +  convert between RSS type names and values. These helpers provide a global
> +  RSS type string table via ``struct rte_eth_rss_type_info``.
> +
> +* **Added experimental port and queue identifier typedefs in ethdev.**
> +
> +  Added new experimental typedefs ``rte_port_id_t`` and ``rte_queue_id_t``
> +  to provide type-safe identifiers for Ethernet device ports and queues.
>  

I would rather see this library work without the addition of typedefs for this.
The types for port and queue should be typedef'd but it should be its own
patch series and fix it everywhere, "yes that would be a very big patch".

Introducing it in middle of other library addition means it would
only be partially done and create lots of confusion.
