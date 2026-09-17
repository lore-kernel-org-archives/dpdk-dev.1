Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22583C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8180B42F6F;
	Thu, 17 Sep 2026 18:18:57 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3741042F7A
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:18:56 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so936639a91.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661935;
 x=1790266735; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Py2K+3rToPtTLNF6pxJ5fnPvRxbxrX+TQZOILLgw2YQ=;
 b=DNjF4Od+zQ62a7SHW6TvmQg8jw5yQo7/ZP2y7eGoGvdWG9kIAicBzbTRebPQwrrjSW
 /QsBy9XNe1eX8iOcZStCWBAZOa2tKIV0O0VTT8Fz56qNmnGJU86CUOohmSs6cTMhnN/q
 b0i++cmrAcpZKJTveg6W9Bom2NfifUqdk6DDb4F+mgYKZmqIsNFI53Q25oOJNM89Y2+x
 KmKJ2lhOYPqzqYKg7edabx6fk+gKd8M2Ku0kp7yLlgV0y2wSa7JjuKfy0PnbAYuuF9e1
 tu1RA4PvtM/MPYluchKWFIW5aj1kWrHdjlYb18CWr5LqqrPh09wdy8IHK/6Ozi9OooDJ
 hX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661935; x=1790266735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Py2K+3rToPtTLNF6pxJ5fnPvRxbxrX+TQZOILLgw2YQ=;
 b=UHLIwaz5rpHyx0BzJ4C+iUBQsbi2m8qJg243L3dAWzGeC5Fu/+R0AX7QuXIG7jwEpa
 c2tlPWT8xVRW7wxcYRioYsDOAlUwjb0Bb4M0biMSBtrRNqwZYa9Utw40eZgjars0bBKA
 F5AOGtxHgQDcL58VFMX47TIEMO9zGM7My0Mh/eY6OZtc43q155LRQkFDzsXcyUdASuyn
 uboi5Lwpju9O4ia2bOep+1o8VEU7cOhWiWYf38sSzPzMEiXp7KPPi0TPPBnN30fakgb1
 WD2xh+14qU+Fz+A4r6rCabwwXLt26h5w+tRMQWrDJ9Zf7Z72gwGqjY2Ae4b+e8k9luKE
 pYSg==
X-Gm-Message-State: AFuF++kAe4mX06f4I6W4y5ESqbQwzzJlOn1a0Y2tykQKIfzEX2xxFmwJ
 KFqHol/JqNNoyzZxtXX2X81ZI4bb4CbVywnr7ARsOawx80OwsnVZR5kT7oTj2urXl/w=
X-Gm-Gg: AYBFou2B7/09O2ZcBrXXg8iz8Gh9IRNzH4RffVFdthyrs53GUkNyc/FwQERV7rKdUQX
 tW80gr12pOjIvaCh6R1xgUVsvLuz9znk6AN0HWR+E5Agi8EHzrw9t0SBnlc2pB/Do8MAMNTG3dL
 V25fByR6eFbmwEimG7MGoVmo/rsdTb1NPYL+K4wDhF+7Glla+G4xhuL03bXBh/KiC/sGfLbUOVA
 sTOllnlH+EiqOSDgkCYWSLJN5L8fIxuAJOZjy09WXuk9rG69cI2IJN61ZdN1cKbdy7NJPYPrQZR
 p/g9zLL+utPvxGNcmK4of64ZKdKe8SMisiiArRUlJpZ9FlP2pilWMKCtuUR8xMiOGclIDJkJvFC
 e39r+KJSzkehQKr9gmICTIxQxCwQ0Ajao3cswNk/IhCd97F0HohvufSclOyFOgibfjBgtKwM3fT
 fIpq3Fr3JgwjxKfLpo0yr6xdFJr9+W+ySqYuUc44xLnFgpIr83YRT5/Cx057INWBy5N/EIm3Rle
 5v/FJDkQ3Gsp6t88qHxf3rF0SEqwaVN86L0Hf0Q
X-Received: by 2002:a17:90a:d01:b0:39e:237c:50e0 with SMTP id
 98e67ed59e1d1-39e237c51f8mr9390837a91.13.1789661934742; 
 Thu, 17 Sep 2026 09:18:54 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:18:54 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:15:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>, <jerinj@marvell.com>, Aarnav JP
 <ajp@marvell.com>, <stable@dpdk.org>
Subject: Re: [PATCH 06/14] common/cnxk: fix null deref and irq ack in CPT CQ
 handler
Message-ID: <20260917091517.3566dfe7@phoenix.local>
In-Reply-To: <20260917071016.2366467-6-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-6-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:08 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Aarnav JP <ajp@marvell.com>
> 
> The CPT CQ interrupt handler (nix_inl_cpt_cq_cb) unconditionally
> dereferences lf->dev->roc_nix to obtain roc_nix, nix, and port_id.
> For inbound, the CPT LF belongs to the inline device which is not
> an ethdev, so roc_nix is NULL and the dereference crashes.
> 
> Additionally, error paths returned without writing CPT_LF_DONE_ACK,
> leaving CQ entries unacknowledged causing the completion queue to
> fill up.
> 
> Fix by deferring roc_nix/nix/port_id derivation into the outbound
> branch where roc_nix is valid, setting port_id to UINT32_MAX for
> inbound, and routing all error paths through a common cq_ack label
> that drains entries and writes CPT_LF_DONE_ACK.
> 
> Fixes: 3fdf3e53f3c4 ("common/cnxk: enable CPT CQ for inline IPsec inbound")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Aarnav JP <ajp@marvell.com>
> ---

More detailed AI review:

Patch 6/14 common/cnxk: fix null deref and irq ack in CPT CQ handler
-------------------------------------------------------------------
Info: at cq_ack,
  head = (lf->cq_head + count) % lf->cq_size;
overwrites the head the loop already computed on the normal path.
It is only needed for the early gotos.
