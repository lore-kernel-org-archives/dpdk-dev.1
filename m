Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65699C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95316402EF;
	Thu, 20 Feb 2025 21:58:39 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 781424026D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:58:37 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-221057b6ac4so26392825ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740085116;
 x=1740689916; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsFZubeMp/AahE5iiivi/JgcTPnUPQOyFOJJzBRXoN8=;
 b=oMAeVvNOok2EKdENc8Zc4sRliptZK3Vks6AmzHsiLt7D9MNZ1sZoaT9+//E80zLi/3
 wCFozd4MY1UuYtXC1fpB5NJGzTRMkT49i6dvajCC2nEByYICMUX7suborFVo1mALbYTn
 F7DlYC9AyeZ0Y/uDQJp7EBhX3Smgp5OqWvUjKrkWlfoHnqUOAmPTevGecEaXMYSCrCbB
 8CYq4IhjFxZBDyyvsoLA0sTSM91GRTCPO9K9EBYluw4UoaO6dihHgPTNE19dCn22TYnl
 OtQc1xxe9UeGoNkHxse+oKNBekUCnL1KCGaO9GfRMQG2Jy3T0283UGY3WRFC8NaCKSpm
 tvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740085116; x=1740689916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsFZubeMp/AahE5iiivi/JgcTPnUPQOyFOJJzBRXoN8=;
 b=IkZF1f5uhw9GgTcIBzkRWepAFuKNpJazQzjcXkCq7O7c2C1i10Tq5S+l4OrXscimUa
 VOpq85lmPJ3BcoIm4rsbBPKdJInD+l4+6gerDIeIrNO01c7JBYjDRIBexsg5qJZXOhlY
 OYgKZ+LTGDmHIAbD06eblod6zYdccFjaCLtPiyBrQEfbhkU03HetN1m4b+fFoISoEVU5
 1u1aG2smpucSeZ8FAhWRzKDgjRBSC9ujyToxTGeSHxGVGln4ZyOJ8vGoiV3a5nsjb0HX
 wGdbtdBZJXmYJeBWhhaw4rowigItqfpIo0Sx/YLNAduv8df0aGvFrTUfXTR5D08rfUR2
 h9ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQoUQ6/5rlqnnMQFR0d/IguOsZR8PL05bit0nTW85ItyA59vuidQGkEstTS+L9/WRo+es=@dpdk.org
X-Gm-Message-State: AOJu0YzIDrezObA/Xf0T1yiHAucrzQ5iVV3sRMN6Pw6laXLhRhtR8u8G
 he1Vn/IKrQ0zNr6NUqL4icEJf5CkqzArvevtZ0Zn23wB07uA23PeM/7kYEnFAsg=
X-Gm-Gg: ASbGnctLL3YfzdshBk2YU42X+RQ4KyoBRQabAVIidRMkFz9FPmECC78/3Wz883ms5YH
 G2dkAwhcYyskWm9+mhzZJHYXYyMtavtnToLyd6NwO4f47N5jc1LlD2V9MpEjV4z1URLrqU1a+YT
 lpkopaeG0E+O6AxcHntFZMzCV4k3Ff9FtPVgNOkE6m1PwlBFC7xdbj5hRLkdpAxNaXk1Zov6DO1
 +rz86iFIjAI1U2xOzZ1F6t0G+RpZBQy4ea4xacO9axZd9V8xnYnWHVpRr3/cUoUGT/rzFsf93Oz
 5nq+ojuC/Spdh0qNl9V+9fMROJzN/yJf3rh5sO9Aac09ZX67CtM7H4OrjsUXvUru2u2d
X-Google-Smtp-Source: AGHT+IGfSb29OkeLNVm9mhot4JIaJW8MXdp6b3ZVJ7FLkynARyc652T1LxutcZEUF/FkJBsoJq85Cg==
X-Received: by 2002:a17:902:ea10:b0:21f:9c7:2d2e with SMTP id
 d9443c01a7336-221a1191916mr2507885ad.40.1740085116579; 
 Thu, 20 Feb 2025 12:58:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d558edd1sm126466245ad.235.2025.02.20.12.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:58:36 -0800 (PST)
Date: Thu, 20 Feb 2025 12:58:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Minggang Li(Gavin)" <gavinl@nvidia.com>
Cc: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, <dev@dpdk.org>, <rasland@nvidia.com>
Subject: Re: [PATCH 0/2] use flags from user if it is set
Message-ID: <20250220125834.4ca311ef@hermes.local>
In-Reply-To: <20250218103322.166461-1-gavinl@nvidia.com>
References: <20250218103322.166461-1-gavinl@nvidia.com>
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

On Tue, 18 Feb 2025 12:33:20 +0200
"Minggang Li(Gavin)" <gavinl@nvidia.com> wrote:

> This patch series also fixed mlx5 release notes on VXLAN limitations.
> 
> Minggang Li (Gavin) (2):
>   doc: fix mlx5 VXLAN matching limitations
>   app/testpmd: use flags from user if it is set
> 
>  app/test-pmd/cmdline_flow.c | 3 ++-
>  doc/guides/nics/mlx5.rst    | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 


Applied to next-net.
Checkpatches gives warnings because the entry in mailmap has a space before the
parenthesis part and the Signed-off-by does not. I resolved it by putting space
in the Signed-off-by but probably want to fix your mail settings to match.

Also added cc to stable on both
