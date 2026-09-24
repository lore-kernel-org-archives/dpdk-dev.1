Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B3C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2EB4027B;
	Thu, 24 Sep 2026 17:37:13 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 20BB940144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:37:11 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so20497a91.1
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790264231;
 x=1790869031; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j5B3VPIodPQIOPeCQWULbfXHzl0qRDOCUp1rY0CZHTM=;
 b=QOis0kBdcYIItHe2BshRiky3s0Aw+paJNoUP2P/w3jrzP3ETEPGOIyrYnKGHI/QKpg
 399LjHmi5n2H7j/REZbBaiEMjGh+w677qf2TwdbfC2Q2YiHtv/xEgDUkRGH0zaG/DP0W
 t4nyUDlqMRKXLG3lkGN6x2gj6uo05yoV9fYiaB3eSYjJu0oBxbJgXHZha26OPzwpgaZc
 QACZA+qbIGX70OxonW4td/6ljK7d8aPBYjPm24BykmvOZmWspt7KYSYmLU37BAensNM6
 iauAX4lpUQfbp6F6/SpEIiq0MRdJ95ERZXZF1lUxBokbmbnoSIjlF2mBuLubGNP+a7A3
 k5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264231; x=1790869031;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j5B3VPIodPQIOPeCQWULbfXHzl0qRDOCUp1rY0CZHTM=;
 b=xWKooHE8b97wourWqOtnpEzzj+LwnFJzBzOiNH4wGBeWl3oLyPOHp1UPzkjHcqlYlo
 OSyLrC4C5Sr4YQNKylnnyIbekIa51MUYHEdoDFERV/Vm9ISq8c0D1I84hGyDFoDFvl4u
 wgyzND1DdAuRZBAmRD6BgihurhdR0iW/2POGeWyStWRNmo7UbZTVIo+qs46txEPXe0ph
 /gutMF8SxiqYXr7KiJM7elKiQvhzARq3b8Jt0hlk45S1SDYS+M/F365uMHbz5GRMN7DO
 JKlRc0MfXXoGXFTWXty92C/Yc2yFOPHr48yO8i9/I2as/oipETSYCi1W/Rnr3RCOpuOD
 mS+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4TP5QJK/i7XdcF9h6tFKqVG7I+jBVvrtD4moIOvheISecZS75QJOzl0EQy9zOTR6K1ZU=@dpdk.org
X-Gm-Message-State: AFuF++k7OnrwaWuKt8SKG+NcdwhrcLT1iH7H/WH3m348AEuYnfXmsBia
 TqAHp2UQ+Q/hw0/BxpIfsFcolvCU1yetV4YwGd16VMqdiC/EL0G34c7Ob0RUn3kCpD4=
X-Gm-Gg: AYBFou3R0Bh0ywDgPoDAPiC5KmB5WmUmQab8ep3ImhAf28gDt4te8z85xeVv3I8WED6
 jH7qVSSi3iB7xAKjkXhxRBGFKLGU10R8kPaviDrIjJjm98uSXT4VINjPRbSoDTVLF6X8nhY5nX2
 KbJO9wSJ2+OJC7SAu+Mxdb0a8Nm+fmX8ZfeUgc/u8EcShaSBQ38MDLazTc5KkCXjrQFghDeNJHQ
 bl1O3TmMfqhMyH1GYRr/ZAZGofFPneGcfvvxzzaAsQfwizPU1bf+M54JAUQxMCPhhKdTkQXWe8I
 GoMRchTwc/PeeYOtquTTubfPBiHKvv8vsuCrJjBN0H4NcPAVQVol8S/gn+Haoh3VXvVc7veq60v
 5kxJZpZmKDk3vFPsnOqkGGglcjYHWjDy8mi8n1N5CWApmSdkGt0NtzrLiuoZX52cmW+jrVTBGfq
 d3LGBfcTvbSV/65O6zY7DQcjhrImjz6mLWbb8xHaEzxN48/U1pD5GmAAeNTpUaCqXPWZMy+GkuD
 p56oPGCFw7egATEyyxH0/WifwHbshywNC9Y/Ybw
X-Received: by 2002:a17:90a:51e5:b0:3a0:a83d:dd0c with SMTP id
 98e67ed59e1d1-3a0a83de3c6mr714505a91.17.1790264230917; 
 Thu, 24 Sep 2026 08:37:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09766210bsm5495967a91.8.2026.09.24.08.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:37:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:37:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, dev@dpdk.org, chenbox@nvidia.com, Yongji Xie
 <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com, Bruce
 Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
Message-ID: <20260924083708.2436f5dd@phoenix.local>
In-Reply-To: <CAJFAV8w+cau6y0dqdDP7iNHsdjSBNvj6B6m6iy2JCnVf5nLNng@mail.gmail.com>
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
 <CAJaqyWc9F=kVhFFoJzMZSQDw30qsdi932S1TaDbkqSH-tmdo=w@mail.gmail.com>
 <CAJFAV8w+cau6y0dqdDP7iNHsdjSBNvj6B6m6iy2JCnVf5nLNng@mail.gmail.com>
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

On Thu, 24 Sep 2026 16:00:19 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We import and update all uapi headers or none in DPDK, for a given
> kernel version.
> And the CI checks that the imported headers are aligned with the
> announced kernel version (meaning that we can't update our local copy
> of the header).
> 
> We could import linux/stddef.h but it may become a problem in the future.
> Or pass a -D'__counted_by(a)=' option in the DPDK project CFLAGS if
> the compiler does not support __counted_by...
> Or another option would be to update all users of linux/vfio.h in DPDK... :-(
> 
> Other ideas?

I think you need to have headers as a complete set.
For iproute2 ended up having to build a dependency graph so if
foo.h includes bar.h that both foo.h and bar.h are in private tree.
Yes it is a nuisance, but you can't expect kernel to support header cherry picking.


