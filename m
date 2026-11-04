Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42540606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hQ8YdB07
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC444026E;
	Wed,  4 Nov 2026 08:29:32 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 5034040151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 08:29:30 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so60649666b.3
 for <dev@dpdk.org>; Tue, 03 Nov 2026 23:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793777369;
 x=1794382169; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQLe8cs4yilxDF8X+Q6aJx+WRBDHNhihoNHFUTdiFBc=;
 b=hQ8YdB076lsv+Rgg0biCu2pbw4xocgyyiyN2Z28HLU1VwssiXJqrkX7fI7o/PCE04h
 pjyYuPC6lRknYreIXH/Ynj9dvSFfBmDy/3FmzIccJvMJGi50SWOlP9jOkr7aF5O1CasS
 EeOvaw7ZT7BUffZy6HUbz7i3uK1hPrqNpEUGeom/yL02P8tymolKFC5QHGI5A+41Cf0G
 Ro0MtcQqxZBg2prcq8JDRiSRC0kbnHVQnYxTnlh+idBIdWjzhVgSzpntFjvBISXABe9D
 qcQhM+PktImMDm8y8eZQPL/85RnLiCFBtWgiEiS3zaU7+NZV/1rA0JtIgXbRmPU4Hvca
 KnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777369; x=1794382169;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQLe8cs4yilxDF8X+Q6aJx+WRBDHNhihoNHFUTdiFBc=;
 b=xvUDfHNTisv32iQjdX56Blbt5AqAhJi8xF+l92vwqhYpu7hT2iHSTNQz2SVeGJYDBZ
 8ZftCj/sJ755DOSeSvDafJazpbE/8B4VT6l9j5cdqbJfL4QJIYe6KwO5GUGLgoAqLzO6
 B7Zq2BObOplqr8c152t5OlxGRYIK95igJTiaK1IPYteDYNW4gCat175B6XZk/l4wjROf
 9hnYnus+2A3kO88kO+Y2nJ8O1JdQjF6fzydG3IlE2NTnhUyOMX3gzYxHWK7NMrQvd0bT
 UPqc+F9Y1M6c6wMY+IU75ZRjEGTDrUACHc3/cPawS+CE6unguHjLuW81FqDpi8EFsX6M
 xisA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc7OIZwlSZvTsy2+2KeBQ5hUYX0Ps1H+RgAwWtvdK/z1s/hph8y8VgJm3ZbaSNSrysDIY=@dpdk.org
X-Gm-Message-State: APuU4Z+/TWD/qpnBnTBRp14kbMUhuRq3D2g6pp4c57l3Hh5yZlPeAjGN
 v6J1ACXuQCcQ3xLAcJmBrnTFLzTODHbAjmfmFw2I7ZnMX8Hk24vwc+IAJcZTwCWQsWA=
X-Gm-Gg: AYBFou03e7CzY10iGaEETnU11YjO5Wh7mmILKLqwov4309NUciRjAspYIL3Rs8/05ta
 ETJmx7loSUeRe9c5ojzMGENp32w10tZ0LwY4rsP9qm+wKeY7tUOReTGMuMh6Kmv9ilTGr928rxz
 Ahkf5WTsNg5ghwLnkRUcxS/J849Q28qzBk/MDc5ncbGlYyY+hcDyircmZetBhRm/nF2uKSzf9mB
 +bvJGVjJskITInXsF8hGt1CqNJ00cHH24NSR+/Cjc9bzllrVXFmyQj7ArlqAGhEsV0kjO4kO390
 nepT3N/FBW3u3deisBbuzvB0g42p83QNoeCwV+OFJhf7N+M9k+yh0TT5cMmU9Vkjm26SDg1dxFS
 Gj3OdrlH/HjEfaYQ/D3KfPIpgYfiqa4icJyE1tgahiL4IoIIJ6Ku+VNDu2FQex5jM85Wah7CCpx
 8hHEozG+DKljIXfKrF2NmyMTm7cRNAOkfbDKCu0FaOvHu95ps1pigfgMs3t0BFaeL52Un3CeWtX
 YxoiqXIMHfUVXJcVOtpaFjEKIkEq7biIurdJfs/RAyH7MwzwM9TuywcERn4TBlyCPW6PWondr2l
 T2WjQQc0J7Xagd7W1Nh8PG6DfH9/8fyusSM4Usg26YpExfRgVTFlLEhgdlOwgo/I6Z3ZKQyuw4h
 BkgfutxYmOy9N5RI=
X-Received: by 2002:a17:907:c5ce:b0:c29:63f2:99bb with SMTP id
 a640c23a62f3a-c4ca7acf3a8mr1403607466b.47.1793777369428; 
 Tue, 03 Nov 2026 23:29:29 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e46622asm41672066b.52.2026.11.03.23.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:29:29 -0800 (PST)
Date: Wed, 4 Nov 2026 08:29:26 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] net/mlx5: improvements to link status handling
Message-ID: <20261104082926.47f4ff38@stephen-xps.local>
In-Reply-To: <PH0PR12MB7077AFBC1E81E2E489F6CAE1A4692@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261030172843.2304296-1-dsosnowski@nvidia.com>
 <20261102090744.06c8be14@stephen-xps.local>
 <PH0PR12MB7077AFBC1E81E2E489F6CAE1A4692@PH0PR12MB7077.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 11:04:39 +0000
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Monday, November 2, 2026 9:08 AM
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> > <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> > <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>;
> > dev@dpdk.org
> > Subject: Re: [PATCH v2 0/2] net/mlx5: improvements to link status handling
> > 
> > On Fri, 30 Oct 2026 18:28:41 +0100
> > Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >   
> > > This series is a result of splitting patch:
> > > https://patches.dpdk.org/project/dpdk/patch/20261026160400.1290443-1-  
> > d  
> > > sosnowski@nvidia.com/
> > >
> > > Patch 1 - Fix for mlx5 link update function to query current link
> > > carrier status, bypassing the delay introduced by linkwatch in Linux kernel.
> > >
> > > Patch 2 - Move to link status polling, in place of relying on netlink
> > > events which can be delayed by linkwatch for up to 1s.  
> > 
> > Instead of polling is there a way to get the lsc directly from devx or ibv on
> > mlx5? That would work around the issue and avoid the overhead.  
> 
> From DevX, unfortunately no.
> 
> In ibv there are 2 options:
> 
> - IBV_EVENT_PORT_ACTIVE/ERR - generated on up/down respectively;
>   On ethernet devices, these are generated from netdev carrier state, so they are
>   subjected to the same linkwatch delay.
> 
> - IBV_EVENT_DEVICE_SPEED_CHANGE - generated on up and down;
>   Is generated immediately on FW event reception.
>   It is available from Linux kernel v7.0 and rdma-core v62.0.
> 
> IBV_EVENT_DEVICE_SPEED_CHANGE would be ideal here,
> but there's no good way to discover whether currently running kernel supports it.
> 
> Theoretically, this event was added alongside ibv_query_port_speed() IB verb.
> Following logic could be implemented (for DPDK compiled with recent rdma-core)
> 
> - Call ibv_query_port_speed()
> - If error:
>     - start listening on device speed change async event
>     - on event: query link status of DPDK ports on that device
> - else if ENOTSUP:
>     - start link status poll loop
> 
> > 
> > Long term, it would be good if kernel had sysctl to set linkwatch per interface
> > but it doesn't  

I have a patch to allow link watch timeout to be set via netlink or sysfs.
But needs more testing. In future, mlx5 could detect and configure that.
