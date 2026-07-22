Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEC7C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 22:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01719402AD;
	Thu, 23 Jul 2026 00:23:02 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 46AB04027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 00:23:01 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso206545ad.0
 for <dev@dpdk.org>; Wed, 22 Jul 2026 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784758980;
 x=1785363780; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v00DYkk9/Y5uf+tkRqe2Qi6baLIz40PM7WZodKLDLEY=;
 b=aua6rV3Xaa3zpTrkfinp2BjeH0/OG39ugs5nKkgiGGEZ8+6edn9HjDlycYl6B7VDTZ
 Ie/f0xzQVlmEI8b15//mPEHfhpenlCnQEP5PBAp9gQrVxNBbFB7HZYuiBxaJmOSFfy0I
 MWev9j7iq0w7IsCU6VqAHejjx3AIFpg7AX7mNGgNVrhs2vhlPYT0i3hDvs2Rk0a8U/Td
 XQujC5hzhNjIQPZHAo97k8tcH+lFS/wkAN4C7WjAVViVnu5rC7mymwLBtq7uF1zLpnwZ
 g6GgBTYMBUJWadp359f+7TSaEWvXl/bnNO6okx2+LgPbGaquPnPGzC+kd/fj5kZwGfQP
 XZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784758980; x=1785363780;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v00DYkk9/Y5uf+tkRqe2Qi6baLIz40PM7WZodKLDLEY=;
 b=EsbUpwwaFh2hUSODT9KFkauCFthJtga6xIgW4JdWL7HGXx5kcP6Io2kwxDwXZNiZZX
 h018xHTMBBfzTz5akqbIuKo+OYO4yh+82360Zq8YOhmE3rMCz2H0WYHF11bSQ763Zem8
 yke6ZOeH6vtCeAsZN4WA2rh8LHafYGLo15nK6B5WT12ozSKbl1czNtLPob3RJ2nbx52/
 +ZFPh8kHs1TCoOZ6ReSDyH3r247gFspix6y7PjAt8We4Ox1M0xxdjnxOVrTak9ytgZI3
 umLsxnAiULVVagkiHQ99sI9Hrekpbz7Zuq6ohNFDqAUMBOdFKZhUx2+QYgnq4+sfUlno
 xrwg==
X-Gm-Message-State: AOJu0YyZEkbR1G28pa2mhC5t7LEmEIJvnnNce1dtOh9KaTXoQ1dt1iPD
 aGm2FG0gW25AC9679y+6M5qP70F+EPWpx10PONp7CDSAgR26CJs+yOGjldDVY+KdB4c=
X-Gm-Gg: AR+sD12kItZ97VKANkEbYhZtGwh7xmumjhKX7e72lI/aMic5kUvwpPdWb7adz6705d5
 HYCqPMs3Wk1Mrux0euOmKcd97hkkBBeZOh1mhcvL+rrAmwz8SmSRE6S+djFd/kKGt8t4BZc92UD
 pdmuLPa+TaXwrEvGkOYc1FDmDCKotRcBKXZDr97oIOiqXUXu2QP8nxHVgKcavBfh3QXDLKxakMJ
 jvD04xJTo/jNdquuGVmijlh1m3xj9d83XfuyLf9+TjzBe6rVNpRcoDQhWDvaPYvSRwnFJmDnzH0
 CjVv1uaKEnmNlE/KutE4OzbyeiN5H8zmWQcPT0veSwww16SbDDKLnx/kh1xP75iY5Lu3mZC5fWT
 mcVtnISTvpWI1SqHrqvm2Xny8K1vUiZy4JnNEShKNwHLCy5tOw3fkjjThfMaoOI4pVpX5S1VPMZ
 808WmQq64U4vxeVysSC5Onn7QDDDzrro+gnk9BcucUiFI=
X-Received: by 2002:a05:6a20:430f:b0:3aa:ec1c:84e5 with SMTP id
 adf61e73a8af0-3c44b157950mr420139637.43.1784758979990; 
 Wed, 22 Jul 2026 15:22:59 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1ca3efsm15392811eec.30.2026.07.22.15.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 15:22:59 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:22:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v3] app/testpmd: support runt and ultra-small frames in
 txonly
Message-ID: <20260722152256.16fa03a9@phoenix.local>
In-Reply-To: <20260706132050.3054235-1-yangxingui@huawei.com>
References: <20260706132050.3054235-1-yangxingui@huawei.com>
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

On Mon, 6 Jul 2026 21:20:50 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> Allow set txpkts to accept packet lengths as small as one byte,
> enabling generation of runt frames and ultra-small packets for
> testing NIC padding logic and undersized frame handling.
> 
> The txonly engine handles three ranges: normal (>= 42 bytes) with
> full Ethernet/IPv4/UDP headers, runt (14-41 bytes) with truncated
> headers, and ultra-small (< 14 bytes) filled with a repeating
> pattern. Checksum offloads are disabled when headers are incomplete.
> 
> Minimum length validation in set_tx_pkt_segments() is relaxed from
> 42 to 1 byte. Random split and multi-flow still require the full
> header stack in the first segment, as enforced by tx_only_begin().
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
 
I would suggest that if NIC ever gets a packet < ethernet header it is
an application bug, and driver should drop it as an transmit error.
Or crash with an assert failed. There is no guarantee that this
will ever work.

Therefore can not see why testpmd needs to do this.

For packets with Ethernet header plus a few more bytes, it makes
sense to allow. There are always control level protocols that are
very short.
