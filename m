Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B0D262B5
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 14:40:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 489D3427E1;
	Wed, 21 Jan 2026 15:40:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 909D7400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 15:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769006422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iunB5t+QxaCNXP87hbMtqCJ+F3/50zYnYgi7nWvj1sE=;
 b=VC09uP/3WpoDlOLCzIZ+rwNyfx1G5KmEoGVbfnrVXYkzmjsuh5iWo0OAGTm60G5XBpFc0v
 ajZGsL1k0LEDl7A3dBLcM2diKw/OuSl/l6VA/Rsp/w40LLynF8Gh3D2DTAv1E3qyq6Co5P
 0LSH8WGy+ak3izPl1D+4/rAqkOMrNOw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-MAe_rqCRNyaY3LI19BWSVA-1; Wed, 21 Jan 2026 09:40:20 -0500
X-MC-Unique: MAe_rqCRNyaY3LI19BWSVA-1
X-Mimecast-MFC-AGG-ID: MAe_rqCRNyaY3LI19BWSVA_1769006419
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6a9bf5cbso4901709e87.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 06:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769006419; x=1769611219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iunB5t+QxaCNXP87hbMtqCJ+F3/50zYnYgi7nWvj1sE=;
 b=s0MZnd5iZmlbE4NeCihGJrIK486ymF5GdQb5OuVM5YXXIHJEFYv2IgzWtVPJcas8uu
 Jhp8aWjIJVLMJ7uvcvJnlPCsLXz6jv1We2TjYkcaJpszhLP/4tjumZPbSg39d68WpvVS
 nZDxZndjmXPdGFpaeHkj00ENTeCy5a8+j5tpJ5cVH725i5/o/QyKx8LMFIck9w1A7mVF
 75MRoEjphlzFbibNjR1cK4Sc4bqX5dxet3xlrza3504qc1H5hAQdkcK1faNTjTXK0U8E
 WdUrUpGNb20UlRT75LPeuS2mxg7ofTOYv2zlgPskDV0g1eQss+iMyAo3cM57gwiQWJVH
 gI7g==
X-Gm-Message-State: AOJu0YyyowrYkb3P31icqe2o3GCy6wHzCgjY5eSeZUSHWIy6H/b9fSX/
 uVqJTQKezC2Ecn7bODXrLyoSenjDMDvHRIhTB7JlNFE2GumlFto1MyV70OxpFEpAVIVWSHUiwes
 Id057namq78mb6ge/354xIex3KGKMCdd0OAD8Hk2ZQR7cTq8I4wmwzWeCKW2PeotfpV75DUvN3a
 OxGPehUZyWjOSLp6wwIHk=
X-Gm-Gg: AZuq6aJYkMOT9dBTfevkenr8TNqZ94F8wE2Xr2bWENJd7M6/ZBSsIa9KKuTHqE6yQI5
 cAok0em5zHWkzqdWlvn5hussrw08gXNUR0hY6RbGF6SQHJG48AZa2qzWyb9WmXMvfrZeiayGdwP
 ayEFWOl+8O4tgDxQG6PHMdVDVgK3N9gAsxSv0GlbP+VYTc45xlJq02Xzp8x/YVZAl6soUf
X-Received: by 2002:a05:6512:1105:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59bafdb6c43mr6386593e87.16.1769006418913; 
 Wed, 21 Jan 2026 06:40:18 -0800 (PST)
X-Received: by 2002:a05:6512:1105:b0:59b:6f90:4a2 with SMTP id
 2adb3069b0e04-59bafdb6c43mr6386571e87.16.1769006418272; Wed, 21 Jan 2026
 06:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20260120231638.194471-1-sismis@dyna-nic.com>
 <20260120231638.194471-2-sismis@dyna-nic.com>
 <CAJFAV8wPT5fTZaOVhMXLHHa0J66kBUaPJX6a-8+-d-hdvNcYiw@mail.gmail.com>
In-Reply-To: <CAJFAV8wPT5fTZaOVhMXLHHa0J66kBUaPJX6a-8+-d-hdvNcYiw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 15:40:06 +0100
X-Gm-Features: AZwV_QhKMbDQ-2Luk9U4tSmhDZlJuIY92G5JrdRKwtUIeuRz050sX7zp3l3uJpI
Message-ID: <CAJFAV8w2bUQn2xi-nVDEpU4P2wuFLwECdkhm-=3J-QrN0hYW3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dts: fix invalid f-string syntax in testpmd API
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, thomas@monjalon.net, 
 Luca Vizzarro <luca.vizzarro@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JuzjielKFp6h7RSwyEi-kqkyM4UpmBkdRx0T_KzoRGY_1769006419
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

On Wed, 21 Jan 2026 at 10:02, David Marchand <david.marchand@redhat.com> wrote:
> On Wed, 21 Jan 2026 at 00:17, Lukas Sismis <sismis@dyna-nic.com> wrote:
> >
> > Fix f-string syntax errors where double quotes were nested inside
> > f-strings that also use double quotes as delimiters.
>
> This is backport material, since it affects 25.11.
>
> Fixes: 9db52910a8aa ("dts: add mbuf fast free in testpmd shell")
> Fixes: 554192dbe9e9 ("dts: add start Tx first method to testpmd
> shell")
> Fixes: cfd851f264d8 ("dts: add QinQ strip and VLAN extend to testpmd
> shell")
> Cc: stable@dpdk.org
>
> >
> > Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>

(I'm taking this fix via main directly, as confirmed offlist with Luca.)

I updated your mail contact and applied, thanks for the fix Lukas.


-- 
David Marchand

