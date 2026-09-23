Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FAC9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 157674027C;
	Wed, 23 Sep 2026 22:11:54 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 71A1F40276
 for <dev@dpdk.org>; Wed, 23 Sep 2026 22:11:53 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so824915a91.0
 for <dev@dpdk.org>; Wed, 23 Sep 2026 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790194312;
 x=1790799112; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z8AnCrSUHAXycPmnyB5FkbGPCNhMdXxk9yaMQLNsj1I=;
 b=k3Jjt31Vu76jOTp45N6ECHXw+w8AI/C/Y9UABHk6XR2hFsTH/oUGgwuW7Z2Vq9o1I5
 m4Mo4gi9+WRBWn24P5HQD7Ha3W4Bcck1xgXbxxjgQl/zR1SWOW9AnKlhs9/TqRTptqHm
 +1cJXi5jR665XO0tegEntvxoM+/lkTipdh2mIbgAW11V+OEoSHBHxgG2BGSQS7TGh6D0
 we0DrE99oLjmzcLBVr0rVMyUEyto98vw5pK5ZsIUM4pc25IAXF0ZOwV5dREdDO+Vxoz3
 PcjUPJS3mrKYIqlKWSo2EQoFm8rfrdAcdpHtu2z60XQcQQ4IDRmIj+LQAeU0hrQ2961H
 AZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194312; x=1790799112;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z8AnCrSUHAXycPmnyB5FkbGPCNhMdXxk9yaMQLNsj1I=;
 b=HQVtqmyY/oQrBS4mgJjqq6BpvTZVrvLZf9QVvMecs6W7gTQ/d3wLyIG29JQ/BHr1Cr
 LlRpLmP2uZD4zVHfFv8dzzRCova52Ia1IiQL7xX3srhidkNL/+15Vj2LQcMjuZAnLFpP
 J2TeRd7faqC3/S2JlQyQ8JtQPTuZgIFKbhed+AZqGAmJT+QgFHcZ5SICuHx+zzhhWeLo
 LF/q1bwn+4tPHuw0Luyo9ZNvRBbOYd9asTuhQKsEK0lWYMgXcabkZl662zC03Xgzvb5N
 3JFcliCwbUPBwWmjRpetEC7mgEFFeifIqiuzD6kxAK/C6rTef6N3GWarvl3AYyxLBVVV
 yY0Q==
X-Gm-Message-State: AFuF++lyGWWGBzBZm9d5S41amV0KA9/F9BmboCUUt1ZGgP2DpTgC6Xmt
 ZLIOCW50KGW3FacLlx4qcI5bWS2N719IUZ0Kd5AU2pHY/VUDN6cudX6M8EltByxpeDs=
X-Gm-Gg: AYBFou3XHz1MkeNEwObobxQ/A0NQgMIcWs9tuWS9pLg5DItL9WxM9dlq33xx7b+0lQt
 twsflGFu8bO+1ButgLiraH/slGKTdIQMc3rXOAIKL7DhfMcwLTxBU8Bc1S1uH+5OfDOC5b3m5H5
 zNh3iiBkyoV8RbGF3CF9Oamq24UJ9YV7qFqwKkOGK029f2LI+nSxw70dQhni6SMRz67jFSOTh3x
 fJQN7cTOY5W1vZ+oK/hWj6fu4AhjQbKNNICoQRnPXkdu4ow052ywZkeygMGObj0jxP6yIJyuowo
 iL/sb+3jPx26A37t6+A7+TNeoo14fdCvOirm/jY+ZYe+FV6sQjjkdcSTABFGg9zotK8EEQ1b4DG
 7vUdK0zhvZvkB9rlSbStA85AXQ++WTlIUo1Zg+L1jpcD+qDdFyKryxAJtTNR/AUrvG4dUIIv+c7
 l21alp7iP6p3KF/Va8OUmMvCLCyi3YHptqAG9Z/v/lzcRc3/3GWo2+APovLds+aTyX5P2C4ZEoi
 ZhV6HQHv+LRvXatyNTkqKnS8bBoImDUDDi4au9d
X-Received: by 2002:a17:90b:4c0d:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-3a0985baa7dmr210619a91.8.1790194312323; 
 Wed, 23 Sep 2026 13:11:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0974ec5d0sm694671a91.4.2026.09.23.13.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:11:52 -0700 (PDT)
Date: Wed, 23 Sep 2026 13:11:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Message-ID: <20260923131149.72f449d3@phoenix.local>
In-Reply-To: <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
References: <20260923184207.626576-1-stephen@networkplumber.org>
 <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
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

On Wed, 23 Sep 2026 21:19:45 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 23/09/2026 20:42, Stephen Hemminger:
> > The existing check-doc-vs-code.sh only compares rte_flow items and
> > actions, and only for drivers whose directory matches the ini name,
> > so none of the drivers under net/intel are checked.
> > 
> > Replace it and parse-flow-support.sh with a Python script covering
> > the whole NIC feature matrix:  
> [...]
> >  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
> >  devtools/check-doc-vs-code.sh          |   84 --
> >  devtools/parse-flow-support.sh         |   92 --
> >  doc/guides/contributing/new_driver.rst |    4 +-
> >  doc/guides/contributing/patches.rst    |   27 +
> >  doc/guides/nics/features.rst           |    5 +
> >  8 files changed, 1169 insertions(+), 180 deletions(-)
> >  create mode 100755 devtools/check-doc-vs-code.py
> >  delete mode 100755 devtools/check-doc-vs-code.sh
> >  delete mode 100755 devtools/parse-flow-support.sh  
> 
> Thanks for working on it.
> 
> My concern is how easy it is to maintain for all contributors
> having to insert their rules and exceptions?

The result doesn't have to be nothing. I would rather not keep track
of exceptions in the script.

> It is replacing less 200 lines with more than 1000 lines
> so it looks a lot more complex.
> It is probably fully generated by AI?
> Can we make it simpler?

I will look into it, should be table driven and more split up.
