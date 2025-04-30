Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D4DC3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 14:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F499402B1;
	Wed, 30 Apr 2025 16:28:30 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7663B402A0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 16:28:28 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-224171d6826so108798315ad.3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746023307;
 x=1746628107; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/FwAPx7hDiJigWgqV/+NklcZ1Wb3gCdqsrD6kxcCQQ=;
 b=yOb8P3RBBoCVNa5sSFYhKNQU7hp7ixc/VfrxtLGgQ9HoLk1+VZuLGVAOI9df2PlZGd
 jckbXEa06vlsQTf7lA0RqZh8n8xxhyCay4AwMOZRLPcut0lhwO7HElvhKc/KgFvJfI0U
 Ix9328bGxx3bQsBxXt4+ltmsCpnBwgy7j4C8N+4Ox3oP1MbGovL38A0uAjusG3pAGqcx
 Xs/oHvnD219MERIyLoRT/lwU9J1I/aJuxjKGrMJy9KhdVIU48K5b30Z6w2agB/bW/AnG
 ATvHkZBVFef0wXdAQQitcfp8buUQwg9NvPydWdtimalHOER82zrx3mvPBIUqBCjtoV5x
 UhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023307; x=1746628107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/FwAPx7hDiJigWgqV/+NklcZ1Wb3gCdqsrD6kxcCQQ=;
 b=CAvtgwe5NKIz7V1t/t5AjF+M4dnGIuLxQPBfBLNnY7xGnzpYCaN7M+3f18jaNHObtT
 OUlognRazGfQnCGJnBrkV03+eOqGoDJm27RKFzpLn2+Fy1iBJOelpr6eBlPjfQJbT7O0
 8KcL7zsXFi3lagz/A1syePIlvmNbsW+SmGzcw3gcqbyiGvqseeoEYmLqvxaKuNzBzzeS
 yyz37cTYh4y6B6aBfzMvwQBekwMJ52dN5zXGFzFl61PGlHZAloAScxf5tq/X5y/uQwDP
 IB0s5iMGomjI7w+gCo3L4VGzisE70ZsBbMV6oCb3edV2OCW3bITVIFpaH9/i43A7q7io
 +OHw==
X-Gm-Message-State: AOJu0YzxqZ8i9gmEpYnCebzoTs9lmOv+P2JJN1RWzMoKiBmwjzpFhRk+
 CjY0xiqIfAAIP7fLfRFe6HwvuU6Hf0ylXNMhE5ZrQPNXJrZG4mDlXNWTQaW7m5k=
X-Gm-Gg: ASbGncvUofWNHLS5vL6oMW6TNJ71uUu7htGEy+40jEttl5nuukggrFHcHycxy1dxBm8
 1LV5PydnpdD5smWndilG8CERKLcIdUaPIbRVpJgYV+dRqaomTpFI8uU6ovk84kzj+8bYwnAacJL
 ueZDy8BCbiUEhSHFGHNMKAc7Bs2LpWYwicWDqh37RZOc4FQuuP0jI3HmyAr85TV+OfXdUX1MBxy
 ch1caKObMzwmnsA1tJE2zHRHP/Ne7CiFmpQaj807bihvxHQsH9r12D9Hf3BHlX8hCtTsO3eAnfY
 9wce0WIqvVEuPzk6RRAVcc6ieaITxdTcuO7Xfu2AGqxZbutpUkdYoy6IjUJML/5gypUdSaI1meQ
 dNeip1J4I1liVqZWs
X-Google-Smtp-Source: AGHT+IGPrYGtYMuV3fO1jYJlvUuQEYDDnmnDW3IYChUPQe/7OKBhJNjDRFMs0VJ3j2ZGABG4cjUzeA==
X-Received: by 2002:a17:903:2ac4:b0:21f:6c81:f63 with SMTP id
 d9443c01a7336-22df578a2cfmr48071965ad.16.1746023307451; 
 Wed, 30 Apr 2025 07:28:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbd3f9sm122493375ad.89.2025.04.30.07.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:28:27 -0700 (PDT)
Date: Wed, 30 Apr 2025 07:28:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Upadhyaya <praupadhyaya@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Regarding Mellanox bifurcated driver on Azure
Message-ID: <20250430072825.13ceae3e@hermes.local>
In-Reply-To: <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
References: <CAPBAu3WOch_LYAUp_R47-=Uaos1yJLKgpRBM1ewJ+vaRysCDCQ@mail.gmail.com>
 <20250426082843.736964ba@hermes.local>
 <CAPBAu3WOq6_77mBvd=B8x2tso9hWpjFTyUuEeJgZazSm_y_GHQ@mail.gmail.com>
 <20250428083712.50b2e7ce@hermes.local>
 <CAPBAu3UDao48OmcnEMQw9-W3pesM1W2ftQsEG3EtHDxxOXCc=Q@mail.gmail.com>
 <20250429092415.2a37c090@hermes.local>
 <CAPBAu3XDwr82ghjdhK=QXO53OPH3MgUtkP7r3TLEwOnHe_St5w@mail.gmail.com>
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

On Wed, 30 Apr 2025 13:00:53 +0530
Prashant Upadhyaya <praupadhyaya@gmail.com> wrote:

> > With DPDK on Azure, an application should never use the VF directly.
> > It needs to use either netvsc PMD which handles both the vmbus (slow path)
> > and VF (fast path) combined. Or use the older vdev_netvsc/failsafe/tap
> > combination.
> > The latter uses a virtual device to make a failsafe PMD which then does
> > a combination of TAP (via kernel slow path) and MLX5 VF.  The failsafe PMD
> > is what is exposed for application usage.
> >
> > The limitations are not explicitly mentioned in the documentation but:
> >   - don't use VF directly in application
> >   - there is no support for bifurcation where some packets go to kernel
> >     and some to DPDK
> >   - there is only very limited support for rte_flow; that is with failsafe
> > PMD
> >     (not netvsc PMD) and the limitations are that the emulation of rte_flow
> >     in the TAP device only supports a few things.
> >  
> 
> Thanks Stephen, the above information was very instructive.
> If I do use the Netvsc PMD with the latest DPDK, will my DPDK app get the
> non IP packets like ARP, please confirm.
> I quickly tried the Netvsc PMD but don't seem to be getting the ARP packets
> in still.
> When you mention "The failsafe PMD is what is exposed for application
> usage", what is the meaning of this, are the apps expected to use failsafe
> PMD, please suggest.
> 
> Regards
> -Prashant

ARP handled differently in virtual network environments. The ARP packets sent
get consumed and replied to by the network infrastructure (in all virtual networks
not just Azure). Non-IP packets always show up on the synthetic VMBus device.

Current docs are here:
https://learn.microsoft.com/en-us/azure/virtual-network/setup-dpdk?tabs=redhat

See vdev_netvsc for picture. https://doc.dpdk.org/guides/nics/vdev_netvsc.html


