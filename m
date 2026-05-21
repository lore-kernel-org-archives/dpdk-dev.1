Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0448DCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:52:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0592D402A2;
	Thu, 21 May 2026 16:52:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DC694400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 16:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779375119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfRwmst/w0uW5hC/PUV13wLNgodInCsYTTySCCHsSGg=;
 b=WnuQ+iRhHLCdTuPixgtvpzMjgBpQ3Xh2IKgzrmExBeZDwd6MNzXZLCPq9bVSk6gIit5zBM
 /UtYJe+XI0bOqMp7PBBis1sc6YwI2Fm0SQue5ap0BYQZrO7/Ob/QLRNbNrbRbVTzS9MVDJ
 mZQn/7WH7CscLpcGBaM9/hvUisF3qc0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Nbl4i9c7OdGqp-g-rNviLw-1; Thu, 21 May 2026 10:51:57 -0400
X-MC-Unique: Nbl4i9c7OdGqp-g-rNviLw-1
X-Mimecast-MFC-AGG-ID: Nbl4i9c7OdGqp-g-rNviLw_1779375116
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3942da9e8deso23234031fa.0
 for <dev@dpdk.org>; Thu, 21 May 2026 07:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375116; x=1779979916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfRwmst/w0uW5hC/PUV13wLNgodInCsYTTySCCHsSGg=;
 b=f3fyYejovX9YZ2IrIIKQKip14LC/4X/GKp8QlUQ8TAstrLjrmSpPvHTrWymEzg5C42
 bpZy1/Hj+sn5zPsoAXKVODkL28Qxv9Os2s1uiIlNRoyYIY7tfl+YYRk+UgYkr/pH9WZh
 hwWop7u+uSQBF7bk/TAqY52RFCW2iNlg/af+jN0hoaCDDvL+wSPyu3vvpHJveQ1Hj/TP
 /whXkT6ctrq2kzCI1PXC993belNsXxEf514Opl6b7NDeArv16TlJlrRs3+VpVl5h9aAm
 MNG4lvNmmIpdQQnRPtx9Gd4ePcRvJ/Y4s2YfWmpDmZteabPhqVEC+Ah29lmcMr1koQmL
 2n6w==
X-Gm-Message-State: AOJu0Yzs9etcxBFTzD3T7ePe6vX9kYf0ENR4qn5Nc0BQ12NHo1DfMzoZ
 ORaa/90IfF+Z2VyGZS3Xk0JCuKej/CkulLdZyUFokzluMdYrZl+xxVX6KuPnnvZDUOPjyg1ZWJi
 ZWlXCurd4kGaIZtvKyQXhzymCLM3DP1UmoOMNbqK+TF+DIcZPiwY5z2OU9Fh+SN6zQWpkHGl1Dd
 s4vwdCDveS2VGi66TWPoU=
X-Gm-Gg: Acq92OFwYrsM7r8umQvDe95DyUIikq4v73r/o4z0cx0igzWdUjVHjbfL8v4j9mV33/U
 l6VNyIHX/mtjjq5qu6d8h2JYDqvrxLjv5tgejWGvF+JczWxtrIXq4GE692LiqSlYx/9Z9eFAWN/
 B7ElSNV6Tn294jFqca411C6hLgjs5t8u/EXmjwC2ZM4tjzd97ZADYs/rj3ATTQBHAcA49Vy6GAx
 I5yJyxcxryn9qG+rlmwoD+dTvOF5wBXsizDAwZkeVHGlKngmcGHlWTJbNgO1OJLijrkuA==
X-Received: by 2002:a05:651c:41d6:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-395ca5d1a5dmr15357181fa.17.1779375116378; 
 Thu, 21 May 2026 07:51:56 -0700 (PDT)
X-Received: by 2002:a05:651c:41d6:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-395ca5d1a5dmr15356961fa.17.1779375115862; Thu, 21 May 2026
 07:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260513235518.408895-1-andremue@linux.microsoft.com>
In-Reply-To: <20260513235518.408895-1-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 21 May 2026 16:51:43 +0200
X-Gm-Features: AVHnY4Kd8lYLnLZboqz9qhgtgOiOwjI7p8cNAONaeG5HpcxNQYPOf0wehKwKMVg
Message-ID: <CAJFAV8yhmQ8hEpMmUWW77kAyuJXb-Ru6z1kBnHLSBhcZ_LfEhg@mail.gmail.com>
Subject: Re: [PATCH] Windows: fix core count on NUMA with more than 64 cores
 per node
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Gena Tertychnyi <genter@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cm5sw5Dp8PVfD4IekNoazSctrPOGPQkSifA7r0s1Ryw_1779375116
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Thu, 14 May 2026 at 01:56, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> From: Gena Tertychnyi <genter@microsoft.com>
>
> Fix specific to Windows NUMA machines with more than 64 cores per node
> (e.g. 2 NUMAs with 128 cores each):
>
> - NumaNode.GroupMasks[] array is used instead of NumaNode.GroupMask.
> - RelationAll is used instead of RelationNumaNode when calling
> GetLogicalProcessorInformationEx because RelationAll returns the full
> multi-group NUMA affinity as RelationNumaNode returns only the NUMA
> node's primary group.

Probably worth a Fixes: tag.

>
> Signed-off-by: Gena Tertychnyi <genter@microsoft.com>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Dmitry, any objection?


-- 
David Marchand

