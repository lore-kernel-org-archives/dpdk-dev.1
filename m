Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDB606A325
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yT+yMr4l
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A6AB40430;
	Mon, 19 Oct 2026 18:55:04 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 81963402E8
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:55:03 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso912142a12.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792428902;
 x=1793033702; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GUzpDj57XF/luLCmlLP48elJwPXycrBD8t+Z5NcBKCQ=;
 b=yT+yMr4lnnfb4BMg5liG1tBlAw5dg7S0gaxCYR9CbCRRbcbvh3zvwdyXiY908P/sei
 LwrboiSwDQO2swy7oRWp0g5W/wo8CNjDpno6+RRWouZ7E7l+/j0MvJvmNE9FQB95dKjZ
 CNV1GsLUjzptRmWiUHLkczP6/IYsrMgwzLkAecny5tXPihB4QECkUK+m0w2tlNjhZ5rS
 g6/f1rOuvDcFQFC0QRESgIACFZEvWTtRpPGNfzncpRbjGMTLdZWE8CBoxL0SRfjvPG+X
 rgw2+10CljXduI0bOMRRT2QzmLvVvDdYJqHhznx78w25w4DNpzXaWBr9oeDbUfxiPGr7
 0SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792428902; x=1793033702;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUzpDj57XF/luLCmlLP48elJwPXycrBD8t+Z5NcBKCQ=;
 b=gGYNqnwtpsm/egIuHnVAnT2VzxhsyDkbuUzm8Y9lNwmqMtnBT7b2GuPhd2Fm14X4Oj
 e9UgFMEfmc3dlQ1nzMJvq/zQTPJvrvfDwi3cINFksEx49xW06OKuM9OUjudBiuR8wadh
 eXsHnNPE2ePAgkiJiTVHzMcY06IxSfkBPCmEFNWwONdNzT7BJ6tug4hG5+hzivbbXcG6
 vaahepKvo9HUco2YPhZgfOv1SllfjqyX1KTI6vl4phn3jIvoax+LHTJYq44zi/6PTC+q
 zMOYxbQz99XgaED2KcD3DE3UNLi23vhbauuXaKGlsUpXwDd/DZtNUQ8kubVaiCapb5yq
 5+6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv3dFT0FWg8zinxTo6wOnxz/bOtzQ5vPMthjVmKNp9Yw6SH1+cKJ4Q82z+Be2CsvJbwzE=@dpdk.org
X-Gm-Message-State: AFq9FYLDzs1gJAtdOxabEXvM/j9A4edIVX9fhkAv/wmFoKMVlibjUzcx
 2In2CIawwm4odh2hffa6TTm45Qs/LBFp4J+WIrVFRZ898kedlxRXRoHcFzRsjCqae00=
X-Gm-Gg: AYBFou3Keon1HVrCHeCZ9m3ZBmL1ApRQF8sX0F3+u9yXZMvExJCJoZ3jQi+Lk0/bF7F
 sGFGYRtKzXuza5HQ6hw339F+D32ZW6mz6R6ZPWAdcXXVUTR2pVp+yIrEdz0GM4TxBXvIdFwZuPB
 kjnPOVgafl7j/LA3/EBpqArZ4WhTBUcrC4QabaBq58N4v/UMtkRC4ARUdIGpNVh91gIsy7X5p2g
 dj3ssEgKk0AdwqdxRHfV1hHRjQlFxXuozJ6D1pJTkT+mUdNmACYEBLGQTEapg7gLz/BdJvQA/fy
 ybrsrmB8fSCbdQWgeYel8slKYBh57SlBzNtxREPFlWVQb2x9ZKixx2n9/lHb/dWR+O1bSaZB6pi
 uZ89QhhhS00sjIuTMZZuz2IEkOt8e7BE088TinNGBeC9p5Y6oiLt1kSI2yxQ07XHZQDyYIxauUb
 WKyYke040oqqZMJ7mC8iVQNNetM82Zb/rSnZ37fMCCHJqxMgrAw3n2teUshgqhMjGGQ2zw8R93g
 wLfC9MGccI9eA8b6+Mz3mmSE0Z55c5EeJmMOigXlcKyiIplYwZLtkYJ8t5ccT2N/3c4uKyipNp0
 SRAwR2kRYz0JC1H2GjusFQ==
X-Received: by 2002:a17:90b:4ccb:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3aceefbde0dmr8220232a91.13.1792428902566; 
 Mon, 19 Oct 2026 09:55:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f90a4fsm54725a91.14.2026.10.19.09.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:55:02 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:55:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: Joshua Washington <joshwash@google.com>, dev@dpdk.org, stable@dpdk.org,
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>,
 Junfeng Guo <junfengg@nvidia.com>
Subject: Re: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
Message-ID: <20261019095500.5b577674@phoenix.local>
In-Reply-To: <CA++LmPX3NA0=qOs=p7m8=4Zxq-=gLdgMJA=EKJy=SxNKysqfwQ@mail.gmail.com>
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
 <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
 <CA++LmPX3NA0=qOs=p7m8=4Zxq-=gLdgMJA=EKJy=SxNKysqfwQ@mail.gmail.com>
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

On Sun, 18 Oct 2026 13:24:03 +0530
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> > > +static inline bool
> > > +gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)  
> >
> > Minor nit (not worth blocking over, but maybe can be done as the
> > patches are being merged): can this be renamed to
> > gve_tx_validate_pkt_len? This is one step of many in the packet
> > validation pipeline.  
> 
> Thanks for the review, Joshua. Agreed on renaming to gve_tx_validate_pkt_len.
> This change impacts patches 9/10 and 10/10. I am happy to submit a v5
> series if preferred,
> or the maintainer can rename it upon applying.

Renames should go through patchwork. I can cleanup commit messages and
release notes, that is where I stop.
