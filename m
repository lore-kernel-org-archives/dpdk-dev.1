Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86187CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 23:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC234028F;
	Fri, 26 Sep 2025 01:54:50 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 4A7F740273
 for <dev@dpdk.org>; Fri, 26 Sep 2025 01:54:49 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-71b9d805f2fso12426756d6.0
 for <dev@dpdk.org>; Thu, 25 Sep 2025 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758844488;
 x=1759449288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3yNcr/8AAqsrivomhYh7/7aL+iththlbSy9p3WmCCc=;
 b=Kih6dMR7EHHem2L1SSwwMJuGmuRV1fsdN/7vifm9XkQedWkWtnckXvoHTm8NcgLbdx
 zsFRpyuju4/hGIwB1hG7o6wxUJWiiWyGbJdUF9jTFV1RrkHTo59N5ZqjvJ5zmb32y0fx
 A5BRpZ0zMMVE8Ql9mKrmdYleziKR1oH73gy5PociKvVun0bJbfcUZfLltSiZJefUzRFh
 Br34gCvh/aiWBMzNyh3cdLvw6a4gXoB6ynFQaje1be3AdLk77yzNn4GFUDZACZ8tPw5l
 sDpfKEEHEqY777f2JjrJA3lEYjBL4ObRFbKkwDiQLNWBoZCmr3XcVb0CNR8xYNHi6v5Y
 5IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758844488; x=1759449288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3yNcr/8AAqsrivomhYh7/7aL+iththlbSy9p3WmCCc=;
 b=Cwt5gF26ug0CTnKVB5w0o/HMas9jkM3x7rb4J3JcERcAWJK3x0mG2C4aW69a7g4k9L
 p4HRQKk9Mzecmlsx3F+85dKU6zoE4p9NegVKMUnZrnovUEVt/IWkN4n1plrnqfmF5Bi0
 vsD9b3Ptgwk8I8RvjqorGRGFusYTgueiwA6B6bn65ZwDc6mAH9BrbaS88pbLNmYPm5xZ
 lgql12A36fp1p23AioiUZDvtP1GNid2hqI087SUTZfO5sKpcU3XlrNbb0mIgLUKIQpg5
 f3CLfKwbxGYvOYGCvByg4/F7FXHyEuoxdncSDYctIV9+9DL0WfiwkFg+u8aw+jAoboRC
 D1Ow==
X-Gm-Message-State: AOJu0YyU37NN75GD9VInz7JNPRQpWGXy9Lzhiier05V435LUIdGqFzZL
 DTtnUq33QB+Pbsr04cPQmqH8rV9kAc7C1Y3ObnJ5m0+TP1GYX8wgaqqEZGLKY9P/d3s=
X-Gm-Gg: ASbGncth9r4pAl3FgLAmq9jwTOwiWfL2pn/z6oHKczBUTJETbYejOc1AikhJD+QhwkR
 9786InWsSMBO3AkSi1jlU4PMfhKJuQILKi2t6/58Om+5neHIaucyRhFkIMoqiRcbcUZpAcGBT5Z
 xd7RoeO1RUDnk6WWpdDBYZqstcgPBfBBBz2UaYzA8QQLdvt03OoXM3Z71XquZcE0XHx4p0B/4ru
 eZ0AxX/mWrml8dv8cmfIzniwBEMNYzEx+xRSi7DJ4CrcE0wvZFTHBp0xQFDvVYE6eDwxVqqRwFv
 0Vph+Anc0YbHjTBHCmVIXwSBN56qA7gWJFILzfp5x8UGPKyl5/1WurLNJTLVxsjMl9yUQx251to
 Csy3QXQdVJAF+JqVD0zjrtXH8O0SWNka/suHxTpTVcJzyvWXFpkpC3gLWYXt1HPekokgkEN67HH
 E=
X-Google-Smtp-Source: AGHT+IHyO5p2bHB0N6Ma5oFbixcBhSecuKbgG/nwRnwEBZRRnDubREdFuA8jNxslIS9JeskG8zeFjg==
X-Received: by 2002:a05:6214:1c89:b0:7e9:a4a1:b44f with SMTP id
 6a1803df08f44-7fc3aa70787mr77765766d6.36.1758844488377; 
 Thu, 25 Sep 2025 16:54:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80135b55793sm18874826d6.7.2025.09.25.16.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 16:54:48 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:54:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250925165442.3a7a1764@hermes.local>
In-Reply-To: <20250827223216.1337749-1-schneide@qti.qualcomm.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
 <20250827223216.1337749-1-schneide@qti.qualcomm.com>
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

On Wed, 27 Aug 2025 16:32:15 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---
> v2:
> * Remove function versioning
> * Define DLT_EN10MB macro only if it has not been defined
> 
>  .mailmap                               |  1 +
>  app/dumpcap/main.c                     |  5 +++--
>  app/test/test_pcapng.c                 |  8 ++++----
>  doc/guides/rel_notes/release_25_11.rst |  4 ++++
>  lib/graph/graph_pcap.c                 |  2 +-
>  lib/pcapng/rte_pcapng.c                |  4 ++--
>  lib/pcapng/rte_pcapng.h                | 10 +++++++++-
>  7 files changed, 24 insertions(+), 10 deletions(-)


Acked-by: Stephen Hemminger <stephen@networplumber.org>
