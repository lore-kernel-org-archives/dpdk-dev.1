Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B2C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 16:08:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05F5D40647;
	Thu,  3 Sep 2026 18:08:16 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 37CEB402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 18:08:14 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-39927410578so4488167a91.1
 for <dev@dpdk.org>; Thu, 03 Sep 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788451693;
 x=1789056493; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/hX/zrq45Aof8Ax2uSCCCQE4wyfCbV8qtKWD7BoUyFQ=;
 b=0zwnQGKpLdGnkfLSDVRaTT6Env8XXF+uqUEbWbcRyFCGOHA5LWWZ6t70GLkTTcbQa1
 w3S/X4l7Rr6PnOktUqS1l7WWMK7I4miVeaE4HcRnzZdVod4DIIl0rN5nBOQTiu3Ue2Uw
 gyBN+vwtLrFflmEAnihm8P2vxXEpk06diV0ceaPXIDnvsFyQ/ZgFHYuyQll/wDcOalh5
 XQneG2rYIZ/idw6sVFxAy6Xu4AC/reFCm5QsMqCNV2BJWRjSgD4WBZCCn7ur6PQ6P8oD
 ER0USDLmLzOfcbRGu4Df6Th7c9qZq+WrkAZ3auptSyZCYaoxz02o3EqGmDUvjEaq5RGQ
 TXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451693; x=1789056493;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/hX/zrq45Aof8Ax2uSCCCQE4wyfCbV8qtKWD7BoUyFQ=;
 b=q+QmRDPHFMxBgmbs/75xdIWh6XTgZwryVA/M2cyDMnoxgyR6Rtk9qtT1wejEmHLkhc
 gNz81FKW+LVIQW/OTajR2x0wh6BV4l+Zu4mstSAooQZiv6VxLhLn7zBrZwoEl95KUS57
 DULGv5qM7B1TYFbTnjeGA3K+FxologPL6TVm3XbJYF6p/lExYyzaILhANfMZqDkT8tMu
 q02+BwFswBMuRvMLTpootfBkYVq9aXV1rzoyeu0oDCYPWYTcTeZsNQEacaebdZ359kx0
 mOFcwmffkaXkwm8CFM2xJKr89Ra/QOYsZDNci/k0CPy3N+ifSwE2E04pKC88HDjEN+54
 jTSA==
X-Gm-Message-State: AFuF++mXC3Lve0rskZo4UH3Z/ignfCy7gUtA0120wg/38vLug9Xv35B3
 o1thQs5vfIrqs4t6R58e8AR95oI8c/H2zgpetz8h5TiKpPhluDC254hqQqH2+KPkbhM=
X-Gm-Gg: AYBFou3ga3988vtzILUejojw1rLtw6nxPmxQFYMr/1+QXzowFkjqQTFucFFugpKFU7b
 QqyQewIhFFkpP9hGhb4ZAsLrmsZvNFHZP6e5NaAtg9Qa9kzn3AAOeqwihxDgBcrdXdeDeeus6F+
 RIwLScoVVQSCaCRKeraBUs7IJX/x2k3GgRUi2jTEM2crT2d2Jaa8+JS+QXCO7K5aR0oFx6D2Jqw
 ho8eapG+yLil++MeRnpk5nNag+Gfq1nIBHgjEU7x8VsbLhXtI4jMokpzoBrDhVKdAzJU8dsZ58B
 L0RzWyEKCYqvUIOxzkTtlW+GYZAjtv0riaUMR8Vj1oYHCMbLdWgH1eDeu1BIO11qBppEojUJCrB
 vYshwVKZNuDVl1NlF3db6udxu1b3FSqwXpenYj59Z4bI4Eu+ujDDjFkfnkPcsBtkkU+k/1nnZDh
 LLTiH269AQFVK1OS4SDNWrbCa2Z3ydipyYg61uxkAL3Uqd4Z6lRf9ZFc01Wz1AQsaCogkCxfhW0
 eSMSyBn4jZ1/tVuSIVD/RoABgOqRQ==
X-Received: by 2002:a17:90b:1e04:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-39aee16ffd9mr17517471a91.15.1788451692923; 
 Thu, 03 Sep 2026 09:08:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08627417sm6218609a91.12.2026.09.03.09.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 09:08:10 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:08:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 02/23] ethdev: use DPDK byte order conversion
Message-ID: <20260903090802.30707f54@phoenix.local>
In-Reply-To: <apk732FF5TwghkqP@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-3-stephen@networkplumber.org>
 <apk732FF5TwghkqP@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 3 Sep 2026 10:20:31 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Aug 05, 2026 at 10:08:56PM -0700, Stephen Hemminger wrote:
> > DPDK has its own byte order macros which are preferred
> > over the POSIX/libc ones in arpa/inet.h
> > This resolves issue where this code was inheriting the
> > inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/ethdev/sff_8472.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >   
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Ok fix, though I would note that this fix is nothing to do with the removal
> of flow director material.

What happened was that when flow director part (in rte_eth_ctrl.h)
is removed from always being included by rte_ethdev.h, then this
code would not build.  The code relied on the include cascade:
   rte_ethdev.h
     rte_eth_ctrl.h
       rte_flow.h
         rte_ip4.h
           arpa/inet.h

Maybe other things are getting this as well?
The DPDK IP headers should rely on the Linux definitions, but that
is  a different issue.
