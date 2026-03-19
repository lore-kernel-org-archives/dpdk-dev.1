Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148A1075275
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 08:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA92E402D4;
	Thu, 19 Mar 2026 09:41:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 901634013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 09:41:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwvN9kz3doey3zKHsqj1Ds1exn60vouQIBSMSFlGPc0=;
 b=gbbRTfCdQCkSRcwd8sZMgypVuKm1kfD91qrflvGwpD5zvqVcRnJfhjk6bGh5rWyRw/EEXY
 FCudFDitplMObgt4OCMaPno08S8/pa0ZP6xHVv9nM2fU9UuPCk6b+LCGdhNjmHsNk+WTMN
 v/H1uXggSd4UeJRgqsQGpo/Hj7i6AXY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-B1ACWNp4Pb2t-uJ4grHhzA-1; Thu, 19 Mar 2026 04:41:17 -0400
X-MC-Unique: B1ACWNp4Pb2t-uJ4grHhzA-1
X-Mimecast-MFC-AGG-ID: B1ACWNp4Pb2t-uJ4grHhzA_1773909676
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59f8dc94e84so520777e87.0
 for <dev@dpdk.org>; Thu, 19 Mar 2026 01:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909674; x=1774514474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwvN9kz3doey3zKHsqj1Ds1exn60vouQIBSMSFlGPc0=;
 b=ioXctrBvTf9hZrJyBTiRwitZUqNM4XPSVDW15jfPH7i/TDyyNFAuTOMCS9IYY+o2b9
 ynS3oX4xJp0f0E4F5cbKc7jLAhytiBZIpcmUT+UKDxTAHin7oVJwFQNyoXrg3hps55SB
 VEM38rzbZd6xGEuKS0yi5GBUnZKkZOcgKTYXvv1UEAm+31yz/q929cPijRCGQs01Y1bh
 OpD2EfsFvPKHCY4GTIYvoEV2m2gyvj7hcmiJshClWTBrJn521xrDwvxoB7kWMOb+bZWX
 GV5xVDMkwz8cNkR3ka/XhQ9IXEr1ltI/AoVGdk1m+FFJE/MUtzJQM7gqu6Tq48wReOqj
 LKeA==
X-Gm-Message-State: AOJu0YzVYu7LBXv52vpQOQySalytJkNyFaTF2lKFAlYFvUvyoU9PgkHV
 HA7PVNruiGXCmhuOu+GQrA/gSjxaJT989yN91O+ReM/YKO1IRZrlJmrRZLrZMYw0X5mxj6uDxjq
 HfmehO+Zxwfw3ZGa5Ex4T5EpbQDBK7m51vvArvLPK5k+8Lsqz8dWod9dGqhXYPoLhGbQjzBwoFK
 lDXozKImyR+XxIqIyBP1a01R7j0CMEJA==
X-Gm-Gg: ATEYQzwJ1crTAgy8iAxjIBwuAlcJoqpg1LnAT77WEc4n2v9nsLF94YedHYn56/hHMDP
 fY76Lr2h4rCtMdWggXADSRqezyfT1WRZbJh78oz2LLTfeLXUO5SIDUPuprAonuNdpCSdCyCXx8/
 /1pW0L+hytqbWdC6WAjikT3o+LDPmszmKfVBN13Orz/RkXzlY0CiCl8UIx7JxfucXDAx+dvaU7X
 1RNr6o1RnFknY5gVcmL9JrrpAJn5FOGyhglHew0oUZrU2luTPKq8AitCaw9evTs8xpYXA==
X-Received: by 2002:ac2:4561:0:b0:5a1:2f6e:9492 with SMTP id
 2adb3069b0e04-5a27958b8afmr2264344e87.16.1773909674251; 
 Thu, 19 Mar 2026 01:41:14 -0700 (PDT)
X-Received: by 2002:ac2:4561:0:b0:5a1:2f6e:9492 with SMTP id
 2adb3069b0e04-5a27958b8afmr2264333e87.16.1773909673787; Thu, 19 Mar 2026
 01:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260318163628.609968-1-david.marchand@redhat.com>
In-Reply-To: <20260318163628.609968-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Mar 2026 09:41:01 +0100
X-Gm-Features: AaiRm50Ah8f5Gf0ITINFRBFzYKVvch_WovZz2Fpv-zsEYiOl3YugMbfjBn_uJxY
Message-ID: <CAJFAV8xm3yaoAPEDPE=iUqOLvjgbFd0_27KHNoi_rKeaoxfDQg@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix mac deletion on Linux
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RTqORhI0g5FkzfVaHUd6G_mP5djtgMqrSeB6YOzI2zA_1773909676
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

On Wed, 18 Mar 2026 at 17:37, David Marchand <david.marchand@redhat.com> wrote:
>
> Re-enable debug logs unconditionally, this helps understanding why mac
> deletions were silently failing (while a bridge fdb del command was
> working fine).
>
> testpmd> mac_addr add 0 FA:35:44:3F:58:31
> testpmd> mac_addr remove 0 FA:35:44:3F:58:31
> mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
>         Operation not supported
>
> Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
> with a RTM_NEWNEIGH op.
> For a RTM_DELNEIGH op, 0x200 == NLM_F_BULK and passing this flag
> makes the deletion fail miserably for a single mac.

This issue is actually triggered after a change in the kernel uapi.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=545528d788556

So the DPDK bug can be seen with kernels >= 5.19 (and in my case, RHEL9).

Probably worth adding in the commitlog.


> Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

