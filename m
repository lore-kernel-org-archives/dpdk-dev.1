Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA0DC5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 20:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B610D402BD;
	Wed, 19 Aug 2026 22:20:44 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id EB6D6400D5
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:20:43 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1525167b3a.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787170843;
 x=1787775643; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ook1ti3Ts/lxt6AtyGKdc8xhPu+cS+rzM82j7/HQIiM=;
 b=mJ7ZdxGwZhvme497R4zXFd712C3AbdaAR5cUr71UN5lPPNs8e1mFod7KmhxZbYuQb0
 MNsI1npLCLg++f7ViqM7N33d6DMglqeEyAiwg+DYAqvn7IyvoGvbRuO1XMQtq1k+8lgk
 a4xViWe1GnQJkMel+vKCDAtsyKEndYwzc5TAMbU1a6H8Q555ogrDsTpo06651mYJocRZ
 rz6lA9abWWLgs58HYQU4oH9kxZnnAbajkk7je48FUFolxBGjIRhvH8JWAc6ERG7wSnKC
 RWCM3RPyWsVheqJKpIBcl6PfduV7GDv60uuJswcbI5JK2PIQoyxI4HCNCI5hAqEok9Qy
 vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170843; x=1787775643;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ook1ti3Ts/lxt6AtyGKdc8xhPu+cS+rzM82j7/HQIiM=;
 b=juVgesJAHHAMC8N+LyHIfH/pTp4Q3YVb6MPxTaCqwdm73qEl2PXqWuAIpzNDVo5BHF
 DmbZ/vKOLKfcQdJYmeqfSSMZ6EGJ9YX0qxbpSDtvfFeA2ZQ9BCJW4V+/hRRSngc4JxLD
 g64wmOv9afxlKgD8+53TX2ZtZdWkTsl4FgOrypl8mf29UAFRXkzevq7jXPvhEZOKa+e8
 ApWx/VcAWqMTOT2fNj6OtZ2MRKnWA4KMR+xBIZPl0PZ/cgko9tKX5BnLeMIt4A6ic0ZF
 RMi7ym47xlRc0JBW8FXdlwAhxN3crMZTmlRSpDBM2j8xONDFAPstNFaSXDsDVC7iBCY5
 PRsA==
X-Gm-Message-State: AOJu0Ywq/HcbuvuFyHLujIwO+u2OXYa4KrdplFWCqVSdyvOUANnkVCaM
 MQlH5SwUCcQCVt5hy7LvIddyIbMdEbki9k0A3SNQvqJ7rSSVWVojzvA5pEAT5Z2/B/g=
X-Gm-Gg: AR+sD11foEpRmCXKObzvBG5WYFYSQ3wlRFsC0YNC3Bq8RYhntrteJ+s+AyaYrJjtqAw
 jdCIRv/BV0t893oXeclD/9QU+71ozWVfG3TIV/EgpkVF49Ip4jHc3Urv6AyDhPrAjnntuQfLtKA
 BgCsrepjfELPXd7z6/wd5HXN+gq8n7iiNSisqz9PI0FAKEcj3XaCQEMojQYMOLSJMDef63xZtIg
 mw/9Hy/JYOa5ejud6velgXr/MizOl7DshUDQ1Zu2dWsFTgFO0WHQdX+MNj5Ah9AE5G+V+VWLV6E
 lc8yjE3WfY7tJk31EbPSBOtsIc2kZb/ZYV/MSNzG4oTYk1Zq3DbcsPpQW57ekunJaGseALVJQ9I
 5eD24sj/LIq6wKXDkFCYVfV2Qr/MC6J7F1+8D7YCHVxw5rbs5yEjhppc/kAG7gRqFvGkwpm400y
 6IuNnYZiPG1z6AP01GjWDXFTTNjKPELIb9osg5oupOhp5ngtAJ+TmtjhnEr4G50DhbBjd+SjkER
 r52QsSm20o8mxw3ddLjzLfmEY0QxLs+5EXW1dWq
X-Received: by 2002:a05:6a00:4392:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-851d384e9ffmr12338721b3a.7.1787170842869; 
 Wed, 19 Aug 2026 13:20:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3640a4bsm1013763b3a.42.2026.08.19.13.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 13:20:42 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:20:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com,
 joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v7 0/2] net/af_xdp: add Rx timestamping and read_clock
 support
Message-ID: <20260819132032.0c606bb3@phoenix.local>
In-Reply-To: <20260818065000.1597610-1-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260818065000.1597610-1-blasko@google.com>
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

On Tue, 18 Aug 2026 06:49:57 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for dynamic Rx timestamping and
> clock querying in the AF_XDP Poll Mode Driver.
> 
> The first patch introduces three new vdev devargs to specify
> layout-agnostic metadata offsets and bitmasks for extracting hardware
> Rx timestamps from XDP metadata into the mbuf dynamic timestamp field.
> 
> The second patch implements the read_clock ethdev operation, querying
> ethtool for the interface's PTP Hardware Clock index at start and using
> clock_gettime to query the NIC hardware clock time.
> ---

Applied to next-net.
Had to fix some merge conflicts with the previous path changes.
