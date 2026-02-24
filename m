Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8CF3C99B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B8EA402EF;
	Tue, 24 Feb 2026 16:38:26 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id DB9AC402E9
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:38:24 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1270ac5d3efso5174959c88.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771947504;
 x=1772552304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl/5CpzGycJF917zzb50itz4mV9/q0omkwPqu80vi4w=;
 b=bAEvmI24OLlcHZoDlajQGloD+uoj2TWqo2qNDPN4qpJWte/al1rXsdLRJGAcu7P7SZ
 4wSj/WTUDjWG6DYeCQTy6nRA5lGU1JAAm8YkA8pz3kG843pzxJUXtFZxnVcECKDkNops
 FaDpdfCgvrMmY+2XRk4/FvxOkYLrjcXiG5cvlHwZnFW8TZE4pj0ZxbTKlp0bn3GaHX90
 aCK6s7VKrFlyPq/NaQ7mouHN8UO28grGxpnk9TjBZ9IX+QxJ/kXWs5Hib2PjB8Ps9jG9
 rpUva+0ul6sfyJoGSkziojIlhGiXYNyD7F2EQdGduh+ET+qujsBdp8AbP3NIjmwXBg3t
 TdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947504; x=1772552304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rl/5CpzGycJF917zzb50itz4mV9/q0omkwPqu80vi4w=;
 b=qYA07Ud2LDzLgdH5ehBcllk2i4NMZvLBGxfQNx5pa4KUlb53QqkidQCivHi90topiB
 AhL/OjNrZP1kdfFMWCAzoItnmFLVxoxLWY9oBikGghX2hnCbraniM6QZklWyaPapd+le
 mapSuUYW7qUT5sUCx1koJygVb6TARAZ/KrhTArBCvdEhgUud2W6ViVn7lYOp4KBB3Ctu
 4LHm3DibJ6UwKySvwdE5I6D+6+nLwPd29vYvI5S6YL/n1fWQMbMozqwuePFuPzVJsTqO
 nOkIcFi1ilHQ6jFrkuHY5wOb8ulDGqFje4ZT4tALHOmQCc/8KbE0zuRlsZKV/IPT913b
 /KYg==
X-Gm-Message-State: AOJu0YxdFpe4Urz09+jfpdNDBLc+drvc2BCw0cucsIIuBlsQ8vywsyI5
 /b7MZf63JGzGZkj3RDI0XTN2VQVQJETyEmUQVooVyGzxHkeoeVbwKolo9tqAixAb8Cw=
X-Gm-Gg: ATEYQzyz/dKVNYK5GHlSBSmaoP1/Xf4bg8U2lDV8UaQsC7+zvUuWhoRbuSM8EuNB4PR
 0PML3sYityDMVUGDNhc/REUvCBkDY45xfQrQd8iLv5+QnpGOzs3hvwtDjhsCzg7g1BsqfEEDG9I
 548KsgN1GPub5f04uvJ8DbCwrbsnCCWkDzAmi5HAvBNV/AihULA0DdiRTyVCZI0kB5ankjOqBF/
 Bh8uPsHfg++HhTiP75Mu/6K5/yhlZbwgVLFV/FY4s83R1cD/YpdhcPyAq764pEO1ZIg/WiIUkRK
 YCaNaLcRe4s/y2n/EDP/ZmQOa1YglpTS4kVTKnWqvmk01unbFh54wWQYGt1cuSL57Hq1JoggpI5
 50ZFaFlKZEiHv2DHU8PHniMY/pKdyBKwwBgz/OgsnjkZWk462ki2JOcxMzSwpKugOtvL5u59KqN
 Nw5THYyHrI3IR+vYiT4Ct0G8UETOEO4NZGQIDXmMTKCMO4uHGMD0+Duub943mVZIMS
X-Received: by 2002:a05:7300:2142:b0:2b7:24ad:5c54 with SMTP id
 5a478bee46e88-2bd7bb70568mr4059838eec.9.1771947503477; 
 Tue, 24 Feb 2026 07:38:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm6742654eec.12.2026.02.24.07.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:38:23 -0800 (PST)
Date: Tue, 24 Feb 2026 07:38:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, ktraynor@redhat.com
Subject: Re: [PATCH] net/tap: defer qdisc initialisation for rte_flow
Message-ID: <20260224073820.44a5a329@phoenix.local>
In-Reply-To: <20260224152744.3860285-1-david.marchand@redhat.com>
References: <20260224152744.3860285-1-david.marchand@redhat.com>
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

On Tue, 24 Feb 2026 16:27:44 +0100
David Marchand <david.marchand@redhat.com> wrote:

> qdisc setup is required when using a remote_iface or when creating
> rte_flow rules.
> Otherwise, many applications don't care about it.
> 
> Let's postpone the qdisc init to when it is really needed, that will
> avoid spewing ERR logs for nothing.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Agreed. Should probably mark this with Fixes.
The only AI review feedback was that flow_init should be bool not int;
but the existing code uses int for flags so OK.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
