Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80795CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A7AF40DD2;
	Wed, 14 Oct 2026 17:14:30 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id BA2BD40B9C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:14:28 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ac5b090d16so815453a91.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791990868;
 x=1792595668; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zx1adFjXjGrBrOCiFuZN3VAwjvk1Y2r9HJfJIeplMgQ=;
 b=KmEdmHMo8yqGSCsLRO8TdZyC/rQO2srkituX1UOROn9K4SVrB16w8cV5GusBW/SnAA
 B4p4lileybTZF7TX1JUnPPlzFZFSbBPTu39JUYH9fUXKUokZ0IULxIZGnaSjznpfp4Mu
 RmwlKus4PsW2aEjFPSUy7fltKQtoY8La37zZvBfOABfi3N0nQXhBC6lYoYwLMKYKGPX1
 RCFp8kdAE9esHxf7epE3ijN518jVoUgOHNq4nB7a73IVdL2zTROSVAyx+sSAGLWjNAUe
 N2GDV4Ia5guVh+VRmRO2Ty4vAQ0XF7Z0cMf3/SaLD8TrsU38YOxqftCNnihBCFMOedWW
 IbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791990868; x=1792595668;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zx1adFjXjGrBrOCiFuZN3VAwjvk1Y2r9HJfJIeplMgQ=;
 b=u2DPcq3t2biY0sI5opnVS+3BQrkF34et4fNe426Ywl1HdMTLXulKGAQpbKdJPLLzDU
 ZMqaTJvjHowzJ72BsibJdC1iwYxWhM4s0QqiIQfeNfdYFdseN+1Y9EmNWEiUHAnWLtUM
 Jn4cRsL9/JCNG4GKCjS1j6iRPI89w436dsFpDVWC+zDqX8+yS5O5SxJgiZQl3x4bZaDo
 OwgT2VSapZ45jS2QpDML0pcU7NCtOeKSC97moB+o/E2rcWotJjqWH+5dWFl25xRCfa3I
 U1srGZ7wHTLFAP2FkVnK3JHavAbu19bTNT1iP4mZ1WXsTySKBgP1OjcynswWBrSPLcou
 PkdA==
X-Gm-Message-State: AFq9FYKDLszZ+eVW++lwPSl1QdxP8XmY7oF2p/Wer+mGyehFWKqeWjXO
 9QdpCx9wApg9LKxNBBh0tzAGRaBPNuu0Q1FQjqcDBx6ys/DC8eeCVwEsYfbnk58RIh0=
X-Gm-Gg: AYBFou2S2qtdqktQTv6Biyd52e5TsJshK1Qkt8lxeZrcgm752lQHx/sMWHH8D8/RIFO
 EC+C35HoKg3WzaA1b5e8m18psE5fowSQtJ0nZ+EUj+M4op+FAJVAgEPAZSq1ML/1kFaei2lMHZd
 1pcEnGtxTnzoJTziG0TjsWXkUIFbETB5bhd5/uNDnTTdwIcTlqICaYKU90TC5SQ7eiVagRsTtr0
 PbFNJ4FdQSWEu1Mux2ZGts1VkWRGXxbn0uo6a1+AyIfnBAqVUQFZRfV/prm18oilacRETozrTFs
 L7Z2/v9PCgNPHb2oPWst9hCgyXoL7L0T/yLtXsAqUcxzkO/LS3bYKoG9ImAsebU2pfW8qwETJbq
 DNf+t1rqTM/iVqrGyW6pQJWd8ZHYNBYlOH1lQDqKbH17KzgTV2AgdjCZuJVvIjZdqoBQWAr9nD+
 1HZtdUqEmVU08+V0h/UtvoYD0orNG//NxTjglbEf1ojyS021F3B2pBLydpNHI00qfTETvPFld51
 ZKO7s1zslI/7+6WYbNrWq0un3w31DFUIjdTHMMJ
X-Received: by 2002:a17:90b:5343:b0:3a6:d850:bf16 with SMTP id
 98e67ed59e1d1-3ab3a9feae3mr9103210a91.23.1791990866355; 
 Wed, 14 Oct 2026 08:14:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f202d78sm4800424a91.3.2026.10.14.08.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:14:26 -0700 (PDT)
Date: Wed, 14 Oct 2026 08:14:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Cc: dev@dpdk.org, Gaetan Rivet <grive@u256.net>, stable@dpdk.org
Subject: Re: [PATCH 0/5] net/failsafe: fixes for sub-device removal and
 configuration
Message-ID: <20261014081424.10323018@phoenix.local>
In-Reply-To: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
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

On Wed, 14 Oct 2026 19:42:52 +0000
Sandeep Penigalapati <sandeep.penigalapati@intel.com> wrote:

> This series collects fixes for the fail-safe PMD found while testing
> live migration of a VF-backed sub-device (iavf) paired with a virtio-net
> standby sub-device.
> 
> - double release of the sub-device port on hot-unplug;
> - NULL queue-release op on sub-devices that do not implement it;
> - MAC address pool size off-by-one and replay of zeroed MAC slots;
> - unsupported link-status control (-ENOTSUP) treated as fatal;
> - sub-device removal not detected without the RMV interrupt (e.g. VFIO
>   device release), now handled through a bus device-event callback.
> 
> 
> Sandeep Penigalapati (5):
>   net/failsafe: fix double release of sub-device port
>   net/failsafe: fix queue release without sub-device op
>   net/failsafe: fix MAC address pool size and replay
>   net/failsafe: ignore unsupported link status update
>   net/failsafe: detect sub-device removal via device event
> 
>  drivers/net/failsafe/failsafe_ether.c   | 40 ++++++++++--
>  drivers/net/failsafe/failsafe_ops.c     | 24 ++++++-
>  drivers/net/failsafe/failsafe_private.h | 13 ++--
>  drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
>  4 files changed, 62 insertions(+), 98 deletions(-)
> 

One related failsafe issue is that today tap is carrying some stubs
only because failsafe doesn't handle ENOTSUP
