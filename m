Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85663C55174
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 588CF40272;
	Mon,  3 Aug 2026 05:01:57 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id A62BC4014F
 for <dev@dpdk.org>; Mon,  3 Aug 2026 05:01:56 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1691199a91.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785726115;
 x=1786330915; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iw6Smf3pl3DaC8ZAXhVmb0EAWrOjO8PgUpkewQLsOQw=;
 b=HNz2lSSS/huWLxgFrIULQgWM0dBH2YESF/AgqEjbEwGvZfD509deBPdXgcsf24jzxW
 2Bong3UQCd61/BWM593hXpgxAICyWdnrqV7H7o13eXXvIU0yv4WxRDu8beTREVcUFQBs
 CK/u+4CMvlAWCLC0G1ZYh96M1rhvMGrfjTfJolRZPOAMWuB/dgSkKj1pzpRZ8yyUvUYo
 zXspHTudyTCqw39op5EGEJB2cG/uDEDZX+NNbmznVZsg9DW3iT87zJx+W6Q0dAVjKm6v
 iOzMuItYNXE2JprTYzLUmgH6qFhHEuYTxVlI+Coo0OheQfPdnKxjnVfe8c4IISwXDKj8
 FWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785726115; x=1786330915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iw6Smf3pl3DaC8ZAXhVmb0EAWrOjO8PgUpkewQLsOQw=;
 b=qrNE7jkliV+AlxQgwsljZ04iBN4pY/4Hevwn38AAb8p/jB9bQR983chpQboK/exhiS
 3nXf1Wr8KJT39m/bamiP6P5KW4TElg1An8Y2ZhfvdrxbH9uTutEeWeKb8bxpNgXtsRr2
 tsmcdZrwNhwyvk/WCSCTgilMeiPnvlAK6qdLlKyZ12LgdT3J+DRj1TmO9s52mjQnHQ0c
 5U4+jRs9LjDJ2EJVF0IqhVrdACEMJiMm7hQv+BximhUhSh9p2WuJvrOMczGC2kqfXaRs
 OJvVTf9uSsJolkxl/vT+RvULsUEy0zOhFDWP3nQ+nH1nvtrXBiWK8raSvPh9kzXzpj0y
 UV0Q==
X-Gm-Message-State: AOJu0YxWwl1EImPO8noTIlYKCE6fQz5Yna6TFQhgg0lx86Gv7ezDH5hO
 rsE6hA51LfMd32KK6rni9CW3dY2dogNaJY7mQT6lPD4U6+J7WKGBtdFA9uClU3YVf/c=
X-Gm-Gg: AR+sD13pr4wTFK4mrQYql/0/9mbhLjGdXUtrlLBwfbWbr9YircnBgYjsJyhwaYuG2QN
 rmlKMqK2og1ohfoXzljLxF6kRnDVOQvUNoQtHr5n5G6fypE377tOvJOb0XzR7dfs6O8IWnHdsz4
 sOh/2zhJP32/2HZCnYPNQlGQtbRl79vcOvtS/0NXQy54g9Wszw8DOPgnD6+2NtKh5oD6aPhVqSe
 kBxNYJyorxNH7tEIxglgb7MAWcbErt405RjBU76rQ+z8WShmtVTxAqMO/kSIdpIpjqGPSAX2ocW
 5UWYDq2DmuFDboIvwKTOlFH3yA+a8/NLyOHfk+UWjWQgocoJsFwD3yEuq1bBA0A0UehgBAbs80s
 GpA1rbLRqLZu0NV4oFnApLm7ANgDwTwwDFMgM9P0ere2F9xTVd9IQAHRWAFoULXNNgcA2u/bSOw
 PZYz+FW4CoihxEDNx2rmF7jDlAktrdRljiWugpF+IPbijHwDdJiXEZoUOXCoAI1zivfenF3S0Vr
 wnSruOi7HLijipCqADjLnXMaaN2BA==
X-Received: by 2002:a17:90b:2dc4:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-38fbc3f807cmr8146272a91.4.1785726115420; 
 Sun, 02 Aug 2026 20:01:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab4cb50dsm41887987c88.10.2026.08.02.20.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 20:01:55 -0700 (PDT)
Date: Sun, 2 Aug 2026 20:01:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, Akhil Goyal
 <gakhil@marvell.com>, "Anoob Joseph" <anoobj@marvell.com>
Subject: Re: [RFC 11/21] test: include headers directly
Message-ID: <20260802200152.520fccaa@phoenix.local>
In-Reply-To: <4a00ff617234470da636f5b1915eb663@huawei.com>
References: <20260802181835.476887-1-stephen@networkplumber.org>
 <20260802181835.476887-12-stephen@networkplumber.org>
 <4a00ff617234470da636f5b1915eb663@huawei.com>
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

On Sun, 2 Aug 2026 19:37:04 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> > index 3205afaa63..32389c803a 100644
> > --- a/app/test/test_bpf.c
> > +++ b/app/test/test_bpf.c
> > @@ -15,6 +15,9 @@
> >  #include <rte_random.h>
> >  #include <rte_byteorder.h>
> >  #include <rte_errno.h>
> > +#include <rte_ip.h>
> > +#include <rte_udp.h>
> > +#include <rte_tcp.h>
> > 
> >  #include "test.h"
> >   
> 
> This file has another group of includes guarded by RTE_LIB_BPF several lines
> below, with `#include <rte_ip.h>` already there. It also seems that the guard
> is redundant since `meson.build` already declares same dependency. We probably
> should avoid adding duplicates, and optionally also do a cleanup here.
> 
> With test_pipeline_common.h I could not find what uses the newly added header.
> Other changed files have guards against MSVC which are not redundant. If the
> new includes were added under this guard I could probably ack the change as
> harmless, but as is the opinion of other maintainers is needed. So maybe
> splitting the commit per-file would accelerate the process.
> 
> Obvious question is if we could have some general policy and tools.
> Explicit includes are good, but whack-a-mole approach can only go so far.
> 

Good point. There is a good existing tool 'iwyu' that does this.
Will use that.
