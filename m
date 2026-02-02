Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27551E7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 312EE4027D;
	Mon,  2 Feb 2026 19:18:07 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 689044026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 19:18:05 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so25938175e9.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770056285;
 x=1770661085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTrITUT2k6wQX31HwFzNM/kCWbRcczrJCIMrxY8NJrs=;
 b=D/gdcU6cB5hndyprXM6V23nzQG4iks+pFMi28lesg14FT+MOGICUyx5gpOB6o5Te3s
 M+oYNcfiXHiH0AmDP3fAe3PabtDhREncGIMXAeeiAaGpoH+Y+Chgyz6U8JC1QuXDCz2n
 qp05W85sCQIEJ5J24+3wtVbPQT/47e/2Ke5Rc+Gh310ryy3kXWcIH+gWuo+4Gt5tUR5g
 jSbKwAgwyLzoIV8WV0EZ5SRwnhU1mIUAEtoRVoOohqzfZg8smT1XMt37ww/Km7nLKUMC
 P6wTSrhqeixPjzNYw65qT4OR63JpdM8aIE1AFZKppvh+xUgD/s55zQMnfUizNimGZsTz
 cQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770056285; x=1770661085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NTrITUT2k6wQX31HwFzNM/kCWbRcczrJCIMrxY8NJrs=;
 b=QvxOPdD40A/jZlKaN0uNjDdHRNA2tBs//P9rq3Cm7VJY88YC4CyjuGRBSjojR18L5J
 Q37q4n2eLzWcTXpCNd4wJLIdFXLZ/u3PW1ch9N0eojnn4heVaBrLqg36sNMd40RxSs0O
 UyVICeX9lFhUmVzXLT1d+nMzuP0AiBlInLGnZSRSxDEJaiX9HvjsyypmicPuMc+W7YEq
 uSQzBHaVaWhxtMlj0yTkdDqaTmGaS8CnUbEGYZ+UuJURJOQ34tOqKilqW65X2hmzxqXN
 6kOVsMZShMoVbc52+hJjNSF368Zpmz/eEgks7+v8NK31Jy5yupwFpnL3cv9S/WBjSb/+
 Apeg==
X-Gm-Message-State: AOJu0Yxn8L8T/HovOYbdUZQY9MCy9yyS2eUzhLWZ6x9KXOTaNA8hV0ho
 2NP1o9UxKJsrwoP3ixdBRQw+ECROI4pCoqk8Gj7mZjpPN6HTvcwAXKzL9CGjsLLDAzQ=
X-Gm-Gg: AZuq6aI13EtkNcf0C6zqrYg4dTKKdDuA8YBbKaYO8YhMFMFKIMPtJD7F5G4wEQ1E+4g
 /UEPZhNHWGDp0/d5XmHK/ykGKU1Pqx1wtwFX5B7OM9E/F5k2hXyvDlVtx4HlavZmjf6Y/U2frzF
 hcXIhege+OqV+syRGTPbGIHd87NMr7ci/AznlOCrvgnnJ8l0jfpXZ+XifOXngSa8HtavDBKk1Bv
 jHDiVZIVdx1p0Rw4OVmRPisqGcZeHN3EvfSyKwVBFrr4hqPKdmTum0IBDCt6ndiY3d8dUvAvOMB
 KCPogolL2dbeiMgzYHt6b7kisHb0iJoG17hZdBVsexw4PNduyn5KLzVHS5a1UZxrGFQcwNU12Vp
 6Pi7H0wlGUUk/MDABsWorL5O99RoVbvPQitaxknA0bHhRbD3gC5JomEJxAEiitf5oUCiaHD5HFm
 TT4GHFFOjHdZQGlFLofdx6Z38eRXPX66NnSBwFJkhU2NqvBzyYvYM/
X-Received: by 2002:a05:600c:8b86:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-482db48d581mr165688895e9.19.1770056284847; 
 Mon, 02 Feb 2026 10:18:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd0f043sm114911755e9.7.2026.02.02.10.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 10:18:04 -0800 (PST)
Date: Mon, 2 Feb 2026 10:17:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 1/2] ethdev: support selective Rx data
Message-ID: <20260202101758.5904983e@phoenix.local>
In-Reply-To: <20260202160903.254621-1-getelson@nvidia.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
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

On Mon, 2 Feb 2026 18:09:02 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> In some cases application does not need to receive entire packet
> from port hardware.
> If application could receive required Rx data only and safely discard
> the rest of Rx packet data, that could improve port performance by
> reducing PCI bandwidth and application memory consumption.
> 
> Selective Rx data allows application to receive
> only pre-configured packet segments and discard the rest.
> For example:
> - Deliver the first N bytes only.
> - Deliver the last N bytes only.
> - Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.
> 
> Selective Rx data is implemented on-top of the existing Rx
> BUFFER_SPLIT functionality:
> - The rte_eth_rxseg_split will use the NULL mempool for data segments
> that should be discarded.
> - PMD will not create MBUF segments if no data was read.
> 
> For example: Deliver Ethernet header only
> 
> Rx queue segments configuration:
> struct rte_eth_rxseg_split split[2] = {
>     {
>         .mp = <some mempool>,
>         .length = sizeof(struct rte_ether_hdr)
>     },
>     {
>         .mp = NULL, /* discard data */
>         .length = <MTU>
>     }
> };
> 
> Received MBUF configuration:
> mbuf[0].pkt_len = sizeof(struct rte_ether_hdr);
> mbuf[0].data_len = sizeof(struct rte_ether_hdr);
> mbuf[0].next = NULL; /* The next segment did not deliver data */

And nb_segs should be 1?
And mbuf must still pass sanity check?

> 
> After selective Rx, the mbuf packet length reflects only the
> existing data that was actually received, and can be less than the
> original wire packet length.
> 
> A PMD activates the selective Rx data capability by setting the
> rte_eth_rxseg_capa.selective_read bit.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---

Need documentation updates as well.
At a minimum:
  - entry in nic/guides/features/default.ini
  - update to the ethdev documentation
  - release note
It would also be good if one or more examples used split but
that can wait.
